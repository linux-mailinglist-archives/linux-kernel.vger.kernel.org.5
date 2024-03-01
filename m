Return-Path: <linux-kernel+bounces-89119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46E86EAAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD831C224AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9457339;
	Fri,  1 Mar 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RYOkz7na";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V15rvaRy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1245677D;
	Fri,  1 Mar 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326132; cv=none; b=SP0XJeuP3p+E4UFOthz9SwRNj2Vxj+mOxUbk0xfPYpS/pMADixsvXFqXnLmI69q1Ok73o/pbQFqY3ZCNHpepYtjtdXIPFT2HhAkqho1HaDRoTaZyN1z9MC/VE+oQdChHaIjhqz5lPLvh5Bk4x3hS6YSZla5YQLQBFjlPBE6Y7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326132; c=relaxed/simple;
	bh=uWRm6FypxzuMowZAb+KZ/jYkR8Es7SsJhDyzTySJz00=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jymnir0cbaFCWIp6P2Qmash+r5uKS65pNVIyMDilgwWdc3c5K1fsPr4qlqrVECIMgDTm452cDeeVvtc40Cv0hyfa2e1sRAxaEqOpbtPe0JIGSZdoVgnN7cO1PDZU5UBKbKiS/3MCijn7yuscpoaxaTJ1JEwQFUq/BuUm2NLAIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RYOkz7na; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V15rvaRy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 20:48:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709326125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RFjx8lKgfOm+reSQPZfz1E/sYmOeDydFknRFjC+ChM=;
	b=RYOkz7na/O+4dgCzTIr1tyrWhA3qEzl/m6sAQo6TxQOGq+R6AwGNqdElLYQS1a4Oiety26
	dWuDDJKweQuM4lSP93JUKU3pcZp1GZiDlxoq4E7HObIiHpG/khGODZoABr7Z3RNolwimKs
	lU3tqKwSVkfo2w3VeBGrHCupJ6bukCE1vuXjSzymwJsfFKN2zLot8jjw2qNMinl8r7soms
	Yt02qNDf5vgYtmVnWc9KFrQaI9q+ihKBmO0V4gpx3GHAlFvjmyo1Qnc9ukD0iA75upf737
	JY0nGYAtDP4PAGd8CHW/KOhdZSdkGwOyTKV/65veMejbD8+cjI8TYujoO/jxAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709326125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RFjx8lKgfOm+reSQPZfz1E/sYmOeDydFknRFjC+ChM=;
	b=V15rvaRyBJSVRnSI1+CPAr37vxfWtcbzfABh0iz8uNKTxoUOidLzLeGAgMdcuXk8MVrLwI
	LH00zHOf6zY+yyDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] sched/idle: Conditionally handle tick broadcast in
 default_idle_call()
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240229142248.266708822@linutronix.de>
References: <20240229142248.266708822@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170932612462.398.15833470158375898227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2be2a197ff6c3a659ab9285e1d88cbdc609ac6de
Gitweb:        https://git.kernel.org/tip/2be2a197ff6c3a659ab9285e1d88cbdc609ac6de
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Feb 2024 15:23:36 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Mar 2024 21:04:27 +01:00

sched/idle: Conditionally handle tick broadcast in default_idle_call()

The x86 architecture has an idle routine for AMD CPUs which are affected
by erratum 400. On the affected CPUs the local APIC timer stops in the
C1E halt state.

It therefore requires tick broadcasting. The invocation of
tick_broadcast_enter()/exit() from this function violates the RCU
constraints because it can end up in lockdep or tracing, which
rightfully triggers a warning.

tick_broadcast_enter()/exit() must be invoked before ct_cpuidle_enter()
and after ct_cpuidle_exit() in default_idle_call().

Add a static branch conditional invocation of tick_broadcast_enter()/exit()
into this function to allow X86 to replace the AMD specific idle code. It's
guarded by a config switch which will be selected by x86. Otherwise it's
a NOOP.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240229142248.266708822@linutronix.de
---
 include/linux/cpu.h  |  2 ++
 include/linux/tick.h |  3 +++
 kernel/sched/idle.c  | 21 +++++++++++++++++++++
 kernel/time/Kconfig  |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dcb89c9..715017d 100644
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
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 716d17f..e134f28 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -12,6 +12,7 @@
 #include <linux/cpumask.h>
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
+#include <linux/static_key.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -63,6 +64,8 @@ enum tick_broadcast_state {
 	TICK_BROADCAST_ENTER,
 };
 
+extern struct static_key_false arch_needs_tick_broadcast;
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 extern void tick_broadcast_control(enum tick_broadcast_mode mode);
 #else
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 3123192..31ad811 100644
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
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index bae8f11..fc3b1a0 100644
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

