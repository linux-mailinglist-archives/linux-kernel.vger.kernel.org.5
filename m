Return-Path: <linux-kernel+bounces-154446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049C8ADC28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDA21F22A99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90D7208D7;
	Tue, 23 Apr 2024 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFO+hdSq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EE1946B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842269; cv=none; b=kaY2z8tfgM9fZ7kGRDomIdgecCmk+5u+vBEME+oFavlcM4LLa9G1O0CzEKLV1NdyHTJjE5asWEf1ITHNg7p7V0TTNMERwbLLQFwdsjumR0nPcuIn0a3Wfcyg8E7Vf9h7tdtjUUnoQVFgxeEsd35Pd7DZQ1cM2c232175DqPkFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842269; c=relaxed/simple;
	bh=8Ud9azO5PcSjSbHgyCUljRZLTNFfHQSnFxy0D2ZmZBY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sjHkdl1Z7A/zpyJJ6Q95K+DB0byINnLiQLboYLphqjAGqB2QMrADXTl312mNPWDvUbL9AziZl6VfHkOGhMItks+cmw8bsBvgMJK+OKTRBbQyC3nZl1DeSF1Vx2ENsJ+w8dFMsZFJeQj5mQ6t/WWpdAnBJBIsV58qlqfZtbjtbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFO+hdSq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de465062289so11627151276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713842267; x=1714447067; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZQIYLC3Jp4B8zg6R/mTCkQTco968W585hjb/CFclqU=;
        b=PFO+hdSqlIsF6ty84t09pjptlnyTX0DmzAwShAb1KcL0sB6+SdFLA2jAgkUrZAlVDX
         ou09y/9EpGSq1LQEgVnD0JA4pYVDzvu8qDPewj0oFfMbh9pK4HZfa4im830AEWUUju//
         slScyaFrk7xNMRaboWE7fyrqy1FvdBNjzy6RuxrQQNBCY6pZXlxVsQlrRd/St9PU67Lm
         mG0hZE+VYhMiz1OLC5g2wDncPRR2RtJs1hRmmCb7b7zVwup85/O6nE6+OarWGVFpqn03
         O4JNtiGZcPJ4pAW2tvGKJAxgT7t8/YSqJVCGwKykikRrF1ELLGJtfCmLgUwTS4zh4drz
         CD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842267; x=1714447067;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZQIYLC3Jp4B8zg6R/mTCkQTco968W585hjb/CFclqU=;
        b=PkWfdSIBqi3Qcjxpgy0KHNtGcr5yU1nQm7F/GWH7QLD5KsON9ju5Kt70xWy2e9lo+C
         WoxmTz8ASsliCYlFkFmczGmmkWljku9T6FUdUD0Zk3CJ/hnobgWDh7tPGDUAIGnbkwO+
         1mW42AfdX17GwcGHn9Pp10fZesJEUPpCxIUCxzhqCPUMneo6V9dXhDoHohX9U58YX9xs
         +wx2QLGnXPbo9K5abLiARLzNpLUUrSr7S29gvl9iAuKtYouzUZnGx4+UrLE4nTmbIjom
         e5vqjP5rI8vm3aqO3X6MlFdAQzqgFdfMH/0mCQ6Vhq8SaGCaCQNC4URxXYmhe3H/lCCU
         XPWw==
X-Forwarded-Encrypted: i=1; AJvYcCUael/mKg+7ip0q9s5Xl42dJHgINYS/D5NpRc+wpbdykwHIDjd8o3uL9jvJM3qR2DYr3ABeiCkkGGPlqsogo9p1UQ8Zw9+Zg+Jf10fE
X-Gm-Message-State: AOJu0YxtXu45n049KguCRitrYigqiaNlkKuLevZ4gNGBR5Nw78w5HQsD
	rxrv1qevnBE5R2HzA1ZsmhmyCHKKah2UoYL86tbdVxlS/PqOojf322y7AExz/jmqbz4g1jmuDxq
	C42RCxQ==
X-Google-Smtp-Source: AGHT+IH3lZGQUW6LT1S/BiMu7u8Ku/D/9AAj9hgQDSYHOpY7UakxkCM+1OpCzb0NJ61jmcjfNtPzBnUxKrWl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b93:b0:dc6:dfc6:4207 with SMTP
 id fj19-20020a0569022b9300b00dc6dfc64207mr3696839ybb.10.1713842267277; Mon,
 22 Apr 2024 20:17:47 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:17:17 -0700
In-Reply-To: <20240423031719.1941141-1-irogers@google.com>
Message-Id: <20240423031719.1941141-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v2 4/6] perf test pmu: Add an eagerly loaded event test
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow events/aliases to be eagerly loaded for a PMU. Factor out the
pmu_aliases_parse to allow this. Parse a test event and check it
configures the attribute as expected. There is overlap with the
parse-events tests, but this test is done with a PMU created in a temp
directory and doesn't rely on PMUs in sysfs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 69 ++++++++++++++++++++++++++++------------
 2 files changed, 120 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 6b2d9adcc583..f4e9a39534cb 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "evlist.h"
+#include "evsel.h"
 #include "parse-events.h"
 #include "pmu.h"
 #include "tests.h"
@@ -54,6 +56,9 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		{ "krava22", "config2:8,18,48,58\n", },
 		{ "krava23", "config2:28-29,38\n", },
 	};
