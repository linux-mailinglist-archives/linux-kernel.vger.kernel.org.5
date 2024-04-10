Return-Path: <linux-kernel+bounces-139500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3588A03BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4651F29A24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D387136E0D;
	Wed, 10 Apr 2024 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPQqvvBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YhNl7uJX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8E136E00
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789256; cv=none; b=PINF3qYgDRnhJR0DL5QSj7zx+NFB53OBFKwwcE+xrDE8wUhg+2MaVJEBjnCX1iyzOS5QoPBToXAN+H4ZYv8aR6HQv/jF1gyMLaYcSh9K1SxPgaZFJk3JPfGMAJ/J6LCCg344Oeu7mb2AJCsJYt7i7ztMF5+x9OVEnx1WHDGPEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789256; c=relaxed/simple;
	bh=Kaitif/719xp2xVCsTipKGEhafvxHZw3eYIDLxrxhD4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tVbk0+cuU6+c0+jBQHC9ya4haCIh0LA/hSrzYbpTjV+Rv66ElnkvDNYWq7CHH+Q7pXu3VgctROKE/IVLZurr66Q16Z5XenbZaFqs64wPr6XsfJmWPoHoqCp7Ga353sixD0UlZm/epxstUk92JYE1+VdjfOhbjAlb53EGNjNTuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wPQqvvBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YhNl7uJX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.820640735@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TLf+HH0NPG+O40MqHfVvMTLhniRUMJJ6i8JJ174+iCU=;
	b=wPQqvvBOu/geE0SSLMNT8rSv5WiV+XmXZL+SewO9aQzpikSOothjioLtJqbS/WBSWwwF1b
	rUf/UzvgrzQg8B6KsjHCTQ9csFJ/DjxUGtvPCxI4Hy8BV/s61msp7GF0oJPK6OPXJa1f4f
	4q2SVh6d4BCaBJBtvZVm0bEAy5tDmvA5z9zg3NXYBZhu/h2hRK7bBBqV61fmmrhuKugV5Z
	eVNQ/YY4mgHcn3Ls8tcd5FUZRGvwMB4F0P6uFYdKjO2KwKgszfLK3RacYR3+5i2Enn7V2E
	oXqln6OpykbL+HIX+iYERgTRQRzpuqLFkxNNnWnJx1LymRm/0TP2VBZqOqNPtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TLf+HH0NPG+O40MqHfVvMTLhniRUMJJ6i8JJ174+iCU=;
	b=YhNl7uJXnHg0KUvq8XAAfyDPEd8bbrLHrifvknMG2s3N+AoTMHhELDkkswXGxb95u8rQkX
	z2Nsj9uKn8d7HLCw==
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
Subject: [patch V2 46/50] signal: Handle ignored signals in
 do_sigaction(action != SIG_IGN)
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:33 +0200 (CEST)

When a real handler (including SIG_DFL) is installed for a signal, which
had previously SIG_IGN set, then the list of ignored posix timers has to be
checked for timers which are affected by this change.

Add a list walk function which checks for the matching signal number and if
found requeues the timers signal, so the timer is rearmed on signal
delivery.

Rearming the timer right away is not possible because that requires to drop
sighand lock.

No functional change as the counter part which queues the timers on the
ignored list is still missing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2035,7 +2035,55 @@ int posixtimer_send_sigqueue(struct k_it
 	rcu_read_unlock();
 	return ret;
 }
-#endif /* CONFIG_POSIX_TIMERS */
+
+static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
+{
+	struct hlist_head *head = &tsk->signal->ignored_posix_timers;
+	struct hlist_node *tmp;
+	struct k_itimer *tmr;
+
+	if (likely(hlist_empty(head)))
+		return;
+
+	/*
+	 * Rearming a timer with sighand lock held is not possible due to
+	 * lock ordering vs. tmr::it_lock. Just stick the sigqueue back and
+	 * let the signal delivery path deal with it whether it needs to be
+	 * rearmed or not. This cannot be decided here w/o dropping sighand
+	 * lock and creating a loop retry horror show.
+	 */
+	hlist_for_each_entry_safe(tmr, tmp , head, ignored_list) {
+		struct task_struct *target;
+
+		/*
+		 * tmr::sigq.info.si_signo is immutable, so accessing it
+		 * without holding tmr::it_lock is safe.
+		 */
+		if (tmr->sigq.info.si_signo != sig)
+			continue;
+
+		hlist_del_init(&tmr->ignored_list);
+
+		/* This should never happen and leaks a reference count */
+		if (WARN_ON_ONCE(!list_empty(&tmr->sigq.list)))
+			continue;
+
+		/*
+		 * Get the target for the signal. If target is a thread and
+		 * has exited by now, drop the reference count.
+		 */
+		rcu_read_lock();
+		target = posixtimer_get_target(tmr);
+		if (target)
+			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
+		else
+			posixtimer_putref(tmr);
+		rcu_read_unlock();
+	}
+}
+#else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
+#endif /* !CONFIG_POSIX_TIMERS */
 
 void do_notify_pidfd(struct task_struct *task)
 {
@@ -4205,6 +4253,8 @@ int do_sigaction(int sig, struct k_sigac
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
+		bool was_ignored = k->sa.sa_handler == SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k = *act;
@@ -4225,6 +4275,8 @@ int do_sigaction(int sig, struct k_sigac
 			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(&mask, &t->pending, NULL);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
 


