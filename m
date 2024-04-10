Return-Path: <linux-kernel+bounces-139463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5798A0397
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF81C20C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026F47A58;
	Wed, 10 Apr 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kwfe8kRA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7PrYUi+m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FF282F0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789193; cv=none; b=kdAtYy1AC6KeJ63qhntvf0qXsQt8sClZoJ9OteSnqbZeg3RtQuu3Bn6SpXBaTSbzVgIhv6sWd/Qp/JCsJjpr282o/2nefn97XsPN9T20U8RbD2TlMQAyc7CL/VxAZFI1MfqKahlctF1TxAeIoezPj+S5nHdSeyKZ45xtuUM4Kj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789193; c=relaxed/simple;
	bh=uF1VDsOZ4FIX9FT58rai3eHyWyTmEsXGceZwBt+UMwI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=I3Q2GF5QdrpZiQ/0r4Tt4PZDGjMzViS7K33ql2c0OkHjhbJSmsBRJzgTdQmCFgDeJ5L9Hvim9dl6kXdBsk/p1F4Xp4Yc5yxluaHrS7ZcuVI73JVrrsFqStVRjckk47ETuqgQDppWM5eRsui73Vnw501CKAl3TBUY0mQjUL6CxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kwfe8kRA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7PrYUi+m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.571240036@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vXPCMrPwGrJjX858eQh8BXnWzZ6Yig+J2QuB2rurbL0=;
	b=Kwfe8kRAdTEDXospO4AAKMJu55D/3M7fRmrEW12rngOQzXYSEKBCor+NvfzU5qHJEcs0CM
	R6qEIywleaHXsaaTAgpBC7UFL4twnXfK4nxFvVmPEPRKfSerLG6jlMRp0YAQr85R+r4jW7
	48YiFQBrDdqypIbB/tXFGyoCQkYp/mtW53V/h1X5Q5habEs/IB+rs4TGua3McY44i/9EPM
	PFy7pTZKLiRXHhKFQ0Kji5haUPkBx004THcv1mERRlcyNtIL48SCoi9JAnmmhDajx/eZD0
	1/f/dpfR8RAJcVs+Jv+GSJQL5Lj6lpPqKqjDfQyze5D1//TqIwCnIaoWMKqldw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vXPCMrPwGrJjX858eQh8BXnWzZ6Yig+J2QuB2rurbL0=;
	b=7PrYUi+mLm5feOooZsxJFhtOBOc5kFndJxUY0Pw+3Nwu+38Paua1zKiSgt1ymz8J2UKALI
	XsvAAm20nnb3unAg==
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
Subject: [patch V2 10/50] posix-cpu-timers: Handle SIGEV_NONE timers correctly
 in timer_get()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:29 +0200 (CEST)

Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
timer_get(), but the posix CPU timer implementation returns 1 nsec.

Add the missing conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -787,15 +787,17 @@ static int posix_cpu_timer_set(struct k_
 
 static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	u64 expires, iv = timer->it_interval;
 
 	/*
 	 * Make sure that interval timers are moved forward for the
 	 * following cases:
+	 *  - SIGEV_NONE timers which are never armed
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
+	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
@@ -809,11 +811,13 @@ static void __posix_cpu_timer_get(struct
 		itp->it_value = ns_to_timespec64(expires - now);
 	} else {
 		/*
-		 * The timer should have expired already, but the firing
-		 * hasn't taken place yet.  Say it's just about to expire.
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
-		itp->it_value.tv_nsec = 1;
-		itp->it_value.tv_sec = 0;
+		if (!sigev_none)
+			itp->it_value.tv_nsec = 1;
 	}
 }
 


