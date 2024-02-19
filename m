Return-Path: <linux-kernel+bounces-70952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA1859EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF841F238FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02A224F5;
	Mon, 19 Feb 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="by1Sm/eU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOFoaNFG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8621357;
	Mon, 19 Feb 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332337; cv=none; b=I0rf5wg/rsls6JtQcdANy+GnJo6Y0Kq/rFcoRM03xGDA8ouEncVrMnCwKnPLwjGj34SeYWNtV7amRKaaRPae2EWUumKInlSGkHELe5GEHsfmWp3MEfzBCx1A1dN8EGCIysh7a2x6tJOgVqnPIXRCdWIfEONi+OveHxbVFyajahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332337; c=relaxed/simple;
	bh=dQhvt5u878Nz51soq9rQAxJ2HC1xgdldzoXDlIFFyDY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g+D938HeTELROx1jVi/0LXIe/Et9WTTw2C+XP18DE47xfi5Z5n6xygjviS/dbUnw06FFT0b7TCslwh6CQ3HFF0lyMop3b8xgyNLuGwF1rfWrNOvlBWHpCnodT/vjrRjCHhfH+Z32cCZqKJbaMgZZtOYxmIzfd5iyVyt5/S0igY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=by1Sm/eU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOFoaNFG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 08:45:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708332333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQwp9IZkka2ZaAhWMN3EeTNgCDwS9jDJORDVtPlv+do=;
	b=by1Sm/eUluzFQ3sBXnqTBwuzuOxonsN72Y8IopkwRjYga0GJlbP8FmMep1vI6gkGtC2jZR
	7Yp2DFY7hLODc4o2ObACYKdMQvPSTH1pWw1tuhxp+QUDEqa6PJUl/GoIQgt4CuKSh2y5xF
	WmLBZ8ZJPYa2PZx2klccZVufwPSLZ58iYGBb6HhY9zNfzjjsCO9TbtA8k8gbCeHoNrS9o7
	zETGjTx+q/rIxDl064fgErSzlLaK3Pg10lBc/rdauSsdQcf/rKWENV6sUWhzmfRAcFRNSb
	YFXC/okDnOzNqZJdkDQwMEJvhiewDw3tSDvzjOBxJfHg2/aSuQuMhSl5Vj6T8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708332333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQwp9IZkka2ZaAhWMN3EeTNgCDwS9jDJORDVtPlv+do=;
	b=pOFoaNFGs8wxHfZO/r5jn0WAxWbOaTQnH+ZxAz4FletkHLboiUMidpc+5AyGEbfV7oHO/g
	5BZ9MzvzP/dt0CAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Add struct member description for timer_base
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123164702.55612-5-anna-maria@linutronix.de>
References: <20240123164702.55612-5-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170833233296.398.7236151301975481128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     892abd357183bc663d6984d10c62f94b40bfc375
Gitweb:        https://git.kernel.org/tip/892abd357183bc663d6984d10c62f94b40bfc375
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 23 Jan 2024 17:46:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 09:38:00 +01:00

timers: Add struct member description for timer_base

timer_base struct lacks description of struct members. Important struct
member information is sprinkled in comments or in code all over the place.

Collect information and write struct description to keep track of most
important information in a single place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240123164702.55612-5-anna-maria@linutronix.de

---
 kernel/time/timer.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 352b161..d44dba1 100644
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

