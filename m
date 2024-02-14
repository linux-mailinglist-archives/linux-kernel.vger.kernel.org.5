Return-Path: <linux-kernel+bounces-64636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49252854113
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DB428BFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48016FC09;
	Wed, 14 Feb 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiuJlcgl"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136ED510
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873532; cv=none; b=H/0cmmd2uAd6WO5aIOQcOg+V5GL3CiT9MCJHIZnEH8nB93bA/e3Ikr319/LjyBlcyzW6nMXb/ubf4Vo386Illvv9cGhSoEm2gHxQHZb1AGL4F+F2wuSbkxI0+IV3XEaSKXgIIQtJ6W38LrVITkCvYJtDBy40UMS3JOJ5dT+SUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873532; c=relaxed/simple;
	bh=AFVkYXo1+6MUZA8tuWK2rLAzbr5KD528RzfIiw7rR60=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=R8u4PTbR5oQgoMTxx2EuSrJlhwIpavItqs85Zmflm9jt7el6NZ3EY9uiJ8GVHVm8dg8CwP7bxAhLkMEzjg3dupUO1XH54meSZ7Cyu0JLyD2IC/WSUefibTENa1hCNB4UeP/bEyRZz9lQ33YNu3/sh3DDxI4xLngYsItVb3H+dwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiuJlcgl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so4559577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873530; x=1708478330; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXMYa+hwxkFMekcpnDWRRjLsoFXXEPSgsnGBhBzwdHI=;
        b=IiuJlcglXUDL6RF3I8C78g/Ac3bLHyp9gzDfCIBN/ZUA7G0zaUngmMSpR+06DDHPDe
         BYpi0zrPQXRrd4lNtl4t7cmabllnBO2EnJDboxRlKQZL5rTqOWJGOtvHJ6Q+3hY67u8Z
         76oQzlULrl/Yy0t4Cs4M4Wv+XmKOTdiqcNDjR8t/SqT/8RfIKuHTiL//Q+B8TcvyMzyD
         uxRF7VO73Siyt7d5cRUHnKTbTjBmfd7VdBqTk4UH4OP7l6GxXUTjcn2lFBFC05vuYTk5
         i66lofW6LvaxB54Lfov1hqHV+g/8UcwKwZrXUv7OTvMfRak39rLiZbjqLsO8I9nOwkMH
         q1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873530; x=1708478330;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXMYa+hwxkFMekcpnDWRRjLsoFXXEPSgsnGBhBzwdHI=;
        b=BI0Z+TvJ4VsEvkje4e6oMz+pCQg4peYtTaaVxCNWxTO6zwRhyVTR48TzKlwRPaxZI5
         zdSmJNbGDT6VkGXXUWpVrAdXnZ1Smp/k8Z5sBoPr7zQFRXuVJeOdns3LYoFB4GAkQquS
         uemun10WOT8Zo/QsxxXFwRm3YwJiXubjVc/EGongw9ORWvH5UriLhObZr12Aik5Y2HWw
         0U9hOuxQx/C23NR6+cS8YGs/ecmRod963+1nOapQXj/hee8+OV58tpQdM4XRC0LWzY/k
         V+/Mu/SOG/YfdYnYO/ETiROqvJzj9JauXxMR8UN14G6oAUX9MR3Vc7nNjISHQx+epZJb
         7plg==
X-Forwarded-Encrypted: i=1; AJvYcCWE3TyGxcNM0DPoj8LGGYzFMWZjOPiKq6NVJuIhESx2FSRNhHAxoeshMqDjLfhZXZQ8+zSmLz5zDHw63TBF0cVcx2zmoW1WRbPnMTAz
X-Gm-Message-State: AOJu0YyJML3PB6T3l/5wMQpY8VbI0Jgv+jCnkOTj1yDGetjUq26AJdn2
	E+MNAnhw6l234IKp9oP/TrfmfAQs0t/WtsbBxCoa/UOJQ7sjR1lQNLWzA1LajFMcGvoyoykIp8l
	E6MJYKA==
X-Google-Smtp-Source: AGHT+IGW0pTMv12UHpo/ZYgVugkInsPeqfGu/j6vj/eSF52iI4XBxZjPeTfK33CPWekfXKslnVsDMKKRAsXz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:5702:0:b0:5ff:6ec3:b8da with SMTP id
 l2-20020a815702000000b005ff6ec3b8damr108279ywb.1.1707873529994; Tue, 13 Feb
 2024 17:18:49 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:55 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 06/30] perf vendor events intel: Update haswell events to v35
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Update haswell events to v35 released in:
https://github.com/intel/perfmon/commit/c0f9b34d421941bc3e13c6ca5554e6a54e8bd574

Updates "must be precise" on RTM_RETIRED.ABORTED.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/haswell/memory.json | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/perf/pmu-events/arch/x86/haswell/memory.json
index 2fc25e22a42a..6ba0ea6e3fa6 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -371,7 +371,7 @@
         "BriefDescription": "Number of times an RTM execution aborted due to any reasons (multiple categories may count as one).",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PEBS": "1",
+        "PEBS": "2",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 2e72e81669d5..932d7c094e41 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.01,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
-GenuineIntel-6-(3C|45|46),v33,haswell,core
+GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
 GenuineIntel-6-7[DE],v1.19,icelake,core
 GenuineIntel-6-6[AC],v1.23,icelakex,core
-- 
2.43.0.687.g38aa6559b0-goog


