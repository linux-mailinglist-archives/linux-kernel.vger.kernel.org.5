Return-Path: <linux-kernel+bounces-139485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB128A03AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBA01C20F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7381749;
	Wed, 10 Apr 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ne5hvYKc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2HdACHW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043557E119
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789232; cv=none; b=dcFqDBPkRQ3safr91eDlJEId/RWaXRWFAeG+dKpfehNJj6ssEhMUdWlaS6RTTHkD2K/C69zjjKCvWu7eiXRk9Jn/hkPUU5HIXRnMSB81yla2nc66sdqzTyIHvvSW59QYoEvcvDRZJF54jdT2GjuHEa3Tb2jBCufYcIXhe82aWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789232; c=relaxed/simple;
	bh=AEiar334sfqpOjIgW/6Bp180YytMBQoPwW2maP7uYRs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fdtwTgBkEGCPW+LFJT93qy6MLgG4HpXTzm6h97PSzjZ0QkM/QJwHpoHoCYRiIV6nNQm9O+pvLg+ymN7lTM0+JamlJ7Ao+4FRHqlOvdVozX1iYz2Di3NQTuyXbqS2yrKtu8Ab8H5BodQPNOqOrgDxOIqVmr98r/X7DWk2xEEKnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ne5hvYKc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2HdACHW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.957338323@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Un9A+m4IV/Z9ANmuwoM32FYX2xiyOcqxqSOJRbG47kY=;
	b=Ne5hvYKcHYDkD4XQhNb8JajbQk8E1Hd/SmBICv8LOvK870MDpHGIiLppg4C2qLwyHninvQ
	PVXqB4voPpJBuDpo9FPNebEq8D+35mZ8JXBt+nH1smQY1MKtkiq81V1v03tME+Ds17sqzY
	+A6enh/6cyTdRwhzbqoSC2TcH4G3ZRu/bxSFgvAogRQ/EoSM2Bh79qybJZKv6+R1F4Msoi
	6OGxElx1cai5idZW50kD0EuCck8ORijDH5AQMojRVlUMGAIMthWB2D/8NFLDjJDg3GlGk4
	opN4625pub6qu06YmtFeEl30wcjHn3LhS1vCEx8R+m65rteLqFsQH2tck6Fmkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Un9A+m4IV/Z9ANmuwoM32FYX2xiyOcqxqSOJRbG47kY=;
	b=l2HdACHWpTJTJKBANyJF/FP8N/MTcOVHSK1HWC9rnuRzunOPVcX7o65ChLmiUGEZzz9FO0
	TYDQ1eAVKkRwvMAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 32/50] posix-timers: Make signal delivery consistent
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:08 +0200 (CEST)

Signals of timers which are reprogammed, disarmed or deleted can deliver
signals related to the past. The POSIX spec is blury about this:

 - "The effect of disarming or resetting a timer with pending expiration
   notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which has
been disarmed. This makes the behaviour consistent and understandable.

Remove the si_sys_private check from the signal delivery code and invoke
posix_timer_deliver_signal() unconditionally.

Change that function so it controls the actual signal delivery via the
return value. It now instructs the signal code to drop the signal when:

  1) The timer does not longer exist in the hash table

  2) The timer signal_seq value is not the same as the si_sys_private value
     which was set when the signal was queued.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    2 --
 kernel/signal.c                |    2 +-
 kernel/time/posix-cpu-timers.c |    2 +-
 kernel/time/posix-timers.c     |   25 +++++++++++++++----------
 4 files changed, 17 insertions(+), 14 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -137,8 +137,6 @@ static inline void clear_posix_cputimers
 static inline void posix_cputimers_init_work(void) { }
 #endif
 
-#define REQUEUE_PENDING 1
-
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
  * @list:		List head for binding the timer to signals->posix_timers
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -617,7 +617,7 @@ int dequeue_signal(sigset_t *mask, kerne
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private)) {
+		if (unlikely(info->si_code == SI_TIMER)) {
 			if (!posixtimer_deliver_signal(info))
 				goto again;
 		}
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -746,7 +746,7 @@ static void __posix_cpu_timer_get(struct
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_signal_seq & REQUEUE_PENDING) || sigev_none))
+	if (iv && timer->it_status != POSIX_TIMER_ARMED)
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,7 +269,10 @@ bool posixtimer_deliver_signal(struct ke
 	if (!timr)
 		goto out;
 
-	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
+	if (timr->it_signal_seq != info->si_sys_private)
+		goto out_unlock;
+
+	if (timr->it_interval && timr->it_status == POSIX_TIMER_REQUEUE_PENDING) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_status = POSIX_TIMER_ARMED;
@@ -281,6 +284,7 @@ bool posixtimer_deliver_signal(struct ke
 	}
 	ret = true;
 
+out_unlock:
 	unlock_timer(timr, flags);
 out:
 	spin_lock(&current->sighand->siglock);
@@ -293,19 +297,19 @@ bool posixtimer_deliver_signal(struct ke
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret, si_private = 0;
 	enum pid_type type;
+	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
 	if (timr->it_interval) {
+		timr->it_signal_seq++;
 		state = POSIX_TIMER_REQUEUE_PENDING;
-		si_private = ++timr->it_signal_seq;
 	}
 	timr->it_status = state;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -670,7 +674,7 @@ void common_timer_get(struct k_itimer *t
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
+	if (iv && timr->it_status != POSIX_TIMER_ARMED)
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -870,8 +874,6 @@ void posix_timer_set_common(struct k_iti
 	else
 		timer->it_interval = 0;
 
-	/* Prevent reloading in case there is a signal pending */
-	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;
@@ -889,8 +891,6 @@ int common_timer_set(struct k_itimer *ti
 	if (old_setting)
 		common_timer_get(timr, old_setting);
 
-	/* Prevent rearming by clearing the interval */
-	timr->it_interval = 0;
 	/*
 	 * Careful here. On SMP systems the timer expiry function could be
 	 * active and spinning on timr->it_lock.
@@ -940,6 +940,9 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
+	/* Prevent signal delivery and rearming. */
+	timr->it_signal_seq++;
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
@@ -1008,7 +1011,6 @@ int common_timer_del(struct k_itimer *ti
 {
 	const struct k_clock *kc = timer->kclock;
 
-	timer->it_interval = 0;
 	if (kc->timer_try_to_cancel(timer) < 0)
 		return TIMER_RETRY;
 	timer->it_status = POSIX_TIMER_DISARMED;
@@ -1036,6 +1038,9 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	if (!timer)
 		return -EINVAL;
 
+	/* Prevent signal delivery and rearming. */
+	timer->it_signal_seq++;
+
 	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
 		timer = timer_wait_running(timer, &flags);


