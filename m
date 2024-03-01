Return-Path: <linux-kernel+bounces-89115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49BF86EAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9428FDFF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689235646F;
	Fri,  1 Mar 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6xlKup4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cdjH2Xtc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082C537F6;
	Fri,  1 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326128; cv=none; b=plHVxS5C7uxJr+moztGB8ldnxgv4YLreeI2lpTQodU6D0nMPppyTXzUSRc66QIlrD4AC5MPamb1//ITje8BBJ/CZ7J8DPiE96qT4V2JTnRNtughi0G8Bd9eUUJYYR2kymHyD5Qes01Yd4VSQjRgsFB7LgI+gZpRPPEfFhjcMQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326128; c=relaxed/simple;
	bh=lVm0fmnn1SEFePlLOkP7aHhUvllk3HXlAGwr2mbIcMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u7ktQYYto7e3hJrdyyYUKscYfn4DSQsRR+b/1mguqLFy+fDvg0pQ5x1JVxm/bJLc46DzLcRuSyu9b+wvJoAd9tWimOlnxei/4cTkp+5Qe7h7lot3aNyofJtP5ofk8Vg3rWy1Coym4MvRLrEAqamekuNPbWbvcAoczakWEN9aYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6xlKup4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cdjH2Xtc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 20:48:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709326121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFcw22EsX0TAntmyqYDwVrlfo/EZNLuo4RfsMaRqGhQ=;
	b=Q6xlKup4DFIbwGDvmGyeCCh4gNVhLu4pfgO2eXkWIOhkPh6ObeshARE9dwaorgjiqCm9WW
	SOakaIUDsK69Ueop5GlQQ3wBfDwgi+njCUF8Le6RW9Cy9LTWniY9vwCe0urFq7eqYkFPKJ
	EM5it7f1/bxl43mtV5o3zT8w03FNAE4OWd8RhGfhTFJL2dFSjG4OJ1eFMsmHxWKVOCKrf3
	Nq43ANMvsY70lTnhMP8FHHGGhNxuRCZPEiTjxHI7aHIJcrnwyAwp2ReqeXttAQYCzzRFkL
	7qdSjbb9YLqQPLLw9wNd8/z+qxioNbZVySzqsLjWyt7VGLlet/2kTNk28QRWMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709326121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFcw22EsX0TAntmyqYDwVrlfo/EZNLuo4RfsMaRqGhQ=;
	b=cdjH2XtcHUagk3dbEqahtez9BjFEYXaRYXDLbMReTnH3WuLsS3oYLgVOl70pkBMOEXd1Ts
	Kwa1NorKW3lwKLCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/idle: Let prefer_mwait_c1_over_halt() return bool
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240229142248.518723854@linutronix.de>
References: <20240229142248.518723854@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170932612092.398.1034470417889380142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     71f3a783a758696b5f8084b6f1621240b8804568
Gitweb:        https://git.kernel.org/tip/71f3a783a758696b5f8084b6f1621240b8804568
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Feb 2024 15:23:41 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Mar 2024 21:33:12 +01:00

x86/idle: Let prefer_mwait_c1_over_halt() return bool

The return value is truly boolean. Make it so.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240229142248.518723854@linutronix.de
---
 arch/x86/kernel/process.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 678d5cf..2d51cbd 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -853,21 +853,21 @@ void __noreturn stop_this_cpu(void *dummy)
  * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
  * is passed to kernel commandline parameter.
  */
-static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
+static bool prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
 	/* If override is enforced on the command line, fall back to HALT. */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
-		return 0;
+		return false;
 
 	/* MWAIT is not supported on this platform. Fallback to HALT */
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
-		return 0;
+		return false;
 
 	/* Monitor has a bug or APIC stops in C1E. Fallback to HALT */
 	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
-		return 0;
+		return false;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
@@ -876,13 +876,13 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 	 * with EAX=0, ECX=0.
 	 */
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
-		return 1;
+		return true;
 
 	/*
 	 * If MWAIT extensions are available, there should be at least one
 	 * MWAIT C1 substate present.
 	 */
-	return (edx & MWAIT_C1_SUBSTATE_MASK);
+	return !!(edx & MWAIT_C1_SUBSTATE_MASK);
 }
 
 /*

