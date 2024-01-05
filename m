Return-Path: <linux-kernel+bounces-17943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D1825577
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264CC1F2262F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403622DF9C;
	Fri,  5 Jan 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEKgchZb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597C2D051;
	Fri,  5 Jan 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704465494; x=1736001494;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YSFQbND0a5XHp3w2R3jjRw9deEhCemu4BH2VtgO1wcM=;
  b=bEKgchZbr8yxOTV0cNTk0S3DKv4w4IlDXWPYiwrlsrg+il4aKVeSkvow
   tOC/8vJZ5xozww4X9DFViCc4Dx+Csm8p8hhjBiqeN9s2cmk1WvDCWcnhI
   ifpI5bF2cmk1pjsR3gG5kOr6sypitRasSeNHOZfNNgeEriDU6icCmbrb9
   GAKudVJ8UcT+tg5Sf0OZyASyNPYkJr1ekuUdsPIdqCmWiO9laXztNwtfd
   IysAbDx3s3VFkVnJbSEkcbjxjk2kYCB6P6ORfeI/zDnUIToEqSUBc83P6
   VybID3qizd8uH2FDgOMcMgGUy74YppWwG8Vx/+DmyFSpb5A12cnOuU6Hb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="397236835"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="397236835"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:38:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="924233638"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="924233638"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:38:12 -0800
