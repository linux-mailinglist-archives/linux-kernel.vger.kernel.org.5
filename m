Return-Path: <linux-kernel+bounces-86832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1953486CB67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23DF2867B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A9137751;
	Thu, 29 Feb 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUrN2S+N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6geCrle"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CF7D077
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216624; cv=none; b=u2N86rTEDh6deHKnKCWUcu9vYyxCY2D2BglAJWtDN1pST7LuAxXDDhZ6PPbYNZd1tq2jUBtx+JxTykqyBAtXjfA4g0Tuyf0OBQwsE6Gpv3MdJwn7zXuK/Lu+hp8prWzAdEb24llmzzipeTOi4G2gBFMhaETJqXvwlfAif+3SBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216624; c=relaxed/simple;
	bh=55zY29d/udGnwxmlXArsqLI2//BoHZlNbwI2T6gnHa0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=annw+5e0rw77gkcX2Qu4iEgLWN5tHVO7A+QLcZmiFv0swBa1YeTRNwSKtwAzMeM4yI+hmmcO597iNKCA8FeBXutQIp52XVJXbOUIJomLXe7y+ivefGwMMWu6BybhcEKdWXqlr3H/o9iOT22Vwj28rouSuSECbmWqOpWv88z1osE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUrN2S+N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6geCrle; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240229142248.266708822@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709216616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B2ejJz0qvL4jeeFT2KaF7scEKPWGORNFA2dKFt8UgLE=;
	b=iUrN2S+NTli3nENJPs7zEEU6lAsSJdtgYDc9lkZY1OomCHRMd5yh9HonHdSUuiwipCe4Kd
	nnurYBBpb+Ff8kinKlHG6fRpD5tL5mXJTnfucuq5OyE4plz2w0MDBAmFG5rcx0QoXxJ2ZO
	Jz8iWrpcoj6JXY3uup34p3yiV4NVu5AS1hS64XQQSOERqVUzJWnXtuGgHHydMXciEaesvL
	48F+5JgFMeYNI/HOzJEpXp40kMlHqHK17iMxUhZKA+7r4M1gMvuUYwNrxgWjzc10Ui9Q/d
	oK0DOJykitjbhZN8kwpmHlWBaDahVnLr43T75mUDr+ZIcbtVCjrdxSgajV9LLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709216616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B2ejJz0qvL4jeeFT2KaF7scEKPWGORNFA2dKFt8UgLE=;
	b=C6geCrlePlpAOvHxrTnAQXKX1fJbKeUGszlgICNxUaOo2FBTakEpwqjJOlsFPOeIA/2PV6
	tgwCv0qEhBzHBqAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Borislav Petkov <bp@alien8.de>
Subject: [patch 1/6] sched/idle: Conditionally handle tick broadcast in
 default_idle_call()
References: <20240229141407.283316443@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 15:23:36 +0100 (CET)

X86 has a idle routine for AMD CPUs which are affected by erratum 400. On
the affected CPUs the local APIC timer stops in the C1E halt state. It
therefore requires tick broadcasting. The invocation of
tick_broadcast_enter()/exit() from this function violates the RCU
constraints because it can end up in lockdep or tracing, which rightfully
triggers a warning.

tick_broadcast_enter()/exit() must be invoked before ct_cpuidle_enter() and
after ct_cpuidle_exit() in default_idle_call().

Add a static branch conditional invocation of tick_broadcast_enter()/exit()
into this function to allow X86 to replace the AMD specific idle code. It's
guarded by a config switch which will be selected by X86. Otherwise it's a
NOOP.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpu.h  |    2 ++
 include/linux/tick.h |    3 +++
 kernel/sched/idle.c  |   21 +++++++++++++++++++++
 kernel/time/Kconfig  |    5 +++++
 4 files changed, 31 insertions(+)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -196,6 +196,8 @@ void arch_cpu_idle(void);
 void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
+void arch_tick_broadcast_enter(void);
+void arch_tick_broadcast_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
 
 #ifdef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -12,6 +12,7 @@
 #include <linux/cpumask.h>
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
+#include <linux/static_key.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -69,6 +70,8 @@ extern void tick_broadcast_control(enum
 static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
 #endif /* BROADCAST */
 
+extern struct static_key_false arch_needs_tick_broadcast;
+
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
 extern void tick_offline_cpu(unsigned int cpu);
 #else
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -81,6 +81,25 @@ void __weak arch_cpu_idle(void)
 	cpu_idle_force_poll = 1;
 }
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE
+DEFINE_STATIC_KEY_FALSE(arch_needs_tick_broadcast);
+
+static inline void cond_tick_broadcast_enter(void)
+{
+	if (static_branch_unlikely(&arch_needs_tick_broadcast))
+		tick_broadcast_enter();
+}
+
+static inline void cond_tick_broadcast_exit(void)
+{
+	if (static_branch_unlikely(&arch_needs_tick_broadcast))
+		tick_broadcast_exit();
+}
+#else
+static inline void cond_tick_broadcast_enter(void) { }
+static inline void cond_tick_broadcast_exit(void) { }
+#endif
+
 /**
  * default_idle_call - Default CPU idle routine.
  *
@@ -90,6 +109,7 @@ void __cpuidle default_idle_call(void)
 {
 	instrumentation_begin();
 	if (!current_clr_polling_and_test()) {
+		cond_tick_broadcast_enter();
 		trace_cpu_idle(1, smp_processor_id());
 		stop_critical_timings();
 
@@ -99,6 +119,7 @@ void __cpuidle default_idle_call(void)
 
 		start_critical_timings();
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+		cond_tick_broadcast_exit();
 	}
 	local_irq_enable();
 	instrumentation_end();
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -39,6 +39,11 @@ config GENERIC_CLOCKEVENTS_BROADCAST
 	bool
 	depends on GENERIC_CLOCKEVENTS
 
+# Handle broadcast in default_idle_call()
+config GENERIC_CLOCKEVENTS_BROADCAST_IDLE
+	bool
+	depends on GENERIC_CLOCKEVENTS_BROADCAST
+
 # Automatically adjust the min. reprogramming time for
 # clock event device
 config GENERIC_CLOCKEVENTS_MIN_ADJUST


