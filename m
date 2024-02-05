Return-Path: <linux-kernel+bounces-53048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD4849FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15282285B27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C674E1C9;
	Mon,  5 Feb 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dulMkqUV"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3A48CC6;
	Mon,  5 Feb 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151759; cv=none; b=kDV3jYbd8WbOony1FYgzNs443brE9A1RbOT9f7CrH1eBjXLo4yLuNxOa9fzLxOrQXUbQLJb2nCn6rS80Ac5o3+qj65V8CmuQv8w8DqkfwpF3O72Os8WtrD+dqmfFFkQKslYHu8wjCObvgHftIr+gSzTL0LzkjH4JPhND9JIfkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151759; c=relaxed/simple;
	bh=CpFiKt9arcAd/DdvTfXA++kS54iSLovvRvO3R5Xb+n0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FONmCxTOhvz/lGsDboIkN03IPpSejAHHmQsR++C7MYoG1GXFskVttKhxJzc1XxQ7fWhNwLazR2OUao7BHZyATLRpgPk3YLFANsPGROc12262MSRqj/tz/ixbMHUI08TVypc0zEDj8s9RSGroAtBWopLD+JFx3pSjIau0j3zaY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dulMkqUV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so32318365e9.1;
        Mon, 05 Feb 2024 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151755; x=1707756555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYMtIg24uuXRIsgSP6U1ynvtwWf0bDfr47PWEVug3DI=;
        b=dulMkqUVKhjak1U9MiqknnEk24hi34gEIH2n3HDK0hzv4NkhdmY5oZOmsBT2M3KoGy
         yhghr+ROc1HX7g9FKT5qDDiBgnkuGkIly9TX348TLUCJfdDttA5y8C7nDI6ujuTidGNv
         OwjXenArg/sBpEXu9cCyaGEfLx6/yRoAEwbQQUwIwNUhXU+aVDpV2LdQNAYE9rt+08JC
         6xijSIt2FaJ/SF0pIcuaAGJNbiQgDxePBklKmwJDBSvgsCheJ7/KENLd96cuegt3BDzi
         Xja9CpeEnNlM1WCe1ZePGhnzUrF1+NUuWEeWCDjze/2S3V2DkwG7BpDIpbzIDAOOjM6k
         Eb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151755; x=1707756555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYMtIg24uuXRIsgSP6U1ynvtwWf0bDfr47PWEVug3DI=;
        b=FpcP14YxD4xpHRbimp3tG7+2+gNNKTNtVE/ESkKljbUXhAIaSzp1QHMrcZ2dW1w/xH
         2cFr9moZnGo6f/6IRN4cMFsmskOt/yVaxJcBXJZrVAeNTWY00LRSbWoH+yWwh2ZWceQs
         AEIMOG+fBFRDV5uphgPEWbL6uIldckDncAKjfSaP6IZ5NHBkEhCG0oXo+U1Wg9a+90jd
         IhV0+cI/ayTYkxoUoBWYWifa9nyFquhwsK4qySGxB7tXmMWElGXEAnDoPklD8HHBU0uB
         WvWkygADiNAfeYRXo1C8osd9QTXXhVB/sjtKapblRMA/1Pdrfx3GJkPDkcWdYqlNuz74
         NfEw==
X-Gm-Message-State: AOJu0YxwS0mtKw72ezXuGVTm2tYjQFrBXyZ1A66P479WEZx1Sad5YV5b
	fQ+XszqccsVE4eSoDDDmM8nIi0KDYhDKJpx/BQNE8/mlywQplBDJ
X-Google-Smtp-Source: AGHT+IEi8QATNYyOI1Fy4+ITBi+5rJSUtOAAKFklc4IbmDszrmnMRXUZKvO7SLJkh2anNw3N/gB6Hg==
X-Received: by 2002:a05:600c:35cf:b0:40f:dc7e:e286 with SMTP id r15-20020a05600c35cf00b0040fdc7ee286mr177541wmq.13.1707151755398;
        Mon, 05 Feb 2024 08:49:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/3uOUeZhpHZvSDxp4PR2FAfP70ve3t1SpGhfGkEOb3LU5Xilm2HOcMbTQGdsrji1efEw0amW1O7ZqoNFRrpe8zLZErYie2reMvwxQigfLh14m8q40Yw4qffaqdwj6P+ea1vLNhcsEzZX6QFdovi7k9cod4R8Y44jofeB0HknIFmL9rk4zMM1mSBpYcsNcY5PiIszlIZXYQDmSyA4yU7yWXxkVL5fMFUx2rm0DmOP2NKtMgO7GEyrMVjxPixaehdkEO9jkK+48zOes0XmPkD5WAwPncLi2MJryaFY/hd8scT6mlu3OVex278r3v3+vVcueT/7XcQCuYPJWTaUmK/CdC6NB+wNEVPBtVFJnxqWbKsV8iKEviZWfoo2w2sIbgPJj+NdyO9sJLM1A90j/IYl3Dlb8+dTybkYztz+eEwEYI0vIxJZ5+38CHURfc6S1dxaQgkjyC7MPAYsD/Fx5gHPLctPiYAVDptyC1/TQtMuV34Wcrqv1fM2aL94CpN75ABxKVXksI/9BI/p1vZ36jdDa9GHezu4PszG7hfD1uspnbljopQ9gSFurzChW4JEZNwJ7d0Ml7vfZCZElKsXYQovjiYKnW9ZRpDdzr6fzV/rHQoi55TKSff1Z6P0CMIjyaHP1trQpQfzi8Jt3qD0W4sc+cxaCaf8taP5ZXgJGnx3vZ3Sf7rjitg==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:15 -0800 (PST)
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 10/10] net: phy: qca807x: add support for configurable LED
Date: Mon,  5 Feb 2024 17:48:42 +0100
Message-ID: <20240205164851.1351-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/qcom/qca807x.c | 256 ++++++++++++++++++++++++++++++++-
 1 file changed, 254 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index de8ea94c15f7..1ec60eeca3c3 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -57,8 +57,18 @@
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
@@ -121,6 +131,233 @@ static int qca807x_cable_test_start(struct phy_device *phydev)
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
@@ -496,6 +733,16 @@ static int qca807x_probe(struct phy_device *phydev)
 								     "qcom,dac-disable-bias-current-tweak");
 
 	if (IS_ENABLED(CONFIG_GPIOLIB)) {
+		/* Make sure we don't have mixed leds node and gpio-controller
+		 * to prevent registering leds and having gpio-controller usage
+		 * conflicting with them.
+		 */
+		if (of_find_property(node, "leds", NULL) &&
+		    of_find_property(node, "gpio-controller", NULL)) {
+			phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
+			return -EINVAL;
+		}
+
 		/* Do not register a GPIO controller unless flagged for it */
 		if (of_property_read_bool(node, "gpio-controller")) {
 			ret = qca807x_gpio(phydev);
@@ -580,6 +827,11 @@ static struct phy_driver qca807x_drivers[] = {
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


