Return-Path: <linux-kernel+bounces-139475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0388A03A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B3C1F26F76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD153E18;
	Wed, 10 Apr 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5LtzvpX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+bzqUESy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5853392
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789214; cv=none; b=Wo/eOJMy9K5blbJs7IjXdt8MENIMGOAd1PZqdxM3qpaNCobEEz1JqeysTvFJkVkx1u4v6tPwnx6w2yMwO9BkxAt8P4rSX5cmj6OS2AaI+1tDILjwAHb0EbIpVbuANIW8UeLKmclcS12qrgk5F3ylYqoG0igHGWyHmkkB8oQXK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789214; c=relaxed/simple;
	bh=ur+O419OtXBNtUIZuacqd+BURpp8/MYytOmiM6ylieg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=txV645223cHplSn1oJgbAZMOi5cfVVEQnMpLaAXz6cx4UP1JhLs5LFs0/ZjB1valkEVjHnk22rYjHEDnJnFHbvHr13VWRleqMGnF1vIwSQVh+JhZvjhohQsVy5C6ndoaahWRJMJnWo8FfRPiPKWM8sPXK6WmgYLo2LdUfT1gxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5LtzvpX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+bzqUESy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.319533154@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uSjFneRht2ixPq2dOvLaSspY3kohFRB8UKUX6K60b2g=;
	b=C5LtzvpX8y2eS6SFUSY2IIVe7GEx2gr3bFqrXADZvzvpvg62rlH5uVI8u+dPmBmPiOkJgL
	ItrsHRvQx4AdzCjJk7os+ZEf9l01PO8RvpJCm8DJZhFBmMa3s8i9Q9U/q3A1YIhu38amYD
	zK9rus3KzNjwaOB35DCft4SANSTHgMyZIgDZdQ01iIzgnghFibtrMRp7TdzuoAfJLBG2ib
	WdTt5EY4hSF1HHsIHX6BVZz8s7aV/CmgBfAOkPY9TofZkEdxl6OExoAj/WX7gVde3Zs1ie
	D3A6cIsJpQPg3X9kTA9r414KD7FmrUpYatWR6phEsiJE+hyrfI6h+sVJGAOVxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uSjFneRht2ixPq2dOvLaSspY3kohFRB8UKUX6K60b2g=;
	b=+bzqUESyV5ujgVRnBoGxUqfAwarPWgcpS72c1w5t4ahP7w5a2rw0fXQbNwGXGX3gJ82r8S
	eeR6u2X4ipRrhmAg==
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
Subject: [patch V2 22/50] posix-timers: Consolidate signal queueing
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:50 +0200 (CEST)

Rename posix_timer_event() to posix_timer_queue_signal() as this is what
the function is about.

Consolidate the requeue pending and deactivation updates into that function
as there is no point in doing this in all incarnations of posix timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/alarmtimer.c       |    7 +------
 kernel/time/posix-cpu-timers.c |    4 ++--
 kernel/time/posix-timers.c     |   21 +++++++++++----------
 kernel/time/posix-timers.h     |    2 +-
 4 files changed, 15 insertions(+), 19 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -574,15 +574,10 @@ static enum alarmtimer_restart alarm_han
 					    it.alarm.alarmtimer);
 	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
 	unsigned long flags;
-	int si_private = 0;
 
 	spin_lock_irqsave(&ptr->it_lock, flags);
 
-	ptr->it_active = 0;
-	if (ptr->it_interval)
-		si_private = ++ptr->it_requeue_pending;
-
-	if (posix_timer_event(ptr, si_private) && ptr->it_interval) {
+	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
 		/*
 		 * Handle ignored signals and rearm the timer. This will go
 		 * away once we handle ignored signals proper. Ensure that
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -598,9 +598,9 @@ static void cpu_timer_fire(struct k_itim
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
-		posix_timer_event(timer, 0);
+		posix_timer_queue_signal(timer);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
+	} else if (posix_timer_queue_signal(timer)) {
 		/*
 		 * The signal did not get queued because the signal
 		 * was ignored, so we won't get any callback to
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -277,10 +277,17 @@ void posixtimer_rearm(struct kernel_sigi
 	unlock_timer(timr, flags);
 }
 
-int posix_timer_event(struct k_itimer *timr, int si_private)
+int posix_timer_queue_signal(struct k_itimer *timr)
 {
+	int ret, si_private = 0;
 	enum pid_type type;
-	int ret;
+
+	lockdep_assert_held(&timr->it_lock);
+
+	timr->it_active = 0;
+	if (timr->it_interval)
+		si_private = ++timr->it_requeue_pending;
+
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
@@ -309,19 +316,13 @@ int posix_timer_event(struct k_itimer *t
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
+	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
 	enum hrtimer_restart ret = HRTIMER_NORESTART;
-	struct k_itimer *timr;
 	unsigned long flags;
-	int si_private = 0;
 
-	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
 
-	timr->it_active = 0;
-	if (timr->it_interval != 0)
-		si_private = ++timr->it_requeue_pending;
-
-	if (posix_timer_event(timr, si_private)) {
+	if (posix_timer_queue_signal(timr)) {
 		/*
 		 * The signal was not queued due to SIG_IGN. As a
 		 * consequence the timer is not going to be rearmed from
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -36,7 +36,7 @@ extern const struct k_clock clock_proces
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_event(struct k_itimer *timr, int si_private);
+int posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,


