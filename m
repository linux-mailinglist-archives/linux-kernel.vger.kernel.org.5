Return-Path: <linux-kernel+bounces-139496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F58A03B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B4128B6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0B134CE3;
	Wed, 10 Apr 2024 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SIHbGenp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lUXOrPoD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850A13248B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789251; cv=none; b=BFZkKHGkgG48gpNev/rwJTF3/L4jymuaKNPtGxiRjpuR1bRahcUejMqMbb0BMnIPag7ybpFGSk6FVjQeujlanOpcNq1OGCuLI2YteJU4UnSo3S+PBc5sZP1zYgdRyBZVgqfp1YNbKbo4QOeDlMdqHqWtwwPFrLEDegoNKJUGCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789251; c=relaxed/simple;
	bh=H8C4ae3qB9pJTAhYrEUW6UIkzelbDNrIyM/SxoxcYVc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ms2m+6btisAVZ5j2KUp1HijTjKVJRMdBV0SvHIu4mIl4K8YZo9vyxvJ/SJSJXfKilz79NcP7kVAy2e+98N0ukcCYTQBfB1lpcO1SjVl6KTnHjmmQYBJSkWqBsqNRmghYTSsaUU1B+dpBjrAie7F4lf5lbhNbgvZwPQ9gIUHcO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SIHbGenp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lUXOrPoD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.636753630@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gS0GunzjJF0mIhSZ9sJXDkEdhMOznUExWpmLyjVDd8s=;
	b=SIHbGenp76SOLVBs2dAVyy4fAMu+LZLTM/FfoCydWnvcOyeVcs0e2Ctnjy6Y3/oIYFsoHp
	mrVNV4oTcW8ky86GK0kmy7K3qFC9zlG46RxpYdZW8NlJGpp0ubRHiocrJXiC3Xn/y+gcFA
	OcBNNZhUfevnKD2S33f0OhFo3NQGgy7gRXVQJ+PF9CoTGszsQNp6eycRPcHTLDWik39P4g
	NRJoEPEguuLlfD5qgVkRTnhfqcUjJpyVvJ6RM/DOET2BEyFBEzBqOdvhP0oeEbF5ZqiOl8
	eIalQiEhI3gvxVJspxs4rq+Vl9lEiJ77YGLjK+wpv98S5Hdnnzai8XsoCwcY7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gS0GunzjJF0mIhSZ9sJXDkEdhMOznUExWpmLyjVDd8s=;
	b=lUXOrPoD+iJthx03iSV1MRAA+nF/RxjZnoJ9yWD7k+5odTGsMjLbHg9bA3O3ehohvd+mkR
	38HzHIdZlHcR+uDQ==
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
Subject: [patch V2 43/50] signal: Add task argument to flush_sigqueue_mask()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:27 +0200 (CEST)

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a task argument to flush_sigqueue_mask() and fixup all call sites.

This argument will be used in a later step to enqueue posix timers on an
ignored list, so their signal can be requeued when SIG_IGN is lifted later
on.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -724,11 +724,10 @@ void signal_wake_up_state(struct task_st
 
 /*
  * Remove signals in mask from the pending set and queue.
- * Returns 1 if any signals were found.
  *
  * All callers must be holding the siglock.
  */
-static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s, struct task_struct *ptmr_tsk)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
@@ -866,18 +865,18 @@ static bool prepare_signal(int sig, stru
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
 		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t)
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 	} else if (sig == SIGCONT) {
 		unsigned int why;
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
 		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED))) {
 				t->jobctl &= ~JOBCTL_STOPPED;
@@ -4155,8 +4154,8 @@ void kernel_sigaction(int sig, __sighand
 		sigemptyset(&mask);
 		sigaddset(&mask, sig);
 
-		flush_sigqueue_mask(&mask, &current->signal->shared_pending);
-		flush_sigqueue_mask(&mask, &current->pending);
+		flush_sigqueue_mask(&mask, &current->signal->shared_pending, NULL);
+		flush_sigqueue_mask(&mask, &current->pending, NULL);
 		recalc_sigpending();
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -4223,9 +4222,9 @@ int do_sigaction(int sig, struct k_sigac
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending);
+				flush_sigqueue_mask(&mask, &t->pending, NULL);
 		}
 	}
 


