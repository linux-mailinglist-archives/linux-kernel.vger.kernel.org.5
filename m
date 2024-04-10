Return-Path: <linux-kernel+bounces-139501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E38A03BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7628C8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005104174C;
	Wed, 10 Apr 2024 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZULKCBP7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+aDrg01"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927E137746
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789258; cv=none; b=tW59qm3Q1H7c9qJvBMs1qfNShjPFy3NZWwlrHDwzlN55CyNfzMPMyLuLGJD/eGjlsnJibP3Na4s2YYFdIkb/YjZLf0zxob3yvC34vZjVYqxKWL76z4ynOyaE8Ldhu2tVz8pvcVrnsv2RHA6lSuGcqVAvYdpGGAwvOv8pSYqt7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789258; c=relaxed/simple;
	bh=ojSHAmzDSUCtV20tG0Eic6qt8OMUSGLWdNQCp73/DO0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CFYeSx/Y0L/tuiAkMmPx4tmFtgFMzc5XV63U9xWqI0FEyk5ysu413aEbeAPAclJDfJFvfo/kfGHvcH2fmZ3UUFZ9K03Q/ezue+fOEsJv3qq7pD+2yrY28koXVv0tJKjPX7aXDIz7suTdAQi9hjm9gcbEsezE+YftPWoYMDJaozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZULKCBP7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A+aDrg01; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.882049383@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bzEboz8AUjwt0LmBupDNjtajHSCekoKcw08hOKXcNgs=;
	b=ZULKCBP76zpp9/bl0KZoilv8DFZ/NLPLD4CS6xtmVCfo5zqztBAhbPUwmCNzkKCA4xc8/m
	wyIHhJQPtDu+O5+eM+r64YmfrKgXlk38qIVp2dqTTtQVC83g/RtNo8GlIq6nvRrW05KKTe
	5oqbnZmdGqqBmdOvhqMCsxd4HUH8IjgRehupAvb+ZbIu+emUdznD7vK9ZlvglgTs4E9ZFe
	xCV0rORN7i/lVC6yIohKT+1N7TV+/CgNxbIq44K4Ad65sNP/Tus6ETKYWI0eVe1X9Hfc79
	JC+80h1LZJVEr9/2mH6e1dW+iVVyvI9tmYOlD55IE5xpCuP2VNlLPTLnpydpAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bzEboz8AUjwt0LmBupDNjtajHSCekoKcw08hOKXcNgs=;
	b=A+aDrg01PivhTTdDSGJ0HCSDxhdjuor8i5KU9ixzsV0uwoO8VO/Zr4oM6XTWohXKMPl/PL
	bWV/A8Rp5J2tZZDw==
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
Subject: [patch V2 47/50] signal: Queue ignored posixtimers on ignore list
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:34 +0200 (CEST)

Queue posixtimers which have their signal ignored on the ignored list:

   1) When the timer fires and the signal has SIG_IGN set

   2) When SIG_IGN is installed via sigaction() and a timer signal
      is queued

This completes the SIG_IGN handling and such timers are not longer self
rearmed which avoids pointless wakeups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -722,6 +722,16 @@ void signal_wake_up_state(struct task_st
 		kick_process(t);
 }
 
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
+
+static void sigqueue_free_ignored(struct task_struct *ptmr_tsk, struct sigqueue *q)
+{
+	if (likely(!ptmr_tsk || q->info.si_code != SI_TIMER))
+		__sigqueue_free(q);
+	else
+		posixtimer_sig_ignore(ptmr_tsk, q);
+}
+
 /*
  * Remove signals in mask from the pending set and queue.
  *
@@ -740,7 +750,7 @@ static void flush_sigqueue_mask(sigset_t
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(ptmr_tsk, q);
 		}
 	}
 }
@@ -1964,9 +1974,8 @@ int posixtimer_send_sigqueue(struct k_it
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
-	ret = -1;
 	rcu_read_lock();
 
 	t = posixtimer_get_target(tmr);
@@ -2012,13 +2021,24 @@ int posixtimer_send_sigqueue(struct k_it
 	 */
 	q->info.si_overrun = 0;
 
-	ret = 1; /* the signal is ignored */
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
+
+		/* Paranoia check. Try to survive. */
+		if (WARN_ON_ONCE(!list_empty(&q->list)))
+			goto out;
+
+		if (hlist_unhashed(&tmr->ignored_list)) {
+			hlist_add_head(&tmr->ignored_list, &t->signal->ignored_posix_timers);
+			posixtimer_sigqueue_getref(q);
+		}
 		goto out;
 	}
 
-	ret = 0;
+	/* This should never happen and leaks a reference count */
+	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
+		hlist_del_init(&tmr->ignored_list);
+
 	if (unlikely(!list_empty(&q->list))) {
 		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
@@ -2033,7 +2053,14 @@ int posixtimer_send_sigqueue(struct k_it
 	unlock_task_sighand(t, &flags);
 ret:
 	rcu_read_unlock();
-	return ret;
+	return 0;
+}
+
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
 }
 
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
@@ -2082,6 +2109,7 @@ static void posixtimer_sig_unignore(stru
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
@@ -4272,9 +4300,9 @@ int do_sigaction(int sig, struct k_sigac
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
+			flush_sigqueue_mask(&mask, &p->signal->shared_pending, p);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending, NULL);
+				flush_sigqueue_mask(&mask, &t->pending, p);
 		} else if (was_ignored) {
 			posixtimer_sig_unignore(p, sig);
 		}


