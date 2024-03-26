Return-Path: <linux-kernel+bounces-118627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40C88BD79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF5FB24737
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12B5DF23;
	Tue, 26 Mar 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlympjaX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896D4CE18
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444587; cv=none; b=hW0ye34IL7/4Js86P50u9hbjy5w6Sc23L4o9nhyfCxtGRvJ4xq3Y78EgywH8Gj0sDQ+Va5ZmihojFxxvb4Rs0/C0B0ds56JVrfg5GFUpt1ZsenK/LHp6Pjr9k968etgd4lZXfAYUizEl2gumu4ddQw/B4tUTlxqayJkmFLAahr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444587; c=relaxed/simple;
	bh=t5v8MWAUzWaVaJT+ONkt4NRaxll8gNx1zjOwebZP79s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8g2jUY1UXUOTLMCKba98PZ5Kmiv9LvcQL4TdJFgnSCIbtH+K+xJ2wbiULlQMFkZS8y38ybg+4+0dVbzlXqXXiAq6H05pGKkD3mtCJJxjLCAo0XWwSHYV7Ws5lSL2s/b9kCWM5zo3kGRjarKb42NEmIT0VU3UIoLVOakD51pNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlympjaX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4148fc54407so1450595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711444584; x=1712049384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6ml8fn9F+EEQM7pXzSWzzTXbuP8O0u3z4frW2KnSG0=;
        b=rlympjaXuWOdo9d77fqc/+SrIfvo+V3fifS5rfoDXDmTEBs2tY+yg/hlRQcbzjaop4
         DnkzFuF9txAk16cEF2y5ofl5dOOkjCcEO3md43Mwwaz69Rh7HGiWGKFRS4oIHBk6dLUg
         jKNzqX2UcZVME37ZTXQ7xBCTiHuIDm1wiwz9oMbT8rprTdGUw8Y72VbIgQc0s5oBdfoI
         B7n9+sOG2PDkbGXx6Hy6ElhpFkIkmxzbM60Ykjtj08isoGu/iQRZH2qEv8xT+du5U2Ky
         7Q9WXzYacQuJ4X6yaHDTxx15c3L6DudmSlBDoffxrWLRQwKvNNXa53lJ8UkKjKiVHcQi
         266g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444584; x=1712049384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6ml8fn9F+EEQM7pXzSWzzTXbuP8O0u3z4frW2KnSG0=;
        b=BijwZ3ctX3MTrZSxlVXN6KzhVN07/c3hTgkxCbRIQ3hIV5LtEa0rcPHzXffCuSBXrF
         p3GJP4Xfb8AZHw0ZR3ZrVHUEnZQIYKajFguTseHbyOK7jWu+sWyrnq5oqNHGbKgtc6Mw
         o8IGNsaklI/0qVARhsJ9J5zB1y3pWGcEhpn37fbLdOA7iQp6rCERULn0QInrHcMfWfVj
         +5MYipRblJtwuNsmkOfuN91Bxu05+FifDda9+r+m39cy1bIANwkHYwmzW+utgOcDWuqX
         xQlN1wEHFscICU2l4xocJCARwZyZ0Bu0DBtJ29QHUn93UbCc5Uz7PCrcSVzYi0JqBbNN
         NcWA==
X-Forwarded-Encrypted: i=1; AJvYcCWzgtJX5u6TZ+OUZRk0d0BZwPPsCoZaYIxUyIW0NexFK0j0laExxWzsYldOeD3Fyt2UsWcGdtqhZed9q+i/lNd63GBlaGF5yyZSaP8w
X-Gm-Message-State: AOJu0YyGaeJIXtn/Ly/65sgzt6cY6G2mL8KM+GnGfNkWliI8OJvgYD+G
	LvhZKH7tChO84jxctkzTs2D4tfHedwhSm25FVCaJLCJMMHi0Slqt5g7QnCHYMdw=
