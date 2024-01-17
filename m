Return-Path: <linux-kernel+bounces-28666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D1830198
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDBF1F25E73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F9C1400A;
	Wed, 17 Jan 2024 08:54:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032FD13FE4;
	Wed, 17 Jan 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481697; cv=none; b=s7nmvUsNHmb9BCm5lRW5pdWP5c5PVXVwFL6VJVsJUShHKiI/K3fv+EQl2AJDrPLKU00Gwn13/XHFKbHFKYifOnJPSGFsTU9eaPQh96M4m6VRAGSsfrQAsN8XWhr7amradCKuQ9dk7a6nICyt2Fk7fTRbJGNOE9yVRQqi/o2cEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481697; c=relaxed/simple;
	bh=uMbYQTxMbnF5Ux4BJr4laQXlIRlRDBq2XV0W5Adg6mg=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=jd+RxOD56tB9sZEWHf/17reUXsw5dS8WlMUR3oBI40sv5fre0DNgB6ZClcl13y3Xam0hyil/0VeaEgjHU8jW5xAKg6BgUgIxstpiu3nOnuk2R6nwqCVJ9aQ4E+3E6quweTkoYeXcRsz5CU6UlRFqy9DX0/sB2D6uIaiaUvUu63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TFKRn05mQzsR3r;
	Wed, 17 Jan 2024 16:53:57 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 8065318005E;
	Wed, 17 Jan 2024 16:54:50 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 16:54:49 +0800
Message-ID: <bbb13bcf-b7d9-05f7-cd8b-9a97e56dc2f6@huawei.com>
Date: Wed, 17 Jan 2024 16:54:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
CC: Ionela Voinescu <ionela.voinescu@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<rafael@kernel.org>, <beata.michalska@arm.com>, <sumitg@nvidia.com>,
	<zengheng4@huawei.com>, <yang@os.amperecomputing.com>, <will@kernel.org>,
	<sudeep.holla@arm.com>, <liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20231212072617.14756-1-lihuisong@huawei.com>
 <ZZWfJOsDlEXWYHA5@arm.com> <9428a1ed-ba4d-1fe6-63e8-11e152bf1f09@huawei.com>
 <lnocwcitdbmgcyhd2dlczgdlhtfw4pfot2br2i3hqscnvr3xgq@nuxlauxum3nr>
 <d0f47e9d-6a58-8b46-89be-b3182abb69f0@huawei.com> <ZZwAmqp6hcmMF8aN@arm.com>
 <6505bdcb-5a5f-cba6-483b-75c51414a9c6@huawei.com>
 <sx74toxx4ce2jayhvganvhrbkmoi7dnsk3hbzpcbco5wgxk3fo@2r46yhmsgfp4>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <sx74toxx4ce2jayhvganvhrbkmoi7dnsk3hbzpcbco5wgxk3fo@2r46yhmsgfp4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/1/13 2:33, Vanshidhar Konda 写道:
> On Wed, Jan 10, 2024 at 03:09:48PM +0800, lihuisong (C) wrote:
>> Hi Ionela,
>>
>> 在 2024/1/8 22:03, Ionela Voinescu 写道:
>>> Hi,
>>>
>>> On Friday 05 Jan 2024 at 15:04:47 (+0800), lihuisong (C) wrote:
>>>> Hi Vanshi,
>>>>
>>>> 在 2024/1/5 8:48, Vanshidhar Konda 写道:
>>>>> On Thu, Jan 04, 2024 at 05:36:51PM +0800, lihuisong (C) wrote:
>>>>>> 在 2024/1/4 1:53, Ionela Voinescu 写道:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tuesday 12 Dec 2023 at 15:26:17 (+0800), Huisong Li wrote:
>>>>>>>> Many developers found that the cpu current frequency is greater 
>>>>>>>> than
>>>>>>>> the maximum frequency of the platform, please see [1], [2] and 
>>>>>>>> [3].
>>>>>>>>
>>>>>>>> In the scenarios with high memory access pressure, the patch 
>>>>>>>> [1] has
>>>>>>>> proved the significant latency of cpc_read() which is used to 
>>>>>>>> obtain
>>>>>>>> delivered and reference performance counter cause an absurd 
>>>>>>>> frequency.
>>>>>>>> The sampling interval for this counters is very critical and
>>>>>>>> is expected
>>>>>>>> to be equal. However, the different latency of cpc_read() has a 
>>>>>>>> direct
>>>>>>>> impact on their sampling interval.
>>>>>>>>
>>>>>>> Would this [1] alternative solution work for you?
>>>>>> It would work for me AFAICS.
>>>>>> Because the "arch_freq_scale" is also from AMU core and constant
>>>>>> counter, and read together.
>>>>>> But, from their discuss line, it seems that there are some tricky
>>>>>> points to clarify or consider.
>>>>> I think the changes in [1] would work better when CPUs may be 
>>>>> idle. With
>>>>> this
>>>>> patch we would have to wake any core that is in idle state to read 
>>>>> the
>>>>> AMU
>>>>> counters. Worst case, if core 0 is trying to read the CPU 
>>>>> frequency of
>>>>> all
>>>>> cores, it may need to wake up all the other cores to read the AMU
>>>>> counters.
>>>> From the approach in [1], if all CPUs (one or more cores) under one 
>>>> policy
>>>> are idle, they still cannot be obtained the CPU frequency, right?
>>>> In this case, the [1] API will return 0 and have to back to call
>>>> cpufreq_driver->get() for cpuinfo_cur_freq.
>>>> Then we still need to face the issue this patch mentioned.
>>> With the implementation at [1], arch_freq_get_on_cpu() will not 
>>> return 0
>>> for idle CPUs and the get() callback will not be called to wake up the
>>> CPUs.
>> Right, arch_freq_get_on_cpu() will not return 0 for idle CPUs.
>> However, for no-housekeeping CPUs, it will return 0 and have to call 
>> get() callback, right?
>>>
>>> Worst case, arch_freq_get_on_cpu() will return a frequency based on the
>>> AMU counter values obtained on the last tick on that CPU. But if 
>>> that CPU
>>> is not a housekeeping CPU, a housekeeping CPU in the same policy 
>>> will be
>>> selected, as it would have had a more recent tick, and therefore a more
>>> recent frequency value for the domain.
>> But this frequency is from the last tick,
>> this last tick is probably a long time ago and it doesn't update 
>> 'arch_freq_scale' for some reasons like CPU dile.
>> In addition, I'm not sure if there is possible that 
>> amu_scale_freq_tick() is executed delayed under high stress case.
>> It also have an impact on the accuracy of the cpu frequency we query.
>>>
>>> I understand that the frequency returned here will not be up to date,
>>> but there's no proper frequency feedback for an idle CPU. If one only
>>> wakes up a CPU to sample counters, before the CPU goes back to sleep,
>>> the obtained frequency feedback is meaningless.
>>>
>>>>> For systems with 128 cores or more, this could be very expensive and
>>>>> happen
>>>>> very frequently.
>>>>>
>>>>> AFAICS, the approach in [1] would avoid this cost.
>>>> But the CPU frequency is just an average value for the last tick 
>>>> period
>>>> instead of the current one the CPU actually runs at.
>>>> In addition, there are some conditions to use 'arch_freq_scale' in 
>>>> this
>>>> approach.
>>> What are the conditions you are referring to?
>> It depends on the housekeeping CPUs.
>>>
>>>> So I'm not sure if this approach can entirely cover the frequency
>>>> discrepancy issue.
>>> Unfortunately there is no perfect frequency feedback. By the time you
>>> observe/use the value of scaling_cur_freq/cpuinfo_cur_freq, the 
>>> frequency
>>> of the CPU might have already changed. Therefore, an average value 
>>> might
>>> be a better indication of the recent performance level of a CPU.
>> An average value for CPU frequency is ok. It may be better if it has 
>> not any delaying.
>>
>> The original implementation for cpuinfo_cur_freq can more reflect their
>> meaning in the user-guide [1]. The user-guide said:
>> "cpuinfo_cur_freq : Current frequency of the CPU as obtained from the 
>> hardware, in KHz.
>> This is the frequency the CPU actually runs at."
>>
>>
>> [1]https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt
>>
>>>
>>> Would you be able to test [1] on your platform and usecase?
>> I has tested it on my platform (CPU number: 64, SMT: off and CPU base 
>> frequency: 2.7GHz).
>> Accoding to the testing result,
>> 1> I found that patch [1] and [2] cannot cover the no housekeeping 
>> CPUs. They still have to face the large frequency discrepancy issue 
>> my patch mentioned.
>> 2> Additionally, the frequency value of all CPUs are almost the same 
>> by using the 'arch_freq_scale' factor way. I'm not sure if it is ok.
>>
>> The patch [1] has been modified silightly as below:
>> -->
>> @@ -1756,7 +1756,10 @@ static unsigned int 
>> cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>  {
>>         unsigned int new_freq;
>>
>> -       new_freq = cpufreq_driver->get(policy->cpu);
>> +       new_freq = arch_freq_get_on_cpu(policy->cpu);
>> +       if (!new_freq)
>> +               new_freq = cpufreq_driver->get(policy->cpu);
>> +
>>         if (!new_freq)
>>                 return 0;
>>
>> And the result is as follows:
>> *case 1:**No setting the nohz_full and cpufreq use performance governor*
>> *--> Step1: *read 'cpuinfo_cur_freq' in no pressure
>>   0: 2699264     2: 2699264     4: 2699264     6: 2699264
>>   8: 2696628    10: 2696628    12: 2696628    14: 2699264
>>  16: 2699264    18: 2696628    20: 2699264    22: 2696628
>>  24: 2699264    26: 2696628    28: 2699264    30: 2696628
>>  32: 2696628    34: 2696628    36: 2696628    38: 2696628
>>  40: 2699264    42: 2699264    44: 2696628    46: 2696628
>>  48: 2696628    50: 2699264    52: 2699264    54: 2696628
>>  56: 2696628    58: 2696628    60: 2696628    62: 2696628
>>  64: 2696628    66: 2699264    68: 2696628    70: 2696628
>>  72: 2699264    74: 2696628    76: 2696628    78: 2699264
>>  80: 2696628    82: 2696628    84: 2699264    86: 2696628
>>  88: 2696628    90: 2696628    92: 2696628    94: 2699264
>>  96: 2696628    98: 2699264   100: 2699264   102: 2696628
>> 104: 2699264   106: 2699264   108: 2699264   110: 2696628
>> 112: 2699264   114: 2699264   116: 2699264   118: 2699264
>> 120: 2696628   122: 2699264   124: 2696628   126: 2699264
>> Note: the frequency of all CPUs are almost the same.
>>
>> *--> Step 2: *read 'cpuinfo_cur_freq' in the high memory access 
>> pressure.
>>   0: 2696628     2: 2696628     4: 2696628     6: 2696628
>>   8: 2696628    10: 2696628    12: 2696628    14: 2696628
>>  16: 2696628    18: 2696628    20: 2696628    22: 2696628
>>  24: 2696628    26: 2696628    28: 2696628    30: 2696628
>>  32: 2696628    34: 2696628    36: 2696628    38: 2696628
>>  40: 2696628    42: 2696628    44: 2696628    46: 2696628
>>  48: 2696628    50: 2696628    52: 2696628    54: 2696628
>>  56: 2696628    58: 2696628    60: 2696628    62: 2696628
>>  64: 2696628    66: 2696628    68: 2696628    70: 2696628
>>  72: 2696628    74: 2696628    76: 2696628    78: 2696628
>>  80: 2696628    82: 2696628    84: 2696628    86: 2696628
>>  88: 2696628    90: 2696628    92: 2696628    94: 2696628
>>  96: 2696628    98: 2696628   100: 2696628   102: 2696628
>> 104: 2696628   106: 2696628   108: 2696628   110: 2696628
>> 112: 2696628   114: 2696628   116: 2696628   118: 2696628
>> 120: 2696628   122: 2696628   124: 2696628   126: 2696628
>>
>> *Case 2: setting nohz_full and cpufreq use ondemand governor*
>> There is "isolcpus=1-10,41-50 nohz_full=1-10,41-50 
>> rcu_nocbs=1-10,41-50" in /proc/cmdline.
>> *--> Step 1: *setting ondemand governor to all policy and query 
>> 'cpuinfo_cur_freq' in no pressure case.
>> And the frequency of CPUs all are about 400MHz.
>> *--> Step 2:* read 'cpuinfo_cur_freq' in the high memory access 
>> pressure.
>> The high memory access pressure is from the command: "stress-ng -c 64 
>> --cpu-load 100% --taskset 0-63"
>> The result:
>>  0: 2696628     1:  400000     2:  400000     3:  400909
>>  4:  400000     5:  400000     6:  400000     7:  400000
>>  8:  400000     9:  400000    10:  400600    11: 2696628
>> 12: 2696628    13: 2696628    14: 2696628    15: 2696628
>> 16: 2696628    17: 2696628    18: 2696628    19: 2696628
>> 20: 2696628    21: 2696628    22: 2696628    23: 2696628
>> 24: 2696628    25: 2696628    26: 2696628    27: 2696628
>> 28: 2696628    29: 2696628    30: 2696628    31: 2696628
>> 32: 2696628    33: 2696628    34: 2696628    35: 2696628
>> 36: 2696628    37: 2696628    38: 2696628    39: 2696628
>> 40: 2696628    41:  400000    42:  400000    43:  400000
>> 44:  400000    45:  398847    46:  400000    47:  400000
>> 48:  400000    49:  400000    50:  400000    51: 2696628
>> 52: 2696628    53: 2696628    54: 2696628    55: 2696628
>> 56: 2696628    57: 2696628    58: 2696628    59: 2696628
>> 60: 2696628    61: 2696628    62: 2696628    63: 2699264
>>
>> Note:
>> (1) The frequency of 1-10 and 41-50 CPUs work on the lowest frequency.
>>      It turned out that nohz full was already work.
>>      I guess that stress-ng cannot use the CPU in the range of nohz 
>> full.
>>      Because the CPU frequency will be increased to 2.7G by binding 
>> CPU to other application.
>> (2) The frequency of the nohz full core is calculated by get() 
>> callback according to ftrace.
>
> I think this is a good point. It is possible that on large core count
> systems a number of CPUs are isolated and don't have a kernel tick. The
> approach in [1] won't work for those CPUs. The changes proposed in this
> patch make sure that regardless of the scheduler or governor
> configuration, the CPU frequency reporting will be correct.
>
> My concerns with this approach:
> 1. We will wake up idle CPUs and query the AMU counters.
>    a. This may not reflect the CPU frequency at the time the CPU was
>    running. For example, CPU was running at 2.7 GHz, then became idle and
>    invoked WFI. The CPU implementation reduces the CPU frequency to 400
>    MHz when it enters WFI. Now if we wake up the CPU to query the
>    frequency, it will return 400 MHz. This might be misleading.
>
>    b. It wastes energy as we may wake up cores just to query frequency
>    and then have them go back to idle.
Waking up an idle CPU to query CPU frequency and then going back to idle 
wastes energy.
The frequency of the idle CPUs may be is zero, but we cannot display 
zero because it is not friendly for user.
If we use the cached counter as the frequency feedback before CPU being 
idle, it cannot reflect a real frequency on CPU.
So there is no perfect frequency feedback for idle CPUs.
>
>    To solve this, may be we can cache the value of AMU counters; return
>    the cached value of the AMU counter if the CPU is idle.
The "arch_freq_scale" which is from AMU counters is similar to the 
cached value in Beata's approach.
But it just work for the housekeeping CPUs with tick.
If using cached frequency is ok, how shoud we do for nohz full CPUs? I 
have no good idea.
>
> 2. I think the acpi_cppc should use FFH registers only if the firmware
>    publishes FFH support for both the delivered and reference counters.
>    That way the system designer (through firmware) can control if the
>    FFH registers are used for computing frequency.
Right, so this patch have to judge if support FFH.
>
> [1] 
> https://lore.kernel.org/lkml/20231127160838.1403404-3-beata.michalska@arm.com/
>
> Thanks,
> Vanshidhar
>
>>
>> [1] 
>> https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
>> [2] 
>> https://lore.kernel.org/lkml/20231127160838.1403404-3-beata.michalska@arm.com/
>>>
>>> Many thanks,
>>> Ionela.
>>>
>>>> /Huisong
>>>>
>>>>>>> [1] 
>>>>>>> https://lore.kernel.org/lkml/20231127160838.1403404-1-beata.michalska@arm.com/
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Ionela.
>>>>>>>
>>>>>>>> This patch adds a interface, cpc_read_arch_counters_on_cpu, to 
>>>>>>>> read
>>>>>>>> delivered and reference performance counter together. According 
>>>>>>>> to my
>>>>>>>> test[4], the discrepancy of cpu current frequency in the
>>>>>>>> scenarios with
>>>>>>>> high memory access pressure is lower than 0.2% by stress-ng
>>>>>>>> application.
>>>>>>>>
>>>>>>>> [1] 
>>>>>>>> https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
>>>>>>>> [2] 
>>>>>>>> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
>>>>>>>> [3]
>>>>>>>> https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/ 
>>>>>>>>
>>>>>>>>
>>>>>>>> [4] My local test:
>>>>>>>> The testing platform enable SMT and include 128 logical CPU in 
>>>>>>>> total,
>>>>>>>> and CPU base frequency is 2.7GHz. Reading "cpuinfo_cur_freq" 
>>>>>>>> for each
>>>>>>>> physical core on platform during the high memory access 
>>>>>>>> pressure from
>>>>>>>> stress-ng, and the output is as follows:
>>>>>>>>   0: 2699133     2: 2699942     4: 2698189     6: 2704347
>>>>>>>>   8: 2704009    10: 2696277    12: 2702016    14: 2701388
>>>>>>>>  16: 2700358    18: 2696741    20: 2700091    22: 2700122
>>>>>>>>  24: 2701713    26: 2702025    28: 2699816    30: 2700121
>>>>>>>>  32: 2700000    34: 2699788    36: 2698884    38: 2699109
>>>>>>>>  40: 2704494    42: 2698350    44: 2699997    46: 2701023
>>>>>>>>  48: 2703448    50: 2699501    52: 2700000    54: 2699999
>>>>>>>>  56: 2702645    58: 2696923    60: 2697718    62: 2700547
>>>>>>>>  64: 2700313    66: 2700000    68: 2699904    70: 2699259
>>>>>>>>  72: 2699511    74: 2700644    76: 2702201    78: 2700000
>>>>>>>>  80: 2700776    82: 2700364    84: 2702674    86: 2700255
>>>>>>>>  88: 2699886    90: 2700359    92: 2699662    94: 2696188
>>>>>>>>  96: 2705454    98: 2699260   100: 2701097   102: 2699630
>>>>>>>> 104: 2700463   106: 2698408   108: 2697766   110: 2701181
>>>>>>>> 112: 2699166   114: 2701804   116: 2701907   118: 2701973
>>>>>>>> 120: 2699584   122: 2700474   124: 2700768   126: 2701963
>>>>>>>>
>>>>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>>>>>> ---
>> [snip]
>>> .
> .

