Return-Path: <linux-kernel+bounces-156713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A74D8B0734
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9411C22842
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265215A48B;
	Wed, 24 Apr 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STyP2EvO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQhDc7WB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD3159592;
	Wed, 24 Apr 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954139; cv=none; b=FAaarJ4yj15M7Aajj+i/X6gaejLZ5xvdIYtbfYTeH3CEIzPUj8qDenwF6gILkZVYqDsdv5nwKwfVKYLrptOjTK50kiozKksANtcvlNO47dh6P156vf5TAq+gzzAkKM9oFGQtRkXvzzuwc3ke3yPbH3MbCBL6k4ftCBhn0LsgZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954139; c=relaxed/simple;
	bh=6VJ1vjKGdhsizush9OLjwo0Y5BWiOejYdAY5B9OXnwk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m0gF4dDeOq7lxiLpLDNi7+wWbMYj9rddnWWsDFskHOcvCfp2OQ2T1OSZOJVAQpXJSyxJAiFLjP6vKUi2Vwx53qw5pir5t9hhcZcdKbYp5NSaQsP1qV2CtwTUtl4Fna2JvAofiUwomCoq18p5Pfx773LVSBajVQObquQ9AVGfTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STyP2EvO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yQhDc7WB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713954135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U2acL/kmcNUvnTAJQIGt4ejC6pVIWfY1KC0IugjQkU=;
	b=STyP2EvOp5qOPh7w5mHIaQvBW3jinR2tE8Om2jJ6eLgApyInb/L8j++jMGLrmFg9f5lDTQ
	VnQZNYXzrrmbZJrzFQp/04dMPNStJLrhYfv93WKEoa9R/t2/SScKhh8PIO9eODhuuidMav
	5d16aX6AeaYLwkmZkc166b/Kd0Sj7oJ4ewfFhsCnvxpAlucAvg9qDHS52ZWLMIwyRU5Pnz
	7IJGLKs/A//eX/fjRoRX/ltLYC/8gCZ1x5+ILaiVbeBda0dgzI6I+x43yyb+evkJt6bgOx
	BxkAMS8L+rVGRZc1R7I1QeCEhYWsVZ18gxrUr996bP1sAvTvIczjSlSa6hQv+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713954135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U2acL/kmcNUvnTAJQIGt4ejC6pVIWfY1KC0IugjQkU=;
	b=yQhDc7WBU+Yv9wWyd0aCVxWvTi3fbMLBlQgzcMCnty9muPipYHpwUZtoC70sQHJgP8U4Xh
	dXBVGrTce9PEUuDA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpufreq: Rename
 arch_update_thermal_pressure() => arch_update_hw_pressure()
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Qais Yousef <qyousef@layalina.io>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240326091616.3696851-5-vincent.guittot@linaro.org>
References: <20240326091616.3696851-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395413474.10875.3875624042033796865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d4dbc991714eefcbd8d54a3204bd77a0a52bd32d
Gitweb:        https://git.kernel.org/tip/d4dbc991714eefcbd8d54a3204bd77a0a52bd32d
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 26 Mar 2024 10:16:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 12:08:01 +02:00

sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()

Now that cpufreq provides a pressure value to the scheduler, rename
arch_update_thermal_pressure into HW pressure to reflect that it returns
a pressure applied by HW (i.e. with a high frequency change) and not
always related to thermal mitigation but also generated by max current
limitation as an example. Such high frequency signal needs filtering to be
smoothed and provide an value that reflects the average available capacity
into the scheduler time scale.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20240326091616.3696851-5-vincent.guittot@linaro.org
---
 arch/arm/include/asm/topology.h         |  6 ++---
 arch/arm64/include/asm/topology.h       |  6 ++---
 drivers/base/arch_topology.c            | 26 +++++++++++-----------
 drivers/cpufreq/qcom-cpufreq-hw.c       |  4 +--
 include/linux/arch_topology.h           |  8 +++----
 include/linux/sched/topology.h          |  8 +++----
 include/trace/events/hw_pressure.h      | 29 ++++++++++++++++++++++++-
 include/trace/events/sched.h            |  2 +-
 include/trace/events/thermal_pressure.h | 29 +------------------------
 init/Kconfig                            | 12 +++++-----
 kernel/sched/core.c                     |  8 +++----
 kernel/sched/fair.c                     | 16 ++++++-------
 kernel/sched/pelt.c                     | 18 +++++++--------
 kernel/sched/pelt.h                     | 16 ++++++-------
 kernel/sched/sched.h                    | 10 ++++----
 15 files changed, 99 insertions(+), 99 deletions(-)
 create mode 100644 include/trace/events/hw_pressure.h
 delete mode 100644 include/trace/events/thermal_pressure.h

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 853c4f8..ad36b65 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -22,9 +22,9 @@
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure API */
-#define arch_scale_thermal_pressure topology_get_thermal_pressure
-#define arch_update_thermal_pressure	topology_update_thermal_pressure
+/* Replace task scheduler's default HW pressure API */
+#define arch_scale_hw_pressure topology_get_hw_pressure
+#define arch_update_hw_pressure	topology_update_hw_pressure
 
 #else
 
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a323b10..0f6ef43 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -35,9 +35,9 @@ void update_freq_counters_refs(void);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure API */
-#define arch_scale_thermal_pressure topology_get_thermal_pressure
-#define arch_update_thermal_pressure	topology_update_thermal_pressure
+/* Replace task scheduler's default HW pressure API */
+#define arch_scale_hw_pressure topology_get_hw_pressure
+#define arch_update_hw_pressure	topology_update_hw_pressure
 
 #include <asm-generic/topology.h>
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 024b78a..0248912 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -22,7 +22,7 @@
 #include <linux/units.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/thermal_pressure.h>
+#include <trace/events/hw_pressure.h>
 
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
@@ -160,26 +160,26 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
-DEFINE_PER_CPU(unsigned long, thermal_pressure);
+DEFINE_PER_CPU(unsigned long, hw_pressure);
 
 /**
- * topology_update_thermal_pressure() - Update thermal pressure for CPUs
+ * topology_update_hw_pressure() - Update HW pressure for CPUs
  * @cpus        : The related CPUs for which capacity has been reduced
  * @capped_freq : The maximum allowed frequency that CPUs can run at
  *
- * Update the value of thermal pressure for all @cpus in the mask. The
+ * Update the value of HW pressure for all @cpus in the mask. The
  * cpumask should include all (online+offline) affected CPUs, to avoid
  * operating on stale data when hot-plug is used for some CPUs. The
  * @capped_freq reflects the currently allowed max CPUs frequency due to
- * thermal capping. It might be also a boost frequency value, which is bigger
+ * HW capping. It might be also a boost frequency value, which is bigger
  * than the internal 'capacity_freq_ref' max frequency. In such case the
  * pressure value should simply be removed, since this is an indication that
- * there is no thermal throttling. The @capped_freq must be provided in kHz.
+ * there is no HW throttling. The @capped_freq must be provided in kHz.
  */
-void topology_update_thermal_pressure(const struct cpumask *cpus,
+void topology_update_hw_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
 {
-	unsigned long max_capacity, capacity, th_pressure;
+	unsigned long max_capacity, capacity, hw_pressure;
 	u32 max_freq;
 	int cpu;
 
@@ -189,21 +189,21 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	/*
 	 * Handle properly the boost frequencies, which should simply clean
-	 * the thermal pressure value.
+	 * the HW pressure value.
 	 */
 	if (max_freq <= capped_freq)
 		capacity = max_capacity;
 	else
 		capacity = mult_frac(max_capacity, capped_freq, max_freq);
 
-	th_pressure = max_capacity - capacity;
+	hw_pressure = max_capacity - capacity;
 
-	trace_thermal_pressure_update(cpu, th_pressure);
+	trace_hw_pressure_update(cpu, hw_pressure);
 
 	for_each_cpu(cpu, cpus)
-		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+		WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
 }
-EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);
+EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
 
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 70b0f21..ec8df54 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -347,8 +347,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	throttled_freq = freq_hz / HZ_PER_KHZ;
 
-	/* Update thermal pressure (the boost frequencies are accepted) */
-	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
+	/* Update HW pressure (the boost frequencies are accepted) */
+	arch_update_hw_pressure(policy->related_cpus, throttled_freq);
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a63d61c..b721f36 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -60,14 +60,14 @@ void topology_scale_freq_tick(void);
 void topology_set_scale_freq_source(struct scale_freq_data *data, const struct cpumask *cpus);
 void topology_clear_scale_freq_source(enum scale_freq_source source, const struct cpumask *cpus);
 
-DECLARE_PER_CPU(unsigned long, thermal_pressure);
+DECLARE_PER_CPU(unsigned long, hw_pressure);
 
-static inline unsigned long topology_get_thermal_pressure(int cpu)
+static inline unsigned long topology_get_hw_pressure(int cpu)
 {
-	return per_cpu(thermal_pressure, cpu);
+	return per_cpu(hw_pressure, cpu);
 }
 
-void topology_update_thermal_pressure(const struct cpumask *cpus,
+void topology_update_hw_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq);
 
 struct cpu_topology {
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c8fe9ba..4237daa 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -270,17 +270,17 @@ unsigned long arch_scale_cpu_capacity(int cpu)
 }
 #endif
 
