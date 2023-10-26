Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F57D797F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjJZAcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjJZAcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F5181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b10c488cso3282207b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280338; x=1698885138; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0o2QGOYpWvrS5QomD5183Br64G7wtY83rPo3ufwL6Y=;
        b=EMgWPyDdsFImZKMCvlR0ypPHjvkhDSzD5NY051EvmC3AWUGU7Q3W3vVKvBM9y+NoIe
         bK3QOyA25F0YMc7LvmUqAMpPFOwVodX6RgoNZwFScaZPUAawyYF39eQ6KfRbEyz9JnlM
         WAKFBhXAZSNzbkdY4b2KhPNAlRr4UA6N1KVd2zNdKDg2aIC4B2eHAkpPfvDS4epA6+r/
         b4OwOslqFxkLmw/ItH/Iw8NOUnLJ32g0Vf2gDxDOnJGhBMI7D+OlsJdYT50ZDtMnV14p
         EseS2OfB2vTAzCBiCg/WzWWlDmgy4lGagfhcel6Dm/SDck5kO/Lomr5r2dBqCBtcuZoh
         yAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280338; x=1698885138;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0o2QGOYpWvrS5QomD5183Br64G7wtY83rPo3ufwL6Y=;
        b=cNVu/U9Rky3fbfnLwVHmD9L0qhBOmBHC7SX1xWLDJuSHy6iTRY54BIxCM/bGLkeO8n
         J4pn9eW+BfbZtEf9VkK6aO0YIVa+7ZyBQDzvWi5Xfn91NHSU8bv9AnYI/RnSzJcX82OV
         l/Xz1ak13Zlzd5RP3NHMU1MLrfrxwhjZeZN8xX/mjb/vdyQ1lt3KWgaLBDf77nG56BEq
         vKMME34vYVCH/Jt594Zx7ZYNEci4PZ4n+zNOwNbRTY/VXYw0MbabvX/ffrjGc6i90hex
         7j1ck54ajYaDwoT1geQUPc3rd2IvR7+1kzslBXPQ9SPyJer9uhiFZxMBD4mFxJfV2mKj
         qARQ==
X-Gm-Message-State: AOJu0Yxl8v5Vt1fGAMZKnA3QVf6PdqV5joaLa8hKtoNPB7slFgDutd7Q
        3qsEnRbcCqYzonJQjRMMDWeM9hebsCVE
X-Google-Smtp-Source: AGHT+IF1cwrsEyzuVS9KZU+3VmcSVvsCXZpcsJTz4G8EDpFMEYvpmszDn2wC5rVGmu3CjzSDWsbhcuhkA7wv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:e753:0:b0:da0:491a:c242 with SMTP id
 e80-20020a25e753000000b00da0491ac242mr111017ybh.7.1698280338663; Wed, 25 Oct
 2023 17:32:18 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:42 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-2-irogers@google.com>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 2/9] perf vendor events intel: Update emeraldrapids to v1.01
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

Update emeraldrapids to v1.01 from v1.00 adding the changes from:
https://github.com/intel/perfmon/commit/3993b600e032a9fd443ffd828aab73de7cb167e5

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/uncore-cache.json  | 36 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
index cf6fa70f37c1..bf5a511b99d1 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
@@ -3448,6 +3448,15 @@
         "UMask": "0x10c8168201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8168201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts for DRds issued by IA Cores targeting DDR Mem that Missed the LLC",
         "EventCode": "0x35",
@@ -3838,6 +3847,15 @@
         "UMask": "0x10c8068201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8068201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts RFO misses from local IA",
         "EventCode": "0x35",
@@ -4877,6 +4895,15 @@
         "UMask": "0x10c8168201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8168201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for DRds issued by iA Cores targeting DDR Mem that Missed the LLC",
         "EventCode": "0x36",
@@ -5267,6 +5294,15 @@
         "UMask": "0x10c8068201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8068201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; RFO misses from local IA",
         "EventCode": "0x36",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c09b81d8d5e1..7093561389a1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.20,cascadelakex,core
 GenuineIntel-6-9[6C],v1.04,elkhartlake,core
-GenuineIntel-6-CF,v1.00,emeraldrapids,core
+GenuineIntel-6-CF,v1.01,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.00,grandridge,core
-- 
2.42.0.758.gaed0368e0e-goog

