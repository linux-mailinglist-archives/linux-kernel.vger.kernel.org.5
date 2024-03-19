Return-Path: <linux-kernel+bounces-107392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A887FBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9110B22229
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430374CE08;
	Tue, 19 Mar 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Obm4hSC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K7h52diY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54F2C857;
	Tue, 19 Mar 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844569; cv=none; b=qT6EcXBO1Cr2MP3QzPeOXZOmNi+s2aznYrFyN9FaAvVZyBDtIfIklCdpHos9CM9jsDYGJcJmJR+I4v3aGAqejd0WowNG3fk7v+OCqpInHFueImUfDE32cnrZ5A3vQIkQ2ToNlQv8cU3g/3BgXPfkaCB8PvUXYMA+jypfOavXDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844569; c=relaxed/simple;
	bh=yA/gi+UZtY2sgo6ssq3eVk6bUgMu0mV+KbP+SP8eYNA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i5uOzPEcO+G3vil0arBG2jKu3Kizd2tXeJEB+Mkz2qUA6kSs0KBUzpTEECdKEOnYqZ6Mpb2hcX7Wcupq7cgO2luH4zDNwRI0WU1Qf5bd6zrsSvUnWoQWptwx2zNcBF/D3704YkXdxMR0JYAxGBrGQNZbwEr76B79rlNmgnUlCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Obm4hSC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K7h52diY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 10:36:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710844561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWMVMNKD4olJfVRGg6IYC+5cH73CGtuqAe0whZy3grc=;
	b=4Obm4hSCIteawf9Q3z4pxw1MpLyD6wDyQthM3po3QOe+LOYS1FdZpaNrt6HKmbKzdolCEy
	0/tL76nE82bzqq6EQc8q4GTqpBW4JiTV2u9y/I7rK6ZT/sOQpewPAYkpfS6jy89ke1xLut
	2gtg+18Ifi86ELDzqylXBD1eQMQ/Z4q6eVcaUAzos9w7HOt7DrdbPkfzd8NPN0EbnPm38Q
	B0hvz8NZmNEEltyHUuHP0BzdQCRcc3UoENgTFp95QKaiEWTwrL05KkRsr/E6NqeFfjQLHW
	/cu3sVe9ShNsxzVo8i+aPxynI4ldZh1CpS9I8Wk/qkyBs3PugJmjLs52V/4JoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710844561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWMVMNKD4olJfVRGg6IYC+5cH73CGtuqAe0whZy3grc=;
	b=K7h52diYFU2EmlbZ0QnL6PxhknWyrBBcUUgQ5mgyz4qgl8RrG/dczn6Yb7dq1ETHMbLZCQ
	JRwYHw1xoVtzkNAg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/lbr: Use freeze based on availability
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8d47ce56f23dc1eba8f0876b2f32293c2c1c6912=2E17108?=
 =?utf-8?q?36172=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C8d47ce56f23dc1eba8f0876b2f32293c2c1c6912=2E171083?=
 =?utf-8?q?6172=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171084456028.10875.9283629966540169802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     40f192d760cd2e399e826a6e9b728ea91ed307b2
Gitweb:        https://git.kernel.org/tip/40f192d760cd2e399e826a6e9b728ea91ed307b2
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Tue, 19 Mar 2024 13:48:17 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Mar 2024 11:23:48 +01:00

perf/x86/amd/lbr: Use freeze based on availability

Currently, it is assumed that LBR Freeze is supported on all processors
when X86_FEATURE_AMD_LBR_V2 is available i.e. CPUID leaf 0x80000022[EAX]
bit 1 is set. This is incorrect as the availability of the feature is
additionally dependent on CPUID leaf 0x80000022[EAX] bit 2 being set.
This may not be the case for all Zen 4 processors. Define a new feature
bit for LBR and PMC freeze and set the freeze enable bit (FLBRI) in
DebugCtl (MSR 0x1d9) conditionally.

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
Link: https://lore.kernel.org/r/8d47ce56f23dc1eba8f0876b2f32293c2c1c6912.1710836172.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c         |  4 ++--
 arch/x86/events/amd/lbr.c          | 16 ++++++++++------
 arch/x86/include/asm/cpufeatures.h |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

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
index 028f333..e57d584 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -462,6 +462,7 @@
 /* AMD-defined performance monitoring features, CPUID level 0x80000022 (EAX), word 21 */
 #define X86_FEATURE_PERFMON_V2		(21*32+ 0) /* AMD Performance Monitoring Version 2 */
 #define X86_FEATURE_AMD_LBR_V2		(21*32+ 1) /* AMD Last Branch Record Extension Version 2 */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 2) /* AMD LBR and PMC Freeze */
 
 /*
  * BUG word(s)

