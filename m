Return-Path: <linux-kernel+bounces-160896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEA8B443F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A1282381
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E34086A;
	Sat, 27 Apr 2024 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA3DRrB7"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0F40855;
	Sat, 27 Apr 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714194715; cv=none; b=RoRFtHik1HH2b5r3x6OJyOqL6cngRNi1750DJ5khD5XbKlcZoR3/u0fiRCt46MDghYeJ0icm8sDLj71o5tx3qRcTkcWEYZMDRl2lf0nLkDQgZSHWVmdKzcEsfN/6MXotEEw6EYoFjUmabfP/pf2W+oExEiTJowBxrERx4CXhJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714194715; c=relaxed/simple;
	bh=9ZKWPMfna0jwv6fGXFjbpfO9PS9iN4T7q95CeiGCuwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmEQ+rfVwIHpo98E0BX4k/0Lh5BEGoN0afQJ/ZivwWR6zNbZQIkMoFfsMjnuz7Tr0pLz82zrxtiaAa8cFG1BkkkEjb5z4+S6NebY603pA8nqlr7amx2XzKwt5bcHZgte8wZ5NaJvNvha9km0w2d1jEccqtzhed8HXP6zPj3CPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA3DRrB7; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa2551d33dso1876859eaf.0;
        Fri, 26 Apr 2024 22:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714194713; x=1714799513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9F4InxFahtIzBCiasX92apB/V4CV7bosSvWP44yKEb4=;
        b=mA3DRrB7Eo8cTwHt+TZnLKQWA+d3PD89SPdSqWEkAWcwlquGas9cEqb4Wvm7ES0yC6
         YgdBK7L1O8vt7bn1G1rkE2ol9nlaOxIXBGpIBBEg7NHLbedJWvEjsbymYGq/j3DCHpHr
         uc8pRTepnE4+/NiEwlMdgHGEwoDfQfCoXHmwhp3AGgKBeK8PAJXJ0jY41Hg0OMJcwdWV
         An0EAeCIvDgxx4AIiv5zl5wom2J8o/H2VwVJ7WgjmgU9zRKcvcdUz4oKTf0P/l7gIyxf
         i2tV6qrS0+k5JnPEuTcnsB2H1iFjjkOd6Rh18IasVfSsv+bOMLrN80EG7SQLenXpitHw
         tQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714194713; x=1714799513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F4InxFahtIzBCiasX92apB/V4CV7bosSvWP44yKEb4=;
        b=DLMx3kLkULC5N2sXGl+ev6ZsNcTBjC0jxmMazckeUqNUFVivxCCH683oDPNcIe12rA
         TBJRI44s52SIXy6k1KHBkAfVkHOZG2y4zN1IppoeFw2c93V8vubO1NQLMdVAz9OlLJBp
         Sh0hk7quIzkfMacwo4fHzz015MxunsfJ9HsXQstPVaTTZQ93ea01FGUq+C10nouZtFYn
         8XwFefFd8WSiltCONzWqxGF3P8x78AhawZdRxCCLq+H5VLwy174KY5V2RvsSsxnZu2FT
         3DDNbdUbG7W84bMB5RXvvAdsetX/6NxFNe9KQ17iK6+rUUZA7f9CpEkUD1AWjy7iC623
         WrdA==
X-Forwarded-Encrypted: i=1; AJvYcCUO0VVdXbPngrE6nmIOiMUzltpexp4125MTEnF4xLPT33PxH3lciH+TKIgZd+NeOpkvaBUqryJa9vK3PhObyaqiK3aZ47QsmdlwMLjQa6MrhmecQ0UtoOulPy20EnBYCCK8V+MyUfli6g==
X-Gm-Message-State: AOJu0YwdjDOFxBKuUPXrbnMk4b6rrjPRBnzZSItZFycZkQNBwyVLOxDM
	WeUzbAcv2Wkn4q6ej5jytGhEZRy3CETgi7LJ0nz2y/VSAhxWJOnvCA8+2UaO
