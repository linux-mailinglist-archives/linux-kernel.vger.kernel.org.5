Return-Path: <linux-kernel+bounces-14907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195A7822464
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88CC284331
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD018050;
	Tue,  2 Jan 2024 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj4rMXUa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6D18036
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdae92c10aso11766701276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704232671; x=1704837471; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeBLjYeUzVvGXpYvoerCoIh5W3LL/y5Nyz5E/CMr1+M=;
        b=Xj4rMXUanAK4Y+9kZ+tLgszsSp4Q+T/gtWEFz7dx79dAprIueUv1EZXuD0ErgKScyg
         HdwODm43yTQdjWRTdiJ5IaK4316GlWgGhgWWeTBeSc+kP2gQmKzVaOuqPUPXTCCBJABk
         f9sIbuR4JdoZAKCcNcNKZI+uPQ75lwdpOCPisGomUZen+HzpEUOmPXpIZLZLNp6ViOw/
         TRpdsmq2gaZLphbMcv+cA6AhVySBHtk/dEyGx/vOn6PATN4VmOKNsq4QZN7OkIzv1yS6
         CjisvcihVX762rTyJRhALHtSynm2OrQkBYhHBXnwjjp2KpTrYnKEZGH/c8avi6P4Mev5
         5gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232671; x=1704837471;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeBLjYeUzVvGXpYvoerCoIh5W3LL/y5Nyz5E/CMr1+M=;
        b=UiAby6Xoou7etgx/y6toa36EUc9giRoQn7ePBv4lH3z/dIzSt0ueZXlQvyE5FbxzMt
         btUF4owCAo57lMu78pQzG71NSbXdhDRvnMMBIjCAhxPNwMfvxF2rfw6a5ghnNf46DYRv
         D8Pe8j8zVCQ7MI2OF2GLclbswJdQkGcDnRw3zP19g80K21sZjwyUVKSzd+G/8WkH2peV
         cI1+W/8h/sooyBP6ejHuxhYK0rIBy9nrKYgwwLNDn/6oN3oB2Mbl9cJZ/aX/dZy4/oEg
         h4kr1+JsFYnBe7sJheWH7mfBeTNwgk2NSRsMi3qfHOOBaDTcA0KEiPmJ/A/3tOoAr2mg
         etrg==
X-Gm-Message-State: AOJu0Yz847+pthZCOpSO1N6EbnBj7EW0oIZDghjcN/XuXrQ1Dkm6hznc
	vmto7W3EcbZgVUyLtTTdG6UAkL6CIvQENYtXLpA=
X-Google-Smtp-Source: AGHT+IFEQPSm0ADT0ReVTgngHV14SjJnghlnq0H4SAGNO+8sOnWmB2i+R8qvSQI3Xv3M9RlGgdKaCXCz9/yO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a25:6852:0:b0:dbe:9642:8df6 with SMTP id
 d79-20020a256852000000b00dbe96428df6mr405018ybc.6.1704232670871; Tue, 02 Jan
 2024 13:57:50 -0800 (PST)
Date: Tue,  2 Jan 2024 13:57:32 -0800
Message-Id: <20240102215732.1125997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1] perf x86 test: Update hybrid expectations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The legacy events cpu-cycles and instructions have sysfs event
equivalents on x86 (see /sys/devices/cpu_core/events). As sysfs/JSON
events are now higher in priority than legacy events this causes the
hybrid test expectations not to be met. To fix this switch to legacy
events that don't have sysfs versions, namely cpu-cycles becomes
cycles and instructions becomes branches.

Fixes: a24d9d9dc096 ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index eb152770f148..05a5f81e8167 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -47,7 +47,7 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -102,7 +102,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -171,27 +171,27 @@ struct evlist_test {
 
 static const struct evlist_test test__hybrid_events[] = {
 	{
-		.name  = "cpu_core/cpu-cycles/",
+		.name  = "cpu_core/cycles/",
 		.check = test__hybrid_hw_event_with_pmu,
 		/* 0 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
+		.name  = "{cpu_core/cycles/,cpu_core/branches/}",
 		.check = test__hybrid_hw_group_event,
 		/* 1 */
 	},
 	{
-		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
+		.name  = "{cpu-clock,cpu_core/cycles/}",
 		.check = test__hybrid_sw_hw_group_event,
 		/* 2 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
+		.name  = "{cpu_core/cycles/,cpu-clock}",
 		.check = test__hybrid_hw_sw_group_event,
 		/* 3 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
+		.name  = "{cpu_core/cycles/k,cpu_core/branches/u}",
 		.check = test__hybrid_group_modifier1,
 		/* 4 */
 	},
-- 
2.43.0.472.g3155946c3a-goog


