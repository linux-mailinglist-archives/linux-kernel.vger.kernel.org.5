Return-Path: <linux-kernel+bounces-125729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F09892B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D48B222AD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B312219F0;
	Sat, 30 Mar 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpB/f+C2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70B8BFC;
	Sat, 30 Mar 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711803541; cv=none; b=k4mr8rwyoWiwHqM5e7Iw+tj0V1FHDvYqekiKeIU7FStQ4Ami0y2t4MrFbva261fVC1dSLcFfpdvcDk3d1PFYGCQIdcHiOnigvhVShe/Sx/fI3rzSHqEQl4yY8y8Z8Kc6d+1dtf/Xv2k2kShX37IHu8wQ2vkSL2LcoH+LK5X42+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711803541; c=relaxed/simple;
	bh=Car9GN2tQNeTTS1TNLTIQj5FQX9M9R0UjeM03caoV6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8rrncozQZjsL12DBqK9PNYXAnIaZnF9E8gajFgCkFn4PbVNBv8EFQMX7zSSOmwEt2jiM6kXuEKT1gbsjZolsJ/+VK2zW5no4VNu2Uft8SBuwz+4oDIM3zN0ZjPxl4aonY4zyqAGxHgfAJsck7r/eilPRcfZQ89eirwGi4ukqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpB/f+C2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4155bc085dfso1406505e9.1;
        Sat, 30 Mar 2024 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711803537; x=1712408337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JaMGVJLZuF28CmdzYEI45s8CkO4naifu4l9FLwAvec=;
        b=XpB/f+C2jg3uxvcaqp73OYSSjUjLeD3tHJMXnJ8zRglMKzXBnQVmmxQEIvrZJKowLn
         525Mr7hn/mdc7daD+cZksp233jJNxw79rjiWUlHVCL07MwN8OgzCrgYBS0gDRvIs+2C8
         YsPtzUlAiWmasbF3P49aMy79G1QkE7FSqa31piYRlwRduOqPuZCddkOfYMwzZu/a4m0r
         Q3rsDXcNVQSn+cFGZNE9BS6pHie4jK3DppZliyFYqaGgT9deqoGbHBB//zysAO2C7nbc
         GJcYxCDbivNkpeFIkCT3NEGcD4FiBoVAuwPUyLqDPOaSRRYLFfiOPmPXwBjUAmFgqEw6
         uUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711803537; x=1712408337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JaMGVJLZuF28CmdzYEI45s8CkO4naifu4l9FLwAvec=;
        b=r6BdbLQ2fJbSGIcMF6seIW8nt093weiNc5wLxVpkYAKNAVZ3E3Fri5VCgdwZoe5c9l
         pM/fn+n3zfCqB9D6JHeCCPnyBw4HSw6fWTEKaAQtTGCv1PE8RB0JbBz07fAyCYxfv0Dj
         TeNlGv7Xj+a9lAKE4yBZpYi0osBDykZVT3OR4ntxF0XzDP7Gz9uiQmgD1+gPxnVGygmD
         QRudv1bOeMN5Tr2qlf7VTnr+4ezsoncBrmTlL8ZUzJDfRO6ijF0299ZbfBhM/uhmrPY/
         viR0tL4yEroceNZzhyH8Q2KCPHhHlehdXzB4VkDxJ0wQrS7uly6MLsaqtKekJLdSB3tN
         i5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTToItFdW8nfLk4xVonvh0SU+yqT2CIBvNawxyzAcLcHjHY2rLzbs/Bw8Ub9lkM0fjwzoDsCZdDAo3VdFNvpcfAuZwT7/3w/uJl4FjP1OJa63ewk/5i7eOysvDpgzKAvwL3WlrHxo7gTTtG6VFP/aQeCMdDy7D/36RpnniAy0aXEqviAiUCtfCjQia0cu7
X-Gm-Message-State: AOJu0Ywf+/5YcMvVRSJtjG4MVZUAjeY9d5MwHioCNQesODnfQFzn3sz4
	9pK9o+IgpQLMseRjheO6E8AipJZ8vdDchONb0wK1wB3GLYgbnEq6
X-Google-Smtp-Source: AGHT+IEa0WdkS11BCB1d7NoUqJwCtyKOfTMUYVoDqiClzq+5hTM/tfUqq9qFJHWlzyPAyvES/KxpuA==
X-Received: by 2002:a05:600c:1913:b0:414:6172:8366 with SMTP id j19-20020a05600c191300b0041461728366mr4006133wmq.15.1711803537355;
        Sat, 30 Mar 2024 05:58:57 -0700 (PDT)
Received: from [172.18.121.29] (ip-185-104-138-51.ptr.icomera.net. [185.104.138.51])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b00415461b9ab2sm7735216wmb.5.2024.03.30.05.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 05:58:56 -0700 (PDT)
Message-ID: <e8ccce25-86d5-492a-8fb4-3f39036fa91a@gmail.com>
Date: Sat, 30 Mar 2024 13:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-2-luzmaximilian@gmail.com>
 <d49ea735-3113-4c1f-a8dc-c6d8e821c4f1@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <d49ea735-3113-4c1f-a8dc-c6d8e821c4f1@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/24 12:58, Guenter Roeck wrote:
> On 3/30/24 04:24, Maximilian Luz wrote:
>> Some of the newer Microsoft Surface devices (such as the Surface Book
>> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
>> Module (the embedded controller on those devices). Add a basic driver
>> to read out the temperature values of those sensors.
>>
>> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> I very much dislike the idea of having multiple drivers for hardware
> monitoring on the same system. Please explain in detail why this and
> the fan driver for the same system need separate drivers.
> 
> I'll also very much want to know if we will see submissions for separate
> voltage, current, power, energy, humidity, and/or other hardware monitoring
> entities for the same system later on.

The Surface Aggregator EC is not really a single device, but rather a
collection of subsystems. For example, there's one for the battery, one
for thermal sensors, and a separate one for the fan. Not all subsystems
are present on all devices with that EC, so we have modeled them as
separate subdevices of the parent EC controller. This makes it quite a
bit easier to maintain. Especially, since I haven't found any reliable
way to auto-detect the active/supported subsystems.

For example: The Surface Book 3 has thermal sensors that can be accessed
via this driver as well as a fan. As far as I know, however, the fan
subsystem has been introduced later and the Surface Book 3 doesn't
support that yet. So there's (as far as I know) no fan-monitoring
support. Trying to access that will fail with a timeout. For that reason
(but not specifically for that device), we have introduced the split
into subystem devices, which are maunally registered in
surface_aggregator_registry.c based on what we know the device actually
supports.

Further, the devices created for these subsystems also act as a binding
mechanism to the subsystem, speficying the subsystem ID/category used
for making requests to it. For example, this driver probes for

     SSAM_SDEV(TMP, SAM, 0x00, 0x02)

meaning it looks for a device of the TMP subsystem on the SAM target ID
(which can be seen as a bus number) with instance 0 and function 2. This
(in particular subsystem ID and target ID) are directly used when making
requests to the EC. So if we find out down the line that temperature
sensors can be accessed on target ID KIP in addition to SAM, it's as easy
as adding a new device match to the driver.

I believe that this would be more difficult if the driver is merged
together: Doing so would require us to figure out what's present and
what we can or should access inside of the driver (instead of via the
already established registry). So it would either require us to do a
certain amount of hardcoding and if/else branches or we would have to
introduce a bunch of device properties and a meta-device just to bundle
all monitoring-related subsystems together, and again use a bunch of
if/else branches... And in both cases, the direct subsystem binding
originally intended in the device structure of the Surface Aggregator
bus goes out of the window.

So, in my opinion at least, having separate smaller but specific drivers
and leaving that "logic" to the registry driver makes this much more
maintainable.

Regarding other monitoring entities: In short, I don't know. I am not
aware of any other (current/power/...) monitoring capabilities of the EC
right now, but I can't guarantee that MS won't introduce a new subsystem
for those down the line (or that there already is one and we just don't
know about it). At which point, it will quite likely only be supported
on some (probably newer) devices again.

Best regards,
Max

