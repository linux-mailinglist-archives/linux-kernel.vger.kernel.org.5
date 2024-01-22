Return-Path: <linux-kernel+bounces-32750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E75835FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685501C25947
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC003B196;
	Mon, 22 Jan 2024 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C1lJ2k3a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ebtxCKv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6243A278;
	Mon, 22 Jan 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919242; cv=none; b=UxppMeGgtyFhjkyR9sK7AXpURZGYnMAeGnsRpbcnQJU36IKZqVlW7apMaUGwiEvA9gVOUKm8mKrk7REW3/yFgvsfXXQxCQ6oAYN4KITtRkh/ruNOnEsF79/EgquD2v06stWt1OpHFLqftBWXzYaz+TKHk9EhhvR+7Kx0f101ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919242; c=relaxed/simple;
	bh=jZRsclkGS8dzOt2UTjQXIJKQsS1Rrchp8mJDmNSdlyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=owqlJ5O2xDGKokTsg2+JVqgrw8NXb3p3QBnndBCPaVb4Q3/lMfD8wws3P3+htHt6qi9DXnNl1NQw97ltWj9js7oF3/DJuSUJebKluRK2aGrOW6yQQGOIIt440OFWNuFqkUh2frfER+dDrJxFVA07HrNa0eek0qoKRTx4bcvW4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C1lJ2k3a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ebtxCKv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jan 2024 10:27:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705919239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncIERaOhSVJFWuDUSs8GuA6Uftk7aWWlnT/dEMBjjz0=;
	b=C1lJ2k3ajuiHnVgPXtQeplF82Nte+p4spxCXUpvDDNH4svwVGEiaWhlKw8bA1qmvvNWt7M
	mmcEguOcOSsCO7b+AiKjslrGic9HECb3TXZ4DhnccvSOzttZlmRwuV2zA3xwprmQvU2Pq2
	Es37Ed0T0Ln01omN/4kJLbA+lXYPWO2GUbOmCi1cnGoluxzyC4HzjcGkeszSU1+n/4oMdI
	sKZOxemtFgVzNd5oFRC9eOTOWKDGoKcwGeIv+F58lAXPIHwNVHI/idKvGdlNLNP0QDKJIj
	HGykhqRd74UNY9KbKkvX8nlBvH0wPrcL2rxHN7purFlxFuOoAOW+WpN/Oz8kgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705919239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncIERaOhSVJFWuDUSs8GuA6Uftk7aWWlnT/dEMBjjz0=;
	b=6ebtxCKvk2jfnguPa7cWf1zRftlARSLQQQQi4zK5/3oECQBP2RR6592iMZRVDlucsnMrYl
	JGXvwYgoJcvCZcDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Add X86_FEATURE_ZEN5
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240104201138.5072-1-bp@alien8.de>
References: <20240104201138.5072-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170591923823.398.13999497759890877846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     bbfc72531ee7ae1617b39869022ea28b9b6a1b36
Gitweb:        https://git.kernel.org/tip/bbfc72531ee7ae1617b39869022ea28b9b6a1b36
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 04 Jan 2024 21:11:37 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Jan 2024 11:13:37 +01:00

x86/CPU/AMD: Add X86_FEATURE_ZEN5

Add a synthetic feature flag for Zen5.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240104201138.5072-1-bp@alien8.de
---
 arch/x86/include/asm/cpufeatures.h |  4 +---
 arch/x86/kernel/cpu/amd.c          | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 29cb275..fdf723b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -81,10 +81,8 @@
 #define X86_FEATURE_K6_MTRR		( 3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR		( 3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* Centaur MCRs (= MTRRs) */
-
-/* CPU types for specific tunings: */
 #define X86_FEATURE_K8			( 3*32+ 4) /* "" Opteron, Athlon64 */
-/* FREE, was #define X86_FEATURE_K7			( 3*32+ 5) "" Athlon */
+#define X86_FEATURE_ZEN5		( 3*32+ 5) /* "" CPU based on Zen5 microarchitecture */
 #define X86_FEATURE_P3			( 3*32+ 6) /* "" P3 */
 #define X86_FEATURE_P4			( 3*32+ 7) /* "" P4 */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* TSC ticks at a constant rate */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9f42d1c..bc49e3b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -538,7 +538,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 
 	/* Figure out Zen generations: */
 	switch (c->x86) {
-	case 0x17: {
+	case 0x17:
 		switch (c->x86_model) {
 		case 0x00 ... 0x2f:
 		case 0x50 ... 0x5f:
@@ -554,8 +554,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			goto warn;
 		}
 		break;
-	}
-	case 0x19: {
+
+	case 0x19:
 		switch (c->x86_model) {
 		case 0x00 ... 0x0f:
 		case 0x20 ... 0x5f:
@@ -569,7 +569,17 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			goto warn;
 		}
 		break;
-	}
+
+	case 0x1a:
+		switch (c->x86_model) {
+		case 0x00 ... 0x0f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN5);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -1039,6 +1049,11 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
+static void init_amd_zen5(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u64 vm_cr;
@@ -1084,6 +1099,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 		init_amd_zen3(c);
 	else if (boot_cpu_has(X86_FEATURE_ZEN4))
 		init_amd_zen4(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN5))
+		init_amd_zen5(c);
 
 	/*
 	 * Enable workaround for FXSAVE leak on CPUs

