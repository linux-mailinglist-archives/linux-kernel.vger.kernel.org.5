Return-Path: <linux-kernel+bounces-85477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7886B684
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9C1F24409
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5F160872;
	Wed, 28 Feb 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEQMlXMe"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B815F306
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143003; cv=none; b=DyOwwtFnjYMPjZWYXuEy5Hu7Umv07n/pqBJCUBQS3EdsSi2Vb8Xt/f/P2gsWTxWlNRLoNOmTjMrAZ9Exq5dnrNlV0V7A2jNvxqJi3I12oY3AET4GrRSpLcjeGj2M9osvYRmABe6/PfvzQxGEr7lOZxMrJPgblBVt6TmpeonPnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143003; c=relaxed/simple;
	bh=hLfRLYYEBDGHVllbq1W2MRKFt2uEVseZ3ckqP7HQcJs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VDWSiCrc0f1+skUb1EOONgIY+6Wgdbpz1vtB/8ykXxIjrBjoFlYunRqKpxsfP/zqsmZn5cURE0kmBNNA/BLlLq5eyzNoI3V7EwCVT5QC1gz0WfUeRipfxerfgaTmgBIZ0TDK1j2LRrciBQcDIXptO+CrtsqsJLJ3mONogYzvQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEQMlXMe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60948e99cd4so320757b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143001; x=1709747801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=EEQMlXMehu2kkINHdKC4Nd90tvMYxa42cvHMTpxCitmdYviHQUgpN+hq4ZFrc6hL5p
         qQ8RN9xKRkNh1YwK0hg+cSJhqznjAdT/m2SFIEkF050SETIOeHcqkzjZsdDNdQ52BB+x
         120WcQK22Nmbi1m31nlqNCcj1rGAY6DWb/s1pUtVUnX0s/SLIrRZhfeI2/OIXzKZcNGD
         RlS28cgdukAFdY6OSS6+cS4ahgtI2kP2kwiGH5XquVCN1iGxyU3GVNgmsLBto6KYNvxf
         zZxJAgd35Xm92L8Qsty0WO8KJHtJbF+8o5W6fPY8uIb85jJYOxZw90/S9bPf+Dyzcluh
         j3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143001; x=1709747801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=BodullDRj8Z1uoLtcpbP9K0XtCQS3E3B1OpMwkYwLsPeaQOo/H3wkZCC9gbX0Pspdj
         RnQfuItbCE6Af6kTMkPjUU3qMBFObasyomxj4Uh102JuCe7WIHWmkKvesH/5FCmaIl/W
         QPkGu7CeVdD7NPa6A7GUzW4DOeoxTzvGi9vK3E5a1WcMJNf4S91a9ZMKucYVD1XiVIjC
         9EADDNsMnw3so/J5oX3dJxsFIE6tqTTdhhTZ6SZpqgkj5E7Yyq+3KHyUe5QLwRt9uF/m
         xOi0j3M5ZH1CbeO/2+kbpscrL07RDT/PgWYE1rS1pMiQuxA3a5OFTChNOYz0OVMwK0i3
         maAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/c7JI0niju7XhgDQ5pXMUM5YJuqAkm5CtZP4nwyECXVz3C8l3dvC3gvTblO1TOtsfMBcr95yPR5l9uUQUwAFsFlWCmxwCjqSDWliy
X-Gm-Message-State: AOJu0YwqemKSN6+edO30RgduOUkRokrkXdLRXRaG1RzjkKfOnae5KrxZ
	A0e0Qt6zR4KYzR3xsNJNLizfphTYd6M9gaHcnGG6Yu/tuAbSyWIbE4dFWlcirGyA7YH+z3UK7Sq
	NFGtoTA==
X-Google-Smtp-Source: AGHT+IEq8GXay4myjejAWocOtx6DX9DWikTGDj1T+upRTt2z9E4btVYwgR/ZsPdoTsHZzGcTLK4aFbpA6w+l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:120a:b0:dc2:2ace:860 with SMTP id
 s10-20020a056902120a00b00dc22ace0860mr115ybu.2.1709143001286; Wed, 28 Feb
 2024 09:56:41 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:07 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 02/12] perf jevents: Update metric constraint support
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

Previous metric constraints were binary, either none or don't group
when the NMI watchdog is present. Update to match the definitions in
'enum metric_event_groups' in pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 92acd89ed97a..8a718dd4b1fe 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -4,8 +4,14 @@ import ast
 import decimal
 import json
 import re
+from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+class MetricConstraint(Enum):
+  GROUPED_EVENTS = 0
+  NO_GROUP_EVENTS = 1
+  NO_GROUP_EVENTS_NMI = 2
+  NO_GROUP_EVENTS_SMT = 3
 
 class Expression:
   """Abstract base class of elements in a metric expression."""
@@ -423,14 +429,14 @@ class Metric:
   groups: Set[str]
   expr: Expression
   scale_unit: str
-  constraint: bool
+  constraint: MetricConstraint
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: bool = False):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -464,8 +470,8 @@ class Metric:
         'MetricExpr': self.expr.ToPerfJson(),
         'ScaleUnit': self.scale_unit
     }
-    if self.constraint:
-      result['MetricConstraint'] = 'NO_NMI_WATCHDOG'
+    if self.constraint != MetricConstraint.GROUPED_EVENTS:
+      result['MetricConstraint'] = self.constraint.name
 
     return result
 
-- 
2.44.0.278.ge034bb2e1d-goog


