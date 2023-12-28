Return-Path: <linux-kernel+bounces-12794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4D81FA1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90231285D26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A414810950;
	Thu, 28 Dec 2023 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="g4obSGsG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFC107B0;
	Thu, 28 Dec 2023 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40D4660003;
	Thu, 28 Dec 2023 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703782701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLzd7A9jFskmhen4DUM2XT5CFAIISUlx1M90s2C0fRs=;
	b=g4obSGsGdqga49bgW8wAunpOtYZ0THRFsYWaK4w7Af0B0xPCc90zQ+86HdcMGVvPoU7I6N
	JGcMDWFjCwKDXP0yaOMFncICV1yeNYsgLN2sQ7kT/0RgBZE8XZiabUaGSXvAO6+4InerMj
	8GZlnaSpqzmhSxJgexjcgeXJUNgJlCm7ukiB0jp4wY3c64hVw8JXZ1raAnyFONxmba3ZkP
	MzawQwY8euzM3riMX9gGKIe7QL6Lhtteg/Zaxj9+D3UV9UdVUZJ43MTP4+khVGmvU8f5wC
	gF08+DBfiPO1pnR7eKy9mk2nGHJMIUYxHZnKZzSsngDLFfzfBI9zHfmTkMb2ZA==
Message-ID: <d2a7cc7e-bb27-472f-8921-5579a894c71d@arinc9.com>
Date: Thu, 28 Dec 2023 19:58:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231227200217.kdltxpmhvlp6z4cd@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 27.12.2023 23:02, Vladimir Oltean wrote:
> On Wed, Dec 27, 2023 at 10:51:08PM +0300, Arınç ÜNAL wrote:
>> I didn't realise ds->user_mii_bus is also used to store irq mapping for
>> each PHY.
> 
> It needs to, if the MDIO bus does not have an OF description through
> which PHYs can have an 'interrupts' property. But if there is an OF
> description for the MDIO bus and the PHYs, I think it is strange to
> expect PHYs to have interrupts if they aren't described in OF.
> 
>> Should we agree that user_mii_bus is needed for all cases or make
>> another way to store the irq mappings?
> 
> I looked at the upstream device trees:
> - users of arch/mips/boot/dts/ralink/mt7621.dtsi
> - arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dts
> - arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dts
> - arch/arm/boot/dts/mediatek/mt7623a.dtsi
> - arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> - arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> - arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> - arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> 
> and without exception, none of these have the MDIO bus described in OF.
> I'm not sure about other device trees. But it may well be that the
> situation where "MDIO buses present in OF need an IRQ mapping for their
> PHYs" does not need to be handled.

As Daniel stated on a previous submission of this patch, being able to
reference the PHYs on the switch MDIO bus is mandatory on MT7988 as
calibration data from NVMEM for each PHY is required, so defining the MDIO
bus is required to support MT7988. Therefore, we should support interrupts
on device trees with the switch MDIO bus defined.

The implementation below follows this logic:

No switch MDIO bus defined: Register the MDIO bus, set the interrupts for
PHYs if "interrupt-controller" is defined at the switch node.

Switch MDIO bus defined: Register the MDIO bus, set the interrupts for PHYs
if ["interrupt-controller" is defined at the switch node and "interrupts"
is defined at the PHY nodes under the switch MDIO bus node].

I think this approach fits your description so I'd like to agree that this
should be the way for all DSA subdrivers. Please let me know what you
think.

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..bbd230a73ead 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2155,15 +2155,21 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
  {
  	struct dsa_switch *ds = priv->ds;
  	struct device *dev = priv->dev;
+	struct device_node *np, *mnp;
  	struct mii_bus *bus;
  	static int idx;
  	int ret;
  
+	np = priv->dev->of_node;
+	mnp = of_get_child_by_name(np, "mdio");
+
  	bus = devm_mdiobus_alloc(dev);
  	if (!bus)
  		return -ENOMEM;
  
-	ds->user_mii_bus = bus;
+	if (mnp == NULL)
+		ds->user_mii_bus = bus;
+
  	bus->priv = priv;
  	bus->name = KBUILD_MODNAME "-mii";
  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
@@ -2174,10 +2180,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
  	bus->parent = dev;
  	bus->phy_mask = ~ds->phys_mii_mask;
  
-	if (priv->irq)
+	if (priv->irq && mnp == NULL)
  		mt7530_setup_mdio_irq(priv);
  
-	ret = devm_mdiobus_register(dev, bus);
+	ret = devm_of_mdiobus_register(dev, bus, mnp);
+	of_node_put(mnp);
  	if (ret) {
  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
  		if (priv->irq)

With this device tree:

switch {
	interrupt-controller;
}

[    1.420534] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
[    1.433224] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
[    1.445338] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
[    1.457472] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
[    1.469587] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)

With this device tree:

switch {
	interrupt-controller;

	mdio {
		phy {
			reg = <0>;
		}
	}
}

[    1.413101] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=POLL)
[    1.429954] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=POLL)
[    1.443704] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=POLL)
[    1.455876] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=POLL)
[    1.468079] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=POLL)

With this device tree:

switch {
	interrupt-controller;

	mdio {
		phy {
			reg = <0>;
			interrupts = <0>;
		}
	}
}

[    1.420534] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
[    1.433224] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
[    1.445338] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
[    1.457472] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
[    1.469587] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)

Arınç

