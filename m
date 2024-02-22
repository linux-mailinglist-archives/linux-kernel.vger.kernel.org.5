Return-Path: <linux-kernel+bounces-76948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C571085FEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664F01F2A5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4615A487;
	Thu, 22 Feb 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZfxZJ5A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pEU6xs7W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB02158D60;
	Thu, 22 Feb 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621940; cv=none; b=XDMowAxHtsFg0mhedUS6eR5wbd+gIQ0rDnb2bU0+j387EtcZMA8T4hDSuqU9OfAbxZENNqhkXVM92tpsHV5+U9rneJ/pHtCQIdCFf+hvbFVNIsLHY3UGYzY9KAuenPfI7KCaSSNfBHcG45ERi08dYTD8goDUAJj9n8XI/5781P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621940; c=relaxed/simple;
	bh=spfvFpvgZqlevST9g3chJJby3hp1JGyx6xw/6yUN+zg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bYTDzvK9jpMNw9LVy8DCAYZc+kxmmgBeDqhURoaHG/+bDNpX8k/oBDl6s7VEkmE8YCsRrltG+sPm2MfK/roV1t+Fq8TwAzIQZgCqrSVfS5EJgEpIQxvixyFe6pu4Yfzq3W94vOnciIhnMQXoAUf0Y1u+Y82FEEn54cnI7IE10e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZfxZJ5A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pEU6xs7W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkVvU6QEBG4OfplpO7retMfGa8X9Pg44oLEEEvAMwXI=;
	b=wZfxZJ5A2Tax5mLdo9lquOskjgFIzwwNjYFyVEHCxhig3gHxLo0rSEpoTMeUatKsVpaLWk
	h6hohRX+msdWqJN5wjEDlo0SThY4Uj2kU0h93N2PZRxIhmGrtLx1x8xMQVe3aVK24msP5j
	pd++0Psn9yJf9fRPwanqgGjZZ80fagAGln5xlVn8oLNpH6nd2FCMzRkad5AgYZMXspnD3C
	7bkV8fw1khMb1qj05AvoJ0U9YrfsY2CqFpjrYyt1TjQB3v++0P3AaWo2+PQxZSMuTQTRCi
	EUdesZq5ODXhPjzOMLbzxpiANTkUzvfGR6VN725BjPk7TOcRJlhkIRaCKmG2Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkVvU6QEBG4OfplpO7retMfGa8X9Pg44oLEEEvAMwXI=;
	b=pEU6xs7WG/JTgjx3itrGmYe/qc5SRdUS6PHYRruuZ/AnvJnCuuHIkjwTEeI2515GfvKg8P
	Ff86PfgSF/uuwbCA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Optimization for timer_base_try_to_set_idle()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-5-anna-maria@linutronix.de>
References: <20240221090548.36600-5-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193530.398.12139687590128589522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     73129cf4b69cd1aaa3dd5eb7900a9c349773f5ae
Gitweb:        https://git.kernel.org/tip/73129cf4b69cd1aaa3dd5eb7900a9c349773f5ae
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:30 +01:00

timers: Optimization for timer_base_try_to_set_idle()

When tick is stopped also the timer base is_idle flag is set. When
reentering timer_base_try_to_set_idle() with the tick stopped, there is no
need to check whether the timer base needs to be set idle again. When a
timer was enqueued in the meantime, this is already handled by the
tick_nohz_next_event() call which was executed before
tick_nohz_stop_tick().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-5-anna-maria@linutronix.de

---
 kernel/time/tick-sched.c |  2 +-
 kernel/time/timer.c      | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 344b904..f6b6133 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -896,7 +896,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	bool timer_idle;
+	bool timer_idle = ts->tick_stopped;
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a4b8a58..74cfe21 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2044,13 +2044,18 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  * timer_base_try_to_set_idle() - Try to set the idle state of the timer bases
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
- * @idle:	pointer to store the value of timer_base->is_idle
+ * @idle:	pointer to store the value of timer_base->is_idle on return;
+ *		*idle contains the information whether tick was already stopped
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Returns the tick aligned clock monotonic time of the next pending timer or
+ * KTIME_MAX if no timer is pending. When tick was already stopped KTIME_MAX is
+ * returned as well.
  */
 u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
 {
+	if (*idle)
+		return KTIME_MAX;
+
 	return __get_next_timer_interrupt(basej, basem, idle);
 }
 

