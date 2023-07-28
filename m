Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B572E766097
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjG1ANK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjG1ANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:13:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6948F2139
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:13:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so1378333276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503180; x=1691107980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWz7XL7DQKS0EfsO7HA2MTsxrytCVyGHUhFfdbWDZ6s=;
        b=IuvFR8BF5x1tWF1G6W+CDSQZV/ETHOkjlt5JLQdNIV3O6uadOqnLA7xXftF9bM1JRJ
         on3qOQgxzN77vfUrqRid2baZtPRCfB9sIRH5BCkItKwFeqszmlmOn5YSBgft7bE7z/6Q
         optwoMN3KaiZrIGku9DTaf4OIfHXFoNsmZF0uQ3EIckjvyynrnwAtaa58wWI+6s2Ig65
         wVEfTqaXWXIyKp8vHk3ROuUMRureFKatzpizPZ6FYru+IrCB8wbfKnL/ZJRjTP7f7J7m
         PGqB7U2SoXoG1l6H6j360dMT4DCVrFFPBUho6CaHWZEJrgfmiER5JUHJS/YwGAZN4WIF
         wB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503180; x=1691107980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWz7XL7DQKS0EfsO7HA2MTsxrytCVyGHUhFfdbWDZ6s=;
        b=ezNcJLk1Q765Zreqh2I6kpzecoFFL9YHMIYWReOSvSv2eL+G4gIMd+hItRI5OS3+it
         5BmSkS/q1V+Xj3AhIh3vQatu9Cium8OwuIulUUb6HjXcVrBVPDh14ctpZ6wz1RPz6EsN
         PAqxlbnqXi/0SYij2KeFpddPf/Bgp0CMEeWEyoa+CtytX82F8w0jNHzrqEysDEp0vl71
         QMng88CzJJnAjwNdeQnhi0EUYxlSZQZcfjMEiAG05QUwEAFjC7w97lEppd1RlET7A17e
         w3oX3JKxIXc75kLE43mQGhBjhIjp1FwmiEgxokpHpQABirsoxrbmIFrOnivmc2PZ2AbM
         Iesw==
X-Gm-Message-State: ABy/qLbG0LAXCRBiSTRV20KigHMeQFr1NpP1OG2oNIcM0qCecQwLNa/n
        fwpMik85/Y5VIDGmGFNAdPQ0foo914G+
X-Google-Smtp-Source: APBJJlFpuxfDhuyA9wPq1j8ekeU8floVzkUu1hEuEp9+trKyCpF1P2gF/EEdIZPyXLG7MeOx8eR5n175A9UL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a05:6902:569:b0:d11:3c58:2068 with SMTP id
 a9-20020a056902056900b00d113c582068mr1077ybt.2.1690503180537; Thu, 27 Jul
 2023 17:13:00 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:12:12 -0700
In-Reply-To: <20230728001212.457900-1-irogers@google.com>
Message-Id: <20230728001212.457900-4-irogers@google.com>
Mime-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 3/3] perf parse-events: Remove array remnants
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parse_events_array was set up by event term parsing, which no longer
exists. Remove this struct and references to it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-loader.c   | 101 ---------------------------------
 tools/perf/util/parse-events.c |   8 ---
 tools/perf/util/parse-events.h |  10 ----
 3 files changed, 119 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 44cde27d6389..108eca9ddad4 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1091,16 +1091,12 @@ enum bpf_map_op_type {
 
 enum bpf_map_key_type {
 	BPF_MAP_KEY_ALL,
-	BPF_MAP_KEY_RANGES,
 };
 
 struct bpf_map_op {
 	struct list_head list;
 	enum bpf_map_op_type op_type;
 	enum bpf_map_key_type key_type;
-	union {
-		struct parse_events_array array;
-	} k;
 	union {
 		u64 value;
 		struct evsel *evsel;
@@ -1116,8 +1112,6 @@ bpf_map_op__delete(struct bpf_map_op *op)
 {
 	if (!list_empty(&op->list))
 		list_del_init(&op->list);
-	if (op->key_type == BPF_MAP_KEY_RANGES)
-		parse_events__clear_array(&op->k.array);
 	free(op);
 }
 
@@ -1196,18 +1190,6 @@ bpf_map_op_setkey(struct bpf_map_op *op, struct parse_events_term *term)
 	if (!term)
 		return 0;
 
-	if (term->array.nr_ranges) {
-		size_t memsz = term->array.nr_ranges *
-				sizeof(op->k.array.ranges[0]);
-
-		op->k.array.ranges = memdup(term->array.ranges, memsz);
-		if (!op->k.array.ranges) {
-			pr_debug("Not enough memory to alloc indices for map\n");
-			return -ENOMEM;
-		}
-		op->key_type = BPF_MAP_KEY_RANGES;
-		op->k.array.nr_ranges = term->array.nr_ranges;
-	}
 	return 0;
 }
 
@@ -1244,18 +1226,6 @@ bpf_map_op__clone(struct bpf_map_op *op)
 	}
 
 	INIT_LIST_HEAD(&newop->list);
-	if (op->key_type == BPF_MAP_KEY_RANGES) {
-		size_t memsz = op->k.array.nr_ranges *
-			       sizeof(op->k.array.ranges[0]);
-
-		newop->k.array.ranges = memdup(op->k.array.ranges, memsz);
-		if (!newop->k.array.ranges) {
-			pr_debug("Failed to alloc indices for map\n");
-			free(newop);
-			return NULL;
-		}
-	}
-
 	return newop;
 }
 
