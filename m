Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE678E707
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbjHaHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245210AbjHaHOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:14:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A33CC5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:14:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d748b6f1077so381957276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693466086; x=1694070886; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NB1bEEk68L9clRTh/1y8/DGAe5vmtd3xg5rJJg8exGQ=;
        b=U3QXWtX75Vk62ysY3PsvDtr4km0Q0x/zVhvJCvsCySIN6hREjHf+WPKYg8YxTUxlbN
         JDj/v1GpV8GiOoaAWfKa2tmOo9aX4Y6cVY608suCWIAfuvgAp83KIHcn5EyI2D8LCK3b
         WqZLkQF3b5Tx+hyLimuV102+RMHpxTg72Tilfcdqd2MTY7nlQ33p6EpqQwLclx8y5Jvp
         EQrGSLhTB9GWDqZpeiL5FR6h4fetfJgn+gNBIpzlGiv09SX2ENpqPHe+LpxEBBoBWyC7
         g+Z9Iu0dVhpA0tOJemqZaOpG4V3IAUvDHJS6ubtE1XSCynEpOUC3c8pP6lwcTOn2zH4C
         IljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466086; x=1694070886;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NB1bEEk68L9clRTh/1y8/DGAe5vmtd3xg5rJJg8exGQ=;
        b=gtpW3j95Yf46FT53nrN72lSEPi7zZM7IEa7FkOtiVYxDLhZVHXnUaV6rIcW/IzmQc3
         +wClRiImMrZ4OqJQgm1fVB5/WhShmYGUiWAngu7YEgWCur8E09Eshm2YLoxxauJ1uFS0
         TQmRmwnd/jlSGEwuVXQGwj2W82tY1cVJZEXd7Ks9GyBGfaiVIPWcPwPSuxa6iCrIVFEw
         N6uQhn9tqtY9QUKk2/Psi3KuqRxbBahzGbX9fCQOsC77M1/ECvt0uoBS9/OpKy/x05tx
         kSG46fO4AWB1kUBdOOhQnYFfk4VcWJRJU9foM5Nl1ucnhLoVBgSnciZQ02U5OeRoxYx5
         nFzg==
X-Gm-Message-State: AOJu0YyR5zYP/hsqKlzbu9EL+dJT9CHQ2kWOfC2P5sUjQiO9xKf5UASw
        qNMUed+ujsibqRcxNsb7o+m47s8377lc
X-Google-Smtp-Source: AGHT+IFiAhnCHPJZhHHCszMGcWw9cDcgxOBQylSDhdZ9udRXZAU+oCg3AeosZZSmbUJ+BCyopXKmPeu7WjCy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:feef:cd5e:6353:57f0])
 (user=irogers job=sendgmr) by 2002:a25:456:0:b0:d78:3b16:e1f2 with SMTP id
 83-20020a250456000000b00d783b16e1f2mr140850ybe.0.1693466086394; Thu, 31 Aug
 2023 00:14:46 -0700 (PDT)
Date:   Thu, 31 Aug 2023 00:14:20 -0700
In-Reply-To: <20230831071421.2201358-1-irogers@google.com>
Message-Id: <20230831071421.2201358-3-irogers@google.com>
Mime-Version: 1.0
References: <20230831071421.2201358-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 2/3] perf parse-events: Name the two term enums
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the enums used by struct parse_events_term to
parse_events__term_val_type and parse_events__term_type. This allows
greater compile time error checking. Fix -Wswitch related issues by
explicitly listing all enum values prior to default. Add
config_term_name to safely look up a parse_events__term_type name,
bounds checking the array access first. Add documentation to struct
parse_events_terms and reorder to save space.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 174 ++++++++++++++++++++++++---------
 tools/perf/util/parse-events.h |  60 +++++++++---
 tools/perf/util/parse-events.l |   2 +-
 tools/perf/util/parse-events.y |  18 +++-
 4 files changed, 187 insertions(+), 67 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0b941b58bdc0..51b73207e9f4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -153,7 +153,7 @@ const char *event_type(int type)
 	return "unknown";
 }
 
-static char *get_config_str(struct list_head *head_terms, int type_term)
+static char *get_config_str(struct list_head *head_terms, enum parse_events__term_type type_term)
 {
 	struct parse_events_term *term;
 
@@ -722,7 +722,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 
 static int check_type_val(struct parse_events_term *term,
 			  struct parse_events_error *err,
-			  int type)
+			  enum parse_events__term_val_type type)
 {
 	if (type == term->type_val)
 		return 0;
@@ -737,42 +737,49 @@ static int check_type_val(struct parse_events_term *term,
 	return -EINVAL;
 }
 
-/*
- * Update according to parse-events.l
- */
-static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
-	[PARSE_EVENTS__TERM_TYPE_USER]			= "<sysfs term>",
-	[PARSE_EVENTS__TERM_TYPE_CONFIG]		= "config",
-	[PARSE_EVENTS__TERM_TYPE_CONFIG1]		= "config1",
-	[PARSE_EVENTS__TERM_TYPE_CONFIG2]		= "config2",
-	[PARSE_EVENTS__TERM_TYPE_CONFIG3]		= "config3",
-	[PARSE_EVENTS__TERM_TYPE_NAME]			= "name",
-	[PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]		= "period",
-	[PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]		= "freq",
-	[PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE]	= "branch_type",
-	[PARSE_EVENTS__TERM_TYPE_TIME]			= "time",
-	[PARSE_EVENTS__TERM_TYPE_CALLGRAPH]		= "call-graph",
-	[PARSE_EVENTS__TERM_TYPE_STACKSIZE]		= "stack-size",
-	[PARSE_EVENTS__TERM_TYPE_NOINHERIT]		= "no-inherit",
-	[PARSE_EVENTS__TERM_TYPE_INHERIT]		= "inherit",
-	[PARSE_EVENTS__TERM_TYPE_MAX_STACK]		= "max-stack",
-	[PARSE_EVENTS__TERM_TYPE_MAX_EVENTS]		= "nr",
-	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
-	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
-	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
-	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
-	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
-	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
-	[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
-	[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
-	[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
-	[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
-};
-
 static bool config_term_shrinked;
 
+static const char *config_term_name(enum parse_events__term_type term_type)
+{
+	/*
+	 * Update according to parse-events.l
+	 */
+	static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
+		[PARSE_EVENTS__TERM_TYPE_USER]			= "<sysfs term>",
+		[PARSE_EVENTS__TERM_TYPE_CONFIG]		= "config",
+		[PARSE_EVENTS__TERM_TYPE_CONFIG1]		= "config1",
+		[PARSE_EVENTS__TERM_TYPE_CONFIG2]		= "config2",
+		[PARSE_EVENTS__TERM_TYPE_CONFIG3]		= "config3",
+		[PARSE_EVENTS__TERM_TYPE_NAME]			= "name",
+		[PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]		= "period",
+		[PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]		= "freq",
+		[PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE]	= "branch_type",
+		[PARSE_EVENTS__TERM_TYPE_TIME]			= "time",
+		[PARSE_EVENTS__TERM_TYPE_CALLGRAPH]		= "call-graph",
+		[PARSE_EVENTS__TERM_TYPE_STACKSIZE]		= "stack-size",
+		[PARSE_EVENTS__TERM_TYPE_NOINHERIT]		= "no-inherit",
+		[PARSE_EVENTS__TERM_TYPE_INHERIT]		= "inherit",
+		[PARSE_EVENTS__TERM_TYPE_MAX_STACK]		= "max-stack",
+		[PARSE_EVENTS__TERM_TYPE_MAX_EVENTS]		= "nr",
+		[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
+		[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
+		[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
+		[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
+		[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+		[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
+		[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
+		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
+		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+	};
+	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
+		return "unknown term";
+
+	return config_term_names[term_type];
+}
+
 static bool
-config_term_avail(int term_type, struct parse_events_error *err)
+config_term_avail(enum parse_events__term_type term_type, struct parse_events_error *err)
 {
 	char *err_str;
 
@@ -794,13 +801,31 @@ config_term_avail(int term_type, struct parse_events_error *err)
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
+	case PARSE_EVENTS__TERM_TYPE_USER:
+	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
+	case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
+	case PARSE_EVENTS__TERM_TYPE_TIME:
+	case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
+	case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
+	case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
+	case PARSE_EVENTS__TERM_TYPE_INHERIT:
+	case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
+	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
+	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
+	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
+	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
+	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
+	case PARSE_EVENTS__TERM_TYPE_RAW:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
+	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		if (!err)
 			return false;
 
 		/* term_type is validated so indexing is safe */
 		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
-				config_term_names[term_type]) >= 0)
+			     config_term_name(term_type)) >= 0)
 			parse_events_error__handle(err, -1, err_str, NULL);
 		return false;
 	}
@@ -918,10 +943,14 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
+	case PARSE_EVENTS__TERM_TYPE_USER:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
+	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		parse_events_error__handle(err, term->err_term,
-				strdup("unknown term"),
-				parse_events_formats_error_string(NULL));
+					strdup(config_term_name(term->type_term)),
+					parse_events_formats_error_string(NULL));
 		return -EINVAL;
 	}
 
@@ -1007,10 +1036,26 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		return config_term_common(attr, term, err);
+	case PARSE_EVENTS__TERM_TYPE_USER:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+	case PARSE_EVENTS__TERM_TYPE_NAME:
+	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
+	case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
+	case PARSE_EVENTS__TERM_TYPE_TIME:
+	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
+	case PARSE_EVENTS__TERM_TYPE_PERCORE:
+	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
+	case PARSE_EVENTS__TERM_TYPE_RAW:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
+	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
-				strdup("unknown term"),
+						   strdup(config_term_name(term->type_term)),
 				strdup("valid terms: call-graph,stack-size\n"));
 		}
 		return -EINVAL;
@@ -1128,6 +1173,16 @@ do {								\
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
 					    term->val.num, term->weak);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_USER:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_NAME:
+		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
+		case PARSE_EVENTS__TERM_TYPE_RAW:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
+		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		default:
 			break;
 		}
@@ -1157,6 +1212,30 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 		case PARSE_EVENTS__TERM_TYPE_CONFIG:
 			bits = ~(u64)0;
 			break;
+		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_NAME:
+		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
+		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
+		case PARSE_EVENTS__TERM_TYPE_TIME:
+		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
+		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
+		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
+		case PARSE_EVENTS__TERM_TYPE_INHERIT:
+		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
+		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
+		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
+		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
+		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
+		case PARSE_EVENTS__TERM_TYPE_PERCORE:
+		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
+		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
+		case PARSE_EVENTS__TERM_TYPE_RAW:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
+		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		default:
 			break;
 		}
