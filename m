Return-Path: <linux-kernel+bounces-153236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC68ACB40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E47281C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA792145342;
	Mon, 22 Apr 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcqiBEIr"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA2482C1;
	Mon, 22 Apr 2024 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783154; cv=none; b=DFwOcZAeExRWMw6YIA1f3IvQvHoUrTHgZHYgw7EFVHy1vnEoG4fkWtcM0rqH5o/WjiUOTS5I7GEhMUmTdMwobq3cgWzCeZRbwJZEnko4l4wXVv1AhnCaHp5MJf44ugjlxvGAh9aOZ9XGPvTCCVdVdW9vuEC4bAOAqvwRW6OW9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783154; c=relaxed/simple;
	bh=0KlyZbYLtPzoaO0C9rWrtsHQkri9Vg0zakhGtHwYeko=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AL+2fy6M+dLIVy3KwhHj9N9acwDcGaJAqX9xLmjLx5+cFLlXY8lKmpm8CJgrdoPumOM1A2snqBK8mfUZp9atQpM3EBYDDC5eSsmbnkNM2Us6UoqRz8QCWinVNCb2I7Vi1vmKq+7RbNRI1N1Vmj/+KE9zDaNhJXReK02hFKa4Nv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcqiBEIr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso6575908e87.2;
        Mon, 22 Apr 2024 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713783150; x=1714387950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XB9rFLfMWN1g7ihRLHwOUgZ6Nm1LwOP8sZGJRcsldyE=;
        b=QcqiBEIrDdfB2wRJu8SJ4XUlcj7/V+wF/e64LNSS/BwV7wqLh+3FgprSGbhFmYs/RX
         Q2DD7GRioJ1VjI4zN2YFp5oRfKpNFs4VeEqvlQGi6wGeK69m9W/O6OY+MxVe9mKEOAjx
         YQDZSDSpqJKuEBnGslw7uceOBDE/eVz5Jotm/r192Pt3WZEs8vKomEuF1jDcKr08CLIu
         nxwsWrV6uc55lvUnZno6s09QQyQ0prTpcuMMUwZO/Y9uPukI90909IkLcoMGXg576jIS
         If7+USLHSv2R0f7mnkNEw5Fm8RSLNtgF6/RjILYhBWr/jSn2zrye0jqdF+dKaLBCLG3B
         LXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783150; x=1714387950;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XB9rFLfMWN1g7ihRLHwOUgZ6Nm1LwOP8sZGJRcsldyE=;
        b=VMHpXjuaTtxcKNfmjzsWlxl967h/HeJ3Udn5H5wD2k+0IWAi1/nCqVV0E8AlJs0QfU
         PmTyX/KDcq1zk0Ear5nVL+E58G2RdOX/PkuTwaOJFusFTNoTZh9gCJCTS0tNwHLbjolU
         1OXhwu8Iap+O/4tTiNrXH4U5YaolIjdjyJUzx+ZgZXULYgl8DEl01Be4YWRzoVW1agf4
         95KlQ2ISwuRNs1R6MZgZA0jcBlNEFrRcY3PSZtMJFH40ofL4XKZ0s9e/MUpjag0EQ71C
         3HnBBUtES7/8dJRM+R38fzEEcMnaEaSthaB+fC53htctNqC7uCIYv3ogeBNgQnwYIEwf
         iXsg==
X-Forwarded-Encrypted: i=1; AJvYcCU3WGgIHLHCGjcadOBKyfElzqB+tiaEutYRoy3eGMXXXwMwki0I++V8iIDuZXc/Uq3ZSkYlVKB07rXppU8Aehg3rSuGC1rrTewvpOQt3sPXGwf+ym9EcPWN4tlggLhxwfiqDy4R+pUrygztrhrB1Yptp1MUgZoxOGSFKizoLIKbI6j11ZrF2N2A
X-Gm-Message-State: AOJu0Yy0h1hAcsQq/kla0/N2mX+G23LsAqUeaKC3fAatET063+Hm83NF
	QB0RMwXJAhSi4NLbzebkrPfxY/FUnf0Hwjru8jW0mSDSShUnJTpSWIQOVg==
X-Google-Smtp-Source: AGHT+IE2Fra+D9O2RmKL2tYXLgjMiLcbqzqK/4+uP5rJNuLIq6LRSJ0NyrdFpn1hET47c94bt7nfdQ==
X-Received: by 2002:a05:6512:398b:b0:51b:214c:5231 with SMTP id j11-20020a056512398b00b0051b214c5231mr3320962lfu.15.1713783150279;
        Mon, 22 Apr 2024 03:52:30 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b0051b627770ecsm111901lfl.237.2024.04.22.03.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 03:52:29 -0700 (PDT)
Message-ID: <b6ded975-1d16-46ea-84a2-8799b36e1270@gmail.com>
Date: Mon, 22 Apr 2024 13:52:27 +0300
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
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f7d454ac-6ecb-4431-a1de-c9b5d1240969@gmail.com>
 <eb03ec33-0627-4986-be04-8e35da390d6b@sirena.org.uk>
 <b6279be8-cf7d-4608-b556-3c01587f0d43@gmail.com>
 <f1e3d31d-8c24-4cdc-ae26-747f383a937b@gmail.com>
In-Reply-To: <f1e3d31d-8c24-4cdc-ae26-747f383a937b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi dee Ho peeps,

On 4/5/24 12:19, Matti Vaittinen wrote:
> On 4/4/24 16:15, Matti Vaittinen wrote:
>> Hi Mark,
>>
>> On 4/4/24 15:09, Mark Brown wrote:
>>> On Thu, Apr 04, 2024 at 10:26:34AM +0300, Matti Vaittinen wrote:
>>>
>>>> 1. Should we be able to have more than 1 IRQ domain / device?
>>>> 2. Should regmap_irq support having more than 1 HWIRQ
>>>
>>> I would expect each parent interrupt to show up as a separate remap_irq.

..
>>> So if we arrange to supply a name when we register multiple domains
>>> things should work fine?
> 
> After my latest findings, yes, I think so. How to do this correctly is 
> beyond me though. The __irq_domain_create() seems to me that the name is 
> meant to be the dt-node name when the controller is backed by a real 
> dt-node. Naming of the irq_domain_alloc_named_fwnode() sounds to me like 
> it is only intended to be used when there is no real fwnode. All 
> suggestions appreciated. Using the:
> irq_domain_update_bus_token(intb_domain, DOMAIN_BUS_WIRED);
> feels like a dirty hack, and won't scale if there is more HWIRQs.

I tried taking a look at this again.

If we wanted to support multiple HWIRQs / regmap-IRQ controller, it 
would require us to duplicate almost everything in the struct 
regmap_irq_chip for every new parent IRQ. The status/mask register 
information, IRQ type, etc. Naturally, it would require also duplicating 
lot of the data contained in the struct regmap_irq_chip_data. I am not 
sure if this could be done so the change is not reflected in the 
existing IRQ data initialization macros etc. Furthermore, some API 
changes would be required like changes to regmap_irq_get_domain().

I am a bit afraid this change, if implemented in regmap-IRQ, would be 
very intrusive and potentially impact large amount of callers. But more 
importantly, looking the amount of data that should be duplicated per 
new HWIRQ makes me think that an IRQ controller is really a product of a 
parent IRQ, not product of the device. Hence, assuming there is only one 
IRQ controller instance / device does not feel any more correct than 
assuming there is an IRQ controller instance / parent IRQ. Same thinking 
applies to IRQ domains.

Thus, forcing the regmap-IRQ to support multiple parents instead of 
having own regmap-IRQ instance / parent IRQ feels like fitting square 
item to a round hole. I am sure fixing all the bugs I caused would give 
donate a lot of EXP-points though :rolleyes:

Question is, should I still try?

Another option I see, is trying to think if irq-domain name could be 
changed. (This is what the RFC v3 does, [ab]using the 
irq_domain_update_bus_token()). I was a bit put off by the idea of 
'instantiating' multiple domains (or regmap-IRQ controllers) from a 
single node, but more I think of this, more I lean towards it. Besides, 
this is not something completely odd, I think MFD devices do this 
anyways. (Instantiate multiple [sub]devices from single DT-node). I 
would love to get an opinion from someone who knows the 'fundamentals' 
of the IRQ domains, and possibly some pointer for the right approach.

Finally we might also consider adding own sub-node in DT for each parent 
IRQ - but this feels very wrong to me.

All in all, I am having very hard time trying to think how to proceed. 
The last option for me is to skip support for the ERRB IRQ from the 
BD96801 driver, which would leave this problem to the next person 
working with a device providing multiple physical IRQs.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


