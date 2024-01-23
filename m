Return-Path: <linux-kernel+bounces-35703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C7839559
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0B228670A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF2823D5;
	Tue, 23 Jan 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaV2OZp+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZvGQp3T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A781ADD;
	Tue, 23 Jan 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028440; cv=none; b=L9Vkkcl9x3AERU7feg4Rn+9fihm5Jav9TYok5gbZjWyR0SWC0yQroz+xhz0W0CwOVqyjV/CZ0NUQGKJAsAJ7u96TxkOzi0/I/NHCc727NZiv8AxlEroJWrf+KP9+OfwYc4ds3gBLKrFq3FI+KsGpJ++zTgdniLpRpnJV46/xxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028440; c=relaxed/simple;
	bh=d8rsDzMorDANdDMVQ3WQDhgi/FdSTHxklICIHXgHMvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9F+ItRBiUVn0A0uMTBox/iZJ8sLeDFVBHi1a+0Td4r/6LjgdNJWO6cGFuRluo7ZtH7T01QFPN7ah16bH3AFZ/addpApPy5r61KMU/pOJv0cj6I5RgtXyQskIu7w/2eqNJvJbQhLORqLuvU8JLXM+Q2/jfx84u2w6YUp/5cZp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaV2OZp+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PZvGQp3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0sxRv/SQf4nMms7k/oUwYmN6EK8PHV+d6aCUPuL/OY=;
	b=IaV2OZp+82gkYOAV+dk4Zl5Pq/IpigdN4/qk/TGHR43GhajiQJlF66S9vy7HipdqedE1CD
	tR7/fM7p7wmhnPlcXqXpLGRWP+Lg9kpKEwq5UgVXI12WlInhyf6Dn0dkNOhMlb3zUipLJB
	GoYVByy4D6IOXkisiwyC4K9rdCtyWvSe/5sty5NPWBTsbmUF/SXbNZaD9HtvtCSm/G53Nv
	uf8uigvwGdqrT6VKFQZF/gDUC3ToIBf3Qlv0RwdVOqV5tQpsyQSAtyUrGv33enxt4qaZU+
	zb8qvCrqT9TutCQttTLqWeMLnzJe72Q0r5vH3MY2fCzd/a5DhEArfgEbG5Loow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0sxRv/SQf4nMms7k/oUwYmN6EK8PHV+d6aCUPuL/OY=;
	b=PZvGQp3T7mdQiqZcppvQM3x23Dfd6TVpV11f6Zpt1zxEhdsU4qQziTKnKgr9T2LfrL1bHC
	dosDHgv8nHgna1Dg==
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 4/8] timers: Add struct member description for timer_base
Date: Tue, 23 Jan 2024 17:46:58 +0100
Message-Id: <20240123164702.55612-5-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timer_base struct lacks description of struct members. Important struct
member information is sprinkled in comments or in code all over the place.

Collect information and write struct description to keep track of most
important information in a single place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 352b161113cd..d44dba1d4af0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -196,6 +196,51 @@ EXPORT_SYMBOL(jiffies_64);
 # define BASE_DEF	0
 #endif
 
+/**
+ * struct timer_base - Per CPU timer base (number of base depends on config)
+ * @lock:		Lock protecting the timer_base
+ * @running_timer:	When expiring timers, the lock is dropped. To make
+ *			sure not to race agains deleting/modifying a
+ *			currently running timer, the pointer is set to the
+ *			timer, which expires at the moment. If no timer is
+ *			running, the pointer is NULL.
+ * @expiry_lock:	PREEMPT_RT only: Lock is taken in softirq around
+ *			timer expiry callback execution and when trying to
+ *			delete a running timer and it wasn't successful in
+ *			the first glance. It prevents priority inversion
+ *			when callback was preempted on a remote CPU and a
+ *			caller tries to delete the running timer. It also
+ *			prevents a life lock, when the task which tries to
+ *			delete a timer preempted the softirq thread which
+ *			is running the timer callback function.
+ * @timer_waiters:	PREEMPT_RT only: Tells, if there is a waiter
+ *			waiting for the end of the timer callback function
+ *			execution.
+ * @clk:		clock of the timer base; is updated before enqueue
+ *			of a timer; during expiry, it is 1 offset ahead of
+ *			jiffies to avoid endless requeuing to current
+ *			jiffies
+ * @next_expiry:	expiry value of the first timer; it is updated when
+ *			finding the next timer and during enqueue; the
+ *			value is not valid, when next_expiry_recalc is set
+ * @cpu:		Number of CPU the timer base belongs to
+ * @next_expiry_recalc: States, whether a recalculation of next_expiry is
+ *			required. Value is set true, when a timer was
+ *			deleted.
+ * @is_idle:		Is set, when timer_base is idle. It is triggered by NOHZ
+ *			code. This state is only used in standard
+ *			base. Deferrable timers, which are enqueued remotely
+ *			never wake up an idle CPU. So no matter of supporting it
+ *			for this base.
+ * @timers_pending:	Is set, when a timer is pending in the base. It is only
+ *			reliable when next_expiry_recalc is not set.
+ * @pending_map:	bitmap of the timer wheel; each bit reflects a
+ *			bucket of the wheel. When a bit is set, at least a
+ *			single timer is enqueued in the related bucket.
+ * @vectors:		Array of lists; Each array member reflects a bucket
+ *			of the timer wheel. The list contains all timers
+ *			which are enqueued into a specific bucket.
+ */
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
-- 
2.39.2


