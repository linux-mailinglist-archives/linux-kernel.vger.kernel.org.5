Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B047A2DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 07:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjIPFPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 01:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjIPFOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 01:14:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011C1BC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 22:14:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c4ec85ea9so6979397b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694841282; x=1695446082; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DijWxYsxp0ZMmqN/9jzMvriXmGdGGs0CqMSgli1IDx4=;
        b=UbTLVLIwo1djednm8mI0MK6L9ggpiOx0opR3/dvQcVqe+rfu9h19qICmPHnlZfRuvY
         zk68Aw3C8IV0x75S3Ap72JOkP8dzyjASdvY0cQfNMH874I7AbDpApZCwTq5ltkSYi0PQ
         uAmw8J7HeThae2FLP6kmGFnCf3fi6lMgnJNpl+kOn6icBN86LUVxD/VudKJdlgkGtBtI
         XfF6Lqx0WY5/eREsLFX8YNF3RtStEPk4xjcEW19cnr+OOZ+xz2D9pjf64y9KTpdHmOXr
         ju/FeDiXCH8lkPoTMP99YRh2ao6+y1yr8B6N1yL+naVgWv97tlZJjgIIVF0eNDEAYnIt
         RY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694841282; x=1695446082;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DijWxYsxp0ZMmqN/9jzMvriXmGdGGs0CqMSgli1IDx4=;
        b=aS3QyM9zEV6ZShfHMjOl5o9K0RvpLElRNwdMyRdO2x528+x5QA27cURVtA3D9pokEG
         N0r341lkfBJteeCSYUsd2lQG+DGNDxCt6Q03m/i95d8cBiJhqkNGIb1LjYyg+L+0YrN+
         96zXM4LJ8d6//3kzSPWNfAEKtIcOuDQVZRF/b4mqtcwx2F3bevIOQv7hFMphhG5aY4Dr
         P6EdPfd4EnvtwXtgJSq9QfXpdg0kYWJkEoPtau2yv7ltAW4hJ5gbaaW0KLYF1kuPKIHr
         xDl3+5NSLeTlEEDhiqHw4xrqtuSPztiQfBtRXmvrLyMwHZWPgFXcvnDsXtQbDlkJ4R1z
         PvCQ==
X-Gm-Message-State: AOJu0YyVjlKGLzreIowvWbzGDFxZznQ2lWPaaGKukKirUwCVBF9jbhTJ
        H5PlOCmT/LpHG6KDtYl0QfkQje9uqUxc
X-Google-Smtp-Source: AGHT+IHwDAcaG+vPypldlZ0YjslrAJdtjJ7sZmoMhdABOmf7ZNlFEeOw2qD3JjYmRgEqeGhFAQcSpj+zC/oV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:de72:1a43:1938:6165])
 (user=irogers job=sendgmr) by 2002:a81:8b49:0:b0:59b:c811:a709 with SMTP id
 e9-20020a818b49000000b0059bc811a709mr93194ywk.0.1694841282174; Fri, 15 Sep
 2023 22:14:42 -0700 (PDT)
Date:   Fri, 15 Sep 2023 22:13:10 -0700
In-Reply-To: <20230916051310.1124098-1-irogers@google.com>
Message-Id: <20230916051310.1124098-4-irogers@google.com>
Mime-Version: 1.0
References: <20230916051310.1124098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 4/4] perf vendor events intel: Update meteorlake events to v1.05
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1.05 was released in:
https://github.com/intel/perfmon/commit/405d3ee987d756b5b5d9a64d8a8fa775598=
22ecf

Update created using:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 30 ++++++++++
 .../arch/x86/meteorlake/frontend.json         | 29 ++++++++--
 .../arch/x86/meteorlake/memory.json           | 28 +++++++++
 .../pmu-events/arch/x86/meteorlake/other.json | 40 +++++++++++++
 .../arch/x86/meteorlake/pipeline.json         | 57 +++++++++++++++++++
 6 files changed, 181 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index a97f0734099a..e57fde489425 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.00,lunarlake,core
-GenuineIntel-6-A[AC],v1.04,meteorlake,core
+GenuineIntel-6-A[AC],v1.05,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 1de0200b32f6..5fef87502d4b 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -966,6 +966,16 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches, data forwarding is required as the data i=
s modified.",
         "EventCode": "0x2A,0x2B",
@@ -976,6 +986,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches which forwarded the unmodified data to the=
 requesting core.",
         "EventCode": "0x2A,0x2B",
@@ -986,6 +1006,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that resulte=
d in a snoop hit in another cores caches, data forwarding is required as th=
e data is modified.",
         "EventCode": "0x2A,0x2B",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 8264419500a5..9da8689eda81 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -460,6 +460,27 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
         "EventCode": "0x9c",
@@ -470,22 +491,22 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
         "CounterMask": "1",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index 2605e1d0ba9f..1c1a2cf8d9ac 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -66,6 +66,14 @@
         "UMask": "0x84",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "SampleAfterValue": "20003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
         "EventCode": "0xc3",
@@ -279,6 +287,26 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
         "EventCode": "0x21",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index f4c603599df4..d55e792c0c43 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -7,6 +7,46 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "EventCode": "0x2A,0x2B",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 352c5efafc06..85a92baa004a 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -217,6 +217,15 @@
         "UMask": "0x50",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
         "EventCode": "0xc5",
@@ -1045,6 +1054,14 @@
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
         "EventCode": "0x73",
@@ -1068,6 +1085,22 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC and FPC RAT stalls - which=
 can be due to the FIQ and IEC reservation station stall (integer, FP and S=
IMD scheduler not being able to accept another uop. )",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to mrbl stall.  A 'marble' refers=
 to a physical register file entry, also known as the physical destination =
(PDST).",
         "EventCode": "0x74",
@@ -1076,6 +1109,14 @@
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
         "EventCode": "0x74",
@@ -1156,6 +1197,14 @@
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend that do not categorize into any oth=
er common frontend stall",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to predecode wrong",
         "EventCode": "0x71",
@@ -1398,6 +1447,14 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of uops retired.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles with retired uop(s).",
         "CounterMask": "1",
--=20
2.42.0.459.ge4e396fd5e-goog

