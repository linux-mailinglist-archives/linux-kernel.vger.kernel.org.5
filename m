Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0388786573
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbjHXCeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbjHXCdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:33:38 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3422F10DD;
        Wed, 23 Aug 2023 19:33:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VqS2P5a_1692844408;
Received: from 30.221.146.144(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VqS2P5a_1692844408)
          by smtp.aliyun-inc.com;
          Thu, 24 Aug 2023 10:33:29 +0800
Message-ID: <a1e0be71-e613-7a62-6b4c-452515ea566f@linux.alibaba.com>
Date:   Thu, 24 Aug 2023 10:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v7 0/8] perf vendor events: Add JSON metrics for Arm CMN
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
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <566ec1ff-fdea-336e-3cb8-503fc593f8ec@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <566ec1ff-fdea-336e-3cb8-503fc593f8ec@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/23 下午4:12, John Garry 写道:
> On 21/08/2023 09:36, Jing Zhang wrote:
> 
> I'm hoping that Ian can check the outstanding patches here, but I'll also have a look.
> 

Thanks! I haven't added your tag to patch 6 for now, because I made a modification and added
the code in empty-pmu-events.c. Looking forward to your review.

Thanks,
Jing

>> Changes since v6:
>> - Supplement the omitted EventCode;
>> - Keep the original way of ConfigCode;
>> - Supplement the test in empty-pmu-events.c, so that the pmu event test
>>    can succeed when build with NO_JEVENT=1.
>> - Link: https://urldefense.com/v3/__https://lore.kernel.org/all/1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com/__;!!ACWV5N9M2RV99hQ!Lakh7Lf-6l6Hovm4Tt5S5pqV1xHm-LAW2ICVl6gLONlN4CNk-BvyADBfjwQe5yQQj89yMK7s7rSjMNHCyFsIUxnHXg$
>>
>> Jing Zhang (8):
>>    perf pmu: "Compat" supports matching multiple identifiers
>>    perf metric: "Compat" supports matching multiple identifiers
>>    perf vendor events: Supplement the omitted EventCode
>>    perf jevents: Support more event fields
>>    perf test: Make matching_pmu effective
>>    perf test: Add pmu-event test for "Compat" and new event_field.
>>    perf jevents: Add support for Arm CMN PMU aliasing
>>    perf vendor events: Add JSON metrics for Arm CMN
>>
>>   .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
>>   .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
>>   .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
>>   .../pmu-events/arch/x86/alderlake/pipeline.json    |   9 +
>>   .../pmu-events/arch/x86/alderlaken/pipeline.json   |   3 +
>>   .../pmu-events/arch/x86/broadwell/pipeline.json    |   4 +
>>   .../pmu-events/arch/x86/broadwellde/pipeline.json  |   4 +
>>   .../arch/x86/broadwellde/uncore-cache.json         |   2 +
>>   .../arch/x86/broadwellde/uncore-interconnect.json  |   1 +
>>   .../arch/x86/broadwellde/uncore-memory.json        |   1 +
>>   .../arch/x86/broadwellde/uncore-power.json         |   1 +
>>   .../pmu-events/arch/x86/broadwellx/pipeline.json   |   4 +
>>   .../arch/x86/broadwellx/uncore-cache.json          |   2 +
>>   .../arch/x86/broadwellx/uncore-interconnect.json   |  13 +
>>   .../arch/x86/broadwellx/uncore-memory.json         |   2 +
>>   .../arch/x86/broadwellx/uncore-power.json          |   1 +
>>   .../pmu-events/arch/x86/cascadelakex/pipeline.json |   4 +
>>   .../arch/x86/cascadelakex/uncore-cache.json        |   2 +
>>   .../arch/x86/cascadelakex/uncore-interconnect.json |   1 +
>>   .../arch/x86/cascadelakex/uncore-io.json           |   1 +
>>   .../arch/x86/cascadelakex/uncore-memory.json       |   1 +
>>   .../arch/x86/cascadelakex/uncore-power.json        |   1 +
>>   .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   2 +
>>   .../pmu-events/arch/x86/goldmont/pipeline.json     |   3 +
>>   .../pmu-events/arch/x86/goldmontplus/pipeline.json |   3 +
>>   .../pmu-events/arch/x86/grandridge/pipeline.json   |   3 +
>>   .../arch/x86/graniterapids/pipeline.json           |   4 +
>>   .../perf/pmu-events/arch/x86/haswell/pipeline.json |   4 +
>>   .../pmu-events/arch/x86/haswellx/pipeline.json     |   4 +
>>   .../pmu-events/arch/x86/haswellx/uncore-cache.json |   2 +
>>   .../arch/x86/haswellx/uncore-interconnect.json     |  14 ++
>>   .../arch/x86/haswellx/uncore-memory.json           |   2 +
>>   .../pmu-events/arch/x86/haswellx/uncore-power.json |   1 +
>>   .../perf/pmu-events/arch/x86/icelake/pipeline.json |   4 +
>>   .../pmu-events/arch/x86/icelakex/pipeline.json     |   4 +
>>   .../pmu-events/arch/x86/icelakex/uncore-cache.json |   1 +
>>   .../arch/x86/icelakex/uncore-interconnect.json     |   1 +
>>   .../arch/x86/icelakex/uncore-memory.json           |   1 +
>>   .../pmu-events/arch/x86/icelakex/uncore-power.json |   1 +
>>   .../pmu-events/arch/x86/ivybridge/pipeline.json    |   3 +
>>   .../perf/pmu-events/arch/x86/ivytown/pipeline.json |   4 +
>>   .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   2 +
>>   .../arch/x86/ivytown/uncore-interconnect.json      |  11 +
>>   .../pmu-events/arch/x86/ivytown/uncore-memory.json |   1 +
>>   .../pmu-events/arch/x86/ivytown/uncore-power.json  |   1 +
>>   .../pmu-events/arch/x86/jaketown/pipeline.json     |   4 +
>>   .../pmu-events/arch/x86/jaketown/uncore-cache.json |   2 +
>>   .../arch/x86/jaketown/uncore-interconnect.json     |  12 +
>>   .../arch/x86/jaketown/uncore-memory.json           |   1 +
>>   .../pmu-events/arch/x86/jaketown/uncore-power.json |   2 +
>>   .../arch/x86/knightslanding/pipeline.json          |   3 +
>>   .../arch/x86/knightslanding/uncore-cache.json      |   1 +
>>   .../arch/x86/knightslanding/uncore-memory.json     |   4 +
>>   .../pmu-events/arch/x86/meteorlake/pipeline.json   |   8 +
>>   .../pmu-events/arch/x86/sandybridge/pipeline.json  |   4 +
>>   .../arch/x86/sapphirerapids/pipeline.json          |   5 +
>>   .../pmu-events/arch/x86/sierraforest/pipeline.json |   4 +
>>   .../pmu-events/arch/x86/silvermont/pipeline.json   |   3 +
>>   .../perf/pmu-events/arch/x86/skylake/pipeline.json |   4 +
>>   .../pmu-events/arch/x86/skylakex/pipeline.json     |   4 +
>>   .../pmu-events/arch/x86/skylakex/uncore-cache.json |   2 +
>>   .../arch/x86/skylakex/uncore-interconnect.json     |   1 +
>>   .../pmu-events/arch/x86/skylakex/uncore-io.json    |   1 +
>>   .../arch/x86/skylakex/uncore-memory.json           |   1 +
>>   .../pmu-events/arch/x86/skylakex/uncore-power.json |   1 +
>>   .../pmu-events/arch/x86/snowridgex/pipeline.json   |   2 +
>>   .../arch/x86/snowridgex/uncore-cache.json          |   1 +
>>   .../arch/x86/snowridgex/uncore-interconnect.json   |   1 +
>>   .../arch/x86/snowridgex/uncore-memory.json         |   1 +
>>   .../arch/x86/snowridgex/uncore-power.json          |   1 +
>>   .../pmu-events/arch/x86/tigerlake/pipeline.json    |   5 +
>>   tools/perf/pmu-events/empty-pmu-events.c           |   8 +
>>   tools/perf/pmu-events/jevents.py                   |  21 +-
>>   tools/perf/tests/pmu-events.c                      |  64 ++++-
>>   tools/perf/util/metricgroup.c                      |   2 +-
>>   tools/perf/util/pmu.c                              |  33 ++-
>>   tools/perf/util/pmu.h                              |   1 +
>>   77 files changed, 679 insertions(+), 9 deletions(-)
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
>>
