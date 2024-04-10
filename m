Return-Path: <linux-kernel+bounces-139478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089188A03A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE1FB221FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16F5577C;
	Wed, 10 Apr 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSHu0Muz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6/bhmbRJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15654772
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789220; cv=none; b=ZbdeWnSvhEW7QO6ZjtjQ3rwDxbHDIBDWlEV+viqgZs8WUf0lMj6WZzVPvNVr4hUAweTldlY66WffRykIRoao+H5N1xECOld3QnB19VrhbOFJEPKlwpxROHe01TZv6+CbXG1c7xdvi0p1Nzvex/K9CQ9/s8Sfr3+Ie2T67P5G7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789220; c=relaxed/simple;
	bh=TKJn1dWiLSzYuFWlYalQBj85JnAn82gG7J9kjYz+D/0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iQiPlG7sM7r5yQlvcl+AdQJr2PBrga+ah0pZ/wn2PdZwBeeSgAEKYxAPTKO1ecyYwaioZbvO3sb++AeaZYJVy9sIl58YJJqOcCn9ammynHs6Pu5mTtzXW6aeZ7P4OW0T/1jFlxUzPOw3MbUo+aRJ2OGYZo94MMGnFv8e5/EpIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSHu0Muz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6/bhmbRJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.509700441@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Zqea4ZCKHXjl0dJ4sa3tZPhdgHz3TXIy35qUKT56zVA=;
	b=cSHu0MuzZO+1skf/vLAKbmPMJ3mrTqt2Hges/1yKRdZ/RUG0jv5nbJpwWnU8M+lHxQnBvJ
	MiocgRQItWCYoTRBlnAgBrT8Y5mPPK14LuwmpRQi5G8Pplt+mAN/HG9hkzNcFxDkMgSg4r
	TjlH/wGSYLPzWL6gQM+tVff8EUK3PMd7my1XdcFaV78EW7GUNslPgIAR8r+VY5OpaXtbdo
	ExBhUnGN8hNa8LVaGlPJ5EQquL3tPG3WBuhHLzi6ewlYSwznCJFA/FNoJa5StrSPEnOIjb
	l+kw02VuwwHPLoEM0Y8dGmDqq/kbh4zDQpM/dbWuur/jMfR0gu91HUA3GWjS1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Zqea4ZCKHXjl0dJ4sa3tZPhdgHz3TXIy35qUKT56zVA=;
	b=6/bhmbRJyclGwlsKMNeILN5t6+UAO3qt/n4F/aQWdxoRooyIiEuo//ir+nKWJrLkoOZROp
	yW+PM1gp5esmmBBQ==
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
Subject: [patch V2 25/50] signal: Confine POSIX_TIMERS properly
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:56 +0200 (CEST)

