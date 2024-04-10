Return-Path: <linux-kernel+bounces-139486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4B8A03AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C7E1F28D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC17FBB2;
	Wed, 10 Apr 2024 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vuz+Dh71";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVgsM3sC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AADB7FBB0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789234; cv=none; b=Tkbdz8m9XD4ptJhNnmuJnt95FiSuz6TkOFi6I4OLgr1HMaCY9V5uFnd9md4W0C6kC+BKA6N2I4KzHVezAM6cyLHjSgOaDr656aG2ROOf6hHzc+TTn/W/4ZGWz3hxRJxhanPJQx34YpNRt4SgmJSrammCStaVLUtHPmZ5MkkKYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789234; c=relaxed/simple;
	bh=hYNVuSguWX5kL+feRx+7A+qZ1CJIoDAjlsCoswgjWkw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LVUwH5KnDUYkUf+fRt7IFK2+tFyFMskLqDvWu41hPHqTXjtQrYKLrjlB8AdhioV0JHtXp5zLTL+OkIhVdzWRGuAM+ZSDW1qBZ1SPr6WKdW/p0uLJmjAihqXDRZq6wCEvUP/9K27XFlYwPwF3gXOGUl6tGHY4hSlcV5SsxKRGatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vuz+Dh71; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OVgsM3sC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.018701571@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aNS2WvbMpSrKZ+gyfUquRBBrzhJQZEx4EROddFmkK80=;
	b=vuz+Dh71piLtX10dIzChDEHBEph9k5zEn+2i8jRwosi2JDR4XcBxLkOzJhLYTPymHCCVq2
	cLtAw75XODqsnYr6vlXR4i8qxzthjXvHW28NWk9DLDtxD9xmUbSm9qLKzfQXj1z6SAjf7L
	AOcYFH/xT2oh2Eohv5RtU2swQM5tgGF9GWEbJfuDR+fijQ2VHnZxeIAczE1IjIK+wvpKny
	J35IfQN6vvtk3GvPoNu2GhWON1UB1Wl98kIddR6PLCxlIN6YUEbYJN0kd0FIhpQTJHv+1j
	NVhfDyQXDOoaYrBJr9s5IxxSBEj1opynJ1IykEg/BtCnIFjDWcRNOhB0y+cdyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aNS2WvbMpSrKZ+gyfUquRBBrzhJQZEx4EROddFmkK80=;
	b=OVgsM3sCWMqwALpb2w3q3xUU6iTpbkkM2F+dFQD9XiJRohkgoM2p/QGqmslB9GIqS+9fTn
	h9+TlGcemjYefeCg==
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
Subject: [patch V2 33/50] posix-timers: Make signal overrun accounting
 sensible
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:10 +0200 (CEST)

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Make the accounting in send_sigqueue() consistent with that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1965,6 +1965,34 @@ int send_sigqueue(struct sigqueue *q, st
 	 */
 	q->info.si_sys_private = si_private;
 
+	/*
+	 * Set the overrun count to zero unconditionally. The posix timer
+	 * code does not self rearm periodic timers. They are rearmed from
+	 * dequeue_signal().
+	 *
+	 * But there is a situation where @q is already enqueued:
+	 *
+	 * 1) timer_settime()
+	 *      arm_timer()
+	 * 2) timer_expires()
+	 *      send_sigqueue(@q)
+	 *        enqueue(@q)
+	 * 3) timer_settime()
+	 *      arm_timer()
+	 * 4) timer_expires()
+	 *      send_sigqueue(@q) <- Observes @q already queued
+	 *
+	 * In this case incrementing si_overrun does not make sense because
+	 * there is no relationship between timer_settime() #1 and #2.
+	 *
+	 * The POSIX specification is useful as always: "The effect of
+	 * disarming or resetting a timer with pending expiration
+	 * notifications is unspecified."
+	 *
+	 * Just do the sensible thing and reset the overrun.
+	 */
+	q->info.si_overrun = 0;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
@@ -1972,15 +2000,9 @@ int send_sigqueue(struct sigqueue *q, st
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
-		/*
-		 * If an SI_TIMER entry is already queue just increment
-		 * the overrun count.
-		 */
-		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;


