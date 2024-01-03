Return-Path: <linux-kernel+bounces-15177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89BF8227FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EF5B230E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04986199C5;
	Wed,  3 Jan 2024 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMccPR2k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED919BD6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e763e03f4dso101135387b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 21:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258448; x=1704863248; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z16UnioGYiaSKamdLuaFHtqLC5A65Ll4++UiIFp+4EU=;
        b=rMccPR2kkhfeSbrYJOxjCK2D0tJGx/OQkIUwhBx9dZJq/p9KhdUkMZrs+tg6TD00pn
         YCg5Px/7zKjdZ3uzGah1ldy1mHWRzjbq+cs9pWG8klw4cYG2CSsVSEdFkZwRcVamBJMw
         c+fdL2b/TsZ0CmtDHMR0IHxmOd9Owi02mc6l+RpSyIM+Gak5pQO7RW5OKYQ/AaFSvjyJ
         rYz4VCRIR+rBeU+U8B4GWGvSoVUzCwhxCt6z/0QITXZXwtJ77DGiSTzNfRxo2KtUeXMP
         Ubl2W3mlkHadHjkFJKlMfO1g16PMhrztwnE6aP1bTrzjGAvvzgBergePl34FJii+Z5Hu
         vmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258448; x=1704863248;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z16UnioGYiaSKamdLuaFHtqLC5A65Ll4++UiIFp+4EU=;
        b=f9PvZpX2btmOpE+DnFZH2k7G9Mg7flphBho99AnCjERubcE3wWkRTxEVtoUayhp4ED
         cAcySjRasDGM0eaLIY/ZGooilWYnRH53/e/Qay8aNydP/G9EuXZQAOS0lugpZcOmixDi
         K+ItOPoVP6X968BSgbK5sJcKIN3tbOf/uu/D+x3Nzpqn+fr+o4dYJPcWTj2Jrkuxtwt3
         /p2uwBOoaldKRDKOeWqsCMZGVxBpGOZEucfuT9nae9caPlLbfEjtUUMSRVHLGvPlevSJ
         Opgz8IW4cHsuA2yJxsl8qJxwYqRvvaQZI0s1+q7WSZPPqvAqJLho6FDpmwHpjVBv09E8
         c1ZA==
X-Gm-Message-State: AOJu0YyBtgZUIYk7yoBVStfSoEIZsEyBU6qfJ5pxVWolc15ibj3+AoR6
	z7GGEMqqGaxNJhUCP6/ib9jFDB9f1imAnKTfq74=
X-Google-Smtp-Source: AGHT+IGdgV9pW/tFD3Y/drN+0BC8ntocm27iXGGjuMk8K90bOpP7nEGzfdcRgOak3OofVR5bcT6F64GvgEbP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a05:690c:3505:b0:5e7:eec7:c88d with SMTP
 id fq5-20020a05690c350500b005e7eec7c88dmr6767942ywb.5.1704258447980; Tue, 02
 Jan 2024 21:07:27 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:28 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 18/25] perf dsos: Switch more loops to dsos__for_each_dso
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

