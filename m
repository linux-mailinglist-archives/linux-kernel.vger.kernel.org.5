Return-Path: <linux-kernel+bounces-60777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94DB85094C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B47EB22F68
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B315B5B6;
	Sun, 11 Feb 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1u8ieZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35255A798;
	Sun, 11 Feb 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655693; cv=none; b=lQXJ41s9tgC4s/vbNXe96wqk0syXrjZQQmMZnHuKjkKvrAZhD7wQTN6OwkaeikXbGkbNuONZW9hGcbmGinC0Gr52y3L5CwlQKZdhr7Fb71OrmustQCkwNSC+WAyO/BGq86g8w67hlq/8gcF+JVec20AnGjA5Rhdn8SAtRZZt2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655693; c=relaxed/simple;
	bh=u6Mr5fGJF0iXCgWKx7kfEEggUpwMa4m5ClOplGj1NMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pMHztJgBS0m3+Z87wk2f1pYBEnvB5mowUKTL50WKph4UDqurc6Dman7KNiyobhKhoI3Xsaz7ayCVwNQaEnRqiNy1VNDkibeDfhoAxtT1GEMU4YqI0z/3hWzWBYbY3I2JJZIM6qq588m7BEVKBiDg1x6yKLPT/IaBfp1YQ6X0KKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1u8ieZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD01C433A6;
	Sun, 11 Feb 2024 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707655692;
	bh=u6Mr5fGJF0iXCgWKx7kfEEggUpwMa4m5ClOplGj1NMk=;
	h=From:To:Cc:Subject:Date:From;
	b=R1u8ieZCv1rESQTEOGiw9GmxmnNG/xBLov1SuwjF1ZMCvxTAw7EUjYwa5wUHCjbnj
	 CztntfcqgwqX2DmglXLqu71BNq7dqIV5hdo3IepjjfffKPKEfUHyHJq1HTMc8T+/4E
	 +TRgFvo7inEbHB9gXNdKSjSwu7OLSjAQkLOLi/cIJ9GuKo4cNhUcFqlchMdUHY+0aT
	 OKQquO2Dj809asvWXqeWRuXMNTAvq9CM28ANP78TWeWg+67VNv1S2KBHj2yexuwph6
	 eCElCM89gC18iT2zteir5nzG6bFI1ANJagQmx9j72h9ecJB0Bmc7G6Bl+iq4KkO78h
	 d1Slea1HhStqw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] treewide: replace or remove redundant def_bool in Kconfig files
Date: Sun, 11 Feb 2024 21:48:08 +0900
Message-Id: <20240211124808.30313-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'def_bool X' is a shorthand for 'bool' plus 'default X'.

The type definition is redundant where 'bool' is already present, so
'def_bool X' can be replaced with 'default X', or removed if X is 'n'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/Kconfig                   | 4 ++--
 arch/riscv/kernel/tests/Kconfig.debug | 2 +-
 arch/x86/kvm/Kconfig                  | 2 +-
 arch/x86/xen/Kconfig                  | 1 -
 drivers/acpi/Kconfig                  | 1 -
 drivers/iommu/intel/Kconfig           | 2 +-
 drivers/md/Kconfig                    | 1 -
 init/Kconfig                          | 2 +-
 lib/Kconfig.debug                     | 2 +-
 mm/Kconfig                            | 7 +++----
 net/dccp/ccids/Kconfig                | 2 +-
 11 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 5c845e8d59d9..03ce7e185935 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -237,9 +237,9 @@ config PARISC_HUGE_KERNEL
 	def_bool y if !MODULES || UBSAN || FTRACE || COMPILE_TEST
 
 config MLONGCALLS
-	def_bool y if PARISC_HUGE_KERNEL
 	bool "Enable the -mlong-calls compiler option for big kernels" if !PARISC_HUGE_KERNEL
 	depends on PA8X00
+	default PARISC_HUGE_KERNEL
 	help
 	  If you configure the kernel to include many drivers built-in instead
 	  as modules, the kernel executable may become too big, so that the
@@ -254,9 +254,9 @@ config MLONGCALLS
 	  Enabling this option will probably slow down your kernel.
 
 config 64BIT
-	def_bool y if "$(ARCH)" = "parisc64"
 	bool "64-bit kernel" if "$(ARCH)" = "parisc"
 	depends on PA8X00
+	default "$(ARCH)" = "parisc64"
 	help
 	  Enable this if you want to support 64bit kernel on PA-RISC platform.
 
diff --git a/arch/riscv/kernel/tests/Kconfig.debug b/arch/riscv/kernel/tests/Kconfig.debug
index 5dba64e8e977..78cea5d2c270 100644
--- a/arch/riscv/kernel/tests/Kconfig.debug
+++ b/arch/riscv/kernel/tests/Kconfig.debug
@@ -6,7 +6,7 @@ config AS_HAS_ULEB128
 
 menuconfig RUNTIME_KERNEL_TESTING_MENU
        bool "arch/riscv/kernel runtime Testing"
