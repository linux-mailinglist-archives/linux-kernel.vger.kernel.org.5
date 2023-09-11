Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0E79BB72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbjIKUvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbjIKRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267A127
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b50b45481so40098027b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451966; x=1695056766; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+1JF0nXPGoS/vVdsOZGIJs7CEBRG2VuSy9rJAtNprY=;
        b=5BE5OcUUXBss0ejL7AyeJWL0MVOiaWhzHM7YmpFVYa7AUDz/z26MI4nTsRql0+s5gx
         NmKvOyRNZc1KrLdWGpIxSKEawR2SLmZ+nCL014P9ikwZ78f3LN+PUudDS/hcz9op0EJy
         bBMWTDpVqmkdLkDmWwr7MK/CA7eXeg33zQaaimfrqdlPxs951euiwm9ByI0MMGnPekSa
         TVv84rz9pIQHh+v701zV153HB5a5Fpcsy2MDxLcO1EvrBQWJbHNYWtMOUslXGgD6c20b
         Dyygp2aZGAAMVddit4/ZSIaOIgN8tmT0uVbWvY5Cj8XXGs1tuOUb94UEPiUwzb5Nj2Hc
         WlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451966; x=1695056766;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+1JF0nXPGoS/vVdsOZGIJs7CEBRG2VuSy9rJAtNprY=;
        b=vvb18qpiY8gWhumDMHFGliPCZo1xQP3hNufDOzUQES27n5rqdIL+xJbZ8n4N026Mz/
         NDlo3LYkWuxwRAtAUfeH57JdgTqO9OuGdoeKkVG3HNbQYtNFEO/3Pwo46sbKd4skqWGE
         bs+6zQWzE/nRPxAWalzqp76/tssD9wlQlEMgfNdn4WkxEPJ6T/rmWTzSS2+xI1KBHtim
         twXIeeWRR58SNsBBBCnSK7G6wASniT00/bP/xbm8cDSkNnPo2EbcO9aX9YRhuTqqK4eC
         Crusie0vsnS+y+tLsWVJL0S0jC8JrWlPkt3OJZQjLO2QNFILif5tadbk6Za2GL4eZwOS
         JzkQ==
X-Gm-Message-State: AOJu0YxVNAFNU6UCxQ4PmNkG8Y5Bsu0fdb7gpqdkgruA4TdnFkyJ33HS
        mgoBp5gIQSnG4bYtGDPoANu6nXCE5AFx
X-Google-Smtp-Source: AGHT+IEYi4t5k8LUPrFyZM7IByX5LTESJDfzfvk31cVZDMoClizybOgg9g6ptBh8r+jVlC5Vjlvh5W/Wtdhm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a81:d441:0:b0:584:3d8f:a425 with SMTP id
 g1-20020a81d441000000b005843d8fa425mr276417ywl.10.1694451966387; Mon, 11 Sep
 2023 10:06:06 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:55 -0700
Message-Id: <20230911170559.4037734-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 1/5] perf parse-events: Remove unused header files
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
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fnmatch header is now used in the PMU matching logic in pmu.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 21bfe7e0d944..ef03728b7ea3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -9,11 +9,8 @@
 #define YYDEBUG 1
 
 #include <errno.h>
-#include <fnmatch.h>
-#include <stdio.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/zalloc.h>
 #include "pmu.h"
 #include "pmus.h"
 #include "evsel.h"
-- 
2.42.0.283.g2d96d420d3-goog

