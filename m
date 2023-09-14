Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F77A01CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbjINKhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjINKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:37:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0DD1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:36:55 -0700 (PDT)
X-QQ-mid: bizesmtp62t1694687770tc0ax3wh
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 18:36:07 +0800 (CST)
X-QQ-SSF: 00200000000000907000000A0000000
X-QQ-FEAT: QityeSR92A3McIomN9U9NmeiRqhK4geqfNR+UMSijkaoEF+prEGz5E6z1Z0ra
        rDHfriq1Iwoblco1m50jRLj5Bf3SyE/oj4Ifti11gSicGXLBXKm5SzdyGWPg/waEzwxdoZi
        USbVul+DUZc77BOF23H/aiSKB20toY60qoX1AsXSxy6+ypDHkhkLtQciZI9fgL71+blwe3b
        ycX8YF9XksBkAot7uy57x21jfsikuQyHmEcw3nvjy9xiSFVDqV+P+Q+qdjRzpn4Y7YvQFmR
        Xys4iDi87/s7VQNJ/MGnH1dXAkaDujXnokxKLk9i6gvvZ1Vj2speP77YaqzA5J4ZZ6asn76
        pWcnJLfFm0u9bZeCYRnimdiOvJPq8Tp2IU0JzosOpXbLBUkT5qmkUGfaYk2mg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9747960263612415347
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, falcon@tinylab.org,
        w@1wt.eu, linux@weissschuh.net, tanyuan@tinylab.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 1/3] x86/config: Cleanup i386_defconfig and x86_64_defconfig
Date:   Thu, 14 Sep 2023 18:36:06 +0800
Message-Id: <e9aad853957b4ce50cd1f5c15a622f29c7f28d63.1694687048.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694687048.git.tanyuan@tinylab.org>
References: <cover.1694687048.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'make savedefconfig' to cleanup i386_defconfig and x86_64_defconfig.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/x86/configs/i386_defconfig   | 29 +++++++++--------------------
 arch/x86/configs/x86_64_defconfig |  7 +------
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 1b411bbf3cb0..babd91c8091a 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,7 +1,6 @@
 CONFIG_WERROR=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_USELIB=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -28,21 +27,20 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
+CONFIG_CRASH_DUMP=y
 CONFIG_SMP=y
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
-CONFIG_NR_CPUS=8
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
 CONFIG_X86_MSR=y
 CONFIG_X86_CPUID=y
+CONFIG_NUMA=y
 CONFIG_X86_CHECK_BIOS_CORRUPTION=y
 # CONFIG_MTRR_SANITIZER is not set
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
+CONFIG_EFI_MIXED=y
 CONFIG_HZ_1000=y
-CONFIG_KEXEC=y
-CONFIG_CRASH_DUMP=y
-# CONFIG_RETHUNK is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
@@ -51,9 +49,9 @@ CONFIG_ACPI_BGRT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_X86_ACPI_CPUFREQ=y
+CONFIG_IA32_EMULATION=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
-CONFIG_COMPAT_32BIT_TIME=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -64,9 +62,7 @@ CONFIG_BINFMT_MISC=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
-CONFIG_UNIX=y
 CONFIG_XFRM_USER=y
-CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
@@ -127,7 +123,6 @@ CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
-CONFIG_PCI_MSI=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_PCCARD=y
 CONFIG_YENTA=y
@@ -135,7 +130,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
-CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
@@ -150,8 +144,6 @@ CONFIG_ATA_PIIX=y
 CONFIG_PATA_AMD=y
 CONFIG_PATA_OLDPIIX=y
 CONFIG_PATA_SCH=y
-CONFIG_PATA_MPIIX=y
-CONFIG_ATA_GENERIC=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_BLK_DEV_DM=y
@@ -162,17 +154,14 @@ CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
 CONFIG_VIRTIO_NET=y
-CONFIG_BNX2=y
 CONFIG_TIGON3=y
 CONFIG_NET_TULIP=y
 CONFIG_E100=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_SKY2=y
-CONFIG_NE2K_PCI=y
 CONFIG_FORCEDETH=y
 CONFIG_8139TOO=y
-# CONFIG_8139TOO_PIO is not set
 CONFIG_R8169=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_JOYSTICK=y
@@ -191,6 +180,8 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_INTEL is not set
+# CONFIG_HW_RANDOM_AMD is not set
 CONFIG_NVRAM=y
 CONFIG_HPET=y
 # CONFIG_HPET_MMAP is not set
@@ -237,12 +228,14 @@ CONFIG_DMADEVICES=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_EEEPC_LAPTOP=y
+CONFIG_AMD_IOMMU=y
+CONFIG_INTEL_IOMMU=y
+# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=y
 CONFIG_AUTOFS_FS=y
 CONFIG_ISO9660_FS=y
@@ -267,10 +260,8 @@ CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_WX=y
 CONFIG_DEBUG_STACK_USAGE=y
@@ -280,5 +271,3 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_UNWINDER_FRAME_POINTER=y
-# CONFIG_64BIT is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 409e9182bd29..babd91c8091a 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -27,6 +27,7 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
+CONFIG_CRASH_DUMP=y
 CONFIG_SMP=y
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
@@ -40,8 +41,6 @@ CONFIG_EFI=y
 CONFIG_EFI_STUB=y
 CONFIG_EFI_MIXED=y
 CONFIG_HZ_1000=y
-CONFIG_KEXEC=y
-CONFIG_CRASH_DUMP=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
@@ -63,9 +62,7 @@ CONFIG_BINFMT_MISC=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
-CONFIG_UNIX=y
 CONFIG_XFRM_USER=y
-CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
@@ -239,7 +236,6 @@ CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=y
 CONFIG_AUTOFS_FS=y
 CONFIG_ISO9660_FS=y
@@ -264,7 +260,6 @@ CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
-- 
2.34.1

