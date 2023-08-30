Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483578E011
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbjH3TIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbjH3HIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:08:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82EA95
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:07:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d780a0d3cefso6188636276.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693379279; x=1693984079; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5NaHsU6gXgFOenHk7MfqZGVTVXuRwf+WJ70Gj+1DurU=;
        b=6/GxsNd9Kywu8N8XjZIO0gtCnLdeXgprY6VCHDrGvNdNtgmQWcqKTR+ASayOySQdea
         oBuJMJ0bS8QA18CQxHCZuERQQQQTUoRXf4QY9jedpUkKPTXNsSsEmh0nYtpN6CihA2x7
         7kMZwLwOc6AMLS8MOuxrhPupvQDVMbQOV3uOtfQntIvadA20eEHV1a4ncqemahlUoVKf
         KJZfb+dWMC1ProTCP+xXsqpUHwq7upPdAhJL5FZrhstZ486VOWSB4MZ2TvMP6TGG5LGL
         6nxwg9L455g7bJv8sTozqXuIxGezChegJOoEztWFkxvv42t20X7xV6+wdW3LiT6zdI7T
         9liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379279; x=1693984079;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NaHsU6gXgFOenHk7MfqZGVTVXuRwf+WJ70Gj+1DurU=;
        b=SafuYpFgBWzaCUFmJnqVLLxOzut/AA9A2xBbMTV+iaJRxkzjacsvpvXxF+SoGFBJWY
         dPob1QCdlhObpvH/pyOANWDrGi84ylQMNa+QFOp5gPvboZxnbcfLZWPsBUSddxiYiGFx
         elQzL73j3mEuAg+qSCuBihzyFmW7njLLCh4F6XP5pl/t4YZDzMnntsdKr5t2cXJlfqhF
         eIrXcVQ+5WyQwmjqsDemyMkWSxFI0AAAw0vYq3wBtMtASa93+NdFj6IkIbnqyK/H2KGn
         uv+2sbycp3EJmd/hBaLmTB37ywPY1B+RxlL7YX/OHSlkoVK9sGjqFpvJ30MNUXFCsRKN
         lSrQ==
X-Gm-Message-State: AOJu0YzEAgr3vnzFykHLYreWwC0v4mio5B0nWBeO7OnBypQrm1gg+WGF
        SWRsGhajBrCnrv8BJRnjmbQZXz3mYGs9
X-Google-Smtp-Source: AGHT+IEsqhzZVskXpYnOT+qq+VkLTum6nBgxwvZomGfzTOhPcyfHGK9ecuI2vCBSfox/qM2B17EZrYy6QlAq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a25:d0e:0:b0:d63:8364:328 with SMTP id
 14-20020a250d0e000000b00d6383640328mr35188ybn.5.1693379278979; Wed, 30 Aug
 2023 00:07:58 -0700 (PDT)
Date:   Wed, 30 Aug 2023 00:07:51 -0700
Message-Id: <20230830070753.1821629-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 1/3] perf parse-events: Minor help message improvements
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be more specific and fix a typo.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 3a9d4e2513b5..4a370c36a0d5 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -342,7 +342,7 @@ PE_NAME opt_pmu_config
 			struct parse_events_error *error = parse_state->error;
 			char *help;
 
-			if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+			if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", $1) < 0)
 				help = NULL;
 			parse_events_error__handle(error, @1.first_column,
 						   strdup("Bad event or PMU"),
@@ -368,7 +368,7 @@ PE_NAME sep_dc
 		struct parse_events_error *error = parse_state->error;
 		char *help;
 
-		if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+		if (asprintf(&help, "Unable to find event on a PMU of '%s'", $1) < 0)
 			help = NULL;
 		parse_events_error__handle(error, @1.first_column, strdup("Bad event name"), help);
 		free($1);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