+	const char *test_event = "krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
+		"krava13=2,krava21=119,krava22=11,krava23=2\n";
+
 	char name[PATH_MAX];
 	int dirfd, file;
 	struct perf_pmu *pmu = NULL;
@@ -110,6 +115,19 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		close(file);
 	}
 
+	/* Create test event. */
+	if (mkdirat(dirfd, "perf-pmu-test/events", 0755) < 0) {
+		pr_err("Failed to mkdir PMU events directory\n");
+		goto err_out;
+	}
+	file = openat(dirfd, "perf-pmu-test/events/test-event", O_WRONLY | O_CREAT, 0600);
+	if (!file) {
+		pr_err("Failed to open for writing file \"type\"\n");
+		goto err_out;
+	}
+	write(file, test_event, strlen(test_event));
+	close(file);
+
 	/* Make the PMU reading the files created above. */
 	pmu = perf_pmus__add_test_pmu(dirfd, "perf-pmu-test");
 	if (!pmu)
@@ -170,8 +188,62 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
+static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	char dir[PATH_MAX];
+	struct parse_events_error err;
+	struct evlist *evlist;
+	struct evsel *evsel;
+	struct perf_event_attr *attr;
+	int ret;
+	struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
+	const char *event = "perf-pmu-test/test-event/";
+
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	evlist = evlist__new();
+	if (evlist == NULL) {
+		pr_err("Failed allocation");
+		goto err_out;
+	}
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, event, &err);
+	if (ret) {
+		pr_debug("failed to parse event '%s', err %d\n", event, ret);
+		parse_events_error__print(&err, event);
+		ret = TEST_FAIL;
+		if (parse_events_error__contains(&err, "can't access trace events"))
+			ret = TEST_SKIP;
+		goto err_out;
+	}
+	evsel = evlist__first(evlist);
+	attr = &evsel->core.attr;
+	if (attr->config  != 0xc00000000002a823) {
+		pr_err("Unexpected config value %llx\n", attr->config);
+		goto err_out;
+	}
+	if (attr->config1 != 0x8000400000000145) {
+		pr_err("Unexpected config1 value %llx\n", attr->config1);
+		goto err_out;
+	}
+	if (attr->config2 != 0x0400000020041d07) {
+		pr_err("Unexpected config2 value %llx\n", attr->config2);
+		goto err_out;
+	}
+
+	ret = TEST_OK;
+err_out:
+	parse_events_error__exit(&err);
+	evlist__delete(evlist);
+	test_pmu_put(dir, pmu);
+	return ret;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
+	TEST_CASE("Parsing with PMU event", pmu_events),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b86ce9535088..40f3b5bd8260 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -597,33 +597,18 @@ static inline bool pmu_alias_info_file(const char *name)
  * Reading the pmu event aliases definition, which should be located at:
  * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
  */
-static int pmu_aliases_parse(struct perf_pmu *pmu)
+static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 {
-	char path[PATH_MAX];
 	struct dirent *evt_ent;
 	DIR *event_dir;
-	size_t len;
-	int fd, dir_fd;
 
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
-
-	dir_fd = open(path, O_DIRECTORY);
-	if (dir_fd == -1) {
-		pmu->sysfs_aliases_loaded = true;
-		return 0;
-	}
-
-	event_dir = fdopendir(dir_fd);
-	if (!event_dir){
-		close (dir_fd);
+	event_dir = fdopendir(events_dir_fd);
+	if (!event_dir)
 		return -EINVAL;
-	}
 
 	while ((evt_ent = readdir(event_dir))) {
 		char *name = evt_ent->d_name;
+		int fd;
 		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
@@ -635,7 +620,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		if (pmu_alias_info_file(name))
 			continue;
 
-		fd = openat(dir_fd, name, O_RDONLY);
+		fd = openat(events_dir_fd, name, O_RDONLY);
 		if (fd == -1) {
 			pr_debug("Cannot open %s\n", name);
 			continue;
@@ -653,11 +638,50 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 	}
 
 	closedir(event_dir);
-	close (dir_fd);
 	pmu->sysfs_aliases_loaded = true;
 	return 0;
 }
 
+static int pmu_aliases_parse(struct perf_pmu *pmu)
+{
+	char path[PATH_MAX];
+	size_t len;
+	int events_dir_fd, ret;
+
+	if (pmu->sysfs_aliases_loaded)
+		return 0;
+
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
+
+	events_dir_fd = open(path, O_DIRECTORY);
+	if (events_dir_fd == -1) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	close(events_dir_fd);
+	return ret;
+}
+
+static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
+{
+	char path[FILENAME_MAX + 7];
+	int ret, events_dir_fd;
+
+	scnprintf(path, sizeof(path), "%s/events", pmu->name);
+	events_dir_fd = openat(sysfs_fd, path, O_DIRECTORY, 0);
+	if (events_dir_fd == -1) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	close(events_dir_fd);
+	return ret;
+}
+
 static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
 {
 	struct parse_events_term *term, *cloned;
@@ -1042,6 +1066,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 
 	perf_pmu__arch_init(pmu);
 
+	if (eager_load)
+		pmu_aliases_parse_eager(pmu, dirfd);
+
 	return pmu;
 err:
 	zfree(&pmu->name);
-- 
2.44.0.769.g3c40516874-goog


