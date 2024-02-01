Return-Path: <linux-kernel+bounces-48381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B1845B43
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD20B2A181
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF718161B46;
	Thu,  1 Feb 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YArPVWH0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA49E15F307;
	Thu,  1 Feb 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800711; cv=none; b=ZtiDR3vLWxkR5lYBU3QZH1zbrM8Fjad6ftx22uEwjjraXTZkgFDlY1KnYYsUATXvpEcmR1PQcQpJshK7dNJAeGUiJj7gWhS4qogvaT4CBHk12Lx6RPQV90zsRUpDRIhQOw9ccomic2c8wTsnSOBhtbpqiKJRgXjFQXfwKfFUwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800711; c=relaxed/simple;
	bh=9Fpg05V5vDXI66UtCQ/kLPfCuXJ4N6Z3mWRCyN1ldak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRj2d96fblaTnd9caV+W/mcfqBItLHhuYhHRBch0HIC7f4jcU0n2fVUVuKQ36KZao29x0H/HjHtX9svm+uGHDdv/nSmeNQCz6SlmX1qlukDi/Q0Wf6wVSQz/XRx6ujCzjShB/eXotC3CBtUrcHC5zuaspJ4obsrH98t0NKpNt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YArPVWH0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d07b400bb8so7503261fa.2;
        Thu, 01 Feb 2024 07:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800706; x=1707405506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdjUudevVvMDYPb/PMYBwKA6QYqHitGHaVtZelKu0LA=;
        b=YArPVWH0FqHM05uMLEvvG33t8woayfg8INM8BUIrzZT+wsfyjZcjWbbUPIDJ0etNuc
         KfU10x21RR1G/IAa6kiTaHMDhzJ9LA7sO0iSZAg3brBjdwel3JlNtlIAMKVSDqMjQMo0
         lZAEU447cbPQrwb7c/E/bnrTf4Ik8Qu8E9m91hfgcvUBC5Fb36hYsIIFKh4b96g0NxAB
         nHkt6+/53CihyFDW+Zmh1+5xjPXlx/wh7deSzHd7SqYrihFHky9PpkRWl7d5oKyOgN7E
         vvroS4z6SC3VhV1JBBzTdBdiU7Flhz28kay71VntFM8JFWKEl6oD3YsCoL1Zh3Aa57Fx
         Zjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800706; x=1707405506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdjUudevVvMDYPb/PMYBwKA6QYqHitGHaVtZelKu0LA=;
        b=hCZZlD0UOFJuxNmtNf2oqhu6/GMZp68mUgWAU1e8wS5ty9bkq5C9tv2Tys4QGjELGd
         GUi3Yxg9tb5eozTOcUEko5JeFrvxXjK6drKYIzxCiQEk/fn+kUdMvY/dgQptvHnWrmf/
         Rh0plHvmpihkA/ATVeU8QdPQtYCSB7F/tt+WdsATsbAfNMByrsEyVahShNfQHxFv1XD3
         Tq2DpbuaeuwdxN79HH22HoCM2EO080OeOSe10Du5uDzqf0XmTKzc0sMF5HmBlNNjQrBE
         P1MTO/XEkt6Y6luUjftfPMS9F/3E57x1GbehAP3d5e11Byjb51pl4/eU5gqjoDFYcBMZ
         u6VA==
X-Gm-Message-State: AOJu0YzddtrQuCUYOX2XwTzN470KZpx2ENyB+SQPw8rRbHOmwHaKGPrg
	9WT2VfnwXfkABqKOr8jstbcZ50NxKYBZC43tXG2j+tIh5bg695mP
X-Google-Smtp-Source: AGHT+IH/8WMddGSimQDIoodNsvvoOP6RVbEpyKoa76Mp7nCGx4kgCL5Y58RNZsmg/E9rpQ2vA5SasA==
X-Received: by 2002:a05:651c:8c:b0:2d0:5c9e:da73 with SMTP id 12-20020a05651c008c00b002d05c9eda73mr1685518ljq.1.1706800705562;
        Thu, 01 Feb 2024 07:18:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUckalvDW+elKLdnGfsHfFw1TBBi/pMSKwPYiL1IAaVwi4tGZqs5OCqiUbMlL6CWRfo5SLHeCN/9cjyE8W/GU50t4qY3clh1noTSL+yhmaeA4yVFzhgEH+9NlwMK55n+YODacc5CARON8656ah4qojsqAk6hf1gWHgcLqu4B3sE4zCYrLNGTZsBAb8OiI1KaojeA4oXSg96q1+zfu2isdtPWE0nAU+HZ8OBNNGp+8xYJa4ENl3WPq0F2+bnazLYFgtpQ1Di8FmXgnshjNglgNxg9Uvog5NKgrZIBi15+74Fy8nrjPo9WjqtyQaJCtu0+FLPhySbuX2kxYgd0SIqKgbqY2Y5yLpKna5z4oijiyQXWlchuLDsumCNX+vic39FPD97XwbdFG0ALPEqk7/S8i0FPAOhX+EsOnFcKu+kpKdwL1MYyzjC+lvIKUcAwFlPlZWu7/zkWxduqXLfKYfJ2Tmi9uuaqdBFnLAW0wSR+g6xX4QY6BR94ETi/qvSE1EE12+l4qGxGsMtow4EdSvaMm6xXeO5QaB6CHGWjp1G6EXPZHP6cfton+EL6iHClqJToCUxcCCmafbXluf3KVqxNY1QNa81CiGLzl7UA3p2fOf24jaU9/s2WTLs
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:25 -0800 (PST)
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
Subject: [net-next PATCH v5 7/9] net: phy: qcom: add support for QCA807x PHY Family
Date: Thu,  1 Feb 2024 16:17:33 +0100
Message-ID: <20240201151747.7524-8-ansuelsmth@gmail.com>
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

From: Robert Marko <robert.marko@sartura.hr>

This adds driver for the Qualcomm QCA8072 and QCA8075 PHY-s.

They are 2 or 5 port IEEE 802.3 clause 22 compliant 10BASE-Te,
100BASE-TX and 1000BASE-T PHY-s.

They feature 2 SerDes, one for PSGMII or QSGMII connection with
MAC, while second one is SGMII for connection to MAC or fiber.

Both models have a combo port that supports 1000BASE-X and
100BASE-FX fiber.

PHY package can be configured in 3 mode following this table:

              First Serdes mode       Second Serdes mode
Option 1      PSGMII for copper       Disabled
              ports 0-4
Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
              ports 0-4
Option 3      QSGMII for copper       SGMII for
              ports 0-3               copper port 4

Each PHY inside of QCA807x series has 4 digitally controlled
output only pins that natively drive LED-s.
But some vendors used these to driver generic LED-s controlled
by userspace, so lets enable registering each PHY as GPIO
controller and add driver for it.

These are commonly used in Qualcomm IPQ40xx, IPQ60xx and IPQ807x
boards.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/Kconfig   |   8 +
 drivers/net/phy/qcom/Makefile  |   1 +
 drivers/net/phy/qcom/qca807x.c | 578 +++++++++++++++++++++++++++++++++
 3 files changed, 587 insertions(+)
 create mode 100644 drivers/net/phy/qcom/qca807x.c

diff --git a/drivers/net/phy/qcom/Kconfig b/drivers/net/phy/qcom/Kconfig
index 80db24deb689..570626cc8e14 100644
--- a/drivers/net/phy/qcom/Kconfig
+++ b/drivers/net/phy/qcom/Kconfig
@@ -20,3 +20,11 @@ config QCA808X_PHY
 	select QCOM_NET_PHYLIB
 	help
 	  Currently supports the QCA8081 model
