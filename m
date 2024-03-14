Return-Path: <linux-kernel+bounces-102807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCFF87B774
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62091F2152B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D6179BE;
	Thu, 14 Mar 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqyN+p1/"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B31758C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395497; cv=none; b=XKjBYRtlMgd6LhQSIIPLQVecIsrCpkgkj1MIuKT1LlynhT9T7lPrqp+1aIyGzmUmaLt1LN1E1RjCKAmijvbCWfH194TvfDlyRN7l61Mq0phbrWOKxfR+dr2AnaVDc+ZD1oAy9q4c4EXnzBwU/FKc6WiGO9qG9XWNN5fj+djlXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395497; c=relaxed/simple;
	bh=KBRLOPIttIVmUTXmYYpZ5y5zAjJINB3dv9EpY8rLPGk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DXE6u61TajIXJqrF8Vb4NsV2qu3o3iowtcTrrcXfuFr4OtUnPHL9wT/LtUJS1NvGe1cmipHhEUXTQK/lB0+A2TsCOTIsG/4COzKgQugSbPAMixaLhMt70HjMg1Wew6hz/o01/S5W/kfWHxfPXn8EWQeG78UrJaBGAsPf8PYi0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqyN+p1/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so648142276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395494; x=1711000294; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEuSAf1lkMchEU55uC9f020RZIQvzTohuVPV0uKWKVI=;
        b=iqyN+p1/fsXvaY6NdOvI0iLy5MVYnJwaTEcSfjsceeKGFBBEq2YabDH9X8r6gKeCXz
         X8IRl7TBJwUaYRGW/SY5Scm0o59HQiFXdNm5GqY5dVk70d3VXeiFRurpUVow9GWa/apI
         RYuw1fonkvcbugukNyYPS/Ut04RQtKAngSJcHezlYRQlrCy6JGz4k8tF6oiFYVxfWDd+
         +aoV+96Yrs76KwrfnrxDvDyKAkrSyNnl1xNxmea3grBmsCLsLKfu/17BZZ4Dp5740Zuz
         ARLtYEFKLJE4JH5wbYCDE5w6WYdVx1Xu2GXaY3ef4GIxEidefS7NQKqlsNS3iURGPCRm
         ku1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395494; x=1711000294;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEuSAf1lkMchEU55uC9f020RZIQvzTohuVPV0uKWKVI=;
        b=Nv2WyP0/26SgvbhoIFiII3HU3PulOLUzkpWWQV0c4gtWwAu0US52MKo2CI4oLUNC+u
         WxIU4q1aNqm7SmrqBfY0p+S2YYU14jQYEXZDWXwMcEF6I36amgmTqeX2bnpP+Hz7yky0
         jr7sRJpJUrwCwdKfNoKhMv3z5ZW48aTd7LIxky+XacZqJjUqajx7CDtHIQc9BXoqd5kK
         gdo3XQtIXmeOz8ZtMb7Zpb0Vf2z6AsMCXXhAn8u1Q2ptE/OBwysRV5Kp0Y3OON2ehU7h
         dRQl6zlz2enbcD4CKJYjCToZyz/Jc7AVqO/6cSN+9ytrTZ0phKW52UXzBxfOy5u66bF+
         4tqA==
X-Forwarded-Encrypted: i=1; AJvYcCXAS3P93bKzd9YOVYdwedTJ6XNoDKwl4L+Pzn6+XEVMyhv/izfWL/gT6Gnzrw77jgn3wcmt2jIN3NMMv/vAV5AcKmNYODZgJjlFO58O
X-Gm-Message-State: AOJu0YyWkOi0cnWgolUdjLDCrRraIx2qNR2tWBnGG59VyyFfDp0fBBi8
	NkZBmFBt1WovB/yfoJsIxGp3D8N8ozYubhSoG7uTNDGelQD3DYJhVSNhgtArw0qlQb35IScxK/J
	/nlAHzw==
X-Google-Smtp-Source: AGHT+IG0CL5cqXQIbZ1eaywOmmX+tgnH+dpd1oudAB+T9cu4RUKk/wH22kkWUmezUlgBl5zJvsLXxla13pjm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2503:b0:dcb:fb69:eadc with SMTP
 id dt3-20020a056902250300b00dcbfb69eadcmr20395ybb.6.1710395494388; Wed, 13
 Mar 2024 22:51:34 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:47 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 08/12] perf jevents: Move json encoding to its own functions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Have dedicate encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e81fed2e29b5..b39189182608 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -484,15 +484,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -523,8 +514,11 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    result = []
+    for x in sorted(self.Flatten()):
+      result.append(x.ToPerfJson())
+    return result
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -533,7 +527,23 @@ class MetricGroup:
     return result
 
   def __str__(self) -> str:
-    return self.ToPerfJson()
+    return str(self.ToPerfJson())
+
+
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
-- 
2.44.0.278.ge034bb2e1d-goog


