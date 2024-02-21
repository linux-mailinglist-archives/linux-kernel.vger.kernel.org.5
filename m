Return-Path: <linux-kernel+bounces-74355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56BE85D310
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79492284FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94443F9E1;
	Wed, 21 Feb 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhJCVGIR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzezfTvZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23173D555
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506380; cv=none; b=gFk546+GjgDhdkBqnRqhm17ovgf1AUJASbcngun9wuirXY1xjxlgWFTo8tR4p6xcON70+c7GYVxsVyqaD+3935bTPkarIMsZH0WQNwmJLHF8hfti9riE7XDqmQw5t0v7AT981276Jo6OxA0QfYbTy4hPNdvlTOSR+yoPdVJuBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506380; c=relaxed/simple;
	bh=NKQqux4Wr2JtrfLkCkoLP8yZaKcp+XfdbugCAa+8pIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fgi1smnfAixYA65yMI0EFvOeHkDm8h8MPD46j6vxVXeSOzSdnKBGjEWB72KctKngVIhCpueH64I74qms00e63b32iijYYG5iL9xao/AaMEC6i1xSJs1H+Q0oD0puL0VJo7Pygp7fVyHrJZTIGm5t2gCnKshVmcaC6F9S95ryLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhJCVGIR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzezfTvZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQOeVJJgEWbHRW0ZjUOmxv5PwcZZzcUZxTpzkcXB+IU=;
	b=bhJCVGIRnZW5nAb+MFHLSIXlvn8q2m7FJaOZLtBWZMNfNwFPIiYDIJKJqTKXk6mSGiiG2i
	9JWochTRL81HVTQQ1BZLtr0RVgG8kk2D/pJx5eWjFMMChce0FXBxYcpBbge1KxVqAhYif2
	k/0qGm1eGbmph+yFsfz10pk3nf9RTbLdfbLp6CTGdTGizr720SnFShAg3nyqa2kIlStZGf
	ahYQkRnuKsyOuS6vo44TMUQ3P++puSNRVhedU5mV0Z7n7NoorcZOlvkY2KSASgT7DN8PCr
	F9WogggMSm8/1Uvzqsr3qP8IAssQL7p+WlqL21OR4W9+mrsynu9Rtlc4r86kZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQOeVJJgEWbHRW0ZjUOmxv5PwcZZzcUZxTpzkcXB+IU=;
	b=vzezfTvZ41R9PIB5ATY7KiiCPyXomXAqaa8iw9Ah00ue7GuKChysnRLHA/f++2b8iavEOB
	9RyGtvtQ9fkUSEAw==
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
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v11 10/20] timers: Keep the pinned timers separate from the others
Date: Wed, 21 Feb 2024 10:05:38 +0100
Message-Id: <20240221090548.36600-11-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the storage space for pinned timers. Deferrable timers (doesn't
matter if pinned or non pinned) are still enqueued into their own base.

This is preparatory work for changing the NOHZ timer placement from a push
at enqueue time to a pull at expiry time model.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10:
  - Simplify local_first check in __get_next_timer_interrupt() due to
    updated next_expiry values of empty timer bases

v9:
  - Update was required (change of preceding patches)

v6:
  - Drop set TIMER_PINNED flag in add_timer_on() and drop related
    warning. add_timer_on() fix is splitted into a separate
    patch. Therefore also drop "Reviewed-by" of Frederic Weisbecker

v5:
  - Add WARN_ONCE() in add_timer_on()
  - Decrease patch size by splitting into three patches (this patch and the
    two before)

v4:
  - split out logic to forward base clock into a helper function
    forward_base_clk() (Frederic)
  - ease the code in run_local_timers() and timer_clear_idle() (Frederic)
---
 kernel/time/timer.c | 85 +++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4d6cf49a2fd1..5ca831444954 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -187,12 +187,18 @@ EXPORT_SYMBOL(jiffies_64);
 #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
 
 #ifdef CONFIG_NO_HZ_COMMON
