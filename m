Return-Path: <linux-kernel+bounces-48382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D8845B44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FFB2825F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37B161B4D;
	Thu,  1 Feb 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDoR1IEv"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FB15959C;
	Thu,  1 Feb 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800712; cv=none; b=gOu7DnasFxdW0Tt0ADV1zDStCHAWuaYUAQL8cqMJmyBBr805qhk/f/swYa1gdQQW0ItZSM77YSL/v0OPmGyVnHvj0cbi9Uddvy5nOMdEA4v8x0B3P82Wzyzo1YUr1TyQKf39YVWTekVNuAB6oc/hoZGnlHM3tX11122/Da8SNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800712; c=relaxed/simple;
	bh=TIw6iQWeFEW3/xAywLMt34g8j4Z5GYJRGEFf8ufzMZo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/esok4WhqBTp1fupR09Wmk1+IPr5SvO29TekCZqn/IIIm/MnttwaYoFRU76SUcJJMQauhhwX4EgC5RSe5HidBA9zP3EjOn9+ZCCa3a8HEbWgiiejS8E5EbWNLyeQk23/esGtt5UnkYUhMZO0uwk5R06lSODBHHzKaxF9qd2n/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDoR1IEv; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so13586081fa.1;
        Thu, 01 Feb 2024 07:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800708; x=1707405508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSEejDDqRzuGMp5Tl9hjbpg0G4yF9SOkJoVknNvpciM=;
        b=hDoR1IEv2+0TbvYcg1bSadriea3Xg+87VFu0XLeTzUhH4+Ly3/9IZRsAHgbEIacDDa
         T1DH+D5dRLyyY/cCYjS9wMTGlhkz6WAIen+A/u9Z7e8FY2ULZm9AduwSyOAcg+GjDjmU
         NE2XYpljFHnQ/1lRAZvEbUYU6T/+fsoAoisVB/hFEndrTxoyNlwSsGfAqNsmX43clXon
         d1x0xGg4MiRWaJJ8kPM210OfHyGyWVAvp32yoLG8paioJJcvPSE4SV880jLt74Zc+CMF
         no75olD+aflyFE8Pj2D7Y86CmQnFTkuNu0I3anFBOEaVHbipUI8h6VGFIi+BFiom+sEn
         GVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800708; x=1707405508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSEejDDqRzuGMp5Tl9hjbpg0G4yF9SOkJoVknNvpciM=;
        b=fOdxZrt8lfawo7TJFbcV0RbYd6cRwvptgdeJc3cZij3Sd9VBVGBxoDK6epg67zu31R
         dxvU01MmikMFq2w5tB8nRozLhR3nUhHGQGgcfIwccxyWuUoIYdOV+Zttd/A1sjUtnWoA
         qkK/nlQoNYOpUZAcKJFTO3mJYzHi9OCTT9SoNMWx+yTgSUpRIModwjdFI/ObHdRV3odE
         87r5eGSNllKQ+H36vGhWzOA7IUT8WeRUQGtOaQTMB3vAoEfyuGyupwvrsuUg7Rhm1jmL
         BC01Spizx6DnghYTLGccoGMGS4jbF8f5M5gCukWJ4/+CT5A1v53YKnZrG0/xxa4dHnou
         zm2A==
X-Gm-Message-State: AOJu0YyJGdAVqhVVe8Mi1HT0OvWh3WWnzpiUgwBlWxKCKlcDbUAReUs5
	NrTXNfgPegz0ELeCYl8w9uWsQ8bqApqEqrjd3rNOjqF2lk+t3o8g
