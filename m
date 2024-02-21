Return-Path: <linux-kernel+bounces-74187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358EA85D0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A951C22ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F2B3B198;
	Wed, 21 Feb 2024 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5WMWwiS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADAA3A8F5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499283; cv=none; b=YH4/5ntWLtqbyW5ROkHJ7RK9kRhw94f3ZzoDUJztvUO3/9U/rzeRTCTNL7S5rolhIHSpcGFDMTjsn6slLU7tpv1b1o/J29oc2GmcD5ktOWBVvdMKFxIYQcCySsIa291aT6qp8aoIzOKebDLxXDpr8Z6yfDv7m5VAmwDcAVu2O+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499283; c=relaxed/simple;
	bh=VTnFedSHbWRXdPeVX5bVM50OyRSGy300r/pvDJawCfs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=dUmFoBO7ZhKQTiwyalHiBkSWvC9dEMu9FkKSQYKYWzMlYgRvCYJfoEFyzkoxcYReiYBADplcnqHj0TcPtBD2hFrtvWXZFs3CaCUxq0CyzFpepfvxmfzsxYNShbsbCB3vTQz1KbVR99bx4D/CKmK+HBI6rHAwVnIYiVdJmW9Ib0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5WMWwiS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so10934471276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499281; x=1709104081; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfVuTk7FcAUa184IhDAbJwuMC16l/TIzHOCMWidcT2s=;
        b=u5WMWwiSuRnVlwYVjkghy8yD3+KyPndGBwJfXJ3oKw/BulP7ut1YfR1R9vuMafZ1V2
         fGzEfiA49uhG7VmObQzrcbNRYV13emTfYeZ6SSqiqxtNG22tvRMAl5n5UK6gR6qSvFtg
         Pq0kPTpxlRn4r4r7y/pV9Det5kO0rnCLFh8Yf7JHDxKI+Kwj7yxWWgOn/ent8eAN3l8Y
         Cy6WZ5Fr6+JOShEM9A0G507i6PxF1PHmYKLBjZDbTNuTwgCk9fpbMcxZN9iMPAJJp0JW
         y5CaPMzksKBcWYfZXzL8be9GlSwiESvNCzd28wVz9uUSc+nrIibcuBGlyclG6EVfYPo3
         w3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499281; x=1709104081;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfVuTk7FcAUa184IhDAbJwuMC16l/TIzHOCMWidcT2s=;
        b=Y6qkiu+AGSg1Uk8u1aZ6encGMjkV6gYtaFArTMy7hegexDKjRg6YcbVbfDrZ4Y6xpJ
         3NHXY7fTtHKMbnr3/ASVYLXvjzXCSpMVHG4EjGRVKFjsHF0+1gRTKr+osNupLuY+rgFF
         AtHfG16tP8rZwNf5/buvEmeGaZEbA2OyhJ5c+IjHNY5coLgbpGu5C9rF6cJH5D03Ps4G
         5nR75g5Yb+ldZs0SpxCpd0B0QkQzBpQhFs2yz7C4lLR5EtguCiQHCcr+sSDV3jWdJuwe
         CMVdD/5rTPvA1/UP4sBaRhoK5X/VM15IkhXewUb1SG40w/Ni++LiBHUEkdXk2aSvvweW
         wpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlvbpQ7w44aoN1t8vx77My+wc2p/u4BmQRuaAxNd0kZWZA0XtKjPQxPy0CuZvJ3H515FxoUuMbnU+3FcB/bRH8Ah5xsH5FU7qgHiKK
X-Gm-Message-State: AOJu0YyHHD1zxxtka8GaFmjI8/R5KvPMVRYOTz2JqvXxWpdoc17vA2yV
	awOviGGtNOZtLS6pdBjD7ozy2CUWehk2Bm+qPCnZfQWUuanSUV7og9FHLENqsw529dkzZn27o9O
	l5/VnCQ==
X-Google-Smtp-Source: AGHT+IEjSgJYS5XU5/3VduLquncZCLuHXOsyv5NjgSTN6RCN2NQWWZVx/AxQIvEZPul2v2cXQ4FctOlKH6g7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:98b:b0:dc6:ff2b:7e1b with SMTP id
 bv11-20020a056902098b00b00dc6ff2b7e1bmr5058563ybb.4.1708499281168; Tue, 20
 Feb 2024 23:08:01 -0800 (PST)
Date: Tue, 20 Feb 2024 23:07:54 -0800
In-Reply-To: <20240221070754.4163916-1-irogers@google.com>
Message-Id: <20240221070754.4163916-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221070754.4163916-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v3 3/3] perf stat: Fix metric-only aggregation index
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Aggregation index was being computed using the evsel's cpumap which
may have a different (typically the same or fewer) entries.

Before:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            12.8                           0.0                          12.9                          12.7                           0.0                          12.6
CPU1

       1.007806367 seconds time elapsed
```

After:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            15.4                           0.0                          15.3                          15.0                           0.0                          14.9
CPU18                            0.0                           0.0                          13.5                           5.2                           0.0                          11.9

       1.007858736 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>                                  |
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ae37395f90c0..bfc1d705f437 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1137,11 +1137,16 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			u64 ena, run, val;
 			double uval;
 			struct perf_stat_evsel *ps = counter->stats;
-			int aggr_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+			int aggr_idx = 0;
 
-			if (aggr_idx < 0)
+			if (!perf_cpu_map__has(evsel__cpus(counter), cpu))
 				continue;
 
+			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+				if (config->aggr_map->map[aggr_idx].cpu.cpu == cpu.cpu)
+					break;
+			}
+
 			os->evsel = counter;
 			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-- 
2.44.0.rc1.240.g4c46232300-goog


