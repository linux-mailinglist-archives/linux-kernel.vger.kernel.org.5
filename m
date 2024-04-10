Return-Path: <linux-kernel+bounces-138016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524989EB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE17FB24879
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2940BE0;
	Wed, 10 Apr 2024 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnoOY4Xl"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B53F9C5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731354; cv=none; b=ac5T8RBzZyf+HQvrqXcEbZnAzDc86zjb4S0JdvxcH+gFbjTSm0w0FP4GUMlEKQsTD6gXZuZXh+U6pkBNZWe2MKe6/kZKNW/VTXxHqbs02OK9NsplOv+HkqwnB4wKzJuWNtg1mR2ZE/19Nj/aqvr/yi34bVtt+zIyOqTSlOFMQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731354; c=relaxed/simple;
	bh=mAnPFVdlaWL/tFApwYeeagh4y1+c8q5INRTVB6MPKOs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hyVj9J7jFBnX8ibd6jWCwxGoFdVa2HVThIwhLypr/R6FBMtKow49jCmA8MeH2xupNPbk+JSpLVLUOdzXwqzdj+uZjnDujmE0xPa8HGlWmsm/F4dKyfLGuWCWttUv/Dw7nonkOYXgEEcaW60fp3cjyaYuSsX4BnCbCHBYZ61TSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnoOY4Xl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6180514a5ffso29682577b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731350; x=1713336150; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfDRhS4iVAGbl5UNPK+Y2BwcdlYkvyvjTNethl/uYBs=;
        b=ZnoOY4XlOa760KyxZffeazDvqKPPTRiOyRHiMi3tVQvyawiMXa7F0IwsUgBPqVQU36
         aay056mPk7WCE0BvF2gtt7BjI8RQ3W/vIZiIT7sYpinmPCA8G+fqV5tjc6AT5ed9vC3Y
         cNmegPFW9cq0oe5LW17UTZHp6Ina6+Lk00bGZLtdl2o/DaOYNtcm4ygGAkYVX1jlKvif
         Dbc6u+rodx23qAwTgqw8GTGn+E4dvEDSuoJtXLIso/BdLa5Do3LKJ+BOgVmFtfUFfnK+
         vSxrT2Nh5qNx8KBKUQa/gpalrbG/SbcydeGuvDY+HUVYGSD8wYuFQvTfqq9WWfwkQcV1
         H9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731350; x=1713336150;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfDRhS4iVAGbl5UNPK+Y2BwcdlYkvyvjTNethl/uYBs=;
        b=XxP//H7VcmvJ7ZpkM3idsCohKF7cue2XD3EBY2crcM/MlGN8nuKE0V3utSKCAPY/Uk
         V2ezlQN2WfyEJw224i4S305MAHA7BLBiLnBfq4Yc2pOqpMz1McN2BwVoFiZ2FCcTEH8R
         Fk/mK2mdGjkQPitNyQzjZ+9n1ACIPTG958KqrK3dTIYlBRSFM0c9gwEYhjm5OoaNKR3+
         MWLZtiBVNZWZgjdrf4ssCcNWELJKbg+O9YpdoRbVj7pDDuW8094UsgygsISzx4EfPC0Z
         kS6og+Ej1/RcZH/PS5MQKBJAdVU6fzdQV5X5iPgvPxvIr8PQMFIIH1QKJcmYYLUuJ6+K
         spLA==
X-Forwarded-Encrypted: i=1; AJvYcCU1iF1ZdV2tTlZl2xvOQuRj/lqTA5de/uD6CYfCD7rp+1VWZ4aQtO2ULimVniKzFERN9R0IEthVuWFt/AOGSC7BM4Tqh0sDOC0oZC1+
X-Gm-Message-State: AOJu0Yy0L5ioM6USDaA/E+23gHE63QIYN3XE2Gvu33e1tKu45/kGXqVH
	SFwhLzxTahT58ybG1Z8F8aAxFCAaTNqbiMaFHtLb62xjqe9o4k31haR269F++rZPsaMXA7P9e2L
	zkEWFvg==
X-Google-Smtp-Source: AGHT+IHIQuO6GXANAbFhDK4hK1bML6XNxeMNvLF+7KpKn9WoubdbMQqUEGaJu6Jnq6h9i1d883Pi2AS2t0UL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a0d:cb81:0:b0:618:29dd:b96b with SMTP id
 n123-20020a0dcb81000000b0061829ddb96bmr503841ywd.3.1712731350299; Tue, 09 Apr
 2024 23:42:30 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:06 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 04/12] perf dso: Move dso functions out of dsos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move dso and dso_id functions to dso.c to match the struct
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 61 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h  |  4 +++
 tools/perf/util/dsos.c | 61 ------------------------------------------
 3 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6e2a7198b382..ad562743d769 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1269,6 +1269,67 @@ static void dso__set_long_name_id(struct dso *dso, const char *name, struct dso_
 		__dsos__findnew_link_by_longname_id(root, dso, NULL, id);
 }
 
