Return-Path: <linux-kernel+bounces-79994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A08186296C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307C3282311
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE4D28D;
	Sun, 25 Feb 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN9Q0JyE"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0D944C;
	Sun, 25 Feb 2024 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843434; cv=none; b=d2MFUaTYTy8SqAe6qpIIWchXZPd8L5eDprTEuz/awYDyw0DBiHpoKus5Pg6g7G6+f4q181ewqhIipdbJRG5ceYgwiMZTmNjOb23sIcHGqG8Fugb+zkfH/tZ+Obcv87yY9/dRm9t17EQTOK+K2344fUfYtmSBA0ivrWi2VIJSh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843434; c=relaxed/simple;
	bh=3Q/bV9mX9gawd2AT/ewclm3/mjDpZ7txq6oTrl/e5cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8SY4n64cX7NJnMh2UBa/s7738mqN+sINvKeZGTHvACzVXqyg4A3Y9lre4gR5BWXUFuNnoFxkmy93WkQwUZYjqrLHuoYoK+JgfRG9gnVayuARbcnzqQKfx4AcjnZKaC8iLFxuu6AlwIgQCqr+j7P7BZc871AYs2rPG3zDzyboU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN9Q0JyE; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a03f90d1c1so1067338eaf.1;
        Sat, 24 Feb 2024 22:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708843431; x=1709448231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z5RQthc7xL9MTJI54uIG1GcxlcyGFqHbEmRk4dXZCw=;
        b=CN9Q0JyEw+aN3DbDEsss8aat2sVjEMqSIZuQaqdc9MbPNEQ5o45FBDFm7BVJJCCroj
         LQHQ0sqMqtchTK3+luNA0zeI1flxG3mlUpUuOlqdh+xtsOFulvKz1/dFsD9ESs50Cu5h
         qlXFVp1ynq4pR8MIsxevCWK8MFaXsaHtSmFP4DSknvNct4WXvoOoRXePR70JdZgcvtJi
         4afDCH0D3MWKQVbsUiU59VFO0bMMK2mZrNMSll7kh1xtfS7ud9Dqjx/7YYndVQcW5FRa
         2WdYQ5jkyfOv4dxR6pB885Wq4d2DDruh0H9Eynlmlka2OKukixRB6wnlBFRQlzGYsXG9
         3WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708843431; x=1709448231;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Z5RQthc7xL9MTJI54uIG1GcxlcyGFqHbEmRk4dXZCw=;
        b=a6Hi8A/fV5Jy+yO8+g9y5JPjcgUM6ae2PincxduMEOpe7ugKKQWImvFjFKS6hOmxTR
         VDn9tNkMtQ+ASwuL+BHzJ5tTMpkOBj3A6bZ/IOVNRKm7645xkrLADxaR+bIaRj+DVuT0
         et4PqGKqWbOh7RkmG1aaiPYi8dPeLureyUnlyR5DD2g4aSTqG25gHgqfvZApVkgmMyTs
         9eGqiE+8R3w2Xgs7CNZ5QGg1y26dFBs/SS+RRudayKtfucdLuq96Qy1gCYqNWmauUbra
         aphfTB2gaACyvdFlq7ai/tC7S9oNxXQVK2JBWDye+HrD6EtCMWP3j85WIVje677TekcG
         C1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUcgHpEFiM9msFE0G1CZWvs3n7kI5QtW5gWWWGM9y70kgfd8VNCKVv/YNFjs6XVuEXIH61jt5Mar5cdP4eGV1bW17h7pjRMppMk7ecqZs=
X-Gm-Message-State: AOJu0Yz/mF1oSzywUyIrbmMWvVOHnPfzCwGEPjpUHQmMkIYqVz8BpPY3
	Xb3sBJ/I+aNJ6lroA9HTu3AKNePuh5je83VBmD/nQPinlrvMFfP3
X-Google-Smtp-Source: AGHT+IGonzUX+Kk4yzw9TxtPoBmTjown9xVA9KXMa1Rpdyqiyft8PjxP3A6B+YBkaL6skGP6R/6Mzw==
X-Received: by 2002:a05:6358:7416:b0:17b:89ec:819d with SMTP id s22-20020a056358741600b0017b89ec819dmr5024899rwg.7.1708843431011;
        Sat, 24 Feb 2024 22:43:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fn11-20020a056a002fcb00b006e0737f2bafsm1911511pfb.45.2024.02.24.22.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 22:43:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <42a7e7e9-01b0-4d41-8af1-328de90934ef@roeck-us.net>
