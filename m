Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66CB796F06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbjIGCma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjIGCm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:42:29 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391A1997;
        Wed,  6 Sep 2023 19:42:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VrVXchl_1694054538;
Received: from 30.221.145.55(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VrVXchl_1694054538)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 10:42:20 +0800
Message-ID: <3563c30f-eaa1-8bb4-fa6c-2f41c2b30f7d@linux.alibaba.com>
Date:   Thu, 7 Sep 2023 10:42:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v7 0/8] perf vendor events: Add JSON metrics for Arm CMN
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
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
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <ZPijMsM7GsHYtPse@kernel.org>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <ZPijMsM7GsHYtPse@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/7 上午12:05, Arnaldo Carvalho de Melo 写道:
> Em Mon, Aug 21, 2023 at 04:36:09PM +0800, Jing Zhang escreveu:
>> Changes since v6:
>> - Supplement the omitted EventCode;
>> - Keep the original way of ConfigCode;
>> - Supplement the test in empty-pmu-events.c, so that the pmu event test
>>   can succeed when build with NO_JEVENT=1.
>> - Link: https://lore.kernel.org/all/1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Waiting for a v8, from what I saw there are several more review comments
> to address, right?
> 

Yes, I will send v8 soon.

Thanks,
Jing

> - Arnaldo
>  
>> Jing Zhang (8):
>>   perf pmu: "Compat" supports matching multiple identifiers
>>   perf metric: "Compat" supports matching multiple identifiers
>>   perf vendor events: Supplement the omitted EventCode
>>   perf jevents: Support more event fields
>>   perf test: Make matching_pmu effective
>>   perf test: Add pmu-event test for "Compat" and new event_field.
>>   perf jevents: Add support for Arm CMN PMU aliasing
>>   perf vendor events: Add JSON metrics for Arm CMN
>>
>>  .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
>>  .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
>>  .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
>>  .../pmu-events/arch/x86/alderlake/pipeline.json    |   9 +
>>  .../pmu-events/arch/x86/alderlaken/pipeline.json   |   3 +
>>  .../pmu-events/arch/x86/broadwell/pipeline.json    |   4 +
>>  .../pmu-events/arch/x86/broadwellde/pipeline.json  |   4 +
>>  .../arch/x86/broadwellde/uncore-cache.json         |   2 +
>>  .../arch/x86/broadwellde/uncore-interconnect.json  |   1 +
>>  .../arch/x86/broadwellde/uncore-memory.json        |   1 +
>>  .../arch/x86/broadwellde/uncore-power.json         |   1 +
>>  .../pmu-events/arch/x86/broadwellx/pipeline.json   |   4 +
>>  .../arch/x86/broadwellx/uncore-cache.json          |   2 +
>>  .../arch/x86/broadwellx/uncore-interconnect.json   |  13 +
>>  .../arch/x86/broadwellx/uncore-memory.json         |   2 +
>>  .../arch/x86/broadwellx/uncore-power.json          |   1 +
>>  .../pmu-events/arch/x86/cascadelakex/pipeline.json |   4 +
>>  .../arch/x86/cascadelakex/uncore-cache.json        |   2 +
>>  .../arch/x86/cascadelakex/uncore-interconnect.json |   1 +
>>  .../arch/x86/cascadelakex/uncore-io.json           |   1 +
>>  .../arch/x86/cascadelakex/uncore-memory.json       |   1 +
>>  .../arch/x86/cascadelakex/uncore-power.json        |   1 +
>>  .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   2 +
>>  .../pmu-events/arch/x86/goldmont/pipeline.json     |   3 +
>>  .../pmu-events/arch/x86/goldmontplus/pipeline.json |   3 +
>>  .../pmu-events/arch/x86/grandridge/pipeline.json   |   3 +
>>  .../arch/x86/graniterapids/pipeline.json           |   4 +
>>  .../perf/pmu-events/arch/x86/haswell/pipeline.json |   4 +
>>  .../pmu-events/arch/x86/haswellx/pipeline.json     |   4 +
>>  .../pmu-events/arch/x86/haswellx/uncore-cache.json |   2 +
>>  .../arch/x86/haswellx/uncore-interconnect.json     |  14 ++
>>  .../arch/x86/haswellx/uncore-memory.json           |   2 +
>>  .../pmu-events/arch/x86/haswellx/uncore-power.json |   1 +
>>  .../perf/pmu-events/arch/x86/icelake/pipeline.json |   4 +
>>  .../pmu-events/arch/x86/icelakex/pipeline.json     |   4 +
>>  .../pmu-events/arch/x86/icelakex/uncore-cache.json |   1 +
>>  .../arch/x86/icelakex/uncore-interconnect.json     |   1 +
>>  .../arch/x86/icelakex/uncore-memory.json           |   1 +
>>  .../pmu-events/arch/x86/icelakex/uncore-power.json |   1 +
>>  .../pmu-events/arch/x86/ivybridge/pipeline.json    |   3 +
>>  .../perf/pmu-events/arch/x86/ivytown/pipeline.json |   4 +
>>  .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   2 +
>>  .../arch/x86/ivytown/uncore-interconnect.json      |  11 +
>>  .../pmu-events/arch/x86/ivytown/uncore-memory.json |   1 +
>>  .../pmu-events/arch/x86/ivytown/uncore-power.json  |   1 +
>>  .../pmu-events/arch/x86/jaketown/pipeline.json     |   4 +
>>  .../pmu-events/arch/x86/jaketown/uncore-cache.json |   2 +
>>  .../arch/x86/jaketown/uncore-interconnect.json     |  12 +
>>  .../arch/x86/jaketown/uncore-memory.json           |   1 +
>>  .../pmu-events/arch/x86/jaketown/uncore-power.json |   2 +
>>  .../arch/x86/knightslanding/pipeline.json          |   3 +
>>  .../arch/x86/knightslanding/uncore-cache.json      |   1 +
>>  .../arch/x86/knightslanding/uncore-memory.json     |   4 +
>>  .../pmu-events/arch/x86/meteorlake/pipeline.json   |   8 +
>>  .../pmu-events/arch/x86/sandybridge/pipeline.json  |   4 +
>>  .../arch/x86/sapphirerapids/pipeline.json          |   5 +
>>  .../pmu-events/arch/x86/sierraforest/pipeline.json |   4 +
>>  .../pmu-events/arch/x86/silvermont/pipeline.json   |   3 +
>>  .../perf/pmu-events/arch/x86/skylake/pipeline.json |   4 +
>>  .../pmu-events/arch/x86/skylakex/pipeline.json     |   4 +
>>  .../pmu-events/arch/x86/skylakex/uncore-cache.json |   2 +
>>  .../arch/x86/skylakex/uncore-interconnect.json     |   1 +
>>  .../pmu-events/arch/x86/skylakex/uncore-io.json    |   1 +
>>  .../arch/x86/skylakex/uncore-memory.json           |   1 +
>>  .../pmu-events/arch/x86/skylakex/uncore-power.json |   1 +
>>  .../pmu-events/arch/x86/snowridgex/pipeline.json   |   2 +
>>  .../arch/x86/snowridgex/uncore-cache.json          |   1 +
>>  .../arch/x86/snowridgex/uncore-interconnect.json   |   1 +
>>  .../arch/x86/snowridgex/uncore-memory.json         |   1 +
>>  .../arch/x86/snowridgex/uncore-power.json          |   1 +
>>  .../pmu-events/arch/x86/tigerlake/pipeline.json    |   5 +
>>  tools/perf/pmu-events/empty-pmu-events.c           |   8 +
>>  tools/perf/pmu-events/jevents.py                   |  21 +-
>>  tools/perf/tests/pmu-events.c                      |  64 ++++-
>>  tools/perf/util/metricgroup.c                      |   2 +-
>>  tools/perf/util/pmu.c                              |  33 ++-
>>  tools/perf/util/pmu.h                              |   1 +
>>  77 files changed, 679 insertions(+), 9 deletions(-)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
>>
>> -- 
>> 1.8.3.1
>>
> 