X-Google-Smtp-Source: AGHT+IGlGB/S/ILqy/TCYUtgMsbst01QB4nU344/2vkgCOqyTZeZ4erNdJX6EzhQi/eTFgtypr4glw==
X-Received: by 2002:a05:600c:3b11:b0:414:5e92:cbd8 with SMTP id m17-20020a05600c3b1100b004145e92cbd8mr7164439wms.1.1711444583732;
        Tue, 26 Mar 2024 02:16:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e6b6:c92e:43ff:71d7])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b0033e5c54d0d9sm11647606wrs.38.2024.03.26.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:16:22 -0700 (PDT)
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 2/5] sched: Take cpufreq feedback into account
Date: Tue, 26 Mar 2024 10:16:13 +0100
Message-Id: <20240326091616.3696851-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326091616.3696851-1-vincent.guittot@linaro.org>
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aggregate the different pressures applied on the capacity of CPUs and
create a new function that returns the actual capacity of the CPU:
  get_actual_cpu_capacity()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24a7530a7d3f..1896a3138df3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4965,13 +4965,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static inline unsigned long get_actual_cpu_capacity(int cpu)
+{
+	unsigned long capacity = arch_scale_cpu_capacity(cpu);
+
+	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
+
+	return capacity;
+}
+
 static inline int util_fits_cpu(unsigned long util,
 				unsigned long uclamp_min,
 				unsigned long uclamp_max,
 				int cpu)
 {
-	unsigned long capacity_orig, capacity_orig_thermal;
 	unsigned long capacity = capacity_of(cpu);
+	unsigned long capacity_orig;
 	bool fits, uclamp_max_fits;
 
 	/*
@@ -5003,7 +5012,6 @@ static inline int util_fits_cpu(unsigned long util,
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
 	capacity_orig = arch_scale_cpu_capacity(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -5078,7 +5086,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+	if (fits && (util < uclamp_min) &&
+	    (uclamp_min > get_actual_cpu_capacity(cpu)))
 		return -1;
 
 	return fits;
@@ -7498,7 +7507,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = get_actual_cpu_capacity(cpu);
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7991,8 +8000,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
 	int prev_fits = -1, best_fits = -1;
-	unsigned long best_thermal_cap = 0;
-	unsigned long prev_thermal_cap = 0;
+	unsigned long best_actual_cap = 0;
+	unsigned long prev_actual_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -8022,7 +8031,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_thermal_cap, util;
+		unsigned long cpu_cap, cpu_actual_cap, util;
 		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
 		unsigned long cur_delta, base_energy;
@@ -8034,18 +8043,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (cpumask_empty(cpus))
 			continue;
 
-		/* Account thermal pressure for the energy estimation */
+		/* Account external pressure for the energy estimation */
 		cpu = cpumask_first(cpus);
-		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
-		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
+		cpu_actual_cap = get_actual_cpu_capacity(cpu);
 
-		eenv.cpu_cap = cpu_thermal_cap;
+		eenv.cpu_cap = cpu_actual_cap;
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
 			struct rq *rq = cpu_rq(cpu);
 
-			eenv.pd_cap += cpu_thermal_cap;
+			eenv.pd_cap += cpu_actual_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 				continue;
@@ -8116,7 +8124,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
-			prev_thermal_cap = cpu_thermal_cap;
+			prev_actual_cap = cpu_actual_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -8131,7 +8139,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * but best energy cpu has better capacity.
 			 */
 			if ((max_fits < 0) &&
-			    (cpu_thermal_cap <= best_thermal_cap))
+			    (cpu_actual_cap <= best_actual_cap))
 				continue;
 
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
@@ -8152,14 +8160,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			best_delta = cur_delta;
 			best_energy_cpu = max_spare_cap_cpu;
 			best_fits = max_fits;
-			best_thermal_cap = cpu_thermal_cap;
+			best_actual_cap = cpu_actual_cap;
 		}
 	}
 	rcu_read_unlock();
 
 	if ((best_fits > prev_fits) ||
 	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
+	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
 		target = best_energy_cpu;
 
 	return target;
@@ -9564,8 +9572,8 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 
 static unsigned long scale_rt_capacity(int cpu)
 {
+	unsigned long max = get_actual_cpu_capacity(cpu);
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -9577,12 +9585,9 @@ static unsigned long scale_rt_capacity(int cpu)
 	/*
 	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
 	 * (running and not running) with weights 0 and 1024 respectively.
-	 * avg_thermal.load_avg tracks thermal pressure and the weighted
-	 * average uses the actual delta max capacity(load).
 	 */
 	used = cpu_util_rt(rq);
 	used += cpu_util_dl(rq);
-	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.34.1


