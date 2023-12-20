Return-Path: <linux-kernel+bounces-7355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA581A674
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3987F1C257DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83847A7B;
	Wed, 20 Dec 2023 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ps1VYKic"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDAC482C2;
	Wed, 20 Dec 2023 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40F9AC0007;
	Wed, 20 Dec 2023 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703093760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fV1sJxMriyTh60SAIXi7liP9zt+2ygBCARx0JGK9+4U=;
	b=ps1VYKiciDXKUfDbjiWkSBN34+Qb+mbhQCYjPSZwOO0HdhCHI0u82ZTsWuNqBZctmkSGA7
	70DC5cbNk4MxJq9m7kjenJaSCEAZvr3xt55QZMiROIc2q0RRi9mZTjZXIsXsUOrRkUU9Lx
	3sAbnZqT78jUdW0ocXKc9zhczeGneQGerojtBts+AyOuR0xwEy370/nNwcGFltGXlf7Eql
	dfntEUE1DzM6lizsRGe0Jkg+9oQEs4q7TCWA35k8Qk2pD3ph0WiJVFwfMoqPDkgNVPLbKx
	g4so2m+oUR9EwiipDsthT3jSnQ3DAPrjE4BbFBgLAsn8oX+yGtb9SlGQbDRY8Q==
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: dsa: mt7530: register OF node for internal MDIO bus
Date: Wed, 20 Dec 2023 19:35:39 +0200
Message-Id: <20231220173539.59071-1-arinc.unal@arinc9.com>
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

From: David Bauer <mail@david-bauer.net>

The MT753x switches provide a switch-internal MDIO bus for the embedded
PHYs.

Register a OF sub-node on the switch OF-node for this internal MDIO bus.
This allows to configure the embedded PHYs using device-tree.

Signed-off-by: David Bauer <mail@david-bauer.net>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..f8ecc354630b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2155,10 +2155,13 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 {
 	struct dsa_switch *ds = priv->ds;
 	struct device *dev = priv->dev;
+	struct device_node *np, *mnp;
 	struct mii_bus *bus;
 	static int idx;
 	int ret;
 
+	np = priv->dev->of_node;
+
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus)
 		return -ENOMEM;
@@ -2177,7 +2180,9 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	if (priv->irq)
 		mt7530_setup_mdio_irq(priv);
 
-	ret = devm_mdiobus_register(dev, bus);
+	mnp = of_get_child_by_name(np, "mdio");
+	ret = devm_of_mdiobus_register(dev, bus, mnp);
+	of_node_put(mnp);
 	if (ret) {
 		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
 		if (priv->irq)
-- 
2.40.1


