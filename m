Return-Path: <linux-kernel+bounces-74348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CA085D308
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C395284D53
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884803D54C;
	Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLzoLg/K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8390MXB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CB3D0A8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506377; cv=none; b=M6s/vaWTd3tMdJpfWwW5zk0j/l7fiYg5c1eAJ4HsUtS77pJ0UO6/lwjoxMiMC0T/TZyQqgik3I3+3YcuoHH4mr7pa4wLeKXDKuEuXBiGdHI5PbtEv2WOZmPj8xtpJUfctYzQuz9/dAYqYFvdU6kd4ROoSeMN2ZSc9pc+ENg1GHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506377; c=relaxed/simple;
	bh=CoA1DalDvnRQocmU4jzgfw8sIMWdry+4nJS7Y4YZlxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCg4FDuNflX+8PuNM8uQi4o1CmCbeZvFf6Kum5Ka4rbYhpG48CfUYSnUHMMVvRYV61LT8Crch22cFj7mbcQZdmpF1S++eF0KACVWE418bCSRkbkriL0vvRGPGBZN+dbO1mSFz7/k++7AoXTbhSnRsWr/VGiFJbldEPqicyJnB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zLzoLg/K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8390MXB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iSI+fFKaZsEg09o5KpmvrClYbUXst2Mqatycuvus4k=;
	b=zLzoLg/KycHu4YwafMTB2UkhepnmxPhFEU0uvY1lWf8jpdoy6UySKiPgFxdEXhhJyViXIR
	PB8hl7FeSq9WxklOnxHR/+BACLJzfs8g8+nxhQYy2wrEPKoH1ge42WqOjDn6spxEyL3e4l
	vo4u8bGCQ+DRrkWFFatweSp9SwBmfZLHT2ugP7UT7VpY9bLxna9DYqI1t3AE8RfWMHtXtx
	EIPlwIaF2Plcs48a8WMgJUNwpGalHLtVnqK0Yt3lQ0cTahTQMTDi/bx26/+xAzKQaa6nWt
	1AR0HJ/IvlCNDFEAncM+TGpzsEgMhR5Oh4YzbRW/6/nsNcuyVCOHoIp5yEX6jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iSI+fFKaZsEg09o5KpmvrClYbUXst2Mqatycuvus4k=;
	b=p8390MXBavD7rE72Y1+1cYUD60wfPt3atraITeLJ8nqT60CdwQ7jv4UO+MkjTnN9sOF3B8
	caUJh94Hgq0/yOCw==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v11 03/20] timers: Move marking timer bases idle into tick_nohz_stop_tick()
Date: Wed, 21 Feb 2024 10:05:31 +0100
Message-Id: <20240221090548.36600-4-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v11:
 - early return in tick_nohz_stop_tick() when timer base is not idle

v10a:
 - Drop the unnecessary if branch which handles return value of
   timer_base_try_to_set_idle()
 - Do not open code 'tick_nohz_retain_tick()' and keep
   tick_nohz_idle_retain_tick() as is.
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 40 +++++++++++++++++--------
 kernel/time/timer.c         | 60 ++++++++++++++++++++++++++-----------
 3 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 481b7ab65e2c..47df30b871e4 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -163,6 +163,7 @@ static inline void timers_update_nohz(void) { }
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 01fb50c1b17e..72c80f6e7bed 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -849,11 +849,6 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 */
 	delta = next_tick - basemono;
 	if (delta <= (u64)TICK_NSEC) {
-		/*
-		 * Tell the timer code that the base is not idle, i.e. undo
-		 * the effect of get_next_timer_interrupt():
-		 */
-		timer_clear_idle();
 		/*
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
@@ -889,12 +884,38 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
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
 
+	/*
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
 	/*
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs
@@ -991,7 +1012,7 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	touch_softlockup_watchdog_sched();
 
 	/* Cancel the scheduled timer and restore the tick: */
-	ts->tick_stopped  = 0;
+	ts->tick_stopped = 0;
 	tick_nohz_restart(ts, now);
 }
 
@@ -1147,11 +1168,6 @@ void tick_nohz_idle_stop_tick(void)
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
index 2aea55d53416..3a668060692e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1911,19 +1911,22 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
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
@@ -1953,17 +1956,26 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
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
 
@@ -1980,7 +1992,21 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
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
@@ -1998,10 +2024,8 @@ void timer_clear_idle(void)
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
 
-- 
2.39.2


