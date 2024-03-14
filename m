Return-Path: <linux-kernel+bounces-102826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8099B87B796
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25131C224EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CE18E20;
	Thu, 14 Mar 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Si15N7Sq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809411863E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395947; cv=none; b=PlZcQBL+igCrkXQuETlIZZOe3NdF6VCv/IA82Ccbu07D8ECz0G9l8uxOlpflgkvUs9rDu2pFtd/XrwZDCYX1DEbYFOO6f8ltJpQSDSf+tlpRqbKfhmQPRzf0aaDY+A4YbAWdtEb+25oiwpOwtoq9gKLE4INF+aM/RrdGqI5KJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395947; c=relaxed/simple;
	bh=A3qe7dMEX2lXbNeL+sr2/wlfhIFe+L9DGvZJP6pwk94=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H3k8d2C2bw+ZGuoPROj6hUZMWDhIp+tVCn3PPGKURmvttziWjWvRIeAUsPsHuREgS+xDHSuxXwB//HJku7YWP0tfCkHUPXRvk6rlWmnVGtnhFSWRGqkq3Jjryf6jIfgr2QNd72VpEda9CEPwJmyORDQcWxFKJ6bl1HnrefHMmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Si15N7Sq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so913398276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395944; x=1711000744; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NROLFT4HVfPyZQ7YdAuPbGl5r8e13yqyBFaFho3+nMQ=;
        b=Si15N7SqefEE20XoTlFaR+2ST7S2GuTXRS697CZw3NBndnHgZdUWYzTh6V5H6TDr4m
         YnmRJmf0eqK3hFrzhUoE6sqe1Z757jRa0kE78o+Ea3At+EqeFyayi6yFRRRPtoig/Miu
         3ZepVv4Zr30tG/DPGk1WX8xm1Zax32msi7dkoAz7W2tz1LeImnn5I5x0wIzFc0idkOxV
         fTMoljj4vPpct677E3M8xKzbi39MpOjwJfFVbl9vlnnnOsyCMbABMG2Xx7liwVJzLQkh
         IpChl4SbtNub26spUzKQR0xcsQOylJ1C5UGEY3v+aQB5+OBmntkXZnVBj3iJiStgk5mS
         u/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395944; x=1711000744;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NROLFT4HVfPyZQ7YdAuPbGl5r8e13yqyBFaFho3+nMQ=;
        b=Sin8J722NxGUXJMnUp0hvjCT3znRTRud8gWVlqDPTqeZvUe3udK1ffDTptYHiVweW4
         IDn0wyeImX472VfK+HFWFeNYK0NDf8mES1uPaofGURvtH3BIdwqcSTzmi5d3D4AZcK/s
         ucw4lwDJQtKNwqCQJa2EncEVGj846xOhUV3mXn8K4WDBwqAnISuyaiDfcrFJ1NrJoRAz
         drjTB10jHIiABzj1J0N2JsP407maSeJBy/33ntpsBieTEevhTxzUlC8A/tYtlhqBLRzX
         kQ7QB7u+zuuEQsnhDGJ0nnbTobarUQiqODjbkshauvyUfDZAuOtEsDTssqt/CzP0O+XQ
         4Shw==
X-Forwarded-Encrypted: i=1; AJvYcCUeWo3hrY4LHR+jGzdUOYYefatzabIfgDilGq42MebiYlYqjTgn85UJ6OMVMPpdLMF/tAIJOSf6m28dC820c/Ev+YLkOfcO+nm0XvRV
X-Gm-Message-State: AOJu0Yxia/63GFOi1gBOboz934rGLeIeS4wx8OyF/1NZPriJj4tUZgPi
	4fPCCyDra5e75gXkJSycCkvMpVZwKavXTBn4AmgVVIatxFbVsYKuAzLer9++qI4AXkI84JBv+Gm
	svwuxfg==
X-Google-Smtp-Source: AGHT+IEkB6E/HmiiV6NChvaNoFf1Ne5N34wILtWGVdfafUgNW4vqbhRifL/71foolCMM/EeILiEhRu1XtVrP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP
 id w4-20020a056902100400b00dc644d4bee0mr27734ybt.7.1710395944447; Wed, 13 Mar
 2024 22:59:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:36 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 09/12] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 1bddfb939597..79312e33c2d0 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -466,6 +466,22 @@ def Rapl() -> MetricGroup:
   return MetricGroup("cpu_power", metrics,
                      description="Processor socket power consumption estimates")
 
+def UncoreL3():
+  acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+              "l3_lookup_state.all_l3_req_typs")
+  miss = Event("l3_lookup_state.l3_miss",
+               "l3_comb_clstr_state.request_miss")
+  acc = max(acc, miss)
+  hits = acc - miss
+
+  return MetricGroup("l3", [
+      Metric("l3_accesses", "L3 victim cache accesses",
+             d_ratio(acc, interval_sec), "accesses/sec"),
+      Metric("l3_hits", "L3 victim cache hit rate", d_ratio(hits, acc), "100%"),
+      Metric("l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+             "100%"),
+  ], description="L3 cache breakdown per CCX")
+
 
 def main() -> None:
   global _args
@@ -501,6 +517,7 @@ def main() -> None:
       AmdUpc(),
       Idle(),
       Rapl(),
+      UncoreL3(),
   ])
 
   if _args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


