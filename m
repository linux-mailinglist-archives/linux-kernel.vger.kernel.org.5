Return-Path: <linux-kernel+bounces-137635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84CF89E4D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E340283611
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55715887D;
	Tue,  9 Apr 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ys63OKZ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ncQF9kW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B829D153BDD;
	Tue,  9 Apr 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697493; cv=none; b=liEKQWHQ5v/KKKZE+jEByQpGT/F55LSPefMoUeau7tgkPVOUrWv2bMHDKEcjKUoYpT97coKk4j1tAqgpLeGi/mPv4rfyYDVB5HhDNZd+1DHYqDqSE/F38HupXTaNKi2Bezzi+UI2xlu3gdq7db0cBQDHgcThBxBsX1ZjobFG4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697493; c=relaxed/simple;
	bh=BQTagZAEorP6V35OBJen8skGrIt9hv2mDaNpSKyorEc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YY5Wb9sn3TN5LFXe7V3BX58fkdmsjQSf+JOAm0CQ6t49dd84snUqXBu94OhX8I+79HQQSo8BVpUQ8OoXqz+UR3xnVzk0YITJnEKaN4xpGzQ8psFe2Av/VmiV0syPzz37egFzisq4j+rF6JAdE5g9pBstEDsTA1uE0U9PUn+6Gj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ys63OKZ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ncQF9kW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 21:18:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712697489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ovza6i6YjoELFSx0bZ/SzYo4bBbazMhSHjwv4Pnur4=;
	b=ys63OKZ/JBiMyJb3uWomyz++q0mDJT74B3BtkfmeSM76RdztkNYJaWUnnPO42fnd0llQIV
	HKiP+6wfRuEBOlwwyw/zVCYJeI9g1GiMtrQrELUBtdU+gRXG44SQOC2+eeuZBXO/w9svjZ
	kr+e9Hs+fAvSutyPxUQzoTFzJkODog+lV/dDUQKMlH7knr9iA5mUisFEOO1fS6/w+n61dQ
	P7T/R8DJ9oGlRxImycW9wPu9kdga88HZLfi0hvXOQ5zVCGux3CdWj+WGPl0kngTC7/rt9r
	GZqH9nftYcc0/UFsGihut122c+00vt/Uqfwbtcfo9vyyBcDFLwbVVwP0DL3jvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712697489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ovza6i6YjoELFSx0bZ/SzYo4bBbazMhSHjwv4Pnur4=;
	b=5ncQF9kW4YywtQmJ+CPOlRn2i72z4wLvY6BWrfzFUxXnck84nXJIn5hzehepsU8xW/8Liv
	ulXSFrThAJC2skAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timekeeping: Use READ/WRITE_ONCE() for tick_do_timer_cpu
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Anderson <sean.anderson@seco.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87cyqy7rt3.ffs@tglx>
References: <87cyqy7rt3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171269748856.10875.3911619468870441338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     0200ddd723d6056d0b1c1ebde4b11e75a0f2ed7e
Gitweb:        https://git.kernel.org/tip/0200ddd723d6056d0b1c1ebde4b11e75a0f2ed7e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Apr 2024 12:29:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 23:09:44 +02:00

timekeeping: Use READ/WRITE_ONCE() for tick_do_timer_cpu

tick_do_timer_cpu is used lockless to check which CPU needs to take care
of the per tick timekeeping duty. This is done to avoid a thundering
herd problem on jiffies_lock.

The read and writes are not annotated so KCSAN complains about data races:

  BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event                                                                                                                                                       
                                                                                                                                                                                                                                 
  write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 26:                                                                                                                                                                    
   tick_nohz_idle_stop_tick+0x3b1/0x4a0                                                                                                                                                                                          
   do_idle+0x1e3/0x250                                                                                                                                                                                                           
                                                                                                                                                                                                                                 
  read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16:                                                                                                                                                                     
   tick_nohz_next_event+0xe7/0x1e0                                                                                                                                                                                               
   tick_nohz_get_sleep_length+0xa7/0xe0                                                                                                                                                                                          
   menu_select+0x82/0xb90                                                                                                                                                                                                        
   cpuidle_select+0x44/0x60                                                                                                                                                                                                      
   do_idle+0x1c2/0x250                                                                                                                                                                                                           
                                                                                                                                                                                                                                 
  value changed: 0x0000001a -> 0xffffffff                  

Annotate them with READ/WRITE_ONCE() to document the intentional data race.

Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/87cyqy7rt3.ffs@tglx

---
 kernel/time/tick-common.c | 17 +++++++++--------
 kernel/time/tick-sched.c  | 36 ++++++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index fb0fdec..a285f4d 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -7,6 +7,7 @@
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
  */
+#include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/hrtimer.h>
@@ -84,7 +85,7 @@ int tick_is_oneshot_available(void)
  */
 static void tick_periodic(int cpu)
 {
-	if (tick_do_timer_cpu == cpu) {
+	if (READ_ONCE(tick_do_timer_cpu) == cpu) {
 		raw_spin_lock(&jiffies_lock);
 		write_seqcount_begin(&jiffies_seq);
 
@@ -215,8 +216,8 @@ static void tick_setup_device(struct tick_device *td,
 		 * If no cpu took the do_timer update, assign it to
 		 * this cpu:
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			tick_do_timer_cpu = cpu;
+		if (READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
@@ -232,7 +233,7 @@ static void tick_setup_device(struct tick_device *td,
 						!tick_nohz_full_cpu(cpu)) {
 			tick_take_do_timer_from_boot();
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(tick_do_timer_cpu != cpu);
+			WARN_ON(READ_ON_ONCE(tick_do_timer_cpu) != cpu);
 #endif
 		}
 
@@ -406,10 +407,10 @@ void tick_assert_timekeeping_handover(void)
 int tick_cpu_dying(unsigned int dying_cpu)
 {
 	/*
-	 * If the current CPU is the timekeeper, it's the only one that
-	 * can safely hand over its duty. Also all online CPUs are in
-	 * stop machine, guaranteed not to be idle, therefore it's safe
-	 * to pick any online successor.
+	 * If the current CPU is the timekeeper, it's the only one that can
+	 * safely hand over its duty. Also all online CPUs are in stop
+	 * machine, guaranteed not to be idle, therefore there is no
+	 * concurrency and it's safe to pick any online successor.
 	 */
 	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 1331216..71a792c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -8,6 +8,7 @@
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
  */
+#include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/hrtimer.h>
@@ -204,7 +205,7 @@ static inline void tick_sched_flag_clear(struct tick_sched *ts,
 
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
-	int cpu = smp_processor_id();
+	int tick_cpu, cpu = smp_processor_id();
 
 	/*
 	 * Check if the do_timer duty was dropped. We don't care about
@@ -216,16 +217,18 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * If nohz_full is enabled, this should not happen because the
 	 * 'tick_do_timer_cpu' CPU never relinquishes.
 	 */
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
-	    unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	tick_cpu = READ_ONCE(tick_do_timer_cpu);
+
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && unlikely(tick_cpu == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
-		tick_do_timer_cpu = cpu;
+		WRITE_ONCE(tick_do_timer_cpu, cpu);
+		tick_cpu = cpu;
 	}
 
 	/* Check if jiffies need an update */
-	if (tick_do_timer_cpu == cpu)
+	if (tick_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
 	/*
@@ -610,7 +613,7 @@ bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
-	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
+	if (tick_nohz_full_running && READ_ONCE(tick_do_timer_cpu) == cpu)
 		return false;
 	return true;
 }
@@ -891,6 +894,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
 	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
+	int tick_cpu;
 
 	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
@@ -947,9 +951,9 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu != tick_do_timer_cpu &&
-	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE ||
-	     !tick_sched_flag_test(ts, TS_FLAG_DO_TIMER_LAST)))
+	tick_cpu = READ_ONCE(tick_do_timer_cpu);
+	if (tick_cpu != cpu &&
+	    (tick_cpu != TICK_DO_TIMER_NONE || !tick_sched_flag_test(ts, TS_FLAG_DO_TIMER_LAST)))
 		delta = KTIME_MAX;
 
 	/* Calculate the next expiry time */
@@ -970,6 +974,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
 	bool timer_idle = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
+	int tick_cpu;
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
@@ -1007,10 +1012,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * do_timer() never gets invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
 	 */
-	if (cpu == tick_do_timer_cpu) {
-		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+	tick_cpu = READ_ONCE(tick_do_timer_cpu);
+	if (tick_cpu == cpu) {
+		WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
 		tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+	} else if (tick_cpu != TICK_DO_TIMER_NONE) {
 		tick_sched_flag_clear(ts, TS_FLAG_DO_TIMER_LAST);
 	}
 
@@ -1173,15 +1179,17 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		return false;
 
 	if (tick_nohz_full_enabled()) {
+		int tick_cpu = READ_ONCE(tick_do_timer_cpu);
+
 		/*
 		 * Keep the tick alive to guarantee timekeeping progression
 		 * if there are full dynticks CPUs around
 		 */
-		if (tick_do_timer_cpu == cpu)
+		if (tick_cpu == cpu)
 			return false;
 
 		/* Should not happen for nohz-full */
-		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
+		if (WARN_ON_ONCE(tick_cpu == TICK_DO_TIMER_NONE))
 			return false;
 	}
 

