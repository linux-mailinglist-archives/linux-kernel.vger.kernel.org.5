Return-Path: <linux-kernel+bounces-45459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A378C8430FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87DE1C213C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2483CC1;
	Tue, 30 Jan 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkxel4D9"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1583CA0;
	Tue, 30 Jan 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656478; cv=none; b=rolcQKM8ZYjtXBGThVibFhiavji0/ui4QOjLKt/RSzkMa36xM/3vJTtrJT3iiYmydvuR+OWok26RvaB6MO0OX95uooO1CSND7AwqXOiTJicSHPGBpgmsmyTZWH0L4gFEOT0zWe4AwjMbPIARDjv6GQN01rFeHJTzruhrX9zAGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656478; c=relaxed/simple;
	bh=Z+KSWzoyD03FxX1yk8zLCaZt3EiLsZ0lz5o1EfgHvEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KmnaWHwWVTGpljiUXpMViD37AQrYScmzqQgTKFqSAImR1hP6TXzpxnEbZw88n/rzLqzbfSQgtIyMXVuY7Q5CmzXRsN/Y2VK8eYKxWnnQrZEcDL345FTf83cYjFcWCTiCwddB+BD2Tn6QEZuCSTiuFNNXXrnV7w4VNg71Y9JGKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkxel4D9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d8e7df6abcso17074785ad.1;
        Tue, 30 Jan 2024 15:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656477; x=1707261277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dH08kQGG8/TB47QvoaZ0YHpG8Sx3RZOkHm5Pla/90B8=;
        b=gkxel4D9EofINjAH9M9rgxwhg0UYYW+BCx8Qhi+MlK0ghwpLCxM9LCgOwGImjHHy5V
         qbQaXSehudZ7VPWG2SlNGLYRfYNVFihhaV4Rj/4ne8YEc/wlMRAjRppfipaC+7/h9jau
         z6zMK4c6q30LN1Ie6ZKlAWb4KQvAetm4gdhInSRxoMPFsdJjkwdKKFDB8DCvm+qwZvD6
         G5ZhzoVhJlD3dzRiqvxvuP3gm+N/Yh4Gr909mZVZiaGptBYcT2JK/qsSyZYT6BzJlnUN
         ASq7ywv1lPuvUcns0b4F/9dhcabITkotPYzbDjsfmqTrMrnaoRiNEdlFR7QyPzvJq2t1
         zkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656477; x=1707261277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH08kQGG8/TB47QvoaZ0YHpG8Sx3RZOkHm5Pla/90B8=;
        b=euNCNB0Wfkl6ldDLfuQYYfUi5q/ZhYsHRAeXxJCKmGuErHoraRXgZc0BUHy92hN01O
         JV0Wryhnd0NJZH7gJ1wxPXME5nsbzlFVLf87ZLAzZgDognqf8kz4xwekjA8X3jRFLBpJ
         gYgIRccP6Bc+ok/pCpy+gRwjkBa0u+GqsV9wgOz8JZFZkRLkJM/11C47RnG2DhVLdIlS
         +oV5zNy0MQ9sPbnYTf5cysiUKZRb/+7qQg16fz2/3QiiRHD1e3OroXk6NDc3uRD8CXs+
         FHdM+5iF9yqu3Ov93PC4pZSY7wGEEsh495yF/Al9ASFi8POxnrLAGwP3DOl4LCxK9H8V
         wggQ==
X-Gm-Message-State: AOJu0Yw6DNc3i6c8f6MwYjCLuBz/2N5zHR4cuV4BoW18O7Etf1O4vU36
	BYzW5Cecwlq+J/G3TkvypyXWROP7U3aFLDB5UnVt5XyjF3TNbd4r
X-Google-Smtp-Source: AGHT+IGbmgtdQdIajMHcbOmMdz0lXX4yk3C7AAufykp6ylRtkWE1PF7IDGH9LOZzJXuPexGYn8V5RQ==
X-Received: by 2002:a17:902:f551:b0:1d8:f21b:809c with SMTP id h17-20020a170902f55100b001d8f21b809cmr45494plf.60.1706656476680;
        Tue, 30 Jan 2024 15:14:36 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:36 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:28 -0300
Subject: [PATCH net-next v5 09/11] net: dsa: realtek: migrate user_mii_bus
 setup to realtek-dsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-realtek_reverse-v5-9-ecafd9283a07@gmail.com>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
In-Reply-To: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6171; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=Z+KSWzoyD03FxX1yk8zLCaZt3EiLsZ0lz5o1EfgHvEY=;
 b=owGbwMvMwMG4W/D2rovs1mGMp9WSGFJ3Nm3kyJ0Y2pn7VZBXmu+K9BkL/XczDwQxFfsIbjj0/
 +/fiZKXOhmNWRgYORhkxRRZBNk13FvPRlsJ/dL/ATOIlQlkCgMXpwBMpKSG/X9KpXb9t+OyOedK
 0nkN/57ZyLNnKs+S7ZxdIqrqHg2L7e5+Vgw/Nf979YlFfsujy9WP+PJGsxi0zA4607XZIsxDpbx
 veveOr03P2J/Mzpi8wvLZRQ029f2xEWfmSXgcv3Ey97dboefKitWB7/7ueREi+ZPFae8q9ld1Jc
 ady0Wtje/qZAX9TV/3aeH2UJ4CPdcHidwH93BmCvXmxy3ZE9ZnEfIsfPO97tMP/CwZp79TLLARr
 3CeyfQtT9GN70aI4eKl05cUMzyrC/40Y87iJM+DLxm0GySFXSz3tyT0TN/Pn2j5V4rjh4R4HFvb
 Kr111RElsjMrxbK13/Ye2pPAqp1uwCfpYH79b6N5/48uAA==
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

