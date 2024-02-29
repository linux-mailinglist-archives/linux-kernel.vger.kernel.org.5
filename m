Return-Path: <linux-kernel+bounces-85908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23F86BCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DD3B25A04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C55D72D;
	Thu, 29 Feb 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrth8MBR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B35CDF1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165941; cv=none; b=QyPc9+8DhmdQfKi6WGGUheCBzz+BvVeSs9p+7wY9P+LGYvVwzaLjUSkuiqxxPOOCeteAqzLV/afcLvGi+c1fvZyBgOo8wclmdL+6wWmJ3C2Tq3P8S5XnG6tmeu0dhzqkt6QWlDoDRhsNTNrkyiT0GrO8Bvmq9LAfC05QwbnV2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165941; c=relaxed/simple;
	bh=n24bfMvbsLQrhJDf7paSd47VFWDE5Eb6tLHa7+2e2r0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cn0QmnwPbj9T4Eg2lHT6Reb6p2/JUN/Tbn2vBm2yF0tkloKoQTEUfkNjX+GomOeY/+kJHQlfH0vh0d6QXy1coNg81W/4kRCRrNQ6yz8NyThMfnphqx17FnZ/on/BJ6ECEqNvO/9P6/yrcCb0C9RcOtN4y+WJKgqqaVpc1tr9J2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrth8MBR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6092c637278so5462317b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165939; x=1709770739; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssvmfSzbf4Bf2vyw+vKAKxfn6gLVPgVaJ3+6XRQ1Cxo=;
        b=qrth8MBREDCJTrleDBrvcaqUHpkrb00Y19EVfjNfUN9B8oZw1XTRDF0lXpEPIlrxgP
         5ENyMP3H/WNzf1eAsoLe3aoIb1RBSZbg/PiVPaewoI8buU2LtG1k4HLbjgr4mGfGDvlD
         0/2KND3NLY3iV38VfUIUcnAx3m9dBPsi2XarNSlLycUmRDWI6nbN4ivRD/8gIYSPsCly
         bb9fGbNMPCREHF2oIVpF3RITj/rX5+cN0m5DciPNRcPbSimBMdwNLSCarEpzbReqn/dF
         SpphuyVhD+5sUOodIZUqM2Lh0qNbnEt5hRJ+UXSCcaqbzbGiFXIk7FfEf3y2KIaZw67I
         RIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165939; x=1709770739;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssvmfSzbf4Bf2vyw+vKAKxfn6gLVPgVaJ3+6XRQ1Cxo=;
        b=HZRlIIsu83BiNW+xkyEGyhvkYFVZnGa1CUZjJAI2IPo0uL+rIle0w6vWKQJhvfEAa9
         Klhj/RkAbRkNQ7lMBJqc02aT/0Xbz+m6eJX/dqR+M1NZwmNe04XS3YrUNnFY+2BrNEiz
         sqfzG5OFpeB2ZTR2o4R6WB86AsrCB5GJOOBeV8eKZIJmVAoKS1zllESdOnRowEUJiFzF
         Yq8iRH9B2+y1VrTOtnmtdXBd16IJjArz/vingFKPdm/3ZrpG+m4e6kEa/2eNCM+39jBv
         IEv5033JreLTuYQcbp3ztB5pzrDY84qWmBKX+Ar+VeIzxNFVcqvr9oQaQeVbgEdbSDR2
         vuRA==
X-Forwarded-Encrypted: i=1; AJvYcCUbSIX+Xe8hOvnL4l121cUSCe1l3yIi9dp6Z3PwnKKVY7RgTEgqqx+2febMkycVwOS1r36A21VG8H+38OURASEcMRw/rxaAY8cwbiou
X-Gm-Message-State: AOJu0Yz+TnlECOQpjfRie2J2Qno/Oxbbdx5MPIyWmzmuU8+FWQipVz4M
	oIQDBYRBtQ0UuuLbP2Lq6NKe619USeY1b1kZrW9e8yONiGtAoRLpODMMkCgAKolERuF55JN38xR
	ijrsU1w==
X-Google-Smtp-Source: AGHT+IFYx1pPpl/3L/ukt52mSMHT09pD1GZ+Vg5CU2Ry8/gBNKYecgQfOm9KeJwP1leD9BBJnhi+/kJ5KMhs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:230a:b0:dcc:6bf0:2eb6 with SMTP
 id do10-20020a056902230a00b00dcc6bf02eb6mr41891ybb.6.1709165939066; Wed, 28
 Feb 2024 16:18:59 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:00 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 15/20] perf jevents: Add mem_bw metric for Intel
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

Break down memory bandwidth using uncore counters. For many models
this matches the memory_bandwidth_* metrics, but these metrics aren't
made available on all models. Add support for free running counters.
Query the event json when determining which what events/counters are
available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index e373f87d499d..8d02be83b491 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+  mem_events = []
+  try:
+    mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                f"/arch/x86/{args.model}/uncore-memory.json"))
+  except:
+    pass
+
+  ddr_rds = 0
+  ddr_wrs = 0
+  ddr_total = 0
+  for x in mem_events:
+    if "EventName" in x:
+      name = x["EventName"]
+      if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+        ddr_rds += Event(name)
+      elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+        ddr_wrs += Event(name)
+      #elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+      #  ddr_total += Event(name)
+
+  if ddr_rds == 0:
+    try:
+      ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+      ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+    except:
+      return None
+
+  ddr_total = ddr_rds + ddr_wrs
+
+  pmm_rds = 0
+  pmm_wrs = 0
+  try:
+    pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+    pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+  except:
+    pass
+
+  pmm_total = pmm_rds + pmm_wrs
+
+  scale = 64 / 1_000_000
+  return MetricGroup("mem_bw", [
+      MetricGroup("mem_bw_ddr", [
+          Metric("mem_bw_ddr_read", "DDR memory read bandwidth",
+                 d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_ddr_write", "DDR memory write bandwidth",
+                 d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_ddr_total", "DDR memory write bandwidth",
+                 d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+      ], description = "DDR Memory Bandwidth"),
+      MetricGroup("mem_bw_pmm", [
+          Metric("mem_bw_pmm_read", "PMM memory read bandwidth",
+                 d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_pmm_write", "PMM memory write bandwidth",
+                 d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_pmm_total", "PMM memory write bandwidth",
+                 d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+      ], description = "PMM Memory Bandwidth") if pmm_rds != 0 else None,
+  ], description = "Memory Bandwidth")
+
+
 all_metrics = MetricGroup("", [
     Cycles(),
     Idle(),
@@ -815,6 +876,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreMemBw(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


