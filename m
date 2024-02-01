Return-Path: <linux-kernel+bounces-47663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D68450E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DE71C20934
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231679DAB;
	Thu,  1 Feb 2024 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FhC1Prbb"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DA612F1;
	Thu,  1 Feb 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766425; cv=none; b=VKHEDJ9x9GHLXXvKa96ECpKU+O05S7QBy7AS5ET+Z5nRq6Pc0zkNBtUwPrCgr1niJKXzEMxD+E6Uafx/jQhMxqjNCXp/2sCrqTNJBPiRPD7nVhdLp2PFEJmHT2qjACw0PtiDcD8GD4BwVWqQJSxgc/DryQTgFmUqpkXZvJuCHeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766425; c=relaxed/simple;
	bh=1ieNoHVYGzHm0IWMO9EIkmxRFHvwzhAR6RzHs/ay6NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gW6WrqTeoRYDKdFwz3G1vhz3S1BzxbwwniHYzipMU3S/t/CX2aUsHr3rhO2tfS0TmVKjum8JBuUSEQUAVB0T2EbQN98ANIIgq2SlDzTOo4TnoxLxPCaEZ+E72i+OIT93rgLE48Z01uWI2dRvgPVlahmlRToKiy69uFj2kjDdxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FhC1Prbb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4115kU5H3816769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 31 Jan 2024 21:46:35 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4115kU5H3816769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706766395;
	bh=6jCJ2dDytWCqiXwBq1kK/4328oG6ngH5txsdvpUd5kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhC1Prbb5haW2rsOutM1JEjwHmBL1X5jpvgszRtMZezgSL1l0Zkkh0jtNTJlryrZf
	 tPZUkhhA/cT3rjP84UOM6jMTgj7t5DYVtAqdW5LhPLbPwr78cAnxKUrGUzTEolcoHR
	 oPBlnC3oxICwhHppneu4ifcoNVlEHBY/hONVeQgW0HOUWWmtlQVInikibs4vzfqp4V
	 Mzp4nz3Pm9RLuTf/bMSBx4FTbfUWitDtPP1vChosQgLCYIP9ZytLRGWGOniwjgaoB0
	 jSGP9GfytAGYIGQL4j4S8C/UmqDGt/qtJCoQJ/Btnjy/WI2UUTu2SjaTFb3rFh5pEO
	 F1kCGSF09Lotw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
Subject: [PATCH v1 1/3] x86/cpufeatures: Add {required,disabled} feature configs
Date: Wed, 31 Jan 2024 21:46:27 -0800
Message-ID: <20240201054629.3816748-2-xin@zytor.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201054629.3816748-1-xin@zytor.com>
References: <20240201054629.3816748-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

To prepare for auto-generating a header with required and disabled
feature masks based on build config, add feature Kconfig items:
  - X86_REQUIRED_FEATURE_x
  - X86_DISABLED_FEATURE_x
which are set to "y" if their preconditions are met.

X86_CMPXCHG64 and X86_CMOV are required features, thus renamed to
X86_REQUIRED_FEATURE_CX8 and X86_REQUIRED_FEATURE_CMOV.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/Kconfig                              |   4 +-
 arch/x86/Kconfig.cpu                          |  16 +-
 arch/x86/Kconfig.cpufeatures                  | 149 ++++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h         |   2 +-
 arch/x86/include/asm/atomic64_32.h            |   2 +-
 arch/x86/include/asm/bitops.h                 |   4 +-
 arch/x86/include/asm/cmpxchg_32.h             |   4 +-
 arch/x86/include/asm/required-features.h      |   4 +-
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 lib/atomic64_test.c                           |   2 +-
 .../arch/x86/include/asm/required-features.h  |   4 +-
 12 files changed, 178 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e78071049121..8bf28685d582 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -120,7 +120,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
-	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_REQUIRED_FEATURE_CX8
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
@@ -3066,4 +3066,6 @@ config HAVE_ATOMIC_IOMAP
 
 source "arch/x86/kvm/Kconfig"
 
+source "arch/x86/Kconfig.cpufeatures"
+
 source "arch/x86/Kconfig.assembler"
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index b9224cf2ee4d..68f97eabece6 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -358,6 +358,10 @@ config X86_P6_NOP
 	depends on X86_64
 	depends on (MCORE2 || MPENTIUM4 || MPSC)
 
+config X86_REQUIRED_FEATURE_NOPL
+	def_bool y
+	depends on X86_64 || X86_P6_NOP
+
 config X86_TSC
 	def_bool y
 	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
@@ -366,21 +370,27 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
 
-config X86_CMPXCHG64
+config X86_REQUIRED_FEATURE_CX8
 	def_bool y
 	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
-config X86_CMOV
+config X86_REQUIRED_FEATURE_CMOV
 	def_bool y
 	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
 
+# this should be set for all -march= options where the compiler
+# generates movbe.
+config X86_REQUIRED_FEATURE_MOVBE
+	def_bool y
+	depends on MATOM
+
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
 	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
