Return-Path: <linux-kernel+bounces-32328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E7835A47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD1B22636
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED675224;
	Mon, 22 Jan 2024 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="n/cLpFXA"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E426112;
	Mon, 22 Jan 2024 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901693; cv=none; b=anKJww6qj346c9jT5UA2X5la+R1cAi3fzvfQjSVeoxKtXh/MGn6cFx88+vAOitgrp4dXA0W+wuURj+PxkqSqm+EyaHeiuCqtacJYoXsWIQDD0xaEfnywuAU+mONm50bAIOYO778doiRdqEK+9uzZlCIYi2EIJVLHvXk1dl1xf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901693; c=relaxed/simple;
	bh=GmYuZctNufNpnOl4/pnFA9sbQd4paA+kmX5NFn121W0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aXTG0SvMin6rH29zALTy6cYd8HI6OEA981nCOa659V+PKih5bXgq2WIK/cLGqY46FrAcQdfJeuaUhYFJkXvft/NLVQdGm6gLNJY7wLsyzd7xYIEQmOsbhGNIW24zocdnPWve03vKPq08tzpYdF2bUxsvbOgBl6RVTaymtZQ/B+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=n/cLpFXA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E957240004;
	Mon, 22 Jan 2024 05:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705901683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uTfZ42YMdPsc//kAzPHZ2G81y8NgAM6Sfpnm9pJXkZE=;
	b=n/cLpFXAnCndk/5bqPBQr1sNRXHQbO3V/lGqNjaW2xLNfGvv4yW61KmF56OTU9yrw4zM92
	7yEYaETXr6L4LPi5cPhmBhPFQWKfaNaqdJ3QXdcoyLs6I1CHdPOaR13ihNO43AQ76UlfTh
	VTjzDp1CVW9VNmZEa2dZV/1tQTK1lbycsfvLYy4V7IS4hIGirRtUQqC5bmsymCjE8E49EX
	NoW88/KHNkRAz2CFkut/qcUnRxkfdY54Oc4+0WCUx7waZ+tUOT3MjOn3OKtlZFXCFWHbsf
	BaMb3OE15U3oENyr8kLkwAkez3dMEqVlL6rDyOp31VTUk8l+3UaR2eGGCsk5sg==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: David Bauer <mail@david-bauer.net>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: dsa: mt7530: support OF-based registration of switch MDIO bus
Date: Mon, 22 Jan 2024 08:34:31 +0300
Message-Id: <20240122053431.7751-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Currently the MDIO bus of the switches the MT7530 DSA subdriver controls
can only be registered as non-OF-based. Bring support for registering the
bus OF-based.

The subdrivers that control switches [with MDIO bus] probed on OF must
follow this logic to support all cases properly:

No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if "interrupt-controller" is defined at
the switch node. This case should only be covered for the switches which
their dt-bindings documentation didn't document the MDIO bus from the
start. This is to keep supporting the device trees that do not describe the
MDIO bus on the device tree but the MDIO bus is being used nonetheless.

Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
the switch node and "interrupts" is defined at the PHY nodes under the
switch MDIO bus node].

Switch MDIO bus defined but explicitly disabled: If the device tree says
status = "disabled" for the MDIO bus, we shouldn't need an MDIO bus at all.
Instead, just exit as early as possible and do not call any MDIO API.

The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
switch is described on the device tree [1], which is why we don't populate
ds->user_mii_bus in that case.

Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
Suggested-by: David Bauer <mail@david-bauer.net>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

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
 
-- 
2.40.1


