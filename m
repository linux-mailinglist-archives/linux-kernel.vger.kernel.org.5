Return-Path: <linux-kernel+bounces-159058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E68B28C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772761C216D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6915252C;
	Thu, 25 Apr 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="I1bO8uuX"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AF1514C0;
	Thu, 25 Apr 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071984; cv=none; b=RHcYW/nQi4s/k8LWBZVd1oidVyDW9w7IOwK22b3H9q9FNHNQwANnLt0Au1Jl/5UGpED1vL/FPuYRAfV1a6ly8C4j7GNGJZlo+iMYP+2VGSKznsJI+EFDWl2C6/PzoF46s11yGJ9noPHoAfF+nkQ6F8EEEY8eoO3OY1woN3DXnPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071984; c=relaxed/simple;
	bh=2jAkH/4slcBB0FrrUcxT2gp0uWceY5jr+Vu7+y8rmkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WekgrlaplxjOMmOkvnW510TP2k+AaCu/Oc53hFuX/yXz1bLyHP7Lkn6FqAWd7h+U89i+6HhCnIYJLy1F7yitFCkvLSovcAVyigNhANqXxn1eHP5QXNjcYB8BgmMuZDYhCJsVe9PDiMO70njXB5olp9pnMmdlMeQYLvV7rG+MwYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=I1bO8uuX reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id a7f5f0d9fbc4a1c5; Thu, 25 Apr 2024 21:06:18 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5B4ED66DF24;
	Thu, 25 Apr 2024 21:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714071978;
	bh=2jAkH/4slcBB0FrrUcxT2gp0uWceY5jr+Vu7+y8rmkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1bO8uuXiSjcOOp5xEk/RvQrvkrqkEBIjWiqgaJ7THnvTateNEMm/jWsCd8n/hz2i
	 rXbNg75vWsuSW/HFKOrCHMQAEwNuEnsK/p4ChQvqwcKwSHr8VA8TzAu1rEQGvmzFb+
	 Y0GqAgrACOOn0XPM95wZVX9IjumBECwFrzcAky4u7TW1h+s9LMHvDGIwfveYNazbhu
	 GiNHETSsZg3UhikUg/HLjoMq9uOREFGgra0NxLPx3+gbnk4aBQtxbheaEF6Ai9mn6b
	 SLBD3gzO0cHYvLWroTpZM+4q2BfDygIv8p3pT7F0D6uB8OOQ2t7wVP7VzuT6DKajFK
	 xo6fxI+ZfSnCA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 [RFC][PATCH v1 3/3] cpufreq: intel_pstate: Set asymmetric CPU capacity on
 hybrid systems
Date: Thu, 25 Apr 2024 21:06:08 +0200
Message-ID: <1799046.VLH7GnMWUR@kreacher>
In-Reply-To: <7663799.EvYhyI6sBW@kreacher>
References: <7663799.EvYhyI6sBW@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrggu
 vggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make intel_pstate use the HWP_HIGHEST_PERF values from
MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
via the previously introduced arch_set_cpu_capacity() on hybrid
systems without SMT.

Setting asymmetric CPU capacity is generally necessary to allow the
scheduler to compute task sizes in a consistent way across all CPUs
in a system where they differ by capacity.  That, in turn, should help
to improve task placement and load balancing decisions.  It is also
necessary for the schedutil cpufreq governor to operate as expected
on hybrid systems where tasks migrate between CPUs of different
capacities.

The underlying observation is that intel_pstate already uses
MSR_HWP_CAPABILITIES to get CPU performance information which is
exposed by it via sysfs and CPU performance scaling is based on it.
Thus using this information for setting asymmetric CPU capacity is
consistent with what the driver has been doing already.  Moreover,
HWP_HIGHEST_PERF reflects the maximum capacity of a given CPU including
both the instructions-per-cycle (IPC) factor and the maximum turbo
frequency and the units in which that value is expressed are the same
for all CPUs in the system, so the maximum capacity ratio between two
CPUs can be obtained by computing the ratio of their HWP_HIGHEST_PERF
values.  Of course, in principle that capacity ratio need not be
directly applicable at lower frequencies, so using it for providing the
asymmetric CPU capacity information to the scheduler is a rough
approximation, but it is as good as it gets.  Also, measurements
indicate that this approximation is not too bad in practice.

If the given system is hybrid and non-SMT, the new code disables ITMT
support in the scheduler (because it may get in the way of asymmetric CPU
capacity code in the scheduler that automatically gets enabled by setting
asymmetric CPU capacity) after initializing all online CPUs and finds
the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
capacity number for each (online) CPU by dividing the product of its
HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PERF.

When a CPU goes offline, its capacity is reset to SCHED_CAPACITY_SCALE
and if it is the one with the maximum HWP_HIGHEST_PERF value, the
capacity numbers for all of the other online CPUs are recomputed.  This
also takes care of a cleanup during driver operation mode changes.

