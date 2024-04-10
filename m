Return-Path: <linux-kernel+bounces-139459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908BC8A0391
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C58B283E27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB574317E;
	Wed, 10 Apr 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SxdENd8A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AeR/qmm9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5040BF2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789188; cv=none; b=MQ0vBb9T+DvZ9OfZqDH/bJMEH2WLqBYg8bXKvwV+ld16pHh6eBf9TOpFewosN2+zf8sgtFnbzKG6W8gMeGC3T50ofSD5G9alUgNdXdP+SMjUR3DPjvneHrxyKVhuSM1x4hZ7GeiDGojo5oNFXnw6gjcGrTINpsuIRaocTWeNv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789188; c=relaxed/simple;
	bh=5E5SF6djGIEJs9V+wAgKePOcQC5ojpZdVLcsv/5ENUo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NcoWmy5uKCS2VB4vCngm1lhBjYBXh4sF8N8+cU42y58FA2Cv2WMKFIG5fOIIkCV+v4nNNDLTejuNWaLub1+FIjTaTa2fQap9MQcT5yFkb7wF7FZxuJJrafye/SNW2O/Rb9dYhV9qUwL2ToFTtYqVXTKfc4lP6QaESeShxVjvVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SxdENd8A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AeR/qmm9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.376994018@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+/WP0ANjczawtPlZe0Ru3wamTdkxabLE/EGLxYuvFcc=;
	b=SxdENd8AQlIuGElK3HqraY3nm3G+pcB3HvAZrvv6BHt/sPK62dkVLHU5K6EBzJFdAPdJCr
	fSfPqTJ3Nl1dwjAe2fEUDa+YbQwBhMOwkTN6WNkrGJ7dMZYlyLcfKk84PpmHtBUtCx1FNg
	fjaJeWaM+vI/xhWRJv73i1h2houoB4CktHQcHBXlYDm/y38BpOkw1Lv4PI+a+9jKPBhi6R
	wC3ZuavN7IVZvdp253Yls2RuA5zjsZ08qmwVmnSp80cwBRipjhNPH+02evKKxOPZJX1Nul
	Q9ITohwXt2E0qNLdg61MA1f92YVGx1qGR7hiBJJUWmJApbp2QSXgo9KY5Q4Reg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+/WP0ANjczawtPlZe0Ru3wamTdkxabLE/EGLxYuvFcc=;
	b=AeR/qmm9tI8sitHKw4Zm4S278BreQlFM09BR+brsBiKExnnafX4U+mcQzABLWjKQ+AP6P2
	L38W7hsisXBdnmAg==
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
Subject: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:24 +0200 (CEST)

In preparation for addressing issues in the timer_get() and timer_set()
functions of posix CPU timers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   51 +++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -785,33 +785,9 @@ static int posix_cpu_timer_set(struct k_
 	return ret;
 }
 
-static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
-	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	u64 now, expires = cpu_timer_getexpires(ctmr);
-	struct task_struct *p;
-
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
-
-	/*
-	 * Easy part: convert the reload time.
-	 */
-	itp->it_interval = ktime_to_timespec64(timer->it_interval);
-
-	if (!expires)
-		goto out;
-
-	/*
-	 * Sample the clock to take the difference with the expiry time.
-	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		now = cpu_clock_sample(clkid, p);
-	else
-		now = cpu_clock_sample_group(clkid, p, false);
+	u64 expires = cpu_timer_getexpires(&timer->it.cpu);
 
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
@@ -823,7 +799,28 @@ static void posix_cpu_timer_get(struct k
 		itp->it_value.tv_nsec = 1;
 		itp->it_value.tv_sec = 0;
 	}
-out:
+}
+
+static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+{
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
+	struct task_struct *p;
+	u64 now;
+
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (p) {
+		itp->it_interval = ktime_to_timespec64(timer->it_interval);
+
+		if (cpu_timer_getexpires(&timer->it.cpu)) {
+			if (CPUCLOCK_PERTHREAD(timer->it_clock))
+				now = cpu_clock_sample(clkid, p);
+			else
+				now = cpu_clock_sample_group(clkid, p, false);
+
+			__posix_cpu_timer_get(timer, itp, now);
+		}
+	}
 	rcu_read_unlock();
 }
 


