# Author: Dmitry Kireev (@kireevco)
#
# Contrubutions: (@Juppit) - patches for gcc & Cygwin
#
# Credits to Paul Sokolovsky (@pfalcon) for esp-open-sdk
# Credits to Fabien Poussin (@fpoussin) for xtensa-lx106-elf build script
#

STANDALONE = y
PREBUILT_TOOLCHAIN = n
DEBUG = n
UTILS = n


VENDOR_SDK_VERSION = 1.4.0
GMP_VERSION = 6.0.0a
MPFR_VERSION = 3.1.3
MPC_VERSION = 1.0.3
GDB_VERSION = 7.10
GCC_VERSION = 5.1.0


TOP = $(PWD)
TARGET = xtensa-lx106-elf
TOOLCHAIN = $(TOP)/$(TARGET)

MINGW_DIR := c:\tools\mingw64

XTTC = $(TOOLCHAIN)
XTBP = $(TOP)/build
XTDLP = $(TOP)/src
UTILS_DIR = $(TOP)/utils
PATCHES_DIR = $(XTDLP)/patches

GMP_TAR = gmp-$(GMP_VERSION).tar.bz2
MPFR_TAR = mpfr-$(MPFR_VERSION).tar.bz2
MPC_TAR = mpc-$(MPC_VERSION).tar.gz
GDB_TAR = gdb-$(GDB_VERSION).tar.xz


GMP_DIR = gmp-$(GMP_VERSION)
MPFR_DIR = mpfr-$(MPFR_VERSION)
MPC_DIR = mpc-$(MPC_VERSION)
GDB_DIR = gdb-$(GDB_VERSION)

GCC_DIR = gcc-$(GCC_VERSION)

ifneq "$(wildcard $(XTDLP)/gcc-xtensa)" ""
    GCC_DIR := gcc-xtensa
endif


XTENSA_TOOLCHAIN_WINDOWS_TAR := xtensa-lx106-elf-v5.1.0.64-windows-x86.zip
XTENSA_TOOLCHAIN_MAC_TAR := xtensa-lx106-elf-v5.1.0.64-macos-x86_64.zip
XTENSA_TOOLCHAIN_LINUX_TAR := xtensa-lx106-elf-v5.1.0.64-linux-x86_64.tar.gz

NEWLIB_DIR = newlib-xtensa
BINUTILS_DIR = esp-binutils
LIBHAL_DIR = lx106-hal
ESPTOOL_DIR = esptool
ESPTOOL2_DIR = esptool2
ESPTOOL2_SRCREPO = rabutron-esp8266
MEMANALYZER_DIR = ESP8266_memory_analyzer


ifeq ($(DEBUG),y)
	UNTAR := bsdtar -vxf
	MAKE_OPT := make
	CONF_OPT := configure
	INST_OPT := install
else
	UNTAR := bsdtar -xf
	MAKE_OPT := make -s -j2
	CONF_OPT := configure -q
	INST_OPT := install -s
endif


PLATFORM := $(shell uname -s)

PATH := $(TOOLCHAIN)/bin:$(PATH)
SAFEPATH := $(TOOLCHAIN)/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/mingw/bin/:/c/tools/mingw32/bin:/c/tools/mingw64/bin


VENDOR_SDK_ZIP = $(VENDOR_SDK_ZIP_$(VENDOR_SDK_VERSION))
VENDOR_SDK_DIR = $(VENDOR_SDK_DIR_$(VENDOR_SDK_VERSION))

VENDOR_SDK_ZIP_1.3.0-rtos = ESP8266_RTOS_SDK-v1.3.0.10.zip
VENDOR_SDK_DIR_1.3.0-rtos = ESP8266_RTOS_SDK-v1.3.0

VENDOR_SDK_ZIP_1.5.0 = esp_iot_sdk_v1.5.0_15_11_27.zip
VENDOR_SDK_DIR_1.5.0 = esp_iot_sdk_v1.5.0
VENDOR_SDK_ZIP_1.4.0 = esp_iot_sdk_v1.4.0_15_09_18.zip
VENDOR_SDK_DIR_1.4.0 = esp_iot_sdk_v1.4.0
VENDOR_SDK_ZIP_1.3.0 = esp_iot_sdk_v1.3.0_15_08_08.zip
VENDOR_SDK_DIR_1.3.0 = esp_iot_sdk_v1.3.0
VENDOR_SDK_ZIP_1.2.0 = esp_iot_sdk_v1.2.0_15_07_03.zip
VENDOR_SDK_DIR_1.2.0 = esp_iot_sdk_v1.2.0
VENDOR_SDK_ZIP_1.1.2 = esp_iot_sdk_v1.1.2_15_06_12.zip
VENDOR_SDK_DIR_1.1.2 = esp_iot_sdk_v1.1.2
VENDOR_SDK_ZIP_1.1.1 = esp_iot_sdk_v1.1.1_15_06_05.zip
VENDOR_SDK_DIR_1.1.1 = esp_iot_sdk_v1.1.1
VENDOR_SDK_ZIP_1.1.0 = esp_iot_sdk_v1.1.0_15_05_26.zip
VENDOR_SDK_DIR_1.1.0 = esp_iot_sdk_v1.1.0
# MIT-licensed version was released without changing version number
#VENDOR_SDK_ZIP_1.1.0 = esp_iot_sdk_v1.1.0_15_05_22.zip
#VENDOR_SDK_DIR_1.1.0 = esp_iot_sdk_v1.1.0
VENDOR_SDK_ZIP_1.0.1 = esp_iot_sdk_v1.0.1_15_04_24.zip
VENDOR_SDK_DIR_1.0.1 = esp_iot_sdk_v1.0.1
VENDOR_SDK_ZIP_1.0.1b2 = esp_iot_sdk_v1.0.1_b2_15_04_10.zip
VENDOR_SDK_DIR_1.0.1b2 = esp_iot_sdk_v1.0.1_b2
VENDOR_SDK_ZIP_1.0.1b1 = esp_iot_sdk_v1.0.1_b1_15_04_02.zip
VENDOR_SDK_DIR_1.0.1b1 = esp_iot_sdk_v1.0.1_b1
VENDOR_SDK_ZIP_1.0.0 = esp_iot_sdk_v1.0.0_15_03_20.zip
VENDOR_SDK_DIR_1.0.0 = esp_iot_sdk_v1.0.0
VENDOR_SDK_ZIP_0.9.6b1 = esp_iot_sdk_v0.9.6_b1_15_02_15.zip
VENDOR_SDK_DIR_0.9.6b1 = esp_iot_sdk_v0.9.6_b1
VENDOR_SDK_ZIP_0.9.5 = esp_iot_sdk_v0.9.5_15_01_23.zip
VENDOR_SDK_DIR_0.9.5 = esp_iot_sdk_v0.9.5
VENDOR_SDK_ZIP_0.9.4 = esp_iot_sdk_v0.9.4_14_12_19.zip
VENDOR_SDK_DIR_0.9.4 = esp_iot_sdk_v0.9.4
VENDOR_SDK_ZIP_0.9.3 = esp_iot_sdk_v0.9.3_14_11_21.zip
VENDOR_SDK_DIR_0.9.3 = esp_iot_sdk_v0.9.3
VENDOR_SDK_ZIP_0.9.2 = esp_iot_sdk_v0.9.2_14_10_24.zip
VENDOR_SDK_DIR_0.9.2 = esp_iot_sdk_v0.9.2


