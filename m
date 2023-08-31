Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8467778F011
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjHaPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbjHaPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:17:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38ED8E5B;
        Thu, 31 Aug 2023 08:17:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4165DC15;
        Thu, 31 Aug 2023 08:18:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73D813F64C;
        Thu, 31 Aug 2023 08:17:21 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/7] perf jevents: Remove unused keyword
Date:   Thu, 31 Aug 2023 16:16:13 +0100
Message-Id: <20230831151632.124985-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831151632.124985-1-james.clark@arm.com>
References: <20230831151632.124985-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cpuid_not_more_than' was the working title of the new
'strcmp_cpuid_str' keyword and was accidentally left in. It was never
used so tidying it up has no effect.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/pmu-events/metric.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0e9ec65d92ae..1bbb89102901 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -558,8 +558,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # Convert accidentally converted scientific notation constants back
   py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
-  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str',
-              'cpuid_not_more_than']
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
     py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
   try:
-- 
2.34.1

