Return-Path: <linux-kernel+bounces-102862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDEC87B7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111C1282392
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD615810C;
	Thu, 14 Mar 2024 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1uXLqd5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D056778
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396018; cv=none; b=Jf74jOK8FPjTtHmnxRrrCB8FUNpfDq2exbFedPvevkdTTZgfS4XYkV6AvqjeU7wq9OcYPn4QMTmVzQQBPCrp/QqD9MYJCNSz4j3Uj0m+OtuSOAYv6JfuMkuEO9rO5InzTgxjyGxmxBFnrR7JNpkZk7ijxXrozhYxkB1Ck2QBNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396018; c=relaxed/simple;
	bh=0Zo8R254uOIKz9KStTxbs7l4SJp7WcXgFS9ByH5pyCM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dJFtDrIYBGfdjefiDjPZOn6I0e3oODEC1Zir7bzrcQU1DU8OUC6dCOPE6tqF/CiLApxFFWyUh8HB2APNceVN9Vx2IiBKQ0SMw4wJ51AvHFLNzcydaU/xmdfqLMlFE1qE25BWo2hWkPl3sPJ6MLMx+hbQkLn/ooZuM6HRWDQDNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1uXLqd5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fe434210so11150997b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396016; x=1711000816; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDFD9Y18bukkro/r+Y8KdzL6nCPbvRJd0LPXdIXayJo=;
        b=g1uXLqd5FDuR9dBz2U/mk4+wOTrmwWSTDtXqzXeuknNqMOFafbd60rbD/dwaj55KZr
         3DdRWNqe71RLSIue35IN1jcXdanvFh6snQDvKO9kOHpkRChUcECMvIolqR6b5eATWLsp
         8tmmUt7+zaSE3LDCQipDwxiJQpEyewb4b2HrRDWdhfhenu9WeTqwgEzukqIVzCtnKK8D
         a2uCyVqe3iDfnAhS0zIOsCPEQCwHixqC+WYiBQXGoth7xehoQ0u3oec4+r+vmNk/oXEd
         FjhoCMr/4u3S2wllLIiKEZOs9Iy9/TJNBHPRKZ+Isfyrt5dG1tAhKkjUqFHCpo2uaZOg
         AxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396016; x=1711000816;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDFD9Y18bukkro/r+Y8KdzL6nCPbvRJd0LPXdIXayJo=;
        b=vA0GDJxHXNb8WDy8ioSnykY3PSOSOo1nTkz71FpyzYPGtpXSodG0qLoI4WuzYeOss8
         pe4wIaOKwYnSYhmfAGodijzvf56kq2iNra2rAYyIU58TmiS+FqEWd8z0kFBDGnLTVzbE
         z36c3ti7H/otRcPnVa8EOSl+RxHyLJjWgC5n+C0nKqfgAXULZ3k/9FeYUYrTT9aeQCZB
         tny4A9eQlDwvtaPmi6Kl8yTI8W/KeUMSeyJVv9ElxcwLo42eGacXYlQpAiTwcEZ8FKYA
         cbJbb/rJOu925AJYXURpsmorctPs5M/YWcdOafzH04zVNhsAMT5wV4hbuvcHLRBDSXqw
         koPw==
X-Forwarded-Encrypted: i=1; AJvYcCWFvFCr4SuMnn7N3OiWBoyFSLYfVD8nHLEdobrVO4uezgFdXvfTMRkkD5BSmKSQtiiHmeN6jXFWiRYFvq3xsYMaKAID8EtqJVo5pN03
X-Gm-Message-State: AOJu0YyAEqGibFEgFFvdqzfd9OqJk5avRnbUk4GVMYKYWJ1zJbHW4ooh
	lsGtBu6e/sywvDvC3+2Y7wU0DSzLU/IeGHHdkaqXrElN46rcjbri3fP+scn+64PPfr23WRzfqbi
	Rz3FobQ==
X-Google-Smtp-Source: AGHT+IFCCHvmnfwMl0XKusulfjELHvLep8sljrDBi80dV8URe61Da0Q6hQGTUYmLqa19UYC2ZnH6QjGjcAOy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP
 id w4-20020a056902100400b00dc644d4bee0mr27751ybt.7.1710396016604; Wed, 13 Mar
 2024 23:00:16 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:18 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 19/20] perf jevents: Add local/remote miss latency metrics
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
index 6fd45350395f..95b4dd3c175d 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -595,6 +595,64 @@ def IntelL2() -> Optional[MetricGroup]:
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
@@ -958,6 +1016,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMissLat(),
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog


