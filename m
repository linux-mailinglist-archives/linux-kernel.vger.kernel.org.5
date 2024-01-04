Return-Path: <linux-kernel+bounces-16327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629F823CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD241F2548C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121A200C0;
	Thu,  4 Jan 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm8RxCbb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453671F613
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ecfd153ccfso4848217b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704354210; x=1704959010; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwbou5X5NyQdoxnUE3iUXmkSStdOyAVMt2PfwDEEFP8=;
        b=Dm8RxCbbXpIGVLqdIwgMIyAsstlad7ICdEPJ3HTa7aN8E9YACsIYJ5SurSmJXuHMgj
         qGunpevK3LFn+iSYRgPZrL4Lk6Zydsyo0su6xDY2ltAyKbkmnan8UnhVkE0eDDDdK5YW
         XP8x3Lhsc1H+2JSYaF6JdgXoNltGwJ8eRAZeSGKbtOtmbj9TpWFE8QmDY9rU4mfEHksL
         KP/xbcbQUldDEeTicvlVGLDX6o+z2kEAWIasEoRgesCmG35pEgnpitQnt4xao0qORRLm
         kRoCp8M9fy5c7mdM+6TgZFWWsEqyiR9WFty59RrEM7/MmcPYPhnGKEaKH385EJfDKcw6
         IEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354210; x=1704959010;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pwbou5X5NyQdoxnUE3iUXmkSStdOyAVMt2PfwDEEFP8=;
        b=C+sjiRgZFqaiHEQsTcq1vLWsyI6NI1ewzZYym+U4r+QZZezCDZl6GZDof4S8pYk26I
         /TW7PbYBN0I8yt1jY+D7OtxLZncIfwymF/SybBQ3kymkUC4sU/QzyFBd0LXHnt4ChXfH
         sGhf36MNKBgPKkKXGE9dWBHRYPgaZ8zDR/DKUuY9W5ra+2XR0duGbRh5652ygjKwyJfJ
         OEg4dJ8al4+MZp5eixIq6qka65heOBjsuizWnFEFhC11Fkxdzbzs+L4y0zAmWtiECVJM
         9qFROEnl5dx5vpUV8Sxy0zF6naG6JqrAwL0FLEJoEdWfNznk8UY9Y/hf/8VhLVmJmZCe
         OJgw==
X-Gm-Message-State: AOJu0YwQds0lkxzlNMDco4hmpxrpE0iRTgy2/XUJ8msIZNTgyxnGLf8M
	4QJejEkQpbIenJPTX8HglTKPco87Npb/MdWZT7M=
X-Google-Smtp-Source: AGHT+IE/WNDM7tqvvJ8mKXKXrbmUCdOPso32Lt/kCCvD16VbQEQHhVoZZUKkobHRTttvjYt18v1tj8QGTquD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f607:7105:a86e:433f])
 (user=irogers job=sendgmr) by 2002:a05:690c:3383:b0:5d3:e848:918b with SMTP
 id fl3-20020a05690c338300b005d3e848918bmr135464ywb.4.1704354210140; Wed, 03
 Jan 2024 23:43:30 -0800 (PST)
Date: Wed,  3 Jan 2024 23:42:57 -0800
In-Reply-To: <20240104074259.653219-1-irogers@google.com>
Message-Id: <20240104074259.653219-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104074259.653219-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 2/4] perf vendor events intel: Update emeraldrapids events
 to v1.02
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update to v1.02 released in:
https://github.com/intel/perfmon/pull/123

Removes events AMX_OPS_RETIRED.BF16 and AMX_OPS_RETIRED.INT8. Add
events FP_ARITH_DISPATCHED.V0, FP_ARITH_DISPATCHED.V1,
FP_ARITH_DISPATCHED.V2, UNC_IIO_IOMMU0.1G_HITS, UNC_IIO_IOMMU0.2M_HITS
and UNC_IIO_IOMMU0.4K_HITS. Description updates.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../x86/emeraldrapids/floating-point.json     | 27 +++++++++++++++--
 .../arch/x86/emeraldrapids/pipeline.json      | 18 +----------
 .../emeraldrapids/uncore-interconnect.json    |  8 ++---
 .../arch/x86/emeraldrapids/uncore-io.json     | 30 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 5 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
index 4a9d211e9d4f..1bdefaf96287 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
@@ -23,26 +23,47 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is ali=
as to FP_ARITH_DISPATCHED.V0]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is ali=
as to FP_ARITH_DISPATCHED.V1]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is ali=
as to FP_ARITH_DISPATCHED.V2]",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_0]",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_1]",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_5]",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V2",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
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
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
index 6dcf3b763af4..1f8200fb8964 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
@@ -1,20 +1,4 @@
 [
-    {
-        "BriefDescription": "AMX retired arithmetic BF16 operations.",
-        "EventCode": "0xce",
-        "EventName": "AMX_OPS_RETIRED.BF16",
-        "PublicDescription": "Number of AMX-based retired arithmetic bfloa=
t16 (BF16) floating-point operations. Counts TDPBF16PS FP instructions. SW =
to use operation multiplier of 4",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "AMX retired arithmetic integer 8-bit operatio=
ns.",
-        "EventCode": "0xce",
-        "EventName": "AMX_OPS_RETIRED.INT8",
-        "PublicDescription": "Number of AMX-based retired arithmetic integ=
er operations of 8-bit width source operands. Counts TDPB[SS,UU,US,SU]D ins=
tructions. SW should use operation multiplier of 8.",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.DIV_ACTIVE",
         "CounterMask": "1",
@@ -505,7 +489,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.=
json
index 09d840c7da4c..65d088556bae 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json
@@ -4825,11 +4825,11 @@
         "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (AD Bouncable)",
+        "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (AD Bounceable)",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "AD Bouncable : Number of allocations into th=
e CRS Egress",
+        "PublicDescription": "AD Bounceable : Number of allocations into t=
he CRS Egress",
         "UMask": "0x1",
         "Unit": "MDF"
     },
@@ -4861,11 +4861,11 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (BL Bouncable)",
+        "BriefDescription": "Number of allocations into the CRS Egress  us=
ed to queue up requests destined to the mesh (BL Bounceable)",
         "EventCode": "0x47",
         "EventName": "UNC_MDF_CRS_TxR_INSERTS.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "BL Bouncable : Number of allocations into th=
e CRS Egress",
+        "PublicDescription": "BL Bounceable : Number of allocations into t=
he CRS Egress",
         "UMask": "0x4",
         "Unit": "MDF"
     },
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
index 557080b74ee5..0761980c34a0 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
@@ -1185,6 +1185,36 @@
         "UMask": "0x70ff010",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": ": IOTLB Hits to a 1G Page",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.1G_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x0000",
+        "PublicDescription": ": IOTLB Hits to a 1G Page : Counts if a tran=
saction to a 1G page, on its first lookup, hits the IOTLB.",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB Hits to a 2M Page",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.2M_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x0000",
+        "PublicDescription": ": IOTLB Hits to a 2M Page : Counts if a tran=
saction to a 2M page, on its first lookup, hits the IOTLB.",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB Hits to a 4K Page",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.4K_HITS",
+        "PerPkg": "1",
+        "PortMask": "0x0000",
+        "PublicDescription": ": IOTLB Hits to a 4K Page : Counts if a tran=
saction to a 4K page, on its first lookup, hits the IOTLB.",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": ": Context cache hits",
         "EventCode": "0x40",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index e571683f59f3..fd38c516c048 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.20,cascadelakex,core
 GenuineIntel-6-9[6C],v1.04,elkhartlake,core
-GenuineIntel-6-CF,v1.01,emeraldrapids,core
+GenuineIntel-6-CF,v1.02,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.00,grandridge,core
--=20
2.43.0.472.g3155946c3a-goog


