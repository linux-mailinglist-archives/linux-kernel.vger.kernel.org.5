Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BE76A864
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHAFhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjHAFhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:37:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F41BF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d326cb4c97fso1705002276.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690868213; x=1691473013;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKKw+NoKhTAujkctGAEA03hT1bAPJjDpeY1EXDQF9cg=;
        b=q6mr/otNvx2nbxcxVCrk74/og2gISIFG6v2fLfLC1kP8KTWbzsu4C4kRbqmhMLyDo2
         4mzM/6+JtWILDXVoGkJdk7m6Fc0eWnqkzMNSwLpATn8rJHoJgWlDUBNS2+mPkdNJ1DU2
         l6hLg+kVsntRrSILPpPc9IZ7/Q+L1LJLNr3jnxA0lhPivxDRQfM7hoHeAm6j1tq8qHF+
         pxsbLHqC99bcCRvVb9ef3eVuOb70YIE9eTO39B/qleRyn7Mma0P4nYsf7cy/I26vmYCm
         hpZnDMMtxvEDiwD5JAL2428WVYqiETYbI9CnWwcIbWQRX+Zobnccp4PYJBCZ4d5Ogwww
         LzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868213; x=1691473013;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKKw+NoKhTAujkctGAEA03hT1bAPJjDpeY1EXDQF9cg=;
        b=iolkGUY9hNNzBhrQ+/QX3rqiBMrYaH78MRS/qLunJCw3kYn4RILg4XisfnJ6ffsUIv
         dy10FPV74ZeveCNLE2eSvtK9cAvXQr0bthNyRYj24OWinNQ594mb6E2ZJgL5gLB6pu0v
         MDSNo0MwV01/A+hHQ8acVycPTNwdqwGUA7FvUbdauZ/cq5/DQZW/lPzsp0yJEtlLTKpf
         zaVPuQDTBA0XBFD6MeROMlJ6PM3aLFlCN/Mq7PnnExBKxF3p1U+q3nfwdR+2LsF55NUO
         PABwk39Q6+qf2V/JLZJgZOGXSoamgFwD3BqG5lCHa6+eXvHHf0Y/58kcHgbU1zJ7Uj0P
         tM6w==
X-Gm-Message-State: ABy/qLboWt7dYYo7QR44r1pTqzUktjxRzxXzoumhKCWUsnCcWP2IcWsT
        rQpieGrEwo4gSgQS1ijlZ1e7ULj/Sqwv
X-Google-Smtp-Source: APBJJlGHBKhwYEiNXtpe+3148aniIERraU7cOk0yF95FuPWBpAxYzpg9M/tmYEo+B0FB56/TFySIN1uF3T1J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dd0a:f4b:6531:d8dc])
 (user=irogers job=sendgmr) by 2002:a25:ce91:0:b0:c4e:3060:41f9 with SMTP id
 x139-20020a25ce91000000b00c4e306041f9mr71542ybe.9.1690868213682; Mon, 31 Jul
 2023 22:36:53 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:36:33 -0700
In-Reply-To: <20230801053634.1142634-1-irogers@google.com>
Message-Id: <20230801053634.1142634-4-irogers@google.com>
Mime-Version: 1.0
References: <20230801053634.1142634-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1 3/4] perf vendor events intel: Update sapphirerapids to 1.15
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.15 events were released in:
https://github.com/intel/perfmon/commit/76dfb81a1148ec049fd9caae9c62529404da63df
Adds the events OCR.DEMAND_DATA_RD.LOCAL_SOCKET_PMM and
OCR.DEMAND_DATA_RD.PMM.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv     |  2 +-
 .../arch/x86/sapphirerapids/other.json         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 9020d7a23c91..3a8770e29fe8 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,7 +24,7 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-(8F|CF),v1.14,sapphirerapids,core
+GenuineIntel-6-(8F|CF),v1.15,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
index 31b6be9fb8c7..442ef3807a9d 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -76,6 +76,24 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by PMM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM accesses that are controlled by the close or distant SNC Cluster.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_SOCKET_PMM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x700C00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by PMM.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.PMM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x703C00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied by DRAM attached to another socket.",
         "EventCode": "0x2A,0x2B",
-- 
2.41.0.585.gd2178a4bd4-goog

