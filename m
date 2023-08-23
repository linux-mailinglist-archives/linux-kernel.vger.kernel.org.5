Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05A78526A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjHWILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjHWIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18EE71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fbfcb8d90so47611797b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778114; x=1693382914;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5WZqRzaVJvIJMjlwpO1R+wpxZBFSIFOikqyfQZH1kE=;
        b=vjnAbFlXmxVBv6vhTv/dewJWBXmjwm2OZGZhVUyI+WT5WjEmpIiHXIAnBHZ/9vLEL3
         SEf147geT7ig/Nw+0gJeZpKAj6t+oojfrPtsbCVnIiSr+O3Fl3fChvDEfeWUidpZb/RJ
         stA+nOYj81ZN9/kK0gtg3S8DuPuikRuZyQjIzCDLtMDUz9y6+GktwhMjBQlLDgw853+a
         xWJoQvT7cSi2BgIA4sFXTxYkYlVkapVypIdwQ863mieqdXjiJ1beJ+FJNUBDIMtjJyz2
         8ZFX98FZFa0tk/RH4KDq3Q0inG2o8tI0noe7LJM4t2eoFMSugbojcNsxnvk2Tnjh+cb0
         GBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778114; x=1693382914;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5WZqRzaVJvIJMjlwpO1R+wpxZBFSIFOikqyfQZH1kE=;
        b=TU/mU0wG0rNV3R59pK7NnWBOsWV75ZrXG3ndfwTTL2Og1BUyQCXDH3Zh2QM3dXPAOO
         Mp+zthdCdqCoxVkHRv7n+nFVvdQrccbCVlrkprlFSplLkOggUE9nM4W2fG5OP6bfVMDZ
         6mXuctQqykgwVuMlpzX6apUQm0/IGS0KxDR8OhO7iQvhNX+qJb3bH6NUXGW3SeuTKKKk
         gPUDp2Wcuek/usOmWkDUrN5Q/EtKLSYfUKTKhNkpgK9DnEXVoWsO8UqZoOADnZnvlSor
         V8MG1A6MSM61/MUj6wBdCzITJbB+iQrk8prJuWwPsj+MsK8+1Fj65Dyx4fRocj7P5AuR
         ce9w==
X-Gm-Message-State: AOJu0YwKkErKMa19/MHpgEa2cTS9S1EQsXYoi0wl1BGUJ4weSl9gNNFC
        qVtt+Fnu6hRDDejg8a1zBAXR2ltcZ2//
X-Google-Smtp-Source: AGHT+IFabHEBo1r4vNQ9MCETBVuXu18lGMDuZDFKBOYUQ77bnKyfuRUJ5IHUoxWgEiaxyrvuDZkQjPMRxYpO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a81:ad08:0:b0:58c:a9b4:a64c with SMTP id
 l8-20020a81ad08000000b0058ca9b4a64cmr147675ywh.1.1692778114142; Wed, 23 Aug
 2023 01:08:34 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:04 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-2-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 01/25] perf script ibs: Remove unused include
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
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

Done to reduce dependencies on pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/amd-sample-raw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 6a6ddba76c75..9d0ce88e90e4 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -15,7 +15,6 @@
 #include "session.h"
 #include "evlist.h"
 #include "sample-raw.h"
-#include "pmu-events/pmu-events.h"
 #include "util/sample.h"
 
 static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
-- 
2.42.0.rc1.204.g551eb34607-goog

