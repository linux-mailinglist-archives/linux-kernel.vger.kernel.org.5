Return-Path: <linux-kernel+bounces-131558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEDB89898C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD41C27B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF51292E5;
	Thu,  4 Apr 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bw1RwpTM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADD12A16A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239664; cv=none; b=ZA4SPOjdVtvuhJyqDsFPRgTl4irVjI2ueI1SBjYAAa4rRYKkBhYJVBrDbot+rQbrq0MsdDNPWP6tNmD1xe/JZZhQFfGklhl3C4jbr0Cz4WyDvd/K+X61aMknhVK+hhUkHJUQVOClr3HDNJWibZro3L9mG8OL20Uc1qS3Q6tM4fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239664; c=relaxed/simple;
	bh=eSaXxz2dlBW4YqCtqkhvmG4oKTPY5QaMhQTpqp4qNZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/bnOZJYOwt/bWs0tM1aWB/cY+fLiqC0L1RVAAqS6mFKV2ck8w9qAm5W8LUsYWRLso8ErWA6odeRmp4lxS53GW2mT3LO6LQ5zifZFiTwpTXF0ngBo73cH0Fj/jaYAl7CTu8v/6PftaFxFCmSL4Tezj0+beb+0t+2aEiG2a/C/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bw1RwpTM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239662; x=1743775662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSaXxz2dlBW4YqCtqkhvmG4oKTPY5QaMhQTpqp4qNZQ=;
  b=bw1RwpTM5FXlbLTXreONfTXu6+J6U/6wwZiy59czxNV6pt5IpAuZab1m
   +QcYuv0M2FDMEOCa5FuVfxmasLchoOi6Adl2IY8x+1iSVLuVShenW5b6+
   G8S+3o6Cphe0VxTX8u6bX8igmQaVcg7ekFbxL6QjQytj7jJCr4t9OiCdJ
   kuZK5vu2NC5BoATZC3QDfA8iHVLI8ml+CQqDLDOpL91HPx2eCvY7dvHzv
   wowZBGuqACh4sR9Cxk4OxIP1E5Y6pn65D/jtxsLXbWCsqKaQDucMBJI0J
   Bn/TAZISrEBOA6IclwzsGK9YsDZcMEZC7ehOL/EFBtD6QwOtk6bgMS5TC
   Q==;
X-CSE-ConnectionGUID: xceFz8ViTI6PZsknbqTcYA==
X-CSE-MsgGUID: sCaOryNiR4a8zGg5kparRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346509"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346509"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:42 -0700
X-CSE-ConnectionGUID: rdwL5s4bQC2jKhO849o13g==
X-CSE-MsgGUID: bgiFKroDQ7SMQJ4VreYfSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258871"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:41 -0700
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
Subject: [PATCH 03/12] perf/x86: Add Lunar Lake and Arrow Lake support
Date: Thu,  4 Apr 2024 07:06:28 -0700
Message-Id: <20240404140637.1232635-4-kan.liang@linux.intel.com>
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

From PMU's perspective, Lunar Lake and Arrow Lake are similar to the
previous generation Meteor Lake. Both are hybrid platforms, with e-core
and p-core.

The key differences include:
- The e-core supports 3 new fixed counters
- The p-core supports an updated PEBS Data Source format
- More GP counters (Updated event constraint table)
- New Architectural performance monitoring V6
  (New Perfmon MSRs aliasing, umask2, eq).
- New PEBS format V6 (Counters Snapshotting group)
- New RDPMC metrics clear mode

The legacy features, the 3 new fixed counters and updated event
constraint table are enabled in this patch.

The new PEBS data source format, the architectural performance
monitoring V6, the PEBS format V6, and the new RDPMC metrics clear mode
are supported in the following patches.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 117 ++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c        |  24 ++++++
 arch/x86/events/perf_event.h      |   2 +
 arch/x86/include/asm/perf_event.h |   4 +
 4 files changed, 147 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 30374d3d7b0e..285bcfb43697 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -220,6 +220,17 @@ static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
+	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
+	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_skl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -370,6 +381,55 @@ static struct extra_reg intel_rwc_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct event_constraint intel_lnc_event_constraints[] = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BE_BOUND, 3),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_HEAVY_OPS, 4),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BR_MISPREDICT, 5),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
+
+	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x0175, 0x4),
+
+	INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff),
+	INTEL_EVENT_CONSTRAINT(0x3c, 0x3ff),
+	/*
+	 * Generally event codes < 0x90 are restricted to counters 0-3.
+	 * The 0x2E and 0x3C are exception, which has no restriction.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x01, 0x8f, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x08a3, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
+	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
+
+	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
+	/*
+	 * Generally event codes >= 0x90 are likely to have no restrictions.
+	 * The exception are defined as above.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0x3ff),
+
+	EVENT_CONSTRAINT_END
+};
+
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
@@ -5797,6 +5857,23 @@ static struct attribute *adl_hybrid_events_attrs[] = {
 	NULL,
 };
 
+EVENT_ATTR_STR_HYBRID(topdown-retiring,      td_retiring_lnl,  "event=0xc2,umask=0x02;event=0x00,umask=0x80", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-fe-bound,      td_fe_bound_lnl,  "event=0x9c,umask=0x01;event=0x00,umask=0x82", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-be-bound,      td_be_bound_lnl,  "event=0xa4,umask=0x02;event=0x00,umask=0x83", hybrid_big_small);
+
+static struct attribute *lnl_hybrid_events_attrs[] = {
+	EVENT_PTR(slots_adl),
+	EVENT_PTR(td_retiring_lnl),
+	EVENT_PTR(td_bad_spec_adl),
+	EVENT_PTR(td_fe_bound_lnl),
+	EVENT_PTR(td_be_bound_lnl),
+	EVENT_PTR(td_heavy_ops_adl),
+	EVENT_PTR(td_br_mis_adl),
+	EVENT_PTR(td_fetch_lat_adl),
+	EVENT_PTR(td_mem_bound_adl),
+	NULL
+};
+
 /* Must be in IDX order */
 EVENT_ATTR_STR_HYBRID(mem-loads,     mem_ld_adl,     "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", hybrid_big_small);
 EVENT_ATTR_STR_HYBRID(mem-stores,    mem_st_adl,     "event=0xd0,umask=0x6;event=0xcd,umask=0x2",                 hybrid_big_small);
@@ -6146,6 +6223,21 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 	intel_pmu_ref_cycles_ext();
 }
 
+static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
+{
+	intel_pmu_init_glc(pmu);
+	hybrid(pmu, event_constraints) = intel_lnc_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_lnc_pebs_event_constraints;
+	hybrid(pmu, extra_regs) = intel_rwc_extra_regs;
+}
+
+static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
+{
+	intel_pmu_init_grt(pmu);
+	hybrid(pmu, event_constraints) = intel_skt_event_constraints;
+	hybrid(pmu, extra_regs) = intel_cmt_extra_regs;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -6871,6 +6963,31 @@ __init int intel_pmu_init(void)
 		name = "meteorlake_hybrid";
 		break;
 
+	case INTEL_FAM6_LUNARLAKE_M:
+	case INTEL_FAM6_ARROWLAKE:
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		x86_pmu.get_event_constraints = mtl_get_event_constraints;
+		x86_pmu.hw_config = adl_hw_config;
+
+		td_attr = lnl_hybrid_events_attrs;
+		mem_attr = mtl_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_skt(&pmu->pmu);
+
+		pr_cont("Lunarlake Hybrid events, ");
+		name = "lunarlake_hybrid";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 38e549d2c3bc..8da1ab01d12f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1086,6 +1086,30 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_lnc_pebs_event_constraints[] = {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
+
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
+
+	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
+
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
+
+	/*
+	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
+	 * need the full constraints from the main table.
+	 */
+
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
 	struct event_constraint *pebs_constraints = hybrid(event->pmu, pebs_constraints);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f86bd1113e6a..ee28da240d03 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1559,6 +1559,8 @@ extern struct event_constraint intel_icl_pebs_event_constraints[];
 
 extern struct event_constraint intel_glc_pebs_event_constraints[];
 
+extern struct event_constraint intel_lnc_pebs_event_constraints[];
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
 void intel_pmu_pebs_add(struct perf_event *event);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 3736b8a46c04..0c8e6d585add 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -307,6 +307,10 @@ struct x86_pmu_capability {
 #define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
 #define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
 
+/* TOPDOWN_BAD_SPECULATION.ALL: fixed counter 4 (Atom only) */
+/* TOPDOWN_FE_BOUND.ALL: fixed counter 5 (Atom only) */
+/* TOPDOWN_RETIRING.ALL: fixed counter 6 (Atom only) */
+
 static inline bool use_fixed_pseudo_encoding(u64 code)
 {
 	return !(code & 0xff);
-- 
2.35.1


