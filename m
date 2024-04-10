Return-Path: <linux-kernel+bounces-138021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31C89EB29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFEE282CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950746BA6;
	Wed, 10 Apr 2024 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yi8NnbPo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4A46556
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731364; cv=none; b=dGMdmVDWQfwsphJ78uQYvFFmwPHb1PoFL9/D/e8bzThtQ8fqtD5WlFoPXcKiim1HBVBiudxThlicWmSZ3iuDlWjieMYkeX3SfmRMAEgl50EXRwZGI/fJ37x4yW5eoUh0csCty+g3ZEnYrp/6PsJvt6WiNCmjCOsjeD6K6SgYO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731364; c=relaxed/simple;
	bh=42zY53QnJZrcTSN1WBu7uhZGWBRzUr8uOaTtwwiy10M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=o4pCoBptv2vF5evP6oBHHItWAUsAgicgotjZxFeqN7mDbDyH1Uka9CUrf4ZRSa4FU3qYtRsHn1Bf2pMbzWy7C/wP//fzK0vU5dod+icCx8HY23ZPjIh5ylDCk53lgPaBHqjIKqv/oJJIdK+JycXP265oR69sHd2jgYjSGL7pxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yi8NnbPo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61807bac417so52230677b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731362; x=1713336162; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SblkLkdI+0aSxodGWL1iRbgRohVBloy3Iv378OtJsOw=;
        b=Yi8NnbPo4YIgfGyFADrXRhmjSLqF51cDyEmaSo2Zw4U3qVIl9Pi4BsJO14U3q2sPoE
         sC98lIQ6d3/aAGsxu8Ouw6+DbePoMz9IYhEDau7wrV53jzSYjWU5lv3gb196zSSIn6DO
         C+cTaLXotJfSXqunoN0no6IU4YZjIZTjBDmXqwy9CH/OhQkTHnzv/cuI8GHKNmFwSL6K
         oYZKsudzjFzHsxn664U62G2aVjzRAbOzGL2CDi2rBlxX46Lg68FSpIunIGPUmy6L5HXO
         q9+HBJ/yRCWxqcXhyFYFvT3j+FxoUg6+/O24wgfySqIi/QHmXdfsP/juoKC9kgjQGgV+
         pSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731362; x=1713336162;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SblkLkdI+0aSxodGWL1iRbgRohVBloy3Iv378OtJsOw=;
        b=bn5q6+DK6RZi5H9S1Pr7nG1J0BctZbaOMPmMx/mQBZXqUbXkcehVgNC2wTGtF6yFYI
         +KF1FWK0x8U7weCVbWRF9/xCkaoXTioXQtpjmv00fLueBQG+SbcMI4ZOyORe+KofePeN
         m7tm09cK41/JoK+SC36KxKMwddCiY3/yumZyfUpknvF2bX1IEtZU/KGvccc85z11oTgu
         eZz0Lm+O3tnQFw5bO80FkSAcv/f+x35YPzxiXC50U2zbSZYAcMQfgOpyS+7OC+nctZf8
         TvY+PX+rpjmweeg2DWvRXdPhpGrB2wnv2N0+HlHmzZZbkAEeJEYYjM5HlnRZ2R+BkaY5
         4eRg==
X-Forwarded-Encrypted: i=1; AJvYcCVfkvTKx1bDYTfpfzAE7VsOJWK82VkBXOe3KRkq4HYBN/aF3FsOw3aTbSTq0rIN5LbzDqjvLjSiWT6U2QsuPR+k9w6P9CY0jh8rOECF
X-Gm-Message-State: AOJu0Yxh4mOzN9Ax51Yr5VNC+YEnZjDFvVSZr5QPyIE0pPnWZ8KR83wn
	yhEy/q5+xwdUkhoTXG0qWe7AC2XNuEQQvwKSEFlWqEETdX2+QA2nMtw2Jqr4WeMRHa1sTjO6TkX
	OhwJaaA==
X-Google-Smtp-Source: AGHT+IFxRteKS7D+GrbeTQYsLt5Wj6GEXZGo+1pVZfHBsC6OgEkiEVQRzvGZRMGh0SAZyLeUJGMtwQQ1KYaZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:c0f:b0:dc6:fa35:b42 with SMTP id
 fs15-20020a0569020c0f00b00dc6fa350b42mr601993ybb.2.1712731362215; Tue, 09 Apr
 2024 23:42:42 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:11 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 09/12] perf dsos: Switch hand code to bsearch
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
2.44.0.478.gd926399ef9-goog


