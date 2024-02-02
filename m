Return-Path: <linux-kernel+bounces-49253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B58467E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B443D1C2473F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4E3A1CC;
	Fri,  2 Feb 2024 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMyNxbhY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DC199AD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854581; cv=none; b=CA70JCFAfjXEkkxr7IdXffnkDqa/6sAZKrG9T9zhWTdsCDCov8BkFlv0vm3antPjGlMsDWSdgitEQf+pjRBynUpvaYhv3kR+qbrhaj7+SyHAj01vkhDtuEeu8L1OkfVrSKJdqj0rzl+Zd76bWKngwv7wMttHF4k09qP8Rx5vI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854581; c=relaxed/simple;
	bh=j92hVn9YgCWJ2fm11qA6UVczuOUwP6B514JEUF/+mfg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tTob/0qJYOm5HFztLuiAZ51LnMXyErc+QcsC0zXqy2JpEwGemDY1QAZVv/1QT68ji8uJUVP/SGxoECstOBgflQu9D+SAYmyK+srMV64OaquSpGI+1P/I5q7fMUWS7ttpUV5nL05adNRqSHPMfDN94OnwnpsbjZGz2JK74L8hl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMyNxbhY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60416f4cba4so33443597b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854579; x=1707459379; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXogDo+6q/mPbZDdbW0fAeXsEyRZMpGXEP5SHwZqJ18=;
        b=FMyNxbhYBu/yB93ViMyKyecrw/utbWrA96Xqnw48W5N0GQF2JMN3Qcv29F7UTfZsPj
         bgRcP6ZVPIr4QRrhZBgxyaUJIv6IIWJquGeirlWtFuBgXebgYCFRDlxZcSTjv2WzLOC8
         xNXhMaBxBcHKh9Ofo2Ot07t/tBM//sXnIIvsQjKz96+T1UlgrSquJJaREhSHleyldpJn
         q+pYu5oTCe7+BA4EKI3g1ndPvhODzAT4hrUR0jF8Ff922dqX7/rttwenxasfXNg2tZPe
         4WnCcqeJ4iXWl8qLyP1synjB7g2fgtrI4WKcYuMY2///aqKpxXvTW4GV1uncPeJR4kbM
         py4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854579; x=1707459379;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXogDo+6q/mPbZDdbW0fAeXsEyRZMpGXEP5SHwZqJ18=;
        b=iGor4hL0kxJPBRaJqBoyEa52hb88NyCoHduh4wu2PTkDHpF+q0lAlLrCpGqW3bFp9n
         7if2PeHBhiZDyScvmV34Sf5e/v2tBL1aCxGU5i4Qh8seKLWit2mCfYPfGg761e4EUfcm
         CUEbJ0sqqrcwpSeFwg7f3WfdW294bxNYwHZTY7YXrpVDkGhwwmrAKB52KrNYuONqw3ND
         UUJwfyFNTvwpEz+YNMAVJV+9y8YYGjs4MT9QMcgJ9OgL+cpDhIDXqEfZbxi5FHS+BU26
         L6cQf0kQ5GCBBdU7dcHBeCDiTMirM/3xf5+ZyFkA73Q5+cp6qvqpSqvNvmPOQCkgqCk3
         GhKA==
X-Gm-Message-State: AOJu0YxjiyuuJahoEXg28Wp9PWwD+DRMCLtjwoS/cHn4eYkhao5TkonA
	FHfBIG1m5PRaltRYujQVleaPrFWEJb53sAIF0o4BFPddiiGCxj5JYyLX+AJG5w4eX/Okfz/lVi/
	7HIzmdw==
X-Google-Smtp-Source: AGHT+IEa56wVKON0AWSgrfLndMt2GQb+ZgzmGjWiDjOvwuEN3WPQYHU9bZZF3tLa7Bm3Vhrm08o+JPgC+AWP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a81:98d1:0:b0:604:225f:3b4b with SMTP id
 p200-20020a8198d1000000b00604225f3b4bmr341248ywg.5.1706854579150; Thu, 01 Feb
 2024 22:16:19 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:21 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 14/25] perf dsos: Attempt to better abstract dsos internals
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Move functions from machine and build-id to dsos. Pass dsos struct
rather than internal state. Rename some functions to better represent
which data structure they operate on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/builtin-record.c |  2 +-
 tools/perf/util/build-id.c  | 38 +---------------------------
 tools/perf/util/build-id.h  |  2 --
 tools/perf/util/dso.h       |  6 -----
 tools/perf/util/dsos.c      | 49 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/dsos.h      | 19 +++++++++++---
 tools/perf/util/machine.c   | 40 ++++++------------------------
 tools/perf/util/machine.h   |  2 ++
 tools/perf/util/session.c   | 21 ++++++++++++++++
 tools/perf/util/session.h   |  2 ++
 11 files changed, 97 insertions(+), 86 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index eb3ef5c24b66..ef73317e6ae7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2122,7 +2122,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		 */
 		if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
 		    inject->have_auxtrace && !inject->itrace_synth_opts.set)
