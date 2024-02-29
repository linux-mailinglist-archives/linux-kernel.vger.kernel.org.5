Return-Path: <linux-kernel+bounces-86834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFB86CB69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705681C20F70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C26A13A874;
	Thu, 29 Feb 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCgrKLzN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wrb4cDbK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC41361CF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216625; cv=none; b=HlTqmkGoIiIS6fkFJgWDV9Gaw0FuyykzWpae1hQhAwJ9zdgedwGsMsJyGrqMYTfi/FWqsCA/SLAGPB9lS9QrlER6JQOlPos16xNmrJgrnO5DIIlP8z5psWv81o95weyqfQcUnc9Y3jEVB1vWDiheKMVIaudrQ+Bh4cYcY3tszD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216625; c=relaxed/simple;
	bh=RYjgrsnTa5ZE0/Y2Vs7u3YT+7pEEBNYqFqB94PRnE9Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tbRKIK63v6NKdmYHkegnSVRzR6YgrQdrubXjOOa07P52mLKoAoi9mskikfxm0QBJ63NeeXRq03uMJ/Wabopi08nBgohL43pZU9aY2OEseXKtridKV9eQiKuKCUpNWm0KyJg6hLt5S7cHsV8Eo9Sut3MR2v+v+W8xgGXMVLBdX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCgrKLzN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wrb4cDbK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240229142248.582321500@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709216622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LNNG9Jq+5CN9Sd6cMwb+ZtsoydO1GTY3u/PKYA5LbYI=;
	b=rCgrKLzNnXAJY4Zz0SDVlmyfrwrDTu1tzaZdnmqkKGsPyT8ZvfLWIrxWM0KMMstuUsF4Mp
	97wJ0KRpLX6QqeXkvlcbzkZQVfpZTMeusQ4GBJuZER5nrB0oSySQjs0AzfJSWSo8t/SRlr
	6lLWUnEMzXPgViZs+oRCFLTeMEc0F3U2qS13dPNPZHXS6TvXvP0W5ncMekrVxuZsiIRpi2
	wMqd3IdOQbEng36tO+U9mAnPrkmhi6cJ/bFcwdWjGMAArLWEQs5+WwLIbJjU9ztNBM6IPl
	E95s9nm1Kd+xIsyPUcrcQshE/PJ1PCWiSk79ZsF5ydZsFZ225Rrg5yCAEIz7MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709216622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LNNG9Jq+5CN9Sd6cMwb+ZtsoydO1GTY3u/PKYA5LbYI=;
	b=wrb4cDbKtuppv+wHBLyf/kbGN8Bpl/sOApjOH/vE/24sPbalv/MlJMr3qmAp2IwJTtjcka
	4qMjKjSYLXXY0ODA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 6/6] x86/idle: Select idle routine only once
References: <20240229141407.283316443@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 15:23:42 +0100 (CET)

The idle routine selection is done on every CPU bringup operation and has a
guard in place which is effective after the first invocation, which is a
pointless exercise.

Invoke it once on the boot CPU and mark the related functions __init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    4 ++--
 arch/x86/kernel/process.c        |   10 ++++------
 3 files changed, 7 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -555,7 +555,7 @@ static inline void load_sp0(unsigned lon
 
 unsigned long __get_wchan(struct task_struct *p);
 
-extern void select_idle_routine(const struct cpuinfo_x86 *c);
+extern void select_idle_routine(void);
 extern void amd_e400_c1e_apic_setup(void);
 
 extern unsigned long		boot_option_idle_override;
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1938,8 +1938,6 @@ static void identify_cpu(struct cpuinfo_
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
-	select_idle_routine(c);
-
 #ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
 #endif
@@ -2343,6 +2341,8 @@ void __init arch_cpu_finalize_init(void)
 {
 	identify_boot_cpu();
 
+	select_idle_routine();
+
 	/*
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -853,8 +853,9 @@ void __noreturn stop_this_cpu(void *dumm
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
@@ -916,10 +917,7 @@ void select_idle_routine(const struct cp
 		return;
 	}
 
-	if (x86_idle_set())
-		return;
-
-	if (prefer_mwait_c1_over_halt(c)) {
+	if (prefer_mwait_c1_over_halt()) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {


