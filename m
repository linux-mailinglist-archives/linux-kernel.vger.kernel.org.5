Return-Path: <linux-kernel+bounces-102821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E787B791
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649322860B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27B179AB;
	Thu, 14 Mar 2024 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDDF1mI9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44B168DA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395936; cv=none; b=BFlUSsfxf5J66VYloi5Hm0zUlgepvLK6lHmjATi2KSJbjGbnUlTTzO9c6f/G5cxt5MWGLt9NFAbsHBKlDuFNGCaWGDOBkviIEtWT/nOC+3i8XnX8nXN/qfuIrcOcZrndP1fwaNq67uxYC0okAc7vLMdUzEeUjGpIPtKHkH+tJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395936; c=relaxed/simple;
	bh=1aTQAgc1+FUV3JZPE25wSRhpJaaZ7z2hEU8jOaHOcOY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=evRNJg1MU8zuvgIcsjIHjeVwi9+TEL3m6chI8brKgEuReVZosfuxAu2cZAFwaqC98nFLdiF9ubLFnWCkbpCArXb5pWRMK0sG0K/1655rb3J+3dy9tv/+FVccCHo5huaEWFZlx6ITLbeNQuMjBDgO/cscF8jw8RnyckrdkgNbBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDDF1mI9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0b18e52dso7643327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395934; x=1711000734; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDtQKHb7FIK3RKA97IRnCPyGvKIoLbeEOtfXenAPU+w=;
        b=aDDF1mI9Jr1dz5FZGsa1CHAlGjmGG3ATW8Fgtb1gmA2wS1+mZDPDRAjtWdA8m7G8bA
         nwtxVWhFvwCUBDmfuPgsaxSWGpf/O3Nv5Tn4Sp3D5uoimXMrf0HCOG0D/pYNmTkpyqPs
         hrlzayQfzmmU+U8txZS8sXdfEM4L1TlPLQOjva2GpKsb3DG/owS/ZvV3cV3m7qudxL9A
         0ySYOu1gGzQF5U/GebGjpeEudnZ7dWmHd0VH8uP9hQRrZOHwakPV2aoGcoNiK6+otkld
         0XfOP6rfiwd8g0kjv/xCE5OB4uXTTspOnlMEBk3yFH/jbRmTMuZzQDvfsQKSrqseey4+
         qZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395934; x=1711000734;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDtQKHb7FIK3RKA97IRnCPyGvKIoLbeEOtfXenAPU+w=;
        b=cS6ckqIB+fS1qArjdCb3P6tdeYBaqjfVeioOlLK/GfMJUzKRLHzX48NfCd8VrVrSA6
         0sU+GTt8SOjg5+IKUBuHN04GO3TAofEbRXtCfs6GkZqslAPo6qYQQyLQDcKgtA0NCwzY
         +9Olk0RWgGAjOutH2++ZZVG5HYIZQMAtpmtvA4fzqqNyUvhmPsBiqIBeQIzJG214Jmlf
         oZNRfKSQLXAUuV5wVibJrunX8JSK/FaattoPvB/eJ0PSfgEPQCzKTIIrfCTZws9x1CFf
         4B1DN9UxtlG6yHG++DbMaQekGzd8pe+18+t85ctCK0hYiO3Wb9XTXw3UoItPlYkQfRF5
         wSog==
X-Forwarded-Encrypted: i=1; AJvYcCV84w96yyn+pV0yQsA9G8WAib3s+2cNmNx5o2j8lf44mzpxkjDRwoiqsGRgNBjj2cz31mmjqPKkUI8ujl5vkqkpEyuGjmuZnFz2LLcF
X-Gm-Message-State: AOJu0YyXZMj3YHtJ2CAjSXtcAdbjEYX9C/FpXClc451AkvaybUYzyyPd
	RfkUcBU4T8HViEfeI5L2ZFkxFySk0K3FVL79pO9qGogT95AJptThuz6K/YDKsSfxeNg1hWPTJYU
	rXAHdpg==
X-Google-Smtp-Source: AGHT+IEJ8B3EIxhKlxB3fmkLM4IXaBlERvuraNfoOEV2xzDcBSpZhi2nZqvRMYbMZYe/L0moJuzyDmxkri/N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:6dc8:0:b0:60c:1a1a:657b with SMTP id
 i191-20020a816dc8000000b0060c1a1a657bmr229501ywc.4.1710395934222; Wed, 13 Mar
 2024 22:58:54 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:31 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 04/12] perf jevents: Add br metric group for branch
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
 tools/perf/pmu-events/amd_metrics.py | 105 +++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index c64470d4822e..90545d4862a6 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -7,15 +7,119 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
 _zen_model: int = 1
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
+    global _zen_model
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
+    if _zen_model == 2:
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
@@ -78,6 +182,7 @@ def main() -> None:
   _zen_model = int(_args.model[6:])
 
   all_metrics = MetricGroup("", [
+      AmdBr(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.44.0.278.ge034bb2e1d-goog


