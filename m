Return-Path: <linux-kernel+bounces-69096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE383858470
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D553280FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC91369BE;
	Fri, 16 Feb 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SsuA7Nva"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038481353E6;
	Fri, 16 Feb 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105366; cv=none; b=k1ZKTIt4qhSs9o4YxwuIXtrQ0HnoFVkCZU5NserfXm7N+MGnxS2x7CTlpI3mry91mKrZUtLdO0/Stj81Nvit6VmAYSQrW+RlXAJIAlH+JfsxlkMKv9iEXkLeoNlBB/ARWlImTgguAb1dHjbO4aH4NTuwFfsndgjL8bg3tJ7j6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105366; c=relaxed/simple;
	bh=PpsyNMdLxEOIEfnbTp+pBvpidipRHF9L8aBJTqmqb/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvYf6nw3Jyey8eJr3PxaDtbhor9Tqnc72WizSyImgc9BhtuWA7eO5Fai+xVQKBclDJlPyUclzXimM6O3SxVm31UTEnsgM0j8HW/uvgWA3YElYS1oeJwEGwrjUlmrp2tj/tirJCZ8/dCW5Bl+DaZWdAhCm1nWZTPXwdrAGAURFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SsuA7Nva; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16DA31C0006;
	Fri, 16 Feb 2024 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/xJ16yj8WxYIe9GyjcF+QVWZQeGfsPuTQ2nq8RbNuU=;
	b=SsuA7NvamiWZNQcZnchgBOayZIqArrvJQxQUmGOYgPQPL/SXbGEXpKSj3n3hhFQ7fFK4o2
	+RZwJOnKF/9o6+XvH29c6gLl6HDcaSDCw1/IqZ5/k0WkG0ypY/oV2eCItpyDAVtQOYInZM
	gvlNCiL3rtSFEUSCDQaM6bq3Ygj3EPyHO+qjgkjBQYdxPBi1umWiSc3ZAnk7+gbwXb29lj
	eG62/HJhrsDWAIQ1VT3xajkm+9UhjGRf7kYlzzWDaJ0yi6BKi/fqRocYBCphafmlKz4nJd
	Wb+JUuhQZ8kCZcvsVfuBzZPU40CY22OkAw/Exef/HHQYXVpiLWXwwRfySRiEfA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v8 13/14] MIPS: Add support for Mobileye EyeQ5
Date: Fri, 16 Feb 2024 18:42:22 +0100
Message-ID: <20240216174227.409400-14-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Introduce support for the MIPS based Mobileye EyeQ5 SoCs.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/Kbuild.platforms          |   1 +
 arch/mips/Kconfig                   |  54 ++++++++++++++
 arch/mips/configs/eyeq5_defconfig   | 108 ++++++++++++++++++++++++++++
 arch/mips/mobileye/Makefile         |   1 +
 arch/mips/mobileye/Platform         |  16 +++++
 arch/mips/mobileye/board-epm5.its.S |  24 +++++++
 arch/mips/mobileye/vmlinux.its.S    |  32 +++++++++
 7 files changed, 236 insertions(+)
 create mode 100644 arch/mips/configs/eyeq5_defconfig
 create mode 100644 arch/mips/mobileye/Makefile
 create mode 100644 arch/mips/mobileye/Platform
 create mode 100644 arch/mips/mobileye/board-epm5.its.S
 create mode 100644 arch/mips/mobileye/vmlinux.its.S

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index a2311c4bce6a6..5c145b67d3bf4 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -17,6 +17,7 @@ platform-$(CONFIG_MACH_LOONGSON2EF)	+= loongson2ef/
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 platform-$(CONFIG_MACH_LOONGSON64)	+= loongson64/
 platform-$(CONFIG_MIPS_MALTA)		+= mti-malta/
+platform-$(CONFIG_MACH_EYEQ5)		+= mobileye/
 platform-$(CONFIG_MACH_NINTENDO64)	+= n64/
 platform-$(CONFIG_PIC32MZDA)		+= pic32/
 platform-$(CONFIG_RALINK)		+= ralink/
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5549d26448941..a40eb9ecb50d5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -569,6 +569,60 @@ config MACH_PIC32
 	  Microchip PIC32 is a family of general-purpose 32 bit MIPS core
 	  microcontrollers.
 
+config MACH_EYEQ5
+	bool "Mobileye EyeQ5 SoC"
+	select MACH_GENERIC_CORE
+	select ARM_AMBA
+	select PHYSICAL_START_BOOL
+	select ARCH_SPARSEMEM_DEFAULT if 64BIT
+	select BOOT_RAW
+	select BUILTIN_DTB
+	select CEVT_R4K
+	select CLKSRC_MIPS_GIC
+	select COMMON_CLK
+	select CPU_MIPSR2_IRQ_EI
+	select CPU_MIPSR2_IRQ_VI
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select HAVE_PCI
+	select IRQ_MIPS_CPU
+	select MIPS_AUTO_PFN_OFFSET
+	select MIPS_CPU_SCACHE
+	select MIPS_GIC
+	select MIPS_L1_CACHE_SHIFT_7
+	select PCI_DRIVERS_GENERIC
+	select SMP_UP if SMP
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_MIPS64_R6
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_MIPS_CPS
+	select SYS_SUPPORTS_RELOCATABLE
+	select SYS_SUPPORTS_ZBOOT
+	select UHI_BOOT
+	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USE_OF
+	help
+	  Select this to build a kernel supporting EyeQ5 SoC from Mobileye.
+
+	bool
+
+config FIT_IMAGE_FDT_EPM5
+	bool "Include FDT for Mobileye EyeQ5 development platforms"
+	depends on MACH_EYEQ5
+	default n
+	help
+	  Enable this to include the FDT for the EyeQ5 development platforms
+	  from Mobileye in the FIT kernel image.
+	  This requires u-boot on the platform.
+
+
 config MACH_NINTENDO64
 	bool "Nintendo 64 console"
 	select CEVT_R4K