In the user MDIO driver, despite numerous references to SMI, including
its compatible string, there's nothing inherently specific about the SMI
interface in the user MDIO bus. Consequently, the code has been migrated
to the rtl83xx module. All references to SMI have been eliminated.

The MDIO bus id was changed from Realtek-<switch id> to the switch
devname suffixed with :user_mii, giving more information about the bus
it is referencing.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 57 +----------------------------
 drivers/net/dsa/realtek/rtl83xx.c     | 69 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h     |  1 +
 3 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index b84df4564c15..4d35621b5583 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -31,7 +31,6 @@
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
@@ -312,60 +311,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
 	return realtek_smi_read_reg(priv, reg, val);
 }
 
-static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
-{
-	struct realtek_priv *priv = bus->priv;
-
-	return priv->ops->phy_read(priv, addr, regnum);
-}
-
-static int realtek_smi_mdio_write(struct mii_bus *bus, int addr, int regnum,
-				  u16 val)
-{
-	struct realtek_priv *priv = bus->priv;
-
-	return priv->ops->phy_write(priv, addr, regnum, val);
-}
-
-static int realtek_smi_setup_mdio(struct dsa_switch *ds)
-{
-	struct realtek_priv *priv =  ds->priv;
-	struct device_node *mdio_np;
-	int ret = 0;
-
-	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
-	if (!mdio_np) {
-		dev_err(priv->dev, "no MDIO bus node\n");
-		return -ENODEV;
-	}
-
-	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
-	if (!priv->user_mii_bus) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
-
-	priv->user_mii_bus->priv = priv;
-	priv->user_mii_bus->name = "SMI user MII";
-	priv->user_mii_bus->read = realtek_smi_mdio_read;
-	priv->user_mii_bus->write = realtek_smi_mdio_write;
-	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
-		 ds->index);
-	priv->user_mii_bus->parent = priv->dev;
-
-	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
-	if (ret) {
-		dev_err(priv->dev, "unable to register MDIO bus %s\n",
-			priv->user_mii_bus->id);
-		goto err_put_node;
-	}
-
-err_put_node:
-	of_node_put(mdio_np);
-
-	return ret;
-}
-
 static const struct realtek_interface_info realtek_smi_info = {
 	.reg_read = realtek_smi_read,
 	.reg_write = realtek_smi_write,
@@ -403,7 +348,7 @@ int realtek_smi_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mdio);
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = realtek_smi_setup_mdio;
+	priv->setup_interface = rtl83xx_setup_user_mdio;
 	priv->ds_ops = priv->variant->ds_ops_smi;
 
 	ret = rtl83xx_register_switch(priv);
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index fb3b3b2305d1..f05fe6efe5a4 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/of_mdio.h>
 
 #include "realtek.h"
 #include "rtl83xx.h"
@@ -43,6 +44,74 @@ void rtl83xx_unlock(void *ctx)
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
 
+static int rtl83xx_user_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_read(priv, addr, regnum);
+}
+
+static int rtl83xx_user_mdio_write(struct mii_bus *bus, int addr, int regnum,
+				   u16 val)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_write(priv, addr, regnum, val);
+}
+
+/**
+ * rtl83xx_setup_user_mdio() - register the user mii bus driver
+ * @ds: DSA switch associated with this user_mii_bus
+ *
+ * This function first gets and mdio node under the dev OF node, aborting
+ * if missing. That mdio node describing an mdio bus is used to register a
+ * new mdio bus.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct device_node *mdio_np;
+	struct mii_bus *bus;
+	int ret = 0;
+
+	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
+	if (!mdio_np) {
+		dev_err(priv->dev, "no MDIO bus node\n");
+		return -ENODEV;
+	}
+
+	bus = devm_mdiobus_alloc(priv->dev);
+	if (!bus) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+
+	bus->priv = priv;
+	bus->name = "Realtek user MII";
+	bus->read = rtl83xx_user_mdio_read;
+	bus->write = rtl83xx_user_mdio_write;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s:user_mii", dev_name(priv->dev));
+	bus->parent = priv->dev;
+
+	ret = devm_of_mdiobus_register(priv->dev, bus, mdio_np);
+	if (ret) {
+		dev_err(priv->dev, "unable to register MDIO bus %s\n",
+			bus->id);
+		goto err_put_node;
+	}
+
+	priv->user_mii_bus = bus;
+
+err_put_node:
+	of_node_put(mdio_np);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_setup_user_mdio, REALTEK_DSA);
+
 /**
  * rtl83xx_probe() - probe a Realtek switch
  * @dev: the device being probed
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index a8eed92bce1a..0ddff33df6b0 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -10,6 +10,7 @@ struct realtek_interface_info {
 
 void rtl83xx_lock(void *ctx);
 void rtl83xx_unlock(void *ctx);
+int rtl83xx_setup_user_mdio(struct dsa_switch *ds);
 struct realtek_priv *
 rtl83xx_probe(struct device *dev,
 	      const struct realtek_interface_info *interface_info);

-- 
2.43.0


