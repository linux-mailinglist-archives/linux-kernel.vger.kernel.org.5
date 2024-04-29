Return-Path: <linux-kernel+bounces-162993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CBD8B6316
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB3D283970
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956DC142918;
	Mon, 29 Apr 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyCg1iCF"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F6146A6C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420974; cv=none; b=Ygs3wdRihx8WZYCH15/iC0YLcxYbp7zo5SgbG6Cowf2aj3MuLnXIxVzLULIFk7bjKZKcfkDObTBzMkgjKnBCcqjMR1g1GGMJr9UH7iqkb3CHNMb/3J5PheOICapOd1Te5BjUv/UjoX+Grcr1i+dqNtyI/S0hIGsMZbDbWl4U6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420974; c=relaxed/simple;
	bh=Unxtsgv9pMjovJEC2q3+izNqU1jvDayjR6yTMLvqpEc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=moXajjcXs9n8rOTtf4PxYt7sa4ptDoAlPd3734yCWCWLjwqfYSddTPWppcOoHvaDlTprTmFqplgY+lFaylB6Ci8EcPZnJQtv2erh6Umiz4UiFlzKcgsF1a7klalFOJzBx3tRwv29O/ygd2mZVeLRpYqNL9G5WNxtxNBq1oVdqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyCg1iCF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f9ca09so859037b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420972; x=1715025772; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNfu8Xy7Q56dzltFDRS+tQNs0guv+YCXtYt4P68p4eQ=;
        b=jyCg1iCFJC+rXZABCEfXaVW54lDhrlfHLxgtPNayFNAElh35jD4CicQSUVjvwxxwl4
         7Nbnf+OuApgqu5OOKhG6tofS9aQzeCunz6LtIKf6Ax5tMcND6u3Fod7WWakMrRqEPVL4
         JxDSneHO6ag2Od98jzvwC+SYt+Ho9DJihTnOBSckGcN4lMf1Aw1WcV6u4jx9nCynECqB
         t8eQ1R7YI5ck6oqijst4wG7mJYk0seEqLMuBlDojwq72OiAoWx9iinCibGhocNH1FvpN
         m8jmFj2ap3Hs/zCPcWoG7+acebLS0NzZSDmkq/c27moeDWXkKz6D7IyfbNmbCSZ3sOLo
         r4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420972; x=1715025772;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNfu8Xy7Q56dzltFDRS+tQNs0guv+YCXtYt4P68p4eQ=;
        b=Kyb/V1fDVMCUCz7JQn8UG+7OV+mr26RO3tVAm/zkM2NcpMD6zG1bgDeuEfo4FGI16F
         8/Iu987AZBMmN9yhSaf2N1obf47jgzvlIiqBViprg0RnOlY/s5j6e4zbonWxJu/M82C3
         dXBGVTKNsHMgrpLUVTdQo1VJFTS6iRXiTKjYxkJs65WYe2PDO25y9aemmafn8VCc4ZRV
         1fpIZ7Cl1ubLN6NyGe0lC6KOks4EoAUNpAHDfRbe8ViiHbRT0/2aueR/9DOU+ZOJpeMl
         MvgNR5doDw6K25UPNF5isNMqGV7ZwsB9zfUDIf+i+DcDR0626UiEpvWMSyN4KNDB29+z
         z8qw==
X-Forwarded-Encrypted: i=1; AJvYcCV8B0kALuFhwBdieHIRkDnw3aSRSoo6oqOxl3TkU6NdNTMim0M55jQaTU8tpJc+m9SRNuXO44fE2KQKsBIQ+nxJdI3GTBQUJFugBlY3
X-Gm-Message-State: AOJu0YzR7jT8O7+rzE02oFMjVbURZKQUv3JzzorGw1EsAWipQG27esi7
	+sJKbsp4IQnz9WFbSlPhDhYBex9lL0lqblkh7Hc7nBt05HkHLJe4xchIzxniUiZpktMqph087bZ
	9kD5AJg==
X-Google-Smtp-Source: AGHT+IGsVhZGsNjKtERvwq/fiWI1kJ9TCPCN8BzaO5p7q3MXouSFdqmTCi5SbWmF4ilVx8kgfLeJYQulq5YF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a0d:dd81:0:b0:618:9007:a15d with SMTP id
 g123-20020a0ddd81000000b006189007a15dmr3201802ywe.9.1714420972132; Mon, 29
 Apr 2024 13:02:52 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:25 -0700
In-Reply-To: <20240429200225.1271876-1-irogers@google.com>
Message-Id: <20240429200225.1271876-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429200225.1271876-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 6/6] perf pmu: Assume sysfs events are always the same case
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

Perf event names aren't case sensitive. For sysfs events the entire
directory of events is read then iterated comparing names in a case
insensitive way, most often to see if an event is present.

Consider:
$ perf stat -e inst_retired.any true

The event inst_retired.any may be present in any PMU, so every PMU's
sysfs events are loaded and then searched with strcasecmp to see if
any match. This event is only present on the cpu PMU as a json event
so a lot of events were loaded from sysfs unnecessarily just to prove
an event didn't exist there.

This change avoids loading all the events by assuming sysfs event
names are always either lower or uppercase. It uses file exists and
only loads the events when the desired event is present.

For the example above, the number of openat calls measured by perf
trace on a tigerlake laptop goes from 325 down to 255. The reduction
will be larger for machines with many PMUs, particularly replicated
uncore PMUs.

Ensure pmu_aliases_parse is called before all uses of the aliases
list, but remove some "pmu->sysfs_aliases_loaded" tests as they are
now part of the function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7849be4bfea1..7275076e6d83 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -425,9 +425,30 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 
-	if (load && !pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
+	if (load && !pmu->sysfs_aliases_loaded) {
+		bool has_sysfs_event;
+		char event_file_name[FILENAME_MAX + 8];
 
+		/*
+		 * Test if alias/event 'name' exists in the PMU's sysfs/events
+		 * directory. If not skip parsing the sysfs aliases. Syfs event
+		 * name must be all lower or all upper case.
+		 */
+		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
+		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+			event_file_name[i] = tolower(event_file_name[i]);
+
+		has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+		if (!has_sysfs_event) {
+			for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+				event_file_name[i] = toupper(event_file_name[i]);
+
+			has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+		}
+		if (has_sysfs_event)
+			pmu_aliases_parse(pmu);
+
+	}
 	list_for_each_entry(alias, &pmu->aliases, list) {
 		if (!strcasecmp(alias->name, name))
 			return alias;
@@ -1717,9 +1738,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
-	if (!pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
-
+	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases;
 
 	if (pmu->cpu_aliases_added)
@@ -1778,6 +1797,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct strbuf sb;
 
 	strbuf_init(&sb, /*hint=*/ 0);
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
@@ -2193,6 +2213,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		struct perf_event_attr attr = {.config = 0,};
-- 
2.44.0.769.g3c40516874-goog


