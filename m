Return-Path: <linux-kernel+bounces-59008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157084EFC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4FE2892D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772EA58218;
	Fri,  9 Feb 2024 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOyn6gDn"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AC58139;
	Fri,  9 Feb 2024 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455082; cv=none; b=ObsH9pZTMqLTy4a6r57gGw5MvxNSLZ3jpda/B+9MdccxxImQ2ytozRRcTReLBI/vObkw9gftC2FYOdj5uixE45pDmVIHT5hODu7fn1OZUoRCCwcuCrdKHyqXquePg4wCeS1cGsyvNy0ndqniOnb7oJKkUA7weWITUMHU0yGpVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455082; c=relaxed/simple;
	bh=baCHYu3lUoAm9OmUdcjhgQtmp/3g3SLNPUPQxd6A1uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUQq/ytfjcl9buJvy7VLZkQc/1q0PpVCTnzTrWj3ewv4+MYMCB77RXUA7YgY+a+rBtq19WVdmiv5bF43qs1Mb132HH3Ez1pCNWtPPns9RVzIdHmOhjzKwfGIYQ70Ux+D8A5OFVhzX/bHlAgFFkcRf8NNHUy4QaYTR4dOLxYIXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOyn6gDn; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e2c4866b33so256160a34.2;
        Thu, 08 Feb 2024 21:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455079; x=1708059879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO4Ry7kvRIzLLQF7E33i4/x/m3CKHgGMzMktOiu6/Eo=;
        b=GOyn6gDn4tHGeR4X9NXC7YqP5jPPUl1J2cRJxcm8WcxhAjb7XLcrDl1i+mzOWFk3Ls
         SKIo1odTqKcbhhE8GpbX4esjuGowBSHOsygl9iv5KcDJUq1Z+6l8DSXx8ia9PFAoM+bf
         vz1PiZncELETD5ba2kjEt3ve8IRuggnsQ2ijgIQC7s1vtSBvK6ZeJPLUZnGljmsIVMZK
         6lpAgRC1iwW//bjzllBq6Rhz7wuEF65EJH1EdhvEs2O0sO37GeqtuIKZJ+S1ELn3orV8
         NvQJN+y/sn5XV7Nfda2/qTGoPJtxFai0P43YHLduXoLGwmX7D526z/gRCi6BOTwZNV6w
         Pnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455079; x=1708059879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QO4Ry7kvRIzLLQF7E33i4/x/m3CKHgGMzMktOiu6/Eo=;
        b=CjImWCCza7Mn3wpfpm4SgYhHwiQU10rP2q9zRy1v1YaQe4yW+355cZHoaYJABO3Oao
         sleipFB3+TxATKbXB3i9g2QpHk/6WIlcRlRhNMICe1ZTmpWex84A6uknqREgvfE9auuL
         71YkmZRsJDSMG9nuQ9Twy9Ti9VeqQcvm/SiIuSaFdOOe9c7AkPTPautY6Ot2sElVkA/0
         lmLtzGX9QG7yV3NjFbIPAd37gYv/Z6mna95yqLngVVKD4TDyDWtdDYXhVdG25d1DCHzt
         bmL8TD6GzpryQYXKV4dTjTzG+nbWHHFJJ7y9KGbQSesFoYUapPQfRSHe28baO09fCQqg
         K8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWXnDevfd2xwRNA0jb/lVSLt8R8Jfl053vHRS0mnvXyC0KZ3KqBW/qzTrq9IV7N9foLfw7mM0Pxoy6qEo2hZ2v0RE6RMC3NQPCXFaPW
X-Gm-Message-State: AOJu0YyeCLwUw9GDOZZEy1FyWCqIP8aCTwKp4H9NPy5yETsiUCi1Ge+r
	l6wLKQq9Byv4ogl57hd/z8GjgjaMsXprmGf8zmCNtE7uS+HNABEyDj1/yeSdiWw=