X-Google-Smtp-Source: AGHT+IE4bqioLoCGV+jzLhQAaIUbw7Dc8kiVDJrn5V2zZm+LA6pJOaXRtr0eZA54kNM1E4aqo9TKTA==
X-Received: by 2002:a05:6359:4294:b0:183:7f41:8c10 with SMTP id kp20-20020a056359429400b001837f418c10mr4776508rwb.31.1714194712723;
        Fri, 26 Apr 2024 22:11:52 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.34.32.15])
        by smtp.gmail.com with ESMTPSA id cb17-20020a056a02071100b0060063c4be3bsm8108513pgb.14.2024.04.26.22.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 22:11:52 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 27 Apr 2024 02:11:28 -0300
Subject: [PATCH net-next v2 1/3] net: dsa: realtek: keep default LED state
 in rtl8366rb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-realtek-led-v2-1-5abaddc32cf6@gmail.com>
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
In-Reply-To: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6278; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=9ZKWPMfna0jwv6fGXFjbpfO9PS9iN4T7q95CeiGCuwg=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBmLIkLMef9uX5o5VyYCAREndzz27xiW68szjmjh
 PaKiXSrgFmJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZiyJCwAKCRC7Edu60Qc7
 Vi4YB/9TgcRLUrU8mlHtt1MMiLgR4y/xp/ysUsPNJWrQ+kbrYuJ05BaM8qxHoYuK+6rIWvoKcRD
 sdmll/wLVIg8sOW4oBY+FI1WbkxEVoY4avEEE++1tvRLP8Y206nOq3BtX5Or02nbqXDsxcy0IZM
 10iYQ5kChGk+WXpHG2kuBJCJx6kwkokTZoiox1BH+J/HW8D9w4XRGl6BUPWA8gFCjk0EMEi7Lfi
 6Rg5V2qTjfJxaI8u1FZjFDmGITOFcH4vfotL5TOT9QNxIs5QNgtr6tTaU7CbpsC21i6dYbgjrBJ
 Fk+xTL15wTCJN4dv2DhUnV9NlfcuHto5AErvkvhXpsVKBhVx
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

This switch family supports four LEDs for each of its six ports. Each
LED group is composed of one of these four LEDs from all six ports. LED
groups can be configured to display hardware information, such as link
activity, or manually controlled through a bitmap in registers
RTL8366RB_LED_0_1_CTRL_REG and RTL8366RB_LED_2_3_CTRL_REG.

After a reset, the default LED group configuration for groups 0 to 3
indicates, respectively, link activity, link at 1000M, 100M, and 10M, or
RTL8366RB_LED_CTRL_REG as 0x5432. These configurations are commonly used
for LED indications. However, the driver was replacing that
configuration to use manually controlled LEDs (RTL8366RB_LED_FORCE)
without providing a way for the OS to control them. The default
configuration is deemed more useful than fixed, uncontrollable turned-on
LEDs.

The driver was enabling/disabling LEDs during port_enable/disable.
However, these events occur when the port is administratively controlled
(up or down) and are not related to link presence. Additionally, when a
port N was disabled, the driver was turning off all LEDs for group N,
not only the corresponding LED for port N in any of those 4 groups. In
such cases, if port 0 was brought down, the LEDs for all ports in LED
group 0 would be turned off. As another side effect, the driver was
wrongly warning that port 5 didn't have an LED ("no LED for port 5").
Since showing the administrative state of ports is not an orthodox way
to use LEDs, it was not worth it to fix it and all this code was
dropped.

The code to disable LEDs was simplified only changing each LED group to
the RTL8366RB_LED_OFF state. Registers RTL8366RB_LED_0_1_CTRL_REG and
RTL8366RB_LED_2_3_CTRL_REG are only used when the corresponding LED
group is configured with RTL8366RB_LED_FORCE and they don't need to be
cleaned. The code still references an LED controlled by
RTL8366RB_INTERRUPT_CONTROL_REG, but as of now, no test device has
actually used it. Also, some magic numbers were replaced by macros.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 87 +++++++++----------------------------
 1 file changed, 20 insertions(+), 67 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index e10ae94cf771..5ccb1a3a149d 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -185,7 +185,12 @@
 #define RTL8366RB_LED_BLINKRATE_222MS		0x0004
 #define RTL8366RB_LED_BLINKRATE_446MS		0x0005
 
+/* LED trigger event for each group */
 #define RTL8366RB_LED_CTRL_REG			0x0431
