Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A08F7D5E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjJXW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbjJXW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:26:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A71BDF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3a38b96cso5574231276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186343; x=1698791143; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtLWFp/Ay9yY6/sZZC/VcUQilprFkB+Z9rXtdAZQ2Hk=;
        b=vPvtXrnG8y52U1DnsKfD3FlNUA/UY/g3ZmVg0L5CYQShxdXUf8wRf3pZB+jRG8gEmb
         sJ/8waadxrtY6OZHqiBYN7W7/0CejexF/FSHZJ5XkVbnO5Txt67fZLgV24iwCDBxm+Bb
         C7p47VBoIvJNXtDN/QboNm6yziMnKhwmtyVo8SvDLVcfWkWtB4hups1Jd77XqvOgu9a0
         7uIho2d+zfBA2E8bAOqf9WFdFWtyorfkBNUcDYdinqWyIi8UHqWfq9ID0ZHHgDaqkN/5
         Lpv+xLEdSbEh8cmKnuWm5zjYWHWWkVXrJSXtIRX8YHejpeMNJcu1yZqF+cEc899WtyS2
         dgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186343; x=1698791143;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtLWFp/Ay9yY6/sZZC/VcUQilprFkB+Z9rXtdAZQ2Hk=;
        b=i9gISZUFIFjW9rHM1GwA+9taO5F3yXjNgPIiZlFxGzMlmSCDBbER2mmr9ZJikKh0gW
         6CPAf0GcGt/8Ak6PyIrCTfDeCsoeARNJOxQ2unS1M/VXCJuD96n8TWrHTFid4mHWe1f0
         YSAHQk0JKTcG4pB5HiVHzo62G7+Kh3ClDqNZkVfFeU9AULzUkA3TvP8iDPzAHuM9QlfD
         dVd2iJP0WaGgbTCBFpgfS53zy0UT5iU25ImA5G7MesamaeYYjhVr/C7SJV794IAMeP6n
         d+z7UQfJ8neZy7R5quUJ9MjPUc7KupUF+l/AsfdOVkFyeVGFW2946NgPYY0EdaXaDvHH
         oDXw==
X-Gm-Message-State: AOJu0YwCfHK6K2tghZ1emHyTHLG3Gq4qcWTZ+lhZgIPRaFj+3VVygGti
        cuNIL2LXsfkZa6MjKRdvNeTNbJTwkr0U
X-Google-Smtp-Source: AGHT+IH1VJaLecK8Lh/GjKSrj6AHVlw+lugysGylLHLYOzg2UmD5lYnTuPdFaNM/Qb3X0R/yjnlmGpi0SUnn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1888:b0:d9a:520f:1988 with SMTP
 id cj8-20020a056902188800b00d9a520f1988mr364100ybb.4.1698186343062; Tue, 24
 Oct 2023 15:25:43 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:43 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-41-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 40/50] perf maps: Get map before returning in maps__find_by_name
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
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/vmlinux-kallsyms.c |  5 +++--
 tools/perf/util/machine.c           |  6 ++++--
 tools/perf/util/maps.c              |  6 +++---
 tools/perf/util/probe-event.c       |  1 +
 tools/perf/util/symbol-elf.c        |  4 +++-
 tools/perf/util/symbol.c            | 18 +++++++++++-------
 6 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index e808e6fc8f76..fecbf851bb2e 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -131,9 +131,10 @@ static int test__vmlinux_matches_kallsyms_cb1(struct map *map, void *data)
 	struct map *pair = maps__find_by_name(args->kallsyms.kmaps,
 					(dso->kernel ? dso->short_name : dso->name));
 
-	if (pair)
+	if (pair) {
 		map__set_priv(pair, 1);
-	else {
+		map__put(pair);
+	} else {
 		if (!args->header_printed) {
 			pr_info("WARN: Maps only in vmlinux:\n");
 			args->header_printed = true;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1112a9dbb21a..d6b3f84cb935 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1538,8 +1538,10 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 		return 0;
 
 	long_name = strdup(path);
-	if (long_name == NULL)
+	if (long_name == NULL) {
+		map__put(map);
 		return -ENOMEM;
+	}
 
 	dso = map__dso(map);
 	dso__set_long_name(dso, long_name, true);
@@ -1553,7 +1555,7 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 		dso->symtab_type++;
 		dso->comp = m->comp;
 	}
-
+	map__put(map);
 	return 0;
 }
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 28facfdac1d7..8a8c1f216b86 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -885,7 +885,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 			struct dso *dso = map__dso(maps__maps_by_name(maps)[i]);
 
 			if (dso && strcmp(dso->short_name, name) == 0) {
-				result = maps__maps_by_name(maps)[i]; // TODO: map__get
+				result = map__get(maps__maps_by_name(maps)[i]);
 				done = true;
 			}
 		}
@@ -897,7 +897,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 					sizeof(*mapp), map__strcmp_name);
 
 			if (mapp) {
-				result = *mapp; // TODO: map__get
+				result = map__get(*mapp);
 				i = mapp - maps__maps_by_name(maps);
 				RC_CHK_ACCESS(maps)->last_search_by_name_idx = i;
 			}
@@ -922,7 +922,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 					struct dso *dso = map__dso(pos);
 
 					if (dso && strcmp(dso->short_name, name) == 0) {
-						result = pos; // TODO: map__get
+						result = map__get(pos);
 						break;
 					}
 				}
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a1a796043691..be71abe8b9b0 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -358,6 +358,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 		map = maps__find_by_name(machine__kernel_maps(host_machine), module_name);
 		if (map) {
 			dso = map__dso(map);
+			map__put(map);
 			goto found;
 		}
 		pr_debug("Failed to find module %s.\n", module);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4b934ed3bfd1..5990e3fabdb5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1470,8 +1470,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_loaded(curr_dso);
 		*curr_mapp = curr_map;
 		*curr_dsop = curr_dso;
-	} else
+	} else {
 		*curr_dsop = map__dso(curr_map);
+		map__put(curr_map);
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ad4819a24320..3f31e868d883 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -814,7 +814,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				struct map *initial_map)
 {
 	struct machine *machine;
-	struct map *curr_map = initial_map;
+	struct map *curr_map = map__get(initial_map);
 	struct symbol *pos;
 	int count = 0, moved = 0;
 	struct rb_root_cached *root = &dso->symbols;
@@ -858,13 +858,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					dso__set_loaded(curr_map_dso);
 				}
 
+				map__zput(curr_map);
 				curr_map = maps__find_by_name(kmaps, module);
 				if (curr_map == NULL) {
 					pr_debug("%s/proc/{kallsyms,modules} "
 					         "inconsistency while looking "
 						 "for \"%s\" module!\n",
 						 machine->root_dir, module);
-					curr_map = initial_map;
+					curr_map = map__get(initial_map);
 					goto discard_symbol;
 				}
 				curr_map_dso = map__dso(curr_map);
@@ -888,7 +889,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 * symbols at this point.
 			 */
 			goto discard_symbol;
-		} else if (curr_map != initial_map) {
+		} else if (RC_CHK_ACCESS(curr_map) != RC_CHK_ACCESS(initial_map)) {
 			char dso_name[PATH_MAX];
 			struct dso *ndso;
 
@@ -899,7 +900,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			}
 
 			if (count == 0) {
-				curr_map = initial_map;
+				map__zput(curr_map);
+				curr_map = map__get(initial_map);
 				goto add_symbol;
 			}
 
@@ -913,6 +915,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					kernel_range++);
 
 			ndso = dso__new(dso_name);
+			map__zput(curr_map);
 			if (ndso == NULL)
 				return -1;
 
@@ -926,6 +929,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
 			if (maps__insert(kmaps, curr_map)) {
+				map__zput(curr_map);
 				dso__put(ndso);
 				return -1;
 			}
@@ -936,7 +940,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			pos->end -= delta;
 		}
 add_symbol:
-		if (curr_map != initial_map) {
+		if (RC_CHK_ACCESS(curr_map) != RC_CHK_ACCESS(initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
 			rb_erase_cached(&pos->rb_node, root);
@@ -951,12 +955,12 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		symbol__delete(pos);
 	}
 
-	if (curr_map != initial_map &&
+	if (RC_CHK_ACCESS(curr_map) != RC_CHK_ACCESS(initial_map) &&
 	    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 	    machine__is_default_guest(maps__machine(kmaps))) {
 		dso__set_loaded(map__dso(curr_map));
 	}
-
+	map__put(curr_map);
 	return count + moved;
 }
 
-- 
2.42.0.758.gaed0368e0e-goog

