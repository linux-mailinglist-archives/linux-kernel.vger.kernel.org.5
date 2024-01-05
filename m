Return-Path: <linux-kernel+bounces-17516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B37824EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CEB2846A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6763AF;
	Fri,  5 Jan 2024 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lng2EOyV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DB1D68C;
	Fri,  5 Jan 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4054qwcj000752;
	Fri, 5 Jan 2024 06:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UQcabtasED6YyQRtlveON93kfKhc0NA+dGnblGjUnDo=;
 b=lng2EOyViyLi0kiWyZDvrGQu7AA0o46p3ryMnCLCkB1PgjUXT1HibVeX6ui0qYPamz5B
 hpo++OiN7OIAwHKCrmKN7b8DQ9DFZXv1uE+T5aj2AV0ha6+lKicG5U/+1LCRZv2V1/8n
 QVxmDn3zgGQrGAVAQacv5fdaKct2xjRcuNxn6+zoFG8pfoG7dOzq9HUJ7vPuf5ShXfVw
 H6ws+iaKAg3Rmr0zKjSfTqkfhqJ8uF4epWwFSOkN94LjSwoF0IYLxqRj0vbJVPm5HIbr
 FbHZmJP8V1xHVj3yWJJvSxMkiL2yaVoL7gRPy7A+oHOQwIJ701IAXZvB45yxt8WUp3vB gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve75sf58p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 06:39:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4055pt4e016297;
	Fri, 5 Jan 2024 06:39:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve75sf57x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 06:39:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4056SBbV019327;
	Fri, 5 Jan 2024 06:39:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sw54r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 06:38:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4056cp3g32833808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 06:38:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1863E20063;
	Fri,  5 Jan 2024 06:38:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D663D2005A;
	Fri,  5 Jan 2024 06:38:46 +0000 (GMT)
Received: from [9.171.46.159] (unknown [9.171.46.159])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jan 2024 06:38:46 +0000 (GMT)
Message-ID: <057a1c19-3117-1aec-41d6-4950c599b862@linux.ibm.com>
Date: Fri, 5 Jan 2024 12:08:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 0/7] Clean up perf mem
To: "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
        irogers@google.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <a0abfee5-4dcd-3eb5-82fe-1a0dcdade038@linux.ibm.com>
 <befb6acd-86be-4255-af96-38865affc56c@linux.intel.com>
 <8bfadc86-e137-4a9f-a9ce-0bc62464c195@linux.intel.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <8bfadc86-e137-4a9f-a9ce-0bc62464c195@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZRmdHNq2a3gw6YD3VOZoBLN-MIHgfhiV
X-Proofpoint-GUID: btOFsyXGbKqO4PCdzXLTmz6TwPeRSz-c
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_02,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401050055



On 1/3/24 01:38, Liang, Kan wrote:
> Hi Kajol Jain
> 
> On 2023-12-19 9:15 a.m., Liang, Kan wrote:
>>
>>
>> On 2023-12-19 4:26 a.m., kajoljain wrote:
>>> Hi,
>>>   I was trying to test this patchset on powerpc.
>>>
>>> After applying it on top of acme's perf-tools-next branch, I am getting
>>> below error:
>>>
>>>   INSTALL libsubcmd_headers
>>>   INSTALL libperf_headers
>>>   INSTALL libsymbol_headers
>>>   INSTALL libapi_headers
>>>   INSTALL libbpf_headers
>>>   CC      arch/powerpc/util/mem-events.o
>>> In file included from arch/powerpc/util/mem-events.c:3:
>>> arch/powerpc/util/mem-events.h:5:52: error: ‘PERF_MEM_EVENTS__MAX’
>>> undeclared here (not in a function)
>>>     5 | extern struct perf_mem_event
>>> perf_mem_events_power[PERF_MEM_EVENTS__MAX];
>>>       |
>>> ^~~~~~~~~~~~~~~~~~~~
>>> make[6]: *** [/home/kajol/linux/tools/build/Makefile.build:105:
>>> arch/powerpc/util/mem-events.o] Error 1
>>> make[5]: *** [/home/kajol/linux/tools/build/Makefile.build:158: util]
>>> Error 2
>>> make[4]: *** [/home/kajol/linux/tools/build/Makefile.build:158: powerpc]
>>> Error 2
>>> make[3]: *** [/home/kajol/linux/tools/build/Makefile.build:158: arch]
>>> Error 2
>>> make[3]: *** Waiting for unfinished jobs....
>>> make[2]: *** [Makefile.perf:693: perf-in.o] Error 2
>>> make[1]: *** [Makefile.perf:251: sub-make] Error 2
>>> make: *** [Makefile:70: all] Error 2
>>>
>>> It seems some headerfiles are missing from arch/powerpc/util/mem-
>>> events.c
>>>
>>
>> Leo updated the headerfiles for ARM. https://termbin.com/0dkn
>>
>> I guess powerpc has to do the same thing. Could you please try the below
>> patch?
> 
> 
> Does the patch work on powerpc?

Hi Kan,
   Sorry I went for vacation so couldn't update. Yes this fix works. But
we have another issue, actually this patch set changes uses ldlat
attribute. But ldlat is not supported in powerpc because of which perf
mem is failing in powerpc.

I am looking into a work around to fix this issue. I will update the fix.

Thanks,
Kajol Jain


> 
> 
> Thanks,
> Kan
>>
>> diff --git a/tools/perf/arch/powerpc/util/mem-events.c
>> b/tools/perf/arch/powerpc/util/mem-events.c
>> index 72a6ac2b52f5..765d4a054b0a 100644
>> --- a/tools/perf/arch/powerpc/util/mem-events.c
>> +++ b/tools/perf/arch/powerpc/util/mem-events.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> -#include "map_symbol.h"
>> +#include "util/map_symbol.h"
>> +#include "util/mem-events.h"
>>  #include "mem-events.h"
>>
>>  #define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat
>> = l, .aux_event = a }
>>
>> Thanks,
>> Kan
>>
>>> Thanks,
>>> Kajol Jain
>>>
>>> On 12/14/23 01:21, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Changes since V2:
>>>> - Fix the Arm64 building error (Leo)
>>>> - Add two new patches to clean up perf_mem_events__record_args()
>>>>   and perf_pmus__num_mem_pmus() (Leo)
>>>>
>>>> Changes since V1:
>>>> - Fix strcmp of PMU name checking (Ravi)
>>>> - Fix "/," typo (Ian)
>>>> - Rename several functions with perf_pmu__mem_events prefix. (Ian)
>>>> - Fold the header removal patch into the patch where the cleanups made.
>>>>   (Arnaldo)
>>>> - Add reviewed-by and tested-by from Ian and Ravi
>>>>
>>>> As discussed in the below thread, the patch set is to clean up perf mem.
>>>> https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com/
>>>>
>>>> Introduce generic functions perf_mem_events__ptr(),
>>>> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
>>>> ARCH specific ones.
>>>> Simplify the perf_mem_event__supported().
>>>>
>>>> Only keeps the ARCH-specific perf_mem_events array in the corresponding
>>>> mem-events.c for each ARCH.
>>>>
>>>> There is no functional change.
>>>>
>>>> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
>>>> etc. But I can only test it on two Intel platforms.
>>>> Please give it try, if you have machines with other ARCHs.
>>>>
>>>> Here are the test results:
>>>> Intel hybrid machine:
>>>>
>>>> $perf mem record -e list
>>>> ldlat-loads  : available
>>>> ldlat-stores : available
>>>>
>>>> $perf mem record -e ldlat-loads -v --ldlat 50
>>>> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
>>>>
>>>> $perf mem record -v
>>>> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
>>>>
>>>> $perf mem record -t store -v
>>>> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
>>>>
>>>>
>>>> Intel SPR:
>>>> $perf mem record -e list
>>>> ldlat-loads  : available
>>>> ldlat-stores : available
>>>>
>>>> $perf mem record -e ldlat-loads -v --ldlat 50
>>>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
>>>>
>>>> $perf mem record -v
>>>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
>>>>
>>>> $perf mem record -t store -v
>>>> calling: record -e cpu/mem-stores/P
>>>>
>>>> Kan Liang (7):
>>>>   perf mem: Add mem_events into the supported perf_pmu
>>>>   perf mem: Clean up perf_mem_events__ptr()
>>>>   perf mem: Clean up perf_mem_events__name()
>>>>   perf mem: Clean up perf_mem_event__supported()
>>>>   perf mem: Clean up is_mem_loads_aux_event()
>>>>   perf mem: Clean up perf_mem_events__record_args()
>>>>   perf mem: Clean up perf_pmus__num_mem_pmus()
>>>>
>>>>  tools/perf/arch/arm/util/pmu.c            |   3 +
>>>>  tools/perf/arch/arm64/util/mem-events.c   |  39 +---
>>>>  tools/perf/arch/arm64/util/mem-events.h   |   7 +
>>>>  tools/perf/arch/powerpc/util/mem-events.c |  13 +-
>>>>  tools/perf/arch/powerpc/util/mem-events.h |   7 +
>>>>  tools/perf/arch/powerpc/util/pmu.c        |  11 ++
>>>>  tools/perf/arch/s390/util/pmu.c           |   3 +
>>>>  tools/perf/arch/x86/util/mem-events.c     |  99 ++--------
>>>>  tools/perf/arch/x86/util/mem-events.h     |  10 +
>>>>  tools/perf/arch/x86/util/pmu.c            |  19 +-
>>>>  tools/perf/builtin-c2c.c                  |  45 ++---
>>>>  tools/perf/builtin-mem.c                  |  48 ++---
>>>>  tools/perf/util/mem-events.c              | 217 +++++++++++++---------
>>>>  tools/perf/util/mem-events.h              |  19 +-
>>>>  tools/perf/util/pmu.c                     |   4 +-
>>>>  tools/perf/util/pmu.h                     |   7 +
>>>>  tools/perf/util/pmus.c                    |   6 -
>>>>  tools/perf/util/pmus.h                    |   1 -
>>>>  18 files changed, 278 insertions(+), 280 deletions(-)
>>>>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>>>>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>>>>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>>>>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
>>>>
>>>
>>

