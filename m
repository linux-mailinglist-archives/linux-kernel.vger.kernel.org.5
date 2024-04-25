Return-Path: <linux-kernel+bounces-159326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C458B2D28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457ED1C21A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1407A86268;
	Thu, 25 Apr 2024 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2J7S0Ld"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67429156979
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084465; cv=none; b=mVXFWo2GI/npKP3hmjUIk7u86+237ZWsz6LCd1ZmEi8QGDjxI3SwkUzdLr95E6EQQgsyQEGYSV+acTY33NCVObvEPeaX5eYLXQqDvMZxyc7bMNIE8JLiOTn+j3xwxKb4ytfj08T64Vek/Puon/ezO5FgCcasw9uwlNp38o91tog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084465; c=relaxed/simple;
	bh=ZSwI+yq5E5BN4AjdvtMRad6FLRDWGqvN6S1bQXrEnHk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RsHFJt0jZXUUks2Iz0jqRCRq20Ew+lQCOoOuwztUknTDBvvbwQXEpNEsr+JnEQ2jaoBf2pJOYUcDXm6w69m75D8NfGOmJ/2Y9iYKz6ZbKa1umSmFPk9fr0X7WK7lRQsMjegzai1GUqyen2itJulkNlZ06YZYWvgNA/Z8vEXiT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2J7S0Ld; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b3b02f691so23746287b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714084462; x=1714689262; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pr67K9okSqlKqRnt5D4jF0pSd06W4wTNqiSPTASJPI=;
        b=G2J7S0LdC/2qf3MOFGuzqlAknAtlTuJBnkoVaPFabuPwTZhEpdceTI+qgKn88HsyAh
         bKtAFvArxzQ5eqF5ut6hrLohy8itmXQcboELFMtpVZWFtapC930Jsm+04UoMDFP0FxVc
         ougUP9gGVTmQwdxw4RhsgYjyR+VC6Ty5WWf6VCxNPC4xa5XcGyhTE6UBTdW0wB5Ja+Jo
         uei/cJCJ+vzgtdvq0uDUhKjhjWf0iFneQpviNwTVC6sHKyfeCqQituIdc9V3kJvQwwIw
         WK1DRUsFzniFxPTo8PTH3YtJ8NvB/sdkohoNLMH9MQOOkWMM5dOVJYqQHQFMok/JuL2r
         H8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084462; x=1714689262;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pr67K9okSqlKqRnt5D4jF0pSd06W4wTNqiSPTASJPI=;
        b=M5vn+47U06Ynb1Afm5eC6xBYLrzhIbZecINNI6uEIGAlvEYU+u7ZHpqNk2YMdqlD5j
         NDOeVBR0fcBMVpbLmyrXH5bA1Ks4O+yLtKPM+B07zZ/14X8UfNhXE4BowlObtwmWa3ZQ
         zrtZIebISEiHrVI/O05qaAVTLoxRUNL0CM/QnMkU9zT2nFCTNzj/vJ+duwGbYiFs6UDp
         F8h2J5mKSEullu/6SEIZHpil+mn18SrDOPdYl0zzJt4W2jAqqYli8auIKb7j0GuhKmaN
         yFf3/1mB51ug+lmUW/xQuU2mYeigccUIgtHFcN7xOVMGYF46f1RFP+3jGiT5K1i6f1IN
         rFkw==
X-Forwarded-Encrypted: i=1; AJvYcCXgu7nrDdD/M64d16gHfUDJdknnqY7/euyzO/qXBHVzmpTbE7UhTg1wqXaRALCPUiWE9D4qz4gH/7sb4+PNK6CkhbpOoaI/LiZ4Xb9C
X-Gm-Message-State: AOJu0YxhyqfH2wtaGJshpLZeDZezeNjeUIVsIKlmcSTc1kg7ptZq7Yjz
	EwCJComUG9GqVtFbTupj5an0+MiBhRqS9DYJ+Gfm3y9+yaBUqmAIrMU72qjrURBcoSKBjefew+o
	eylP/GQ==
