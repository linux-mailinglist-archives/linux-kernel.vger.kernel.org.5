Return-Path: <linux-kernel+bounces-91107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F408709C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDD7B23322
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DD79938;
	Mon,  4 Mar 2024 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1t8wP7xb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AB78B74
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577349; cv=none; b=jnLhxM+oewrOLhODYa276PvXcCY5fk6B+38o1idlbN0zN0WcrEAxBD3kI3EaM+st6sAdkjvLChFYT1sQrZRT6us+TY3x+hSxd7eRtAKlYAhxPOFVo3e5QVyXLFI7HR5sIn4rjiOZ5gIy8ljwEBXbEUwiGtH2FO6jIppXHkUJYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577349; c=relaxed/simple;
	bh=7ZGeFXYPxlXoiSR7ELk0fV3Kp4F+iESFyVoygtu4wT8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l2aIqxOHW6WJDa0u+H0+V7KuHdAfzzMacahEBJmXiLHGVP6LuTJHZhnjSB7YCwqW+Lws2qfH8ur6xY2UWHZY3HW9NerWtFg+hbsP48GGj/3s7sUKWGYuSJA5F0u9Nw/i8JpgcuRNMshlTvxhEcbaQX2ofwh4gTFtMbdrZqzNVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1t8wP7xb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd001f821caso5711230276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577347; x=1710182147; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KRmb59btpdI9eLRWvmOTziIcJBW1aKy0HrEtzGC1rY=;
        b=1t8wP7xbXxYsg0etLeiXB5zt4tdX96q+Lc1e9hc0pIgMkz50R4Rdbx+O/2QYMTboPh
         wHZZuMctUBFsmj9Q9/Lt4P92MojrZzA5Q968nlSa/rSFEqSputwzjL6psnoxh2Tqdzh5
         Cjhc+oHTWf21fd+pbTMwHenZbJnZgNRM00WQDDElapBpz40Pjh3VB27YWhbuwwH3GxyD
         jFn19ZCXxaIb1/J/LB/Z3thQ1EuGCv3+grGt6sg3ooy6JFG0Hs9/EjexumkznyPnKwm5
         G5GS1dLaWFxsopZfTjPqtAYGo6zmmB/WN2WLX6Ec3YNiu3dy8ZpbXLi4NdoaCJG4vJpf
         VcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577347; x=1710182147;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KRmb59btpdI9eLRWvmOTziIcJBW1aKy0HrEtzGC1rY=;
        b=YKmGy6iCKMRD8mLoi7x4sgUmiEpp3Zbrqydp+2vV1Cw2Cvg/pUSBafx5MLWFMhZ4mj
         YfaCspJEZeR25Cu1jTlwyDWqcf2C45ViyG/P6wFumdLaUmPPQhvEFGxzc64ugjsAAOlY
         sca9xpB9EiZtRX8y351gY/VMeNj8qFbUEdfPGGzpfDcneu+cpwhhD4kGNcpwTBZwypu5
         +AQBNHbox2RzVfxS6UEcdKkCx8fceyjXTXaNGgB/lz1cuahtbYM2Od3nWhO7qPLP+SFk
         ZJCNF1NdrvxqAol9AtGv51lluPBkBulwwTrNMqhsaLpQD9O6KdS4oRJD2kt2AakA8R6Z
         ZD8A==
X-Forwarded-Encrypted: i=1; AJvYcCWOqpKvt4JiWxeQEvztVqasqiWN+DzgVPAiQ07AchkLE1+w1wrNBugwH5lghIANwA5Z2APHM+YhjkggcQgW4yFzGny0zHScyvE+cAge
X-Gm-Message-State: AOJu0Yz3TLC//4KZO/Hy4RtuCxfEw6Jv775xedwTxU9IkkBdhjYERLRW
	j8Bw2XGbZ+JpTaNs3ivccN40+K+1+ETTWJbNqk+g8KT6Q/Rkj/rDKzFn3/zPfYUKeqqOfNIIgPg
	gSHjZAw==
X-Google-Smtp-Source: AGHT+IETjRZ8/6ZPNzEjOi309bhrwHRRnUZdYcpf2644eHz4pjDE/oryZ2w3Baou79kcbVl4fnCNGoCD1zAo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dbd:ee44:8908 with SMTP
 id w13-20020a056902100d00b00dbdee448908mr76964ybt.0.1709577347153; Mon, 04
 Mar 2024 10:35:47 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:14 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 03/13] perf dsos: Tidy reference counting and locking
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move more functionality into dsos.c generally from machine, renaming
functions to match their new usage. The find function is made to
always "get" before returning a dso. Reduce the scope of locks in vdso
to match the locking paradigm.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c    | 73 +++++++++++++++++++++++++++++++++++----
 tools/perf/util/dsos.h    |  9 ++++-
 tools/perf/util/machine.c | 62 ++-------------------------------
 tools/perf/util/map.c     |  4 +--
 tools/perf/util/vdso.c    | 48 +++++++++++--------------
 5 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e65ef6762bed..d269e09005a7 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -181,7 +181,7 @@ struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso
 			 * at the end of the list of duplicates.
 			 */
 			if (!dso || (dso == this))
