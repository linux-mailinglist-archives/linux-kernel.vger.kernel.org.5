Return-Path: <linux-kernel+bounces-122492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5588F87A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAEE1F264DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D051C3F;
	Thu, 28 Mar 2024 07:21:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E081E89C;
	Thu, 28 Mar 2024 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610494; cv=none; b=aqKObknfSDg+90bA/PYGqwwHaDzE4JbYuGYootUUNL/vK6wR48kca7xK7VfLhdaL/SwUb2znG0A9/4e3VWtiebVlsOg6vS1IoIJcY16GtWjjfrBL0LjO6L8o32CkUHS+jN1m9/HwakFCn6XFk9ChHAemQYRDJ6uUFS2+4B/BH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610494; c=relaxed/simple;
	bh=jUemk+VG3jTjLUtctuQ9btb67Jp6DBUNLMtVoqXzJv0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q806PfolIVjTVwH9azRKfghVXJGmDZWMiFPzgCHM/1twwXM5BJ4bJ49FvzWgyba8k1vKa/jjD1hV/OUSvxxiSZEFkGaeQ/LhAbGLN01A5Mc2JcGT6LPRBmEiIXHpFEvVW1tiNvX2L7R7WhwS8NSJTffvNNr0OCZ71BfFRJ412iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5682F4;
	Thu, 28 Mar 2024 00:22:05 -0700 (PDT)
Received: from [192.168.178.110] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 859E43F64C;
	Thu, 28 Mar 2024 00:21:29 -0700 (PDT)
Message-ID: <9f2f5c94-cc9f-4a16-9b70-f00598af8cab@arm.com>
Date: Thu, 28 Mar 2024 08:21:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 3/4] PM: EM: Add em_dev_update_chip_binning()
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Lukasz Luba <lukasz.luba@arm.com>
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
In-Reply-To: <410c5da7-c79c-4607-9aa3-2e78d991d2d7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/03/2024 13:55, Dietmar Eggemann wrote:
> On 26/03/2024 21:32, Lukasz Luba wrote:
>>
>>
>> On 3/26/24 10:09, Dietmar Eggemann wrote:
>>> On 22/03/2024 12:08, Lukasz Luba wrote:
> 
> [...]
> 
>>>> +    return em_recalc_and_update(dev, pd, em_table);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
>>>
>>> In the previous version of 'chip-binning' you were using the new EM
>>> interface em_dev_compute_costs() (1) which is now replaced by
>>> em_recalc_and_update() -> em_compute_costs().
>>>
>>> https://lkml.kernel.org/r/20231220110339.1065505-2-lukasz.luba@arm.com
>>>
>>> Which leaves (1) still unused.
>>>
>>> That was why my concern back then that we shouldn't introduce EM
>>> interfaces without a user:
>>>
>>> https://lkml.kernel.org/r/8fc499cf-fca1-4465-bff7-a93dfd36f3c8@arm.com
>>>
>>> What happens now with em_dev_compute_costs()?
>>>
>>
>> For now it's not used, but modules which will create new EMs
>> with custom power values will use it. When such a module have
>> e.g. 5 EMs for one PD and only switches on one of them, then
>> this em_dev_compute_costs() will be used at setup for those
>> 5 EMs. Later it won't be used.
>> I don't wanted to combine the registration of new EM with
>> the compute cost, because that will create overhead in the
>> switching to new EM code path. Now we have only ~3us, which
>> was the main goal.
>>
>> When our scmi-cpufreq get the support for EM update this
>> compute cost will be used there.
> 
> OK, I see. I checked the reloadable EM test module and
> em_dev_compute_costs() is used there like you described it.

I had a second look and IMHO the layout is like this:

Internal (1) and external (2,3) 'reloadable EM' use cases:
(EM alloc and free not depicted)

1. Late CPUs booting (CPU capacity adjustment)

 e3f1164fc9ee  PM: EM: Support late CPUs booting and capacity adjustment

 schedule_delayed_work(&em_update_work, ...)

  em_update_workfn()
   em_check_capacity_update()
    em_adjust_new_capacity()
     em_recalc_and_update()       <-- (i)
      em_compute_costs()          <-- (ii)
      em_dev_update_perf_domain() <-- external

2. Reload EM from driver

 22ea02848c07  PM: EM: Add em_dev_compute_costs()
 977230d5d503  PM: EM: Introduce em_dev_update_perf_domain() for EM
               updates

 em_dev_compute_costs()           <-- external
  em_compute_costs()              <-- (ii)
 em_dev_update_perf_domain()      <-- external

3. Chip binning

 this patchset  PM: EM: Add em_dev_update_chip_binning()

 em_dev_update_chip_binning()     <-- external
  em_recalc_and_update()          <-- (i)
   em_compute_costs()             <-- (ii)
   em_dev_update_perf_domain()    <-- external




