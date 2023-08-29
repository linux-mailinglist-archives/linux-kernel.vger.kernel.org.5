Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62978BC01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjH2ASE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjH2ARs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:17:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060C592
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:17:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e4d2b7d16so57165287b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693268262; x=1693873062;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq532HfYtARdbzxsdl7+0/+JZnzRWIeDPiq9J/Gizug=;
        b=1ncRyVzFcHIs9KBgg1nr2wNY8+BNjKLe/vJt03xrTBg45242u9Uk4/S3AumYsBYZbY
         yZrUz3JzH4CfytUVxmNYgJyc9fhZAkknFqHCvvBKRQ9oOuWFskXUPJjHjN0uC34SDAVD
         SNnrgej853ojAt9OQ/aRRDoIBOaaS1sd+B5F4TK2Rq+bgxqHcYgAjoSyqmBZpEq+No4B
         GDX7XlXRqZg41BtpScw8Q3yO1FDkIjSmBjKqSS4NAa5ZM+ZpAP1i7rlyozSfrK5H/njz
         pwVFN63h5ZaEkXnEVeoXMCLLM74MD5a56VqzO1Jeo4JsrfMHBKRnZubRwtGHvV4LpJ60
         R5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693268262; x=1693873062;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tq532HfYtARdbzxsdl7+0/+JZnzRWIeDPiq9J/Gizug=;
        b=GM/bviCyG/aDLnB5j6ApAv1sCl6pCmB/3gCtIpCiVXqUXTXzjw773OaxrG9X/UPk6X
         PtOhxjitNOzpYTRj/OSg5u8x3TTx33svYBvJw1ocJd+ufWU3GvBIrr4hgIFsLe+tsuXe
         u5/T5dUtr1xSG+ciQyPecOQJvTYNAGNBA5lLmUntUgzCpTYf/86mRyI+RxmMJL7D8FQu
         raTbsTwLyWoQvio8ESIEoQTJu0MyIqIhYN5Yy96hdln/zHIwqt9OqAb8fbG2ySNH6+Ah
         sihPORKAqR8seEAPz3YAu7E3TP72BSDVNISvA7vbdtwRhhlT+yv2hv6TtvzlAFbTjKiQ
         Kfpg==
X-Gm-Message-State: AOJu0Yy6ZQJ4KKls45ztkTD2+OVhy958PdgobBPnVL0GzZWyDI0syues
        naPCkre1fkCWFYvA6DNJ9ybzsXbkwfmh
X-Google-Smtp-Source: AGHT+IEhf2YJxvwI0NaciSYyOvzNkLAN5AFWnN/Yyq2CYUAfFeV7KsPFEpQ9W9wD6ciiHo3LQToQ0khbvyhD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e38:88dc:18c:7fc5])
 (user=irogers job=sendgmr) by 2002:a0d:ec05:0:b0:57a:118a:f31 with SMTP id
 q5-20020a0dec05000000b0057a118a0f31mr839602ywn.7.1693268262304; Mon, 28 Aug
 2023 17:17:42 -0700 (PDT)
Date:   Mon, 28 Aug 2023 17:17:30 -0700
In-Reply-To: <20230829001730.1352769-1-irogers@google.com>
Message-Id: <20230829001730.1352769-3-irogers@google.com>
Mime-Version: 1.0
References: <20230829001730.1352769-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 3/3] perf vendor events intel: Fix spelling mistakes
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

This is added on top of the spelling mistakes and release number
updates in:
https://github.com/intel/perfmon/pull/98
EMR, SPR, CLX, SKX, BDX, HSX, BDW-DE, WSM-EP*, NHM-*, JKT, IVT : Release ev=
ent
updates

