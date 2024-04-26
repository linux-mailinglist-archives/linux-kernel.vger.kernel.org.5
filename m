Return-Path: <linux-kernel+bounces-160552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881128B3F08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E5E284CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE6173351;
	Fri, 26 Apr 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDtpyt7g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KLdLNeHL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4D16FF49;
	Fri, 26 Apr 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155138; cv=none; b=Zv9XcoKjnfsvMJS+QALT0yjFbKt6y3v3PM8OlC4RxendFil2XtGFXCdMbOoNbAHEZjOTc4tm6BGrokmAvnCRa/jmx7pDgU9Gl8ze2DkoJJDLpLbEet1S0ZkvG1tUX9BpGBwa3C3KGXXoSBhzcmoUtsS15kmYyTXqACktIEgyI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155138; c=relaxed/simple;
	bh=oVQ/c6vRD+E+IuEoP/TgnBSCJAedYfsqmZcahLpy4b4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=R9Z6FHy/ssbg8Uj1EgMXZk6kKMH6MLcvrVdFLXGzpjwMgCaRUY0QiLTWyx9xR2uv937ZtvE76FCfg3WTC1tMeSGCCzLigoCZ/Z4ThW9VB+v97gBSdqnl7QDcn24MrcdZKRVZILIsyTGbRcE9L1IBm9AGBj5jhxm6p00Dx0w8XwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDtpyt7g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KLdLNeHL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tHeHIuKAaYY/sJSTKbZYKWFvjEI/DvPO1k/UX6wjaOY=;
	b=BDtpyt7gKTFC4qB36EqyyX1ChT5R2odZZMToF+VqHpJ1OnCCTbIaSsKyHXMmXF7dokAgcz
	SJg3ohcg01HzyqR5rJql8OyaVLGs30Fw3st0LyX/djvB5BkzGUpm32xwQu95Aw+wfzFsZg
	jxGQr7d5vRV2eoqVwPmTnV7AHPCvNmGy5/C2ezy9wQajlc0R8zIfQpUfz9OrROp/fLK8Xp
	j6U9vetk4B49kcYUqQYufyxosDcEWP9O3eCYcOTEN9wvBxrmqspV0zx2eeoylDgeJBf88Q
	VVvf8JYqh2wLf1b+aHQltYXkngQ/LT0UlX+odadzdSbzuUHrIvCOEhJcpQ7vtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tHeHIuKAaYY/sJSTKbZYKWFvjEI/DvPO1k/UX6wjaOY=;
	b=KLdLNeHLYb+m0EkkGsoEtHyvT1cWv9lheQugXtkFEGrDtM1a1iFlTKVS1uhXllf/mWZzvF
	mqlXQqh59hKI8lAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu/intel_epb: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513163.10875.2127948930072445264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     77d0930acedf5b81c0a88d385b90747cc1fc4ca0
Gitweb:        https://git.kernel.org/tip/77d0930acedf5b81c0a88d385b90747cc1fc4ca0
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:09 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:24 -07:00

x86/cpu/intel_epb: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181510.41733-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/intel_epb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index f18d35f..30b1d63 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -204,12 +204,12 @@ static int intel_epb_offline(unsigned int cpu)
 }
 
 static const struct x86_cpu_id intel_epb_normal[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
 	{}
 };
 

