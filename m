Return-Path: <linux-kernel+bounces-89114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8547F86EAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF0B28FE0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB205644A;
	Fri,  1 Mar 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="elYG/t1N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LemgOSdq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207EF537EC;
	Fri,  1 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326128; cv=none; b=BsMgfnwIAyn2lVDgIkD9toWf6Daj0xZELdg5LBj4Nv+rhqQqkvQyaPDP1iCoUJ4uW0ks0lnk4cuE2LegbaUvyTBWM0SjCTF3e+VbSlPHa0FgW6nsxR1gKRGJ/E+0zgPu3W/c+OrgYZx4HQnZrTvvfTv2/LggTerpSSz7ejInKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326128; c=relaxed/simple;
	bh=AmmkBhmavhgPhD/NMBu+VsLPjLOw/ch4lurlwmfpego=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GJ0qWCPJLwZXMJEVbsf/wCJp4uaio15MADIYH2vXOwUh9vhR0JtdhlriNyuYC6VK9U8en6Ic+/zvInRLaHxtNmU6uJQ3LI7SaJHfqGr/tOU4N4H8GryQxSGXj+cYoVk/SuV8+Cn8YZUurXWbb5zrTDdiAOk18/P3upti5objkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=elYG/t1N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LemgOSdq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 20:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709326123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPt61NgyrrVAT3ev1oj2xf/IZRQk5WLtiQKyFPY39cM=;
	b=elYG/t1N2EFRfsPhOjljmn3Dg+M1E0eKrbp6sgAAE8J573iKHsHIn8fhaG2Sk3F5XU9mzF
	9i3YwxFaoWW+KQdiq408GYwB0L9tM51rrCJ6ouZTKQfbWbIRgTx0wUX/qPcOaIWcOb0PRY
	G3Gc99u+aXxvzsmRl/QSgIFTcocoFIgfu+acxt0b9XEz92GmdY5ZGA8Gn/45mxaO70s43G
	5L3nJO6THO74hpqwg6h3OUnmInCQjB1mYiymJjRGzmFbeL9vuRc+j1b2Jdq/8n1qnx4IJy
	gLRQv1NqNaY2LkYfRF8VIlz2SgFg5hBun2CraMU06BG/4PVbyVxrqFguAF8iFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709326123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPt61NgyrrVAT3ev1oj2xf/IZRQk5WLtiQKyFPY39cM=;
	b=LemgOSdqFP7GkvLGKApUd4gHFRCZrBstamgEHYe/64l4Yv/Aj5gPna9mbwep8nblZ3B66W
	QPcDwEanyV6NKQBA==
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
Message-ID: <170932612275.398.5909023853768866399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     18a9f4806dcb33ed7eab93232d13facf5c6e2b70
Gitweb:        https://git.kernel.org/tip/18a9f4806dcb33ed7eab93232d13facf5c6e2b70
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Feb 2024 15:23:38 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Mar 2024 21:33:12 +01:00

x86/idle: Clean up idle selection

Clean up the code to make it readable. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240229142248.392017685@linutronix.de
---
 arch/x86/kernel/process.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5853d56..b6512f7 100644
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

