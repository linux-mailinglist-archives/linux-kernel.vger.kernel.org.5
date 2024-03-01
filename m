Return-Path: <linux-kernel+bounces-88961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C3686E932
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5BCB30C21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18D39FC0;
	Fri,  1 Mar 2024 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12dW9lnK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2A3B198
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319382; cv=none; b=fKFirw9GRpe63iZfh+yJ8M6Ao881MKy+8FbYpkL4i64pHoaoYPQu8O1a+Hzwj1uDWEn9mIM8TTYgCKpzxArhVA121qGi1uvjZSudMusmhk1pq2dLZaG8SHanMJLH2IqS9y8kiF235G9z/T3UD5nVjMwoupeDvvcHFU0WsyCRGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319382; c=relaxed/simple;
	bh=8oHWhZlncmxDfpV4axl6yS7DtQzS0saV/qldweLxMzo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WBm2EoM7JGPlXJvs+uXdnTpwS8xhSnwAJf1dvbGdcvGcvGL6LHfqyPVQm9esui81oPGbQegnSYrX8NicOOd2pC+jHJAKxWo/h50CZWJxSXn99wuw+5CV8T7xG95pz34dfjv2hAs4frnGN6O2y6BxOhW9j0j9XIZSdyibiR+746M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12dW9lnK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso4549141276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319380; x=1709924180; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RK+fLoseEVnt8AotaCi+y9ZDN/WJ8lwPCKN8c7HO7+s=;
        b=12dW9lnKkgDoBGQjOHPeh+9G6SQr8fVUDHqSyoSTIddpRuQxRxtCA24wQl8+LGcxQ6
         NE8hKTKrwTZQqXr8yubxvKRZzZ/P4n1TW2B/Fgzr15bSMu25nQslO8PD6Hauya+YT6mE
         TIH0VQ56QfEi8EwOTPqSgAjZJ8O5eFj29VwhENAyOwyluMYY0u18qFBPc3yz3uVt8aN7
         okdwnRNxGBDxPyMdqmo1RnTxfvcHwJBLdC3x1wPt8tFzn7dE7C0jng7/me/rkkP9tP5d
         kNwib/h3N/ZTsQIOzlITB1TK3s9kli3+9CR0lG2Ds1InbUFjuSfxM/OU4uCRg4BxW+dt
         9b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319380; x=1709924180;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RK+fLoseEVnt8AotaCi+y9ZDN/WJ8lwPCKN8c7HO7+s=;
        b=AzfXrEOYTr9IkvmqPU5zBWgVMtRsL1iuEQxoHzWflht3w62rfcIq5y0QO08VlUVgyQ
         8XsjJIa21Jgq1Bmgcvs2ABUEQPo+2wPpsHuBVraWyqtLjYHbJvVLg+Vp6KC2yhd+W2oV
         x7GtPzYPhejl11YwwsjUf+48fGFZvMscrC46TJvNC2NlMnYU4WwFe+UF8IE3FCBYzjdT
         2/STbSzlPNxPK9vGmEo6OMKFrwETl0Mh3xqFZ53VrxUcHjZ2BCYm1M/onofX23rsFC0z
         IeTaq2CqOlqZa0curNgDDEerfvnclZWnROgMGS3nwHhn2XKF9lfgmpw9Sf6xF39Mc1xl
         TUcA==
X-Forwarded-Encrypted: i=1; AJvYcCXhUUvhJzoAzaIg5s+gbpdaepI2y0VWusdIBZchA5dZg5QYGmx+X3V2Gjx2K8xX1deJIFz26HGADWo8k03weP97nrmwUTdTSuql9zue
X-Gm-Message-State: AOJu0YwF91n1nOElvVY2vN6H8SMv/CDowZVIa6cZDG2LAx++nujapQQP
	+6R5J2j1Fcr2FZCPOrNBTSmvYPoNnXqLgeeh9K3jhhtBIDDrCNySIqRnwAFM2r1CkNyQ2ajEI3x
	HknhB+g==
X-Google-Smtp-Source: AGHT+IHCc0kh+X6efbw5NDafcaFuhbYBF2KtHDUK+A5x2nachpEw69wy7QXYLBwTSQquIn96WORrAauZre3t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dc6:cd85:bcd7 with SMTP
 id w13-20020a056902100d00b00dc6cd85bcd7mr572697ybt.3.1709319380436; Fri, 01
 Mar 2024 10:56:20 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:42 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 03/20] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 2622d4e5ff54..81879e68da96 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -62,9 +62,28 @@ def Rapl() -> MetricGroup:
                      description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
+                        has_event(aperf),
+                        0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts. '
+               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description = 'System Management Interrupt metrics')
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
+    Smi(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


