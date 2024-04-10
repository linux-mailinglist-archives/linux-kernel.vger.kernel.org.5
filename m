Return-Path: <linux-kernel+bounces-139479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937338A03A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8EB28351C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4755C3C;
	Wed, 10 Apr 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPDwHGzM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbDIKNug"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87654F91
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789221; cv=none; b=sX/m7inHdMmGH3K6bceYpIL5yXf0/nO7Bcc1KI961gfkSyLMc18rGxgG4o5y23lyMLxMp8e1PYdVmyPieY3N1e+pXEl1qiuRm4HrW5ZxLYaOaYq31vS8IFLLOyo8VM3AJVs2bnz8F2VWp0/KCTqMSnXQd9NozNnb/sV2tfthZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789221; c=relaxed/simple;
	bh=ipfz+AaYDg2jRk2QzxjlJP24YxnDWUAysNYhb2QjuYU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ictxthlcx/mIf9UnRdAVhABgsC59MgCIVKrxBu1nlqXEhIl5WcpXd5okF7tXlWyifEPx1/K/Pojk2ar+UAlwAqiH13Q7qq0vlGC+ooiYY9ONNeFUf+L/ZNAbNRszGxpd2AJfnCPisC7/BS69ZtQFiydoB1YD7lEIZcW7yt//GrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPDwHGzM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbDIKNug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.572304080@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t7pjsSQKBc6tEHZWynKUhlTqjE2Ct45jVqlBq7pgRI0=;
	b=mPDwHGzMsYi9guyziH1nqXc1/wh9AIulGLHFee23j+SNPuBzYg17wR2FD3n2ytABEFRe5V
	7zzTKUgFXVZwjBnMm5VYbofTEf8mrJ3mW1x1hndkMX3QhRAE6QUXoIfz9zH1obhBN21VCT
	+tXZGzOJ9G2lNMsgp3uOIk/jxysM/vsKR7IZoydMfjzaY7FAJ0/biRpjLTcP1id51HhBzn
	g20pxjgMUnTce3UhlaBWSmsVTQ+OkbqmJ0JK7j1vTBNjte8uOPOD1PtBHcxkm2pJykX/nc
	yk1LJlOQvrIaVYpRBc5xW2ymV3/YQcD5Bz7VDa7LcJM+oJFOpal8hCbta/zz5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t7pjsSQKBc6tEHZWynKUhlTqjE2Ct45jVqlBq7pgRI0=;
	b=cbDIKNugg358Psea1JVSW1YSq4zWt2pclLbdfx6o180qJhFcPTu1xY5dzI6MFHhxiyLJ9i
	8SqzYdSfVCSzSLCg==
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
Subject: [patch V2 26/50] signal: Get rid of resched_timer logic
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:57 +0200 (CEST)

There is no reason for handing the *resched pointer argument through
several functions just to check whether the signal is related to a self
rearming posix timer.

SI_TIMER is only used by the posix timer code and cannot be queued from
user space. The only extra check in collect_signal() to verify whether the
queued signal is preallocated is not really useful. Some other places
already check purely the SI_TIMER type.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -526,8 +526,7 @@ bool unhandled_signal(struct task_struct
 	return !tsk->ptrace;
 }
 
-static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
-			   bool *resched_timer)
+static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info)
 {
 	struct sigqueue *q, *first = NULL;
 
@@ -549,12 +548,6 @@ static void collect_signal(int sig, stru
 still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
-
-		*resched_timer =
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code == SI_TIMER) &&
-			(info->si_sys_private);
-
 		__sigqueue_free(first);
 	} else {
 		/*
@@ -571,13 +564,12 @@ static void collect_signal(int sig, stru
 	}
 }
 
-static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			kernel_siginfo_t *info, bool *resched_timer)
+static int __dequeue_signal(struct sigpending *pending, sigset_t *mask, kernel_siginfo_t *info)
 {
 	int sig = next_signal(pending, mask);
 
 	if (sig)
-		collect_signal(sig, pending, info, resched_timer);
+		collect_signal(sig, pending, info);
 	return sig;
 }
 
@@ -589,17 +581,15 @@ static int __dequeue_signal(struct sigpe
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
 	struct task_struct *tsk = current;
-	bool resched_timer = false;
 	int signr;
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
 	*type = PIDTYPE_PID;
-	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
 		*type = PIDTYPE_TGID;
-		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
+		signr = __dequeue_signal(&tsk->signal->shared_pending, mask, info);
 
 		if (unlikely(signr == SIGALRM))
 			posixtimer_rearm_itimer(tsk);
@@ -626,7 +616,7 @@ int dequeue_signal(sigset_t *mask, kerne
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(resched_timer))
+		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
 			posixtimer_rearm(info);
 	}
 
@@ -1011,6 +1001,9 @@ static int __send_signal_locked(int sig,
 
 	lockdep_assert_held(&t->sighand->siglock);
 
+	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
+		return 0;
+
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, force))
 		goto ret;


