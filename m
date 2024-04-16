Return-Path: <linux-kernel+bounces-146331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25FA8A6395
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE70B24631
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526E84E0B;
	Tue, 16 Apr 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxdiMkSt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13E84D3C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248170; cv=none; b=QOTYRGaBGdGcK9lNjrJBlwiBJECcoDW/xLWp4A1iF3mnWBbCNtzZgwe1LAD+c3zfdU6sBGHtk/tAW94xMjpSF+vL89A7n+Fzl+U740A+y2tlpcTAVxfnoGKoj2RQIuSMdHqMzNYRCX8/bkh69mDQ55tCX0kjEZvLu7ER0di05rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248170; c=relaxed/simple;
	bh=O8OUGtb6bTGqfSyRVlfSK5T8OB2WkT+9dGZAqdqh/Cs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y6l+ahSCMrZefam+cOUeTDG8cRo7PI2aMbd87WAS5ROtkn9xU5p8aJGIihaf7UBXp/HMk4mjPQKm0SNgIqo5OGExWp11jV/wn+2Mong7VFiGKkB08fIkHN2fArKFee0SAXbidHMvEaZvzCojazFC2xKtzmrHLxlUhZGmCf/6G/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxdiMkSt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso6190990276.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248168; x=1713852968; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PPi7agW0cdqI/eav98kRS0rctCNoN8MXcmmiJuSnV8=;
        b=MxdiMkStihO7e4lTLn3RbwoirBdNzvt5ov3NOwHLmnM6Z91/xTBJKXWNvoeS+ww1lM
         BQJJIzlhPn+/OSHvtMeiKwoZmM/mQnXovIH8xqJvZigGu9sJ8/lPhwEGSwqJJVeHA8k3
         CkRBlZQTUUHlpgFW3SYk0PlIIjAPULZO9FatnbmNRJzTdEcPNmF+DOI0URQjkbQPDvzK
         wW9NKS9EwnLNOR3ISpRNw725sg9H+9B9ONerKHIDoLjyWr3XjjNJhbOcpHzX+DQqKJWI
         oJcwIMCFVyshepxMkdBFoGSXyC9GSPaR+DJrTVfPygsJc7nF/a43CtmXc+gM94DrdI63
         gOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248168; x=1713852968;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PPi7agW0cdqI/eav98kRS0rctCNoN8MXcmmiJuSnV8=;
        b=iN70b3BvuhX3Ik5hpi/nMWW2LHqHf0Kt3C8bXqQXvauLAX+NcLrykm8k+Rf/BJ1bbz
         aMktPBJ+u0fYFjcFCmLq4u+dZDskVwXMXLQdXWg/+d11/Re8wf3ZtfGbk9TNs2SCdqo0
         zoIH5Z9w6nW6WoH59jLZo/AndSzK3/1MvJ2jLrvO+zObKYgyHyZXncpIXE08Z7i/IC0t
         6Z+lfyMaD57WeeqXxQSWIOTbevwwDEqQaZWm/lP9KPZ0AIqwiWi42giYey6aC5SIY8Mm
         t6Mu0ilx9jxn8p0G0ivJHjZlmZOGLMnl8HDT4v0NZe0WRdWEzmQ15em7RutdhAQT3AlP
         tbdw==
X-Forwarded-Encrypted: i=1; AJvYcCVrWW1nJtT0YVZ8Ibt8B/xZHnhvzNH5okNhJGjL0wzlULeNDQGC+2geErH1VxCl6NZmPUs9Wpk7boqyynHg2P3c0/CBrHHOapZGeHhW
X-Gm-Message-State: AOJu0Yz1PET/minK0GveFP9Qd+IzaIhKJMK9t6Iw/xa41aVr6YWKzKhJ
	M41Z8UwoC8Y4IIGTWcem2TMm9FQ398XhdKZQSGW/sBJT27kKijEE2bEHaK4YsO0ccMISNJOm35O
	I/1+Guw==
X-Google-Smtp-Source: AGHT+IH2niG4HLP7/x+KA0mPGPOc5Cee9M3cvuF12USU8FSK8dwpi2y2t4/mArka5E1ZbdSzG8VUZRYDDFLw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1501:b0:dd9:1b94:edb5 with SMTP
 id q1-20020a056902150100b00dd91b94edb5mr1355225ybu.10.1713248167928; Mon, 15
 Apr 2024 23:16:07 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:26 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 10/16] perf parse-events: Inline parse_events_update_lists
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

The helper function just wraps a splice and free. Making the free
inline removes a comment, so then it just wraps a splice which we can
make inline too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 13 -----------
 tools/perf/util/parse-events.h |  2 --
 tools/perf/util/parse-events.y | 41 +++++++++++++++++++++-------------
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 805872c90a3e..7eba714f0d73 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1720,19 +1720,6 @@ void parse_events__set_leader(char *name, struct list_head *list)
 	leader->group_name = name;
 }
 
-/* list_event is assumed to point to malloc'ed memory */
-void parse_events_update_lists(struct list_head *list_event,
-			       struct list_head *list_all)
-{
-	/*
-	 * Called for single event definition. Update the
-	 * 'all event' list, and reinit the 'single event'
-	 * list, for next event definition.
-	 */
-	list_splice_tail(list_event, list_all);
-	free(list_event);
-}
-
 struct event_modifier {
 	int eu;
 	int ek;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 7e5afad3feb8..e8f2aebea10f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -226,8 +226,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 					void *loc_);
 
 void parse_events__set_leader(char *name, struct list_head *list);
-void parse_events_update_lists(struct list_head *list_event,
-			       struct list_head *list_all);
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 31fe8cf428ff..51490f0f8c50 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -125,6 +125,10 @@ static void free_list_evsel(struct list_head* list_evsel)
 }
 %%
 
+ /*
+  * Entry points. We are either parsing events or terminals. Just terminal
+  * parsing is used for parsing events in sysfs.
+  */
 start:
 PE_START_EVENTS start_events
 |
@@ -132,31 +136,36 @@ PE_START_TERMS  start_terms
 
 start_events: groups
 {
+	/* Take the parsed events, groups.. and place into parse_state. */
+	struct list_head *groups  = $1;
 	struct parse_events_state *parse_state = _parse_state;
 
-	/* frees $1 */
-	parse_events_update_lists($1, &parse_state->list);
+	list_splice_tail(groups, &parse_state->list);
+	free(groups);
 }
 
-groups:
+groups: /* A list of groups or events. */
 groups ',' group
 {
-	struct list_head *list  = $1;
-	struct list_head *group = $3;
+	/* Merge group into the list of events/groups. */
+	struct list_head *groups  = $1;
+	struct list_head *group  = $3;
 
-	/* frees $3 */
-	parse_events_update_lists(group, list);
-	$$ = list;
+	list_splice_tail(group, groups);
+	free(group);
+	$$ = groups;
 }
 |
 groups ',' event
 {
-	struct list_head *list  = $1;
+	/* Merge event into the list of events/groups. */
+	struct list_head *groups  = $1;
 	struct list_head *event = $3;
 
-	/* frees $3 */
-	parse_events_update_lists(event, list);
-	$$ = list;
+
+	list_splice_tail(event, groups);
+	free(event);
+	$$ = groups;
 }
 |
 group
@@ -206,12 +215,12 @@ PE_NAME '{' events '}'
 events:
 events ',' event
 {
+	struct list_head *events  = $1;
 	struct list_head *event = $3;
-	struct list_head *list  = $1;
 
-	/* frees $3 */
-	parse_events_update_lists(event, list);
-	$$ = list;
+	list_splice_tail(event, events);
+	free(event);
+	$$ = events;
 }
 |
 event
-- 
2.44.0.683.g7961c838ac-goog


