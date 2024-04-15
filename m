Return-Path: <linux-kernel+bounces-144599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376B8A483F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BA11C210FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4711C69D;
	Mon, 15 Apr 2024 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LE1BPs3L"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9625383A3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163012; cv=none; b=FvxSolHyrCRst+QmBOIydzF0snlvkUgiwU1qJcx+6Y//pZvSaZ39yn8sBNsb2b+0K5FEWeQzKAjVWT9eGGstGlqD0XKXRRD9v3dKKhXRsSSLIjFVvEWNc+IFvvE39RtfWskUMUUju504QwNc2A9YTFdnrDuoSbiR9wKQoxJoZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163012; c=relaxed/simple;
	bh=YnUF3ceBTuEWLeyH8vOqzQm1Yqq/JnFb2jhfnx6s9QU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eAzVDG5SknwDqBbJL6IRwmUMlQLyiDT8SAc5knxr29yxT22ZF8s+QD0dE2xkpnyQQMIGD9JJkIh2WJYAPav9S7vAyvucUOMZZOP9VQzkoRHxyRPZGaWNi3WBGkxGoPqEgdjzPauwA5iUD4SPBhxkQXlXxOftut1AihpHhD6FvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LE1BPs3L; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so5174236276.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163010; x=1713767810; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsM8Y1cj6kmrsHpwiXYtXKur/DOQuLkG4gE86ZL8CEk=;
        b=LE1BPs3LcUYqEEl7YNf0MJSUzYbOnMtITFXjBs0w/nJE4yjQuInhXMvMerZjwquSkA
         NzX3yJwHs29EN8taGYBGLrELzTH0Kf15s2wO96zuSMMbOkZESkJyFV8rx+WaahyXYT4s
         nSqAyZySXkYbvjHkSQ+gcej82kbT3h88QPEtmqa0ymaaBLXCAfgkyD66Y/2rjcB+wI1W
         GBCHKu5luo+nuIw61j6J1P9AeKWcgR8x2AhYaUjKBxbr7YvL1GiW9Uw6pYMUzhX0OSOW
         47XT7fDOJ0BB1EniV6eEEGXl6KnDp8oZwL8qBXdwfA77OKE4R007+Bs6HFyPwcAjHOnf
         CCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163010; x=1713767810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsM8Y1cj6kmrsHpwiXYtXKur/DOQuLkG4gE86ZL8CEk=;
        b=LD5K0CGoEKGgT9e27F9t713vDblDuAi5/lbSmsw9Qdrt1sKmDYekg+nhrwLkyezeVb
         XXxHR4P0jUjPGjgGtF1lZyGc6lEmBtI6gY3Wx5gq5xGqAlUZOSVTejNqnqZLBHkhKKrR
         jt2m2i6H4RxP+P42QOs6Md82gVOE4goV/lED/D3xTyfOaqkclxEgEfR6Drvrp13jjn6h
         HgL8UUwaXi/ka2wLrfv5+hOb3lcRtk5z+KM0mmHZgQsLrG/0NlaQPI3Ym1VZj8X35d7e
         9J34dM27hVIByS7zt4sPxpVL00kBhAR+prYF0Lfx2isuzjbYUG/aFbnUJqfD1UJ4zaFg
         XJIw==
X-Forwarded-Encrypted: i=1; AJvYcCUGNAsYAoh7lpP2QvxAuJ0JqrWSjR5dUrboVLQzJzB+MXRhzGHqjbN+5CZrPaosU4mkM8ar0eCkMsWNcTld274OjoYe89O6B+tobPTZ
X-Gm-Message-State: AOJu0YzJzXu7nasHH75E30hstnl4BWWqvna6o1X1IApmGRhmn6WK7GTn
	PMK2JDUWGdKgqa4BbCpFPlhXaiVvO8r0gEWto5bKuGgoO7Nhpm5fuiSZVsGRZ/uD7uhAe9WYe7x
	Tz/vfzQ==
X-Google-Smtp-Source: AGHT+IGgmCtdEtZrTu/VTbHRcGxy01TSWSnKf6exxI0DVUKXLBA7LgeFtUQlO61tu+Bc2rAGxXCSISNxPEr+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:6902:1549:b0:dc6:dfd9:d431 with SMTP
 id r9-20020a056902154900b00dc6dfd9d431mr2983582ybu.1.1713163009901; Sun, 14
 Apr 2024 23:36:49 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:25 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 8/9] perf parse-events: Constify parse_events_add_numeric
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

Allow the term list to be const so that other functions can pass const
term lists. Add const as necessary to called functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f711ad9b18f0..50c4012c737e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -34,7 +34,8 @@
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
-static int get_config_terms(struct parse_events_terms *head_config, struct list_head *head_terms);
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms);
 static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 
@@ -154,7 +155,7 @@ const char *event_type(int type)
 	return "unknown";
 }
 
-static char *get_config_str(struct parse_events_terms *head_terms,
+static char *get_config_str(const struct parse_events_terms *head_terms,
 			    enum parse_events__term_type type_term)
 {
 	struct parse_events_term *term;
@@ -169,12 +170,12 @@ static char *get_config_str(struct parse_events_terms *head_terms,
 	return NULL;
 }
 
-static char *get_config_metric_id(struct parse_events_terms *head_terms)
+static char *get_config_metric_id(const struct parse_events_terms *head_terms)
 {
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_METRIC_ID);
 }
 
-static char *get_config_name(struct parse_events_terms *head_terms)
+static char *get_config_name(const struct parse_events_terms *head_terms)
 {
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
@@ -358,7 +359,7 @@ static int config_term_common(struct perf_event_attr *attr,
 			      struct parse_events_term *term,
 			      struct parse_events_error *err);
 static int config_attr(struct perf_event_attr *attr,
-		       struct parse_events_terms *head,
+		       const struct parse_events_terms *head,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term);
 
@@ -1107,7 +1108,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 #endif
 
 static int config_attr(struct perf_event_attr *attr,
-		       struct parse_events_terms *head,
+		       const struct parse_events_terms *head,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term)
 {
@@ -1120,7 +1121,8 @@ static int config_attr(struct perf_event_attr *attr,
 	return 0;
 }
 
-static int get_config_terms(struct parse_events_terms *head_config, struct list_head *head_terms)
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms)
 {
 #define ADD_CONFIG_TERM(__type, __weak)				\
 	struct evsel_config_term *__t;			\
@@ -1324,7 +1326,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 				struct list_head *list,
 				struct perf_pmu *pmu, u32 type, u32 extended_type,
-				u64 config, struct parse_events_terms *head_config)
+				u64 config, const struct parse_events_terms *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -1360,7 +1362,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
-			     struct parse_events_terms *head_config,
+			     const struct parse_events_terms *head_config,
 			     bool wildcard)
 {
 	struct perf_pmu *pmu = NULL;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index db47913e54bc..5005782766e9 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -196,7 +196,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
-			     struct parse_events_terms *head_config,
+			     const struct parse_events_terms *head_config,
 			     bool wildcard);
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
-- 
2.44.0.683.g7961c838ac-goog