.PHONY: standalone sdk sdk_patch utils

# all: esptool libcirom standalone sdk sdk_patch $(TOOLCHAIN)/xtensa-lx106-elf/sysroot/usr/lib/libhal.a $(TOOLCHAIN)/bin/xtensa-lx106-elf-gcc
all: debug platform-specific
# all: platform-specific
	@echo
	@echo "Xtensa toolchain is built, to use it:"
	@echo
	@echo 'export PATH=$(TOOLCHAIN)/bin:$$PATH'
	@echo
ifneq ($(STANDALONE),y)
	@echo "Espressif ESP8266 SDK is installed. Toolchain contains only Open Source components"
	@echo "To link external proprietary libraries add:"
	@echo
	@echo "xtensa-lx106-elf-gcc -I$(TOP)/sdk/include -L$(TOP)/sdk/lib"
	@echo
else
	@echo "Espressif ESP8266 SDK is installed, its libraries and headers are merged with the toolchain"
	@echo
endif

build: toolchain standalone $(TOP)/sdk sdk_patch $(TOOLCHAIN)/xtensa-lx106-elf/lib/libhal.a utils libcirom
build-prebuilt-toolchain: standalone $(TOP)/sdk sdk_patch utils

#utils: esptool esptool2 memanalyzer
utils: 
ifeq ($(UTILS),y)
	esptool
	esptool2
	memanalyzer
endif

esptool: $(UTILS_DIR)/esptool
esptool2: $(UTILS_DIR)/esptool2
memanalyzer: $(UTILS_DIR)/memanalyzer


$(UTILS_DIR)/esptool: $(XTDLP)/$(ESPTOOL_DIR)/esptool.py	
	mkdir -p $(UTILS_DIR)/
#	cd $(XTDLP)/$(ESPTOOL_DIR); python setup.py install
  ifeq ($(OS),Windows_NT)
		cd $(XTDLP)/$(ESPTOOL_DIR); pyinstaller --onefile esptool.py
		cd $(XTDLP)/$(ESPTOOL_DIR)/dist; cp esptool.exe $(UTILS_DIR)/
  else
		cp $(XTDLP)/$(ESPTOOL_DIR)/esptool.py $(UTILS_DIR)/
  endif

