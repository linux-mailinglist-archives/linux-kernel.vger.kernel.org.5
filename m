Return-Path: <linux-kernel+bounces-102819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE987B78A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B616228646B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD114F62;
	Thu, 14 Mar 2024 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgvQmxMm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9E13FF2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395932; cv=none; b=CZTIboE4Q+QgPvd4RqM81qiurAUx4YRODdKVIwzXQ/BhjptnYtwtAX+B8wVnM6Ow7xMA/KYnxFivRghRIlFxHD3P6pc5ZvYC0mJkt3q6IAxY8iRa24+ooUFg0uGlXvctD9vWHCFM+Gd272BB0XmSspOLIdEOBGNKpf/Bh8WhD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395932; c=relaxed/simple;
	bh=ANNGBGcZ3vDgNq3zL21zrHIvWLxXdmT224ZJ8sCgbXk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iEIaXNaqcsxhfI4VAHiwvO3Kv8P+aCoeGvv6H3CSugCGfvAN0D/FGnMr/MlHJ9dFi2rGTYDQCuAgImMDqpNVM2+N3p1fOe74ZyQcFtMkBqTZ0IyPqnKLOEq3diiw/GcwXWqVostsdss4Pwsw8XHO+BRH8V0SO6If4he9eyWe8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgvQmxMm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a629e2121so11859427b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395930; x=1711000730; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEqFUQsewVgNTMEeM5wU4wFjtSmvLCXeb2V2OfeYmrA=;
        b=IgvQmxMmCCmcOuj/Cx6M8n7hVRHZ+64QVWIp1umzp4RWmVZlBKKlmNJlzOMhiLAKgU
         D2ehwpsf3jngvFbVUMYBsflj/GqFhSBes9fPwrXpRAlbs7hLwDC1qhu4CerFWh+vE+2E
         XewRJ/xPXUerSwhyoFsKT8lVDA99JORsRCNYHw939BsEaBWLURVle/CzrV0ExG1S/irc
         1vc4zWfxjPQ+mt6sKxvUBt5Gt26AyDxnxD1bb9qbpo5KSAjlCs8p6WIGa6/WMTG0Ry5z
         ohWBOMRyiyijPYl7Nk7LCbp2vJGfk8mwJPoB+ULQpjDczC7gjFnLmIEPPzbzauphBOHG
         CCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395930; x=1711000730;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEqFUQsewVgNTMEeM5wU4wFjtSmvLCXeb2V2OfeYmrA=;
        b=XmV9JZ1MAWEdE2uC3p/VMFP4IV3vTJtOeIiAvF+3CmBd18OWPGLQes1bsSuFdy9wvP
         Ehkfon6jP4VyGqmytp61v4/v58fWlvbMYE8lEd/r9a3KNx3vLPbPJWHZMMkxNo8IH6+M
         GrNijTuP4i4KOVfH+ghkbCau435oRL2w/xuLJAvpUM486XYaYbD1LqfqjGw+ElJfRcF9
         MnvJGnaJNZTCKBo6caEIeQ+HX8c888qh2aB0wENgj6Ig5Cssb8PBNrm+whQ2VbgomOKy
         HY2jPscMrpISompdzcmjVnqYgeWqscFJEIYvTLImywNm3u+Ome6mz8DVtTZ9tE0mz9VX
         dFGA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJqJVvbt8nDlc4xwQkh3Ke/5hque4wZu8THG7hnYWak8hrjy3h5BLAxBhKN7JUc/y9/MADv/d9WgDFpVUk8AauO2ibOFyTiHwlIdY
X-Gm-Message-State: AOJu0YyM7zs7OWb31jrShT++RPVv75aKUQn3kP0ImcecGbirF6j7Oudr
	UP0GprzlUS5QyeCLcYgaB8Fnq6is6suqcaSb084n/qt8acFfY+1zjxDd7B2iWO0zajW+8q+cW8r
	Djcbdfw==
X-Google-Smtp-Source: AGHT+IHT5rYavCu3O8x9OWfHu1PU/pOaCHZYG/nQxLnQ3Zyb39rA6u658fANhWXSCYfWQxXIQEfB/afY9/d3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1a45:b0:dcd:88e9:e508 with SMTP
 id cy5-20020a0569021a4500b00dcd88e9e508mr252693ybb.5.1710395930282; Wed, 13
 Mar 2024 22:58:50 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:29 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 02/12] perf jevents: Add idle metric for AMD zen models
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
index fd420466b999..e069b95d6470 100755
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
@@ -12,6 +13,16 @@ _args = None
 
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
 
@@ -55,6 +66,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


