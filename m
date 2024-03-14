Return-Path: <linux-kernel+bounces-102803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43787B770
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB89F284EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510E11718;
	Thu, 14 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cqa/Ajnv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799210979
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395488; cv=none; b=TvP69NpyS2MUpNEfYsDRQC1eUDcQbrZYG4H5kw1EqrRTDv+S9iNk7JxsNg9m7SRgIDoqUv7yQoFnOmF9IZVLn58h+XjTDyvN415g6FyQfccUjJ4YsejmNw2XMRgU11uwS8RJhKhNyURFvJxyRX1Q2ADDgCV++kF0YbaDcbonIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395488; c=relaxed/simple;
	bh=0IeSdmWuvcjIVBTAhF6kJkhdSlGmwLTCZHLsTn46VzI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J12Ph1Pf1DAH+z5KMfhV+lbisuN0V7KIYreV57u3caQObb5S2bo9+AU5Y39kd2ikV/L0hI9l8mPocUJxbl2urDigBfJ+uEhdoZDaGiKl1NTAvlH8ywrzBZWQl3YKxxTTsizHK4Gwof2mltI0U6hbJLYYF1FTu91KEeUZS0RyrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cqa/Ajnv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso842557276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395486; x=1711000286; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=Cqa/AjnvWM+D9pUSSoE2IB/bUcFo6AB5XZWJ4zZpT8TRbEsBJ/iQXNUUEw8D7gyrTB
         0VUmM/ZX/3KI8TBQHUo0mh5ZElapr+Ti+c6YUt7gNXm6O2fl0u4wgXDaiceXbFH+J8oJ
         9RlMOEbi6myM5aCeBjk6c+ytJXTsR8ql2+XvpXbSa+dElycdC38EhbxB1crwJnSLCvHR
         CzyjP3niqwTGdLY7HWOH3LgRYGAWNmtCYIHvH+iYrDZObzmf456gbAKKSgJZ16k0jki4
         Xobo0J6AI59rwep/e/GohIL/mznlLxRiA6tUZOFoElgwUEMUDZWKHOmiAJHKHNbgwtS4
         ElDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395486; x=1711000286;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=KxAsiuz/Re2xgKXW6B9pC6UAMh3EoWL0mLKSu4nh7eZMAwPcgpFjOqiF16p/OaGQ7d
         vUQ/v9NLdzSzTHogWW17lW9BLfHXSGyuNJUp32aC3P7iM1UhVEJ+E5Losn4apdNIahzR
         z+qnJPKf49yCzEIBCZV89KN8BDA0eY1oh1Ewv59YSoIRMeCtv947DdjmAyMzr9Z9n8rT
         SNoyCrm6npXWPPzpXHep4IgbSwjPSj8JB9oET2bu/ozsdkgre9dVsevy4L4LE9Qzar0+
         in4fstYYZ/n8NbEdbKJ3lbIUF4jyKq2SW2J6tAiklojiMcdjF6eXK0qwa63fKp4n0970
         fYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAWpj2TVTRkDfDWURBZjyzyKG9+CopLmkO9msdtn5ZJuYGMv0rtY1UrLdBFSE5LvizX5O8KGqbulYgXYmvb3G7kr+2dz9UqP7aKuAq
X-Gm-Message-State: AOJu0Yy24qu4hKNP4VjRVodUrQYsi9y3Ow2OoPlS1yvSZLDiYBg1gsgo
	iWIyqLPhQOenYpbsYewNmplBUUYv5mraG0803B/GigvJ25XzOpfRkvLhAOkRMRMhszt7fLvoqs6
	oYda+9g==
X-Google-Smtp-Source: AGHT+IHH79mYs40F7BUOVmWvFB09LOQpAhVrdOQEbqFP6DpavW8hsUs5XlfpYxn7j1hIau2yyW/X2EXz7AAa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2290:b0:dc2:5456:d9ac with SMTP
 id dn16-20020a056902229000b00dc25456d9acmr34068ybb.5.1710395485890; Wed, 13
 Mar 2024 22:51:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:43 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 04/12] perf jevents: Allow metric groups not to be named
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


