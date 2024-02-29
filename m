Return-Path: <linux-kernel+bounces-85898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5230086BCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085822835BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43047524BF;
	Thu, 29 Feb 2024 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR06XwA5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059E44C9C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165920; cv=none; b=iIOF9L9Umbkb+ksKsS9pu56VqKQbDTRlhmNOHF3BfvNJWYbjCjmACIHWbDEdUnEoJfRgNrGpVuTmeQ8+hVI7YCrsaWIBOm5Q9PVxE+X5h4nt/a3lMwvYCo5jx0eOaMAYH8/+KDqLdLoHjqufCHSycoeUdOZFVzeczUapqwucrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165920; c=relaxed/simple;
	bh=OGxEkqtAUV2coFbRq/RJ+uPweZKIEnWlAUORKInoJ9k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=o1OSfn4TSCNKQoyUDlmR4CxtUbLYRZkxxPq1x46Wl6DyBw8H1Of62gjXflVLGDW25zpaZ9eB1JpW/mC+hDq2D4SdC/pa1QpgkBaOby5xd06npUFimUAmPxe18UJPcYJP2jNa2vXlKMaLfAN4MP1TvO9QJHg8qNeebQS8ULR/Pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR06XwA5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so16776767b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165918; x=1709770718; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHYTrWPQQfDvRO2Y3kXJ96unWdbam7XTLAS0vgfzft0=;
        b=pR06XwA5lQ9LpnUlZYP7b9tIwA5e47krSbwhi7Nkhfatb4DJAwfubLgO90TwYDmEO4
         FgbArula5qk/jcYnL0B9xl4pidhkd7LaDW/9t0NYBJzou60+vBBETmiZU9/x4C4kgg4L
         HSoavzNP1z4zKcEjKV9DSD2fUAKrNLFvDWXebXOCa8re02Dtsjh0BEzggc407h0ZX8L8
         mS7u2VxhhXGkfZEOA6E1hge/ToiGYDDt3cL0b5zMqUR14xMCgvxEq2JRDvsHMe6aU63c
         Ka++HWop1e36Caj/nGWHNPzq4P1dnHlMaNH+GZiQFgH7lZK/QqOTOxKcdLQ9+EP5VaAe
         oEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165918; x=1709770718;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHYTrWPQQfDvRO2Y3kXJ96unWdbam7XTLAS0vgfzft0=;
        b=fSFUB1vaQKOzeDeUNobJr3jMkIT4PBLLr0G2C6XJ21UBAROVTKiS9bEYZu/wloJ+oj
         OzqdTJfwlEniQJIckK4+JmN/mL+XD4vsMo9tHL3T+ptLPHnuNKnfxSQCPF0ss6zBBAgt
         i6aVTLIY5kX/dPPfEHhBl2fZqechdl5BEVjchAB84puDTNtk/wcyc4MGUnOw0uJg4lNU
         5iV5DxI1AYuRoZXt0RfNBx/oK2JWumr37jQUF8DKvDablYgbEZIV7w5IORst/UMufBLY
         39IJwbQTRRZzv2aa4rw7upQp4gjuDawu+Nr5WqD0bv0UoI5AqZFqH4LdJewrDDSFQRCY
         pnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzX5v871M6VNb5FrmhNJXfmN4gxfKkbFCsWc/8xjIPmfwi980LHINlAnwjEQuqHv7AgT5iR8pSKBTesxa0dCj2WKYRSUnXkqmd7nqE
X-Gm-Message-State: AOJu0YwjrqezrxKdBgS/IJbvgTFb4KHn4Ahx+6R+NC1uVwLDbcfLCO1w
	SwN6FuutxJOM/Jd+0uzlaIW21e96N8QPRiNdhvSJj2YLToXAAdzrHMfylOjq09gGe47gIaWexz+
	/CELFyg==
X-Google-Smtp-Source: AGHT+IFsFIxXr34yPFaTcqdM+Heeyoehfw8+UOaykD8oVJ1gpIJF6XDDTAdFszmDzAu1PmNjo/KNp2O3QSMG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:505:b0:dc7:4ca0:cbf0 with SMTP id
 x5-20020a056902050500b00dc74ca0cbf0mr46479ybs.3.1709165917807; Wed, 28 Feb
 2024 16:18:37 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:51 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 06/20] perf jevents: Add software prefetch (swpf) metric
 group for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index bee5da19d19d..f11273e9935c 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -265,12 +265,77 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("swpf", [
+      MetricGroup("swpf_totals", [
+          Metric("swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("swpf_bkdwn", [
+          MetricGroup("swpf_bkdwn_nta", [
+              Metric("swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t0", [
+              Metric("swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t1_t2", [
+              Metric("swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_w", [
+              Metric("swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Sofware prefetch instruction breakdown")
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelSwpf(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


