Return-Path: <linux-kernel+bounces-88939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B284086E8AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450652827D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B393A8EB;
	Fri,  1 Mar 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/lklG85"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF23A1CB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318873; cv=none; b=uMRuj/QSg9MByNtoOzxjQdTmndUDsf3U1nun77WoxjsW8mTTr1ke+pc4lo9csQePHN9RcF44pE3tMS0MAf/jzLkAMGBco3+OpfIzubMhy154X/T8Bg/yiaikTX9dvxnKnumRKfUi2tDhRJJnA0leonMCewiPFX5cN0jwiGs31XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318873; c=relaxed/simple;
	bh=Dfpdo2YwplSQDWWpMc73Uzmy+I+y4UMFYX3EUMZzsvM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a94qQvCl41scC26XVMImtrfoABsSAQgtBI3ElxpoK2guzL1EQ9mnACWcD6nYIl1rJXz7jlH3ZBSt3PgJjdCfq8pSIa16GIkKUNVTT0gZW8dnjSI9Me4Qwp1C0wa+MOHP2waPUQH1o/5fKd5Dk8oUG8CBazYEUcJXcuaQihCGr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/lklG85; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso4227592276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318871; x=1709923671; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=P/lklG85DrBGjnJvJCtcGNEFpzfLaJUIxPTojlYtHk25zI5/skH/M+2+Kq8KB9Uo8l
         T6XMcL5z+eQOxZKBx0DGVZ/mo8mb5awbK6fKZfqyqwgBwCL6Bb+YXLi3UsyQnmNzhn/m
         yHLH+o7v4f1G3ThXg7VqYXxAjN1x3FsYxNDOEfraHFgwKrvlN07LQ0dvHb+GFnhUPxhg
         6e1+9BzYO1l1nem147r1x996ADOvDaZSkq1KUwcmoegCYhVB0N0k6knrgWrI6dnVXKRm
         7OFUkrMc27wuQ1u9R0Fm1o5qJdwrTPlITYSaWZqcLyzDJ4mBcZWwEReBAiao2R1gvvoo
         ZXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318871; x=1709923671;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=Z1dXKT2LfG2yiw59hYz0RL5UDZcsP4FPbmN+H5JTF9rfrQlGB//UvTOYwwAf1/5/MN
         EZ9TfPIa8/aWKfEeyDeMm7B8kqfzX5c1KxQOZdu28QTkb1Veqnekt0o1kULqS96mlHny
         EoHF7EiSIvBYYdIkvWlyb062VU411XStYFpTMmdWtQ4ona7aGWV/lAyfwJF2r1Ue8WCh
         7hqR8ooYO/5+qn4jkkUQmTi9DSLBWJX2bg9W6ht3vHFwgBPEryrkFLdWSfBk0RjMBiT5
         zQdpc2fF5sQZyNtpf1GzUWl1FZs+SUC1WuNEpqvDEbXvg14jSXI4TEWJ3SB4NTNY5D12
         mItQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Q4ePzmfectBzfxxXxkTvV1nRoyTnTPNKyZtNxmaZlBAJ804kZPOzHtFgOj/zYTDc6YXX9Cbgu4mDUIA30E6EOsGpmobp0gMD0Bad
X-Gm-Message-State: AOJu0Yxxo/pnaycWeQEubaakJyeI8pkyKmbkD4MuS7ek/2QFE+nVnLde
	ISQeJRGR/dnq0bHxVT6cKl6f+8oeBiGC+JxK128R+HWz/LBv9Ou4WAT58zK9mqHvC4tAkenwLr1
	LSK2eAQ==
X-Google-Smtp-Source: AGHT+IE7swfGJwI3V9dzGAzE/TRnoKRvinMgKdeoehfNQbwjNw+Yq8v26zjQO8zcLWZiVt3TQ2jWkWBGSWwS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:2690:0:b0:dbd:73bd:e55a with SMTP id
 m138-20020a252690000000b00dbd73bde55amr91844ybm.4.1709318871487; Fri, 01 Mar
 2024 10:47:51 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:27 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 02/12] perf jevents: Add idle metric for AMD zen models
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


