Return-Path: <linux-kernel+bounces-85904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACC886BCBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D584F285527
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228E5B674;
	Thu, 29 Feb 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzaDeDaz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAA58104
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165931; cv=none; b=n6OQGiv4Uw1WGl8FXOYXSLPRcrj4HGaMbSSSu0YdJYBxQRGdm6S3XCw1ZLmNGHlf7jhAoVXtc4eGfFuUFiX/jw788OuRQfeqLpWwW2ZeaFtjuXV3yzXj4kDhAIjKKAUEyB679573JQrYX1i8REH55VuK0EPSl5TeGHu4HPZUOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165931; c=relaxed/simple;
	bh=ky/hxGqHiEPNUXC5YpHVs6vSUyZz80sm9NdbvegFkVY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SIPgdEtyatPS99x3KxEc2pmn31cgiUZ73THYl+OXjl5ko29HtMDfbqSvy0JPmGr2/Izck/3rveQrCW8uJNSjT7gV3xyMKYCMPhOOO8f6GH3YMXdqaW/s2+S+wfuQ5Ev1ILvJ6+fMQH3Zcju0lO5CCalfCKBiYwPJ/VfTgNBFK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzaDeDaz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60942936e31so6125967b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165929; x=1709770729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJrxbtjXZ5o0JjkZHH3aEb9P2cYPenOBkdypf42wLcI=;
        b=YzaDeDazio6WwF+JPxPXpfaFUOQ9x/OMBIxGCUN8m0fwdSO2lw9UmaxgTSu0LUc+VG
         zpzQeEFu54SBwTw/5a3vZMSZ8nrh+fDV8xIy2z1jxqU9//KzoJq4vYex5Iw2V9SYp48z
         2eayrNzEsz9X8/wpap2vpsHkqqCq40vyArcqxP4H2HLW7544L2wg4P6SHgMLm1JHzyVa
         cH8St+39R09/R09pXuSEsr1saPrng479rC89NxqItSij6mO5svAzRu/FLT85v+4fua6G
         T4k0W6lCz9WhDeN0IaChpFUYKGyHySVX1eHa+9e/39zIpHullEhdTld/T8uBaJyUOb46
         +NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165929; x=1709770729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJrxbtjXZ5o0JjkZHH3aEb9P2cYPenOBkdypf42wLcI=;
        b=oApo8qpt/CoNAdJ+42Y2vUaZHfpyuCHdPwDBhN0sde7J7C3lZdmb9U/Zqrkn2P/wPN
         7vO4CJs6QJTOATM9GpRgPu9tt51PCl4rlSMb+bD/3nVmCacDk3KLLDNtHsfsrMhelGn2
         L7zXaeq3hWtRCftoLdMp2o9NRTtzoyLSnFg9v+C1m9D35EjgZcVlmJsoGVttuu6OON6r
         0K70vZDiPDiYniK8vBMiW6/Yr6vPG5F8HNtLp+UMfWUME0C3MvCATDfijSYBn//beJIc
         mnVf29HtOwj7G90Rq6tVMRDS0XmyxO+Y+UEaXWqJjyOFdgyXIcLWKoDMS4vNqwZ1ehlg
         A30A==
X-Forwarded-Encrypted: i=1; AJvYcCXn6xsv+AUso7G/zYLRe5GMSJzaLgxM71SImFmvCAb/W3ANg0F1IMGe0953D7W/oqzlYYPh6ExsFIFr1uqY+Q73kPsGIq+DFfsxu3iS
X-Gm-Message-State: AOJu0Yz+oquCZFuY7Qx988NQsJTrZRkBK4MUnjwxb1CrQzM1msxRTgGa
	8GeDnXkPB14exlkDWzMWELg8AATNSg6VH0oEaEp31r25mQ+j/jZnUNOXDzoBc2zf4+UxPLKqJPI
	adUXRRg==
X-Google-Smtp-Source: AGHT+IEo3RGijORvg0bMyiPUl0pLjQFN4aUVrzl0Qe2gJVNJD3hSooctK9svjYU/OGSVdqBQ1IkB0/0Ggwuh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:4c17:0:b0:609:2455:da6 with SMTP id
 z23-20020a814c17000000b0060924550da6mr154107ywa.5.1709165929121; Wed, 28 Feb
 2024 16:18:49 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:56 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 11/20] perf jevents: Add context switch metrics for Intel
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0ca72aeec1ea..6ee708e84863 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -271,6 +271,60 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+    metrics.append(Metric("cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+    metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+  except:
+    pass
+
+  try:
+    l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                 Event("L2_RQSTS.RFO_MISS") +
+                 Event("L2_RQSTS.CODE_RD_MISS"))
+    try:
+      l2_misses += Event("L2_RQSTS.HWPF_MISS", "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+    except:
+      pass
+
+    metrics.append(Metric("cs_l2_misses", "L2 misses per context switch",
+                          d_ratio(l2_misses, cs), "l2_misses/cs"))
+  except:
+    pass
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -632,6 +686,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelCtxSw(),
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog


