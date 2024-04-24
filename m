Return-Path: <linux-kernel+bounces-156716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141E8B0737
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E41C22B30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BCF15AAA2;
	Wed, 24 Apr 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nThRARga";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DiEjOGLy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82549159903;
	Wed, 24 Apr 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954141; cv=none; b=EHKAQ2SrKMdLj3Tduhc97QExmQUeBVHYYWu9ziBzETm2X/JtEZ23N9xWZpQbsZ6PkRb5FKbigbbVH5SoHuuS+d/0bYj1qw9RHGh5iQDP5QMU+Ghh3qVAtdhp6vZL3c02jpq9r77LJy5kHacqbI6nSsdQPww3Tt9C8YNsNKNl5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954141; c=relaxed/simple;
	bh=LTbRLQJrmrg/VYRMQit3Gmoxkl4zbxM8PMfj+jJFtBg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ssHxxZlFDIRlC+gouexMEg905pFbm27nLwLzRnHDMIZZ1VD+LNc7H20I90WomEOPlgIjRa4T0DtD2j0qr3I/AGAq/nziobwkCdr8B8q3vVdKZCdntSaF/l/w+mHm0ZYLlhPI8q3m5g32GXtOu6TKUag6KrxS/vJwB4RQ78mS/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nThRARga; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DiEjOGLy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713954137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFpK41iGIAVS86XBPEWleQ0pbZGeQaSjyN22l3N+Whg=;
	b=nThRARgaWCdi+7FEMLoPPMnAbip9Nn27x6vyLUyYNSLZ2IDSHF+4GekNVWextAS1O4U9OE
	GO1+v+WXcbh+t8AFBN/qnMk/uymQMSDynG6wTw0a0eKw5WlLVYglAYvEIATcPYFbGCpSeE
	VsX3i8LU4iMdoP0Bbls5ra+4u+j5uLdeQWb8sS/CcIA4ECCHLr7Ec224va8R1GC3Q+M4T/
	UzPr+qZ3GQwffGVsrkTWTLPUcRa9i/4+IoP/HbwF61e+V+DBq89POSp3P3mqYjgImLGIoe
	v3ftZlz/v0ZgKNzd4Q/bQ40m6ow+AsNatjA44IdLEVhxlXEbXKPKkuKNEUwM3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713954137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFpK41iGIAVS86XBPEWleQ0pbZGeQaSjyN22l3N+Whg=;
	b=DiEjOGLyZlkTpIBildCeIhsJVyqtShN/L3jwPK0SFAdkpkdPXHFXvw2b2bqK872gcbQAPp
	LsG+tRMBo6GjbdBA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] cpufreq: Add a cpufreq pressure feedback for the scheduler
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Qais Yousef <qyousef@layalina.io>, Dhruva Gole <d-gole@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240326091616.3696851-2-vincent.guittot@linaro.org>
References: <20240326091616.3696851-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395413709.10875.4213982177945211306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     75d659317bb136d849a10a30ffe7e0462c982d29
Gitweb:        https://git.kernel.org/tip/75d659317bb136d849a10a30ffe7e0462c982d29
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 26 Mar 2024 10:16:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 12:07:58 +02:00

cpufreq: Add a cpufreq pressure feedback for the scheduler

Provide to the scheduler a feedback about the temporary max available
capacity. Unlike arch_update_thermal_pressure(), this doesn't need to be
filtered as the pressure will happen for dozens of ms or more.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20240326091616.3696851-2-vincent.guittot@linaro.org
---
 drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66e10a1..1de8bd1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2582,6 +2582,40 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_get_policy);
 
+DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
+
+/**
+ * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
+ * @policy: cpufreq policy of the CPUs.
+ *
+ * Update the value of cpufreq pressure for all @cpus in the policy.
+ */
+static void cpufreq_update_pressure(struct cpufreq_policy *policy)
+{
+	unsigned long max_capacity, capped_freq, pressure;
+	u32 max_freq;
+	int cpu;
+
+	cpu = cpumask_first(policy->related_cpus);
+	max_freq = arch_scale_freq_ref(cpu);
+	capped_freq = policy->max;
+
+	/*
+	 * Handle properly the boost frequencies, which should simply clean
+	 * the cpufreq pressure value.
+	 */
+	if (max_freq <= capped_freq) {
+		pressure = 0;
+	} else {
+		max_capacity = arch_scale_cpu_capacity(cpu);
+		pressure = max_capacity -
+			   mult_frac(max_capacity, capped_freq, max_freq);
+	}
+
+	for_each_cpu(cpu, policy->related_cpus)
+		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
+}
+
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
  * @policy: Policy object to modify.
@@ -2637,6 +2671,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
 	trace_cpu_frequency_limits(policy);
 
+	cpufreq_update_pressure(policy);
+
 	policy->cached_target_freq = UINT_MAX;
 
 	pr_debug("new min and max freqs are %u - %u kHz\n",
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9956afb..20f7e98 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
 bool has_target_index(void);
+
+DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
+static inline unsigned long cpufreq_get_pressure(int cpu)
+{
+	return READ_ONCE(per_cpu(cpufreq_pressure, cpu));
+}
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
@@ -264,6 +270,10 @@ static inline bool cpufreq_supports_freq_invariance(void)
 }
 static inline void disable_cpufreq(void) { }
 static inline void cpufreq_update_limits(unsigned int cpu) { }
+static inline unsigned long cpufreq_get_pressure(int cpu)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT

