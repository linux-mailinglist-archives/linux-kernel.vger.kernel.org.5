Return-Path: <linux-kernel+bounces-88952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BBA86E92E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE68B2F806
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF23BBF6;
	Fri,  1 Mar 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wr2U2aC9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59483BB2E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318996; cv=none; b=fdQ6MZ3xc494a6Yf5XC5dNZ+yVBBRL4azUX2r2mX6aZQd3A4LJcm7yAlSvZGvjcrdzKiIWvFc333ZhS8Le1OPj1ZYM0GqD2+/3yGiS7gAKlRZ8v1XfqfC3bhUCMOcDQ6Di7DaIlAXYBu1Kd2egQVbyiVtEs306wzcKvyB4Oo7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318996; c=relaxed/simple;
	bh=kRC2xm7uMHGebNB7a/TgeH2yuQp/mFiIM0iKAPFJjpE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JiP4+kRebyVcfu5e3FwzeO/uQ7UC7D+0c0Cm5k1rNPrwPkj1mZOVtgPZ/OIanSg3u0U2HJ3riXEtqeATpnnAS5mXSOGPtQ/m216p54yIZMQWLM/VmIqK4LCZCHLVZB8Dd8VYC4ZoT4d/JcxVPkI4KIB1UYyoicYDnuxhS5VQUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wr2U2aC9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ad239f8fso39541667b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318994; x=1709923794; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6sZaREfZSp3hmPC0ObvAD1D5+ZR7J7opouN89RfYyQ=;
        b=wr2U2aC9wuRXZguRjvyPgcxVnlP86sKVJp5IVKfB5oOzHIB8ZjNFpKVkhYnT0ATjZA
         iZqKDDI35+gbm58/NXI4zGe5yhB+mHc1rciRZ6EwTKcffV5NSY+rtE+pPywbaVb67vJU
         iXEXF6XSNK9FgOQL8Sy1g5+JaxZ//kXyPJ94GxoATTSDCfOWH9bHjieXYbAcaG1tMFHN
         x+MsRG07rWRSw60S+vVsXK+A0Wx7O6E2YicqWuqSICR9oh/DRH3sMTmV+lNaPKP0SaSt
         Fs/vKNq1WsNHJU7zyRE3pp8rn9FAXoKwf3GmWupYzhN2zctv1knEEa6PCIoEEbz3eIA0
         YDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318994; x=1709923794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6sZaREfZSp3hmPC0ObvAD1D5+ZR7J7opouN89RfYyQ=;
        b=o5O4zvx7tFGe+gK7ueT6XcxlUI0I5ZMNV9bMmnHLHWcaDufB/D5ZOOpNMAXK0wYKMr
         cTAPDMK9Vaaje3PzCzE3VSCm9PcH9uxqSZE7mxXzmrFVatiOxCJppjFOM2BmprR0QaB0
         JXWy/leIWOOxj7cwvj+tZDi5UyqNDosd6/5YAxJoTEa308YoyZM90WtU4Z7htoq5sjAw
         dTZ52AlbSWaPlR3U3THtPaikF8c3I9WfmxoI/irGwBwudXUKn7QoiqCE8p8qg4zvMh+8
         rxwt1jjhV+yO2prRW4zFwDRmI0e9nY+BRiacoSDyJkU2dgFuNdHkQ65uafxvVcmgQf+e
         mj9g==
X-Forwarded-Encrypted: i=1; AJvYcCVYmLBg76p5Vh3NJG82w+QCRp3lqytjLTR5eZcpT9GnfNszaudpEwLncDD145/MIcHccqEGTCLdpqABBo4IUwlEn3i5yXiX0DzdXPZm
X-Gm-Message-State: AOJu0YwbmKTitJzrgWeQY06cz1Jk1mcoKZSjnQzojElM93cmZC6LzXHN
	IaPihIgbHYzywHlTz/9Je2P7Zdt3ePrMgiA9i/YnfONO1u8QiEB6gTJAvOplrhfSPMVeIS2wyf3
	KNI7LmQ==
X-Google-Smtp-Source: AGHT+IF7tSFYfPgzeywyxbiOairM8kbPeJ0Gj4zz01HG1jTS6aRheUlZC7o2t0zsuDKJLa/Z3qLLDeBYZB28
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:4c05:0:b0:608:d045:6eff with SMTP id
 z5-20020a814c05000000b00608d0456effmr526031ywa.2.1709318994053; Fri, 01 Mar
 2024 10:49:54 -0800 (PST)
Date: Fri,  1 Mar 2024 10:49:42 -0800
In-Reply-To: <20240301184942.2660478-1-irogers@google.com>
Message-Id: <20240301184942.2660478-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184942.2660478-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 2/2] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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
index 377ce413d051..5a1f10ecff4d 100755
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
@@ -572,6 +573,7 @@ def AmdUpc() -> Metric:
   return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
                 upc, "uops/cycle")
 
+
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
   tsc = Event("msr/tsc/")
@@ -628,6 +630,7 @@ all_metrics = MetricGroup("", [
     AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
+    Cycles(),
     Idle(),
     Rapl(),
     UncoreL3(),
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 0dcf5236ea1f..516b3fa08600 100755
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
@@ -154,6 +155,7 @@ def Arm64Topdown() -> MetricGroup:
 
 all_metrics = MetricGroup("",[
     Arm64Topdown(),
+    Cycles(),
 ])
 
 if args.metricgroups:
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
index 5775ae8a87b4..1a34e2f7a590 100755
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
@@ -1012,6 +1013,7 @@ def UncoreUpiBw() -> Optional[MetricGroup]:
 
 
 all_metrics = MetricGroup("", [
+    Cycles(),
     Idle(),
     Rapl(),
     Smi(),
-- 
2.44.0.278.ge034bb2e1d-goog


