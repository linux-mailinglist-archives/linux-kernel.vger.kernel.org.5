Return-Path: <linux-kernel+bounces-139472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D68A03A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB41F2671C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEF51C50;
	Wed, 10 Apr 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HEm37kCg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKIWlwuE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0F50A79
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789209; cv=none; b=fUCFX700RVWEDZdOd2P9gOoJxmK6nhmR1ecO4AoovN7QI80EGZqTNPuIx4A+NgLpXRXGHHhYcQdTPjc5YeCkSOW9yWwhvLdqdg5XY8a0iH3b3u4HqsHFIMJSvAxB5LJKLmxkBp2cy0AXQw39ggfLFsf+sPYWRp7xF5yvTAvV0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789209; c=relaxed/simple;
	bh=pmCbpSGE0XRK0ukKqo1U6qxPo/JyzQDl0umJpcWyXGY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ig+F5iJOsb9ndo0oZnyV6p1k6QlH1N0tTODxwyz3Bk1jAKHKSdNoj5ENfQX3hNTnRhs94q7pZ1x6EKsPLkI6RnMQg40vkSd4kegchaTxipPT69BJCArbTqBKGGlLJt3z9+woH5rPQ2dsj1fK8sCjx4+Xstr+yxDffh/Y0dfJibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HEm37kCg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKIWlwuE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.133844381@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6GMzkiAHRvFkC+fzhDyL20WSpzWzUN7g85C6W+O5hxI=;
	b=HEm37kCgKIYq1xXA7Xhxbl8h4sWdXv5kXz//YqGI7k0AiHBNWfn5QH7xh2DBmS5ZoquJGq
	PMTySSzPlY741xYVP2ymhWjlggwQxjlmxGLEcQewa0YooznKYwuyZLoqFALSGSFsxciM1F
	CJ05jPO5CelgyoR9ByWYa9DoMeLmqtCh1hrnaZuOA7WVSYK+AHI+0fSWa8V9o6PlaApjyI
	GOou4O7ThGoRJadYOM4Zmj6Kt5/ODvp5tf9dps9lrbQeBjoUGAHRsAucLYFGmWsPxxDtqN
	liYOawtC7FkrWIdKaDZdFRSoOTYCKXOEPs4GoSV+W2WhCZh+zGscw0J8EhEmmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6GMzkiAHRvFkC+fzhDyL20WSpzWzUN7g85C6W+O5hxI=;
	b=wKIWlwuE0WHxWUlDrbEqKDSA7uQv9EvXU/k4BPGT34IeHBUL/ycWuYeH3SxjCx0NvXEnmi
	SrL/KGTagzcUCYAQ==
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
Subject: [patch V2 19/50] posix-timers: Convert timer list to hlist
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:45 +0200 (CEST)

No requirement for a real list. Spare a few bytes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 fs/proc/base.c               |    6 +++---
 include/linux/posix-timers.h |    2 +-
 include/linux/sched/signal.h |    2 +-
 init/init_task.c             |    2 +-
 kernel/fork.c                |    2 +-
 kernel/time/posix-timers.c   |   19 ++++++++-----------
 6 files changed, 15 insertions(+), 18 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2456,13 +2456,13 @@ static void *timers_start(struct seq_fil
 	if (!tp->sighand)
 		return ERR_PTR(-ESRCH);
 
-	return seq_list_start(&tp->task->signal->posix_timers, *pos);
+	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
 }
 
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp = m->private;
-	return seq_list_next(v, &tp->task->signal->posix_timers, pos);
+	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
 }
 
 static void timers_stop(struct seq_file *m, void *v)
@@ -2491,7 +2491,7 @@ static int show_timer(struct seq_file *m
 		[SIGEV_THREAD] = "thread",
 	};
 
-	timer = list_entry((struct list_head *)v, struct k_itimer, list);
+	timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
 	notify = timer->it_sigev_notify;
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -158,7 +158,7 @@ static inline void posix_cputimers_init_
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
-	struct list_head	list;
+	struct hlist_node	list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -137,7 +137,7 @@ struct signal_struct {
 
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
-	struct list_head	posix_timers;
+	struct hlist_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -29,7 +29,7 @@ static struct signal_struct init_signals
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers = LIST_HEAD_INIT(init_signals.posix_timers),
+	.posix_timers	= HLIST_HEAD_INIT,
 	.cputimer	= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1876,7 +1876,7 @@ static int copy_signal(unsigned long clo
 	prev_cputime_init(&sig->prev_cputime);
 
 #ifdef CONFIG_POSIX_TIMERS
-	INIT_LIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -515,7 +515,7 @@ static int do_timer_create(clockid_t whi
 	spin_lock_irq(&current->sighand->siglock);
 	/* This makes the timer valid in the hash table */
 	WRITE_ONCE(new_timer->it_signal, current->signal);
-	list_add(&new_timer->list, &current->signal->posix_timers);
+	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
@@ -1025,7 +1025,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	}
 
 	spin_lock(&current->sighand->siglock);
-	list_del(&timer->list);
+	hlist_del(&timer->list);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1075,7 +1075,7 @@ static void itimer_delete(struct k_itime
 
 		goto retry_delete;
 	}
-	list_del(&timer->list);
+	hlist_del(&timer->list);
 
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
@@ -1096,22 +1096,19 @@ static void itimer_delete(struct k_itime
  */
 void exit_itimers(struct task_struct *tsk)
 {
-	struct list_head timers;
-	struct k_itimer *tmr;
+	struct hlist_head timers;
 
-	if (list_empty(&tsk->signal->posix_timers))
+	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
 
 	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
-	list_replace_init(&tsk->signal->posix_timers, &timers);
+	hlist_move_list(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!list_empty(&timers)) {
-		tmr = list_first_entry(&timers, struct k_itimer, list);
-		itimer_delete(tmr);
-	}
+	while (!hlist_empty(&timers))
+		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,