-				return this;	/* Find matching dso */
+				return dso__get(this);	/* Find matching dso */
 			/*
 			 * The core kernel DSOs may have duplicated long name.
 			 * In this case, the short name should be different.
@@ -253,15 +253,20 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 	if (cmp_short) {
 		list_for_each_entry(pos, &dsos->head, node)
 			if (__dso__cmp_short_name(name, id, pos) == 0)
-				return pos;
+				return dso__get(pos);
 		return NULL;
 	}
 	return __dsos__findnew_by_longname_id(&dsos->root, name, id);
 }
 
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 {
-	return __dsos__find_id(dsos, name, NULL, cmp_short);
+	struct dso *res;
+
+	down_read(&dsos->lock);
+	res = __dsos__find_id(dsos, name, NULL, cmp_short);
+	up_read(&dsos->lock);
+	return res;
 }
 
 static void dso__set_basename(struct dso *dso)
@@ -303,8 +308,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	if (dso != NULL) {
 		__dsos__add(dsos, dso);
 		dso__set_basename(dso);
-		/* Put dso here because __dsos_add already got it */
-		dso__put(dso);
 	}
 	return dso;
 }
@@ -328,7 +331,7 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 {
 	struct dso *dso;
 	down_write(&dsos->lock);
-	dso = dso__get(__dsos__findnew_id(dsos, name, id));
+	dso = __dsos__findnew_id(dsos, name, id);
 	up_write(&dsos->lock);
 	return dso;
 }
@@ -374,3 +377,59 @@ int __dsos__hit_all(struct dsos *dsos)
 
 	return 0;
 }
