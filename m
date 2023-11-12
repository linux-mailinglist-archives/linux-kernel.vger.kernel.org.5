Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0887E8ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjKLGUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjKLGUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:20:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87B5240
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:19:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7069C43397;
        Sun, 12 Nov 2023 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769953;
        bh=Ooj3Z1D8vrwoAvcfoMd2XHUN9ti4j9jFEKxp5Li/2zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkKhnGt+QvcqgukqOM+LkGz4JZ+VW0ka4FydtVLSoYTHX96HX8Mo8GskYTo3Vyh45
         Y4WQ5dxOn/7Kg+WegYxnlemqGxlUSDBkO3ktXh+e3YCBDvpla3qtQvAPvDpCNQh5Qh
         aOKI347cT0SNAqmMdibar/SmpVMz3cpcUpdq9iH+hgppi/pBWLyLccIgcQoeIhYIUR
         oaQNK5k78JUbTOIzix4OIf3otG6UglXiEY2tv+80rGdE7q04hgiiAg8FeKWUens2cE
         LuUwa+cKueaL5l8oh/h2NKpWczNKABQhLxBtjVbzgPPAxgdbT0tRLgvXUuFnRk6DY/
         C/3y7pp2DpNYg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 37/38] add tinylab defconfig
Date:   Sun, 12 Nov 2023 01:15:13 -0500
Message-Id: <20231112061514.2306187-38-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/configs/tinylab32ilp32_defconfig | 88 ++++++++++++++++++++
 arch/riscv/configs/tinylab64ilp32_defconfig | 89 +++++++++++++++++++++
 arch/riscv/configs/tinylab_defconfig        | 89 +++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 arch/riscv/configs/tinylab32ilp32_defconfig
 create mode 100644 arch/riscv/configs/tinylab64ilp32_defconfig
 create mode 100644 arch/riscv/configs/tinylab_defconfig

diff --git a/arch/riscv/configs/tinylab32ilp32_defconfig b/arch/riscv/configs/tinylab32ilp32_defconfig
new file mode 100644
index 000000000000..64adbc788430
--- /dev/null
+++ b/arch/riscv/configs/tinylab32ilp32_defconfig
@@ -0,0 +1,88 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_RD_ZSTD is not set
+# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_MULTIUSER is not set
+# CONFIG_SYSFS_SYSCALL is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_POSIX_TIMERS is not set
+# CONFIG_BUG is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
+# CONFIG_IO_URING is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+# CONFIG_MEMBARRIER is not set
+# CONFIG_KALLSYMS is not set
+# CONFIG_RSEQ is not set
+CONFIG_EMBEDDED=y
+CONFIG_NONPORTABLE=y
+CONFIG_ARCH_RV32I=y
+CONFIG_CMODEL_MEDANY=y
+# CONFIG_RISCV_ISA_SVPBMT is not set
+# CONFIG_RISCV_ISA_ZICBOM is not set
+# CONFIG_RISCV_ISA_ZICBOZ is not set
+# CONFIG_FPU is not set
+# CONFIG_SECCOMP is not set
+# CONFIG_STACKPROTECTOR is not set
+# CONFIG_STRICT_KERNEL_RWX is not set
+# CONFIG_BLOCK is not set
+# CONFIG_BINFMT_SCRIPT is not set
+# CONFIG_COREDUMP is not set
+CONFIG_SLUB_TINY=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_COMPACTION is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SECRETMEM is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_LEGACY_TIOCSTI is not set
+# CONFIG_LDISC_AUTOLOAD is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_DEVMEM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_FS is not set
+# CONFIG_SYSFS is not set
+# CONFIG_EFIVAR_FS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_INIT_STACK_NONE=y
+# CONFIG_SYMBOLIC_ERRNAME is not set
+# CONFIG_DEBUG_MISC is not set
+# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
+CONFIG_PANIC_TIMEOUT=1
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
diff --git a/arch/riscv/configs/tinylab64ilp32_defconfig b/arch/riscv/configs/tinylab64ilp32_defconfig
new file mode 100644
index 000000000000..703778a13157
--- /dev/null
+++ b/arch/riscv/configs/tinylab64ilp32_defconfig
@@ -0,0 +1,89 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_RD_ZSTD is not set
+# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_MULTIUSER is not set
+# CONFIG_SYSFS_SYSCALL is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_POSIX_TIMERS is not set
+# CONFIG_BUG is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
+# CONFIG_IO_URING is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+# CONFIG_MEMBARRIER is not set
+# CONFIG_KALLSYMS is not set
+# CONFIG_RSEQ is not set
+CONFIG_EMBEDDED=y
+CONFIG_NONPORTABLE=y
+CONFIG_ARCH_RV64ILP32=y
+CONFIG_CMODEL_MEDANY=y
+# CONFIG_RISCV_ISA_C is not set
+# CONFIG_RISCV_ISA_SVPBMT is not set
+# CONFIG_RISCV_ISA_ZICBOM is not set
+# CONFIG_RISCV_ISA_ZICBOZ is not set
+# CONFIG_FPU is not set
+# CONFIG_EFI is not set
+# CONFIG_SECCOMP is not set
+# CONFIG_STACKPROTECTOR is not set
+# CONFIG_STRICT_KERNEL_RWX is not set
+# CONFIG_BLOCK is not set
+# CONFIG_BINFMT_SCRIPT is not set
+# CONFIG_COREDUMP is not set
+CONFIG_SLUB_TINY=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_COMPACTION is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SECRETMEM is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_LEGACY_TIOCSTI is not set
+# CONFIG_LDISC_AUTOLOAD is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_DEVMEM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_FS is not set
+# CONFIG_SYSFS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_INIT_STACK_NONE=y
+# CONFIG_SYMBOLIC_ERRNAME is not set
+# CONFIG_DEBUG_MISC is not set
+# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
+CONFIG_PANIC_TIMEOUT=1
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
diff --git a/arch/riscv/configs/tinylab_defconfig b/arch/riscv/configs/tinylab_defconfig
new file mode 100644
index 000000000000..6294c4590edd
--- /dev/null
+++ b/arch/riscv/configs/tinylab_defconfig
@@ -0,0 +1,89 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_RD_ZSTD is not set
+# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_MULTIUSER is not set
+# CONFIG_SYSFS_SYSCALL is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_POSIX_TIMERS is not set
+# CONFIG_BUG is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
+# CONFIG_IO_URING is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+# CONFIG_MEMBARRIER is not set
+# CONFIG_KALLSYMS is not set
+# CONFIG_RSEQ is not set
+CONFIG_EMBEDDED=y
+CONFIG_NONPORTABLE=y
+# CONFIG_RISCV_ISA_C is not set
+# CONFIG_RISCV_ISA_SVNAPOT is not set
+# CONFIG_RISCV_ISA_SVPBMT is not set
+# CONFIG_RISCV_ISA_ZICBOM is not set
+# CONFIG_RISCV_ISA_ZICBOZ is not set
+# CONFIG_FPU is not set
+# CONFIG_COMPAT is not set
+# CONFIG_EFI is not set
+# CONFIG_SECCOMP is not set
+# CONFIG_STACKPROTECTOR is not set
+# CONFIG_STRICT_KERNEL_RWX is not set
+# CONFIG_BLOCK is not set
+# CONFIG_BINFMT_SCRIPT is not set
+# CONFIG_COREDUMP is not set
+CONFIG_SLUB_TINY=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_COMPACTION is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SECRETMEM is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_LEGACY_TIOCSTI is not set
+# CONFIG_LDISC_AUTOLOAD is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_DEVMEM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_FS is not set
+# CONFIG_SYSFS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_INIT_STACK_NONE=y
+# CONFIG_SYMBOLIC_ERRNAME is not set
+# CONFIG_DEBUG_MISC is not set
+# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
+CONFIG_PANIC_TIMEOUT=1
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
-- 
2.36.1

