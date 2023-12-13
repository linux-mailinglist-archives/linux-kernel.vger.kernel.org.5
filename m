Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C3811F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442284AbjLMT4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjLMTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:55:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3332C19B3;
        Wed, 13 Dec 2023 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497281; x=1734033281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+nbyDHhgJ8++zxeQX/mgFJIqBXvnO0Gvfr2EtoiwJl0=;
  b=gK19i7CL2hq5/m+XZTo7SDNqKnZzffTMN6cTzkt6vbJJjNJlEOCzlRpx
   Gia0JQu+ZAg1RG9ZRqT/VzH6q6OC6CzVjjvnLsdspt5qt5EMZ9k7yy1VM
   U1rbplZlivT+GTh/U6TTmtCWzNGU6QD50jdNkriwL7T2yamlYItkemMj7
   O0VJqNgPfaMu9xGm/8vr7+mxYyvM1549W0FwCsKC6oyP7PBr2mHXPQYg+
   RN/X1yJ72ZAmJ6IymZwipPHv0kOyXg+hnKLuoPDSqssbuhJXrFjYQGFNv
   yxJnlFfcWbcz3/ZntoniO9Tb0ac8Ym3fjfxdUnxRkE1eb+rfrdjypFbiQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397802475"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="397802475"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774065511"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774065511"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:54:40 -0800
Received: from [10.212.117.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.117.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 92A81580DA9;
        Wed, 13 Dec 2023 11:54:37 -0800 (PST)
Message-ID: <ab50cc75-2273-47a3-a0c3-fa2d8f1d2fd3@linux.intel.com>
Date:   Wed, 13 Dec 2023 14:54:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/5] Clean up perf mem
Content-Language: en-US
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        john.g.garry@oracle.com, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>, yuhaixin.yhx@linux.alibaba.com,
        renyu.zj@linux.alibaba.com, Thomas Richter <tmricht@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <ZXIrtcYkvpA8Uwj1@kernel.org>
 <DC029166-B60F-4E90-833D-F43818A3C54B@linux.vnet.ibm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <DC029166-B60F-4E90-833D-F43818A3C54B@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-13 4:51 a.m., Athira Rajeev wrote:
> 
> 
>> On 08-Dec-2023, at 2:01 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> Em Thu, Dec 07, 2023 at 11:23:33AM -0800, kan.liang@linux.intel.com escreveu:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Changes since V1:
>>> - Fix strcmp of PMU name checking (Ravi)
>>> - Fix "/," typo (Ian)
>>> - Rename several functions with perf_pmu__mem_events prefix. (Ian)
>>> - Fold the header removal patch into the patch where the cleanups made.
>>>  (Arnaldo)
>>> - Add reviewed-by and tested-by from Ian and Ravi
>>
>> It would be good to have a Tested-by from people working in all the
>> architectures affectes, like we got from Ravi for AMD, can we get those?
>>
>> I'm applying it locally for test building, will push to
>> perf-tools-next/tmp.perf-tools-next for a while, so there is some time
>> to test.
>>
>> ARM64 (Leo?) and ppc, for PPC... humm Ravi did it, who could test it now?
> Hi Arnaldo, Ravi
> 
> Looking into this for testing on powerpc. Will update back.
>

Thanks Athira. I've sent out the latest V3. Please give it a try.

https://lore.kernel.org/lkml/20231213195154.1085945-1-kan.liang@linux.intel.com/

Thanks,
Kan

> Thanks
> Athira
>>
>> - Arnaldo
>>
>>> As discussed in the below thread, the patch set is to clean up perf mem.
>>> https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com/
>>>
>>> Introduce generic functions perf_mem_events__ptr(),
>>> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
>>> ARCH specific ones.
>>> Simplify the perf_mem_event__supported().
>>>
>>> Only keeps the ARCH-specific perf_mem_events array in the corresponding
>>> mem-events.c for each ARCH.
>>>
>>> There is no functional change.
>>>
>>> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
>>> etc. But I can only test it on two Intel platforms.
>>> Please give it try, if you have machines with other ARCHs.
>>>
>>> Here are the test results:
>>> Intel hybrid machine:
>>>
>>> $perf mem record -e list
>>> ldlat-loads  : available
>>> ldlat-stores : available
>>>
>>> $perf mem record -e ldlat-loads -v --ldlat 50
>>> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
>>>
>>> $perf mem record -v
>>> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
>>>
>>> $perf mem record -t store -v
>>> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
>>>
>>>
>>> Intel SPR:
>>> $perf mem record -e list
>>> ldlat-loads  : available
>>> ldlat-stores : available
>>>
>>> $perf mem record -e ldlat-loads -v --ldlat 50
>>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
>>>
>>> $perf mem record -v
>>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
>>>
>>> $perf mem record -t store -v
>>> calling: record -e cpu/mem-stores/P
>>>
>>> Kan Liang (5):
>>>  perf mem: Add mem_events into the supported perf_pmu
>>>  perf mem: Clean up perf_mem_events__ptr()
>>>  perf mem: Clean up perf_mem_events__name()
>>>  perf mem: Clean up perf_mem_event__supported()
>>>  perf mem: Clean up is_mem_loads_aux_event()
>>>
>>> tools/perf/arch/arm64/util/mem-events.c   |  36 +----
>>> tools/perf/arch/arm64/util/pmu.c          |   6 +
>>> tools/perf/arch/powerpc/util/mem-events.c |  13 +-
>>> tools/perf/arch/powerpc/util/mem-events.h |   7 +
>>> tools/perf/arch/powerpc/util/pmu.c        |  11 ++
>>> tools/perf/arch/s390/util/pmu.c           |   3 +
>>> tools/perf/arch/x86/util/mem-events.c     |  99 ++----------
>>> tools/perf/arch/x86/util/pmu.c            |  11 ++
>>> tools/perf/builtin-c2c.c                  |  28 +++-
>>> tools/perf/builtin-mem.c                  |  28 +++-
>>> tools/perf/util/mem-events.c              | 181 +++++++++++++---------
>>> tools/perf/util/mem-events.h              |  15 +-
>>> tools/perf/util/pmu.c                     |   4 +-
>>> tools/perf/util/pmu.h                     |   7 +
>>> 14 files changed, 233 insertions(+), 216 deletions(-)
>>> create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>>> create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>>>
>>> -- 
>>> 2.35.1
>>>
>>
>> -- 
>>
>> - Arnaldo
> 
> 
> 