-	default "5" if X86_32 && X86_CMPXCHG64
+	default "5" if X86_32 && X86_REQUIRED_FEATURE_CX8
 	default "4"
 
 config X86_DEBUGCTLMSR
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
new file mode 100644
index 000000000000..7ae978c904e6
--- /dev/null
+++ b/arch/x86/Kconfig.cpufeatures
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
+# either REQUIRED to be enabled, or DISABLED (always ignored) for this
+# particular compile-time configuration.  The tests for these features
+# are turned into compile-time constants via the generated
+# <asm/featuremasks.h>.
+#
+# The naming of these variables *must* match asm/cpufeatures.h.
+#
+
+config X86_REQUIRED_FEATURE_ALWAYS
+	def_bool y
+
+config X86_REQUIRED_FEATURE_CPUID
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_UP
+	def_bool y
+	depends on !SMP
+
+config X86_REQUIRED_FEATURE_FPU
+	def_bool y
+	depends on !MATH_EMULATION
+
+config X86_REQUIRED_FEATURE_PAE
+	def_bool y
+	depends on X86_64 || X86_PAE
+
+config X86_REQUIRED_FEATURE_PSE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_PGE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_MSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_FXSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM2
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_LM
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_UMIP
+	def_bool y
+	depends on !X86_UMIP
+
+config X86_DISABLED_FEATURE_VME
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_K6_MTRR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CYRIX_ARR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CENTAUR_MCR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_PCID
+	def_bool y
+	depends on !X86_64
+
+config X86_DISABLED_FEATURE_PKU
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_OSPKE
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_LA57
+	def_bool y
+	depends on !X86_5LEVEL
+
+config X86_DISABLED_FEATURE_PTI
+	def_bool y
+	depends on !MITIGATION_PAGE_TABLE_ISOLATION
+
+config X86_DISABLED_FEATURE_RETPOLINE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETPOLINE_LFENCE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETHUNK
+	def_bool y
+	depends on !MITIGATION_RETHUNK
+
+config X86_DISABLED_FEATURE_UNRET
+	def_bool y
+	depends on !MITIGATION_UNRET_ENTRY
+
+config X86_DISABLED_FEATURE_CALL_DEPTH
+	def_bool y
+	depends on !MITIGATION_CALL_DEPTH_TRACKING
+
+config X86_DISABLED_FEATURE_LAM
+	def_bool y
+	depends on !ADDRESS_MASKING
+
+config X86_DISABLED_FEATURE_ENQCMD
+	def_bool y
+	depends on !INTEL_IOMMU_SVM
+
+config X86_DISABLED_FEATURE_SGX
+	def_bool y
+	depends on !X86_SGX
+
+config X86_DISABLED_FEATURE_XENPV
+	def_bool y
+	depends on !XEN_PV
+
+config X86_DISABLED_FEATURE_TDX_GUEST
+	def_bool y
+	depends on !INTEL_TDX_GUEST
+
+config X86_DISABLED_FEATURE_USER_SHSTK
+	def_bool y
+	depends on !X86_USER_SHADOW_STACK
+
+config X86_DISABLED_FEATURE_IBT
+	def_bool y
+	depends on !X86_KERNEL_IBT
+
+config X86_DISABLED_FEATURE_FRED
+	def_bool y
+	depends on !X86_FRED
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 076bf8dee702..fb1fe8547b3a 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -15,7 +15,7 @@
 #include <asm/fred.h>
 #include <asm/gsseg.h>
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_REQUIRED_FEATURE_CX8
 extern void cmpxchg8b_emu(void);
 #endif
 
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 3486d91b8595..d58488dbbafe 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -22,7 +22,7 @@ typedef struct {
 	ATOMIC64_EXPORT(atomic64_##sym)
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %P[func]" \
 		     : out : [func] "i" (atomic64_##g##_cx8), ## in)
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 990eb686ca67..e3e69dca8edb 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -321,7 +321,7 @@ static __always_inline int variable_ffs(int x)
 	asm("bsfl %1,%0"
 	    : "=r" (r)
 	    : "rm" (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CMOV)
 	asm("bsfl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "r" (-1));
@@ -378,7 +378,7 @@ static __always_inline int fls(unsigned int x)
 	asm("bsrl %1,%0"
 	    : "=r" (r)
 	    : "rm" (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CMOV)
 	asm("bsrl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "rm" (-1));
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index b5731c51f0f4..61449e666e0e 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -7,7 +7,7 @@
  *       you need to test for the feature in boot_cpu_data.
  */
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 #define arch_cmpxchg64(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
 					 (unsigned long long)(n)))
@@ -63,7 +63,7 @@ static inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *pold, u64 new)
 	return success;
 }
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_REQUIRED_FEATURE_CX8
 /*
  * Building a kernel capable running on 80386 and 80486. It may be necessary
  * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 7ba1726b71c7..13018e507f76 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -23,13 +23,13 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0
 #endif
 
-#if defined(CONFIG_X86_CMOV) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_REQUIRED_FEATURE_CMOV) || defined(CONFIG_X86_64)
 # define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
 #else
 # define NEED_CMOV	0
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 72cc9c90e9f3..493259ed0cc9 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -62,7 +62,7 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += string_32.o
         lib-y += memmove_32.o
         lib-y += cmpxchg8b_emu.o
-ifneq ($(CONFIG_X86_CMPXCHG64),y)
+ifneq ($(CONFIG_X86_REQUIRED_FEATURE_CX8),y)
         lib-y += atomic64_386_32.o
 endif
 else
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 1c96be769adc..4bc06bd1aee1 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -7,7 +7,7 @@
 
 .text
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_REQUIRED_FEATURE_CX8
 
 /*
  * Emulate 'cmpxchg8b (%esi)' on UP
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..e68bde45b962 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -254,7 +254,7 @@ static __init int test_atomics_init(void)
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
 #ifdef CONFIG_X86_64
 		"x86-64",
-#elif defined(CONFIG_X86_CMPXCHG64)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CX8)
 		"i586+",
 #else
 		"i386+",
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index 7ba1726b71c7..13018e507f76 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -23,13 +23,13 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0
 #endif
 
-#if defined(CONFIG_X86_CMOV) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_REQUIRED_FEATURE_CMOV) || defined(CONFIG_X86_64)
 # define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
 #else
 # define NEED_CMOV	0
-- 
2.43.0


