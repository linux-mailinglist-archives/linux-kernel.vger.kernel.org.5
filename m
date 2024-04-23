Return-Path: <linux-kernel+bounces-154448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E298B8ADC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CAFB23348
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57823749;
	Tue, 23 Apr 2024 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTUgBxaQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1B21A0D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842274; cv=none; b=svDJoZx8taFAXR8on2439eoh/ewR0cCsHWbVycKKJLYuJj7QDdiORfnXc9+DzrBUHXCvaRmJ3m12g7P6u190PYY8b1xEkBNr2tQGnHKiylcqjCtogQ4K3BOm8yCL7W8N+sh+GXwl38L17bPLJF9gNDxSKN999RzorU//WhDZcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842274; c=relaxed/simple;
	bh=SxEDWrn/lFxPOvag5N8wzuGUB1n1P7PWYBfiKXO1nAk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=d7/58ZlsX8YZsh9QZbDVgJYXSOm6hhXYwxRzP2Sv9jH6PmyCN97j5KYcytHvRDHlXLVrlyWDSk76hMwpWr/yeHpkATj8iPOUeLLoRjsMox0EWwKJTBdIN/8/44mAXSl+22goroJmidPipADHNU+Wq/hLJ4NvQMVc9co3bib9Mkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTUgBxaQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6188040f3d2so109285197b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713842272; x=1714447072; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gyJD4QoBqevKrIjKy2FdMgw5O7ztEDQh0P4WQSqqmY=;
        b=nTUgBxaQJ+/GzAN0/Xr/hHl3/ukWu8P1T/KYH494ioXAqSnZKTkU9PJHcZnSXam7aa
         ztoUzr3mnwYPzlBkxzXYmyRY8P1iYFz3p2Xll8Z8SLdHv4mXZ9Hmv+CoPzPxgSEt6euj
         rRheFRx9eRb5gNxF4H5qOsE8KIYojKY97imF0dFrfjTWaLmRY4P8uJCVSr5kr/RLleiJ
         iZgSOAUUTNX+9xkc1DUkf84Fdgy9DNDHWCxNOGWW8Yj1w67hvWoxbn6TXNUzbcSHoDII
         hd1h5unYI3ZUq5iPCKu5Sf8x+0IyaMMpO3oXkGcmPAZ1L36XhPun84m0AC7pvSqYEDRJ
         153w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842272; x=1714447072;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gyJD4QoBqevKrIjKy2FdMgw5O7ztEDQh0P4WQSqqmY=;
        b=P7skoCOTaGs0Pbk6n3mwcp8858KJOMmStubOALlyfwx3t8ZkUAiNjNvM2FwHm9ZYli
         c4Mv7qiZ7KCSCW/J1Jrrqv/gundoibQDDH1GoJ3Je0GXeReXo8MEpX019YpfSZ1zev2i
         wm4vGSjmso6AzTmw6DfmdeIdesGwPsYpc0uvoU9bAcSKj9xR/A3HMvaKnB4SY5TQurng
         b+KzUxoOk+K1a7q44s+g1ISYdSg4K+mBxFhr5FeFgsA3m6Td3hEX1QMy8BI0KT5OMPZt
         3BTZtr/xiMNSqD/6x0TxHq32TkyGefMwJ6SmfC4eCU+2BjPRQWyzs217v2QlVR+7lcP9
         hbSw==
X-Forwarded-Encrypted: i=1; AJvYcCWIbvQSPPosJdgF+k3V3TVqU6+kevtD+l94JAdAnZlyHoO9R/3KE+UOmQGLfLQ03JBFzUslQNTzcNMBcc956eRQs0uhwsmIydv0wcC9
X-Gm-Message-State: AOJu0YzXam2xMX5kpMhIazh5BfseivtA0t71EC1/94rOGm5zsTYoXDLq
	yjRIvDc/nuQWH2TJzLxQlajVocKASNiiHHjk6bfzJZlf/SHgxEp7Nf8keHO8WjAChjxrtcm9W46
	CQFvKcQ==
X-Google-Smtp-Source: AGHT+IHuIv06zsnCVJVN7pSt2E/XMUWzJTdljzRqLpOgrm3bi86g9DMQm+s3UK3S1GujsuF4MIsvc2q2G11B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a0d:efc1:0:b0:615:e53:1c1 with SMTP id
 y184-20020a0defc1000000b006150e5301c1mr3040732ywe.7.1713842271767; Mon, 22
 Apr 2024 20:17:51 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:17:19 -0700
In-Reply-To: <20240423031719.1941141-1-irogers@google.com>
Message-Id: <20240423031719.1941141-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v2 6/6] perf pmu: Assume sysfs events are always lowercase
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
names are always lowercase. It then uses file exists and only loads
the events when the desired event is present.

For the example above, the number of openat calls measured by perf
trace on a tigerlake laptop goes from 325 down to 255. The reduction
will be larger for machines with many PMUs, particularly replicated
uncore PMUs.

Ensure pmu_aliases_parse is called before all uses of the aliases
list, but remove some "pmu->sysfs_aliases_loaded" tests as they are
now part of the function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 40f3b5bd8260..88ce0aae2764 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -425,9 +425,16 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 
-	if (load && !pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
+	if (load && !pmu->sysfs_aliases_loaded) {
+		char event_file_name[FILENAME_MAX + 8];
 
+		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
+		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+			event_file_name[i] = tolower(event_file_name[i]);
+
+		if (perf_pmu__file_exists(pmu, event_file_name))
+			pmu_aliases_parse(pmu);
+	}
 	list_for_each_entry(alias, &pmu->aliases, list) {
 		if (!strcasecmp(alias->name, name))
 			return alias;
@@ -1717,9 +1724,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
-	if (!pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
-
+	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases;
 
 	if (pmu->cpu_aliases_added)
@@ -1778,6 +1783,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct strbuf sb;
 
 	strbuf_init(&sb, /*hint=*/ 0);
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
@@ -2182,6 +2188,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		struct perf_event_attr attr = {.config = 0,};
-- 
2.44.0.769.g3c40516874-goog


