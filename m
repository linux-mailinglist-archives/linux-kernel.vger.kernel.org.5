Return-Path: <linux-kernel+bounces-85911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E786BCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02A7B25BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9155FDC3;
	Thu, 29 Feb 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4xlc3XS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E515FB89
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165948; cv=none; b=TIhwvC6/eSNcfVfbChduA7ZxWQ2n5jD0XkTtci1OrURAe9xbDWOV1BfQR4wWeE5P2ujGoGHGBB0+xE70bY4fLKGmOPTkUT2jW/lDEIuHjmuztt0RkEh1dM2OS6cj9rSRqGAoJzpj6HSghsyupK5ITz8E60ahGgj8je94WNeKaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165948; c=relaxed/simple;
	bh=YXNqPVvmlEQl2UENKfp2LS78R8f/Oi7KHqOEb/B8xzI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sZiCOPiTuI9bLv0vA9yDBja8/Pmjy/akXbqvICNez/M0pJPhcwas+3LBndt7ysVPTAWi88Tob2rprXQwSMPCT/rnvISIPdnRKr57sNX0gsY6APcmQ1f+S8rXDqKXdoqnlYVRdSpM3xFqq3nlP5TnTYLDmaSLCx6D0VTwnnE1zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q4xlc3XS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so506946276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165946; x=1709770746; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ka25JSwa42fEfAhTOfaB0MMLbh9WO0q1HvqA//NrEvI=;
        b=Q4xlc3XSTia1GwWIu8nN9P276UE7RThUVPwR9hbZbxPFfZGqcpn2xhz3KBGXQrBfDn
         JSzDGWp/u6qciDtUHHjd0yarXZLayGSaHXDEJJeNXcaN0neblw9An2ysAZzW5XDGDGRc
         ce/EdhLT0ZakPYUivyZ9jpEVxvejbB/Vj090AfHJooR1GGPX7Sd3cN6oflsQ/54QIlKS
         H5+u/T73nDCdqUnwTmh9HygBC+dypn/UObbWPNxn2a7LphvGzYSId8fV62EZJldLuhzJ
         akJ83nhQWed9nY4mEH44BdyG2VEvz2/jotocxIjjUpGLzEL8FnfeVAoPIrB54+SPO7h4
         PNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165946; x=1709770746;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka25JSwa42fEfAhTOfaB0MMLbh9WO0q1HvqA//NrEvI=;
        b=ohmnhsvGWKsFUISULruB3M8RBLBizkRbIhlLsrjfRmndUXU2PtW04SmtiKzmad/6Oz
         Bs00cPA9+b0/n/TcrwFHJ/DsKOsl6WFrgIIe9FhxK2S7cM1AnlMQ0Sq7/c4qd8EKJq43
         SOPB6H5LeH4ttI6xpAs2vvYVPbu/jAQkE18AQ7aebNKT8tq+OMwoajGaFp5zG6gc/4uZ
         Hz8AQpQLwQBb1Q8MFb0Va68nZjN89Bduc/rCoopDY6lQH9fXIbZrPQIoyPmaLRgdx8Hb
         yHWkOnAeDEBDVsTMvdBup4Gtim+4UCEGiXea+G+5LJvql4sUN2/pa3BOrL8w5zsfRBGz
         a/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXNSOQ07IwxRwVJXQAD4RStJw9fxl/3qwZTVm2/ysqbSMRX9FCBEMVfmAlJZh6WuNLnsrDU42/IBnzY6DwnYV9gFhBN4DEjy96HH2E3
X-Gm-Message-State: AOJu0YwtxIcwJbSklvtD/E2CM3cGFvaMmWIBUGtFV+zCvXqi5Ls1K5EC
	xaHHImrKe55BmLAFhbADjWzjfPkdxf53ZJyD769ctMTtD1PhL+sY5Xq6GulHz9naOYTHhc9DlbO
	++kaU1g==
X-Google-Smtp-Source: AGHT+IE7qOAn33fb6LyFHzyRMlG3Yhp652txDE90NPFvdsr/dtVjuLrjjMFXuYPULSc+eJO1bRRqXl610fKx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dbe:387d:a8ef with SMTP
 id w10-20020a056902100a00b00dbe387da8efmr42143ybt.1.1709165946209; Wed, 28
 Feb 2024 16:19:06 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:03 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 18/20] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
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

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 07aafdf77f79..1b9f7cd3b789 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
@@ -937,6 +963,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreCState(),
     UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
-- 
2.44.0.278.ge034bb2e1d-goog


