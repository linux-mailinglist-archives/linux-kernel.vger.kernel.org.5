Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8167D7982
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjJZAc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjJZAcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16CEDC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7fb3f311bso2991817b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280341; x=1698885141; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fS6WNbKrdhI9LhL+fdlwOt3dMxlWD/TnwGXZN+cwPHo=;
        b=dFF+wSOiXa6VtieUp4erRA+Xo+PUeFOr0rGMf3qJnncGDZe3aArvZ62vo7RllHHHJi
         6Z/LdV/YyP6A/DhGYEQCnyugrD2o+r1pG/ixdAtcPR3gYE0suXd6CR6zNfMNnMSA98R6
         mPFCInxefNJFzhX5ffLlUzXmVRWiUinEZOAHVmfe7FuOEjTwh1cDY7sNWP4XxnCiw5hV
         mn6MsyJzsS/IO+JWJWA5QeUIU3yQ0oMtvRe1liVXbnpptxj7BQcAZFCILD+UZpmwXNzQ
         cmmOMKeDny7YTBtQpAl45iN2pyQu/f3+FvZ01C9+n2OABeV8S9zB5DeV2nDNxyKyWOiI
         P+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280341; x=1698885141;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fS6WNbKrdhI9LhL+fdlwOt3dMxlWD/TnwGXZN+cwPHo=;
        b=tVdhknCl8Kgx7cj9zYSbOIbdBlhnw6Am6KIzzTvGjQdpGeu1RpoIocWZqZ3SmiDWML
         lmhQ3gQqjISZWWfaTIzHYuiNB/UxxA/Yj7rmM6iIdFLmxLSw23EDri+BC6xStTrDY3P/
         YvsE93G9Foqszjvn4opI227pSCZ6I73rth8+76XIOgLaz2R/n5UfxkRa8IwjoMqZ7DcE
         NmZDydvb8Eyf7RCP93tbhfbJwLy8jXSuNAARnK3MJuMvyrO0jXnERkuOw27ZibzbxduO
         FEt81SyULsTfDmX6rQaLSkeX7I+QpmTW4SB7NKC95tneA0tEcNwvEHthDVofqV28o07X
         Fc3A==
X-Gm-Message-State: AOJu0Yy67vEpuwDHsAvqAK+SUGOYrAjfVToYEJy1Yi1bOaBctrtu6DZf
        ui62h04Av6/GqdBXjmGuGMuXSsfoWBHi
X-Google-Smtp-Source: AGHT+IHa/FHFGFt42zD1qd2yqnDQO99w6WxAOWdDuStE5VU4UMbiBqGt/AZOayawBzwRXdJWlUtN8pYeZKsA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a81:4c8f:0:b0:59f:3cde:b33a with SMTP id
 z137-20020a814c8f000000b0059f3cdeb33amr143012ywa.6.1698280340923; Wed, 25 Oct
 2023 17:32:20 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:43 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-3-irogers@google.com>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 3/9] perf vendor events intel: Update a spelling in haswell/haswellx
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spelling of "in-flight" was switched to "inflight".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/haswell/memory.json  | 2 +-
 tools/perf/pmu-events/arch/x86/haswellx/memory.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/per=
f/pmu-events/arch/x86/haswell/memory.json
index df44c28efeeb..2fc25e22a42a 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/pe=
rf/pmu-events/arch/x86/haswellx/memory.json
index d66e465ce41a..2d212cf59e92 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
--=20
2.42.0.758.gaed0368e0e-goog

