Return-Path: <linux-kernel+bounces-1435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A828E814EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6058F2887B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676030114;
	Fri, 15 Dec 2023 17:41:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071630115
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72BEAC15;
	Fri, 15 Dec 2023 09:41:47 -0800 (PST)
Received: from [10.57.4.221] (unknown [10.57.4.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8873F5A1;
	Fri, 15 Dec 2023 09:40:57 -0800 (PST)
Message-ID: <6aed34de-99ab-4601-ba4b-0870992c5da1@arm.com>
Date: Fri, 15 Dec 2023 17:40:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
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
 <20231025180345.28061-3-james.morse@arm.com>
 <208c3ade-a8c3-41cc-b136-4ab9b7e938e5@intel.com>
 <bd3afbfd-3372-cac9-600e-ace19ddd3199@arm.com>
 <cddbbbae-599b-42c0-abe1-4ca74d5ce36c@intel.com>
 <a5ef6b40-a9b3-5338-a12a-6a4540cda861@arm.com>
 <c53872e2-1d2e-44b3-80f1-e39fb0a7330d@intel.com>
From: James Morse <james.morse@arm.com>
Autocrypt: addr=james.morse@arm.com; keydata=
 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
In-Reply-To: <c53872e2-1d2e-44b3-80f1-e39fb0a7330d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/14/23 19:06, Reinette Chatre wrote:
> On 12/14/2023 10:28 AM, James Morse wrote:
>> On 13/12/2023 23:27, Reinette Chatre wrote:
>>> On 12/13/2023 10:03 AM, James Morse wrote:
>>>> On 09/11/2023 17:39, Reinette Chatre wrote:
>>>>> I expect cleanup to do the inverse of init. I do not know what was the
>>>>> motivation for the rdtgroup_exit() to follow cpuhp_remove_state()
>>>>
>>>> This will invoke the hotplug callbacks, making it look to resctrl like all CPUs are
>>>> offline. This means it is then impossible for rdtgroup_exit() to race with the hotplug
>>>> notifiers. (if you could run this code...)
>>
>>> hmmm ... if there is a risk of such a race would the init code not also be
>>> vulnerable to that with the notifiers up before rdtgroup_init()?
>>
>> Nope, because this array is allocated behind rdt_get_mon_l3_config(), which ultimately
>> comes from get_rdt_resources() in resctrl_late_init() - which calls cpuhp_setup_state()
>> after all this init work has been done.
>>
>> (cpu hp always gives me a headache1)
> 
> Right. My comment was actually and specifically about rdtgroup_init() and attempting to
> understand your view of its races with the hotplug notifiers in response to your comment about
> its (the hotplug notifiers) races with rdtgroup_exit().
> 
> The current order of state initialization you mention and hotplug notifiers needing the
> state is sane and implies to expect an inverse order of teardown.
> 
>>> The races you mention
>>> are not obvious to me. I see the filesystem and hotplug code protected against races via
>>> the mutex and static keys. Could you please elaborate on the flows of concern?
>>
>> Functions like __check_limbo() (calling __rmid_entry()) are called under the
>> rdtgroup_mutex, but they don't consider that rmid_ptrs[] may be NULL.
>>
>> But this could only happen if the limbo work ran after cpuhp_remove_state() - this can't
>> happen because the hotplug callbacks cancel the limbo work, and won't reschedule it if the
>> domain is going offline.
>>
>>
>> The only other path is via free_rmid(), I've not thought too much about this as
>> resctrl_exit() can't actually be invoked - this code is discarded by the linker.
>>
>> It could be run on MPAM, but only in response to an 'error interrupt' (which is optional)
>> - and all the MPAM error interrupts indicate a software bug.
> 
> This still just considers the resctrl state and hotplug notifiers.
> 
> I clearly am missing something. It is still not clear to me how this connects to your earlier
> comment about races with the rdtgroup_exit() code ... how the hotplug notifiers races with the
> filesystem register/unregister code.

I don't think there is a specific problem there, this was mostly about unexpected surprises because cpuhp/limbo_handler/overflow_handler all run asynchronously. I may also have added confusion because the code added here moves into rdtgroup_exit() which is renamed resctrl_exit() as part of dragging all this out to /fs/. (This is also why I tried to initially add it in its final location)


Thanks,

James

