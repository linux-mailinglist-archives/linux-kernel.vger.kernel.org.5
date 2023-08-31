Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0578F105
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbjHaQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjHaQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:16:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E1D81B0;
        Thu, 31 Aug 2023 09:16:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF0CC15;
        Thu, 31 Aug 2023 09:17:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BFB33F64C;
        Thu, 31 Aug 2023 09:16:36 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
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
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] perf vendor events arm64: Update V1 events using Arm telemetry repo
Date:   Thu, 31 Aug 2023 17:15:30 +0100
Message-Id: <20230831161618.134738-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last set of JSON updates using the Arm telemetry repo. Perf
now has an up to date copy of everything that is currently published
there. Future updates will be done as new data becomes available.

James Clark (2):
  perf vendor events arm64: Update V1 events using Arm telemetry repo
  perf vendor events arm64: Add V1 metrics using Arm telemetry repo

 .../arch/arm64/arm/neoverse-v1/branch.json    |   8 -
 .../arch/arm64/arm/neoverse-v1/bus.json       |  18 +-
 .../arch/arm64/arm/neoverse-v1/cache.json     | 155 ------------
 .../arch/arm64/arm/neoverse-v1/exception.json |  45 ++--
 .../arm64/arm/neoverse-v1/fp_operation.json   |  10 +
 .../arch/arm64/arm/neoverse-v1/general.json   |  10 +
 .../arm64/arm/neoverse-v1/instruction.json    | 119 ---------
 .../arch/arm64/arm/neoverse-v1/l1d_cache.json |  54 ++++
 .../arch/arm64/arm/neoverse-v1/l1i_cache.json |  14 ++
 .../arch/arm64/arm/neoverse-v1/l2_cache.json  |  50 ++++
 .../arch/arm64/arm/neoverse-v1/l3_cache.json  |  22 ++
 .../arch/arm64/arm/neoverse-v1/ll_cache.json  |  10 +
 .../arch/arm64/arm/neoverse-v1/memory.json    |  21 +-
 .../arch/arm64/arm/neoverse-v1/metrics.json   | 233 ++++++++++++++++++
 .../arch/arm64/arm/neoverse-v1/pipeline.json  |  23 --
 .../arch/arm64/arm/neoverse-v1/retired.json   |  30 +++
 .../arch/arm64/arm/neoverse-v1/spe.json       |  18 ++
 .../arm64/arm/neoverse-v1/spec_operation.json | 110 +++++++++
 .../arch/arm64/arm/neoverse-v1/stall.json     |  30 +++
 .../arch/arm64/arm/neoverse-v1/sve.json       |  30 +++
 .../arch/arm64/arm/neoverse-v1/tlb.json       |  66 +++++
 21 files changed, 735 insertions(+), 341 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/general.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/tlb.json

-- 
2.34.1