Some additional spelling fixes reported by Edward Baker
<edward.baker@intel.com> are added on top of this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       |  6 ++---
 .../arch/x86/alderlake/pipeline.json          |  2 +-
 .../arch/x86/alderlaken/adln-metrics.json     |  6 ++---
 .../pmu-events/arch/x86/bonnell/frontend.json |  2 +-
 .../x86/broadwellde/uncore-interconnect.json  | 18 +++++++--------
 .../x86/broadwellx/uncore-interconnect.json   | 18 +++++++--------
 .../pmu-events/arch/x86/haswell/memory.json   |  2 +-
 .../pmu-events/arch/x86/haswellx/memory.json  |  2 +-
 .../x86/haswellx/uncore-interconnect.json     | 18 +++++++--------
 .../pmu-events/arch/x86/ivybridge/cache.json  |  8 +++----
 .../arch/x86/ivybridge/frontend.json          | 18 +++++++--------
 .../pmu-events/arch/x86/ivytown/cache.json    |  4 ++--
 .../arch/x86/ivytown/uncore-interconnect.json | 20 ++++++++---------
 .../x86/jaketown/uncore-interconnect.json     | 18 +++++++--------
 tools/perf/pmu-events/arch/x86/mapfile.csv    | 22 +++++++++----------
 .../pmu-events/arch/x86/nehalemep/cache.json  |  2 +-
 .../arch/x86/nehalemep/floating-point.json    |  2 +-
 .../pmu-events/arch/x86/nehalemex/cache.json  |  2 +-
 .../arch/x86/nehalemex/floating-point.json    |  2 +-
 .../x86/westmereep-dp/floating-point.json     |  2 +-
 .../arch/x86/westmereep-sp/cache.json         |  2 +-
 .../x86/westmereep-sp/floating-point.json     |  2 +-
 .../pmu-events/arch/x86/westmereex/cache.json |  2 +-
 .../arch/x86/westmereex/floating-point.json   |  2 +-
 24 files changed, 91 insertions(+), 91 deletions(-)

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
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json b/tools/p=
erf/pmu-events/arch/x86/bonnell/frontend.json
index 8d2f4edfb597..42284c02c11d 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
@@ -63,7 +63,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Non-CISC nacro instructions decoded",
+        "BriefDescription": "Non-CISC macro instructions decoded",
         "EventCode": "0xAA",
         "EventName": "MACRO_INSTS.NON_CISC_DECODED",
         "SampleAfterValue": "2000000",
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
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json b/tools/pe=
rf/pmu-events/arch/x86/ivybridge/cache.json
index 6ddc7d1c61d5..46570b522095 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
@@ -8,16 +8,16 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability",
+        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers unavailability",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PublicDescription": "Cycles a demand request was blocked due to F=
ill Buffers inavailability.",
+        "PublicDescription": "Cycles a demand request was blocked due to F=
ill Buffers unavailability.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "L1D miss oustandings duration in cycles",
+        "BriefDescription": "L1D miss outstanding duration in cycles",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "Increments the number of outstanding L1D mis=
ses every cycle. Set Cmask =3D 1 and Edge =3D1 to count occurrences.",
@@ -506,7 +506,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Cacheable and noncachaeble code read requests=
",
+        "BriefDescription": "Cacheable and noncacheable code read requests=
",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "PublicDescription": "Demand code read requests sent to uncore.",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json b/tools=
/perf/pmu-events/arch/x86/ivybridge/frontend.json
index 89004a6c9ed1..4ee100024ca9 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
@@ -142,35 +142,35 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
-        "PublicDescription": "Cycles when uops are being delivered to Inst=
ruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "PublicDescription": "Cycles when uops are being delivered to Inst=
ruction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy.",
         "SampleAfterValue": "2000003",
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
-        "PublicDescription": "Cycles when uops initiated by Decode Stream =
Buffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mi=
crocode Sequenser (MS) is busy.",
+        "PublicDescription": "Cycles when uops initiated by Decode Stream =
Buffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mi=
crocode Sequencer (MS) is busy.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy",
+        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_OCCUR",
-        "PublicDescription": "Deliveries to Instruction Decode Queue (IDQ)=
 initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is =
busy.",
+        "PublicDescription": "Deliveries to Instruction Decode Queue (IDQ)=
 initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is =
