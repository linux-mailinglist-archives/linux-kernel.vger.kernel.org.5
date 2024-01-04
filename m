Return-Path: <linux-kernel+bounces-16329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F7823CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31761C241F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15092032E;
	Thu,  4 Jan 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ZfAnRCH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE62030F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcd9f4396eso388238276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704354214; x=1704959014; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrARqRcEzdmT9hKY4SsQfbqr52MIo3gXN0CckjNla4U=;
        b=4ZfAnRCH2xOvaT2/VKFSGTMx6kwzrRNIb8nAfjJZRgVbtE00gquUrKuQ8soTAbm022
         PhoiGQdlBwwN6jvNyoSxmIOlhgIPBSg/CV/ZNFpnntAd69Oh0ZMa97inHY9thVH9oIkF
         fLCCUP8K4cYYXppYCpo6lkTylxB0o/qKOwffffajb/v6eH96TOCEvlb/XFAvKXZYhP2G
         bltUvat4vimbMlzPge49UkiycfQpeZKpgnV9YTgyo6JrtGDcZmwbYj8gvnxj9lNXmgtX
         088Pp4n6pqTAn52SWmo3FtbrhHEMdblCqrWwLBh9N86zYFgaBRAIaw4+HXeulfXJ2h9q
         5gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354214; x=1704959014;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrARqRcEzdmT9hKY4SsQfbqr52MIo3gXN0CckjNla4U=;
        b=sC9+s7IpbuFR5sez86fJWuU+0GUwIYX0cTDsHiDyyVxOJBF3lIHVbnlxomDwHFYq6Q
         J5nyBEsedCe8lw5r1w7qHMaE4j8YrSfJ7lRJJae2fOiBjVN9DZ3WX58R18jvNKB1m20A
         fxOnzeHq/Y5oFpN6PvFoGYvqX7kTIKV+VTdmWsnCx/1rSOsRTzmIG9V0h9DhlxNB5xkK
         /qbSEXzs33DHd5OvvrnEdPFlSVMUhuxzg0wuOfUUe2oHZ08Yc2XsVgJiVaUnuJDOBXqL
         GdYBXm1zQN3zMEin7ZGXOMmBN5zm5DZvJC7LiGB+9BpmRZsEvvh3CFFixk6KOq3nZD6V
         yxfQ==
X-Gm-Message-State: AOJu0YwIoC1PUpDibACR2xNrjrd0QEqvqeYCF8JkR+Uq6N9i7GaGpOA4
	iJZI/Lwy/IY0/zf42TZH8uwriMURW/Qv95GO+mQ=
X-Google-Smtp-Source: AGHT+IEITqazmrSJyheUy7O7abTyIkWrsUX/xegl+/80jTxZR/SW+TB1jaX48bCHr23xsw9NXQe5Yao81lue
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f607:7105:a86e:433f])
 (user=irogers job=sendgmr) by 2002:a05:6902:542:b0:dbe:9f60:c72f with SMTP id
 z2-20020a056902054200b00dbe9f60c72fmr69462ybs.4.1704354214534; Wed, 03 Jan
 2024 23:43:34 -0800 (PST)
Date: Wed,  3 Jan 2024 23:42:59 -0800
In-Reply-To: <20240104074259.653219-1-irogers@google.com>
Message-Id: <20240104074259.653219-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104074259.653219-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 4/4] perf vendor events intel: Update sapphirerapids events
 to v1.17
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

Update to v1.17 released in:
https://github.com/intel/perfmon/pull/123

Add events FP_ARITH_DISPATCHED.V0, FP_ARITH_DISPATCHED.V1,
FP_ARITH_DISPATCHED.V2, UNC_IIO_IOMMU0.1G_HITS, UNC_IIO_IOMMU0.2M_HITS
and UNC_IIO_IOMMU0.4K_HITS. Description updates.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../x86/sapphirerapids/floating-point.json    | 27 +++++++++++++++--
 .../arch/x86/sapphirerapids/pipeline.json     |  2 +-
 .../sapphirerapids/uncore-interconnect.json   |  8 ++---
 .../arch/x86/sapphirerapids/uncore-io.json    | 30 +++++++++++++++++++
 5 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index c1820eb16a19..4d1deed4437a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-8F,v1.16,sapphirerapids,core
+GenuineIntel-6-8F,v1.17,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
index 4a9d211e9d4f..1bdefaf96287 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 6dcf3b763af4..2cfe814d2015 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -505,7 +505,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconn=
ect.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnec=
t.json
index 09d840c7da4c..65d088556bae 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
index 8b5f54fed103..03596db87710 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
@@ -1249,6 +1249,36 @@
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
--=20
2.43.0.472.g3155946c3a-goog


