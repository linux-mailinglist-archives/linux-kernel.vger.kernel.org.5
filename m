Return-Path: <linux-kernel+bounces-129196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D588966D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED051F28B8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FD75B1E2;
	Wed,  3 Apr 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVP5zgQt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYO5ymlc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29855C61A;
	Wed,  3 Apr 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130031; cv=none; b=BW/JsMjhLQbgzYwuZwDEscFA65NWOROxwZ7zNIuadZhIaoHuU09b82fMLYEgzvk9wDBusqSvZq4hcYtNx+jTyKDGQF06ssGXOPuyFcz1O329Re0uat1vN8NVqgRK1K8Kdl8EDA9fSQjsX3GPjbif/MOQKDMfkknLihgb/CuN9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130031; c=relaxed/simple;
	bh=s4XNOm3zwwHdgssGUB4Kpn3Q3dzhNVzh3W2Mc9wqG90=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j2uBDchsU7HZIR8/bNsHXGfc6iwEYCnB2SpG/aHJjtpx5gcPu5ZDLnoK2r3OvY1M9Mqkk99Utfb0KfGggm03f9M8N+ravydaDr7i3BB+dRNAoDztNuzIT3QwmC0mBP8Yv7HIqLmv0QCetK1rOY5rn3LQI9aReXoQm2cRCrpWxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EVP5zgQt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYO5ymlc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:40:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712130028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGMn/Seh4flrGYbzstDZ+VvPnLE7wrsngm8xG9aYo38=;
	b=EVP5zgQtlYPIstIsJojLzgRmZhYsssjdCJZEs9cfyVQCU5IdG7KlqourrxfZOcapVKd4Hl
	KXIy8TSSoHj6HG2qnoxdSUDdOm2bHL9o7StfYLFoDyTBPHfC1MgMzUMsV+0R9tYw64O/9w
	hzhwa95ylZvF2sKHsnoU513HURO1+AntJE3OvoPKENTKT8hhOjeICg4v0oBX9E6M842PBs
	K1ae90HqJvkWRj/hFaolcpgCPPIRwUVZpFyk0FU1cBmeKGYEm4y7Jr+AxBHBw1oXeGsQyG
	jg09fF+kDnDxEdKD8y2oHK6nj96gI01+ESLSDofclWesX1+wXBeiz1uvCl02cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712130028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGMn/Seh4flrGYbzstDZ+VvPnLE7wrsngm8xG9aYo38=;
	b=WYO5ymlcTN2B98QU1jcCFsTpkxzPWoECQABlFp8JrvU44GYczttJuosGVH9jPePgCcYoni
	rFGbAuUQtTuGYOCw==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/amd: Avoid taking branches before disabling LBR
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240402022118.1046049-3-andrii@kernel.org>
References: <20240402022118.1046049-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213002758.10875.5606424809206243156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1eddf187e5d087de4560ec7c3baa2f8283920710
Gitweb:        https://git.kernel.org/tip/1eddf187e5d087de4560ec7c3baa2f8283920710
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Mon, 01 Apr 2024 19:21:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 09:14:26 +02:00

perf/x86/amd: Avoid taking branches before disabling LBR

In the following patches we will enable LBR capture on AMD CPUs at
arbitrary point in time, which means that LBR recording won't be frozen
by hardware automatically as part of hardware overflow event. So we need
to take care to minimize amount of branches and function calls/returns
on the path to freezing LBR, minimizing LBR snapshot altering as much as
possible.

As such, split out LBR disabling logic from the sanity checking logic
inside amd_pmu_lbr_disable_all(). This will ensure that no branches are
taken before LBR is frozen in the functionality added in the next patch.
Use __always_inline to also eliminate any possible function calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-3-andrii@kernel.org
---
 arch/x86/events/amd/lbr.c    |  9 +--------
 arch/x86/events/perf_event.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 5149830..33d0a45 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -414,18 +414,11 @@ void amd_pmu_lbr_enable_all(void)
 void amd_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-
-	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
-		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
-	}
+	__amd_pmu_lbr_disable();
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fb56518..72b022a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1329,6 +1329,19 @@ void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
 
+static __always_inline void __amd_pmu_lbr_disable(void)
+{
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
+}
+
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
 #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */

