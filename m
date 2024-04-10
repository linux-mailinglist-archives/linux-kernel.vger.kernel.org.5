Return-Path: <linux-kernel+bounces-139494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08998A03B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F418D1C21118
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6386D40860;
	Wed, 10 Apr 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3kbH20h3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJEnKXMJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0713175F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789248; cv=none; b=bNVpeR9RueThE8ZQAbkPPPl+ShyhAnxGMHv76UkkcFWpjsptRdSztIDYUi2beQmpj+VhKDDjHU/TD2Met+MoGJ/4aW/DBmoyfBekjuSjHsTUmwUNQS1eSubKiTWGlYAtkWxzHS3AIOetxGaV7pbot0iK5ZC0D8sPGzRN45TSNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789248; c=relaxed/simple;
	bh=Av97VYgeAlc/bafwWL1PU9mzhCMFWi3Lv4kAdQb33FE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gUgnfpSs6rlmYfUTYziSNIhDjply2LyGj9t/gQAFslqaGodaYcjszooDd4EiLegWT7u/P4/gogElkSSjP7600XKSQAhJlld8+wxBj1zUbkS+Zf6Cun8kv4Tg7TPS7lg+dj54ucsWUZl3Nmfma6UDRMd2FUMIFC8B9chekCR2pVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3kbH20h3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJEnKXMJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.514023899@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QZvmW79aSWaOCLeBfAMHsnSFDDjvmnR1BtBxPWfUF0o=;
	b=3kbH20h3GZBDT7shxup5NTYfeMLvf3Fo/aRo/kt4GJ8Vq4mO6y27gUh04toPQDEjGFFvVu
	lJfJ9xZ3nl7sgSJU1EKmrR01OkZdJneyb3sDEmjlvGydr6YpNgEJzJrEd+AjHtnv4J+q/h
	f0NVVhnAEUkdBMUp1wMEfstsXKsXRlWbwMzv/k3DaO1AhyZ8zmoYWCSqJgSNIsZNMEuwCk
	X09iiFqb7cU+aFkAsLtY/eBl4GzMwayCpv3xpdEiS6n79Knu3fPBQhTxozj+wz/4M/IeMB
	m6IScmcwNGBP/+4qnkRt6Z1mlwfYCz+vyZ4t98hfMdzp8PILs6xQ1DBPEMFasA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QZvmW79aSWaOCLeBfAMHsnSFDDjvmnR1BtBxPWfUF0o=;
	b=iJEnKXMJm8xIPDPMgynOSaA0BIlaEPHaDWzLBvhifC8kErPdix45lr1aVBuogeAQSSSR3r
	q5yggw1Or2DBViAQ==
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
Subject: [patch V2 41/50] posix-timers: Embed sigqueue in struct k_itimer
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:24 +0200 (CEST)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Now that the prerequisites are in place, embed the sigqueue into struct
k_itimer and fixup the relevant usage sites.

