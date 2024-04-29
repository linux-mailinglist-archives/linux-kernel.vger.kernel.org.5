Return-Path: <linux-kernel+bounces-162353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF91F8B59B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FA91F2293F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0556B6C;
	Mon, 29 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="FGEd0IUV"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071674404;
	Mon, 29 Apr 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396701; cv=none; b=Q/skNZEUV07BRMCzKnqML/vlQ3yPToFl2Fff8oR5rtmTGf0xuHbzuiYhkCLT1vBN65gMqDbIt6IL331DXxkhCvmu8uAV5l9bozmt80JZl3TZExX4+fXp9tJdpKS8uIm1ZBW3ygOf3S28NkVIodgE+7vBnza1cTicectnhzaIprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396701; c=relaxed/simple;
	bh=EUNYM67ljV/1+l6ugAx8BfuV7yZemSgbjdsgHuN1rzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ta39qU74o4aQRWbPSlinkK+n0d/sOVbKQsiNKNX6qENo9nu5/bqhLVbAVwJC0MU/SQIw6Tn+MJPyUupwEz9FmrJWrTuoP2ocmVq9RhWYQ+WDVpfrA7PPiTWhC0xL9I554ekr/XiZWorH0zIeFW4CsJJKcKC+cgThCEBa7WyKkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=FGEd0IUV; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4C1DC0005;
	Mon, 29 Apr 2024 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1714396691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WIxTn0pRjbZXHgFG8AwaR4joGVxkdi8wOuc1SO7gIs=;
	b=FGEd0IUVUimnHqEMC3oAwvto00HNVnMflL0L7Ph/Ryrk7N/JOd8t1z4bbBPy5b58KRO9k5
	I3szYcCy8KVwRYHA1I6NfbF0HWGffDxy9+baoG19copWjA/jxRvbpIWFAaMDBDjyaWLWXk
	IKPn/HbPA4OqlW2+y/DGE85RCCMAklQrxnr+rWemcMa7T4IlOjaPDGsuV3y00M+UGoipOp
	Lsv/aCYhblt5FsBnUNpFA/1mLETUrUj0KaEnJ+E/2UYRMLXP3yc6HN0o0gYxq4oRf5EWh1
	txO81TyFcNZxEJVl4hf3JCF+BaPQlmyEXsv00J6rxXu9sd40YeFXkPafTdvXzg==
Message-ID: <f5eb359a-fdbf-4b0a-8df5-be034da1aca3@arinc9.com>
Date: Mon, 29 Apr 2024 16:17:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: detect PHY muxing when PHY is
 defined on switch MDIO bus
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240429-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v1-1-1f775983e155@arinc9.com>
 <Zi9vYLwgekd0Pmzn@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zi9vYLwgekd0Pmzn@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 29.04.2024 12:58, Russell King (Oracle) wrote:
> On Mon, Apr 29, 2024 at 12:46:43PM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Currently, the MT7530 DSA subdriver configures the MT7530 switch to provide
>> direct access to switch PHYs, meaning, the switch PHYs listen on the MDIO
>> bus the switch listens on. The PHY muxing feature makes use of this.
>>
>> This is problematic as the PHY may be probed before the switch is
>> initialised, in which case attaching the PHY will fail.
>>
>> Since commit 91374ba537bd ("net: dsa: mt7530: support OF-based registration
>> of switch MDIO bus"), we can describe the switch PHYs on the MDIO bus of
>> the switch on the device tree. Extend the check to detect PHY muxing when
>> the PHY is defined on the MDIO bus of the switch on the device tree.
>>
>> When the PHY is described this way, the switch will be initialised first,
>> then the switch MDIO bus will be registered. Only after these steps, the
>> PHY will be probed.
> 
> Looking at the commit description and the patch, I'm not sure whether
> you really mean "probed" or whether you mean "attached".
> 
> PHY drivers will bind to PHY devices when they are detected on the MDIO
> bus (either by scanning or instantiating firmware description) and the
> devices are registered. As each device is registered, the drivers for
> the bus type are scanned and any matches will have their probe function
> called. This happens outside of any control of the DSA driver if the
> DSA device is on the same MDIO bus.
> 
> This is separate from the process of looking up a PHY and attaching the
> PHY.
> 
> So, I think there is probably a terminology issue with the patch
> description. I suspect you don't mean "probing" as in phy_probe() being
> called. Looking at the code, it looks like the driver is making
> decisions based on how PHYs are connected to the ethernet MACs in the
> device tree, and you're making decisions based on that. I wouldn't call
> that "probing" a PHY.

Yes, I meant to say "looking up a PHY and attaching the PHY" by probing a
PHY. I'll adjust the patch log to below, thanks.

Currently, the MT7530 DSA subdriver configures the MT7530 switch to provide
direct access to switch PHYs, meaning, the switch PHYs listen on the MDIO
bus the switch listens on. The PHY muxing feature makes use of this.

This is problematic as the PHY may be attached before the switch is
initialised, in which case, the PHY will fail to be attached.

Since commit 91374ba537bd ("net: dsa: mt7530: support OF-based registration
of switch MDIO bus"), we can describe the switch PHYs on the MDIO bus of
the switch on the device tree. Extend the check to detect PHY muxing when
the PHY is defined on the MDIO bus of the switch on the device tree.

When the PHY is described this way, the switch will be initialised first,
then the switch MDIO bus will be registered. Only after these steps, the
PHY will be attached.

Arınç

