Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B489278F010
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbjHaPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbjHaPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:17:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E85C6E50;
        Thu, 31 Aug 2023 08:17:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AA0C15;
        Thu, 31 Aug 2023 08:17:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5470D3F64C;
        Thu, 31 Aug 2023 08:17:04 -0700 (PDT)
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
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/7] perf test: Check result of has_event(cycles) test
Date:   Thu, 31 Aug 2023 16:16:12 +0100
Message-Id: <20230831151632.124985-2-james.clark@arm.com>
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

Currently the function always returns 0, so even when the has_event()
test fails, the test still passes. Fix it by returning ret instead.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/expr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 81229fa4f1e9..39be7f3b3a53 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -263,7 +263,7 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 
 	expr__ctx_free(ctx);
 
-	return 0;
+	return ret;
 }
 
 DEFINE_SUITE("Simple expression parser", expr);
-- 
2.34.1

