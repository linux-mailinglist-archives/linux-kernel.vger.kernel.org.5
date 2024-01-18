Return-Path: <linux-kernel+bounces-30574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E58320D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6251C22149
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054043173E;
	Thu, 18 Jan 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC4W2gp9"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CC2E405;
	Thu, 18 Jan 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613047; cv=none; b=m+hrFwWqJpuS+fA9V8FQbb08M9eRxP9mNlVHS/cY0JQft5+rFbNzgX2G0kGDuGQXvJjEoNdVwIRlusN0aNKo42IyECi6fn13850RewHTW6hSBg9Z8lqiLc16JPjcwkbZ3XhqR2AXWWM8wK3NYPSG0/7fB2qjz80cd+4+o2AV/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613047; c=relaxed/simple;
	bh=nV5Epwtfj43CfsDY+btqvJMgNLhKxrX+UbpI0r1cITQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laLfroYJ8yJCwACHI3mtTiJ/H9hwb94KsXVwajgiDO6nfe9NPzvlJSXOxe0AkNL32xHkr3iBkgkIcYFdoyKKiqgsMqKdshkICuyPeA0RGr7fdwj1G2F0gb2osLjsJDyhIQbYjNxC4qCXzP7+0hF9S8ktvMH5Htdb4qE1ypYb2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC4W2gp9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2e0be86878so228904166b.1;
        Thu, 18 Jan 2024 13:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705613044; x=1706217844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6V7BDU9o08vRVVyAw58Pbua7zHoihB1/j/BFdMT2AoM=;
        b=nC4W2gp9NDHjIlszQuAmfhUw2xhwUOBG9T1fYWE7PMBmX64iWBAfueC/RQWY+SanhK
         hz4nTNDSpgOskkiXATKnk0GBq8+qRM2nkNtg1zAQwNmIYB0lZafiYVII6yAvgNq84XZG
         po0r0AuQFQB+znZ2i7OjmC9Wi6dRmZv5grOsC+MbQw3jycFIh+2orVDq/iBrp09MLroD
         k0vjy4XFV7VWWdGeN5K5b1YNS+lnzAVM6Ukr5MoGMU+6ddm3qLDBh/JQ+bTQSW+wNQ47
         2vU23NbWAPVJWOE/46K5dhgcVRPf/jqEesJQmIVds/7hO495mfipEvJP8mRfE/yzBYts
         h8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705613044; x=1706217844;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V7BDU9o08vRVVyAw58Pbua7zHoihB1/j/BFdMT2AoM=;
        b=ELAjtEORhIwgWVT6V0eZuU1fXC+qP3s9rDX3pSOJxhsg3Z3Tf+/pu0FGe5StSIW2b/
         uu7doorQdnuwPULruXtGITMprG4mNKLbmgipf9sNSjhZSIx57LFGS8JVylwwcDloSwHZ
         ZONZb187NuZ/mhlhtldCpbvWf9DrBiQkxpiuxvjTsyLjokgpxoB/ivvng3Tj5xIj1F9Z
         rYahkd3EF3gp/gS2wKBbdaoV2B5Sll2vPoZNuz5Yi4ehzIhdwyf2yDqdkMhsOrzKEFz/
         FeyqSANf7Mo+wKZUVXh7IyYZciQaroxC8d/f4aqHyEuqOyODq77OgdLGodyFSEzR5DO5
         gd2Q==
X-Gm-Message-State: AOJu0YxquQACwSFoLVE4YTHld9zCva7Iylj0o/tZAFrVl+uSGeP9uekt
	xZW4pkpQMHkZgXXp/ijChNLjeD6w7U/QcliQ9fj29SK21rqbflCv
X-Google-Smtp-Source: AGHT+IGRl05QVJGRsN1ucHpsFmEeNyaX2ChFO6PGcn2zyLPIzH3jrWEjtRFYCvKpzpTf+FZkoYbq4g==
X-Received: by 2002:a17:906:b089:b0:a2b:2bdb:5a2a with SMTP id x9-20020a170906b08900b00a2b2bdb5a2amr1871741ejy.49.1705613043500;
        Thu, 18 Jan 2024 13:24:03 -0800 (PST)
Received: from ?IPV6:2a01:c22:7bf1:7700:512:7071:c9dd:e8d5? (dynamic-2a01-0c22-7bf1-7700-0512-7071-c9dd-e8d5.c22.pool.telefonica.de. [2a01:c22:7bf1:7700:512:7071:c9dd:e8d5])
        by smtp.googlemail.com with ESMTPSA id hy7-20020a1709068a6700b00a280944f775sm9534875ejc.153.2024.01.18.13.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 13:24:03 -0800 (PST)
