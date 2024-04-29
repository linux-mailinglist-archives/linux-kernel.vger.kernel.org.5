Return-Path: <linux-kernel+bounces-162992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A548B6315
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62BE284B41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E6146A7D;
	Mon, 29 Apr 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEPD+lg1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14E14534F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420972; cv=none; b=H6Rt/mc8wexJiSuneyylNutT5FNU8UXSstQBes6DL4SnOzZgZpz07Hx4rx2Bm6ddll1qNcSZCupwNDpVp9lr2DgeXdaTBRCIjE0q8vaqIRzc/cpOV+2RJzIc1vb2gGqpXfPWCB1hzx9ctukli11bltOci/ZK69UgkPY+9Wnib5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420972; c=relaxed/simple;
	bh=i7OIixObrBK6wLYTL3j3asD5BAu4/Nn0mVDSiF2+fSc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=FnHsJ5BYyrecNw0A/Q5jBpqVgvbcMgU+F0GpS33cuADX18nuav6vwTA732d3/tTPoxFmCNOo121be2lJ99EgWU/BNVY82w72h3gGDvh2RIr1vPMOIiBOqWkadwQfk6kYEmsTvtm6T3Jv3j63wazfXp/bsT6rAMFRcJEVt7ruIBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEPD+lg1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so9610377276.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420970; x=1715025770; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ST8QMxONeyaCSSADxQ7gE/hk81EFR0HpWu5Q0a0nK/c=;
        b=yEPD+lg1F8kAXPEHKQXsDxPiGfRIUfBtyRYk6hB4/RNhsCLah894gvZkIoGHTcKFne
         HMDKe0afvrfPxOlXy+6WyHaQyv9WiVUpe3n6m9crGN2qrs+UDZakugsQlfRl3JZQFITT
         RRiputSmbYhlJmBXDrrE6o00j+oP1EUNkTRU+LWH4riYVnDqPS5viKUeZwpNn75BgBbP
         GX7vGYRkpG/5nAij/4bsMSp2vY/QEY3Zlfk4CyLKTwTNznWRvTupyKYxwxEKkOEHP7a0
         abo7IQdD9hc56EbYiT46tTse5aIhXmZUGHspLCGKWfdtQjCHCk3J6PsXg1u1ZEvpkvAF
         Gtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420970; x=1715025770;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ST8QMxONeyaCSSADxQ7gE/hk81EFR0HpWu5Q0a0nK/c=;
        b=F8g5PSGhTyKhHiBEs7gdZCiUZFqHILdn00lvxY/4BiLLitdzPueM2a2WcTNKykp4ZC
         CfV7hb5T0mCs/IDFrPWsZR4F3bfoEhJ683e0Pov43ZSFpRrrdk9hOSjSTpERqZ2ivkii
         LQfM8xZRttHYHUdqco0pFyswvF/yZAQIJVoTgJampagCQl/2VjWREWChkcuBCsKu14sx
         cv9/Iw9m6NyyqgO7L2qinGpDFCx0RdvdZY1NPd+Cg2aUS1Urg9cALenrF9GTAtwn+ryp
         q+QCww7fhgQ4Cpte1Tb7d3TYlSVxW1LwYXAtl5viOe28sFjFP9WoViAQVVvxenH8RxXA
         1HNg==
X-Forwarded-Encrypted: i=1; AJvYcCW/AdKbuw9vde+r/iMJl7YD2gJtR4/NJdgTQzjHkqP58oIcJvCmYnRXXabFRbh151i/KBMNPOfYyvJNfHAufOqC2Aia2yJ2KT+GzZVt
X-Gm-Message-State: AOJu0YysRs/8Az93KSKtmlDyOxUoVgOC5W8TH6Wir64ls+eN4EQncaDH
	TbOhqxmRDy74XS155cACSj2vQ2n2HJDeo+drFglWu7kM/K/02jtPnkFwAkXKnbbhhwP01xTll4+
	OMGLElw==
X-Google-Smtp-Source: AGHT+IEdshl6jAfPfpA6iqxesOkw60DMf+W+01LOHg9JXbD7BDh8K4GQj/MJappVF0/dTW7wyFQ/T3jqlrO2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:18ca:b0:dcc:c57c:8873 with SMTP
 id ck10-20020a05690218ca00b00dccc57c8873mr3789929ybb.9.1714420969922; Mon, 29
 Apr 2024 13:02:49 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:24 -0700
In-Reply-To: <20240429200225.1271876-1-irogers@google.com>
Message-Id: <20240429200225.1271876-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429200225.1271876-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 5/6] perf test pmu: Test all sysfs PMU event names are the
 same case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Being either lower or upper case means event name probes can avoid
scanning the directory doing case insensitive comparisons, just the
lower or upper case version of the name can be checked for
existence. For the majority of PMUs event names are all lower case,
upper case names are present on S390.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index f4e9a39534cb..ea21b4db10e1 100644
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
@@ -241,9 +246,94 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
+static bool permitted_event_name(const char *name)
+{
+	bool has_lower = false, has_upper = false;
+
+	for (size_t i = 0; i < strlen(name); i++) {
+		char c = name[i];
+
+		if (islower(c)) {
+			if (has_upper)
+				return false;
+			has_lower = true;
+			continue;
+		}
+		if (isupper(c)) {
+			if (has_lower)
+				return false;
+			has_upper = true;
+			continue;
+		}
+		if (!isdigit(c) && c != '.' && c != '_' && c != '-')
+			return false;
+	}
+	return true;
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
+			pr_debug("Skipping as no event directory \"%s\"\n", path);
+			continue;
+		}
+		while ((event_dent = readdir(event_dir))) {
+			const char *event_name = event_dent->d_name;
+
+			if (!strcmp(event_name, ".") || !strcmp(event_name, ".."))
+				continue;
+
+			if (!permitted_event_name(event_name)) {
+				pr_err("Invalid sysfs event name: %s/%s\n",
+					pmu_dent->d_name, event_name);
+				ret = TEST_FAIL;
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


