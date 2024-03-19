Return-Path: <linux-kernel+bounces-107393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5F87FBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B361C221F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111A5810A;
	Tue, 19 Mar 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLd4pYVH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eh/oiLDO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50D1E498;
	Tue, 19 Mar 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844570; cv=none; b=Smz+wM/DZLfEXNa4NDWRvif2sr3GGxT9OWhXD5DMShkshqYTgpiu2dHP2gxERsCdNkOq/2Z812cKRi7cHcli+8dpHuid4iEiVFqK8Bo0Gjq6yivn/81w6OtMC8aahqfX1DtdaW1kxyxoAjYJUhpW89xits9PTkup9lLvVdRKBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844570; c=relaxed/simple;
	bh=SF9hZk9D5JEpWhWb1dgPuO1xdui8PrBB0ei1mPf/Rlw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iGNTCvfqrf8aiPAdJRRoAT8xasK6SJVbuNbywhBVfkyqLw+eDeAKQ2PFmUTdUBIdXLYcRedd67cFzJUOIOv6psl5xDGf9yTalWjQkSXcY+wdyrM61pfGt3SAjsKoKaGOayWOXtiQPZ+HdgC0+PQtdNa+g8VqELV1QPRRr6YLUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLd4pYVH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eh/oiLDO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 10:36:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710844561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0E2/dEPk5lG6k9uskg8drcEFP8QyIym24r1RxN7YCFM=;
	b=yLd4pYVHbEVjY0NroDXFoMQDXMBcWG5HSRQn/gG6rneShva3e8V0E8k+lD4GZSn2+FFQWE
	y/P0WqNh0PKVAL6VM9JrF1p/0iUZ3LEQfeHuL+FuLHcH/qNl9qjTT70R5wzwfaHTbLCgQe
	rSEu4vA3TH41JQWa/tfDhTER8mT2EHOjGdqjpRpRpjRR7I+gpQBAm/4BOmx68n68FK6bHR
	ZdUs2jE3E+JakPs2/1JlSNxZhF1BtkqVVMW7JTKk2F8eVWNKRPX6UMPyNew3GldVpbzBVZ
	toJVTgf1gkn4prceP6GroCYvoOleqp034xhXd4240ZWpUWa0QaNApfij5ubTqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710844561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0E2/dEPk5lG6k9uskg8drcEFP8QyIym24r1RxN7YCFM=;
	b=eh/oiLDO/oa41y5SSlnCCnQrQqV5089Qi/EtLBLoqzfOUCa6tqdqmrpuwQ2w3SFgw6Ahhm
	I+kIZD0GiJOCnEBA==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/cpufeatures: Add dedicated feature word for
 CPUID leaf 0x80000022[EAX]
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C846eebace0aea3a600b81b06bddd0024e5ac1350=2E17108?=
 =?utf-8?q?36172=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C846eebace0aea3a600b81b06bddd0024e5ac1350=2E171083?=
 =?utf-8?q?6172=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171084456107.10875.4104379273551108641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f0a22ea644717fa21698a32d342fcd307e53a935
Gitweb:        https://git.kernel.org/tip/f0a22ea644717fa21698a32d342fcd307e53a935
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Tue, 19 Mar 2024 13:48:16 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Mar 2024 11:23:47 +01:00

x86/cpufeatures: Add dedicated feature word for CPUID leaf 0x80000022[EAX]

Move the existing scattered performance monitoring related feature bits
from CPUID leaf 0x80000022[EAX] into a dedicated word since additional
bits will be defined from the same leaf in the future. This includes
X86_FEATURE_PERFMON_V2 and X86_FEATURE_AMD_LBR_V2.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/846eebace0aea3a600b81b06bddd0024e5ac1350.1710836172.git.sandipan.das@amd.com
---
 arch/x86/include/asm/cpufeature.h        |  7 +++++--
 arch/x86/include/asm/cpufeatures.h       | 10 +++++++---
 arch/x86/include/asm/disabled-features.h |  3 ++-
 arch/x86/include/asm/required-features.h |  3 ++-
 arch/x86/kernel/cpu/common.c             |  3 +++
 arch/x86/kernel/cpu/scattered.c          |  2 --
 arch/x86/kvm/cpuid.c                     |  5 +----
 arch/x86/kvm/reverse_cpuid.h             |  1 -
 8 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a127369..68dd27d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -33,6 +33,7 @@ enum cpuid_leafs
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
+	CPUID_8000_0022_EAX,
 };
 
 #define X86_CAP_FMT_NUM "%d:%d"
@@ -91,8 +92,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -116,8 +118,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f0337f7..028f333 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NCAPINTS			22	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -94,7 +94,7 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
+/* FREE!				( 3*32+17) */
 #define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers using VERW */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
@@ -209,7 +209,7 @@
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
-#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring Version 2 */
+/* FREE!				( 7*32+20) */
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
@@ -459,6 +459,10 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/* AMD-defined performance monitoring features, CPUID level 0x80000022 (EAX), word 21 */
+#define X86_FEATURE_PERFMON_V2		(21*32+ 0) /* AMD Performance Monitoring Version 2 */
+#define X86_FEATURE_AMD_LBR_V2		(21*32+ 1) /* AMD Last Branch Record Extension Version 2 */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index da4054f..c492bdc 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -155,6 +155,7 @@
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	(DISABLE_SEV_SNP)
 #define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define DISABLED_MASK21	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 7ba1726..e9187dd 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -99,6 +99,7 @@
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define REQUIRED_MASK21	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba8cf5e..771e32a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1039,6 +1039,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	if (c->extended_cpuid_level >= 0x80000021)
 		c->x86_capability[CPUID_8000_0021_EAX] = cpuid_eax(0x80000021);
 
+	if (c->extended_cpuid_level >= 0x80000022)
+		c->x86_capability[CPUID_8000_0022_EAX] = cpuid_eax(0x80000022);
+
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a..b5b1ce0 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -47,8 +47,6 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
-	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
-	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adba49a..f9bcbb0 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -773,10 +773,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
-
-	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0022_EAX,
-		F(PERFMON_V2)
-	);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_PERFMON_V2);
 
 	/*
 	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index aadefca..c69d05c 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -15,7 +15,6 @@ enum kvm_only_cpuid_leafs {
 	CPUID_12_EAX	 = NCAPINTS,
 	CPUID_7_1_EDX,
 	CPUID_8000_0007_EDX,
-	CPUID_8000_0022_EAX,
 	CPUID_7_2_EDX,
 	NR_KVM_CPU_CAPS,
 