X-Google-Smtp-Source: AGHT+IFtPTqMyFPlUEA83jO6S8cfsPVfGuW6p7qbvYx4galgmjpo6w0WgOMNmkHgVwvJb46mPDcrvhHnfULi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8708:517d:aade:8c87])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0c:b0:de5:78:34d2 with SMTP id
 fi12-20020a0569022b0c00b00de5007834d2mr115971ybb.6.1714084462481; Thu, 25 Apr
 2024 15:34:22 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:34:06 -0700
In-Reply-To: <20240425223406.471120-1-irogers@google.com>
Message-Id: <20240425223406.471120-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425223406.471120-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v1 3/3] perf evsel: Add retirement latency event support
From: Ian Rogers <irogers@google.com>
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a retirement latency event is processed it sets a flag on the
evsel. This change makes it so that when the flag is set evsel
opening, reading and exiting report values from child perf record and
perf report processes.

Something similar was suggested by Namhyung Kim in:
https://lore.kernel.org/lkml/CAM9d7cgdQQn5GYB7t++xuoMdeqPXiEkkcop69+rD06RAnu9-EQ@mail.gmail.com/

This is trying to add support for retirement latency directly in
events rather than through metric changes, as suggested by Weilin Wang in:
https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.com/
---
 tools/perf/util/evsel.c | 181 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h |   3 +
 2 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2743d40665ff..3f0b4326bac6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -56,6 +56,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include <subcmd/run-command.h>
 
 #include <linux/ctype.h>
 
@@ -491,6 +492,156 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 }
 #endif
 