Date: Sat, 24 Feb 2024 22:43:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Content-Language: en-US
To: Mark Pearson <mpearson@squebb.ca>, David Ober <dober6023@gmail.com>,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 David Ober <dober@lenovo.com>
References: <20230721122931.505957-1-dober6023@gmail.com>
 <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
 <6b0373a2-7750-4d57-8839-95c6fa30c6b8@roeck-us.net>
 <4209014c-1730-4c31-87d8-4192d68bcbc6@app.fastmail.com>
 <6615ab2a-3267-477c-ad1b-a72d5a4244e0@roeck-us.net>
 <412acdd3-6b1f-4c45-966f-c493b6fc3ddf@app.fastmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <412acdd3-6b1f-4c45-966f-c493b6fc3ddf@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/24 12:19, Mark Pearson wrote:
> Thanks Guenter,
> 
> On Sat, Feb 24, 2024, at 10:49 AM, Guenter Roeck wrote:
>> On 2/23/24 16:43, Mark Pearson wrote:
>>> Thanks Guenter
>>>
>>> On Fri, Feb 23, 2024, at 3:21 PM, Guenter Roeck wrote:
>>>> On 2/23/24 11:58, Mark Pearson wrote:
>>>>> On Fri, Jul 21, 2023, at 8:29 AM, David Ober wrote:
>>>>>> This modules is to allow for the new ITE 5632 EC chip
>>>>>> to support the watchdog for initial use in the Lenovo SE10
>>>>>>
>>>>>> Signed-off-by: David Ober <dober6023@gmail.com>
>>>>>>
>>>>>> V2 Fix stop to deactivate wdog on unload of module
>>>>>> V2 Remove extra logging that is not needed
>>>>>> V2 change udelays to usleep_range
>>>>>> V2 Changed to now request region on start and release on stop instead
>>>>>>       of for every ping and read/write
>>>>>> V3 add counter to while loops so it will not hang
>>>>>> V3 rework code to use platform_device_register_simple
>>>>>> V3 rework getting the Chip ID to remove duplicate code and close IO
>>>>>> V3 change some extra logging to be debug only
>>>>>> ---
>>>> [ ... ]
>>>>>> +config ITE5632_WDT
>>>>>> +        tristate "ITE 5632"
>>>>>> +        select WATCHDOG_CORE
>>>>>> +        help
>>>>>> +          If you say yes here you get support for the watchdog
>>>>>> +          functionality of the ITE 5632 eSIO chip.
>>>>>> +
>>>>>> +          This driver can also be built as a module. If so, the module
>>>>>> +          will be called ite5632_wdt.
>>>>>> +
>>>>
>>>> [ ... ]
>>>>
>>>>>
>>>>>
>>>>> Please let us know if there is anything else needed to get this accepted. Happy to address any feedback.
>>>>>
>>>>
>>>> I am sure I commented on this before. The fact that the Lenovo SE10 uses an
>>>> ITE 5632 controller is completely irrelevant. Lenovo could decide tomorrow to
>>>> replace the ITE chip with a Nuvoton chip, use the same API to talk with it,
>>>> and the watchdog would work perfectly fine.
>>>>
>>>> This is a driver for the watchdog implemented in the embedded controller
>>>> on Lenovo SE10. It is not a watchdog driver for ITE5632. Again, the EC chip
>>>> used in that Lenovo system is completely irrelevant, even more so since
>>>> this seems to be one of those undocumented ITE chips which officially
>>>> don't even exist. Claiming that this would be a watchdog driver for ITE5632
>>>> would be not only misleading but simply wrong.
>>>>
>>>> It seems that we can not agree on this. That means that, from my perspective,
>>>> there is no real path to move forward. Wim will have to decide if and how
>>>> to proceed.
>>>>
>>> My apologies - I hadn't realised that was the issue (my fault for missing it). Appreciate the clarification.
>>>
>>> Is this as simple as renaming this driver as (for example) a lenovo_se_wdt device, and adding in the appropriate checking during the init that it is only used on Lenovo SE10 platforms?
>>>
>>
>> There would have to be additional changes. For example, the driver does not
>> return errors if its wait loops time out, and it doesn't reserve the IO address
>> range used by the chip. Tying the wait time to the number of wait loops
>> and not to the elapsed time is also something that would need to be explained.
>>
> Ack - we can look at those. Thanks for the feedback.
> 
>> Also, I notice that the communication is similar to the communication with
>> Super-IO chips from ITE, but not the same. Specifically, the unlock key is
>> the same, but the lock key is different. This means that the code may unlock
>> other chips from ITE in a given system, but not lock them. Some of those chips
>> are ... let's call it less then perfect. They will act oddly on the bus if left
>> unlocked. Some of those chips will act oddly if an attempt is made to lock them
>> after unlocking them, and they have to remain unlocked to avoid corrupting
>> communication with other chips on the same bus. The impact on other chips
>> from the same vendor will have to be explored further.
> 
> Afraid I'm still missing something here. If we make it so this driver is only used on the SE10 platform, then does that remove the concern? At that point it's specific to that HW platform and no HW changes are planned.

Yes.

> Agreed that having this available generically is not a good idea.
> 
>>
>>> I don't understand the concern if a different chip was used - wouldn't that need a different driver at that point?
>>>
>>
>> Why would that be the case ?
>>
>> Maybe I am missing something essential. If you insist to tie this driver to the
>> ITE5632 and not to the system, you will have to provide additional information.
> 
> I'm in agreement we should tie this to the platform - we'll make that change. No insistence implied :)
> 
>> The chip does not even exist in public, so no one but you and ITE really knows
>> what its capabilities are. Is this is a chip which is used, or is going to be
>> used, in a variety of systems, possibly including systems from other vendors ?
>> Is the communication between main CPU and the chip tied to the chip and will/may
>> only be used with this chip or variants of it ? Is the ITE5632 a SuperIO-like
>> chip with fixed capabilities, or is it a programmed micro-controller ?
>>
> 
> Afraid I don't understand the point about the chip not existing in public - do you just mean publicly available datasheets? At the risk of being repetitive, if this driver is locked to the Lenovo SE10 platform does that address the concerns?
> 

Just try to find information about this chip anywhere. The only evidence that the
chip even exists appears to be this submission.

>> To a large degree all that is due to ITE and its customers not
>> providing information
>> about their chips to the public. Due to that lack of information, my
>> assumption was
>> that it is a programmed micro-controller. The code itself suggests,
>> through the
>> use of the term "EC" in the driver, that it is an embedded controller,
>> not a Suoer-IO
>> or other fixed-capability chip. If that is not the case, and if the
>> communication
>> with the chip is fixed and not programmable, you'll have to explain
>> that.
> 
> Yeah, ack to that - and in that's something we need to address going forward in contracts we set for platforms that will have Linux support. I can't change what has already been done I'm afraid. We do have access, under NDA, to more details - but we're also limited in what we can disclose.
> I need to go look at the details for this again, with David, and see what we can do to address any questions; but there are going to be some limits I'm afraid and I'm hoping they aren't blockers.

I can't say that I am surprised. It is quite common for chips from ITE.
Most of them seem to be custom builds made for specific customers/boards,
with little if any information available. People providing tools for Windows
can often sign NDAs with board vendors to get the information they need to
implement support in those tools. Unfortunately that isn't an option for
Linux kernel maintainers.

> The aim is to get a driver working for this platform in shape enough to get accepted upstream and be useful.
> 
>>
>> If it is an EC, the protocol is defined by its microcode, and the
>> driver needs
>> to be tied to the systems using that microcode. If it is a
>> fixed-capability chip,
>> the driver should not suggest that it communicates with an embedded
>> controller
>> but with a fixed-capability chip.
>>
> 
> OK - we may also have used some incorrect terminology inadvertently, so I don't want to jump to too many conclusions. Will look into this.
> 
> Thanks for the detailed notes - we weren't sure what had been missing from the driver since the last submission so it's helpful to know where improvements are needed.
> Appreciate the patience as this is a learning experience for us for this kernel sub-tree.
> 
And I still have no idea if this an EC or not ;-). My best guess would
be that it is an NDS32 based micro-controller, related to IT5671.

Of course, the next question would be if this chip has additional
functionality, such as hardware monitoring. I guess I'll see that
when I get a patch introducing its hwmon driver.

Guenter