Analogously, when a new CPU goes online, its capacity number is updated
and if its HWP_HIGHEST_PERF value is greater than the current maximum
one, the capacity numbers for all of the other online CPUs are
recomputed.

The case when the driver is notified of a CPU capacity change, either
through the HWP interrupt or through an ACPI notification, is handled
similarly to the CPU online case above, except that if the target CPU
is the current highest-capacity one and its capacity is reduced, the
capacity numbers for all of the other online CPUs need to be recomputed
either.

If the driver's "no_trubo" sysfs attribute is updated, all of the CPU
capacity information is computed from scratch to reflect the new turbo
status.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  187 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -16,6 +16,7 @@
 #include <linux/tick.h>
 #include <linux/slab.h>
 #include <linux/sched/cpufreq.h>
+#include <linux/sched/smt.h>
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
@@ -215,6 +216,7 @@ struct global_params {
  * @hwp_req_cached:	Cached value of the last HWP Request MSR
  * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
  * @last_io_update:	Last time when IO wake flag was set
+ * @capacity_perf:	Perf from HWP_CAP used for capacity computations
  * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
  * @suspended:		Whether or not the driver has been suspended.
@@ -253,6 +255,7 @@ struct cpudata {
 	u64 hwp_req_cached;
 	u64 hwp_cap_cached;
 	u64 last_io_update;
+	unsigned int capacity_perf;
 	unsigned int sched_flags;
 	u32 hwp_boost_min;
 	bool suspended;
@@ -295,6 +298,7 @@ static int hwp_mode_bdw __ro_after_init;
 static bool per_cpu_limits __ro_after_init;
 static bool hwp_forced __ro_after_init;
 static bool hwp_boost __read_mostly;
+static bool hwp_is_hybrid;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
@@ -934,6 +938,93 @@ static struct freq_attr *hwp_cpufreq_att
 	NULL,
 };
 
+static struct cpudata *hybrid_max_perf_cpu __read_mostly;
+/*
+ * This protects hybrid_max_perf_cpu, the @capacity_perf fields in struct
+ * cpudata, and the x86 arch capacity information from concurrent updates.
+ */
+static DEFINE_MUTEX(hybrid_capacity_lock);
+
+static unsigned int hybrid_get_cap_perf(struct cpudata *cpu)
+{
+	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
+
+	if (READ_ONCE(global.no_turbo))
+		return HWP_GUARANTEED_PERF(hwp_cap);
+
+	return HWP_HIGHEST_PERF(hwp_cap);
+}
+
+static void hybrid_set_cpu_capacity(struct cpudata *cpu)
+{
+	u64 cap = div_u64((u64)SCHED_CAPACITY_SCALE * cpu->capacity_perf,
+			  hybrid_max_perf_cpu->capacity_perf);
+
+	arch_set_cpu_capacity(cpu->cpu, cap);
+}
+
+static void hybrid_set_capacity_of_cpus(void)
+{
+	int cpunum;
+
+	for_each_online_cpu(cpunum) {
+		struct cpudata *cpu = all_cpu_data[cpunum];
+
+		/*
+		 * Skip hybrid_max_perf_cpu because its capacity is the
+		 * maximum and need not be computed.
+		 */
+		if (cpu && cpu != hybrid_max_perf_cpu)
+			hybrid_set_cpu_capacity(cpu);
+	}
+}
+
+static void hybrid_update_cpu_scaling(void)
+{
+	struct cpudata *max_perf_cpu = NULL;
+	unsigned int max_cap_perf = 0;
+	int cpunum;
+
+	for_each_online_cpu(cpunum) {
+		struct cpudata *cpu = all_cpu_data[cpunum];
+		unsigned int cap_perf;
+
+		/*
+		 * If hybrid_max_perf_cpu is not NULL at this point, it is
+		 * being replaced, so skip it.
+		 */
+		if (!cpu || cpu == hybrid_max_perf_cpu)
+			continue;
+
+		cap_perf = hybrid_get_cap_perf(cpu);
+		cpu->capacity_perf = cap_perf;
+		if (cap_perf > max_cap_perf) {
+			max_cap_perf = cap_perf;
+			max_perf_cpu = cpu;
+		}
+	}
+
+	if (max_perf_cpu) {
+		arch_set_cpu_capacity(max_perf_cpu->cpu, SCHED_CAPACITY_SCALE);
+		hybrid_max_perf_cpu = max_perf_cpu;
+		hybrid_set_capacity_of_cpus();
+	} else {
+		/* Revert to the flat CPU capacity structure. */
+		for_each_online_cpu(cpunum)
+			arch_set_cpu_capacity(cpunum, SCHED_CAPACITY_SCALE);
+	}
+}
+
+static void hybrid_init_cpu_scaling(void)
+{
+	mutex_lock(&hybrid_capacity_lock);
+
+	hybrid_max_perf_cpu = NULL;
+	hybrid_update_cpu_scaling();
+
+	mutex_unlock(&hybrid_capacity_lock);
+}
+
 static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
@@ -962,6 +1053,40 @@ static void intel_pstate_get_hwp_cap(str
 	}
 }
 