-#ifndef arch_scale_thermal_pressure
+#ifndef arch_scale_hw_pressure
 static __always_inline
-unsigned long arch_scale_thermal_pressure(int cpu)
+unsigned long arch_scale_hw_pressure(int cpu)
 {
 	return 0;
 }
 #endif
 
-#ifndef arch_update_thermal_pressure
+#ifndef arch_update_hw_pressure
 static __always_inline
-void arch_update_thermal_pressure(const struct cpumask *cpus,
+void arch_update_hw_pressure(const struct cpumask *cpus,
 				  unsigned long capped_frequency)
 { }
 #endif
diff --git a/include/trace/events/hw_pressure.h b/include/trace/events/hw_pressure.h
new file mode 100644
index 0000000..b9cd688
--- /dev/null
+++ b/include/trace/events/hw_pressure.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hw_pressure
+
+#if !defined(_TRACE_THERMAL_PRESSURE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_THERMAL_PRESSURE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(hw_pressure_update,
+	TP_PROTO(int cpu, unsigned long hw_pressure),
+	TP_ARGS(cpu, hw_pressure),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, hw_pressure)
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->hw_pressure = hw_pressure;
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu=%d hw_pressure=%lu", __entry->cpu, __entry->hw_pressure)
+);
+#endif /* _TRACE_THERMAL_PRESSURE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4..d115d64 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -752,7 +752,7 @@ DECLARE_TRACE(pelt_dl_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
-DECLARE_TRACE(pelt_thermal_tp,
+DECLARE_TRACE(pelt_hw_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
diff --git a/include/trace/events/thermal_pressure.h b/include/trace/events/thermal_pressure.h
deleted file mode 100644
index b686802..0000000
--- a/include/trace/events/thermal_pressure.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM thermal_pressure
-
-#if !defined(_TRACE_THERMAL_PRESSURE_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_THERMAL_PRESSURE_H
-
-#include <linux/tracepoint.h>
-
-TRACE_EVENT(thermal_pressure_update,
-	TP_PROTO(int cpu, unsigned long thermal_pressure),
-	TP_ARGS(cpu, thermal_pressure),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, thermal_pressure)
-		__field(int, cpu)
-	),
-
-	TP_fast_assign(
-		__entry->thermal_pressure = thermal_pressure;
-		__entry->cpu = cpu;
-	),
-
-	TP_printk("cpu=%d thermal_pressure=%lu", __entry->cpu, __entry->thermal_pressure)
-);
-#endif /* _TRACE_THERMAL_PRESSURE_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff --git a/init/Kconfig b/init/Kconfig
index aa02aec..f0c9117 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -547,24 +547,24 @@ config HAVE_SCHED_AVG_IRQ
 	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
 	depends on SMP
 
-config SCHED_THERMAL_PRESSURE
+config SCHED_HW_PRESSURE
 	bool
 	default y if ARM && ARM_CPU_TOPOLOGY
 	default y if ARM64
 	depends on SMP
 	depends on CPU_FREQ_THERMAL
 	help
-	  Select this option to enable thermal pressure accounting in the
-	  scheduler. Thermal pressure is the value conveyed to the scheduler
+	  Select this option to enable HW pressure accounting in the
+	  scheduler. HW pressure is the value conveyed to the scheduler
 	  that reflects the reduction in CPU compute capacity resulted from
-	  thermal throttling. Thermal throttling occurs when the performance of
-	  a CPU is capped due to high operating temperatures.
+	  HW throttling. HW throttling occurs when the performance of
+	  a CPU is capped due to high operating temperatures as an example.
 
 	  If selected, the scheduler will be able to balance tasks accordingly,
 	  i.e. put less load on throttled CPUs than on non/less throttled ones.
 
 	  This requires the architecture to implement
-	  arch_update_thermal_pressure() and arch_scale_thermal_pressure().
+	  arch_update_hw_pressure() and arch_scale_thermal_pressure().
 
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0621e4e..67a8302 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -108,7 +108,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
-EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_hw_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
@@ -5668,7 +5668,7 @@ void sched_tick(void)
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
-	unsigned long thermal_pressure;
+	unsigned long hw_pressure;
 	u64 resched_latency;
 
 	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
@@ -5679,8 +5679,8 @@ void sched_tick(void)
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
-	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
-	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
+	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
+	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19199c1..eef39ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -78,7 +78,7 @@ static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
-int sched_thermal_decay_shift;
+int sched_hw_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
 	int _shift = 0;
@@ -86,7 +86,7 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 	if (kstrtoint(str, 0, &_shift))
 		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
 
-	sched_thermal_decay_shift = clamp(_shift, 0, 10);
+	sched_hw_decay_shift = clamp(_shift, 0, 10);
 	return 1;
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
@@ -4969,7 +4969,7 @@ static inline unsigned long get_actual_cpu_capacity(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
 
-	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
+	capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
 
 	return capacity;
 }
@@ -5002,7 +5002,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
 	 * should fit a little cpu even if there's some pressure.
 	 *
-	 * Only exception is for thermal pressure since it has a direct impact
+	 * Only exception is for HW or cpufreq pressure since it has a direct impact
 	 * on available OPP of the system.
 	 *
 	 * We honour it for uclamp_min only as a drop in performance level
@@ -9324,7 +9324,7 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (cpu_util_dl(rq))
 		return true;
 
-	if (thermal_load_avg(rq))
+	if (hw_load_avg(rq))
 		return true;
 
 	if (cpu_util_irq(rq))
@@ -9354,7 +9354,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 {
 	const struct sched_class *curr_class;
 	u64 now = rq_clock_pelt(rq);
-	unsigned long thermal_pressure;
+	unsigned long hw_pressure;
 	bool decayed;
 
 	/*
@@ -9363,11 +9363,11 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 */
 	curr_class = rq->curr->sched_class;
 
-	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
+	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
+		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 3a96da2..ef00382 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -384,30 +384,30 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
-#ifdef CONFIG_SCHED_THERMAL_PRESSURE
+#ifdef CONFIG_SCHED_HW_PRESSURE
 /*
- * thermal:
+ * hardware:
  *
  *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
  *
  *   util_avg and runnable_load_avg are not supported and meaningless.
  *
  * Unlike rt/dl utilization tracking that track time spent by a cpu
- * running a rt/dl task through util_avg, the average thermal pressure is
- * tracked through load_avg. This is because thermal pressure signal is
+ * running a rt/dl task through util_avg, the average HW pressure is
+ * tracked through load_avg. This is because HW pressure signal is
  * time weighted "delta" capacity unlike util_avg which is binary.
  * "delta capacity" =  actual capacity  -
- *			capped capacity a cpu due to a thermal event.
+ *			capped capacity a cpu due to a HW event.
  */
 
-int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
-	if (___update_load_sum(now, &rq->avg_thermal,
+	if (___update_load_sum(now, &rq->avg_hw,
 			       capacity,
 			       capacity,
 			       capacity)) {
-		___update_load_avg(&rq->avg_thermal, 1);
-		trace_pelt_thermal_tp(rq);
+		___update_load_avg(&rq->avg_hw, 1);
+		trace_pelt_hw_tp(rq);
 		return 1;
 	}
 
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 9e10834..2150062 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -7,21 +7,21 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
-#ifdef CONFIG_SCHED_THERMAL_PRESSURE
-int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
+#ifdef CONFIG_SCHED_HW_PRESSURE
+int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
 
-static inline u64 thermal_load_avg(struct rq *rq)
+static inline u64 hw_load_avg(struct rq *rq)
 {
-	return READ_ONCE(rq->avg_thermal.load_avg);
+	return READ_ONCE(rq->avg_hw.load_avg);
 }
 #else
 static inline int
-update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
 	return 0;
 }
 
-static inline u64 thermal_load_avg(struct rq *rq)
+static inline u64 hw_load_avg(struct rq *rq)
 {
 	return 0;
 }
@@ -202,12 +202,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
-update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
 	return 0;
 }
 
-static inline u64 thermal_load_avg(struct rq *rq)
+static inline u64 hw_load_avg(struct rq *rq)
 {
 	return 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7c39dbf..993edb0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1108,8 +1108,8 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
-#ifdef CONFIG_SCHED_THERMAL_PRESSURE
-	struct sched_avg	avg_thermal;
+#ifdef CONFIG_SCHED_HW_PRESSURE
+	struct sched_avg	avg_hw;
 #endif
 	u64			idle_stamp;
 	u64			avg_idle;
@@ -1561,11 +1561,11 @@ static inline u64 rq_clock_task(struct rq *rq)
  *	3			256
  *	4			512
  */
-extern int sched_thermal_decay_shift;
+extern int sched_hw_decay_shift;
 
-static inline u64 rq_clock_thermal(struct rq *rq)
+static inline u64 rq_clock_hw(struct rq *rq)
 {
-	return rq_clock_task(rq) >> sched_thermal_decay_shift;
+	return rq_clock_task(rq) >> sched_hw_decay_shift;
 }
 
 static inline void rq_clock_skip_update(struct rq *rq)

