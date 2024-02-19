Return-Path: <linux-kernel+bounces-72139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EC85AFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E51C22A19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DE859176;
	Mon, 19 Feb 2024 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djz+7muT"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAD56B7F;
	Mon, 19 Feb 2024 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386308; cv=none; b=NZquHmKhIW6MhQBqqMm89JpQou+7fwhdAcEYiSJ+DSh0lhBmuwSGCsDlfRfgzQXkxMEIpKcuMmu611ac5al4EpTYVdkKJ7j1vtmuNgmeFsQJgfFpD/UzEFdeNPFO0KJKP/mn3xVsAcoHYRQmcQ0LR6JbfrX7NU3XVRdXR70VIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386308; c=relaxed/simple;
	bh=lFFtbhACJmztPPpr3pxi0hEjHTFow84caBqcjZJj8og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLvAHebfgHeX/4rhocx7R/BNH6FZ/DN9KFGzYiNni77JMbTSnzmXUOlZpSuYBvlYpdRqSnox/CSezgzTgoc/tkfmfJ2SBu00WuAOigKUCoPk8fAOn88OxBbV86izbVsl293sG377znlGGZhxp4NMKBc0/6UzwUpOxNFcyaFG5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djz+7muT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dba94f9201so29530575ad.0;
        Mon, 19 Feb 2024 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708386306; x=1708991106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HwRlWfaCNPwM9GD0tDSwVZojM3ImHfFlaKA9xUSN8o=;
        b=djz+7muTDp/Fg5r40hkyvSNKb1zzNATD1hpFaSjv57aU4L1ZMcnSmVoWycXmpT19Ig
         wt7k1uZQ6b9by/Q5GNDJjhLOZVOCLLFMCXA8ZBbFXHMDFen6nriSHNCc+ttIEdz2NmyY
         yaDPK1s2eCray7HQujq1cgoTLlz91JlZs2FGmTkfHh60z66J9QeKBIaySSNHA9TbP4DH
         WyZ6RwaeEBgupgUj1gbkJG2K1NyNFJ7JYHlO2hQkDWtoOGJ4yt2VnLnso1LKZCAo0eUy
         Sn5Qmba8CTOFRDPjecFbNcN3mSOV0Auhb/M63iW/GrA594gZcsac2AVaAq2JqPBtdClH
         Bw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708386306; x=1708991106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HwRlWfaCNPwM9GD0tDSwVZojM3ImHfFlaKA9xUSN8o=;
        b=fHp7I/wwQpjaY/g1gzQV5IMX24BOD1RqxLY4sfA4XvRBxbyaD5sW7121jGe8HnPvzw
         3ccrWEn9x557gDoXLIOEOaoj1CvUCyN5hsWcKOlJGyeHlp5lRyNTm5sElItqqkrpjllh
         XKYnxGwhBPKUpX1BuHmFDZtlwC610oL5RGtDtHdwBf5xWyOaloyfRSq4Pwv4N1i7xp6X
         bfthe8ZAh3cs/n0+K2HrvB4j6ZXfYhtJLLD4D4LPS6U6PUqxomFvi8bwnWZlizestFun
         Kcfymk4ON3FgSXW2ZUmIHyppk1NeBxP+ZBxvCSl770Ew5RFzN3VSX9tLz+0dpRHACY05
         Ri7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJRwcYi8zNk9hXXgQ1Ww0mPu6tWHO72UxsU/lw16qScne7h6Jdwthzb1tp6yTlEwil6UBNHn/kraXkuNfoDD+DA0GhpZ3pTVjKGEdHm1o2iTp3xIT/4C1rHrfy5TU4RGCNWece29/BYQ==
X-Gm-Message-State: AOJu0YzfDRV4Qh3b1qm+XwQtVcYbqQs+Xl5KsJnc+2Rgd5qnXyV3Na+A
	Z94MOHATiH6XGcIDFWS8Qb0sXuLsB48jjXE5UeZM5BtOJja/8N/rt4kenWTzhsM=
X-Google-Smtp-Source: AGHT+IGqnWwAjyCSoltIVO84hnuEhpGtrjqY10JbapIt9XKWcr/SbDKXvxDVFKvIFfU9XF9iAGy4qQ==
X-Received: by 2002:a17:902:b944:b0:1d9:893f:cd06 with SMTP id h4-20020a170902b94400b001d9893fcd06mr12525368pls.60.1708386305530;
        Mon, 19 Feb 2024 15:45:05 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001db7ed7ac34sm4903477plb.297.2024.02.19.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 15:45:04 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Feb 2024 20:44:42 -0300