+static int evsel__start_retire_latency_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
+					  int cpu_map_idx)
+{
+	char buf[16];
+	int pipefd[2];
+	int err, i, event_len;
+	struct perf_cpu cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
+	struct child_process *child_record =
+		xyarray__entry(evsel->children, cpu_map_idx, 0);
+	struct child_process *child_report =
+		xyarray__entry(evsel->children, cpu_map_idx, 1);
+	char *event = strdup(evsel__name(evsel));
+	// TODO: the dummy event also won't be used, but there's no option to disable.
+	const char *record_argv[15] = {
+		[0] = "perf",
+		[1] = "record",
+		[2] = "--synth=no",
+		[3] = "-W",
+		[4] = "-o",
+		[5] = "-",
+		[6] = "-e",
+	};
+	const char *report_argv[] = {
+		[0] = "perf",
+		[1] = "report",
+		[2] = "-i",
+		[3] = "-",
+		[4] = "-q",
+		[5] = "-F",
+		[6] = "weight1",
+		NULL,
+	};
+
+	if (!event)
+		return -ENOMEM;
+
+	// Remove the R from the modifiers.
+	event_len = strlen(event);
+	if (event[event_len - 1] == 'R' && event[event_len - 2] == ':') {
+		event[strlen(event) - 2] = '\0';
+	} else if (event[event_len - 1] == 'R' && event[event_len - 2] == '/') {
+		event[strlen(event) - 1] = '\0';
+	} else {
+		for (i = event_len - 1; i > 0; i--) {
+			if (event[i] == 'R') {
+				for (int j = i + 1; j < event_len; j++)
+					event[i] = event[j];
+				event[strlen(event) - 1] = '\0';
+				break;
+			}
+		}
+		if (i == 0)
+			pr_err("Expected retired latency 'R'\n");
+	}
+
+	i = 7;
+	record_argv[i++] = event;
+	if (verbose) {
+		record_argv[i++] = verbose > 1 ? "-vv" : "-v";
+	}
+	if (cpu.cpu >= 0) {
+		record_argv[i++] = "-C";
+		snprintf(buf, sizeof(buf), "%d", cpu.cpu);
+		record_argv[i++] = buf;
+	} else {
+		record_argv[i++] = "-a";
+	}
+	record_argv[i++] = "sleep";
+	// TODO: interval and support for different periods.
+	record_argv[i++] = "0.1";
+
+	if (pipe(pipefd) < 0) {
+		free(event);
+		return -errno;
+	}
+
+	child_record->argv = record_argv;
+	child_record->pid = -1;
+	child_record->no_stdin = 1;
+	if (verbose)
+		child_record->err = fileno(stderr);
+	else
+		child_record->no_stderr = 1;
+	child_record->out = pipefd[1];
+	err = start_command(child_record);
+	free(event);
+	if (err)
+		return err;
+
+	child_report->argv = report_argv;
+	child_report->pid = -1;
+	if (verbose)
+		child_report->err = fileno(stderr);
+	else
+		child_report->no_stderr = 1;
+	child_report->in = pipefd[0];
+	child_report->out = -1;
+	return start_command(child_report);
+}
+
+static int evsel__finish_retire_latency_cpu(struct evsel *evsel, int cpu_map_idx)
+{
+	struct child_process *child_record =
+		xyarray__entry(evsel->children, cpu_map_idx, 0);
+	struct child_process *child_report =
+		xyarray__entry(evsel->children, cpu_map_idx, 1);
+
+	finish_command(child_record);
+	finish_command(child_report);
+	return 0;
+}
+
+static int evsel__read_retire_latency(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	struct child_process *child_report = xyarray__entry(evsel->children, cpu_map_idx, 1);
+	struct perf_counts_values *count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	char buf[256];
+	int err;
+
+	err = read(child_report->out, buf, sizeof(buf));
+	if (err < 0 || strlen(buf) == 0)
+		return -1;
+
+	count->val = atoll(buf);
+	count->ena = 1;
+	count->run = 1;
+	count->id = 0;
+	count->lost = 0;
+
+	err = evsel__finish_retire_latency_cpu(evsel, cpu_map_idx);
+	if (err)
+		return err;
+
+	/* Restart the counter. */
+	return evsel__start_retire_latency_cpu(evsel, evsel->core.cpus, cpu_map_idx);
+}
+
+static int evsel__finish_retire_latency(struct evsel *evsel)
+{
+	int idx;
+
+	perf_cpu_map__for_each_idx(idx, evsel->core.cpus) {
+		int err = evsel__finish_retire_latency_cpu(evsel, idx);
+
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
 	"cycles",
 	"instructions",
@@ -1463,6 +1614,10 @@ static void evsel__free_config_terms(struct evsel *evsel)
 
 void evsel__exit(struct evsel *evsel)
 {
+	if (evsel->children) {
+		evsel__finish_retire_latency(evsel);
+		zfree(&evsel->children);
+	}
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
 	bpf_counter__destroy(evsel);
@@ -1602,9 +1757,10 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	u64 read_format = evsel->core.attr.read_format;
+	if (evsel->retire_lat)
+		return evsel__read_retire_latency(evsel, cpu_map_idx, thread);
 
-	if (read_format & PERF_FORMAT_GROUP)
+	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
 
 	return evsel__read_one(evsel, cpu_map_idx, thread);
@@ -1819,10 +1975,22 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		threads = empty_thread_map;
 	}
 
-	if (evsel->core.fd == NULL &&
+	if (!evsel->retire_lat && evsel->core.fd == NULL &&
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
+	if (evsel->retire_lat && evsel->children == NULL) {
+		/*
+		 * Use ylen of 2, [0] is the record and [1] is the report
+		 * command. Currently retirement latency doesn't support
+		 * per-thread mode.
+		 */
+		evsel->children = xyarray__new(perf_cpu_map__nr(cpus), /*ylen=*/2,
+					sizeof(struct child_process));
+		if (!evsel->children)
+			return -ENOMEM;
+	}
+
 	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
 	if (evsel->cgrp)
 		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
@@ -2033,6 +2201,13 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 
+		if (evsel->retire_lat) {
+			err = evsel__start_retire_latency_cpu(evsel, cpus, idx);
+			if (err)
+				return err;
+			continue;
+		}
+
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
 retry_open:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e6726587e1bc..ab7c10e7f063 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -171,6 +171,9 @@ struct evsel {
 
 	/* for missing_features */
 	struct perf_pmu		*pmu;
+
+	/* Used for retire_lat child process. */
+	struct xyarray *children;
 };
 
 struct perf_missing_features {
-- 
2.44.0.769.g3c40516874-goog


