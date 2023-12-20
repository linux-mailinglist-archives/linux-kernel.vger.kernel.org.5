Return-Path: <linux-kernel+bounces-7234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9AB81A382
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26EC1C24A83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51FE4A9B4;
	Wed, 20 Dec 2023 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jinvgm0c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNiduHEx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C3495D7;
	Wed, 20 Dec 2023 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087951;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDMFbsrl7NIvvTeHGjj1b2fApttklFCFE6PwYdb7l2Y=;
	b=Jinvgm0cqZslohr0qoG5Oeu4wpcnGqvtJZ/EljAVYTN6JXbboFd/ILJ4/kkka/KgwUXRY0
	4BwrngnmoeC9TJdyhfjz4mUSMKp4R66yFaJz2q29k5gvhroUiKhjYMzJFYQE/wlTzWyKOi
	lpbt6e/ELdHDtnEt1eLgtFHpIxkQtiV2Jny+k7FrVgtVfs4rQWDU6t54UyEtj9OzkFozKU
	1Gf5F2W7l3GNxsDjSYyptX/oLmFzsysUXBbKuoECuLja9VrDf0qWKsVQa1dMqUgYV8U0gs
	9mw12vQI6MNnCKNjfV6O57/Nv6bHvD6trupkT9hw3J2BYgOFYGpa6LOEczIs/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087951;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDMFbsrl7NIvvTeHGjj1b2fApttklFCFE6PwYdb7l2Y=;
	b=mNiduHExktAHUR6b9ZdS+G2tBOWRzWom0WoVDiqFuzb4smVFbvLrDqrER0nv3WQGDTyYSy
	6PV8vO12zx5IYCDA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tracing/timers: Enhance timer_start tracepoint
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-5-anna-maria@linutronix.de>
References: <20231201092654.34614-5-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308795069.398.13945448411846727113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dbcdcb62b59db2cf6a24113873b90da15c6f0b19
Gitweb:        https://git.kernel.org/tip/dbcdcb62b59db2cf6a24113873b90da15c6f0b19
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

tracing/timers: Enhance timer_start tracepoint

For starting a timer, the timer is enqueued into a bucket of the timer
wheel. The bucket expiry is the defacto expiry of the timer but it is not
equal the timer expiry because of increasing granularity when bucket is in
a higher level of the wheel. To be able to figure out in a trace whether a
timer expired in time or not, the bucket expiry time is required as well.

Add bucket expiry time to the timer_start tracepoint and thereby simplify
the arguments.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-5-anna-maria@linutronix.de

---
 include/trace/events/timer.h | 20 ++++++++++----------
 kernel/time/timer.c          |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index b4bc282..99ada92 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -46,22 +46,21 @@ DEFINE_EVENT(timer_class, timer_init,
 
 /**
  * timer_start - called when the timer is started
- * @timer:	pointer to struct timer_list
- * @expires:	the timers expiry time
- * @flags:	the timers flags
+ * @timer:		pointer to struct timer_list
+ * @bucket_expiry:	the bucket expiry time
  */
 TRACE_EVENT(timer_start,
 
 	TP_PROTO(struct timer_list *timer,
-		unsigned long expires,
-		unsigned int flags),
+		unsigned long bucket_expiry),
 
-	TP_ARGS(timer, expires, flags),
+	TP_ARGS(timer, bucket_expiry),
 
 	TP_STRUCT__entry(
 		__field( void *,	timer		)
 		__field( void *,	function	)
 		__field( unsigned long,	expires		)
+		__field( unsigned long,	bucket_expiry	)
 		__field( unsigned long,	now		)
 		__field( unsigned int,	flags		)
 	),
@@ -69,15 +68,16 @@ TRACE_EVENT(timer_start,
 	TP_fast_assign(
 		__entry->timer		= timer;
 		__entry->function	= timer->function;
-		__entry->expires	= expires;
+		__entry->expires	= timer->expires;
+		__entry->bucket_expiry	= bucket_expiry;
 		__entry->now		= jiffies;
-		__entry->flags		= flags;
+		__entry->flags		= timer->flags;
 	),
 
-	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
+	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] bucket_expiry=%lu cpu=%u idx=%u flags=%s",
 		  __entry->timer, __entry->function, __entry->expires,
 		  (long)__entry->expires - __entry->now,
-		  __entry->flags & TIMER_CPUMASK,
+		  __entry->bucket_expiry, __entry->flags & TIMER_CPUMASK,
 		  __entry->flags >> TIMER_ARRAYSHIFT,
 		  decode_timer_flags(__entry->flags & TIMER_TRACE_FLAGMASK))
 );
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7..a81d793 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -606,7 +606,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 	__set_bit(idx, base->pending_map);
 	timer_set_idx(timer, idx);
 
-	trace_timer_start(timer, timer->expires, timer->flags);
+	trace_timer_start(timer, bucket_expiry);
 
 	/*
 	 * Check whether this is the new first expiring timer. The

