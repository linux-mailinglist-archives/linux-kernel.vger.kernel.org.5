Return-Path: <linux-kernel+bounces-85901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6D86BCB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25EF1F22A18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDC556B99;
	Thu, 29 Feb 2024 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR0zNOB8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794F56B88
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165927; cv=none; b=APDdpS37ho+mMleXaKR1DiyrIQNnYMb8YXRpaOXB1gBfME7tAGMS+BlE4lSMO4EFwd62JsKF0NZGfSCpJlKXWRFN7ir+ZuxPxEX9zGibj7/j08FjFpFNf86bLBJtuEk9k0UeKEEK9LGlZj0ifNZwCqe2WS5QqPZYxXXKJAaoL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165927; c=relaxed/simple;
	bh=UjJzZnr6R5qqlP0DPOq4yMkAe+ITwoRcLwikAmtf/Vw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mflPjHg7I1dol5iy0SfrinEk29AuM1OzMjUTru4/HiSvpaOquFZIrEASZdWBsv7dPNzxC3u0GFq9338bswOM7TfUV8XvIshm8TkT85t50oKdGf4OsxbpxSo2aC2VemQdxQAoftDm/bDHgeFTmyYB62A1tG74BycrpBTUjSxu+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RR0zNOB8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60904453110so4401937b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165924; x=1709770724; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvXKnLjoS9aTofIk7NbrGOXPtcvKKSLx7CVRKwsuqGc=;
        b=RR0zNOB8QeKKDr9zT4ymzlehbUTq4Ui15grlGIksHGrCfIyyjAOYOiJOt4DcJh6ajy
         c6XTjZVtqxJrmvEs6J5P1xYa+Brie3id9EWJhH6Xan+7DjDFe6gkOz4RdPJnsXIXF+YG
         SpNn25aecQvBbZKxdv9/kbSGDYI/2mYDHzVz0a/CitmuVtZG6ZgOiRstDx9hY+7B4fzE
         2A9ufSdW2NwyB9YQyEKK0l/iJm/lOl0uQgZOEwaJrueL0U+0LkBGeL385WQw3/+WqHS3
         kc2iK5c0Kqk7Zp/d1gfLPaFRtyJFTn+Zg0XCV+J0ikkDTJK6oF7tLaMM9XrYwGo7s5i0
         Cbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165924; x=1709770724;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvXKnLjoS9aTofIk7NbrGOXPtcvKKSLx7CVRKwsuqGc=;
        b=i23guB+MTQUrGIH/1XUJnId3jNu+3QPVoiRxCRovHr4aFuDny7Si6YUSbjjGtIit8W
         hjasm19Klvb0F+3kbW0o9rd5NQ8uHfDda1X3jtd4rv9vkeqTWoRoo1OTvr2bvH7XFQt2
         1RNJPRapuHpyrMiiLmhEE7eLi70dRYAaocDP70zxygA4rG7iEdtZ+L6/w7VhzY5toVDa
         yIQzSyoU9o+QFrA//1nTthKhfpyO81OvMSGHCcb0wfpm6ca+g71Btv0YoJ96Mh5xIv05
         zb7HaAMprGALQLZZlyirw0NK5YDsnQJq5ESOXbmkLH3neTLwIuFGbRLgnkhC92l7pEJB
         7whg==
X-Forwarded-Encrypted: i=1; AJvYcCUpXj5yDoC96P44hiog6UuSs+b+7x3yzAWDxBeA2t9mJyUN4LvF1kO9DRJkD8bTkovTlRISTqJgVg7QLqriqShLFEyQkIURK6k65Ji9
X-Gm-Message-State: AOJu0Yw8Men9zjQzDg+ZoeMVCnFsBoRaJMJnk0LX0zPq5A0zt9gk88Fk
	raKsq8nou2GxX1ophHCCS1GpB4jtLEixjtfxBtIpSjL3VmBc49fb1++UZlvm3X8f1aGsdzpnxQv
	lTBrbDw==
X-Google-Smtp-Source: AGHT+IHYr6WkwPgg9sJvpDhjWJ1lpa1m4OebDRaKpMedQ9jCo9mk+RuOjnH0XKFGykdp5f9bpoPx0dL8kxKL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:a90:b0:609:185:67da with SMTP id
 ci16-20020a05690c0a9000b00609018567damr155415ywb.10.1709165924681; Wed, 28
 Feb 2024 16:18:44 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:54 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/20] perf jevents: Add load store breakdown metrics ldst
 for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 86 +++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index d22a1abca8d9..0035e2441d6b 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricGroup, MetricRef, Select)
