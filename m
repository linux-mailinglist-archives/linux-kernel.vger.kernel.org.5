Return-Path: <linux-kernel+bounces-153533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B78ACF47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C881C2151F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC71514D1;
	Mon, 22 Apr 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDdIN9R+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnHgf69f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877E1509BC;
	Mon, 22 Apr 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795814; cv=none; b=Bq96SDLJ6A8u4NP1R+x2wTDa15zAEt+xq48UGlE00YUZPzNKAN4aRXZPpBuUsDUZax/zjya/aupGME8nUkeKWIKET/51CiitlCRbOF7/lPfeFajqDv98BnYyAG0HGsBHa3jxjeTVkeZLVzx6wlmT3d3VHQ0+aNZMYrKIuqkuylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795814; c=relaxed/simple;
	bh=DM4MXBIlJl+hbMD/iP1kqHzkmvYUb2rZJI8PVAfn09s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=btHAIJCO8nZKx9uT+ehII/woOLf6iJ73RzSXWiCFaFWij1mZtepfmGSM3X9D669GPkjbk/ulKrpnrGQ1djc1bOa/df+jwm9JDwVOhSM/CCEaBgOfa1mu29PcxChnpHul83zXIFz+0kMxyV95Nfuw1a85/g17Y89wbvmRd+VrLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDdIN9R+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnHgf69f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 14:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713795811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rM706dqH+y/+6dVXz78xopwpM4flVmfD5xS75n+Zdzo=;
	b=GDdIN9R+RE2bNRL29WI3+/kxhVVY2gZfF4Su9erwPTTLxkSv8ZCIE6VQGGjzqRMxHCtvUp
	dALX6kplEEWz1+YuGqm1b8zGnMn2zVhK/WRZbLSziGX6E3hdW5Egz/mr0xoBz1lZptndN+
	GqLK2RJq2emvKhgVnj3jNG62AVn8BfZexo8Qfuzb5mcfO7rU2tPQpHT8Hk/bkwZkQFzHC6
	zgJaDiKZ3Xo/RKdA5OBxGPi5o43s3ORIFBk+N0s354HXaKo98yTrEzowBwmLtlrmX3APN8
	7dL16wCffq6E3YWY3pLg0+KOm3gc22HelCu6bNfM6NAMm6dqgMf0ewfmUZViwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713795811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rM706dqH+y/+6dVXz78xopwpM4flVmfD5xS75n+Zdzo=;
	b=tnHgf69fhJBnH//bn2LBmsbZV8kqRa5j109klHBl2zee5VfLY3kaVzIFCmx0GcIc4K4Z/r
	heEbo2jlfsW7c7Cg==
From: "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Rename __hrtimer_hres_active() to
 hrtimer_hres_active()
Cc: Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240418023000.130324-1-jiapeng.chong@linux.alibaba.com>
References: <20240418023000.130324-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171379581042.10875.13838045439359164045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b7c8e1f8a7b4352c1d0b4310686385e3cf6c104a
Gitweb:        https://git.kernel.org/tip/b7c8e1f8a7b4352c1d0b4310686385e3cf6c104a
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Thu, 18 Apr 2024 10:30:00 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Apr 2024 16:13:19 +02:00

hrtimer: Rename __hrtimer_hres_active() to hrtimer_hres_active()

The function hrtimer_hres_active() are defined in the hrtimer.c file, but
not called elsewhere, so rename __hrtimer_hres_active() to
hrtimer_hres_active() and remove the old hrtimer_hres_active() function.

kernel/time/hrtimer.c:653:19: warning: unused function 'hrtimer_hres_active'.

Fixes: 82ccdf062a64 ("hrtimer: Remove unused function")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20240418023000.130324-1-jiapeng.chong@linux.alibaba.com
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8778
---
 kernel/time/hrtimer.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cae9d04..492c14a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -644,17 +644,12 @@ static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
 /*
  * Is the high resolution mode active ?
  */
-static inline int __hrtimer_hres_active(struct hrtimer_cpu_base *cpu_base)
+static inline int hrtimer_hres_active(struct hrtimer_cpu_base *cpu_base)
 {
 	return IS_ENABLED(CONFIG_HIGH_RES_TIMERS) ?
 		cpu_base->hres_active : 0;
 }
 
-static inline int hrtimer_hres_active(void)
-{
-	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
-}
-
 static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
 				struct hrtimer *next_timer,
 				ktime_t expires_next)
@@ -678,7 +673,7 @@ static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
 	 * set. So we'd effectively block all timers until the T2 event
 	 * fires.
 	 */
-	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
+	if (!hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
 		return;
 
 	tick_program_event(expires_next, 1);
@@ -789,12 +784,12 @@ static void retrigger_next_event(void *arg)
 	 * function call will take care of the reprogramming in case the
 	 * CPU was in a NOHZ idle sleep.
 	 */
-	if (!__hrtimer_hres_active(base) && !tick_nohz_active)
+	if (!hrtimer_hres_active(base) && !tick_nohz_active)
 		return;
 
 	raw_spin_lock(&base->lock);
 	hrtimer_update_base(base);
-	if (__hrtimer_hres_active(base))
+	if (hrtimer_hres_active(base))
 		hrtimer_force_reprogram(base, 0);
 	else
 		hrtimer_update_next_event(base);
@@ -951,7 +946,7 @@ void clock_was_set(unsigned int bases)
 	cpumask_var_t mask;
 	int cpu;
 
-	if (!__hrtimer_hres_active(cpu_base) && !tick_nohz_active)
+	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_active)
 		goto out_timerfd;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -1491,7 +1486,7 @@ u64 hrtimer_get_next_event(void)
 
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
-	if (!__hrtimer_hres_active(cpu_base))
+	if (!hrtimer_hres_active(cpu_base))
 		expires = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
@@ -1514,7 +1509,7 @@ u64 hrtimer_next_event_without(const struct hrtimer *exclude)
 
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
-	if (__hrtimer_hres_active(cpu_base)) {
+	if (hrtimer_hres_active(cpu_base)) {
 		unsigned int active;
 
 		if (!cpu_base->softirq_activated) {
@@ -1886,7 +1881,7 @@ void hrtimer_run_queues(void)
 	unsigned long flags;
 	ktime_t now;
 
-	if (__hrtimer_hres_active(cpu_base))
+	if (hrtimer_hres_active(cpu_base))
 		return;
 
 	/*