$(UTILS_DIR)/memanalyzer: $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer.sln
	mkdir -p $(UTILS_DIR)/	  
	
	cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; mcs Program.cs
  
  ifeq ($(OS),Windows_NT)
		cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; cp Program.exe $(UTILS_DIR)/memanalyzer.exe
  endif
	
  ifeq ($(PLATFORM),Darwin)
	 	@echo "Detected: MacOS"
		cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; CC="cc -framework CoreFoundation -lobjc -liconv" mkbundle Program.exe -o memanalyzer --deps --static
		cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; cp memanalyzer $(UTILS_DIR)/
  endif
  ifeq ($(PLATFORM),Linux)
		cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; mkbundle Program.exe -o memanalyzer --deps --static
		cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; cp memanalyzer $(UTILS_DIR)/
  endif
  ifeq ($(PLATFORM),FreeBSD)
	 	cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; mkbundle Program.exe -o memanalyzer --deps --static
	 	cd $(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer/; cp memanalyzer $(UTILS_DIR)/		
  endif

$(UTILS_DIR)/esptool2: $(XTDLP)/$(ESPTOOL2_DIR)/esptool2.c
	make clean -C $(XTDLP)/$(ESPTOOL2_DIR)/
	make -C $(XTDLP)/$(ESPTOOL2_DIR)/
	mkdir -p $(UTILS_DIR)
	cp $(XTDLP)/$(ESPTOOL2_DIR)/esptool2 $(UTILS_DIR)/


$(TOOLCHAIN)/xtensa-lx106-elf/lib/libcirom.a: $(TOOLCHAIN)/xtensa-lx106-elf/lib/libc.a toolchain
	@echo "Creating irom version of libc..."
	$(TOOLCHAIN)/bin/xtensa-lx106-elf-objcopy --rename-section .text=.irom0.text \
		--rename-section .literal=.irom0.literal $(<) $(@);

libcirom: $(TOOLCHAIN)/xtensa-lx106-elf/lib/libcirom.a

sdk_patch: .sdk_patch_$(VENDOR_SDK_VERSION)


.sdk_patch_1.3.0-rtos:
	@touch $@

.sdk_patch_1.5.0:
	patch -N -d $(VENDOR_SDK_DIR_1.5.0) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_1.4.0:
	patch -N -d $(VENDOR_SDK_DIR_1.4.0) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_1.3.0:
	patch -N -d $(VENDOR_SDK_DIR_1.3.0) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_1.2.0: lib_mem_optimize_150714.zip libssl_patch_1.2.0-2.zip empty_user_rf_pre_init.o
	#$(UNTAR) libssl_patch_1.2.0-2.zip
	#$(UNTAR) libsmartconfig_2.4.2.zip
	$(UNTAR) lib_mem_optimize_150714.zip
	#mv libsmartconfig_2.4.2.a $(VENDOR_SDK_DIR_1.2.0)/lib/libsmartconfig.a
	mv libssl.a libnet80211.a libpp.a libsmartconfig.a $(VENDOR_SDK_DIR_1.2.0)/lib/
	patch -N -f -d $(VENDOR_SDK_DIR_1.2.0) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	$(TOOLCHAIN)/bin/xtensa-lx106-elf-ar r $(VENDOR_SDK_DIR_1.2.0)/lib/libmain.a empty_user_rf_pre_init.o
	@touch $@

.sdk_patch_1.1.2: scan_issue_test.zip 1.1.2_patch_02.zip empty_user_rf_pre_init.o
	$(UNTAR) scan_issue_test.zip
	$(UNTAR) 1.1.2_patch_02.zip
	mv libmain.a libnet80211.a libpp.a $(VENDOR_SDK_DIR_1.1.2)/lib/
	patch -N -f -d $(VENDOR_SDK_DIR_1.1.2) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	$(TOOLCHAIN)/bin/xtensa-lx106-elf-ar r $(VENDOR_SDK_DIR_1.1.2)/lib/libmain.a empty_user_rf_pre_init.o
	@touch $@

.sdk_patch_1.1.1: empty_user_rf_pre_init.o
	patch -N -f -d $(VENDOR_SDK_DIR_1.1.1) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	$(TOOLCHAIN)/bin/xtensa-lx106-elf-ar r $(VENDOR_SDK_DIR_1.1.1)/lib/libmain.a empty_user_rf_pre_init.o
	@touch $@

.sdk_patch_1.1.0: lib_patch_on_sdk_v1.1.0.zip empty_user_rf_pre_init.o
	$(UNTAR) $<
	mv libsmartconfig_patch_01.a $(VENDOR_SDK_DIR_1.1.0)/lib/libsmartconfig.a
	mv libmain_patch_01.a $(VENDOR_SDK_DIR_1.1.0)/lib/libmain.a
	mv libssl_patch_01.a $(VENDOR_SDK_DIR_1.1.0)/lib/libssl.a
	patch -N -f -d $(VENDOR_SDK_DIR_1.1.0) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	$(TOOLCHAIN)/bin/xtensa-lx106-elf-ar r $(VENDOR_SDK_DIR_1.1.0)/lib/libmain.a empty_user_rf_pre_init.o
	@touch $@

empty_user_rf_pre_init.o: $(PATCHES_DIR)/empty_user_rf_pre_init.c
	$(TOOLCHAIN)/bin/xtensa-lx106-elf-gcc -O2 -c $<

.sdk_patch_1.0.1: libnet80211.zip esp_iot_sdk_v1.0.1/.dir
	$(UNTAR) $<
	mv libnet80211.a $(VENDOR_SDK_DIR_1.0.1)/lib/
	patch -N -f -d $(VENDOR_SDK_DIR_1.0.1) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_1.0.1b2: libssl.zip esp_iot_sdk_v1.0.1_b2/.dir
	$(UNTAR) $<
	mv libssl/libssl.a $(VENDOR_SDK_DIR_1.0.1b2)/lib/
	patch -N -d $(VENDOR_SDK_DIR_1.0.1b2) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_1.0.1b1:
	patch -N -d $(VENDOR_SDK_DIR_1.0.1b1) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_1.0.0:
	patch -N -d $(VENDOR_SDK_DIR_1.0.0) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_0.9.6b1:
	patch -N -d $(VENDOR_SDK_DIR_0.9.6b1) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_0.9.5: sdk095_patch1.zip esp_iot_sdk_v0.9.5/.dir
	$(UNTAR) $<
	mv libmain_fix_0.9.5.a $(VENDOR_SDK_DIR)/lib/libmain.a
	mv user_interface.h $(VENDOR_SDK_DIR)/include/
	patch -N -d $(VENDOR_SDK_DIR_0.9.5) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_0.9.4:
	patch -N -d $(VENDOR_SDK_DIR_0.9.4) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

.sdk_patch_0.9.3: esp_iot_sdk_v0.9.3_14_11_21_patch1.zip esp_iot_sdk_v0.9.3/.dir
	$(UNTAR) $<
	@touch $@

.sdk_patch_0.9.2: FRM_ERR_PATCH.rar esp_iot_sdk_v0.9.2/.dir 
	unrar x -o+ $<
	cp FRM_ERR_PATCH/*.a $(VENDOR_SDK_DIR)/lib/
	@touch $@

.sdk_patch_0.9.1:
	patch -N -d $(VENDOR_SDK_DIR_0.9.1) -p1 < $(PATCHES_DIR)/c_types-c99.patch
	@touch $@

$(PATCHES_DIR)/.gcc_patch: gcc_patch_$(GCC_VERSION)

gcc_patch_4.9.2:
	-patch -N -d $(XTDLP)/$(GCC_DIR) -p1 < $(PATCHES_DIR)/0001-WIP-don-t-bring-extra-u-int_least32_t-into-std.patch
	@touch $@

gcc_patch_5.1.0:
	-patch -N -d $(XTDLP)/$(GCC_DIR) -p1 < $(PATCHES_DIR)/0001-WIP-don-t-bring-extra-u-int_least32_t-into-std.patch

standalone: sdk sdk_patch
ifeq ($(STANDALONE),y)
	@echo "Installing vendor SDK headers into toolchain sysroot"
	@cp -R -f sdk/include/* $(TOOLCHAIN)/xtensa-lx106-elf/include/
	@echo "Installing vendor SDK libs into toolchain sysroot"
	@cp -R -f sdk/lib/* $(TOOLCHAIN)/xtensa-lx106-elf/lib/
	@echo "Installing vendor SDK linker scripts into toolchain sysroot"
	@sed -e 's/\r//' sdk/ld/eagle.app.v6.ld | sed -e s@../ld/@@ >$(TOOLCHAIN)/xtensa-lx106-elf/lib/eagle.app.v6.ld
	@sed -e 's/\r//' sdk/ld/eagle.rom.addr.v6.ld >$(TOOLCHAIN)/xtensa-lx106-elf/lib/eagle.rom.addr.v6.ld
endif

FRM_ERR_PATCH.rar:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=10" --output-document $@
esp_iot_sdk_v0.9.3_14_11_21_patch1.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=73" --output-document $@
sdk095_patch1.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=190" --output-document $@
libssl.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=316" --output-document $@
libnet80211.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=361" --output-document $@
lib_patch_on_sdk_v1.1.0.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=432" --output-document $@
scan_issue_test.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=525" --output-document $@
1.1.2_patch_02.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=546" --output-document $@
libssl_patch_1.2.0-1.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=583" --output-document $@
libssl_patch_1.2.0-2.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=586" --output-document $@
libsmartconfig_2.4.2.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=585" --output-document $@
lib_mem_optimize_150714.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=594" --output-document $@


$(TOP)/sdk: $(VENDOR_SDK_DIR)/.dir
	rm -rf sdk
	ln -snf $(VENDOR_SDK_DIR) sdk
  ifeq ($(OS),Windows_NT)
		rm -rf ESP8266_SDK
		ln -snf $(VENDOR_SDK_DIR) ESP8266_SDK
  endif

sdk: $(TOP)/sdk
	

$(VENDOR_SDK_DIR)/.dir: $(VENDOR_SDK_ZIP)
	$(UNTAR) $^
	-mv License $(VENDOR_SDK_DIR)
	-mv LICENSE $(VENDOR_SDK_DIR)
	touch $@


esp_iot_sdk_v1.5.0_15_11_27.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=989" --output-document $@

esp_iot_sdk_v1.4.0_15_09_18.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=838" --output-document $@

esp_iot_sdk_v1.3.0_15_08_08.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=664" --output-document $@

esp_iot_sdk_v1.2.0_15_07_03.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=564" --output-document $@

esp_iot_sdk_v1.1.2_15_06_12.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=521" --output-document $@

esp_iot_sdk_v1.1.1_15_06_05.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=484" --output-document $@

esp_iot_sdk_v1.1.0_15_05_26.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=425" --output-document $@

esp_iot_sdk_v1.1.0_15_05_22.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=423" --output-document $@

esp_iot_sdk_v1.0.1_15_04_24.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=325" --output-document $@

esp_iot_sdk_v1.0.1_b2_15_04_10.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=293" --output-document $@

esp_iot_sdk_v1.0.1_b1_15_04_02.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=276" --output-document $@

esp_iot_sdk_v1.0.0_15_03_20.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=250" --output-document $@

esp_iot_sdk_v0.9.6_b1_15_02_15.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=220" --output-document $@

esp_iot_sdk_v0.9.5_15_01_23.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=189" --output-document $@

esp_iot_sdk_v0.9.4_14_12_19.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=111" --output-document $@

esp_iot_sdk_v0.9.3_14_11_21.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=72" --output-document $@

esp_iot_sdk_v0.9.2_14_10_24.zip:
	wget --content-disposition "http://bbs.espressif.com/download/file.php?id=9" --output-document $@

$(VENDOR_SDK_ZIP_1.3.0-rtos):
	wget --no-check-certificate  --content-disposition "https://dl.bintray.com/kireevco/generic/$(VENDOR_SDK_ZIP_1.3.0-rtos)" --output-document $@

$(XTDLP)/$(GMP_TAR):
	wget -c http://ftp.gnu.org/gnu/gmp/$(GMP_TAR) --output-document $(XTDLP)/$(GMP_TAR)	

$(XTDLP)/$(MPC_TAR):
	wget -c http://ftp.gnu.org/gnu/mpc/$(MPC_TAR) --output-document $(XTDLP)/$(MPC_TAR)

$(XTDLP)/$(MPFR_TAR):
	wget -c http://ftp.gnu.org/gnu/mpfr/$(MPFR_TAR) --output-document $(XTDLP)/$(MPFR_TAR)

$(XTDLP)/$(GDB_TAR):
	wget http://ftp.gnu.org/gnu/gdb/$(GDB_TAR) --output-document $(XTDLP)/$(GDB_TAR)



$(XTDLP)/$(XTENSA_TOOLCHAIN_WINDOWS_TAR):
	wget --no-check-certificate https://dl.bintray.com/kireevco/generic/$(XTENSA_TOOLCHAIN_WINDOWS_TAR) --output-document $(XTDLP)/$(XTENSA_TOOLCHAIN_WINDOWS_TAR)

$(XTDLP)/$(XTENSA_TOOLCHAIN_MAC_TAR):	
	wget --no-check-certificate https://dl.bintray.com/kireevco/generic/$(XTENSA_TOOLCHAIN_MAC_TAR) --output-document $(XTDLP)/$(XTENSA_TOOLCHAIN_MAC_TAR)

$(XTDLP)/$(XTENSA_TOOLCHAIN_LINUX_TAR):
	wget --no-check-certificate https://dl.bintray.com/kireevco/generic/$(XTENSA_TOOLCHAIN_LINUX_TAR) --output-document $(XTDLP)/$(XTENSA_TOOLCHAIN_LINUX_TAR)
	

$(XTDLP)/$(BINUTILS_DIR)/configure.ac:
	@echo "You cloned without --recursive, fetching $(BINUTILS_DIR) for you."
	git submodule update --init src/$(BINUTILS_DIR)



$(XTDLP)/$(NEWLIB_DIR)/configure.ac:
#	git clone -b xtensa https://github.com/jcmvbkbc/newlib-xtensa.git $(XTDLP)/$(NEWLIB_DIR)
	@echo "You cloned without --recursive, fetching jcmvbkbc/newlib-xtensa for you."
	git submodule update --init src/$(NEWLIB_DIR)

$(XTDLP)/$(GCC_DIR)/configure.ac:
#	git clone https://github.com/jcmvbkbc/gcc-xtensa.git $(XTDLP)/$(GCC_DIR)
	@echo "You cloned without --recursive, fetching jcmvbkbc/gcc-xtensa for you."
	git submodule update --init src/$(GCC_DIR)

$(XTDLP)/$(LIBHAL_DIR)/configure.ac:
	@echo "You cloned without --recursive, fetching submodules for you."
	git submodule update --init src/$(LIBHAL_DIR)


$(XTDLP)/$(ESPTOOL_DIR)/esptool.py:
	@echo "You cloned without --recursive, fetching esptool for you."
	git submodule update --init src/$(ESPTOOL_DIR)

$(XTDLP)/$(ESPTOOL2_DIR)/esptool2.c:
	@echo "You cloned without --recursive, fetching esptool2 for you."
	git submodule update --init src/$(ESPTOOL2_DIR)

$(XTDLP)/$(MEMANALYZER_DIR)/MemAnalyzer.sln:
	@echo "You cloned without --recursive, fetching MemAnalyzer for you."
	git submodule update --init src/$(MEMANALYZER_DIR)




debug:
  ifeq ($(DEBUG),y)
	@echo "----------------------------------------------------"
	@echo "Outputting debug info. Makefiles are so Makefiles..."	
	@echo "PATH: $(PATH)"
	@echo "TOOLCHAIN: $(TOOLCHAIN)"
	@echo "----------------------------------------------------"

  endif

	


toolchain: $(TOOLCHAIN)/bin/xtensa-lx106-elf-gcc

$(TOOLCHAIN)/bin/xtensa-lx106-elf-gcc: $(TOOLCHAIN) $(XTDLP) $(XTBP) build-gmp build-mpfr build-mpc build-binutils build-gdb build-first-stage-gcc build-newlib build-second-stage-gcc build-libhal strip compress-upx
# $(TOOLCHAIN)/bin/xtensa-lx106-elf-gcc: $(XTDLP) $(XTBP) build-gmp build-mpfr build-mpc build-binutils build-first-stage-gcc 

get-src: $(XTDLP)/$(GMP_DIR) $(XTDLP)/$(MPFR_DIR) $(XTDLP)/$(MPC_DIR) $(XTDLP)/$(BINUTILS_DIR)/configure.ac $(XTDLP)/$(GCC_DIR)/configure.ac $(XTDLP)/$(NEWLIB_DIR)/configure.ac $(XTDLP)/$(LIBHAL_DIR)/configure.ac $(XTDLP)/$(GDB_DIR)/configure.ac
build-gmp: get-src $(XTDLP)/$(GMP_DIR)/build $(XTBP)/gmp
build-mpfr: get-src build-gmp $(XTDLP)/$(MPFR_DIR)/build $(XTBP)/mpfr
build-mpc: get-src build-gmp build-mpfr $(XTDLP)/$(MPC_DIR)/build $(XTBP)/mpc
build-binutils: get-src build-gmp build-mpfr build-mpc $(XTDLP)/$(BINUTILS_DIR)/build $(XTDLP)/$(BINUTILS_DIR)
build-first-stage-gcc: get-src build-gmp build-mpfr build-mpc build-binutils $(XTDLP)/$(GCC_DIR)/build-1
build-second-stage-gcc: get-src build-gmp build-mpfr build-mpc build-binutils build-first-stage-gcc $(XTDLP)/$(GCC_DIR)/build-2
build-newlib: get-src build-gmp build-mpfr build-mpc build-binutils $(XTDLP)/$(NEWLIB_DIR)/build $(XTDLP)/$(NEWLIB_DIR) 
build-libhal: get-src build-binutils $(XTDLP)/$(LIBHAL_DIR)/build $(XTDLP)/$(LIBHAL_DIR)
build-gdb: get-src build-binutils $(XTDLP)/$(GDB_DIR)/build $(XTDLP)/$(GDB_DIR)
compress-upx: $(TOOLCHAIN)/bin/.upx $(TOOLCHAIN)/xtensa-lx106-elf/bin/.upx $(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/.upx
strip: $(TOOLCHAIN)/bin/.strip $(TOOLCHAIN)/xtensa-lx106-elf/bin/.strip $(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/.strip

prebuilt-toolchain-windows: $(XTDLP)/$(XTENSA_TOOLCHAIN_WINDOWS_TAR)	
	$(UNTAR) $(XTDLP)/$(XTENSA_TOOLCHAIN_WINDOWS_TAR) -C $(TOP)

prebuilt-toolchain-mac: $(XTDLP)/$(XTENSA_TOOLCHAIN_MAC_TAR)
	$(UNTAR) $(XTDLP)/$(XTENSA_TOOLCHAIN_MAC_TAR) -C $(TOP)  

prebuilt-toolchain-linux: $(XTDLP)/$(XTENSA_TOOLCHAIN_LINUX_TAR)
	$(UNTAR) $(XTDLP)/$(XTENSA_TOOLCHAIN_LINUX_TAR) -C $(TOP)  

prebuilt-toolchain-freebsd: $(XTDLP)/$(XTENSA_TOOLCHAIN_LINUX_TAR)
	$(UNTAR) $(XTDLP)/$(XTENSA_TOOLCHAIN_LINUX_TAR) -C $(TOP)  


platform-specific:
	@echo "Performing platform-specific actions"
	
ifeq ($(OS),Windows_NT)
  ifneq (,$(findstring MINGW32,$(PLATFORM)))    
		@echo "Detected: MinGW32."
		$(MAKE) /mingw
    ifeq ($(PREBUILT_TOOLCHAIN),y)
			$(MAKE) prebuilt-toolchain-windows
			$(MAKE) build-prebuilt-toolchain
    else
			$(MAKE) build PATH="/c/tools/mingw32/bin:$(PATH)" BUILD_TARGET=i686-w64-mingw32 HOST_TARGET=i686-w64-mingw32
    endif
  endif
endif
    
ifneq (,$(findstring CYGWIN,$(PLATFORM)))
	@echo "Detected: CYGWIN"				
 ifeq ($(PREBUILT_TOOLCHAIN),y)
		$(MAKE) prebuilt-toolchain-windows
		$(MAKE) build-prebuilt-toolchain
  else
		$(MAKE) build BUILD_TARGET=i686-pc-cygwin HOST_TARGET=i686-w64-mingw32
  endif  
endif

ifeq ($(PLATFORM),Darwin)    
		@echo "Detected: MacOS"
    ifeq ($(PREBUILT_TOOLCHAIN),y)
			$(MAKE) prebuilt-toolchain-mac
			$(MAKE) build-prebuilt-toolchain
    else
			$(MAKE) build
    endif
else
  ifeq ($(PLATFORM),Linux)
			@echo "Detected: Linux"
      ifeq ($(PREBUILT_TOOLCHAIN),y)
				$(MAKE) prebuilt-toolchain-linux
				$(MAKE) build-prebuilt-toolchain
      else
				$(MAKE) build
      endif
  endif
  ifeq ($(PLATFORM),FreeBSD)
			@echo "Detected: FreeBSD"
      ifeq ($(PREBUILT_TOOLCHAIN),y)
				$(MAKE) prebuilt-toolchain-freebsd
      endif
			$(MAKE) build
  endif
endif


/mingw:
	@echo "/mingw directory not found, mounting"
	mount $(MINGW_DIR) /mingw	

$(XTDLP):
	mkdir -p $(XTDLP)

$(XTBP):
	mkdir -p $(XTBP)

$(TOOLCHAIN):
	git config --global core.autocrlf false
	mkdir -p $(TOOLCHAIN)

# GMP
$(XTDLP)/$(GMP_DIR): $(XTDLP)/$(GMP_TAR)
	@echo "################## GMP ##################"
	mkdir -p $(XTDLP)/$(GMP_DIR)
	$(UNTAR) $(XTDLP)/$(GMP_TAR) -C $(XTDLP)/$(GMP_DIR)
	mv $(XTDLP)/$(GMP_DIR)/gmp-*/* $(XTDLP)/$(GMP_DIR)

$(XTDLP)/$(GMP_DIR)/build: $(XTDLP)/$(GMP_DIR)
	mkdir -p $(XTDLP)/$(GMP_DIR)/build/
	cd $(XTDLP)/$(GMP_DIR)/build/; PATH=$(SAFEPATH); ../$(CONF_OPT) --prefix=$(XTBP)/gmp --disable-shared --enable-static --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) -C $(XTDLP)/$(GMP_DIR)/build/

$(XTBP)/gmp: $(XTDLP)/$(GMP_DIR)/build
	make $(INST_OPT) -C $(XTDLP)/$(GMP_DIR)/build/

# MPFR	
$(XTDLP)/$(MPFR_DIR): $(XTDLP)/$(MPFR_TAR)
	@echo "################## MPFR ##################"
	mkdir -p $(XTDLP)/$(MPFR_DIR)
	$(UNTAR) $(XTDLP)/$(MPFR_TAR) -C $(XTDLP)/

$(XTDLP)/$(MPFR_DIR)/build: $(XTDLP)/$(MPFR_DIR)
	mkdir -p $(XTDLP)/$(MPFR_DIR)/build
	cd $(XTDLP)/$(MPFR_DIR)/build/; PATH=$(SAFEPATH); ../$(CONF_OPT) --prefix=$(XTBP)/mpfr --with-gmp=$(XTBP)/gmp --disable-shared --enable-static --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) -C $(XTDLP)/$(MPFR_DIR)/build/

$(XTBP)/mpfr: $(XTDLP)/$(MPFR_DIR)/build
	make $(INST_OPT) -C $(XTDLP)/$(MPFR_DIR)/build/

# MPC	
$(XTDLP)/$(MPC_DIR): $(XTDLP)/$(MPC_TAR)
	@echo "################## MPC ##################"
	mkdir -p $(XTDLP)/$(MPC_DIR)
	$(UNTAR) $(XTDLP)/$(MPC_TAR) -C $(XTDLP)/


