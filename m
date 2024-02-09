Return-Path: <linux-kernel+bounces-59012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38C84EFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1301F235CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A5959B46;
	Fri,  9 Feb 2024 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqe8pDub"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBC5916C;
	Fri,  9 Feb 2024 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455098; cv=none; b=br2E92lWN6MXJU9nnS3PcjznB2ZJzCsxvVoI1AvfYWHZnol+5GjdelPJ7T1cqftKPF6/KSGAZHkhX4w2wVL6dW2pVEQaZ5rFogRtiD9PHAK7FyXlEaQLXHPwueZn4FvrvRfTgLWtDaHT/kI5J43Myc4ajUWJZ77igoThMdVLHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455098; c=relaxed/simple;
	bh=otUiPYAp9YLv0L+vaSKcddoDDsCwNIuKy7Ob16ptNf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAxkBUOIs2uCIKVBwyvx2Nc9c9JgqvJeZs8QFS5WdIfYY5v3UpFWz5OixHH8bZ7LR9DWrJBbvPuwaESKu/0xTc966+KF0QXqphx8ixU4Iv8Q+Rir3KLY6l+5ardAQ3frBvEhSm4PTZlhyGeOs1QuX3qGdCkRm43lL1/hlWHw1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqe8pDub; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e12b58a3beso198061a34.1;
        Thu, 08 Feb 2024 21:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455096; x=1708059896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCL6ldcw1wx2vxFXIvZl2VTSDofc/dNo4LHc4NCeTgY=;
        b=fqe8pDubDtPu8I4BJMyZLc61idTbUj5vXJyL3COPEWSN/IaVCAjz57PelLt4c/kOJN
         +wFgLj0/V64XDD8ngWwjra4VFEegfVyVhLWbkc3NX6WQ1fbRes5qc80IRhR1T4Ymtj8m
         W1bTLpGaSd0mBHz7RdaYWspdFcLoPhPo0vt/Mu7ZZ6RFvExfg0MchVV5m5sn5U/btNQa
         87rBIZrycg5SYqVat4twC380VLi6PlLEIMCFGWD0uaZoJaq4t8/trLiW4s7zeFbusZ+X
         rclP7yXSghr010aCo4iUz8q9g+/PShdZVYL5bHWtQNrzlNGHqVamRqLYqkpUrHtYbNxR
         +26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455096; x=1708059896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCL6ldcw1wx2vxFXIvZl2VTSDofc/dNo4LHc4NCeTgY=;
        b=SWeWL14N1JeTPHxywRC9s+OA0m6S/rdkXVZ2b4FPsAIsb/fJ7nRL9GIYDwdA4TVgTK
         iKdmGv5+4e823B4YdDRrgnI8oxzMbmGDDadbw9otVeSSSGDP7fbccjzq9k/YuKtiOVuO
         6TJKlfvlxnBZZsNpIlB0HDyut9DE2/12rNJJWR4yD0UtluJbQmND8JLjY+XeI5lr8Uf9
         3wKmCpNwrPZ5BcTfU+Ci3bBw3OgUzWv6Pc962JvHs5Osf1MASGM+9AU6WC+M8rp9dxER
         X4EtgTXLyPJHgMwh4D7QrJByi9RGQUPiFLPKRTYTV0QVCFSv3CXnGGZvjqbBFiB1nDAT
         pgbg==
X-Gm-Message-State: AOJu0YzASzpd7nUxs+0/vGrnAwREpjLjSBkhpcBzMAxQX9KvvZjj56Yv
	tv3XQ7K87J7CgJMGHcx2F7TKRkzmC32yarL8+6E7/xrALjX3LnKQ
X-Google-Smtp-Source: AGHT+IGQ9Xh0sZx1aAkyQNno9sp8dDn1dzx0Gv845jP5n4blbUKwPWgYT9NrSBXIsqOs62dcmFwwQw==
X-Received: by 2002:a05:6830:1453:b0:6e2:b5e4:30d4 with SMTP id w19-20020a056830145300b006e2b5e430d4mr494018otp.26.1707455096300;
        Thu, 08 Feb 2024 21:04:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBgKBiProL8k1jNk6iGPrf26kZKrMsyYP0uM2GPNal0F7JyiuSFqDu+q3a7NO2IuiWKmRds7TaIvMsyezuzlr/DYwgRY4pCrb/r9BM48hvpm2ZK4003GBLfgtcnezw59GRpt0X/wQAITJGZ/E4qexF8xqbuQCC1m05ovI4kvOvouAvCXQCKy1wmAfhlT1S4rtl1TcqrfwkAgVs6xmlBjYkRqUyDrso2x09vkBnF9rxlh64J26Bg8Ue93yLdnaAssuT9EF+NpcO2TAzBomholXcnPFlx5GThBTdGeRM7v1WJYTCXVY7omoWI6A1KtpJcCYkqacXPFZREQ5zla56rusnZF7DTYGoJInKYkjZ6Rdv7CHCuqM=
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:55 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:45 -0300
Subject: [PATCH net-next v6 09/11] net: dsa: realtek: migrate user_mii_bus
 setup to realtek_dsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-realtek_reverse-v6-9-0662f8cbc7b5@gmail.com>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6106; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=otUiPYAp9YLv0L+vaSKcddoDDsCwNIuKy7Ob16ptNf0=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJMiFE+YmY+O46imTLJr0l/9qjoX1kQmVk0B
 M2/jfbMcDiJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWyTAAKCRC7Edu60Qc7
 Vn1jB/9AEpINM/iamSz7FYJ97GVoTRUPlO8s9nWcFl2c/p6eyX7+l7k8W3T8YFgrVFoWSVHcxBK
 EBzc2N8li5/aBO1JYQT0J4U3MFsGN99gHauy+lBmw5QMIxNRNE+U8vV3L6KgE/mzf4v0DcK91U6
 IC2dBSl/yAlIuMme3DmFfn4YABTlxUzy5ouDVTMKXKKWfZ/uTTN4KOISc5/Jtu290xFYav2h5gA
 VdqPo4w/ZZUk+ZoDKMfYBC3nF83syMP/1CnN/Y5b++2yYOQNDDYoMRXtTYfmYWwKhNB1jEg0187
 sNcNyFALSD1niEijVN8adK39LJM6sMRPUrDaLhPtKcpQgZhF
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
 drivers/net/dsa/realtek/rtl83xx.c     | 68 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h     |  1 +
 3 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 0c36b43cd7b3..bf02276b74d0 100644
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
@@ -407,7 +352,7 @@ int realtek_smi_probe(struct platform_device *pdev)
 	}
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = realtek_smi_setup_mdio;
+	priv->setup_interface = rtl83xx_setup_user_mdio;
 	priv->ds_ops = priv->variant->ds_ops_smi;
 
 	ret = rtl83xx_register_switch(priv);
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index e42139f6e685..ceb8418dfab7 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/of_mdio.h>
 
 #include "realtek.h"
 #include "rtl83xx.h"
@@ -43,6 +44,73 @@ void rtl83xx_unlock(void *ctx)
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
+ * Registers the MDIO bus for built-in Ethernet PHYs, and associates it with
+ * the mandatory 'mdio' child OF node of the switch.
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


