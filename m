Return-Path: <linux-kernel+bounces-146325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929688A6389
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF372819B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21066CDD5;
	Tue, 16 Apr 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bi8kZoQZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77F67C53
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248156; cv=none; b=AK3ShB1VUSNTTOlrT82mblzjXqw9uxVLGyy0PUMv7ctzNRy6dNDWX93E3i4hbPi6UmYnsEULHQPqScO1GZgF/ChsGjwv/XIMTqqhsakzWzJYPAtIfe6Gi2DPFr567KEWFiT0QCFw5US4u9o+yzEM3zwCsTvl1h1sSAfUUMm4bpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248156; c=relaxed/simple;
	bh=lLSR9Zme6R3eaZpgcappeWu5jfr6jnHFV6BaEVpUHMk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RTMRXEhexFyYP7KxFLqihpYq/rgQLQueyASEC8OFYbrz5gw63LtzpZ93IDuF6MpgGeIOITVdfQ50ay65cXZ1Yt8L9aocf14fwd4fC2A1RfBwYY/kZvwzKklLIowGd6rPqxCVkLvD8TXc9yxXkSBo4GN1SzALZ7oAT9r/5sWlb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bi8kZoQZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6183c4a6d18so60750597b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248153; x=1713852953; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoQwW/NovL7e2tX2zfVq3KY3APeKDAqGoyhJSMq8amM=;
        b=Bi8kZoQZjCB2V/V0PplZ6NWHRF0PNQ8XrwjwDQMY4xt+cbR+96VttCc2QwHQ6sW92g
         Z4E0vPbWXIBVeoysmXe6mOEHVgg37vcLDwtbrmcroiu1BE19nHxoa4htzMBO7rz9ggjj
         hIONz7dl0L8LdXXVY9EuEEg4SxWrkrUjqZ+Qc+LAvPTzPNbRb1RZRzWTSctfWVIFaQfO
         6LyJowHdGDj1MbznqiklJmLMZOUFXUNT3NAv8ZSmnwl8J6/tOB6BEE3m6PdNvj87oF+N
         h1J81C6K1XWdTsigKh374hrRlqEOIeW2Y3Xv1LIv8bhlhJLwbZziU/lJuLwVd298GTl8
         O7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248153; x=1713852953;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoQwW/NovL7e2tX2zfVq3KY3APeKDAqGoyhJSMq8amM=;
        b=SVnP4c+5o2rHJFNDf3ZjSg0lW6IbuGFpgztY8zm/RB31lh428Oq4aEGoG/pdXP2zap
         dQ6kiYqnBgTvxxRetSkEBLdOVoeByDLoPBiW4YC6jUGcGcxOywJN67k+hsYZKOzxnOYc
         a/0n1OYbTJ8LU/e9Wb2e+XSImYef8bZrKZI1BFZo73HX7sxJ72W28QTnZFDy8Qhk1MZx
         AWXfHbZ2Wll0Q75c+pyiMDFPzqtWNtPuk36dN3Op9q04ORncCh/lFbRK1W+SDyXHNBZI
         ioy0n2sdV3sTt2qOStfy7zsyS4xjPZa1yW9U9VQbj1kkT7FQcJR2ipmYIZTzb1mhBkTe
         CzLA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ViCQk6LWyxRvJH2mkHWshTckPja+yEYxnqCZ/v8jgB65jdfsIzS4RyWpAnWumK87RuImztxJxg9BqdeQdMTBfxJVXxKuNSbpRcsN
X-Gm-Message-State: AOJu0Yx/RXvXEdhJoZQ3qB/5DtVaraEQsYOvI/GoF7uBSxdexw+a0h3J
	mQUbtfZu7Qf9rG0j2Fibku6kU0tzjqeJdCkCQzsvfDjld+cZtfWn/7/U3SY2kXdkmJoiIhJ6Ga8
	DVqZPLQ==
X-Google-Smtp-Source: AGHT+IHOfFNw3FUspTDzag8H1Vs2s4R7H3wtDbw+0o1oktnOEpdBiBC3Jt+NP9eC79ubMPCeMtZbdbJRfZUt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1027:b0:dc6:dfd9:d423 with SMTP
 id x7-20020a056902102700b00dc6dfd9d423mr968428ybt.3.1713248153495; Mon, 15
 Apr 2024 23:15:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:20 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 04/16] perf pmu: Refactor perf_pmu__match
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

Move all implementation to pmu code. Don't allocate a fnmatch wildcard
pattern, matching ignoring the suffix already handles this, and only
use fnmatch if the given PMU name has a '*' in it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 19 ++-----------------
 tools/perf/util/pmu.c          | 27 +++++++++++++++++++--------
 tools/perf/util/pmu.h          |  2 +-
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3b1f767039fa..39548ec645ec 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1611,7 +1611,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 					struct list_head **listp,
 					void *loc_)
 {
-	char *pattern = NULL;
 	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu;
 	int ok = 0;
@@ -1631,22 +1630,9 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
-	if (asprintf(&pattern, "%s*", event_or_pmu) < 0) {
-		zfree(listp);
-		return -ENOMEM;
-	}
-
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		const char *name = pmu->name;
-
-		if (parse_events__filter_pmu(parse_state, pmu))
-			continue;
-
-		if (!strncmp(name, "uncore_", 7) &&
-		    strncmp(event_or_pmu, "uncore_", 7))
-			name += 7;
-		if (!perf_pmu__match(pattern, name, event_or_pmu) ||
-		    !perf_pmu__match(pattern, pmu->alias_name, event_or_pmu)) {
+		if (!parse_events__filter_pmu(parse_state, pmu) &&
+		    perf_pmu__match(pmu, event_or_pmu)) {
 			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
 			if (!parse_events_add_pmu(parse_state, *listp, pmu,
@@ -1657,7 +1643,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 			}
 		}
 	}
-	zfree(&pattern);
 	if (ok)
 		return 0;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ce72c99e4f61..d7521d84fe4a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2073,18 +2073,29 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 		   name ?: "N/A", buf, config_name, config);
 }
 
-int perf_pmu__match(const char *pattern, const char *name, const char *tok)
+bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
 {
-	if (!name)
-		return -1;
+	const char *name = pmu->name;
+	bool need_fnmatch = strchr(tok, '*') != NULL;
 
-	if (fnmatch(pattern, name, 0))
-		return -1;
+	if (!strncmp(tok, "uncore_", 7))
+		tok += 7;
+	if (!strncmp(name, "uncore_", 7))
+		name += 7;
 
-	if (tok && !perf_pmu__match_ignoring_suffix(name, tok))
-		return -1;
+	if (perf_pmu__match_ignoring_suffix(name, tok) ||
+	    (need_fnmatch && !fnmatch(tok, name, 0)))
+		return true;
 
-	return 0;
+	name = pmu->alias_name;
+	if (!name)
+		return false;
+
+	if (!strncmp(name, "uncore_", 7))
+		name += 7;
+
+	return perf_pmu__match_ignoring_suffix(name, tok) ||
+		(need_fnmatch && !fnmatch(tok, name, 0));
 }
 
 double __weak perf_pmu__cpu_slots_per_cycle(void)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 152700f78455..93d03bd3ecbe 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -263,7 +263,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   const char *config_name);
 void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 
-int perf_pmu__match(const char *pattern, const char *name, const char *tok);
+bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok);
 
 double perf_pmu__cpu_slots_per_cycle(void);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
-- 
2.44.0.683.g7961c838ac-goog


