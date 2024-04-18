Return-Path: <linux-kernel+bounces-149442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3D8A912D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ED31C20F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8514F888;
	Thu, 18 Apr 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wDjtySig"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356164F1E2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713407415; cv=none; b=Wtm9MjvInPaLvuwsLsgFbvPhPFozbw5Fdhsnf3r+2lxcokQLkS7ML6z1AyO3YmDLckMUQo30X+2Fc/451/pyqLxOmsi7Jnldi7uKL5AhXSJj+dbpx9J+xXRx7xK1Xg5hwUViKGRZ06sXKk8AeM34+2vst5OLwRxmNW8voHvh6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713407415; c=relaxed/simple;
	bh=IMP56RhvJSLFJ+ZQWbSX2kc/wrDakyxNU9K0hcpgoM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZgV7xEJkTfw5B9eNDl+/ZDbWPNn2zIbK5U22eH9ufF4ff78nW1CeY9fE7AEbT7pC0bE4M/C4NMWM4vPQXK7wC5ps+cPn6Vwva7Fxd80yUDFy63fgq4sUAD+8SMqizdjvlC/2WFTfZazsQJRPaH5p06eK19a41LRqEflQyunV0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wDjtySig; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713407410; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h8Mgxe98RMZtu3glKZaaHEKrJ1Fp/NRxl64eZJf/vjM=;
	b=wDjtySigCE0F+I4V4NYSWj6O/pjJjYRw+E3KP3/YNp6iGwLbA/rawSxOtD9W7wvUGW2g/XvuEaV73G5N1RpSRiE69NMJS2SnSjAFYNuBEFK8NrTlo64EvPj9/H1Dkzy4pyMB2HObFN3v0y95cX2N0813jYeNTVjuKo14wQPcrsA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W4muzk9_1713407400;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4muzk9_1713407400)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 10:30:09 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: anna-maria@linutronix.de
Cc: frederic@kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] hrtimer: Rename __hrtimer_hres_active() to hrtimer_hres_active()
Date: Thu, 18 Apr 2024 10:30:00 +0800
Message-Id: <20240418023000.130324-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function hrtimer_hres_active() are defined in the hrtimer.c file, but
not called elsewhere, so rename __hrtimer_hres_active() to
hrtimer_hres_active() and remove the old hrtimer_hres_active() function.

kernel/time/hrtimer.c:653:19: warning: unused function 'hrtimer_hres_active'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8778
Fixes: 82ccdf062a64 ("hrtimer: Remove unused function")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Rename __hrtimer_hres_active() to hrtimer_hres_active()
   and remove the old hrtimer_hres_active() function.

 kernel/time/hrtimer.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cae9d04b5584..492c14aac642 100644
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
-- 
2.20.1.7.g153144c


