Return-Path: <linux-kernel+bounces-30818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6C83249B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AEEB21250
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9BDDB7;
	Fri, 19 Jan 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="Mo/nlb74"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E91113;
	Fri, 19 Jan 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645869; cv=none; b=QjwBp1LOzh+cqkqk8llkG3UN/WeXpZdt0m2YkNGWhERnFURWobzyUoR5Zujg9bg6btzb0w2Z0tavLRVAsn+F5J5k8BSZMWXvuIqgiZio3OUMRLKvOeYajm7hXYXB7O8VLYVlcUVv1aAoI8/BcPQ1fkU8C1pmZMFoD7+OHPeZbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645869; c=relaxed/simple;
	bh=nnazP5H6SMjvpHngS1CndHucry3V/1GBbNtZrY9N74Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DFwWI8720jppExp7Ton7R4wG2UspbiCVvbsOR5DhWq8R4iiZZ+wu2ZI9M2tGG739o+pkPGDibceAGIOEE/vCihdQMuoPqEi5WkYnHVz1XNBbGHKe1OGOgFo4NJA178AOLyNM4WPXuxG2dbnS2PGKrZ9Hv8kjHjODusnBknHJMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=Mo/nlb74; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 9F8F29400107;
	Fri, 19 Jan 2024 07:30:59 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id GxGwJ2QrRb54; Fri, 19 Jan 2024 07:30:59 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 6FF68940010D;
	Fri, 19 Jan 2024 07:30:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 6FF68940010D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705645859; bh=vzgrzR/fOk6sY8b1q4eaLk8ijdRdaJ8tk+AyvNHT7dQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Mo/nlb74ZhMo835+D4Styws15BksZEejL/gconR0mj3GatfZu6xRZB8MgxyzaPhhM
	 YKyHKPFB2XZWjyZ5OVBySRAELnlQ+FoR/jzxskPdrOmaFbEKaVYPmoBRyEXrVc7fcZ
	 3YKbdKallZn/xbfG3l+QBsKJPG6n5bdDwPuYNa/oqWNri8ff9zBynu/wtUbNg27UEw
	 J0YPNrh3YYAt3wOYHu4PSRZQp1C5gHG/w06IJM2PUgevUz/dlvdpNNyHtuEeLHtFFc
	 2pg8cGpODejH69EaHlQgNpEpa1gh9GhEEr0EU8+FfTzA8wEyXhnL+NI/sYWS4kmyRm
	 d/2iMoId1HP4w==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id y3q33CBtFvWw; Fri, 19 Jan 2024 07:30:59 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 08A2E9400107;
	Fri, 19 Jan 2024 07:30:59 +0100 (CET)
Date: Fri, 19 Jan 2024 07:30:46 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
cc: Andrew Lunn <andrew@lunn.ch>, 
    Andre Werner <andre.werner@systec-electronic.com>, davem@davemloft.net, 
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
    linux@armlinux.org.uk, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
In-Reply-To: <70a4f7de-6032-4247-a484-56d1fdcee7f8@gmail.com>
Message-ID: <78d30a5b-0308-7fd5-1b2c-7e9aeef238d8@systec-electronic.com>
References: <20240118104341.10832-1-andre.werner@systec-electronic.com> <322d5543-4d13-48a7-af58-daa8cc840f05@lunn.ch> <727d83ab-3315-4b5c-84da-25f8ffd6aca5@gmail.com> <4e30f871-c7b7-4dc5-ba4c-629a63dc3261@lunn.ch>
 <70a4f7de-6032-4247-a484-56d1fdcee7f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 Jan 2024, Heiner Kallweit wrote:

