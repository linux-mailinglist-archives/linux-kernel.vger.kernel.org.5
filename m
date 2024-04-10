Return-Path: <linux-kernel+bounces-139480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6BA8A03A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9412830F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C17156B69;
	Wed, 10 Apr 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxY/71Ws";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KpccPDeE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50555C1A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789223; cv=none; b=WDc74spEFD+5cEn1d+o/f3XriMlLzwljxHBfPCTcQjHloH90q0n+i4hcSV6FB8lA9SdJXEOhbzWfyVdFT2R0GIS+z4htfkUciRGg6tqCRQy+ehU0MKPzQNIgpb+cm6/1HElBqo9RDgT5I+GSkfYU5RVlJfxzt1gPuo74Ut1MGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789223; c=relaxed/simple;
	bh=YUYXbvNLeAAZW3gzVGbt6Jlqa6UfoUuXxN1tUXO46bM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=htu4aKcr3AQd8/CW57twRaTvHX1MVFNIpmtTMA+sC6IJNZ+vke8+/aQL3CaHzYNENa5GzFDfzAQH65wN3rckmRLO18dmroUmIhMR8wurQ3mPc67c9v68aRhHbAlRlAiq2maQORXttdS56cDHxpwORKw6/ZtJhUa+U4ZLU4gIgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxY/71Ws; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KpccPDeE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.633773866@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WkRZaZxYlvrm5s7eSkUnSudnYssu5hu4hAXagPKaAJw=;
	b=MxY/71Wsh0Jh4+Amnr/H/hy2OvhG7xkSPUB0bVzu1aVYcn6upCmiE4YjQ8GJ3+yDZDhjyu
	dx5Tv+q+tz0ErIQjnK1IqFSMPQ1WA7m8r35jBvSk6dNvqUpOApLAO1gI9v4zL8mahWhbxE
	T+64wN7uHlEaaTNqPGTzvye6+stvuE1v7N0nKlw2sPHOr1cu3sHHZH4yambIT3ePvUJsqn
	Lc6/9h/JmmLm8nfLGbciW/EmubO3QII+hWlBLl83BIHchq9l2grFjg6dETnR89JknnrIPl
	F2BDSucxddGq6+KR4wYmiNG/9uQ7bUwPqSZokhRiGoT7p+5NkZzSC/r/gm20aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WkRZaZxYlvrm5s7eSkUnSudnYssu5hu4hAXagPKaAJw=;
	b=KpccPDeE+wwk9dDhrW1VJb86aaO0ndsNOVDcVIM6jyKFODiG7T1EpQirrgWBW5Q4a2M9d7
	+Q73MJkSbMtlQSCw==
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
Subject: [patch V2 27/50] posix-timers: Cure si_sys_private race
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:59 +0200 (CEST)

The si_sys_private member of the siginfo which is embedded in the
preallocated sigqueue is used by the posix timer code to decide whether a
timer must be reprogrammed on signal delivery.

The handling of this is racy as a long standing comment in that code
documents. It is modified with the timer lock held, but without sighand
lock being held. The actual signal delivery code checks for it under
sighand lock without holding the timer lock.

Hand the new value to send_sigqueue() as argument and store it with sighand
lock held.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/signal.h |    2 +-
 kernel/signal.c              |   10 +++++++++-
 kernel/time/posix-timers.c   |   15 +--------------
 3 files changed, 11 insertions(+), 16 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -339,7 +339,7 @@ extern int send_sig(int, struct task_str
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
+extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1919,7 +1919,7 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
+int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
 {
 	int sig = q->info.si_signo;
 	struct sigpending *pending;
@@ -1954,6 +1954,14 @@ int send_sigqueue(struct sigqueue *q, st
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
+	/*
+	 * Update @q::info::si_sys_private for posix timer signals with
+	 * sighand locked to prevent a race against dequeue_signal() which
+	 * decides based on si_sys_private whether to invoke
+	 * posixtimer_rearm() or not.
+	 */
+	q->info.si_sys_private = si_private;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,21 +299,8 @@ int posix_timer_queue_signal(struct k_it
 	if (timr->it_interval)
 		si_private = ++timr->it_requeue_pending;
 
-	/*
-	 * FIXME: if ->sigq is queued we can race with
-	 * dequeue_signal()->posixtimer_rearm().
-	 *
-	 * If dequeue_signal() sees the "right" value of
-	 * si_sys_private it calls posixtimer_rearm().
-	 * We re-queue ->sigq and drop ->it_lock().
-	 * posixtimer_rearm() locks the timer
-	 * and re-schedules it while ->sigq is pending.
-	 * Not really bad, but not that we want.
-	 */
-	timr->sigq->info.si_sys_private = si_private;
-
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }


