Return-Path: <linux-kernel+bounces-85906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D73C86BCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD5DB24FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A685C61A;
	Thu, 29 Feb 2024 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cv5Mz9Xn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93D5A0EA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165936; cv=none; b=nr3buHyCS7PahX1ulNkCVO9mRez3Qk3cxuYwII1Af3dC5OFHHCsNDEeDGWnse72oG0/3iviDFpWsaJ+rm5Ux6LlGpLWtf28L4cj8/afQOGHDo/JiPsiVL1ZKnrUBRoIGKZjwcO01bQv9eFFf2dfLwHExLhKnBfDI4BI5oIZzPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165936; c=relaxed/simple;
	bh=v5ABchTQpnOktYWaziSCuW1XX126+T9HD5NGgP4r64Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qdQS8FdzDKpslGOQgDtGku5hvkaTf0mBxOU8wqioq0iCkOh1Ni6qn8q8/JVMMmEWw7PcKMDo6oKcwuH8RsrK1wpuubmTcQzOYZ3WJWvgxVRHlmyjaDmi8czFZWnI9sLYDdoAPbcsEnFLXAC9Y9DKI5bMvSd8da39Imvd/Hk0nj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cv5Mz9Xn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so705879276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165934; x=1709770734; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEWMbeD73ltjKkx6wjteD4TdhZhnTqNw+z4QfFdR0Xg=;
        b=cv5Mz9Xn851PoHzwY/s7tDctOCA1uwhB84iMDCNAWRukfJB5/61FSTKs0BUFAZ+oYn
         ABhK2ZAqwsTETsRP36y66QwLGBTGGg3gZR2oJPucKHoXrqi9UFxf9iwWlcboB71s0gvx
         oOknQGF4vB6+boswVezJnRQfgnhoWuRYhDEXW+WfqZwFzT2UiJz3BZAQM4RlM1PuCjrB
         0VkvGCCQKajdsCwsLDJ0t8IcBgwobZw2u6VQRhUnasHddcoh87xiEUZkAmEfKYpHE30Z
         zJoztG8o5CaO/Prq69rhZLP1IVEq/j4jmE2+Hvy4APEv1HnTbeHXBSMU6e2XtGiwN7J9
         OWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165934; x=1709770734;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEWMbeD73ltjKkx6wjteD4TdhZhnTqNw+z4QfFdR0Xg=;
        b=es9CkG4z85dwXvImo463u8cjDdP5zoJdR0WIdDHeg/DNIVyOPXdpj3oQy0tX3+VJHD
         rVTOngv7X5rGwwUc/hKDs+ocWuJ6SvnCT2fJqyNsUF+/6dh+s8/r0qIXD2KS/QlCBLsc
         VwYcexe+MSQTzzbDz5CbPKM3D7ptt6BPzy5FDD1Q6K9SY2aMuT49U2yiMP7n2yEQ2hvV
         No9zQo1q9U4158KqCE5kOwJqS52VlARHZLT54aXrWuC9oNBrU7tpVBhto0Fe2NPhVgJ5
         6tD/ZaHiLjqVOUgM3gqOUJdMtc92BiXdhFJuoDSNDt71c4X2Eb9GF3I+tsaaSwy+o9qJ
         N9ag==
X-Forwarded-Encrypted: i=1; AJvYcCUz514+ssvJscIz/gCUTQIXhAzK8zMD2HZLvnl0114H8zqleWdzq4n5wH4J6a476OpEwzVa7d3mTsqeD9vQfpYRywMEH+dtARu0cKeD
X-Gm-Message-State: AOJu0YwKNw0HQIfApvyeOEUd9oUxB0oERMOfxRIkrq3hzmEty0iTrVeJ
	kaTskZlihob0x2i09gwOb+HFr0R01Vh1ZheEkSQoKiBNxTuR7TqSkUgAGFWYhl/T3LttNpqfwKh
	cSmhTEQ==
X-Google-Smtp-Source: AGHT+IEJb5VW34AwdxpVKBuzoStD9RSRzgrbaIVXVct5TzwAEjIblZgUt1eFNmQgufvv+zH2ji/1rFQJZfgv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a25:b225:0:b0:dcf:6b50:9bd7 with SMTP id
 i37-20020a25b225000000b00dcf6b509bd7mr214560ybj.7.1709165934246; Wed, 28 Feb
 2024 16:18:54 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:58 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 13/20] perf jevents: Add cycles breakdown metric for Intel
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

Breakdown cycles to user, kernel and guest.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dae44d296861..fef40969a4b8 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -26,6 +26,23 @@ core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
 smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
 
 
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
@@ -770,6 +787,7 @@ def IntelLdSt() -> Optional[MetricGroup]:
 
 
 all_metrics = MetricGroup("", [
+    Cycles(),
     Idle(),
     Rapl(),
     Smi(),
-- 
2.44.0.278.ge034bb2e1d-goog


