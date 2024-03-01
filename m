Return-Path: <linux-kernel+bounces-88980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C886E934
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B824B32906
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97070CDA;
	Fri,  1 Mar 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMQwDk3t"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6416FB80
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319422; cv=none; b=dZNSdwn/rtLHovr0POsJO6aDfX0k+balhIfXWeDfJXEoQu88UvKslgjZ1VAdN0UZechyQuESKyrF3YYa60E7lQT2tp2WVoOSs5yNaQwWqW4/IARzExxdhvxFxIRezAN577xU+B5055oX62Nng51RbXDSme+jqDrodkyAoh8OhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319422; c=relaxed/simple;
	bh=JNlhdQ95scJS1Q2EhZ10SIKN+JTQT447NTNMbhZM01Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RBxM4++zy2uEjsJKA4DAE09S3O/E4QQuVr8s0PvCnEiNpKYSUT/t6lTb+DB+dASiZRvMIuszckO6VhCj16DVoWCO4W681hBFpXhGuGJi0k+Q/Vw/0Mfgo1FhgwGb3J9Af6HU02f9uVuerh5wle7SzgWbn65J1MB2I2S0DZCRVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VMQwDk3t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so3564353276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319420; x=1709924220; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0LitAivSVkSNkxIQWgisNIRh3jWm5LVjR7Wq74t4Ec=;
        b=VMQwDk3trzRDd9c3xdSoNQui1Az+eXf51DIaOPpI1ONuWdAXqNfUmiqjicHfmfDruO
         XB2srp3cAVn5cX26mGXbDVVhub00Td5RGCAXhS9jDnsVRG6hrUJ09uW8D1OyW94GXivi
         Mdy9mbMn0ynhVomEzUB2JQAwLYq2qJpk0HdpCfpwWvI1syhkdwsTiJ+qNFmYkSfM3NY5
         xBvBil+ZN51w1CmtVPg63Fj1DQp8l3hbwe7lRMsaYnnMvenlTY32AmQEaVVErYNJMT0q
         bl6ApRD5qO+E+F3EM/AIq7Xa6LDYGb6U/e6BP5lzebMbZ4Chu068XYPokAeRmscFUAqI
         tXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319420; x=1709924220;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0LitAivSVkSNkxIQWgisNIRh3jWm5LVjR7Wq74t4Ec=;
        b=Q+hL15yyuxGmFu5H1SF26TfRWN4XfSLsZzjE4rf+zdihMhI0bv3Enk76EdOIHegBdS
         jZEH1KEBpD8TaVhbRoSSitxmSnVzh2ZIa+K4s1V2AZkgk1xDMbQ5FMfAyzx+Q14a8klH
         H0cXM+a/yv+WrKyGGpPUB1sVQZPqEB/0Tf02te8rBSbyXqHZLc8gckCYtkzev0kTPB+N
         ZR75S8egjJSRMp+HseJ8m3zkVcpLs0vuIdez+mUbIUjYfJzxb26Bdh7Y6b5fcuBSaS+g
         F76+omvUUSYlAfEzzYPIQiFWb+Ms3d98C7B14jyf7HOnkSLQo4Rh4VflMiepiRrYrS+W
         X0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5WIAWIxPTfoL1ITruokjA0ppBWsKnTHcL2wImqEN+QQOTnaG89w4N1n6ApaJsLqnbvhYXVZY9PrwX9T8puAg/IxFi6eHVNVi9idVN
X-Gm-Message-State: AOJu0YxgEKR7tDJ6hQJuA0hikWTl1R+IkeLHnECT/I/gwYI1DcAm4WfG
	Bzb5naYby5ZJBXWr0M5RFal3br3FRe9nnt+LWtT7Qrlx5+rbTaxAnmvybuCHuiFBhYcwSK1PDD3
	7PK8vqQ==
X-Google-Smtp-Source: AGHT+IFiik1twHkySjCG+q0PZLNGQ+/qXzURw7UAUGAHx92sAQlAJmGQax5Fwa+zn95yKD6Hm3P8+q9WrJlk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:a009:0:b0:dc6:b982:cfa2 with SMTP id
 x9-20020a25a009000000b00dc6b982cfa2mr89928ybh.8.1709319420327; Fri, 01 Mar
 2024 10:57:00 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:58 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 19/20] perf jevents: Add local/remote miss latency metrics
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

Derive from CBOX/CHA occupancy and inserts the average latency as is
provided in Intel's uncore performance monitoring reference.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 2e076f695292..fec8dc23f475 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -601,6 +601,64 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMissLat() -> Optional[MetricGroup]:
+  try:
+    ticks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    data_rd_loc_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.MISS_OPCODE")
+    data_rd_loc_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_INSERTS.MISS_OPCODE")
+    data_rd_rem_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE")
+    data_rd_rem_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_INSERTS.NID_MISS_OPCODE")
+  except:
+    return None
+
+  if (data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE" or
+      data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_OPCODE"):
+    data_rd = 0x182
+    for e in [data_rd_loc_occ, data_rd_loc_ins, data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += f"/filter_opc={hex(data_rd)}/"
+  elif data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS":
+    # Demand Data Read - Full cache-line read requests from core for
+    # lines to be cached in S or E, typically for data
+    demand_data_rd = 0x202
+    #  LLC Prefetch Data - Uncore will first look up the line in the
+    #  LLC; for a cache hit, the LRU will be updated, on a miss, the
+    #  DRd will be initiated
+    llc_prefetch_data = 0x25a
+    local_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                    f"filter_opc1={hex(llc_prefetch_data)},"
+                    "filter_loc,filter_nm,filter_not_nm/")
+    remote_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                     f"filter_opc1={hex(llc_prefetch_data)},"
+                     "filter_rem,filter_nm,filter_not_nm/")
+    for e in [data_rd_loc_occ, data_rd_loc_ins]:
+      e.name += local_filter
+    for e in [data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += remote_filter
+  else:
+    assert data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL", data_rd_loc_occ
+
+  loc_lat = interval_sec * 1e9 * data_rd_loc_occ / (ticks * data_rd_loc_ins)
+  rem_lat = interval_sec * 1e9 * data_rd_rem_occ / (ticks * data_rd_rem_ins)
+  return MetricGroup("miss_lat", [
+      Metric("miss_lat_loc", "Local to a socket miss latency in nanoseconds",
+             loc_lat, "ns"),
+      Metric("miss_lat_rem", "Remote to a socket miss latency in nanoseconds",
+             rem_lat, "ns"),
+  ])
+
+
 def IntelMlp() -> Optional[Metric]:
   try:
     l1d = Event("L1D_PEND_MISS.PENDING")
@@ -943,6 +1001,7 @@ all_metrics = MetricGroup("", [
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
+    IntelMissLat(),
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog


