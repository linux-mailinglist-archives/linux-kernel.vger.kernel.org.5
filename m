Return-Path: <linux-kernel+bounces-1904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D703981558F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F3B245A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E63C41212;
	Sat, 16 Dec 2023 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WexT5Hx+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720916FCC;
	Sat, 16 Dec 2023 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3363eba94ebso934945f8f.3;
        Fri, 15 Dec 2023 16:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702686188; x=1703290988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIXO+pxuufKHplD7mxtVHj98eE+3KzzT1cWSD2a1WH0=;
        b=WexT5Hx+2RHiSZhHk8+EQQjJe6NpR5tnISs8MFyVEWbhYASMuROqHepd4yGxrNcK0P
         yrsZ3GfzXEO6Tnrhz1It1T6PwWNJoPqGSTbUzYBP/Heybcin8HG9c05VYfsjshyQu3l5
         uySpj7yyLpTr6Eu+Rhr1Z3IaIyNNqodXh1wQ17l8gAgHqUbcyeK5o5NRGpq/Ep96LNrL
         zm1S+sAY7CW8/ueB+mco9rXnMllXSncg4nR8/VQAYOZnFQlGti2KBOxtyRB+fOTrh/ME
         ElJA7MhbdQQG6T0bNxkQnshTuOq4052bgS9QAq2oMqnvOBGG5+VJ5qhdcnQi9Q+GFa/0
         Suiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702686188; x=1703290988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIXO+pxuufKHplD7mxtVHj98eE+3KzzT1cWSD2a1WH0=;
        b=NrNs2Ybr1Z6/TKZyJOvAnCPkPuoSuVNEkC0CBJUVtoFEgEIvXv5ergw7BBfFltcIYO
         mZ1QTh/M9acolugpqGZ6FMgx050nEQONxo4nOhf3a9f08B7j4fvkG/DW0KIU3qziYQHT
         OXJx3rn5Lk9SDB7QaiDLXupAt0GLvrY8W6f71p+OtzUSO/gRV4Qjd2k6IOshTvE9R7n+
         l6/Rw50jRelOSM6s6CISvoJcSw3traWmRBQoru2L70iQzBQgO7+dEE9Tca+skti2prgW
         AFUvv381PkRyR0JGjJPmYG7b2inVTQxzRbw3HNJ+M19tt2xxEbsAfzu42kVhdWnso+Bu
         w0iQ==
X-Gm-Message-State: AOJu0YytedBfIXUO0CqC5VEFlRDtkbPNVrbo2AcMC0T1OO1pXI+QuNrI
	lsgzzATaCUICg1s8J5gPHUQ=
X-Google-Smtp-Source: AGHT+IGGNAwF5C6fAi5f5M65yoR5PxJ0HKMu6Cq+CQ7xlx3zvLT6xpkIECMzGkkpva+pqlaf2lKq6Q==
X-Received: by 2002:adf:fb07:0:b0:333:470f:cdf9 with SMTP id c7-20020adffb07000000b00333470fcdf9mr3190088wrr.93.1702686188487;
        Fri, 15 Dec 2023 16:23:08 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a15-20020a5d508f000000b0033330846e76sm1496191wrt.86.2023.12.15.16.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:23:08 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: [net-next PATCH v4 2/4] net: phy: add support for PHY LEDs polarity modes
Date: Fri, 15 Dec 2023 22:22:42 +0100
Message-Id: <20231215212244.1658-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215212244.1658-1-ansuelsmth@gmail.com>
References: <20231215212244.1658-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PHY LEDs polarity modes. Some device might require
special polarity mode for the LED to correctly work and those mode
doesn't reflect what the PHY sets by default.

An example is a PHY device that set LED to active high but the attached
LEDs require to be active low to correctly work (and turn on when
actually requested)

PHY driver needs to declare .led_polarity_set() to configure LED
polarity. Index of the LED is passed and the polarity mode in the enum.

If a polarity is not set in DT and .led_polarity_set() is declared,
PHY_LED_POLARITY_DEFAULT is passed as polarity mode to let the PHY
driver decide a default polarity mode for the attached LEDs.

This is needed for PHY that sets active high on reset and the common
configuration is LEDs with active low polarity.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Drop for global active-low
- Rework to polarity option (for marvell10g series support)
Changes v3:
- Out of RFC
Changes v2:
- Add this patch

 drivers/net/phy/phy_device.c | 45 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          | 25 ++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d8e9335d415c..b35b7a8717cc 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -43,6 +43,13 @@ MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
 
+static const char * const phy_led_polarity_mode_strings[] = {
+	[PHY_LED_POLARITY_ACTIVE_LOW] = "active-low",
+	[PHY_LED_POLARITY_ACTIVE_HIGH] = "active-high",
+	[PHY_LED_POLARITY_ACTIVE_LOW_TRISTATED] = "active-low-tristated",
+	[PHY_LED_POLARITY_ACTIVE_HIGH_TRISTATED] = "active-low-tristated",
+};
+
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_basic_features);
 
@@ -3086,6 +3093,40 @@ static void phy_leds_unregister(struct phy_device *phydev)
 	}
 }
 
+static int of_phy_set_led_polarity(struct phy_device *phydev,
+				   struct device_node *led, u32 index)
+{
+	const char *polarity_str;
+	int i, err;
+
+	err = of_property_read_string(led, "polarity", &polarity_str);
+	if (err) {
+		if (err != -EINVAL)
+			return err;
+
+		/* Nothing to do, polarity setting not supported */
+		if (!phydev->drv->led_polarity_set)
+			return 0;
+
+		/* Apply default polarity if supported */
+		return phydev->drv->led_polarity_set(phydev, index,
+						     PHY_LED_POLARITY_DEFAULT);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(phy_led_polarity_mode_strings); i++)
+		if (!strcmp(phy_led_polarity_mode_strings[i], polarity_str)) {
+			if (!phydev->drv->led_polarity_set) {
+				phydev_warn(phydev, "Ignoring LED polarity in DT. Setting polarity not supported\n");
+				return 0;
+			}
+
+			return phydev->drv->led_polarity_set(phydev, index, i);
+		}
+
+	/* Unknown polarity mode declared */
+	return -EINVAL;
+}
+
 static int of_phy_led(struct phy_device *phydev,
 		      struct device_node *led)
 {
@@ -3109,6 +3150,10 @@ static int of_phy_led(struct phy_device *phydev,
 	if (index > U8_MAX)
 		return -EINVAL;
 
+	err = of_phy_set_led_polarity(phydev, led, index);
+	if (err)
+		return err;
+
 	phyled->index = index;
 	if (phydev->drv->led_brightness_set)
 		cdev->brightness_set_blocking = phy_led_set_brightness;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6e7ebcc50b85..88ff4195bc4f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -852,6 +852,16 @@ struct phy_plca_status {
 	bool pst;
 };
 
+enum phy_led_polarity_modes {
+	PHY_LED_POLARITY_ACTIVE_LOW,
+	PHY_LED_POLARITY_ACTIVE_HIGH,
+	PHY_LED_POLARITY_ACTIVE_LOW_TRISTATED,
+	PHY_LED_POLARITY_ACTIVE_HIGH_TRISTATED,
+
+	/* PHY driver apply a default value */
+	PHY_LED_POLARITY_DEFAULT,
+};
+
 /**
  * struct phy_led: An LED driven by the PHY
  *
@@ -1145,6 +1155,21 @@ struct phy_driver {
 	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
 				  unsigned long *rules);
 
+	/**
+	 * @led_polarity_set: Set the LED polarity mode
+	 * @dev: PHY device which has the LED
+	 * @index: Which LED of the PHY device
+	 * @polarity_mode: LED polarity mode from enum
+	 *
+	 * Set PHY to requested LED polarity mode.
+	 *
+	 * If polarity mode PHY_LED_POLARITY_DEFAULT is passed,
+	 * PHY driver should apply a default LED polarity mode.
+	 *
+	 * Returns 0, or an error code.
+	 */
+	int (*led_polarity_set)(struct phy_device *dev, int index,
+				enum phy_led_polarity_modes polarity_mode);
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.40.1


