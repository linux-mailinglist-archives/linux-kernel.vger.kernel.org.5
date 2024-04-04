Return-Path: <linux-kernel+bounces-131559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153889898D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E93C1C2152D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F66612AAE2;
	Thu,  4 Apr 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tczrpz60"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725A8528B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239665; cv=none; b=G+Re24PeZqlildUgbQD6Ib4ZcEKMfPu54bXjfJbERBl3Dbxfkx9CdrUi0AWYSrwxf4HV8evsebe+IEa4Gp7Gs9wM2uOhRvZgEX43cebmxVBYOfYygbBUcsLusObs0IXO4BrqUOXuo1lYSMY9go57fdcjMs1tScVITkK4iyYfewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239665; c=relaxed/simple;
	bh=iZZhp3gSWGGv8XdtodnIulSZDjyfI1Bmqq+2WYcU3Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mimLcNSHW9Z2I9z8vLsCHM8tvSWr32Kv7uaqbuZHjIa8bcBIE/0HEKowg+p/plWvDgIeQFV09WFZZlYZ9z26EquJosWDrLL57ULcQRn3oNC53B5zRxavSmb9YZaujO8jYBY9ahIhAx9kkDaY9x87foEFlW0z4qsyUDsZ7CK3Zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tczrpz60; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239663; x=1743775663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZZhp3gSWGGv8XdtodnIulSZDjyfI1Bmqq+2WYcU3Vk=;
  b=Tczrpz60ZMyFZOlvuN4/OomRsuATbDciVlbXH5zYIVqE4KO64mWYhFex
   hxfw8z90FMiUDE9bwI/AK34J7bnw8buh/Syc4nfme9rMv1QFmsFwPw98D
   5fGrqDQ5A7UqGyRIVTDJptwxQNFsnol2XY2Rd6wly223UXBwJ5EpJCbbW
   eHfrddbRmfzdw72Z71jMOx4krwA4qt/vIOAXxn2QaUOGD3o5jlmgvpx+R
   PAqdN591V/dGRWg2rleVjMk74xOMTohU3t8n35gTTk9Jh1yN5DB3y3KAV
   gLLUEBySNVoWcFWXAFAQYSNV+SI9qF9mM9vi+RSYBNbu4gw1pBFskAZPk
   Q==;
X-CSE-ConnectionGUID: 1HTgpeo3T8OnE4tgOU7kFQ==
X-CSE-MsgGUID: +75jbGvHRt2iDK7Q2MIC7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346516"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346516"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:43 -0700
X-CSE-ConnectionGUID: 7cPqzyjQS5GMIvgUo9gKyw==
X-CSE-MsgGUID: doFzRv76TSanRVF4neJOsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258876"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:42 -0700
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
Subject: [PATCH 04/12] perf/x86/intel: Support new data source for Lunar Lake
Date: Thu,  4 Apr 2024 07:06:29 -0700
Message-Id: <20240404140637.1232635-5-kan.liang@linux.intel.com>
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

A new PEBS data source format is introduced for the p-core of Lunar
Lake. The data source field is extended to 8 bits with new encodings.

A new layout is introduced into the union intel_x86_pebs_dse.
Introduce the lnl_latency_data() to parse the new format.
Enlarge the pebs_data_source[] accordingly to include new encodings.

Only the mem load and the mem store events can generate the data source.
Introduce INTEL_HYBRID_LDLAT_CONSTRAINT and
INTEL_HYBRID_STLAT_CONSTRAINT to mark them.

Add two new bits for the new cache-related data src, L2_MHB and MSC.
The L2_MHB is short for L2 Miss Handling Buffer, which is similar to
LFB (Line Fill Buffer), but to track the L2 Cache misses.
The MSC stands for the memory-side cache.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c    |  2 +
 arch/x86/events/intel/ds.c      | 88 ++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h    | 16 +++++-
 include/uapi/linux/perf_event.h |  6 ++-
 4 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 285bcfb43697..16b4efdad03e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6967,6 +6967,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ARROWLAKE:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
+		x86_pmu.pebs_latency_data = lnl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 
@@ -6984,6 +6985,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		intel_pmu_init_skt(&pmu->pmu);
 
+		intel_pmu_pebs_data_source_lnl();
 		pr_cont("Lunarlake Hybrid events, ");
 		name = "lunarlake_hybrid";
 		break;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8da1ab01d12f..36425cff1a31 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -63,6 +63,15 @@ union intel_x86_pebs_dse {
 		unsigned int mtl_fwd_blk:1;
 		unsigned int ld_reserved4:24;
 	};
+	struct {
+		unsigned int lnc_dse:8;
+		unsigned int ld_reserved5:2;
+		unsigned int lnc_stlb_miss:1;
+		unsigned int lnc_locked:1;
+		unsigned int lnc_data_blk:1;
+		unsigned int lnc_addr_blk:1;
+		unsigned int ld_reserved6:18;
+	};
 };
 
 
@@ -77,7 +86,7 @@ union intel_x86_pebs_dse {
 #define SNOOP_NONE_MISS (P(SNOOP, NONE) | P(SNOOP, MISS))
 
 /* Version for Sandy Bridge and later */
-static u64 pebs_data_source[] = {
+static u64 pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {
 	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),/* 0x00:ukn L3 */
 	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),  /* 0x01: L1 local */
 	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE), /* 0x02: LFB hit */
@@ -173,6 +182,40 @@ void __init intel_pmu_pebs_data_source_cmt(void)
 	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
 }
 
+/* Version for Lunar Lake p-core and later */
+static u64 lnc_pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {
+	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),	/* 0x00: ukn L3 */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x01: L1 hit */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x02: L1 hit */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x03: LFB/L1 Miss Handling Buffer hit */
+	0,							/* 0x04: Reserved */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x05: L2 Hit */
+	OP_LH | LEVEL(L2_MHB) | P(SNOOP, NONE),			/* 0x06: L2 Miss Handling Buffer Hit */
+	0,							/* 0x07: Reserved */
+	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),	/* 0x08: L3 Hit */
+	0,							/* 0x09: Reserved */
+	0,							/* 0x0a: Reserved */
+	0,							/* 0x0b: Reserved */
+	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOPX, FWD),	/* 0x0c: L3 Hit Snoop Fwd */
+	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0d: L3 Hit Snoop HitM */
+	0,							/* 0x0e: Reserved */
+	P(OP, LOAD) | P(LVL, MISS) | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0f: L3 Miss Snoop HitM */
+	OP_LH | LEVEL(MSC) | P(SNOOP, NONE),			/* 0x10: Memory-side Cache Hit */
+	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, NONE), /* 0x11: Local Memory Hit */
+};
+
+void __init intel_pmu_pebs_data_source_lnl(void)
+{
+	u64 *data_source;
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].pebs_data_source;
+	memcpy(data_source, lnc_pebs_data_source, sizeof(lnc_pebs_data_source));
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	__intel_pmu_pebs_data_source_cmt(data_source);
+}
+
 static u64 precise_store_data(u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -264,7 +307,7 @@ static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
 
 	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
 
-	dse &= PERF_PEBS_DATA_SOURCE_MASK;
+	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
 	val = hybrid_var(event->pmu, pebs_data_source)[dse];
 
 	pebs_set_tlb_lock(&val, tlb, lock);
@@ -300,6 +343,45 @@ u64 mtl_latency_data_small(struct perf_event *event, u64 status)
 					dse.mtl_fwd_blk);
 }
 
+u64 lnl_latency_data(struct perf_event *event, u64 status)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
+	u64 val;
+
+	if (pmu->pmu_type == hybrid_small)
+		return mtl_latency_data_small(event, status);
+
+	dse.val = status;
+
+	/* LNC core latency data */
+	val = hybrid_var(event->pmu, pebs_data_source)[status & PERF_PEBS_DATA_SOURCE_MASK];
+	if (!val)
+		val = P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
+
+	if (dse.lnc_stlb_miss)
+		val |= P(TLB, MISS) | P(TLB, L2);
+	else
+		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	if (dse.lnc_locked)
+		val |= P(LOCK, LOCKED);
+
+	if (dse.lnc_data_blk)
+		val |= P(BLK, DATA);
+	if (dse.lnc_addr_blk)
+		val |= P(BLK, ADDR);
+	if (!dse.lnc_data_blk && !dse.lnc_addr_blk)
+		val |= P(BLK, NA);
+
+	src.val = val;
+	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+		src.mem_op = P(OP, STORE);
+
+	return src.val;
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -1090,6 +1172,8 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3ff),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ee28da240d03..3a65bfbb1173 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -476,6 +476,14 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID)
 
+#define INTEL_HYBRID_LDLAT_CONSTRAINT(c, n)	\
+	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID|PERF_X86_EVENT_PEBS_LD_HSW)
+
+#define INTEL_HYBRID_STLAT_CONSTRAINT(c, n)	\
+	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID|PERF_X86_EVENT_PEBS_ST_HSW)
+
 /* Event constraint, but match on all event flags too. */
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
 	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
@@ -655,8 +663,10 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
-#define PERF_PEBS_DATA_SOURCE_MAX	0x10
+#define PERF_PEBS_DATA_SOURCE_MAX	0x100
 #define PERF_PEBS_DATA_SOURCE_MASK	(PERF_PEBS_DATA_SOURCE_MAX - 1)
+#define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
+#define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
 
 enum hybrid_cpu_type {
 	HYBRID_INTEL_NONE,
@@ -1529,6 +1539,8 @@ u64 adl_latency_data_small(struct perf_event *event, u64 status);
 
 u64 mtl_latency_data_small(struct perf_event *event, u64 status);
 
+u64 lnl_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
@@ -1650,6 +1662,8 @@ void intel_pmu_pebs_data_source_mtl(void);
 
 void intel_pmu_pebs_data_source_cmt(void);
 
+void intel_pmu_pebs_data_source_lnl(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..4842c36fdf80 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1349,12 +1349,14 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0x7 available */
+#define PERF_MEM_LVLNUM_L2_MHB	0x05 /* L2 Miss Handling Buffer */
+#define PERF_MEM_LVLNUM_MSC	0x06 /* Memory-side Cache */
+/* 0x7 available */
 #define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
+#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB / L1 Miss Handling Buffer */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
 #define PERF_MEM_LVLNUM_PMEM	0x0e /* PMEM */
 #define PERF_MEM_LVLNUM_NA	0x0f /* N/A */
-- 
2.35.1


