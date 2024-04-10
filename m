Return-Path: <linux-kernel+bounces-139490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D68A03B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB831F29510
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C188D130A43;
	Wed, 10 Apr 2024 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCBCziDD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHNfD1Ve"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775712F598
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789241; cv=none; b=qMx/EMi6c0UNl5CaBGPSHR5JR1AhsyGq1BlVlC8E3/QSqobQn2NUaoh5VRmhFYBxkTSbW2xBYY8PRWyLHVIAOlybGRAXGBAlIFekh4JTraiiMw9VIobxHwGGGCKfuzVbKTp9VcfTMfGlFK6IKJW67kqGNJIiURbqbfNXa3h5rlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789241; c=relaxed/simple;
	bh=JBVsg51a1C6emguYqjQ6r5sm9uw8SoWsLBDNYeJITWk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=EGjzKCOi0iMAWGkl5sNiguju6ZMxOy5M9Ui4Ayl3y+nksYc4bAkxMJFyfg5pfSwB06XYIgbzesVJel/qxiMHgdUYNXrYZ35GUVUWPEWvX+zbSIqwLIy8w4delArE4CWCICgvsxJVmleZpnoFZ/fNU5o14helTCNoWJNI1Lwg1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCBCziDD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHNfD1Ve; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.263875002@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uih5CqJpJPUslYvMN+crWXfC4uyqUetkrCUQg27T5sU=;
	b=RCBCziDDYk8F0k08nosKA+Ykwj99TGVPTAO8C1s4EAvyRezArbTUnTxcqm9pLdoFCzNCl/
	DjV5+/1UTy6p3rp7we9OH1j38D90ObzcZ/xhq9MakdCmGDGkNxXo0jIp1AJNnKWNNWfRI8
	q+UcU/i0XjzRWTYOw4UDeKf1cu3E1vSqUo0NwJrMQ4dX+LeZwt1RuUeM+/nUCIVlaFIWDL
	LSgVfj8L5I4SCtMqqB2ioLs/nttUZg77sErDBvEVQZ8V18FRHBeLtZTNcqsXjT81lq9QPD
	xpp4I4jbkS2YkLg0e7+jjkwAtKWYyWRFaGVNbElTe+tcqEs0GXliPCh4f7CIlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uih5CqJpJPUslYvMN+crWXfC4uyqUetkrCUQg27T5sU=;
	b=uHNfD1VesuL0ML1QFJEDCYSbAmdJvPtbk96Erb0B7GRhFHI3b9yz2W0CXTpNpfu7WBdSmZ
	mi5dEovzu4lAA4Aw==
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
Subject: [patch V2 37/50] signal: Provide posixtimer_sigqueue_init()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:17 +0200 (CEST)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    2 ++
 kernel/signal.c              |   11 +++++++++++
 2 files changed, 13 insertions(+)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -12,6 +12,7 @@
 
 struct kernel_siginfo;
 struct task_struct;
+struct sigqueue;
 struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
@@ -106,6 +107,7 @@ static inline void posix_cputimers_rt_wa
 }
 
 void posixtimer_rearm_itimer(struct task_struct *p);
+bool posixtimer_init_sigqueue(struct sigqueue *q);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1909,6 +1909,17 @@ void flush_itimer_signals(void)
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 }
 
+bool posixtimer_init_sigqueue(struct sigqueue *q)
+{
+	struct ucounts *ucounts = sig_get_ucounts(current, -1, 0);
+
+	if (!ucounts)
+		return false;
+	clear_siginfo(&q->info);
+	__sigqueue_init(q, ucounts, SIGQUEUE_PREALLOC);
+	return true;
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);


