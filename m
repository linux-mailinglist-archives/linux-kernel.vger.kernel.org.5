Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455776A865
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHAFhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjHAFhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:37:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DB199E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58473c4f629so55475487b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690868211; x=1691473011;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDwbBIhhv9guUY7kz5vhWz9Ol5BMymdmzTOJH3VXtzY=;
        b=KiHT8gPWAv/Si85igoRB7An7peG/8JKQPLdnC2nBBpPeTg+Hi6yaFsuYJw0qtA5KAB
         p5l1ret51dS5nyD0GSy4YaiXdOMBK7q48gF7RotWA1XSavK4h8e+pIoIcI/61nTBDyLW
         0TsO7XluDdtfbrzsu5GEzuTWo0JTf8PN0WvUg7B9yDUIdyQMIRophltixXRfKYMfMPCt
         RW8BtxQsuvhEHcgADRis4BaT/gpJACBPa74f5c33KeEIhoMf8doUk66Sa8qJ75NFaRWM
         +QVlSNMXl3TbFWH9YG03Vmg2NzI5uO+HO93IGAYnQ8RBnS66tTEZqrLxwcMBgfxWfXXE
         6wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868211; x=1691473011;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDwbBIhhv9guUY7kz5vhWz9Ol5BMymdmzTOJH3VXtzY=;
        b=Yeey2X8tmeXP9JHS+ZxfO2XnoaJN5juDHrDHLkgQKbQN/mp4RTg20mOPfZ3IKY9v1N
         gcOwjrBUcGyfLO+1ppc0Neh3ru8EcaNPOWZu121OnS3YCFBF/cF9UA3WJmTgfdLPiSKW
         hGsjRBBIvH2+PyeR2LxnH0G9V32cYCOUHf8VuiBmjp1vMj1a3TF0oFROdm/2TMgDvvGQ
         LSKpWo4Ym8dDD5G7Pyvh8kmrkUtlhXkspOnTmlquCO/MmvtfJ2unP1Uucr3NsI/46TTe
         c84fCx5EcXxarRIYDbaq/dghDBgIc4MhP+1Rit4gDQqtxYpSgmepcqQH6hKcTQa6xG7T
         ATUA==
X-Gm-Message-State: ABy/qLbrtfNj5GjywPqLbUBiThS10YwiHV3icgBMdQUvzY91bUI0Aqmv
        SV4sm2VAs4vgheqpySrcKfiS1uj0NV+8
X-Google-Smtp-Source: APBJJlGBABYJDe0ieiW93uGmJqm/PsE3Cyn++5rBcmuJffG7xSigHTbC4cc24O1RBsmQ+ZxUBhWnRF/2UP24
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dd0a:f4b:6531:d8dc])
 (user=irogers job=sendgmr) by 2002:a81:b248:0:b0:583:491b:53d3 with SMTP id
 q69-20020a81b248000000b00583491b53d3mr102335ywh.9.1690868211254; Mon, 31 Jul
 2023 22:36:51 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:36:32 -0700
In-Reply-To: <20230801053634.1142634-1-irogers@google.com>
Message-Id: <20230801053634.1142634-3-irogers@google.com>
Mime-Version: 1.0
References: <20230801053634.1142634-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1 2/4] perf vendor events intel: Update meteorlake to 1.04
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

1.04 events were released in:
https://github.com/intel/perfmon/commit/44fe3681501f43fc515577aced8e944b187=
c8e51
Addition of 51 core events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 165 ++++++++++++++++++
 .../arch/x86/meteorlake/floating-point.json   |   8 +
 .../arch/x86/meteorlake/frontend.json         |  56 ++++++
 .../arch/x86/meteorlake/memory.json           |  80 +++++++++
 .../pmu-events/arch/x86/meteorlake/other.json |  16 ++
 .../arch/x86/meteorlake/pipeline.json         | 159 +++++++++++++++++
 7 files changed, 485 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 6650100830c4..9020d7a23c91 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -19,7 +19,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v23,ivytown,core
 GenuineIntel-6-2D,v23,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
-GenuineIntel-6-A[AC],v1.03,meteorlake,core
+GenuineIntel-6-A[AC],v1.04,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index e1ae7c92f38e..1de0200b32f6 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -36,6 +36,15 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.L2_STALLS",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Number of L1D misses that are outstanding",
         "EventCode": "0x48",
@@ -260,6 +269,15 @@
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when =
the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LO=
CK_DURATION).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "EventCode": "0x2e",
@@ -514,6 +532,17 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "PEBS": "1",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
         "Data_LA": "1",
@@ -730,6 +759,14 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired.",
         "Data_LA": "1",
@@ -977,6 +1014,15 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cacheable and Non-Cacheable code read request=
s",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
+        "PublicDescription": "Counts both cacheable and Non-Cacheable code=
 read requests.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
         "EventCode": "0x21",
@@ -995,6 +1041,89 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PublicDescription": "Counts cycles when offcore outstanding cache=
able Core Data Read transactions are present in the super queue. A transact=
ion is considered to be in the Offcore outstanding state between L2 miss an=
d transaction completion sent to requestor (SQ de-allocation). See correspo=
nding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding Code Reads tr=
ansactions in the SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 outstanding demand da=
ta read request is pending.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding demand rfo re=
ads transactions in SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
+        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Offcore outstanding Code Reads transactions i=
n the SuperQueue (SQ), queue to uncore, every cycle.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue.",
+        "CounterMask": "6",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Store Read transactions pending for off-core.=
 Highly correlated.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
