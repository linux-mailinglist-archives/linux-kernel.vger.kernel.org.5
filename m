Return-Path: <linux-kernel+bounces-8648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA381BA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971CC1C25DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563A53A0D;
	Thu, 21 Dec 2023 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM+H0TUe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98B53A03
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so10173095e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172254; x=1703777054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zohfXtGM2GCrz2nZyChH1tghSTpVPce2CN7RQuQ1TjI=;
        b=xM+H0TUeIH3fH92MyfVz5ts+f7ofnMDFAgZT1lH38ca7/h1zAywoJvuNIDpzb5l/Fm
         hWK1/wTupHrmnWaykWkwkuDWztU7DtJw/moa5IXbOrRtAsrud7F3XJTTcr2EogbDLgLg
         kW3DmshBQqWAQxUtxTy3sxW478Y4Fq0/GS/B93oQLd45AvXi4CQC/plvnlT1Ru5IJ/Zf
         Svs4OfZ++rhHhPUpymFV0SE7u4Ot6tlzHxxGfLEO9d1Q2YiUD9WSOciy2ZMZNc6F4ayz
         0mO1Uv62Sl8mFv+ZUN1LwbLELVraAJX7XSjwRztRPZlX7lqla8ly3KKZAftG1rcrZgfh
         CCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172254; x=1703777054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zohfXtGM2GCrz2nZyChH1tghSTpVPce2CN7RQuQ1TjI=;
        b=J55TF/nJzuZmQlioc9S09swKlKYjRViRUU4+qDVQxFcW9oAC8TzafaMAO61a8qKQcq
         +TNd5/I34z6y75990KqWO7iNCp9tH7wLhqvt/ZJYYRoBT2xv713VGaSPkDGSVV7+Vo+Y
         PstNvyeEfc97cRrcZz7U3A//v54Z+QMFve49cWmOROEgo/8/V5FI/ajAyncdL939Xo9i
         8ILPhO71HOXse+vQtqYrcnBkUqoR8/UCBtSHJus0hyq7LY5vdLbnO1HpYpVBM0rch+qV
         7Prjy0vWigIxErklB8figAPI6k/ISNCfE9ac9YnIIzqL8w6fR0+PX/m6ImGty7OMRltH
         Notg==
X-Gm-Message-State: AOJu0YzkzcRWaWJxRc61DC7mR7DzB5YAWWfhquFHnmMvcFrKDLdINVhk
	k93xWlHz7sivkC8wCfEWPrGe4g==
X-Google-Smtp-Source: AGHT+IGtJfW7BlyAUKqwR1FNvygLVOGbcBkSWigaj2LfFH2vhX9i97acD457XBguD/r7aqGMCj1bqw==
X-Received: by 2002:a05:600c:21c3:b0:40d:2377:306d with SMTP id x3-20020a05600c21c300b0040d2377306dmr696756wmj.87.1703172254005;
        Thu, 21 Dec 2023 07:24:14 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:2db4:9d2a:db65:42d6])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm11466974wmo.19.2023.12.21.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:24:13 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: catalin.marinas@arm.com,
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
	linux@armlinux.org.uk,
	corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/5] sched: Take cpufreq feedback into account
Date: Thu, 21 Dec 2023 16:24:04 +0100
Message-Id: <20231221152407.436177-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221152407.436177-1-vincent.guittot@linaro.org>
References: <20231221152407.436177-1-vincent.guittot@linaro.org>
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
---
 kernel/sched/fair.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..0235081defa5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4932,13 +4932,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
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
@@ -4970,7 +4979,6 @@ static inline int util_fits_cpu(unsigned long util,
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
 	capacity_orig = arch_scale_cpu_capacity(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -5045,7 +5053,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+	if (fits && (util < uclamp_min) &&
+	    (uclamp_min > get_actual_cpu_capacity(cpu)))
 		return -1;
 
 	return fits;
@@ -7426,7 +7435,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = get_actual_cpu_capacity(cpu);
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7919,8 +7928,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -7950,7 +7959,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_thermal_cap, util;
+		unsigned long cpu_cap, cpu_actual_cap, util;
 		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
 		unsigned long cur_delta, base_energy;
@@ -7962,18 +7971,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -8044,7 +8052,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
-			prev_thermal_cap = cpu_thermal_cap;
+			prev_actual_cap = cpu_actual_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -8059,7 +8067,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * but best energy cpu has better capacity.
 			 */
 			if ((max_fits < 0) &&
-			    (cpu_thermal_cap <= best_thermal_cap))
+			    (cpu_actual_cap <= best_actual_cap))
 				continue;
 
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
@@ -8080,14 +8088,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -9465,8 +9473,8 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 
 static unsigned long scale_rt_capacity(int cpu)
 {
+	unsigned long max = get_actual_cpu_capacity(cpu);
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -9478,12 +9486,9 @@ static unsigned long scale_rt_capacity(int cpu)
 	/*
 	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
 	 * (running and not running) with weights 0 and 1024 respectively.
-	 * avg_thermal.load_avg tracks thermal pressure and the weighted
-	 * average uses the actual delta max capacity(load).
 	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
-	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.34.1


