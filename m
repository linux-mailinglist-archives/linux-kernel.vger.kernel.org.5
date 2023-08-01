Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893B76A866
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjHAFhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHAFhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:37:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE71FC9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d061f324d64so5526637276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690868217; x=1691473017;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbCLMGMEsNi4R0z+TbrnfgluYwXGQPMhFZKJ1X9gbTE=;
        b=ZSlB4EfKU6QY5k33ik8Xfcz+f72KWQWxz5SblXqTZSKtcW6sPGRrp6EZSRS9aoY5K4
         9c4FuX94Z8U7IhQNJlPBilYAN6y7iZih4mY9C3o0tVX8LxVdbWmBkcljyNntTyue+9Jt
         IP5hJ8yS7S8SwOG7ByQnv00LJnuVX53dKpEG5q9twtLK9N7lPaimgT8zpRQblmITeKGl
         wrQepr2ipUePDhJISyvMtzRPph++kxF/Gydw6TyefBdVDvlBzSsde8YuAbjnDFrsKiHJ
         yl08ff0wocUO79XF2y/OxFgHp43B7RwuBHx1xc3Ew2kj2nvC9t9MYDyppQDs52ShzrRR
         RvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868217; x=1691473017;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TbCLMGMEsNi4R0z+TbrnfgluYwXGQPMhFZKJ1X9gbTE=;
        b=IS31bp+OxtksJ5aN5l75O/I0Jw/V0o0nHyZknxHCdZ5Q0jPPfA4vV38O7qJVcxPKlB
         cjluK7f3jPf9X/AqWHizzA24+oFHKhDrpv6m6fmGdn1O7eDKKe5ok/cfBmmJN7SrIOYN
         WycEkI5oJnZ5QA4v5gZjk5pRIDW4gqw4IBgRpaLoIQgDGCtOC5ZdbVMyi+n8hvtQOFGE
         DXcwQNi6H8y7q9QEEYZuTKK9ha8SYW/Sg6mmIkoOXfD/g/X9PwBXlhlyFMkx83R+EYsM
         opvPlSqkgTsauiNBgDW+4FzomVgmpRW5St46AYs5b6RLnO3uvMfWaJh53/1W7Hk3FJo7
         uR6g==
X-Gm-Message-State: ABy/qLbM3N7nyo6mvc+YzizchcvJXIN0rIiPbAVZE6o0aKimx5E4y4D5
        YuxSB2ZWb9JY7tYvC7mFMhueEW4X5QvN
X-Google-Smtp-Source: APBJJlGroOR0/AOlBeGaIu9EhDMydKpkqKNMeqpXQdTH6hPo1wm8H5Be7ucSuM9adgVFHinR1DvUhm03IAui
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dd0a:f4b:6531:d8dc])
 (user=irogers job=sendgmr) by 2002:a05:6902:1582:b0:d0a:353b:b93b with SMTP
 id k2-20020a056902158200b00d0a353bb93bmr75142ybu.3.1690868216155; Mon, 31 Jul
 2023 22:36:56 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:36:34 -0700
In-Reply-To: <20230801053634.1142634-1-irogers@google.com>
Message-Id: <20230801053634.1142634-5-irogers@google.com>
Mime-Version: 1.0
References: <20230801053634.1142634-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1 4/4] perf vendor events intel: Update Icelake+ metric constraints
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid grouping events especially in cases where the kernel's PMU
driver fails to not open the events, causing the events to report back
as "<not counted>".

This update comes from:
https://github.com/intel/perfmon/pull/94

Fixes issues reported with patch:
https://lore.kernel.org/lkml/20230719001836.198363-3-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlake/adl-metrics.json    | 11 +++++++----
 .../pmu-events/arch/x86/alderlaken/adln-metrics.json  |  2 ++
 .../perf/pmu-events/arch/x86/icelake/icl-metrics.json | 10 ++++++----
 .../pmu-events/arch/x86/icelakex/icx-metrics.json     | 10 ++++++----
 .../pmu-events/arch/x86/rocketlake/rkl-metrics.json   | 10 ++++++----
 .../arch/x86/sapphirerapids/spr-metrics.json          |  9 +++++----
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json    | 10 ++++++----
 7 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index daf9458f0b77..c6780d5c456b 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -558,6 +558,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / tma_info_=
