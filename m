Return-Path: <linux-kernel+bounces-89116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28B86EAA7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E560728FEA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F05674D;
	Fri,  1 Mar 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Laa2tLjy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2NNufubw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A667537E5;
	Fri,  1 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326128; cv=none; b=H+JG0cxubdr/0jjQKsf9Qf3Jq+17wQ4+34Y7ruDtkUH7vIx65I+gkLwqE+bVFJDqVwGfgZb7aNELUEbKuqmwR8uomRcNVSRPmTqPorPa0m8jCnSTin+c0an+anCk8ccmOSYygXaNTo3U1QuWPMV59Q2R+cm6JDUb3G1MLfPIocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326128; c=relaxed/simple;
	bh=xFSoLRHZ1pg3hz59nq1ZMqlI9iLTuRh6cYkpmEO4s1s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PbY6418yOY1RYkSTN+myo6b0egr6IvoHsPMOKmJqDK5SQ+oPruyNXdt2Vm2fVYQr5tAJjDeo2UnLPy+Bxv6Y4KK46hsyyKi1IZFdqhKIEgiV56eNnmV40lm2vC5Nwf2vddKISs8vm0j0SfjPiVKD/nww5SYLZ0dX5NfEUAzn3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Laa2tLjy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2NNufubw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 20:48:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709326124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQJ0cFB/y9cWkLzdFv+zCeeLapn0Qvop2py0VkQ2On4=;
	b=Laa2tLjy5fNDYeOEG5h+EdlK4GRSBsiGp/jSlDsUtOeRMDTTFBC8pu+0COTXS/CN1ZKIFj
	cboFTQFSRggl5MZTuy87mg2FjhyZ1GfZUHJaLcR3CuEGB2JSRVTMYOnaMSyfh2QSyPOPiz
	qty/k1yMIXLPRw7n0x55wXxITjwihmao5UtVt4/BmE2O/1/NYCJh+wOuGa6q6T5CWsoA+c
	sTFVtM+0B7JgrYPuEik6UEKRT18GQ4nXjKN9Vl6aeflf7oXZfkgVx/waJHwcexqrty6tKl
	DaAVWYdv5/rJm5KzuYhKMwWzyVbmwqkhx0B1tDe4us3TLORDEXA4J0A2sPbFiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709326124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQJ0cFB/y9cWkLzdFv+zCeeLapn0Qvop2py0VkQ2On4=;
	b=2NNufubwUWNAO4hG2W0gxRRkRACJj/25P+uZo1ywkAG6KEEOS1JptqLhCwfFHQnUNowcqx
	AgjD4UAhJs/1xHDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/idle: Sanitize X86_BUG_AMD_E400 handling
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <877cim6sis.ffs@tglx>
References: <877cim6sis.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170932612368.398.10382603040701836222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3b9b8e89c8e1e97c76be6abc67db702ea978d89b
Gitweb:        https://git.kernel.org/tip/3b9b8e89c8e1e97c76be6abc67db702ea978d89b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 28 Feb 2024 23:13:00 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Mar 2024 21:33:05 +01:00

x86/idle: Sanitize X86_BUG_AMD_E400 handling

amd_e400_idle(), the idle routine for AMD CPUs which are affected by
erratum 400 violates the RCU constraints by invoking tick_broadcast_enter()
and tick_broadcast_exit() after the core code has marked RCU non-idle.  The
functions can end up in lockdep or tracing, which rightfully triggers a
RCU warning.

The core code provides now a static branch conditional invocation of the
broadcast functions.

Remove amd_e400_idle(), enforce default_idle() and enable the static branch
on affected CPUs to cure this.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/877cim6sis.ffs@tglx
---
 arch/x86/Kconfig          |  1 +-
 arch/x86/kernel/process.c | 42 ++++++++------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5029862..0802653 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -147,6 +147,7 @@ config X86
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
+	select GENERIC_CLOCKEVENTS_BROADCAST_IDLE	if GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 45a9d49..5853d56 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -846,31 +846,6 @@ void __noreturn stop_this_cpu(void *dummy)
 }
 
 /*
- * AMD Erratum 400 aware idle routine. We handle it the same way as C3 power
- * states (local apic timer and TSC stop).
- *
- * XXX this function is completely buggered vs RCU and tracing.
- */
-static void amd_e400_idle(void)
-{
-	/*
-	 * We cannot use static_cpu_has_bug() here because X86_BUG_AMD_APIC_C1E
-	 * gets set after static_cpu_has() places have been converted via
-	 * alternatives.
-	 */
-	if (!boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
-		default_idle();
-		return;
-	}
-
-	tick_broadcast_enter();
-
-	default_idle();
-
-	tick_broadcast_exit();
-}
-
-/*
  * Prefer MWAIT over HALT if MWAIT is supported, MWAIT_CPUID leaf
  * exists and whenever MONITOR/MWAIT extensions are present there is at
  * least one C1 substate.
@@ -890,8 +865,8 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
 		return 0;
 
-	/* Monitor has a bug. Fallback to HALT */
-	if (boot_cpu_has_bug(X86_BUG_MONITOR))
+	/* Monitor has a bug or APIC stops in C1E. Fallback to HALT */
+	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
 		return 0;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
@@ -942,17 +917,15 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
 		return;
 
-	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
-		pr_info("using AMD E400 aware idle routine\n");
-		static_call_update(x86_idle, amd_e400_idle);
-	} else if (prefer_mwait_c1_over_halt(c)) {
+	if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
 		static_call_update(x86_idle, tdx_safe_halt);
-	} else
+	} else {
 		static_call_update(x86_idle, default_idle);
+	}
 }
 
 void amd_e400_c1e_apic_setup(void)
@@ -985,7 +958,10 @@ void __init arch_post_acpi_subsys_init(void)
 
 	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 		mark_tsc_unstable("TSC halt in AMD C1E");
-	pr_info("System has AMD C1E enabled\n");
+
+	if (IS_ENABLED(GENERIC_CLOCKEVENTS_BROADCAST_IDLE))
+		static_branch_enable(&arch_needs_tick_broadcast);
+	pr_info("System has AMD C1E erratum E400. Workaround enabled.\n");
 }
 
 static int __init idle_setup(char *str)

