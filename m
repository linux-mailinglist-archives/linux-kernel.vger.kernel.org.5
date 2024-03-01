Return-Path: <linux-kernel+bounces-88977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D086E8F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A2285AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B84F8A1;
	Fri,  1 Mar 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+yRUIUF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465574CB4E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319415; cv=none; b=NMKIIuii+ajmDi7Rq9zk2iBIDuxFhBB4PqBdgqZsrX3eJkuFsA323I8+ReNXtR5h+vPCfCYdq8rCmY+YEwlDjo1pZaNcvfXZcq+BG2fpolNMIsxfetq3TkT0MFOFiDlSZS1lZPKZEQnLSVLBIJ1Ul6HXTu4w8SUYtUKqwZJNeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319415; c=relaxed/simple;
	bh=zsfAdzqNvQWvzalFsOpTfd82DF9L2jXbTJgB7wNHPc8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M6IuXzAOTiHp72q10cm7qIZ385ElXbrB677psIkHU2rL65tgtgtLA+q2Y4TSCTf0PBcPg+duCcuCp6QaEvO5fXBhdg8aKEGnr9br5xWuvREuUm+UdM38T/wf+3aXoXutrfxoYx3PY8Rd5Q0jb0YUptSRZ1aHx0cJfs3EwYCM4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+yRUIUF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6097409275bso30731897b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319413; x=1709924213; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDxjwfTbKIrn1N686Z4rZ9XKDC8dsWniG1Tg4NyRgEw=;
        b=a+yRUIUFKsAJv/B0w7AxZau5Xx1UytXkK3u0j2iJROfZs1+V3G+S10phf/n8yUEwr3
         n2b0hUq5oOZ7Zs+63zWKb4yDHlEq5VfCtvh+8tYh5DeD+0OBVPDckcfzh2eXIIAUEzGx
         +apCXwgzOwPjSJjWBva0cHRi1Xa/aJfO7kQ2rlp+uKgZep+RQZUOtXZVlaygx3pKF9p7
         oLZ6TUoVukkNBsQ2g3LTcYJQeE4I7B42INvCUaCNtUrAZ0y+l1EiV6zYlgdCx1nLnqmL
         FT52innv/qBw6UuIfj5ViVtl6Lc8m4iaI4A3dvgFoP3SSR19XauY/+MYos9oOPcW1gdg
         Orag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319413; x=1709924213;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDxjwfTbKIrn1N686Z4rZ9XKDC8dsWniG1Tg4NyRgEw=;
        b=CpDpMIOq1PjT/XWm0ZZsqmHeQy3K4vtoY7v+Cjehgyx2Zt3RewZIrRC1roRZlh9kEe
         N9k/hH5BYOD+/3uI88/ntIr6YN6OdUr49G2EjrxxVFxLBn0+ixR8eiYG/JDnbP2BvzIC
         ncZUAA7nOxYbMx3jEYYe4urkqjtJq26udfdz9NeaNy9yZI0wtrsW8nArqi3s1Zl0BIZl
         li/Iebe5k32C3Pa3FM1tThkZD4K9sZXlEBEKz8V5Izg4rYxZ0kGSjmtqrwrCqr03ddVL
         pciTwV60ifGJuz4dTbB9bMQ8oHLXNiIZU8q3uolfoJKOZqFOgV1i7RaSIRi609jjGe0r
         CbCg==
X-Forwarded-Encrypted: i=1; AJvYcCU6s/RBD/k5bNNzrmYVyRA3C9wmCIBRYS4VQCPQHmesvqj6aa2SaW9gl5TGf51AfBSDLPZzT8vE0onNKHieXz4O5UeM5JCefgPrEu/s
X-Gm-Message-State: AOJu0YyX6TypmT6MESh86QGzhBod25WJZ3dxLBwPXFmFYZ9sgiiJ74VE
	Vih2e6d5yBcOF2L6VkWOa0lXEWnjnXBaQZMbeJgRxVYRGi96X25yNzjGTE1J4VzN3cQjmlWRHDK
	wjmf3/w==
X-Google-Smtp-Source: AGHT+IFcTTyu5RZjJnXeSWT6rp6vToR2nFN5tVjEEa509a6ZpN8KHnYfYnzjmWPK8VsMEIHdXXVBxXALr2ZT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9a05:0:b0:608:2ad5:cd28 with SMTP id
 r5-20020a819a05000000b006082ad5cd28mr464509ywg.4.1709319413260; Fri, 01 Mar
 2024 10:56:53 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:55 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 16/20] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
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

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index a5d68b7deab3..76e71f11a579 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -784,6 +784,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+  try:
+    loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
+    rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE", "UNC_H_REQUESTS.READS_REMOTE")
+    loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL", "UNC_H_REQUESTS.WRITES_LOCAL")
+    rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE", "UNC_H_REQUESTS.WRITES_REMOTE")
+  except:
+    return None
+
+  scale = 64 / 1_000_000
+  return MetricGroup("mem", [
+      MetricGroup("mem_local", [
+          Metric("mem_local_read", "Local memory read bandwidth not including directory updates",
+                 d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_local_write", "Local memory write bandwidth not including directory updates",
+                 d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+      MetricGroup("mem_remote", [
+          Metric("mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                 d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                 d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+  ], description = "Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
   mem_events = []
   try:
@@ -859,6 +885,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreMem(),
     UncoreMemBw(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog


