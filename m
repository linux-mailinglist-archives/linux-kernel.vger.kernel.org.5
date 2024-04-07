Return-Path: <linux-kernel+bounces-134364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC989B0B5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17395281C38
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B93B2AE72;
	Sun,  7 Apr 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XCiJwHv8";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="CTF5znRv"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7C22EFD;
	Sun,  7 Apr 2024 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492343; cv=none; b=g0SHm6G/BT3thVJpbieLeIf6ty6slS0Hc55FPCdhyagK1uybIkYB+YLigpSNC+IThF7bb8BT5K85k5zEWKd+nx2Vc92hwLKz4VHY8SbpjU8jRG2aQpjq/Aac00nzhmT+aNMZ9wGnhDzSR0ATdQdG7tHCSys8LMniqtVSl8bPIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492343; c=relaxed/simple;
	bh=QHIKR9y7g6cSt5DXzAIiaGmRTUaGawOCp3GhZNAHZGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mK8OIAH4+GmH/ANzuTHLujiwIAGi7sAlmNVfOa9kjAZV0sgRFwxAmZU5FoE+f9jiaV5ze+oTzyUH4K3P3nds7iZR+rYMJLfqo5qLqraD0/IkGwHur42tuanRD0mZdsYmAMn2ZPedOnwckKonQh3jGoft3ySwzDGVynuZvkG9K2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=XCiJwHv8; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=CTF5znRv; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id D31DCC01C; Sun,  7 Apr 2024 14:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492339; bh=AcmFfipoJbwXPcuwe+G/ffcJRLh8XWlTMp6pXT3ZnTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XCiJwHv8UXoWVFbilqe/6vZNZYol5lFaH6ONfN0Aqrc2doJoRJVfjQOeFckcP7Rb7
	 IDmbVtFGNdTmdkib4K5sQWcePsBa3L2BMvT9U6fzOJiOACmXuUhwsvhendOY8BagW6
	 Im3QuxAV27BLTsImWI7XTfQil58Fz5l2GMYMLDONvfK9jeq/+H27oIkryaAg2e4KR0
	 oxP6TSmu++ElVbabOBOy9iwWy8gsyLm7X8E5sALiMloiBYiFU9nWys4GgtslNf3EzE
	 fLHq/sQ8+3MldZUD0dMmpDjgaEChP21BQWAYJwp3AN0m1MYPoVUtxutV12/IpO5vZ/
	 UV31+wdsli3RQ==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 5D60EC01C;
	Sun,  7 Apr 2024 14:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492337; bh=AcmFfipoJbwXPcuwe+G/ffcJRLh8XWlTMp6pXT3ZnTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CTF5znRv7jsfgcezhFLZ2a5WzsXU3Z8Ngi03Bmdq4DXcNKSyd4WqIc5/AOofXxep/
	 EKu0I8IHdvFkmcuMzjrlXBCYBlLSlqSlgvvzgg+kv6CHa+lhUKSBgybmmBf/hv7gdf
	 zvwx43wnaEUwURj8gbMpNjFj9VDMxZPbZFQ1MjF8Ug6zQFRNiKh3MMnQDGTzDAi7dv
	 HOeML8S0ZlsSwfFWh+itJJWUjckzfoYgBW+nVcNEcOQMsPz/su96E6CcayErZlVidl
	 1m2FvZMAoUzl+PTK4e5lvFwPxj8D1KsU3JyiNnfHIoQhHiXCh3t4lllM63iimpgNHo
	 uB9MeOatgqgNw==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id c8312b56;
	Sun, 7 Apr 2024 12:18:38 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Sun, 07 Apr 2024 21:18:20 +0900
Subject: [PATCH 2/3] perf parse-events: Add new 'fake_tp' parameter for
 tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-perf_digit-v1-2-57ec37c63394@codewreck.org>
References: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
In-Reply-To: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>, Jiri Olsa <olsajiri@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8987;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=QHIKR9y7g6cSt5DXzAIiaGmRTUaGawOCp3GhZNAHZGg=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmEo8eC0jyndCoSRQ0SDD10KwGThMCEpaB9hDSX
 JEVdEEvy82JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZhKPHgAKCRCrTpvsapjm
 cM/0D/4yfX1EnqURpqDrjBEapVKH/pOWqHBNXSJJ3Y/zyAKDT8TcZX7gK1r/BuT8EEK9iAdr/3a
 R9rcdrVnskvxhIPDHEwCtm/UDIpt2dz1crfyXV/b/mG2vCjKGEeKVwHBIFjPg05gr6mMu2aWV7W
 Q0eg0muk4KnF372O0sNo+oCki44/H8WJgGHljl+jGf9AyKjQVEyKlzfDzwXdcijV29CkCyqLcNt
 /4dP30hFPUcNwkQlZRdBvse4tYDUtr6pm77IJMxcfWFC9r6I2MgIrrmYBWWcJ6+3JLWq3kZeaaK
 UoDPhnDrMIvOaysip7vdKFfX+WDnT1+qyliBMdu7O/nbuMF9CT+NoMN4kmoGYtcXz8dZ9xceBVf
 TTF7VWEiZYgJrKM0ehiVQRZoWt1sXnWUHDKYTuRN4Wbmc25hRcXvhnJZMGS75w+n+GdnnP2RT3+
 Nt8o93lNoTMgyqsDyRZeSlM1z2ZjL2t8WE4YCHCYcQM7KTHysi8fypYH7CfEAwV0jEMXOIiJs02
 hOu/A2TMo86c3/BrUYHcS9asixN0pbfr0XrX5gI59ZN9WhFlIMJh1yTj2NcVbNvS6+OAQsRqhxa
 928obQUYfkeAt6U4HJmxj3UzZN8oF86Fq0AIaSusIijYUV2ljNykNo2lvL9HVF/VQVrvIZidDnT
 YBtspACGeQzk5xA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

