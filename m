Return-Path: <linux-kernel+bounces-139503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543D8A03C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53993B23A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C06137938;
	Wed, 10 Apr 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YZJxQh1d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0MpMRws"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA2137920
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789262; cv=none; b=EmpG5TwvvTBPak7G7nli3OfP0HWI8a+RKX/stGbnew4I6d3btBRKbmrE340hsTIIon/AkYDj48r6z1/X6lVZOUbkvlw/R/vp7P5eR9eLXJfnI9Lo+kCtUfH61JiH2pEdM0WoGv/eWetga50J8FI+R5pj3oMZ+BjarJoUr+iwyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789262; c=relaxed/simple;
	bh=dVOMH7eiDEHVePUyZa4h1ExK1Rjvcqco8G9d9SW/qIU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gmAVOXhulHbyYCUQbTCkNwihjluPXmnCeD0//7dGIDBlVKSsRIiDwtNv9Y++JDVWp/Brj4uPZt3YPKKe+6Z8ao9ZUIHjfur86AMLReqivygsEZdbMKAchZLJiSHAvOCkPnEfrxYvHMY91VOhLGoj8A94fvp2M1XaRCqf2a1n/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YZJxQh1d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0MpMRws; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165554.006264248@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HdIXDmhsPUZ2RPLujxzrsxlJ5xE23RHzUivxcwc9L5U=;
	b=YZJxQh1d7Qif5pxOkRNipZyUppU6m7sWLta6DG+n/0pZ/d3DDBme6w9JKblkxesr2xKRAe
	NDaUMFmXYwQ9k99YKrz5ayXJsIr9vM4nVNU+Lv3v9p61poxL0/miinJE1MJQfRblI5ZyqN
	wcjBBnQYDjmBwfv2r6tUVY5XSmGXsrolH68Uj6Jz7l4ZquTNpim7Syda1dmz3LZ9KNni8a
	hGX+OomHVlNmRnTnMixD78g8r6fkWXWyD1AUGmCHQIHqWjMxOImsSYyjnrgPUQA6On6lD+
	9Py09DDHUzPQMnf1p+2VUU+b9TtySj8Rw+QN2Rr8u753N1WQHpr8KLL7zFIu2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HdIXDmhsPUZ2RPLujxzrsxlJ5xE23RHzUivxcwc9L5U=;
	b=U0MpMRwsQqLODerCJMW3g9iewUoFzUAL4LK7s/hdDaIgFg7aH5IFT4KJfnF94R40zLByef
	hPYWncPcq/ud5NCw==
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
Subject: [patch V2 49/50] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:38 +0200 (CEST)

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the unused alarm timer parts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -469,35 +469,11 @@ u64 alarm_forward(struct alarm *alarm, k
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
 
-static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool throttle)
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	ktime_t now = base->get_ktime();
-
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
-		/*
-		 * Same issue as with posix_timer_fn(). Timers which are
-		 * periodic but the signal is ignored can starve the system
-		 * with a very small interval. The real fix which was
-		 * promised in the context of posix_timer_fn() never
-		 * materialized, but someone should really work on it.
-		 *
-		 * To prevent DOS fake @now to be 1 jiffie out which keeps
-		 * the overrun accounting correct but creates an
-		 * inconsistency vs. timer_gettime(2).
-		 */
-		ktime_t kj = NSEC_PER_SEC / HZ;
 
-		if (interval < kj)
-			now = ktime_add(now, kj);
-	}
-
-	return alarm_forward(alarm, now, interval);
-}
-
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
-{
-	return __alarm_forward_now(alarm, interval, false);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 


