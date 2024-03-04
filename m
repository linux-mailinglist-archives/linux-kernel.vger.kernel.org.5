Return-Path: <linux-kernel+bounces-90959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F86A8707A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26528B232D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA345BF6;
	Mon,  4 Mar 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAdEtoEE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U/mnxoCn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D15FDDD;
	Mon,  4 Mar 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571086; cv=none; b=FGUydnPZ+i2TsCnou0XcxHXyQflv90kCkeV5QZV6sQrZEsn6ScUkp87eDZ16kD3HryT69PMX7NRV4rJ2VCQTmPoA7Trej5ujyMnsQUJOQ9P1h/fpm9vVjOZq8QDDpEQtjpJJauFITWZ5k3t2mlJathuT7MTp1WF0CIIJnBSvIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571086; c=relaxed/simple;
	bh=dQbmAu2rwruOqP/ABkEiJsKHiX/3Vyq2dMg6yOxWuPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RIiznai8d/SPGzo4JF+cnw2uGD/kTtuShexycHgqq4Tn2lmwz5XeJ73Cutm/ThpwZsxFVHIaM1dBi+lSY4eyPasqo+DsQ/FprKp07XTsu9yISTLn1zwvkcyjlj+acyVSQVxpeWHyCYGFqhP6Zidu691aP4lTa5a1kEAxw+eR2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAdEtoEE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U/mnxoCn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 16:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709571076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GC5ZbR6JL0+F9LFYFrxKkVTnjHv8MW3IG4YBYZHG/FU=;
	b=LAdEtoEE0xOCTE1QP7wccUNGcpCC/so0EFhuXUXsAdXRdgOcHsmoNc9bVVrZ1mtmCKjmO6
	u59fewJX35mNjXpFpVeT8BXkPXJu3o/9l5Jtac7rNit9F1NBGOIyGYKA35hgF2/CeI/t/N
	h8on4QL78HrbGDVW2E8u2njW9QVg4aF1X0pyX3V7Ee1WW2fe1RjJaf2jTcFFtSezDNFr4h
	LWRn9UmfwDyP87TQRQ2Tvu7C1lR8j6fb9Lu8w2bpoOj6TAkQMCtOshSFW6YhCKyq70B+sV
	jJ7J+eDQ1dwfDG9pMVY86/N+Ukr5XcnsIQyJTCRP3XRGMXTQNKDLKvx7P/w0DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709571076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GC5ZbR6JL0+F9LFYFrxKkVTnjHv8MW3IG4YBYZHG/FU=;
	b=U/mnxoCnXhmwz73W2DzUW/MDpnKV+BKSxVK2zk2UQr0vQ2F/fe6Eo09JBfqXnMFJVaymxf
	RQYRZhxOZiqNPvCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/idle: Clean up idle selection
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240229142248.392017685@linutronix.de>
References: <20240229142248.392017685@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170957107541.398.17375423777710078618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0ab562875c01c91ec8167f8f6593ea61e510fd0a
Gitweb:        https://git.kernel.org/tip/0ab562875c01c91ec8167f8f6593ea61e510fd0a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Feb 2024 15:23:38 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 17:39:24 +01:00

x86/idle: Clean up idle selection

Clean up the code to make it readable. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240229142248.392017685@linutronix.de
---
 arch/x86/kernel/process.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b86ff0f..792394b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -910,11 +910,13 @@ static __cpuidle void mwait_idle(void)
 
 void select_idle_routine(const struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_SMP
-	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
-		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
-#endif
-	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
+	if (boot_option_idle_override == IDLE_POLL) {
+		if (IS_ENABLED(CONFIG_SMP) && smp_num_siblings > 1)
+			pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
+		return;
+	}
+
+	if (x86_idle_set())
 		return;
 
 	if (prefer_mwait_c1_over_halt(c)) {

