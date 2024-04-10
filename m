Return-Path: <linux-kernel+bounces-139495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525198A03B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AFE1F29550
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525311327F3;
	Wed, 10 Apr 2024 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJvDVrTE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qylp4H7x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A40E40843
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789249; cv=none; b=N1t2TwbMQtzbvDRycRx1VCgKPVacS8T2G8Z5qKpzMcOdMuX8x8XKVLIDqW5vjCAvX/8LV8PPOmwlml21hVATbtG8dV0UO4PZ0OG9Pu9IDN2d13KPZKLqHiNFeb9jlwXnkUUcykQVzlwODIUkef+Y1BeMs0ewfuHSIdaFpwOLJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789249; c=relaxed/simple;
	bh=NFKqTJ9ShtyiYAgy+AdG3Zbk7Do+0qFmxaGilWT4BiI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UKstWOUTEeGccqdFQTRyi0ME8knCmelYlGrWD0+x01+UI7sr7Nl1RerWulbG0O1nqfGf64+r9HSbVRm6qRbuI1kwrWCyblcEmV7jalIDWLvjHMAMDiD1pEFlO/eF+9lIQSAe8EPtYX2X97tP5bfgZr3ekKnYUA6oulvDdnszeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJvDVrTE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qylp4H7x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.575951796@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DxPffv+7izSrJC7n0/k0QCEO3R4CfssBq8UJE3DdsrY=;
	b=rJvDVrTE+1ky0Yq0jWNVPhG+ArTg8A5L41Kqlyxk0d0qD6f9k6O8EsKOm+VYp+1XtOS1Ch
	WQx2Iudy9ve1/LrgseDKPxvsCYXRoLXdoJnBIav+XhFSCL2uB8cIm7Zs+uGnDj++hsvmK0
	kpOz0WgEjpoWn5nTxUDlc3DTddxw6nBWUpUULlmPLS2+VYtJi8aFpm6Y4aEMHKDcDPqXQc
	6s7lTpveHoJhj5EiTJs5sAgkl1WUZtetzQ5gvS+7JtWgtbv4rI5At3PszZ/Z+sWTwVCOjO
	sKAyj9yrowz5uA5mOH2OhdJKnT4iqbAS9ealmdx0S4A9I/Gdh/hsKZ6OmbqaOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DxPffv+7izSrJC7n0/k0QCEO3R4CfssBq8UJE3DdsrY=;
	b=qylp4H7xxjolIyCzjsq4MKgXTom4k1nfJrOwjGKjSI5UBPMIfyP1du3PNwwl6GwrGnr2EG
	Rqq9wBTx+UE8bVBg==
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
Subject: [patch V2 42/50] signal: Cleanup unused posix-timer leftovers
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:26 +0200 (CEST)

Remove the leftovers of sigqueue preallocation as it's not longer used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/signal.h |    2 --
 kernel/signal.c              |   43 +++++++------------------------------------
 2 files changed, 7 insertions(+), 38 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -337,8 +337,6 @@ extern void force_fatal_sig(int);
 extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
-extern struct sigqueue *sigqueue_alloc(void);
-extern void sigqueue_free(struct sigqueue *);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -439,8 +439,8 @@ static void __sigqueue_init(struct sigqu
  * - this may be called without locks if and only if t == current, otherwise an
  *   appropriate lock must be held to stop the target task from exiting
  */
-static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-					 int override_rlimit, const unsigned int sigqueue_flags)
+static struct sigqueue *sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+				       int override_rlimit)
 {
 	struct ucounts *ucounts = sig_get_ucounts(t, sig, override_rlimit);
 	struct sigqueue *q;
@@ -454,14 +454,16 @@ static struct sigqueue *__sigqueue_alloc
 		return NULL;
 	}
 
-	__sigqueue_init(q, ucounts, sigqueue_flags);
+	__sigqueue_init(q, ucounts, 0);
 	return q;
 }
 
 static void __sigqueue_free(struct sigqueue *q)
 {
-	if (q->flags & SIGQUEUE_PREALLOC)
+	if (q->flags & SIGQUEUE_PREALLOC) {
+		posixtimer_sigqueue_putref(q);
 		return;
+	}
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts = NULL;
@@ -1065,7 +1067,7 @@ static int __send_signal_locked(int sig,
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+	q = sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
@@ -1925,37 +1927,6 @@ bool posixtimer_init_sigqueue(struct sig
 	return true;
 }
 
-struct sigqueue *sigqueue_alloc(void)
-{
-	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
-}
-
-void sigqueue_free(struct sigqueue *q)
-{
-	spinlock_t *lock = &current->sighand->siglock;
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return;
-	/*
-	 * We must hold ->siglock while testing q->list
-	 * to serialize with collect_signal() or with
-	 * __exit_signal()->flush_sigqueue().
-	 */
-	spin_lock_irqsave(lock, flags);
-	q->flags &= ~SIGQUEUE_PREALLOC;
-	/*
-	 * If it is queued it will be freed when dequeued,
-	 * like the "regular" sigqueue.
-	 */
-	if (!list_empty(&q->list))
-		q = NULL;
-	spin_unlock_irqrestore(lock, flags);
-
-	if (q)
-		__sigqueue_free(q);
-}
-
 static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t, enum pid_type type)
 {
 	struct sigpending *pending;


