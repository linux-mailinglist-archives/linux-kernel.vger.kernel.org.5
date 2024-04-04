Return-Path: <linux-kernel+bounces-131557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B1389898E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA1228351F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC511292EE;
	Thu,  4 Apr 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzK29iey"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AEE129E6E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239664; cv=none; b=B18xMoI+/cksnPeA+jdgjgeHBHspcTowRfjARRJgvWibgrrvY5hsxs63KyJEP7UHDHUQE7fVE/NqBR3Xg2JV6udtMGaScKn8qrwwhMUtubQBOs+e5Qj+p9rBD0EF6PG6Y0pxZN0Mb9F6scwbkeI7EgOBNzdHn5jl3FSwsWYljtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239664; c=relaxed/simple;
	bh=gEVF4aIJM736x3egYNoylJ/TuUF1GEPXnoMILjwmDeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+MK8Sd0omN6eoxK/MOrf2srDasdWTCjS0y9zarLSGwBuuXCIuDl5vagNPWsmGS6IFc1e0AzVbusdhy/pgpo0RvL6xsq1j6950eOR/dxfGhc89l5tn55auQKaN3iXWfWGLsjesrZuIRl8kZuJY+a3naL9lSXeEhXkvQ/KLeJ8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzK29iey; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239661; x=1743775661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gEVF4aIJM736x3egYNoylJ/TuUF1GEPXnoMILjwmDeQ=;
  b=gzK29ieyVEV29IG9g/61j/PD6DcCVI+aQs5ACBLnC+8qs44JPw6zml9b
   2lT0ufQYB8UKDmhhfRLBrxtvNG6kubcuME4RvcOnbPamBi2uB9riaNcII
   E6V86P0dVT2XANQD7PMqoVyxdfSm9NFEDUcKW5N6BnMIWZWJ26QCtDwI2
   TME6Yws08YKRBT7Op3WS9w23aTnbKwmDaIQJbOzALz0Sup4thJXE+vl5C
   k7WoQN8/7Jh8hW1X/4Lzm0aXFAkErw43nj/1oCOMDWZjmVA6pOR8omKdg
   8zstinN/Pa4sGZWD37VQRZNNlsT4PGQxuvIG+O50PSrxK/bwyASWKu1pl
   Q==;
X-CSE-ConnectionGUID: Zo+tzG1KT9+reyDBhI3VrQ==
X-CSE-MsgGUID: 2LPdliTCTj+R0jvtbjpK6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346500"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346500"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:40 -0700
X-CSE-ConnectionGUID: 1+TjtkeIRzKmkHoXh0S2jA==
X-CSE-MsgGUID: RN2IZzUsRs+vDQu7vELzkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258862"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:39 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH 02/12] perf/x86: Support counter mask
Date: Thu,  4 Apr 2024 07:06:27 -0700
Message-Id: <20240404140637.1232635-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404140637.1232635-1-kan.liang@linux.intel.com>
References: <20240404140637.1232635-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current perf assumes that both GP and fixed counters are contiguous.
But it's not guaranteed on newer Intel platforms or in a virtualization
environment.

Use the counter mask to replace the number of counters for both GP and
the fixed counters. For the other ARCHs or old platforms which don't
support a counter mask, using GENMASK_ULL(num_counter - 1, 0) to
replace. There is no functional change for them.

The interface to KVM is not changed. The number of counters still be
passed to KVM. It can be updated later separately.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: silviazhao <silviazhao-oc@zhaoxin.com>
Cc: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/amd/core.c     |  24 ++---
 arch/x86/events/core.c         |  98 ++++++++++----------
 arch/x86/events/intel/core.c   | 164 ++++++++++++++++-----------------
 arch/x86/events/intel/ds.c     |  19 ++--
 arch/x86/events/intel/knc.c    |   2 +-
 arch/x86/events/intel/p4.c     |  10 +-
 arch/x86/events/intel/p6.c     |   2 +-
 arch/x86/events/perf_event.h   |  37 ++++++--
 arch/x86/events/zhaoxin/core.c |  12 +--
 9 files changed, 189 insertions(+), 179 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index aec16e581f5b..281273fbf621 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -403,7 +403,7 @@ static void __amd_put_nb_event_constraints(struct cpu_hw_events *cpuc,
 	 * be removed on one CPU at a time AND PMU is disabled
 	 * when we come here
 	 */
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for_each_set_bit(i, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		if (cmpxchg(nb->owners + i, event, NULL) == event)
 			break;
 	}
@@ -470,7 +470,7 @@ __amd_get_nb_event_constraints(struct cpu_hw_events *cpuc, struct perf_event *ev
 	 * because of successive calls to x86_schedule_events() from
 	 * hw_perf_group_sched_in() without hw_perf_enable()
 	 */
-	for_each_set_bit(idx, c->idxmsk, x86_pmu.num_counters) {
+	for_each_set_bit(idx, c->idxmsk, x86_pmu_num_counters(NULL)) {
 		if (new == -1 || hwc->idx == idx)
 			/* assign free slot, prefer hwc->idx */
 			old = cmpxchg(nb->owners + idx, NULL, event);
@@ -513,7 +513,7 @@ static struct amd_nb *amd_alloc_nb(int cpu)
 	/*
 	 * initialize all possible NB constraints
 	 */
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for_each_set_bit(i, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		__set_bit(i, nb->event_constraints[i].idxmsk);
 		nb->event_constraints[i].weight = 1;
 	}
@@ -706,7 +706,7 @@ static void amd_pmu_check_overflow(void)
 	 * counters are always enabled when this function is called and
 	 * ARCH_PERFMON_EVENTSEL_INT is always set.
 	 */
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
 
@@ -726,7 +726,7 @@ static void amd_pmu_enable_all(int added)
 
 	amd_brs_enable_all();
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		/* only activate events which are marked as active */
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
@@ -918,7 +918,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	/* Clear any reserved bits set by buggy microcode */
 	status &= amd_pmu_global_cntr_mask;
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
 
@@ -1253,7 +1253,7 @@ static __initconst const struct x86_pmu amd_pmu = {
 	.addr_offset            = amd_pmu_addr_offset,
 	.event_map		= amd_pmu_event_map,
 	.max_events		= ARRAY_SIZE(amd_perfmon_event_map),
-	.num_counters		= AMD64_NUM_COUNTERS,
+	.cntr_mask64		= GENMASK_ULL(AMD64_NUM_COUNTERS - 1, 0),
 	.add			= amd_pmu_add_event,
 	.del			= amd_pmu_del_event,
 	.cntval_bits		= 48,
@@ -1352,7 +1352,7 @@ static int __init amd_core_pmu_init(void)
 	 */
 	x86_pmu.eventsel	= MSR_F15H_PERF_CTL;
 	x86_pmu.perfctr		= MSR_F15H_PERF_CTR;
-	x86_pmu.num_counters	= AMD64_NUM_COUNTERS_CORE;
+	x86_pmu.cntr_mask64	= GENMASK_ULL(AMD64_NUM_COUNTERS_CORE - 1, 0);
 
 	/* Check for Performance Monitoring v2 support */
 	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
@@ -1362,9 +1362,9 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.version = 2;
 
 		/* Find the number of available Core PMCs */
-		x86_pmu.num_counters = ebx.split.num_core_pmc;
+		x86_pmu.cntr_mask64 = GENMASK_ULL(ebx.split.num_core_pmc - 1, 0);
 
-		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+		amd_pmu_global_cntr_mask = x86_pmu.cntr_mask64;
 
 		/* Update PMC handling functions */
 		x86_pmu.enable_all = amd_pmu_v2_enable_all;
@@ -1392,12 +1392,12 @@ static int __init amd_core_pmu_init(void)
 		 * even numbered counter that has a consecutive adjacent odd
 		 * numbered counter following it.
 		 */
-		for (i = 0; i < x86_pmu.num_counters - 1; i += 2)
+		for (i = 0; i < x86_pmu_num_counters(NULL) - 1; i += 2)
 			even_ctr_mask |= BIT_ULL(i);
 
 		pair_constraint = (struct event_constraint)
 				    __EVENT_CONSTRAINT(0, even_ctr_mask, 0,
-				    x86_pmu.num_counters / 2, 0,
+				    x86_pmu_num_counters(NULL) / 2, 0,
 				    PERF_X86_EVENT_PAIR);
 
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f17h;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 09050641ce5d..08c31f48cead 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -189,29 +189,31 @@ static DEFINE_MUTEX(pmc_reserve_mutex);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-static inline int get_possible_num_counters(void)
+static inline u64 get_possible_counter_mask(void)
 {
-	int i, num_counters = x86_pmu.num_counters;
+	u64 cntr_mask = x86_pmu.cntr_mask64;
+	int i;
 
 	if (!is_hybrid())
-		return num_counters;
+		return cntr_mask;
 
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++)
-		num_counters = max_t(int, num_counters, x86_pmu.hybrid_pmu[i].num_counters);
+		cntr_mask |= x86_pmu.hybrid_pmu[i].cntr_mask64;
 
-	return num_counters;
+	return cntr_mask;
 }
 
 static bool reserve_pmc_hardware(void)
 {
-	int i, num_counters = get_possible_num_counters();
+	u64 cntr_mask = get_possible_counter_mask();
+	int i, end;
 
-	for (i = 0; i < num_counters; i++) {
+	for_each_set_bit(i, (unsigned long *)&cntr_mask, X86_PMC_IDX_MAX) {
 		if (!reserve_perfctr_nmi(x86_pmu_event_addr(i)))
 			goto perfctr_fail;
 	}
 
-	for (i = 0; i < num_counters; i++) {
+	for_each_set_bit(i, (unsigned long *)&cntr_mask, X86_PMC_IDX_MAX) {
 		if (!reserve_evntsel_nmi(x86_pmu_config_addr(i)))
 			goto eventsel_fail;
 	}
@@ -219,13 +221,14 @@ static bool reserve_pmc_hardware(void)
 	return true;
 
 eventsel_fail:
-	for (i--; i >= 0; i--)
+	end = i;
+	for_each_set_bit(i, (unsigned long *)&cntr_mask, end)
 		release_evntsel_nmi(x86_pmu_config_addr(i));
-
-	i = num_counters;
+	i = X86_PMC_IDX_MAX;
 
 perfctr_fail:
-	for (i--; i >= 0; i--)
+	end = i;
+	for_each_set_bit(i, (unsigned long *)&cntr_mask, end)
 		release_perfctr_nmi(x86_pmu_event_addr(i));
 
 	return false;
@@ -233,9 +236,10 @@ static bool reserve_pmc_hardware(void)
 
 static void release_pmc_hardware(void)
 {
-	int i, num_counters = get_possible_num_counters();
+	u64 cntr_mask = get_possible_counter_mask();
+	int i;
 
-	for (i = 0; i < num_counters; i++) {
+	for_each_set_bit(i, (unsigned long *)&cntr_mask, X86_PMC_IDX_MAX) {
 		release_perfctr_nmi(x86_pmu_event_addr(i));
 		release_evntsel_nmi(x86_pmu_config_addr(i));
 	}
@@ -248,7 +252,8 @@ static void release_pmc_hardware(void) {}
 
 #endif
 
-bool check_hw_exists(struct pmu *pmu, int num_counters, int num_counters_fixed)
+bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
+		     unsigned long *fixed_cntr_mask)
 {
 	u64 val, val_fail = -1, val_new= ~0;
 	int i, reg, reg_fail = -1, ret = 0;
@@ -259,7 +264,7 @@ bool check_hw_exists(struct pmu *pmu, int num_counters, int num_counters_fixed)
 	 * Check to see if the BIOS enabled any of the counters, if so
 	 * complain and bail.
 	 */
-	for (i = 0; i < num_counters; i++) {
+	for_each_set_bit(i, cntr_mask, X86_PMC_IDX_MAX) {
 		reg = x86_pmu_config_addr(i);
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
@@ -273,12 +278,12 @@ bool check_hw_exists(struct pmu *pmu, int num_counters, int num_counters_fixed)
 		}
 	}
 
-	if (num_counters_fixed) {
+	if (*(u64 *)fixed_cntr_mask) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
-		for (i = 0; i < num_counters_fixed; i++) {
+		for_each_set_bit(i, fixed_cntr_mask, X86_PMC_IDX_MAX) {
 			if (fixed_counter_disabled(i, pmu))
 				continue;
 			if (val & (0x03ULL << i*4)) {
@@ -679,7 +684,7 @@ void x86_pmu_disable_all(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		struct hw_perf_event *hwc = &cpuc->events[idx]->hw;
 		u64 val;
 
@@ -736,7 +741,7 @@ void x86_pmu_enable_all(int added)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		struct hw_perf_event *hwc = &cpuc->events[idx]->hw;
 
 		if (!test_bit(idx, cpuc->active_mask))
@@ -975,7 +980,6 @@ EXPORT_SYMBOL_GPL(perf_assign_events);
 
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 {
-	int num_counters = hybrid(cpuc->pmu, num_counters);
 	struct event_constraint *c;
 	struct perf_event *e;
 	int n0, i, wmin, wmax, unsched = 0;
@@ -1051,7 +1055,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 
 	/* slow path */
 	if (i != n) {
-		int gpmax = num_counters;
+		int gpmax = find_last_bit(hybrid(cpuc->pmu, cntr_mask), X86_PMC_IDX_MAX) + 1;
 
 		/*
 		 * Do not allow scheduling of more than half the available
@@ -1072,7 +1076,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		 * the extra Merge events needed by large increment events.
 		 */
 		if (x86_pmu.flags & PMU_FL_PAIR) {
-			gpmax = num_counters - cpuc->n_pair;
+			gpmax -= cpuc->n_pair;
 			WARN_ON(gpmax <= 0);
 		}
 
@@ -1157,12 +1161,10 @@ static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
  */
 static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader, bool dogrp)
 {
-	int num_counters = hybrid(cpuc->pmu, num_counters);
-	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct perf_event *event;
 	int n, max_count;
 
-	max_count = num_counters + num_counters_fixed;
+	max_count = x86_pmu_num_counters(cpuc->pmu) + x86_pmu_num_counters_fixed(cpuc->pmu);
 
 	/* current number of events already accepted */
 	n = cpuc->n_events;
@@ -1522,13 +1524,13 @@ void perf_event_print_debug(void)
 	u64 pebs, debugctl;
 	int cpu = smp_processor_id();
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
-	int num_counters = hybrid(cpuc->pmu, num_counters);
-	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
+	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
+	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
 	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
 	unsigned long flags;
 	int idx;
 
-	if (!num_counters)
+	if (!*(u64 *)cntr_mask)
 		return;
 
 	local_irq_save(flags);
@@ -1555,7 +1557,7 @@ void perf_event_print_debug(void)
 	}
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
-	for (idx = 0; idx < num_counters; idx++) {
+	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {
 		rdmsrl(x86_pmu_config_addr(idx), pmc_ctrl);
 		rdmsrl(x86_pmu_event_addr(idx), pmc_count);
 
@@ -1568,7 +1570,7 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d:   gen-PMC%d left:  %016llx\n",
 			cpu, idx, prev_left);
 	}
-	for (idx = 0; idx < num_counters_fixed; idx++) {
+	for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
@@ -1681,7 +1683,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	 */
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
 
@@ -2037,18 +2039,15 @@ static void _x86_pmu_read(struct perf_event *event)
 	static_call(x86_pmu_update)(event);
 }
 
-void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
-			  u64 intel_ctrl)
+void x86_pmu_show_pmu_cap(struct pmu *pmu)
 {
 	pr_info("... version:                %d\n",     x86_pmu.version);
 	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
-	pr_info("... generic registers:      %d\n",     num_counters);
+	pr_info("... generic registers:      %d\n",     x86_pmu_num_counters(pmu));
 	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
 	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %lu\n",
-			hweight64((((1ULL << num_counters_fixed) - 1)
-					<< INTEL_PMC_IDX_FIXED) & intel_ctrl));
-	pr_info("... event mask:             %016Lx\n", intel_ctrl);
+	pr_info("... fixed-purpose events:   %lu\n",    hweight64(hybrid(pmu, fixed_cntr_mask64)));
+	pr_info("... event mask:             %016Lx\n", hybrid(pmu, intel_ctrl));
 }
 
 static int __init init_hw_perf_events(void)
@@ -2085,7 +2084,7 @@ static int __init init_hw_perf_events(void)
 	pmu_check_apic();
 
 	/* sanity check that the hardware exists or is emulated */
-	if (!check_hw_exists(&pmu, x86_pmu.num_counters, x86_pmu.num_counters_fixed))
+	if (!check_hw_exists(&pmu, x86_pmu.cntr_mask, x86_pmu.fixed_cntr_mask))
 		goto out_bad_pmu;
 
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
@@ -2096,14 +2095,14 @@ static int __init init_hw_perf_events(void)
 		quirk->func();
 
 	if (!x86_pmu.intel_ctrl)
-		x86_pmu.intel_ctrl = (1 << x86_pmu.num_counters) - 1;
+		x86_pmu.intel_ctrl = x86_pmu.cntr_mask64;
 
 	perf_events_lapic_init();
 	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
 
 	unconstrained = (struct event_constraint)
-		__EVENT_CONSTRAINT(0, (1ULL << x86_pmu.num_counters) - 1,
-				   0, x86_pmu.num_counters, 0, 0);
+		__EVENT_CONSTRAINT(0, x86_pmu.cntr_mask64,
+				   0, x86_pmu_num_counters(NULL), 0, 0);
 
 	x86_pmu_format_group.attrs = x86_pmu.format_attrs;
 
@@ -2112,11 +2111,8 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	if (!is_hybrid()) {
-		x86_pmu_show_pmu_cap(x86_pmu.num_counters,
-				     x86_pmu.num_counters_fixed,
-				     x86_pmu.intel_ctrl);
-	}
+	if (!is_hybrid())
+		x86_pmu_show_pmu_cap(NULL);
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
@@ -2480,7 +2476,7 @@ void perf_clear_dirty_counters(void)
 	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
 		if (i >= INTEL_PMC_IDX_FIXED) {
 			/* Metrics and fake events don't have corresponding HW counters. */
-			if ((i - INTEL_PMC_IDX_FIXED) >= hybrid(cpuc->pmu, num_counters_fixed))
+			if (!test_bit(i - INTEL_PMC_IDX_FIXED, hybrid(cpuc->pmu, fixed_cntr_mask)))
 				continue;
 
 			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
@@ -2982,8 +2978,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	 * base PMU holds the correct number of counters for P-cores.
 	 */
 	cap->version		= x86_pmu.version;
-	cap->num_counters_gp	= x86_pmu.num_counters;
-	cap->num_counters_fixed	= x86_pmu.num_counters_fixed;
+	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
+	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
 	cap->bit_width_gp	= x86_pmu.cntval_bits;
 	cap->bit_width_fixed	= x86_pmu.cntval_bits;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c173e35a5660..30374d3d7b0e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2874,23 +2874,23 @@ static void intel_pmu_reset(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
-	int num_counters = hybrid(cpuc->pmu, num_counters);
+	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
+	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
 	unsigned long flags;
 	int idx;
 
-	if (!num_counters)
+	if (!*(u64 *)cntr_mask)
 		return;
 
 	local_irq_save(flags);
 
 	pr_info("clearing PMU state on CPU#%d\n", smp_processor_id());
 
-	for (idx = 0; idx < num_counters; idx++) {
+	for_each_set_bit(idx, cntr_mask, INTEL_PMC_MAX_GENERIC) {
 		wrmsrl_safe(x86_pmu_config_addr(idx), 0ull);
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
-	for (idx = 0; idx < num_counters_fixed; idx++) {
+	for_each_set_bit(idx, fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
@@ -2940,8 +2940,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 	    !guest_pebs_idxs)
 		return;
 
-	for_each_set_bit(bit, (unsigned long *)&guest_pebs_idxs,
-			 INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed) {
+	for_each_set_bit(bit, (unsigned long *)&guest_pebs_idxs, X86_PMC_IDX_MAX) {
 		event = cpuc->events[bit];
 		if (!event->attr.precise_ip)
 			continue;
@@ -4199,7 +4198,7 @@ static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr, void *data)
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
 	int idx;
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++)  {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		struct perf_event *event = cpuc->events[idx];
 
 		arr[idx].msr = x86_pmu_config_addr(idx);
@@ -4217,7 +4216,7 @@ static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr, void *data)
 			arr[idx].guest &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 	}
 
-	*nr = x86_pmu.num_counters;
+	*nr = x86_pmu_num_counters(cpuc->pmu);
 	return arr;
 }
 
@@ -4232,7 +4231,7 @@ static void core_pmu_enable_all(int added)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		struct hw_perf_event *hwc = &cpuc->events[idx]->hw;
 
 		if (!test_bit(idx, cpuc->active_mask) ||
@@ -4684,13 +4683,33 @@ static void flip_smm_bit(void *data)
 	}
 }
 
-static void intel_pmu_check_num_counters(int *num_counters,
-					 int *num_counters_fixed,
-					 u64 *intel_ctrl, u64 fixed_mask);
+static void intel_pmu_check_counters_mask(unsigned long *cntr_mask,
+					  unsigned long *fixed_cntr_mask,
+					  u64 *intel_ctrl)
+{
+	unsigned int bit;
+
+	bit = find_last_bit(cntr_mask, X86_PMC_IDX_MAX);
+	if (bit > INTEL_PMC_MAX_GENERIC) {
+		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
+		     bit, INTEL_PMC_MAX_GENERIC);
+		*cntr_mask &= GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
+	}
+	*intel_ctrl = *cntr_mask;
+
+	bit = find_last_bit(fixed_cntr_mask, X86_PMC_IDX_MAX);
+	if (bit > INTEL_PMC_MAX_FIXED) {
+		WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
+		     bit, INTEL_PMC_MAX_FIXED);
+		*fixed_cntr_mask &= GENMASK_ULL(INTEL_PMC_MAX_FIXED - 1, 0);
+	}
+
+	*intel_ctrl |= (u64)*fixed_cntr_mask << INTEL_PMC_IDX_FIXED;
+}
 
 static void intel_pmu_check_event_constraints(struct event_constraint *event_constraints,
-					      int num_counters,
-					      int num_counters_fixed,
+					      u64 cntr_mask,
+					      u64 fixed_cntr_mask,
 					      u64 intel_ctrl);
 
 static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
@@ -4713,11 +4732,10 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
 			    &eax, &ebx, &ecx, &edx);
-		pmu->num_counters = fls(eax);
-		pmu->num_counters_fixed = fls(ebx);
+		pmu->cntr_mask64 = eax;
+		pmu->fixed_cntr_mask64 = ebx;
 	}
 
-
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
@@ -4726,12 +4744,12 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 {
-	intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
-				     &pmu->intel_ctrl, (1ULL << pmu->num_counters_fixed) - 1);
-	pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
+	intel_pmu_check_counters_mask(pmu->cntr_mask, pmu->fixed_cntr_mask,
+				      &pmu->intel_ctrl);
+	pmu->pebs_events_mask = intel_pmu_pebs_mask(pmu->cntr_mask64);
 	pmu->unconstrained = (struct event_constraint)
-			     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
-						0, pmu->num_counters, 0, 0);
+			     __EVENT_CONSTRAINT(0, pmu->cntr_mask64,
+						0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
 	if (pmu->intel_cap.perf_metrics)
 		pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
@@ -4744,8 +4762,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
 
 	intel_pmu_check_event_constraints(pmu->event_constraints,
-					  pmu->num_counters,
-					  pmu->num_counters_fixed,
+					  pmu->cntr_mask64,
+					  pmu->fixed_cntr_mask64,
 					  pmu->intel_ctrl);
 
 	intel_pmu_check_extra_regs(pmu->extra_regs);
@@ -4806,7 +4824,7 @@ static bool init_hybrid_pmu(int cpu)
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
-	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
+	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask))
 		return false;
 
 	pr_info("%s PMU driver: ", pmu->name);
@@ -4816,8 +4834,7 @@ static bool init_hybrid_pmu(int cpu)
 
 	pr_cont("\n");
 
-	x86_pmu_show_pmu_cap(pmu->num_counters, pmu->num_counters_fixed,
-			     pmu->intel_ctrl);
+	x86_pmu_show_pmu_cap(&pmu->pmu);
 
 end:
 	cpumask_set_cpu(cpu, &pmu->supported_cpus);
@@ -5962,29 +5979,9 @@ static const struct attribute_group *hybrid_attr_update[] = {
 
 static struct attribute *empty_attrs;
 
-static void intel_pmu_check_num_counters(int *num_counters,
-					 int *num_counters_fixed,
-					 u64 *intel_ctrl, u64 fixed_mask)
-{
-	if (*num_counters > INTEL_PMC_MAX_GENERIC) {
-		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
-		     *num_counters, INTEL_PMC_MAX_GENERIC);
-		*num_counters = INTEL_PMC_MAX_GENERIC;
-	}
-	*intel_ctrl = (1ULL << *num_counters) - 1;
-
-	if (*num_counters_fixed > INTEL_PMC_MAX_FIXED) {
-		WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
-		     *num_counters_fixed, INTEL_PMC_MAX_FIXED);
-		*num_counters_fixed = INTEL_PMC_MAX_FIXED;
-	}
-
-	*intel_ctrl |= fixed_mask << INTEL_PMC_IDX_FIXED;
-}
-
 static void intel_pmu_check_event_constraints(struct event_constraint *event_constraints,
-					      int num_counters,
-					      int num_counters_fixed,
+					      u64 cntr_mask,
+					      u64 fixed_cntr_mask,
 					      u64 intel_ctrl)
 {
 	struct event_constraint *c;
@@ -6021,10 +6018,9 @@ static void intel_pmu_check_event_constraints(struct event_constraint *event_con
 			 * generic counters
 			 */
 			if (!use_fixed_pseudo_encoding(c->code))
-				c->idxmsk64 |= (1ULL << num_counters) - 1;
+				c->idxmsk64 |= cntr_mask;
 		}
-		c->idxmsk64 &=
-			~(~0ULL << (INTEL_PMC_IDX_FIXED + num_counters_fixed));
+		c->idxmsk64 &= cntr_mask | (fixed_cntr_mask << INTEL_PMC_IDX_FIXED);
 		c->weight = hweight64(c->idxmsk64);
 	}
 }
@@ -6075,12 +6071,12 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 		pmu->pmu_type = intel_hybrid_pmu_type_map[bit].id;
 		pmu->name = intel_hybrid_pmu_type_map[bit].name;
 
-		pmu->num_counters = x86_pmu.num_counters;
-		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
-		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
+		pmu->cntr_mask64 = x86_pmu.cntr_mask64;
+		pmu->fixed_cntr_mask64 = x86_pmu.fixed_cntr_mask64;
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(pmu->cntr_mask64);
 		pmu->unconstrained = (struct event_constraint)
-				     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
-							0, pmu->num_counters, 0, 0);
+				     __EVENT_CONSTRAINT(0, pmu->cntr_mask64,
+							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
 		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
 		if (pmu->pmu_type & hybrid_small) {
@@ -6193,14 +6189,14 @@ __init int intel_pmu_init(void)
 		x86_pmu = intel_pmu;
 
 	x86_pmu.version			= version;
-	x86_pmu.num_counters		= eax.split.num_counters;
+	x86_pmu.cntr_mask64		= GENMASK_ULL(eax.split.num_counters - 1, 0);
 	x86_pmu.cntval_bits		= eax.split.bit_width;
 	x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
 
 	x86_pmu.events_maskl		= ebx.full;
 	x86_pmu.events_mask_len		= eax.split.mask_length;
 
-	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(GENMASK_ULL(x86_pmu.num_counters - 1, 0));
+	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(x86_pmu.cntr_mask64);
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
 
 	/*
@@ -6210,12 +6206,10 @@ __init int intel_pmu_init(void)
 	if (version > 1 && version < 5) {
 		int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
 
-		x86_pmu.num_counters_fixed =
-			max((int)edx.split.num_counters_fixed, assume);
-
-		fixed_mask = (1L << x86_pmu.num_counters_fixed) - 1;
+		x86_pmu.fixed_cntr_mask64 =
+			GENMASK_ULL(max((int)edx.split.num_counters_fixed, assume) - 1, 0);
 	} else if (version >= 5)
-		x86_pmu.num_counters_fixed = fls(fixed_mask);
+		x86_pmu.fixed_cntr_mask64 = fixed_mask;
 
 	if (boot_cpu_has(X86_FEATURE_PDCM)) {
 		u64 capabilities;
@@ -6810,11 +6804,13 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		intel_pmu_init_glc(&pmu->pmu);
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
-			pmu->num_counters = x86_pmu.num_counters + 2;
-			pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
+			pmu->cntr_mask64 <<= 2;
+			pmu->cntr_mask64 |= 0x3;
+			pmu->fixed_cntr_mask64 <<= 1;
+			pmu->fixed_cntr_mask64 |= 0x1;
 		} else {
-			pmu->num_counters = x86_pmu.num_counters;
-			pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
+			pmu->cntr_mask64 = x86_pmu.cntr_mask64;
+			pmu->fixed_cntr_mask64 = x86_pmu.fixed_cntr_mask64;
 		}
 
 		/*
@@ -6824,15 +6820,16 @@ __init int intel_pmu_init(void)
 		 * mistakenly add extra counters for P-cores. Correct the number of
 		 * counters here.
 		 */
-		if ((pmu->num_counters > 8) || (pmu->num_counters_fixed > 4)) {
-			pmu->num_counters = x86_pmu.num_counters;
-			pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
+		if ((x86_pmu_num_counters(&pmu->pmu) > 8) || (x86_pmu_num_counters_fixed(&pmu->pmu) > 4)) {
+			pmu->cntr_mask64 = x86_pmu.cntr_mask64;
+			pmu->fixed_cntr_mask64 = x86_pmu.fixed_cntr_mask64;
 		}
 
-		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(pmu->cntr_mask64);
 		pmu->unconstrained = (struct event_constraint)
-					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
-							   0, pmu->num_counters, 0, 0);
+				     __EVENT_CONSTRAINT(0, pmu->cntr_mask64,
+				     0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
+
 		pmu->extra_regs = intel_glc_extra_regs;
 
 		/* Initialize Atom core specific PerfMon capabilities.*/
@@ -6899,9 +6896,9 @@ __init int intel_pmu_init(void)
 			 * The constraints may be cut according to the CPUID enumeration
 			 * by inserting the EVENT_CONSTRAINT_END.
 			 */
-			if (x86_pmu.num_counters_fixed > INTEL_PMC_MAX_FIXED)
-				x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
-			intel_v5_gen_event_constraints[x86_pmu.num_counters_fixed].weight = -1;
+			if (find_last_bit(x86_pmu.fixed_cntr_mask, X86_PMC_IDX_MAX) > INTEL_PMC_MAX_FIXED)
+				x86_pmu.fixed_cntr_mask64 &= GENMASK_ULL(INTEL_PMC_MAX_FIXED - 1, 0);
+			intel_v5_gen_event_constraints[find_last_bit(x86_pmu.fixed_cntr_mask, INTEL_PMC_MAX_FIXED) + 1].weight = -1;
 			x86_pmu.event_constraints = intel_v5_gen_event_constraints;
 			pr_cont("generic architected perfmon, ");
 			name = "generic_arch_v5+";
@@ -6928,18 +6925,17 @@ __init int intel_pmu_init(void)
 		x86_pmu.attr_update = hybrid_attr_update;
 	}
 
-	intel_pmu_check_num_counters(&x86_pmu.num_counters,
-				     &x86_pmu.num_counters_fixed,
-				     &x86_pmu.intel_ctrl,
-				     (u64)fixed_mask);
+	intel_pmu_check_counters_mask(x86_pmu.cntr_mask,
+				      x86_pmu.fixed_cntr_mask,
+				      &x86_pmu.intel_ctrl);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
 	if (x86_pmu.intel_cap.anythread_deprecated)
 		x86_pmu.format_attrs = intel_arch_formats_attr;
 
 	intel_pmu_check_event_constraints(x86_pmu.event_constraints,
-					  x86_pmu.num_counters,
-					  x86_pmu.num_counters_fixed,
+					  x86_pmu.cntr_mask64,
+					  x86_pmu.fixed_cntr_mask64,
 					  x86_pmu.intel_ctrl);
 	/*
 	 * Access LBR MSR may cause #GP under certain circumstances.
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a5d861093335..38e549d2c3bc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1138,7 +1138,6 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
 	int max_pebs_events = hweight64(hybrid(cpuc->pmu, pebs_events_mask));
-	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	u64 threshold;
 	int reserved;
 
@@ -1146,7 +1145,7 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 		return;
 
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
-		reserved = max_pebs_events + num_counters_fixed;
+		reserved = max_pebs_events + x86_pmu_num_counters_fixed(cpuc->pmu);
 	else
 		reserved = max_pebs_events;
 
@@ -2172,8 +2171,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	mask = x86_pmu.pebs_events_mask;
 	size = max_pebs_events;
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
-		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
-		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
+		mask |= x86_pmu.fixed_cntr_mask64 << INTEL_PMC_IDX_FIXED;
+		size = INTEL_PMC_IDX_FIXED + x86_pmu_num_counters_fixed(NULL);
 	}
 
 	if (unlikely(base >= top)) {
@@ -2268,11 +2267,10 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
 	void *base, *at, *top;
-	int bit, size;
+	int bit;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
@@ -2284,11 +2282,10 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	ds->pebs_index = ds->pebs_buffer_base;
 
 	mask = hybrid(cpuc->pmu, pebs_events_mask) |
-	       (((1ULL << num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
-	size = INTEL_PMC_IDX_FIXED + num_counters_fixed;
+	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
 
 	if (unlikely(base >= top)) {
-		intel_pmu_pebs_event_update_no_drain(cpuc, size);
+		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
 		return;
 	}
 
@@ -2298,11 +2295,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
 		pebs_status &= mask;
 
-		for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
+		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX)
 			counts[bit]++;
 	}
 
-	for_each_set_bit(bit, (unsigned long *)&mask, size) {
+	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
 		if (counts[bit] == 0)
 			continue;
 
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 618001c208e8..034a1f6a457c 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -303,7 +303,7 @@ static const struct x86_pmu knc_pmu __initconst = {
 	.apic			= 1,
 	.max_period		= (1ULL << 39) - 1,
 	.version		= 0,
-	.num_counters		= 2,
+	.cntr_mask64		= 0x3,
 	.cntval_bits		= 40,
 	.cntval_mask		= (1ULL << 40) - 1,
 	.get_event_constraints	= x86_get_event_constraints,
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 35936188db01..844bc4fc4724 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -919,7 +919,7 @@ static void p4_pmu_disable_all(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		struct perf_event *event = cpuc->events[idx];
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
@@ -998,7 +998,7 @@ static void p4_pmu_enable_all(int added)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		struct perf_event *event = cpuc->events[idx];
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
@@ -1040,7 +1040,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		int overflow;
 
 		if (!test_bit(idx, cpuc->active_mask)) {
@@ -1353,7 +1353,7 @@ static __initconst const struct x86_pmu p4_pmu = {
 	 * though leave it restricted at moment assuming
 	 * HT is on
 	 */
-	.num_counters		= ARCH_P4_MAX_CCCR,
+	.cntr_mask64		= GENMASK_ULL(ARCH_P4_MAX_CCCR - 1, 0),
 	.apic			= 1,
 	.cntval_bits		= ARCH_P4_CNTRVAL_BITS,
 	.cntval_mask		= ARCH_P4_CNTRVAL_MASK,
@@ -1395,7 +1395,7 @@ __init int p4_pmu_init(void)
 	 *
 	 * Solve this by zero'ing out the registers to mimic a reset.
 	 */
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for_each_set_bit(i, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		reg = x86_pmu_config_addr(i);
 		wrmsrl_safe(reg, 0ULL);
 	}
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 408879b0c0d4..a6cffb4f4ef5 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -214,7 +214,7 @@ static __initconst const struct x86_pmu p6_pmu = {
 	.apic			= 1,
 	.max_period		= (1ULL << 31) - 1,
 	.version		= 0,
-	.num_counters		= 2,
+	.cntr_mask64		= 0x3,
 	/*
 	 * Events have 40 bits implemented. However they are designed such
 	 * that bits [32-39] are sign extensions of bit 31. As such the
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 047aa1c8d5c6..f86bd1113e6a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -685,8 +685,14 @@ struct x86_hybrid_pmu {
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	u64				pebs_events_mask;
-	int				num_counters;
-	int				num_counters_fixed;
+	union {
+			u64		cntr_mask64;
+			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	union {
+			u64		fixed_cntr_mask64;
+			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
 	struct event_constraint		unconstrained;
 
 	u64				hw_cache_event_ids
@@ -774,8 +780,14 @@ struct x86_pmu {
 	int		(*rdpmc_index)(int index);
 	u64		(*event_map)(int);
 	int		max_events;
-	int		num_counters;
-	int		num_counters_fixed;
+	union {
+			u64		cntr_mask64;
+			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	union {
+			u64		fixed_cntr_mask64;
+			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
 	int		cntval_bits;
 	u64		cntval_mask;
 	union {
@@ -1125,8 +1137,8 @@ static inline int x86_pmu_rdpmc_index(int index)
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
 }
 
-bool check_hw_exists(struct pmu *pmu, int num_counters,
-		     int num_counters_fixed);
+bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
+		     unsigned long *fixed_cntr_mask);
 
 int x86_add_exclusive(unsigned int what);
 
@@ -1197,8 +1209,17 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
-void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
-			  u64 intel_ctrl);
+void x86_pmu_show_pmu_cap(struct pmu *pmu);
+
+static inline int x86_pmu_num_counters(struct pmu *pmu)
+{
+	return hweight64(hybrid(pmu, cntr_mask64));
+}
+
+static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
+{
+	return hweight64(hybrid(pmu, fixed_cntr_mask64));
+}
 
 extern struct event_constraint emptyconstraint;
 
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 3e9acdaeed1e..2fd9b0cf9a5e 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -530,13 +530,13 @@ __init int zhaoxin_pmu_init(void)
 	pr_info("Version check pass!\n");
 
 	x86_pmu.version			= version;
-	x86_pmu.num_counters		= eax.split.num_counters;
+	x86_pmu.cntr_mask64		= GENMASK_ULL(eax.split.num_counters - 1, 0);
 	x86_pmu.cntval_bits		= eax.split.bit_width;
 	x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
 	x86_pmu.events_maskl		= ebx.full;
 	x86_pmu.events_mask_len		= eax.split.mask_length;
 
-	x86_pmu.num_counters_fixed = edx.split.num_counters_fixed;
+	x86_pmu.fixed_cntr_mask64	= GENMASK_ULL(edx.split.num_counters_fixed - 1, 0);
 	x86_add_quirk(zhaoxin_arch_events_quirk);
 
 	switch (boot_cpu_data.x86) {
@@ -604,13 +604,13 @@ __init int zhaoxin_pmu_init(void)
 		return -ENODEV;
 	}
 
-	x86_pmu.intel_ctrl = (1 << (x86_pmu.num_counters)) - 1;
-	x86_pmu.intel_ctrl |= ((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+	x86_pmu.intel_ctrl = x86_pmu.cntr_mask64;
+	x86_pmu.intel_ctrl |= x86_pmu.fixed_cntr_mask64 << INTEL_PMC_IDX_FIXED;
 
 	if (x86_pmu.event_constraints) {
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
-			c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
-			c->weight += x86_pmu.num_counters;
+			c->idxmsk64 |= x86_pmu.cntr_mask64;
+			c->weight += x86_pmu_num_counters(NULL);
 		}
 	}
 
-- 
2.35.1


