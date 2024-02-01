Return-Path: <linux-kernel+bounces-48383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4D845B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D8029443E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2158161B75;
	Thu,  1 Feb 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Brzrk2"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A6160878;
	Thu,  1 Feb 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800713; cv=none; b=mii/+XX0Ig2xGOhsCcPeIdBLiZQvvvuhlmmzCj6brWCQNj0XSKjstiFdaqt7/Rpgnt/oaBbGcYPjp3rxGN11BzxI3fXri/Mfn3rsFpCA4SM8rWYPTDoaLGsqTmbyd6fbDO7+5fmKCsvks6nsXWajvgd00uG7ca/sa+W5JhAsHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800713; c=relaxed/simple;
	bh=k2sOP785pc0oOoJN++0dNNzykTF1ju30lV9nO1lO7mQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uG3gVRnh+S0s/9ePz9OSyh+XxiYJQkEKB8wU7ojXd1yqkuPUh9sQTte0XVVdUoSJmqmzXiTD56sPONbKrh4GMAzrgucld/RYLViJboUNIwNUzFHOT3gYsEH/zFXlaWZLPdo1eOvaXo5hdvRs5qeB6fSB4dViVinlIw1RdY/Cf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Brzrk2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d07f2696a4so3100211fa.3;
        Thu, 01 Feb 2024 07:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800709; x=1707405509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPDJTzuzSaVXPpWPlsQr2wpNCRYD0dBZ+TyHi5To/ZA=;
        b=b3Brzrk2lBPMWvhxn2UmdYLpAhKieHmB+6d/aOIPWEQsVErstRERguxfQzf5zfqSfW
         c86hWxPJOUh0fO9wEPv7K0OyNULN3IxhEDpRsRMYFgzv+bhddfEVZ54lwTrsNxoRKHNQ
         bFUqIsY/JT35j/gN3oAjxHM1eW75sAL/8p9jhHQRxCzsaA9AKmk2P6PbRlvr8fQarWo2
         6VeSGPowD9Dp9GovY1dLPl6lx9aGfk9NV0ixjSMBRj4muAK9//JxYK5gsBgC8ctYQylW
         tZh7wjQsNvuFb8TkQq3CKxhuq+XyR2Io0MEBEqrPvi9T5oUCThfyS3pMt1Kk+UKX2492
         sdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800709; x=1707405509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPDJTzuzSaVXPpWPlsQr2wpNCRYD0dBZ+TyHi5To/ZA=;
        b=PkwqfP4mfArCxMIitl2LO3Zxhxt4eXBkb4avyYZb5bCpWcna5pI2UoGQb5SC2FJsqV
         izycg/dtHzRBX5EmWTWnJ59ghDc/EOBXNdCdIszd3ZZSnReyWjd6q4XZak9XO5FqCOtV
         tD5tdRRwFffvqvXNL6i6B8TjJQjLsS5NqvdLXl6lTRXuspudn8/2ufW34U1taXzkfO8P
         ptAnnZyDPoB9Skvcivc9xq5ILcRdg99xrhdS7rVWtb1R12IoTCMQBj0qHB80WupkNJyn
         E2npWO97KwQystAYQnvRGTTuusJF+4+rQ4u+ShXHRXZmffdOhA6A1nhRWv/5pRloNnmp
         HFQQ==
X-Gm-Message-State: AOJu0Yxwb98R9my63b12ZBC9QY7KuVb8bVnmXHv6FPAkTXLW/evsxlG2
	6TK5qu4IWKrqg556S3g19ljU2RYn2l9YAUMw06UNTnRihwCbx0jZ
X-Google-Smtp-Source: AGHT+IEtskKvSGCGmwWceQcyC9B0HCHd87vN71sLlBXdNSqU+1VzjZoPTDllNZyf5VaPLk6PLA/aTg==
X-Received: by 2002:a2e:9e95:0:b0:2d0:78b4:329a with SMTP id f21-20020a2e9e95000000b002d078b4329amr1456352ljk.35.1706800709480;
        Thu, 01 Feb 2024 07:18:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjkj1ajue1Zf464zibJ7pVsut1kqBrOMmIHeU+AZuUHKYmEMhEAARoVWTg7zBnnMo5YOtcpLh/6bkXzavJuPa3cch8fYmKf4tioCXVFJUbd+ttV42bSpm6cV2woNrxd6EwnmAG/RY14x8tZfAC11TXgoDn8/xJhFKA1J00p33gKuNExjOv6BxBd3jS14HMMai2+Lvkj276rctgDjPgr9MMwPN/3Q9Aa1wpuJw4zkCHm+TDjzt2JjldmE9/dCKGRryHK25YuJnadip9lO08dx3yT9lTfyBtVZmcCYH014bLzgGxbtpoLnOmoLBiD7tuj87v3I5pHzRQTI1RrS1IJy3yMTLj2NP1LYfEn3vJipU2zWFnt56VdLmd0aSxd/GusMoKGsuukS6tRtJRQAv9xp3tdjroOkL9OSjSKCgqqJZcq547HuYTr4mmo0u+Jhklsz9EgPE1Axr2DcSQtsKxFmUtozSjensTzyS9VNWZVrUDmGerTT5s4aCb2mjWSbH+Tpxvgz0EO/d2fvAvs+dfyuAlPUuAVwbqKqOHuJBaavnHT324wzZpyhh0GFUwlft0VEoHUb4tlw0zz0ZWAh3m83gJLT1NegKQ9mtWKLgjg4fxLPpZiv0ER2Mr
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:29 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 9/9] net: phy: qca807x: add support for configurable LED
Date: Thu,  1 Feb 2024 16:17:35 +0100
Message-ID: <20240201151747.7524-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201151747.7524-1-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QCA8072/5 have up to 2 LEDs attached for PHY.

LEDs can be configured to be ON/hw blink or be set to HW control.

Hw blink mode is set to blink at 4Hz or 250ms.

PHY can support both copper (TP) or fiber (FIBRE) kind and supports
different HW control modes based on the port type.

HW control modes supported for netdev trigger for copper ports are:
- LINK_10
- LINK_100
- LINK_1000
- TX
- RX
- FULL_DUPLEX
- HALF_DUPLEX

HW control modes supported for netdev trigger for fiber ports are:
- LINK_100
- LINK_1000
- TX
- RX
- FULL_DUPLEX
- HALF_DUPLEX

LED support conflicts with GPIO controller feature and must be disabled
if gpio-controller is used for the PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca807x.c | 258 ++++++++++++++++++++++++++++++++-
 1 file changed, 256 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 5ff6ba9fa1a0..0d7fd1a9404e 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -47,8 +47,18 @@
 #define QCA807X_MMD7_LED_CTRL(x)			(0x8074 + ((x) * 2))
 #define QCA807X_MMD7_LED_FORCE_CTRL(x)			(0x8075 + ((x) * 2))
 
-#define QCA807X_GPIO_FORCE_EN				BIT(15)
-#define QCA807X_GPIO_FORCE_MODE_MASK			GENMASK(14, 13)
+/* LED hw control pattern for fiber port */
+#define QCA807X_LED_FIBER_PATTERN_MASK			GENMASK(11, 1)
+#define QCA807X_LED_FIBER_TXACT_BLK_EN			BIT(10)
+#define QCA807X_LED_FIBER_RXACT_BLK_EN			BIT(9)
+#define QCA807X_LED_FIBER_FDX_ON_EN			BIT(6)
+#define QCA807X_LED_FIBER_HDX_ON_EN			BIT(5)
+#define QCA807X_LED_FIBER_1000BX_ON_EN			BIT(2)
+#define QCA807X_LED_FIBER_100FX_ON_EN			BIT(1)
+
+/* Some device repurpose the LED as GPIO out */
+#define QCA807X_GPIO_FORCE_EN				QCA808X_LED_FORCE_EN
+#define QCA807X_GPIO_FORCE_MODE_MASK			QCA808X_LED_FORCE_MODE_MASK
 
 #define QCA807X_FUNCTION_CONTROL			0x10
 #define QCA807X_FC_MDI_CROSSOVER_MODE_MASK		GENMASK(6, 5)
