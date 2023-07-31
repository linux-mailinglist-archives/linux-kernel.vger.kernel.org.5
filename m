Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B7769247
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjGaJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGaJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:50:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F8F19B0;
        Mon, 31 Jul 2023 02:49:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686efa1804eso2988056b3a.3;
        Mon, 31 Jul 2023 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690796980; x=1691401780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NVTfBN5N9lCiJFglea9HccCPavQm9AmSWqbL+0BDsu8=;
        b=SZ5yC6WE9LxSRAcxOxJT8x45C7+LJ4saf6KPzt8jTuIx9bxWK2FyxtaboxNway8jfB
         cnJDOSprxQOy/1+88C0yQS5At9EpKGKmxIaBKRb/YvhISFRnjk9gkgtFAWRzb1tNGPns
         8HmpI/2YrMIJDtNnf6Kw7PcboQK+1uayVqTCkYl1Yd2qNGDhGqzvwTttziUV2jGPCZjx
         IQx8NCFs5yqMUdH6s/OkDcTdcitf3raYPR2FN3M8XjrvYbZV0k6yA5IwzJOSTh9krSVC
         ZM3QRPVmyOPagpHs7k88p1KtvRO27S/oJWh8TZtXah/RjoiTgUzNTpiDK0kCZ7/YP9p2
         EOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796980; x=1691401780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVTfBN5N9lCiJFglea9HccCPavQm9AmSWqbL+0BDsu8=;
        b=lzFGxXvs/iOXKpJzRMbojoMbBTrosCb2bpfx1Nmep+JXp1xTNPiyiAkqu0IAkLWuX5
         CrE7xK04wDsEYQBI7Bj1ih8cH5DH1RZw3L7QE/6yAFgWj8Cd0m4PzCbeLTJIigDRfiTZ
         OSQ2jFpNjvyfLP4PAPIrPpKKhST2deLOwiWUJhZz3UmwUmm8LgR+k9KauoxLKxqg5XRS
         QaDhMcof8LmXvssiM9jI3zRDWDyWtLhLdh8/CIDOZaq7OgIxzsAZHkPzLIT+n36G0Anc
         oSp4ozdzEVGaOYQXmAAzaI831QiTrYAqK6XwdxC3lI/ApdQZac85zglfU8fMkgITqOyy
         19uA==
X-Gm-Message-State: ABy/qLbH4w6Nm/420ZTDOixqz1RIW6/HwA2bKonKsFvrzS+9ftjNUtcg
        fPydZZa+hWg1S5++oQTEzjc=
X-Google-Smtp-Source: APBJJlEBfoCU0leQatKwiPNbEyjBgQarWXa+XcwWMccpedf6MAf+Rs4L5qPoFF5mRt0qpOhF92CmBw==
X-Received: by 2002:a05:6a21:329e:b0:13d:df16:cf29 with SMTP id yt30-20020a056a21329e00b0013ddf16cf29mr2138744pzb.15.1690796980158;
        Mon, 31 Jul 2023 02:49:40 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([117.111.1.150])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001bbd1562e75sm8117852plb.55.2023.07.31.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:49:39 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/2] perf hists browser: Fix hierarchy mode header
Date:   Mon, 31 Jul 2023 02:49:32 -0700
Message-ID: <20230731094934.1616495-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit ef9ff6017e3c4 ("perf ui browser: Move the extra title lines
from the hists browser") introduced ui_browser__gotorc_title() to help
moving non-title lines easily.  But it missed to update the title for
the hierarchy mode so it won't print the header line on TUI at all.

  $ perf report --hierarchy

Fixes: ef9ff6017e3c4 ("perf ui browser: Move the extra title lines from the hists browser")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c7ad9e003080..d8b88f10a48d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1779,7 +1779,7 @@ static void hists_browser__hierarchy_headers(struct hist_browser *browser)
 	hists_browser__scnprintf_hierarchy_headers(browser, headers,
 						   sizeof(headers));
 
-	ui_browser__gotorc(&browser->b, 0, 0);
+	ui_browser__gotorc_title(&browser->b, 0, 0);
 	ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
 	ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
 }
-- 
2.41.0.487.g6d72f3e995-goog

