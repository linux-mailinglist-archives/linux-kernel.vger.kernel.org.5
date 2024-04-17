Return-Path: <linux-kernel+bounces-148018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248508A7CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF761F222AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB736A34C;
	Wed, 17 Apr 2024 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="QU4lGByn"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02E6A029;
	Wed, 17 Apr 2024 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337361; cv=none; b=AlTNBzbvGius0WLSsAfUrBvdrNzNPURHXZhXkgysoKX9A0KBj+Iny93lmbyZH6ctsXDn1zHKogTAxt0f4omITFuhKd+ayL0zgs0vk2CxDehfHd1MU8ec1FNGK+RRmO1BruqLZuXPEE+7Wqae3+s/MOs4SGwvWQFwA7CZOWftR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337361; c=relaxed/simple;
	bh=MmPZqLHT6L7Vgu7zz8S+Lpd/ePgl7MaOqJfEknD5Mg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxsAzGhNxMWMQgVGd5U8g71xuqVNhBcYN/YvTBEWGeNNVawCBBRKS2FHersATWVjidfEnYf3+cn3WPmVmoA/KOew4pti75cgJij1Q08k2Iw8NhuXBPp4cXRd1sD60i0D5oia2/bO7PFpP9l7v6QAuNhjwV6TKTsZbxx3J2lGHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=QU4lGByn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D33EE0008;
	Wed, 17 Apr 2024 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713337357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHi33ssp9kCXeOvzprYeABBoEMwbdoM+wrd834QLJgg=;
	b=QU4lGBynmQ5d3Z4ZmTULXjUTDwkmk5natWmgnO1imlQ1bVRPMtlLpNeLVZXZ1IcJRNuztx
	wePVgJlAYGli9/dzyC6C7oH9C5oBIgwVxNphpIV3REr7jmxMNrhyd0m1FaZOszzItJM1Zq
	Id1yoHl8PizieY9dSgxsrkgTfu7ZlfB2u6v8Lae+MzF2iVPtsB7WRYYUTJReJjMF5to/uC
	fAMnT3zgHQAVk82Eg5VB+cR2NJbz5YV6J++Lhd8tYxodZJu/JJqw3EHdHTZt4lfhEyZstN
	MUJwgKTVvvdmjC658Wzjq6OvSDz555mdVpe2rsDT+mF6n4lWhvXfwUm304Kjvw==
Message-ID: <48cabb89-e3bb-4f72-b6fc-024b6900149d@arinc9.com>
Date: Wed, 17 Apr 2024 10:02:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mt7530-mdio: read PHY address
 of switch from device tree
To: Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-0-1a7649c4d3b6@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-1-1a7649c4d3b6@arinc9.com>
 <459b31bd-64b3-4804-bc5a-c8ffd145e055@gmail.com>
 <7d0ded52-14f0-4f6a-b639-72f537603be8@arinc9.com>
 <050ef345-9f4c-437c-863b-fdb8e2a47041@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <050ef345-9f4c-437c-863b-fdb8e2a47041@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 17/04/2024 06:09, Florian Fainelli wrote:
> 
> 
> On 4/16/2024 1:32 AM, Arınç ÜNAL wrote:
>> On 15/04/2024 18:30, Florian Fainelli wrote:
>>> I would go a step further and name phy_addr switch_mdio_addr, or something along those lines to clearly denote this is not a per-port PHY address neither a proper PHY device, but we've already had a similar discussion before about spelling this out clearly as a "pseudo PHY"....
>>
>> I am fine with calling the switch operating on an MDIO bus a psuedo-PHY.
>> But I don't believe this grants making up names on our own instead of using
>> the name described in IEEE Std 802.3-2022. The switch listens on a PHY
>> address on the MDIO bus. 
> 
> The switch listens at a particular address on the MDIO bus, that is the key thing. Whether the addressable device happens to be an Ethernet/SATA/PCIe/USB PHY, an accelerometer, a light switch or an Ethernet switch does not matter as long as it is addressable over clause 22 and/or 45. For all that matters the switch's MDIO interface is not a PHY, otherwise its registers 0-15 would be abiding by the IEEE 802.3-2022 standard, and that is not the case.

I don't deny anything you've said here. I just don't see how this
constitutes making up a different name. The field which the address is
stored is called "PHYAD (PHY Address)". The PHY Address field of the
management frame structure the switch implements is still Clause 22
conformant, as far as I understand.

> 
>> The description for the phy_addr member of the
>> mt753x_info structure clearly explains that so I don't see a reason to
>> change the variable name.
> 
> IMHO it is clearer to use mdiodev->addr through and through, the shorthand is not necessary and does not save that many characters to type in the first place. Saving a mdiodev pointer into mt7530_priv and accessing priv->mdiodev->addr would be 18 characters to type versus 14 with priv->phy_addr.

Fine by me, I can do that.

Arınç

