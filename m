Return-Path: <linux-kernel+bounces-145069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6508A4F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365712836F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C5E6D1A1;
	Mon, 15 Apr 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IA2k3c0V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TUgzW5rl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9081FA1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184256; cv=none; b=Gyf1Rst6XJFxK1RQl+eBXGMgb//L1juXY+Ab7cAIQoywQwk7VMqpkHB8h/MY7Yy5cud6t6OePP0gLgYAXDtJipFi0f5jvAcWXwo1wJ+d87PVFw3KvXGkIGSwn2h7mFR6+HwOlP45fRjvsLD5f+AqRZ/D9e3yHb5KZjww7Ewz/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184256; c=relaxed/simple;
	bh=16igbDBxYxvU1x661QKxvfTSCMQD0ch6OYA44oQy3vM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CaiiWqwgwhsuXLmw7m2nxoNJIy3SygCUY/Tgg6KAMJROMobZ6OKFl9uM9ALPaXP1pBguJSeIW+TvSgVcVuL1olZ+CfW4PQVu44TysYxYEOT0Ou1FLq/ruXo0mcYIIF17BDWBvMi0+6sORxNAEUOtj9pd44TBtRl/iuG7LjLEM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IA2k3c0V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TUgzW5rl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713184246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31UKcuC29fhH2gQ7AFdErWb9xDpB3f6MYdu5CdzUIIQ=;
	b=IA2k3c0VmYV/3qlHKG/q0IL16+qVecLW1kmkRnzkF8ZJQyMSpEQHQ03AhC+Qrf1qersnMn
	OjmfGotp7DvX/pNtpnTxEqe0380WqVjMynm/cZit7Arlx3x4TlJP/BxcJxtKp8qr36bBgc
	fPV/88gmDf3HBPqCmi0KZEYUYVvV0FicAHPTpDUyqsTDGXUCSZVB2G6bqekpvOmZKT0FII
	0Q8mHybMXof9/JkcsB5ULGYMPreJwUDblsZebPW4V+2kRZGdDh1VqNgblUb0d6WagCLrSu
	hpoFiiCXUn5dbOgiU8jDGWqlpCofehUb/Jm2h7cYY5aUe2McPU6PZ25WSa4dHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713184246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31UKcuC29fhH2gQ7AFdErWb9xDpB3f6MYdu5CdzUIIQ=;
	b=TUgzW5rlPcFwUnHGWaqJx1OzgGk/iRrOD4lh6AyUxW9TXvku79JXSZ64ChEDnt8EhUMXW3
	4RYcrrpU6vkFVZAQ==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] posix-timers: Handle returned errors poperly in
 [i]timer_delete()
In-Reply-To: <20240410164558.316665885@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
Date: Mon, 15 Apr 2024 14:30:46 +0200
Message-ID: <8734rm95ah.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

timer_delete_hook() returns -EINVAL when the clock or the timer_del
callback of the clock does not exist. This return value is not handled by
the callsites timer_delete() and itimer_delete().

Therefore add proper error handling.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
When having a look at the posix timer code during reviewing the queue, I
stumbled over this inconsitency. Maybe you want to have it in your
cleanup queue. Patch applies on top of your queue.

 kernel/time/posix-timers.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1009,6 +1009,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 {
 	struct k_itimer *timer;
 	unsigned long flags;
+	int ret;
 
 	timer = lock_timer(timer_id, &flags);
 
@@ -1019,7 +1020,11 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	/* Prevent signal delivery and rearming. */
 	timer->it_signal_seq++;
 
-	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
+	ret = timer_delete_hook(timer);
+	if (ret < 0)
+		return ret;
+
+	if (unlikely(ret == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
 		timer = timer_wait_running(timer, &flags);
 		goto retry_delete;
@@ -1047,6 +1052,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 static void itimer_delete(struct k_itimer *timer)
 {
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * irqsave is required to make timer_wait_running() work.
@@ -1054,13 +1060,17 @@ static void itimer_delete(struct k_itime
 	spin_lock_irqsave(&timer->it_lock, flags);
 
 retry_delete:
+	ret = timer_delete_hook(timer);
+	if (WARN_ON_ONCE(ret < 0))
+		return;
+
 	/*
 	 * Even if the timer is not longer accessible from other tasks
 	 * it still might be armed and queued in the underlying timer
 	 * mechanism. Worse, that timer mechanism might run the expiry
 	 * function concurrently.
 	 */
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
+	if (ret == TIMER_RETRY) {
 		/*
 		 * Timer is expired concurrently, prevent livelocks
 		 * and pointless spinning on RT.

