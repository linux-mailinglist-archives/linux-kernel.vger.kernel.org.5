Return-Path: <linux-kernel+bounces-82389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0AC86839A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8368C28146F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DAF132491;
	Mon, 26 Feb 2024 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8MSAp9n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYKUu0gs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5005132C0B;
	Mon, 26 Feb 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986274; cv=none; b=u2i0RN7y3MMzZU+2Q30WdJ/hu7ZM2/NdHjFAqQarxhEmVnbjqzB0arDogJRYnjYuK+IQU1QnMFNNo9tdVpGW4RhvvDc7VtXbrCU9euWeHK0x1VE/vK2Mdwe+ueHGxL9irzxQR7inM9Ff600npUl7z2YE5s+Is3klsQNhOfMCf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986274; c=relaxed/simple;
	bh=SHT+PsLK9/XAM8n7DZNptXYvukSaAfiQz+q9YEvuxzc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JJ0hGtsUtmpOPSOXmh6TuWz5eaPmbTbAdV7DDRzvJAE5RqyfNPDleB3PMYg7c5GvJl2DTZKUVaoBW7o6jPdR1hUX3esPr0DHpPIw9134DarioONhKzZkRlq453DelZuPPatXEFS3l3me48BSQf5oy2GPFMWD/wfJxqa/B5awTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8MSAp9n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYKUu0gs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7Nb/epJU1nOd40bkU9iyOThlK/mwyumynu8JQaJsHc=;
	b=U8MSAp9ne3QhNExXbE+klQVYFBAkoHeQc/PANwga4uD74AyXgoMoYr2B7OnyR3lCRn4NwF
	85h8HxegNJVkv5o7GpyLQftMaJS4CM7JCNG/tQ7vmJubJIucRDSkBItzGp6fMde0cKISI4
	AD9WxTPP3cMGDbZ+b/lvlB4ilD7Qd1auBpTNdMVgvo/VRmVNRnDcLIDVyPcchtEomsFLOQ
	CrhW4zkNzhCfdkw4BCa6Ol4mxTRjZm0QXKDk7D7AQR6Ctz9k7IjCwGbH2UsPPnFBqXlHMM
	aCDe2OEnXSuQ2ft/IDnfnCwRIUJSlPV1GDyinWZyJG7aEILBD8m4ibLoVz3/wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7Nb/epJU1nOd40bkU9iyOThlK/mwyumynu8JQaJsHc=;
	b=MYKUu0gsQ4HtJzTykJNvsxTsxZWQ6eluuu9xHplm03BgW1bgkSoZlf1PTRawbwuvKHJFEh
	q+cdLd8Tf3dhsqDg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] tick: Split nohz and highres features from nohz_mode
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-14-frederic@kernel.org>
References: <20240225225508.11587-14-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627026.398.2008623390447364745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7988e5ae2be70b110db9d4b8ec163bd42e67d3be
Gitweb:        https://git.kernel.org/tip/7988e5ae2be70b110db9d4b8ec163bd42e67d3be
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:32 +01:00

tick: Split nohz and highres features from nohz_mode

The nohz mode field tells about low resolution nohz mode or high
resolution nohz mode but it doesn't tell about high resolution non-nohz
mode.

In order to retrieve the latter state, tick_cancel_sched_timer() must
fiddle with struct hrtimer's internals to guess if the tick has been
initialized in high resolution.

Move instead the nohz mode field information into the tick flags and
provide two new bits: one to know if the tick is in nohz mode and
another one to know if the tick is in high resolution. The combination
of those two flags provides all the needed informations to determine
which of the three tick modes is running.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-14-frederic@kernel.org

---
 kernel/time/hrtimer.c    |  2 +-
 kernel/time/tick-sched.c | 32 +++++++++++++++++---------------
 kernel/time/tick-sched.h | 13 +++++--------
 kernel/time/timer_list.c |  5 +++--
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3e95474..70625df 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -747,7 +747,7 @@ static void hrtimer_switch_to_hres(void)
 	base->hres_active = 1;
 	hrtimer_resolution = HIGH_RES_NSEC;
 
-	tick_setup_sched_timer(NOHZ_MODE_HIGHRES);
+	tick_setup_sched_timer(true);
 	/* "Retrigger" the interrupt to get things going */
 	retrigger_next_event(NULL);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4aa7ce0..dcb9f03 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -831,7 +831,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	/* Forward the time to expire in the future */
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
 		hrtimer_start_expires(&ts->sched_timer,
 				      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
@@ -1040,14 +1040,14 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires == KTIME_MAX)) {
-		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
+		if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
 			hrtimer_cancel(&ts->sched_timer);
 		else
 			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
 		hrtimer_start(&ts->sched_timer, expires,
 			      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
@@ -1108,7 +1108,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
-	if (ts->nohz_mode == NOHZ_MODE_INACTIVE)
+	if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
 		return;
 
 	__tick_nohz_full_update_tick(ts, ktime_get());
@@ -1168,7 +1168,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		return false;
 	}
 
-	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE))
+	if (unlikely(!tick_sched_flag_test(ts, TS_FLAG_NOHZ)))
 		return false;
 
 	if (need_resched())
@@ -1487,11 +1487,11 @@ static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
-static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
+static inline void tick_nohz_activate(struct tick_sched *ts)
 {
 	if (!tick_nohz_enabled)
 		return;
-	ts->nohz_mode = mode;
+	tick_sched_flag_set(ts, TS_FLAG_NOHZ);
 	/* One update is enough */
 	if (!test_and_set_bit(0, &tick_nohz_active))
 		timers_update_nohz();
@@ -1512,7 +1512,7 @@ static void tick_nohz_switch_to_nohz(void)
 	 * Recycle the hrtimer in 'ts', so we can share the
 	 * highres code.
 	 */
-	tick_setup_sched_timer(NOHZ_MODE_LOWRES);
+	tick_setup_sched_timer(false);
 }
 
 static inline void tick_nohz_irq_enter(void)
@@ -1540,7 +1540,7 @@ static inline void tick_nohz_irq_enter(void)
 
 static inline void tick_nohz_switch_to_nohz(void) { }
 static inline void tick_nohz_irq_enter(void) { }
-static inline void tick_nohz_activate(struct tick_sched *ts, int mode) { }
+static inline void tick_nohz_activate(struct tick_sched *ts) { }
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
@@ -1567,15 +1567,17 @@ early_param("skew_tick", skew_tick);
  * tick_setup_sched_timer - setup the tick emulation timer
  * @mode: tick_nohz_mode to setup for
  */
-void tick_setup_sched_timer(int mode)
+void tick_setup_sched_timer(bool hrtimer)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer) {
+		tick_sched_flag_set(ts, TS_FLAG_HIGHRES);
 		ts->sched_timer.function = tick_nohz_handler;
+	}
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
@@ -1589,11 +1591,11 @@ void tick_setup_sched_timer(int mode)
 	}
 
 	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer)
 		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	else
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	tick_nohz_activate(ts, mode);
+	tick_nohz_activate(ts);
 }
 
 void tick_cancel_sched_timer(int cpu)
@@ -1602,7 +1604,7 @@ void tick_cancel_sched_timer(int cpu)
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && ts->sched_timer.base)
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
 		hrtimer_cancel(&ts->sched_timer);
 
 	idle_sleeptime = ts->idle_sleeptime;
@@ -1652,7 +1654,7 @@ int tick_check_oneshot_change(int allow_nohz)
 	if (!test_and_clear_bit(0, &ts->check_clocks))
 		return 0;
 
-	if (ts->nohz_mode != NOHZ_MODE_INACTIVE)
+	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
 		return 0;
 
 	if (!timekeeping_valid_for_hres() || !tick_is_oneshot_available())
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 07a4c01..bbe72a0 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -14,12 +14,6 @@ struct tick_device {
 	enum tick_device_mode mode;
 };
 
-enum tick_nohz_mode {
-	NOHZ_MODE_INACTIVE,
-	NOHZ_MODE_LOWRES,
-	NOHZ_MODE_HIGHRES,
-};
-
 /* The CPU is in the tick idle mode */
 #define TS_FLAG_INIDLE		BIT(0)
 /* The idle tick has been stopped */
@@ -31,6 +25,10 @@ enum tick_nohz_mode {
 #define TS_FLAG_IDLE_ACTIVE	BIT(2)
 /* CPU was the last one doing do_timer before going idle */
 #define TS_FLAG_DO_TIMER_LAST	BIT(3)
+/* NO_HZ is enabled */
+#define TS_FLAG_NOHZ		BIT(4)
+/* High resolution tick mode */
+#define TS_FLAG_HIGHRES		BIT(5)
 
 /**
  * struct tick_sched - sched tick emulation and no idle tick control/stats
@@ -84,7 +82,6 @@ struct tick_sched {
 	ktime_t				idle_entrytime;
 
 	/* Tick stop */
-	enum tick_nohz_mode		nohz_mode;
 	unsigned long			last_jiffies;
 	u64				timer_expires_base;
 	u64				timer_expires;
@@ -107,7 +104,7 @@ struct tick_sched {
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
 
-extern void tick_setup_sched_timer(int mode);
+extern void tick_setup_sched_timer(bool hrtimer);
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 extern void tick_cancel_sched_timer(int cpu);
 #else
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 38f81d8..1c311c4 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -152,7 +152,8 @@ static void print_cpu(struct seq_file *m, int cpu, u64 now)
 
 	{
 		struct tick_sched *ts = tick_get_tick_sched(cpu);
-		P(nohz_mode);
+		P_flag(nohz, TS_FLAG_NOHZ);
+		P_flag(highres, TS_FLAG_HIGHRES);
 		P_ns(last_tick);
 		P_flag(tick_stopped, TS_FLAG_STOPPED);
 		P(idle_jiffies);
@@ -259,7 +260,7 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
 
 static inline void timer_list_header(struct seq_file *m, u64 now)
 {
-	SEQ_printf(m, "Timer List Version: v0.9\n");
+	SEQ_printf(m, "Timer List Version: v0.10\n");
 	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
 	SEQ_printf(m, "now at %Ld nsecs\n", (unsigned long long)now);
 	SEQ_printf(m, "\n");