X-Google-Smtp-Source: AGHT+IENaE2THeiIne8asjUZxmESX+Xpud6A+8KR2xtuhO1nVeNQz1JjyNWxxevD7WXbvUsoB7Z8Ew==
X-Received: by 2002:a2e:a785:0:b0:2cf:4994:616b with SMTP id c5-20020a2ea785000000b002cf4994616bmr2104657ljf.15.1706800707483;
        Thu, 01 Feb 2024 07:18:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/kZ/8+WnE5HWnLD+yk9EtEw4TzUIPK3h2YsD6yBEdgdA0v8nrvZ+/KQMH49jdbUav0xuhjpTzyJSR0OoMrBeZaJf5K00rOSqc3zI0hJPXvOC5HAZckbo9O2hdRZUGvN7at9gtmCIW0T76kpOIvbdtdF0torJ72AfgftkwfhQAwbUE8vr5LtWyGUKlULsAZEKaKWIzS1LbS5Tre9DIdDoLxbID2WfX2uNFHSXvjvJ9qJsG9IYRZEAJwEOJuZeR0/J0SkaGc2flwdCx78ZoM/Y+mxwSHhGogJ882K2BA3b82oCYdrNydx3IHcgtOeqspJ8nmIs5FZMh2Jy4vB2YOc5CQBYop+OwZ8Dmz3qd8UwW/Ig4U1/OSVbfZnH6mdqLLJ9mfLurkenaDPxiubtIOusb299zFZIaSHMqUV0mm5fEh02KPCyuLn7c8s2/bBKwY9VVnUUBy7eRTJaytMfqtN7eSE9MzWkTn8fWkw0BL/engHjRGtXND20YDtprasre+1zAcU1UpasRUrlFKhlNrP340wApBzsfnFpR1L5fA4QPPY5vRMn2qSfS+ByIMqz2cNfDYHUnr3t9hKEWF+WyDjqIYM9Fu2e/dYBfJMmzv+AEi8VEVbkRCzAH
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:27 -0800 (PST)
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
Subject: [net-next PATCH v5 8/9] net: phy: qcom: generalize some qca808x LED functions
Date: Thu,  1 Feb 2024 16:17:34 +0100
Message-ID: <20240201151747.7524-9-ansuelsmth@gmail.com>
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

Generalize some qca808x LED functions in preparation for qca807x LED
support.

The LED implementation of qca808x and qca807x is the same but qca807x
supports also Fiber port and have different hw control bits for Fiber
port. To limit code duplication introduce micro functions that takes reg
instead of LED index to tweak all the supported LED modes.

Also move to shared header all the common LED bits.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c      | 106 ++--------------------------
 drivers/net/phy/qcom/qcom-phy-lib.c |  54 ++++++++++++++
 drivers/net/phy/qcom/qcom.h         |  72 +++++++++++++++++++
 3 files changed, 131 insertions(+), 101 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8124bc2d5e5f..d25ab19b18bf 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -62,29 +62,6 @@
 #define QCA808X_DBG_AN_TEST			0xb
 #define QCA808X_HIBERNATION_EN			BIT(15)
 
-#define QCA808X_MMD7_LED_GLOBAL			0x8073
-#define QCA808X_LED_BLINK_1			GENMASK(11, 6)
-#define QCA808X_LED_BLINK_2			GENMASK(5, 0)
-/* Values are the same for both BLINK_1 and BLINK_2 */
-#define QCA808X_LED_BLINK_FREQ_MASK		GENMASK(5, 3)
-#define QCA808X_LED_BLINK_FREQ_2HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x0)
-#define QCA808X_LED_BLINK_FREQ_4HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x1)
-#define QCA808X_LED_BLINK_FREQ_8HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x2)
-#define QCA808X_LED_BLINK_FREQ_16HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x3)
-#define QCA808X_LED_BLINK_FREQ_32HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x4)
-#define QCA808X_LED_BLINK_FREQ_64HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x5)
-#define QCA808X_LED_BLINK_FREQ_128HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x6)
-#define QCA808X_LED_BLINK_FREQ_256HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x7)
-#define QCA808X_LED_BLINK_DUTY_MASK		GENMASK(2, 0)
-#define QCA808X_LED_BLINK_DUTY_50_50		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x0)
-#define QCA808X_LED_BLINK_DUTY_75_25		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x1)
-#define QCA808X_LED_BLINK_DUTY_25_75		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x2)
-#define QCA808X_LED_BLINK_DUTY_33_67		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x3)
-#define QCA808X_LED_BLINK_DUTY_67_33		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x4)
-#define QCA808X_LED_BLINK_DUTY_17_83		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x5)
-#define QCA808X_LED_BLINK_DUTY_83_17		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x6)
-#define QCA808X_LED_BLINK_DUTY_8_92		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x7)
-
 #define QCA808X_MMD7_LED2_CTRL			0x8074
 #define QCA808X_MMD7_LED2_FORCE_CTRL		0x8075
 #define QCA808X_MMD7_LED1_CTRL			0x8076
