Return-Path: <linux-kernel+bounces-88966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5586E8DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540ED283DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4943D0C4;
	Fri,  1 Mar 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6kwWqdY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F253CF72
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319395; cv=none; b=ol4jY+ARRFoj7u/TLznzvJM6W4/C+zCIZqQSZEq2GEB8IJNU2QLcJf3xUhQhMVaMnNXuNlvcxP6v44FulAAD55e3ZSSPBYBsEMiSEHJyeWH/XVPtwUx/ub1LjFp5utvOv2iYajCwWhk/THHWNXWQ307s+v/P63HwDb2AfEaprIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319395; c=relaxed/simple;
	bh=r4ihq+erhDIJ96eTIi6uun2xGpgFyBqf/JqZ/4nXlRw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pzYvgJtKfL+j/DIBvX7UBrqQTYwngtG4i+4yXo4pN94T72tYXn496RAYTnycDTHtKdPZJkUZUh8ThoJkMlsJkTweEMnURvWcpvab+A/ZgsBRKuwkXn0wlg//6/tvfD4CRS7ukp2WRyf7hAvg19smSJwJUNutAhiXsChCPv1J2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6kwWqdY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso3612614276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319392; x=1709924192; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7yzNIE0K5lHOvKYMdHiv1H80sWzgzKkY1SnsP+lPB0=;
        b=u6kwWqdYUqf5ggYScGevoedifLvbkx3oW50/pWIIElME6tZ/SNYxTL0fQ4EsufPWqB
         MfBNXd8KpBg72OSx/Mbzy71b/frPpli2FO02pSdH27A305tTgbMCS5qwS9HphZKF+SWA
         IeB5domtpNlFof9dKUIM1gqsyMePmlYWI3AEkvu1fzba9vOd4wVeSRpfU9CXy25wFWgX
         qk6nyjoPKqsvHHZlLgBCnUh8Tkt0aCrDjj+ErcNUVxklBFqbESmIm6h62viLNxzKpZKp
         eaRkRzDyJofvOd6+tyAmVlFHqHcMoqGmNEiiHR6NReBfT0ThJZ/u7IVErKW5BiLRwjPo
         uXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319392; x=1709924192;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7yzNIE0K5lHOvKYMdHiv1H80sWzgzKkY1SnsP+lPB0=;
        b=lQqdKv9WAVCDuysNrJLzDnzABtvEehW5cjKcHHjZ7h85yeq8cO7s3skzv/GznfqyC2
         WwHTw7WLfO2UXCtd4NRrsQ45+zJmdf4Endhj+oC2Jcxnpi9ownYDk59oYUyKtUy9Qulh
         5OvvdMX6YQdKtwFdA4Za7f4ojso7VzNQhjvkTXTATrm9yaqtEPoYDZfHQZR2c2mPG24i
         hZ/fVvyFxAEXuBQ4j/QnWMFfpcIZUGExdjub9w209/vI3MqKPXeoT2BAa2U2C39MTU/M
         49cPr5Orl0wjxHtWtxTN7SCIUDx7yJhKRslzhjHRvIGhZAoebiNt0qT/my6MQ2veUpTo
         vZeg==
X-Forwarded-Encrypted: i=1; AJvYcCUwMG+0EGGJcveN/F798PFTOcIZfyhELoYib+8yQGw1U6XGKt46+AUY7els4475AZCAZwq3M5fs1b0PCuCNk3SPAEfodxTYLE6RSRzj
X-Gm-Message-State: AOJu0YwSPe3tvgSE6uUBmPfED3J2ANf9JfpocQqKEuyKs1c0KGIJj+mn
	IXcIvuZHkdGYYcDWwgPUMY2x4Rfyl5DX2AATwfCPGoDgnws+OPmlMwKWpbg8LrAzr/K9pQcF05y
	VTHiejA==
X-Google-Smtp-Source: AGHT+IG6ceWekcjgL/fYnf/VMGmCO/lnutsaDenvRqQ0JanWjuvoPrnbXWTWwuJKIYrMXYcveSJoPdoWUUGi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:2206:b0:dc2:26f6:fbc8 with SMTP
 id dm6-20020a056902220600b00dc226f6fbc8mr101587ybb.7.1709319392696; Fri, 01
 Mar 2024 10:56:32 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:47 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 08/20] perf jevents: Add ports metric group giving
 utilization on Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 6c42c8947652..49b83bc28891 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+import re
 from typing import Optional
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
@@ -18,6 +19,11 @@ directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model
 LoadEvents(directory)
 
 interval_sec = Event("duration_time")
+core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                    "CPU_CLK_UNHALTED.DISTRIBUTED",
+                    "cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -266,6 +272,28 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                   f"/arch/x86/{args.model}/pipeline.json"))
+
+  metrics = []
+  for x in pipeline_events:
+    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+      name = x["EventName"]
+      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+      if name.endswith("_CORE"):
+        cyc = core_cycles
+      else:
+        cyc = smt_cycles
+      metrics.append(Metric(port, f"{port} utilization (higher is better)",
+                            d_ratio(Event(name), cyc), "100%"))
+  if len(metrics) == 0:
+    return None
+
+  return MetricGroup("ports", metrics, "functional unit (port) utilization -- "
+                     "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
   ins = Event("instructions")
   try:
@@ -336,6 +364,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelPorts(),
     IntelSwpf(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