+
+struct dso *dsos__findnew_module_dso(struct dsos *dsos,
+				     struct machine *machine,
+				     struct kmod_path *m,
+				     const char *filename)
+{
+	struct dso *dso;
+
+	down_write(&dsos->lock);
+
+	dso = __dsos__find_id(dsos, m->name, NULL, /*cmp_short=*/true);
+	if (!dso) {
+		dso = __dsos__addnew(dsos, m->name);
+		if (dso == NULL)
+			goto out_unlock;
+
+		dso__set_module_info(dso, m, machine);
+		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_SPACE__KERNEL;
+	}
+
+out_unlock:
+	up_write(&dsos->lock);
+	return dso;
+}
+
+struct dso *dsos__find_kernel_dso(struct dsos *dsos)
+{
+	struct dso *dso, *res = NULL;
+
+	down_read(&dsos->lock);
+	list_for_each_entry(dso, &dsos->head, node) {
+		/*
+		 * The cpumode passed to is_kernel_module is not the cpumode of
+		 * *this* event. If we insist on passing correct cpumode to
+		 * is_kernel_module, we should record the cpumode when we adding
+		 * this dso to the linked list.
+		 *
+		 * However we don't really need passing correct cpumode.  We
+		 * know the correct cpumode must be kernel mode (if not, we
+		 * should not link it onto kernel_dsos list).
+		 *
+		 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
+		 * is_kernel_module() treats it as a kernel cpumode.
+		 */
+		if (!dso->kernel ||
+		    is_kernel_module(dso->long_name,
+				     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
+			continue;
+
+		res = dso__get(dso);
+		break;
+	}
+	up_read(&dsos->lock);
+	return res;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 1c81ddf07f8f..a7c7f723c5ff 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -10,6 +10,8 @@
 
 struct dso;
 struct dso_id;
+struct kmod_path;
+struct machine;
 
 /*
  * DSOs are put into both a list for fast iteration and rbtree for fast
@@ -33,7 +35,7 @@ void dsos__exit(struct dsos *dsos);
 void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
@@ -48,4 +50,9 @@ size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
 
 int __dsos__hit_all(struct dsos *dsos);
 
+struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
+				     struct kmod_path *m, const char *filename);
+
+struct dso *dsos__find_kernel_dso(struct dsos *dsos);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index acd22b589f18..a06b030fba54 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -646,31 +646,6 @@ int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static struct dso *machine__findnew_module_dso(struct machine *machine,
-					       struct kmod_path *m,
-					       const char *filename)
-{
-	struct dso *dso;
-
-	down_write(&machine->dsos.lock);
-
-	dso = __dsos__find(&machine->dsos, m->name, true);
-	if (!dso) {
-		dso = __dsos__addnew(&machine->dsos, m->name);
-		if (dso == NULL)
-			goto out_unlock;
-
-		dso__set_module_info(dso, m, machine);
-		dso__set_long_name(dso, strdup(filename), true);
-		dso->kernel = DSO_SPACE__KERNEL;
-	}
-
-	dso__get(dso);
-out_unlock:
-	up_write(&machine->dsos.lock);
-	return dso;
-}
-
 int machine__process_aux_event(struct machine *machine __maybe_unused,
 			       union perf_event *event)
 {
@@ -854,7 +829,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	if (kmod_path__parse_name(&m, filename))
 		return NULL;
 
-	dso = machine__findnew_module_dso(machine, &m, filename);
+	dso = dsos__findnew_module_dso(&machine->dsos, machine, &m, filename);
 	if (dso == NULL)
 		goto out;
 
@@ -1663,40 +1638,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		 * Should be there already, from the build-id table in
 		 * the header.
 		 */
-		struct dso *kernel = NULL;
-		struct dso *dso;
-
-		down_read(&machine->dsos.lock);
-
-		list_for_each_entry(dso, &machine->dsos.head, node) {
-
-			/*
-			 * The cpumode passed to is_kernel_module is not the
-			 * cpumode of *this* event. If we insist on passing
-			 * correct cpumode to is_kernel_module, we should
-			 * record the cpumode when we adding this dso to the
-			 * linked list.
-			 *
-			 * However we don't really need passing correct
-			 * cpumode.  We know the correct cpumode must be kernel
-			 * mode (if not, we should not link it onto kernel_dsos
-			 * list).
-			 *
-			 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
-			 * is_kernel_module() treats it as a kernel cpumode.
-			 */
-
-			if (!dso->kernel ||
-			    is_kernel_module(dso->long_name,
-					     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
-				continue;
-
-
-			kernel = dso__get(dso);
-			break;
-		}
-
-		up_read(&machine->dsos.lock);
+		struct dso *kernel = dsos__find_kernel_dso(&machine->dsos);
 
 		if (kernel == NULL)
 			kernel = machine__findnew_dso(machine, machine->mmap_name);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 14a5ea70d81e..67db017f7e7d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -196,9 +196,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			 * reading the header will have the build ID set and all future mmaps will
 			 * have it missing.
 			 */
-			down_read(&machine->dsos.lock);
-			header_bid_dso = __dsos__find(&machine->dsos, filename, false);
-			up_read(&machine->dsos.lock);
+			header_bid_dso = dsos__find(&machine->dsos, filename, false);
 			if (header_bid_dso && header_bid_dso->header_build_id) {
 				dso__set_build_id(dso, &header_bid_dso->bid);
 				dso->header_build_id = 1;
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index df8963796187..35532dcbff74 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -133,8 +133,6 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 	if (dso != NULL) {
 		__dsos__add(&machine->dsos, dso);
 		dso__set_long_name(dso, long_name, false);
-		/* Put dso here because __dsos_add already got it */
-		dso__put(dso);
 	}
 
 	return dso;
@@ -252,17 +250,15 @@ static struct dso *__machine__findnew_compat(struct machine *machine,
 	const char *file_name;
 	struct dso *dso;
 
-	dso = __dsos__find(&machine->dsos, vdso_file->dso_name, true);
+	dso = dsos__find(&machine->dsos, vdso_file->dso_name, true);
 	if (dso)
-		goto out;
+		return dso;
 
 	file_name = vdso__get_compat_file(vdso_file);
 	if (!file_name)
-		goto out;
+		return NULL;
 
-	dso = __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
-out:
-	return dso;
+	return __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
 }
 
 static int __machine__findnew_vdso_compat(struct machine *machine,
@@ -308,21 +304,21 @@ static struct dso *machine__find_vdso(struct machine *machine,
 	dso_type = machine__thread_dso_type(machine, thread);
 	switch (dso_type) {
 	case DSO__TYPE_32BIT:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO32, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSO32, true);
 		if (!dso) {
-			dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO,
-					   true);
+			dso = dsos__find(&machine->dsos, DSO__NAME_VDSO,
+					 true);
 			if (dso && dso_type != dso__type(dso, machine))
 				dso = NULL;
 		}
 		break;
 	case DSO__TYPE_X32BIT:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSOX32, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSOX32, true);
 		break;
 	case DSO__TYPE_64BIT:
 	case DSO__TYPE_UNKNOWN:
 	default:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
 		break;
 	}
 
@@ -334,37 +330,33 @@ struct dso *machine__findnew_vdso(struct machine *machine,
 {
 	struct vdso_info *vdso_info;
 	struct dso *dso = NULL;
+	char *file;
 
-	down_write(&machine->dsos.lock);
 	if (!machine->vdso_info)
 		machine->vdso_info = vdso_info__new();
 
 	vdso_info = machine->vdso_info;
 	if (!vdso_info)
-		goto out_unlock;
+		return NULL;
 
 	dso = machine__find_vdso(machine, thread);
 	if (dso)
-		goto out_unlock;
+		return dso;
 
 #if BITS_PER_LONG == 64
 	if (__machine__findnew_vdso_compat(machine, thread, vdso_info, &dso))
-		goto out_unlock;
+		return dso;
 #endif
 
-	dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
-	if (!dso) {
-		char *file;
+	dso = dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
+	if (dso)
+		return dso;
 
-		file = get_file(&vdso_info->vdso);
-		if (file)
-			dso = __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
-	}
+	file = get_file(&vdso_info->vdso);
+	if (!file)
+		return NULL;
 
-out_unlock:
-	dso__get(dso);
-	up_write(&machine->dsos.lock);
-	return dso;
+	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
 }
 
 bool dso__is_vdso(struct dso *dso)
-- 
2.44.0.278.ge034bb2e1d-goog


