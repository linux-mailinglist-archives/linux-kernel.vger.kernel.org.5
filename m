Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5687D7986
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjJZAc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZAcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8ACD44
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0737dcb26so234345276.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280352; x=1698885152; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7OBreGJUzqAMOgAvVj/rwBcf5+fRvTFtfbDZAV5mtY=;
        b=ktmI7q1W3GD9oui9MNevESqh4QInA71eIpOiDDKZdio57uS5vPsiEsa4+mobobtSO5
         wN0LD8gbxhlH2igYjvcZfPxvnTgvSjqVr/sg4sIDmun9YqgVLqpJOQziB8s/j9rbg4k/
         qNhVZiHR7AVbxbVP6sLGmTlCclrL94Rvc0u6dHLn6Kip/eNNloPNcO226TTkvenz9z5i
         dEj1yFLaaraflt5yQ94Fzkc5kqLW/pRQPDs1ra4R+cT5f6mnU91JlSNlLz67xAhL1Xgm
         UP4EFGHNplA01ZYwKN6TaKm26NpsH8owxL4ExfulD8RbuTZfViIQxqM9YM8IQTKHwR79
         zkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280352; x=1698885152;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7OBreGJUzqAMOgAvVj/rwBcf5+fRvTFtfbDZAV5mtY=;
        b=oHRCMPN0AjrlOsjlb83Vbodck9bTI3ozvzTsFMJB343SE75bnJkEIjO5aTxK1uclue
         zDUDzguVTNbZRgKNf+xar5DNT0PpBDDF6f7+qkkLFi0nLbRt0vbdv2H+EV6scXwGXyUa
         Lm7f5ExA+ST6f7KVkN2iOu5iTK+YPZGXca0PlQToaaVBg/ewENdauCapDHxGYGiKiQ0t
         nxDHn88/0B7LImqnxXn8rgbEyF9ugncpWfv5dV/1DOuFgDJb0sG/+ZE7jSw1VNw00/fr
         4kfRGSfWk60tVqrQ6diZkvzNWNb/LaMbnMRrbUaR4ghOp7rVzsBOuY1vpHG7irJTfkCw
         9XJA==
X-Gm-Message-State: AOJu0YyNtKmnVpaqAXFfLxVkJUcNpOmDJt87Ks1uDrYShu+JnPSBvgfn
        Mvyb/kYO4MYi0eGqLSmoRO9sQYe36tPr
X-Google-Smtp-Source: AGHT+IFDI9AFGQLlpSOOnrNi7Sz1UkkS4mcp+siEs/Ec9A0S0Op47syUrqdx7urODzP3eQWNa11IIZHIOLlu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a05:6902:105:b0:da0:3da9:ce08 with SMTP id
 o5-20020a056902010500b00da03da9ce08mr137173ybh.10.1698280352413; Wed, 25 Oct
 2023 17:32:32 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:48 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-8-irogers@google.com>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 8/9] perf vendor events intel: Update bonnell version
 number to v5
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

Spelling fixes were already incorporated in the Linux perf tree,
update the version number to reflect this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 0dee3de3187c..e571683f59f3 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.23,alderlake,core
 GenuineIntel-6-BE,v1.23,alderlaken,core
-GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
+GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v28,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
-- 
2.42.0.758.gaed0368e0e-goog

