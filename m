Return-Path: <linux-kernel+bounces-134363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0789B0B4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19985281C46
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36872562E;
	Sun,  7 Apr 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="fjcizU+Z";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ssexH76N"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992C20DCB;
	Sun,  7 Apr 2024 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492342; cv=none; b=eHpp1wsjqbJBxot1LEEhfTEuVvKv28olr3QjVu15L90q1vnvQGXR1msA4LNy1Yp5MXqPDKJUYgtGY/ZzFSE9iOnJIDlvmlfyelAL5TIiH4YXTr5e1xDF77iDMyqaOXdH6/kuvtVUJ/c1tX8Ko/RoeQwNdgipYImmVFkJphJ+gFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492342; c=relaxed/simple;
	bh=YPrT3RrPwtMxYxYHR1tgMYaAG6KTL3PQJhOp5B0pO64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePiB5TjhzUtAHqzmkuG1/5YSd0fipNP13pdfVJlon5gQCCCFVranLTWhKu8J8ecaFwFl18U4kr0d2XmjxOXZ5j2FZZYMSQwY2TUgu3t79Vwn5oAFTV5XVJdWahuC6vfTMKYXX385/He9lJqjFhBpybnn5PwbJrly1gIzf0FO18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=fjcizU+Z; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ssexH76N; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 5D80AC029; Sun,  7 Apr 2024 14:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492338; bh=ySaPnN89k1k/kS3RX4gmm+u+jmLYBvg6IkAyvSgsLXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fjcizU+ZwLUMe2bc9moBAiXDnmoh+uwIrYaxI+EFiHrkbdkakPuwQ51mN/jl2VkTS
	 Pieeqt3oOZTKHYMfoh0M8sYzYEc1MMS2QZjxeOgt8KvRFVSjWr2e6Cit/AY9UO2397
	 bXepDvRy5Em8rupzPzMUCmdkqnZK3RGFv6uu1QIE4QGoiEe4Gx9hvxg2HsSE7owtuw
	 yBTsaGIWtjfOPnDCCWJJwWa1b2IdRae6GfaiBOKiPsTbIfHBEGquI7a7GM0IC7JTfZ
	 TB0zTmn+1hlzyaxOpUhYYaOluvQjo+YHczX+wKcy0WdEoD+kfK9zgxnvUhqzx6lFII
	 xcwiUt7im3swg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 8FB97C021;
	Sun,  7 Apr 2024 14:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492336; bh=ySaPnN89k1k/kS3RX4gmm+u+jmLYBvg6IkAyvSgsLXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ssexH76Nq+Ph9vUT9OsoCOp+xC+nHUol7N1KhJbQK6Tl2p9M1BjGFYaDqD5Q5gK79
	 zGRTwDCKufTkeaSE2GeWkZVc+KbN1mCN7lm/1vO3zlt99OVhIh7Qs98Q1Um74T057+
	 QV6p4ZG4F5leUkCQQazyDmq80wCPTk7eaP/DunWfP66i1JPjvP/oEUa7d01jT7u/f4
	 eysw9gZp6ddJB5hn371tVyUEZ4aVaOgno1mC8n9cb26IjXAqLbSR2iZ4KJkfLyte6Y
	 Er13DEMlNvGz8DLU6yTvBr3WarPp92436RaxMcQtYbWnO2AA5nYCLW5ulcGCzWU6Z8
	 OX4heFF2vkWNg==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 188a9b4c;
	Sun, 7 Apr 2024 12:18:38 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Sun, 07 Apr 2024 21:18:19 +0900
Subject: [PATCH 1/3] perf parse-events: pass parse_state to add_tracepoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-perf_digit-v1-1-57ec37c63394@codewreck.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6036;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=YPrT3RrPwtMxYxYHR1tgMYaAG6KTL3PQJhOp5B0pO64=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmEo8eb7GtTPr46kh5kJ+NWT3vY30ASSM4zRLGq
 /AAgIEFifWJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZhKPHgAKCRCrTpvsapjm
 cLPeD/9NBSQ4wDqoTAdnYfEkz2h//YI+wzWrXFEiHTKiDk7sv3IEL7FgVGD9od/fTwIy9AawVDg
 pD5h3WmYL1jjF0wCVApb8TMS9qOFs57PKK6ROmdy5q8JtlBqrJQeaEtZ68fkzYwgPi8pusPqO+C
 DnMmREhyjGtD6uDPZjGYf9acDzK17dN6C8sInWS3a8ZtD4gaFqnBUQFbDLqhR7l0FqO0dGBqag/
 gGmdZIp6bAbt8AZAPai3r6e2QnI0v0FxNKZUbqZtSRzsABafmosDvpKpPPfebNMZdnUXgOicNQ8
 si69YwvbZtk5UY7bMqKS9V5Oafd6uE8Rod1fK/y2GT2VIJ5hRaTNwzCI0OlIDZJ2VcptvPmKh4u
 oTf2qpLpsPXI5k+f25mbl9V2Phd1aW6QPI4Lt6jQwzBMNBh7x0ysAWMr9C5VLnCvLTs5KvCHVAl
 yRoLHHdqJwwxttUhzCOnVeEbKNbaCpl4e+uuGyW3K1Mw4zIZfOdRVN/pf5H4iIrgnNRAJcc9laP
 k4G1k4ZgVPFhtPLVCRIvCuIXATZcr8CF213Kw+ECczXyBxowsorDvOY3TZbhW8kAjZ5jOGAvKor
 t2ZCDR5MgycGf7+FNqWde6n7l0DM9NewqgM4BF9xXSxtRRZN8UBp82mf9k6y01thDMb9WJfLgU6
 Ucs+YspgfElSODA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

