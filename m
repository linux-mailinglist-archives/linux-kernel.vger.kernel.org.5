Return-Path: <linux-kernel+bounces-18351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB826825BED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5602028535C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7F21A11;
	Fri,  5 Jan 2024 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="jDeNszcH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F536091;
	Fri,  5 Jan 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 401C8FF805;
	Fri,  5 Jan 2024 20:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704487536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMAg9jld//C51JoR4LMGUJ8fPsqbBBCWDsSDlVbcZt4=;
	b=jDeNszcHy+TaKLR6TCFOLvVAPiRaRJdw+iRQvipfT9sLXuI+Hnll/4icc9lB9aQJ7dcqIV
	pKCCdNpNC39hBK0M0oABh5XXXImfLcrMRV97tNgfWO40lgsIGJ8RN02bqxKq5yR424Xi1Z
	KHq4Geyu7CvCkH0knoLqwLslPOyzLRszSyvIxn8O45fQKMUp6vCJyr3oemDPBn+c7yQvJV
	nKGXRQ0xLAg8i3hC2hwjlTUxuH9jBCfcIfGFLyTy7/7julcomY2Zdx020rbTpsnd1iKbP8
	TZpqnV+Zut57nRIHduGgdsmREw5NwN0E4BKvwYmj15VJBmjt7kk2IKiH0S5WHw==
Message-ID: <d31000b0-c0d9-457f-9493-e54fd228e317@arinc9.com>
Date: Fri, 5 Jan 2024 23:45:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231221151607.ujobhh4aet4obxdz@skbuf>
 <6600c6b1-2230-4963-940c-8b95a01750fd@arinc9.com>
 <20231227191154.6jkqdlqdxciidpfw@skbuf>
 <bdbe24b2-30f6-48fa-b6eb-a1ae3afe9076@arinc9.com>
 <20231227200217.kdltxpmhvlp6z4cd@skbuf>
 <d2a7cc7e-bb27-472f-8921-5579a894c71d@arinc9.com>
 <20240103190246.ctyeehvfmhctpphf@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240103190246.ctyeehvfmhctpphf@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 3.01.2024 22:02, Vladimir Oltean wrote:
> On Thu, Dec 28, 2023 at 07:58:13PM +0300, Arınç ÜNAL wrote:
>> The implementation below follows this logic:
>>
>> No switch MDIO bus defined: Register the MDIO bus, set the interrupts for
>> PHYs if "interrupt-controller" is defined at the switch node.
>>
>> Switch MDIO bus defined: Register the MDIO bus, set the interrupts for PHYs
>> if ["interrupt-controller" is defined at the switch node and "interrupts"
>> is defined at the PHY nodes under the switch MDIO bus node].
>>
>> I think this approach fits your description so I'd like to agree that this
>> should be the way for all DSA subdrivers. Please let me know what you
>> think.
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 391c4dbdff42..bbd230a73ead 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2155,15 +2155,21 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>>   {
>>   	struct dsa_switch *ds = priv->ds;
>>   	struct device *dev = priv->dev;
>> +	struct device_node *np, *mnp;
>>   	struct mii_bus *bus;
>>   	static int idx;
>>   	int ret;
>> +	np = priv->dev->of_node;
>> +	mnp = of_get_child_by_name(np, "mdio");
>> +
> 
> Empty line between variable declarations and code. Or you can initialize
> them as part of their declaration, but you need to stick to the "longest
> line first" rule.
> 
> Also, it would be good to also check of_device_is_available(mnp).

Will do.

> 
>> +		ds->user_mii_bus = bus;
>> +
>>   	bus->priv = priv;
>>   	bus->name = KBUILD_MODNAME "-mii";
>>   	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
>> @@ -2174,10 +2180,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>>   	bus->parent = dev;
>>   	bus->phy_mask = ~ds->phys_mii_mask;
>> -	if (priv->irq)
>> +	if (priv->irq && mnp == NULL)
>>   		mt7530_setup_mdio_irq(priv);
>> -	ret = devm_mdiobus_register(dev, bus);
>> +	ret = devm_of_mdiobus_register(dev, bus, mnp);
>> +	of_node_put(mnp);
> 
> This is going to be interesting. There isn't really a correct way to
> manage the reference to "mnp", as far as I can tell. Normally, it should
> have been possible to release the reference as you did. But you need
> something along the lines of what Luiz/Russell have been discussing
> here:
> 
> https://lore.kernel.org/netdev/20231220045228.27079-2-luizluca@gmail.com/
> 
> In any case, the devres variant of of_mdiobus_register() seems incompatible
> with the mt7530 driver owning the "mnp" node for any longer than this,
> because it has no hook to call of_node_put() once the MDIO bus is unregistered.

I'm not sure what's the step I should take here. I don't know how MDIO
registration works and don't intend to spend time studying it at this time.

Looking at the conversation, I see that, in the end, this patch is applied:

https://lore.kernel.org/netdev/E1rLL6p-00EvAd-Ej@rmk-PC.armlinux.org.uk/

> 
>>   	if (ret) {
>>   		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
>>   		if (priv->irq)
>>
>> With this device tree:
>>
>> switch {
>> 	interrupt-controller;
>> }
>>
>> [    1.420534] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
>> [    1.433224] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
>> [    1.445338] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
>> [    1.457472] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
>> [    1.469587] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)
>>
>> With this device tree:
>>
>> switch {
>> 	interrupt-controller;
>>
>> 	mdio {
>> 		phy {
>> 			reg = <0>;
>> 		}
>> 	}
>> }
>>
>> [    1.413101] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    1.429954] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    1.443704] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    1.455876] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    1.468079] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=POLL)
>>
>> With this device tree:
>>
>> switch {
>> 	interrupt-controller;
>>
>> 	mdio {
>> 		phy {
>> 			reg = <0>;
>> 			interrupts = <0>;
>> 		}
>> 	}
>> }
>>
>> [    1.420534] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
>> [    1.433224] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
>> [    1.445338] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
>> [    1.457472] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
>> [    1.469587] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)
> 
> Looks sane.
> 
> FWIW, I found Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> where internal PHYs don't have an 'interrupts' property, yet they are
> probably still expected to use interrupts - according to ksz_irq_phy_setup().

This conflicts with the reason we want the subdrivers to use
ds->user_mii_bus for. I'd much like to implement what I've done with this
patch to this subdriver. I believe it's negligible for the old device trees
to have the switch PHYs work with polling until the interrupts are defined
on the device tree.

> 
> Anyway, what's done is done, but I still don't see the point of making
> the binding much more flexible than it needs to be.

I don't see it that way. It's simply about describing the hardware. PHYs
without interrupts is still valid hardware. If the PHYs of this specific
hardware cannot possibly come without interrupts, then it should be the
bindings that ensure that interrupts on the device tree are always defined.
Not the other way around: Keep this information out of the device tree and
do it on the subdriver.

Arınç