+                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -514,6 +514,89 @@ def IntelSwpf() -> Optional[MetricGroup]:
   ], description="Sofware prefetch instruction breakdown")
 
 
+def IntelLdSt() -> Optional[MetricGroup]:
+  if args.model in [
+      "bonnell",
+      "nehalemep",
+      "nehalemex",
+      "westmereep-dp",
+      "westmereep-sp",
+      "westmereex",
+  ]:
+    return None
+  LDST_LD = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+  LDST_ST = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+  LDST_LDC1 = Event(f"{LDST_LD.name}/cmask=1/")
+  LDST_STC1 = Event(f"{LDST_ST.name}/cmask=1/")
+  LDST_LDC2 = Event(f"{LDST_LD.name}/cmask=2/")
+  LDST_STC2 = Event(f"{LDST_ST.name}/cmask=2/")
+  LDST_LDC3 = Event(f"{LDST_LD.name}/cmask=3/")
+  LDST_STC3 = Event(f"{LDST_ST.name}/cmask=3/")
+  ins = Event("instructions")
+  LDST_CYC = Event("CPU_CLK_UNHALTED.THREAD",
+                   "CPU_CLK_UNHALTED.CORE_P",
+                   "CPU_CLK_UNHALTED.THREAD_P")
+  LDST_PRE = None
+  try:
+    LDST_PRE = Event("LOAD_HIT_PREFETCH.SWPF", "LOAD_HIT_PRE.SW_PF")
+  except:
+    pass
+  LDST_AT = None
+  try:
+    LDST_AT = Event("MEM_INST_RETIRED.LOCK_LOADS")
+  except:
+    pass
+  cyc  = LDST_CYC
+
+  ld_rate = d_ratio(LDST_LD, interval_sec)
+  st_rate = d_ratio(LDST_ST, interval_sec)
+  pf_rate = d_ratio(LDST_PRE, interval_sec) if LDST_PRE else None
+  at_rate = d_ratio(LDST_AT, interval_sec) if LDST_AT else None
+
+  ldst_ret_constraint = MetricConstraint.GROUPED_EVENTS
+  if LDST_LD.name == "MEM_UOPS_RETIRED.ALL_LOADS":
+    ldst_ret_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_loads", "Load/store instructions total loads",
+                 ld_rate, "loads"),
+          Metric("ldst_total_stores", "Load/store instructions total stores",
+                 st_rate, "stores"),
+      ]),
+      MetricGroup("ldst_prcnt", [
+          Metric("ldst_prcnt_loads", "Percent of all instructions that are loads",
+                 d_ratio(LDST_LD, ins), "100%"),
+          Metric("ldst_prcnt_stores", "Percent of all instructions that are stores",
+                 d_ratio(LDST_ST, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_lds", [
+          Metric("ldst_ret_lds_1", "Retired loads in 1 cycle",
+                 d_ratio(max(LDST_LDC1 - LDST_LDC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_2", "Retired loads in 2 cycles",
+                 d_ratio(max(LDST_LDC2 - LDST_LDC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_3", "Retired loads in 3 or more cycles",
+                 d_ratio(LDST_LDC3, cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_sts", [
+          Metric("ldst_ret_sts_1", "Retired stores in 1 cycle",
+                 d_ratio(max(LDST_STC1 - LDST_STC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_2", "Retired stores in 2 cycles",
+                 d_ratio(max(LDST_STC2 - LDST_STC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_3", "Retired stores in 3 more cycles",
+                 d_ratio(LDST_STC3, cyc), "100%"),
+      ]),
+      Metric("ldst_ld_hit_swpf", "Load hit software prefetches per second",
+             pf_rate, "swpf/s") if pf_rate else None,
+      Metric("ldst_atomic_lds", "Atomic loads per second",
+             at_rate, "loads/s") if at_rate else None,
+  ], description = "Breakdown of load/store instructions")
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
@@ -521,6 +604,7 @@ all_metrics = MetricGroup("", [
     Tsx(),
     IntelBr(),
     IntelL2(),
+    IntelLdSt(),
     IntelPorts(),
     IntelSwpf(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


