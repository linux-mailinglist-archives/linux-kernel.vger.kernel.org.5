Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39904771BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHGHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHGHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:51:41 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF210F4;
        Mon,  7 Aug 2023 00:51:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VpC-01._1691394688;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VpC-01._1691394688)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 15:51:34 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 0/7] Add aliases and metrics for Arm CMN
Date:   Mon,  7 Aug 2023 15:51:18 +0800
Message-Id: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v5:
- Split the first patch out into 1st pmu.c change and 2nd metricgroup.c
  change.
- Change order to check alias and then identifier.
- Fix matching_pmu.
- Add event documentation links.

Jing Zhang (7):
  perf pmu: "Compat" supports matching multiple identifiers
  perf metric: "Compat" supports matching multiple identifiers
  perf jevents: Support more event fields
  perf test: Fix matching_pmu
  perf test: Add pmu-event test for "Compat" and new event_field.
  perf jevents: Add support for Arm CMN PMU aliasing
  perf vendor events: Add JSON metrics for Arm CMN

 .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
 .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
 .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
 tools/perf/pmu-events/jevents.py                   |  22 +-
 tools/perf/tests/pmu-events.c                      |  64 ++++-
 tools/perf/util/metricgroup.c                      |   2 +-
 tools/perf/util/pmu.c                              |  33 ++-
 tools/perf/util/pmu.h                              |   1 +
 8 files changed, 457 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json

-- 
1.8.3.1

