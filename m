Return-Path: <linux-kernel+bounces-16328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A492E823CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C82287219
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66820305;
	Thu,  4 Jan 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxkaFWoA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A09200BD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e8d966fbc0so1965227b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704354212; x=1704959012; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/2tuLKGnXP/VBMG7KDv1Ce5GK1oOvMtuCNcueHPkkg=;
        b=QxkaFWoADocjuFBxZDc0+CVd+D8Dbj9UFF+95lfmpwGYCwuBbf8CfiMeLduKIXQFBq
         IhYQxUyWIuKymuh1BVSqL/E05y0LEMSHC7IGLb1p1v3G1e5tdY17HVqe+wMrt8aei7B3
         qmC2LBKpX9SkWBhCnD22UNBywtm+Ldf8BZhCNxZbJO8l4CRjA0pAIThgzDfhfq5XPi6k
         clf/VTEcEObL4yunztQoctwSjE9gScW9hTXWc+uM3untLFdO31Y29r2vD6cY3n2HTgcV
         L5DpqVSnvIiRkKhoNgdXvRM2KLfjuizLSAp7Gqf4+jF0LsweLsGBXVaT/4FXnZcYP2lK
         Caeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354212; x=1704959012;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2/2tuLKGnXP/VBMG7KDv1Ce5GK1oOvMtuCNcueHPkkg=;
        b=bvZxyPXRDgbhStXJn9mbgtr/5fyi2+/I34bl+X+KkUKmt8hHAshrKOMjnUM9fygQD0
         OM6uPnQKfyJS8E3mcCQ6RFo4AIU9wGuu+vAm8ED2IDXbn/5OXybX68ipxjFFEXc1Nt5b
         Atw1LgH4EZnZzqCnnE2o84KFwUFQ/WREzh2jSMxFaJR8zy3dM6xpWFW3lJehIEyccxVA
         lE6u/2CxD8PKHf6m1XvAvP4/Od74Dc6xKYpEL+Z37+u/tVsWdhOCaqVNW5OjZUiv/D0w
         9zd3nKFapWQvNWMTrRcc6xrGoris/FJcD7SfU7vXxRlmskkhYb0GhWkgKqIYggYDACHr
         KMIA==
X-Gm-Message-State: AOJu0YwCOoUo3wNzWI7dttYZrDi2gw4XtfrSAwRMLtY+ZzEGR8IEZq/V
	YU/59n0iqW3xPVcvHPTah02dFxzBmPy9odxiFoE=
X-Google-Smtp-Source: AGHT+IGTqO5dRA9KRnCdC8Au8zJHDXDGujRo5mWSvsMsUeFmpur+WJb1SoyBk0cbQvJRIufPKvvGgV7YaS+q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f607:7105:a86e:433f])
 (user=irogers job=sendgmr) by 2002:a05:690c:b1d:b0:5e6:f5a:bf71 with SMTP id
 cj29-20020a05690c0b1d00b005e60f5abf71mr41819ywb.3.1704354212358; Wed, 03 Jan
 2024 23:43:32 -0800 (PST)
Date: Wed,  3 Jan 2024 23:42:58 -0800
In-Reply-To: <20240104074259.653219-1-irogers@google.com>
Message-Id: <20240104074259.653219-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104074259.653219-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 3/4] perf vendor events intel: Update icelakex events to v1.23
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

Update to v1.23 released in:
https://github.com/intel/perfmon/pull/123

Updates to event descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/icelakex/other.json          | 2 +-
 tools/perf/pmu-events/arch/x86/icelakex/pipeline.json       | 2 +-
 .../pmu-events/arch/x86/icelakex/uncore-interconnect.json   | 6 +++---
 tools/perf/pmu-events/arch/x86/mapfile.csv                  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools/per=
f/pmu-events/arch/x86/icelakex/other.json
index 63d5faf2fc43..11810daaf150 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
@@ -19,7 +19,7 @@
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the AVX512 turbo schedule.",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
-        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server microarcht=
ecture).  This includes high current AVX 512-bit instructions.",
+        "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server microarchi=
tecture).  This includes high current AVX 512-bit instructions.",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index 176e5ef2a24a..45ee6bceba7f 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -519,7 +519,7 @@
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
         "EventCode": "0x5e",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into stravation periods (e.g. branch mispredi=
ctions or i-cache misses)",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
index f87ea3f66d1b..a066a009c511 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
@@ -38,7 +38,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "Coherent Ops : CLFlush : Counts the number o=
f coherency related operations servied by the IRP",
+        "PublicDescription": "Coherent Ops : CLFlush : Counts the number o=
f coherency related operations serviced by the IRP",
         "UMask": "0x80",
         "Unit": "IRP"
     },
@@ -65,7 +65,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "Coherent Ops : WbMtoI : Counts the number of=
 coherency related operations servied by the IRP",
+        "PublicDescription": "Coherent Ops : WbMtoI : Counts the number of=
 coherency related operations serviced by the IRP",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -454,7 +454,7 @@
         "EventCode": "0x11",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Inbound Transaction Count : Writes : Counts =
the number of Inbound transactions from the IRP to the Uncore.  This can be=
 filtered based on request type in addition to the source queue.  Note the =
special filtering equation.  We do OR-reduction on the request type.  If th=
e SOURCE bit is set, then we also do AND qualification based on the source =
portID. : Trackes only write requests.  Each write request should have a pr=
efetch, so there is no need to explicitly track these requests.  For writes=
 that are tickled and have to retry, the counter will be incremented for ea=
ch retry.",
+        "PublicDescription": "Inbound Transaction Count : Writes : Counts =
the number of Inbound transactions from the IRP to the Uncore.  This can be=
 filtered based on request type in addition to the source queue.  Note the =
special filtering equation.  We do OR-reduction on the request type.  If th=
e SOURCE bit is set, then we also do AND qualification based on the source =
portID. : Tracks only write requests.  Each write request should have a pre=
fetch, so there is no need to explicitly track these requests.  For writes =
that are tickled and have to retry, the counter will be incremented for eac=
h retry.",
         "UMask": "0x2",
         "Unit": "IRP"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index fd38c516c048..c1820eb16a19 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -15,7 +15,7 @@ GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
 GenuineIntel-6-7[DE],v1.19,icelake,core
-GenuineIntel-6-6[AC],v1.21,icelakex,core
+GenuineIntel-6-6[AC],v1.23,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
--=20
2.43.0.472.g3155946c3a-goog