Switch loops within dsos.c, add a version that isn't locked. Switch
some unlocked loops to hold the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c |   2 +-
 tools/perf/util/dsos.c     | 258 ++++++++++++++++++++++++-------------
 tools/perf/util/dsos.h     |   8 +-
 tools/perf/util/machine.c  |   8 +-
 4 files changed, 174 insertions(+), 102 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a6d3c253f19f..864bc26b6b46 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -964,7 +964,7 @@ int perf_session__cache_build_ids(struct perf_session *session)
 
 static bool machine__read_build_ids(struct machine *machine, bool with_hits)
 {
-	return __dsos__read_build_ids(&machine->dsos, with_hits);
+	return dsos__read_build_ids(&machine->dsos, with_hits);
 }
 
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index f816927a21ff..b7fbfb877ae3 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -41,38 +41,65 @@ void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
+
+static int __dsos__for_each_dso(struct dsos *dsos,
+				int (*cb)(struct dso *dso, void *data),
+				void *data)
+{
+	struct dso *dso;
+
+	list_for_each_entry(dso, &dsos->head, node) {
+		int err;
+
+		err = cb(dso, data);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+struct dsos__read_build_ids_cb_args {
+	bool with_hits;
+	bool have_build_id;
+};
+
+static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 {
-	struct list_head *head = &dsos->head;
-	bool have_build_id = false;
-	struct dso *pos;
+	struct dsos__read_build_ids_cb_args *args = data;
 	struct nscookie nsc;
 
-	list_for_each_entry(pos, head, node) {
-		if (with_hits && !pos->hit && !dso__is_vdso(pos))
-			continue;
-		if (pos->has_build_id) {
-			have_build_id = true;
-			continue;
-		}
-		nsinfo__mountns_enter(pos->nsinfo, &nsc);
-		if (filename__read_build_id(pos->long_name, &pos->bid) > 0) {
-			have_build_id	  = true;
-			pos->has_build_id = true;
-		} else if (errno == ENOENT && pos->nsinfo) {
-			char *new_name = dso__filename_with_chroot(pos, pos->long_name);
-
-			if (new_name && filename__read_build_id(new_name,
-								&pos->bid) > 0) {
-				have_build_id = true;
-				pos->has_build_id = true;
-			}
-			free(new_name);
+	if (args->with_hits && !dso->hit && !dso__is_vdso(dso))
+		return 0;
+	if (dso->has_build_id) {
+		args->have_build_id = true;
+		return 0;
+	}
+	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	if (filename__read_build_id(dso->long_name, &dso->bid) > 0) {
+		args->have_build_id = true;
+		dso->has_build_id = true;
+	} else if (errno == ENOENT && dso->nsinfo) {
+		char *new_name = dso__filename_with_chroot(dso, dso->long_name);
+
+		if (new_name && filename__read_build_id(new_name, &dso->bid) > 0) {
+			args->have_build_id = true;
+			dso->has_build_id = true;
 		}
-		nsinfo__mountns_exit(&nsc);
+		free(new_name);
 	}
+	nsinfo__mountns_exit(&nsc);
+	return 0;
+}
 
-	return have_build_id;
+bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
+{
+	struct dsos__read_build_ids_cb_args args = {
+		.with_hits = with_hits,
+		.have_build_id = false,
+	};
+
+	dsos__for_each_dso(dsos, dsos__read_build_ids_cb, &args);
+	return args.have_build_id;
 }
 
 static int __dso__cmp_long_name(const char *long_name, struct dso_id *id, struct dso *b)
@@ -105,6 +132,7 @@ struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso
 
 	if (!name)
 		name = dso->long_name;
+
 	/*
 	 * Find node with the matching name
 	 */
@@ -185,17 +213,40 @@ static struct dso *__dsos__findnew_by_longname_id(struct rb_root *root, const ch
 	return __dsos__findnew_link_by_longname_id(root, NULL, name, id);
 }
 
+struct dsos__find_id_cb_args {
+	const char *name;
+	struct dso_id *id;
+	struct dso *res;
+};
+
+static int dsos__find_id_cb(struct dso *dso, void *data)
+{
+	struct dsos__find_id_cb_args *args = data;
+
+	if (__dso__cmp_short_name(args->name, args->id, dso) == 0) {
+		args->res = dso__get(dso);
+		return 1;
+	}
+	return 0;
+
+}
+
 static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct dso_id *id, bool cmp_short)
 {
-	struct dso *pos;
+	struct dso *res;
 
 	if (cmp_short) {
-		list_for_each_entry(pos, &dsos->head, node)
-			if (__dso__cmp_short_name(name, id, pos) == 0)
-				return dso__get(pos);
-		return NULL;
+		struct dsos__find_id_cb_args args = {
+			.name = name,
+			.id = id,
+			.res = NULL,
+		};
+
+		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
+		return args.res;
 	}
-	return __dsos__findnew_by_longname_id(&dsos->root, name, id);
+	res = __dsos__findnew_by_longname_id(&dsos->root, name, id);
+	return res;
 }
 
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
@@ -275,48 +326,74 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 	return dso;
 }
 
-size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
-			       bool (skip)(struct dso *dso, int parm), int parm)
-{
-	struct list_head *head = &dsos->head;
-	struct dso *pos;
-	size_t ret = 0;
+struct dsos__fprintf_buildid_cb_args {
+	FILE *fp;
+	bool (*skip)(struct dso *dso, int parm);
+	int parm;
+	size_t ret;
+};
 
-	list_for_each_entry(pos, head, node) {
-		char sbuild_id[SBUILD_ID_SIZE];
+static int dsos__fprintf_buildid_cb(struct dso *dso, void *data)
+{
+	struct dsos__fprintf_buildid_cb_args *args = data;
+	char sbuild_id[SBUILD_ID_SIZE];
 
-		if (skip && skip(pos, parm))
-			continue;
-		build_id__sprintf(&pos->bid, sbuild_id);
-		ret += fprintf(fp, "%-40s %s\n", sbuild_id, pos->long_name);
-	}
-	return ret;
+	if (args->skip && args->skip(dso, args->parm))
+		return 0;
+	build_id__sprintf(&dso->bid, sbuild_id);
+	args->ret += fprintf(args->fp, "%-40s %s\n", sbuild_id, dso->long_name);
+	return 0;
 }
 
-size_t __dsos__fprintf(struct dsos *dsos, FILE *fp)
+size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
+			       bool (*skip)(struct dso *dso, int parm), int parm)
 {
-	struct list_head *head = &dsos->head;
-	struct dso *pos;
-	size_t ret = 0;
+	struct dsos__fprintf_buildid_cb_args args = {
+		.fp = fp,
+		.skip = skip,
+		.parm = parm,
+		.ret = 0,
+	};
+
+	dsos__for_each_dso(dsos, dsos__fprintf_buildid_cb, &args);
+	return args.ret;
+}
 
-	list_for_each_entry(pos, head, node) {
-		ret += dso__fprintf(pos, fp);
-	}
+struct dsos__fprintf_cb_args {
+	FILE *fp;
+	size_t ret;
+};
 
-	return ret;
+static int dsos__fprintf_cb(struct dso *dso, void *data)
+{
+	struct dsos__fprintf_cb_args *args = data;
+
+	args->ret += dso__fprintf(dso, args->fp);
+	return 0;
 }
 
-int __dsos__hit_all(struct dsos *dsos)
+size_t dsos__fprintf(struct dsos *dsos, FILE *fp)
 {
-	struct list_head *head = &dsos->head;
-	struct dso *pos;
+	struct dsos__fprintf_cb_args args = {
+		.fp = fp,
+		.ret = 0,
+	};
 
-	list_for_each_entry(pos, head, node)
-		pos->hit = true;
+	dsos__for_each_dso(dsos, dsos__fprintf_cb, &args);
+	return args.ret;
+}
 
+static int dsos__hit_all_cb(struct dso *dso, void *data __maybe_unused)
+{
+	dso->hit = true;
 	return 0;
 }
 
+int dsos__hit_all(struct dsos *dsos)
+{
+	return dsos__for_each_dso(dsos, dsos__hit_all_cb, NULL);
+}
+
 struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 				     struct machine *machine,
 				     struct kmod_path *m,
@@ -342,49 +419,44 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 	return dso;
 }
 
