Return-Path: <linux-kernel+bounces-82398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B444C8683AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6719F285408
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B5135A71;
	Mon, 26 Feb 2024 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+0elAe9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jgn70aLo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE021350F5;
	Mon, 26 Feb 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986282; cv=none; b=uTnGKBJ5uCMyA/Bhr0OwuPzZ4O45lZ4hiE5rXcPXoHtDNZMxqM+foLyebQcsOiRMK8V76OcuW4o1u68eUYKkZdqDk6HdxNc3AedgfFq27+uW73JEeqo9URhUkle/09We+kgsleZJcWWkMXkoLC4K+BZD+2BUL/PwZhh3+ZjMrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986282; c=relaxed/simple;
	bh=wTaaRj1rbh/Mk8J8wQVl6oDSBEOHpaHf3SCdmAOD5nA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WW6PorTKn9PArdxdtPlOsUKaVazSvSgkwdXIOpkrZnELY9Vd+yvRmDAu2QtvNqpB/xss4TpsrlxiDIy7HsM9rK0IbNXKSbIEV4mA+y3OtrVuxBIwZh5ehGydjQ6KSHni4DDXiYOJs6sO/DGCzvYy0o7sfMXhZeQ8ZdBG/cBVLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+0elAe9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jgn70aLo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ksKHz87bIRtJ74lNIDMAofe9tFtsWBRzXLz/ox7z8c=;
	b=c+0elAe9cp8q/9qhNBkDslIiilbMsYC98HCZI4yG9soF0JYpAqWyZjGRPge8DkhV3+tI5Z
	Fo91TaE+EbHUveM1IpbBXYoGXfba2088I87kD4hJpbNKTbdlyKiNWSTmJs8coHBJRzeQzb
	NoP1wSJmETytBbutDlWCV4X0RtAbFGeH56Gx1QvlrdrxV+9R2whDyrEn41a6yDOEbEKTPX
	DGB8sbjnpd/1T3uA4Z9MH8dfRWvMzL288W4qicDQpZlUnFzXhR9nsQIuUP9WdnMEcU311k
	zH7CTrWelzSP6s+y3+kXWHGXh9EG6FHwedS6hfW6rJ+G5lFVAcRjnU+6XdoH6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ksKHz87bIRtJ74lNIDMAofe9tFtsWBRzXLz/ox7z8c=;
	b=jgn70aLo2XcrWO9U9s2G6I20YTPzrCjV2UwiDNu9mQgkcrrdo6F9RYPIRl3xV8e7wB3BUB
	ob9tthCsYze9idAA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Use IS_ENABLED() whenever possible
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-5-frederic@kernel.org>
References: <20240225225508.11587-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627844.398.16307853897539009522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     27dc08096ce498ec8b87fb12ce4b9932c8111898
Gitweb:        https://git.kernel.org/tip/27dc08096ce498ec8b87fb12ce4b9932c8111898
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:54:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:31 +01:00

tick: Use IS_ENABLED() whenever possible

Avoid ifdeferry if it can be converted to IS_ENABLED() whenever possible

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-5-frederic@kernel.org

---
 kernel/time/tick-common.c |  4 +---
 kernel/time/tick-sched.c  | 14 +++++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e9138cd..0084e1a 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -111,15 +111,13 @@ void tick_handle_periodic(struct clock_event_device *dev)
 
 	tick_periodic(cpu);
 
-#if defined(CONFIG_HIGH_RES_TIMERS) || defined(CONFIG_NO_HZ_COMMON)
 	/*
 	 * The cpu might have transitioned to HIGHRES or NOHZ mode via
 	 * update_process_times() -> run_local_timers() ->
 	 * hrtimer_run_queues().
 	 */
-	if (dev->event_handler != tick_handle_periodic)
+	if (IS_ENABLED(CONFIG_TICK_ONESHOT) && dev->event_handler != tick_handle_periodic)
 		return;
-#endif
 
 	if (!clockevent_state_oneshot(dev))
 		return;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 27aaecb..4e34967 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -186,7 +186,6 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
 
-#ifdef CONFIG_NO_HZ_COMMON
 	/*
 	 * Check if the do_timer duty was dropped. We don't care about
 	 * concurrency: This happens only when the CPU in charge went
@@ -197,13 +196,13 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * If nohz_full is enabled, this should not happen because the
 	 * 'tick_do_timer_cpu' CPU never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
+	    unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
 		tick_do_timer_cpu = cpu;
 	}
-#endif
 
 	/* Check if jiffies need an update */
 	if (tick_do_timer_cpu == cpu)
@@ -230,7 +229,6 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 
 static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 {
-#ifdef CONFIG_NO_HZ_COMMON
 	/*
 	 * When we are idle and the tick is stopped, we have to touch
 	 * the watchdog as we might not schedule for a really long
@@ -239,7 +237,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	 * idle" jiffy stamp so the idle accounting adjustment we do
 	 * when we go busy again does not account too many ticks.
 	 */
-	if (ts->tick_stopped) {
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && ts->tick_stopped) {
 		touch_softlockup_watchdog_sched();
 		if (is_idle_task(current))
 			ts->idle_jiffies++;
@@ -250,7 +248,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 		 */
 		ts->next_tick = 0;
 	}
-#endif
+
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
@@ -1587,10 +1585,8 @@ void tick_cancel_sched_timer(int cpu)
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
-# ifdef CONFIG_HIGH_RES_TIMERS
-	if (ts->sched_timer.base)
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
-# endif
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;

