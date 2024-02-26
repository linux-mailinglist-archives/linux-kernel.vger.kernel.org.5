Return-Path: <linux-kernel+bounces-82388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC3868398
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92ADB21F13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B371332A9;
	Mon, 26 Feb 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKctK12h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WIyTqlVn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348613249C;
	Mon, 26 Feb 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986273; cv=none; b=b9RIEG1N0H08R87aB1dMhfIEtAcPLe3PGN3So8FL5YjhHqQsiAVsNBt2Xct25TpWulLKa1o+FI2cbYNoVDbJrtqVPVPdYS+a6YYU3+lUBcehVumh4Lqis6V3aYj5/66AFjcxFcybDF+RKwYlfePbiqWBBEMlCSEDKxLryGjy8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986273; c=relaxed/simple;
	bh=YK+gb9/jyy0d4w+W35SvBsoEycHJgPqX6bWivLKiY4s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AVs2uq581RHbBkUdtJPd6wze+eJSFXnjcQApoNk22wW9Ja0gQ0MU16PcwLiDQFfj0l3FFsNALTFc6ANZCVdF5o7dnX8zNydPGhJzF9ORNtPGRawaL3s+GobvIItN+nKxxxlQYldZgRDPSAbue6eodLGPwfIMUI47SnpK17zQMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKctK12h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WIyTqlVn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xTIw5tqjVZIpH35eKhPSVJAIAlEyQ7W8yT+EkIHaiU=;
	b=xKctK12hz6sSi2+3JHUeonMCANn+ucQj+nDgM1lZU62YF4VFr+olrcY6ija4vWmqzBK6n7
	GsloVN3IpREor1dN/e5f3SMHW+jhO2HAFiIZeTew+/93lu6fCjYbwv9epNiK157TUBIPSS
	nXn97a5a9G9FHOL4Ancr+2xkzVKbPJBCHw59Jl3JRV1VqcBPg05Qr9exx8C1Y5q6p31nKs
	oVbClVgPDy14BWOxZE0hA4ztryoWj7+NLZM2IuzZZVi1/TIslfqf/R+JjaIoqs1Jzmb224
	xnZ5BUOdRM5CFa6iVCrdP4rTksdWOt2ZverryyU1BqW9fZSdK8Dxaai4BCg9eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xTIw5tqjVZIpH35eKhPSVJAIAlEyQ7W8yT+EkIHaiU=;
	b=WIyTqlVnIs42Jg+6nIgywv2yvw6itLiCb3YvKpw19N714FS0zWLMZVwG49s2Q2RemhVaiC
	sxZhyoNOIXCArKBA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Shut down low-res tick from dying CPU
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-15-frederic@kernel.org>
References: <20240225225508.11587-15-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898626934.398.2472263585670806931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3f69d04e146c6e14ccdd4e7b37d93f789229202a
Gitweb:        https://git.kernel.org/tip/3f69d04e146c6e14ccdd4e7b37d93f789229202a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:32 +01:00

tick: Shut down low-res tick from dying CPU

The timekeeping duty is handed over from the outgoing CPU within stop
machine. This works well if CONFIG_NO_HZ_COMMON=n or the tick is in
high-res mode. However in low-res dynticks mode, the tick isn't
cancelled until the clockevent is shut down, which can happen later. The
tick may therefore fire again once IRQs are re-enabled on stop machine
and until IRQs are disabled for good upon the last call to idle.

That's so many opportunities for a timekeeper to go idle and the
outgoing CPU to take over that duty. This is why
tick_nohz_idle_stop_tick() is called one last time on idle if the CPU
is seen offline: so that the timekeeping duty is handed over again in
case the CPU has re-taken the duty.

This means there are two timekeeping handovers on CPU down hotplug with
different undocumented constraints and purposes:

1) A handover on stop machine for !dynticks || highres. All online CPUs
   are guaranteed to be non-idle and the timekeeping duty can be safely
   handed-over. The hrtimer tick is cancelled so it is guaranteed that in
   dynticks mode the outgoing CPU won't take again the duty.

2) A handover on last idle call for dynticks && lowres.  Setting the
   duty to TICK_DO_TIMER_NONE makes sure that a CPU will take over the
   timekeeping.

Prepare for consolidating the handover to a single place (the first one)
with shutting down the low-res tick as well from
tick_cancel_sched_timer() as well. This will simplify the handover and
unify the tick cancellation between high-res and low-res.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-15-frederic@kernel.org

---
 kernel/time/tick-common.c |  3 ++-
 kernel/time/tick-sched.c  | 32 +++++++++++++++++++++++++-------
 kernel/time/tick-sched.h  |  4 ++--
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 5224140..9cd09ee 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -410,7 +410,8 @@ int tick_cpu_dying(unsigned int dying_cpu)
 	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
 
-	tick_cancel_sched_timer(dying_cpu);
+	/* Make sure the CPU won't try to retake the timekeeping duty */
+	tick_sched_timer_dying(dying_cpu);
 
 	/* Remove CPU from timer broadcasting */
 	tick_offline_cpu(dying_cpu);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index dcb9f03..89d16b8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -308,6 +308,14 @@ static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
 	return HRTIMER_RESTART;
 }
 
+static void tick_sched_timer_cancel(struct tick_sched *ts)
+{
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+		hrtimer_cancel(&ts->sched_timer);
+	else if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
+		tick_program_event(KTIME_MAX, 1);
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
 EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
@@ -1040,10 +1048,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires == KTIME_MAX)) {
-		if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
-			hrtimer_cancel(&ts->sched_timer);
-		else
-			tick_program_event(KTIME_MAX, 1);
+		tick_sched_timer_cancel(ts);
 		return;
 	}
 
@@ -1598,14 +1603,27 @@ void tick_setup_sched_timer(bool hrtimer)
 	tick_nohz_activate(ts);
 }
 
-void tick_cancel_sched_timer(int cpu)
+/*
+ * Shut down the tick and make sure the CPU won't try to retake the timekeeping
+ * duty before disabling IRQs in idle for the last time.
+ */
+void tick_sched_timer_dying(int cpu)
 {
+	struct tick_device *td = &per_cpu(tick_cpu_device, cpu);
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct clock_event_device *dev = td->evtdev;
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
-	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
-		hrtimer_cancel(&ts->sched_timer);
+	/* This must happen before hrtimers are migrated! */
+	tick_sched_timer_cancel(ts);
+
+	/*
+	 * If the clockevents doesn't support CLOCK_EVT_STATE_ONESHOT_STOPPED,
+	 * make sure not to call low-res tick handler.
+	 */
+	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
+		dev->event_handler = clockevents_handle_noop;
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index bbe72a0..58d8d1c 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -106,9 +106,9 @@ extern struct tick_sched *tick_get_tick_sched(int cpu);
 
 extern void tick_setup_sched_timer(bool hrtimer);
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
-extern void tick_cancel_sched_timer(int cpu);
+extern void tick_sched_timer_dying(int cpu);
 #else
-static inline void tick_cancel_sched_timer(int cpu) { }
+static inline void tick_sched_timer_dying(int cpu) { }
 #endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST

