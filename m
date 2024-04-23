Return-Path: <linux-kernel+bounces-154499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF708ADCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417FF1C20EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6561CF92;
	Tue, 23 Apr 2024 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkTVVeHW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1423775
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846391; cv=none; b=hWZw5GbNSFcNng+mdqGXKmle9++elCOcINXTOiTZRH0+Den+4E0d3TskH7Vq2BPv8m4KU5Ninb5qG3bdQzBPbl36vfOE/WHX5ZfWUQ6YL4lM4cEP9OduByyqalKs7IiNSr1OlRo3C6tfdn9vRYb6jVB4rrsXhdLdyyhlv7kUb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846391; c=relaxed/simple;
	bh=lIMr2C7pqzDmaOI4kvlL+gVjJA0HX90NyHek76POXmg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hfdPtjZlo9Xte0pKFPpUCnSfoz+h6UeGH0dkgZE0sWpHz2VNesl1JGsveJDk2Ds/AbAMPJ3yc26KXFZCgWCLxMMHVZyC8lvCNwv+g/Z5vfFyuBJ6p+WoJ4gvtF086ZiPaOEdiMbjbWJqNPTPTKRNpmffwIEOjnpfDRW43EYdv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkTVVeHW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61aecbcb990so99093957b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713846389; x=1714451189; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t830lzcH7ZkA8fGoYpxo9R5dnhJpcUV3/G0NAtLbkkI=;
        b=qkTVVeHW1fNCZ7HhC0v5Bzt5d59aZzAUw4BR7iDK1fC3hUOanK63jbZL1dsQlRenJT
         vldyWsQrPhaVdADo4PeSkl4633lOWQ7aRw/iOO8NVfpmtsY6ehv5BubAinxA1G6/G5Ly
         TRnEtUwZWQtGIrp2sMycu8w+vMWK1pFebtEvM0sVS0WyHp+bOMDlC1yV4NI7g98tzhAh
         temy5OebKRkzuh1whSDt7YE6Pz72foPwkkAseLShhIbRXwLqhNzK2pO4dKvbSB2TrIQk
         jGdbae4FLQUiHUC+YhEWyTkcV1qR+mChTQ7GSuilB7ThsUWc90375D+C0MZH5NpWkWaC
         wyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846389; x=1714451189;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t830lzcH7ZkA8fGoYpxo9R5dnhJpcUV3/G0NAtLbkkI=;
        b=LiR8FApspbpLSRh4GMSUdasJjXm/t2syxNLK/OGGbyL6e73V30M7V67n4Hm4StfER+
         h1tSEhiJq08qAI+NLnX7YIsEtVL42ZIT4k7y300CoqWk/ECHcBq8uw7QjyEjSIpufS1Y
         PBnPWSTfCFT4rwVzttBRze/G2dswdZzlF0hB21eXiBRC0Yk1wL4rk4c9YLRwoMaMXOV6
         H8wCQGD0j0Y2jC67ONwbpnxcKgQbet8TXfSzDRnV6MnNwRoFx6W1TbGj9TgkR662ISqy
         gM7xWeWdr9jpQWUNHJn2e9AK1YVI65M6WOi4PUsr1HBpHSBWHo1w28XLT47t+r01FBE1
         vkHg==
X-Forwarded-Encrypted: i=1; AJvYcCUTpRGOKrM1bXvfvEnaauyg/xhyHhPtFjcZbnY65XbHEzVok5izGReg8PqAhVpA7/kRg5+WFLLSm/MktshDPHbPtBMqscoOwgzhpowD
X-Gm-Message-State: AOJu0YwzIpPyCRZ/TmZrhzVc5CRIPZvgdGx0ZkvQTMaIdDvb8hFD14Sz
	KOGfDPCqkviui2eHqm1WkLy7kOmOESx4XJ6U9N0S48Thofv0CY7EGfzeR9w0sxOvqs7jD5GumYL
	fsid/1w==
X-Google-Smtp-Source: AGHT+IFLLHM5oEDt4wk7tbrU3Fyl6JYkACMhSxYcEYtGwh8vGDOVLkjQHzBU+PW+OTbRnPVPnJIMHPovhntu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a0d:c803:0:b0:61b:5888:aa59 with SMTP id
 k3-20020a0dc803000000b0061b5888aa59mr1710937ywd.2.1713846388874; Mon, 22 Apr
 2024 21:26:28 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:25:58 -0700
In-Reply-To: <20240423042601.2009469-1-irogers@google.com>
Message-Id: <20240423042601.2009469-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423042601.2009469-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v4 4/7] perf dsos: Switch hand code to bsearch
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
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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


