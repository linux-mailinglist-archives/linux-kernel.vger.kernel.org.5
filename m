Return-Path: <linux-kernel+bounces-45458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694A8430FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47C71F23F78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75A83CA4;
	Tue, 30 Jan 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtjDk2IZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624382894;
	Tue, 30 Jan 2024 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656474; cv=none; b=hnv0owVbxcrw0XvYe+XVKCNB7vWE3iBdgSlWdkHOirBH17HYSJVhrqCHXo6tCn4D5ufTodSTe/eBxhmHtZG4PH+w85JZFioJ8/w2plqlJmj6z5YhNbQhLO4J4hewz0QL+3L3y4VvigArv5kTpzB5h+GOFl1PoIDOZc90KaNYAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656474; c=relaxed/simple;
	bh=4IV+dPdI08zimBNVCA9zvFgCo39imZ7Pxgsk7JpWdaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/e2IuNPdHJSIWkksWT9Mli8mAMZ/0h4OHBgkPI4HQ28FbPYjgsheB0S82gPPWbHOTLOwd1bW6t5dzUF439yJMo6jz8Jnpj7UnmSJSrOP2cP+dr38LFW5Hzn2Ofr3S6OttqOmqNPTUTjWkc/hcUFv0euau6f+PEVa+aNT25C1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtjDk2IZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7232dcb3eso23771775ad.2;
        Tue, 30 Jan 2024 15:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656472; x=1707261272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzlkUZ88PnE68OAhgmXxQkn/nQs2BjH2k5xb3I1hQhI=;
        b=FtjDk2IZZjZN4bwzBNx+DWF8eu5VxfkHW1E1ntsjcznbwhcp6TtKAzGXQxSldTMENy
         h9i0HMYKMnk/EV2xnT0lKPlY40JE22ozfiRNcikr8A5NAyMUe02tf896971K7UicM2WU
         qccbVNJTrmWSn7IzMWlQYneKhWD7+qhjyzdPuztuvZ4vVD8vz0JNObVRxxorOzb9M2Ea
         ST/MwhHvrx+M6hbg095EJnv2HudTr4CgarPjgBx0M5OBCh7/P9ZcEIHK0p9iceNHxV75
         0LRK9kQMptReZewROX96fNqIehejNGDhVJi+vncAbJ71c7DKyNP79caGDQxAdew+kCxR
         uqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656472; x=1707261272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzlkUZ88PnE68OAhgmXxQkn/nQs2BjH2k5xb3I1hQhI=;
        b=jg0iZGgIHEF2Qwz9cpD2vfdWxMUiVgVJqGPoVFEmLfXZQS3lufX8OexLebLI0PBdrd
         JPX+LnuV8NUjkaJuyys26kAjs3RqCbo3vHIVhdzirZucoKPWEIlA3mako92RcTFRY4UJ
         ye32OBElKB22ejsA06SKgSepm6x+x42CKfQ8vgA9mUMZe2GIbkIcWFlwKM10FITI/Yop
         55+kZd1v9saWW7R5DKmDgoYXkBrngguXvn1acFS3W6LzrNoG+Yvd3BiAQSVk8kHCcvY8
         olbwUXb5iofh8FB6Hw8lbd99HAZDN+T1PA5bLqY61xGnZr0V3twtWpDavDXtQrN1Brd5
         mIEQ==
X-Gm-Message-State: AOJu0YwLIGI+3i8q35sehq0rmcAvmPiEnJouaWDNayXF7+gFHJca5MOt
	Av2m/I1LDQL4XuI7DGBqOSw/+FpCVBiC8uWfOSvXotyGuFuARJ3f
X-Google-Smtp-Source: AGHT+IHwke5/slfTVBoO8650FSGkXRYSWkhvOrcp35baPXhjlrXRNagNwOXTIs1vYb6mmUcBPvVdSA==
X-Received: by 2002:a17:902:6507:b0:1d8:a75c:2dd6 with SMTP id b7-20020a170902650700b001d8a75c2dd6mr63483plk.15.1706656472615;
        Tue, 30 Jan 2024 15:14:32 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:31 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:27 -0300
Subject: [PATCH net-next v5 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-realtek_reverse-v5-8-ecafd9283a07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=4IV+dPdI08zimBNVCA9zvFgCo39imZ7Pxgsk7JpWdaY=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKxsocLt6Ost9igjJjs9XSOU6LhVTUi1iHyj
 5sR8nP2n5eJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsQAKCRC7Edu60Qc7
 Vj9nB/9USXIGEXOjj0uJiEgniJ5zjV7cxQBufC7TqiqSvCUfivQgxLJZJCzn/emzAbwCCQ6ndg2
 +Nbj0JkR3T1HV+wFPc5J8gMU6PngbSUbWPQXF2F3DH7Sjg9MuUnvKqShI4sFSLbr6qvNjLRTlLU
 V9KnuHEFjUc0odKkXFCiIVesgyVNrGLGUedKS+drLMUZNFk9B0duU8Bnz6jo7FD/eu5n52z9S7i
 o1G/kQTNfzaWuG6b/iyyod3pZJTBhKwUrvE6l2BSInd9x/qyKNNDW+SNxi2b/CqyI7uU2J5Jl+O
 vUFPFo3xsipO0555+Vv2XFtH0NzftvAN3XCxfZ1JqHvP6Vrj
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Remove the line assigning dev.of_node in mdio_bus as subsequent
of_mdiobus_register will always overwrite it.

As discussed in [1], allow the DSA core to be simplified, by not
assigning ds->user_mii_bus when the MDIO bus is described in OF, as it
is unnecessary.

Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
to mdiobus"), we can put the "mdio" node just after the MDIO bus
registration.

[1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index ad47dcbbd2b2..b84df4564c15 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -331,7 +331,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv =  ds->priv;
 	struct device_node *mdio_np;
-	int ret;
+	int ret = 0;
 
 	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (!mdio_np) {
@@ -344,15 +344,14 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 		ret = -ENOMEM;
 		goto err_put_node;
 	}
+
 	priv->user_mii_bus->priv = priv;
 	priv->user_mii_bus->name = "SMI user MII";
 	priv->user_mii_bus->read = realtek_smi_mdio_read;
 	priv->user_mii_bus->write = realtek_smi_mdio_write;
 	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
 		 ds->index);
-	priv->user_mii_bus->dev.of_node = mdio_np;
 	priv->user_mii_bus->parent = priv->dev;
-	ds->user_mii_bus = priv->user_mii_bus;
 
 	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
 	if (ret) {
@@ -361,8 +360,6 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 		goto err_put_node;
 	}
 
-	return 0;
-
 err_put_node:
 	of_node_put(mdio_np);
 
@@ -422,8 +419,7 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
  * @pdev: platform_device to be removed.
  *
  * This function should be used as the .remove_new in a platform_driver. First
- * it unregisters the DSA switch and cleans internal data. Finally, it calls
- * the common remove function.
+ * it unregisters the DSA switch and then it calls the common remove function.
  *
  * Context: Can sleep.
  * Return: Nothing.
@@ -437,9 +433,6 @@ void realtek_smi_remove(struct platform_device *pdev)
 
 	rtl83xx_unregister_switch(priv);
 
-	if (priv->user_mii_bus)
-		of_node_put(priv->user_mii_bus->dev.of_node);
-
 	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);

-- 
2.43.0


