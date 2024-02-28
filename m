Return-Path: <linux-kernel+bounces-85487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1F86B68F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5A91F2438D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD815F30E;
	Wed, 28 Feb 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vso+9MMN"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E974436
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143027; cv=none; b=DfqOvez9KneqAVbIdAndQ1IS+CWx1PVWhzLpaCW1v1eBfPe74FeSHvGKixyPx4aiPUwDAFuJ5oqfLQKcDPTqs8h0yvxNcOluqAUrCG903JA7zmf7mj550K0coAcz6DxYb7vfzkpS0T+Dl1Pj4YWRJVPYU/KoP+ASzsDNPzom6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143027; c=relaxed/simple;
	bh=RFf0SovuHqWJtY0/DKROVO/7jIucJjMLUFN5wMVSl0U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M14gxrkb5WVyM07xQAPKRYXeoas3l2a/iKJLLvNlC1QOwTmDchvJYKuGHREtEhfYiAZyPBEAbSsNsj+Frn3/1Ak5gS4VTq4hnXyax1JcS+XWSFP8LkbBBDg6njiyABN1gzVN8+6n9CTNY0YN7wQB2YhCsSoDvlNLQIQdz80LCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vso+9MMN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so84344276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143025; x=1709747825; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6NqTe4lQsI2lCeybdcDVIAKYLSVy1HDfTgRobHAwi4=;
        b=vso+9MMNgXr6fayIR2i1LyL62utD/cc1sKvPb0PfhNZwymo1M/gyZW+v3uaSHSdQU7
         T2ov0MIlHn51uINxFF0lREaMCLvvGxnahnFJ3sweFaGaA9XM00ok8T1kWykxjbksnyH+
         DBZuUOmpZnSkiDz0+1vXnj+Xzq2KUP/yQhv0VuZv2G1EsFOCJ6a+3atI5V72W+a+l178
         jzwXs/pTCEx9TKnUYhw/IjmxoUsuZ8Fh+jXZwQoEM7RrkBAGeRmmCrqNOsdV859TX+Ee
         zDTyJcnFzHG8Kgh64AobR9P1sBnBPNaJCL5KWytIbWh1XsJh0wmHkCRscWpA79GDD4Ud
         8P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143025; x=1709747825;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6NqTe4lQsI2lCeybdcDVIAKYLSVy1HDfTgRobHAwi4=;
        b=JsDASKh1ybCS0+eavV6d/gFyOzuFBrgJdQsVLe4UaaqmKJtW0af7W7igm+ZPwakpaU
         glkXaifH6mSoe+fiZD1XcguzgAcWIcyuZRem/JP6O57grU1ClbdFZrwZfzUlsCsbbG+s
         D1o5YePtSMpm2f+ihzn2VmaAsi8mmymAuj+DBJQbzkBNK5TAFsuPHDPoi1BTDOtdyq6A
         0NhboOhStHEHgaIoHDQMCIo8Dl4FKhU99GZFFoN0yQ5Urb5wCeag+EiSp2iGOkWxDbMY
         bpemD53NTmJzf2ldEamCpVfJthNJBaKlLHN4SapTW5X3ucD8RkuWPeVyByBUnuq8xVH6
         4J4g==
X-Forwarded-Encrypted: i=1; AJvYcCWUCOFp9bB4EVyng55KITjzfKUV3Tom6mo5J+nz3qYzC148bBiUIq54A2dMFbc1O0r0ZbV2bIzNQj723rWKh3RwGB7q2n6L5FqUeZ0k
X-Gm-Message-State: AOJu0YyyXuV8Px4Mw/NHlBy/GKWb33SWWlmgh64czsrduyfRRKVtvOBZ
	XJlTLGUt4bbbOFHjERSuMfp63ANt59oJFNIX9LuBINXuYqqnz2q/jxinXNTbkjZJ/DIXnN4Vw0d
	p4Wwssw==
X-Google-Smtp-Source: AGHT+IEXq2MY86zbh8qNj0dj6Z5P07UKBCnxR9qEnKybPAvKfXIeSsHZc2tWN3H1cMUiTPnEctFXUrTRqY9Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:dcf:b5b8:f825 with SMTP
 id t4-20020a056902124400b00dcfb5b8f825mr11204ybu.0.1709143025258; Wed, 28 Feb
 2024 09:57:05 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:17 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 12/12] perf jevents: Add load event json to verify and
 allow fallbacks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a LoadEvents function that loads all event json files in a
