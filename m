Return-Path: <linux-kernel+bounces-11918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC981ED8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8109E1F22B73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B332E3F8;
	Wed, 27 Dec 2023 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSKj3xPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE22DF65;
	Wed, 27 Dec 2023 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3369ccb539aso3152890f8f.3;
        Wed, 27 Dec 2023 01:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703667791; x=1704272591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RraVKdn/3CtUzdc/GUkx4wIWX/WntChO7vtqlU3szKo=;
        b=CSKj3xPoe0b81auFzX5J5r8+gHDtSQ8bTLHyuTSByN5ubgk4ShJnW0WabScu/PWsoO
         GIk3e8M6h8tqtSwzHT5DkMWLqb7v9GuGAluLL5l2PNxuaGDmeqil1mJ00JKwRJCbBIGZ
         OR+5SXX+NRoES0dpjTKeUehHdrMTAKHvC0KK3Qq9DOnbVTEwuSaA+J1Ftj14XiW80b0A
         tgCb1bz++/sdlFb5Av23VYzsyDTElaOP8wFcaHZWfW7iQYlSe5cxgfGVjgM9aWlHNTFT
         4TIkzUJaThEh2f1ZQ8ZdX3FbltMnUH6fdmgyxiNiYguE0XU6YkyCOHcrHXnELhBBZp/C
         sdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667791; x=1704272591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RraVKdn/3CtUzdc/GUkx4wIWX/WntChO7vtqlU3szKo=;
        b=Utekqe3RvOZRy4FiOZ021MFtCa8PqQavCkRm0r6I0K9mFt0Ss1697CKj59sVA6UR3R
         bFsxF3EIHuf083Bb0oinvkQxTndhtqyHqqthoOj0h5bwTOzBqIu4+3uCqVMhDeHD+ntr
         FpK8w1r95gF9jjtfzmvQPCaoPJ8Pmx1WCw/krOCeJh4MSTENJbAPRoyhLQ7Isy/cLTa6
         lK+0v3GcXlB1/rzakB2ZWO00GW+XpSctFmV4PoBUwHA3L18KbYZacMIDa4sRG8fTF3Wq
         s/Fi9iK6GhjzuEMVJ3UAUoqSJgEe0RtcVutl3eboY0nct1teXH0jom81X5rItjWXxfkL
         auug==
X-Gm-Message-State: AOJu0Yxgtqs1jrnvd57Y/+0b+O8ZeUJ0kYDUCyby5lHURF8bzwkTNA4Z
	UsNg0pmlma1uzwoUzIgQb48=
X-Google-Smtp-Source: AGHT+IHzsOs4p8HP8d1yYaPv2Nuxy0oYAJxlZLFgEmeJWBl/k5eA1TsyrGHT0l7hkmB3olgSIFB2wA==
X-Received: by 2002:a05:6000:1042:b0:336:73d6:b42b with SMTP id c2-20020a056000104200b0033673d6b42bmr4549978wrx.117.1703667791035;
        Wed, 27 Dec 2023 01:03:11 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056000104900b003368849129dsm13616525wrx.15.2023.12.27.01.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:03:10 -0800 (PST)
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
Subject: [net-next PATCH v5 3/5] net: phy: add support for PHY LEDs polarity modes
Date: Wed, 27 Dec 2023 10:02:29 +0100
Message-Id: <20231227090231.4246-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227090231.4246-1-ansuelsmth@gmail.com>
References: <20231227090231.4246-1-ansuelsmth@gmail.com>
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
index 3611ea64875e..b99c7579d9c4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3097,6 +3097,7 @@ static int of_phy_led(struct phy_device *phydev,
 	struct device *dev = &phydev->mdio.dev;
 	struct led_init_data init_data = {};
 	struct led_classdev *cdev;
+	unsigned long modes = 0;
 	struct phy_led *phyled;
 	u32 index;
 	int err;
@@ -3114,6 +3115,17 @@ static int of_phy_led(struct phy_device *phydev,
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
index e9e85d347587..5ac54f9eee82 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -853,6 +853,15 @@ struct phy_plca_status {
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
@@ -1146,6 +1155,19 @@ struct phy_driver {
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
2.40.1