@@ -92,51 +69,9 @@
 #define QCA808X_MMD7_LED0_CTRL			0x8078
 #define QCA808X_MMD7_LED_CTRL(x)		(0x8078 - ((x) * 2))
 
-/* LED hw control pattern is the same for every LED */
-#define QCA808X_LED_PATTERN_MASK		GENMASK(15, 0)
-#define QCA808X_LED_SPEED2500_ON		BIT(15)
-#define QCA808X_LED_SPEED2500_BLINK		BIT(14)
-/* Follow blink trigger even if duplex or speed condition doesn't match */
-#define QCA808X_LED_BLINK_CHECK_BYPASS		BIT(13)
-#define QCA808X_LED_FULL_DUPLEX_ON		BIT(12)
-#define QCA808X_LED_HALF_DUPLEX_ON		BIT(11)
-#define QCA808X_LED_TX_BLINK			BIT(10)
-#define QCA808X_LED_RX_BLINK			BIT(9)
-#define QCA808X_LED_TX_ON_10MS			BIT(8)
-#define QCA808X_LED_RX_ON_10MS			BIT(7)
-#define QCA808X_LED_SPEED1000_ON		BIT(6)
-#define QCA808X_LED_SPEED100_ON			BIT(5)
-#define QCA808X_LED_SPEED10_ON			BIT(4)
-#define QCA808X_LED_COLLISION_BLINK		BIT(3)
-#define QCA808X_LED_SPEED1000_BLINK		BIT(2)
-#define QCA808X_LED_SPEED100_BLINK		BIT(1)
-#define QCA808X_LED_SPEED10_BLINK		BIT(0)
-
 #define QCA808X_MMD7_LED0_FORCE_CTRL		0x8079
 #define QCA808X_MMD7_LED_FORCE_CTRL(x)		(0x8079 - ((x) * 2))
 
-/* LED force ctrl is the same for every LED
- * No documentation exist for this, not even internal one
- * with NDA as QCOM gives only info about configuring
- * hw control pattern rules and doesn't indicate any way
- * to force the LED to specific mode.
- * These define comes from reverse and testing and maybe
- * lack of some info or some info are not entirely correct.
- * For the basic LED control and hw control these finding
- * are enough to support LED control in all the required APIs.
- *
- * On doing some comparison with implementation with qca807x,
- * it was found that it's 1:1 equal to it and confirms all the
- * reverse done. It was also found further specification with the
- * force mode and the blink modes.
- */
-#define QCA808X_LED_FORCE_EN			BIT(15)
-#define QCA808X_LED_FORCE_MODE_MASK		GENMASK(14, 13)
-#define QCA808X_LED_FORCE_BLINK_1		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x3)
-#define QCA808X_LED_FORCE_BLINK_2		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x2)
-#define QCA808X_LED_FORCE_ON			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x1)
-#define QCA808X_LED_FORCE_OFF			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x0)
-
 #define QCA808X_MMD7_LED_POLARITY_CTRL		0x901a
 /* QSDK sets by default 0x46 to this reg that sets BIT 6 for
  * LED to active high. It's not clear what BIT 3 and BIT 4 does.
@@ -492,9 +427,7 @@ static int qca808x_led_hw_control_enable(struct phy_device *phydev, u8 index)
 		return -EINVAL;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
-				  QCA808X_LED_FORCE_EN);
+	return qca808x_led_reg_hw_control_enable(phydev, reg);
 }
 
 static int qca808x_led_hw_is_supported(struct phy_device *phydev, u8 index,
@@ -535,16 +468,12 @@ static int qca808x_led_hw_control_set(struct phy_device *phydev, u8 index,
 static bool qca808x_led_hw_control_status(struct phy_device *phydev, u8 index)
 {
 	u16 reg;
-	int val;
 
 	if (index > 2)
 		return false;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
-
-	return !(val & QCA808X_LED_FORCE_EN);
+	return qca808x_led_reg_hw_control_status(phydev, reg);
 }
 
 static int qca808x_led_hw_control_get(struct phy_device *phydev, u8 index,
@@ -590,8 +519,7 @@ static int qca808x_led_hw_control_reset(struct phy_device *phydev, u8 index)
 	if (index > 2)
 		return -EINVAL;
 
-	reg = QCA808X_MMD7_LED_CTRL(index);
-
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
 	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
 				  QCA808X_LED_PATTERN_MASK);
 }
@@ -612,44 +540,20 @@ static int qca808x_led_brightness_set(struct phy_device *phydev,
 	}
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
-			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
-			      QCA808X_LED_FORCE_EN | value ? QCA808X_LED_FORCE_ON :
-							     QCA808X_LED_FORCE_OFF);
+	return qca808x_led_reg_brightness_set(phydev, reg, value);
 }
 
 static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
 				 unsigned long *delay_on,
 				 unsigned long *delay_off)
 {
-	int ret;
 	u16 reg;
 
 	if (index > 2)
 		return -EINVAL;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	/* Set blink to 50% off, 50% on at 4Hz by default */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