> On 18.01.2024 21:09, Andrew Lunn wrote:
>> On Thu, Jan 18, 2024 at 06:36:16PM +0100, Heiner Kallweit wrote:
>>> On 18.01.2024 17:53, Andrew Lunn wrote:
>>>> On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
>>>>> If using ADIN1100 as an external phy, e.g. in combination with
>>>>> "smsc95xx", we ran into nullptr exception by creating a link.
>>>>>
>>>>> In our case the "smsc95xx" does not check for an available interrupt handler
>>>>> on external phy driver to use poll instead of interrupts if no handler is
>>>>> available. So we decide to implement a small handler in the phy driver
>>>>> to support other MACs as well.
>>>>>
>>>>> I update the driver to add an interrupt handler because libphy
>>>>> does not check if their is a interrupt handler available either.
>>>>>
>>>>> There are several interrupts maskable at the phy, but only link change interrupts
>>>>> are handled by the driver yet.
>>>>>
>>>>> We tested the combination "smsc95xx" and "adin1100" with Linux Kernel 6.6.9
>>>>> and Linux Kernel 6.1.0, respectively.
>>>>
>>>> Hi Andre
>>>>
>>>> A few different things....
>>>>
>>>> Please could you give more details of the null pointer
>>>> exception. phylib should test if the needed methods have been
>>>> implemented in the PHY driver, and not tried to use interrupts when
>>>> they are missing. It should of polled the PHY. So i would like to
>>>> understand what went wrong. Maybe we have a phylib core bug we should
>>>> be fixing. Or a bug in the smsc95xx driver.
>>>>
>>> Seems to be a bug in smsc95xx. The following is the relevant code piece.
>>>
>>> ret = mdiobus_register(pdata->mdiobus);
>>> 	if (ret) {
>>> 		netdev_err(dev->net, "Could not register MDIO bus\n");
>>> 		goto free_mdio;
>>> 	}
>>>
>>> 	pdata->phydev = phy_find_first(pdata->mdiobus);
>>> 	if (!pdata->phydev) {
>>> 		netdev_err(dev->net, "no PHY found\n");
>>> 		ret = -ENODEV;
>>> 		goto unregister_mdio;
>>> 	}
>>>
>>> 	pdata->phydev->irq = phy_irq;
>>>
>>> The interrupt is set too late, after phy_probe(), where we have this:
>>>
>>> if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
>>> 		phydev->irq = PHY_POLL;
>>>
>>> So we would have two steps:
>>> 1. Fix the smsc95xx bug (as the same issue could occur with another PHY type)
>>
>> Its not so nice to fix.
>>
>> Normally you would do something like:
>>
>>         pdata->mdiobus->priv = dev;
>>         pdata->mdiobus->read = smsc95xx_mdiobus_read;
>>         pdata->mdiobus->write = smsc95xx_mdiobus_write;
>>         pdata->mdiobus->reset = smsc95xx_mdiobus_reset;
>>         pdata->mdiobus->name = "smsc95xx-mdiobus";
>>         pdata->mdiobus->parent = &dev->udev->dev;
>>
>>         snprintf(pdata->mdiobus->id, ARRAY_SIZE(pdata->mdiobus->id),
>>                  "usb-%03d:%03d", dev->udev->bus->busnum, dev->udev->devnum);
>>
>> 	pdata->mdiobus->irq[X] = phy_irq;
>>
>> 	ret = mdiobus_register(pdata->mdiobus);
>>
>> By setting pdata->mdiobus->irq[X] before registering the PHY, the irq
>> number gets passed to the phydev->irq very early on. If everything is
>> O.K, interrupts are then used.
>>
>> However, because of the use of phy_find_first(), we have no idea what
>> address on the bus the PHY is using. So we don't know which member of
>> irq[] to set. Its not ideal, but one solution is to set them all.
>>
>> However, a better solution is to perform the validation again in
>> phy_attach_direct(). Add a second:
>>
>> 	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
>>         	phydev->irq = PHY_POLL;

I add this check into phy_device.c-> phy_attach_direct as a work around
for now. I will send a new patch set to net-next as suggested.

>>
> This would save us here, but can't prevent that phydev->irq may be set
> even later. I think, ideally nobody should ever access phydev->irq directly.
> There should be a setter which performs the needed checks.
> But it may be a longer journey to make parts of struct phy_device private
> to phylib.
>
>> which will force phydev->irq back to polling.
>>
>>       Andrew
>
> Heiner
>

Regards,

Andre

