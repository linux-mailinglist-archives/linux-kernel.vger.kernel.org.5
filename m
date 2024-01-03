Return-Path: <linux-kernel+bounces-15162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF6D8227EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADAD1C22E42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9605182A8;
	Wed,  3 Jan 2024 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XR/KpROP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A518032
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ecfd153ccfso109903197b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 21:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258414; x=1704863214; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvY724cCwHP6hlu/fSGAIkqdw5CGWNhU4kpeuf9SkbE=;
        b=XR/KpROP7bWTFUy3US5nheI+SWzgty18qixhQVZKiZtHV8JWO2JEi2eoHMkVx1ZOFr
         sVAwNSvBKwGhgjFFx8i9FfrZ36RMi/iB2oBansQveFchcvR9kb7jIySQIiRlyb0dn2Ij
         VOILIV1iKGe2OxuUY6tyDmi62QK0rLu3N+v9drNkktvk0WwMBSX3qe0+dkzl2KTjoxTN
         ZMh36wFgP4oEVNG32jKrKeIeABIZUkvMkI2nuJjPYDEUlXCHTNDXlabGUFsRNXQSPhOC
         NerYd84/FXG0LxHJ/hyhyXV36eMxIoONl9I+Ojr3W1YbAA0YQaCegW5rONqiMR44r1sU
         COuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258414; x=1704863214;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvY724cCwHP6hlu/fSGAIkqdw5CGWNhU4kpeuf9SkbE=;
        b=GlvwxY1gTRh1KIxirf8PIV5oMR4H2yuTVX3lSh2sKjbdaR6xaNqEDz25QspKUCIkRs
         A6j70Xrz4yJVpAy5uzCC2ufInDXUxIaHg1zB7rgIVBJLFolj0WHmKmpQcpwfhKgFpSPp
         9JSqu4jCVXH9CNHQdJFGzoGD8Ekv+heM9iGzBCi/WmJF9i8mgZ6eHN0iRMBWtNzwdw7p
         jzvm+Kp0ntjGQZka7QroB344EeWtYBxyT4/2gkvLETR98kPjZCmb/ViQzwZ8Iu4P/CWG
         PJYdHGM+o/e/eTI82WU75bc3XLjFf1NDQJ1kfBNBJfjgw+bhcEDQlfO2QqqxjfwXcmc6
         Lm8g==
X-Gm-Message-State: AOJu0YzYEUL9VxZr9k79xjeM9EBr1T9Bk0scr2PW251yiMvnU0BEvhXm
	gNlFwIO+SZCcfbhrZ+Svl5IhBuANR1vi7wtXjsg=
X-Google-Smtp-Source: AGHT+IG4YGYQzbJCVi7S4ye53Kd5aBI5mVFnDNXSlxWFhcQhgcfhPjab8P4ckqviWhXj6C7B59lOf8bUgCB+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a05:690c:e06:b0:5d3:40f3:56bf with SMTP id
 cp6-20020a05690c0e0600b005d340f356bfmr9638632ywb.1.1704258413783; Tue, 02 Jan
 2024 21:06:53 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:13 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 03/25] perf maps: Get map before returning in maps__find_by_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this. Also fix some reference counted pointer comparisons.

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
index e8eb9f0b073f..7031f6fddcae 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1537,8 +1537,10 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 		return 0;
 
 	long_name = strdup(path);
-	if (long_name == NULL)
+	if (long_name == NULL) {
+		map__put(map);
 		return -ENOMEM;
+	}
 
 	dso = map__dso(map);
 	dso__set_long_name(dso, long_name, true);
@@ -1552,7 +1554,7 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 		dso->symtab_type++;
 		dso->comp = m->comp;
 	}
-
+	map__put(map);
 	return 0;
 }
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 17aa894721a7..b85147cc8723 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -886,7 +886,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 			struct dso *dso = map__dso(maps__maps_by_name(maps)[i]);
 
 			if (dso && strcmp(dso->short_name, name) == 0) {
-				result = maps__maps_by_name(maps)[i]; // TODO: map__get
+				result = map__get(maps__maps_by_name(maps)[i]);
 				done = true;
 			}
 		}
@@ -898,7 +898,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 					sizeof(*mapp), map__strcmp_name);
 
 			if (mapp) {
-				result = *mapp; // TODO: map__get
+				result = map__get(*mapp);
 				i = mapp - maps__maps_by_name(maps);
 				RC_CHK_ACCESS(maps)->last_search_by_name_idx = i;
 			}
@@ -923,7 +923,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
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
index 1710b89e207c..0785a54e832e 100644
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
+		} else if (!RC_CHK_EQUAL(curr_map, initial_map)) {
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
+		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
 			rb_erase_cached(&pos->rb_node, root);
@@ -951,12 +955,12 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		symbol__delete(pos);
 	}
 
-	if (curr_map != initial_map &&
+	if (!RC_CHK_EQUAL(curr_map, initial_map) &&
 	    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 	    machine__is_default_guest(maps__machine(kmaps))) {
 		dso__set_loaded(map__dso(curr_map));
 	}
-
+	map__put(curr_map);
 	return count + moved;
 }
 
-- 
2.43.0.472.g3155946c3a-goog


