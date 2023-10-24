Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAE7D5E10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjJXWZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344525AbjJXWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7163410E2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3a38b96cso5573853276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186282; x=1698791082; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a57oV/e0Ni3jLZTf3mm6h3wI1Kphc9bMaGQTthj78GI=;
        b=lAtV+NBSe+UpA5Rr+Qd3pgNNsrTd3pDBkC2VnSTgUeHV+/WWSNMzgqe+hFljO5X3Xe
         OW+vvhGQnJNm4LaVzIjI7Mlg1SDO/g6gUfX4HKCffk2z6HJ+26ZvARpkL3E+8ZHfEiRQ
         p4rx+J3d+OOBZnyPb4c6C1dmCCQInCcRR5niZhlW3zmENUqwYtFwfHrtPghdVmE5ViZD
         /OYXinPQu9CTdOApQBa9RBJx97eEE4TJiizBdQRj7eIwZO2UHpilM+OauJBRMUvxVxYt
         oeej7fuVOb+dKVoIcE/v1jPDbO8BUU2XBfNY5t1J5vouR/+WumYlOvgYAyAYc4ztMILH
         0YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186282; x=1698791082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a57oV/e0Ni3jLZTf3mm6h3wI1Kphc9bMaGQTthj78GI=;
        b=Sm/ze2VOKNreCitf6wm1C8M8YpRpE7m3vhjxNN9qUbMASVbVCFo8wAj76kfUlNbHQE
         RGH0oWqA08IykJXnqv5Ji2teZeyTYdcLEVpy74rABjxJCd+4K+W9ZeLJwJDJodznh3fh
         SmVDNbKP86ZIUwOTWuYaWI5lqnkLHtSr7UF8LDFiWX4DqfNuoKjiUkz+zusA2T/h4dO8
         SKk4bWhCw88SM6jfyQ4D5JKG5jSzqaVO/iTDDnj/pR8u1t+cKM7+1RUN5xgBSS91ZsNw
         IKsN+MgBzvX2c2Rt+Ik6h2JVA1s3Z0tEsJ1krKlgpjlsPVzMgLGHhXb3wD8jSbowoiaB
         mYZQ==
X-Gm-Message-State: AOJu0YyHCm3FHO+ELtflow5uCYGShwaP9IHntBJO2EEOLm5w1hX++GwP
        qEEJxPFJ/YkuIWVgLLkxH+iyhMzZRrKU
X-Google-Smtp-Source: AGHT+IEPkOL25RHk8bVRtyjdwz3hrjdxp1tqKTyWX0JQPAMbJoqhJ5b/EnMNMB5cIk3AOTLJjQOWC+0bE/sd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:4f4c:961b with SMTP
 id v3-20020a056902108300b00d9a4f4c961bmr353600ybu.1.1698186282072; Tue, 24
 Oct 2023 15:24:42 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:16 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-14-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 13/50] libperf: Lazily allocate mmap event copy
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event copy in the mmap is used to have storage to a read
event. Not all users of mmaps read the events, such as perf record, so
switch the allocation to being on first read rather than being
embedded within the perf_mmap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/mmap.h | 2 +-
 tools/lib/perf/mmap.c                  | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5a062af8e9d8..b11aaf5ed645 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -33,7 +33,7 @@ struct perf_mmap {
 	bool			 overwrite;
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
-	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void			*event_copy;
 	struct perf_mmap	*next;
 };
 
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 2184814b37dd..91ae46aac378 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	free(map->event_copy);
+	map->event_copy = NULL;
 	if (map && map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
+			if (!dst) {
+				dst = malloc(PERF_SAMPLE_MAX_SIZE);
+				if (!dst)
+					return NULL;
+				map->event_copy = dst;
+			}
+
 			do {
 				cpy = min(map->mask + 1 - (offset & map->mask), len);
 				memcpy(dst, &data[offset & map->mask], cpy);
-- 
2.42.0.758.gaed0368e0e-goog

