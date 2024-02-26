Return-Path: <linux-kernel+bounces-82387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA42868395
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A21C22E18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE59132C29;
	Mon, 26 Feb 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1o14nUx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kgo1tvv4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF31CA91;
	Mon, 26 Feb 2024 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986272; cv=none; b=C4FtnJNMdAsFJ/KFeW8YQ4Xxpgwb+lZ5t1BddQTOsfZA7gBLObeWoaX5QXPTLwOk1dgKQqotgxGyjXhuwzgeN0tD2V+UEJxrYC+r/I3UGlGQj+o1wuLhPFhml6gronyoImwoblJATYKAG1glvUh7l83C3rkWHKWiAJgbNHs4C0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986272; c=relaxed/simple;
	bh=P+LSxAkJgCgUUp+ht2CL/CypOeU7CJvwZexFnnIv/fk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y/aMRhO+8aAo+wGJEiZJ6ekRNziik+TwJDiy5FSC7yjL/5zKhoE6EJEgETGRpOaEaaTFN5CC22Vtau82e/y4N5Vn6sEoQCH+a2CRcdRSdPlIbHfzgvMpUvg0YyX7wgLiisV/M+pURcDl6Gji78ALUwe1VNlNFmEmPvg9DHLCcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1o14nUx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kgo1tvv4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMPImZHQM5CM4wHeMA76ZPHOkb23MRJVX2X0h+q2bmA=;
	b=z1o14nUxJKOkAzWRYRxysLpAWzS0nyqTbQd8JNvyFRInvIrvogulXToTotAyMCKCPXIO41
	IcQQbnTa0susmze/cYct9WlkQZgBMqLm9Ky8JGq0gvjy9rdPianJ1wqm0ZKrsgRSV1oPqA
	XbFyMhtc+zheVgzcI8nFegbdlJZTMEAKVlzxz4Kcl0GZMa+u91fIRsGv+jitcwRPYNg5BV
	0n+tV/EXANEschFImSen+rHAq91M2Vwn6fIenJxbCQcyeOg4PtIrLG9/y0NTfTxXtnf+wz
	4lUoLi/2mGPoTb+bPu1KIs4WmZysASqm2qwVi+pYq1Gzj34yyNEP26UdlUtDvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMPImZHQM5CM4wHeMA76ZPHOkb23MRJVX2X0h+q2bmA=;
	b=Kgo1tvv4d8pEbz7jNbYdyM+cHJ2pCewooTRKTa5Xvg6RuUdQniQRuKkOTSc3rpIb8BmTjN
	zJ4j08Zl4QIJ23Cw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Assume timekeeping is correctly handed over
 upon last offline idle call
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-16-frederic@kernel.org>
References: <20240225225508.11587-16-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898626843.398.9239239187122557870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     500f8f9bced86f0c0f2482773bd64a1b7ec9c4e1
Gitweb:        https://git.kernel.org/tip/500f8f9bced86f0c0f2482773bd64a1b7ec9c4e1
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:32 +01:00

tick: Assume timekeeping is correctly handed over upon last offline idle call

The timekeeping duty is handed over from the outgoing CPU on stop
machine, then the oneshot tick is stopped right after.  Therefore it's
guaranteed that the current CPU isn't the timekeeper upon its last call
to idle.

Besides, calling tick_nohz_idle_stop_tick() while the dying CPU goes
into idle suggests that the tick is going to be stopped while it is
actually stopped already from the appropriate CPU hotplug state.

Remove the confusing call and the obsolete case handling and convert it
to a sanity check that verifies the above assumption.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-16-frederic@kernel.org

---
 include/linux/tick.h      |  2 ++
 kernel/cpu.c              |  1 +
 kernel/sched/idle.c       |  1 -
 kernel/time/tick-common.c |  4 ++++
 kernel/time/tick-sched.c  | 13 +------------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index c7840ae..44fddfa 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -29,8 +29,10 @@ static inline void tick_cleanup_dead_cpu(int cpu) { }
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
 extern int tick_cpu_dying(unsigned int cpu);
+extern void tick_assert_timekeeping_handover(void);
 #else
 #define tick_cpu_dying	NULL
+static inline void tick_assert_timekeeping_handover(void) { }
 #endif
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_SUSPEND)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5a8ad4f..7e84a7b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1399,6 +1399,7 @@ void cpuhp_report_idle_dead(void)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
+	tick_assert_timekeeping_handover();
 	rcutree_report_cpu_dead();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 3123192..b15d40c 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -291,7 +291,6 @@ static void do_idle(void)
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
-			tick_nohz_idle_stop_tick();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9cd09ee..fb0fdec 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -396,6 +396,10 @@ int tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
 
 #ifdef CONFIG_HOTPLUG_CPU
+void tick_assert_timekeeping_handover(void)
+{
+	WARN_ON_ONCE(tick_do_timer_cpu == smp_processor_id());
+}
 /*
  * Stop the tick and transfer the timekeeping job away from a dying cpu.
  */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 89d16b8..269e215 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1160,18 +1160,7 @@ static bool report_idle_softirq(void)
 
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
-	/*
-	 * If this CPU is offline and it is the one which updates
-	 * jiffies, then give up the assignment and let it be taken by
-	 * the CPU which runs the tick timer next. If we don't drop
-	 * this here, the jiffies might be stale and do_timer() never
-	 * gets invoked.
-	 */
-	if (unlikely(!cpu_online(cpu))) {
-		if (cpu == tick_do_timer_cpu)
-			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		return false;
-	}
+	WARN_ON_ONCE(cpu_is_offline(cpu));
 
 	if (unlikely(!tick_sched_flag_test(ts, TS_FLAG_NOHZ)))
 		return false;