-# define NR_BASES	2
-# define BASE_STD	0
-# define BASE_DEF	1
+/*
+ * If multiple bases need to be locked, use the base ordering for lock
+ * nesting, i.e. lowest number first.
+ */
+# define NR_BASES	3
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	1
+# define BASE_DEF	2
 #else
 # define NR_BASES	1
-# define BASE_STD	0
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	0
 # define BASE_DEF	0
 #endif
 
@@ -899,7 +905,10 @@ static int detach_if_pending(struct timer_list *timer, struct timer_base *base,
 
 static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 {
-	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = per_cpu_ptr(&timer_bases[index], cpu);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -912,7 +921,10 @@ static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 
 static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = this_cpu_ptr(&timer_bases[index]);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -1961,6 +1973,9 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	 * Move next_expiry for the empty base into the future to prevent an
 	 * unnecessary raise of the timer softirq when the next_expiry value
 	 * will be reached even if there is no timer pending.
+	 *
+	 * This update is also required to make timer_base::next_expiry values
+	 * easy comparable to find out which base holds the first pending timer.
 	 */
 	if (!base->timers_pending)
 		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
@@ -1971,9 +1986,10 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long nextevt, nextevt_local, nextevt_global;
+	struct timer_base *base_local, *base_global;
 	u64 expires = KTIME_MAX;
-	unsigned long nextevt;
+	bool local_first;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1985,10 +2001,20 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		return expires;
 	}
 
-	raw_spin_lock(&base->lock);
-	nextevt = next_timer_interrupt(base, basej);
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
 
-	if (base->timers_pending) {
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt_local = next_timer_interrupt(base_local, basej);
+	nextevt_global = next_timer_interrupt(base_global, basej);
+
+	local_first = time_before_eq(nextevt_local, nextevt_global);
+
+	nextevt = local_first ? nextevt_local : nextevt_global;
+
+	if (base_local->timers_pending || base_global->timers_pending) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
@@ -1999,31 +2025,31 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
 	 */
-	__forward_timer_base(base, basej);
+	__forward_timer_base(base_local, basej);
+	__forward_timer_base(base_global, basej);
 
 	/*
 	 * Set base->is_idle only when caller is timer_base_try_to_set_idle()
 	 */
 	if (idle) {
 		/*
-		 * Base is idle if the next event is more than a tick away.
+		 * Bases are idle if the next event is more than a tick away.
 		 *
 		 * If the base is marked idle then any timer add operation must
 		 * forward the base clk itself to keep granularity small. This
-		 * idle logic is only maintained for the BASE_STD base,
-		 * deferrable timers may still see large granularity skew (by
-		 * design).
+		 * idle logic is only maintained for the BASE_LOCAL and
+		 * BASE_GLOBAL base, deferrable timers may still see large
+		 * granularity skew (by design).
 		 */
-		if (!base->is_idle) {
-			if (time_after(nextevt, basej + 1)) {
-				base->is_idle = true;
-				trace_timer_base_idle(true, base->cpu);
-			}
+		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
+			base_local->is_idle = base_global->is_idle = true;
+			trace_timer_base_idle(true, base_local->cpu);
 		}
-		*idle = base->is_idle;
+		*idle = base_local->is_idle;
 	}
 
-	raw_spin_unlock(&base->lock);
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);
 }
@@ -2067,15 +2093,14 @@ u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
  */
 void timer_clear_idle(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-
 	/*
 	 * We do this unlocked. The worst outcome is a remote enqueue sending
 	 * a pointless IPI, but taking the lock would just make the window for
 	 * sending the IPI a few instructions smaller for the cost of taking
 	 * the lock in the exit from idle path.
 	 */
-	base->is_idle = false;
+	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
+	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
 }
 #endif
@@ -2126,11 +2151,13 @@ static inline void __run_timers(struct timer_base *base)
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	__run_timers(base);
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
+		__run_timers(this_cpu_ptr(&timer_bases[BASE_GLOBAL]));
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+	}
 }
 
 /*
@@ -2138,7 +2165,7 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
  */
 static void run_local_timers(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	hrtimer_run_queues();
 
-- 
2.39.2


