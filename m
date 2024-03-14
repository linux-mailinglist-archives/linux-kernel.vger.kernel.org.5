Return-Path: <linux-kernel+bounces-102820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B187B78E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E271A1F233D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613E17555;
	Thu, 14 Mar 2024 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBhAJVK5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A914AB0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395934; cv=none; b=L6rrZFnE7+OwUyuAgABf9mVRorN+iYPrJTjBrvxKfQOtu/0ydENTP16Vw7og4V8tiM4jrEC9RvFNrwrW5ieVvaTdNTYDP6vxpjyJa+vI3+7f7lc95KshO7xAOPF7jY2LelMDk4fIijlcd0ZtfbQoD6W+NDNnmqkGZsbYIF5zSVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395934; c=relaxed/simple;
	bh=TmZjr1X7q9cH5lQWNtCsYCRCu/YSYQB8OaB2AWUPRcA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rVKyXR0GtxAC3CMHvQwbhM4NmAssDsGCNOfiSCUd9iwDG4MA56IvOMs8EctjDqJ0ulBP1b+XDNm69GXGsNV/h7aHhPhVGGkTmMTP1RhHYzCTa8P/1X9zJeC8gkSlZpPeH7oFvqMWa0v/gGV4qs/jRYG32DSF17nQpiun2FhNrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBhAJVK5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cbba6fa0bso14084837b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395932; x=1711000732; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kqjdI3Mz70ShPxJH/La6sSgiKNcz9TbPXqY+nxcV2M=;
        b=EBhAJVK5PnGtR8OPR1NG+3ArmxY6TXNyhiof0bifQGnZB/KXLKCAO42cG+fioTT/R9
         BE1AFSnStU/jgBG6ZNGFjQfnifqukKY+3WV8k8IJuftGERZ+MGofiyJm7jsG9qihoLDj
         sWWmdGxYKucAjs9h4tvsr/SBpNhpUyPbDSE8Wy4tqIZpDiBIfl5Kk0GLJYecnLH/uaxH
         M7CNXFxrNt6GdKJpYKq5z6ogixSHWA/l3fSpvFIGrKetvb+DsImFlzFgHPK9YJQ8iGoO
         lsDvo/FUqGqtRHjj3gIJqh4ug1mEIVg5ICWgIRWvnPUcCkbny9eE/CIja3AwsAHFS8yD
         5JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395932; x=1711000732;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kqjdI3Mz70ShPxJH/La6sSgiKNcz9TbPXqY+nxcV2M=;
        b=mejwGPvZcesxFn0rS+L0u+J6vnUqqFlKoOrBNySUGrj7B66M1c4vSLln2AnFm0UUlh
         kCuznKcPtHaWVB8LvEBHMGOlAEl/ZtlgmSSihmWOYQY1u4CygWrEKI+IazyEJ0OyQ2xr
         CRlwHfqENvOAFeAfR0NlplKR5PxKr3gZMhMaqGEXg4iBOONc38LlEgnZpR9OFeBtQ05i
         gdgjTC1HsYrJy+UTFWbrbGpjugYCPri4FwYaQQbyfzoDs3tDt519P27+keW1aJIVmU9J
         k8AKYfjFWEV66UNjdjq1zdMzkehrMccobDeAD38Gs1xBaFKYhL0LNxvKtWwL/PhQ7y4P
         JdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpfgAS5Gu34F6PkuTSKJ6aimMBhBYTF9+MQ8MtnT2CWab2tXDTW6PNn3Sueedxa7PZdcdZCjapra0MNPTvzuWF+qVW6Wv4WV/b7+ev
X-Gm-Message-State: AOJu0YxBwiOwblX/fJA0XrEhTD0CUyDMBxSx7HXMad5ffPs5lCpk3BRa
	5fLdEZ58j/sFxPV7Lm/68Mlxv7LgKEM4DH4giJTtKoebntdU1eukMjXbZGONHmxUxG5b+Md2kJ0
	JtWyqFA==
X-Google-Smtp-Source: AGHT+IHnDGcpkrYyy1dIlgPlwKh6DeetOXeGIVDucIy4Xp2XHB5PqzZtCKmDu2XfMYM5K7xn9HL8uoH0G+Bp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:220e:b0:dcb:bc80:8333 with SMTP
 id dm14-20020a056902220e00b00dcbbc808333mr211969ybb.13.1710395932244; Wed, 13
 Mar 2024 22:58:52 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:30 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 03/12] perf jevents: Add upc metric for uops per cycle for AMD
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

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index e069b95d6470..c64470d4822e 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 import argparse
 import json
 import math
@@ -10,8 +10,17 @@ import os
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
 interval_sec = Event("duration_time")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+def AmdUpc() -> Metric:
+  ops = Event("ex_ret_ops", "ex_ret_cops")
+  upc = d_ratio(ops, smt_cycles)
+  return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
+                upc, "uops/cycle")
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -45,6 +54,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
   global _args
+  global _zen_model
 
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
@@ -65,7 +75,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
+  _zen_model = int(_args.model[6:])
+
   all_metrics = MetricGroup("", [
+      AmdUpc(),
       Idle(),
       Rapl(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog


