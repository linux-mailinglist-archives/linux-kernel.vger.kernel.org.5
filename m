Return-Path: <linux-kernel+bounces-76950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5A85FEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC6C1F2ACE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2515AABE;
	Thu, 22 Feb 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAuiKXhw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eV9qdCki"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21E1552F5;
	Thu, 22 Feb 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621941; cv=none; b=k2jP8/1SnN5gGSv1bHXfLWlJm4CEklutAcYqUgNZfHHFJW7789X+GKf+1U7uhngUJLHUWCihhlU0aibi964wpipl6UDZblLeO3OZxDwBS4g1Tk4znkqYVrxrdi+VE+HCqkJtci+I/yWpuHD7i1lZ47tKobAfh70RRNkrMIGgoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621941; c=relaxed/simple;
	bh=8RiqyfTthNO4dHUPh4yYO93S+rAFUXnT2V1YGoNbKq4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Voj6YGaes7io+uGH747H8tD02IwRsqHUlAoHY1Bx4t1NHTxVySobFlfj3u/gS29RbmYlAy9ae6C8MUJzqWyuoaqT/eZpi9DDiEe0GtMCk07n49y2S1Q4hS23+ddikw0CTyQEZJkOIVjyYrRBjhUhW2VJqQscNYRPXNkiT5UKXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAuiKXhw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eV9qdCki; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EMfCaOfLWU04yhiPFpzKkW87yYPSJP7CduXzPHCoTM=;
	b=SAuiKXhwlXp2O+zbJeDBmlmHAfJE050MHuklNMnluEsu7Rgs6uqf+iqHB0TufSSPD/10KP
	Qk/g4VNcGJgOu/knD+n6H7Xokzr50tNhuwgYqIdtma0PdLE6f8KQ4UO1/k2tJpbZ7meZ+D
	R7pDw2AqssV39SowKtN+QNuSDtru08AbRWkUtE5V1iTvLLOnku2m6FixlScB8rCUzhbLdy
	diq/XxGPWWoUNdSrPohIZLs3HLbrrBUzy5k7PyTiWFfectjFWP4/9bYb4/OsIn0UmHzasD
	rwo4c/aq8BuGCM3Z+XqJLP8XGV27alNo5mgK/wyNMbDqVobCbuXSgo/rJpjATg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EMfCaOfLWU04yhiPFpzKkW87yYPSJP7CduXzPHCoTM=;
	b=eV9qdCkiTvHowrbX6VtdT53z0SbwZJJzOWvL3uUxlRrAox4w+74Um0eNHdW/eG41zSu0bP
	aX/S85gn38JKo/Bw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-4-anna-maria@linutronix.de>
References: <20240221090548.36600-4-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193597.398.11739577160319960761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e2e1d724e948c87a31c18c34c6b6a193a9b2a0f0
Gitweb:        https://git.kernel.org/tip/e2e1d724e948c87a31c18c34c6b6a193a9b2a0f0
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:30 +01:00

timers: Move marking timer bases idle into tick_nohz_stop_tick()

The timer base is marked idle when get_next_timer_interrupt() is
executed. But the decision whether the tick will be stopped and whether the
system is able to go idle is done later. When the timer bases is marked
idle and a new first timer is enqueued remote an IPI is raised. Even if it
is not required because the tick is not stopped and the timer base is
evaluated again at the next tick.

To prevent this, the timer base is marked idle in tick_nohz_stop_tick() and
get_next_timer_interrupt() is streamlined by only looking for the next timer
interrupt. All other work is postponed to timer_base_try_to_set_idle() which is
called by tick_nohz_stop_tick(). timer_base_try_to_set_idle() never resets
timer_base::is_idle state. This is done when the tick is restarted via
tick_nohz_restart_sched_tick().

With this, tick_sched::tick_stopped and timer_base::is_idle are always in
sync. So there is no longer the need to execute timer_clear_idle() in
tick_nohz_idle_retain_tick(). This was required before, as
tick_nohz_next_event() set timer_base::is_idle even if the tick would not be
stopped. So timer_clear_idle() is only executed, when timer base is idle. So the
check whether timer base is idle, is now no longer required as well.

While at it fix some nearby whitespace damage as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-4-anna-maria@linutronix.de

