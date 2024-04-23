Return-Path: <linux-kernel+bounces-154497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE818ADCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CF0B2110B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B072135B;
	Tue, 23 Apr 2024 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OtzGqESa"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71A200A0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846386; cv=none; b=rz4CV66jOCdtzCIWWfc0rTAxDVmi4jSLLGINwGq+WHLFlUYaDLAyqRtYYAt1H7Q54EIrR+4HHkhd/CNXxxGF/3iKb3rFkvYuiTJa8w+AAdR/NsfbiqnhNRVrS5ZvO85a56oXWyXRg3mJsTwzJTRcqHXn3+EqdsoMH7LzE++BGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846386; c=relaxed/simple;
	bh=yUjT8P/u/B1NvSyqFF6Xe0KfOnvdIqmsfdBBhuufJoU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=etyegENHb87h9BahzFaCOZ63MxsJ8bXiUQ0wKPv4tWNnjAYHFn+YKtjtBNlxTSZQaZ0JDX7ri8Rr/78ch+1jrqs9UbBwnjDMGijG77CXKmmVBmZXsgzAISrEQTidAHYGFmAD7Gh9P++kmw/P1bC8+z0TOedq3ebFvMU+ogmb+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OtzGqESa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab173fe00so104974657b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713846384; x=1714451184; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egW6wC7a2vf04dYdvmCm4HwIn7PFhsPkwsZotZmHl6Q=;
        b=OtzGqESanv53dJ+T/LpOF3iw+aGXqSVQH8ZTb5zfOja8Y+Xbd77jDb94XUo7Sp2uiV
         9cfYaHrD+SnyLXodHi5X7Hdqc5UWhZL4PchYHW52eMtW9ab+Z+4+HjoBisVgi80aO/Xv
         EFVFnCjLrU6nAAZNJfn6KK7OkBQsDg/+DtIcmhlVk2IkIimAnjTiGlVwFAevi6fVrDDK
         eKqYvokRc5xAinT9kU1+urn61jNL2R6Ok0/80M8EllxJQIlHsvqilN+r2ch3BqDbVQ3O
         zbTPiO1Pd64iEf+iPvNKWnRWPS1I+rfyavmLz8Gj/7iR0hIdfxZv4s+Mcmq5cNg/Oi9a
         b8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846384; x=1714451184;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egW6wC7a2vf04dYdvmCm4HwIn7PFhsPkwsZotZmHl6Q=;
        b=HyMbodO6lRxsaEu2IEQZzpLKO07P0vAm0rrgaPwLOtUVWFHPigZbW5LtOQv4JRAwQe
         IUdAlglKCKvsv0UZ3MieumLk/3Xs6AQ/sNotl8s8L0qdWmcmJ0vUb36/cRzsWFiWbt5k
         CszFOfW3KuSVGhRIo45NaaQdTCnzUx10FPsMKgPbNq7ptp5DYHff05KPaVfdcvJ9jU1V
         jlleVWukHt8elOvtZWAD/rAlJxsd0ZCHI6itR+9IoQF3lN6iQIdqxVoLLSnPrLLYML3l
         qmuYY9fcBqRDGVa1IAytJ3qVmhUf+sOEVA11funF8k32ffxPRqzrHqhBYYRYYvllnIZz
         fNTA==
X-Forwarded-Encrypted: i=1; AJvYcCXMCJJpz4+0+nq1ld3ehr0PHZIKYjrxAI8BrQqWhQHN8nIrLDU9xCrodQYqMZswrnHS6T3t4OHGzqiCf1hO+eJYfENo9hY3+N/knXEe
X-Gm-Message-State: AOJu0YxfYz/oolxHeFF7mwFLL7JnUPc7mS7bng6phbAhmdkR7CXudIr7
	7cycsmlgKNbC4Iq8Bzk5MFX4m57S6vIM5uF/PhnwPXAsARQbLGkoI9jLJuw3aMTm1+U7h419B7l
	p7rSC7Q==
X-Google-Smtp-Source: AGHT+IE2os1+HQ2OZb9YCFhvP3ZM+TYfxKBgk8bo+cQsRHum3506ljwIH0nNK+Q1w0VLHS+2OVWiaW6nvwxU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a05:6902:709:b0:dcc:c57c:8873 with SMTP id
 k9-20020a056902070900b00dccc57c8873mr3981086ybt.9.1713846384089; Mon, 22 Apr
 2024 21:26:24 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:25:56 -0700
In-Reply-To: <20240423042601.2009469-1-irogers@google.com>
Message-Id: <20240423042601.2009469-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423042601.2009469-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v4 2/7] perf dsos: Remove __dsos__addnew
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


