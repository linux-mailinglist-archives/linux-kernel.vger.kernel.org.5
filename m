Return-Path: <linux-kernel+bounces-76938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD185FEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250B628B565
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB60C157E70;
	Thu, 22 Feb 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAI9ZvpB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jM6gd+8y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040C15531F;
	Thu, 22 Feb 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621932; cv=none; b=ZvDl3I89EI1GuwTJ55S3GprbKZi4omSCRBfgYj7mP+2jA11EHizl4PZ0ZQq8vtE5r+NUmIP7can2zhlI5g09VTEeINxaiv7zLtA7KT2WMu2vBFm+tXmee0mVEJwSiQMLnEf8/lTalQHWjXRcpOPxl3zclGE2hlfN/qCimYIOV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621932; c=relaxed/simple;
	bh=iz/0atIqVTkjNZkdwKWQy3RNapr8HgTKcqdSsz0XKuU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hA5as4gyyWlvilJNno/TZyVQOE8FGat7lrJgZeuf7lkVoVmWvvqUlOZqJ/rnTED/HFMwOkp2sDW3yXRXKmKn2IwIpWE9gB1tp1G2WAbqvMufhD/apxbnFtxR2TFiBotcMNArck9xvZ3I6nrOuk9kcb093JDhFaJfpn7g+V9rMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAI9ZvpB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jM6gd+8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLn33LD8Qj/C95HP7uinFUBZxJe0QSWpPvGr/HdBU/A=;
	b=zAI9ZvpBUdtZ062Degjl1ue8dKg2SOLUqiyk1j9o9wPcTGeScbD/E1FsDiXRbONNVtyYdd
	cfyXeT1EEZ0EVq7Wqkp2DjtlwH7h4WQSjqLRISVxvr2vuj0661ZRo4DXi8QA/I9LXt5ljX
	ghV/7g0ROGp4ub3juVvNtn7EqrExucTZAylT73UVKvoLoBNYHKwRyYer3dQiI5ekGdXxgA
	6pXQr6KzAU0I3NULGlW1tuXo+0DXXsIKq5AHWvgs6j0f+K7FN+Gy0Di5dQ1ZAgXA0CnS+9
	kUpTT+A8soRZdRAEFbqgZpUWkccyhUCMODec5HDYogDr0tLyT55V9il8DmiwHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLn33LD8Qj/C95HP7uinFUBZxJe0QSWpPvGr/HdBU/A=;
	b=jM6gd+8y96z0tlHPuuzRSCvS8ybYFx2WNZaicqGxcg/9RpHEx39rXU6/l1bagc4Oc4FiI/
	aaIg+zrV+c8e1DBw==
From:
 "tip-bot2 for Richard Cochran (linutronix GmbH)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Restructure internal locking
Cc: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-15-anna-maria@linutronix.de>
References: <20240221090548.36600-15-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192867.398.3423551157545120676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     90f5df66c86c259d61aff84e16f519fe1424e1ef
Gitweb:        https://git.kernel.org/tip/90f5df66c86c259d61aff84e16f519fe1424e1ef
Author:        Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
AuthorDate:    Wed, 21 Feb 2024 10:05:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Restructure internal locking

Move the locking out from __run_timers() to the call sites, so the
protected section can be extended at the call site. Preparatory work for
changing the NOHZ timer placement to a pull at expiry time model.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-15-anna-maria@linutronix.de

---
 kernel/time/timer.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index bc074c0..51053af 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2283,11 +2283,7 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (time_before(jiffies, base->next_expiry))
-		return;
-
-	timer_base_lock_expiry(base);
-	raw_spin_lock_irq(&base->lock);
+	lockdep_assert_held(&base->lock);
 
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
@@ -2311,21 +2307,36 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+}
+
+static void __run_timer_base(struct timer_base *base)
+{
+	if (time_before(jiffies, base->next_expiry))
+		return;
+
+	timer_base_lock_expiry(base);
+	raw_spin_lock_irq(&base->lock);
+	__run_timers(base);
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
 
+static void run_timer_base(int index)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[index]);
+
+	__run_timer_base(base);
+}
+
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-
-	__run_timers(base);
+	run_timer_base(BASE_LOCAL);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_GLOBAL]));
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		run_timer_base(BASE_GLOBAL);
+		run_timer_base(BASE_DEF);
 	}
 }
 

