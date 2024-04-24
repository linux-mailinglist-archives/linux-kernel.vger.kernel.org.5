Return-Path: <linux-kernel+bounces-156712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C6F8B072F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CFD1F22A38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8F1598F1;
	Wed, 24 Apr 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HAZnfvH9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ci8CzZYm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C85159589;
	Wed, 24 Apr 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954138; cv=none; b=VKru2TrK4WW237UAlCxD0DW8oGHHPh2RhJ8jEyRzMZw8SZrxhw3wkHJCWl3mD7F2faKtoSS1zT8MOoGV0uQV8KmbAWFZF9Lv0QB4pJzMtmDLe6H3CPZEkHMmT2ohm/hjh0dsdlzej50fbp824vRxMJt7xL3p3uSrK9ODKclwXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954138; c=relaxed/simple;
	bh=c58ruGXdHBHTiN0JCnQnjfVOvlIsy4P4n7D1gbAveeM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UbzgxO4wG/a8y1+z742Iazd5qa7kdTmGF/U3np0ccXbKeBJT9OORm6PFIo1/CIaivLT6IprXxcldOpmB5iCUHT/ukhRBs1CZtcldl4rAWP5e17uG0IAYFh8CNoagctOepMCnxITChGPtpqQ00IW13UbVUYulx6GcOJKamUFlBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HAZnfvH9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ci8CzZYm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:22:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713954134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cTIC5+dPTqSbpBWUDyfvIYbWqBu90juHkYMhfCHuU=;
	b=HAZnfvH9OpaUpb/HmWED6G+OAQ59vMnuVIQh29NkR4iXU/7RxatTB6Zwmz3CdpEwS80SDx
	IwLWwNobLq7eg4/JifrHas9mzVYBPawTuvdve7bDvt3xP8aa9wR3Tr2V/PuYR4mwubxlbo
	pUw/ykr4MQ6222WhPqexIPi7jfLTE5HYSLAUAHFmXwKwBk70/JAn6njIEpnzrbQCzcZ183
	61s59YZxyNe2tbfBEWS9UEsKD3U7uujRXnh0Bz77TGoZ+9uL3WIyYdXeAWG6BfOXo4hBzl
	uWa7rRbJFVzS1KTcp5SGYfT0ia2dSJ523erNm2TQH6f8rUrQ9ihHM6BgRgDrUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713954134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cTIC5+dPTqSbpBWUDyfvIYbWqBu90juHkYMhfCHuU=;
	b=Ci8CzZYmlwKX6UmZgp/9OmRZLllmoMeitR5GeaapB9M34xdkbaDV3FyiCie9WR7Opjl15g
	FfeePigvDq8v+WDg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Remove shift of thermal clock
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Qais Yousef <qyousef@layalina.io>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240326091616.3696851-6-vincent.guittot@linaro.org>
References: <20240326091616.3696851-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395413392.10875.3951642329310305062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     97450eb909658573dcacc1063b06d3d08642c0c1
Gitweb:        https://git.kernel.org/tip/97450eb909658573dcacc1063b06d3d08642c0c1
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 26 Mar 2024 10:16:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 12:08:02 +02:00

sched/pelt: Remove shift of thermal clock

The optional shift of the clock used by thermal/hw load avg has been
introduced to handle case where the signal was not always a high frequency
hw signal. Now that cpufreq provides a signal for firmware and
SW pressure, we can remove this exception and always keep this PELT signal
aligned with other signals.
Mark sysctl_sched_migration_cost boot parameter as deprecated

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20240326091616.3696851-6-vincent.guittot@linaro.org
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +-
 kernel/sched/core.c                             |  2 +-
 kernel/sched/fair.c                             | 10 +--------
 kernel/sched/sched.h                            | 18 +----------------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb884c1..3f390cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5807,6 +5807,7 @@
 			but is useful for debugging and performance tuning.
 
 	sched_thermal_decay_shift=
+			[Deprecated]
 			[KNL, SMP] Set a decay shift for scheduler thermal
 			pressure signal. Thermal pressure signal follows the
 			default decay period of other scheduler pelt
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67a8302..1a91438 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5680,7 +5680,7 @@ void sched_tick(void)
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
+	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eef39ae..9eb6357 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -78,15 +78,9 @@ static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
-int sched_hw_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
-	int _shift = 0;
-
-	if (kstrtoint(str, 0, &_shift))
-		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
-
-	sched_hw_decay_shift = clamp(_shift, 0, 10);
+	pr_warn("Ignoring the deprecated sched_thermal_decay_shift= option\n");
 	return 1;
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
@@ -9367,7 +9361,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
+		  update_hw_load_avg(now, rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 993edb0..cb3792c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1550,24 +1550,6 @@ static inline u64 rq_clock_task(struct rq *rq)
 	return rq->clock_task;
 }
 
-/**
- * By default the decay is the default pelt decay period.
- * The decay shift can change the decay period in
- * multiples of 32.
- *  Decay shift		Decay period(ms)
- *	0			32
- *	1			64
- *	2			128
- *	3			256
- *	4			512
- */
-extern int sched_hw_decay_shift;
-
-static inline u64 rq_clock_hw(struct rq *rq)
-{
-	return rq_clock_task(rq) >> sched_hw_decay_shift;
-}
-
 static inline void rq_clock_skip_update(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);