+#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
+	(4 * (led_group))
+#define RTL8366RB_LED_CTRL_MASK(led_group)	\
+	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
 #define RTL8366RB_LED_OFF			0x0
 #define RTL8366RB_LED_DUP_COL			0x1
 #define RTL8366RB_LED_LINK_ACT			0x2
@@ -202,6 +207,11 @@
 #define RTL8366RB_LED_LINK_TX			0xd
 #define RTL8366RB_LED_MASTER			0xe
 #define RTL8366RB_LED_FORCE			0xf
+
+/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
+ * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
+ * RTL8366RB_LED_FORCE. Otherwise, it is ignored.
+ */
 #define RTL8366RB_LED_0_1_CTRL_REG		0x0432
 #define RTL8366RB_LED_1_OFFSET			6
 #define RTL8366RB_LED_2_3_CTRL_REG		0x0433
@@ -1001,28 +1011,20 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	 */
 	if (priv->leds_disabled) {
 		/* Turn everything off */
-		regmap_update_bits(priv->map,
-				   RTL8366RB_LED_0_1_CTRL_REG,
-				   0x0FFF, 0);
-		regmap_update_bits(priv->map,
-				   RTL8366RB_LED_2_3_CTRL_REG,
-				   0x0FFF, 0);
 		regmap_update_bits(priv->map,
 				   RTL8366RB_INTERRUPT_CONTROL_REG,
 				   RTL8366RB_P4_RGMII_LED,
 				   0);
-		val = RTL8366RB_LED_OFF;
-	} else {
-		/* TODO: make this configurable per LED */
-		val = RTL8366RB_LED_FORCE;
-	}
-	for (i = 0; i < 4; i++) {
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_CTRL_REG,
-					 0xf << (i * 4),
-					 val << (i * 4));
-		if (ret)
-			return ret;
+
+		for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
+			val = RTL8366RB_LED_OFF << RTL8366RB_LED_CTRL_OFFSET(i);
+			ret = regmap_update_bits(priv->map,
+						 RTL8366RB_LED_CTRL_REG,
+						 RTL8366RB_LED_CTRL_MASK(i),
+						 val);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = rtl8366_reset_vlan(priv);
@@ -1167,52 +1169,6 @@ rtl8366rb_mac_link_down(struct dsa_switch *ds, int port, unsigned int mode,
 	}
 }
 
-static void rb8366rb_set_port_led(struct realtek_priv *priv,
-				  int port, bool enable)
-{
-	u16 val = enable ? 0x3f : 0;
-	int ret;
-
-	if (priv->leds_disabled)
-		return;
-
-	switch (port) {
-	case 0:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_0_1_CTRL_REG,
-					 0x3F, val);
-		break;
-	case 1:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_0_1_CTRL_REG,
-					 0x3F << RTL8366RB_LED_1_OFFSET,
-					 val << RTL8366RB_LED_1_OFFSET);
-		break;
-	case 2:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_2_3_CTRL_REG,
-					 0x3F, val);
-		break;
-	case 3:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_2_3_CTRL_REG,
-					 0x3F << RTL8366RB_LED_3_OFFSET,
-					 val << RTL8366RB_LED_3_OFFSET);
-		break;
-	case 4:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_INTERRUPT_CONTROL_REG,
-					 RTL8366RB_P4_RGMII_LED,
-					 enable ? RTL8366RB_P4_RGMII_LED : 0);
-		break;
-	default:
-		dev_err(priv->dev, "no LED for port %d\n", port);
-		return;
-	}
-	if (ret)
-		dev_err(priv->dev, "error updating LED on port %d\n", port);
-}
-
 static int
 rtl8366rb_port_enable(struct dsa_switch *ds, int port,
 		      struct phy_device *phy)
@@ -1226,7 +1182,6 @@ rtl8366rb_port_enable(struct dsa_switch *ds, int port,
 	if (ret)
 		return ret;
 
-	rb8366rb_set_port_led(priv, port, true);
 	return 0;
 }
 
@@ -1241,8 +1196,6 @@ rtl8366rb_port_disable(struct dsa_switch *ds, int port)
 				 BIT(port));
 	if (ret)
 		return;
-
-	rb8366rb_set_port_led(priv, port, false);
 }
 
 static int

-- 
2.44.0


