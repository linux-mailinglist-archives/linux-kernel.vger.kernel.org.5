Return-Path: <linux-kernel+bounces-7229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7F81A377
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE99281C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C210D48CCA;
	Wed, 20 Dec 2023 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rDQvxYM6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUHeoUbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2447A66;
	Wed, 20 Dec 2023 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2cYFFxbS9r6uTryeX9Gz9Qr7bZHoLddNK2Xwnf8vnc=;
	b=rDQvxYM6LdIHH32XQchXW1nY/cDUT336SDlAX1wyV9Ghnrm+iaRTrQEjoX6GwRoqtAwVR8
	JDB//jHSQdzCbYcczaERLQoMgBxHTiFzOThSw5lZLCGI+DLbeQeJN5H7rHU7Q8a57F28Ne
	rdnzz6KnzGHnBD0JedGna9GGgNtyYKC6jnF+4lGGjFQ6Dv8X+dIKQ6+Z7TK7B53dMOd9tA
	9D87OfEBOKAbgMAISimXynpF/WHKaB/AaMjcwpQe0PYU2FgBSvJmkpHb62M1turENzg/Mx
	HbbLK868DaluFH4/ciOJ4ym7qYP0TCC59f3xG0FrrLZvu2Cm2Lfi9ONsJDUYdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2cYFFxbS9r6uTryeX9Gz9Qr7bZHoLddNK2Xwnf8vnc=;
	b=rUHeoUbwRtlZae6xeFbGxr3phvxxuwp3KTRrX09n3IjEUnETsBJhuweeNIaSPFGGheTzM3
	sRz1PNGA5DnGqTDA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Clarify check in forward_timer_base()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-9-anna-maria@linutronix.de>
References: <20231201092654.34614-9-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308794817.398.17855561566614353854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8a2c9c7e7848d7f63d38b698209148b5bb4ba7f3
Gitweb:        https://git.kernel.org/tip/8a2c9c7e7848d7f63d38b698209148b5bb4ba7f3
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

timers: Clarify check in forward_timer_base()

The current check whether a forward of the timer base is required can be
simplified by using an already existing comparison function which is easier
to read. The related comment is outdated and was not updated when the check
changed in commit 36cd28a4cdd0 ("timers: Lower base clock forwarding
threshold").

Use time_before_eq() for the check and replace the comment by copying the
comment from the same check inside get_next_timer_interrupt(). Move the
precious information of the outdated comment to the proper place in
__run_timers().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-9-anna-maria@linutronix.de

---
 kernel/time/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 490ff8e..f75f932 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -944,11 +944,10 @@ static inline void forward_timer_base(struct timer_base *base)
 	unsigned long jnow = READ_ONCE(jiffies);
 
 	/*
-	 * No need to forward if we are close enough below jiffies.
-	 * Also while executing timers, base->clk is 1 offset ahead
-	 * of jiffies to avoid endless requeuing to current jiffies.
+	 * Check whether we can forward the base. We can only do that when
+	 * @basej is past base->clk otherwise we might rewind base->clk.
 	 */
-	if ((long)(jnow - base->clk) < 1)
+	if (time_before_eq(jnow, base->clk))
 		return;
 
 	/*
@@ -2021,6 +2020,10 @@ static inline void __run_timers(struct timer_base *base)
 		 */
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
+		/*
+		 * While executing timers, base->clk is set 1 offset ahead of
+		 * jiffies to avoid endless requeuing to current jiffies.
+		 */
 		base->clk++;
 		next_expiry_recalc(base);
 