directory. In the Event constructor ensure all events are defined in
the event json except for legacy events like "cycles". If the initial
event isn't found then legacy_event1 is used, and if that isn't found
legacy_event2 is used. This allows a single Event to have multiple
event names as models will often rename the same event over time. If
the event doesn't exist an exception is raised.

So that references to metrics can be added, add the MetricRef
class. This doesn't validate as an event name and so provides an
escape hatch for metrics to refer to each other.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py   |  7 ++-
 tools/perf/pmu-events/arm64_metrics.py |  7 ++-
 tools/perf/pmu-events/intel_metrics.py |  7 ++-
 tools/perf/pmu-events/metric.py        | 77 +++++++++++++++++++++++++-
 4 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index cb850ab1ed13..227f9b98c016 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,14 +1,19 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
 parser.add_argument("model", help="e.g. amdzen[123]")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index a54fa8aae2fa..7cd0ebc0bd80 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,8 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="ARM perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -10,6 +12,9 @@ parser.add_argument("vendor", help="e.g. arm")
 parser.add_argument("model", help="e.g. neoverse-n1")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/arm64/{args.vendor}/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8b67b9613ab5..4fbb31c9eccd 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,14 +1,19 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
 parser.add_argument("model", help="e.g. skylakex")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0326050f1e0f..7d445e47ae09 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -3,10 +3,50 @@
 import ast
 import decimal
 import json
+import os
 import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_events = set()
+
+def LoadEvents(directory: str) -> None:
+  """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_events
+  all_events = {
+      "context\-switches",
+      "cycles",
+      "duration_time",
+      "instructions",
+      "l2_itlb_misses",
+  }
+  for file in os.listdir(os.fsencode(directory)):
+    filename = os.fsdecode(file)
+    if filename.endswith(".json"):
+      for x in json.load(open(f"{directory}/{filename}")):
+        if "EventName" in x:
+          all_events.add(x["EventName"])
+        elif "ArchStdEvent" in x:
+          all_events.add(x["ArchStdEvent"])
+
+
+def CheckEvent(name: str) -> bool:
+  """Check the event name exists in the set of all loaded events"""
+  global all_events
+  if len(all_events) == 0:
+    # No events loaded so assume any event is good.
+    return True
+
+  if ':' in name:
+    # Remove trailing modifier.
+    name = name[:name.find(':')]
+  elif '/' in name:
+    # Name could begin with a PMU or an event, for now assume it is good.
+    return True
+
+  return name in all_events
+
+
 class MetricConstraint(Enum):
   GROUPED_EVENTS = 0
   NO_GROUP_EVENTS = 1
@@ -317,9 +357,18 @@ def _FixEscapes(s: str) -> str:
 class Event(Expression):
   """An event in an expression."""
 
-  def __init__(self, name: str, legacy_name: str = ''):
-    self.name = _FixEscapes(name)
-    self.legacy_name = _FixEscapes(legacy_name)
+  def __init__(self, *args: str):
+    error = ""
+    for name in args:
+      if CheckEvent(name):
+        self.name = _FixEscapes(name)
+        return
+      if error:
+        error += " or " + name
+      else:
+        error = name
+    global all_events
+    raise Exception(f"No event {error} in:\n{all_events}")
 
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
@@ -338,6 +387,28 @@ class Event(Expression):
     return self
 
 
+class MetricRef(Expression):
+  """A metric reference in an expression."""
+
+  def __init__(self, name: str):
+    self.name = _FixEscapes(name)
+
+  def ToPerfJson(self):
+    return self.name
+
+  def ToPython(self):
+    return f'MetricRef(r"{self.name}")'
+
+  def Simplify(self) -> Expression:
+    return self
+
+  def Equals(self, other: Expression) -> bool:
+    return isinstance(other, MetricRef) and self.name == other.name
+
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
+
 class Constant(Expression):
   """A constant within the expression tree."""
 
-- 
2.44.0.278.ge034bb2e1d-goog