Received: from [10.212.120.196] (kliang2-mobl1.ccr.corp.intel.com [10.212.120.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 12F7E580D25;
	Fri,  5 Jan 2024 06:38:09 -0800 (PST)
Message-ID: <692e16f9-062c-4b3c-bd66-a16bac68216c@linux.intel.com>
Date: Fri, 5 Jan 2024 09:38:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] Clean up perf mem
To: kajoljain <kjain@linux.ibm.com>, acme@kernel.org, irogers@google.com,
 peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
 will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
 leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com,
 renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com,
 atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <a0abfee5-4dcd-3eb5-82fe-1a0dcdade038@linux.ibm.com>
 <befb6acd-86be-4255-af96-38865affc56c@linux.intel.com>
 <8bfadc86-e137-4a9f-a9ce-0bc62464c195@linux.intel.com>
 <057a1c19-3117-1aec-41d6-4950c599b862@linux.ibm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <057a1c19-3117-1aec-41d6-4950c599b862@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-01-05 1:38 a.m., kajoljain wrote:
> 
> 
> On 1/3/24 01:38, Liang, Kan wrote:
>> Hi Kajol Jain
>>
>> On 2023-12-19 9:15 a.m., Liang, Kan wrote:
>>>
>>>
>>> On 2023-12-19 4:26 a.m., kajoljain wrote:
>>>> Hi,
>>>>   I was trying to test this patchset on powerpc.
>>>>
>>>> After applying it on top of acme's perf-tools-next branch, I am getting
>>>> below error:
>>>>
>>>>   INSTALL libsubcmd_headers
>>>>   INSTALL libperf_headers
>>>>   INSTALL libsymbol_headers
>>>>   INSTALL libapi_headers
>>>>   INSTALL libbpf_headers
>>>>   CC      arch/powerpc/util/mem-events.o
>>>> In file included from arch/powerpc/util/mem-events.c:3:
>>>> arch/powerpc/util/mem-events.h:5:52: error: ‘PERF_MEM_EVENTS__MAX’
>>>> undeclared here (not in a function)
>>>>     5 | extern struct perf_mem_event
>>>> perf_mem_events_power[PERF_MEM_EVENTS__MAX];
>>>>       |
>>>> ^~~~~~~~~~~~~~~~~~~~
>>>> make[6]: *** [/home/kajol/linux/tools/build/Makefile.build:105:
>>>> arch/powerpc/util/mem-events.o] Error 1
>>>> make[5]: *** [/home/kajol/linux/tools/build/Makefile.build:158: util]
>>>> Error 2
>>>> make[4]: *** [/home/kajol/linux/tools/build/Makefile.build:158: powerpc]
>>>> Error 2
>>>> make[3]: *** [/home/kajol/linux/tools/build/Makefile.build:158: arch]
>>>> Error 2
>>>> make[3]: *** Waiting for unfinished jobs....
>>>> make[2]: *** [Makefile.perf:693: perf-in.o] Error 2
>>>> make[1]: *** [Makefile.perf:251: sub-make] Error 2
>>>> make: *** [Makefile:70: all] Error 2
>>>>
>>>> It seems some headerfiles are missing from arch/powerpc/util/mem-
>>>> events.c
>>>>
>>>
>>> Leo updated the headerfiles for ARM. https://termbin.com/0dkn
>>>
>>> I guess powerpc has to do the same thing. Could you please try the below
>>> patch?
>>
>>
>> Does the patch work on powerpc?
> 
> Hi Kan,
>    Sorry I went for vacation so couldn't update. Yes this fix works. 

Thanks for the update.

> But
> we have another issue, actually this patch set changes uses ldlat
> attribute. But ldlat is not supported in powerpc because of which perf
> mem is failing in powerpc.

For powerpc, the patch 3 introduced a perf_mem_events_power, which
doesn't have ldlat. But it only be assigned to the pmu->is_core. I'm not
sure if it's the problem.
Also, S390 still uses the default perf_mem_events, which includes ldlat.
I'm not sure if S390 supports the ldlat.

Thanks,
Kan
> 
> I am looking into a work around to fix this issue. I will update the fix.
> 
> Thanks,
> Kajol Jain
> 
> 
>>
>>
>> Thanks,
>> Kan
>>>
>>> diff --git a/tools/perf/arch/powerpc/util/mem-events.c
>>> b/tools/perf/arch/powerpc/util/mem-events.c
>>> index 72a6ac2b52f5..765d4a054b0a 100644
>>> --- a/tools/perf/arch/powerpc/util/mem-events.c
>>> +++ b/tools/perf/arch/powerpc/util/mem-events.c
>>> @@ -1,5 +1,6 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>> -#include "map_symbol.h"
>>> +#include "util/map_symbol.h"
>>> +#include "util/mem-events.h"
>>>  #include "mem-events.h"
>>>
>>>  #define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat
>>> = l, .aux_event = a }
>>>
>>> Thanks,
>>> Kan
>>>
>>>> Thanks,
>>>> Kajol Jain
>>>>
>>>> On 12/14/23 01:21, kan.liang@linux.intel.com wrote:
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> Changes since V2:
>>>>> - Fix the Arm64 building error (Leo)
>>>>> - Add two new patches to clean up perf_mem_events__record_args()
>>>>>   and perf_pmus__num_mem_pmus() (Leo)
>>>>>
>>>>> Changes since V1:
>>>>> - Fix strcmp of PMU name checking (Ravi)
>>>>> - Fix "/," typo (Ian)
>>>>> - Rename several functions with perf_pmu__mem_events prefix. (Ian)
>>>>> - Fold the header removal patch into the patch where the cleanups made.
>>>>>   (Arnaldo)
>>>>> - Add reviewed-by and tested-by from Ian and Ravi
>>>>>
>>>>> As discussed in the below thread, the patch set is to clean up perf mem.
>>>>> https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com/
>>>>>
>>>>> Introduce generic functions perf_mem_events__ptr(),
>>>>> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
>>>>> ARCH specific ones.
>>>>> Simplify the perf_mem_event__supported().
>>>>>
>>>>> Only keeps the ARCH-specific perf_mem_events array in the corresponding
>>>>> mem-events.c for each ARCH.
>>>>>
>>>>> There is no functional change.
>>>>>
>>>>> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
>>>>> etc. But I can only test it on two Intel platforms.
>>>>> Please give it try, if you have machines with other ARCHs.
>>>>>
>>>>> Here are the test results:
>>>>> Intel hybrid machine:
>>>>>
>>>>> $perf mem record -e list
>>>>> ldlat-loads  : available
>>>>> ldlat-stores : available
>>>>>
>>>>> $perf mem record -e ldlat-loads -v --ldlat 50
>>>>> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
>>>>>
>>>>> $perf mem record -v
>>>>> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
>>>>>
>>>>> $perf mem record -t store -v
>>>>> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
>>>>>
>>>>>
>>>>> Intel SPR:
>>>>> $perf mem record -e list
>>>>> ldlat-loads  : available
>>>>> ldlat-stores : available
>>>>>
>>>>> $perf mem record -e ldlat-loads -v --ldlat 50
>>>>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
>>>>>
>>>>> $perf mem record -v
>>>>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
>>>>>
>>>>> $perf mem record -t store -v
>>>>> calling: record -e cpu/mem-stores/P
>>>>>
>>>>> Kan Liang (7):
>>>>>   perf mem: Add mem_events into the supported perf_pmu
>>>>>   perf mem: Clean up perf_mem_events__ptr()
>>>>>   perf mem: Clean up perf_mem_events__name()
>>>>>   perf mem: Clean up perf_mem_event__supported()
>>>>>   perf mem: Clean up is_mem_loads_aux_event()
>>>>>   perf mem: Clean up perf_mem_events__record_args()
>>>>>   perf mem: Clean up perf_pmus__num_mem_pmus()
>>>>>
>>>>>  tools/perf/arch/arm/util/pmu.c            |   3 +
>>>>>  tools/perf/arch/arm64/util/mem-events.c   |  39 +---
>>>>>  tools/perf/arch/arm64/util/mem-events.h   |   7 +
>>>>>  tools/perf/arch/powerpc/util/mem-events.c |  13 +-
>>>>>  tools/perf/arch/powerpc/util/mem-events.h |   7 +
>>>>>  tools/perf/arch/powerpc/util/pmu.c        |  11 ++
>>>>>  tools/perf/arch/s390/util/pmu.c           |   3 +
>>>>>  tools/perf/arch/x86/util/mem-events.c     |  99 ++--------
>>>>>  tools/perf/arch/x86/util/mem-events.h     |  10 +
>>>>>  tools/perf/arch/x86/util/pmu.c            |  19 +-
>>>>>  tools/perf/builtin-c2c.c                  |  45 ++---
>>>>>  tools/perf/builtin-mem.c                  |  48 ++---
>>>>>  tools/perf/util/mem-events.c              | 217 +++++++++++++---------
>>>>>  tools/perf/util/mem-events.h              |  19 +-
>>>>>  tools/perf/util/pmu.c                     |   4 +-
>>>>>  tools/perf/util/pmu.h                     |   7 +
>>>>>  tools/perf/util/pmus.c                    |   6 -
>>>>>  tools/perf/util/pmus.h                    |   1 -
>>>>>  18 files changed, 278 insertions(+), 280 deletions(-)
>>>>>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>>>>>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>>>>>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>>>>>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
>>>>>
>>>>
>>>
> 

