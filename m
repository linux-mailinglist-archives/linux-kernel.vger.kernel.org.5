Return-Path: <linux-kernel+bounces-102806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8087B773
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CF128191C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939D17583;
	Thu, 14 Mar 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhDD+RPh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74216427
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395494; cv=none; b=L3MLibgdVvLhglnGK8CFMkweVAHk/b1YyzCDgVuMg09awBMDPKAVN05GVd7pdp9CRUWYJWVTW7jLqwC0ocn4jIOsM+2vy5r9jn4vm/0Ia6JPWtBTt0g87rgCeFAdKKTPNxppOMZk2uaAMoQ31mjZHbIWvW3rWam3TylAGiPwx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395494; c=relaxed/simple;
	bh=ZXVWxGkn7pnCvmd8l6DV72SPICzKi/Gva//TpBe7PFE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=b2vFgtc7kHg0x8H2XoQw7lTK0SgBIYdOm9Uww+S75sqkcL+ApdMK18bcFeXoWqP0zvlzjFFgYIYWdc3+wNAteIkbNhFe9wjodx92gw3X//rA7xM94NkXqkh4gaLon0fQe3WVF6TQ380eGRpzSNSKYPx4eJdIkn5ZPyOxCBE1Ces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhDD+RPh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so983997276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395492; x=1711000292; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/C1Fptl7F9oJgqV/SnZtPnw4T5ATAHSmXZQvuFpHbZA=;
        b=NhDD+RPh3rHlVtWYFWIW0V7DrUHitrNiDOjKSPAFCokyfEYSIhypiv/y2pc6ziHFEt
         1/+RdNLqHxBaP1Nci6FXFFJilzRcFOAq5aSYHKnnBFAnEFcGQqogkbsqqY5K7N3pVPJO
         D5ip0X+8U5jzBJ107DYGeZ0Y1mMW9DUvVjKpEmbCDNKm0F271c+C5KrSV/OBTv8OnBOz
         FkSWDb4Re3BfeK6q5jMU0bS4VhVbB79Ih6ShuFP1+BcsTdYfj4ihpF2XAMwfvBrQKUiQ
         UtsOTi3+s+AO0cpz1Nuy+qLL+vTmmh7Mirwa09hm/7vAhGactidj927m5FhvXONlmGcO
         kqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395492; x=1711000292;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/C1Fptl7F9oJgqV/SnZtPnw4T5ATAHSmXZQvuFpHbZA=;
        b=ie392BWuSmyxg7gLM0xrk9gvWGGTaITtvwkPjYJD2AGVR6OL6Ca6jTuKGFKLkEQp17
         GG0Q5CHHa7do7ZhmYTPAhA6P2TAUjtaTo1ZFjWInre/4T/672eBivUl9JIKjc+mhkIQb
         646taupkewMDFK1hYT2VS2dKEVWzOtBUvUWqdFZ73lJlmTX/POuDpjGk/CvNP86KcPYO
         pSC2CkUQHuoiW4ns3Ora3OazG0/5Qam4CNHILRBifeVpT/2C+Z855upSRAroLg9z/Fr7
         SofX3IbnXI08RWi94APoX6Bq+SrsVaClhb5+u42sAdU4hN2KiTlyzJBL2LBoQ0ultiQL
         z+0g==
X-Forwarded-Encrypted: i=1; AJvYcCXE9JM90TtZKVZPaJFMOJ1vyeM7vTbbaVeaWmcKNihLJ8rbd1/uAjHAihqcV5unlubXURhu7hsyjtcvQNvZlhCXPJYqk26IGxvWHIDC
X-Gm-Message-State: AOJu0Yy7dMYAjSnWd+LQ2C8kxizYHUg0jwVF128TzmtzIhexlbpDgclu
	ED8FG/m5CXnsndyYRVZPxVB9CiyAICNNwoigFJFriRid5cUdu9ovMcfJeOuMWO0l2QZLxlDHwLg
	F3r7NjA==
X-Google-Smtp-Source: AGHT+IHw6hjxV9hhspQnyQcHkhWwT+EcUhpj579SmRSVmnT7yCS95BNBfP3BMnwEWgPrdRais/+kEfahu9uL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1895:b0:dcc:f01f:65e1 with SMTP
 id cj21-20020a056902189500b00dccf01f65e1mr255453ybb.8.1710395492472; Wed, 13
 Mar 2024 22:51:32 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:46 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 07/12] perf jevents: Add threshold expressions to Metric
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

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.44.0.278.ge034bb2e1d-goog