-       def_bool y
+       default y
        help
          Enable riscv kernel runtime testing.
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 87e3da7b0439..d72be552c86d 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -119,8 +119,8 @@ config KVM_AMD
 	  will be called kvm-amd.
 
 config KVM_AMD_SEV
-	def_bool y
 	bool "AMD Secure Encrypted Virtualization (SEV) support"
+	default y
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	help
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index a65fc2ae15b4..77e788e928cd 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -81,7 +81,6 @@ config XEN_PVH
 	bool "Xen PVH guest support"
 	depends on XEN && XEN_PVHVM && ACPI
 	select PVH
-	def_bool n
 	help
 	  Support for running as a Xen PVH guest.
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3c3f8037ebed..8ce591679d50 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -474,7 +474,6 @@ config ACPI_BGRT
 
 config ACPI_REDUCED_HARDWARE_ONLY
 	bool "Hardware-reduced ACPI support only" if EXPERT
-	def_bool n
 	help
 	  This config item changes the way the ACPI code is built.  When this
 	  option is selected, the kernel will use a specialized version of
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 012cd2541a68..95d9f4e1a176 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -97,8 +97,8 @@ config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	  the default value.
 
 config INTEL_IOMMU_PERF_EVENTS
-	def_bool y
 	bool "Intel IOMMU performance events"
+	default y
 	depends on INTEL_IOMMU && PERF_EVENTS
 	help
 	  Selecting this option will enable the performance monitoring
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index a743e2c572fc..0392154bbcab 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -519,7 +519,6 @@ config DM_VERITY
 	  If unsure, say N.
 
 config DM_VERITY_VERIFY_ROOTHASH_SIG
-	def_bool n
 	bool "Verity data device root hash signature verification support"
 	depends on DM_VERITY
 	select SYSTEM_DATA_VERIFICATION
diff --git a/init/Kconfig b/init/Kconfig
index 55b7dd252fa8..4697b2f7e6a6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1490,7 +1490,7 @@ config MULTIUSER
 
 config SGETMASK_SYSCALL
 	bool "sgetmask/ssetmask syscalls support" if EXPERT
-	def_bool PARISC || M68K || PPC || MIPS || X86 || SPARC || MICROBLAZE || SUPERH
+	default PARISC || M68K || PPC || MIPS || X86 || SPARC || MICROBLAZE || SUPERH
 	help
 	  sys_sgetmask and sys_ssetmask are obsolete system calls
 	  no longer supported in libc but still enabled by default in some
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..e9b3b9543661 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2127,7 +2127,7 @@ config KCOV_IRQ_AREA_SIZE
 
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
-	def_bool y
+	default y
 
 if RUNTIME_TESTING_MENU
 
diff --git a/mm/Kconfig b/mm/Kconfig
index ffc3a2ba3a8c..4914eb3216fc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -599,7 +599,7 @@ config MEMORY_BALLOON
 # support for memory balloon compaction
 config BALLOON_COMPACTION
 	bool "Allow for balloon memory compaction/migration"
-	def_bool y
+	default y
 	depends on COMPACTION && MEMORY_BALLOON
 	help
 	  Memory fragmentation introduced by ballooning might reduce
@@ -614,7 +614,7 @@ config BALLOON_COMPACTION
 # support for memory compaction
 config COMPACTION
 	bool "Allow for memory compaction"
-	def_bool y
+	default y
 	select MIGRATION
 	depends on MMU
 	help
@@ -637,7 +637,6 @@ config COMPACT_UNEVICTABLE_DEFAULT
 # support for free page reporting
 config PAGE_REPORTING
 	bool "Free page reporting"
-	def_bool n
 	help
 	  Free page reporting allows for the incremental acquisition of
 	  free pages from the buddy allocator for the purpose of reporting
@@ -649,7 +648,7 @@ config PAGE_REPORTING
 #
 config MIGRATION
 	bool "Page migration"
-	def_bool y
+	default y
 	depends on (NUMA || ARCH_ENABLE_MEMORY_HOTREMOVE || COMPACTION || CMA) && MMU
 	help
 	  Allows the migration of the physical location of pages of processes
diff --git a/net/dccp/ccids/Kconfig b/net/dccp/ccids/Kconfig
index a3eeb84d16f9..e3d388c33d25 100644
--- a/net/dccp/ccids/Kconfig
+++ b/net/dccp/ccids/Kconfig
@@ -13,7 +13,7 @@ config IP_DCCP_CCID2_DEBUG
 
 config IP_DCCP_CCID3
 	bool "CCID-3 (TCP-Friendly)"
-	def_bool y if (IP_DCCP = y || IP_DCCP = m)
+	default IP_DCCP = y || IP_DCCP = m
 	help
 	  CCID-3 denotes TCP-Friendly Rate Control (TFRC), an equation-based
 	  rate-controlled congestion control mechanism.  TFRC is designed to
-- 
2.40.1


