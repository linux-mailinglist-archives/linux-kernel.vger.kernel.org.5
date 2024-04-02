Return-Path: <linux-kernel+bounces-127662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEAF894F21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7D61F24D03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31BC5914A;
	Tue,  2 Apr 2024 09:51:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183C5731E;
	Tue,  2 Apr 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051509; cv=none; b=Mz15UI3kDGGAtXfkMRVOxc9sxtl66T+EqJiG16zWFIf9TmMLo8A7AWd5+CQJfccDO/LpAdOKAi3Kw6k+onxxNDIpL5ZSghwGevRQAZJLeMauTPxYfeAeGwvkuGeDcZ4uOOpoQZ0b7/2VNAMfOMwhnE2sUisLkjrmVPcPjv5YrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051509; c=relaxed/simple;
	bh=rOdi/4vFsvEtuu98vAyIokjgeKKsJDEXWo+b+t4gSN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+MigYapiPtN00Nf0W8siS4xXuzArq1W6gMypd6jQyokwJP4ig+dPT0eebascgEIq1CU07phvgU7hW3Z+dANgpnR/Nioxq+oHY7lPPbfW+tUoqivOLFnZPxuzNj4UVmEvBwU5dHMAZURvF2sn/pzHBJa+gKbFqjW5iZSyLVFYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0201042;
	Tue,  2 Apr 2024 02:52:18 -0700 (PDT)
