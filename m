Return-Path: <linux-kernel+bounces-85907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A086BCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99172819B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2C5CDE2;
	Thu, 29 Feb 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L26MF88Z"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651005C8E0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165939; cv=none; b=SelaJQkRU0etQMWGScSvKT5ojtcdY7h5xISm0mNiCrW2rnA+2e79TNI29a+Bc5lFBVCxBzy1hGocWDGo5V+5WnRLDBhoDrdcZcSKcu2djrWx+UUxTLTDyGrmBVc5xh0AhJ6diz9v8NkCDIIrJMhjX2O/bvNy8gLDjtjw9VTlU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165939; c=relaxed/simple;
	bh=Qu4qP63a5Y9CrGCImGaK6yBhwp9wAZMVltq+qFK/h0Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MLsAhsMPDaLcv667OhLbuRuY2F9Fe2CNElsoDR2CEkBYd6SDbyi0yAj2mkcSX21Z5HbhJQo2544Ql5WZsH/q2PsPbrojc6JdO8tcGMb8dvAMbj27YwBrirJk71tLG17yy5eB/78uIn8piMuaLxHapn6+6QJbh+ZqgFPcBNgBLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L26MF88Z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so444944276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165936; x=1709770736; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wt3W9ZcbAW1zDD9azPxHXaT0ia+NyzLn1A0me08+DuM=;
        b=L26MF88ZMojJIDofhZMd9KkyDI4vGYuhVr6qdWGL2YZZ+e42LlE1EIQgGqy7e+z2yR
         0wnghwy0hlKHKV/z9VeVqu9x4L0ydd+zWk95/nQpRFZEjtjSQYQyN0JFs6MPHxd5iB0W
         WnOpfngbWv5Z7Rt8w20if0qJ0w7nqZ5SRZeypQCEx8TZ1NTv3e4sPpDh67sIHX84Sy//
         8bYTxUUr8kHcDOYN9K75AhgX5q0QXL8GWe4EgjmzpVIX3aB/f6321ALnvprBP0wcCZb+
         a+KiZaDLtCLk6a+nnUnmmnbmDRswyi0DzJLnxSe6FgpO4nnfuWw5tY/WhjuT351fxUwO
         d3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165936; x=1709770736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt3W9ZcbAW1zDD9azPxHXaT0ia+NyzLn1A0me08+DuM=;
        b=fBecPoSekZV4eolA2bDEcMRBmrrkAnSY/e3jGk3eEhvhj/NK7+rnNjrd5Qx0HqtUQP
         hUwRs3MeG94AjTw4lgOxplBz8UIG6x2cGEM3az4K8R+pfrGoHHJjKUZaVcIBL6wAUNON
         p2fkDOan5cJuXSDJkKjShTFDbTvSBvQq73Emv0hCPkMboWDKgFaoSzxNfjWqhyqcXsCN
         CsfgpmOpa+7fMK4ibvl80p3bMNlKAefZA6Ya0vV5GX6/Un8uHuclDzM2h4aDW+/Rzmuy
         x0nSls2OqfBKHS0k3+JJ26dbYY/aVoOzZeneh23Mob/r9W0FwgvOSO+hoHuvbVlvbMPf
         Nvzw==
X-Forwarded-Encrypted: i=1; AJvYcCWUvELAvV52feHCA/Zt262gsVFnVOkWku7UFh2ki65sJLHHrDoc+P75BIfOGc6djN5l5CekbXqFbOJTf8NPjND5jNORy2DTTxMS6oqu
X-Gm-Message-State: AOJu0YxaZfPdFUTGgJLUskqhDLpMye2z8lv0i1WcXNkHOA3nweaCcNxu
	AbiVjpDT3mBqOKQ+G34PLzXgIGNiGRAISkf8fU6H3Ev89fNsrb/RelcI9o3eqg8CR8WPWkKOYGY
	6rCZd8w==
X-Google-Smtp-Source: AGHT+IGUBulIB0EcVC9cQ1MEXMXtqcNX6iDWn1TNNmA27BTL87q2tAn8K8mQi2yLo5e07l8f4F0DhycAxfEU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:b982:cfa2 with SMTP
 id w2-20020a05690210c200b00dc6b982cfa2mr42080ybu.8.1709165936522; Wed, 28 Feb
 2024 16:18:56 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:59 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 14/20] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
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

Number of oustanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index fef40969a4b8..e373f87d499d 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -617,6 +617,20 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+  try:
+    l1d = Event("L1D_PEND_MISS.PENDING")
+    l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+  except:
+    return None
+
+  l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+  ml = d_ratio(l1d, l1dc)
+  return Metric("mlp",
+                "Miss level parallelism - number of oustanding load misses per cycle (higher is better)",
+                ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
                                    f"/arch/x86/{args.model}/pipeline.json"))
@@ -798,6 +812,7 @@ all_metrics = MetricGroup("", [
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
+    IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


