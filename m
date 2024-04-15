Return-Path: <linux-kernel+bounces-144597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A918A483B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3EB1F226E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768F374EA;
	Mon, 15 Apr 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whYhHOca"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBD364AC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163007; cv=none; b=mVILAHJjVnvYlnQToaS5qJD4+S3sfx1S8CiF1Rw92THPERmvwS60c3CGfighpv66knM16wbkipxmJDHbx05l9c1rzzD5Ugfmh97MdDo8xoD7t+9Xj4+NAP/UWb3ShwPY663/CnBMdUNiHiAvaYnOmc6UNlQrCnw3f4Xt5kTlp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163007; c=relaxed/simple;
	bh=0qNUELlBjl8dO1+sdDUCDBg6O9xZvVY5pIsvof/yf3Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tH2BdaA0iL1ZMAJm/e97IyTlDBJuevioHXT74U1D8STJQpnj7WMGV9h0LRjz432y6tjZrY4chJ9IG7cVQ3uoVwU4+D3v3SzbhULjaju0p2a9aN0NTSFQWmfUU9Oxc6aj15jiGfy0MLzLj6vOeNiart3R/rLRNEC8r2I6HDj6FNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whYhHOca; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so4155933276.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163005; x=1713767805; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hx/Ta0rDGqfG4yTzEhISDdPx4oXkJbCeHRtXa2sGNYw=;
        b=whYhHOcapG2gxVPKNsrJ1t/iUzeCyUiF0iaJ41cp+kFsRWALiNmG+NCp/AnlVjNFNO
         zwwbbpDQftH6OGur+ZQvBZSJ3nu3USJqpbgHXlHbKZypi71MMByRGWHOTUmcFL04oBFb
         8jDglc0tYbWojnI2nWcO2FhR+jlR5CyvJyrstEhCts9ucqVunhELgGUmbSEu0km/j40m
         9wY545dSOaGSE1r8wl4vzjmNmLEca3QmJbcbTzxvG3m8nUSWLbuzToMU7+6yYPT4ACZS
         b8oW/hqwD+EcG4MBKsgUgs1I9MfN488WOpVYcWj18eNLANbnpabydyh2yU2kttCPopHv
         Ii2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163005; x=1713767805;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx/Ta0rDGqfG4yTzEhISDdPx4oXkJbCeHRtXa2sGNYw=;
        b=nLDcXnY0ldBCAx57Jmog9ES4pzHoPstCJUokArn0LWKcRcXFIcPwnOZRPk1biXRC9G
         NIkCcWcFsurQMmUs463WPOq+VNh7BkW1QsywOm7pOgLwtBtpLEo8njXt4jPWVa2CUtb3
         JN+MzfTe5llRIKu/b4VEszpNtmvgftX8KwwRZ5VYVk2Zs6a1xihgwJZdBxCywI5THxLl
         pwV9TV98Cp01mqNADPgtkY61NL8rZy3UtGPeXmjs4K4JqrsLuz4EdIf1K+5hKDoBtaut
         GULyB4hzZGZbdfziOs5Z18Ybi8wXnJV4IBeJ/iZ0OUWoOnbNBULNM84DEZENYEGBH8mU
         2zJw==
X-Forwarded-Encrypted: i=1; AJvYcCVY1d+ASFg7AHGrMq0vBN7yryujARl2Q6YiEGOPLGeUg+GmXiW8z7izqs3CUAWOTCMos7CReOGIHidPKBQMOuMISnq/29kLZ7MjWy8S
X-Gm-Message-State: AOJu0YzmHOGjU2NOuBxpJdsfxKL4c1fK1bll7ljmTcFQzU/mDXvqxoIy
	QrJ3Rf/9pbZgrVBLzcYPXqa49aBEgOsiF49lpJ6DRxehY76rf+w0l87UFvPVrUyTBLur7tnSvW4
	pkOj0Jg==
X-Google-Smtp-Source: AGHT+IGKjbFopUbPAz4023seU2rQZ1FOntIZ8rt7x+OCB1yu2RcNgzS+jPNzrST2MfTWwwugdpm9slVKlTFo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:6902:120b:b0:de0:ecc6:87b with SMTP id
 s11-20020a056902120b00b00de0ecc6087bmr742661ybu.1.1713163004978; Sun, 14 Apr
 2024 23:36:44 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:23 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 6/9] perf parse-events: Legacy cache names on all PMUs and
 lower priority
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

Prior behavior is to not look for legacy cache names in sysfs/json and
to create events on all core PMUs. New behavior is to look for
sysfs/json events first on all PMUs, for core PMUs add a legacy event
if the sysfs/json event isn't present.

This is done so that there is consistency with how event names in
terms are handled and their prioritization of sysfs/json over
legacy. It may make sense to use a legacy cache event name as an event
name on a non-core PMU so we should allow it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 38 +++++++++++++++++++++++++++-------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f4de374dab59..f711ad9b18f0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -442,17 +442,21 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
 }
 
+static int parse_events_add_pmu(struct parse_events_state *parse_state,
+				struct list_head *list, struct perf_pmu *pmu,
+				const struct parse_events_terms *const_parsed_terms,
+				bool auto_merge_stats);
+
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *head_config)
+			   struct parse_events_terms *parsed_terms)
 {
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
-	const char *config_name = get_config_name(head_config);
-	const char *metric_id = get_config_metric_id(head_config);
+	const char *config_name = get_config_name(parsed_terms);
+	const char *metric_id = get_config_metric_id(parsed_terms);
 
-	/* Legacy cache events are only supported by core PMUs. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
 		int ret;
@@ -460,6 +464,24 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
+		if (perf_pmu__have_event(pmu, name)) {
+			/*
+			 * The PMU has the event so add as not a legacy cache
+			 * event.
+			 */
+			ret = parse_events_add_pmu(parse_state, list, pmu,
+						   parsed_terms,
+						   perf_pmu__auto_merge_stats(pmu));
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		if (!pmu->is_core) {
+			/* Legacy cache events are only supported by core PMUs. */
+			continue;
+		}
+
 		memset(&attr, 0, sizeof(attr));
 		attr.type = PERF_TYPE_HW_CACHE;
 
@@ -469,11 +491,11 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		found_supported = true;
 
-		if (head_config) {
-			if (config_attr(&attr, head_config, parse_state->error, config_term_common))
+		if (parsed_terms) {
+			if (config_attr(&attr, parsed_terms, parse_state->error, config_term_common))
 				return -EINVAL;
 
-			if (get_config_terms(head_config, &config_terms))
+			if (get_config_terms(parsed_terms, &config_terms))
 				return -ENOMEM;
 		}
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a331b9f0da2b..db47913e54bc 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -203,7 +203,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *head_config);
+			   struct parse_events_terms *parsed_terms);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
-- 
2.44.0.683.g7961c838ac-goog


