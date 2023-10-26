Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A4D7D7985
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJZAcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjJZAcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE21AD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso256526276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280350; x=1698885150; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4P4Ckt7g7gTNX776QqcLXSzZoxp2WVgO5XwUIxwuv+A=;
        b=e1CGX+InIxqWtJDL5/FvJy3A5HP3RtrZA52tNmZ86kZtxOkwzO276YSlmdll3pL5Dx
         +kiKGR54W/BHV0uTOpv/q27zMN9TOD0zRmscnue+GpmJE3l/3Im2h5MXvbGtEPRA3VVh
         25+TC9Rw9atFTLOLRiUG6E9E399F6vwAeACJjv2TYzTOLJPpF9Ok+KdS93p9lNW4l2ZI
         kwsSjEIhkCOfeLi3jRAgUSZT4smqmAM3iW+HergEnCEvPCEofRlV0V4pxKw+q2aFUMj+
         /PtUmF7jLSaNXACFmLV/haPBqknxyWRxOJHhqQzJlVdhQy8CQofWikHdo6tdS0qrD6nV
         +OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280350; x=1698885150;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4P4Ckt7g7gTNX776QqcLXSzZoxp2WVgO5XwUIxwuv+A=;
        b=sAIZytocRXkxEKE5sl+knsC+JhOe/GeqdV5kS9u4w/xJv7bolNHT6iZsw3JuE3weeB
         MQMhPCpOfoFV+TA1JM85sIYAQbbSYObLVgwuj5LecDyn/aVkWSi1aLLon1nMOANnKMwv
         DE9imdPKTA4GDfPDSDeZ2F7wh775o24fiALs4/mBq5ByR/fa5FRcVcUHOpfCF4Sgk+j/
         gsMDNJ7j/Fm9Fj+MOujteuNVmvdv8b8GQzoXTEW1EzQQQ7PtjqyLjeIHYCDj5TtgSYy+
         BkAAfMf0BfHpqqtEKw+qzW0NJaJ01tbCuHHA7Spvw+Y/H1EhNNLmDgSvt5/ISGQbS77X
         Fs5Q==
X-Gm-Message-State: AOJu0Yx2/PlZ6DQ0KDkqTHVhwO2mYkLYhJiklISYGmN3MuyGzXiRew4u
        +CTrJLvaZyhW0+L9K8a4JHA45A+SyosP
X-Google-Smtp-Source: AGHT+IEKM2WBSyG+hlRtFEqZP5bsLUwbk8vBV8YiICaKGHobmwXo31vK4KGKqNtEuib+kL0Rv4H42EEPc1qi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:297:0:b0:d9a:4c45:cfd0 with SMTP id
 145-20020a250297000000b00d9a4c45cfd0mr297919ybc.2.1698280350215; Wed, 25 Oct
 2023 17:32:30 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:47 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-7-irogers@google.com>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 7/9] perf vendor events intel: Update westmereex events to v4
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
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

Update westmereex events from v3 to v4 fixing a spelling issue.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv              | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5b455739065b..0dee3de3187c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -35,7 +35,7 @@ GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.13,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
-GenuineIntel-6-2F,v3,westmereex,core
+GenuineIntel-6-2F,v4,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
index 1c61d18a4b5f..026236558d05 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
@@ -45,7 +45,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "BriefDescription": "Early Branch Prediction Unit clears",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
         "SampleAfterValue": "2000000",
-- 
2.42.0.758.gaed0368e0e-goog

