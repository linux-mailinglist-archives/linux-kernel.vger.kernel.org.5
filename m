Return-Path: <linux-kernel+bounces-162851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A923A8B6157
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219621F20FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342E13C683;
	Mon, 29 Apr 2024 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAsCQMof"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCF13BC32
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416397; cv=none; b=Tsdq8ecy/QunBnjiweQuDZ0YEXovymknR/8m0fCLDRcQuXe61FY+SGJTM6YTiHXVtzVmZ8wDrlZeq6e6YRVgjcvw2YXtodDeQk9QTZ4wl85r3Z//0s8VAlCv2wDnBPbXsvt9Yya2lPNJUdDGctiTqUs3vLoCJGQeWHlTMxTOYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416397; c=relaxed/simple;
	bh=lIMr2C7pqzDmaOI4kvlL+gVjJA0HX90NyHek76POXmg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UrorF6Oei/haef21mmj63c7pwVQn3/pMBZ00gL1TH7mAWwbzWdZNj9POokRfG0iEz/Aed8HAYVaT3CENHtbfV36sQkzh3plFTX93d8zqUOfTSjFEq06Jn5bNGHgFZlwhfJSxYx++uE6PkP8vuZbfmnvhJj3XLhFOIIYlreGpZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAsCQMof; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be325413eso6906307b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714416394; x=1715021194; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t830lzcH7ZkA8fGoYpxo9R5dnhJpcUV3/G0NAtLbkkI=;
        b=RAsCQMofKX/qnXwz+B98pphpFrLRT+OcKCBriURhKFpGWWrfVOT7lxZwoZaukH0Tch
         Dr5qdwSTeo5LjLmaOhJb9XsBEWZMTaSuLcLtDnOKMhibwz1JPV2KZF+1lte8lxYEqlUy
         eZTAjrvuTdzxMEqC61hTxGsXW0EisO3/0uhtUWhixxrsCp/a0G+lT3SdnHZEwIHG7FN2
         kNfG2dH9LLYJ/wlWJhr1sTEA8vTg6slmnQ+FVFTxyEzC9wOu7q72CIp86wZOpHOHj7Oo
         2Qk9yW8ylBRieadHqcwzSo83VLuTqYSpFdP2HEaIDJWsN5PQHatMXDhswa0F/mCP3LpD
         6xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416394; x=1715021194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t830lzcH7ZkA8fGoYpxo9R5dnhJpcUV3/G0NAtLbkkI=;
        b=V5BVZ2qZ1H6ukUs2qGpPDHlHk7+prr4kFDLkFrLc3d09kuXIQ+UVMuDxi7IvtgyDcz
         ppxBN0vktiI9eJb591QgkgOsQJiL6ragb60PDJP3g1yWwcIAqoFOSZ7DGCQZXVt8gUWI
         7rw3a66O5nlxOC/CGbD88LBd/I3E6cfhMS30GIc1pvjVFf1spqU6sbg3TTHKh8gs29lV
         2GbF3xjABL81pq4UFOtxuzSXC2zCgvdFK25gYRe2fRV3JURCp7C9ba3tmovY0P8+Y1ol
         sjQGM+6vxThbrCgfkFIAI3i9jX7YcnuOaV8v40BFNY8oanpOxpLSUFzXP/Z0XyEBl7s6
         0QFA==
X-Forwarded-Encrypted: i=1; AJvYcCWhUgSTU+WwXmjNsCzq894JEgVUP1YHIMSsUf4LwaFmJCBkz68ppC+MPco3PaqTyG+xGZI/2yQPbj6lf7JLaxM7SDxVAe7sIRJwx1KO
X-Gm-Message-State: AOJu0YzRAPE8nhBUsziZ/jvJFnY6zFi/m/FdGvNn4utzwB0WAKTSrNGd
	wN9/dlZn0C30ixwrz0PbIrX7D1Qi19e8ALfnDFZ5t/BSxuGOSJbKlepUour7Ae8ZRKqPwnMknUc
	AxfJZ3g==
X-Google-Smtp-Source: AGHT+IFFsmMPcHsPdDc+H2stjnuMt+QQETrq1lIc23awjP5WEsDkUfiVQzwpl0Hs74qYWMuw1BzKaJPC9FQH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a0d:e2c3:0:b0:61a:d420:3b57 with SMTP id
 l186-20020a0de2c3000000b0061ad4203b57mr112870ywe.0.1714416394201; Mon, 29 Apr
 2024 11:46:34 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:46:11 -0700
In-Reply-To: <20240429184614.1224041-1-irogers@google.com>
Message-Id: <20240429184614.1224041-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429184614.1224041-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v5 4/7] perf dsos: Switch hand code to bsearch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch to using the bsearch library function rather than having a hand
written binary search. Const-ify some static functions to avoid
compiler warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e4110438841b..23c3fe4f2abb 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -107,13 +107,15 @@ bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 	return args.have_build_id;
 }
 
-static int __dso__cmp_long_name(const char *long_name, struct dso_id *id, struct dso *b)
+static int __dso__cmp_long_name(const char *long_name, const struct dso_id *id,
+				const struct dso *b)
 {
 	int rc = strcmp(long_name, b->long_name);
 	return rc ?: dso_id__cmp(id, &b->id);
 }
 
-static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, struct dso *b)
+static int __dso__cmp_short_name(const char *short_name, const struct dso_id *id,
+				 const struct dso *b)
 {
 	int rc = strcmp(short_name, b->short_name);
 	return rc ?: dso_id__cmp(id, &b->id);
@@ -133,6 +135,19 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 	return rc;
 }
 
+struct dsos__key {
+	const char *long_name;
+	const struct dso_id *id;
+};
+
+static int dsos__cmp_key_long_name_id(const void *vkey, const void *vdso)
+{
+	const struct dsos__key *key = vkey;
+	const struct dso *dso = *((const struct dso **)vdso);
+
+	return __dso__cmp_long_name(key->long_name, key->id, dso);
+}
+
 /*
  * Find a matching entry and/or link current entry to RB tree.
  * Either one of the dso or name parameter must be non-NULL or the
@@ -143,7 +158,11 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 					       struct dso_id *id,
 					       bool write_locked)
 {
-	int low = 0, high = dsos->cnt - 1;
+	struct dsos__key key = {
+		.long_name = name,
+		.id = id,
+	};
+	struct dso **res;
 
 	if (!dsos->sorted) {
 		if (!write_locked) {
@@ -162,23 +181,12 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 		dsos->sorted = true;
 	}
 
-	/*
-	 * Find node with the matching name
-	 */
-	while (low <= high) {
-		int mid = (low + high) / 2;
-		struct dso *this = dsos->dsos[mid];
-		int rc = __dso__cmp_long_name(name, id, this);
+	res = bsearch(&key, dsos->dsos, dsos->cnt, sizeof(struct dso *),
+		      dsos__cmp_key_long_name_id);
+	if (!res)
+		return NULL;
 
-		if (rc == 0) {
-			return dso__get(this);	/* Find matching dso */
-		}
-		if (rc < 0)
-			high = mid - 1;
-		else
-			low = mid + 1;
-	}
-	return NULL;
+	return dso__get(*res);
 }
 
 int __dsos__add(struct dsos *dsos, struct dso *dso)
-- 
2.44.0.769.g3c40516874-goog


