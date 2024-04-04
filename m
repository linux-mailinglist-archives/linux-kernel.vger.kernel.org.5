Return-Path: <linux-kernel+bounces-131566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF68898995
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED191C28AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823D2130A47;
	Thu,  4 Apr 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3wPgb3s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182912DDBF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239674; cv=none; b=kB201dCJWuCh0Oag4dNk/FTbX340beT4yJNWQKyZdTxr43YIAwVlFD3ng/Qp6EC2VciseqYuPjfEz8jAy+TmqdTwrHQOikOtlBWmUGkABdtzbUsDGrQ9XslEhNIt/gGVhb0p/6usga8UZXvNjHLgb0TkKRKegzKqP1dVH1pUZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239674; c=relaxed/simple;
	bh=FYmxQRLHUqP9B3Ju00zFS9xMhLAuJqC4liWy4KbYeDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqNKeMqUPwgybzoD0npulRZjuhYv3WI1QO5nq7QvBhVqJDdP/OQhMQ+lMy/CnLqkSpilXIPCZ4S5jK/ogQ1X+OJ4mD4fMAMMR2UsXHI0e+G/AiCg3bFzHV4VgLmf3cMUBh13atlZ5jCmqbd15PHETFhwk7r8s2RWFpnE8kdgLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3wPgb3s; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239672; x=1743775672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYmxQRLHUqP9B3Ju00zFS9xMhLAuJqC4liWy4KbYeDo=;
  b=D3wPgb3smBeioZLj4fIJZwKKwPaL+716N5Vx2JSPgxDdCzNyGw9DXvmE
   WvkgyzGJdX0fU7P3e7zo2meGLpW8RfhJBCp0lNc3akxNrfNutmdJ/hbM/
   ubloNJ391xngmu84XNArrMDjBd5Mzu5D/91JnI3gqbWmvZyIDlORK7VSF
   LvP5fQS1xyOqyX5V/kJ4O15hn58ZSCF7kRLfUKbfQ0nzFcVrRheWYaSoL
   6Jj8ir+Nj4r44jomGhhTTL1ZHF7DwQtxagroWA5R6g48nh2icGnB9vlDb
   RJsJ6OH7NvU4jWVsVOBSH6/VinEy6nkwxLr3iwlCAZzjDjxfE2vEoTrxt
   Q==;
X-CSE-ConnectionGUID: KiQ9ColUQcCmu0K562nJQQ==
X-CSE-MsgGUID: vZSHfoMtTKaUIxlgy5T88w==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346567"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346567"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:52 -0700
X-CSE-ConnectionGUID: mTNIA4dERi6GuQfj+zmWYw==
X-CSE-MsgGUID: j0zIt8KdS5KaB9bt7CWeSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258920"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:51 -0700
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 11/12] perf/x86/intel: Support PEBS counters snapshotting
Date: Thu,  4 Apr 2024 07:06:36 -0700
Message-Id: <20240404140637.1232635-12-kan.liang@linux.intel.com>
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

The counters snapshotting is a new adaptive PEBS extension, which can
capture programmable counters, fixed-function counters, and performance
metrics in a PEBS record. The feature is available in the PEBS format
V6.

The target counters can be configured in the new fields of MSR_PEBS_CFG.
Then the PEBS HW will generate the bit mask of counters (Counters Group
Header) followed by the content of all the requested counters into a
PEBS record.

The current Linux perf sample read feature intends to read the counters
of other member events when the leader event is overflowing. But the
current read is in the NMI handler, which may has a small gap from
overflow. Using the counters snapshotting feature for the sample read.

Add a new PEBS_CNTR flag to indicate a sample read group that utilizes
the counters snapshotting feature. When the group is scheduled, the
PEBS configure can be updated accordingly.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c       |  33 ++++++++-
 arch/x86/events/intel/ds.c         | 114 +++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h       |   3 +
 arch/x86/events/perf_event_flags.h |   2 +-
 arch/x86/include/asm/perf_event.h  |  15 ++++
 5 files changed, 157 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5e0d22e5681d..d05a8dfc0f8e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4058,6 +4058,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
+	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
+	    (x86_pmu.intel_cap.pebs_format >= 6)) {
+		struct perf_event *leader = event->group_leader;
+
+		if (is_slots_event(leader))
+			leader = list_next_entry(leader, sibling_list);
+
+		if (leader->attr.precise_ip) {
+			leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
+			event->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
+		}
+	}
+
 	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
 	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
@@ -4161,6 +4174,24 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	return 0;
 }
 
+static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
+{
+	struct perf_event *event;
+	int ret = x86_schedule_events(cpuc, n, assign);
+
+	if (ret)
+		return ret;
+
+	if (cpuc->is_fake)
+		return ret;
+
+	event = cpuc->event_list[n - 1];
+	if (event && (event->hw.flags & PERF_X86_EVENT_PEBS_CNTR))
+		intel_pmu_pebs_update_cfg(cpuc, n, assign);
+
+	return 0;
+}
+
 /*
  * Currently, the only caller of this function is the atomic_switch_perf_msrs().
  * The host perf context helps to prepare the values of the real hardware for
@@ -5248,7 +5279,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.set_period		= intel_pmu_set_period,
 	.update			= intel_pmu_update,
 	.hw_config		= intel_pmu_hw_config,
-	.schedule_events	= x86_schedule_events,
+	.schedule_events	= intel_pmu_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
 	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1df69a75b1f1..f95cca6b632a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1281,10 +1281,61 @@ static void adaptive_pebs_record_size_update(void)
 		sz += sizeof(struct pebs_xmm);
 	if (pebs_data_cfg & PEBS_DATACFG_LBRS)
 		sz += x86_pmu.lbr_nr * sizeof(struct lbr_entry);
+	if (pebs_data_cfg & (PEBS_DATACFG_METRICS | PEBS_DATACFG_CNTR)) {
+		sz += sizeof(struct pebs_cntr_header);
+
+		/* Metrics base and Metrics Data */
+		if (pebs_data_cfg & PEBS_DATACFG_METRICS)
+			sz += 2 * sizeof(u64);
+
+		if (pebs_data_cfg & PEBS_DATACFG_CNTR) {
+			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
+			      * sizeof(u64);
+			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
+			      * sizeof(u64);
+		}
+	}
 
 	cpuc->pebs_record_size = sz;
 }
 
+static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
+					int idx, u64 *pebs_data_cfg)
+{
+	if (is_metric_event(event)) {
+		*pebs_data_cfg |= PEBS_DATACFG_METRICS;
+		return;
+	}
+
+	*pebs_data_cfg |= PEBS_DATACFG_CNTR;
+
+	if (idx >= INTEL_PMC_IDX_FIXED) {
+		*pebs_data_cfg |= ((1ULL << (idx - INTEL_PMC_IDX_FIXED)) & PEBS_DATACFG_FIX_MASK)
+				  << PEBS_DATACFG_FIX_SHIFT;
+	} else {
+		*pebs_data_cfg |= ((1ULL << idx) & PEBS_DATACFG_CNTR_MASK)
+				  << PEBS_DATACFG_CNTR_SHIFT;
+	}
+}
+
+void intel_pmu_pebs_update_cfg(struct cpu_hw_events *cpuc, int n, int *assign)
+{
+	struct perf_event *leader, *event;
+	u64 pebs_data_cfg = 0;
+	int i = n - 1;
+
+	leader = cpuc->event_list[i]->group_leader;
+	for (; i >= 0; i--) {
+		event = cpuc->event_list[i];
+		if (leader != event->group_leader)
+			break;
+		__intel_pmu_pebs_update_cfg(event, assign[i], &pebs_data_cfg);
+	}
+
+	if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
+		cpuc->pebs_data_cfg |= pebs_data_cfg | PEBS_UPDATE_DS_SW;
+}
+
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR |			     \
 				PERF_SAMPLE_WEIGHT_TYPE |		     \
@@ -2024,6 +2075,40 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
+	if (format_size & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
+		struct pebs_cntr_header *cntr = next_record;
+		int bit;
+
+		next_record += sizeof(struct pebs_cntr_header);
+
+		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
+			x86_perf_event_update(cpuc->events[bit], (u64 *)next_record);
+			next_record += sizeof(u64);
+		}
+
+		for_each_set_bit(bit, (unsigned long *)&cntr->fixed, INTEL_PMC_MAX_FIXED) {
+			/* The slots event will be handled with perf_metric later */
+			if ((cntr->metrics == INTEL_CNTR_METRICS) &&
+			    (INTEL_PMC_IDX_FIXED_SLOTS == bit + INTEL_PMC_IDX_FIXED)) {
+				next_record += sizeof(u64);
+				continue;
+			}
+			x86_perf_event_update(cpuc->events[bit + INTEL_PMC_IDX_FIXED], (u64 *)next_record);
+			next_record += sizeof(u64);
+		}
+
+		/* HW will reload the value right after the overflow. */
+		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+			local64_set(&event->hw.prev_count, (u64)-event->hw.sample_period);
+
+		if (cntr->metrics == INTEL_CNTR_METRICS) {
+			static_call(intel_pmu_update_topdown_event)
+					(event->group_leader, (u64 *)next_record);
+			next_record += 2 * sizeof(u64);
+		}
+		data->sample_flags |= PERF_SAMPLE_READ;
+	}
+
 	WARN_ONCE(next_record != __pebs + (format_size >> 48),
 			"PEBS record size %llu, expected %llu, config %llx\n",
 			format_size >> 48,
@@ -2188,13 +2273,22 @@ __intel_pmu_pebs_event(struct perf_event *event,
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		/*
-		 * Now, auto-reload is only enabled in fixed period mode.
-		 * The reload value is always hwc->sample_period.
-		 * May need to change it, if auto-reload is enabled in
-		 * freq mode later.
-		 */
-		intel_pmu_save_and_restart_reload(event, count);
+		if (event->hw.flags & PERF_X86_EVENT_PEBS_CNTR) {
+			/*
+			 * The value of each sample has been updated when setup
+			 * the corresponding sample data. But there may be a small
+			 * gap between the last overflow and the drain_pebs().
+			 */
+			intel_pmu_save_and_restart_reload(event, 0);
+		} else {
+			/*
+			 * Now, auto-reload is only enabled in fixed period mode.
+			 * The reload value is always hwc->sample_period.
+			 * May need to change it, if auto-reload is enabled in
+			 * freq mode later.
+			 */
+			intel_pmu_save_and_restart_reload(event, count);
+		}
 	} else
 		intel_pmu_save_and_restart(event);
 }
@@ -2485,6 +2579,10 @@ void __init intel_ds_init(void)
 			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
+		case 6:
+			if (x86_pmu.intel_cap.pebs_baseline)
+				x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
+			fallthrough;
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
@@ -2509,7 +2607,7 @@ void __init intel_ds_init(void)
 					  PERF_SAMPLE_REGS_USER |
 					  PERF_SAMPLE_REGS_INTR);
 			}
-			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
+			pr_cont("PEBS fmt%d%c%s, ", format, pebs_type, pebs_qual);
 
 			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7f0544fe2444..51d934d49585 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1132,6 +1132,7 @@ extern u64 __read_mostly hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_RESULT_MAX];
 
 u64 x86_perf_event_update(struct perf_event *event, u64 *cntr);
+DECLARE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 
 static inline unsigned int x86_pmu_config_addr(int index)
 {
@@ -1603,6 +1604,8 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
+void intel_pmu_pebs_update_cfg(struct cpu_hw_events *cpuc, int n, int *assign);
+
 void intel_pmu_auto_reload_read(struct perf_event *event);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 6c977c19f2cd..1d9e385649b5 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -9,7 +9,7 @@ PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
 PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
 PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
 PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
-			/*	0x00080	*/
+PERF_ARCH(PEBS_CNTR,		0x00080) /* PEBS counters snapshot */
 PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
 PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
 PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8b02df9a2eb2..6465cee82c9f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -140,6 +140,12 @@
 #define PEBS_DATACFG_XMMS	BIT_ULL(2)
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_LBR_SHIFT	24
+#define PEBS_DATACFG_CNTR	BIT_ULL(4)
+#define PEBS_DATACFG_CNTR_SHIFT	32
+#define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
+#define PEBS_DATACFG_FIX_SHIFT	48
+#define PEBS_DATACFG_FIX_MASK	GENMASK_ULL(7, 0)
+#define PEBS_DATACFG_METRICS	BIT_ULL(5)
 
 /* Steal the highest bit of pebs_data_cfg for SW usage */
 #define PEBS_UPDATE_DS_SW	BIT_ULL(63)
@@ -444,6 +450,15 @@ struct pebs_xmm {
 	u64 xmm[16*2];	/* two entries for each register */
 };
 
+struct pebs_cntr_header {
+	u32 cntr;
+	u32 fixed;
+	u32 metrics;
+	u32 reserved;
+};
+
+#define INTEL_CNTR_METRICS		0x3
+
 /*
  * AMD Extended Performance Monitoring and Debug cpuid feature detection
  */
-- 
2.35.1


