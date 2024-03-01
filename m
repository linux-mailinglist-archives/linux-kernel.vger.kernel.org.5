Return-Path: <linux-kernel+bounces-88938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB0C86E8AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE632822D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B111E88A;
	Fri,  1 Mar 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Sixqs21"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABDF39AF6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318871; cv=none; b=SXAPiOiMEScNysBvoPBM8Z5y4m4UGDyyvZxjWaGRcXi+THJI8YV9Gy9kzYeW8vQ130zc+1b97l0XPu7BGf+vyeiyuWhO9IuaVss+x4c1SRzBeO99c2J4FrlvGlcOhNB3sLdxo9QnznOOmMI/OqVyg1NJz73pwo3TDWWlaYi1x8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318871; c=relaxed/simple;
	bh=RzPNAkcYFaWtPD0d/orbD+ZkcQxuwvwqzQzOuKyN1IE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eSrb+hxAde04YLPmqAhP72AK5Z/jVz8zs+RSUe/dsBys92MpXr+Ww1113vxK+48tiM2sjFEXaHNaDoD1L+/ZmwlDep9WyRLpEjFHoEKGjOV/X0QzDikBXO1XG4qVaS6uTEsTuo2DG8yrk1pp3CcwiK5t02kB4Hs/63pReIZwUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Sixqs21; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so3500027276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318869; x=1709923669; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=1Sixqs21LI2Q8+b0hz22jeQsPK1Pyp9lTx6foX7/mvlu6EFagVWgAQEuXAyZ0XCcqG
         ZcwV+01ok3ktnDlZDOyFjV6Xxsd4mZDTwY5OzLL2pdeqv6RgLO+arZ+OE+PxvULqgK8q
         t6KjhC9HldfqmksE9Ago7BrxJ3Xn9r9GTis+S6+8iTJyt7gieellQSWgzbzNHZ7gYZo2
         FnKX++BZL/NCfWKKxjo1yBglhKwcbxeu0PQj+WR7alTlaXYi8x5ZpAf4/0L5yIsLdtL/
         aFyAQ06PiVeKpwkjAnBnF3FNsWGpExPKauxuT/yjiJgkKRGT13PyLb2JWH41SAnZ1M3i
         ebJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318869; x=1709923669;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=JFS8pDSW07JjnPSXfQWCnOXpTnWnSnNutIPE4eIzlBsQy/+9FMHCINMhrbXHaJ09j8
         A7DxWJLBofn6H4Zh9U/Gjxro0ZsGmdsS4NtbdMPWpdr4q2DvmToojttN4EYSdgznCohQ
         haEIOiq6iDFO0HXPI3/ub8wKv/u1cWkmPpAujBnRmEfrCMq9RKBlh4fG5DdeB5N+l81U
         uu+bY2dZaKgaFX4m3EDWoYvSMKQP5me1FEZHpp8D81KH7aEkUQGkjSfkM1lqfshgQDBP
         ZE7BFphPDDhd6qv9n7zJDZ3+PnibBDBojDmwLLNTOIQP3O+vt8oFLrJPf790Ed07/W31
         AAEg==
X-Forwarded-Encrypted: i=1; AJvYcCU3fiU0poWkcvlC3kkDo3LfSVRAd7WVHC9v/7kcx8gkageeRdhazs4aXBILfNYDcxt8mdlfYdcw0ZIhmK+PYcRPJlL9Q8Wrl/vRgLfR
X-Gm-Message-State: AOJu0Yw9EZ7aS946PJt3+XUOirFsSIH9+prDtA7naM4HImVlraPfiK8M
	WBkpWSQkKyakggYU2ZcztDuYfKBh18LD6EhcCfdDFRJy8AYA1S8KyP8TmC8CGwohR9JWjBByiRo
	LmRZc9g==
X-Google-Smtp-Source: AGHT+IFm0q/+8fcaHJsyvMKBQbXB7wGuaoK+1iVffALN1FvhwatbmfRhWbsjMoCKbxv+o3p2hxkXyZpnsI7s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:2688:0:b0:dc6:eea0:1578 with SMTP id
 m130-20020a252688000000b00dc6eea01578mr531960ybm.13.1709318868700; Fri, 01
 Mar 2024 10:47:48 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:26 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 01/12] perf jevents: Add RAPL event metric for AMD zen models
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


