Return-Path: <linux-kernel+bounces-110299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07C885CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689B0B26956
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1712CD81;
	Thu, 21 Mar 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvpbhedJ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9212C55F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037000; cv=none; b=uDYJ7MWKNcbUfT+dR6+HEbPTjSonwg6sxjvTVB9B0yPvnZXD+awW2edWPZQivKBUR870ZpFJn7GDOfK/WlDazDKeaYpMROilYMwwM3C0o77XzYWbTob25wVxADYbAR5p3Y1kxGgFxTFBy9PenBL6zWpzpRyvvAXi4B/8ykeHmBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037000; c=relaxed/simple;
	bh=QP0PbL5rLghFLJ//+TLNVGLCNfruBUXZgQsXaCRy2/8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LtbIx3sJgKKz+z8GST/cSHXKWNft8SIJyBVZchMecoVzahVeAL/UsGN9TFm2h23/ZRe5H//pBmygTyBLjf9wmvm89GD0jX9ihxbUZANSPU2CJqNEtW2h/r4BkOrlAVfSi7v8cqMJHXJjr5sgyB5ABD7D2xhBezBuCMKWHNn8is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvpbhedJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610fe0406e9so18137927b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711036996; x=1711641796; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4Lbk6+ewHbBcUKKBVnEnKnqA+Oj4kfXooBC1ERcwlI=;
        b=fvpbhedJ3ostsIWDVr0+plwZyH0ltVpwqpfw2iI23Pqvl8oJq1NvbnqgGEBfxlimNM
         2ic8ezsuNp5x7EAk5VD8gS3Pwwi9h5/ew3f3RFwbGRyKLTlDvut85/eG50f93ma1N6Ro
         AyVZrwlCtlGeNQQ1rBlG2JXh0aoHR6O41ti6i6bnnF0DsMvbN5RefKfnffsuVBqxsSTb
         ZjdPbn5FL+/vnB5W9T+QwPzC2Zej4M6J4btcZ+ozzTYDy5BzysMVGiPibPwkOU7SUE89
         K+P9Oy3ejreJaeIvelu0ztCLx/mOtIxceX0AUcmxbwFctnkKCR+jubYZEYBZchlyWG6J
         14Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036996; x=1711641796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4Lbk6+ewHbBcUKKBVnEnKnqA+Oj4kfXooBC1ERcwlI=;
        b=LS5M91ggB2nsDa+LUZG4t2fk3/0/X6hYhOzWnKTp1MCRbJzyG8Z8GI1G0Auic+Rzc+
         WTVHEg+Xkbx1BtAvbDPwEMKFvj0rgyt/Qn33WgRQFXGsB7DA5Xa+sAUpwyMYQlADs4g5
         D8AoKp1yE5rScQVJ0tCipJT4z3k5tfY82xB295X2S6gC9yqiRovU6YUoBgvQQY1VCSa1
         8ybDRtN5x9sDzbAeLDwgcOfqckUFlAkFFPODa6NazQnu/l/uMTHvWIgEiR/xBsmKvc6/
         D57oe8aeUxRqLGwnL4ivBqyAafA6eAhhTPiGs5hLI9niA+ofyL8oWMLHgZVW4+DwGUb/
         kxXw==
X-Forwarded-Encrypted: i=1; AJvYcCVHLJJPsk6ar520pjYTyMmrUDkTCz6AQdAHL/DrsVUGUisKLvSDjPRlIXPptO/mVcYLM1IKsIfxV5J3ATrfNL6RP4eV1ITu71HhSmeX
X-Gm-Message-State: AOJu0YwNWyJ0gu8FCeaevuP1P6oz/j87Pk5led4zMKQikZnAhHFSGqTP
	tVXq7llEoKYVCUPR6xRQ78LjxMuSBlVRF/Nlz4Hgzwch4Mh6HHhVPYOA5ybbL+DJqKRESrs33eu
	hw2ST5g==
X-Google-Smtp-Source: AGHT+IFngUIcQyUkSV+lDyA6uYRYCWeFxyIyvFvF0RBuKGP5TZQi67/EnGPw/vg+0RUL9Ac4OvnP2/r6Rczh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a0d:e64e:0:b0:609:1253:bfd with SMTP id
 p75-20020a0de64e000000b0060912530bfdmr3974752ywe.10.1711036996192; Thu, 21
 Mar 2024 09:03:16 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:02:51 -0700
In-Reply-To: <20240321160300.1635121-1-irogers@google.com>
Message-Id: <20240321160300.1635121-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v2 04/13] perf dsos: Add dsos__for_each_dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To better abstract the dsos internals, add dsos__for_each_dso that
does a callback on each dso. This also means the read lock can be
correctly held.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 25 +++++++-----
 tools/perf/util/build-id.c  | 76 ++++++++++++++++++++-----------------
 tools/perf/util/dsos.c      | 16 ++++++++
 tools/perf/util/dsos.h      |  8 +---
 tools/perf/util/machine.c   | 40 +++++++++++--------
 5 files changed, 100 insertions(+), 65 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ef73317e6ae7..ce5e28eaad90 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1187,23 +1187,28 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 					       process_build_id, machine);
 }
 
+static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
+{
+	struct guest_session *gs = data;
+	struct perf_inject *inject = container_of(gs, struct perf_inject, guest_session);
+
+	if (!dso->has_build_id)
+		return 0;
+
+	return synthesize_build_id(inject, dso, gs->machine_pid);
+
+}
+
 static int guest_session__add_build_ids(struct guest_session *gs)
 {
 	struct perf_inject *inject = container_of(gs, struct perf_inject, guest_session);
-	struct machine *machine = &gs->session->machines.host;
-	struct dso *dso;
-	int ret;
 
 	/* Build IDs will be put in the Build ID feature section */
 	perf_header__set_feat(&inject->session->header, HEADER_BUILD_ID);
 
-	dsos__for_each_with_build_id(dso, &machine->dsos.head) {
-		ret = synthesize_build_id(inject, dso, gs->machine_pid);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return dsos__for_each_dso(&gs->session->machines.host.dsos,
+				  guest_session__add_build_ids_cb,
+				  gs);
 }
 
 static int guest_session__ksymbol_event(struct perf_tool *tool,
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a617b1917e6b..a6d3c253f19f 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -327,48 +327,56 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	return write_padded(fd, name, name_len + 1, len);
 }
 
-static int machine__write_buildid_table(struct machine *machine,
-					struct feat_fd *fd)
+struct machine__write_buildid_table_cb_args {
+	struct machine *machine;
+	struct feat_fd *fd;
+	u16 kmisc, umisc;
+};
+
+static int machine__write_buildid_table_cb(struct dso *dso, void *data)
 {
-	int err = 0;
-	struct dso *pos;
-	u16 kmisc = PERF_RECORD_MISC_KERNEL,
-	    umisc = PERF_RECORD_MISC_USER;
+	struct machine__write_buildid_table_cb_args *args = data;
+	const char *name;
+	size_t name_len;
+	bool in_kernel = false;
 
-	if (!machine__is_host(machine)) {
-		kmisc = PERF_RECORD_MISC_GUEST_KERNEL;
-		umisc = PERF_RECORD_MISC_GUEST_USER;
-	}
+	if (!dso->has_build_id)
+		return 0;
 
-	dsos__for_each_with_build_id(pos, &machine->dsos.head) {
-		const char *name;
-		size_t name_len;
-		bool in_kernel = false;
+	if (!dso->hit && !dso__is_vdso(dso))
+		return 0;
 
-		if (!pos->hit && !dso__is_vdso(pos))
-			continue;
+	if (dso__is_vdso(dso)) {
+		name = dso->short_name;
+		name_len = dso->short_name_len;
+	} else if (dso__is_kcore(dso)) {
+		name = args->machine->mmap_name;
+		name_len = strlen(name);
+	} else {
+		name = dso->long_name;
+		name_len = dso->long_name_len;
+	}
 
-		if (dso__is_vdso(pos)) {
-			name = pos->short_name;
-			name_len = pos->short_name_len;
-		} else if (dso__is_kcore(pos)) {
-			name = machine->mmap_name;
-			name_len = strlen(name);
-		} else {
-			name = pos->long_name;
-			name_len = pos->long_name_len;
-		}
+	in_kernel = dso->kernel || is_kernel_module(name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
+	return write_buildid(name, name_len, &dso->bid, args->machine->pid,
+			     in_kernel ? args->kmisc : args->umisc, args->fd);
+}
 
-		in_kernel = pos->kernel ||
-				is_kernel_module(name,
-					PERF_RECORD_MISC_CPUMODE_UNKNOWN);
-		err = write_buildid(name, name_len, &pos->bid, machine->pid,
-				    in_kernel ? kmisc : umisc, fd);
-		if (err)
-			break;
+static int machine__write_buildid_table(struct machine *machine, struct feat_fd *fd)
+{
+	struct machine__write_buildid_table_cb_args args = {
+		.machine = machine,
+		.fd = fd,
+		.kmisc = PERF_RECORD_MISC_KERNEL,
+		.umisc = PERF_RECORD_MISC_USER,
+	};
+
+	if (!machine__is_host(machine)) {
+		args.kmisc = PERF_RECORD_MISC_GUEST_KERNEL;
+		args.umisc = PERF_RECORD_MISC_GUEST_USER;
 	}
 
-	return err;
+	return dsos__for_each_dso(&machine->dsos, machine__write_buildid_table_cb, &args);
 }
 
 int perf_session__write_buildid_table(struct perf_session *session,
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d269e09005a7..d43f64939b12 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -433,3 +433,19 @@ struct dso *dsos__find_kernel_dso(struct dsos *dsos)
 	up_read(&dsos->lock);
 	return res;
 }
+
+int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data)
+{
+	struct dso *dso;
+
+	down_read(&dsos->lock);
+	list_for_each_entry(dso, &dsos->head, node) {
+		int err;
+
+		err = cb(dso, data);
+		if (err)
+			return err;
+	}
+	up_read(&dsos->lock);
+	return 0;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a7c7f723c5ff..317a263f0e37 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -23,12 +23,6 @@ struct dsos {
 	struct rw_semaphore lock;
 };
 
-#define dsos__for_each_with_build_id(pos, head)	\
-	list_for_each_entry(pos, head, node)	\
-		if (!pos->has_build_id)		\
-			continue;		\
-		else
-
 void dsos__init(struct dsos *dsos);
 void dsos__exit(struct dsos *dsos);
 
@@ -55,4 +49,6 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
 
 struct dso *dsos__find_kernel_dso(struct dsos *dsos);
 
+int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a06b030fba54..bd153bc2c8da 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1562,16 +1562,14 @@ int machine__create_kernel_maps(struct machine *machine)
 	return ret;
 }
 
-static bool machine__uses_kcore(struct machine *machine)
+static int machine__uses_kcore_cb(struct dso *dso, void *data __maybe_unused)
 {
-	struct dso *dso;
-
-	list_for_each_entry(dso, &machine->dsos.head, node) {
-		if (dso__is_kcore(dso))
-			return true;
-	}
+	return dso__is_kcore(dso) ? 1 : 0;
+}
 
-	return false;
+static bool machine__uses_kcore(struct machine *machine)
+{
+	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL) != 0 ? true : false;
 }
 
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
@@ -3137,16 +3135,28 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 	return sym->name;
 }
 
+struct machine__for_each_dso_cb_args {
+	struct machine *machine;
+	machine__dso_t fn;
+	void *priv;
+};
+
+static int machine__for_each_dso_cb(struct dso *dso, void *data)
+{
+	struct machine__for_each_dso_cb_args *args = data;
+
+	return args->fn(dso, args->machine, args->priv);
+}
+
 int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv)
 {
-	struct dso *pos;
-	int err = 0;
+	struct machine__for_each_dso_cb_args args = {
+		.machine = machine,
+		.fn = fn,
+		.priv = priv,
+	};
 
-	list_for_each_entry(pos, &machine->dsos.head, node) {
-		if (fn(pos, machine, priv))
-			err = -1;
-	}
-	return err;
+	return dsos__for_each_dso(&machine->dsos, machine__for_each_dso_cb, &args);
 }
 
 int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
-- 
2.44.0.396.g6e790dbe36-goog


