Return-Path: <linux-kernel+bounces-139476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6FB8A03A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7EB1F27080
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DC54273;
	Wed, 10 Apr 2024 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYJjIESs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="icpzEGWo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1851C43
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789216; cv=none; b=W+btllpD4GVwW5PTQwGERzpr73DQzeMl4TU8ULtXF4SOBGwrn0WJKxUwF/sqyQJ0n+ywh+ZJIqAUb8u6k+W5OcCFtRjQBOJ0Xupq+Y6kNhj4ZQM6DzZLCZXru8nVfDaGQGzRdRFIcMKRWRVK/s+VXFk6t5ywMJtiNKTp773PyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789216; c=relaxed/simple;
	bh=+8eJhLmLaBhsdGTxPY+WrOPg4LBJu0d/eL03Sd/TxJs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oPvtSLQ35YFlG4oRdyULSRjMWBnWYvJSx/GFy/K5SB9tlo5jqhauhsrR0kuw9AitVlx6MNYvG+eIm8sUtq5QdmUalBWMtx3PxFf8qbpV/A7jgihnRCXWY/9uavmfvDHU6ZXjoqtULYynAwG5sLBVJ2ZuBa2l2/bDbkCf1303FCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYJjIESs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=icpzEGWo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.381760138@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uf6CyGlUDp6ZuYdKBwWfggnizxjbUvxBehy8Wo6qoQk=;
	b=NYJjIESs6bBU6Y64vsH3XYdBtc1g0QTb1WETOk95koqefnolJFSJSHX7DdFUB1MiibCaxq
	bEXy+JqSXsTzF0foDzNo685LrlaIdDNW3Rb63OXU4XhFarRg+gR/36rU/A4G5dIEN8PEDZ
	l7ZJ15ms9SQ4Mz9UyacYGewC0+VydKpspP7EH8uugH3Ur7B75Aawerf/SwfBVvRaQLPr8J
	dNujNOtI0JI9Uqd5r5F9HweDfwQOt+l9cQcCuvtXsC4OaqcdtVK00gXSJGl8UpR8xv/eD3
	NULDnvEfJGEe9DkfFwALJ8Uu2xHZfuJ8ymkIvN48zu4hjGBmT2Uee1PtHiaC7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uf6CyGlUDp6ZuYdKBwWfggnizxjbUvxBehy8Wo6qoQk=;
	b=icpzEGWoPoG3Saqqyav5+hYuUTJHZj1lezVlTJRSn3lGoDK2u/+gNCBTclnXbwvkiI4sym
	OFEb1y+l7QtbtTBQ==
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
Subject: [patch V2 23/50] signal: Remove task argument from dequeue_signal()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:52 +0200 (CEST)

The task pointer which is handed to dequeue_signal() is always current. The
argument along with the first comment about signalfd in that function is
confusing at best. Remove it and use current internally.

Update the stale comment for dequeue_signal() while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 fs/signalfd.c                |    4 ++--
 include/linux/sched/signal.h |    5 ++---
 kernel/signal.c              |   23 ++++++++++-------------
 3 files changed, 14 insertions(+), 18 deletions(-)

--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -160,7 +160,7 @@ static ssize_t signalfd_dequeue(struct s
 	DECLARE_WAITQUEUE(wait, current);
 
 	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+	ret = dequeue_signal(&ctx->sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -175,7 +175,7 @@ static ssize_t signalfd_dequeue(struct s
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+		ret = dequeue_signal(&ctx->sigmask, info, &type);
 		if (ret != 0)
 			break;
 		if (signal_pending(current)) {
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -276,8 +276,7 @@ static inline void signal_set_stop_flags
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
-			  kernel_siginfo_t *info, enum pid_type *type);
+extern int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type);
 
 static inline int kernel_dequeue_signal(void)
 {
@@ -287,7 +286,7 @@ static inline int kernel_dequeue_signal(
 	int ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	ret = dequeue_signal(task, &task->blocked, &__info, &__type);
+	ret = dequeue_signal(&task->blocked, &__info, &__type);
 	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -618,20 +618,18 @@ static int __dequeue_signal(struct sigpe
 }
 
 /*
- * Dequeue a signal and return the element to the caller, which is
- * expected to free it.
- *
- * All callers have to hold the siglock.
+ * Try to dequeue a signal. If a deliverable signal is found fill in the
+ * caller provided siginfo and return the signal number. Otherwise return
+ * 0.
  */
-int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
-		   kernel_siginfo_t *info, enum pid_type *type)
+int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
+	struct task_struct *tsk = current;
 	bool resched_timer = false;
 	int signr;
 
-	/* We only dequeue private signals from ourselves, we don't let
-	 * signalfd steal them
-	 */
+	lockdep_assert_held(&tsk->sighand->siglock);
+
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
@@ -2787,8 +2785,7 @@ bool get_signal(struct ksignal *ksig)
 		type = PIDTYPE_PID;
 		signr = dequeue_synchronous_signal(&ksig->info);
 		if (!signr)
-			signr = dequeue_signal(current, &current->blocked,
-					       &ksig->info, &type);
+			signr = dequeue_signal(&current->blocked, &ksig->info, &type);
 
 		if (!signr)
 			break; /* will return 0 */
@@ -3642,7 +3639,7 @@ static int do_sigtimedwait(const sigset_
 	signotset(&mask);
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	sig = dequeue_signal(tsk, &mask, info, &type);
+	sig = dequeue_signal(&mask, info, &type);
 	if (!sig && timeout) {
 		/*
 		 * None ready, temporarily unblock those we're interested
@@ -3661,7 +3658,7 @@ static int do_sigtimedwait(const sigset_
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
-		sig = dequeue_signal(tsk, &mask, info, &type);
+		sig = dequeue_signal(&mask, info, &type);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 


