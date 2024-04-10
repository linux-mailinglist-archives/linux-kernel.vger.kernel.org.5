Return-Path: <linux-kernel+bounces-139498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA88A03B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C974C28BB45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6740BF5;
	Wed, 10 Apr 2024 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUaOE1Vx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="65/gtTev"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5A134723
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789253; cv=none; b=NYGTWEzhInV97UzmW2cUqSizMmcwOm7Ftxn8Ay8raRoQHFRrAhs6jpRdANTQl9KJ+joXLYSnlFVekRJma42KkrU0r7UQdK5fkNq9vF3hID1qQRuaaynic78z6d7gM+4Qoa1EbxEyJTi8xl5zOkblTkfWhyQZhJxMWnIe36GPn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789253; c=relaxed/simple;
	bh=cp19dVUb7xvWUsokdlmPF5WkDY+X0uWwwuOAQ7Ty6Vc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rqdFF+64BWxz8sZKTJL5EU7XE9EcwPpgKYbJs09oq5DlMalq1mUBkUvU5CSkoM7rgFy5or7Z49Ub6HP5H6zWKyZp/f/qEJ+zQmP/QY6pGXkTerIa/1zOLQrDOKCmiDGY8nyS75pAg3W0whVl2MQZWJpsXN4Qqu59OVuGfBLzNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUaOE1Vx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=65/gtTev; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.699821482@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pv6YrQN2ETIiH5UgbcE48m3AAv3y/nIIur52dGrER6A=;
	b=jUaOE1VxK0rkmAl5Q50vmOUaJIP24WYKpeBT9ld8uKfYKCb23U5uzyQHzO7obq6pBZIF8E
	HCe7glmNlBbc/ciYExpG/z4mY+mSsIW50zkbuloJTh05+/tBqqv1/x1lWnFdNbk/0WSGPn
	uesy6o6gv78OwT3V3QEML+cRKgxGyn8O+4IbBvMVVMpJXV+v8x3FBhYv05lXYqgXrvQ7bP
	neuztj+7bFE9QywjjIQqVgN5gAqS/fh2wCzQm7UT/MAoQUNv08UueRkiA4kWzpd6UeKicp
	l+AX/y8OODO+V/ayugdTQ54lX40+T6hoW0ap875xTgQWv73N1UK9267pEbsSnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pv6YrQN2ETIiH5UgbcE48m3AAv3y/nIIur52dGrER6A=;
	b=65/gtTev2nEhnOx3GTX9mzsFaXErSxtYWTmSWv4oAE7m3TOOcc+WKKiULC7QIuRY+KACcs
	gP9CJMyfsQ4zHBDw==
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
Subject: [patch V2 44/50] signal: Provide ignored_posix_timers list
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:29 +0200 (CEST)

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a list to task::signal.

This list will be used to queue posix timers so their signal can be
requeued when SIG_IGN is lifted later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/signal.h |    1 +
 init/init_task.c             |    5 +++--
 kernel/fork.c                |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -138,6 +138,7 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
 	struct hlist_head	posix_timers;
+	struct hlist_head	ignored_posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -29,8 +29,9 @@ static struct signal_struct init_signals
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers	= HLIST_HEAD_INIT,
-	.cputimer	= {
+	.posix_timers		= HLIST_HEAD_INIT,
+	.ignored_posix_timers	= HLIST_HEAD_INIT,
+	.cputimer		= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
 #endif
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1877,6 +1877,7 @@ static int copy_signal(unsigned long clo
 
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif


