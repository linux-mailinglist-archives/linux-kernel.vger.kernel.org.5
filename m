Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FF78793F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbjHXUYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243545AbjHXUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:24:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064501BF5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:24:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d780a0d3cefso288653276.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692908654; x=1693513454;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8lbYzuAjiIwvbINlV0oRf1zIRCEOQDh7Iqjg5SpPgY=;
        b=M7+WolYp56Vg/KY9LX2z68OD9y5L/0RM9btrjfzFVo7XFpbruuYspec+KfFCdF2sSK
         qY1dWUCT//Ug08HZmjucmj9zRWwpBOk6P7aYT/1CVPX0/VF/fK1gEJWeEiX+UlrAZh9v
         pIZVTpFja6E0MjpGq09XEcUAqaOltObijBDoNsRWSSbA4SETc2ARV313uARkxzkFY68V
         jggH+ZS6zE/Ak+ytVziR6lYLAfcP7wnFWVaSu/rOhDL5MTO+ck6LIca88DKyRIzOqbhS
         mH5NErgFhqhlNbmcf9B/1ZLK+hkmGcgrrEs9QgsZ+HEWMKzz9jSVE4gxsHCyaD0webf9
         L1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692908654; x=1693513454;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M8lbYzuAjiIwvbINlV0oRf1zIRCEOQDh7Iqjg5SpPgY=;
        b=cr2k6YpTU3D+e8VL1RCNSQRqXnnR8xAHgYMTKgABz3H+WW7Wmo5NBTa2GMdtGjk5ln
         3D5SvjVme93kqusnQdvVzTUnnSxhqtEFiDtQB2l3kNChbMewHcuHXRzJsFB26PB2dy5X
         9gEUayHJFJHCaWpmRH7xpcvbqHnMyRBz83aqqIp4edxTnwQiC9HPeQqynaCONBY4cDcK
         IhjtaDO3zk7FyE5mUigmeAyPP7bvgJMPm9HVc1bhiHVNiJ9u2sByrbeV3sZboe0KJwgo
         5cn7yAUFoox86nzR2kLRvTKT6Chd96c5pXUKccEfuMasbFO7RsN0MR+OaDuZZOuOqv1A
         QJ1w==
X-Gm-Message-State: AOJu0YxVlT+jFkPOIZS8Y/0Acqqb8VzdYPLTG8/NOwTeuECYu6gi6BDw
        2xyMeb4jQbBvIWMhSgwVG+3GFwdY/7np
X-Google-Smtp-Source: AGHT+IFnK7buND917Pw/3R/QOor+l+1P6/ypXwI5ckdnfa36rgJvDcvL1It4/5t4xCS/WADUBs+aHtAlnsSL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a05:6902:12c6:b0:d77:bcce:eb11 with SMTP
 id j6-20020a05690212c600b00d77bcceeb11mr172282ybu.10.1692908654330; Thu, 24
 Aug 2023 13:24:14 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:24:02 -0700
In-Reply-To: <20230824202402.436107-1-irogers@google.com>
Message-Id: <20230824202402.436107-2-irogers@google.com>
Mime-Version: 1.0
References: <20230824202402.436107-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 2/2] perf vendor events intel: Fix spelling mistakes
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
        Colin Ian King <colin.i.king@gmail.com>,
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

Update perf json files with spelling fixes by Colin Ian King
<colin.i.king@gmail.com> contributed in:
https://github.com/intel/perfmon/pull/96
Fix various spelling mistakes and typos as found using codespell #96

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json        |  6 +++---
 .../arch/x86/alderlake/pipeline.json           |  2 +-
 .../arch/x86/alderlaken/adln-metrics.json      |  6 +++---
 .../x86/broadwellde/uncore-interconnect.json   | 18 +++++++++---------
 .../x86/broadwellx/uncore-interconnect.json    | 18 +++++++++---------
 .../pmu-events/arch/x86/haswell/memory.json    |  2 +-
 .../pmu-events/arch/x86/haswellx/memory.json   |  2 +-
 .../arch/x86/haswellx/uncore-interconnect.json | 18 +++++++++---------
 .../arch/x86/ivytown/uncore-interconnect.json  | 18 +++++++++---------
 .../arch/x86/jaketown/uncore-interconnect.json | 18 +++++++++---------
 .../arch/x86/nehalemep/floating-point.json     |  2 +-
 .../arch/x86/nehalemex/floating-point.json     |  2 +-
 .../arch/x86/westmereep-dp/floating-point.json |  2 +-
 .../arch/x86/westmereep-sp/floating-point.json |  2 +-
 .../arch/x86/westmereex/floating-point.json    |  2 +-
 15 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index c6780d5c456b..8b6bed3bc766 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -395,13 +395,13 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricName": "tma_info_inst_mix_ipbranch",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
         "MetricName": "tma_info_inst_mix_ipcall",
         "Unit": "cpu_atom"
@@ -726,7 +726,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
+        "BriefDescription": "Counts the number of issue slots  that result=
 in retirement slots.",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index cb5b8611064b..a92013cdf136 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -1145,7 +1145,7 @@
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index 06e67e34e1bf..c150c14ac6ed 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -328,12 +328,12 @@
         "MetricName": "tma_info_inst_mix_idiv_uop_ratio"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricName": "tma_info_inst_mix_ipbranch"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
         "MetricName": "tma_info_inst_mix_ipcall"
     },
@@ -616,7 +616,7 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
+        "BriefDescription": "Counts the number of issue slots  that result=
 in retirement slots.",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect=
.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
index 8a327e0f1441..910395977a6e 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
@@ -253,7 +253,7 @@
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -261,7 +261,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -269,7 +269,7 @@
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
@@ -277,7 +277,7 @@
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -285,7 +285,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -293,7 +293,7 @@
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
@@ -301,7 +301,7 @@
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -309,7 +309,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -317,7 +317,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
index e61a23f68899..b9fb216bee16 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
@@ -271,7 +271,7 @@
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -279,7 +279,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -287,7 +287,7 @@
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
@@ -295,7 +295,7 @@
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -303,7 +303,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -311,7 +311,7 @@
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
@@ -319,7 +319,7 @@
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -327,7 +327,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -335,7 +335,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/per=
f/pmu-events/arch/x86/haswell/memory.json
index 2fc25e22a42a..df44c28efeeb 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/pe=
rf/pmu-events/arch/x86/haswellx/memory.json
index 2d212cf59e92..d66e465ce41a 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
index 954e8198c7a5..bef1f5ef6f31 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
@@ -271,7 +271,7 @@
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -279,7 +279,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -287,7 +287,7 @@
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
@@ -295,7 +295,7 @@
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -303,7 +303,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -311,7 +311,7 @@
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
@@ -319,7 +319,7 @@
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -327,7 +327,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
@@ -335,7 +335,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index ccf451534d16..f4d11da01383 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -140,7 +140,7 @@
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -148,21 +148,21 @@
         "EventCode": "0x1",
         "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -170,21 +170,21 @@
         "EventCode": "0x2",
         "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -192,14 +192,14 @@
         "EventCode": "0x3",
         "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index 874f15ea8228..0fc907e5cf3c 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -140,7 +140,7 @@
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -148,21 +148,21 @@
         "EventCode": "0x1",
         "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -170,21 +170,21 @@
         "EventCode": "0x2",
         "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requests as well as outbound MM=
IO writes.",
         "Unit": "IRP"
     },
     {
@@ -192,14 +192,14 @@
         "EventCode": "0x3",
         "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requests as well as outbound MMIO =
writes.",
         "Unit": "IRP"
     },
     {
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requests as well as outbound=
 MMIO writes.",
         "Unit": "IRP"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b=
/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
index c03f8990fa82..196ae1d9b157 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "X87 Floating poiint assists for invalid input=
 value (Precise Event)",
+        "BriefDescription": "X87 Floating point assists for invalid input =
value (Precise Event)",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.INPUT",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json b=
/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
index c03f8990fa82..196ae1d9b157 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "X87 Floating poiint assists for invalid input=
 value (Precise Event)",
+        "BriefDescription": "X87 Floating point assists for invalid input =
value (Precise Event)",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.INPUT",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
index c03f8990fa82..196ae1d9b157 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "X87 Floating poiint assists for invalid input=
 value (Precise Event)",
+        "BriefDescription": "X87 Floating point assists for invalid input =
value (Precise Event)",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.INPUT",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
index c03f8990fa82..196ae1d9b157 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "X87 Floating poiint assists for invalid input=
 value (Precise Event)",
+        "BriefDescription": "X87 Floating point assists for invalid input =
value (Precise Event)",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.INPUT",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json =
b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
index c03f8990fa82..196ae1d9b157 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "X87 Floating poiint assists for invalid input=
 value (Precise Event)",
+        "BriefDescription": "X87 Floating point assists for invalid input =
value (Precise Event)",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.INPUT",
         "PEBS": "1",
--=20
2.42.0.rc2.253.gd59a3bf2b4-goog

