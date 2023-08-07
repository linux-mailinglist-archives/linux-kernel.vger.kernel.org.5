Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BE771A14
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjHGGRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGGRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:17:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389331708;
        Sun,  6 Aug 2023 23:16:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc3bec2c95so26748255ad.0;
        Sun, 06 Aug 2023 23:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691389018; x=1691993818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hWSw1cLZzYS5vKRsvMKmSpxrp08yn5uIfOo+OozYAdo=;
        b=HwU9SEaatG57jdR6wuZSqJMKyUNhDfa0uP8FImIbIgZV2rai1QGi3j9lqgqcDkdgHN
         ctU0WN/y4VDsIie+cUCYuCCTSyGPldGAXIZsk5N7kNhh7JAZ0TFb4rijRhRINQaaWdO+
         9O+I99F3LbnJkPR3cW6lmNjR4bQOiYOU6gXS9Vi4Zs+cvKmn4dg/e+n9jWirWYhiVnW3
         UE0VH9a5LMHbqQuBRAbdcCAM7iuHzpbabC6C5Sszw5oCPrCB6bgIy81Ma+XnRCEzD3rF
         OeRvy02qaVQIjOUqCzTSZrrmec7AuKXpSq/IJrVDuOo28EgpYyRBPmbum1U8+NXr//HW
         gFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389018; x=1691993818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWSw1cLZzYS5vKRsvMKmSpxrp08yn5uIfOo+OozYAdo=;
        b=ZdIlux3IaLKkHCq7yDnS8naLtLVqNvuDNFoLSk0rZkfR02mUTLHzIVUEhv+RkAOX9N
         dLkqJV7oHTzE3QVx1PUKl1h1Mqem6R2fJ0AFTGZwhfeT+5wz2gc7cAiLI/FqGYESWVvl
         13sVXLudkTjZAPisoTjMT+0CoD0xMMlfsPXrmQqUvwakYu2dBqQ3ywcWAkarhxMBoCkz
         EwSex9tmR24TPCdBeRmJ6tICsIN6DMWtQmcQlemTkKSa21zpsjB8BSic1czT64sYeOlk
         mHP6UYp7Sf2D1xAkAotw0Rcom9KDNncryainjFUBKrrKY2+OP5kLaC5BbjSu5lNeSZip
         zN3g==
X-Gm-Message-State: AOJu0YyItgi2kRKnNj+WBPzW9ThxI/Yc2aNV+4wvkYfDPRiuiCXBb5Tk
        flBjZUtHpMyJvt+ByoLvWgM=
X-Google-Smtp-Source: AGHT+IHAtwij15YfOFbneacM2RiSmvEA+/32SOpKBuYhB0VQfBVDprtR6R9BICxF3cWUOvANqCHrXQ==
X-Received: by 2002:a17:903:228e:b0:1bb:d586:d29a with SMTP id b14-20020a170903228e00b001bbd586d29amr7565312plh.34.1691389017519;
        Sun, 06 Aug 2023 23:16:57 -0700 (PDT)
Received: from bangji.corp.google.com ([100.64.98.31])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001bb9b5e86b7sm5907769plb.91.2023.08.06.23.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 23:16:56 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Handle old data in PERF_RECORD_ATTR
Date:   Mon,  7 Aug 2023 15:16:52 +0900
Message-ID: <20230807061652.2492167-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PERF_RECORD_ATTR is used for a pipe mode to describe an event with
attribute and IDs.  The ID table comes after the attr and it calculate
size of the table using the total record size and the attr size.

  n_ids = (total_record_size - end_of_the_attr_field) / sizeof(u64)

This is fine for most use cases, but sometimes it saves the pipe output
in a file and then process it later.  And it becomes a problem if there
is a change in attr size between the record and report.

  $ perf record -o- > perf-pipe.data  # old version
  $ perf report -i- < perf-pipe.data  # new version

For example, if the attr size is 128 and it has 4 IDs, then it would
save them in 168 byte like below:

   8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
 128 byte: perf event attr { .size = 128, ... },
  32 byte: event IDs [] = { 1234, 1235, 1236, 1237 },

But when report later, it thinks the attr size is 136 then it only read
the last 3 entries as ID.

   8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
 136 byte: perf event attr { .size = 136, ... },
  24 byte: event IDs [] = { 1235, 1236, 1237 },  // 1234 is missing

So it should use the recorded version of the attr.  The attr has the
size field already then it should honor the size when reading data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/header.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 52fbf526fe74..f89321cbfdee 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4381,7 +4381,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
 {
-	u32 i, ids, n_ids;
+	u32 i, n_ids;
+	u64 *ids;
 	struct evsel *evsel;
 	struct evlist *evlist = *pevlist;
 
@@ -4397,9 +4398,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 
 	evlist__add(evlist, evsel);
 
-	ids = event->header.size;
-	ids -= (void *)&event->attr.id - (void *)event;
-	n_ids = ids / sizeof(u64);
+	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids = n_ids / sizeof(u64);
 	/*
 	 * We don't have the cpu and thread maps on the header, so
 	 * for allocating the perf_sample_id table we fake 1 cpu and
@@ -4408,8 +4408,9 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
+	ids = (void *)&event->attr.attr + event->attr.attr.size;
 	for (i = 0; i < n_ids; i++) {
-		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
+		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
 	}
 
 	return 0;
-- 
2.41.0.640.ga95def55d0-goog

