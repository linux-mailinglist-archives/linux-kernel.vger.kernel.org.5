Return-Path: <linux-kernel+bounces-54656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C9784B219
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E40284620
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6CF12EBC5;
	Tue,  6 Feb 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HtH0ojja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKEfr1is"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D912E1C5;
	Tue,  6 Feb 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214227; cv=none; b=KmpWSpMknIMFCpGxLHiy3RtcHBBAx6Ej1Z9ZyQh6ZW02v2XGJYO9nq/YwwsJWWkgnrYUg5JnFZTTNlebuSEyjL7iGmLFY+dO2rkFsq0WUeu5fO6zmuA5qsK2A5t5ra6UxjBXnWuLRuSecEVPid6BY+DjgwXLi+sQc8GI1QdPdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214227; c=relaxed/simple;
	bh=/WH4wHExctajLCka8lPaJbDC+CM3T/biAoLKRWKeI9c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=clp8MQpCZuBQ9ddiI4PJAWLd62eQjcPsDD41c8/roYSP7TfVgLMWu3CLbqSrnytWAa2mce5+iy3oMC71Fz8pQ//HWJ8qPA3uNr/Rcoh6JhuSQ0ASLg4+VGkiSMgEBcmAom0aDrLyOITj/LPqkfzukyd30CKYgJPxsXa/i6d47Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HtH0ojja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKEfr1is; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Feb 2024 10:10:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707214223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85JFYrajsZCSPLaR70HH1roOmEwxVGyELjZIaTlWZzE=;
	b=HtH0ojjaPgsOapXdl4MFrGz9hNSpBrMRiKHQtUGzcWToQMezt/SjXJXx/xejOMN6Cdoy1A
	Sasr0nlsy5PhgFy/kjoIE3pfddjwaKVAgmAHu9u2wyB7ycRpI+NM6KAfkUaoojhbxIHo4L
	btuYjdjyfYCJxkI9CefuVvv8u2lOklMH1qozC/L/HlJZIsZq7wPVsHzLQbzJV4yYOZ2SZl
	eT7WoaXtkK68hnARc9WV1oB9qYYdpz+MeZ5ar5BQh776Wp0eNuLZ2ag42E+B8K2SqUbqqF
	+lagKbyd8ehAxAzJlLcrWPJkEaOqVBNyEjN3QkBi9JWgxZdslUmMHHPUMovznQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707214223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85JFYrajsZCSPLaR70HH1roOmEwxVGyELjZIaTlWZzE=;
	b=GKEfr1isn26zmy7+wqvheQ9ouEgknT3tUwr6cr0khC1Ajczz7oTYFj34vX3KkMKv5nv3iR
	mUL8jG+vFYB0RKDw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Report offline hrtimer enqueue
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240129235646.3171983-4-boqun.feng@gmail.com>
References: <20240129235646.3171983-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170721422238.398.262942897891124372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     dad6a09f3148257ac1773cd90934d721d68ab595
Gitweb:        https://git.kernel.org/tip/dad6a09f3148257ac1773cd90934d721d68ab595
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 29 Jan 2024 15:56:36 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 Feb 2024 10:56:35 +01:00

hrtimer: Report offline hrtimer enqueue

The hrtimers migration on CPU-down hotplug process has been moved
earlier, before the CPU actually goes to die. This leaves a small window
of opportunity to queue an hrtimer in a blind spot, leaving it ignored.

For example a practical case has been reported with RCU waking up a
SCHED_FIFO task right before the CPUHP_AP_IDLE_DEAD stage, queuing that
way a sched/rt timer to the local offline CPU.

Make sure such situations never go unnoticed and warn when that happens.

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240129235646.3171983-4-boqun.feng@gmail.com
---
 include/linux/hrtimer.h | 4 +++-
 kernel/time/hrtimer.c   | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 87e3bed..641c456 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -157,6 +157,7 @@ enum  hrtimer_base_type {
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
  * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
  *			 expired
+ * @online:		CPU is online from an hrtimers point of view
  * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
  *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
@@ -179,7 +180,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7607939..edb0f82 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1085,6 +1085,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2183,6 +2184,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2250,6 +2252,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;