Message-ID: <70a4f7de-6032-4247-a484-56d1fdcee7f8@gmail.com>
Date: Thu, 18 Jan 2024 22:24:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andre Werner <andre.werner@systec-electronic.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118104341.10832-1-andre.werner@systec-electronic.com>
 <322d5543-4d13-48a7-af58-daa8cc840f05@lunn.ch>
 <727d83ab-3315-4b5c-84da-25f8ffd6aca5@gmail.com>
 <4e30f871-c7b7-4dc5-ba4c-629a63dc3261@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4e30f871-c7b7-4dc5-ba4c-629a63dc3261@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.01.2024 21:09, Andrew Lunn wrote:
> On Thu, Jan 18, 2024 at 06:36:16PM +0100, Heiner Kallweit wrote:
>> On 18.01.2024 17:53, Andrew Lunn wrote:
>>> On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
>>>> If using ADIN1100 as an external phy, e.g. in combination with
>>>> "smsc95xx", we ran into nullptr exception by creating a link.
>>>>
>>>> In our case the "smsc95xx" does not check for an available interrupt handler
>>>> on external phy driver to use poll instead of interrupts if no handler is
>>>> available. So we decide to implement a small handler in the phy driver
>>>> to support other MACs as well.
>>>>
>>>> I update the driver to add an interrupt handler because libphy
>>>> does not check if their is a interrupt handler available either.
>>>>
>>>> There are several interrupts maskable at the phy, but only link change interrupts
>>>> are handled by the driver yet.
>>>>
>>>> We tested the combination "smsc95xx" and "adin1100" with Linux Kernel 6.6.9
>>>> and Linux Kernel 6.1.0, respectively.
>>>
>>> Hi Andre
>>>
>>> A few different things....
>>>
>>> Please could you give more details of the null pointer
>>> exception. phylib should test if the needed methods have been
>>> implemented in the PHY driver, and not tried to use interrupts when
>>> they are missing. It should of polled the PHY. So i would like to
>>> understand what went wrong. Maybe we have a phylib core bug we should
>>> be fixing. Or a bug in the smsc95xx driver.
>>>
>> Seems to be a bug in smsc95xx. The following is the relevant code piece.
>>
>> ret = mdiobus_register(pdata->mdiobus);
>> 	if (ret) {
>> 		netdev_err(dev->net, "Could not register MDIO bus\n");
>> 		goto free_mdio;
>> 	}
>>
>> 	pdata->phydev = phy_find_first(pdata->mdiobus);
>> 	if (!pdata->phydev) {
>> 		netdev_err(dev->net, "no PHY found\n");
>> 		ret = -ENODEV;
>> 		goto unregister_mdio;
>> 	}
>>
>> 	pdata->phydev->irq = phy_irq;
>>
>> The interrupt is set too late, after phy_probe(), where we have this:
>>
>> if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
>> 		phydev->irq = PHY_POLL;
>>
>> So we would have two steps:
>> 1. Fix the smsc95xx bug (as the same issue could occur with another PHY type)
> 
> Its not so nice to fix.
> 
> Normally you would do something like:
> 
>         pdata->mdiobus->priv = dev;
>         pdata->mdiobus->read = smsc95xx_mdiobus_read;
>         pdata->mdiobus->write = smsc95xx_mdiobus_write;
>         pdata->mdiobus->reset = smsc95xx_mdiobus_reset;
>         pdata->mdiobus->name = "smsc95xx-mdiobus";
>         pdata->mdiobus->parent = &dev->udev->dev;
> 
>         snprintf(pdata->mdiobus->id, ARRAY_SIZE(pdata->mdiobus->id),
>                  "usb-%03d:%03d", dev->udev->bus->busnum, dev->udev->devnum);
> 
> 	pdata->mdiobus->irq[X] = phy_irq;
> 
> 	ret = mdiobus_register(pdata->mdiobus);
> 
> By setting pdata->mdiobus->irq[X] before registering the PHY, the irq
> number gets passed to the phydev->irq very early on. If everything is
> O.K, interrupts are then used.
> 
> However, because of the use of phy_find_first(), we have no idea what
> address on the bus the PHY is using. So we don't know which member of
> irq[] to set. Its not ideal, but one solution is to set them all.
> 
> However, a better solution is to perform the validation again in
> phy_attach_direct(). Add a second:
> 
> 	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
>         	phydev->irq = PHY_POLL;
> 
This would save us here, but can't prevent that phydev->irq may be set
even later. I think, ideally nobody should ever access phydev->irq directly.
There should be a setter which performs the needed checks.
But it may be a longer journey to make parts of struct phy_device private
to phylib.

> which will force phydev->irq back to polling.
> 
>       Andrew

Heiner