+static void hybrid_update_capacity(struct cpudata *cpu)
+{
+	unsigned int max_cap_perf, cap_perf;
+
+	mutex_lock(&hybrid_capacity_lock);
+
+	if (!hybrid_max_perf_cpu)
+		goto unlock;
+
+	max_cap_perf = hybrid_max_perf_cpu->capacity_perf;
+
+	intel_pstate_get_hwp_cap(cpu);
+
+	cap_perf = hybrid_get_cap_perf(cpu);
+	cpu->capacity_perf = cap_perf;
+
+	if (cap_perf > max_cap_perf) {
+		arch_set_cpu_capacity(cpu->cpu, SCHED_CAPACITY_SCALE);
+		hybrid_max_perf_cpu = cpu;
+		hybrid_set_capacity_of_cpus();
+		goto unlock;
+	}
+
+	if (cpu == hybrid_max_perf_cpu && cap_perf < max_cap_perf) {
+		hybrid_update_cpu_scaling();
+		goto unlock;
+	}
+
+	hybrid_set_cpu_capacity(cpu);
+
+unlock:
+	mutex_unlock(&hybrid_capacity_lock);
+}
+
 static void intel_pstate_hwp_set(unsigned int cpu)
 {
 	struct cpudata *cpu_data = all_cpu_data[cpu];
@@ -1070,6 +1195,16 @@ static void intel_pstate_hwp_offline(str
 		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
 
 	wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+
+	mutex_lock(&hybrid_capacity_lock);
+
+	if (hybrid_max_perf_cpu == cpu)
+		hybrid_update_cpu_scaling();
+
+	mutex_unlock(&hybrid_capacity_lock);
+
+	/* Reset the capacity of the CPU going offline to the initial value. */
+	arch_set_cpu_capacity(cpu->cpu, SCHED_CAPACITY_SCALE);
 }
 
 #define POWER_CTL_EE_ENABLE	1
@@ -1164,21 +1299,41 @@ static void __intel_pstate_update_max_fr
 static void intel_pstate_update_limits(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
+	struct cpudata *cpudata;
 
 	if (!policy)
 		return;
 
-	__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
+	cpudata = all_cpu_data[cpu];
+
+	__intel_pstate_update_max_freq(cpudata, policy);
+
+	/* Prevent the driver from being unregistered now. */
+	mutex_lock(&intel_pstate_driver_lock);
 
 	cpufreq_cpu_release(policy);
+
+	hybrid_update_capacity(cpudata);
+
+	mutex_unlock(&intel_pstate_driver_lock);
 }
 
 static void intel_pstate_update_limits_for_all(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
-		intel_pstate_update_limits(cpu);
+	for_each_possible_cpu(cpu) {
+		struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
+
+		if (!policy)
+			continue;
+
+		__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
+
+		cpufreq_cpu_release(policy);
+	}
+
+	hybrid_init_cpu_scaling();
 }
 
 /************************** sysfs begin ************************/
@@ -1612,6 +1767,13 @@ static void intel_pstate_notify_work(str
 		__intel_pstate_update_max_freq(cpudata, policy);
 
 		cpufreq_cpu_release(policy);
+
+		/*
+		 * The driver will not be unregistered while this function is
+		 * running, so update the capacity without acquiring the driver
+		 * lock.
+		 */
+		hybrid_update_capacity(cpudata);
 	}
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
@@ -2013,8 +2175,10 @@ static void intel_pstate_get_cpu_pstates
 
 		if (pstate_funcs.get_cpu_scaling) {
 			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
-			if (cpu->pstate.scaling != perf_ctl_scaling)
+			if (cpu->pstate.scaling != perf_ctl_scaling) {
 				intel_pstate_hybrid_hwp_adjust(cpu);
+				hwp_is_hybrid = true;
+			}
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}
@@ -2682,6 +2846,8 @@ static int intel_pstate_cpu_online(struc
 		 */
 		intel_pstate_hwp_reenable(cpu);
 		cpu->suspended = false;
+
+		hybrid_update_capacity(cpu);
 	}
 
 	return 0;
@@ -3124,6 +3290,19 @@ static int intel_pstate_register_driver(
 
 	global.min_perf_pct = min_perf_pct_min();
 
+	/*
+	 * On hybrid systems, use asym capacity instead of ITMT, but because
+	 * the capacity of SMT threads is not deterministic even approximately,
+	 * do not do that when SMT is in use.
+	 */
+	if (hwp_is_hybrid && !sched_smt_active()) {
+		sched_clear_itmt_support();
+
+		hybrid_init_cpu_scaling();
+
+		arch_rebuild_sched_domains();
+	}
+
 	return 0;
 }
 




