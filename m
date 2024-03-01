Return-Path: <linux-kernel+bounces-88941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45786E8B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B110A28779C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C173B798;
	Fri,  1 Mar 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yH3OGAUy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11812900
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318878; cv=none; b=IpL3jwUgegvCZblOafEucULCNyzuEoLTywP23lWAvXXhJMwu3q7AM3QC++HPhq5m5fcycbTlnxOVSfRSgDPCHGFCjcGCe3+1L60u1qrt3VJ8j/O5RQRs/38/E4Bpm/oR2b8jnSjBRmuuxqX2W8YhEUU3wonkjt2RjKdKRFmtok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318878; c=relaxed/simple;
	bh=YIxmuBzBhglh4md55W8onI4xgQ9tn1Wuzd6FPGsaM/I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Gd7ouPTeAlXjDdHzIAM9xEJ4aK6XE3rjAUJyrQHw5sd/4vAEWazpEm/dXRquXwZWl5fVcB0EWyqM+Vgg93rzELdXWdEQgeALihHzG6F5DGwRBc0XqxlCfghAE3ooXLBd7Z/TieTSLJl4w08nhNem3G/PfOFgmvMZlj41rodw69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yH3OGAUy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60942936e31so43519337b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318876; x=1709923676; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWgiWiE03exBg0PhwlQIGByRAV21o9JQjLn06/BhBfg=;
        b=yH3OGAUySB209hsYUXvNYToJJzxjq4DTKItQNGML61GQ5U64i9Cp72Sj9rX4U4WwBK
         YaGOxcmgNuS5hWIZUxOu2GfqZU1OiIIsLjlRcubZ3411LizS38zwv5iDL4ilRdebCB3F
         OjQUieCT6HZG5QhVrhUdCo+7efXaenQpeIKo/J7IaGAL3yzTnM7AQrIc7BSOhaS6nj5v
         bAkLr7b9T577qn7zX0gq6J3BPXR1YZmt+zGMuljCAP9Qt342Xc+HPfq2hpzFM2xlH4If
         ZpIwM4l4ss4ogAMiW9ezIDarxGfkrykZlUPjGhGJPTEwPbTI/Z5qblTlXdnJIRpmVuKE
         /9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318876; x=1709923676;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWgiWiE03exBg0PhwlQIGByRAV21o9JQjLn06/BhBfg=;
        b=HWpXpuIUjpT2DdE4eUfCP3HeIdRP/chIbJA8OoeoJiyntv2mnNuSFMz1DIXuuLuJ5H
         c4fnP0/4y4RTm4fKuOVYBbZ7bbxkLL7q6JA9p+fxhTdOcaXoES+7rkp/QUQmuzdqa2MX
         JPaiaRCAtXLHXmpnfSxENOWWD+JdgsHcaC69hiKL/KhXsO5gkakMa59JbwVKC9W7eeal
         eSYjUM/JRK1hQzYHFpe4GuLAohk5SAmQ44+VacXFn839iq889t6tDaP0DYUwvbbY9Nod
         kNM3B3k7YqtO+OlhMHeRKxy78Lu+G1Tl/dl44Dqc1zSzPTC1RNUGXx0fZSybkkLscMy0
         GlRw==
X-Forwarded-Encrypted: i=1; AJvYcCUtdEnxt0r9gohHP0bUFq/FsUiyTNYL/mRfInbnywCOJcCIIN2sgV3PrKwBKsHwBx+T70rtvROxBFf9R5E3Q7ofjVR90e8pfy57cYQ7
X-Gm-Message-State: AOJu0YyVYsXLvVcTlmG1QYJz91pE/PJPe+hpKdkHoXIjCEQ1l/pOgZjM
	R/DhU8Cxpku2XI/6HoRV8dJNSw4yKpZb0dWrjKN4Wm222HP2qHW+BcC2/jXIK0PYLdkpAXLHL9u
	SAVUzaw==
X-Google-Smtp-Source: AGHT+IE7pj32x6WrVCQQM+ysloCim8gCidK00gD6ABKPAt9fXyIR1B+Q0/OzmRUrOXeRT0Qj+ZfM1R4+pLJ5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9809:0:b0:609:2031:1e09 with SMTP id
 p9-20020a819809000000b0060920311e09mr600157ywg.6.1709318875876; Fri, 01 Mar
 2024 10:47:55 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:29 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 04/12] perf jevents: Add br metric group for branch
 statistics on AMD
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. The lack of conditional events on anything but zen2 means this
category is lacking on zen1, zen3 and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index ce3d1535483a..f8d5ba2861ee 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -7,6 +7,7 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -18,10 +19,112 @@ LoadEvents(directory)
 
 zen_model = int(args.model[6:])
 interval_sec = Event("duration_time")
+ins = Event("instructions")
 cycles = Event("cycles")
 # Number of CPU cycles scaled for SMT.
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
+def AmdBr():
+  def Total() -> MetricGroup:
+    br = Event("ex_ret_brn")
+    br_m_all = Event("ex_ret_brn_misp")
+    br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch", "ex_ret_brn_resync")
+
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_all, br)
+    clr_r = d_ratio(br_clr, interval_sec)
+
+    return MetricGroup("br_total", [
+        Metric("br_total_retired",
+               "The number of branch instructions retired per second.", br_r,
+               "insn/s"),
+        Metric(
+            "br_total_mispred",
+            "The number of branch instructions retired, of any type, that were "
+            "not correctly predicted as a percentage of all branch instrucions.",
+            misp_r, "100%"),
+        Metric("br_total_insn_between_branches",
+               "The number of instructions divided by the number of branches.",
+               ins_r, "insn"),
+        Metric("br_total_insn_fe_resteers",
+               "The number of resync branches per second.", clr_r, "req/s")
+    ])
+
+  def Taken() -> MetricGroup:
+    br = Event("ex_ret_brn_tkn")
+    br_m_tk = Event("ex_ret_brn_tkn_misp")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_tk, br)
+    return MetricGroup("br_taken", [
+        Metric("br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%"),
+        Metric(
+            "br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    br = Event("ex_ret_cond")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+
+    metrics = [
+        Metric("br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+    ]
+    if zen_model == 2:
+      br_m_cond = Event("ex_ret_cond_misp")
+      misp_r = d_ratio(br_m_cond, br)
+      metrics += [
+          Metric("br_cond_mispred",
+                 "Retired conditional branch instructions mispredicted as a "
+                 "percentage of all conditional branches.", misp_r, "100%"),
+      ]
+
+    return MetricGroup("br_cond", metrics)
+
+  def Fused() -> MetricGroup:
+    br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("br_cond", [
+        Metric("br_fused_retired",
+               "Retired fused branch instructions per second.", br_r, "insn/s"),
+        Metric(
+            "br_fused_insn_between_branches",
+            "The number of instructions divided by the number of fused "
+            "branches.", ins_r, "insn"),
+    ])
+
+  def Far() -> MetricGroup:
+    br = Event("ex_ret_brn_far")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("br_far", [
+        Metric("br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("br", [Total(), Taken(), Conditional(), Fused(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -58,6 +161,7 @@ def Rapl() -> MetricGroup:
                      description="Processor socket power consumption estimates")
 
 all_metrics = MetricGroup("", [
+    AmdBr(),
     AmdUpc(),
     Idle(),
     Rapl(),
-- 
2.44.0.278.ge034bb2e1d-goog


