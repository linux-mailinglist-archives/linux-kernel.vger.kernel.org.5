Return-Path: <linux-kernel+bounces-144593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF78A4833
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4D21F224E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEE224DC;
	Mon, 15 Apr 2024 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrgtutIL"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2B200B7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162998; cv=none; b=ukUy7K+W8J+bXJKyCa/Br9U7HcetyKgODsH7MnNkwCZK6Z4EgGZm6firIr/MfpxJ7b6/i/YrxBI5rQIeSZ6tOcP4xQSOgclBLR1qev+UB/ebNaCYbEdKoX82SzYP3pQk2r4ZaDMIUEkQKuRUbAS2L3N/1TVzdZiLsRGWPLNRq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162998; c=relaxed/simple;
	bh=O7hIVbr0xqoOv6vBJUBcktxWCtmfzAofbpA7+d5SIhs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aw9b9UjIPQ9Ky29wAMZUMInBpdBHqvS4bribQjwIrJSPiizYjPcST5FXaGn8QLopTRlpZhw30SdKD91SBjDelvYWTfEuTm2+m82tGYNBKmQ9WHGQL35Z5/LnZCP6nvP5P3mD3kN9/CeIkAiry5GedunYDY88FZkory4ZphMttQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrgtutIL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4a072ce28so3082933a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713162995; x=1713767795; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBIPczyGmK1H1pt2G8mgcHP61YsaqzYuWfuwlwliFdk=;
        b=RrgtutILUolHbtiLYDeQ7CZbZ872b3LlbNocS+Hx6FpRHOOeyRY5wLvAQUCgtP80f/
         rIWx3yQPAKNA9UozRK6c9+Cb7lLPPqDqAVqiy4ebspFhVIMUlbOgRWk6gVwpmgGEhly0
         yoc5uYsXIMOrLvn9TW27reVlWkLXAKxAW/FePBVb9boAkxRZCrCHfdoQN7Gq8rwFYBFe
         ejjmQ2ciD2C79XsVRgul3H6X9GU//Yu2/3g1VXyACIveSTWyopXGevm6mFKle+TMKnbm
         rHaP8b6wuAz7cYM6LBKRVw75sTEIZzhnJEBELE0eqPz4whaSpj7FhpbNcJ7Erd9ifX/j
         2yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162995; x=1713767795;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBIPczyGmK1H1pt2G8mgcHP61YsaqzYuWfuwlwliFdk=;
        b=ME4m05Opol7MlRQ6Jm+PA5q1DFb931C3YiUY0uZNpsWqwtu2thqkbpZrY49YF4VvCc
         MLbPy/u9VNGv/EclVaoap90LMZ1WlP9Dk4XrG5ZZdwdo2lGnNW5BUSCYuscTBvXAAEFR
         TOHBH+N8aiYJhaSheiEtBXqplOA0Pg+Z9yVO1o53C76tkoxc8dyT3q9jtNZWeexymhBI
         Sh5LARnPAZDp6c/W/SG+pDmwhsYmtVPfm/og+9+1mRCRs4Fvf+Xc8loq98rY+bglC8eN
         f7I5gNqChFUInJpibZ7IET69bhZIruuVNKyjX9nR47zfJa1gf6zdBH+SN9+B5UR0g6yL
         N4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVIG2nbh/i37G7vm0sbujHuvWQsf2Vv+W9zR04n3g1G8ZElTrBBPOBAtE29ULP5OuUjeZbVGDlLsWtrdzPqx0CZr6l3JBnaLVlOQ2ql
X-Gm-Message-State: AOJu0YxGHrDt1mxLxdvRqFrN22t+2DjP7WTZMPdZjjDCWWEZ8AX9HWKg
	WydEwvNA0ThELESZQITj42se2Q4zRoG5Yy8Di6ptiRRS2rICUUaM2vmS5BpCqF4UAIzTfIUREop
	UlrHehQ==
X-Google-Smtp-Source: AGHT+IHksE11INoODcmfSA8PUTVNGXIlCH66XxnH2VvOntZKJzWoEyBWTiUDIjjhs1caK8c5pV3a1jp10fJX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a63:f919:0:b0:5db:edca:d171 with SMTP id
 h25-20020a63f919000000b005dbedcad171mr25389pgi.6.1713162994834; Sun, 14 Apr
 2024 23:36:34 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:19 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 2/9] perf parse-events: Directly pass PMU to parse_events_add_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Avoid passing the name of a PMU then finding it again, just directly
