Return-Path: <linux-kernel+bounces-15785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED4823216
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A551F24C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD031C2BC;
	Wed,  3 Jan 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eh2JebeE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363601C289
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8d966fbc0so7149657b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704301347; x=1704906147; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8ct6VoaAtjOWTSfz3qxb/rNG29MuT41YEGX5EcWiuQ=;
        b=eh2JebeErGDABln5wH06jXVhMKRW/jAwTogEGZitLp6b40BkiPnYtMcabcZPXH9/mQ
         +vZLylagS+2uHwpF/mIh8Fl2MjxbkRHOwD3vh2x1P40g6NFmDC5sepBNblDS2KoLCWaf
         lzeSEs/gI15Ol0pi2X+fGOsUD9KhLllgvQEG7kIH59NsRgcfVj8YX2imsbDp317VX086
         07zz8CgX6pXmkSrN1CEzjlWwQy8FAcWTZeahIEafZxxQ/iBRKQZbQzzizZ18gXeWlNAS
         bdhOh4d46P6mFblbOvx8FPPjQlhab7JmGZgh7snEpnWSpia77hHXCfHtEDw98Zf3hxG0
         7SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704301347; x=1704906147;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8ct6VoaAtjOWTSfz3qxb/rNG29MuT41YEGX5EcWiuQ=;
        b=IOjO52S1rG+nYdhId5FOrZQggmhkqcALpzikOOHE0tSNqw2FW35YVrR/qAUgcF9NEX
         nqipW+WV5GgvacfrVvRdCZXhnO6JjZ8xBYpG7yMD+JQgr/o2V19f0exal70t/8VZPSOh
         nxzEALiTof8g9FXSiVX3lRHRHmU0/ftGSV5roXXLghQHYMhFE8ZDW2ilbXT0ulvAAtpl
         CgqFKKIcaNCyfP2Lkk97KDhp21yLw0RM2RPPRn47yDfMRWFoS7etOd1R4dhQXawVe8v9
         TqmV6wq2pHQivFmUhlO/8NNggJNaftvWhGXWssapHw1tJrODNU5xip8cLm+PLhQqo3ag
         fiQQ==
X-Gm-Message-State: AOJu0YzAArxTD3NB37l/m+TRaZkwl9hIH1DJfUc9xnbi9z94ff574rWN
	74tc6uiDS38SPaw7dvnG+2IufmMeYnURWZjlAP8=
X-Google-Smtp-Source: AGHT+IEidN4jaY+kMawsZbuYMlQREGJgSrIwSj5F0TujEN8ufDJ4J9xpiFUfvC7Jxm6wsDE/lnfx4ZCmnS6o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f607:7105:a86e:433f])
 (user=irogers job=sendgmr) by 2002:a05:690c:3a0:b0:5d6:f1d2:2e5e with SMTP id
 bh32-20020a05690c03a000b005d6f1d22e5emr762847ywb.0.1704301347343; Wed, 03 Jan
 2024 09:02:27 -0800 (PST)
Date: Wed,  3 Jan 2024 09:01:59 -0800
In-Reply-To: <20240103170159.1435753-1-irogers@google.com>
Message-Id: <20240103170159.1435753-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103170159.1435753-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v2 2/2] perf x86 test: Add hybrid test for conflicting
 legacy/sysfs event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cpu-cycles event is both a legacy event and declared in
/sys/devices/cpu_core/events/cpu-cycles. The cycles event is a legacy
event but with no sysfs version. Add a test that the sysfs version is
preferred to the legacy for cpu-cycles, while for cycles we use the
legacy version.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 05a5f81e8167..40f5d17fedab 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -163,6 +163,24 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static int test__hybrid_hw_group_event_2(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == 0x3c);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+	return TEST_OK;
+}
+
 struct evlist_test {
 	const char *name;
 	bool (*valid)(void);
@@ -215,6 +233,11 @@ static const struct evlist_test test__hybrid_events[] = {
 		.check = test__hybrid_cache_event,
 		/* 8 */
 	},
+	{
+		.name  = "{cpu_core/cycles/,cpu_core/cpu-cycles/}",
+		.check = test__hybrid_hw_group_event_2,
+		/* 9 */
+	},
 };
 
 static int test_event(const struct evlist_test *e)
-- 
2.43.0.472.g3155946c3a-goog