Aside of preparing for proper SIG_IGN handling, this spares an extra
allocation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/base.c               |    4 +-
 include/linux/posix-timers.h |   23 +++++++++++++++-
 kernel/signal.c              |   12 +++++++-
 kernel/time/posix-timers.c   |   59 ++++++++++++++++++++++++++-----------------
 4 files changed, 69 insertions(+), 29 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2496,8 +2496,8 @@ static int show_timer(struct seq_file *m
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
 	seq_printf(m, "signal: %d/%px\n",
-		   timer->sigq->info.si_signo,
-		   timer->sigq->info.si_value.sival_ptr);
+		   timer->sigq.info.si_signo,
+		   timer->sigq.info.si_value.sival_ptr);
 	seq_printf(m, "notify: %s/%s.%d\n",
 		   nstr[notify & ~SIGEV_THREAD_ID],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -39,6 +39,8 @@ static inline int clockid_to_fd(const cl
 
 #ifdef CONFIG_POSIX_TIMERS
 
+#include <linux/signal_types.h>
+
 /**
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
@@ -165,7 +167,7 @@ static inline void posix_cputimers_init_
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
  * @rcuref:		Reference count for life time management
- * @sigq:		Pointer to preallocated sigqueue
+ * @sigq:		Embedded sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
  * @rcu:		RCU head for freeing the timer.
@@ -189,7 +191,7 @@ struct k_itimer {
 		struct pid		*it_pid;
 		struct task_struct	*it_process;
 	};
-	struct sigqueue		*sigq;
+	struct sigqueue		sigq;
 	rcuref_t		rcuref;
 	union {
 		struct {
@@ -217,6 +219,23 @@ static inline void posixtimer_putref(str
 	if (rcuref_put(&tmr->rcuref))
 		posixtimer_free_timer(tmr);
 }
+
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	WARN_ON_ONCE(!rcuref_get(&tmr->rcuref));
+}
+
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	posixtimer_putref(tmr);
+}
+#else  /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
 #endif
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -566,7 +566,12 @@ static void collect_signal(int sig, stru
 still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
-		__sigqueue_free(first);
+		/*
+		 * Do not drop the reference count for posix timer
+		 * signals. That's done in posix_timer_deliver_signal().
+		 */
+		if (info->si_code != SI_TIMER)
+			__sigqueue_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -1985,7 +1990,7 @@ static inline struct task_struct *posixt
 
 int posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
-	struct sigqueue *q = tmr->sigq;
+	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
@@ -2045,9 +2050,12 @@ int posixtimer_send_sigqueue(struct k_it
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
+		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
+
+	posixtimer_sigqueue_getref(q);
 	posixtimer_queue_sigqueue(q, t, tmr->it_pid_type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,12 +251,13 @@ static void common_hrtimer_rearm(struct
 
 /*
  * This function is called from the signal delivery code. It decides
- * whether the signal should be dropped and rearms interval timers.
+ * whether the signal should be dropped and rearms interval timers.  The
+ * timer can be unconditionally accessed as there is a reference held on
+ * it.
  */
 bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
-	struct k_itimer *timr;
-	unsigned long flags;
+	struct k_itimer *timr = info->si_sys_privptr;
 	bool ret = false;
 
 	/*
@@ -264,12 +265,14 @@ bool posixtimer_deliver_signal(struct ke
 	 * timr::it_lock. Keep interrupts disabled.
 	 */
 	spin_unlock(&current->sighand->siglock);
+	spin_lock(&timr->it_lock);
 
-	timr = lock_timer(info->si_tid, &flags);
-	if (!timr)
-		goto out;
-
-	if (timr->it_signal_seq != info->si_sys_private)
+	/*
+	 * Check if the timer is still alive or whether it got modified
+	 * since the signal was queued. In either case, don't rearm and
+	 * drop the signal.
+	 */
+	if (!timr->it_signal || timr->it_signal_seq != info->si_sys_private)
 		goto out_unlock;
 
 	if (timr->it_interval && timr->it_status == POSIX_TIMER_REQUEUE_PENDING) {
@@ -285,8 +288,10 @@ bool posixtimer_deliver_signal(struct ke
 	ret = true;
 
 out_unlock:
-	unlock_timer(timr, flags);
-out:
+	spin_unlock(&timr->it_lock);
+	/* Drop the reference which was acquired when the signal was queued */
+	posixtimer_putref(timr);
+
 	spin_lock(&current->sighand->siglock);
 
 	/* Don't expose the si_sys_priv* values to userspace */
@@ -405,17 +410,17 @@ static struct pid *good_sigevent(sigeven
 	}
 }
 
-static struct k_itimer * alloc_posix_timer(void)
+static struct k_itimer *alloc_posix_timer(void)
 {
 	struct k_itimer *tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
 
 	if (!tmr)
 		return tmr;
-	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
+
+	if (unlikely(!posixtimer_init_sigqueue(&tmr->sigq))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		return NULL;
 	}
-	clear_siginfo(&tmr->sigq->info);
 	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
@@ -430,7 +435,8 @@ static void k_itimer_rcu_free(struct rcu
 void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
-	sigqueue_free(tmr->sigq);
+	if (tmr->sigq.ucounts)
+		dec_rlimit_put_ucounts(tmr->sigq.ucounts, UCOUNT_RLIMIT_SIGPENDING);
 	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
@@ -492,13 +498,13 @@ static int do_timer_create(clockid_t whi
 			goto out;
 		}
 		new_timer->it_sigev_notify     = event->sigev_notify;
-		new_timer->sigq->info.si_signo = event->sigev_signo;
-		new_timer->sigq->info.si_value = event->sigev_value;
+		new_timer->sigq.info.si_signo = event->sigev_signo;
+		new_timer->sigq.info.si_value = event->sigev_value;
 	} else {
 		new_timer->it_sigev_notify     = SIGEV_SIGNAL;
-		new_timer->sigq->info.si_signo = SIGALRM;
-		memset(&new_timer->sigq->info.si_value, 0, sizeof(sigval_t));
-		new_timer->sigq->info.si_value.sival_int = new_timer->it_id;
+		new_timer->sigq.info.si_signo = SIGALRM;
+		memset(&new_timer->sigq.info.si_value, 0, sizeof(sigval_t));
+		new_timer->sigq.info.si_value.sival_int = new_timer->it_id;
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
@@ -507,9 +513,9 @@ static int do_timer_create(clockid_t whi
 	else
 		new_timer->it_pid_type = PIDTYPE_TGID;
 
-	new_timer->sigq->info.si_tid   = new_timer->it_id;
-	new_timer->sigq->info.si_code  = SI_TIMER;
-	new_timer->sigq->info.si_sys_privptr  = new_timer;
+	new_timer->sigq.info.si_tid = new_timer->it_id;
+	new_timer->sigq.info.si_code = SI_TIMER;
+	new_timer->sigq.info.si_sys_privptr = new_timer;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;
@@ -593,7 +599,14 @@ static struct k_itimer *__lock_timer(tim
 	 *  1) Set timr::it_signal to NULL with timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
-	 *  4) Call RCU for removal after the grace period
+	 *  4) Put the reference count.
+	 *
+	 * The reference count might not drop to zero if timr::sigq is
+	 * queued. In that case the signal delivery or flush will put the
+	 * last reference count.
+	 *
+	 * When the reference count reaches zero, the timer is scheduled
+	 * for RCU removal after the grace period.
 	 *
 	 * Holding rcu_read_lock() accross the lookup ensures that
 	 * the timer cannot be freed.