diff --git a/arch/mips/configs/eyeq5_defconfig b/arch/mips/configs/eyeq5_defconfig
new file mode 100644
index 0000000000000..c35c29a4d4795
--- /dev/null
+++ b/arch/mips/configs/eyeq5_defconfig
@@ -0,0 +1,108 @@
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_TASKSTATS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_MEMCG=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_MACH_EYEQ5=y
+CONFIG_FIT_IMAGE_FDT_EPM5=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_MIPS_CPS=y
+CONFIG_CPU_HAS_MSA=y
+CONFIG_NR_CPUS=16
+CONFIG_MIPS_RAW_APPENDED_DTB=y
+CONFIG_JUMP_LABEL=y
+CONFIG_COMPAT_32BIT_TIME=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_TRIM_UNUSED_KSYMS=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_USERFAULTFD=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_NETFILTER=y
+CONFIG_CAN=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DEBUG=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_BLOCK=y
+CONFIG_SCSI=y
+CONFIG_NETDEVICES=y
+CONFIG_MACVLAN=y
+CONFIG_IPVLAN=y
+CONFIG_MACB=y
+CONFIG_MARVELL_PHY=y
+CONFIG_MICREL_PHY=y
+CONFIG_CAN_M_CAN=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_HW_RANDOM=y
+# CONFIG_PTP_1588_CLOCK is not set
+CONFIG_PINCTRL=y
+CONFIG_MFD_SYSCON=y
+CONFIG_HID_A4TECH=y
+CONFIG_HID_BELKIN=y
+CONFIG_HID_CHERRY=y
+CONFIG_HID_CYPRESS=y
+CONFIG_HID_EZKEY=y
+CONFIG_HID_ITE=y
+CONFIG_HID_KENSINGTON=y
+CONFIG_HID_REDRAGON=y
+CONFIG_HID_MICROSOFT=y
+CONFIG_HID_MONTEREY=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_RESET_CONTROLLER=y
+# CONFIG_NVMEM is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_FS_ENCRYPTION=y
+CONFIG_FUSE_FS=y
+CONFIG_CUSE=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_UBIFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_ROOT_NFS=y
+CONFIG_CRYPTO_CRC32_MIPS=y
+CONFIG_FRAME_WARN=1024
+CONFIG_DEBUG_FS=y
+# CONFIG_RCU_TRACE is not set
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="earlycon"
diff --git a/arch/mips/mobileye/Makefile b/arch/mips/mobileye/Makefile
new file mode 100644
index 0000000000000..315c06b689cfb
--- /dev/null
+++ b/arch/mips/mobileye/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/arch/mips/mobileye/Platform b/arch/mips/mobileye/Platform
new file mode 100644
index 0000000000000..43b6f4644592f
--- /dev/null
+++ b/arch/mips/mobileye/Platform
@@ -0,0 +1,16 @@
+#
+# Copyright (C) 2016 Imagination Technologies
+# Author: Paul Burton <paul.burton@mips.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the
+# Free Software Foundation;  either version 2 of the  License, or (at your
+# option) any later version.
+#
+
+load-$(CONFIG_MACH_EYEQ5)	= 0xa800000808000000
+all-$(CONFIG_MACH_EYEQ5)	+= vmlinux.gz.itb
+
+its-y					:= vmlinux.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_EPM5)	+= board-epm5.its.S
+
diff --git a/arch/mips/mobileye/board-epm5.its.S b/arch/mips/mobileye/board-epm5.its.S
new file mode 100644
index 0000000000000..08e8c4f183d63
--- /dev/null
+++ b/arch/mips/mobileye/board-epm5.its.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/ {
+	images {
+		fdt-mobileye-epm5 {
+			description = "Mobileeye MP5 Device Tree";
+			data = /incbin/("boot/dts/mobileye/eyeq5-epm5.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash {
+				algo = "sha1";
+			};
+		};
+	};
+
+    configurations {
+		default = "conf-1";
+		conf-1 {
+			description = "Mobileye EPM5 Linux kernel";
+			kernel = "kernel";
+			fdt = "fdt-mobileye-epm5";
+		};
+	};
+};
diff --git a/arch/mips/mobileye/vmlinux.its.S b/arch/mips/mobileye/vmlinux.its.S
new file mode 100644
index 0000000000000..3e254676540f4
--- /dev/null
+++ b/arch/mips/mobileye/vmlinux.its.S
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/dts-v1/;
+
+/ {
+	description = KERNEL_NAME;
+	#address-cells = <ADDR_CELLS>;
+
+	images {
+		kernel {
+			description = KERNEL_NAME;
+			data = /incbin/(VMLINUX_BINARY);
+			type = "kernel";
+			arch = "mips";
+			os = "linux";
+			compression = VMLINUX_COMPRESSION;
+			load = /bits/ ADDR_BITS <VMLINUX_LOAD_ADDRESS>;
+			entry = /bits/ ADDR_BITS <VMLINUX_ENTRY_ADDRESS>;
+			hash {
+				algo = "sha1";
+			};
+		};
+	};
+
+	configurations {
+		default = "conf-default";
+
+		conf-default {
+			description = "Generic Linux kernel";
+			kernel = "kernel";
+		};
+	};
+};
-- 
2.43.0