-struct dso *dsos__find_kernel_dso(struct dsos *dsos)
+static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 {
-	struct dso *dso, *res = NULL;
+	struct dso **res = data;
+	/*
+	 * The cpumode passed to is_kernel_module is not the cpumode of *this*
+	 * event. If we insist on passing correct cpumode to is_kernel_module,
+	 * we should record the cpumode when we adding this dso to the linked
+	 * list.
+	 *
+	 * However we don't really need passing correct cpumode.  We know the
+	 * correct cpumode must be kernel mode (if not, we should not link it
+	 * onto kernel_dsos list).
+	 *
+	 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
+	 * is_kernel_module() treats it as a kernel cpumode.
+	 */
+	if (!dso->kernel ||
+	    is_kernel_module(dso->long_name, PERF_RECORD_MISC_CPUMODE_UNKNOWN))
+		return 0;
 
-	down_read(&dsos->lock);
-	list_for_each_entry(dso, &dsos->head, node) {
-		/*
-		 * The cpumode passed to is_kernel_module is not the cpumode of
-		 * *this* event. If we insist on passing correct cpumode to
-		 * is_kernel_module, we should record the cpumode when we adding
-		 * this dso to the linked list.
-		 *
-		 * However we don't really need passing correct cpumode.  We
-		 * know the correct cpumode must be kernel mode (if not, we
-		 * should not link it onto kernel_dsos list).
-		 *
-		 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
-		 * is_kernel_module() treats it as a kernel cpumode.
-		 */
-		if (!dso->kernel ||
-		    is_kernel_module(dso->long_name,
-				     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
-			continue;
+	*res = dso__get(dso);
+	return 1;
+}
 
-		res = dso__get(dso);
-		break;
-	}
-	up_read(&dsos->lock);
+struct dso *dsos__find_kernel_dso(struct dsos *dsos)
+{
+	struct dso *res = NULL;
+
+	dsos__for_each_dso(dsos, dsos__find_kernel_dso_cb, &res);
 	return res;
 }
 
 int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data)
 {
-	struct dso *dso;
+	int err;
 
 	down_read(&dsos->lock);
-	list_for_each_entry(dso, &dsos->head, node) {
-		int err;
-
-		err = cb(dso, data);
-		if (err)
-			return err;
-	}
+	err = __dsos__for_each_dso(dsos, cb, data);
 	up_read(&dsos->lock);
-	return 0;
+	return err;
 }
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 317a263f0e37..50bd51523475 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -33,16 +33,16 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
-bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits);
+bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
 struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
 						const char *name, struct dso_id *id);
 
-size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
+size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
-size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
+size_t dsos__fprintf(struct dsos *dsos, FILE *fp);
 
-int __dsos__hit_all(struct dsos *dsos);
+int dsos__hit_all(struct dsos *dsos);
 
 struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
 				     struct kmod_path *m, const char *filename);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f1186a5bb73c..0210c10e616b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -852,11 +852,11 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 {
 	struct rb_node *nd;
-	size_t ret = __dsos__fprintf(&machines->host.dsos, fp);
+	size_t ret = dsos__fprintf(&machines->host.dsos, fp);
 
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-		ret += __dsos__fprintf(&pos->dsos, fp);
+		ret += dsos__fprintf(&pos->dsos, fp);
 	}
 
 	return ret;
@@ -865,7 +865,7 @@ size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 size_t machine__fprintf_dsos_buildid(struct machine *m, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm)
 {
-	return __dsos__fprintf_buildid(&m->dsos, fp, skip, parm);
+	return dsos__fprintf_buildid(&m->dsos, fp, skip, parm);
 }
 
 size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
@@ -3207,5 +3207,5 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 int machine__hit_all_dsos(struct machine *machine)
 {
-	return __dsos__hit_all(&machine->dsos);
+	return dsos__hit_all(&machine->dsos);
 }
-- 
2.43.0.472.g3155946c3a-goog