+        "PublicDescription": "Counts the number of off-core outstanding re=
ad-for-ownership (RFO) store transactions every cycle. An RFO transaction i=
s considered to be in the Off-core outstanding state between L2 cache miss =
and transaction completion.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
         "EventCode": "0x2c",
@@ -1004,6 +1133,42 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to an icache miss",
         "EventCode": "0x71",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
index 616489f0974a..f66506ee37ef 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
@@ -41,6 +41,14 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.PORT_5",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
         "EventCode": "0xc7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 0f064518d1c0..8264419500a5 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -43,6 +43,14 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "DSB_FILL.FB_STALL_OT",
+        "EventCode": "0x62",
+        "EventName": "DSB_FILL.FB_STALL_OT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired ANT branches",
         "EventCode": "0xc6",
@@ -55,6 +63,30 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x1",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x11",
+        "PEBS": "1",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
         "EventCode": "0xc6",
@@ -88,6 +120,18 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L2_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x13",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
         "EventCode": "0xc6",
@@ -243,6 +287,18 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.STLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x15",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "EventCode": "0xc6",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index 67e949b4c789..2605e1d0ba9f 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -66,6 +66,15 @@
         "UMask": "0x84",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
         "CounterMask": "3",
@@ -95,6 +104,35 @@
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "MEMORY_ORDERING.MD_NUKE",
+        "EventCode": "0x09",
+        "EventName": "MEMORY_ORDERING.MD_NUKE",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of memory ordering machine =
clears due to memory renaming.",
+        "EventCode": "0x09",
+        "EventName": "MEMORY_ORDERING.MRN_NUKE",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "53",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
         "Data_LA": "1",
@@ -121,6 +159,19 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "23",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
         "Data_LA": "1",
@@ -235,5 +286,34 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where data return is pending for a Dem=
and Data Read request who miss L3 cache.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_L3_MISS_DEM=
AND_DATA_RD",
+        "PublicDescription": "Cycles with at least 1 Demand Data Read requ=
ests who miss L3 cache in the superQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where the core is waiting on at least =
6 outstanding demand data read requests known to have missed the L3 cache."=
,
+        "CounterMask": "6",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD_=
GE_6",
+        "PublicDescription": "Cycles where the core is waiting on at least=
 6 outstanding demand data read requests known to have missed the L3 cache.=
  Note that this event does not capture all elapsed cycles while the reques=
ts are outstanding - only cycles from when the requests were known to have =
missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index 2ec57f487525..f4c603599df4 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -1,4 +1,12 @@
 [
+    {
+        "BriefDescription": "ASSISTS.PAGE_FAULT",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.PAGE_FAULT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "EventCode": "0x2A,0x2B",
@@ -30,6 +38,14 @@
         "UMask": "0x7",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "RS.EMPTY_RESOURCE",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will onl=
y put the CPU into C0.1 activity state (not C0.2 activity state)",
         "EventCode": "0x75",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index eeaa7a97f71c..352c5efafc06 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -311,6 +311,16 @@
         "UMask": "0x60",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET",
+        "PEBS": "1",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
         "EventCode": "0xc5",
@@ -329,6 +339,33 @@
         "UMask": "0x48",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C01",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C02",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x70",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
         "EventName": "CPU_CLK_UNHALTED.CORE",
@@ -361,6 +398,24 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
         "EventCode": "0x3c",
@@ -602,6 +657,15 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired NOP instructions.",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.NOP",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
         "EventName": "INST_RETIRED.PREC_DIST",
@@ -611,6 +675,15 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.REP_ITERATION",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles the Backend cluster is recovering afte=
r a miss-speculation or a Store Buffer or Load Buffer drain stall.",
         "CounterMask": "1",
@@ -621,6 +694,17 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Clears speculative count",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
         "EventCode": "0xad",
@@ -630,6 +714,15 @@
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when Resource Allocation Table (RAT) e=
xternal stall is sent to Instruction Decode Queue (IDQ) for the thread",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.RAT_STALLS",
+        "PublicDescription": "This event counts the number of cycles durin=
g which Resource Allocation Table (RAT) external stall is sent to Instructi=
on Decode Queue (IDQ) for the current thread. This also includes the cycles=
 during which the Allocator is serving another thread.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
         "EventCode": "0xad",
@@ -733,6 +826,15 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
         "EventCode": "0x03",
@@ -742,6 +844,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x88",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
         "EventCode": "0x03",
@@ -751,6 +862,15 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x82",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
         "CounterMask": "1",
@@ -823,6 +943,24 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Self-modifying code (SMC) detected.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "LFENCE instructions retired",
+        "EventCode": "0xe0",
+        "EventName": "MISC2_RETIRED.LFENCE",
+        "PublicDescription": "number of LFENCE retired instructions",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
         "EventCode": "0xa2",
@@ -1260,6 +1398,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles with retired uop(s).",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.CYCLES",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
         "EventCode": "0xc2",
@@ -1306,6 +1454,17 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles without actually retired uops.",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
         "CounterMask": "10",
--=20
2.41.0.585.gd2178a4bd4-goog