$(XTDLP)/$(MPC_DIR)/build: $(XTDLP)/$(MPC_DIR)
	mkdir -p $(XTDLP)/$(MPC_DIR)/build	
	cd $(XTDLP)/$(MPC_DIR)/build/; ../$(CONF_OPT) --prefix=$(XTBP)/mpc --with-mpfr=$(XTBP)/mpfr --with-gmp=$(XTBP)/gmp --disable-shared --enable-static --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) -C $(XTDLP)/$(MPC_DIR)/build/

$(XTBP)/mpc: $(XTDLP)/$(MPC_DIR)/build
	make $(INST_OPT) -C $(XTDLP)/$(MPC_DIR)/build/


# Binutils
$(XTDLP)/$(BINUTILS_DIR)/build: $(XTDLP)/$(BINUTILS_DIR)/configure.ac
	@echo "################## BINUTILS ##################"
	mkdir -p $(XTDLP)/$(BINUTILS_DIR)/build
	cd $(XTDLP)/$(BINUTILS_DIR)/build/; chmod -R 777 $(XTDLP)/$(BINUTILS_DIR); ../$(CONF_OPT) --prefix=$(TOOLCHAIN) --target=$(TARGET) --enable-werror=no  --enable-multilib --disable-nls --disable-shared --disable-threads --with-gcc --with-gnu-as --with-gnu-ld --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) -C $(XTDLP)/$(BINUTILS_DIR)/build/
	@touch $@

