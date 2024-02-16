Return-Path: <linux-kernel+bounces-68584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD7857CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41191C21493
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1F1292C5;
	Fri, 16 Feb 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6IwiskZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+FthxQQm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905581292E6;
	Fri, 16 Feb 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086922; cv=none; b=ESQ+rMPwRE1UY6OUlu1HqLH8iAG99MV1XNr+HsSKjOtALYviRMYH8oYUJXZ2bwxHJt4jWapF8cBFvMVlhPnBYgU6YRAU2+RUaq/J3kOH+3VZfsaSdsKMpT8zkwyT75M48FLH9b6RsQxHr8iorRff2YmhZKaPC5pvGB6P9y9YF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086922; c=relaxed/simple;
	bh=gByuKHBT+pO62w52Soorh9A5vO5ZQ4X/kEeA3nLMKXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MXMVD5pSFZYW7JgFGrGBVlsVr+nLxl0c7c4hWiLDxFBPZDGC8Ae5M+QM/JDrFu3K+uIzFrYKD/0H8Y3of1iz38Us2C4qPzHL6Qe1zqG/QRtlQYIQ/inzrPMXPGdgKZEqWlgFU2yVu7O2A/AZHrS1Z2Ekab7qbgzFvqpNGYDqWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6IwiskZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+FthxQQm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 12:35:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708086912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmXlKSB84u3mNALRU0XpyIXwoW3M9MHnRTLBqOdEn98=;
	b=d6IwiskZfMyQGuybkaqKJza1BYgmoZau/24Yipc8GfcMfXolmNNxdZL5IoStAUgN8ghcAQ
	Iq/4A7P8EJTHqBnZUmoRBa5iISxOL3CxJZ8zQ3QQwyKPcrwkNeGMDq0PaBVcq8DND/pMv1
	UYY85JtZv0kxDQtyNAX0xVlmnlmx5YaUhVcqbntRG3RJtvNj7xueVfVyDgHWGeTG1d/Kar
	0RBDNLIA/uGVDkdjyQNs5k5GJbgztKD03J1zcVmXQ2/N4VYbsUwDTUCwPRe2BovEvCnH10
	KHWoX8uyVskosWQs4krjruAiTnPtLVzC6SjFtUTezNitpBJNCX+77600nQgQrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708086912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmXlKSB84u3mNALRU0XpyIXwoW3M9MHnRTLBqOdEn98=;
	b=+FthxQQmXGonKHtYT6mXJa60VQVFAHZABnoxFqABBVXww1jCmQUF7ECHfYOri8p+2oSMvs
	uiN8Ey79528/fGCQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Do the common init on future Zens too
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201161024.30839-1-bp@alien8.de>
References: <20240201161024.30839-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170808691158.398.9488356519655439203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     03ceaf678d444e67fb9c1a372458ba869aa37a60
Gitweb:        https://git.kernel.org/tip/03ceaf678d444e67fb9c1a372458ba869aa37a60
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 01 Feb 2024 17:10:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 13:15:12 +01:00

x86/CPU/AMD: Do the common init on future Zens too

There's no need to enable the common Zen init stuff for each new family
- just do it by default on everything >= 0x17 family.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240201161024.30839-1-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f3abca3..fc042af 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -969,7 +969,6 @@ static void init_amd_zen_common(void)
 
 static void init_amd_zen1(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
 	fix_erratum_1386(c);
 
 	/* Fix up CPUID bits, but only if not virtualised. */
@@ -1023,7 +1022,6 @@ static void zen2_zenbleed_check(struct cpuinfo_x86 *c)
 
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
 	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 	zen2_zenbleed_check(c);
@@ -1031,8 +1029,6 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		/*
 		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
@@ -1046,15 +1042,12 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
 
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
-	init_amd_zen_common();
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
@@ -1094,6 +1087,13 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x16: init_amd_jg(c); break;
 	}
 
+	/*
+	 * Save up on some future enablement work and do common Zen
+	 * settings.
+	 */
+	if (c->x86 >= 0x17)
+		init_amd_zen_common();
+
 	if (boot_cpu_has(X86_FEATURE_ZEN1))
 		init_amd_zen1(c);
 	else if (boot_cpu_has(X86_FEATURE_ZEN2))

