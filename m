Return-Path: <linux-kernel+bounces-15161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF998227EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5901C22E19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6C1802A;
	Wed,  3 Jan 2024 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvdkyGkl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DA17996
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e10c4fcso314230276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 21:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258411; x=1704863211; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pw15FJ2pBS80M89TKz25UQyINC5jo1uys1vvlVevvQs=;
        b=yvdkyGklLJnRSy4BBxExqs9q7et+sXHFK3Eyeg/nbtWdWZ+icD4VEMVrprwBqrBbPn
         jjCbhQAh8kaHOM1qPpmqTe5X+xqdiB54wlPTGz6jEzlXpOxS6Rh/WayaYs0thunPtqZG
         XuEfIQl7Yq4c5o7Pg4MyNQQksrlzPDs9l8oRGHhSWxhwd+DggwQgQoOeVp2cLJ6KhT0x
         B+eqLLZq2sk/deilaK0RFIs0lRtEtPIIKBtvPNIvsruuhW2eXTqoa9QR0TdmAUwnEA6f
         wGlHFZLLb/PpJOq3+yRP2EMlkypte/XmyOds++y0m02yuYkCPq8h3guo6C+E8kg7YQGt
         +E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258411; x=1704863211;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pw15FJ2pBS80M89TKz25UQyINC5jo1uys1vvlVevvQs=;
        b=ZJK+4WGptDAjCu9DeCkOnPvlYbaOuC9yn8aBuqcba5CjUIuQSlzt1Zymj8GZDptEmm
         Hr/fukklJ6dwzdkFaeGnEnFngRR4PpqEnP6WUkh8bGpgFiLHZa2DSQafXDjRAqBvJJ0E
         GgCTdBrkcGPKjd9Ainc8zNsmC2EbeND00kWoYkyF4Ia0vCRfsprqyYHznOD6EeKbON3/
         P3OkrijNDvLvzDPAalo3ROIhsbHHice0tD0//+IU/fFieGexRVfG70+i5TqD4i0jYoqp
         FWz4T/IDrJRAAX1HTKPYeY1vSui40+u+DhcdcfSit38nTX5OBbOlrJhODG+JHOAumf5d
         ebEw==
X-Gm-Message-State: AOJu0YxWxSSu0xhBj5ZmorHsFbnbBws8EVOvNU5afkRrILLF2l7eSwQV
	6QobttkA5ehQNM1wHnbVUbGIM3H99TQOWUd4YKs=
X-Google-Smtp-Source: AGHT+IFi6PTTAYKxOEfSXBs682xA/+YfPemI4PvEMVe0bUq+TArgt+MOvKIldrkdAtAFrqV2HRBSEBU3q/Sy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a05:6902:1347:b0:dbc:ed8b:feaa with SMTP
 id g7-20020a056902134700b00dbced8bfeaamr5165113ybu.10.1704258411335; Tue, 02
 Jan 2024 21:06:51 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:12 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 02/25] perf maps: Get map before returning in maps__find
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
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c |  1 +
 tools/perf/tests/vmlinux-kallsyms.c      |  5 ++---
 tools/perf/util/bpf-event.c              |  1 +
 tools/perf/util/event.c                  |  4 ++--
 tools/perf/util/machine.c                | 22 ++++++++--------------
 tools/perf/util/maps.c                   | 17 ++++++++++-------
 tools/perf/util/symbol.c                 |  3 ++-
 7 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 5bfec3345d59..c05c0a85dad4 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 	}
 
 	stack_size = map__end(map) - sp;
+	map__put(map);
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 822f893e67d5..e808e6fc8f76 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -151,10 +151,8 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 	u64 mem_end = map__unmap_ip(args->vmlinux_map, map__end(map));
 
 	pair = maps__find(args->kallsyms.kmaps, mem_start);
-	if (pair == NULL || map__priv(pair))
-		return 0;
 
-	if (map__start(pair) == mem_start) {
+	if (pair != NULL && !map__priv(pair) && map__start(pair) == mem_start) {
 		struct dso *dso = map__dso(map);
 
 		if (!args->header_printed) {
@@ -170,6 +168,7 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 		pr_info(" %s\n", dso->name);
 		map__set_priv(pair, 1);
 	}
+	map__put(pair);
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 830711cae30d..d07fd5ffa823 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -63,6 +63,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
 			dso->bpf_prog.id = id;
 			dso->bpf_prog.sub_id = i;
 			dso->bpf_prog.env = env;
+			map__put(map);
 		}
 	}
 	return 0;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 68f45e9e63b6..198903157f9e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -511,7 +511,7 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
 		struct addr_location al;
 
 		addr_location__init(&al);
-		al.map = map__get(maps__find(machine__kernel_maps(machine), tp->addr));
+		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
 		if (al.map && map__load(al.map) >= 0) {
 			al.addr = map__map_ip(al.map, tp->addr);
 			al.sym = map__find_symbol(al.map, al.addr);
@@ -641,7 +641,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		return NULL;
 	}
 	al->maps = maps__get(maps);
-	al->map = map__get(maps__find(maps, al->addr));
+	al->map = maps__find(maps, al->addr);
 	if (al->map != NULL) {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b397a769006f..e8eb9f0b073f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -896,7 +896,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct symbol *sym;
 	struct dso *dso;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
-	bool put_map = false;
 	int err = 0;
 
 	if (!map) {
@@ -913,12 +912,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			err = -ENOMEM;
 			goto out;
 		}
-		/*
-		 * The inserted map has a get on it, we need to put to release
-		 * the reference count here, but do it after all accesses are
-		 * done.
-		 */
-		put_map = true;
 		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
 			dso->binary_type = DSO_BINARY_TYPE__OOL;
 			dso->data.file_size = event->ksymbol.len;
@@ -952,8 +945,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	}
 	dso__insert_symbol(dso, sym);
 out:
-	if (put_map)
-		map__put(map);
+	map__put(map);
 	return err;
 }
 
@@ -977,7 +969,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 		if (sym)
 			dso__delete_symbol(dso, sym);
 	}
-
+	map__put(map);
 	return 0;
 }
 
@@ -1005,11 +997,11 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		perf_event__fprintf_text_poke(event, machine, stdout);
 
 	if (!event->text_poke.new_len)
-		return 0;
+		goto out;
 
 	if (cpumode != PERF_RECORD_MISC_KERNEL) {
 		pr_debug("%s: unsupported cpumode - ignoring\n", __func__);
-		return 0;
+		goto out;
 	}
 
 	if (dso) {
@@ -1032,7 +1024,8 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		pr_debug("Failed to find kernel text poke address map for %#" PRI_lx64 "\n",
 			 event->text_poke.addr);
 	}
-
+out:
+	map__put(map);
 	return 0;
 }
 
@@ -1300,9 +1293,10 @@ static int machine__map_x86_64_entry_trampolines_cb(struct map *map, void *data)
 		return 0;
 
 	dest_map = maps__find(args->kmaps, map__pgoff(map));
-	if (dest_map != map)
+	if (RC_CHK_ACCESS(dest_map) != RC_CHK_ACCESS(map))
 		map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
 
+	map__put(dest_map);
 	args->found = true;
 	return 0;
 }
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 6ee81160cdab..17aa894721a7 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -487,15 +487,18 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
+	struct symbol *result = NULL;
 
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
-		if (mapp != NULL)
-			*mapp = map; // TODO: map_put on else path when find returns a get.
-		return map__find_symbol(map, map__map_ip(map, addr));
-	}
+		if (mapp)
+			*mapp = map;
 
-	return NULL;
+		result = map__find_symbol(map, map__map_ip(map, addr));
+		if (!mapp)
+			map__put(map);
+	}
+	return result;
 }
 
 struct maps__find_symbol_by_name_args {
@@ -539,7 +542,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
-		ams->ms.map = maps__find(maps, ams->addr);  // TODO: map_get
+		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
 	}
@@ -849,7 +852,7 @@ struct map *maps__find(struct maps *maps, u64 ip)
 					sizeof(*mapp), map__addr_cmp);
 
 			if (mapp)
-				result = *mapp; // map__get(*mapp);
+				result = map__get(*mapp);
 			done = true;
 		}
 		up_read(maps__lock(maps));
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index be212ba157dc..1710b89e207c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -757,7 +757,6 @@ static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
 
 static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 {
-	struct map *curr_map;
 	struct symbol *pos;
 	int count = 0;
 	struct rb_root_cached old_root = dso->symbols;
@@ -770,6 +769,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	*root = RB_ROOT_CACHED;
 
 	while (next) {
+		struct map *curr_map;
 		struct dso *curr_map_dso;
 		char *module;
 
@@ -796,6 +796,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
 		symbols__insert(&curr_map_dso->symbols, pos);
 		++count;
+		map__put(curr_map);
 	}
 
 	/* Symbols have been adjusted */
-- 
2.43.0.472.g3155946c3a-goog


