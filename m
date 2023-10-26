Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02E47D7980
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjJZAcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZAcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653CDC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0631f977bso265777276.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280336; x=1698885136; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRNjnd043JX8hEJW/fd0FSKwagFVS2vRzvj93RBhBno=;
        b=xliPRyHego/1H3qi7kdGpYluFFzRtmrfSX0bvrqUt9qjeBX8CQD8m9GXOLxyCySCLx
         0FWOYpvrcnkRbraFjayoktmWovc3wXPv9FLzhy2XsPB5/UD/4Jdgc6dg6x7/tJj/1cMk
         /AyhqYT8KqDyNS8AACxahlagv8ECSx9xJoav4i+QG6HnjHkf+32MN0hE2W3zD07KEBJ/
         nieIE55Z0Q6nVZu0KEDBTvgOB0AAvGFBu5iqX4f+dq9G5MVVX2qJhn78twB1dwtUr/rV
         ILY0eYymFBomRtHFzJG0hIJdHrOxy6nqM7NGByM11bSnRPUtbeVDgyk4e18+Q6tK6cWx
         Y/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280336; x=1698885136;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRNjnd043JX8hEJW/fd0FSKwagFVS2vRzvj93RBhBno=;
        b=U1s6e5Feil0G31RHV3Yieuf2vpBBxzQTCov1FgFMxCvGmvyJW/++D8GrU+POrPHwkF
         JEs/WFTIKHJLjZCdQ2MvZKSiGUgS67cZnRJ5DE7IVS9hRzKDBIxmjaSwmoS93xNpxp22
         yKuA8Qyw3dkOIack3HzRFTU+X4sySwo2DOdipDaIehPAaUQLA/I3ebQCLumKQUNluFgC
         X0Apz2EnIf1Buzj8981zji5wzncHcMOVaCQ3hhlISJ58KS/tcvsAfY9e6E33f771myYl
         jWNokM5XgbHiIQfL4Xyr7bEVO7g2kbng/VITgo0g/rtA5DFByG6DlLHaxE3qVMq4xzy5
         WS+A==
X-Gm-Message-State: AOJu0YwWJtY1uz0C7tOPXKGsDOcXDZhLImNOVUJbueK+9kYK9uZv+WXv
        OGVntq373Hrx5BM8+FJOTtxdTSOWrgIl
X-Google-Smtp-Source: AGHT+IHdFvzvzGp8S7xbt7mVgfuKYe/8E9cAUa5+H17naIXB7ORUY6aOqJaZqtKJrQsYNEnM2BIGCK7nJxF/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:d601:0:b0:d9b:e3f6:c8c6 with SMTP id
 n1-20020a25d601000000b00d9be3f6c8c6mr347486ybg.4.1698280336606; Wed, 25 Oct
 2023 17:32:16 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:41 -0700
Message-Id: <20231026003149.3287633-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 1/9] perf vendor events intel: Update alderlake/alderlake
 events to v1.23
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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

Update alderlake and alderlaken events from v1.21 to v1.23 adding the
changes from:
https://github.com/intel/perfmon/commit/8df4db9433a2aab59dbbac1a70281032d1a=
f7734
https://github.com/intel/perfmon/commit/846bd247c6e04acc572ca56c992e9e65852=
bbe63

The tsx_cycles_per_elision metric is updated from PR:
https://github.com/intel/perfmon/pull/116

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       |  2 +-
 .../arch/x86/alderlake/frontend.json          | 42 ++++++++++--
 .../pmu-events/arch/x86/alderlake/memory.json |  4 +-
 .../arch/x86/alderlake/pipeline.json          | 20 +++++-
 .../x86/alderlake/uncore-interconnect.json    |  2 +
 .../arch/x86/alderlaken/memory.json           |  4 +-
 .../arch/x86/alderlaken/pipeline.json         | 16 +++++
 .../x86/alderlaken/uncore-interconnect.json   | 66 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  4 +-
 9 files changed, 146 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 8b6bed3bc766..3388b58b8f1a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -99,7 +99,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided=
 by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) e=
lse 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) e=
lse 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index 81349100fe32..542ba4a81996 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -394,31 +394,61 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
+        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE=
]",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CORE",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
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
+    {
+        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled [This event is alias to IDQ_BUBBLES.CORE]",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
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
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 73d92d5c9f9d..23d36164433f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -248,7 +248,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -278,7 +278,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index a92013cdf136..f9876bef16da 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -238,6 +238,15 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc0",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken branch instructions retired.",
         "EventCode": "0xc4",
@@ -411,6 +420,15 @@
         "UMask": "0x7e",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
         "EventCode": "0xc5",
@@ -842,7 +860,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
index 34fc052d00e4..8bf020a9dfa8 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
@@ -25,6 +25,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "Deprecated": "1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_DAT_REQUESTS.RD",
         "PerPkg": "1",
@@ -33,6 +34,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_OCCUPANCY.ALL",
+        "Deprecated": "1",
         "EventCode": "0x85",
         "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/=
perf/pmu-events/arch/x86/alderlaken/memory.json
index 37259d38a222..863a3ba2b4b2 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
@@ -59,7 +59,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -77,7 +77,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index fa53ff11a509..3153bab527a9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -90,6 +90,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc0"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT",
         "Deprecated": "1",
@@ -183,6 +191,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT",
         "Deprecated": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
index 4af695a5e755..8bf020a9dfa8 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
@@ -7,6 +7,56 @@
         "UMask": "0x1",
         "Unit": "ARB"
     },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "Deprecated": "1",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_OCCUPANCY.ALL",
+        "Deprecated": "1",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_T=
RK_OCCUPANCY.RD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
     {
         "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
         "EventCode": "0x80",
@@ -15,6 +65,14 @@
         "UMask": "0x1",
         "Unit": "ARB"
     },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_R=
EQ_TRK_OCCUPANCY.DRD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
     {
         "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC.",
         "EventCode": "0x81",
@@ -22,5 +80,13 @@
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD=
]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 57ba7e814563..c09b81d8d5e1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.21,alderlake,core
-GenuineIntel-6-BE,v1.21,alderlaken,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.23,alderlake,core
+GenuineIntel-6-BE,v1.23,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v28,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
--=20
2.42.0.758.gaed0368e0e-goog

