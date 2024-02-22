Return-Path: <linux-kernel+bounces-76949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A6085FEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E2C286B88
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2215A4BF;
	Thu, 22 Feb 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJ8zyjHj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLrk6WXe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8B158D84;
	Thu, 22 Feb 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621941; cv=none; b=jB+aXeLbmuyJZMtKBTVMkoWTfyLAuzRMVs1PeahhDC6JqKuWKazRQNPtof+5y2o73pv6wLRgaWBn6SZRIewBsYDT5R7TYl1V3r7JOdGeiaJvtpCfG7VoDnkDK5ZOBV4EnCH60AHwZuRx/cEL7ncLy/5p3dO0JvZPuPXLepD30no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621941; c=relaxed/simple;
	bh=mV2PrR4Usm2PIu4+ErGt4TihHQsC5QqH+o32tIYElZw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DdeLPUY2yOJ4JcRjYDN5NBX5CBiPKMP2TXfk7MDy8/Fy7eyjXXoZUzqD16434Ztyp2ygzCRxKTbsf5/QjyWXpC0Sb9/QlXdV36h64FIo+Y5xFeLX84rK5f5zLn6/zFjOP7FSBanEL10Qdu+MUWVYQGvktV8C0AVlihxXDi6SZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJ8zyjHj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLrk6WXe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVBV2k4IF6uEYwFoMSee/IXm9EY81Z+l9OeRL9GrjE8=;
	b=HJ8zyjHj+lt/48Lmzfyg8BSxVwq9eA4DXhU2MSrOdzqYyfBRObzHJXmki9dStklWpHh17k
	+mUzytK8obbhjREkJNnNJbvmAtTb4sO6MvPeqJ0GN8JDNTOWTeaKoX6btmGj0pXExeWjeg
	reOYbg8piXWUB4BKvd0Ivj8x/ZppXW2ftHpnNf+n94VmOy3dzIlV/n68kKzPzCRy4EjAf0
	U2aild7Mz3wpD4f1TGMwe7lVtP8oH9Cl20ns6u3PGInEHbOuD8acZs4tqnFJU2GhIAfsK2
	iTThCkdirSQfDOmGr/Olju3YVpiWYYd0cVvzOtKWTlzQT6rZzpJogVleyd3quA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVBV2k4IF6uEYwFoMSee/IXm9EY81Z+l9OeRL9GrjE8=;
	b=fLrk6WXeASLDRnyP3X1WKIRPXTgQSRCFR4Flt9hY9h+pewZbVLA/9kH7jF968CEFWw7BSX
	9AMY+gO/5J8IVAAg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Split out get next timer interrupt
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-3-anna-maria@linutronix.de>
References: <20240221090548.36600-3-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193662.398.10028344831805251766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     39ed699fb660c65cef4759c041763c75e0948425
Gitweb:        https://git.kernel.org/tip/39ed699fb660c65cef4759c041763c75e0948425
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:30 +01:00

timers: Split out get next timer interrupt

Split out get_next_timer_interrupt() to be able to extend it and make it
reusable for other call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-3-anna-maria@linutronix.de

---
 kernel/time/timer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 316ded6..9f0cdba 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1956,15 +1956,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-/**
- * get_next_timer_interrupt - return the time (clock mono) of the next timer
- * @basej:	base time jiffies
- * @basem:	base time clock monotonic
- *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
- */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
@@ -2024,6 +2016,19 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 }
 
 /**
+ * get_next_timer_interrupt() - return the time (clock mono) of the next timer
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ *
+ * Returns the tick aligned clock monotonic time of the next pending
+ * timer or KTIME_MAX if no timer is pending.
+ */
+u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+{
+	return __get_next_timer_interrupt(basej, basem);
+}
+
+/**
  * timer_clear_idle - Clear the idle state of the timer base
  *
  * Called with interrupts disabled

