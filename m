Return-Path: <linux-kernel+bounces-139467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A848A039B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1802841D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968B4C60C;
	Wed, 10 Apr 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zv7eZuDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="au0L6PkP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB674AEF0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789200; cv=none; b=d853m5RklhWQmBuZQSUB6NpJOQACPQHZIvh540tL/ujfrqz37HjfAK1pT7+GCI50D5bH3djoq589M0A3V2dqpr7ZVwdDucaZx4CKODqOAtP7V5eZRnRgZkie7wSLz5i9RpHrH0M2Hvdf371jGoJQG3VUj8WSrW14soP+5nGgtJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789200; c=relaxed/simple;
	bh=dB7rimPTTgIr+XyZdIogR3o9dlxge5G3DTP9z9KIRro=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UGsaTWrgT63cFBSW7Uzm5OI4m4OabavIhIxlihh12IBbpY+aLuL1hjOXXZ48PIoBLh2jck5tgGraSuFfZJsmBVij2owF71+pIp5rU6gl1cRQYEzaKvUi1ywBZJlh7l0V4Si5qHe1okNtVn/Q9ESXGwdxJVWd+mSbfK6kkWbGioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zv7eZuDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=au0L6PkP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.819762665@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ExiTF3X05BrX2DL4sY3OO9bGQhEyAP9yIOBmxwKI0QM=;
	b=Zv7eZuDY6jfp+OF3wtQ59z6745cPcoDLK8WvDi3i5DVS7dGKFe9PCwYr23I594ocv4GBHB
	AZE83iVNQR8glt5Tq9PL7OipZam708qVuooL34IRFAAAsOa5WPJ8cZZfM3uTYtOI3cWSV7
	1xhCM+Utdz+Aj63ZCXmopq2Qu3k8wB/rTInTPU8My0fjlqlyoWqMMcmnSsiswsyvtEFSl6
	hmXAoJagN6N1ulJZF3Mg1bxarLAfJV3Wk6ttu1DFgfWFCM8urhKdaLudhU6dEo8/nD1ORs
	OH3JvzNuPXAY7Aju6ijSD81DcT6USWKVmVrNziVAOgokptwHQCfNjHDxijwIrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ExiTF3X05BrX2DL4sY3OO9bGQhEyAP9yIOBmxwKI0QM=;
	b=au0L6PkPGh5Pj8csUnTBrFeJaO+Ke1tmtONjPo9knLZS/Z5rMpHrvjCVTqua+l8RGyWn1j
	UfNn/slP3vzaBoDQ==
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
Subject: [patch V2 14/50] posix-cpu-timers: Use @now instead of @val for
 clarity
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:36 +0200 (CEST)

posix_cpu_timer_set() uses @val as variable for the current time. That's
confusing at best.

Use @now as anywhere else and rewrite the confusing comment about clock
sampling.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-cpu-timers.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -622,7 +622,7 @@ static int posix_cpu_timer_set(struct k_
 {
 	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, val;
+	u64 old_expires, new_expires, old_incr, now;
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
@@ -674,23 +674,19 @@ static int posix_cpu_timer_set(struct k_
 	}
 
 	/*
-	 * We need to sample the current value to convert the new
-	 * value from to relative and absolute, and to convert the
-	 * old value from absolute to relative.  To set a process
-	 * timer, we need a sample to balance the thread expiry
-	 * times (in arm_timer).  With an absolute time, we must
-	 * check if it's already passed.  In short, we need a sample.
+	 * Sample the current clock for saving the previous setting
+	 * and for rearming the timer.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		val = cpu_clock_sample(clkid, p);
+		now = cpu_clock_sample(clkid, p);
 	else
-		val = cpu_clock_sample_group(clkid, p, !sigev_none);
+		now = cpu_clock_sample_group(clkid, p, !sigev_none);
 
 	/* Retrieve the previous expiry value if requested. */
 	if (old) {
 		old->it_value = (struct timespec64){ };
 		if (old_expires)
-			__posix_cpu_timer_get(timer, old, val);
+			__posix_cpu_timer_get(timer, old, now);
 	}
 
 	if (unlikely(ret)) {
@@ -706,7 +702,7 @@ static int posix_cpu_timer_set(struct k_
 
 	/* Convert relative expiry time to absolute */
 	if (new_expires && !(timer_flags & TIMER_ABSTIME))
-		new_expires += val;
+		new_expires += now;
 
 	/* Set the new expiry time (might be 0) */
 	cpu_timer_setexpires(ctmr, new_expires);
@@ -716,7 +712,7 @@ static int posix_cpu_timer_set(struct k_
 	 * not yet expired and the timer requires signal delivery.
 	 * SIGEV_NONE timers are never armed.
 	 */
-	if (!sigev_none && new_expires && val < new_expires)
+	if (!sigev_none && new_expires && now < new_expires)
 		arm_timer(timer, p);
 
 	unlock_task_sighand(p, &flags);
@@ -736,7 +732,7 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (!sigev_none && val >= new_expires) {
+	if (!sigev_none && now >= new_expires) {
 		if (new_expires != 0) {
 			/*
 			 * The designated time already passed, so we notify


