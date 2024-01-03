Return-Path: <linux-kernel+bounces-16101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43C8238F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCF61F25D49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E8208A6;
	Wed,  3 Jan 2024 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxDse3hW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78C2030C;
	Wed,  3 Jan 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so5832835e9.1;
        Wed, 03 Jan 2024 15:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323098; x=1704927898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQabVWmpmoZU8yQyfqwraJ/6CaCvr56KIOoajwAPETc=;
        b=MxDse3hWvNUKQcWTfGWcSkDMqkngH3VYgZlEkZFrgbt3j0DjM7GDw9frQboyT0J+Yd
         dgmiaBUVUbkd2TVcbDpSE3RSYsCkONzFQknw3h8HPSfhlQBisLFjSHRW6Nzicnib9yub
         O2sKciBHGgW+Nl9Kfog29FxRm+0bU2QM1X3aiQZFHL3/b5O0IYibngSj60Mh0Na7SDlF
         yDtK0Cp4jKPKYPAh2Lvg7EiC20Nw5Ig+wN4/P4ebbdWXduwrnN7FPxUfXCajpny4hnKY
         PnkYDODkzCRKHR0WgUkzkER9+QC9stMg/moDGfypuv29zBlQVIneUIN3JTj0V7n7sLIw
         rD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323098; x=1704927898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQabVWmpmoZU8yQyfqwraJ/6CaCvr56KIOoajwAPETc=;
        b=bvt10lEgyAOt4AiA1GYk9NaOoAJL1X1AGa+yhgIE1Bd01ALU3IY/wL6j1wBQKxQ06F
         e2vn7SKIxSkuLBGuxAlhJS7rpHZPr+9desuG7AQ5Y9poLcO0sooBzyEweFFoBC8Vg2D+
         wgHcM7UQ9bQY5Qu/B7SN/ACB2Dyh1CrEB5Cp+Pa+GDijYnxRDVOi7uLnZoP5OhJY7ZBw
         G+RB1GPRLJpulmuCFYvhUmdF+mtKZeXTjpK7GAzJHr7/BjQNFBllBw8NaFPGT0MldC2w
         te07kPEnW4FOx3IZwTLZPv8lN3hnOdo3cpIU6niDuRLBAG6kueYtzHE+jyGq777OjMYV
         QFVA==
X-Gm-Message-State: AOJu0YzG+cwnobxcOc8K5L5hWMgbXj1AtA+nPdDLVnvsgjg3sbKNONxv
	aYNFUvbP7wcszHq3OacEkPA=
X-Google-Smtp-Source: AGHT+IEISrlEqHRrW/K5DonT/q6LvZTnvXJR8+etSCMcMD15Rp6nle4ldjMSNCtJ7gs908viVsaVuA==
X-Received: by 2002:a05:600c:2a4e:b0:40d:8f7a:9f9e with SMTP id x14-20020a05600c2a4e00b0040d8f7a9f9emr934834wme.73.1704323098376;
        Wed, 03 Jan 2024 15:04:58 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id w13-20020a05600c474d00b0040c46719966sm3740969wmo.25.2024.01.03.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:04:57 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [net-next PATCH v7 3/5] net: phy: add support for PHY LEDs polarity modes
Date: Wed,  3 Jan 2024 15:12:36 +0100
Message-ID: <20240103141251.23446-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103141251.23446-1-ansuelsmth@gmail.com>
References: <20240103141251.23446-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PHY LEDs polarity modes. Some PHY require LED to be set
to active low to be turned ON. Adds support for this by declaring
active-low property in DT.

PHY driver needs to declare .led_polarity_set() to configure LED
polarity modes. Function will pass the index with the LED index and a
bitmap with all the required modes to set.

Current supported modes are:
- active-low with the flag PHY_LED_ACTIVE_LOW. LED is set to active-low
  to turn it ON.
- inactive-high-impedance with the flag PHY_LED_INACTIVE_HIGH_IMPEDANCE.
  LED is set to high impedance to turn it OFF.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v5:
- Rework to LED modes bitmap
Changes v4:
- Drop for global active-low
- Rework to polarity option (for marvell10g series support)
Changes v3:
- Out of RFC
Changes v2:
- Add this patch

 drivers/net/phy/phy_device.c | 12 ++++++++++++
 include/linux/phy.h          | 22 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1e595762afea..437a1c6046ab 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3152,6 +3152,7 @@ static int of_phy_led(struct phy_device *phydev,
 	struct device *dev = &phydev->mdio.dev;
 	struct led_init_data init_data = {};
 	struct led_classdev *cdev;
+	unsigned long modes = 0;
 	struct phy_led *phyled;
 	u32 index;
 	int err;
@@ -3169,6 +3170,17 @@ static int of_phy_led(struct phy_device *phydev,
 	if (index > U8_MAX)
 		return -EINVAL;
 
+	if (phydev->drv->led_polarity_set) {
+		if (of_property_read_bool(led, "active-low"))
+			set_bit(PHY_LED_ACTIVE_LOW, &modes);
+		if (of_property_read_bool(led, "inactive-high-impedance"))
+			set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
+
+		err = phydev->drv->led_polarity_set(phydev, index, modes);
+		if (err)
+			return err;
+	}
+
 	phyled->index = index;
 	if (phydev->drv->led_brightness_set)
 		cdev->brightness_set_blocking = phy_led_set_brightness;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ac22b8e28a85..da0a15a6d638 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -860,6 +860,15 @@ struct phy_plca_status {
 	bool pst;
 };
 
+/* Modes for PHY LED configuration */
+enum phy_led_modes {
+	PHY_LED_ACTIVE_LOW = 0,
+	PHY_LED_INACTIVE_HIGH_IMPEDANCE = 1,
+
+	/* keep it last */
+	__PHY_LED_MODES_NUM,
+};
+
 /**
  * struct phy_led: An LED driven by the PHY
  *
@@ -1153,6 +1162,19 @@ struct phy_driver {
 	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
 				  unsigned long *rules);
 
+	/**
+	 * @led_polarity_set: Set the LED polarity if active low
+	 * @dev: PHY device which has the LED
+	 * @index: Which LED of the PHY device or -1
+	 * @modes: bitmap of LED polarity modes
+	 *
+	 * Configure LED with all the required polarity modes in @modes
+	 * to make it correctly turn ON or OFF.
+	 *
+	 * Returns 0, or an error code.
+	 */
+	int (*led_polarity_set)(struct phy_device *dev, int index,
+				unsigned long modes);
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.43.0


