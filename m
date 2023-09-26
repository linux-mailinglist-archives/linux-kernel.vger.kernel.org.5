Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491AA7AF121
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjIZQsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:48:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFBACE;
        Tue, 26 Sep 2023 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695746926; x=1727282926;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LBVll71AmupPCU5W9lts6N+NWDSZlNkgAGXT6anFo5k=;
  b=a1iOlMfyXiCEXqnw1BS16riiNUIeM8zw5S30bt9QEB2rVUV7m5WI+TdX
   GxNjVU4W5eizvPdCOSv/z+I6CR4LMMN9XQ95u4XTRDsKbTouM48QNzpRW
   oTJcB8XMmRG3TKCK3puEtoCIw1lnoIm51W8XjRIr5Lr8tLntPhrfXPnf6
   IMb6tLhn4Erxld7vf+JvOK4VsQF2x4KYbjY/xw1W+jkuSuoeTzmKiqe2e
   s3ugIUccJLoOPqt3g1d0zrQhDh2qJpbkWoOq7UL2vWFM3jKtu/4U8cneP
   bnAepOHxWsQhOZ/Dstv8bXSijMGnx9idZqyNO8mcWzVO73AjZyEPNQPQZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385462418"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="385462418"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="225044"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:48:15 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5A860580D9B;
        Tue, 26 Sep 2023 09:48:42 -0700 (PDT)
Message-ID: <b54140e3-8253-8ede-5c76-438267c92928@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:48:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 00/25] Perf stat metric grouping with hardware
 information
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <bc11c58c-5d2c-ce41-9834-70b6468ac92b@linux.intel.com>
In-Reply-To: <bc11c58c-5d2c-ce41-9834-70b6468ac92b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-26 10:43 a.m., Liang, Kan wrote:
> 
> 
> On 2023-09-25 2:17 a.m., weilin.wang@intel.com wrote:
>> From: Weilin Wang <weilin.wang@intel.com>
>>
>> Perf stat metric grouping generates event groups that are provided to kernel for
>> data collection using the hardware counters. Sometimes, the grouping might fail
>> and kernel has to retry the groups because generated groups do not fit in the
>> hardware counters correctly. In some other cases, the groupings are collected
>> correctly, however, they left some hardware counters unused.
>>
>> To improve these inefficiencies, we would like to propose a hardware aware
>> grouping method that does metric/event grouping based on event counter>> restriction rules and the availability of hardware counters in the
system. This
>> method is generic as long as all the restriction rules could be provided from
>> the pmu-event JSON files.
> 
> This method assumes that it's the only user (expect NMI watchdog) and
> all the HW resource are available. Right?

It's better to give more details about the algorithm of the method. How
to decide to create a new group? How to decide which group the event
will be added into. etc.

Thanks,
Kan
> 
>>
>> This patch set includes code that does hardware aware grouping and updated
>> pmu-event JSON files for four platforms (SapphireRapids, Icelakex, Cascadelakex,
>> and Tigerlake) for your testing and experimenting. We've successfully tested
>> these patches on three platforms (SapphireRapids, Icelakex, and Cascadelakex)
>> with topdown metrics from TopdownL1 to TopdownL6.
>>
>> There are some optimization opportunities that we might implement in the future:
>> 1) Better NMI hanlding: when NMI watchdog is enabled, we reduce the default_core
>> total counter size by one. This could be improved to better utilize the counter.
>> 2) Fill important events into unused counter for better counter utlization:
>> there might be some unused counters scattered in the groups. We could consider
>> to add important events in this slots if necessary. This could help increase the
>> multiplexing percentage and help improve accuracy if the event is critical.
>>
>> Remaining questions for dicussion:
>> 3) Where to start grouping from? The current implementation start grouping by
>> combining all the events into a single list. This step deduplicates events. But
>> it does not maintain the relationship of events according to the metrics, i.e.
>> events required by one metric may not be collected at the same time. Another
>> type of starting point would be grouping each individual metric and then try to
>> merge the groups.
> 
> Maybe you can add a new flag to tag the metric which should/better be
> scheduled together, e.g., IPC.
> 
> Thanks,
> Kan
>> 4) Any comments, suggestions, new ideas?
>> 5) If you are interested to test the patch out and the pmu-event JSON files of
>> your testing platform is not provided here, please let me know so that I could
>> provide you the files.
>>
>>
>> Weilin Wang (25):
>>   perf stat: Add hardware-grouping cmd option to perf stat
>>   perf stat: Add basic functions for the hardware-grouping stat cmd
>>     option
>>   perf pmu-events: Add functions in jevent.py
>>   perf pmu-events: Add counter info into JSON files for SapphireRapids
>>   perf pmu-events: Add event counter data for Cascadelakex
>>   perf pmu-events: Add event counter data for Icelakex
>>   perf stat: Add helper functions for hardware-grouping method
>>   perf stat: Add functions to get counter info
>>   perf stat: Add helper functions for hardware-grouping method
>>   perf stat: Add helper functions to hardware-grouping method
>>   perf stat: Add utility functions to hardware-grouping method
>>   perf stat: Add more functions for hardware-grouping method
>>   perf stat: Add functions to hardware-grouping method
>>   perf stat: Add build string function and topdown events handling in
>>     hardware-grouping
>>   perf stat: Add function to combine metrics for hardware-grouping
>>   perf stat: Update keyword core to default_core to adjust to the
>>     changes for events with no unit
>>   perf stat: Handle taken alone in hardware-grouping
>>   perf stat: Handle NMI in hardware-grouping
>>   perf stat: Handle grouping method fall back in hardware-grouping
>>   perf stat: Code refactoring in hardware-grouping
>>   perf stat: Add tool events support in hardware-grouping
>>   perf stat: Add TSC support in hardware-grouping
>>   perf stat: Fix a return error issue in hardware-grouping
>>   perf stat: Add check to ensure correctness in platform that does not
>>     support hardware-grouping
>>   perf pmu-events: Add event counter data for Tigerlake
>>
>>  tools/lib/bitmap.c                            |   20 +
>>  tools/perf/builtin-stat.c                     |    7 +
>>  .../arch/x86/cascadelakex/cache.json          | 1237 ++++++++++++
>>  .../arch/x86/cascadelakex/counter.json        |   17 +
>>  .../arch/x86/cascadelakex/floating-point.json |   16 +
>>  .../arch/x86/cascadelakex/frontend.json       |   68 +
>>  .../arch/x86/cascadelakex/memory.json         |  751 ++++++++
>>  .../arch/x86/cascadelakex/other.json          |  168 ++
>>  .../arch/x86/cascadelakex/pipeline.json       |  102 +
>>  .../arch/x86/cascadelakex/uncore-cache.json   | 1138 +++++++++++
>>  .../x86/cascadelakex/uncore-interconnect.json | 1272 +++++++++++++
>>  .../arch/x86/cascadelakex/uncore-io.json      |  394 ++++
>>  .../arch/x86/cascadelakex/uncore-memory.json  |  509 +++++
>>  .../arch/x86/cascadelakex/uncore-power.json   |   25 +
>>  .../arch/x86/cascadelakex/virtual-memory.json |   28 +
>>  .../pmu-events/arch/x86/icelakex/cache.json   |   98 +
>>  .../pmu-events/arch/x86/icelakex/counter.json |   17 +
>>  .../arch/x86/icelakex/floating-point.json     |   13 +
>>  .../arch/x86/icelakex/frontend.json           |   55 +
>>  .../pmu-events/arch/x86/icelakex/memory.json  |   53 +
>>  .../pmu-events/arch/x86/icelakex/other.json   |   52 +
>>  .../arch/x86/icelakex/pipeline.json           |   92 +
>>  .../arch/x86/icelakex/uncore-cache.json       |  965 ++++++++++
>>  .../x86/icelakex/uncore-interconnect.json     | 1667 +++++++++++++++++
>>  .../arch/x86/icelakex/uncore-io.json          |  966 ++++++++++
>>  .../arch/x86/icelakex/uncore-memory.json      |  186 ++
>>  .../arch/x86/icelakex/uncore-power.json       |   26 +
>>  .../arch/x86/icelakex/virtual-memory.json     |   22 +
>>  .../arch/x86/sapphirerapids/cache.json        |  104 +
>>  .../arch/x86/sapphirerapids/counter.json      |   17 +
>>  .../x86/sapphirerapids/floating-point.json    |   25 +
>>  .../arch/x86/sapphirerapids/frontend.json     |   98 +-
>>  .../arch/x86/sapphirerapids/memory.json       |   44 +
>>  .../arch/x86/sapphirerapids/other.json        |   40 +
>>  .../arch/x86/sapphirerapids/pipeline.json     |  118 ++
>>  .../arch/x86/sapphirerapids/uncore-cache.json |  534 +++++-
>>  .../arch/x86/sapphirerapids/uncore-cxl.json   |   56 +
>>  .../sapphirerapids/uncore-interconnect.json   |  476 +++++
>>  .../arch/x86/sapphirerapids/uncore-io.json    |  373 ++++
>>  .../x86/sapphirerapids/uncore-memory.json     |  391 ++++
>>  .../arch/x86/sapphirerapids/uncore-power.json |   24 +
>>  .../x86/sapphirerapids/virtual-memory.json    |   20 +
>>  .../pmu-events/arch/x86/tigerlake/cache.json  |   65 +
>>  .../arch/x86/tigerlake/counter.json           |    7 +
>>  .../arch/x86/tigerlake/floating-point.json    |   13 +
>>  .../arch/x86/tigerlake/frontend.json          |   56 +
>>  .../pmu-events/arch/x86/tigerlake/memory.json |   31 +
>>  .../pmu-events/arch/x86/tigerlake/other.json  |    4 +
>>  .../arch/x86/tigerlake/pipeline.json          |   96 +
>>  .../x86/tigerlake/uncore-interconnect.json    |   11 +
>>  .../arch/x86/tigerlake/uncore-memory.json     |    6 +
>>  .../arch/x86/tigerlake/uncore-other.json      |    1 +
>>  .../arch/x86/tigerlake/virtual-memory.json    |   20 +
>>  tools/perf/pmu-events/jevents.py              |  179 +-
>>  tools/perf/pmu-events/pmu-events.h            |   26 +-
>>  tools/perf/util/metricgroup.c                 |  927 +++++++++
>>  tools/perf/util/metricgroup.h                 |   82 +
>>  tools/perf/util/pmu.c                         |    5 +
>>  tools/perf/util/pmu.h                         |    1 +
>>  tools/perf/util/stat.h                        |    1 +
>>  60 files changed, 13790 insertions(+), 25 deletions(-)
>>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/counter.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/counter.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.json
>>
>> --
>> 2.39.3
>>
