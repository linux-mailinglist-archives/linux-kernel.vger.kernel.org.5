Return-Path: <linux-kernel+bounces-88940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253C86E8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF194287614
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77753B1B7;
	Fri,  1 Mar 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1D6q+WK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250139AF6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318876; cv=none; b=f+XwoKmzBpgPvpeaMU5n3gBDf8AqLEXhBOwLii2YA32R3SsILA97ploji/+ya5tVbgTbC/AyqJNoxR2OkitmjJCaFwaAbzEwMoXdqhdQM6pUwITzKOX6+WVlr8xmL6EiHyRPxcAY8NJjCFwRUnqfcO7Fx/wtGD8133CEqQ1HcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318876; c=relaxed/simple;
	bh=yEm8gDDiOp2kaCb7bjt8yDfO5lzyLygQrwL/+bKOLd4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SF7I/Wmj4WrPkeG3Xd3rhL9KgDCO0j16JwCBqpMwRrP8FK8oXxi/q/1fiMPQXBBnmFfMC4Cs1dR/GTaHy4boVI4tXyHvIqedKjVhoZQ2UdMCMLpiwc8YPN0EHjM2KfJXpBmsGF5jXO81HCm2dcBtUod3VgiIUFKBlXhnXTRISXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1D6q+WK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6098d88e994so5067677b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318874; x=1709923674; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7UsDzYt66DPsayZORzPPicQ8YRzeND3f/RE4XjTOWg=;
        b=Y1D6q+WKyJ7+I+ltfXM5u87F7qgTMdnqW18Bhuh+ivJpubUsD3SE1UOaUMRVc8TPiH
         KQQq38JqzLqcgklJzqpK2Aq7hqfZWEqSD2mNtpPZQt3ixGmO/foTGYCzDGc0OMgOSF2U
         6TRIILIGnrBP1/Zz/X0l3U0f6no/Yd8gbQ3IV2QmQbz9cnBeyX9SABeNNHSFPVYbglRU
         zBU49X0VKwE+gCexNQPE2Y0elZaJUNCVPHFrdSrvuiZo37oNxNbOzF1+uuTmoIL7zIBB
         EtPK04VEs+MwcTwBQCxa5lsca0eVI0pGLUzoDQFK9rdQbQlDyfKJrtHhWugdnBcReTEO
         Htug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318874; x=1709923674;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7UsDzYt66DPsayZORzPPicQ8YRzeND3f/RE4XjTOWg=;
        b=Rj4IPQZupkkJh/udza9MQ2S06Y2MjwblrS8xrZH9Isr1UbqzloR73xTLcto5efUSkh
         MfhYIithOQ9RLhC17vUTVQiT7nIeNeZTx/Za6cWA1LZD5rpcft9OICMKl52/lJWOAtD0
         JroOJt9JC1ewDjiF4DcHZGgX8Uqd9zNkGJTJ4/3iwMlNtPJOU1V4zV/xM9kY8ebKXw5t
         8ksLW68iWimk1qmUxQwPuOeR6Xv9AsEO4TqXjZmAGTW7DJTiqGFL2F436mUo+rXt9MDT
         M4mFJbYxKkdB9o2ksDmiJHCLUerzXG9Zl4pusp3Hd2nwPFK9xWCHlI2KBuRa2ta/DqOs
         OGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVfiGm2rHSIwiUtowESuf85wdnxnP7e5hIX0FDqIfvFgjQN1YuUErTqhnDXVP6XQI2LaZCOXs353pdu1E3tTXn6qx0mabuHkAduw/u
X-Gm-Message-State: AOJu0YwRFKN5hWmEzetpHtADIT00qTPTqNAGSSWIBwB4IA8yr3b5cH+6
	sWVgaNpFS8/mXIfXw2oQQhLv3ZoGNuwhpJPcxzvkPS0twxlD1j0lYo7HZBUQxt8valto5TLN2b0
	EcIDcbw==
X-Google-Smtp-Source: AGHT+IFYx7cD9VesT55TnwwdjBlf92SmG03a+uOHSN8skXYByJOCNu5JBfkzi9D+lGPIKi6LeOzudT4bvl0m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:3702:b0:608:1b39:245c with SMTP
 id fv2-20020a05690c370200b006081b39245cmr631942ywb.9.1709318873830; Fri, 01
 Mar 2024 10:47:53 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:28 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 03/12] perf jevents: Add upc metric for uops per cycle for AMD
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
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index fd3095cb5c1d..ce3d1535483a 100755
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
@@ -16,9 +16,17 @@ args = parser.parse_args()
 directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
 LoadEvents(directory)
 
-all_metrics = MetricGroup("",[])
-
+zen_model = int(args.model[6:])
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
@@ -50,6 +58,7 @@ def Rapl() -> MetricGroup:
                      description="Processor socket power consumption estimates")
 
 all_metrics = MetricGroup("", [
+    AmdUpc(),
     Idle(),
     Rapl(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