Received: from [10.57.72.194] (unknown [10.57.72.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73FF3F766;
	Tue,  2 Apr 2024 02:51:44 -0700 (PDT)
Message-ID: <2a04d77c-52b8-47f5-b8e7-c36936db99ac@arm.com>
Date: Tue, 2 Apr 2024 10:51:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Allow binding without
 cooling devices
Content-Language: en-US
To: Nikita Travkin <nikitos.tr@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru>
 <CAJZ5v0jAq=iMKzYBz-Ni6Zqpbgxp3_0UYpPiAoSLcfGNJ8ruhQ@mail.gmail.com>
 <1bfcb1cf-fc08-404b-be36-b5e1863f7c59@arm.com>
 <3df783db-3243-4484-a429-4d3e64b9dbae@arm.com>
 <1467af1e-cdeb-4fe0-ad42-407de96dcf01@gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1467af1e-cdeb-4fe0-ad42-407de96dcf01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/29/24 13:54, Nikita Travkin wrote:
> Hi Lukasz, Rafael!
> 
> First of all, it seems like outlook mail server that serves @arm.com 
> refuses
> to communicate with mine so I can't send anything to it and it refuses to
> send anything to me either...
> 
> I'm sorry for any inconvenience this may cause and I will deal with it 
> somehow...
> 
> 28.03.2024 14:50, Lukasz Luba пишет:
>>
>>
>> On 3/28/24 09:12, Lukasz Luba wrote:
>>> Hi Rafael,
>>>
>>> On 3/27/24 15:25, Rafael J. Wysocki wrote:
>>>> On Thu, Mar 21, 2024 at 3:44 PM Nikita Travkin <nikita@trvn.ru> wrote:
>>>>>
>>>>> Commit e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip 
>>>>> points earlier")
>>>>> added a check that would fail binding the governer if there is no
>>>>> cooling devices bound to the thermal zone. Unfortunately this causes
>>>>> issues in cases when the TZ is bound to the governer before the 
>>>>> cooling
>>>>> devices are attached to it. (I.e. when the tz is registered using
>>>>> thermal_zone_device_register_with_trips().)
>>>>>
>>>>> Additionally, the documentation across gov_power_allocator suggests 
>>>>> it's
>>>>> intended to allow it to be bound to thermal zones without cooling
>>>>> devices (and thus without passive/active trip points), however the 
>>>>> same
>>>>> change added a check for the trip point to be present, causing 
>>>>> those TZ
>>>>> to fail probing. 
>>
>> This patch description is mixing trips and cooling devices and refers to
>> a commit which is only for guarding the trip points number to be
>> not less than 2. In IPA we require 2 trip points.
> 
> I'm sorry, I probably worded this poorly. I meant that there may be
> a TZ that has no trip points because it's not meant to be used with
> any cooling device.

The 'empty' thermal zone w/o trip points and w/o cooling devices, but
w/ governor looks odd but still live.

> 
>>>>>
>>>>> Those changes cause all thermal zones to fail on some devices (such as
>>>>> sc7180-acer-aspire1) and prevent the kernel from controlling the 
>>>>> cpu/gpu
>>>>> frequency based on the temperature, as well as losing all the other
>>>>> "informational" thermal zones if power_allocator is set as default.
>>>>>
>>>>> This commit partially reverts the referenced one by dropping the trip
>>>>> point check and by allowing the TZ to probe even if no actor buffer 
>>>>> was
>>>>> allocated to allow those TZ to probe again.
>>>>>
>>>>> Fixes: e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip 
>>>>> points earlier") 
>>
>> Not that commit.
>>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>>> ---
>>>>> I've noticed that all thermal zones fail probing with -EINVAL on my
>>>>> sc7180 based Acer Aspire 1 since 6.8. This commit allows me to bring
>>>>> them back. 
>>>>
>>>> Łukasz, any comments? 
>>>
>>> Let me check this today.
>>>>> ---
>>>>>   drivers/thermal/gov_power_allocator.c | 14 +++++---------
>>>>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/thermal/gov_power_allocator.c 
>>>>> b/drivers/thermal/gov_power_allocator.c
>>>>> index 1b17dc4c219c..4f2d7f3b7508 100644
>>>>> --- a/drivers/thermal/gov_power_allocator.c
>>>>> +++ b/drivers/thermal/gov_power_allocator.c
>>>>> @@ -679,11 +679,6 @@ static int power_allocator_bind(struct 
>>>>> thermal_zone_device *tz)
>>>>>                  return -ENOMEM;
>>>>>
>>>>>          get_governor_trips(tz, params);
>>>>> -       if (!params->trip_max) {
>>>>> -               dev_warn(&tz->device, "power_allocator: missing 
>>>>> trip_max\n"); 
>>
>> This if() guards the binding of TZ with less than 2 trip points,
>> not the cooling devices.
>>>>> - kfree(params);
>>>>> -               return -EINVAL;
>>>>> -       }
>>>>>
>>>>>          ret = check_power_actors(tz, params);
>>>>>          if (ret < 0) {
>>>>> @@ -693,7 +688,7 @@ static int power_allocator_bind(struct 
>>>>> thermal_zone_device *tz)
>>>>>          }
>>>>>
>>>>>          ret = allocate_actors_buffer(params, ret);
>>>>> -       if (ret) { 
>>
>> This if() is from different commit.
> 
> Hm you're right, I misread the commit I think and on a second thought
> this patch combines two different issues. I will split it up into two.
> 
>>>>> +       if (ret && ret != -EINVAL) { 
>>
>> This is about 0 cooling devices in the thermal zone, but IPA won't work
>> so why to even fake and forward binding?
>>
>> Rafael should we support binding with 0 cooling devices? 
> 
> As I understand it, cooling devices can attach to existing thermal zones
> so it's possible that TZ is registered before any cooling devices has
> attached to it. This is exactly what happens in my case: first the
> IPA is probed for the TZ and after that the cooling device is attached.

That's fair enough. IPA should support it.

> 
> check_power_actors() kerneldoc in IPA says:
> 
>> * If all of the cooling  devices currently attached to @tz implement 
>> the power
>> * actor API, return the  number of them (which may be 0, because some 
>> cooling
>> * devices may be  attached later). Otherwise, return -EINVAL.
> 
> and afaiu this is exactly how it's used by 
> thermal_zone_device_register_with_trips():
> 
>      result = thermal_set_governor(tz, governor);
>      if (result) {
> mutex_unlock(&thermal_governor_lock);
>          goto unregister;
>      }
>      (...)
>      /* Bind cooling devices for this zone */
>      bind_tz(tz);
> 
>>>>> dev_warn(&tz->device, "power_allocator: allocation failed\n");
>>>>>                  kfree(params);
>>>>>                  return ret;
>>>>> @@ -714,9 +709,10 @@ static int power_allocator_bind(struct 
>>>>> thermal_zone_device *tz)
>>>>>          else
>>>>>                  params->sustainable_power = 
>>>>> tz->tzp->sustainable_power;
>>>>>
>>>>> -       estimate_pid_constants(tz, tz->tzp->sustainable_power,
>>>>> -                              params->trip_switch_on,
>>>>> - params->trip_max->temperature);
>>>>> +       if (params->trip_max) 
>>
>> This is not supported, we need those 2 trip points.
> 
> Yes, I understand that IPA is useless without trip points and/or cooling
> devices. However from the snippet above the TZ won't be registered if
> the governor fails to probe. This means that if one has IPA set as the
> default, thermal core will try to probe it for TZ without trip points and,
> when it fails, will fail to probe the whole TZ.
> 
> get_governor_trips() kerneldoc in IPA says:
> 
>  > * on.  If there are no passive or active trip points, then the
>  > * governor won't do anything.  In fact, its throttle function
>  > * won't be called at all.
> 
> Which suggests to me that being bound to such TZ is expected.
> 
> Unless you have any thoughts on how to solve this better, I will split
> this into two commits and resubmit in a few days:

Yes, please split into 2 patches for different commits.

> 
>   - Allow binding without cooling devices (allow -EINVAL after allocate)

It won't be the fix, it's a hack. If the 0 cooling devices is going to 
be the normal state, then it has to be handled not as error exception
path.

Please change the allocate_actors_buffer():
          if (!num_actors) {
                  ret = -EINVAL;   <--- ret = 0 here

since it's normal state now.

>   - Allow binding without trip points (Rest of this patch)

Yes, the rest of that patch looks good.