-			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
-			     QCA808X_LED_BLINK_FREQ_4HZ | QCA808X_LED_BLINK_DUTY_50_50);
-	if (ret)
-		return ret;
-
-	/* We use BLINK_1 for normal blinking */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
-			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
-			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_BLINK_1);
-	if (ret)
-		return ret;
-
-	/* We set blink to 4Hz, aka 250ms */
-	*delay_on = 250 / 2;
-	*delay_off = 250 / 2;
-
-	return 0;
+	return qca808x_led_reg_blink_set(phydev, reg, delay_on, delay_off);
 }
 
 static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
index 786bfc39912c..d28815ef56bb 100644
--- a/drivers/net/phy/qcom/qcom-phy-lib.c
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -620,3 +620,57 @@ int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qca808x_cable_test_get_status);
+
+int qca808x_led_reg_hw_control_enable(struct phy_device *phydev, u16 reg)
+{
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
+				  QCA808X_LED_FORCE_EN);
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_hw_control_enable);
+
+bool qca808x_led_reg_hw_control_status(struct phy_device *phydev, u16 reg)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	return !(val & QCA808X_LED_FORCE_EN);
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_hw_control_status);
+
+int qca808x_led_reg_brightness_set(struct phy_device *phydev,
+				   u16 reg, enum led_brightness value)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
+			      QCA808X_LED_FORCE_EN | (value ? QCA808X_LED_FORCE_ON :
+							      QCA808X_LED_FORCE_OFF));
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_brightness_set);
+
+int qca808x_led_reg_blink_set(struct phy_device *phydev, u16 reg,
+			      unsigned long *delay_on,
+			      unsigned long *delay_off)
+{
+	int ret;
+
+	/* Set blink to 50% off, 50% on at 4Hz by default */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
+			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
+			     QCA808X_LED_BLINK_FREQ_4HZ | QCA808X_LED_BLINK_DUTY_50_50);
+	if (ret)
+		return ret;
+
+	/* We use BLINK_1 for normal blinking */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
+			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_BLINK_1);
+	if (ret)
+		return ret;
+
+	/* We set blink to 4Hz, aka 250ms */
+	*delay_on = 250 / 2;
+	*delay_off = 250 / 2;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_blink_set);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index dc259bbf0678..4bb541728846 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -103,6 +103,71 @@
 /* Added for reference of existence but should be handled by wait_for_completion already */
 #define QCA808X_CDT_STATUS_STAT_BUSY		(BIT(1) | BIT(3))
 
+#define QCA808X_MMD7_LED_GLOBAL			0x8073
+#define QCA808X_LED_BLINK_1			GENMASK(11, 6)
+#define QCA808X_LED_BLINK_2			GENMASK(5, 0)
+/* Values are the same for both BLINK_1 and BLINK_2 */
+#define QCA808X_LED_BLINK_FREQ_MASK		GENMASK(5, 3)
+#define QCA808X_LED_BLINK_FREQ_2HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x0)
+#define QCA808X_LED_BLINK_FREQ_4HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x1)
+#define QCA808X_LED_BLINK_FREQ_8HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x2)
+#define QCA808X_LED_BLINK_FREQ_16HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x3)
+#define QCA808X_LED_BLINK_FREQ_32HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x4)
+#define QCA808X_LED_BLINK_FREQ_64HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x5)
+#define QCA808X_LED_BLINK_FREQ_128HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x6)
+#define QCA808X_LED_BLINK_FREQ_256HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x7)
+#define QCA808X_LED_BLINK_DUTY_MASK		GENMASK(2, 0)
+#define QCA808X_LED_BLINK_DUTY_50_50		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x0)
+#define QCA808X_LED_BLINK_DUTY_75_25		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x1)
+#define QCA808X_LED_BLINK_DUTY_25_75		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x2)
+#define QCA808X_LED_BLINK_DUTY_33_67		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x3)
+#define QCA808X_LED_BLINK_DUTY_67_33		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x4)
+#define QCA808X_LED_BLINK_DUTY_17_83		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x5)
+#define QCA808X_LED_BLINK_DUTY_83_17		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x6)
+#define QCA808X_LED_BLINK_DUTY_8_92		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x7)
+
+/* LED hw control pattern is the same for every LED */
+#define QCA808X_LED_PATTERN_MASK		GENMASK(15, 0)
+#define QCA808X_LED_SPEED2500_ON		BIT(15)
+#define QCA808X_LED_SPEED2500_BLINK		BIT(14)
+/* Follow blink trigger even if duplex or speed condition doesn't match */
+#define QCA808X_LED_BLINK_CHECK_BYPASS		BIT(13)
+#define QCA808X_LED_FULL_DUPLEX_ON		BIT(12)
+#define QCA808X_LED_HALF_DUPLEX_ON		BIT(11)
+#define QCA808X_LED_TX_BLINK			BIT(10)
+#define QCA808X_LED_RX_BLINK			BIT(9)
+#define QCA808X_LED_TX_ON_10MS			BIT(8)
+#define QCA808X_LED_RX_ON_10MS			BIT(7)
+#define QCA808X_LED_SPEED1000_ON		BIT(6)
+#define QCA808X_LED_SPEED100_ON			BIT(5)
+#define QCA808X_LED_SPEED10_ON			BIT(4)
+#define QCA808X_LED_COLLISION_BLINK		BIT(3)
+#define QCA808X_LED_SPEED1000_BLINK		BIT(2)
+#define QCA808X_LED_SPEED100_BLINK		BIT(1)
+#define QCA808X_LED_SPEED10_BLINK		BIT(0)
+
+/* LED force ctrl is the same for every LED
+ * No documentation exist for this, not even internal one
+ * with NDA as QCOM gives only info about configuring
+ * hw control pattern rules and doesn't indicate any way
+ * to force the LED to specific mode.
+ * These define comes from reverse and testing and maybe
+ * lack of some info or some info are not entirely correct.
+ * For the basic LED control and hw control these finding
+ * are enough to support LED control in all the required APIs.
+ *
+ * On doing some comparison with implementation with qca807x,
+ * it was found that it's 1:1 equal to it and confirms all the
+ * reverse done. It was also found further specification with the
+ * force mode and the blink modes.
+ */
+#define QCA808X_LED_FORCE_EN			BIT(15)
+#define QCA808X_LED_FORCE_MODE_MASK		GENMASK(14, 13)
+#define QCA808X_LED_FORCE_BLINK_1		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x3)
+#define QCA808X_LED_FORCE_BLINK_2		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x2)
+#define QCA808X_LED_FORCE_ON			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x1)
+#define QCA808X_LED_FORCE_OFF			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x0)
+
 #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
 #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
 #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
@@ -169,3 +234,10 @@ int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start);
 int at803x_cdt_wait_for_completion(struct phy_device *phydev,
 				   u32 cdt_en);
 int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished);
+int qca808x_led_reg_hw_control_enable(struct phy_device *phydev, u16 reg);
+bool qca808x_led_reg_hw_control_status(struct phy_device *phydev, u16 reg);
+int qca808x_led_reg_brightness_set(struct phy_device *phydev,
+				   u16 reg, enum led_brightness value);
+int qca808x_led_reg_blink_set(struct phy_device *phydev, u16 reg,
+			      unsigned long *delay_on,
+			      unsigned long *delay_off);
-- 
2.43.0