busy.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ when MS_busy by DSB. Set Cmask =3D 1 to count cycles. Add Edge=3D1 to c=
ount # of delivery.",
@@ -178,7 +178,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ when MS_busy by MITE. Set Cmask =3D 1 to count cycles.",
@@ -196,7 +196,7 @@
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ from MS by either DSB or MITE. Set Cmask =3D 1 to count cycles.",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/cache.json b/tools/perf=
/pmu-events/arch/x86/ivytown/cache.json
index c8f7d5e66504..0e8e77253978 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
@@ -8,11 +8,11 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability",
+        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers unavailability",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PublicDescription": "Cycles a demand request was blocked due to F=
ill Buffers inavailability.",
+        "PublicDescription": "Cycles a demand request was blocked due to F=
ill Buffers unavailability.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index ccf451534d16..914d2cfb3d3d 100644
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
@@ -293,7 +293,7 @@
         "EventCode": "0xd",
         "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
+        "PublicDescription": "Accumulates the number of outstanding outbou=
nd requests from the IRP to the switch (towards the devices).  This can be =
used in conjunction with the allocations event in order to calculate averag=
e latency of outbound requests.",
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index dca2133473e3..57ba7e814563 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -3,9 +3,9 @@ GenuineIntel-6-(97|9A|B7|BA|BF),v1.21,alderlake,core
 GenuineIntel-6-BE,v1.21,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v28,broadwell,core
-GenuineIntel-6-56,v10,broadwellde,core
-GenuineIntel-6-4F,v21,broadwellx,core
-GenuineIntel-6-55-[56789ABCDEF],v1.19,cascadelakex,core
+GenuineIntel-6-56,v11,broadwellde,core
+GenuineIntel-6-4F,v22,broadwellx,core
+GenuineIntel-6-55-[56789ABCDEF],v1.20,cascadelakex,core
 GenuineIntel-6-9[6C],v1.04,elkhartlake,core
 GenuineIntel-6-CF,v1.00,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
@@ -13,28 +13,28 @@ GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.00,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
-GenuineIntel-6-3F,v27,haswellx,core
+GenuineIntel-6-3F,v28,haswellx,core
 GenuineIntel-6-7[DE],v1.19,icelake,core
 GenuineIntel-6-6[AC],v1.21,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
-GenuineIntel-6-3E,v23,ivytown,core
-GenuineIntel-6-2D,v23,jaketown,core
+GenuineIntel-6-3E,v24,ivytown,core
+GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-BD,v1.00,lunarlake,core
 GenuineIntel-6-A[AC],v1.04,meteorlake,core
-GenuineIntel-6-1[AEF],v3,nehalemep,core
-GenuineIntel-6-2E,v3,nehalemex,core
+GenuineIntel-6-1[AEF],v4,nehalemep,core
+GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.16,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
-GenuineIntel-6-55-[01234],v1.31,skylakex,core
+GenuineIntel-6-55-[01234],v1.32,skylakex,core
 GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.13,tigerlake,core
-GenuineIntel-6-2C,v4,westmereep-dp,core
-GenuineIntel-6-25,v3,westmereep-sp,core
+GenuineIntel-6-2C,v5,westmereep-dp,core
+GenuineIntel-6-25,v4,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/pe=
rf/pmu-events/arch/x86/nehalemep/cache.json
index 1a132fcda964..5113a4e059e4 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
@@ -287,7 +287,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "L2 lines alloacated",
+        "BriefDescription": "L2 lines allocated",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
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
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/pe=
rf/pmu-events/arch/x86/nehalemex/cache.json
index a4142cd2ca86..0042e53fdc78 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
@@ -287,7 +287,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "L2 lines alloacated",
+        "BriefDescription": "L2 lines allocated",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tool=
s/perf/pmu-events/arch/x86/westmereep-sp/cache.json
index e00c301640f3..d025e2c0cf1c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
@@ -182,7 +182,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "L2 lines alloacated",
+        "BriefDescription": "L2 lines allocated",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/p=
erf/pmu-events/arch/x86/westmereex/cache.json
index 6c7c52733dda..18d61d43e4c9 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
@@ -182,7 +182,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "L2 lines alloacated",
+        "BriefDescription": "L2 lines allocated",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
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

