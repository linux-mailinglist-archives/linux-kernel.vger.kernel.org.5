Return-Path: <linux-kernel+bounces-78074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F74C860E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508821C24AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4F5D49E;
	Fri, 23 Feb 2024 09:48:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EFC5D471;
	Fri, 23 Feb 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681735; cv=none; b=YnthpCRAsUgB1ShvPqTRKBg0CWcd+KuXZzNhp+ccyZ5gfgKL5mLw2DHNveHMuAv5+j/TLmWX8PCqWUmjAkEhTNTZsD0vWTVQK0soL0n83CiCs3xxx5JFIRnVw1lnOs2LQlUvxiqBCQWnWoIi/a6nsRgtaagZfLojcsn/xrrw/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681735; c=relaxed/simple;
	bh=nRLPoamuIA2shnoR1FKakvBvVXEWTXJdoH6Txg+Qw14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prLllwhhXNBhizY52vgX2Y42v5eWU3QKft2yLshK/ikPdnW6JRukdYckvdKevZvgY/d3WYMbvQFG5tOofbxoyKbs0uWcFtd7jzV978S++782+TaM/+IgG9KclHuJB1mBfSKJiGF69vK6Gm1z2G0MOgtANw2XC1if64XoVenVlD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22E81596;
	Fri, 23 Feb 2024 01:49:29 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 096983F766;
	Fri, 23 Feb 2024 01:48:48 -0800 (PST)
Message-ID: <fdd82ddb-82bc-4c8c-86ef-c80505881013@arm.com>
Date: Fri, 23 Feb 2024 10:48:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Christian.Loehle@arm.com
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
 <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
 <20240220135037.qriyapwrznz2wdni@airbuntu>
 <d58de550-0ce1-4af9-9e2d-dedd5e73c797@arm.com>
 <20240222115557.blnm4uulkxnorrl4@airbuntu>
 <f4c3f028-b93e-4658-af28-ac2123203d68@arm.com>
 <20240222233947.sl435tvhhpe5iqzw@airbuntu>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240222233947.sl435tvhhpe5iqzw@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 00:39, Qais Yousef wrote:
> On 02/22/24 16:15, Pierre Gondois wrote:
> 
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 66cef33c4ec7..68a5ba24a5e0 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -576,6 +576,15 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>>>
>>>           latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>>>           if (latency) {
>>> +               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
>>> +
>>> +               /*
>>> +                * If the platform already has high transition_latency, use it
>>> +                * as-is.
>>> +                */
>>> +               if (latency > max_delay_us)
>> [1]  return min(latency, 10ms);
>>> +                       return latency;
>>> +
>>>                   /*
>>>                    * For platforms that can change the frequency very fast (< 10
>>>                    * us), the above formula gives a decent transition delay. But
>>> @@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>>>                    * a reasonable amount of time after which we should reevaluate
>>>                    * the frequency.
>>>                    */
>>> -               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
>>> +               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
>>>           }
>>>
>>>           return LATENCY_MULTIPLIER;
>>>
>>
>> A policy with these values:
>> - transition_delay_us = 0
>> - transition_latency = 30ms
>> would get a transition_delay of 30ms I think.
>>
>> Maybe it would be better to default to the old value in this case [1].
> 
> Hmm. I think it wouldn't make sense to have 2 levels of capping. It's either we
> cap to 2ms, or honour the transition latency from the driver if it is higher
> and let it lower it if it can truly handle smaller values?
> 
> Rafael, should I send a new version of the patch, a new patch on top or would
> you like to take a fixup if you can amend the commit? If you and Viresh think
> the two levels of capping make sense as suggested above let me know. I think
> better to delegate to the drivers if they report transition_latency higher than
> 2ms.

The latency can be computed by dev_pm_opp_get_max_transition_latency() and
one of its component comes from `clock-latency-ns` DT binding. The maximum value
I saw is 10ms, so it seems it should be ok not to add: `min(latency, 10ms)`


> 
> -->8--
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 66cef33c4ec7..668263c53810 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>   
>          latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>          if (latency) {
> +               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
> +
> +               /*
> +                * If the platform already has high transition_latency, use it
> +                * as-is.
> +                */
> +               if (latency > max_delay_us)
> +                       return latency;
> +
>                  /*
> -                * For platforms that can change the frequency very fast (< 10
> +                * For platforms that can change the frequency very fast (< 20

I think it should be 10->2us as we do:
   min(latency * 1000, 2ms)


>                   * us), the above formula gives a decent transition delay. But
>                   * for platforms where transition_latency is in milliseconds, it
>                   * ends up giving unrealistic values.
> @@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>                   * a reasonable amount of time after which we should reevaluate
>                   * the frequency.
>                   */
> -               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
> +               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
>          }
>   
>          return LATENCY_MULTIPLIER;
> 
> -->8--
> 
>>
>> ---
>>
>> Also a note that on the Pixel6 I have, transition_latency=5ms,
>> so the platform's policies would end up with transition_delay=5ms
> 
> Yes I know. But at this stage it's a driver issue. I think this value is not
> correct and there's a typo.
> 
>>
>>
>>>>
>>>>
>>>> 2.
>>>> There are references to the 10ms values at other places in the code:
>>>>
>>>> include/linux/cpufreq.h
>>>>    * ondemand governor will work on any processor with transition latency <= 10ms,
>>>
>>> Not sure this one needs updating. Especially with the change above which means
>>> 10ms could theoretically happen. But if there are suggestions happy to take
>>> them.
>>
>> a.
>> LATENCY_MULTIPLIER introduction:
>> 112124ab0a9f ("[CPUFREQ] ondemand/conservative: sanitize sampling_rate restrictions")
>>
>> b.
>> max_transition_latency removal:
>> ed4676e25463 ("cpufreq: Replace "max_transition_latency" with "dynamic_switching"")
>>
>> c.
>> dynamic_switching removal:
>> 9a2a9ebc0a75 ("cpufreq: Introduce governor flags")
>>
>> The value could be removed independently from this patch indeed, as this is not
>> related to cpufreq_policy_transition_delay_us() since b.
> 
> Thanks for sending the patch.
> 
>>
>>
>>>
>>>>
>>>> drivers/cpufreq/cpufreq.c
>>>>    * For platforms that can change the frequency very fast (< 10
>>>>    * us), the above formula gives a decent transition delay. But
>>>> -> the 10us value matches 10ms = 10us * LATENCY_MULTIPLIER
>>>
>>> I can't find this one.
>>
>> It's in cpufreq_policy_transition_delay_us(),
>>    "the 10us value matches 10ms = 10us * LATENCY_MULTIPLIER"
>> is a sentence I wrote, the comment to modify would be:
>> """
>> * For platforms that can change the frequency very fast (< 10
>> * us), the above formula gives a decent transition delay. But
>> """
> 
> Ah you were referring to s/10/20/. Done.
> 
>>
>>>
>>>>
>>>> Documentation/admin-guide/pm/cpufreq.rst
>>>>    Typically, it is set to values of the order of 10000 (10 ms).  Its
>>>>    default value is equal to the value of ``cpuinfo_transition_latency``
>>>
>>> I am not sure about this one. It refers to cpuinfo_transition_latency not the
>>> delay and uses a formula to calculate it based on that.
>>>
>>> Seems the paragraph needs updating in general to reflect other changes?
>>
>> aa7519af450d ("cpufreq: Use transition_delay_us for legacy governors as well")
>>
>> The cpufreq_policy_transition_delay_us() was introduced there and integrates the
>> 10ms value related to this paragraph.
>>
>> ---
>>
>> I assume that if we keep the 10ms value in the code, it should be ok to let
>> the comment as is. I'll send a patch to remove the first one as it can be
>> done independently.
> 
> Thanks!
> 
> --
> Qais Yousef