pass the PMU. parse_events_multi_pmu_add_or_add_pmu is the only
version that needs to find a PMU, so move the find there. Remove the
error message as parse_events_multi_pmu_add_or_add_pmu will given an
error at the end when a name isn't either a PMU name or event
name. Without the error message being created the location in the
input parameter (loc) can be removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 46 +++++++++++++---------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b16c75bf5580..bc4a5e3c6c21 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1386,32 +1386,18 @@ static bool config_term_percore(struct list_head *config_terms)
 }
 
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, const char *name,
-			 const struct parse_events_terms *const_parsed_terms,
-			 bool auto_merge_stats, void *loc_)
+				struct list_head *list, struct perf_pmu *pmu,
+				const struct parse_events_terms *const_parsed_terms,
+				bool auto_merge_stats)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
-	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
-	YYLTYPE *loc = loc_;
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
 
-	pmu = parse_state->fake_pmu ?: perf_pmus__find(name);
-
-	if (!pmu) {
-		char *err_str;
-
-		if (asprintf(&err_str,
-				"Cannot find PMU `%s'. Missing kernel support?",
-				name) >= 0)
-			parse_events_error__handle(err, loc->first_column, err_str, NULL);
-		return -EINVAL;
-	}
-
 	parse_events_terms__init(&parsed_terms);
 	if (const_parsed_terms) {
 		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
@@ -1425,9 +1411,9 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		strbuf_init(&sb, /*hint=*/ 0);
 		if (pmu->selectable && list_empty(&parsed_terms.terms)) {
-			strbuf_addf(&sb, "%s//", name);
+			strbuf_addf(&sb, "%s//", pmu->name);
 		} else {
-			strbuf_addf(&sb, "%s/", name);
+			strbuf_addf(&sb, "%s/", pmu->name);
 			parse_events_terms__to_strbuf(&parsed_terms, &sb);
 			strbuf_addch(&sb, '/');
 		}
@@ -1469,7 +1455,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		strbuf_init(&sb, /*hint=*/ 0);
 		parse_events_terms__to_strbuf(&parsed_terms, &sb);
-		fprintf(stderr, "..after resolving event: %s/%s/\n", name, sb.buf);
+		fprintf(stderr, "..after resolving event: %s/%s/\n", pmu->name, sb.buf);
 		strbuf_release(&sb);
 	}
 
@@ -1583,8 +1569,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			continue;
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
-		if (!parse_events_add_pmu(parse_state, list, pmu->name,
-					  &parsed_terms, auto_merge_stats, loc)) {
+		if (!parse_events_add_pmu(parse_state, list, pmu,
+					  &parsed_terms, auto_merge_stats)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1596,8 +1582,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	}
 
 	if (parse_state->fake_pmu) {
-		if (!parse_events_add_pmu(parse_state, list, event_name, &parsed_terms,
-					  /*auto_merge_stats=*/true, loc)) {
+		if (!parse_events_add_pmu(parse_state, list, parse_state->fake_pmu, &parsed_terms,
+					  /*auto_merge_stats=*/true)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1626,7 +1612,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 {
 	char *pattern = NULL;
 	YYLTYPE *loc = loc_;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 	int ok = 0;
 	char *help;
 
@@ -1637,10 +1623,12 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	INIT_LIST_HEAD(*listp);
 
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
-	if (!parse_events_add_pmu(parse_state, *listp, event_or_pmu, const_parsed_terms,
-					/*auto_merge_stats=*/false, loc))
+	pmu = parse_state->fake_pmu ?: perf_pmus__find(event_or_pmu);
+	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
+					/*auto_merge_stats=*/false))
 		return 0;
 
+	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
 	if (asprintf(&pattern, "%s*", event_or_pmu) < 0) {
 		zfree(listp);
@@ -1660,8 +1648,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 		    !perf_pmu__match(pattern, pmu->alias_name, event_or_pmu)) {
 			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-			if (!parse_events_add_pmu(parse_state, *listp, pmu->name, const_parsed_terms,
-						  auto_merge_stats, loc)) {
+			if (!parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
+						  auto_merge_stats)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
-- 
2.44.0.683.g7961c838ac-goog


