Return-Path: <linux-kernel+bounces-85878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086786BC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91651F26157
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAEF1DFF8;
	Thu, 29 Feb 2024 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMwi+yyz"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670F12E5B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165747; cv=none; b=nslTBYOeo+6hn4vIW2UbybRi6BJB/6gFZ6a0zsRC4GsqvrQktrx2WjdSyvLywnCVhNv0tTZBp5T1Q44qgdfkrIfQ8MVehPzudxIY0dK8P+mnCNE46jmtTqdsLzM7ivC4pmLNejIPmaRzvM1XMTrNSdOscc7HbVj3V+t1ayf6G/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165747; c=relaxed/simple;
	bh=RzPNAkcYFaWtPD0d/orbD+ZkcQxuwvwqzQzOuKyN1IE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bb6xmdTAEDbfctDuJJOPcP/hsiKLPM6rYbBnE/d+bweVKzbL22p4ElUQAu7jEdGOXEPdpLrVS5eKwCmuQtjP9ZXNOQLGFNgTACMV62lx8O0i7C80pNa71cZ9XBw+lxqkCRnM9nMu+Zie6iM22TfRTKZbhfZqUzjz5oDPiMeAxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMwi+yyz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607a628209eso6340677b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165745; x=1709770545; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=DMwi+yyzPIDxeLUohhLyyw3Uevex68cK35ybDsd9KNGqd5SNUEO+hP4KOObu+/rKfw
         ENWiNj3If0uSM/Uwa8D4vEqKIG8socREWoXrjYocmcqu5lcC1Oj37X1/OaDtAY2QDU1G
         4VwYHXwkdWkzcMK9CgFCiqSYSu3GGGmXC2Q7NLcd7XZ6XUG+TgZ9o8wEHWYKk0wuX5rz
         d+fEvZHCeVQ/rPbkm3TScoMWPqsvOP4ttNrLwj/40Tsn2eDO91cYQf+oGjqkZZ1FyyIq
         FxcVLi4FQqGU1f86EZ/LPi2tBMz/HXBYP71Ae2g3HP4dmJPHCdBygcllzM7cv75nFVT/
         +fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165745; x=1709770545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=Tkj8KZN01oxHc3OsT69GHqU/TXVDtC3XE2Cd1ECQyZ9F+GA2fWKTUaGJIRLBzWI/lj
         Uv7NfU4ZNJl0/uRo4eBZ6jUCEQ8bX/Hvb5YZ+9gFjm6K7ve7t+kiz6grmUaXpFOYZqoY
         1gpyLlMYGvKcA7H3m/zaXII/cc6wg3JdcvA4l+5oZYbmnSq1iIumdp9ACSrCT0KbheoA
         HU4cIbsnLVRIZ1MIzD8jVdt6c9/boLPmIwxeJ87gY8+bDT7Qd2YdQ0MaWNBskgqGRNWZ
         DeToYNSVBYvq/UB+zm2BBJe5dr7jF5SLeXWoLZFmdQszPcocXl4VuOFFsqjdDRBbih/7
         zsEA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKjxj45hC8eP5njhgKjsBH18AlMsKH4FkZt7xxE8olrAAEwipaCJWmBdhZOQRo41YhQunLGEp3tBvo52vgX3vexOqe9j64iDGq7AM
X-Gm-Message-State: AOJu0YxU5NdGYkoPTBzFrNy2Lj88ElMLoeLmGati+5br+tPcc7WBR9vR
	qHwAD20fNNXkHQlc24MSeKZ/ousHawRML85HBl4ElMlCqZWU1Q7voFb4NaiS5Q79HUIxNwINzOz
	3H8aHCw==
X-Google-Smtp-Source: AGHT+IFAGDlooaxb4JUzFOd4FVURqFLJ3cLhFWTMF7Ek4ZhqqGZ3hz7Iz/E+Wym48GXf3UUgFDjuVIILXDdJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:9a86:0:b0:608:bee6:150c with SMTP id
 r128-20020a819a86000000b00608bee6150cmr153903ywg.8.1709165745002; Wed, 28 Feb
 2024 16:15:45 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:25 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 01/13] perf jevents: Add RAPL event metric for AMD zen models
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 227f9b98c016..4016ecee6464 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,9 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 import argparse
 import json
+import math
 import os
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
@@ -16,6 +17,31 @@ LoadEvents(directory)
 
 all_metrics = MetricGroup("",[])
 
+interval_sec = Event("duration_time")
+
+def Rapl() -> MetricGroup:
+  """Processor socket power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  # Currently only energy-pkg is supported by AMD:
+  # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
+  pkg = Event("power/energy\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("cpu_power", metrics,
+                     description="Processor socket power consumption estimates")
+
+all_metrics = MetricGroup("", [
+    Rapl(),
+])
+
 if args.metricgroups:
   print(JsonEncodeMetricGroupDescriptions(all_metrics))
 else:
-- 
2.44.0.278.ge034bb2e1d-goog