$(XTDLP)/$(BINUTILS_DIR): $(XTDLP)/$(BINUTILS_DIR)/build
	make $(INST_OPT) -C $(XTDLP)/$(BINUTILS_DIR)/build/
	@touch $@

# GDB
$(XTDLP)/$(GDB_DIR)/configure.ac: $(XTDLP)/$(GDB_TAR)
	@echo "################## GDB ##################"
  ifeq "$(wildcard $(XTDLP)/$(GDB_DIR) )" ""
	mkdir -p $(XTDLP)/$(GDB_DIR)
	$(UNTAR) $(XTDLP)/$(GDB_TAR) -C $(XTDLP)
  endif

$(XTDLP)/$(GDB_DIR)/build: $(XTDLP)/$(GDB_DIR)/configure.ac
	mkdir -p $(XTDLP)/$(GDB_DIR)/build
	cd $(XTDLP)/$(GDB_DIR)/build/; chmod -R 777 $(XTDLP)/$(GDB_DIR); ../$(CONF_OPT) --prefix=$(TOOLCHAIN) --target=$(TARGET) --enable-werror=no  --enable-multilib --disable-nls --disable-shared --disable-threads --with-gcc --with-gnu-as --with-gnu-ld --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) -C $(XTDLP)/$(GDB_DIR)/build/
	@touch $@