+static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	if (a->maj > b->maj) return -1;
+	if (a->maj < b->maj) return 1;
+
+	if (a->min > b->min) return -1;
+	if (a->min < b->min) return 1;
+
+	if (a->ino > b->ino) return -1;
+	if (a->ino < b->ino) return 1;
+
+	/*
+	 * Synthesized MMAP events have zero ino_generation, avoid comparing
+	 * them with MMAP events with actual ino_generation.
+	 *
+	 * I found it harmful because the mismatch resulted in a new
+	 * dso that did not have a build ID whereas the original dso did have a
+	 * build ID. The build ID was essential because the object was not found
+	 * otherwise. - Adrian
+	 */
+	if (a->ino_generation && b->ino_generation) {
+		if (a->ino_generation > b->ino_generation) return -1;
+		if (a->ino_generation < b->ino_generation) return 1;
+	}
+
+	return 0;
+}
+
+bool dso_id__empty(struct dso_id *id)
+{
+	if (!id)
+		return true;
+
+	return !id->maj && !id->min && !id->ino && !id->ino_generation;
+}
+
+void dso__inject_id(struct dso *dso, struct dso_id *id)
+{
+	dso->id.maj = id->maj;
+	dso->id.min = id->min;
+	dso->id.ino = id->ino;
+	dso->id.ino_generation = id->ino_generation;
+}
+
+int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (dso_id__empty(a) || dso_id__empty(b))
+		return 0;
+
+	return __dso_id__cmp(a, b);
+}
+
+int dso__cmp_id(struct dso *a, struct dso *b)
+{
+	return __dso_id__cmp(&a->id, &b->id);
+}
+
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 {
 	dso__set_long_name_id(dso, name, NULL, name_allocated);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3d4faad8d5dc..2c295438226d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -238,6 +238,9 @@ static inline void dso__set_loaded(struct dso *dso)
 	dso->loaded = true;
 }
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b);
+bool dso_id__empty(struct dso_id *id);
+
 struct dso *dso__new_id(const char *name, struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
@@ -245,6 +248,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+void dso__inject_id(struct dso *dso, struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d43f64939b12..f816927a21ff 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -41,67 +41,6 @@ void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	if (a->maj > b->maj) return -1;
-	if (a->maj < b->maj) return 1;
-
-	if (a->min > b->min) return -1;
-	if (a->min < b->min) return 1;
-
-	if (a->ino > b->ino) return -1;
-	if (a->ino < b->ino) return 1;
-
-	/*
-	 * Synthesized MMAP events have zero ino_generation, avoid comparing
-	 * them with MMAP events with actual ino_generation.
-	 *
-	 * I found it harmful because the mismatch resulted in a new
-	 * dso that did not have a build ID whereas the original dso did have a
-	 * build ID. The build ID was essential because the object was not found
-	 * otherwise. - Adrian
-	 */
-	if (a->ino_generation && b->ino_generation) {
-		if (a->ino_generation > b->ino_generation) return -1;
-		if (a->ino_generation < b->ino_generation) return 1;
-	}
-
-	return 0;
-}
-
-static bool dso_id__empty(struct dso_id *id)
-{
-	if (!id)
-		return true;
-
-	return !id->maj && !id->min && !id->ino && !id->ino_generation;
-}
-
-static void dso__inject_id(struct dso *dso, struct dso_id *id)
-{
-	dso->id.maj = id->maj;
-	dso->id.min = id->min;
-	dso->id.ino = id->ino;
-	dso->id.ino_generation = id->ino_generation;
-}
-
-static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	/*
-	 * The second is always dso->id, so zeroes if not set, assume passing
-	 * NULL for a means a zeroed id
-	 */
-	if (dso_id__empty(a) || dso_id__empty(b))
-		return 0;
-
-	return __dso_id__cmp(a, b);
-}
-
-int dso__cmp_id(struct dso *a, struct dso *b)
-{
-	return __dso_id__cmp(&a->id, &b->id);
-}
-
 bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 {
 	struct list_head *head = &dsos->head;
-- 
2.44.0.478.gd926399ef9-goog


