Return-Path: <linux-kernel+bounces-85890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CEC86BCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68725285661
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5435A0F0;
	Thu, 29 Feb 2024 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CP2Sa1r7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989D57334
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165775; cv=none; b=sMS+EJTtHbX5lENdZvlEkHgDkka10rWpFIIfq+xjnqxUlXzn4fKHaGCs+lbh+YZjQu8BCEAYvCUdRU2kPJ5drQtdIYoXdxWP5oYuMHQrPmy69LqzxdYHa2jYyevoDIcVwNvbcQlJf3PjPZ1PExG7tqWNSeKvfnDqWWhCjrWkUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165775; c=relaxed/simple;
	bh=Ws6o7/tvtsGwdgLcPgbopHYfQtUw+y5EJAHJUjeoJ3s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UepjpZEZ92XPMSiu3WkiCISziQOg3XquYp5xlJ12fGnpLFJIkkQHquX9tiq6IqlRheyHi5t+rr9V9U7seKZ1MqPlCD0ZiehMX2RYxWQlwyv5JBw4Aw2mhYRWSoN5JvMuuojQ2F8xZCNo0G2/QGb4DQLm5b/+zbsBu5Nw9j8nOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CP2Sa1r7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so5918517b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165773; x=1709770573; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AfLiGExWQ7LJtXjB9I1zr2EY79Wd3x7GNxPRkAZ0FM=;
        b=CP2Sa1r7lcFvXFJMyTk5Kw9+CFf19L0mh/gqK6+9aMM1xmTrj0cUXPR5Baz0d5Jmhc
         wVC+2LSYJZLKrdGehyKMhEaJnrFd3LmMIAZxRo+PGysxq+qR65nZsb8EpVsMnYwyCVTE
         YRy8fw79PWP8mfNzHNU1ispsc4mUFvw37ZWr+txh8GEbqX5uZBGSCMhuUa+3rmNu00bZ
         qyU8tvGNI8PlxhrQ2WDQ+1BKubH8wC0HGzizyO0Qg1fFucvF+sCulRNFwApewE0jl6wP
         +fFfWnFj706TPbidsdVEI4MT13CW+snNPT+eWocu2qkCTAm4VeqSQnS+ryEbpTwk7Ax9
         l0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165773; x=1709770573;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AfLiGExWQ7LJtXjB9I1zr2EY79Wd3x7GNxPRkAZ0FM=;
        b=BcSa7FhTwamtvwgJpgI2w6T3nfzp6rwSskmgnZJTcydDc4NtxFxSZhWVSaBgvdZShx
         sJ25Qp9xr6VLDL68+4HG7NiUuev7IRVRs5eS47CHGLr7N1Kk2uimbQsHyHHrcjCcEcfD
         AJTshb/Dzg2dv0lJqLqtc0CU6/SLyeqauvEqjZl8ctWKgDwh8OGz5pdTt/PanZUMAjmG
         UXhuheNAAmYwBRI0Zo1AKzwQpg9mr7J0+3uYHtkor084rdgqGsls5alcM+CpqlQ0MzWO
         U/gjvQKe+Bh4f2/dbEzR2ltjJiO8Yp76lq5vCVnMilhwEmKzwufbbxhqCF7GGKru83/C
         K1eg==
X-Forwarded-Encrypted: i=1; AJvYcCX6t8GszXRio441zZc8End3XeZkNiZqm4hlTiaWdRY5Jx5bVn/EhtENxWhJ2UflRSKDY2mXzR7ixdydFscB/aVkswmNZcrjt3Cq8yil
X-Gm-Message-State: AOJu0Yz+rv77pyoS5K6x4xWABhskyI4xlp19RtAaKjUVF/Qpg9dYEU5W
	zlU3bQ+X55MvetDJXd4OROfejX27Hq42M6WDPTl8k/lJN6xhWyEe28BYfN+38qbWWLMNI/oP1Rc
	jfTiR0A==
X-Google-Smtp-Source: AGHT+IFfl2ppkZ2NhKizORHQsmVurAIjOtkG220jnLfGtZvLkBHAnml1/LtUoThBMUVwguYx9HgxzWvpv3UR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:9acc:0:b0:608:398c:33bf with SMTP id
 r195-20020a819acc000000b00608398c33bfmr135323ywg.8.1709165773285; Wed, 28 Feb
 2024 16:16:13 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:37 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 13/13] perf jevents: Add cycles breakdown metric for AMD
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

Breakdown cycles to user, kernel and guest.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 377ce413d051..2def2adf232e 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -572,6 +572,24 @@ def AmdUpc() -> Metric:
   return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
                 upc, "uops/cycle")
 
+
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cycles:kHh")
+  cyc_g = Event("cycles:G")
+  cyc_u = Event("cycles:uH")
+  cyc = cyc_k + cyc_g + cyc_u
+
+  return MetricGroup("cycles", [
+      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
+      Metric("cycles_user", "User cycles as a percentage of all cycles",
+             d_ratio(cyc_u, cyc), "100%"),
+      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
+             d_ratio(cyc_k, cyc), "100%"),
+      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+             d_ratio(cyc_g, cyc), "100%"),
+  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
+
+
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
   tsc = Event("msr/tsc/")
@@ -628,6 +646,7 @@ all_metrics = MetricGroup("", [
     AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
+    Cycles(),
     Idle(),
     Rapl(),
     UncoreL3(),
-- 
2.44.0.278.ge034bb2e1d-goog


