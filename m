Return-Path: <linux-kernel+bounces-162848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9828B6154
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6012A1F22A48
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8013B2AC;
	Mon, 29 Apr 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBTlteyW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9813AD27
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416391; cv=none; b=JHDVGJMlaHhS3kxGWpVZCLPiX4DCwVOiYsZgail11GAOWZHFh0GLW7mFkvD+f0m7Rcyc/RFdcdmAdweEHr9tsqguTuqdUzQLPd/KArMfEX0u4fZ0SHwCQwe4UWlmSr+ItmNYTCwjVQ14+lnyVWmlc949lPpZwrgGP5PjS90uPLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416391; c=relaxed/simple;
	bh=yUjT8P/u/B1NvSyqFF6Xe0KfOnvdIqmsfdBBhuufJoU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YIBLMK4VbNr4wKmqpUhBPfGTOHhoFcSnyUExK610uxF0e4m6yO/wvD/bXVz4j8esKt7ljA1eouRtt+Zon4bspjr5c3rqDQI/CQxZCL7ovTvM4uOa6y29GnYZP4vNnlcEIt2uyeEXrWBaGykGQoPrxcEpNFeFgyrJ37ShhVE6m6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBTlteyW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45dba157dso8002544276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714416389; x=1715021189; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egW6wC7a2vf04dYdvmCm4HwIn7PFhsPkwsZotZmHl6Q=;
        b=PBTlteyW8Ag4oREfpsdy/6LSQF61db0V8UK95UMnjFv2aDQ1AyLnVBzJhnPrHgdToC
         uzq+sGoWz52O+3E5nl0nx6yh7Lghb0wW8+70SD5cuNAOv2ZYm2YHsevq4HV9irdXAavi
         RSxhTAwlOiYGOuPTVC9n9gSOoIZADYQzJTQjw11H/l3svFYyhVFtZNEs0eH1H7PsZvFy
         4l7GWNR/S2em/4uec14MIV7ObpwOHvEnmd+7sQe1RenghHbrSLUGzsPfHqjKqej7Mtyq
         Qnun8JHPKBNgM0i9V4lRVb45rGn7NCRG/Gc4iZPmDS1JiSrP1eIOqZ2jzsvUOCKACjEH
         T3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416389; x=1715021189;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egW6wC7a2vf04dYdvmCm4HwIn7PFhsPkwsZotZmHl6Q=;
        b=rMlFIEEbGmwvOf9i5gA6CeZmdu5uAM6lqFQqIGuWomisseU4gr6FKRyEKvOwZke2qJ
         OBVkOMQQzRlAKVyss8gJcUaF6w+ct0O33HXD66nSNriEry8qbPBxzT4F9VL9MxPtKHgt
         NTUqvTYHUzNDYhUoaC/ASDuJC1Dw8aIc+GR5XZZWoYqqrSrC7v8pALFHJkdeI/qTSOD/
         yjUxnH+NHVYCAXYb9cMw02dAzznGV+YXEuYhLr4Lov0cWrnnVtyNHYwI7fuLLmH60bqO
         49IDlzmgbzWV+YnouqA+kC7mu32QuBzjJdg5b7BHO3GCWc7BvgYlt5+7itybdrsDBTpD
         RQIw==
X-Forwarded-Encrypted: i=1; AJvYcCVxoqUeR3NRzcfahgVtaw/s9PW37vQp3okyqF/h5zy832L5XvcaBVaZAqiDu0y+5Hfio8hiMrk7Q3NVUiQOf4oZ+uzCZqq5A0JuslLF
X-Gm-Message-State: AOJu0YytGzqDGb3KyOa8O4e14jEJisrP92zHOWU4oRN4HjUBndWK3wW0
	gB+qQIq5rP0+bsboybX8pKxxGJwilaMFFdN+vG93UfzehOiD6IcYFCHz4djjwfMeSAWjJiKa+Sh
	fMlizxw==
X-Google-Smtp-Source: AGHT+IG+InmiLhdsJdOYabDmZTl1O5M401Ry60HUlNW5hja7+vp3a8Iz6QJ4bUh5CJZfyJDA4v7PgKPSNdVI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1148:b0:dda:c566:dadd with SMTP
 id p8-20020a056902114800b00ddac566daddmr42118ybu.4.1714416389216; Mon, 29 Apr
 2024 11:46:29 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:46:09 -0700
In-Reply-To: <20240429184614.1224041-1-irogers@google.com>
Message-Id: <20240429184614.1224041-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429184614.1224041-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v5 2/7] perf dsos: Remove __dsos__addnew
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

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.44.0.769.g3c40516874-goog


