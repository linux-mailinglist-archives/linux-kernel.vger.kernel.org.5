Return-Path: <linux-kernel+bounces-1436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F26814EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599671C24540
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A53010E;
	Fri, 15 Dec 2023 17:41:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB830104
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECDB9C15;
	Fri, 15 Dec 2023 09:42:32 -0800 (PST)
Received: from [10.57.4.221] (unknown [10.57.4.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B7E3F5A1;
	Fri, 15 Dec 2023 09:41:43 -0800 (PST)
Message-ID: <bd8a64fa-86d3-4417-a570-36469330508f@arm.com>
Date: Fri, 15 Dec 2023 17:41:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-22-james.morse@arm.com>
 <9084cb79-22bd-4cb3-b48d-f0d8d71aa47c@intel.com>
 <b077b38f-b42c-f679-1e08-70b55d116e17@arm.com>
 <9a66b7f8-097b-45af-97b2-4c403c295301@intel.com>
From: James Morse <james.morse@arm.com>
Autocrypt: addr=james.morse@arm.com; keydata=
 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
In-Reply-To: <9a66b7f8-097b-45af-97b2-4c403c295301@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/14/23 18:53, Reinette Chatre wrote:
> On 12/14/2023 3:38 AM, James Morse wrote:
>> On 09/11/2023 17:48, Reinette Chatre wrote:
>>> On 10/25/2023 11:03 AM, James Morse wrote:

>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index c4c1e1909058..f5fff2f0d866 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -61,19 +61,36 @@
>>>>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>>>>    *			        aren't marked nohz_full
>>>>    * @mask:	The mask to pick a CPU from.
>>>> + * @exclude_cpu:The CPU to avoid picking.
>>>>    *
>>>> - * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
>>>> - * nohz_full, these are preferred.
>>>> + * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
>>>> + * CPUs that don't use nohz_full, these are preferred. Pass
>>>> + * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
>>>> + *
>>>> + * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
>>>>    */
>>>> -static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>>>> +static inline unsigned int
>>>> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>>>   {
>>>>   	unsigned int cpu, hk_cpu;
>>>>   
>>>> -	cpu = cpumask_any(mask);
>>>> -	if (!tick_nohz_full_cpu(cpu))
>>>> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
>>>> +		cpu = cpumask_any(mask);
>>>> +	else
>>>> +		cpu = cpumask_any_but(mask, exclude_cpu);
>>>> +
>>>> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
>>>> +		return cpu;
>>>
>>> It is not clear to me how cpumask_any_but() failure is handled.
>>>
>>> cpumask_any_but() returns ">= nr_cpu_ids if no cpus set" ...
>>
>> It wasn't a satisfiable request, there are no CPUs for this domain other than the one that
>> was excluded. cpumask_any_but() also describes its errors as "returns >= nr_cpu_ids if no
>> CPUs are available".
>>
>> The places this can happen in resctrl are:
>> cqm_setup_limbo_handler(), where it causes the schedule_delayed_work_on() call to be skipped.
>> mbm_setup_overflow_handler(), which does similar.
>>
>> These two cases are triggered from resctrl_offline_cpu() when the last CPU in a domain is
>> going offline, and the domain is about to be free()d. This is how the limbo/overflow
>> 'threads' stop.

> Right ... yet this is a generic function, if there are any requirements on when/how it should
> be called then it needs to be specified in the function comments. I do not expect this to
> be the case for this function.

There are no special requirements, like all the other cpumask_foo() helpers, you can feed it
an empty bitmap and it will return '>= nr_cpu_ids' as an error.

[...]

>>> But that would have
>>> code continue ... so maybe it needs explicit error check of
>>> cpumask_any_but() failure with an earlier exit?
>>
>> I'm not sure what the problem you refer to here is.
>> If 'cpu' is valid, and not marked nohz_full, nothing more needs doing.
>> If 'cpu' is invalid or a CPU marked nohz_full, then a second attempt is made to find a
>> housekeeping CPU into 'hk_cpu'. If the second attempt is valid, it's used in preference.
> 
> Considering that the second attempt can only be on the same or smaller set of CPUs,
> how could the second attempt ever succeed if the first attempt failed? I do not see
> why it is worth continuing.

Its harmless, its not on a performance sensitive path and it would take extra logic in the
more common cases to detect this and return early.


Thanks,

James

