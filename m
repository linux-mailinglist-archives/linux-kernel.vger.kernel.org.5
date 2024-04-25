Return-Path: <linux-kernel+bounces-158950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AA8B2743
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D81C24148
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BDA14EC48;
	Thu, 25 Apr 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNIIvOm+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0aRqtY4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508E14D70C;
	Thu, 25 Apr 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065042; cv=none; b=hWCUNkK4UWq+5tCbn3BEYK+QEegCaDQy9RKujapOpXonGHrvOzuZQXzTXt/Wbn5yK0fEzUvKLAGm5Fo4Ie/NTgU1+yFk3S1KuIgs6Xd1gfimcSXFWDZ/jfTk8Fukg3Oxf7oKJomoFEhtwf98Nhr1sDzwphuCDpvdtW46cJQvIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065042; c=relaxed/simple;
	bh=nqpKJluw1doy3y0allgcYKgIgsh/jnQXaIoFaSK7oOg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=U5AwN4V2F/PKz9128pyg3CPAYZG5exYb5ShRV/7z0QxCHgrjqCakkz49BeVSWWHW1P+oTHqpEtyVXc3oXD/3yB/xFiB/2fA4JJtmM1/PPYTWB61Mo/vTIep4KsSFeWh4oUFTb72T1iROZIvO13CXD79S8ONybzMeCClfSs3gGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNIIvOm+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0aRqtY4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 17:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714065036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wugknEMx6eimT+Flw8Mly0d3keuHZeLUeiEU1ZFIR0U=;
	b=wNIIvOm+tj4cgLNEkM8MBEpxUshpJ/iYSv2PLOtpgS5Z3HbTEck4/hr4aZidrPJJ0FhRGY
	8dgyUh8mz8tgqDPlKsbWbVMDQ0RGBC696GYUeWEB329TFjVj5C0M/jaYntgyZrDWvEEylq
	VDXx+H8vrZw40OjxmvYvfHQmz1uNkewU57L7bMxMtXh6BBfL6JcZoV90NjYzAe+wftpp9L
	V28hNl420QzlE9hwdXvjdLRACRnlBP8sjpgQyrCWCAIIxxcM/tcv+jxstFPpN4Rd2A4DQf
	Ftiavrx6fYDlsUCLp6JdzTVZGLNia46Kkx5q9mujsd6Ix+cxpH3Jxpfw0OLGaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714065036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wugknEMx6eimT+Flw8Mly0d3keuHZeLUeiEU1ZFIR0U=;
	b=E0aRqtY4Zt8fZRdSgWRVwt8U4pT2b+yLDoHO4HvS1DiVHYOV8N+v9k8l3oDA9xxdMupn2u
	49PGDMHPFvGnpfDw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] perf/x86/intel/uncore: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171406503634.10875.16911960699005867696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     438731421a2f6dc11a7a4f0ef9a19d79f77ed75f
Gitweb:        https://git.kernel.org/tip/438731421a2f6dc11a7a4f0ef9a19d79f77ed75f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 Apr 2024 09:04:32 -07:00

perf/x86/intel/uncore: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181503.41595-1-tony.luck%40intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2eaf0f3..74b8b21 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* SandyBridge-EP/IvyTown uncore support */
+#include <asm/cpu_device_id.h>
 #include "uncore.h"
 #include "uncore_discovery.h"
 
@@ -3285,7 +3286,7 @@ void bdx_uncore_cpu_init(void)
 	uncore_msr_uncores = bdx_msr_uncores;
 
 	/* Detect systems with no SBOXes */
-	if ((boot_cpu_data.x86_model == 86) || hswep_has_limit_sbox(BDX_PCU_DID))
+	if (boot_cpu_data.x86_vfm == INTEL_BROADWELL_D || hswep_has_limit_sbox(BDX_PCU_DID))
 		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
@@ -5394,7 +5395,7 @@ static int icx_iio_get_topology(struct intel_uncore_type *type)
 static void icx_iio_set_mapping(struct intel_uncore_type *type)
 {
 	/* Detect ICX-D system. This case is not supported */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_D) {
+	if (boot_cpu_data.x86_vfm == INTEL_ICELAKE_D) {
 		pmu_clear_mapping_attr(type->attr_update, &icx_iio_mapping_group);
 		return;
 	}

