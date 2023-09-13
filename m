Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072F279ED1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjIMPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIMPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:34:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B642893;
        Wed, 13 Sep 2023 08:34:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF921FB;
        Wed, 13 Sep 2023 08:34:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 590393F5A1;
        Wed, 13 Sep 2023 08:34:17 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] perf: strcmp_cpuid_str() expression fixups
Date:   Wed, 13 Sep 2023 16:33:47 +0100
Message-Id: <20230913153355.138331-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set of fixes related to the comments here [1]. Mainly cleanups,
additional tests and refactoring since adding the new strcmp_cpuid_str()
metric expression.

I added the string replace function to the perf utils
rather than tools/lib/string.c because it didn't seem
easy to add tests for tools/lib.

[1]: https://lore.kernel.org/linux-arm-kernel/CAP-5=fVnUx0BnJC7X1rrm42OD7Bk=ZsHWNwAZMBYyB7yWhBfhQ@mail.gmail.com/
[2]: https://lore.kernel.org/linux-perf-users/ZQC7da2AM9ih8RMz@kernel.org/

---
Changes since v2:
  * Drop patches that were already applied (which makes the cover letter
    mostly redundant)
  * Avoid generating the compiler warning reported here [2]

Changes since v1:
  * s -> haystack
  * find -> needle

James Clark (3):
  perf pmu: Move pmu__find_core_pmu() to pmus.c
  perf pmus: Simplify perf_pmus__find_core_pmu()
  perf pmu: Remove unused function

 tools/perf/arch/arm64/util/pmu.c | 20 ++++++++------------
 tools/perf/tests/expr.c          |  2 +-
 tools/perf/util/expr.c           |  2 +-
 tools/perf/util/pmu.c            | 22 ----------------------
 tools/perf/util/pmu.h            |  3 +--
 tools/perf/util/pmus.c           |  8 +++++++-
 6 files changed, 18 insertions(+), 39 deletions(-)

-- 
2.34.1