$(XTDLP)/$(GDB_DIR): $(XTDLP)/$(GDB_DIR)/build
	make $(INST_OPT) -C $(XTDLP)/$(GDB_DIR)/build/
	@touch $@

# GCC Step 1
$(XTDLP)/$(GCC_DIR)/build-1: $(XTDLP)/$(GCC_DIR)/configure.ac
	@echo "################## GCC PASS 1 ##################"
	mkdir -p $(XTDLP)/$(GCC_DIR)/build-1
	cd $(XTDLP)/$(GCC_DIR)/build-1/; ../$(CONF_OPT) --prefix=$(TOOLCHAIN) --target=$(TARGET) --enable-multilib --enable-languages=c --with-newlib --disable-nls --disable-shared --disable-threads --with-gnu-as --with-gnu-ld --with-gmp=$(XTBP)/gmp --with-mpfr=$(XTBP)/mpfr --with-mpc=$(XTBP)/mpc  --disable-libssp --without-headers --disable-__cxa_atexit --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) all-gcc -C $(XTDLP)/$(GCC_DIR)/build-1/
	$(MAKE_OPT) install-gcc -C $(XTDLP)/$(GCC_DIR)/build-1/
	cd $(TOOLCHAIN)/bin/; cp xtensa-lx106-elf-gcc xtensa-lx106-elf-cc
	@touch $@

# GCC Step 2
$(XTDLP)/$(GCC_DIR)/build-2: $(XTDLP)/$(GCC_DIR)/configure.ac $(XTDLP)/$(NEWLIB_DIR)
	@echo "################## GCC PASS 2 ##################"
	make $(PATCHES_DIR)/.gcc_patch
	mkdir -p $(XTDLP)/$(GCC_DIR)/build-2
	cd $(XTDLP)/$(GCC_DIR)/build-2/; ../$(CONF_OPT) --prefix=$(TOOLCHAIN) --target=$(TARGET) --enable-multilib --disable-nls --disable-shared --disable-threads --with-gnu-as --with-gnu-ld --with-gmp=$(XTBP)/gmp --with-mpfr=$(XTBP)/mpfr --with-mpc=$(XTBP)/mpc --enable-languages=c,c++ --with-newlib --disable-libssp --disable-__cxa_atexit --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) -C $(XTDLP)/$(GCC_DIR)/build-2/
	make $(INST_OPT) -C $(XTDLP)/$(GCC_DIR)/build-2/
	@touch $@

$(XTDLP)/$(GCC_DIR): $(XTDLP)/$(GCC_DIR)/build-1 $(XTDLP)/$(GCC_DIR)/build-2
	@touch $@

# Newlib
$(XTDLP)/$(NEWLIB_DIR)/build: $(XTDLP)/$(NEWLIB_DIR)/configure.ac
	@echo "################## NEWLIB ##################"
	mkdir $(XTDLP)/$(NEWLIB_DIR)/build
	cd $(XTDLP)/$(NEWLIB_DIR)/build/; ../$(CONF_OPT) --prefix=$(TOOLCHAIN) --target=$(TARGET) --enable-multilib --with-gnu-as --with-gnu-ld --disable-nls --build=$(BUILD_TARGET) --host=$(HOST_TARGET)
	$(MAKE_OPT) -C $(XTDLP)/$(NEWLIB_DIR)/build/
	@touch $@

$(XTDLP)/$(NEWLIB_DIR): $(XTDLP)/$(NEWLIB_DIR)/build
	make $(INST_OPT) -C $(XTDLP)/$(NEWLIB_DIR)/build/
	@touch $@

# Libhal
$(XTDLP)/$(LIBHAL_DIR)/build: $(XTDLP)/$(LIBHAL_DIR)/configure.ac
	@echo "################## LIBHAL ##################"
	cd $(XTDLP)/$(LIBHAL_DIR); autoreconf -i
	mkdir -p $(XTDLP)/$(LIBHAL_DIR)/build/
	cd $(XTDLP)/$(LIBHAL_DIR)/build/; PATH=$(SAFEPATH) ../$(CONF_OPT) --host=$(TARGET) --prefix=$(TOOLCHAIN)/xtensa-lx106-elf/
	PATH=$(SAFEPATH) $(MAKE_OPT) -C $(XTDLP)/$(LIBHAL_DIR)/build/
	@touch $@

$(XTDLP)/$(LIBHAL_DIR): $(XTDLP)/$(LIBHAL_DIR)/build
	PATH=$(SAFEPATH) make $(INST_OPT) -C $(XTDLP)/$(LIBHAL_DIR)/build/
	@touch $@

# Srip Debug
$(TOOLCHAIN)/bin/.strip:	
	@echo "Stripping debug symbols from executables in ${TOOLCHAIN}/bin/"
	cd $(TOOLCHAIN)/bin/ && (find . -type f -perm 0111 -exec strip -S "{}" +) & touch $(TOOLCHAIN)/bin/.strip

$(TOOLCHAIN)/xtensa-lx106-elf/bin/.strip:
	@echo "Stripping debug symbols from executables in ${TOOLCHAIN}/xtensa-lx106-elf/bin/"
	cd $(TOOLCHAIN)/xtensa-lx106-elf/bin && (find . -type f -perm 0111 -exec strip -S "{}" +) & touch $(TOOLCHAIN)/xtensa-lx106-elf/bin/.strip

$(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/.strip:
	@echo "Stripping debug symbols from executables in ${TOOLCHAIN}/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/"
	cd $(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/ && (find . -type f -perm 0111 -exec strip -S "{}" +) & touch $(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/.strip


# Compress via UPX
$(TOOLCHAIN)/bin/.upx:
	@echo "Compressing executables in ${TOOLCHAIN}/bin/"
	cd $(TOOLCHAIN)/bin/ && (find . -type f -perm 0111 -exec upx --best "{}" +) & touch $(TOOLCHAIN)/bin/.upx

$(TOOLCHAIN)/xtensa-lx106-elf/bin/.upx:
	@echo "Compressing executables in ${TOOLCHAIN}/xtensa-lx106-elf/bin/"
	cd $(TOOLCHAIN)/xtensa-lx106-elf/bin && (find . -type f -perm 0111 -exec upx --best "{}" +) & touch $(TOOLCHAIN)/xtensa-lx106-elf/bin/.upx

$(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/.upx:
	@echo "Compressing executables in ${TOOLCHAIN}/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/"
	cd $(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/ && (find . -type f -perm 0111 -exec upx --best "{}" +) & touch $(TOOLCHAIN)/libexec/gcc/xtensa-lx106-elf/$(GCC_VERSION)/.upx




clean: clean-sdk
	-rm -rf $(TOOLCHAIN)
	rm -rf $(XTDLP)/$(GMP_DIR)/build
	rm -rf $(XTDLP)/$(MPFR_DIR)/build
	rm -rf $(XTDLP)/$(MPC_DIR)/build
	rm -rf $(XTDLP)/$(BINUTILS_DIR)/build
	rm -rf $(XTDLP)/$(GCC_DIR)/build-1
	rm -rf $(XTDLP)/$(GCC_DIR)/build-2
	rm -rf $(XTDLP)/$(NEWLIB_DIR)/build
	rm -rf $(XTDLP)/$(LIBHAL_DIR)/build
	rm -rf $(XTDLP)/$(GDB_DIR)/build
	rm -rf $(XTDLP)/$(ESPTOOL2_DIR)/esptool2
	rm -rf $(UTILS_DIR)/*

clean-sdk:
	rm -rf $(VENDOR_SDK_DIR)
	rm -rf $(VENDOR_SDK_ZIP)
	rm -rf release_note.txt
	rm -rf sdk
	rm -rf ESP8266_SDK
	rm -f .sdk_patch_*
	rm -f $(PATCHES_DIR)/.gcc_patch*
	rm -rf build
	rm -rf bin


purge: clean
	rm -rf $(XTDLP)/$(GMP_DIR)/
	rm -rf $(XTDLP)/$(MPFR_DIR)/
	rm -rf $(XTDLP)/$(MPC_DIR)/
	rm -rf $(XTDLP)/$(GDB_DIR)/
	rm -rf $(XTDLP)/$(UTILS_DIR)/
	rm -rf $(XTDLP)/*.{zip,bz2,xz,gz}
	cd $(XTDLP)/$(BINUTILS_DIR)/; git reset --hard
	cd $(XTDLP)/$(GCC_DIR)/; git reset --hard
	cd $(XTDLP)/$(NEWLIB_DIR)/; git reset --hard
	cd $(XTDLP)/$(LIBHAL_DIR)/; git reset --hard
	cd $(XTDLP)/$(ESPTOOL2_DIR); git reset --hard

clean-sysroot:
	rm -rf $(TOOLCHAIN)/xtensa-lx106-elf/usr/lib/*
	rm -rf $(TOOLCHAIN)/xtensa-lx106-elf/usr/include/*
