Return-Path: <linux-kernel+bounces-139469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF58A039D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200F32844C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3F4F88B;
	Wed, 10 Apr 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cjCI4sb2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtBQOmX9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA64D112
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789204; cv=none; b=kiowRvrsi+9rcr4c3x0UzGqhNyjgsOKpc27VF416EMNxHCrzA4slchsDqZk4BI82qjOt/l5sYAYuvd45pIpYE0V7jJQJ3JPZ1XzmXCluTVwFxQMWYSpjEXs9Yhsggz66Dpv01IrraIAVTJ50gi8x8SQcXD82ux5LXeOwKliOcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789204; c=relaxed/simple;
	bh=jwLW+rNG7bMs4zQGx/O8eL+ZFKFCQ9a+FbpMQ0kFoaQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=km1gSvrwxgy3INsyTfGlzq+v9VQhczGYYra4Hp5pJwUOSG6vq2SGJcCB6PjKz7LaXjGG1+AQRVUrxwuHd7n4g+ONUKFpJ1IVaNrLyqicEkXDxZxbvohjNMxZOmZfYrB9H4oqJ40OAXvOReirVF7GBJF4tFmaAdzltqTRc35Vivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cjCI4sb2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtBQOmX9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.943625183@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=prXY1arwiBmGreObgLsf7R5UB66La837yy2ta+3sTC4=;
	b=cjCI4sb2+ouxHsXnpuMYh8rkL5BNqBue0YnhK4whsbmKl9PTRMA5eSNJDwFS72Z+VXMXH3
	XQFD5O/sVegZGi+bc/CezdFtt+B1BHo9SE2z7ghaaoihKQySMaIzbRpzXD9mxYomOSIhKz
	9Y2sW0E6OQsDSaBM7A8/p26iNUcpfY+IX1zxckTb7Y6s7mcwPpV7JSw9t6coNxZvOTLt21
	3Og2ZwFNYdXraNQtNXKqKKPrG2w/WlFvnWE3PNX+zyBV2JS93EwqY+TBfBy0LkjsS2RV2n
	PrGIHQnxo4Ki42hxVPZmG5U5N7Fw3TSb28l9wemS2l0MlAY0X+hFFdj6d7EUvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=prXY1arwiBmGreObgLsf7R5UB66La837yy2ta+3sTC4=;
	b=MtBQOmX99XXLjGA+DYB/y8fzrQ7xInDBvvCcUod2moCFArtFK0y2CmGIgtqblp+p9x0LOx
	6Gnt3aArXdCX98Dg==
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
Subject: [patch V2 16/50] posix-cpu-timers: Simplify posix_cpu_timer_set()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:40 +0200 (CEST)

Avoid the late sighand lock/unlock dance when a timer is not armed to
enforce reevaluation of the timer base so that the process wide CPU timer
sampling can be disabled.

Do it right at the point where the arming decision is made which already
has sighand locked.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   44 +++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -705,10 +705,16 @@ static int posix_cpu_timer_set(struct k_
 	/*
 	 * Arm the timer if it is not disabled, the new expiry value has
 	 * not yet expired and the timer requires signal delivery.
-	 * SIGEV_NONE timers are never armed.
+	 * SIGEV_NONE timers are never armed. In case the timer is not
+	 * armed, enforce the reevaluation of the timer base so that the
+	 * process wide cputime counter can be disabled eventually.
 	 */
-	if (!sigev_none && new_expires && now < new_expires)
-		arm_timer(timer, p);
+	if (likely(!sigev_none)) {
+		if (new_expires && now < new_expires)
+			arm_timer(timer, p);
+		else
+			trigger_base_recalc_expires(timer, p);
+	}
 
 	unlock_task_sighand(p, &flags);
 	/*
@@ -727,30 +733,14 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (!sigev_none && now >= new_expires) {
-		if (new_expires != 0) {
-			/*
-			 * The designated time already passed, so we notify
-			 * immediately, even if the thread never runs to
-			 * accumulate more time on this clock.
-			 */
-			cpu_timer_fire(timer);
-		}
-
-		/*
-		 * Make sure we don't keep around the process wide cputime
-		 * counter or the tick dependency if they are not necessary.
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			goto out;
-
-		if (!cpu_timer_queued(ctmr))
-			trigger_base_recalc_expires(timer, p);
-
-		unlock_task_sighand(p, &flags);
-	}
- out:
+	/*
+	 * If the new expiry time was already in the past the timer was not
+	 * queued. Fire it immediately even if the thread never runs to
+	 * accumulate more time on this clock.
+	 */
+	if (!sigev_none && new_expires && now >= new_expires)
+		cpu_timer_fire(timer);
+out:
 	rcu_read_unlock();
 	if (old)
 		old->it_interval = ns_to_timespec64(old_incr);


