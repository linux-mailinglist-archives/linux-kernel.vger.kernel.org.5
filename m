Return-Path: <linux-kernel+bounces-146324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D48A6385
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05CB284F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069B5EE67;
	Tue, 16 Apr 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNN4qflV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26258203
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248153; cv=none; b=EDCgAachAi7xeQvCKbAZlyqGXOTJZJyXPXVdYsXyOXuMBhPTrHMDYoaz+qNtUBQ1c7aIUVzvIlEoa1XFQXXt8ouFAJwUSi/nvGVmwGk8vDtrtVcvGrkLy6ZJ/9QlbrhAnQlnXLQE4pwSKzwV0XJFhGpHkyAAS5X1nK/AbjkiwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248153; c=relaxed/simple;
	bh=IERvH/Ao6HfWGEykCXtiWrApDF698nujkO4wwCpYmzw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H7IJBE5w1pkPtoYu+sGI9CCajGwzV93BHN6P4lXUU50top9NTRaBm9oDd+0n2B5KQpzVY8CkxctBu0efZ6j3dbWhwXsmyKhPi6pKK9smhqFHjZ8F4xlCSIp1QQSZ0mnnlOW/nJtCnCtGstc1cC+BLH4cUxSxNMZx2vbzmprdMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNN4qflV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61acc68c1bdso16319137b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248151; x=1713852951; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trVc8Z3cM9HfuUa79775aNx5De/ILl71mqLeEIudwkY=;
        b=XNN4qflVBY4y9wyZFiv0CpHJcPKMRC7AEpYwTL2cRaJQDuj6JK1i9EDrFqhyXSY4ih
         RsW/5rpPp/tXv4Ygt424I5TOBks3HxBrLTO+eHniPjok95LQPzu0YnWf46AjZ5vkgIc5
         Jh3+xbHXNq0lM9vloV2y94TIByFwtdip9eWaLX2IOAUVXSZDjGMpSAzO09EZwKtjLVj/
         2b7kZi+sEBjL1CpmQle52ix7WJr50iH7b0HX1qmFsO5olvaI2kklsycZX8AV7JHXt5MH
         VvaXSZrbkxAQG5PKyXMPiCDcesROb4qqpMhVL28wmMoMn/Hw8hOmtorLX9lPrcqGOXaU
         9E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248151; x=1713852951;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trVc8Z3cM9HfuUa79775aNx5De/ILl71mqLeEIudwkY=;
        b=jjY5xGpryeLLw47OZx9A5p0VQ+zAWlIKJfYHO+8pjLSibWz9KruF7yuLuuw+VileyN
         qZ5P2c6r0sZrGhCh8Q7wwlx3U+qfX5eD+iLxdVAvqW621QZNTRscxtwEI3B2sIxNAgid
         1fPxYC/5WaDpiGDCSYj1yZjRQKST3+QKEXzHQVT1p8a8K2PwOmTokHgFR/u5tme+qAqS
         /y6/TwFS9x2zYxlSA3PUMH+3kh8EEHQwmXVHRt2qHzJTyFvVhyPaLa1QLv1xwRel3yVW
         NkuohT+FgcsfAFtJATcQaVggcr4CdmQZGAC+imQzad08ZjRNSGlii7aHeN5sPWS9JLWM
         OrpA==
X-Forwarded-Encrypted: i=1; AJvYcCVvxPGy0idX5UDGqzZrDzOs3pTZTE68Jq+Dene76XMeAUxvqygBy0AzlcwDPoNSkX/ci5cIS6JZnOdXHyNAndV0dlD4x1TbRGGu1cyo
X-Gm-Message-State: AOJu0YxaIsen/TZKapbLbohTySmdvTUSUTC9uqa92Vr3XoTw4TJiPunb
	5s9kss+iaBQ3+TEjQsW4aXr9OtPNg04n1YDdSeHeSfW5mpplkpxp8wPuAV76J9bdDlwY5MboL0k
	6WdhHkQ==
X-Google-Smtp-Source: AGHT+IHbe1DxlHRAKrzSKiVOtakxA6Q18A5QeFHX1nkM8ma5D0AnWniiwkUYIfGXxIcoemP4HQq1Zn/FTkGf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dbd:ee44:8908 with SMTP
 id w13-20020a056902100d00b00dbdee448908mr615704ybt.0.1713248151392; Mon, 15
 Apr 2024 23:15:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:19 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 03/16] perf parse-events: Avoid copying an empty list
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

In parse_events_add_pmu, delay copying the list of terms until it is
known the list contains terms.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2d5a275dd257..3b1f767039fa 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1398,29 +1398,21 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
 
-	parse_events_terms__init(&parsed_terms);
-	if (const_parsed_terms) {
-		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
-
-		if (ret)
-			return ret;
-	}
-
 	if (verbose > 1) {
 		struct strbuf sb;
 
 		strbuf_init(&sb, /*hint=*/ 0);
-		if (pmu->selectable && list_empty(&parsed_terms.terms)) {
+		if (pmu->selectable && const_parsed_terms &&
+		    list_empty(&const_parsed_terms->terms)) {
 			strbuf_addf(&sb, "%s//", pmu->name);
 		} else {
 			strbuf_addf(&sb, "%s/", pmu->name);
-			parse_events_terms__to_strbuf(&parsed_terms, &sb);
+			parse_events_terms__to_strbuf(const_parsed_terms, &sb);
 			strbuf_addch(&sb, '/');
 		}
 		fprintf(stderr, "Attempt to add: %s\n", sb.buf);
 		strbuf_release(&sb);
 	}
-	fix_raw(&parsed_terms, pmu);
 
 	memset(&attr, 0, sizeof(attr));
 	if (pmu->perf_event_attr_init_default)
@@ -1428,7 +1420,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	attr.type = pmu->type;
 
-	if (list_empty(&parsed_terms.terms)) {
+	if (!const_parsed_terms || list_empty(&const_parsed_terms->terms)) {
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
@@ -1437,6 +1429,15 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return evsel ? 0 : -ENOMEM;
 	}
 
+	parse_events_terms__init(&parsed_terms);
+	if (const_parsed_terms) {
+		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
+
+		if (ret)
+			return ret;
+	}
+	fix_raw(&parsed_terms, pmu);
+
 	/* Configure attr/terms with a known PMU, this will set hardcoded terms. */
 	if (config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
 		parse_events_terms__exit(&parsed_terms);
-- 
2.44.0.683.g7961c838ac-goog