@@ -105,6 +115,233 @@ static int qca807x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca807x_led_parse_netdev(struct phy_device *phydev, unsigned long rules,
+				    u16 *offload_trigger)
+{
+	/* Parsing specific to netdev trigger */
+	switch (phydev->port) {
+	case PORT_TP:
+		if (test_bit(TRIGGER_NETDEV_TX, &rules))
+			*offload_trigger |= QCA808X_LED_TX_BLINK;
+		if (test_bit(TRIGGER_NETDEV_RX, &rules))
+			*offload_trigger |= QCA808X_LED_RX_BLINK;
+		if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+			*offload_trigger |= QCA808X_LED_SPEED10_ON;
+		if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+			*offload_trigger |= QCA808X_LED_SPEED100_ON;
+		if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+			*offload_trigger |= QCA808X_LED_SPEED1000_ON;
+		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+			*offload_trigger |= QCA808X_LED_HALF_DUPLEX_ON;
+		if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+			*offload_trigger |= QCA808X_LED_FULL_DUPLEX_ON;
+		break;
+	case PORT_FIBRE:
+		if (test_bit(TRIGGER_NETDEV_TX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_TXACT_BLK_EN;
+		if (test_bit(TRIGGER_NETDEV_RX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_RXACT_BLK_EN;
+		if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_100FX_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_1000BX_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_HDX_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_FDX_ON_EN;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (rules && !*offload_trigger)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int qca807x_led_hw_control_enable(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+
+	if (index > 1)
+		return -EINVAL;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_hw_control_enable(phydev, reg);
+}
+
+static int qca807x_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 offload_trigger = 0;
+
+	if (index > 1)
+		return -EINVAL;
+
+	return qca807x_led_parse_netdev(phydev, rules, &offload_trigger);
+}
+
+static int qca807x_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	u16 reg, mask, offload_trigger = 0;
+	int ret;
+
+	if (index > 1)
+		return -EINVAL;
+
+	ret = qca807x_led_parse_netdev(phydev, rules, &offload_trigger);
+	if (ret)
+		return ret;
+
+	ret = qca807x_led_hw_control_enable(phydev, index);
+	if (ret)
+		return ret;
+
+	switch (phydev->port) {
+	case PORT_TP:
+		reg = QCA807X_MMD7_LED_CTRL(index);
+		mask = QCA808X_LED_PATTERN_MASK;
+		break;
+	case PORT_FIBRE:
+		/* HW control pattern bits are in LED FORCE reg */
+		reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+		mask = QCA807X_LED_FIBER_PATTERN_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg, mask,
+			      offload_trigger);
+}
+
+static bool qca807x_led_hw_control_status(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+
+	if (index > 1)
+		return false;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_hw_control_status(phydev, reg);
+}
+
+static int qca807x_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	u16 reg;
+	int val;
+
+	if (index > 1)
+		return -EINVAL;
+
+	/* Check if we have hw control enabled */
+	if (qca807x_led_hw_control_status(phydev, index))
+		return -EINVAL;
+
+	/* Parsing specific to netdev trigger */
+	switch (phydev->port) {
+	case PORT_TP:
+		reg = QCA807X_MMD7_LED_CTRL(index);
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+		if (val & QCA808X_LED_TX_BLINK)
+			set_bit(TRIGGER_NETDEV_TX, rules);
+		if (val & QCA808X_LED_RX_BLINK)
+			set_bit(TRIGGER_NETDEV_RX, rules);
+		if (val & QCA808X_LED_SPEED10_ON)
+			set_bit(TRIGGER_NETDEV_LINK_10, rules);
+		if (val & QCA808X_LED_SPEED100_ON)
+			set_bit(TRIGGER_NETDEV_LINK_100, rules);
+		if (val & QCA808X_LED_SPEED1000_ON)
+			set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+		if (val & QCA808X_LED_HALF_DUPLEX_ON)
+			set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+		if (val & QCA808X_LED_FULL_DUPLEX_ON)
+			set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
+		break;
+	case PORT_FIBRE:
+		/* HW control pattern bits are in LED FORCE reg */
+		reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+		if (val & QCA807X_LED_FIBER_TXACT_BLK_EN)
+			set_bit(TRIGGER_NETDEV_TX, rules);
+		if (val & QCA807X_LED_FIBER_RXACT_BLK_EN)
+			set_bit(TRIGGER_NETDEV_RX, rules);
+		if (val & QCA807X_LED_FIBER_100FX_ON_EN)
+			set_bit(TRIGGER_NETDEV_LINK_100, rules);
+		if (val & QCA807X_LED_FIBER_1000BX_ON_EN)
+			set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+		if (val & QCA807X_LED_FIBER_HDX_ON_EN)
+			set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+		if (val & QCA807X_LED_FIBER_FDX_ON_EN)
+			set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qca807x_led_hw_control_reset(struct phy_device *phydev, u8 index)
+{
+	u16 reg, mask;
+
+	if (index > 1)
+		return -EINVAL;
+
+	switch (phydev->port) {
+	case PORT_TP:
+		reg = QCA807X_MMD7_LED_CTRL(index);
+		mask = QCA808X_LED_PATTERN_MASK;
+		break;
+	case PORT_FIBRE:
+		/* HW control pattern bits are in LED FORCE reg */
+		reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+		mask = QCA807X_LED_FIBER_PATTERN_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg, mask);
+}
+
+static int qca807x_led_brightness_set(struct phy_device *phydev,
+				      u8 index, enum led_brightness value)
+{
+	u16 reg;
+	int ret;
+
+	if (index > 1)
+		return -EINVAL;
+
+	/* If we are setting off the LED reset any hw control rule */
+	if (!value) {
+		ret = qca807x_led_hw_control_reset(phydev, index);
+		if (ret)
+			return ret;
+	}
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_brightness_set(phydev, reg, value);
+}
+
+static int qca807x_led_blink_set(struct phy_device *phydev, u8 index,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+	u16 reg;
+
+	if (index > 1)
+		return -EINVAL;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_blink_set(phydev, reg, delay_on, delay_off);
+}
+
 #ifdef CONFIG_GPIOLIB
 static int qca807x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
@@ -481,11 +718,23 @@ static int qca807x_probe(struct phy_device *phydev)
 		return -EINVAL;
 
 	if (IS_ENABLED(CONFIG_GPIOLIB)) {
+		if (of_find_property(node, "leds", NULL) &&
+		    of_find_property(node, "gpio-controller", NULL)) {
+			phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
+			return -EINVAL;
+		}
+
 		/* Do not register a GPIO controller unless flagged for it */
 		if (of_property_read_bool(node, "gpio-controller")) {
 			ret = qca807x_gpio(phydev);
 			if (ret)
 				return ret;
+
+			phydev->drv->led_brightness_set = NULL;
+			phydev->drv->led_blink_set = NULL;
+			phydev->drv->led_hw_is_supported = NULL;
+			phydev->drv->led_hw_control_set = NULL;
+			phydev->drv->led_hw_control_get = NULL;
 		}
 	}
 
@@ -561,6 +810,11 @@ static struct phy_driver qca807x_drivers[] = {
 		.suspend	= genphy_suspend,
 		.cable_test_start	= qca807x_cable_test_start,
 		.cable_test_get_status	= qca808x_cable_test_get_status,
+		.led_brightness_set = qca807x_led_brightness_set,
+		.led_blink_set = qca807x_led_blink_set,
+		.led_hw_is_supported = qca807x_led_hw_is_supported,
+		.led_hw_control_set = qca807x_led_hw_control_set,
+		.led_hw_control_get = qca807x_led_hw_control_get,
 	},
 };
 module_phy_driver(qca807x_drivers);
-- 
2.43.0