The next commit will allow tracepoints starting with digits, but most
systems do not have any available by default so tests should skip the
actual "check if it exists in /sys/kernel/debug/tracing" step.

In order to do that, add a new boolean flag specifying if we should
actually "format" the probe or not.

Originally-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c |  6 ++++--
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/evlist.c        |  3 ++-
 tools/perf/util/evsel.c         | 20 +++++++++++++-------
 tools/perf/util/evsel.h         |  4 ++--
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  |  9 ++++++---
 tools/perf/util/parse-events.h  |  6 ++++--
 8 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index feb5727584d1..ef056e8740fe 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2504,7 +2504,8 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = parse_events(evlist, e->name, &err);
+	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/NULL,
+			     /*warn_if_reordered=*/true, /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
 		parse_events_error__print(&err, e->name);
@@ -2532,7 +2533,8 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
-			     &perf_pmu__fake, /*warn_if_reordered=*/true);
+			     &perf_pmu__fake, /*warn_if_reordered=*/true,
+			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
 			 str, ret);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 47a7c3277540..0a1308d84e9e 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -842,7 +842,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 		*cur = '/';
 
 	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, fake_pmu,
-			     /*warn_if_reordered=*/true);
+			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 55a300a0977b..3a719edafc7a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -298,7 +298,8 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 #ifdef HAVE_LIBTRACEEVENT
 struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
 {
-	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0);
+	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0,
+					       /*format=*/true);
 
 	if (IS_ERR(evsel))
 		return evsel;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..4f818ab6b662 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -452,7 +452,7 @@ struct evsel *evsel__clone(struct evsel *orig)
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 #ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
@@ -469,14 +469,20 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
 			goto out_free;
 
-		evsel->tp_format = trace_event__tp_format(sys, name);
-		if (IS_ERR(evsel->tp_format)) {
-			err = PTR_ERR(evsel->tp_format);
-			goto out_free;
+		event_attr_init(&attr);
+
+		if (format) {
+			evsel->tp_format = trace_event__tp_format(sys, name);
+			if (IS_ERR(evsel->tp_format)) {
+				err = PTR_ERR(evsel->tp_format);
+				goto out_free;
+			}
+			attr.config = evsel->tp_format->id;
+		} else {
+			attr.config = (__u64) -1;
 		}
 
-		event_attr_init(&attr);
-		attr.config = evsel->tp_format->id;
+
 		attr.sample_period = 1;
 		evsel__init(evsel, &attr, idx);
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..375a38e15cd9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -234,14 +234,14 @@ void free_config_terms(struct list_head *config_terms);
 
 
 #ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
 
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
-	return evsel__newtp_idx(sys, name, 0);
+	return evsel__newtp_idx(sys, name, 0, true);
 }
 #endif
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 79ef6095ab28..c21f05f8f255 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1502,7 +1502,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
 	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
-			     &parse_error, fake_pmu, /*warn_if_reordered=*/false);
+			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
+			     /*fake_tp=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6e8cba03f0ac..04508e07569d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -526,7 +526,8 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 			  struct parse_events_terms *head_config, void *loc_)
 {
 	YYLTYPE *loc = loc_;
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++,
+					       !parse_state->fake_tp);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
@@ -2126,7 +2127,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
 		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
-		   bool warn_if_reordered)
+		   bool warn_if_reordered, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
 		.list	  = LIST_HEAD_INIT(parse_state.list),
@@ -2134,6 +2135,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 		.error	  = err,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.fake_tp  = fake_tp,
 		.pmu_filter = pmu_filter,
 		.match_legacy_cache_terms = true,
 	};
@@ -2343,7 +2345,8 @@ int parse_events_option(const struct option *opt, const char *str,
 
 	parse_events_error__init(&err);
 	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
-			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
+			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true,
+			     /*fake_tp=*/false);
 
 	if (ret) {
 		parse_events_error__print(&err, str);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index fd55a154ceff..b985a821546b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -32,14 +32,14 @@ int parse_events_option_new_evlist(const struct option *opt, const char *str, in
 __attribute__((nonnull(1, 2, 4)))
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
 		   struct parse_events_error *error, struct perf_pmu *fake_pmu,
-		   bool warn_if_reordered);
+		   bool warn_if_reordered, bool fake_tp);
 
 __attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
 	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/NULL,
-			      /*warn_if_reordered=*/true);
+			      /*warn_if_reordered=*/true, /*fake_tp=*/false);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -152,6 +152,8 @@ struct parse_events_state {
 	int			   stoken;
 	/* Special fake PMU marker for testing. */
 	struct perf_pmu		  *fake_pmu;
+	/* Skip actual tracepoint processing for testing. */
+	bool			   fake_tp;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */

-- 
2.43.0


