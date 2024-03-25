Return-Path: <linux-kernel+bounces-116837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D918D88A462
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547FE2E22E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22111B882D;
	Mon, 25 Mar 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KeDIKjiv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n+H1F5/l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02EC1369AE;
	Mon, 25 Mar 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362565; cv=none; b=dhGcGhbk6C675LMkaUaxCTddL/Sse4YCBtaMhm4/0ohOMNqDyL/OFrxK2UFxPTrukRb9AjY7eVBzavWFwTfwJ3hMSGyobcdIUUg3Duz2yFVPiXpwOtR/AvFdaAR5Esm4xFFJZKtGgEpjQPQ9i31Kf83WFiOPUVxs91bYJkA4eXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362565; c=relaxed/simple;
	bh=g2g+kGjEtIBZuotbcnr8C0kpZvKfMNjedEE5Miwg+wY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FOxjnwkmBgC5Ti4cFbUDpzSSzyFZaUrw43+T/sXbNidpkaclcD1TWb/QQ3S7B9qkSEn/IfKYBbfi6mEIjmwPPNCYyZj3hU3OpSNjVJaRUIFfVChYiCjUqMROtP5T6AFNWy8aiGS0B+mS93ft3tfBOqhyBfRdlMq8New7wuvDgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KeDIKjiv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n+H1F5/l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 10:29:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711362562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQR+ANvwAki3owoddODTgNqKRNA7nCOsWGtZc/nEndI=;
	b=KeDIKjiv+n/TZXbSx7kR3zBKMm9waA7cv+cRtbQlAKjTzzTKHEC623zvKsbJ+s/hFU6BoA
	CJGM6EMJUZiOf0c4H4GKkZnQ/P670aM+AnYsoFfvxrMUpvUO5cRLZQKC6umh+JwDN8Szhj
	0QK4oXRX10pJyZGPviF6tVj02Oj3Kj01S6g8csI6LVoZJSjnkML7yQCHuv1FWLOYYrPk1Z
	d+dvGeBtPc16ufB10oNBVPdMCjpBOsp0/UOU6hxZlKLoWiRrt/OVYI7FT7n6dQSxK6kHEZ
	+TsEDRLJ/LtOr77WQEGZkHT7aj6xq8JqR8KesqdoRrTPb7i3JHYWK+/7RA8bdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711362562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQR+ANvwAki3owoddODTgNqKRNA7nCOsWGtZc/nEndI=;
	b=n+H1F5/lDxX9OY4x9M9/zO5AGpA3lWEw/mTHn9+yAkWSpFqJbx42mTNVz8l6u36qse7Bu2
	nZiZLBgIzQkFrmAA==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/lbr: Use freeze based on availability
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C69a453c97cfd11c6f2584b19f937fe6df741510f=2E17110?=
 =?utf-8?q?91584=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C69a453c97cfd11c6f2584b19f937fe6df741510f=2E171109?=
 =?utf-8?q?1584=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136256136.10875.3859253801060340333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     598c2fafc06fe5c56a1a415fb7b544b31453d637
Gitweb:        https://git.kernel.org/tip/598c2fafc06fe5c56a1a415fb7b544b31453d637
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 25 Mar 2024 13:01:45 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 11:16:55 +01:00

perf/x86/amd/lbr: Use freeze based on availability

Currently, the LBR code assumes that LBR Freeze is supported on all processors
when X86_FEATURE_AMD_LBR_V2 is available i.e. CPUID leaf 0x80000022[EAX]
bit 1 is set. This is incorrect as the availability of the feature is
additionally dependent on CPUID leaf 0x80000022[EAX] bit 2 being set,
which may not be set for all Zen 4 processors.

Define a new feature bit for LBR and PMC freeze and set the freeze enable bit
(FLBRI) in DebugCtl (MSR 0x1d9) conditionally.

It should still be possible to use LBR without freeze for profile-guided
optimization of user programs by using an user-only branch filter during
profiling. When the user-only filter is enabled, branches are no longer
recorded after the transition to CPL 0 upon PMI arrival. When branch
entries are read in the PMI handler, the branch stack does not change.

E.g.

  $ perf record -j any,u -e ex_ret_brn_tkn ./workload

Since the feature bit is visible under flags in /proc/cpuinfo, it can be
used to determine the feasibility of use-cases which require LBR Freeze
to be supported by the hardware such as profile-guided optimization of
kernels.

Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/69a453c97cfd11c6f2584b19f937fe6df741510f.1711091584.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c         |  4 ++--
 arch/x86/events/amd/lbr.c          | 16 ++++++++++------
 arch/x86/include/asm/cpufeatures.h |  8 ++++++++
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index aec16e5..5692e82 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -904,8 +904,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	if (!status)
 		goto done;
 
-	/* Read branch records before unfreezing */
-	if (status & GLOBAL_STATUS_LBRS_FROZEN) {
+	/* Read branch records */
+	if (x86_pmu.lbr_nr) {
 		amd_pmu_lbr_read();
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 4a1e600..5149830 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -402,10 +402,12 @@ void amd_pmu_lbr_enable_all(void)
 		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
 	}
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
 }
 
@@ -418,10 +420,12 @@ void amd_pmu_lbr_disable_all(void)
 		return;
 
 	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4d850a7..a38f8f9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -460,6 +460,14 @@
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
 /*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0x80000022, etc.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
+
+/*
  * BUG word(s)
  */
 #define X86_BUG(x)			(NCAPINTS*32 + (x))
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a..a515328 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 