Move the itimer rearming out of the signal code and consolidate all posix
timer related functions in the signal code under one ifdef.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    5 +
 kernel/signal.c              |  125 +++++++++++++++----------------------------
 kernel/time/itimer.c         |   22 +++++++
 kernel/time/posix-timers.c   |   15 ++++-
 4 files changed, 82 insertions(+), 85 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -100,6 +100,8 @@ static inline void posix_cputimers_rt_wa
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+void posixtimer_rearm_itimer(struct task_struct *p);
+void posixtimer_rearm(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -122,6 +124,8 @@ struct cpu_timer { };
 static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
+static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
+static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -196,5 +200,4 @@ void set_process_cpu_timer(struct task_s
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
-void posixtimer_rearm(struct kernel_siginfo *info);
 #endif
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -478,42 +478,6 @@ void flush_signals(struct task_struct *t
 }
 EXPORT_SYMBOL(flush_signals);
 
-#ifdef CONFIG_POSIX_TIMERS
-static void __flush_itimer_signals(struct sigpending *pending)
-{
-	sigset_t signal, retain;
-	struct sigqueue *q, *n;
-
-	signal = pending->signal;
-	sigemptyset(&retain);
-
-	list_for_each_entry_safe(q, n, &pending->list, list) {
-		int sig = q->info.si_signo;
-
-		if (likely(q->info.si_code != SI_TIMER)) {
-			sigaddset(&retain, sig);
-		} else {
-			sigdelset(&signal, sig);
-			list_del_init(&q->list);
-			__sigqueue_free(q);
-		}
-	}
-
-	sigorsets(&pending->signal, &signal, &retain);
-}
-
-void flush_itimer_signals(void)
-{
-	struct task_struct *tsk = current;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	__flush_itimer_signals(&tsk->pending);
-	__flush_itimer_signals(&tsk->signal->shared_pending);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
-}
-#endif
-
 void ignore_signals(struct task_struct *t)
 {
 	int i;
@@ -636,31 +600,9 @@ int dequeue_signal(sigset_t *mask, kerne
 		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info, &resched_timer);
-#ifdef CONFIG_POSIX_TIMERS
-		/*
-		 * itimer signal ?
-		 *
-		 * itimers are process shared and we restart periodic
-		 * itimers in the signal delivery path to prevent DoS
-		 * attacks in the high resolution timer case. This is
-		 * compliant with the old way of self-restarting
-		 * itimers, as the SIGALRM is a legacy signal and only
-		 * queued once. Changing the restart behaviour to
-		 * restart the timer in the signal dequeue path is
-		 * reducing the timer noise on heavy loaded !highres
-		 * systems too.
-		 */
-		if (unlikely(signr == SIGALRM)) {
-			struct hrtimer *tmr = &tsk->signal->real_timer;
 
-			if (!hrtimer_is_queued(tmr) &&
-			    tsk->signal->it_real_incr != 0) {
-				hrtimer_forward(tmr, tmr->base->get_time(),
-						tsk->signal->it_real_incr);
-				hrtimer_restart(tmr);
-			}
-		}
-#endif
+		if (unlikely(signr == SIGALRM))
+			posixtimer_rearm_itimer(tsk);
 	}
 
 	recalc_sigpending();
@@ -682,22 +624,12 @@ int dequeue_signal(sigset_t *mask, kerne
 		 */
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
-#ifdef CONFIG_POSIX_TIMERS
-	if (resched_timer) {
-		/*
-		 * Release the siglock to ensure proper locking order
-		 * of timer locks outside of siglocks.  Note, we leave
-		 * irqs disabled here, since the posix-timers code is
-		 * about to disable them again anyway.
-		 */
-		spin_unlock(&tsk->sighand->siglock);
-		posixtimer_rearm(info);
-		spin_lock(&tsk->sighand->siglock);
 
-		/* Don't expose the si_sys_private value to userspace */
-		info->si_sys_private = 0;
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		if (unlikely(resched_timer))
+			posixtimer_rearm(info);
 	}
-#endif
+
 	return signr;
 }
 EXPORT_SYMBOL_GPL(dequeue_signal);
@@ -1924,15 +1856,45 @@ int kill_pid(struct pid *pid, int sig, i
 }
 EXPORT_SYMBOL(kill_pid);
 
+#ifdef CONFIG_POSIX_TIMERS
 /*
- * These functions support sending signals using preallocated sigqueue
- * structures.  This is needed "because realtime applications cannot
- * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of POSIX Timers
- * we allocate the sigqueue structure from the timer_create.  If this
- * allocation fails we are able to report the failure to the application
- * with an EAGAIN error.
+ * These functions handle POSIX timer signals. POSIX timers use
+ * preallocated sigqueue structs for sending signals.
  */
+static void __flush_itimer_signals(struct sigpending *pending)
+{
+	sigset_t signal, retain;
+	struct sigqueue *q, *n;
+
+	signal = pending->signal;
+	sigemptyset(&retain);
+
+	list_for_each_entry_safe(q, n, &pending->list, list) {
+		int sig = q->info.si_signo;
+
+		if (likely(q->info.si_code != SI_TIMER)) {
+			sigaddset(&retain, sig);
+		} else {
+			sigdelset(&signal, sig);
+			list_del_init(&q->list);
+			__sigqueue_free(q);
+		}
+	}
+
+	sigorsets(&pending->signal, &signal, &retain);
+}
+
+void flush_itimer_signals(void)
+{
+	struct task_struct *tsk = current;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tsk->sighand->siglock, flags);
+	__flush_itimer_signals(&tsk->pending);
+	__flush_itimer_signals(&tsk->signal->shared_pending);
+	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
@@ -2029,6 +1991,7 @@ int send_sigqueue(struct sigqueue *q, st
 	rcu_read_unlock();
 	return ret;
 }
+#endif /* CONFIG_POSIX_TIMERS */
 
 void do_notify_pidfd(struct task_struct *task)
 {
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -151,7 +151,27 @@ COMPAT_SYSCALL_DEFINE2(getitimer, int, w
 #endif
 
 /*
- * The timer is automagically restarted, when interval != 0
+ * Invoked from dequeue_signal() when SIG_ALRM is delivered.
+ *
+ * Restart the ITIMER_REAL timer if it is armed as periodic timer.  Doing
+ * this in the signal delivery path instead of self rearming prevents a DoS
+ * with small increments in the high reolution timer case and reduces timer
+ * noise in general.
+ */
+void posixtimer_rearm_itimer(struct task_struct *tsk)
+{
+	struct hrtimer *tmr = &tsk->signal->real_timer;
+
+	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr != 0) {
+		hrtimer_forward(tmr, tmr->base->get_time(),
+				tsk->signal->it_real_incr);
+		hrtimer_restart(tmr);
+	}
+}
+
+/*
+ * Interval timers are restarted in the signal delivery path.  See
+ * posixtimer_rearm_itimer().
  */
 enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 {
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,7 +251,7 @@ static void common_hrtimer_rearm(struct
 
 /*
  * This function is called from the signal delivery code if
- * info->si_sys_private is not zero, which indicates that the timer has to
+ * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
 void posixtimer_rearm(struct kernel_siginfo *info)
@@ -259,9 +259,15 @@ void posixtimer_rearm(struct kernel_sigi
 	struct k_itimer *timr;
 	unsigned long flags;
 
+	/*
+	 * Release siglock to ensure proper locking order versus
+	 * timr::it_lock. Keep interrupts disabled.
+	 */
+	spin_unlock(&current->sighand->siglock);
+
 	timr = lock_timer(info->si_tid, &flags);
 	if (!timr)
-		return;
+		goto out;
 
 	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
@@ -275,6 +281,11 @@ void posixtimer_rearm(struct kernel_sigi
 	}
 
 	unlock_timer(timr, flags);
+out:
+	spin_lock(&current->sighand->siglock);
+
+	/* Don't expose the si_sys_private value to userspace */
+	info->si_sys_private = 0;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)


