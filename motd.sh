#!/bin/bash

# Couleurs

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}"
echo "  ╔══════════════════════════════╗ "
echo "  ║     🖥️  DEBIAN LINUX            "
echo "  ╚══════════════════════════════╝ "
echo -e "${NC}"

echo -e "${RED}"
echo "   __   ___   _  ____ _____ _     ____    _    _   _      ______   ______ _____ _____ __  __   "
echo "   \ \ / / | | |/ ___| ____| |   / ___|  / \  | \ | |    / ___\ \ / / ___|_   _| ____|  \/  |  "
echo "    \ V /| | | | |   |  _| | |   \___ \ / _ \ |  \| |    \___ \\ V /\___ \ | | |  _| | |\/| |  "
echo "     | | | |_| | |___| |___| |___ ___) / ___ \| |\  |     ___) || |  ___) || | | |___| |  | |  "
echo "     |_|  \___/ \____|_____|_____|____/_/   \_\_| \_|    |____/ |_| |____/ |_| |_____|_|  |_|  "
echo -e "${NC}"

# Variables

OS_NAME=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
IP=$(hostname -I | awk '{print $1}')
KERNEL=$(uname -r)
CPU=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^[ \t]*//')
LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | sed 's/^ //')
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DATE=$(date +"%A, %d %B %Y %H:%M:%S")

# Functions

if command -v docker &> /dev/null; then
    DOCKER_RUNNING=$(docker ps --format '{{.Names}}')
    DOCKER_COUNT=$(docker ps -q | wc -l)
    if [ "$DOCKER_COUNT" -eq 0 ]; then
	CONTAINER_INFO="Aucun conteneur en cours"
    else
	CONTAINER_INFO="$DOCKER_COUNT conteneur(s) actif(s): $DOCKER_RUNNING"
    fi
else
    CONTAINER_INFO="Docker non installé"
fi

# ASCII BANNER (tu peux changer par SCALEWAY / DEBIAN / autre)

echo -e "${CYAN}"
echo "    ____  _______     _____  ____  ____    " 
echo "   |  _ \| ____\ \   / / _ \|  _ \/ ___|   " 
echo "   | | | |  _|  \ \ / / | | | |_) \___ \   "
echo "   | |_| | |___  \ V /| |_| |  __/ ___) |  "
echo "   |____/|_____|  \_/  \___/|_|   |____/   " 
echo -e "${NC}"

echo -e "${GREEN}Welcome to $HOSTNAME "
echo -e "${BLUE}────────────────────────────────────────────${NC}"
echo -e "${RED}"
echo -e "Date        : $DATE}"
echo -e "OS System   : ${OS_NAME}"
echo -e "IP Address  : ${IP}"
echo -e "Kernel      : ${KERNEL}"
echo -e "Uptime      : ${UPTIME}"
echo -e "CPU         : ${CPU}"
echo -e "Load Avg    : ${LOAD}"
echo -e "RAM Usage   : ${MEM_USED}MB / ${MEM_TOTAL}MB"
echo -e "Disk Usage  : ${DISK_USED} / ${DISK_TOTAL}"
echo -e "Containers  : ${CONTAINER_INFO}"
echo -e "${NC}"
echo -e "${BLUE}────────────────────────────────────────────${NC}"
