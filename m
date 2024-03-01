Return-Path: <linux-kernel+bounces-88943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758386E8D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB80B2E082
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD239FDA;
	Fri,  1 Mar 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Evknf8o/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E43BB33
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318882; cv=none; b=ug/IvV4Bbw7sFS5/qMPm6pL/OMIyrSf9FUuOKhRAdGSH3dsR/rCa79DKZ+05EXSQC3fprpJvstOc+zpKV3FpnQ8jw4gARY/mq8ZgNmk/75d2H/VIDgLDAgE4pQ+5Foz459yVaOqh+Cgy7oYZ0cKC9XV3HxUT5atSKe1DLz7gv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318882; c=relaxed/simple;
	bh=5rPQbQbgB4a9rwpPs3GZO8lIicUTIgfjGCJZshFzKwg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LUXP6cjrZ2a4RCHFqT9QZ7gAuplYw7RBj4fW/aWZ44MZL0efseP/f24ujmwjrDsWLRUHNTa/4Fp896AeYoETFE3G2xH1MtUD1fju6vgHW1XQdOu8ubpNqCphc2/+3sW9D7koPtAZXjPkoKaf44fEabflCZMCVAFz42Vo3MrAXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Evknf8o/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so4185367276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318880; x=1709923680; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbbMwVexzgBT1fsV6th5WqgIzFECec7b7GQZlOqA780=;
        b=Evknf8o/nqyk2JNM7kr8uuxwOFw4tsN3TnEF97Pj2+ODXPRwmBoLjZamMZMiHf3PYH
         NjRFBk3MX6vxd4leLLxZbPtOeK3IirKAMrabqjyW5o4ModALpsKeVZgn185X8MGoLLtF
         skXqSdFkccJba7WT8hB1miExbblFcdsveUSex3ELF5Kk5668f+0j7P8oHsnrwInBpPDa
         LpCr7HL7adFf+D/Bqd+YsBdBySpsShHXVUkdM4Zyy49ZE0DejcL8+1/EYekTxZiK56C1
         X5Q5dd59py0hE7z3Vck84w5Y3te8Mhp4Fxw4mpux+oyDF/A7Rxv+aB3RTq9anvNnb/+H
         msQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318880; x=1709923680;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbbMwVexzgBT1fsV6th5WqgIzFECec7b7GQZlOqA780=;
        b=Hmxd4/AjmlM3dliTMCdslY7Y2VZXDMuxhNBSLjpWyUqfhUbk1hWHX54RhFDLLaE3J9
         wnuP/eeytOL/qcDQucpeIm+ZiFekVMqAMN3So3viYQywRqUotBsTLimwGop1MZanm1SH
         QFXW78dWpALdIZI3Kgx+W+hJ0AhnzhkryVMHHddih36RnWpOGzo3lVi//RFrGFvQUI0i
         MJoj5uFsUrrH1Me+qFEuJXBlIHOfFcKku+PZ/PKxBIYUmQaVvyn2at/tqQiicfgNLgyt
         mFnfImASuG52RbCyAJsx2nzqfHT/ZOEnHizAK4Qcy6+BMGL/zKj+CD56vg7rVGDfKSLi
         aWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTYbbIC+xu6W4uU/APWAZQjnMEro+vWgAhtGGaYt9qKQpKijL6ffH1pbKP+KfcdFnPtuKUg3KgfUq9fMUI6I1hzyn4MIeRjbSoHPqr
X-Gm-Message-State: AOJu0Yz0UTOIhmCIjdabcb8/3Gj6qsU/pRHiaAGTSSKyf8l0h7RMDOp1
	aq9LVNRKqMjEjFuKqFBrjV6deA8H6Aqq9pMuAYAG1PN0DhrmBYWVRb0dOmrpxKEUqwrm+35JpE+
	oTUdunQ==
X-Google-Smtp-Source: AGHT+IE5nxV/pgGxXp00PVwm6AlU+TV6KffKjboinyt9/660ehCiQ+tNob0FZh6YQwufQKBXF7YVUK/ZqTWG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:dbc9:0:b0:dc6:dfc6:4207 with SMTP id
 g192-20020a25dbc9000000b00dc6dfc64207mr528160ybf.10.1709318880106; Fri, 01
 Mar 2024 10:48:00 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:31 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 06/12] perf jevents: Add hardware prefetch (hwpf) metric
 group for AMD
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

Add metrics that give the utility of hardware prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 61 ++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 52451bcb4bbf..dda904998269 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,66 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+  """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+  if zen_model <= 1:
+      return None
+
+  hwp_ld = Event("ls_dispatch.ld_dispatch")
+  hwp_l2 = Event("ls_hw_pf_dc_fills.local_l2",
+                 "ls_hw_pf_dc_fills.lcl_l2",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2")
+  hwp_lc = Event("ls_hw_pf_dc_fills.local_ccx",
+                 "ls_hw_pf_dc_fills.int_cache",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache")
+  hwp_lm = Event("ls_hw_pf_dc_fills.dram_io_near",
+                 "ls_hw_pf_dc_fills.mem_io_local",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram")
+  hwp_rc = Event("ls_hw_pf_dc_fills.far_cache",
+                 "ls_hw_pf_dc_fills.ext_cache_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache")
+  hwp_rm = Event("ls_hw_pf_dc_fills.dram_io_far",
+                 "ls_hw_pf_dc_fills.mem_io_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+  loc_pf = hwp_l2 + hwp_lc + hwp_lm
+  rem_pf = hwp_rc + hwp_rm
+  all_pf = loc_pf + rem_pf
+
+  r1 = d_ratio(ins, all_pf)
+  r2 = d_ratio(hwp_ld, all_pf)
+  r3 = d_ratio(all_pf, interval_sec)
+
+  overview = MetricGroup("hwpf_overview", [
+      Metric("hwpf_ov_insn_bt_hwpf", "Insn between HWPF", r1, "insns"),
+      Metric("hwpf_ov_loads_bt_hwpf", "Loads between HWPF", r2, "loads"),
+      Metric("hwpf_ov_rate", "HWPF per second", r3, "hwpf/s"),
+  ])
+  r1 = d_ratio(hwp_l2, all_pf)
+  r2 = d_ratio(hwp_lc, all_pf)
+  r3 = d_ratio(hwp_lm, all_pf)
+  data_src_local = MetricGroup("hwpf_data_src_local", [
+      Metric("hwpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("hwpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("hwpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(hwp_rc, all_pf)
+  r2 = d_ratio(hwp_rm, all_pf)
+  data_src_remote = MetricGroup("hwpf_data_src_remote", [
+      Metric("hwpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("hwpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("hwpf_data_src", [data_src_local, data_src_remote])
+  return MetricGroup("hwpf", [overview, data_src],
+                     description="Hardware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdSwpf() -> Optional[MetricGroup]:
   """Returns a MetricGroup representing AMD software prefetch metrics."""
   if zen_model <= 1:
@@ -256,6 +316,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
     Idle(),
-- 
2.44.0.278.ge034bb2e1d-goog


