Return-Path: <linux-kernel+bounces-102825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC887B795
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DF51F23580
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1081865B;
	Thu, 14 Mar 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BA6Rl4Ng"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C318044
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395944; cv=none; b=D4wM9zGxhwlXSPqktwjBc7UIw1TBv9JP4UFPUtD02MVAahAG4FfuS3hcmZa36zCGNBRnZmqvMKfRQeG5LHNUGFFJRFiOsfVGdEBSH987TxIgrUQBz4do8hp9OUwQT3LrSvFiEHgecg4v8njcSDuZhtG21yDHmucjEU3FlMQ4x8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395944; c=relaxed/simple;
	bh=whMVmxF3NoYz6Wx64jZe95t16CbQJLeON0KmO6ONXNo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=USxFp5SmarW0y/LADIm+k0XUKor8INIyUQsE3nk4kvQbBPpjPkmOW//HowPFTwDif710deU6tiqsyZvGrFh00T82DUniF6VcBCEFaKmquQ434Ij3hioDp18qnLuAjnB481828t0X0VRBhsKYy++gKdLo0znBaUv8NVIMBOs1GxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BA6Rl4Ng; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0815e3f9so10277747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395942; x=1711000742; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AScvNp0fYbHG89nkyRKQajNiisdR6SwLChBrHvGyhcc=;
        b=BA6Rl4Ng0vnBae80umvCxBknVss+ZLbp7Yz/SWwZTk7IwLQ+wOs65KcFAHPqBP5rNE
         XBeBQ0N8zJgi1h2p33BKL1zeqP0/ZnRzbno1t3lLhMHqAmZeSn4+KI+uLqKjX2y1DDbA
         nVrtO3GHCNL30WT7IB5uYfGhJxD1lfAJF5w40EaVkEQfm4Ysrbkp5wHVjIlflh59/NLp
         wpLHVosUbpn1WiEcPeCCmnOqJzma7XydPyPRWTKbAzteL3oVmW9rZQw5Xh+SrAp2LgIX
         TudOCpXnSyiT52G73ihG0k5rGYtO7Wa+SYjWfaBDEHMr4a80vQcrPrukelNSLyTdCeys
         RJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395942; x=1711000742;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AScvNp0fYbHG89nkyRKQajNiisdR6SwLChBrHvGyhcc=;
        b=lyKAoJTcWHqthnCK6GdWSFTpPDM1nc+U9juJP2hSMxo1GdGMxUKx/nZKhtZb3k7mcA
         3oIOIUQr4EqnOz/1y9oq5wRKcXqWNGB7LhSuEPP74z/Sn7chI1EOg39zOWwYvdMyUkBM
         y98+68mIqGZRBGBSnrXrjW0uPnqQ2GilmvRPJhkmvnKJbx3JxKhgiRM5+JyYX8bXhHQL
         sZCeO6h/OpR8Uy6OHyXW+4BPbuPjZwbTYkflrsoWNbDriMN/sYeKzbm7mQqIgg24I2fS
         Khqr2MNv4dlY8b2cHQbiUp/WpgItAYAmUFhvtIQhdDcIZoYOYJxNoKuHJS2ru/pXKF6d
         BCjw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQooyDXDKbNnn4pX1qkEZfnlHVjMP2WrW30fddGnrlHRHcC/62KXHl1qZ0V/1EGu4Ml5GC0cf/9elrnBhSoxEeDSmbZrSmYejPqp2
X-Gm-Message-State: AOJu0YwBFxLffviaX1cIbyQaVQA2csH29dbFxrr0rAoRt9kyBZ+SG7mm
	mvGMoMNnfPFARVWto1+YWEogpOT/vqyQlMJGoko2Bp73H9ucdWPG/dI1fBMw/VHwgfc+lYOYuNp
	TlnSoCw==
