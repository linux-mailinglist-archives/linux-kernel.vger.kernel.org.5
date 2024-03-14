Return-Path: <linux-kernel+bounces-102814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4087B77E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AD41F219B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2D101E6;
	Thu, 14 Mar 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzM2XQqI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30FEAFA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395897; cv=none; b=SIuFie+Yw6ApDovZs6npkBSXhN7B8iBusRVJSqE3/b4Oer4nYCCtiuFa49cBFx3bxBtwWlbKoTKLI+qCoGkn3jNTQvh6AaKyZaDr7G8AYlnNijpe3q7w0RVx5xDjkE29xbetVKwN0e1NUwP4mLyV0ZRu0nBkZWLtjjdjd15BHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395897; c=relaxed/simple;
	bh=GtOcNQci7lNKa3ehQEO3xTf6nz2BWb4JsfJsdPofBto=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ovo4yNOG3oz/IRbfy2HfKeY+dfnrADlCPsLdsUgrx7Rgo0ciN/F5xk/pk/Hxj/2sVdYNSQcrihXF0OsWpeK/gnCLU0I9CrK/q+phquQjxDtStOV1P+V9BV6Qtun3n/zzsNd1NHju5UO7lO5UjcCSHEff0041uY/g+0fJlrnEbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzM2XQqI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ab69a9e6fso17026997b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395894; x=1711000694; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZVS5QWFLmTo0szmCPE3w0W/tL0dObYV4L95M/u9QHI=;
        b=GzM2XQqIcZXhcsJ290IsIaIl92hsR7nh9oOnSMvNXHar0Bb7xNDA4cJRXaMi6sBmp3
         3vmF4cqW7JdAaF8yECxIAd7JCOqgYF/HKEUii6xY8jLH0Ag0Pefa4TnyO/qJyOOsZQv2
         o/gJn6g9TbF6YXYOJuiYuRY24o/yvGTucXCjhjpnx2flyIEjYbtCgE8CrofRwJZHNppH
         Dc1+OKBANIeFZfN4YbPKbi2MAnH7smJ83x+q5McJ8XNNddIgz5bQsJrLdddJGHuBFa76
         14Qefi6X/YjWPpvsjHte9PUzXYGCpSkWI5HtyF4QhktHCbX4sSUp7qFY8t2j8osauqkt
         xBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395894; x=1711000694;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZVS5QWFLmTo0szmCPE3w0W/tL0dObYV4L95M/u9QHI=;
        b=MOw0hqsGz++kAhKdkcrM195AqQYAOwhLfM/KfurwS/dmMW6+bmqe7fVYP2YYPQTK2k
         uzJVjZmqd01vX4leD9iLvbIU5KE4VSryiwdOmhfc+SNK4rCwkx6kdbWMmlyNmsS0aB/n
         OQ1FVIIUUhcojzBp5SmetyIa8L52EQYEHqBYhCIoOTozpcCY2Jr35frvpkWnt/nryyKP
         37/sp6NajaKsgIiQtJueXJCQ5UxAQhcf365vl930NlvTPbxhuIQSaU+LclOnYxDL8Cpz
         Y4DNODvqHeuipkYmF2iB+STslgLxwMFmhK6XJFKnHvYC+dc6zeq1wCWwmn2uZZ/eS/Oe
         ddfg==
X-Forwarded-Encrypted: i=1; AJvYcCUKJrfqs8sOxK1dlxvkxRhgbrwK168JfRMYbq+WcYgKTAYRmhax2u8nVG6UVvi3MrxqnQ+/PYL3Eb01cwcyRwjEIBq5HSIXxCtEM0Oh
X-Gm-Message-State: AOJu0Yyi2kHtVhz+YGgAASJkZFmBiyYPSCKJ9FHYJicPWe4GvEkdqMFI
	cA5R56YzBsLwZKq7v1z6Xl9o7GrgfVjqKKfvDoDj//PrNQqhXgSp7FvGd4JCwFAPbdmZMvppF4m
	uJ5Ribg==
X-Google-Smtp-Source: AGHT+IFA4KbJ6mnt+zctixRr2CaatQMutKEJy44tORPbK6bAD7Yq7oUqgqHoXdQ2D4DfxBToVTBHNo6AjEYU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a0d:d80d:0:b0:60a:402:cf62 with SMTP id
 a13-20020a0dd80d000000b0060a0402cf62mr1230661ywe.4.1710395894774; Wed, 13 Mar
 2024 22:58:14 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:01 -0700
In-Reply-To: <20240314055801.1973422-1-irogers@google.com>
Message-Id: <20240314055801.1973422-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055801.1973422-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 2/2] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown cycles to user, kernel and guest. Add a common_metrics.py
file for such metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py    |  3 +++
 tools/perf/pmu-events/arm64_metrics.py  |  2 ++
 tools/perf/pmu-events/common_metrics.py | 18 ++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py  |  2 ++
 4 files changed, 25 insertions(+)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index bc70743c2f11..f14f65ccea2f 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -4,6 +4,7 @@ from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
                     Metric, MetricGroup, Select)
 import argparse
+from common_metrics import Cycles
 import json
 import math
 import os
@@ -571,6 +572,7 @@ def AmdUpc() -> Metric:
   return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
                 upc, "uops/cycle")
 
+
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
   tsc = Event("msr/tsc/")
@@ -652,6 +654,7 @@ def main() -> None:
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
+      Cycles(),
       Idle(),
       Rapl(),
       UncoreL3(),
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 53615ffa8d96..a9ef51a9112a 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -3,6 +3,7 @@
 from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
                     LoadEvents, Metric, MetricGroup)
 import argparse
+from common_metrics import Cycles
 import json
 import os
 from typing import Optional
@@ -168,6 +169,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("",[
       Arm64Topdown(),
+      Cycles(),
   ])
 
   directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
diff --git a/tools/perf/pmu-events/common_metrics.py b/tools/perf/pmu-events/common_metrics.py
new file mode 100644
index 000000000000..74c58f9ab020
--- /dev/null
+++ b/tools/perf/pmu-events/common_metrics.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (d_ratio, Event, Metric, MetricGroup)
+
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cycles:kHh")
+  cyc_g = Event("cycles:G")
+  cyc_u = Event("cycles:uH")
+  cyc = cyc_k + cyc_g + cyc_u
+
+  return MetricGroup("cycles", [
+      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
+      Metric("cycles_user", "User cycles as a percentage of all cycles",
+             d_ratio(cyc_u, cyc), "100%"),
+      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
+             d_ratio(cyc_k, cyc), "100%"),
+      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+             d_ratio(cyc_g, cyc), "100%"),
+  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 778517968b4e..f8c4eb29d4f6 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -4,6 +4,7 @@ from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
                     Metric, MetricConstraint, MetricGroup, MetricRef, Select)
 import argparse
+from common_metrics import Cycles
 import json
 import math
 import os
@@ -1027,6 +1028,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Cycles(),
       Idle(),
       Rapl(),
       Smi(),
-- 
2.44.0.278.ge034bb2e1d-goog


