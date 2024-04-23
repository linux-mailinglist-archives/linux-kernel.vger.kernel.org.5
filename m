Return-Path: <linux-kernel+bounces-154447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFBD8ADC29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B021F22612
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B61BDC4;
	Tue, 23 Apr 2024 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfXKRgps"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6F208A9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842273; cv=none; b=V17bucbzS9ej0JEFd4XYU6ZUWyWCYZLfHgy/N0+ntkyWNXfGlm1pFG4KsuvKlCd15FCysewf/DlTB8e+5Lc8TbSnR0gMPrTbpor0hLqrGwFhV9IA4iz9IcrRTFAZF+SZvNkjQfrOH8PJsNnqIvURs1fTy3uqtUgzoLE2A48eBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842273; c=relaxed/simple;
	bh=E1NYTZCiPELYJLqZwKX2be/pmTCtqFmd3FWtFUf2X/o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Kqdhd07ntV6el+3RoIF5nlVj4RtanWGJGGOwWzQp6UNXKMWvzB/JtgTOdn5jIdzLgLS9IIQfveSX1a8Do+5N2qup1tNkciZWTb3MeZ/PKjF15aTZdwz8Nl2zPj71u6sco4hCSv/H/rP5UUYmMwqdqnOrWLdczh+HQ8JFG7l8aZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfXKRgps; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54ab795e9so879722276.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713842269; x=1714447069; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MZ1B2ThtmuE4LUDfVaEWTRWvyIuqxlXw4qD7SFEw9g=;
        b=jfXKRgps/TqR5jWCUL9LS5sSS17uaPQvtlJMeMXMCyTC80xyNWQMUT71TH3XpmlE8z
         D75H8JG7Wjcgyq3/xSDgMle4JDviuOiWDEUteQYbsUurZpO1l0lcNcah+o7X0Wtoyk6e
         ffeJu7PRUn7+nBtoncgRgM4wu318S7j/LNt1ErAHxkO7PtQFCgszGiRqGmKfkCPwA9MM
         9rYFANXkUWnOM2IrYSFskS2h1/g1Qv6xqZbMfO56cZV84UI1eMIri8/ZjwCzZoJM6+yy
         pxkwiPSPPl2GItzQjqPq0eXYN/IX98o0STznMotKUJlNq/Ax75uMwMF9T6K6gK0eFd5W
         Acmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842269; x=1714447069;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MZ1B2ThtmuE4LUDfVaEWTRWvyIuqxlXw4qD7SFEw9g=;
        b=BC1XgAi5ecxO3K2qT8/EeL56YAGcdyPN/Pbs7Oug+DwTrP1giuQQ39+6f1mqHltqie
         SDTCBfrYbxPbyhGFNwVSjdnGlGrU2ShfMKpgfS+LD8VB846I56GkkLaVgoGlgR+CZvZM
         T2efNLj2G4A+BXgUjx64pbqzKxy7wSE84w+SejErJDOhPstrv97hRkiAuAehUi5QeSZr
         wmc42CkRib1d4hdFZKA84vVVlqmlTBfCfHWhL/F/TY2n2NXBJSSFiTVSlJIbQmgneGOM
         oo/8XnSWycTc8zBlGvf7Q+I/SmY/rglmGxKTJ2lMtZR5scY5VgFaEp0I2o6aMq9Hzl+h
         k35g==
X-Forwarded-Encrypted: i=1; AJvYcCWTjxWtqLQxoBb1/jDLveFuFWUEy7GBCWgFGVzN+gFbml6BDJ3mI9aWO3pDUV/kJUHIIJW6Wu28MQwZ51eeCB9ZbiKcsCJTfJwJL8ee
X-Gm-Message-State: AOJu0YyV0Aci7ZLimr5mLfytutYTMU/WpToFc0qZkqasA+Kc6BzRVnBc
	cbDl8wyDyNBVqgpnYpoz53bp9hybjYT1VCydnIyMjc81ezz3MYA1BZJcPJONE85mdbVy26C4qu9
	Alh8jCw==
