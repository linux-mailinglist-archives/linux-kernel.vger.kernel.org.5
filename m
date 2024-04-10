Return-Path: <linux-kernel+bounces-139462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD608A0396
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8AF1C2182C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3F46542;
	Wed, 10 Apr 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwBgcegB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hac/vYtR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3044C9C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789191; cv=none; b=aQFlX81kRmqZz404qNcanW31lroif72hKAy+EkrRX1lC4HROzRdk8dGvWtsocVwft54JdDZvjlD9qagqZz1xght2yZpmy5BbH4p0nYyzHl1osPcBEVqooiRv8Mb+7R9mmyji/2eYH03wRLOFfsR3ylgIF6CicxbqPV1n+CKQ2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789191; c=relaxed/simple;
	bh=tBM7wjzipNsnWNbyoaSXjOxN31IJ8Anu9Imn8eeRuXc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=l2Ct9sEl3OouNQMPxyc+RTyyL/dlRckxp2XR35Go6otqVqPXo1ongsjjLSuMOha8soe2mKc0maRQi2rqt3sEjfHUCyUlPBc0/ObliIZMAB85vKb7GBO/kgJMwJftwCo01bVTIK5hKYGVu0bxOIFBmQGnmnp+drS3AGTeNwJgLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwBgcegB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hac/vYtR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.507566619@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bZ0w/TM6AE9SMRNm3Xm9JEw2iNfzEaEbkpBswlSbBEk=;
	b=JwBgcegBSK9F8S1rCnEh4K9h4RRWM/Kw2wiHMj1/nDmTravpXYCT/k0L0Pm0e4ljUM/IHn
	G8/RW6PDW88uQQ3R2Iy9go6jmBxoShjXpcmYMtG1IM7GepGCGWNJzBk5CJRN7zZdVDKGrH
	mTAniro9eIsm9A4r0N/4eB9VgpaiK0zxPURA2Pp9XRsIqNjHBSiEuZ/14cuvL4f/OV5zoF
	vFOOZ/Lk91Fw57CCZPcQvi0WeEDvAKyRKoonTr/Q3zaEYjfTvJhwU5hq/qmt8r97zJmTAz
	ZtNmVeomMpz07L3NteXi1YslIGNDkV1b6gT60sl/GDr8KLikZbHjD2H5FDc4sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bZ0w/TM6AE9SMRNm3Xm9JEw2iNfzEaEbkpBswlSbBEk=;
	b=Hac/vYtRiZ/v2yf/qhXTlwR+4llBiC0FbGcSvaa+/fVJuqyZlm+bBGIdylWhZIkZrjElwO
	xMF2/1wiZ6JXOaCA==
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
Subject: [patch V2 09/50] posix-cpu-timers: Handle interval timers correctly
 in timer_get()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:27 +0200 (CEST)

timer_gettime() must return the remaining time to the next expiry of a
timer or 0 if the timer is not armed and no signal pending, but posix CPU
timers fail to forward a timer which is already expired.

Add the required logic to address that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -787,8 +787,24 @@ static int posix_cpu_timer_set(struct k_
 
 static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
-	u64 expires = cpu_timer_getexpires(&timer->it.cpu);
+	u64 expires, iv = timer->it_interval;
 
+	/*
+	 * Make sure that interval timers are moved forward for the
+	 * following cases:
+	 *  - Timers which expired, but the signal has not yet been
+	 *    delivered
+	 */
+	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
+		expires = bump_cpu_timer(timer, now);
+	else
+		expires = cpu_timer_getexpires(&timer->it.cpu);
+
+	/*
+	 * Expired interval timers cannot have a remaining time <= 0.
+	 * The kernel has to move them forward so that the next
+	 * timer expiry is > @now.
+	 */
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
 	} else {


