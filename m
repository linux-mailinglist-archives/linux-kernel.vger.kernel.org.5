Return-Path: <linux-kernel+bounces-122506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9388F8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D32298CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34F535C8;
	Thu, 28 Mar 2024 07:30:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712202C6B8;
	Thu, 28 Mar 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611035; cv=none; b=TVDzjvxOSf5nCoa/W3OCF//T6pcmZclSTa+xSjNHn5A+Li8NqF5wPbhSUV+kw95P8VZj1R9mtgZORkHCCism9kvLD3T0MTcoayjwsq0ZTSxhHNwzr8QEGNEQfGLT3UvAM4zmMfxrptX5Pk1zPR38uGziGonCON8pX9YdEjfvjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611035; c=relaxed/simple;
	bh=3exzUqajDFk/5+jRBK0S4zTkjn1GxyDjBzP18yJnkn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRgY1xop8AhtIAnyMgLSyKUYWVuvff3GuhzBE5ry/o4ChEyAbf2jEL2g1NIpMf4onKMw0vO2o0JcxfcXW3h8eIzruFM76FFULHcIt9fSw0lGXlIftpWrQS8wUxmF0qTzeeOF0+OhvhrDuvPgKOwwpTAT2QzB7tLjbXzMxdZzwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1A02F4;
	Thu, 28 Mar 2024 00:31:06 -0700 (PDT)
Received: from [10.57.73.83] (unknown [10.57.73.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B2123F64C;
	Thu, 28 Mar 2024 00:30:30 -0700 (PDT)
Message-ID: <b4d1cb26-f49a-4f5e-9059-8bc87baba5e3@arm.com>
Date: Thu, 28 Mar 2024 07:30:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 3/4] PM: EM: Add em_dev_update_chip_binning()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-4-lukasz.luba@arm.com>
 <eb9f48f6-cca8-405b-82a2-352893a79f14@arm.com>
 <30ee98e9-3d9a-4be8-8127-043f68a7dcb1@arm.com>
 <410c5da7-c79c-4607-9aa3-2e78d991d2d7@arm.com>
 <9f2f5c94-cc9f-4a16-9b70-f00598af8cab@arm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9f2f5c94-cc9f-4a16-9b70-f00598af8cab@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/28/24 07:21, Dietmar Eggemann wrote:
> On 27/03/2024 13:55, Dietmar Eggemann wrote:
>> On 26/03/2024 21:32, Lukasz Luba wrote:
>>>
>>>
>>> On 3/26/24 10:09, Dietmar Eggemann wrote:
>>>> On 22/03/2024 12:08, Lukasz Luba wrote:
>>
>> [...]
>>
>>>>> +    return em_recalc_and_update(dev, pd, em_table);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
>>>>
>>>> In the previous version of 'chip-binning' you were using the new EM
>>>> interface em_dev_compute_costs() (1) which is now replaced by
>>>> em_recalc_and_update() -> em_compute_costs().
>>>>
>>>> https://lkml.kernel.org/r/20231220110339.1065505-2-lukasz.luba@arm.com
>>>>
>>>> Which leaves (1) still unused.
>>>>
>>>> That was why my concern back then that we shouldn't introduce EM
>>>> interfaces without a user:
>>>>
>>>> https://lkml.kernel.org/r/8fc499cf-fca1-4465-bff7-a93dfd36f3c8@arm.com
>>>>
>>>> What happens now with em_dev_compute_costs()?
>>>>
>>>
>>> For now it's not used, but modules which will create new EMs
>>> with custom power values will use it. When such a module have
>>> e.g. 5 EMs for one PD and only switches on one of them, then
>>> this em_dev_compute_costs() will be used at setup for those
>>> 5 EMs. Later it won't be used.
>>> I don't wanted to combine the registration of new EM with
>>> the compute cost, because that will create overhead in the
>>> switching to new EM code path. Now we have only ~3us, which
>>> was the main goal.
>>>
>>> When our scmi-cpufreq get the support for EM update this
>>> compute cost will be used there.
>>
>> OK, I see. I checked the reloadable EM test module and
>> em_dev_compute_costs() is used there like you described it.
> 
> I had a second look and IMHO the layout is like this:
> 
> Internal (1) and external (2,3) 'reloadable EM' use cases:
> (EM alloc and free not depicted)
> 
> 1. Late CPUs booting (CPU capacity adjustment)
> 
>   e3f1164fc9ee  PM: EM: Support late CPUs booting and capacity adjustment
> 
>   schedule_delayed_work(&em_update_work, ...)
> 
>    em_update_workfn()
>     em_check_capacity_update()
>      em_adjust_new_capacity()
>       em_recalc_and_update()       <-- (i)
>        em_compute_costs()          <-- (ii)
>        em_dev_update_perf_domain() <-- external
> 
> 2. Reload EM from driver
> 
>   22ea02848c07  PM: EM: Add em_dev_compute_costs()
>   977230d5d503  PM: EM: Introduce em_dev_update_perf_domain() for EM
>                 updates
> 
>   em_dev_compute_costs()           <-- external
>    em_compute_costs()              <-- (ii)
>   em_dev_update_perf_domain()      <-- external
> 
> 3. Chip binning
> 
>   this patchset  PM: EM: Add em_dev_update_chip_binning()
> 
>   em_dev_update_chip_binning()     <-- external
>    em_recalc_and_update()          <-- (i)
>     em_compute_costs()             <-- (ii)
>     em_dev_update_perf_domain()    <-- external
> 
> 
> 
> 

Yes, that's correct.