Subject: [PATCH net-next v4 3/3] net: dsa: realtek: support reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-realtek-reset-v4-3-858b82a29503@gmail.com>
References: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
In-Reply-To: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=lFFtbhACJmztPPpr3pxi0hEjHTFow84caBqcjZJj8og=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl0+ft1uzi91WMpRJ3ECBz5sXwj5Hc/Mhg4KxC1
 KliBUhSIwKJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZdPn7QAKCRC7Edu60Qc7
 VueGB/4k7dGr5BUWCt+XUMcKX+WhyEhLtmzbmJ3IJ/MRp94Fn0aSfzon/UmfQ7CuFbKXFZHCje5
 ro/vvNzWM1G74FKhdQs0mI64GlBfsO1XV29tikEEaMzfEQEOIKVybAi0AqA8g7plQCfG3ZN8hIZ
 LLdhFstkENlRyjqUcwHkE0KLTyFuYUv2nrk3FZztwuQXQjZ4DbE/jRyPQyWeaGTL9ntG7w8qwui
 PbNKSdX0KWILvEh8UCOghaMrYBE3NBCldf1hNphLYJNNj0rS2mky80N6bZLGs3NghGX59a+wG+Q
 AL3cZR3aRGKUgsnKmicYNyLHAJYXkhxwDx2lJ+sAlpyhuone
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Add support for resetting the device using a reset controller,
complementing the existing GPIO reset functionality (reset-gpios).

Although the reset is optional and the driver performs a soft reset
during setup, if the initial reset pin state was asserted, the driver
will not detect the device until the reset is deasserted.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/realtek.h |  2 ++
 drivers/net/dsa/realtek/rtl83xx.c | 46 ++++++++++++++++++++++++++++++++++-----
 drivers/net/dsa/realtek/rtl83xx.h |  2 ++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index b80bfde1ad04..e0b1aa01337b 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <net/dsa.h>
+#include <linux/reset.h>
 
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
@@ -48,6 +49,7 @@ struct rtl8366_vlan_4k {
 
 struct realtek_priv {
 	struct device		*dev;
+	struct reset_control    *reset_ctl;
 	struct gpio_desc	*reset;
 	struct gpio_desc	*mdc;
 	struct gpio_desc	*mdio;
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 801873754df2..8262ec5032a4 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -184,6 +184,13 @@ rtl83xx_probe(struct device *dev,
 						    "realtek,disable-leds");
 
 	/* TODO: if power is software controlled, set up any regulators here */
+	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(priv->reset_ctl)) {
+		ret = PTR_ERR(priv->reset_ctl);
+		dev_err_probe(dev, ret, "failed to get reset control\n");
+		return ERR_CAST(priv->reset_ctl);
+	}
+
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
@@ -192,11 +199,11 @@ rtl83xx_probe(struct device *dev,
 
 	dev_set_drvdata(dev, priv);
 
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+	if (priv->reset_ctl || priv->reset) {
+		rtl83xx_reset_assert(priv);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		rtl83xx_reset_deassert(priv);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -292,11 +299,40 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_shutdown, REALTEK_DSA);
 void rtl83xx_remove(struct realtek_priv *priv)
 {
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	rtl83xx_reset_assert(priv);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 
+void rtl83xx_reset_assert(struct realtek_priv *priv)
+{
+	int ret;
+
+	ret = reset_control_assert(priv->reset_ctl);
+	if (!ret)
+		return;
+
+	dev_warn(priv->dev,
+		 "Failed to assert the switch reset control: %pe\n",
+		 ERR_PTR(ret));
+
+	gpiod_set_value(priv->reset, true);
+}
+
+void rtl83xx_reset_deassert(struct realtek_priv *priv)
+{
+	int ret;
+
+	ret = reset_control_deassert(priv->reset_ctl);
+	if (!ret)
+		return;
+
+	dev_warn(priv->dev,
+		 "Failed to deassert the switch reset control: %pe\n",
+		 ERR_PTR(ret));
+
+	gpiod_set_value(priv->reset, false);
+}
+
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index 0ddff33df6b0..c8a0ff8fd75e 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -18,5 +18,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv);
 void rtl83xx_unregister_switch(struct realtek_priv *priv);
 void rtl83xx_shutdown(struct realtek_priv *priv);
 void rtl83xx_remove(struct realtek_priv *priv);
+void rtl83xx_reset_assert(struct realtek_priv *priv);
+void rtl83xx_reset_deassert(struct realtek_priv *priv);
 
 #endif /* _RTL83XX_H */

-- 
2.43.0


