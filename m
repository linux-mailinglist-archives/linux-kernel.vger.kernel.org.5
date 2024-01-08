Return-Path: <linux-kernel+bounces-19483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE81A826D96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F46B21B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563993FE57;
	Mon,  8 Jan 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="CnWKE+c2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53963FE43;
	Mon,  8 Jan 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0C6C1C0006;
	Mon,  8 Jan 2024 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704716095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm5EAPPVxetSThQhTA1Yp9hIcUX30yOFV9rrGkdITCw=;
	b=CnWKE+c2iTvEZ+tt6oyNhwN+KXV0tsgvbYNlDK66quL+Ws/yc8i9Xbp9OJi18PakSyBmZt
	RSdA+1OYQcgDhcKDN6eJrCQ2SnafZhAsjzXMAgtnutbQluDH0cvFWGzk33J5WFK08xvmZt
	ASu9x8zdLivdIj+s+WnZo4buiGf47DZx6ybS0Uj3zNbtvjeEH/eUSHlHIqTvQ2e13PXrZf
	4OdOxugnhJ6uFh36iCVzb9I6ptuujnqht1ZFJARncCdUMrUZH1xWFj838ubKbVASZmhZr3
	A8ULRC2nEArCBqUrEzYj+wkKA0vcXdj/K+8kszZ/D/C9a60nCVIxyYaUrn+BCA==
Message-ID: <7e89034c-afbd-4180-98e5-50d8cd07f924@arinc9.com>
Date: Mon, 8 Jan 2024 15:14:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: support OF-based registration
 of switch MDIO bus
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240106122142.235389-1-arinc.unal@arinc9.com>
 <20240107195241.GB132648@kernel.org>
 <65274929-fa59-482c-a744-6b9ce162ab46@arinc9.com>
 <20240108110000.aujqhlufehngtkjj@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240108110000.aujqhlufehngtkjj@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 8.01.2024 14:00, Vladimir Oltean wrote:
> On Mon, Jan 08, 2024 at 01:22:18PM +0300, Arınç ÜNAL wrote:
>>>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>>>> index 391c4dbdff42..39d7e7ad7154 100644
>>>> --- a/drivers/net/dsa/mt7530.c
>>>> +++ b/drivers/net/dsa/mt7530.c
>>>> @@ -2153,17 +2153,25 @@ mt7530_free_irq(struct mt7530_priv *priv)
>>>>    static int
>>>>    mt7530_setup_mdio(struct mt7530_priv *priv)
>>>>    {
>>>> +	struct device_node *mnp, *np = priv->dev->of_node;
>>>>    	struct dsa_switch *ds = priv->ds;
>>>>    	struct device *dev = priv->dev;
>>>>    	struct mii_bus *bus;
>>>>    	static int idx;
>>>> -	int ret;
>>>> +	int ret = 0;
>>>> +
>>>> +	mnp = of_get_child_by_name(np, "mdio");
>>>> +
>>>> +	if (mnp && !of_device_is_available(mnp))
>>>> +		goto out;
>>>
>>> nit: I think it would easier on the eyes to simply
>>>
>>> 		return 0;
> 
> Actually "return 0" leaks "mnp". An of_node_put() is needed.

I realised that I also miss these:

- run of_node_put(mnp) if bus = devm_mdiobus_alloc(dev) fails
- don't run mt7530_free_mdio_irq if MDIO bus is described on OF

Please let me know if this addresses everything:

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..cf2ff7680c15 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2146,24 +2146,40 @@ mt7530_free_irq_common(struct mt7530_priv *priv)
  static void
  mt7530_free_irq(struct mt7530_priv *priv)
  {
-	mt7530_free_mdio_irq(priv);
+	struct device_node *mnp, *np = priv->dev->of_node;
+
+	mnp = of_get_child_by_name(np, "mdio");
+	if (!mnp)
+		mt7530_free_mdio_irq(priv);
+	of_node_put(mnp);
+
  	mt7530_free_irq_common(priv);
  }
  
  static int
  mt7530_setup_mdio(struct mt7530_priv *priv)
  {
+	struct device_node *mnp, *np = priv->dev->of_node;
  	struct dsa_switch *ds = priv->ds;
  	struct device *dev = priv->dev;
  	struct mii_bus *bus;
  	static int idx;
-	int ret;
+	int ret = 0;
+
+	mnp = of_get_child_by_name(np, "mdio");
+
+	if (mnp && !of_device_is_available(mnp))
+		goto out;
  
  	bus = devm_mdiobus_alloc(dev);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (!mnp)
+		ds->user_mii_bus = bus;
  
-	ds->user_mii_bus = bus;
  	bus->priv = priv;
  	bus->name = KBUILD_MODNAME "-mii";
  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
@@ -2174,16 +2190,18 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
  	bus->parent = dev;
  	bus->phy_mask = ~ds->phys_mii_mask;
  
-	if (priv->irq)
+	if (priv->irq && !mnp)
  		mt7530_setup_mdio_irq(priv);
  
-	ret = devm_mdiobus_register(dev, bus);
+	ret = devm_of_mdiobus_register(dev, bus, mnp);
  	if (ret) {
  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
-		if (priv->irq)
+		if (priv->irq && !mnp)
  			mt7530_free_mdio_irq(priv);
  	}
  
+out:
+	of_node_put(mnp);
  	return ret;
  }
  

Arınç

