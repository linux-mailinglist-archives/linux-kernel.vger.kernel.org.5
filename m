Return-Path: <linux-kernel+bounces-35080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAEE838B92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEDF1F23B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36845A790;
	Tue, 23 Jan 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="evUI6CTe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBP/gPOM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFB5A119;
	Tue, 23 Jan 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005109; cv=none; b=LllPlrZQo3a2yvJaNMeehdmFLRg1cp3YvUjVtyhrm3GEY6xonaT6exGX7RT7RRqnCClMTzWYJ2GzW27G1O9ZyCeh9V8lnGdVYlGGSDv55EKiHSzsMh1S1Y4miI9LISfsW/HHk/TnNHdPdzOhTfWQEfwfi+thKGeHOEB9Hp4gSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005109; c=relaxed/simple;
	bh=f3BXlIxqxKATNk2TfuAQlr+G36z0om5u6wct8Gd7i80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YU+zyf7kO1urSq5sY/nvOIkirn2VewODWUnKipRnmNKKJuouqbS+qfx5RSAuA5+WptYdstfVp73qCETHEK3jyoUm08eabjcY1CTe5FHVp0D1XHB8p2AKem5DbkQMmv4UMBuYipu0fS/wrhcdzCE4v6PShtEhbyJq8do4+l/nW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=evUI6CTe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LBP/gPOM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Jan 2024 10:18:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706005106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGGls34kRnOUwStnotkuyY4f95C+5TYh2bd6Riinmng=;
	b=evUI6CTe9ojgU/v8uk2+RzgY+hcPygvRJD0kV3303OKQYFGVGCyVSOf6WMurvzo4FSI6O5
	isZVu687tYqEu6wt7bPFqXWsPXAKSfrXtvxKOgJ1HjSzaPq+h4TqUwPn9xPKIrYU2uMIM1
	g1INlkdAlMDD8SOVImzYtFXuUiY+HuiSlnVf/jC7IVd77ag6QT8N41lQ/QrWFABHSh6XUT
	YX5ptjgTePkBy1yg4dYQMJAsHFIFg3HAbNYa95ie86P2eIhr32owtxLnarQRMhysu6UVr+
	slTPIdEKWnJmH1z+R5IbHKYBaaCZNhfSGQLuIg7DRY9wpoEmDD1mSaRZWMZueQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706005106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGGls34kRnOUwStnotkuyY4f95C+5TYh2bd6Riinmng=;
	b=LBP/gPOMI1RhGO/7RF3O71i7OTd0Ac0/DgHH6OAuZ01gAWMQ68c2zI+I4FkrM0iGcqnAiq
	Ynmf1UrOdZ/WjNCQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Add X86_FEATURE_ZEN5
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
Message-ID: <170600510534.398.14282471394356279646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3e4147f33f8b647775357bae0248b9a2aeebfcd2
Gitweb:        https://git.kernel.org/tip/3e4147f33f8b647775357bae0248b9a2aeebfcd2
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 04 Jan 2024 21:11:37 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 23 Jan 2024 11:06:18 +01:00

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

