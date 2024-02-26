Return-Path: <linux-kernel+bounces-82395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C38683A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE4D1C22C54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172201350F7;
	Mon, 26 Feb 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38xFmnrO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EWyAQEGK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5041339B4;
	Mon, 26 Feb 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986280; cv=none; b=bdjTP1d7tr3BP8bq5/mpC/BYz7NlAmkxJL+ZM/RV10k/4TCBRZXymNG3Yzx+DkHWDjI0LgtsqVj6IbGUpM3sJH5880sbQIYW/t6ja2/NB2NiJOFO/+3chOHtTDa/NBjgb+dMPAlRJ+v9g0KIglPmbe1zFcTQGaTcLononqBFVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986280; c=relaxed/simple;
	bh=s07hb8EJQ1tDnTq94R6R5PSxA06ga9giK3TfHeUT4g8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I0WeS41fzygl6Pv5DIkl+jSbg6eRk/Q8AyLZIMb8Tiz27Ti24q0WgDUU7ZDBYu+bHv0mw00n+cI/71OtkxLcbXDCP1FnZ2RskyLeSarvnNCAVsglOkghyMDgTL3cWJf0pmLifYBRdlndsw4fJd3A9ZCzrUaFiMNoehZBIGb2QR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=38xFmnrO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EWyAQEGK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMCPD9dqdwmuJQjsibfihMTK9e103CemTaNMfc1aWWw=;
	b=38xFmnrOhnbSWRCgLPgKg3UpP0urMGSO36luMqzrGRi7ZgYBiHetkzUk4Nw4jQcLi2DbI2
	EgocbUqRoIaRtbxzY7WbdzbywgO8ab4IEbJ5nkN2x5GkCDXPFmzycb2PwNGiJOJXU01pJD
	2odYl84Kq7PjbWu1vHef1nSPLcg/SyOhZSrtd8mp/WdAWDl5WsUB3VD6tLIqv9puOxKggK
	VmK4JQl9ZIpocIy/aUn6n/TCHtk1x2JGft3r4K5+bSMpZ3uXN0yW2cst4QAHDkn6O8XyCa
	co/IzCLUGExLi9diP24ZlIXeGar3mycsGyieiixmIXnwMZAgrgRVB4QQ81ezKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMCPD9dqdwmuJQjsibfihMTK9e103CemTaNMfc1aWWw=;
	b=EWyAQEGKBLoKks3X4lS0F3jWwJ0NQYbHOMF58Dew609ax72W9UMH4NyffShLeXCC8to/c0
	DOHNQoLS2+G5YWAA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Start centralizing tick related CPU hotplug
 operations
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-8-frederic@kernel.org>
References: <20240225225508.11587-8-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627577.398.14467061840941409576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3ad6eb0683a1edbb4bb117b85d61f17a879155a1
Gitweb:        https://git.kernel.org/tip/3ad6eb0683a1edbb4bb117b85d61f17a879155a1
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:54:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:31 +01:00

tick: Start centralizing tick related CPU hotplug operations

During the CPU offlining process, the various timer tick features are
shut down from scattered places, sometimes from teardown callbacks on
stop machine, sometimes through explicit calls, sometimes from the
control CPU after the CPU died. The reason why these shutdown operations
are spread around is not always clear and it makes the tick lifecycle
hard to follow.

The tick should be shut down in order from highest to lowest level:

On stop machine from the dying CPU (high-level):

 1) Hand-over the timekeeping duty (tick_handover_do_timer())
 2) Cancel the tick implementation called by the clockevent callback
    (tick_cancel_sched_timer())
 3) Shutdown broadcasting (tick_offline_cpu() / tick_broadcast_offline())

On stop machine from the dying CPU (low-level):

 4) Shutdown clockevents drivers (CPUHP_AP_*_TIMER_STARTING states)

>From the control CPU after the CPU died (low-level):

 5) Shutdown/unregister/cleanup clockevents for the dead CPU
    (tick_cleanup_dead_cpu())

Instead the current order is 2, 4 (both from CPU hotplug states), then
1 and 3 through direct calls. This layout and order don't make much
sense. The operations 1, 2, 3 should be gathered together and in order.

Sort this situation with creating a new TICK shut-down CPU hotplug state
and start with introducing the timekeeping duty hand-over there. The
state must precede hrtimers migration because the tick hrtimer will be
stopped from it in a further patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-8-frederic@kernel.org

---
 include/linux/cpuhotplug.h |  1 +
 include/linux/tick.h       |  8 ++++++--
 kernel/cpu.c               |  8 +++++---
 kernel/time/tick-common.c  | 17 +++++++++++------
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7651904..35e78dd 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -184,6 +184,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
 	CPUHP_AP_HRTIMERS_DYING,
+	CPUHP_AP_TICK_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 716d17f..afff4c2 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -19,16 +19,20 @@ extern void __init tick_init(void);
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it */
 extern void tick_resume_local(void);
-extern void tick_handover_do_timer(void);
 extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
-static inline void tick_handover_do_timer(void) { }
 static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
+#if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
+extern int tick_cpu_dying(unsigned int cpu);
+#else
+#define tick_cpu_dying	NULL
+#endif
+
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_SUSPEND)
 extern void tick_freeze(void);
 extern void tick_unfreeze(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba..2635080 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1324,8 +1324,6 @@ static int take_cpu_down(void *_param)
 	 */
 	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
 
-	/* Give up timekeeping duties */
-	tick_handover_do_timer();
 	/* Remove CPU from timer broadcasting */
 	tick_offline_cpu(cpu);
 	/* Park the stopper thread */
@@ -2205,7 +2203,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= NULL,
 		.teardown.single	= hrtimers_cpu_dying,
 	},
-
+	[CPUHP_AP_TICK_DYING] = {
+		.name			= "tick:dying",
+		.startup.single		= NULL,
+		.teardown.single	= tick_cpu_dying,
+	},
 	/* Entry state on starting. Interrupts enabled from here on. Transient
 	 * state for synchronsization */
 	[CPUHP_AP_ONLINE] = {
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 0084e1a..a89ef45 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -397,15 +397,20 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * Transfer the do_timer job away from a dying cpu.
- *
- * Called with interrupts disabled. No locking required. If
- * tick_do_timer_cpu is owned by this cpu, nothing can change it.
+ * Stop the tick and transfer the timekeeping job away from a dying cpu.
  */
-void tick_handover_do_timer(void)
+int tick_cpu_dying(unsigned int dying_cpu)
 {
-	if (tick_do_timer_cpu == smp_processor_id())
+	/*
+	 * If the current CPU is the timekeeper, it's the only one that
+	 * can safely hand over its duty. Also all online CPUs are in
+	 * stop machine, guaranteed not to be idle, therefore it's safe
+	 * to pick any online successor.
+	 */
+	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
+
+	return 0;
 }
 
 /*

