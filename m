Return-Path: <linux-kernel+bounces-102842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8460E87B7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62F81C21070
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4EB3BB2E;
	Thu, 14 Mar 2024 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ijfrqof"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA339AE1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395990; cv=none; b=GK4gOwRmWSswDuH48cgRdQ6dahmdTFtkSO5KntSQMnt7wJ8ILWUT66jiBztgFHhpHBO41eX9pV2Tl/HWUQyrbzXmpJ0GWwZ5PpcgC4ck6f20GSjWTgqfSt6dJ8NoOxaqeXS8VIKM2y9DDMxKh16AibIj/dOpLQN7nN0n+Htik+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395990; c=relaxed/simple;
	bh=ezts1SNNXZNxj9LhQuYH/wsj+Q9nYnkcvRFPOrQH5NU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VRbbQpLjXE4QsQRmVXSH1YVhZcPrBDW48zm4c/MFUkqnmQAA+iCPY6CE91vqKsXAOuADGVLhJjLxOw2jsTJS5PpeajU3h6ewiO/3mk0vZXJb0V1YSO6EYO+CcbO3hshBmPEG2C6VrVnaxLXPtgxAgLFcTmDuz3BTsckfz4bwiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ijfrqof; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609f2920b53so10456237b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395988; x=1711000788; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wc6YXjrCOCpyJhvEJp6tDQdGSaY//cGMnlBPtpOLWG8=;
        b=4IjfrqofBkyItL+StkrOLepM6fJXlYqAi/Gcv68JYrW+QIGLigm7hYjcKBkcyrkXuT
         Pw3PIowx1U9NykU6KnvFbrBnjOllxxa4TByuVt0kDUt5qEjL3DWB7L9tLYICspx1CcL1
         0uDCtNuAYlEize0osqOZ5hQUmkhfDv7pluqpJPoLv3zXCnaEHTrD0+0NJGMGRc/HfenA
         J1SLh5mz9mw9iAHyrJgfjN5SPQq9JGBixt6vKwV4ElOPV/N6Ekcfg5bJXUwDUdUoTRXI
         7Hi2sag6sNciQwMllKbAOtt5MZlv9coJvOROYawXhWQpDQ0RWeaASxkt3x9/2uwGCwbJ
         w1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395988; x=1711000788;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc6YXjrCOCpyJhvEJp6tDQdGSaY//cGMnlBPtpOLWG8=;
        b=mvA+2yya6nGg5w15ImeJfhWiqb4x3LfovUwNApZt0TIl4CznjLywmHfTZZx5UdQPe7
         QkmaMtmPa4mJJ5evcE49nSnlv6rcC+Wq9qx21o6lTlQkA4A4wFBncRW0vuG4jiQehr+/
         IFfehQ1uha3jhBmv4/d1wvdyZYY7Kg803JqbKTynzTc6BqzkSh5QffhPlBHvTrfRLBgE
         unqpiByCXliPowKo7v1PCV48EtzZUanT/UzSdcBYF4IdvBpP5DwW1fRZMJIpeyJlDND4
         zWcMlmV7PauUjHBmMDQBJ53546DLxWLAxs+E/7xAx0V3FT5UAsvWPT9exiEeqsuMUi73
         YRwA==
X-Forwarded-Encrypted: i=1; AJvYcCV2nb8V3rXt07nEZEi8e1ke/6LWa9DpULpq7meawdBnCTQpShSBHLuYZ3lhMNZd9X7Bqwl0Qxk2BW3CGBcv+vghNCRbqGffTtyrLtQ6
X-Gm-Message-State: AOJu0Yy/6dWEsM2D8zI2awNz0jYT2FTc34k5vwBCZjMhe43+sPCVA6RC
	KFyuz7axExB3RNYu6F4QTKvllEJNkO0RObQFfhcCg6YhkMggDRpaMJjUYjOnx7WsXn4K4TEEd61
	S8Hq1EA==
X-Google-Smtp-Source: AGHT+IEOxKPeWAIPaad3vDYh4PJ0xM4XujFoN/8aPaMrp250cr+Ezt/hXSmH49NAvHShMRe7EKsrv+g3X0FM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2301:b0:dc7:865b:22c6 with SMTP
 id do1-20020a056902230100b00dc7865b22c6mr34277ybb.8.1710395987985; Wed, 13
 Mar 2024 22:59:47 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:04 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 05/20] perf jevents: Add tsx metric group for Intel models
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

Allow duplicated metric to be dropped from json files. Detect when TSX
is supported by a model by using the json events, use sysfs events at
runtime as hypervisors, etc. may disable TSX.

Add CheckPmu to metric to determine if which PMUs have been associated
with the loaded events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 52 +++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f34b4230a4ee..58e243695f0a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
                     MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
@@ -74,6 +75,54 @@ def Smi() -> MetricGroup:
     ], description = 'System Management Interrupt metrics')
 
 
+def Tsx() -> Optional[MetricGroup]:
+  pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
+  cycles = Event('cycles')
+  cycles_in_tx = Event(f'{pmu}/cycles\-t/')
+  cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
+  try:
+    # Test if the tsx event is present in the json, prefer the
+    # sysfs version so that we can detect its presence at runtime.
+    transaction_start = Event("RTM_RETIRED.START")
+    transaction_start = Event(f'{pmu}/tx\-start/')
+  except:
+    return None
+
+  elision_start = None
+  try:
+    # Elision start isn't supported by all models, but we'll not
+    # generate the tsx_cycles_per_elision metric in that
+    # case. Again, prefer the sysfs encoding of the event.
+    elision_start = Event("HLE_RETIRED.START")
+    elision_start = Event(f'{pmu}/el\-start/')
+  except:
+    pass
+
+  return MetricGroup('transaction', [
+      Metric('tsx_transactional_cycles',
+             'Percentage of cycles within a transaction region.',
+             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
+             '100%'),
+      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
+             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
+                    has_event(cycles_in_tx),
+                    0),
+             '100%'),
+      Metric('tsx_cycles_per_transaction',
+             'Number of cycles within a transaction divided by the number of transactions.',
+             Select(cycles_in_tx / transaction_start,
+                    has_event(cycles_in_tx),
+                    0),
+             "cycles / transaction"),
+      Metric('tsx_cycles_per_elision',
+             'Number of cycles within a transaction divided by the number of elisions.',
+             Select(cycles_in_tx / elision_start,
+                    has_event(elision_start),
+                    0),
+             "cycles / elision") if elision_start else None,
+  ], description="Breakdown of transactional memory statistics")
+
+
 def main() -> None:
   global _args
 
@@ -100,6 +149,7 @@ def main() -> None:
       Idle(),
       Rapl(),
       Smi(),
+      Tsx(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog


