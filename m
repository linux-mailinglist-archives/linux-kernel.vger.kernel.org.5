Return-Path: <linux-kernel+bounces-139466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC1D8A039A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB642841F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6234C624;
	Wed, 10 Apr 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KGMZ0QcS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rh1zKcqn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14148787
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789198; cv=none; b=ls9gpnSp7in0bQ2v2zP5VZiiu8WR7Dsg2pG7ZGU6H3k32pveFnxY7gTqHtj9/rFEvHQHkTQT1gw5Qno+OxM7JGMDzKDJq5p5EzkujeCNjjtUppWUrBcs3VGDPTWYutMQLOinxHGK1FjhSNleVnYorg4b21XwwWyKdDTVsIk5JaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789198; c=relaxed/simple;
	bh=XOVBbigKGjPLdX5P0pMrym6mQdm4eaTiAmzCqhAsQJU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Q8admTkqo4v+y2rDFAkfFT8FJENPyY83gYxjfNyoJz61sIZYVumOhmr/tKI3jO0C1wgpmuRr1trZtykLvxUamkQ3sk5KpxhfhvwrhsV0VRCdefpeokKUofOwDptmkGbdkkm6ilsyG2r3MAyGT2RpjZJ84bXmWE/+j7PTYuaFeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KGMZ0QcS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rh1zKcqn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.757677561@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=osYubTMAcZxZdMMm1RQggfIXZUJTx+ldm1e90x9mqTY=;
	b=KGMZ0QcSsDrIFmz1HuXGMSEeYWKjpSHbfEvGRaRmkTuh/EH1WHIcjCMoFqnaRTWFDuOA2/
	CvISAI8kzccU0Gl3fi21vDDtM0O+AfSEnqt0XOU6gBFFpcSFg6UPUGJPe2kh88wgKkntHE
	lgGly3PqA1cxnyGmrVXqPXm5DqxWZ2wggs94w7bP2839k18PkHym7eXrCIJJ+PHpkeIaR9
	aYDKeIKt8wrs2Mfx/k3UXAqdQV+eAjnE4bGqzQIH6mdAKVS4gH5pax3IUE0rjQE2LZ32iQ
	i/o62jo+z3EKr0sqpEKa2Wq+88TFqWIqaKG2UpW6fBWT9dEa3mi5R53eyf1KnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=osYubTMAcZxZdMMm1RQggfIXZUJTx+ldm1e90x9mqTY=;
	b=rh1zKcqnevxoG3D4vAAnbhlB4eisPLVMYLLIyfKIT9XpKcY3qHtT4egZhZLlzYu1JBAkiV
	IFzzTBhI18AcVBAQ==
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
Subject: [patch V2 13/50] posix-cpu-timers: Do not arm SIGEV_NONE timers
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:34 +0200 (CEST)

There is no point in arming SIGEV_NONE timers as they never deliver a
signal. timer_gettime() is handling the expiry time correctly and that's
all SIGEV_NONE timers care about.

Prevent arming them and remove the expiry handler code which just disarms
them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -584,12 +584,7 @@ static void cpu_timer_fire(struct k_itim
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
-	if ((timer->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-		/*
-		 * User don't want any signal.
-		 */
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -625,6 +620,7 @@ static void __posix_cpu_timer_get(struct
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
@@ -688,7 +684,7 @@ static int posix_cpu_timer_set(struct k_
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		val = cpu_clock_sample(clkid, p);
 	else
-		val = cpu_clock_sample_group(clkid, p, true);
+		val = cpu_clock_sample_group(clkid, p, !sigev_none);
 
 	/* Retrieve the previous expiry value if requested. */
 	if (old) {
@@ -708,19 +704,20 @@ static int posix_cpu_timer_set(struct k_
 		goto out;
 	}
 
-	if (new_expires != 0 && !(timer_flags & TIMER_ABSTIME)) {
+	/* Convert relative expiry time to absolute */
+	if (new_expires && !(timer_flags & TIMER_ABSTIME))
 		new_expires += val;
-	}
+
+	/* Set the new expiry time (might be 0) */
+	cpu_timer_setexpires(ctmr, new_expires);
 
 	/*
-	 * Install the new expiry time (or zero).
-	 * For a timer with no notification action, we don't actually
-	 * arm the timer (we'll just fake it for timer_gettime).
+	 * Arm the timer if it is not disabled, the new expiry value has
+	 * not yet expired and the timer requires signal delivery.
+	 * SIGEV_NONE timers are never armed.
 	 */
-	cpu_timer_setexpires(ctmr, new_expires);
-	if (new_expires != 0 && val < new_expires) {
+	if (!sigev_none && new_expires && val < new_expires)
 		arm_timer(timer, p);
-	}
 
 	unlock_task_sighand(p, &flags);
 	/*
@@ -739,7 +736,7 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (val >= new_expires) {
+	if (!sigev_none && val >= new_expires) {
 		if (new_expires != 0) {
 			/*
 			 * The designated time already passed, so we notify


