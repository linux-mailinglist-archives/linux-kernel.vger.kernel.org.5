Return-Path: <linux-kernel+bounces-85879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F086BC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03D11F263DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E629D0C;
	Thu, 29 Feb 2024 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BLPzBn8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BE1E507
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165749; cv=none; b=uZSU4qhgx3v05ZGxxDRt9tWptjJa1EHp9YfHGgBdygKdeD4ZrBGcAenjEp5za8jMa/JCs7mkhjwqq3OdldvIbCWJd9FRfK/La9bTv1U9AQF1zrhj9ovRdtPDXkOh1uc5s43w948yd8Iq2ZlDVpg4pM8FL2b9Fj3Vf1xETY3FYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165749; c=relaxed/simple;
	bh=Dfpdo2YwplSQDWWpMc73Uzmy+I+y4UMFYX3EUMZzsvM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=q63TNhUnztdNBvMkyB9cEwqdoA2PS6SLVUKS/qjXIPSWIxT2hIg9//o/fOhGw1AfAIAr1iziS+3jmYE94jpdKutBDnvGcWdd3iZelzgI3GyjUPdhfg3kyE49rvQlJd2XYxnWKE2U/J0CCQ7tpfe6sj+fzHf8WnalaAi4ur1A2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BLPzBn8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso6397887b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165747; x=1709770547; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=1BLPzBn89W0Tdh3j9cdOTO/vJxleAcibZR2pwDCEc3w7FJEci1cEqUW4A4vaqVm0h6
         dBNXFhyhMgcGeV20wGtNfnuNdEBLENpXkQ97/sorr8IYcvKRyXj7H2Cxr+1KjpdBUABS
         NVYkXl9LlD9cAqBVkdUqbyo5pnxtwTn7cXKmuqPobO4J7DaCGUBYWxafTIWXn5GW3kAs
         J1UYAIpKs4fB73cs3y+5wy5Jyw2Q84D8RfDxX0Z575hcvliI7t20GxQVoXUHwpTbej4D
         ucyNOr/rtSYZTgZhdkjPj8FoDqcHkANMrxug3uUcz2s6QXF53S2MaKnP4viceufBmv0s
         xDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165747; x=1709770547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=EXt1H9Uv10Fszt2tTM9PTnkG7q+wouUrqSMfG9b98dnp9k7TNvIk2bC0JRrbotn5V0
         nA9roLCN5+uu6NEjVQTBt+phfIJVyZ3W+1IeHqRnKPabq0sY5RXk1X1u4S4IVACi8F9x
         K0vFQ/Fh3L3TRdiHujAQhBcvSlqWuuG977T53E4aVfdDyysjXN1sFHv7xTL9yuqIA6XE
         4cEhgtaXNNiBDep4YPSIs9Nhn7XpGfyWfGyRVHQjfzK4wPao1pjgHxg5fHZuC4ywyJdX
         Fictux6mvWQPxqCeF+NA7lxavs684LpUq5CXHkiNLbNNUyfakZmRPPjZGNiatT3akRtI
         QTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJiqbR5EckqLQQzivhzJKZctf8VQs+Mu+eXeleElYLhX4OruoZXUBbRPnaqnixOjDlQfabKFNHL9NYzjgc1KSoVFZbREckXUV0bkyx
X-Gm-Message-State: AOJu0Yx8sktYSzXRrqh3vt3U2lkyLjdIRlukkvdlCOSz+D9kODmCbsug
	ZUuFZUmJGb/X5QpQy48aCUXj0+dPujqIIeHASbBmjqOxDaZgdArJ1GnUhk867ml6s1vd18xPV+1
	P84XUVg==
X-Google-Smtp-Source: AGHT+IGZ2G5HVElLXvbFoGXcebpq9RsE79E/PZGstTBYxPQKg/pbonCsSFVPw3r4QeMKxfTeLw7P4boJe3U/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:3505:b0:609:343e:db43 with SMTP
 id fq5-20020a05690c350500b00609343edb43mr117344ywb.5.1709165747562; Wed, 28
 Feb 2024 16:15:47 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:26 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 02/13] perf jevents: Add idle metric for AMD zen models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 4016ecee6464..fd3095cb5c1d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
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
@@ -19,6 +20,16 @@ all_metrics = MetricGroup("",[])
 
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
 
@@ -39,6 +50,7 @@ def Rapl() -> MetricGroup:
                      description="Processor socket power consumption estimates")
 
 all_metrics = MetricGroup("", [
+    Idle(),
     Rapl(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


