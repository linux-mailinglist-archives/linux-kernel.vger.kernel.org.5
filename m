Return-Path: <linux-kernel+bounces-90956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D737870789
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A356284923
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076D5CDC8;
	Mon,  4 Mar 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EoFG5Vy1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+YJXaBj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B74D9FA;
	Mon,  4 Mar 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571083; cv=none; b=jcLubqYlpj8zIhHbCPHjKKW3x0qt0arg38gIErF7Owg4zCG27zN0vU5Ai+VXw5zDtAwrOwCrFMk9amib3+bAfa4I/9+9uwXtkSBg0V4Vg40xxrYZ9T3pKwgIM5Y+iknQceF+BhdUbkyl2iH22w3ZCRkUghL3sfUqd6rl+GJSa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571083; c=relaxed/simple;
	bh=zbedetWYI+wnqCi1nmRH++kTU2cA0anbJccqB868Fq4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IMmKYe0tWsWkzL9NTh650heNeo4YDRVIYKQDDI0yPyIPrGfaQ0Ncn75rWPvd71/3grAjnLrActQN4RumaCbzUroP4mH252uW7EY3UiR/DFT1KQeot+4FvvHs+2qyUEiuUYhmLX+IKeem6b6mTzRHPzQ9UpLoJVWjySPJVVMLaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EoFG5Vy1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+YJXaBj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 16:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709571074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/oxIPCp3dJtSzJIAQ62RazA/EZBb/7hLFyOpf5dOng=;
	b=EoFG5Vy1B1SCUUKdEpjgyXybvUBJyOyIK0O6fZeNae9audmnfFr4tOxk1pjxXPBJKoUvAg
	tUtFKSvkG4bJ2hUcUTPY34kKmimJMljIoKHliYv3J7Y7coDUjMSFgT4jOVs2pMzWtMy31S
	6UgDpIZCnf/bSMDhvA3p1tPc2zdXeS856olNCAFatzKfKSLiqb1TEoIWRA3Dv3pPU0nGQk
	pv1trdd+50/ROZAnN7dNyuu4NfBCNxAjTkpFm1jIzbaA5THjPIf0mgNxd+ldhOk9/GvMo4
	PvqnpNAnJVI2dCb0GETXQiqlExGakGXpeJh0LxWoB1suc0gmlZtlaovdBHRelQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709571074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/oxIPCp3dJtSzJIAQ62RazA/EZBb/7hLFyOpf5dOng=;
	b=p+YJXaBj8embbcKurIyKwCVhaUSXwaHo3Zd8rUKZiQH4e1+Y8Jl5uSgCmTO+hgw4bf2fQr
	KlaZzR4M8C/X8qCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/idle: Select idle routine only once
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87edcu6vaq.ffs@tglx>
References: <87edcu6vaq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170957107241.398.4180780999750222432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     35ce64922c8263448e58a2b9e8d15a64e11e9b2d
Gitweb:        https://git.kernel.org/tip/35ce64922c8263448e58a2b9e8d15a64e11e9b2d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 28 Feb 2024 23:20:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 17:39:24 +01:00

x86/idle: Select idle routine only once

The idle routine selection is done on every CPU bringup operation and
has a guard in place which is effective after the first invocation,
which is a pointless exercise.

Invoke it once on the boot CPU and mark the related functions __init.
The guard check has to stay as xen_set_default_idle() runs early.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/87edcu6vaq.ffs@tglx
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/common.c     | 4 ++--
 arch/x86/kernel/process.c        | 8 +++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 1188e8b..523c466 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -558,7 +558,7 @@ static inline void load_sp0(unsigned long sp0)
 
 unsigned long __get_wchan(struct task_struct *p);
 
-extern void select_idle_routine(const struct cpuinfo_x86 *c);
+extern void select_idle_routine(void);
 extern void amd_e400_c1e_apic_setup(void);
 
 extern unsigned long		boot_option_idle_override;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f367d3..5c72af1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1938,8 +1938,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
-	select_idle_routine(c);
-
 #ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
 #endif
@@ -2344,6 +2342,8 @@ void __init arch_cpu_finalize_init(void)
 {
 	identify_boot_cpu();
 
+	select_idle_routine();
+
 	/*
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ccaacc7..f0166b3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -853,8 +853,9 @@ void __noreturn stop_this_cpu(void *dummy)
  * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
  * is passed to kernel commandline parameter.
  */
-static bool prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
+static __init bool prefer_mwait_c1_over_halt(void)
 {
+	const struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 eax, ebx, ecx, edx;
 
 	/* If override is enforced on the command line, fall back to HALT. */
@@ -908,7 +909,7 @@ static __cpuidle void mwait_idle(void)
 	__current_clr_polling();
 }
 
-void select_idle_routine(const struct cpuinfo_x86 *c)
+void __init select_idle_routine(void)
 {
 	if (boot_option_idle_override == IDLE_POLL) {
 		if (IS_ENABLED(CONFIG_SMP) && smp_num_siblings > 1)
@@ -916,10 +917,11 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 		return;
 	}
 
+	/* Required to guard against xen_set_default_idle() */
 	if (x86_idle_set())
 		return;
 
-	if (prefer_mwait_c1_over_halt(c)) {
+	if (prefer_mwait_c1_over_halt()) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {

