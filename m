Return-Path: <linux-kernel+bounces-35569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24900839364
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61161F21B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005560875;
	Tue, 23 Jan 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZt+NvkO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/r8C8Z68"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093645FBA6;
	Tue, 23 Jan 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024211; cv=none; b=mnaPvsVloR1JWL6rWhcOt4H1dUGhh+Y2wQt3qeDOQsKBnAmLY07Rai5QdgkHKwQR4OfKhx9zG0olffyqtGLLX3jZx1PW5Bvl4a88ckCKVHTDqN0uB/TWoV5MbQt+r1I7lN3gALXsTRzZqlre9p+q3byA6/ujadzhueRO5dBAhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024211; c=relaxed/simple;
	bh=VFgK83r6eoNutpLWcAkVqsC2L9t4AKlcxFeiUozXTXA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LeQ7inUnVtoPaq07rEcFi+LOp1lVzTKLUQRechBcxZvD16Mn9kQAZDMjb6yhLaHITy2dBX4crzp2rofSqB2QbINku5pPTlgDeTjL0GINE3Th5hW54aG7JzDC3IwMQlOe82DwVmjOuXjbIcGE179NMniOsQ/6p606XlRyKG9NTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AZt+NvkO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/r8C8Z68; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Jan 2024 15:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706024206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d86NwgS8OBa5LM5tX4uFn5K56SW++QkcJmeXelRoGKc=;
	b=AZt+NvkOYBYYcA6ZnWsgkFwwX2xYhfV6YX/jLXKP0FTo4Cw/r/8OyN0lz0jasSZfFF44mk
	pwOcXl/bdbS1aoF/uJI1rEYD3kFc0BkW/F2kYYEl5wrIsHxXV+IR0tTpEV8Z7UScFpcQRe
	NvN7zwXSo5PTIzeM+p+k5Re5IzUL11QJdMAsq8dT2Mjw6pm5xDE+CHAE6uGSrlMZsouRmo
	L5LOXmn7/StUx3Wye6lpeSfiW6BmbsJn7eGmPRIbcYsUFQ+WjfRrP/0RP7xtsjvX7GqsYg
	1Eef5yuqf2nXVrLX5SqwnzmLpLO9GR1pK5wJhdnzV0ph4RNwA/RXV7C+PULA5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706024206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d86NwgS8OBa5LM5tX4uFn5K56SW++QkcJmeXelRoGKc=;
	b=/r8C8Z68n59lEt1lpcFxzTGROHwHi5NGhnNzBwgEIARm1ncikkxHu8hhvzIU46s6mZdYE5
	TrZZTbfmlpdXj0Ag==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Remove hard-coded memory bandwidth limit
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com>
References:
 <c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170602420610.398.10595146977994857056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0976783bb123f30981bc1e7a14d9626a6f63aeac
Gitweb:        https://git.kernel.org/tip/0976783bb123f30981bc1e7a14d9626a6f63aeac
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 15 Jan 2024 16:52:27 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 23 Jan 2024 16:22:51 +01:00

x86/resctrl: Remove hard-coded memory bandwidth limit

The QOS Memory Bandwidth Enforcement Limit is reported by
CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02:

  Bits	 Description
  31:0	 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.

Newer processors can support higher bandwidth limit than the current
hard-coded value. Remove latter and detect using CPUID instead. Also,
update the register variables eax and edx to match the AMD CPUID
definition.

The CPUID details are documented in the Processor Programming Reference
(PPR) Vol 1.1 for AMD Family 19h Model 11h B1 - 55901 Rev 0.25 in the
Link tag below.

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Link: https://lore.kernel.org/r/c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 ++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d29ebe3..aa9810a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -231,9 +231,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	union cpuid_0x10_3_eax eax;
-	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx, subleaf;
+	u32 eax, ebx, ecx, edx, subleaf;
 
 	/*
 	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
@@ -241,9 +239,9 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	 */
 	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
 
-	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
-	hw_res->num_closid = edx.split.cos_max + 1;
-	r->default_ctrl = MAX_MBA_BW_AMD;
+	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
+	hw_res->num_closid = edx + 1;
+	r->default_ctrl = 1 << eax;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa1..d297974 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -18,7 +18,6 @@
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
-#define MAX_MBA_BW_AMD			0x800
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)