core_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS=
_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT=
@ / cpu_atom@MEM_BOUND_STALLS.LOAD@",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -800,6 +801,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
@@ -1058,7 +1060,6 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -1230,6 +1231,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -1267,6 +1269,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_dt=
lb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_=
blk))",
         "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_memory_bandwidth",
@@ -1355,7 +1358,6 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / tma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc",
@@ -1363,7 +1365,6 @@
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
@@ -1769,7 +1770,6 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire",
@@ -2002,6 +2002,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -2375,6 +2376,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
@@ -2405,6 +2407,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_t=
hread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index 0f1628d698da..06e67e34e1bf 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -466,6 +466,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_core_clks =
- max((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_core_clks=
, 0) * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -682,6 +683,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index 8fcc05c4e0a1..a6eed0d9a26d 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -85,6 +85,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
@@ -319,7 +320,6 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -464,6 +464,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -497,6 +498,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
         "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_memory_bandwidth",
@@ -574,14 +576,12 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
@@ -927,7 +927,6 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
@@ -1100,6 +1099,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -1419,6 +1419,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
@@ -1446,6 +1447,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index 9bb7e3f20f7f..7082ad5ba961 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -289,6 +289,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
@@ -523,7 +524,6 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -668,6 +668,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -701,6 +702,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_pmm_bound + tma_store_bound) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_b=
ound + tma_store_bound) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load +=
 tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk))",
         "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_memory_bandwidth",
@@ -778,14 +780,12 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
@@ -1144,7 +1144,6 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
@@ -1369,6 +1368,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -1715,6 +1715,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
@@ -1742,6 +1743,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json b/t=
ools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
index 1bb9cededa56..a0191c8b708d 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
@@ -85,6 +85,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
@@ -319,7 +320,6 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -464,6 +464,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -497,6 +498,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
         "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_memory_bandwidth",
@@ -574,14 +576,12 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
@@ -933,7 +933,6 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
@@ -1126,6 +1125,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -1445,6 +1445,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
@@ -1472,6 +1473,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index c207c851a9f9..222212abd811 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -553,7 +553,6 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector + tma_f=
p_amx",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -717,6 +716,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -750,6 +750,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_pmm_bound + tma_store_bound) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_b=
ound + tma_store_bound) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma=
_lock_latency + tma_split_loads + tma_store_fwd_blk))",
         "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_memory_bandwidth",
@@ -827,14 +828,12 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + FP_ARITH_INST_RETIRED2.SCALAR_HALF + 2 * (FP_ARITH_INST_RETIRED.=
128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF) + 4 * cpu@=
FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * (FP_ARITH_=
INST_RETIRED2.128B_PACKED_HALF + cpu@FP_ARITH_INST_RETIRED.256B_PACKED_SING=
LE\\,umask\\=3D0x60@) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_=
ARITH_INST_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_P=
ACKED_HALF + 4 * AMX_OPS_RETIRED.BF16",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
@@ -1216,7 +1215,6 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
@@ -1467,6 +1465,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -1841,6 +1840,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
@@ -1868,6 +1868,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index c7c2d6ab1a93..fab084e1bc69 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -79,6 +79,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
@@ -313,7 +314,6 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -458,6 +458,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -491,6 +492,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
         "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_memory_bandwidth",
@@ -568,14 +570,12 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
@@ -927,7 +927,6 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
@@ -1114,6 +1113,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
@@ -1433,6 +1433,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
@@ -1460,6 +1461,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
--=20
2.41.0.585.gd2178a4bd4-goog

