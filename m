Return-Path: <linux-kernel+bounces-19648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD1F82704B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AB41C22682
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6146B85;
	Mon,  8 Jan 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chVFedUY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812E46544
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso21427075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704721736; x=1705326536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6tS/zmA8jTmUGQmD7ZGbI7KJfpIZIi+8GuPTUd/kRc=;
        b=chVFedUYM36NKkGOYXAqT/Lo0iBTj1e+0nxYmADVdc4KsN5scXoT0CuAvi6rAnMiGO
         HLCZE58JC3b1z466Y5LJVfzwHlLnyrzqHmj6XHxgSmbfGZk2oyaROYDB5P00e2UkVsRF
         xdVh6hYmm09TILJy1DjghxcxUH5w1tiqr2ab9x92uXoSbqmX5r92texj6dk4JvjFBKGx
         3Qw8E2vXOxvt7vPwjOXy4v3pgVJGlBWQzjZm+e5uul1p6roosO8FQ7mMhPCazTHoc62D
         hNgjf8NXSooYAl4OEMOaqW+5hkfe8x1hzG5gh5Fi0BI/7egl7tUBsKc0DNPlXvWJaWXC
         73og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721736; x=1705326536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6tS/zmA8jTmUGQmD7ZGbI7KJfpIZIi+8GuPTUd/kRc=;
        b=bH0oVgnAMhxNCNKpGHqBeYuxMDloKCVOShSfpzPmcEUi8oUrvgodOk9vF6gwr4i94T
         g7lx4ttKA5oCtTFDR5dUIxft1J1Vf8JgwsP3PoFjD+cPv5iBUec4Y6Pi9hEtYiIEqd08
         YyIkU5ti0OI4KnniRPmFK07BZs36vF0oYZ6RGdgfuAGuzor8y28XwdzkfzwYk3bLLiKg
         RtrOwnOhZzd1Pb5RscJvxlHnVIZfqYU2egYj4IAFeQa+b4AreLfktkCgEIbpLdCkafzj
         ysLumnPkYdyXe06CIwa4rAocRwFnHE0IxX/TWcuMmAjb4A7mRmBHYaYpcw2V6vdqjTfB
         sicw==
X-Gm-Message-State: AOJu0YymxK9ZRQCJqvUPaiLcAn7q7RfTeMoSuC39ieCutgM+zU8v9qHE
	XYpSaJFozzrVSfEsmp3zZr61oAHYa9onPw==
X-Google-Smtp-Source: AGHT+IExBXWbVBsi6lW0nbPs92Y11blHgXhSiv0yCc/BePGdHEv57ZAi/RZ/fcIrf0iFuASaoWVAHA==
X-Received: by 2002:a05:600c:5403:b0:40e:4b6d:c9fa with SMTP id he3-20020a05600c540300b0040e4b6dc9famr30807wmb.147.1704721736518;
        Mon, 08 Jan 2024 05:48:56 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:53aa:59bc:34ea:bb2c])
        by smtp.gmail.com with ESMTPSA id n34-20020a05600c3ba200b0040d5b984668sm11165003wms.9.2024.01.08.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:48:55 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: qyousef@layalina.io,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 5/5] sched/pelt: Remove shift of thermal clock
Date: Mon,  8 Jan 2024 14:48:43 +0100
Message-Id: <20240108134843.429769-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108134843.429769-1-vincent.guittot@linaro.org>
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The optional shift of the clock used by thermal/hw load avg has been
introduced to handle case where the signal was not always a high frequency
hw signal. Now that cpufreq provides a signal for firmware and
SW pressure, we can remove this exception and always keep this PELT signal
aligned with other signals.
Mark deprecated sched_thermal_decay_shift boot parameter.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 .../admin-guide/kernel-parameters.txt          |  1 +
 kernel/sched/core.c                            |  2 +-
 kernel/sched/fair.c                            | 10 ++--------
 kernel/sched/sched.h                           | 18 ------------------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..2ee15522b15d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5722,6 +5722,7 @@
 			but is useful for debugging and performance tuning.
 
 	sched_thermal_decay_shift=
+			[Deprecated]
 			[KNL, SMP] Set a decay shift for scheduler thermal
 			pressure signal. Thermal pressure signal follows the
 			default decay period of other scheduler pelt
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a6f084bdf1c5..c68e47bfd5ae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5670,7 +5670,7 @@ void scheduler_tick(void)
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
+	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f1c3d600d6d6..d5ba6cdb141c 100644
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
@@ -9247,7 +9241,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
+		  update_hw_load_avg(now, rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 677d24202eec..6fc6718a1060 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1520,24 +1520,6 @@ static inline u64 rq_clock_task(struct rq *rq)
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
-- 
2.34.1


