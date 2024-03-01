Return-Path: <linux-kernel+bounces-88979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE086E8F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E1B28751E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C976F52A;
	Fri,  1 Mar 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6G6qI99"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190469E09
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319420; cv=none; b=Je+7opidnwTcBLMRBcoDPAFP9wVzo9nyfVllJg5cAZ7CE14MRXXRrYnAHVdxyAE87lpweeEDSyb9uJhB1e8+kLS3wlvDd5lOlA+jNIACCN2l8+BV8iZucjMGebJNeuN3T1HVqkiBIItI5c4RG40L3BGWPKeOQYQ2350+U3HmLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319420; c=relaxed/simple;
	bh=smAVN/GCgA5/MmqiHaxq1BP/CFOoXWsEkiW9uPTpG1E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pyOnxjy1tpNJXNxLyqQuRV+o4J1mMPLWoceMbU697pKUu45/OHfWrba4PMTJnb4RZorgI/L/TQtyoX9Rru3bhg3Gao0eUrVoStLmKABEWhg9VWmAHuadYqBWO+jaW6IuKnB7iTpajfKasMSPgjMDuAoR96F9Gb4DR0n+zUyzgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6G6qI99; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6093f75fc81so43608237b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319418; x=1709924218; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbLHB0Wrr0NrYcqmEePKnNB9gjFn+6QmEJrv+HDup90=;
        b=t6G6qI99RwYDk8lLd8c+8YQSOw4EvEtnlkSUvumWBJf6eWsWySUW7gl2IylYg5P625
         UfxOxxIPjYv3ViXMhVv5xaw/q9DQ1QNyKz1s9xpGj6lHCATlIJjdd75Cr6d1rxTWaGs1
         r6Xaq9T2JIz3OOit3nDL8KI9z0Q2vPo3XlFRzZ3ilvFW9IxSwrICBFOBjKf3xMhbjx9w
         Fp8k9ARuT+IZi5qENBMRNSKtWNIyRxEdxqCGZvyKUXl99hn0dqmZXDyIFhfAgKZ/SG/b
         0wieEVfPAJ+/R6iRuqgVQEqOdtzuo5T5VfIKkAsnvTOF2y7Ozm/NGPHpNlR3ma6qFxZx
         ZzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319418; x=1709924218;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbLHB0Wrr0NrYcqmEePKnNB9gjFn+6QmEJrv+HDup90=;
        b=xU4fEaWBc4ipQ0cFYOYeaNMRb+zdBt2cnfinxNnIlM7vnh09HJIlY0162I+HMP9Gtu
         eC6bTKluJCDGX+MtKnqSRlvqXCImge1RNEBlijR9bjznmL0NL/LFPXAz5ukkf8Z+Opw5
         lDoDkMFP4zIsERltI1C5LssPmDvJSvm2+2iKgq2pKpq0q+W3cdwr3IQgsnhIXt7NG8qr
         qIet1qTpTz15pnupNetp142Hy08mQ/nMGFCihiaoFWfpZ8u16bOmD3CEgL9brnGLjQe/
         2RHLHNUg4TR3D/z9SpPDNtCphF8h+TSEoM/uCsQF+nPgS2+WQb+ajxhUmyN31R31l/HI
         iJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKkroTKCxqAla1vvsVuSxJFASKHpPNF7VatvoK7hzyrZkJBCslxdNId3FuGt6whkHDO4B059UPQVX98WIYnG/4UhtZOq8V/JiPdof2
X-Gm-Message-State: AOJu0Yx7fZ7Ov1/HDwHvVsXR51Q7tTXuCay15pjz2vRl2iKKHlMqY7IK
	EfBhLXoq5dn5n/U/MwQTLMmzL7R7yBT5bz77pcxb4nSspg6Q0lsqUzQYRwEGInQs3Gr3nGIx0MU
	jegvyLA==
X-Google-Smtp-Source: AGHT+IGPaYTWA7DQPmtXyKutHOy7Zf8bDiW6iSVJS0oNgfz+N591zshd8V9MDXT27vNWrKGa9/wDtpZ6/gv5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:7908:0:b0:609:2cab:1bd7 with SMTP id
 u8-20020a817908000000b006092cab1bd7mr635579ywc.1.1709319418022; Fri, 01 Mar
 2024 10:56:58 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:57 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 18/20] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
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

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8086aef3557a..2e076f695292 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -784,6 +784,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+  try:
+    pcu_ticks = Event("UNC_P_CLOCKTICKS")
+    c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+    c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+    c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+  except:
+    return None
+
+  num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+  max_cycles   = pcu_ticks * num_cores;
+  total_cycles = c0 + c3 + c6
+
+  # remove fused-off cores which show up in C6/C7.
+  c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+              total_cycles > max_cycles,
+              c6)
+
+  return MetricGroup("cstate", [
+      Metric("cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -920,6 +946,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreCState(),
     UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
-- 
2.44.0.278.ge034bb2e1d-goog