+
+config QCA807X_PHY
+	tristate "Qualcomm QCA807x PHYs"
+	select QCOM_NET_PHYLIB
+	depends on OF_MDIO
+	help
+	  Currently supports the Qualcomm QCA8072, QCA8075 and the PSGMII
+	  control PHY.
diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
index 0362d7ed47be..f24fb550babd 100644
--- a/drivers/net/phy/qcom/Makefile
+++ b/drivers/net/phy/qcom/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_QCOM_NET_PHYLIB)	+= qcom-phy-lib.o
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
 obj-$(CONFIG_QCA83XX_PHY)	+= qca83xx.o
 obj-$(CONFIG_QCA808X_PHY)	+= qca808x.o
+obj-$(CONFIG_QCA807X_PHY)	+= qca807x.o
diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
new file mode 100644
index 000000000000..5ff6ba9fa1a0
--- /dev/null
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ *         Christian Marangi <ansuelsmth@gmail.com>
+ *
+ * Qualcomm QCA8072 and QCA8075 PHY driver
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/bitfield.h>
+#include <linux/gpio/driver.h>
+#include <linux/sfp.h>
+
+#include "qcom.h"
+
+#include <dt-bindings/net/qcom-qca807x.h>
+
+#define QCA807X_CHIP_CONFIGURATION				0x1f
+#define QCA807X_BT_BX_REG_SEL					BIT(15)
+#define QCA807X_BT_BX_REG_SEL_FIBER				0
+#define QCA807X_BT_BX_REG_SEL_COPPER				1
+#define QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK		GENMASK(3, 0)
+#define QCA807X_CHIP_CONFIGURATION_MODE_QSGMII_SGMII		4
+#define QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_FIBER		3
+#define QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_ALL_COPPER	0
+
+#define QCA807X_MEDIA_SELECT_STATUS				0x1a
+#define QCA807X_MEDIA_DETECTED_COPPER				BIT(5)
+#define QCA807X_MEDIA_DETECTED_1000_BASE_X			BIT(4)
+#define QCA807X_MEDIA_DETECTED_100_BASE_FX			BIT(3)
+
+#define QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION			0x807e
+#define QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION_EN		BIT(0)
+
+#define QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH	0x801a
+#define QCA807X_CONTROL_DAC_MASK				GENMASK(2, 0)
+
+#define QCA807X_MMD7_LED_100N_1				0x8074
+#define QCA807X_MMD7_LED_100N_2				0x8075
+#define QCA807X_MMD7_LED_1000N_1			0x8076
+#define QCA807X_MMD7_LED_1000N_2			0x8077
+
+#define QCA807X_MMD7_LED_CTRL(x)			(0x8074 + ((x) * 2))
+#define QCA807X_MMD7_LED_FORCE_CTRL(x)			(0x8075 + ((x) * 2))
+
+#define QCA807X_GPIO_FORCE_EN				BIT(15)
+#define QCA807X_GPIO_FORCE_MODE_MASK			GENMASK(14, 13)
+
+#define QCA807X_FUNCTION_CONTROL			0x10
+#define QCA807X_FC_MDI_CROSSOVER_MODE_MASK		GENMASK(6, 5)
+#define QCA807X_FC_MDI_CROSSOVER_AUTO			3
+#define QCA807X_FC_MDI_CROSSOVER_MANUAL_MDIX		1
+#define QCA807X_FC_MDI_CROSSOVER_MANUAL_MDI		0
+
+/* PQSGMII Analog PHY specific */
+#define PQSGMII_CTRL_REG				0x0
+#define PQSGMII_ANALOG_SW_RESET				BIT(6)
+#define PQSGMII_DRIVE_CONTROL_1				0xb
+#define PQSGMII_TX_DRIVER_MASK				GENMASK(7, 4)
+#define PQSGMII_TX_DRIVER_140MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x0)
+#define PQSGMII_TX_DRIVER_160MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x1)
+#define PQSGMII_TX_DRIVER_180MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x2)
+#define PQSGMII_TX_DRIVER_200MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x3)
+#define PQSGMII_TX_DRIVER_220MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x4)
+#define PQSGMII_TX_DRIVER_240MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x5)
+#define PQSGMII_TX_DRIVER_260MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x6)
+#define PQSGMII_TX_DRIVER_280MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x7)
+#define PQSGMII_TX_DRIVER_300MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x8)
+#define PQSGMII_TX_DRIVER_320MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x9)
+#define PQSGMII_TX_DRIVER_400MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0xa)
+#define PQSGMII_TX_DRIVER_500MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0xb)
+#define PQSGMII_TX_DRIVER_600MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0xc)
+#define PQSGMII_MODE_CTRL				0x6d
+#define PQSGMII_MODE_CTRL_AZ_WORKAROUND_MASK		BIT(0)
+#define PQSGMII_MMD3_SERDES_CONTROL			0x805a
+
+#define PHY_ID_QCA8072		0x004dd0b2
+#define PHY_ID_QCA8075		0x004dd0b1
+
+#define QCA807X_COMBO_ADDR_OFFSET			4
+#define QCA807X_PQSGMII_ADDR_OFFSET			5
+#define SERDES_RESET_SLEEP				100
+
+enum qca807x_global_phy {
+	QCA807X_COMBO_ADDR = 4,
+	QCA807X_PQSGMII_ADDR = 5,
+};
+
+struct qca807x_shared_priv {
+	unsigned int package_mode;
+	u32 tx_driver_strength;
+};
+
+struct qca807x_gpio_priv {
+	struct phy_device *phy;
+};
+
+static int qca807x_cable_test_start(struct phy_device *phydev)
+{
+	/* we do all the (time consuming) work later */
+	return 0;
+}
+
+#ifdef CONFIG_GPIOLIB
+static int qca807x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int qca807x_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
+	u16 reg;
+	int val;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(offset);
+	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, reg);
+
+	return FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
+}
+
+static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
+	u16 reg;
+	int val;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(offset);
+
+	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, reg);
+	val &= ~QCA807X_GPIO_FORCE_MODE_MASK;
+	val |= QCA807X_GPIO_FORCE_EN;
+	val |= FIELD_PREP(QCA807X_GPIO_FORCE_MODE_MASK, value);
+
+	phy_write_mmd(priv->phy, MDIO_MMD_AN, reg, val);
+}
+
+static int qca807x_gpio_dir_out(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	qca807x_gpio_set(gc, offset, value);
+
+	return 0;
+}
+
+static int qca807x_gpio(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct qca807x_gpio_priv *priv;
+	struct gpio_chip *gc;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->phy = phydev;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->label = dev_name(dev);
+	gc->base = -1;
+	gc->ngpio = 2;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
+	gc->can_sleep = true;
+	gc->get_direction = qca807x_gpio_get_direction;
+	gc->direction_output = qca807x_gpio_dir_out;
+	gc->get = qca807x_gpio_get;
+	gc->set = qca807x_gpio_set;
+
+	return devm_gpiochip_add_data(dev, gc, priv);
+}
+#endif
+
+static int qca807x_read_fiber_status(struct phy_device *phydev)
+{
+	int ss, err, lpa, old_link = phydev->link;
+
+	/* Update the link, but return if there was an error */
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+		lpa = phy_read(phydev, MII_LPA);
+		if (lpa < 0)
+			return lpa;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 phydev->lp_advertising, lpa & LPA_LPACK);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				 phydev->lp_advertising, lpa & LPA_1000XFULL);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 phydev->lp_advertising, lpa & LPA_1000XPAUSE);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 phydev->lp_advertising,
+				 lpa & LPA_1000XPAUSE_ASYM);
+
+		phy_resolve_aneg_linkmode(phydev);
+	}
+
+	/* Read the QCA807x PHY-Specific Status register fiber page,
+	 * which indicates the speed and duplex that the PHY is actually
+	 * using, irrespective of whether we are in autoneg mode or not.
+	 */
+	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
+	if (ss < 0)
+		return ss;
+
+	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
+		switch (FIELD_GET(AT803X_SS_SPEED_MASK, ss)) {
+		case AT803X_SS_SPEED_100:
+			phydev->speed = SPEED_100;
+			break;
+		case AT803X_SS_SPEED_1000:
+			phydev->speed = SPEED_1000;
+			break;
+		}
+
+		if (ss & AT803X_SS_DUPLEX)
+			phydev->duplex = DUPLEX_FULL;
+		else
+			phydev->duplex = DUPLEX_HALF;
+	}
+
+	return 0;
+}
+
+static int qca807x_read_status(struct phy_device *phydev)
+{
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported)) {
+		switch (phydev->port) {
+		case PORT_FIBRE:
+			return qca807x_read_fiber_status(phydev);
+		case PORT_TP:
+			return at803x_read_status(phydev);
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return at803x_read_status(phydev);
+}
+
+static int qca807x_phy_package_probe_once(struct phy_device *phydev)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct qca807x_shared_priv *priv = shared->priv;
+	unsigned int tx_driver_strength = 0;
+	const char *package_mode_name;
+
+	of_property_read_u32(shared->np, "qcom,tx-driver-strength",
+			     &tx_driver_strength);
+	switch (tx_driver_strength) {
+	case 140:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_140MV;
+		break;
+	case 160:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_160MV;
+		break;
+	case 180:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_180MV;
+		break;
+	case 200:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_200MV;
+		break;
+	case 220:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_220MV;
+		break;
+	case 240:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_240MV;
+		break;
+	case 260:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_260MV;
+		break;
+	case 280:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_280MV;
+		break;
+	case 300:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_300MV;
+		break;
+	case 320:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_320MV;
+		break;
+	case 400:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_400MV;
+		break;
+	case 500:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_500MV;
+		break;
+	case 600:
+	default:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_600MV;
+	}
+
+	priv->package_mode = PHY_INTERFACE_MODE_NA;
+	if (!of_property_read_string(shared->np, "qcom,package-mode",
+				     &package_mode_name)) {
+		if (!strcasecmp(package_mode_name,
+				phy_modes(PHY_INTERFACE_MODE_PSGMII)))
+			priv->package_mode = PHY_INTERFACE_MODE_PSGMII;
+
+		if (!strcasecmp(package_mode_name,
+				phy_modes(PHY_INTERFACE_MODE_QSGMII)))
+			priv->package_mode = PHY_INTERFACE_MODE_QSGMII;
+	}
+
+	return 0;
+}
+
+static int qca807x_phy_package_config_init_once(struct phy_device *phydev)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct qca807x_shared_priv *priv = shared->priv;
+	int val, ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	/* Set correct PHY package mode */
+	val = __phy_package_read(phydev, QCA807X_COMBO_ADDR,
+				 QCA807X_CHIP_CONFIGURATION);
+	val &= ~QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK;
+	if (priv->package_mode == PHY_INTERFACE_MODE_QSGMII)
+		val |= QCA807X_CHIP_CONFIGURATION_MODE_QSGMII_SGMII;
+	else
+		val |= QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_ALL_COPPER;
+	ret = __phy_package_write(phydev, QCA807X_COMBO_ADDR,
+				  QCA807X_CHIP_CONFIGURATION, val);
+	if (ret)
+		goto exit;
+
+	/* After mode change Serdes reset is required */
+	val = __phy_package_read(phydev, QCA807X_PQSGMII_ADDR,
+				 PQSGMII_CTRL_REG);
+	val &= ~PQSGMII_ANALOG_SW_RESET;
+	ret = __phy_package_write(phydev, QCA807X_PQSGMII_ADDR,
+				  PQSGMII_CTRL_REG, val);
+	if (ret)
+		goto exit;
+
+	msleep(SERDES_RESET_SLEEP);
+
+	val = __phy_package_read(phydev, QCA807X_PQSGMII_ADDR,
+				 PQSGMII_CTRL_REG);
+	val |= PQSGMII_ANALOG_SW_RESET;
+	ret = __phy_package_write(phydev, QCA807X_PQSGMII_ADDR,
+				  PQSGMII_CTRL_REG, val);
+	if (ret)
+		goto exit;
+
+	/* Workaround to enable AZ transmitting ability */
+	val = __phy_package_read_mmd(phydev, QCA807X_PQSGMII_ADDR,
+				     MDIO_MMD_PMAPMD, PQSGMII_MODE_CTRL);
+	val &= ~PQSGMII_MODE_CTRL_AZ_WORKAROUND_MASK;
+	ret = __phy_package_write_mmd(phydev, QCA807X_PQSGMII_ADDR,
+				      MDIO_MMD_PMAPMD, PQSGMII_MODE_CTRL, val);
+	if (ret)
+		goto exit;
+
+	/* Set PQSGMII TX AMP strength */
+	val = __phy_package_read(phydev, QCA807X_PQSGMII_ADDR,
+				 PQSGMII_DRIVE_CONTROL_1);
+	val &= ~PQSGMII_TX_DRIVER_MASK;
+	val |= FIELD_PREP(PQSGMII_TX_DRIVER_MASK, priv->tx_driver_strength);
+	ret = __phy_package_write(phydev, QCA807X_PQSGMII_ADDR,
+				  PQSGMII_DRIVE_CONTROL_1, val);
+	if (ret)
+		goto exit;
+
+	/* Prevent PSGMII going into hibernation via PSGMII self test */
+	val = __phy_package_read_mmd(phydev, QCA807X_COMBO_ADDR,
+				     MDIO_MMD_PCS, PQSGMII_MMD3_SERDES_CONTROL);
+	val &= ~BIT(1);
+	ret = __phy_package_write_mmd(phydev, QCA807X_COMBO_ADDR,
+				      MDIO_MMD_PCS, PQSGMII_MMD3_SERDES_CONTROL, val);
+
+exit:
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+static int qca807x_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+{
+	struct phy_device *phydev = upstream;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(support) = { 0, };
+	phy_interface_t iface;
+	int ret;
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+
+	sfp_parse_support(phydev->sfp_bus, id, support, interfaces);
+	iface = sfp_select_interface(phydev->sfp_bus, support);
+
+	dev_info(&phydev->mdio.dev, "%s SFP module inserted\n", phy_modes(iface));
+
+	switch (iface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_100BASEX:
+		/* Set PHY mode to PSGMII combo (1/4 copper + combo ports) mode */
+		ret = phy_modify(phydev,
+				 QCA807X_CHIP_CONFIGURATION,
+				 QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK,
+				 QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_FIBER);
+		/* Enable fiber mode autodection (1000Base-X or 100Base-FX) */
+		ret = phy_set_bits_mmd(phydev,
+				       MDIO_MMD_AN,
+				       QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION,
+				       QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION_EN);
+		/* Select fiber page */
+		ret = phy_clear_bits(phydev,
+				     QCA807X_CHIP_CONFIGURATION,
+				     QCA807X_BT_BX_REG_SEL);
+
+		phydev->port = PORT_FIBRE;
+		break;
+	default:
+		dev_err(&phydev->mdio.dev, "Incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static void qca807x_sfp_remove(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+
+	/* Select copper page */
+	phy_set_bits(phydev,
+		     QCA807X_CHIP_CONFIGURATION,
+		     QCA807X_BT_BX_REG_SEL);
+
+	phydev->port = PORT_TP;
+}
+
+static const struct sfp_upstream_ops qca807x_sfp_ops = {
+	.attach = phy_sfp_attach,
+	.detach = phy_sfp_detach,
+	.module_insert = qca807x_sfp_insert,
+	.module_remove = qca807x_sfp_remove,
+};
+
+static int qca807x_probe(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct qca807x_shared_priv *shared_priv;
+	struct phy_package_shared *shared;
+	int ret;
+
+	ret = devm_of_phy_package_join(&phydev->mdio.dev, phydev,
+				       sizeof(*shared_priv));
+	if (ret)
+		return ret;
+
+	if (phy_package_probe_once(phydev)) {
+		ret = qca807x_phy_package_probe_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	shared = phydev->shared;
+	shared_priv = shared->priv;
+
+	/* Make sure PHY follow PHY package mode if enforced */
+	if (shared_priv->package_mode != PHY_INTERFACE_MODE_NA &&
+	    phydev->interface != shared_priv->package_mode)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_GPIOLIB)) {
+		/* Do not register a GPIO controller unless flagged for it */
+		if (of_property_read_bool(node, "gpio-controller")) {
+			ret = qca807x_gpio(phydev);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Attach SFP bus on combo port*/
+	if (phy_read(phydev, QCA807X_CHIP_CONFIGURATION)) {
+		ret = phy_sfp_probe(phydev, &qca807x_sfp_ops);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->advertising);
+	}
+
+	return ret;
+}
+
+static int qca807x_config_init(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	int control_dac, ret;
+	u32 of_control_dac;
+
+	if (phy_package_init_once(phydev)) {
+		ret = qca807x_phy_package_config_init_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	if (of_property_read_u32(node, "qcom,control-dac", &of_control_dac))
+		of_control_dac = QCA807X_CONTROL_DAC_DSP_VOLT_QUARTER_BIAS;
+
+	control_dac = phy_read_mmd(phydev, MDIO_MMD_AN,
+				   QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH);
+	control_dac &= ~QCA807X_CONTROL_DAC_MASK;
+	control_dac |= FIELD_PREP(QCA807X_CONTROL_DAC_MASK, of_control_dac);
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN,
+			    QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH,
+			    control_dac);
+
+	return ret;
+}
+
+static struct phy_driver qca807x_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_QCA8072),
+		.name           = "Qualcomm QCA8072",
+		.flags		= PHY_POLL_CABLE_TEST,
+		/* PHY_GBIT_FEATURES */
+		.probe		= qca807x_probe,
+		.config_init	= qca807x_config_init,
+		.read_status	= qca807x_read_status,
+		.config_intr	= at803x_config_intr,
+		.handle_interrupt = at803x_handle_interrupt,
+		.soft_reset	= genphy_soft_reset,
+		.get_tunable	= at803x_get_tunable,
+		.set_tunable	= at803x_set_tunable,
+		.resume		= genphy_resume,
+		.suspend	= genphy_suspend,
+		.cable_test_start	= qca807x_cable_test_start,
+		.cable_test_get_status	= qca808x_cable_test_get_status,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_QCA8075),
+		.name           = "Qualcomm QCA8075",
+		.flags		= PHY_POLL_CABLE_TEST,
+		/* PHY_GBIT_FEATURES */
+		.probe		= qca807x_probe,
+		.config_init	= qca807x_config_init,
+		.read_status	= qca807x_read_status,
+		.config_intr	= at803x_config_intr,
+		.handle_interrupt = at803x_handle_interrupt,
+		.soft_reset	= genphy_soft_reset,
+		.get_tunable	= at803x_get_tunable,
+		.set_tunable	= at803x_set_tunable,
+		.resume		= genphy_resume,
+		.suspend	= genphy_suspend,
+		.cable_test_start	= qca807x_cable_test_start,
+		.cable_test_get_status	= qca808x_cable_test_get_status,
+	},
+};
+module_phy_driver(qca807x_drivers);
+
+static struct mdio_device_id __maybe_unused qca807x_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(PHY_ID_QCA8072) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_QCA8075) },
+	{ }
+};
+
+MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Qualcomm QCA807x PHY driver");
+MODULE_DEVICE_TABLE(mdio, qca807x_tbl);
+MODULE_LICENSE("GPL");
-- 
2.43.0