The next patch will add another flag to parse_state that we will want to
pass to evsel__nwetp_idx(), so pass the whole parse_state all the way
down instead of giving only the index

Originally-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/util/parse-events.c | 31 ++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6f8b0fa17689..6e8cba03f0ac 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -519,13 +519,14 @@ static void tracepoint_error(struct parse_events_error *e, int err,
 	parse_events_error__handle(e, column, strdup(str), strdup(help));
 }
 
-static int add_tracepoint(struct list_head *list, int *idx,
+static int add_tracepoint(struct parse_events_state *parse_state,
+			  struct list_head *list,
 			  const char *sys_name, const char *evt_name,
 			  struct parse_events_error *err,
 			  struct parse_events_terms *head_config, void *loc_)
 {
 	YYLTYPE *loc = loc_;
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
@@ -544,7 +545,8 @@ static int add_tracepoint(struct list_head *list, int *idx,
 	return 0;
 }
 
-static int add_tracepoint_multi_event(struct list_head *list, int *idx,
+static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
+				      struct list_head *list,
 				      const char *sys_name, const char *evt_name,
 				      struct parse_events_error *err,
 				      struct parse_events_terms *head_config, YYLTYPE *loc)
@@ -578,7 +580,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 
 		found++;
 
-		ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
+		ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
 				     err, head_config, loc);
 	}
 
@@ -592,19 +594,21 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 	return ret;
 }
 
-static int add_tracepoint_event(struct list_head *list, int *idx,
+static int add_tracepoint_event(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys_name, const char *evt_name,
 				struct parse_events_error *err,
 				struct parse_events_terms *head_config, YYLTYPE *loc)
 {
 	return strpbrk(evt_name, "*?") ?
-		add_tracepoint_multi_event(list, idx, sys_name, evt_name,
+		add_tracepoint_multi_event(parse_state, list, sys_name, evt_name,
 					   err, head_config, loc) :
-		add_tracepoint(list, idx, sys_name, evt_name,
+		add_tracepoint(parse_state, list, sys_name, evt_name,
 			       err, head_config, loc);
 }
 
-static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
+static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
+				    struct list_head *list,
 				    const char *sys_name, const char *evt_name,
 				    struct parse_events_error *err,
 				    struct parse_events_terms *head_config, YYLTYPE *loc)
@@ -630,7 +634,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 		if (!strglobmatch(events_ent->d_name, sys_name))
 			continue;
 
-		ret = add_tracepoint_event(list, idx, events_ent->d_name,
+		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
 					   evt_name, err, head_config, loc);
 	}
 
@@ -1266,7 +1270,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 	return 0;
 }
 
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
 				struct parse_events_terms *head_config, void *loc_)
@@ -1282,14 +1287,14 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 	}
 
 	if (strpbrk(sys, "*?"))
-		return add_tracepoint_multi_sys(list, idx, sys, event,
+		return add_tracepoint_multi_sys(parse_state, list, sys, event,
 						err, head_config, loc);
 	else
-		return add_tracepoint_event(list, idx, sys, event,
+		return add_tracepoint_event(parse_state, list, sys, event,
 					    err, head_config, loc);
 #else
+	(void)parse_state;
 	(void)list;
-	(void)idx;
 	(void)sys;
 	(void)event;
 	(void)head_config;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 809359e8544e..fd55a154ceff 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -189,7 +189,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
 int parse_events_name(struct list_head *list, const char *name);
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
 				struct parse_events_terms *head_config, void *loc);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d70f5d84af92..0bab4263f8e3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -537,7 +537,7 @@ tracepoint_name opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
+	err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
 					error, $2, &@1);
 
 	parse_events_terms__delete($2);

-- 
2.43.0