---
 kernel/time/tick-internal.h |  1 +-
 kernel/time/tick-sched.c    | 40 ++++++++++++++++--------
 kernel/time/timer.c         | 60 +++++++++++++++++++++++++-----------
 3 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 481b7ab..47df30b 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -163,6 +163,7 @@ static inline void timers_update_nohz(void) { }
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7c9efe3..344b904 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -860,11 +860,6 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	delta = next_tick - basemono;
 	if (delta <= (u64)TICK_NSEC) {
 		/*
-		 * Tell the timer code that the base is not idle, i.e. undo
-		 * the effect of get_next_timer_interrupt():
-		 */
-		timer_clear_idle();
-		/*
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
 		 */
@@ -899,13 +894,39 @@ out:
 static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	u64 expires = ts->timer_expires;
+	bool timer_idle;
+	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base = 0;
 
 	/*
+	 * Now the tick should be stopped definitely - so the timer base needs
+	 * to be marked idle as well to not miss a newly queued timer.
+	 */
+	expires = timer_base_try_to_set_idle(basejiff, basemono, &timer_idle);
+	if (expires > ts->timer_expires) {
+		/*
+		 * This path could only happen when the first timer was removed
+		 * between calculating the possible sleep length and now (when
+		 * high resolution mode is not active, timer could also be a
+		 * hrtimer).
+		 *
+		 * We have to stick to the original calculated expiry value to
+		 * not stop the tick for too long with a shallow C-state (which
+		 * was programmed by cpuidle because of an early next expiration
+		 * value).
+		 */
+		expires = ts->timer_expires;
+	}
+
+	/* If the timer base is not idle, retain the not yet stopped tick. */
+	if (!timer_idle)
+		return;
+
+	/*
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs
 	 * the tick timer next, which might be this CPU as well. If we
@@ -1001,7 +1022,7 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	touch_softlockup_watchdog_sched();
 
 	/* Cancel the scheduled timer and restore the tick: */
-	ts->tick_stopped  = 0;
+	ts->tick_stopped = 0;
 	tick_nohz_restart(ts, now);
 }
 
@@ -1157,11 +1178,6 @@ void tick_nohz_idle_stop_tick(void)
 void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
-	/*
-	 * Undo the effect of get_next_timer_interrupt() called from
-	 * tick_nohz_next_event().
-	 */
-	timer_clear_idle();
 }
 
 /**
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9f0cdba..a4b8a58 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1956,19 +1956,22 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
-	bool was_idle;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
 	 * Possible pending timers will be migrated later to an active cpu.
 	 */
-	if (cpu_is_offline(smp_processor_id()))
+	if (cpu_is_offline(smp_processor_id())) {
+		if (idle)
+			*idle = true;
 		return expires;
+	}
 
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
@@ -1998,17 +2001,26 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
 	__forward_timer_base(base, basej);
 
 	/*
-	 * Base is idle if the next event is more than a tick away.
-	 *
-	 * If the base is marked idle then any timer add operation must forward
-	 * the base clk itself to keep granularity small. This idle logic is
-	 * only maintained for the BASE_STD base, deferrable timers may still
-	 * see large granularity skew (by design).
+	 * Set base->is_idle only when caller is timer_base_try_to_set_idle()
 	 */
-	was_idle = base->is_idle;
-	base->is_idle = time_after(nextevt, basej + 1);
-	if (was_idle != base->is_idle)
-		trace_timer_base_idle(base->is_idle, base->cpu);
+	if (idle) {
+		/*
+		 * Base is idle if the next event is more than a tick away.
+		 *
+		 * If the base is marked idle then any timer add operation must
+		 * forward the base clk itself to keep granularity small. This
+		 * idle logic is only maintained for the BASE_STD base,
+		 * deferrable timers may still see large granularity skew (by
+		 * design).
+		 */
+		if (!base->is_idle) {
+			if (time_after(nextevt, basej + 1)) {
+				base->is_idle = true;
+				trace_timer_base_idle(true, base->cpu);
+			}
+		}
+		*idle = base->is_idle;
+	}
 
 	raw_spin_unlock(&base->lock);
 
@@ -2025,7 +2037,21 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
-	return __get_next_timer_interrupt(basej, basem);
+	return __get_next_timer_interrupt(basej, basem, NULL);
+}
+
+/**
+ * timer_base_try_to_set_idle() - Try to set the idle state of the timer bases
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @idle:	pointer to store the value of timer_base->is_idle
+ *
+ * Returns the tick aligned clock monotonic time of the next pending
+ * timer or KTIME_MAX if no timer is pending.
+ */
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
+{
+	return __get_next_timer_interrupt(basej, basem, idle);
 }
 
 /**
@@ -2043,10 +2069,8 @@ void timer_clear_idle(void)
 	 * sending the IPI a few instructions smaller for the cost of taking
 	 * the lock in the exit from idle path.
 	 */
-	if (base->is_idle) {
-		base->is_idle = false;
-		trace_timer_base_idle(false, smp_processor_id());
-	}
+	base->is_idle = false;
+	trace_timer_base_idle(false, smp_processor_id());
 }
 #endif
 

