Return-Path: <linux-kernel+bounces-91114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86E8709B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDCD2888D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557E7C0A0;
	Mon,  4 Mar 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkSr25sd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2D7BB1C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577366; cv=none; b=i4dlrgtye/ntKfoSmOMhZePu0HDOPuk7PWoGvy417yX6bkiY4DZt2gP9BOVd5lU/cHD7S1MSFyusdTThrSdvCfPZX+n35nfZf12GArkkHBLaguOaNHTOcGsIMqTb7ftkP/RwznoWhPg9z9k3Rof+8fwjUcutyuxqwgtFCVaQ9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577366; c=relaxed/simple;
	bh=Rmm4Jl+dKojydHSTYsw6rZLmqtvLqjTT3t4QBJkAQUc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oobVQQDryDGXWVRfVTSO2xPlWpz8DmItdbt7gUuKKEZT0SlsYxLcFH9QOFvT9nYHfhe5XqVHlc3ulG7IQJWzVXlc9jSHJBcxaPYRTKmmpkLPol6N+WU/NFk6zMbRLUbaB9AumaSciHvMrjqWykpqEq8Z/m0Vg2Mb5HW3BLkwMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkSr25sd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60802b0afd2so44059567b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577364; x=1710182164; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elyaXxnu3kLNSiHaHQqHNNSmPD05pnTV+NtD2a7Yb6M=;
        b=WkSr25sdEBmmSyXKsm2evhzKm5y0gYlgnSZAv9M9gZg7f7zHLaCgd21emCzrxcNQNP
         oWF+oMEfV9vsjG+3YvxhG3cx1d0+YlpAqjDVdrwZHFN6GumuMvs/22NxH1El/dGD0VES
         QQol54aXd8aPv+RvLMkmXp2eJySGLoQC9CuOfLsW6XcyC9rsUasRYRGWX9mxHy8765ul
         rvb4w5+fMJegHpSOY8nehOR7muW6psE2D4Y1dHzY2RKHWn4Khrn97FMp6xbA/yqTOuKV
         X1D9/85BCmqrk+GUSFCHpp3clfHuC6h0s0vXpO6ZMif5HeiT7BGP9eQFDAffUeY/FJYU
         VO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577364; x=1710182164;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elyaXxnu3kLNSiHaHQqHNNSmPD05pnTV+NtD2a7Yb6M=;
        b=okoIg6BkwCNtJB5NXkSXKzygJ0Amp1v2AWrOZtNNu6cmde8KIbTcoh+0O04QJ5gPZu
         LF7mTrUXA2kXhHdGyf/BBbGf71z/X9vwia8+L7rZd9/QORflsS6i//DRKhTEAEa4aZY2
         H6AoSybt4QC19zP7B+OFbUKDnxXefKpbKC7zwBvBCK0hj9VMEoF0Qr6csmh8oZIyC6aZ
         mjsTr0nRDTuJQyIylYZoqore1Oa1LKKEHV7ohvMzCZ3JRsXtrB7uxqGWFOpgiv0X+3+A
         FZqy+XflCPABJ23DV/z8bDLlUrV7qOhcQ/xj+GijKQhfzEs8+STnfSHojI7bLJZGoyu+
         sAuw==
X-Forwarded-Encrypted: i=1; AJvYcCUCz5GwCbiehrLD+ghVId8RRcag0fStfWRCsxniWTOJ7q5GER7BaHeg9G9aUyrFNm7Xo4Kkj7rJyCFHsanxB8P+VyeCl3evHGCaycl6
X-Gm-Message-State: AOJu0YwV/84AoCuiyt5lNgKPELcm1ggNgjiWAY8PTzPM39wxNUDNqiF5
	fbsGg8ue2GriSSn4s5KIvmCV9NF5/Vhzj1q1Yty+yaqPQ0wb1Z5SDR085Ecu0yeq1MS8Rsh9auU
	BS5j/bA==
X-Google-Smtp-Source: AGHT+IG3ITz47E+3/2P/RfAiowo5eAkzURLf4b3AU5AgOv6MaRd9ZwJizc0+g6TRKlkVVPGed7ribMZLMhLr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a81:d104:0:b0:609:82e7:c0b with SMTP id
 w4-20020a81d104000000b0060982e70c0bmr48613ywi.3.1709577364013; Mon, 04 Mar
 2024 10:36:04 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:21 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 10/13] perf dsos: Switch hand code to bsearch
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
2.44.0.278.ge034bb2e1d-goog