X-Google-Smtp-Source: AGHT+IFFkMR91+4WamnF5jU1jy66HUh37ZDG5SlCY/q6Kc7cyBxemp5moQUFnelv0KCgKJs0ZPJ7qApHXmTd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:4886:0:b0:60a:66b9:c089 with SMTP id
 v128-20020a814886000000b0060a66b9c089mr149852ywa.8.1710395942348; Wed, 13 Mar
 2024 22:59:02 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:35 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 08/12] perf jevents: Add dtlb metric group for AMD
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

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 519aa9ab8801..1bddfb939597 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,114 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+  global _zen_model
+  if _zen_model >= 4:
+      return None
+
+  d_dat = Event("ls_dc_accesses") if _zen_model <= 3 else None
+  d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+  d_hcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if _zen_model >= 2 else 0
+  d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+  d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+  d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+  d_mcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if _zen_model >= 2 else 0
+  d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+  d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+  d_w0 = Event("ls_tablewalker.dc_type0") if _zen_model <= 3 else None
+  d_w1 = Event("ls_tablewalker.dc_type1") if _zen_model <= 3 else None
+  walks = d_w0 + d_w1
+  walks_r = d_ratio(walks, interval_sec)
+  ins_w = d_ratio(ins, walks)
+  l1 = d_dat
+  l1_r = d_ratio(l1, interval_sec)
+  l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+  l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+  l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+  l1_miss = l2_hits + l2_miss + walks
+  l1_hits = max(l1 - l1_miss, 0)
+  ins_l = d_ratio(ins, l1_miss)
+
+  return MetricGroup("dtlb", [
+      MetricGroup("dtlb_ov", [
+          Metric("dtlb_ov_insn_bt_l1_miss",
+                 "DTLB overview: instructions between l1 misses.", ins_l,
+                 "insns"),
+          Metric("dtlb_ov_insn_bt_walks",
+                 "DTLB overview: instructions between dtlb page table walks.",
+                 ins_w, "insns"),
+      ]),
+      MetricGroup("dtlb_l1", [
+          Metric("dtlb_l1_hits",
+                 "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_hits, l1), "100%"),
+          Metric("dtlb_l1_miss",
+                 "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_miss, l1), "100%"),
+          Metric("dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                 "insns/s"),
+      ]),
+      MetricGroup("dtlb_l2", [
+          Metric("dtlb_l2_hits",
+                 "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_miss",
+                 "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                 "insns/s"),
+          MetricGroup("dtlb_l2_4kb", [
+              Metric(
+                  "dtlb_l2_4kb_hits",
+                  "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                  "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+              Metric(
+                  "dtlb_l2_4kb_miss",
+                  "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                  "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+          ]),
+          MetricGroup("dtlb_l2_coalesced", [
+              Metric(
+                  "dtlb_l2_coal_hits",
+                  "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                  "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                    d_hcoal + d_mcoal), "100%"),
+              Metric(
+                  "dtlb_l2_coal_miss",
+                  "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                  "DTLB L2 coalesced accesses.",
+                  d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+          ]),
+          MetricGroup("dtlb_l2_2mb", [
+              Metric(
+                  "dtlb_l2_2mb_hits",
+                  "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                  "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+              Metric(
+                  "dtlb_l2_2mb_miss",
+                  "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                  "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+          ]),
+          MetricGroup("dtlb_l2_1g", [
+              Metric(
+                  "dtlb_l2_1g_hits",
+                  "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                  "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+              Metric(
+                  "dtlb_l2_1g_miss",
+                  "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                  "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+          ]),
+      ]),
+      MetricGroup("dtlb_walks", [
+          Metric("dtlb_walks_reqs", "DTLB page table walks per second.",
+                 walks_r, "walks/s"),
+      ]),
+  ], description="Data TLB metrics")
+
+
 def AmdItlb():
   global _zen_model
   l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
@@ -386,6 +494,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdDtlb(),
       AmdItlb(),
       AmdHwpf(),
       AmdSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog


