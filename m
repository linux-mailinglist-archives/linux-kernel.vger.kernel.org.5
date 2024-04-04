Return-Path: <linux-kernel+bounces-131556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726689898B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C18B1F27FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F689129E80;
	Thu,  4 Apr 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XN+BjBK4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7312883A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239660; cv=none; b=HbooRn+1sFP2AkfTO16/N6YKI5BgZajECfUqvJ3dEhJEXbOkaYl8uQRNz6nr3HUdq7k2+ft7M9D7I7G0n2yFBAuAdQ8Mn5WnUC47rpWrAGNPUhhTFb2rPlu5fc00Fd5IAzpbVwPzQVpybAk7S5U6yYOUTQLzMISkqLWOti30134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239660; c=relaxed/simple;
	bh=s4JJsoMKMgAG9ip2qjlQgIvTEYnZrRpwCUXCl6YsmN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+lyqNWHpv0hAgGMk/OcB9pmQUXy9BzNJaSsWiabhpzueCxawFmTtUlBqDXxVwewB8zlgzwckQkXbmBU9+TKk2qtRI1dDwooDlRLgkXXHldNJZ1GZNwCtCoG00DhhRW0tNjM3P7wLI4zbKu/KFkcPDzoI8oTi2Dv4W2RhAP/Jrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XN+BjBK4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239659; x=1743775659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s4JJsoMKMgAG9ip2qjlQgIvTEYnZrRpwCUXCl6YsmN4=;
  b=XN+BjBK40g4EPd8JPHe44xjiyd85rVl0Ka9W6MDlq9NoyK0tLp2LnOlU
   uDpsf8X4hzSn2oDuET/NFlH0PODboyatQaX4sflans+4i+92TaXMVrHf1
   rnTnEhIynCXsfrr8yf5sLXu4FdXYzkj6NCsoWM+tjF3NTYuXcOk5vp1ZL
   DYSfMBkKihmQkY0YgA7qzg7Jm4Bgt2kiaydWFJ6+CbAGt7BVNIUwuwF4C
   uCUNCcn4poDuY+0KmDMV2d0mrko5wAE/T3257ceL4HiYz7Aq73MGWLvJS
   QQxOuLWoY9SnpRVKtjN3tsqrgzrLKsaOVkineHlRyDD9YcaFuXXZaBLb0
   Q==;
X-CSE-ConnectionGUID: IG4iwSUuTmGlHvDlVocG5Q==
X-CSE-MsgGUID: eYv9wHQjSBC/wynkxtwtnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346494"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346494"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:38 -0700
X-CSE-ConnectionGUID: 9lnTalpfSgaohXdh+jmNKQ==
X-CSE-MsgGUID: d5KL/5dhSrWJmj+cfY6SQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258847"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:38 -0700
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
Subject: [PATCH 01/12] perf/x86/intel: Support the PEBS event mask
Date: Thu,  4 Apr 2024 07:06:26 -0700
Message-Id: <20240404140637.1232635-2-kan.liang@linux.intel.com>
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

The current perf assumes that the counters that support PEBS are
contiguous. But it's not guaranteed with the new leaf 0x23 introduced.
The counters are enumerated with a counter mask. There may be holes in
the counter mask for future platforms or in a virtualization
environment.

Store the PEBS event mask rather than the maximum number of PEBS
counters in the x86 PMU structures.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c    |  8 ++++----
 arch/x86/events/intel/ds.c      | 14 +++++++-------
 arch/x86/events/perf_event.h    |  4 ++--
 arch/x86/include/asm/intel_ds.h |  6 ++++++
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 768d1414897f..c173e35a5660 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4728,7 +4728,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 {
 	intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
 				     &pmu->intel_ctrl, (1ULL << pmu->num_counters_fixed) - 1);
-	pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+	pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 	pmu->unconstrained = (struct event_constraint)
 			     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 						0, pmu->num_counters, 0, 0);
@@ -6077,7 +6077,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 
 		pmu->num_counters = x86_pmu.num_counters;
 		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
-		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 		pmu->unconstrained = (struct event_constraint)
 				     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							0, pmu->num_counters, 0, 0);
@@ -6200,7 +6200,7 @@ __init int intel_pmu_init(void)
 	x86_pmu.events_maskl		= ebx.full;
 	x86_pmu.events_mask_len		= eax.split.mask_length;
 
-	x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
+	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(GENMASK_ULL(x86_pmu.num_counters - 1, 0));
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
 
 	/*
@@ -6829,7 +6829,7 @@ __init int intel_pmu_init(void)
 			pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
 		}
 
-		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 		pmu->unconstrained = (struct event_constraint)
 					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							   0, pmu->num_counters, 0, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 20ddfed3e721..a5d861093335 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1137,7 +1137,7 @@ void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sche
 static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
-	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
+	int max_pebs_events = hweight64(hybrid(cpuc->pmu, pebs_events_mask));
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	u64 threshold;
 	int reserved;
@@ -2157,6 +2157,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	void *base, *at, *top;
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	int max_pebs_events = hweight64(x86_pmu.pebs_events_mask);
 	int bit, i, size;
 	u64 mask;
 
@@ -2168,8 +2169,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
-	size = x86_pmu.max_pebs_events;
+	mask = x86_pmu.pebs_events_mask;
+	size = max_pebs_events;
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
 		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
 		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
@@ -2208,8 +2209,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 			pebs_status = p->status = cpuc->pebs_enabled;
 
 		bit = find_first_bit((unsigned long *)&pebs_status,
-					x86_pmu.max_pebs_events);
-		if (bit >= x86_pmu.max_pebs_events)
+					max_pebs_events);
+		if (bit >= max_pebs_events)
 			continue;
 
 		/*
@@ -2267,7 +2268,6 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
@@ -2283,7 +2283,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = ((1ULL << max_pebs_events) - 1) |
+	mask = hybrid(cpuc->pmu, pebs_events_mask) |
 	       (((1ULL << num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
 	size = INTEL_PMC_IDX_FIXED + num_counters_fixed;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fb56518356ec..047aa1c8d5c6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -684,7 +684,7 @@ struct x86_hybrid_pmu {
 	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
-	int				max_pebs_events;
+	u64				pebs_events_mask;
 	int				num_counters;
 	int				num_counters_fixed;
 	struct event_constraint		unconstrained;
@@ -852,7 +852,7 @@ struct x86_pmu {
 			pebs_ept		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
-	int		max_pebs_events;
+	u64		pebs_events_mask;
 	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 2f9eeb5c3069..d11f0f480ccb 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -9,6 +9,7 @@
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8
 #define MAX_PEBS_EVENTS		32
+#define MAX_PEBS_EVENTS_MASK	GENMASK_ULL(MAX_PEBS_EVENTS - 1, 0)
 #define MAX_FIXED_PEBS_EVENTS	16
 
 /*
@@ -35,4 +36,9 @@ struct debug_store_buffers {
 	char	pebs_buffer[PEBS_BUFFER_SIZE];
 };
 
+static inline u64 intel_pmu_pebs_mask(u64 cntr_mask)
+{
+	return MAX_PEBS_EVENTS_MASK & cntr_mask;
+}
+
 #endif
-- 
2.35.1


