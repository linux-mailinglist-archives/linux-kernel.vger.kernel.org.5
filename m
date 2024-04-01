Return-Path: <linux-kernel+bounces-126529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C4F893924
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E3281E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E7DF62;
	Mon,  1 Apr 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZLb1zm7q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4sTSJedq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336EDDA7;
	Mon,  1 Apr 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961257; cv=none; b=W7pxBSclb2jP/++eiKKWuhkUWi8f9GzuNUQYKHmXFwrN6XmGUm7twMjHbYGo4KgdhDWDwqk0sc8ADaDB1V0wdOB9HsnB8ihdCLT+0xsnCwKkup9bNNmoXYeZ+TseXyPfsFD1TYbgUO3cNnfKS+O1nEpJa318OI3o2RHGbBi5Uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961257; c=relaxed/simple;
	bh=WacFEThZdZ/CeEkhPpaOXAkvpDcAJFT5q5lXYhowVgs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NqwqAXWFt1wviDvYm2bu91EnfR6kJq3EeVtNP8g2UGtCV5JJF2YXjNgCqQWPz1TfyMVDQcNDVg43hmzeU7PNU0yqUmIQiE0XTjzZNHoN4aZPuiHIH9WODzpXiZHGBRkqpa6cTvBauy31AXUu7qp8aKF1izQL2tdc7gJD7hyExOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZLb1zm7q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4sTSJedq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Apr 2024 08:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711961247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtHh4UuqdvPc0eGJDnBaV3DpW+FpXi8pKi6HDkOgI+U=;
	b=ZLb1zm7qZZeILP0O9tWhW2Uzv4MvEt3jYd9/IKIK+0RLM+hvPFrHsY8Mnvoanwq4xEECVF
	uZ8lXlrr55BlGLQof8FvyiwTph0HXC1qiIRs8o7w1i0RknYuxNGSi3F+k06gtrsQoj2Uhi
	sUEfmYlrzLqbABSOKYf5fR/DkPmp4f7aYTUjFU9CJ2F+ibrW9zrCDr+lTDEA1Y6uCHaPyw
	QIluBaYv0h/oYvjc6eixP0XWMbnXyHl0j580QwZXrGeWsWrj5AHfVnO1MMX+TEP8X2G5tb
	KIltXA5ebrEBHs5BirUSztnGcNwAFf5yH01jMwuhPmyRVfMkAWYB1ETeT/UzvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711961247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtHh4UuqdvPc0eGJDnBaV3DpW+FpXi8pKi6HDkOgI+U=;
	b=4sTSJedqEqQTPQH0PY96NTMFoogocug92cL3+n5WEbPczW1POTvJm8kMhlwRzYKoXud5Wd
	4Hu4HyvEiY+YwXDQ==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers: Fix text inconsistencies and spelling
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240331172652.14086-7-rdunlap@infradead.org>
References: <20240331172652.14086-7-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171196124670.10875.10311187024916401962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     9e643ab59d7ee4332994671720a9528bac62e9b7
Gitweb:        https://git.kernel.org/tip/9e643ab59d7ee4332994671720a9528bac62e9b7
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 31 Mar 2024 10:26:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Apr 2024 10:36:35 +02:00

timers: Fix text inconsistencies and spelling

Fix some text for consistency: s/lvl/level/ in a comment and use
correct/full function names in comments.

Correct spelling errors as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240331172652.14086-7-rdunlap@infradead.org
---
 kernel/time/timer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index dee29f1..3baf2fb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -64,15 +64,15 @@ EXPORT_SYMBOL(jiffies_64);
 
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
- * LVL_SIZE buckets. Each level is driven by its own clock and therefor each
+ * LVL_SIZE buckets. Each level is driven by its own clock and therefore each
  * level has a different granularity.
  *
- * The level granularity is:		LVL_CLK_DIV ^ lvl
+ * The level granularity is:		LVL_CLK_DIV ^ level
  * The level clock frequency is:	HZ / (LVL_CLK_DIV ^ level)
  *
  * The array level of a newly armed timer depends on the relative expiry
  * time. The farther the expiry time is away the higher the array level and
- * therefor the granularity becomes.
+ * therefore the granularity becomes.
  *
  * Contrary to the original timer wheel implementation, which aims for 'exact'
  * expiry of the timers, this implementation removes the need for recascading
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(jiffies_64);
  * struct timer_base - Per CPU timer base (number of base depends on config)
  * @lock:		Lock protecting the timer_base
  * @running_timer:	When expiring timers, the lock is dropped. To make
- *			sure not to race agains deleting/modifying a
+ *			sure not to race against deleting/modifying a
  *			currently running timer, the pointer is set to the
  *			timer, which expires at the moment. If no timer is
  *			running, the pointer is NULL.
@@ -737,7 +737,7 @@ static bool timer_is_static_object(void *addr)
 }
 
 /*
- * fixup_init is called when:
+ * timer_fixup_init is called when:
  * - an active object is initialized
  */
 static bool timer_fixup_init(void *addr, enum debug_obj_state state)
@@ -761,7 +761,7 @@ static void stub_timer(struct timer_list *unused)
 }
 
 /*
- * fixup_activate is called when:
+ * timer_fixup_activate is called when:
  * - an active object is activated
  * - an unknown non-static object is activated
  */
@@ -783,7 +783,7 @@ static bool timer_fixup_activate(void *addr, enum debug_obj_state state)
 }
 
 /*
- * fixup_free is called when:
+ * timer_fixup_free is called when:
  * - an active object is freed
  */
 static bool timer_fixup_free(void *addr, enum debug_obj_state state)
@@ -801,7 +801,7 @@ static bool timer_fixup_free(void *addr, enum debug_obj_state state)
 }
 
 /*
- * fixup_assert_init is called when:
+ * timer_fixup_assert_init is called when:
  * - an untracked/uninit-ed object is found
  */
 static bool timer_fixup_assert_init(void *addr, enum debug_obj_state state)
@@ -914,7 +914,7 @@ static void do_init_timer(struct timer_list *timer,
  * @key: lockdep class key of the fake lock used for tracking timer
  *       sync lock dependencies
  *
- * init_timer_key() must be done to a timer prior calling *any* of the
+ * init_timer_key() must be done to a timer prior to calling *any* of the
  * other timer functions.
  */
 void init_timer_key(struct timer_list *timer,
@@ -1417,7 +1417,7 @@ static int __timer_delete(struct timer_list *timer, bool shutdown)
 	 * If @shutdown is set then the lock has to be taken whether the
 	 * timer is pending or not to protect against a concurrent rearm
 	 * which might hit between the lockless pending check and the lock
-	 * aquisition. By taking the lock it is ensured that such a newly
+	 * acquisition. By taking the lock it is ensured that such a newly
 	 * enqueued timer is dequeued and cannot end up with
 	 * timer->function == NULL in the expiry code.
 	 *
@@ -2306,7 +2306,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 
 		/*
 		 * When timer base is not set idle, undo the effect of
-		 * tmigr_cpu_deactivate() to prevent inconsitent states - active
+		 * tmigr_cpu_deactivate() to prevent inconsistent states - active
 		 * timer base but inactive timer migration hierarchy.
 		 *
 		 * When timer base was already marked idle, nothing will be

