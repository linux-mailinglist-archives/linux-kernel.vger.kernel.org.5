Return-Path: <linux-kernel+bounces-82400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B078683AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426151C22345
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC7136670;
	Mon, 26 Feb 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XyBM4C3x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9Yf1rvE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6C135A47;
	Mon, 26 Feb 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986284; cv=none; b=lXy2JGziAmiuuD4bsxTK+W7hEXN0tDCSQK6UHNdjPg9rFWhH03+lCSMSmecDFYxgCxeNwinuDGG66ckp8pv9IvfjnpY5uATj252tpQpQYrX754EQ0KkEmrUjm0U0zkesmlpX5ImP+9blYSV60s17mE1oU1sFwndhHsn7szKPAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986284; c=relaxed/simple;
	bh=zsiin/e9DCCAHFYVmvc8VlxYCJKmc7/so4tlT/LafQI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gPzuyRzWMW9a3SZIG8tMGMeEKHsd4xeMxfRmj4IqWVU3BDsWuXZc8flVY111Z7aSl3uUSGP4sfYcCfgtdCW0LTM//uzYA3nPKAaQjYnv9QZTxgUbhiOYcRZQ0vhEO49d9TFjFgsePXfPVcF+SSzNltRTjrwymwmXYK2OUYP/hhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XyBM4C3x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9Yf1rvE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6L7KZYYUOJiap7pCXaChkuCbO1qvcGQt3YWzNUKv4o=;
	b=XyBM4C3xF73HOVQvE/mYombPc7rQD/sYcHPKfDKP76nPkGAGIDZI50/UFtTMgPKZ+DQVt3
	QDFIPUUDVeVqmQDTwZzj9GG4UkeYQw6HRw68MMqwg7CGMUsgzrxns92HbLL/BGwgGjx0rs
	vEL6opIXP/leQDV5DrI4qNLvwFQLriai7DGPjT3WSdX8P43vMcWw4HYyeSsuG8sYFZ6B1S
	HqXrsAHdqPRBZw4NGdBsi1mQ5HMw9YvtL4cSdFpLjlh4sQShaahiz+cZoPIyzlgzemHq2c
	njBVnrzxULbGpyVHhuNIoYu6d8vfjzOdvf8DNbKsm/71S1X9Bwm6ZwY8NqaZeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6L7KZYYUOJiap7pCXaChkuCbO1qvcGQt3YWzNUKv4o=;
	b=L9Yf1rvEkjtzg7CB+jUNoy9iexNd2gBWZ83XZYOYmDKYfkz4Dug/ruS4jNyNP3wfTRBQ4J
	znzjGmUfgf0zjJBQ==
From: "tip-bot2 for Peng Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/nohz: Remove duplicate between lowres and
 highres handlers
Cc: Peng Liu <liupeng17@lenovo.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-3-frederic@kernel.org>
References: <20240225225508.11587-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898628040.398.17292804624941572167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     37263ba0c44b13b2025398ac81919df9f0a91368
Gitweb:        https://git.kernel.org/tip/37263ba0c44b13b2025398ac81919df9f0a91368
Author:        Peng Liu <liupeng17@lenovo.com>
AuthorDate:    Sun, 25 Feb 2024 23:54:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:31 +01:00

tick/nohz: Remove duplicate between lowres and highres handlers

tick_nohz_lowres_handler() does the same work as
tick_nohz_highres_handler() plus the clockevent device reprogramming, so
make the former reuse the latter and rename it accordingly.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-3-frederic@kernel.org

---
 kernel/time/tick-sched.c | 96 ++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 60 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d490165..88c992f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -255,6 +255,40 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
+
+/*
+ * We rearm the timer until we get disabled by the idle code.
+ * Called with interrupts disabled.
+ */
+static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
+{
+	struct tick_sched *ts =	container_of(timer, struct tick_sched, sched_timer);
+	struct pt_regs *regs = get_irq_regs();
+	ktime_t now = ktime_get();
+
+	tick_sched_do_timer(ts, now);
+
+	/*
+	 * Do not call when we are not in IRQ context and have
+	 * no valid 'regs' pointer
+	 */
+	if (regs)
+		tick_sched_handle(ts, regs);
+	else
+		ts->next_tick = 0;
+
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
+	if (unlikely(ts->tick_stopped))
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward(timer, now, TICK_NSEC);
+
+	return HRTIMER_RESTART;
+}
 #endif
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -1429,31 +1463,15 @@ void tick_nohz_idle_exit(void)
  * at the clockevent level. hrtimer can't be used instead, because its
  * infrastructure actually relies on the tick itself as a backend in
  * low-resolution mode (see hrtimer_run_queues()).
- *
- * This low-resolution handler still makes use of some hrtimer APIs meanwhile
- * for convenience with expiration calculation and forwarding.
  */
 static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	struct pt_regs *regs = get_irq_regs();
-	ktime_t now = ktime_get();
 
 	dev->next_event = KTIME_MAX;
 
-	tick_sched_do_timer(ts, now);
-	tick_sched_handle(ts, regs);
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (likely(!ts->tick_stopped)) {
-		hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+	if (likely(tick_nohz_handler(&ts->sched_timer) == HRTIMER_RESTART))
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	}
-
 }
 
 static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
@@ -1522,48 +1540,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-/*
- * High resolution timer specific code
- */
-#ifdef CONFIG_HIGH_RES_TIMERS
-/*
- * We rearm the timer until we get disabled by the idle code.
- * Called with interrupts disabled.
- */
-static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
-{
-	struct tick_sched *ts =
-		container_of(timer, struct tick_sched, sched_timer);
-	struct pt_regs *regs = get_irq_regs();
-	ktime_t now = ktime_get();
-
-	tick_sched_do_timer(ts, now);
-
-	/*
-	 * Do not call when we are not in IRQ context and have
-	 * no valid 'regs' pointer
-	 */
-	if (regs)
-		tick_sched_handle(ts, regs);
-	else
-		ts->next_tick = 0;
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (unlikely(ts->tick_stopped))
-		return HRTIMER_NORESTART;
-
-	hrtimer_forward(timer, now, TICK_NSEC);
-
-	return HRTIMER_RESTART;
-}
-#else
-#define tick_nohz_highres_handler NULL
-#endif /* CONFIG_HIGH_RES_TIMERS */
-
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
@@ -1587,7 +1563,7 @@ void tick_setup_sched_timer(int mode)
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 
 	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
-		ts->sched_timer.function = tick_nohz_highres_handler;
+		ts->sched_timer.function = tick_nohz_handler;
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());