-			dsos__hit_all(session);
+			perf_session__dsos_hit_all(session);
 		/*
 		 * The AUX areas have been removed and replaced with
 		 * synthesized hardware events, so clear the feature flag.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0b6f29fa0064..b89460cfc96d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1787,7 +1787,7 @@ record__finish_output(struct record *rec)
 		process_buildids(rec);
 
 		if (rec->buildid_all)
-			dsos__hit_all(rec->session);
+			perf_session__dsos_hit_all(rec->session);
 	}
 	perf_session__write_header(rec->session, rec->evlist, fd, true);
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 03c64b85383b..a617b1917e6b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -390,42 +390,6 @@ int perf_session__write_buildid_table(struct perf_session *session,
 	return err;
 }
 
-static int __dsos__hit_all(struct list_head *head)
-{
-	struct dso *pos;
-
-	list_for_each_entry(pos, head, node)
-		pos->hit = true;
-
-	return 0;
-}
-
-static int machine__hit_all_dsos(struct machine *machine)
-{
-	return __dsos__hit_all(&machine->dsos.head);
-}
-
-int dsos__hit_all(struct perf_session *session)
-{
-	struct rb_node *nd;
-	int err;
-
-	err = machine__hit_all_dsos(&session->machines.host);
-	if (err)
-		return err;
-
-	for (nd = rb_first_cached(&session->machines.guests); nd;
-	     nd = rb_next(nd)) {
-		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-
-		err = machine__hit_all_dsos(pos);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 void disable_buildid_cache(void)
 {
 	no_buildid_cache = true;
@@ -992,7 +956,7 @@ int perf_session__cache_build_ids(struct perf_session *session)
 
 static bool machine__read_build_ids(struct machine *machine, bool with_hits)
 {
-	return __dsos__read_build_ids(&machine->dsos.head, with_hits);
+	return __dsos__read_build_ids(&machine->dsos, with_hits);
 }
 
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 4e3a1169379b..3fa8bffb07ca 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -39,8 +39,6 @@ int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
 			   struct perf_sample *sample, struct evsel *evsel,
 			   struct machine *machine);
 
-int dsos__hit_all(struct perf_session *session);
-
 int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 			       struct perf_sample *sample, struct evsel *evsel,
 			       struct machine *machine);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 33a41bcea335..2b9cf9177085 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -232,12 +232,6 @@ struct dso {
 #define dso__for_each_symbol(dso, pos, n)	\
 	symbols__for_each_entry(&(dso)->symbols, pos, n)
 
-#define dsos__for_each_with_build_id(pos, head)	\
-	list_for_each_entry(pos, head, node)	\
-		if (!pos->has_build_id)		\
-			continue;		\
-		else
-
 static inline void dso__set_loaded(struct dso *dso)
 {
 	dso->loaded = true;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cf80aa42dd07..e65ef6762bed 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -12,6 +12,35 @@
 #include <symbol.h> // filename__read_build_id
 #include <unistd.h>
 
+void dsos__init(struct dsos *dsos)
+{
+	INIT_LIST_HEAD(&dsos->head);
+	dsos->root = RB_ROOT;
+	init_rwsem(&dsos->lock);
+}
+
+static void dsos__purge(struct dsos *dsos)
+{
+	struct dso *pos, *n;
+
+	down_write(&dsos->lock);
+
+	list_for_each_entry_safe(pos, n, &dsos->head, node) {
+		RB_CLEAR_NODE(&pos->rb_node);
+		pos->root = NULL;
+		list_del_init(&pos->node);
+		dso__put(pos);
+	}
+
+	up_write(&dsos->lock);
+}
+
+void dsos__exit(struct dsos *dsos)
+{
+	dsos__purge(dsos);
+	exit_rwsem(&dsos->lock);
+}
+
 static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 {
 	if (a->maj > b->maj) return -1;
@@ -73,8 +102,9 @@ int dso__cmp_id(struct dso *a, struct dso *b)
 	return __dso_id__cmp(&a->id, &b->id);
 }
 
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
+bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 {
+	struct list_head *head = &dsos->head;
 	bool have_build_id = false;
 	struct dso *pos;
 	struct nscookie nsc;
@@ -303,9 +333,10 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 	return dso;
 }
 
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm)
 {
+	struct list_head *head = &dsos->head;
 	struct dso *pos;
 	size_t ret = 0;
 
@@ -320,8 +351,9 @@ size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
 	return ret;
 }
 
-size_t __dsos__fprintf(struct list_head *head, FILE *fp)
+size_t __dsos__fprintf(struct dsos *dsos, FILE *fp)
 {
+	struct list_head *head = &dsos->head;
 	struct dso *pos;
 	size_t ret = 0;
 
@@ -331,3 +363,14 @@ size_t __dsos__fprintf(struct list_head *head, FILE *fp)
 
 	return ret;
 }
+
+int __dsos__hit_all(struct dsos *dsos)
+{
+	struct list_head *head = &dsos->head;
+	struct dso *pos;
+
+	list_for_each_entry(pos, head, node)
+		pos->hit = true;
+
+	return 0;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 5dbec2bc6966..1c81ddf07f8f 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -21,6 +21,15 @@ struct dsos {
 	struct rw_semaphore lock;
 };
 
+#define dsos__for_each_with_build_id(pos, head)	\
+	list_for_each_entry(pos, head, node)	\
+		if (!pos->has_build_id)		\
+			continue;		\
+		else
+
+void dsos__init(struct dsos *dsos);
+void dsos__exit(struct dsos *dsos);
+
 void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
@@ -28,13 +37,15 @@ struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
+bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits);
+
 struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
 						const char *name, struct dso_id *id);
 
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits);
-
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
-size_t __dsos__fprintf(struct list_head *head, FILE *fp);
+size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
+
+int __dsos__hit_all(struct dsos *dsos);
 
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e668a97255f8..d235d65fb35b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -48,13 +48,6 @@ static struct dso *machine__kernel_dso(struct machine *machine)
 	return map__dso(machine->vmlinux_map);
 }
 
-static void dsos__init(struct dsos *dsos)
-{
-	INIT_LIST_HEAD(&dsos->head);
-	dsos->root = RB_ROOT;
-	init_rwsem(&dsos->lock);
-}
-
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -165,28 +158,6 @@ struct machine *machine__new_kallsyms(void)
 	return machine;
 }
 
-static void dsos__purge(struct dsos *dsos)
-{
-	struct dso *pos, *n;
-
-	down_write(&dsos->lock);
-
-	list_for_each_entry_safe(pos, n, &dsos->head, node) {
-		RB_CLEAR_NODE(&pos->rb_node);
-		pos->root = NULL;
-		list_del_init(&pos->node);
-		dso__put(pos);
-	}
-
-	up_write(&dsos->lock);
-}
-
-static void dsos__exit(struct dsos *dsos)
-{
-	dsos__purge(dsos);
-	exit_rwsem(&dsos->lock);
-}
-
 void machine__delete_threads(struct machine *machine)
 {
 	threads__remove_all_threads(&machine->threads);
@@ -906,11 +877,11 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 {
 	struct rb_node *nd;
-	size_t ret = __dsos__fprintf(&machines->host.dsos.head, fp);
+	size_t ret = __dsos__fprintf(&machines->host.dsos, fp);
 
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-		ret += __dsos__fprintf(&pos->dsos.head, fp);
+		ret += __dsos__fprintf(&pos->dsos, fp);
 	}
 
 	return ret;
@@ -919,7 +890,7 @@ size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 size_t machine__fprintf_dsos_buildid(struct machine *m, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm)
 {
-	return __dsos__fprintf_buildid(&m->dsos.head, fp, skip, parm);
+	return __dsos__fprintf_buildid(&m->dsos, fp, skip, parm);
 }
 
 size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
@@ -3281,3 +3252,8 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 	return false;
 }
+
+int machine__hit_all_dsos(struct machine *machine)
+{
+	return __dsos__hit_all(&machine->dsos);
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index e28c787616fe..05927aa3e813 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -306,4 +306,6 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 int machine__resolve(struct machine *machine, struct addr_location *al,
 		     struct perf_sample *sample);
 
+int machine__hit_all_dsos(struct machine *machine);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 199d3e8df315..e7b5d360a212 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2906,3 +2906,24 @@ int perf_event__process_id_index(struct perf_session *session,
 	}
 	return 0;
 }
+
+int perf_session__dsos_hit_all(struct perf_session *session)
+{
+	struct rb_node *nd;
+	int err;
+
+	err = machine__hit_all_dsos(&session->machines.host);
+	if (err)
+		return err;
+
+	for (nd = rb_first_cached(&session->machines.guests); nd;
+	     nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
+		err = machine__hit_all_dsos(pos);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index ee3715e8563b..25c0d6c9cac9 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -154,6 +154,8 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample);
 
+int perf_session__dsos_hit_all(struct perf_session *session);
+
 int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event);
 
-- 
2.43.0.594.gd9cf4e227d-goog