@@ -2386,7 +2465,8 @@ static int new_term(struct parse_events_term **_term,
 }
 
 int parse_events_term__num(struct parse_events_term **term,
-			   int type_term, const char *config, u64 num,
+			   enum parse_events__term_type type_term,
+			   const char *config, u64 num,
 			   bool no_value,
 			   void *loc_term_, void *loc_val_)
 {
@@ -2396,7 +2476,7 @@ int parse_events_term__num(struct parse_events_term **term,
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
-		.config    = config ? : strdup(config_term_names[type_term]),
+		.config    = config ? : strdup(config_term_name(type_term)),
 		.no_value  = no_value,
 		.err_term  = loc_term ? loc_term->first_column : 0,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
@@ -2406,7 +2486,8 @@ int parse_events_term__num(struct parse_events_term **term,
 }
 
 int parse_events_term__str(struct parse_events_term **term,
-			   int type_term, char *config, char *str,
+			   enum parse_events__term_type type_term,
+			   char *config, char *str,
 			   void *loc_term_, void *loc_val_)
 {
 	YYLTYPE *loc_term = loc_term_;
@@ -2424,11 +2505,12 @@ int parse_events_term__str(struct parse_events_term **term,
 }
 
 int parse_events_term__term(struct parse_events_term **term,
-			    int term_lhs, int term_rhs,
+			    enum parse_events__term_type term_lhs,
+			    enum parse_events__term_type term_rhs,
 			    void *loc_term, void *loc_val)
 {
 	return parse_events_term__str(term, term_lhs, NULL,
-				      strdup(config_term_names[term_rhs]),
+				      strdup(config_term_name(term_rhs)),
 				      loc_term, loc_val);
 }
 
@@ -2539,7 +2621,7 @@ int parse_events_term__to_strbuf(struct list_head *term_list, struct strbuf *sb)
 				if (ret < 0)
 					return ret;
 			} else if (term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
-				ret = strbuf_addf(sb, "%s=", config_term_names[term->type_term]);
+				ret = strbuf_addf(sb, "%s=", config_term_name(term->type_term));
 				if (ret < 0)
 					return ret;
 			}
@@ -2567,7 +2649,7 @@ static void config_terms_list(char *buf, size_t buf_sz)
 
 	buf[0] = '\0';
 	for (i = 0; i < __PARSE_EVENTS__TERM_TYPE_NR; i++) {
-		const char *name = config_term_names[i];
+		const char *name = config_term_name(i);
 
 		if (!config_term_avail(i, NULL))
 			continue;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 20bdc35d6112..855b0725c5d4 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -48,12 +48,12 @@ int parse_events_terms(struct list_head *terms, const char *str, FILE *input);
 int parse_filter(const struct option *opt, const char *str, int unset);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
 
-enum {
+enum parse_events__term_val_type {
 	PARSE_EVENTS__TERM_TYPE_NUM,
 	PARSE_EVENTS__TERM_TYPE_STR,
 };
 
-enum {
+enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_USER,
 	PARSE_EVENTS__TERM_TYPE_CONFIG,
 	PARSE_EVENTS__TERM_TYPE_CONFIG1,
@@ -80,27 +80,54 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-	__PARSE_EVENTS__TERM_TYPE_NR,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
 };
 
 struct parse_events_term {
+	/** @list: The term list the term is a part of. */
+	struct list_head list;
+	/**
+	 * @config: The left-hand side of a term assignment, so the term
+	 * "event=8" would have the config be "event"
+	 */
 	const char *config;
+	/**
+	 * @val: The right-hand side of a term assignment that can either be a
+	 * string or a number depending on type_val.
+	 */
 	union {
 		char *str;
 		u64  num;
 	} val;
-	int type_val;
-	int type_term;
-	struct list_head list;
-	bool used;
-	bool no_value;
-
-	/* error string indexes for within parsed string */
+	/** @type_val: The union variable in val to be used for the term. */
+	enum parse_events__term_val_type type_val;
+	/**
+	 * @type_term: A predefined term type or PARSE_EVENTS__TERM_TYPE_USER
+	 * when not inbuilt.
+	 */
+	enum parse_events__term_type type_term;
+	/**
+	 * @err_term: The column index of the term from parsing, used during
+	 * error output.
+	 */
 	int err_term;
+	/**
+	 * @err_val: The column index of the val from parsing, used during error
+	 * output.
+	 */
 	int err_val;
-
-	/* Coming from implicit alias */
+	/** @used: Was the term used during parameterized-eval. */
+	bool used;
+	/**
+	 * @weak: A term from the sysfs or json encoding of an event that
+	 * shouldn't override terms coming from the command line.
+	 */
 	bool weak;
+	/**
+	 * @no_value: Is there no value. TODO: this should really be part of
+	 * type_val.
+	 */
+	bool no_value;
 };
 
 struct parse_events_error {
@@ -139,14 +166,17 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 void parse_events__shrink_config_terms(void);
 int parse_events__is_hardcoded_term(struct parse_events_term *term);
 int parse_events_term__num(struct parse_events_term **term,
-			   int type_term, const char *config, u64 num,
+			   enum parse_events__term_type type_term,
+			   const char *config, u64 num,
 			   bool novalue,
 			   void *loc_term, void *loc_val);
 int parse_events_term__str(struct parse_events_term **term,
-			   int type_term, char *config, char *str,
+			   enum parse_events__term_type type_term,
+			   char *config, char *str,
 			   void *loc_term, void *loc_val);
 int parse_events_term__term(struct parse_events_term **term,
-			    int term_lhs, int term_rhs,
+			    enum parse_events__term_type term_lhs,
+			    enum parse_events__term_type term_rhs,
 			    void *loc_term, void *loc_val);
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term);
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 1147084b2c76..4ef4b6f171a0 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -116,7 +116,7 @@ static int tool(yyscan_t scanner, enum perf_tool_event event)
 	return PE_VALUE_SYM_TOOL;
 }
 
-static int term(yyscan_t scanner, int type)
+static int term(yyscan_t scanner, enum parse_events__term_type type)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4a370c36a0d5..534daed91c50 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -777,7 +777,8 @@ PE_TERM_HW
 PE_TERM '=' name_or_legacy
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, (int)$1, NULL, $3, &@1, &@3);
+	int err = parse_events_term__str(&term, (enum parse_events__term_type)$1,
+					/*config=*/NULL, $3, &@1, &@3);
 
 	if (err) {
 		free($3);
@@ -789,7 +790,8 @@ PE_TERM '=' name_or_legacy
 PE_TERM '=' PE_TERM_HW
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, (int)$1, NULL, $3.str, &@1, &@3);
+	int err = parse_events_term__str(&term, (enum parse_events__term_type)$1,
+					 /*config=*/NULL, $3.str, &@1, &@3);
 
 	if (err) {
 		free($3.str);
@@ -801,7 +803,10 @@ PE_TERM '=' PE_TERM_HW
 PE_TERM '=' PE_TERM
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__term(&term, (int)$1, (int)$3, &@1, &@3);
+	int err = parse_events_term__term(&term,
+					  (enum parse_events__term_type)$1,
+					  (enum parse_events__term_type)$3,
+					  &@1, &@3);
 
 	if (err)
 		PE_ABORT(err);
@@ -812,7 +817,8 @@ PE_TERM '=' PE_TERM
 PE_TERM '=' PE_VALUE
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__num(&term, (int)$1, NULL, $3, false, &@1, &@3);
+	int err = parse_events_term__num(&term, (enum parse_events__term_type)$1,
+					 /*config=*/NULL, $3, /*novalue=*/false, &@1, &@3);
 
 	if (err)
 		PE_ABORT(err);
@@ -823,7 +829,9 @@ PE_TERM '=' PE_VALUE
 PE_TERM
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__num(&term, (int)$1, NULL, 1, true, &@1, NULL);
+	int err = parse_events_term__num(&term, (enum parse_events__term_type)$1,
+					/*config=*/NULL, /*num=*/1, /*novalue=*/true,
+					&@1, /*loc_val=*/NULL);
 
 	if (err)
 		PE_ABORT(err);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