X-Google-Smtp-Source: AGHT+IHaDrw55QOQi2OcL5qkYZUPabOA+Exfyv96i/byxsyQDlCUif+jbm64bsDhJeNP5sRPoTUu8y2nLbDz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a05:6902:1883:b0:de4:67d9:a2c6 with SMTP
 id cj3-20020a056902188300b00de467d9a2c6mr968089ybb.2.1713842269517; Mon, 22
 Apr 2024 20:17:49 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:17:18 -0700
In-Reply-To: <20240423031719.1941141-1-irogers@google.com>
Message-Id: <20240423031719.1941141-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v2 5/6] perf test pmu: Test all sysfs PMU event names are lowercase
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

Being lowercase means event name probes can avoid scanning the
directory doing case insensitive comparisons, just the lowercase
version of the name can be checked for existence.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index f4e9a39534cb..c49e790248cd 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -5,12 +5,17 @@
 #include "pmu.h"
 #include "tests.h"
 #include "debug.h"
+#include "fncache.h"
+#include <api/fs/fs.h>
+#include <ctype.h>
+#include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 
 /* Fake PMUs created in temp directory. */
 static LIST_HEAD(test_pmus);
@@ -241,9 +246,79 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
+static bool permitted_event_name_char(char c)
+{
+	if (islower(c) || isdigit(c))
+		return true;
+
+	return c == '.' || c == '_' || c == '-';
+}
+
+static int test__pmu_event_names(struct test_suite *test __maybe_unused,
+				 int subtest __maybe_unused)
+{
+	char path[PATH_MAX];
+	DIR *pmu_dir, *event_dir;
+	struct dirent *pmu_dent, *event_dent;
+	const char *sysfs = sysfs__mountpoint();
+	int ret = TEST_OK;
+
+	if (!sysfs) {
+		pr_err("Sysfs not mounted\n");
+		return TEST_FAIL;
+	}
+
+	snprintf(path, sizeof(path), "%s/bus/event_source/devices/", sysfs);
+	pmu_dir = opendir(path);
+	if (!pmu_dir) {
+		pr_err("Error opening \"%s\"\n", path);
+		return TEST_FAIL;
+	}
+	while ((pmu_dent = readdir(pmu_dir))) {
+		if (!strcmp(pmu_dent->d_name, ".") ||
+		    !strcmp(pmu_dent->d_name, ".."))
+			continue;
+
+		snprintf(path, sizeof(path), "%s/bus/event_source/devices/%s/type",
+			 sysfs, pmu_dent->d_name);
+
+		/* Does it look like a PMU? */
+		if (!file_available(path))
+			continue;
+
+		/* Process events. */
+		snprintf(path, sizeof(path), "%s/bus/event_source/devices/%s/events",
+			 sysfs, pmu_dent->d_name);
+
+		event_dir = opendir(path);
+		if (!event_dir) {
+			pr_debug("No event directory \"%s\"\n", path);
+			continue;
+		}
+		while ((event_dent = readdir(event_dir))) {
+			const char *event_name = event_dent->d_name;
+
+			if (!strcmp(event_name, ".") || !strcmp(event_name, ".."))
+				continue;
+
+			for (size_t i = 0, n = strlen(event_name); i < n; i++) {
+				if (!permitted_event_name_char(event_name[i])) {
+					pr_err("Sysfs event names should be lower case \"%s/%s\"\n",
+						pmu_dent->d_name, event_name);
+					ret = TEST_FAIL;
+				}
+			}
+		}
+		closedir(event_dir);
+	}
+	closedir(pmu_dir);
+	return ret;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
+	TEST_CASE("PMU event names", pmu_event_names),
 	{	.name = NULL, }
 };
 
-- 
2.44.0.769.g3c40516874-goog