X-Google-Smtp-Source: AGHT+IFoTNaaqdyOrn2aJ+5Kwq9oHhSR2fm7OCOD+nms8wTH/O6oG07596zUq/lS1Kf25aL+7jAoDg==
X-Received: by 2002:a9d:6c59:0:b0:6dd:ed61:546a with SMTP id g25-20020a9d6c59000000b006dded61546amr444639otq.31.1707455078958;
        Thu, 08 Feb 2024 21:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBTfuzcEI+w1S/kB/IWCo665I3l4mSPq78EvUmiIpt2uD6lOwi2AE0Q60/ZvXyKmHG+MyOM4pf5qGHo4MyXzFMcpZPEZS0kOenskl6NRnrreXf9+RWMBWG2u4trx407+3BKIzqCZRbULYGS1GtsD82CvhEfGKC58J2ls+5HMnizEx799e9s4FTMA4OdB/Nav1STdGksGhZFpPbJWnRq8jT8yYof7tBpAjW0NFYgYVAX9ZArqe2IFB92tSUo84RfyMCTv9Zh7BXGqKTSup7oshqdQn4iSB+JTevhEkvXTNZrilBt8OCJRVUxxzzHcA9JEU+5jdGavMed1jRTRjrR/8E+Ys/1tQqwTEJrHWDe4XD/SdpN60=
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:38 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:41 -0300
Subject: [PATCH net-next v6 05/11] net: dsa: realtek: common rtl83xx module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-realtek_reverse-v6-5-0662f8cbc7b5@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=27025; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=baCHYu3lUoAm9OmUdcjhgQtmp/3g3SLNPUPQxd6A1uo=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJL5qUSASUO3EixHoM3uIshfVM/rGQLRx4xe
 Y+fgDgA6MOJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 VuopB/0bn0+meCoaQB0UlgWk9Vxn5ZpoPPpg/L+5jOpqyDQRxes/FRKeroAQlurj7hwijkmgqye
 i7LbdysLW369fnA5AFubD8ggAhmA+HFvupEuR/s54GVca97q/UFc2R2a3zYJyEfMF2tlWMIa1BW
 KlsVpz4yeV3X74kTKe/wERdMHXoMtymWQeiy97hzV5DwjHcHlnfQof6kPocbiF/quQztbDrx67j
 hL4rsY2ukoDDJ4FkRzJ3ayCeEMtXpaVpu09J4OmFehY+jokdAre1LHC9er4b6EkTh7J2NkMdros
 MLV8CIXo/rrpdTFanhLvi7WQP9/zCAfWGHVwrXqucy/uaeuS
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Some code can be shared between both interface modules (MDIO and SMI)
and among variants. These interface functions migrated to a common
module:

- rtl83xx_lock
- rtl83xx_unlock
- rtl83xx_probe
- rtl83xx_register_switch
- rtl83xx_unregister_switch
- rtl83xx_shutdown
- rtl83xx_remove

The reset during probe was moved to the end of the common probe. This way,
we avoid a reset if anything else fails.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile       |   2 +
 drivers/net/dsa/realtek/realtek-mdio.c | 152 +++------------------
 drivers/net/dsa/realtek/realtek-smi.c  | 166 +++++------------------
 drivers/net/dsa/realtek/realtek.h      |   1 +
 drivers/net/dsa/realtek/rtl8365mb.c    |   9 +-
 drivers/net/dsa/realtek/rtl8366rb.c    |   9 +-
 drivers/net/dsa/realtek/rtl83xx.c      | 235 +++++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h      |  21 +++
 8 files changed, 322 insertions(+), 273 deletions(-)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 0aab57252a7c..d579127f05f7 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek_dsa.o
+realtek_dsa-objs			:= rtl83xx.o
 obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
 obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 7be00aa2a9e7..90a017cbe168 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -26,6 +26,7 @@
 
 #include "realtek.h"
 #include "realtek-mdio.h"
+#include "rtl83xx.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -100,147 +101,41 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
 	return ret;
 }
 
-static void realtek_mdio_lock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_lock(&priv->map_lock);
-}
-
-static void realtek_mdio_unlock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_unlock(&priv->map_lock);
-}
-
-static const struct regmap_config realtek_mdio_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_mdio_read,
-	.reg_write = realtek_mdio_write,
-	.cache_type = REGCACHE_NONE,
-	.lock = realtek_mdio_lock,
-	.unlock = realtek_mdio_unlock,
-};
-
-static const struct regmap_config realtek_mdio_nolock_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
+static const struct realtek_interface_info realtek_mdio_info = {
 	.reg_read = realtek_mdio_read,
 	.reg_write = realtek_mdio_write,
-	.cache_type = REGCACHE_NONE,
-	.disable_locking = true,
 };
 
 /**
  * realtek_mdio_probe() - Probe a platform device for an MDIO-connected switch
  * @mdiodev: mdio_device to probe on.
  *
- * This function should be used as the .probe in an mdio_driver. It
- * initializes realtek_priv and read data from the device-tree node. The switch
- * is hard reset if a method is provided. It checks the switch chip ID and,
- * finally, a DSA switch is registered.
+ * This function should be used as the .probe in an mdio_driver. After
+ * calling the common probe function for both interfaces, it initializes the
+ * values specific for MDIO-connected devices. Finally, it calls a common
+ * function to register the DSA switch.
  *
  * Context: Can sleep. Takes and releases priv->map_lock.
  * Return: Returns 0 on success, a negative error on failure.
  */
 int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
-	struct realtek_priv *priv;
 	struct device *dev = &mdiodev->dev;
-	const struct realtek_variant *var;
-	struct regmap_config rc;
-	struct device_node *np;
+	struct realtek_priv *priv;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	if (!var)
-		return -EINVAL;
-
-	priv = devm_kzalloc(&mdiodev->dev,
-			    size_add(sizeof(*priv), var->chip_data_sz),
-			    GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	mutex_init(&priv->map_lock);
-
-	rc = realtek_mdio_regmap_config;
-	rc.lock_arg = priv;
-	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map)) {
-		ret = PTR_ERR(priv->map);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
+	priv = rtl83xx_probe(dev, &realtek_mdio_info);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
-	rc = realtek_mdio_nolock_regmap_config;
-	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map_nolock)) {
-		ret = PTR_ERR(priv->map_nolock);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	priv->mdio_addr = mdiodev->addr;
 	priv->bus = mdiodev->bus;
-	priv->dev = &mdiodev->dev;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	priv->variant = var;
-	priv->ops = var->ops;
-
+	priv->mdio_addr = mdiodev->addr;
 	priv->write_reg_noack = realtek_mdio_write;
+	priv->ds_ops = priv->variant->ds_ops_mdio;
 
-	np = dev->of_node;
-
-	dev_set_drvdata(dev, priv);
-
-	/* TODO: if power is software controlled, set up any regulators here */
-	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
-
-	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return PTR_ERR(priv->reset);
-	}
-
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
-		dev_dbg(dev, "asserted RESET\n");
-		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
-		msleep(REALTEK_HW_START_DELAY);
-		dev_dbg(dev, "deasserted RESET\n");
-	}
-
-	ret = priv->ops->detect(priv);
-	if (ret) {
-		dev_err(dev, "unable to detect switch\n");
-		return ret;
-	}
-
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
-
-	priv->ds->dev = dev;
-	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
-	priv->ds->ops = var->ds_ops_mdio;
-
-	ret = dsa_register_switch(priv->ds);
+	ret = rtl83xx_register_switch(priv);
 	if (ret) {
-		dev_err(priv->dev, "unable to register switch ret = %d\n", ret);
+		rtl83xx_remove(priv);
 		return ret;
 	}
 
@@ -253,8 +148,7 @@ EXPORT_SYMBOL_NS_GPL(realtek_mdio_probe, REALTEK_DSA);
  * @mdiodev: mdio_device to be removed.
  *
  * This function should be used as the .remove_new in an mdio_driver. First
- * it unregisters the DSA switch and cleans internal data. If a method is
- * provided, the hard reset is asserted to avoid traffic leakage.
+ * it unregisters the DSA switch and then it calls the common remove function.
  *
  * Context: Can sleep.
  * Return: Nothing.
@@ -266,11 +160,9 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
+	rtl83xx_unregister_switch(priv);
 
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
 
@@ -278,10 +170,8 @@ EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
  * realtek_mdio_shutdown() - Shutdown the driver of a MDIO-connected switch
  * @mdiodev: mdio_device shutting down.
  *
- * This function should be used as the .shutdown in an mdio_driver. It shuts
- * down the DSA switch and cleans the platform driver data, to prevent
- * realtek_mdio_remove() from running afterwards, which is possible if the
- * parent bus implements its own .shutdown() as .remove().
+ * This function should be used as the .shutdown in a platform_driver. It calls
+ * the common shutdown function.
  *
  * Context: Can sleep.
  * Return: Nothing.
@@ -293,9 +183,7 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	dsa_switch_shutdown(priv->ds);
-
-	dev_set_drvdata(&mdiodev->dev, NULL);
+	rtl83xx_shutdown(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
 
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index ad3b57311015..d676cc44d517 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -41,6 +41,7 @@
 
 #include "realtek.h"
 #include "realtek-smi.h"
+#include "rtl83xx.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
@@ -311,47 +312,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
 	return realtek_smi_read_reg(priv, reg, val);
 }
 
-static void realtek_smi_lock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_lock(&priv->map_lock);
-}
-
-static void realtek_smi_unlock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_unlock(&priv->map_lock);
-}
-
-static const struct regmap_config realtek_smi_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_smi_read,
-	.reg_write = realtek_smi_write,
-	.cache_type = REGCACHE_NONE,
-	.lock = realtek_smi_lock,
-	.unlock = realtek_smi_unlock,
-};
-
-static const struct regmap_config realtek_smi_nolock_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_smi_read,
-	.reg_write = realtek_smi_write,
-	.cache_type = REGCACHE_NONE,
-	.disable_locking = true,
-};
-
 static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct realtek_priv *priv = bus->priv;
@@ -409,111 +369,56 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
+static const struct realtek_interface_info realtek_smi_info = {
+	.reg_read = realtek_smi_read,
+	.reg_write = realtek_smi_write,
+};
+
 /**
  * realtek_smi_probe() - Probe a platform device for an SMI-connected switch
  * @pdev: platform_device to probe on.
  *
- * This function should be used as the .probe in a platform_driver. It
- * initializes realtek_priv and read data from the device-tree node. The switch
- * is hard reset if a method is provided. It checks the switch chip ID and,
- * finally, a DSA switch is registered.
+ * This function should be used as the .probe in a platform_driver. After
+ * calling the common probe function for both interfaces, it initializes the
+ * values specific for SMI-connected devices. Finally, it calls a common
+ * function to register the DSA switch.
  *
  * Context: Can sleep. Takes and releases priv->map_lock.
  * Return: Returns 0 on success, a negative error on failure.
  */
 int realtek_smi_probe(struct platform_device *pdev)
 {
-	const struct realtek_variant *var;
 	struct device *dev = &pdev->dev;
 	struct realtek_priv *priv;
-	struct regmap_config rc;
-	struct device_node *np;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	np = dev->of_node;
-
-	priv = devm_kzalloc(dev, sizeof(*priv) + var->chip_data_sz, GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	mutex_init(&priv->map_lock);
-
-	rc = realtek_smi_regmap_config;
-	rc.lock_arg = priv;
-	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map)) {
-		ret = PTR_ERR(priv->map);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	rc = realtek_smi_nolock_regmap_config;
-	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map_nolock)) {
-		ret = PTR_ERR(priv->map_nolock);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	/* Link forward and backward */
-	priv->dev = dev;
-	priv->variant = var;
-	priv->ops = var->ops;
-
-	priv->setup_interface = realtek_smi_setup_mdio;
-	priv->write_reg_noack = realtek_smi_write_reg_noack;
-
-	dev_set_drvdata(dev, priv);
-	spin_lock_init(&priv->lock);
-
-	/* TODO: if power is software controlled, set up any regulators here */
-
-	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return PTR_ERR(priv->reset);
-	}
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
-		dev_dbg(dev, "asserted RESET\n");
-		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
-		msleep(REALTEK_HW_START_DELAY);
-		dev_dbg(dev, "deasserted RESET\n");
-	}
+	priv = rtl83xx_probe(dev, &realtek_smi_info);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	/* Fetch MDIO pins */
 	priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdc))
+	if (IS_ERR(priv->mdc)) {
+		rtl83xx_remove(priv);
 		return PTR_ERR(priv->mdc);
+	}
+
 	priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdio))
+	if (IS_ERR(priv->mdio)) {
+		rtl83xx_remove(priv);
 		return PTR_ERR(priv->mdio);
-
-	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
-
-	ret = priv->ops->detect(priv);
-	if (ret) {
-		dev_err(dev, "unable to detect switch\n");
-		return ret;
 	}
 
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
-
-	priv->ds->dev = dev;
-	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
+	priv->write_reg_noack = realtek_smi_write_reg_noack;
+	priv->setup_interface = realtek_smi_setup_mdio;
+	priv->ds_ops = priv->variant->ds_ops_smi;
 
-	priv->ds->ops = var->ds_ops_smi;
-	ret = dsa_register_switch(priv->ds);
+	ret = rtl83xx_register_switch(priv);
 	if (ret) {
-		dev_err_probe(dev, ret, "unable to register switch\n");
+		rtl83xx_remove(priv);
 		return ret;
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
@@ -523,8 +428,8 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
  * @pdev: platform_device to be removed.
  *
  * This function should be used as the .remove_new in a platform_driver. First
- * it unregisters the DSA switch and cleans internal data. If a method is
- * provided, the hard reset is asserted to avoid traffic leakage.
+ * it unregisters the DSA switch and cleans internal data. Finally, it calls
+ * the common remove function.
  *
  * Context: Can sleep.
  * Return: Nothing.
@@ -536,13 +441,12 @@ void realtek_smi_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
+	rtl83xx_unregister_switch(priv);
+
 	if (priv->user_mii_bus)
 		of_node_put(priv->user_mii_bus->dev.of_node);
 
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
 
@@ -550,10 +454,8 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
  * realtek_smi_shutdown() - Shutdown the driver of a SMI-connected switch
  * @pdev: platform_device shutting down.
  *
- * This function should be used as the .shutdown in a platform_driver. It shuts
- * down the DSA switch and cleans the platform driver data, to prevent
- * realtek_smi_remove() from running afterwards, which is possible if the
- * parent bus implements its own .shutdown() as .remove().
+ * This function should be used as the .shutdown in a platform_driver. It calls
+ * the common shutdown function.
  *
  * Context: Can sleep.
  * Return: Nothing.
@@ -565,9 +467,7 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	dsa_switch_shutdown(priv->ds);
-
-	platform_set_drvdata(pdev, NULL);
+	rtl83xx_shutdown(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
 
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index c7d5ef99e9db..e9e28b189509 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -62,6 +62,7 @@ struct realtek_priv {
 
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
+	const struct dsa_switch_ops *ds_ops;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index e67c4562f5db..60f826a5a00a 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -103,6 +103,7 @@
 #include "realtek.h"
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
+#include "rtl83xx.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -691,7 +692,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -724,7 +725,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	*data = val & 0xFFFF;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return ret;
 }
@@ -735,7 +736,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -766,7 +767,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 747407ae8225..a0c365325b4a 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -25,6 +25,7 @@
 #include "realtek.h"
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
+#include "rtl83xx.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
@@ -1720,7 +1721,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_READ);
@@ -1748,7 +1749,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 		phy, regnum, reg, val);
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return ret;
 }
@@ -1762,7 +1763,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_WRITE);
@@ -1779,7 +1780,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return ret;
 }
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
new file mode 100644
index 000000000000..0f628065f456
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "realtek.h"
+#include "rtl83xx.h"
+
+/**
+ * rtl83xx_lock() - Locks the mutex used by regmaps
+ * @ctx: realtek_priv pointer
+ *
+ * This function is passed to regmap to be used as the lock function.
+ * It is also used externally to block regmap before executing multiple
+ * operations that must happen in sequence (which will use
+ * realtek_priv.map_nolock instead).
+ *
+ * Context: Can sleep. Holds priv->map_lock lock.
+ * Return: nothing
+ */
+void rtl83xx_lock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_lock(&priv->map_lock);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_lock, REALTEK_DSA);
+
+/**
+ * rtl83xx_unlock() - Unlocks the mutex used by regmaps
+ * @ctx: realtek_priv pointer
+ *
+ * This function unlocks the lock acquired by rtl83xx_lock.
+ *
+ * Context: Releases priv->map_lock lock.
+ * Return: nothing
+ */
+void rtl83xx_unlock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_unlock(&priv->map_lock);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
+
+/**
+ * rtl83xx_probe() - probe a Realtek switch
+ * @dev: the device being probed
+ * @interface_info: specific management interface info.
+ *
+ * This function initializes realtek_priv and reads data from the device tree
+ * node. The switch is hard resetted if a method is provided.
+ *
+ * Context: Can sleep.
+ * Return: Pointer to the realtek_priv or ERR_PTR() in case of failure.
+ *
+ * The realtek_priv pointer does not need to be freed as it is controlled by
+ * devres.
+ */
+struct realtek_priv *
+rtl83xx_probe(struct device *dev,
+	      const struct realtek_interface_info *interface_info)
+{
+	const struct realtek_variant *var;
+	struct realtek_priv *priv;
+	struct regmap_config rc = {
+		.reg_bits = 10, /* A4..A0 R4..R0 */
+		.val_bits = 16,
+		.reg_stride = 1,
+		.max_register = 0xffff,
+		.reg_format_endian = REGMAP_ENDIAN_BIG,
+		.reg_read = interface_info->reg_read,
+		.reg_write = interface_info->reg_write,
+		.cache_type = REGCACHE_NONE,
+		.lock = rtl83xx_lock,
+		.unlock = rtl83xx_unlock,
+	};
+	int ret;
+
+	var = of_device_get_match_data(dev);
+	if (!var)
+		return ERR_PTR(-EINVAL);
+
+	priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
+			    GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&priv->map_lock);
+
+	rc.lock_arg = priv;
+	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
+	if (IS_ERR(priv->map)) {
+		ret = PTR_ERR(priv->map);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	rc.disable_locking = true;
+	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
+	if (IS_ERR(priv->map_nolock)) {
+		ret = PTR_ERR(priv->map_nolock);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	/* Link forward and backward */
+	priv->dev = dev;
+	priv->variant = var;
+	priv->ops = var->ops;
+	priv->chip_data = (void *)priv + sizeof(*priv);
+
+	spin_lock_init(&priv->lock);
+
+	priv->leds_disabled = of_property_read_bool(dev->of_node,
+						    "realtek,disable-leds");
+
+	/* TODO: if power is software controlled, set up any regulators here */
+	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset)) {
+		dev_err(dev, "failed to get RESET GPIO\n");
+		return ERR_CAST(priv->reset);
+	}
+
+	dev_set_drvdata(dev, priv);
+
+	if (priv->reset) {
+		gpiod_set_value(priv->reset, 1);
+		dev_dbg(dev, "asserted RESET\n");
+		msleep(REALTEK_HW_STOP_DELAY);
+		gpiod_set_value(priv->reset, 0);
+		msleep(REALTEK_HW_START_DELAY);
+		dev_dbg(dev, "deasserted RESET\n");
+	}
+
+	return priv;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_probe, REALTEK_DSA);
+
+/**
+ * rtl83xx_register_switch() - detects and register a switch
+ * @priv: realtek_priv pointer
+ *
+ * This function first checks the switch chip ID and register a DSA
+ * switch.
+ *
+ * Context: Can sleep. Takes and releases priv->map_lock.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_register_switch(struct realtek_priv *priv)
+{
+	struct dsa_switch *ds;
+	int ret;
+
+	ret = priv->ops->detect(priv);
+	if (ret) {
+		dev_err_probe(priv->dev, ret, "unable to detect switch\n");
+		return ret;
+	}
+
+	ds = devm_kzalloc(priv->dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
+
+	ds->priv = priv;
+	ds->dev = priv->dev;
+	ds->ops = priv->ds_ops;
+	ds->num_ports = priv->num_ports;
+	priv->ds = ds;
+
+	ret = dsa_register_switch(ds);
+	if (ret) {
+		dev_err_probe(priv->dev, ret, "unable to register switch\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_register_switch, REALTEK_DSA);
+
+/**
+ * rtl83xx_unregister_switch() - unregister a switch
+ * @priv: realtek_priv pointer
+ *
+ * This function unregister a DSA switch.
+ *
+ * Context: Can sleep.
+ * Return: Nothing.
+ */
+void rtl83xx_unregister_switch(struct realtek_priv *priv)
+{
+	dsa_unregister_switch(priv->ds);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_unregister_switch, REALTEK_DSA);
+
+/**
+ * rtl83xx_shutdown() - shutdown a switch
+ * @priv: realtek_priv pointer
+ *
+ * This function shuts down the DSA switch and cleans the platform driver data,
+ * to prevent realtek_{smi,mdio}_remove() from running afterwards, which is
+ * possible if the parent bus implements its own .shutdown() as .remove().
+ *
+ * Context: Can sleep.
+ * Return: Nothing.
+ */
+void rtl83xx_shutdown(struct realtek_priv *priv)
+{
+	dsa_switch_shutdown(priv->ds);
+
+	dev_set_drvdata(priv->dev, NULL);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_shutdown, REALTEK_DSA);
+
+/**
+ * rtl83xx_remove() - Cleanup a realtek switch driver
+ * @priv: realtek_priv pointer
+ *
+ * If a method is provided, this function asserts the hard reset of the switch
+ * in order to avoid leaking traffic when the driver is gone.
+ *
+ * Context: Might sleep if priv->gdev->chip->can_sleep.
+ * Return: nothing
+ */
+void rtl83xx_remove(struct realtek_priv *priv)
+{
+	/* leave the device reset asserted */
+	if (priv->reset)
+		gpiod_set_value(priv->reset, 1);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
+
+MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_DESCRIPTION("Realtek DSA switches common module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
new file mode 100644
index 000000000000..a8eed92bce1a
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _RTL83XX_H
+#define _RTL83XX_H
+
+struct realtek_interface_info {
+	int (*reg_read)(void *ctx, u32 reg, u32 *val);
+	int (*reg_write)(void *ctx, u32 reg, u32 val);
+};
+
+void rtl83xx_lock(void *ctx);
+void rtl83xx_unlock(void *ctx);
+struct realtek_priv *
+rtl83xx_probe(struct device *dev,
+	      const struct realtek_interface_info *interface_info);
+int rtl83xx_register_switch(struct realtek_priv *priv);
+void rtl83xx_unregister_switch(struct realtek_priv *priv);
+void rtl83xx_shutdown(struct realtek_priv *priv);
+void rtl83xx_remove(struct realtek_priv *priv);
+
+#endif /* _RTL83XX_H */

-- 
2.43.0


