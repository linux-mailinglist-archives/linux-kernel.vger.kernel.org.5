Return-Path: <linux-kernel+bounces-85894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C48386BCAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC451F21297
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D62E40D;
	Thu, 29 Feb 2024 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUShJLpk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5D27451
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165910; cv=none; b=hlIjXIZobT3QG8vVTvFuk31PqrjLYAGxe5PlrjvJrbuHclpBST5ftUIgxGa1ihpPxnvVaHzU579FZtY4U7LN2NrHxzBIU0FkqYBg5hCutAGeCUFlX+MgiR3b8wd2NVlP4KgLMYPXY+QirRelKZzNvO38KVnvkSqoJC9nhLNQARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165910; c=relaxed/simple;
	bh=0Tn/XKuGhzhLwIG7EDYrZX1pefqdDM+We6EUBnwMtBM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WUaTUCCXp9BzKvx6ua64EiLAG0JEVmb7T+kOcLfjU6aPeEDMSPSUk2vno/Lgs+eM+lqch9qOu3Y8Yym8UzwybEWfrj2r7BftdQX4DT0yPUxtJDjUckiR5t1MKEoEv2P1/l2D7UQdkT8TtRCK0vK64wVWlB0sfCoAM0kia9n9u2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUShJLpk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so527262276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165908; x=1709770708; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBsfDPoA8IcXye4Tq39UNHv/YJB+B2Yw2JoEeA/NWlM=;
        b=ZUShJLpk5bXaVGv/VL80hXq3ScNmqcPSBo8M3Pzq0EVTXHcNQi3yQ14zS2t+nXTd3M
         Iydmv/3GZlZYMTbUwgswjrvEWkEVq83AajGQX4eEUUApQkwM76aggmjret/+evsacPKv
         72AZJudzeeoxlgyCcfrKJL56oM3CSZdFZHZhHMXsMcS3fD+f9IYTZzPm0R4vIXauYSwf
         eWcg69kac+KeklqiN1J/lm6zvigElevbYqaJknZVe278xY3dP+Y5afsTDLgz7maAPv02
         eCFuzWfHxZXBrp+oHNCnQZZfTWkZtTR1TZjCZ0FnUGd47wfuwAgimIZScYQ2uzcj56t5
         +7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165908; x=1709770708;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBsfDPoA8IcXye4Tq39UNHv/YJB+B2Yw2JoEeA/NWlM=;
        b=HfBP7GVrHbMmFMruKqkt4otKpSyRn3Zk/44nqrNtUYf9QKHBWsxdneCth8omOfsoYH
         EEnBddRyGCMaFXjuEDCuDfGbz6DEjAA25e9DcfZvCM7kkdwqcEhZBDrCFrf87umAe53w
         6woYROHAYtqp3OxTuQIfgyv8oyjB/gpIlnWmN2MqSNahJqX9PsGEEcbsIXbaOijo3whi
         WF8AbT7NXPF9M5T+3DD9RO7Ey78GJnmTJ3Ee7SzFtAkrJbB4LUTTE+G5vc09SYr+5747
         FZ7L5tR+xkxDaQn4bP/JV2VrsoPohsKGTvf4WGR2Jadv8q5fMuH7auzoR1BugLlcdocv
         6QHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvKhEbh59UK5e5F8aABSUnPX4uYXkyvZammpk7P+ds19ZA+qocWzbbnVkHnb0VGW5EeWNqD6TZeRYnavVm3CThFldi/uMw7h06e1jG
X-Gm-Message-State: AOJu0YyJIz7LtkAHjw10ytS8vS9GRChwPjkZtpRarJ0mwxsHV9nPc4um
	rBwg+c0yepRdrgscWddBBwd+bv3xqRScXtfqozyYwF2yIbMlsmksgXhXdeUNvlvn5ov9sTuwShb
	CcSHq9A==
X-Google-Smtp-Source: AGHT+IHQCQ2IXOrY2mjPgDRIoa+ccqeHDBjD+E0ML9EWXecbomV9xJUTkP0nFIRphbrfqPVpoXr2Q4jlfvdV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1207:b0:dc6:dfd9:d423 with SMTP
 id s7-20020a056902120700b00dc6dfd9d423mr42833ybu.3.1709165908591; Wed, 28 Feb
 2024 16:18:28 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:47 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 02/20] perf jevents: Add idle metric for Intel models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 5827f555005f..46866a25b166 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 import argparse
 import json
 import math
@@ -17,6 +18,16 @@ LoadEvents(directory)
 
 interval_sec = Event("duration_time")
 
+def Idle() -> Metric:
+  cyc = Event("msr/mperf/")
+  tsc = Event("msr/tsc/")
+  low = max(tsc - cyc, 0)
+  return Metric(
+      "idle",
+      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+      d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
   """Processor socket power consumption estimate.
 
@@ -52,6 +63,7 @@ def Rapl() -> MetricGroup:
 
 
 all_metrics = MetricGroup("", [
+    Idle(),
     Rapl(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


