Return-Path: <linux-kernel+bounces-89278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C686EDB5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA44286FE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB611725;
	Sat,  2 Mar 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSUiKKTZ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE310A23
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341210; cv=none; b=Raljo1ze8dpsAArjkwV5HAv+nVFfBPGx7E2x0UmeXm9skJa4bHnMCZ6qQOt+fN0ATaHJ+6Q3AvONhpeGAYgr+oM5k5jebSx1w+fbY9aUMi7AQ3r5NUA3jdXxzKks6PqgeEAedHCwllaNyrxuk8PxdDVl/FfbkVeMRmwTbXjYUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341210; c=relaxed/simple;
	bh=0IeSdmWuvcjIVBTAhF6kJkhdSlGmwLTCZHLsTn46VzI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sV+GLo1rRBcZM/AsGgJgGcC2WoqLrxUkzXmBJ3VpPJVDRf08IVuMKyjYOGtJPoNRcgGpRy6uD1h8ZHRPp835nBZDWVKaZCkWGnHoZDu1P/TxZ1sEJWOUVdSyZzYi+amKSO1ttBMG4+wlyXKIfYaqR2kqr4rOKdO8IUUp4mzqJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSUiKKTZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso4064752276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341207; x=1709946007; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=hSUiKKTZMo51O4TPXi6JpFPqXDNBdygWk1alNNT5UMxotiYh9mVdfQhPB97foUdymr
         GdZNLnjq8z2Q8tLWlM1Q2vk4nhV9Rb4An47vFsQVVnbcb0uIkhakLLDsx0H3ojz422vr
         DhD/BoXxAMunHTqXPJ195BYsv/Ak3mbVzjC9Fni3/s5YkIQ4cGpGcgmfBEZPA8V4e4U7
         AI1+2gjO9kx+wbxvdDL06vD7QZVdEh5ONgYkjkv9rb7UqVSbCibY+VAgEshDgSPjEkOM
         d59LTJDnFVa3jYvaFFZT0+jI9pgGNYAbKSzWfSIepmM8TYxUCURGsZt58QAveSQlo4kR
         o6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341207; x=1709946007;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=UaVxZ/+vvUVMMrfvruLTUTJZeSMXxrA+jYFWC3Huso/s9YoTaK2IAYSnXqJrn2L+En
         /11JXTfFCS61hT8Q1tC3KX3WOMXZACAb62o4HNvUFw0ZinckWK81kx1K3gxyHNG8/EL1
         9GNiAQkHxYHTM3pHlXh0B+zQhVFwjEzQVEbEO2dgk/CxI7ID1wOFilvXfFdW1Mvn7KTx
         Ao1bsaaI7PdbfSiFKh7hTw7TZYjusxtiujyKzkLs5MgurzXsdkEMhO3tZhYOYH+O8DGN
         UV9YmLzMh3SbPaYQMgjlcNjOhCotwGhH3DUTRlyFkrec2sCYPHXhgRx0T7n3H3ZSk2Ye
         fG6g==
X-Forwarded-Encrypted: i=1; AJvYcCV6LmaA6OIg4JNpVl/4r4PVDQYHmHjAcVyfbDFzN2dwstZPbSecXqORdlxL4L/J++P+XHQbgQ55G4stp7EuegR8uz19MqIwjURVsro+
X-Gm-Message-State: AOJu0Yz/+cpaQeiiv5O9QZ2Mt8UHh3iZaTQekJ9ozNsLQHlPDnzt/k2M
	Phq/oUp/b3pUl4WK2ZT1mvmo8sxTdxfnYX7tBSqWASM9yRMHIWl/HOfaDo7aQsPjS84u4LsYCYG
	YefBheA==
X-Google-Smtp-Source: AGHT+IEQee9PfjFdXuUYu9MVUX0jdxHct00/YpnBO1NYBsQS8Ffo5pjwxRJKYNCHuvXSoGCpETDnvS0yQNPf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:1142:b0:dce:5218:c89b with SMTP
 id p2-20020a056902114200b00dce5218c89bmr130999ybu.5.1709341207587; Fri, 01
 Mar 2024 17:00:07 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:42 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 04/12] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1de4fb72c75e..847b614d40d5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -455,7 +455,8 @@ class Metric:
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-    self.groups.add(group.name)
+    if group.name:
+      self.groups.add(group.name)
 
   def Flatten(self) -> Set['Metric']:
     """Return a leaf metric."""
-- 
2.44.0.278.ge034bb2e1d-goog


