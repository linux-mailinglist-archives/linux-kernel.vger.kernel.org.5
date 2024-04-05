Return-Path: <linux-kernel+bounces-132725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46E899951
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB21F24AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DA15FD14;
	Fri,  5 Apr 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5Jb0svV"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413913D265;
	Fri,  5 Apr 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308785; cv=none; b=oVwWRDf9lZEiHGEIMrxI97wsHL5cJx2udirtQjMPrmRq19ucStyhRrRXct7II6tVCvI/MShSqywGXvBVhfGKt+pR9UfG+JPKWim9U4Uz525w1+Pv8P7IIehM1uxT6nAPTGtXt+XHq+jDC5ZeMb/39RZbL0vkRbxntgAtkdLTues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308785; c=relaxed/simple;
	bh=a5NXg44BFMiguNC2tDuNWXwZ4iS92c+ZUzIznAf1Qf0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oIWw166U8qVdjK8n0h+qbO78Uijpg+hZXB5zUJOSFWDREnEEGnxW4aseKL+1/Vxg8mpywksNwUaCXNBDzAbN4aGPbtK869OofFZskHsFQXSFpLTGDd9K3cYXA/zyHAZjM/HHkeHWi8g7Kf09VOIxCv9tAYU9CDs1Z12vSi1Bl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5Jb0svV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d536f6f2so383696e87.2;
        Fri, 05 Apr 2024 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712308782; x=1712913582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GMoznVWR9nEnA6pyqwAybCVYGsx+tACDaMjpLe/PK4=;
        b=G5Jb0svVDVBU9BS5xJmBshitddTLtUEaLl87PbTVhplVIS1j11LvuJpOdB6obp1fGu
         SNS5RS/CZjcY5d4/5VktbUaa3gUHfupyfXL5G9M2KgOmDbuAxLd45Muqn6JmImJ4sZnP
         MEUUpMbJVIOTAJ89xrEworeDyMIXtwEsNWEv3xULrZdOQPuLO7y+xfTUkd+olIa0eOra
         B+B6uszPpZCC0vMk0pSiHXzr3OfEQFsiaRhEqgU7Px3CAE2IUSk/LJmM9eIj47/zvdlV
         mUBXTL7qAFUMDlgKCyyYjDUhVIcd4BkVsEitWvZzbplx4u6cSHRDxVFqpHGXFddfDp9K
         J8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308782; x=1712913582;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GMoznVWR9nEnA6pyqwAybCVYGsx+tACDaMjpLe/PK4=;
        b=TqFXntpK0wX8csIYLEFyaKJqObKj225AebtCORNvjN/cM/Rwk06cdBVd7O14900FJh
         km7CGEn5cJIIo5SW/frqZTZHmpKythzoLIaRtTKHJiAHFLO4Y3Kdm0IUg+WQtd5Qm7bL
         h4sOEaMZshQUIDbHmX/AYffISq7EDyJGKe3SujiFFPAWAAEyxxsAPfd8Wo8QymfWBDiL
         Q2qovfxPDT2c2EMckcPIXCMBptLj/HisPuW0I/R3s5F9lqGzdnipif7Axd+/NHhI+0Sq
         08RrMSm3GD2lGyDK+WxbB3h7KndcX8dRSDDQYktoum98X/PYOSOEnjVyoofFQOo8NJbz
         +Otw==
X-Forwarded-Encrypted: i=1; AJvYcCWykpQHjR2HNXklaN0LMRZiP76nK/7vkS0OkHOvwaKW7yjZCq4YVKPL9Oxk+c9qKn1I6FrdaX5ZgCvnQqTucxX6jY2dG/2E+UUqav+0s77QEJtivJf3nrmfVZdHAmTBiV66dbClrZKD1UhnF5NMmEDna3/t9/OKvjYUBqILw//H5ylwoBKeH5+W
X-Gm-Message-State: AOJu0Yxzd+XBF9foexuQtxIz0FmM0KduQLiLfl5Nd96/52nVpVyWWjtp
	7idE1bSd0s6EfxiOC3XsHK1fMNaSkpbY5wryICTTkzErVH2VEAcd7wRCxDgD
X-Google-Smtp-Source: AGHT+IEquSfinz1Ed9BFfdbScz0luX5oc2a4k7Opcpql+MuJP/6bMAdj9F9EyRATWvqJobWtzq6IoA==
X-Received: by 2002:ac2:5ec1:0:b0:513:d640:ff16 with SMTP id d1-20020ac25ec1000000b00513d640ff16mr736418lfq.29.1712308781372;
        Fri, 05 Apr 2024 02:19:41 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w24-20020a05651234d800b00513cb309c8asm139649lfr.52.2024.04.05.02.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:19:41 -0700 (PDT)
Message-ID: <f1e3d31d-8c24-4cdc-ae26-747f383a937b@gmail.com>
Date: Fri, 5 Apr 2024 12:19:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Support ROHM BD96801 scalable PMIC
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f7d454ac-6ecb-4431-a1de-c9b5d1240969@gmail.com>
 <eb03ec33-0627-4986-be04-8e35da390d6b@sirena.org.uk>
 <b6279be8-cf7d-4608-b556-3c01587f0d43@gmail.com>
In-Reply-To: <b6279be8-cf7d-4608-b556-3c01587f0d43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 16:15, Matti Vaittinen wrote:
> Hi Mark,
> 
> On 4/4/24 15:09, Mark Brown wrote:
>> On Thu, Apr 04, 2024 at 10:26:34AM +0300, Matti Vaittinen wrote:
>>
>>> 1. Should we be able to have more than 1 IRQ domain / device?
>>> 2. Should regmap_irq support having more than 1 HWIRQ
>>
>> I would expect each parent interrupt to show up as a separate remap_irq.
>>
>>> then it seems that reading the IRQ information from the /proc/interrupts
>>> works as expected. Here I am making a wild guess that the name of the 
>>> domain
>>> is used as a key for some data-lookups, and having two domains with a 
>>> same
>>> name will either overwrite something or cause wrong domain data to be
>>> fetched. (This is just guessing for now).

This was wrong guessing.

>> So if we arrange to supply a name when we register multiple domains
>> things should work fine?

After my latest findings, yes, I think so. How to do this correctly is 
beyond me though. The __irq_domain_create() seems to me that the name is 
meant to be the dt-node name when the controller is backed by a real 
dt-node. Naming of the irq_domain_alloc_named_fwnode() sounds to me like 
it is only intended to be used when there is no real fwnode. All 
suggestions appreciated. Using the:
irq_domain_update_bus_token(intb_domain, DOMAIN_BUS_WIRED);
feels like a dirty hack, and won't scale if there is more HWIRQs.

> Thanks for taking the time to look at my questions :)
> I have been debugging this thing whole day today, without getting too 
> far :) It seems there is something beyond the name collision though.
> 
> After I tried adding '-1' to the end of the other domain name to avoid 
> the debugfs name collision I managed to do couple of successful runs - 
> after which I reported here that problem seems to be just the naming. 
> Soon after sending that mail I hit the oops again even though the naming 
> was fixed.
> 
> Further debugging shows that the desc->action->name for the last 28 
> 'errb' IRQs get corrupted. This might point more to the IRQ requester 
> side - so I need to further study the BD96801 driver side as well as the 
> regulator_irq_helper. I'm having the creeping feeling that at the end of 
> the day I need to find the guilty one from the mirror :)

I was not wrong on this one. The regulator_irq_helper() duplicates 
memory for the data given in  const struct regulator_irq_desc *d - but 
it does not duplicate the irq name pointed from the given 
regulator_irq_desc. Nor does the request_threaded_irq(). I passed some 
of the IRQ names from the stack in the BD96801 driver ... a bug I 
should've caught earlier.

Well, good thing is that now I can fix the regulator_irq_helper() to do:

--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -352,6 +352,9 @@ void *regulator_irq_helper(struct device *dev,

         h->irq = irq;
         h->desc = *d;
+       h->desc.name = devm_kstrdup(dev, d->name, GFP_KERNEL);
+       if (!h->desc.name)
+               return ERR_PTR(-ENOMEM);

         ret = init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
                               rdev_amount);

I'll send a patch if this sounds like a correct thing to do.



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


