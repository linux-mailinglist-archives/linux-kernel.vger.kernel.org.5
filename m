Return-Path: <linux-kernel+bounces-14720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1B82212B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B29281263
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6720168A4;
	Tue,  2 Jan 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl+zbLHj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0B16415;
	Tue,  2 Jan 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so102786635e9.1;
        Tue, 02 Jan 2024 10:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220737; x=1704825537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQabVWmpmoZU8yQyfqwraJ/6CaCvr56KIOoajwAPETc=;
        b=hl+zbLHjAdt/xFJiZWhtH4kvtjRmCkhOVIjV6I8ntQQY5Al31vNRPg1yx1/OfA1KoC
         lpKWOJg3Ph3/nswHqIpI/lgtXZjJL9Zf9Ruk0TYxyRSdAHbpvwmQ54091Zqp6WBHl9Iu
         z01jTOLQ/5gZVFGWPalxKq0bHSJ+YhNde4A80oJ88fPyfntUteddrFEpAK+NY36sE292
         LiC6DeOPNti4Y/FQT3Oowo4aN6F0FbXM75Y7ZVGiihFRIwNqkwT/jqKIoezIDKhcUbxv
         d87xWaJyvwOlr3CArttjRiqnpVHsz1woRyEC/W4ahdBFovSm/VVsYSkCQzoMWFNBU2W4
         rjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220737; x=1704825537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQabVWmpmoZU8yQyfqwraJ/6CaCvr56KIOoajwAPETc=;
        b=DQ2/KnKP6jLoEjEmX9YDzXNXK23EK7FQw7Y95a61Vu83AQVEyqrCZjQaxFvowLEjs3
         zFE38jHE3ZNMD4XQMvMQNthMd9qIsR7tZXxcYvzXG/pA8nzDYM1OeiimCBZn+Lcn/vWW
         /BBrnaT5h2PsFKoe8Z/aK8cykn62McGuggr399oDXhhrgz+NjZtxk2YWAxFW3Zq7KuUB
         wp30zvRdkCRdCohT948UgSsE/OR1QVbNHOh7Yo/RPUOVJyJKVi39FNYISzv2wd9IfIhn
         fzrnoPSA2/59o12CqS3GllJszGVVrd7F/sF2O0RGo+1IKPmCV+5qVUP9iHOnZH+eMEjI
         E42A==
X-Gm-Message-State: AOJu0YxHmC0UhyvwKiYUHRCn0SWwAvaTrJ6rQ2vBC4mbc5QVsrHMbUzm
	6WM8N+rmn274+KsRZBF6YQHqrQXxFFo=
X-Google-Smtp-Source: AGHT+IGQC9+CQvDnBiBdOXBnI5j7MRwisqOyk1s/BOS7UyEMNf8U0uxdScgydq6ztUjR6kyzFqMFfw==
X-Received: by 2002:a05:600c:2201:b0:40d:35c9:7b6b with SMTP id z1-20020a05600c220100b0040d35c97b6bmr5341006wml.234.1704220736651;
        Tue, 02 Jan 2024 10:38:56 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id p15-20020a05600c468f00b0040d4e1393dcsm37963071wmo.20.2024.01.02.10.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:38:56 -0800 (PST)
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
Subject: [net-next PATCH v6 3/5] net: phy: add support for PHY LEDs polarity modes
Date: Tue,  2 Jan 2024 19:38:32 +0100
Message-ID: <20240102183835.5332-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102183835.5332-1-ansuelsmth@gmail.com>
References: <20240102183835.5332-1-ansuelsmth@gmail.com>
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