@@ -1456,40 +1426,6 @@ struct bpf_obj_config__map_func bpf_obj_config__map_funcs[] = {
 	{"event", bpf_map__config_event},
 };
 
-static int
-config_map_indices_range_check(struct parse_events_term *term,
-			       struct bpf_map *map,
-			       const char *map_name)
-{
-	struct parse_events_array *array = &term->array;
-	unsigned int i;
-
-	if (!array->nr_ranges)
-		return 0;
-	if (!array->ranges) {
-		pr_debug("ERROR: map %s: array->nr_ranges is %d but range array is NULL\n",
-			 map_name, (int)array->nr_ranges);
-		return -BPF_LOADER_ERRNO__INTERNAL;
-	}
-
-	if (!map) {
-		pr_debug("Map '%s' is invalid\n", map_name);
-		return -BPF_LOADER_ERRNO__INTERNAL;
-	}
-
-	for (i = 0; i < array->nr_ranges; i++) {
-		unsigned int start = array->ranges[i].start;
-		size_t length = array->ranges[i].length;
-		unsigned int idx = start + length - 1;
-
-		if (idx >= bpf_map__max_entries(map)) {
-			pr_debug("ERROR: index %d too large\n", idx);
-			return -BPF_LOADER_ERRNO__OBJCONF_MAP_IDX2BIG;
-		}
-	}
-	return 0;
-}
-
 static int
 bpf__obj_config_map(struct bpf_object *obj,
 		    struct parse_events_term *term,
@@ -1525,12 +1461,6 @@ bpf__obj_config_map(struct bpf_object *obj,
 		goto out;
 	}
 
-	*key_scan_pos += strlen(map_opt);
-	err = config_map_indices_range_check(term, map, map_name);
-	if (err)
-		goto out;
-	*key_scan_pos -= strlen(map_opt);
-
 	for (i = 0; i < ARRAY_SIZE(bpf_obj_config__map_funcs); i++) {
 		struct bpf_obj_config__map_func *func =
 				&bpf_obj_config__map_funcs[i];
@@ -1579,7 +1509,6 @@ typedef int (*map_config_func_t)(const char *name, int map_fd,
 				 const struct bpf_map *map,
 				 struct bpf_map_op *op,
 				 void *pkey, void *arg);
-
 static int
 foreach_key_array_all(map_config_func_t func,
 		      void *arg, const char *name,
@@ -1600,32 +1529,6 @@ foreach_key_array_all(map_config_func_t func,
 	return 0;
 }
 
-static int
-foreach_key_array_ranges(map_config_func_t func, void *arg,
-			 const char *name, int map_fd,
-			 const struct bpf_map *map,
-			 struct bpf_map_op *op)
-{
-	unsigned int i, j;
-	int err;
-
-	for (i = 0; i < op->k.array.nr_ranges; i++) {
-		unsigned int start = op->k.array.ranges[i].start;
-		size_t length = op->k.array.ranges[i].length;
-
-		for (j = 0; j < length; j++) {
-			unsigned int idx = start + j;
-
-			err = func(name, map_fd, map, op, &idx, arg);
-			if (err) {
-				pr_debug("ERROR: failed to insert value to %s[%u]\n",
-					 name, idx);
-				return err;
-			}
-		}
-	}
-	return 0;
-}
 
 static int
 bpf_map_config_foreach_key(struct bpf_map *map,
@@ -1666,10 +1569,6 @@ bpf_map_config_foreach_key(struct bpf_map *map,
 				err = foreach_key_array_all(func, arg, name,
 							    map_fd, map, op);
 				break;
-			case BPF_MAP_KEY_RANGES:
-				err = foreach_key_array_ranges(func, arg, name,
-							       map_fd, map, op);
-				break;
 			default:
 				pr_debug("ERROR: keytype for map '%s' invalid\n",
 					 name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0e2004511cf5..70841b0febf3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2717,9 +2717,6 @@ int parse_events_term__clone(struct parse_events_term **new,
 
 void parse_events_term__delete(struct parse_events_term *term)
 {
-	if (term->array.nr_ranges)
-		zfree(&term->array.ranges);
-
 	if (term->type_val != PARSE_EVENTS__TERM_TYPE_NUM)
 		zfree(&term->val.str);
 
@@ -2770,11 +2767,6 @@ void parse_events_terms__delete(struct list_head *terms)
 	free(terms);
 }
 
-void parse_events__clear_array(struct parse_events_array *a)
-{
-	zfree(&a->ranges);
-}
-
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e59b33805886..b77ff619a623 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -81,17 +81,8 @@ enum {
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
-struct parse_events_array {
-	size_t nr_ranges;
-	struct {
-		unsigned int start;
-		size_t length;
-	} *ranges;
-};
-
 struct parse_events_term {
 	char *config;
-	struct parse_events_array array;
 	union {
 		char *str;
 		u64  num;
@@ -162,7 +153,6 @@ int parse_events_term__clone(struct parse_events_term **new,
 void parse_events_term__delete(struct parse_events_term *term);
 void parse_events_terms__delete(struct list_head *terms);
 void parse_events_terms__purge(struct list_head *terms);
-void parse_events__clear_array(struct parse_events_array *a);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
 int parse_events_name(struct list_head *list, const char *name);
-- 
2.41.0.487.g6d72f3e995-goog

