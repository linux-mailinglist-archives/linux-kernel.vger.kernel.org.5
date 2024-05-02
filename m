Return-Path: <linux-kernel+bounces-165956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078D8B93C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CAEB22D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F1250F8;
	Thu,  2 May 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pbg8y/w1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C421350
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622507; cv=none; b=DTUaigLAtsksqhnI3YrPnv18/W6bR5ZuCkzYC3wP+eWbFbO6yzjqTkc5ErmZEkVdiCHDbxukJ5/tX82J6XzE20wY2vkh3lS1YDZHopxAY0zD8ZwVzboXdfB3lb0x3pmE7mT5qAa4acRx0gMztBbfVTGt9yIUlpScEAspL97ncxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622507; c=relaxed/simple;
	bh=LoJaLXnrm+cg8gCQVbKrK6hyShTPLrxvjEHVqlnkjD4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=kr1/6k3/ZfS5EgLiMb7FV21a/dRepTPcwF5fcZwqOj4clglwTcQq8ItZgd89JgKGroAk20DawSj/rzw/YTFXXNqWItcoGVx2Ae/LqdqzWLKz/gYkDra/nz3NZgony+WEtH7HYlWRPJFNAmc8rcA+Dw9YNVXT1DYWXj4UTgIDeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pbg8y/w1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be26af113so57770647b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 21:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622505; x=1715227305; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/IDkFm8YQdijjzsBD7Gmtx7FjqcThxAwNDMqnP0dcc=;
        b=Pbg8y/w1NbWBRnrNdLzSHe+8ev5OFroRA2HhlerOQE87xcqN+Nhf7hRUn8Ch1a9Rjn
         Js6tEGHPCvFjram0B1YhozGZ/P3IqTa29iACJ4jT4GibRYaQG2UqAmxLjzRCC80ApjGH
         DdjkzKZ+WW4ZnHadak2AWVTgx6euE3Bl56mbYPTRnAvYUUuHAN1uLV4dxsq433zhIUju
         o934dIFrjaXCrZpJQkvsirl6lLAP6AP+VUZbTQCnPvXca+pR4EqpPxBUgxPOiTgGGYY/
         5qvzxU+nBfU9rxtLRZcDGFwLSYpD3/MTU4ZphFRPcDvQK8PUKHZokyHUxwiU9hcJuBhT
         aLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622505; x=1715227305;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/IDkFm8YQdijjzsBD7Gmtx7FjqcThxAwNDMqnP0dcc=;
        b=wAFJULppgPdu/45KJvJaEfP99JExo1DkICecE3nr9vFVfwz5AJdi6AYf2Q4EbBOcpS
         ABypeRIDSjYwKfI0PlKnIL35HdpGymi0ANAG/Hhsabr5QxhGGSPazdHOw/sssDeW+/F1
         ZpwEuporYA4/TV67fPyyoBOukrsFHrygVN2J0gnF8ClQ2MnBeoRaxQCvRGObPwjWgJG/
         6sPBfG1P9OOKD3Wp2QvshGYX/xyUd4a61zXgHXK0sdBNwut2fvtoEui6ZH1wl8aXzxIe
         XL7XXTXGUVw/M/geaDMnCQp19evDXx9Ow1FTNsFafJ3GFZIEdT+3R2OrJkl7ea00fDWS
         Uz1A==
X-Forwarded-Encrypted: i=1; AJvYcCWHwPFNNTbbXiYHIerSpdJnGRQokGmv7erNfuQlBqTprayRcNPka/3Vpsi39Z55IKc/PuPNw2P/sd4VQZdRy9w3bUYLyBfXLuCo6fue
X-Gm-Message-State: AOJu0YwDbplJWJUBzmFvGNb8Nn0o7YZEtzy6A4vtlxr0ZivIPCVEnRkw
	eeF7z/6ztSJ/BRcLvs0SKlYC/dvSfnXMT+apbihE3T4yoVJiqAVQ/wKxiQLLpSaX6WqpqY/QpIJ
	/uzT1yw==
X-Google-Smtp-Source: AGHT+IG9tEfOjT0Eqpu9vPzzzQYNyox7AbGmb0IH8fHWMXswZ+Y7bTVgg5flv7C0k5tYmnCX3kAUVqz3wCb6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a05:690c:b1b:b0:611:2c40:e8d0 with SMTP id
 cj27-20020a05690c0b1b00b006112c40e8d0mr1109843ywb.3.1714622504797; Wed, 01
 May 2024 21:01:44 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:12 -0700
In-Reply-To: <20240502040112.2111157-1-irogers@google.com>
Message-Id: <20240502040112.2111157-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502040112.2111157-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 6/6] perf pmu: Assume sysfs events are always the same case
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
index 7849be4bfea1..b3b072feef02 100644
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
+		 * directory. If not skip parsing the sysfs aliases. Sysfs event
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
2.45.0.rc0.197.gbae5840b3b-goog


