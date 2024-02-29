Return-Path: <linux-kernel+bounces-86830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B710E86CB64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4669E1F2509B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86771361A3;
	Thu, 29 Feb 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c4jRcutT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGnSZjKl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EA12AAC1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216623; cv=none; b=rDx/jkPoXGxsf8ZkajlbLVIQqx99UT9+mmKoCeaoEH5YOPS4rksKmP2hirccRwWu4epXo3aUTQ6HNmblQwcg8cmqQIDiRJ1TvxU570PzF4Z3S43g4IS3MNqC2MFnAWrhRRRIzdbcHXIlouzOJ1249aYgSKmoiGF0Uwadr3lul38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216623; c=relaxed/simple;
	bh=kLDDncfMIoSPBawEujdd+4tOaINTsXZmxPLVrOH1Mso=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fibr1sKsB7aM00z3jypUbPgv0mveI30cm5SVUDF6Ou8OmeLClehYOsm2wzvb3GwBUFuzRFD8HpzE8zvtYRbW7ScySXskj2lOdVbPTwrZXiSql/+d034pDN69eSsAztR9/Lji15cA4/NK5tIL69L4jV6HQcHfZewVdJ+1J+m2fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c4jRcutT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGnSZjKl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240229142248.329708185@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709216617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NwhFXWiIfv03GUNxMbXr1/eiWot+mUon4MYYqtAsfLk=;
	b=c4jRcutTzFfHbzAqlu7h87okmmgm8AJHNxVr8cp0XiCrtyDJM6V61QkM3JM4ZSJtFX1DDx
	Uzr9wF8XjSC3f1DJk9KdBvlP3GRsdOUFmoYCig+ji47WRcVNHbCP8WRV7rpP542lnb7tRE
	ZOlo+1i7AeW11TlM04lG80/iD/EOB+slfKBr0Ok3W2BDQLss2yQ7yuq5hADpqL4Av6Zk3z
	LLbwASBQuT2pdhSpv9S1SCzyMza2Cf8ofvTWFxURMe4qla2G/lUTFtoxAGm3NOKI6+vyT2
	sBfaEqVQsGszGk3iFDVJ4Dl/UQ4t9qEmnn6jlzEhgZs5kQ7iBHNlhRc9u7G3Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709216617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NwhFXWiIfv03GUNxMbXr1/eiWot+mUon4MYYqtAsfLk=;
	b=cGnSZjKlw69F5tPrAxUo5pqjKGbhSMDoasLn+3YkL9b70Ol1cygv3AkMBn8Erj07HBQa8W
	QLiE+zIOwvZ7UoDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Borislav Petkov <bp@alien8.de>
Subject: [patch 2/6] x86/idle: Sanitize X86_BUG_AMD_E400 handling
References: <20240229141407.283316443@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 15:23:37 +0100 (CET)

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
---
 arch/x86/Kconfig          |    1 +
 arch/x86/kernel/process.c |   41 ++++++++---------------------------------
 2 files changed, 9 insertions(+), 33 deletions(-)

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
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -846,31 +846,6 @@ void __noreturn stop_this_cpu(void *dumm
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
@@ -890,8 +865,8 @@ static int prefer_mwait_c1_over_halt(con
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
 		return 0;
 
-	/* Monitor has a bug. Fallback to HALT */
-	if (boot_cpu_has_bug(X86_BUG_MONITOR))
+	/* Monitor has a bug or APIC stops in C1E. Fallback to HALT */
+	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
 		return 0;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
@@ -942,17 +917,15 @@ void select_idle_routine(const struct cp
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
@@ -985,7 +958,9 @@ void __init arch_post_acpi_subsys_init(v
 
 	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 		mark_tsc_unstable("TSC halt in AMD C1E");
-	pr_info("System has AMD C1E enabled\n");
+
+	static_branch_enable(&arch_needs_tick_broadcast);
+	pr_info("System has AMD C1E erratum E400. Workaround enabled.\n");
 }
 
 static int __init idle_setup(char *str)


