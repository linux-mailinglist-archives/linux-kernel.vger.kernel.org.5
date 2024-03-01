Return-Path: <linux-kernel+bounces-88944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D4E86E8B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B051D287AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2C3C49B;
	Fri,  1 Mar 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQWq69kw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9E3C097
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318885; cv=none; b=VOfQt1YzKYYPIOZgIIKEVFjMHReJKlGdxBJbXZh4oQKr8iNqNKuwr1RDVAgahtFQDmURDTBChc02K/ILixav8yvsX5/CNluZ+xsCVGijuIiNEYqrPSB4trOwZXbIau7Cb5IhBnoGb65qeYCY45N+O21Ch629TS0WGtIi3Gm38XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318885; c=relaxed/simple;
	bh=Ttu1a53AKHn6jERMdPOWyCk47DSzrYVS6BszAMd1Sa0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QumkMjTJJBC0BHoFW12StUI4TDoQ/NdXKBE0zImk2+PPCV/G+RPESqh6t7XoHngpywkCOWaMsdHQ2RziOcyK8FIknHzQGiz1UUeO6FXICjE4pPT/R/l/ETdTGd4G/AIJL+G7/y2DiLeASRsPk2YoTBBRx4qTG3jZUxdy9rKzRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQWq69kw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so4654337276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318882; x=1709923682; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qpQTOjMlbYqRHWOkfWf3rXeImb6hJen/IuHxVmpGuM=;
        b=wQWq69kwH3Rxc5XR4IZg6z7sSYSQ+gwrT9+lWcLDFtaT3J0HFpU5lOzMQiRyOGrNWr
         SijFzn+D5oWQOnr/MzG2YI6/vJ5H9zuKV0/8Ktxbpc7bCznfq53NydHiQbdcJgOkgvHC
         Bk1pDH7aqDRvrGNFt7pnC17sTbxbQ684n4NSQ4E1ZjpK4e36Z2Q/MyEDgB0L2UlsIU1a
         PnY6hAl00clcfh0D1J65ckUo5VaIeamURn6IkdZPy4DD6LZOIUm9PjXHtW7YzYPYNyCl
         TfI600VoxtXz2UlSYsTfNrqed9rB1nAYIYpN4vU+sZn/EVUrffNu2yLY6mX8HBeraMpT
         P16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318882; x=1709923682;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qpQTOjMlbYqRHWOkfWf3rXeImb6hJen/IuHxVmpGuM=;
        b=kvmaSN9a136mWxiPBHTrLERu8KL+USugcHR5xWb/qu079w1MHp62zKKcea9Hve1ErR
         QmdEt4ERteDBB+4c+Xe8tKgAP786QsZzB8/aNsp1uegYgfeZgdth4yhRZFtuyp7xOGhb
         MjlJQVC6Y+bPa36SGrCPP2YvnujnyGA6Ws9hKXLyuQ64gLcIjrVxBLYKT1zKnvTQx5UD
         Lf0+MamG+mbCeRwC8IVYebaNGBLKPRh7DBFkwyQhTtuLIqfwSAG+jHmQudINRCL414Yn
         OZ8HPYYUinDWudNpIELe4ZO8doXjg55LDLJwgOqTTiclyVHhO0owDN0VJVgaesOtcoHc
         y9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb9AJ9NPqkZiUgtsMP5Xk4qfOh5cXqeWx1T6fhHrikMvECNZaLdJ0L9RzHoU1euFwMesFbjuCHUgd9Bfnlp78p8WGnicl+A9BoqtFg
X-Gm-Message-State: AOJu0YyucXpylPu/3cLp3HH5WL26Vl8lN46WbDFSEg4He83xDKBXIz4X
	Cuz9Qc6jYUqmRRvP7SdCThmtznYwxl6tndIRJd4vS029FGMx53YGPECJ3xwpq0KxdEZnPt0Qapy
	eW1/dWQ==
X-Google-Smtp-Source: AGHT+IHyhUpYurt4vD+rrB/joKVLTsWMuBKF3q9/HAOBpTvjJTE86OHEg3O7FWiNyP92JukvKjLFOJ2CMZAZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:f0b:b0:dc9:5ef8:2b2d with SMTP id
 et11-20020a0569020f0b00b00dc95ef82b2dmr530873ybb.4.1709318882598; Fri, 01 Mar
 2024 10:48:02 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:32 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 07/12] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index dda904998269..82aab39c2a50 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,52 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+  l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+  l2m = Event("l2_itlb_misses")
+  l2r = l2h + l2m
+
+  itlb_l1_mg = None
+  l1m = l2r
+  if zen_model <= 3:
+    l1r = Event("ic_fw32")
+    l1h = max(l1r - l1m, 0)
+    itlb_l1_mg = MetricGroup("itlb_l1", [
+        Metric("itlb_l1_hits",
+               "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1h, l1h + l1m), "100%"),
+        Metric("itlb_l1_miss",
+               "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1m, l1h + l1m), "100%"),
+        Metric("itlb_l1_reqs",
+               "The number of 32B fetch windows transferred from IC pipe to DE "
+               "instruction decoder per second.", d_ratio(l1r, interval_sec),
+               "windows/sec"),
+    ])
+
+  return MetricGroup("itlb", [
+      MetricGroup("itlb_ov", [
+          Metric("itlb_ov_insn_bt_l1_miss",
+                 "Number of instructions between l1 misses", d_ratio(
+                     ins, l1m), "insns"),
+          Metric("itlb_ov_insn_bt_l2_miss",
+                 "Number of instructions between l2 misses", d_ratio(
+                     ins, l2m), "insns"),
+      ]),
+      itlb_l1_mg,
+      MetricGroup("itlb_l2", [
+          Metric("itlb_l2_hits",
+                 "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2h, l2r), "100%"),
+          Metric("itlb_l2_miss",
+                 "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2m, l2r), "100%"),
+          Metric("itlb_l2_reqs", "ITLB accesses per second.",
+                 d_ratio(l2r, interval_sec), "accesses/sec"),
+      ]),
+  ], description="Instruction TLB breakdown")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   if zen_model <= 1:
@@ -316,6 +362,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdItlb(),
     AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
-- 
2.44.0.278.ge034bb2e1d-goog


