Return-Path: <linux-kernel+bounces-39255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE8883CD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34DBB22D73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CCB13BE9D;
	Thu, 25 Jan 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am+JTu6/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3013AA54;
	Thu, 25 Jan 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215049; cv=none; b=d8cip9a+SM1d2ROkH9nQH3jAQJGeGa326pSMyhucxNKsWmsM3PP0EW9Y+153TM170blNts/0rlR1IsNkO3Fx41vgv4JvX346g8/yvqpJ2saNzMpUDqu+GNc1L2V50Qr1Ru7dM8hpHa1sH/NCHF9iVXMS8dnQiKcs+ciiH93jDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215049; c=relaxed/simple;
	bh=d3NaGvYflwcUQV/VikGSZdHmhxFFhyzyYxaFWafKCt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CK6TBaY9cVZt/C6/X8TT6XTSUIpFqw1v3auZOKKXvmeclzoq/LTTVDkov2r28KgLtNhlMCV0p5smu+HOG08NdoYVxqT78vzxNvfewA+Piygr3J5Ptp+m1S1/MOfhK2BSwzF11K5DC0hmw19jaujC0YMZ2OWIHBlxT0fWTCKbZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am+JTu6/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394446205dso2718272f8f.1;
        Thu, 25 Jan 2024 12:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215046; x=1706819846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpRd0Yn9QNceKjRF9svUViPS3a2VtMci6TENx75Wwpw=;
        b=am+JTu6/IxXIdY7zazQ1OcHBXr4Fg494S/Rm+N6xSBOrftUh8xWlGV6aNSPYeCJAPu
         lNSWMTfoavSCso0BhhkIOrKQJwwXpbaaN4YFT2H09zCDtkhBMDYqY1Nu8hKU03Px0zOb
         uGdE1481ueKL/k7pJk4gMGC0neixFtP0SsKxsmQOQv3zk4oijlWaFdDu8D7o78DnLeYg
         7wdJtg9jHv7ePk2fbIZJ0eJo9ar+2Gp6fi16hJAFVp5eIzRx3NbSs4uh6LWuk3vNjYw2
         PV+e81o/MfhmvCi8dpWpUQsscCVbgLsWTkGUTzcFVQ/2U5eyOEFBdU5IyE+8+JAyhLFS
         srZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215046; x=1706819846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpRd0Yn9QNceKjRF9svUViPS3a2VtMci6TENx75Wwpw=;
        b=acQEFd6RdNJptv7HH9uvBSBemibIqKhoN5SOaEftbpteDAJUZdFKM+2q1IoFMFJEkr
         gxp0YwRY3/hZW2Y7C1gzWqpt8Var9+sMAXi4iS3FyTjrTnFoqPCZnBdyT8jfuNkns8to
         1/c2Fnr+eCVTJVEyb2WmNd4YdVN9gWGDJqgOkES2dQygMBf/J/5vKC55AiLn7REDpnuT
         oHIi0w8tw73pVz7bhtdEkg8KA64FN6OqBmqxff/8VJ2/XYBgXKMV0Bm0pvdl/EF0VhKi
         vxHN6vwUyJdyWIyknEikLXJ4cPQpWPbhXuPFTiP8WO2l1VqNfgz/awxwYjVuGDZs/Etg
         qkRg==
X-Gm-Message-State: AOJu0Yzm1TePZaQoE1rqSJxJBQ1YUXTUoIXfqn4PKXXZ1bhz+j0+A3T7
	MUFH6Fp+7vGlGWH+1aMGo9ieqNJGrT8tVuyEIxDi4YBhzEA3SKhe
X-Google-Smtp-Source: AGHT+IHUQdZndKgzA9sfL34hMVS3W2s+ZEUpWSfuceTr+O28FIfSCE4NnmKjr0MzuEqLzcz2W6aqHw==
X-Received: by 2002:a05:600c:4688:b0:40e:3edf:1053 with SMTP id p8-20020a05600c468800b0040e3edf1053mr164563wmo.17.1706215045809;
        Thu, 25 Jan 2024 12:37:25 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j32-20020a05600c1c2000b0040e813f1f31sm3817700wms.25.2024.01.25.12.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:37:25 -0800 (PST)
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
Subject: [net-next PATCH v10 5/5] net: phy: at803x: add LED support for qca808x
Date: Thu, 25 Jan 2024 21:37:01 +0100
Message-ID: <20240125203702.4552-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125203702.4552-1-ansuelsmth@gmail.com>
References: <20240125203702.4552-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LED support for QCA8081 PHY.

Documentation for this LEDs PHY is very scarce even with NDA access
to Documentation for OEMs. Only the blink pattern are documented and are
very confusing most of the time. No documentation is present about
forcing the LED on/off or to always blink.

Those settings were reversed by poking the regs and trying to find the
correct bits to trigger these modes. Some bits mode are not clear and
maybe the documentation option are not 100% correct. For the sake of LED
support the reversed option are enough to add support for current LED
APIs.

Supported HW control modes are:
- tx
- rx
- link_10
- link_100
- link_1000
- link_2500
- half_duplex
- full_duplex

Also add support for LED polarity set to set LED polarity to active
high or low. QSDK sets this value to high by default but PHY reset value
doesn't have this enabled by default.

QSDK also sets 2 additional bits but their usage is not clear, info about
this is added in the header. It was verified that for correct function
of the LED if active high is needed, only BIT 6 is needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v10:
- Add Reviewed tag
- Add link_2500 speed (as the LED branch got merged in net-next)
Changes v9:
- Fix copy-paste error for blink settings
Changes v8:
- Drop unused ret variable
Changes v7:
- Improve set polarity settings (Suggested by Russell)
Changes v6:
- Rebase on top of net-next
Changes v5:
- Rework to polarity option bitmap
- Rafactor with new finding from further reverse
Changes v4:
- Rework to polarity option (for marvell10g series support)
- Rework logic to enforce single PHY polarity mode
Changes v3:
- Out of RFC
- Drop link_25000 and add TODO commends waiting for the
  netdev trigger thing to be merged (I will take care of
  sending a followup patch later)
Changes v2:
- Move to new led_polarity_set implementation
- Drop special probe

 drivers/net/phy/at803x.c | 327 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index a62442a55774..9c07a6cc6e67 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -301,6 +301,87 @@
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
+#define QCA808X_MMD7_LED2_CTRL			0x8074
+#define QCA808X_MMD7_LED2_FORCE_CTRL		0x8075
+#define QCA808X_MMD7_LED1_CTRL			0x8076
+#define QCA808X_MMD7_LED1_FORCE_CTRL		0x8077
+#define QCA808X_MMD7_LED0_CTRL			0x8078
+#define QCA808X_MMD7_LED_CTRL(x)		(0x8078 - ((x) * 2))
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
+#define QCA808X_MMD7_LED0_FORCE_CTRL		0x8079
+#define QCA808X_MMD7_LED_FORCE_CTRL(x)		(0x8079 - ((x) * 2))
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
+#define QCA808X_MMD7_LED_POLARITY_CTRL		0x901a
+/* QSDK sets by default 0x46 to this reg that sets BIT 6 for
+ * LED to active high. It's not clear what BIT 3 and BIT 4 does.
+ */
+#define QCA808X_LED_ACTIVE_HIGH			BIT(6)
+
 /* QCA808X 1G chip type */
 #define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
 #define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
@@ -346,6 +427,7 @@ struct at803x_priv {
 	struct regulator_dev *vddio_rdev;
 	struct regulator_dev *vddh_rdev;
 	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
+	int led_polarity_mode;
 };
 
 struct at803x_context {
@@ -706,6 +788,9 @@ static int at803x_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
+	/* Init LED polarity mode to -1 */
+	priv->led_polarity_mode = -1;
+
 	phydev->priv = priv;
 
 	ret = at803x_parse_dt(phydev);
@@ -2235,6 +2320,242 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
 				   phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
 }
 
+static int qca808x_led_parse_netdev(struct phy_device *phydev, unsigned long rules,
+				    u16 *offload_trigger)
+{
+	/* Parsing specific to netdev trigger */
+	if (test_bit(TRIGGER_NETDEV_TX, &rules))
+		*offload_trigger |= QCA808X_LED_TX_BLINK;
+	if (test_bit(TRIGGER_NETDEV_RX, &rules))
+		*offload_trigger |= QCA808X_LED_RX_BLINK;
+	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+		*offload_trigger |= QCA808X_LED_SPEED10_ON;
+	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+		*offload_trigger |= QCA808X_LED_SPEED100_ON;
+	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+		*offload_trigger |= QCA808X_LED_SPEED1000_ON;
+	if (test_bit(TRIGGER_NETDEV_LINK_2500, &rules))
+		*offload_trigger |= QCA808X_LED_SPEED2500_ON;
+	if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+		*offload_trigger |= QCA808X_LED_HALF_DUPLEX_ON;
+	if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+		*offload_trigger |= QCA808X_LED_FULL_DUPLEX_ON;
+
+	if (rules && !*offload_trigger)
+		return -EOPNOTSUPP;
+
+	/* Enable BLINK_CHECK_BYPASS by default to make the LED
+	 * blink even with duplex or speed mode not enabled.
+	 */
+	*offload_trigger |= QCA808X_LED_BLINK_CHECK_BYPASS;
+
+	return 0;
+}
+
+static int qca808x_led_hw_control_enable(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
+				  QCA808X_LED_FORCE_EN);
+}
+
+static int qca808x_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 offload_trigger = 0;
+
+	if (index > 2)
+		return -EINVAL;
+
+	return qca808x_led_parse_netdev(phydev, rules, &offload_trigger);
+}
+
+static int qca808x_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	u16 reg, offload_trigger = 0;
+	int ret;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_CTRL(index);
+
+	ret = qca808x_led_parse_netdev(phydev, rules, &offload_trigger);
+	if (ret)
+		return ret;
+
+	ret = qca808x_led_hw_control_enable(phydev, index);
+	if (ret)
+		return ret;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			      QCA808X_LED_PATTERN_MASK,
+			      offload_trigger);
+}
+
+static bool qca808x_led_hw_control_status(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+	int val;
+
+	if (index > 2)
+		return false;
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+
+	return !(val & QCA808X_LED_FORCE_EN);
+}
+
+static int qca808x_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	u16 reg;
+	int val;
+
+	if (index > 2)
+		return -EINVAL;
+
+	/* Check if we have hw control enabled */
+	if (qca808x_led_hw_control_status(phydev, index))
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_CTRL(index);
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	if (val & QCA808X_LED_TX_BLINK)
+		set_bit(TRIGGER_NETDEV_TX, rules);
+	if (val & QCA808X_LED_RX_BLINK)
+		set_bit(TRIGGER_NETDEV_RX, rules);
+	if (val & QCA808X_LED_SPEED10_ON)
+		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+	if (val & QCA808X_LED_SPEED100_ON)
+		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+	if (val & QCA808X_LED_SPEED1000_ON)
+		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+	if (val & QCA808X_LED_SPEED2500_ON)
+		set_bit(TRIGGER_NETDEV_LINK_2500, rules);
+	if (val & QCA808X_LED_HALF_DUPLEX_ON)
+		set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+	if (val & QCA808X_LED_FULL_DUPLEX_ON)
+		set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
+
+	return 0;
+}
+
+static int qca808x_led_hw_control_reset(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_CTRL(index);
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
+				  QCA808X_LED_PATTERN_MASK);
+}
+
+static int qca808x_led_brightness_set(struct phy_device *phydev,
+				      u8 index, enum led_brightness value)
+{
+	u16 reg;
+	int ret;
+
+	if (index > 2)
+		return -EINVAL;
+
+	if (!value) {
+		ret = qca808x_led_hw_control_reset(phydev, index);
+		if (ret)
+			return ret;
+	}
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
+			      QCA808X_LED_FORCE_EN | value ? QCA808X_LED_FORCE_ON :
+							     QCA808X_LED_FORCE_OFF);
+}
+
+static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+	int ret;
+	u16 reg;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
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
+
+static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
+				    unsigned long modes)
+{
+	struct at803x_priv *priv = phydev->priv;
+	bool active_low = false;
+	u32 mode;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			active_low = true;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* PHY polarity is global and can't be set per LED.
+	 * To detect this, check if last requested polarity mode
+	 * match the new one.
+	 */
+	if (priv->led_polarity_mode >= 0 &&
+	    priv->led_polarity_mode != active_low) {
+		phydev_err(phydev, "PHY polarity is global. Mismatched polarity on different LED\n");
+		return -EINVAL;
+	}
+
+	/* Save the last PHY polarity mode */
+	priv->led_polarity_mode = active_low;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN,
+			      QCA808X_MMD7_LED_POLARITY_CTRL,
+			      QCA808X_LED_ACTIVE_HIGH,
+			      active_low ? 0 : QCA808X_LED_ACTIVE_HIGH);
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2411,6 +2732,12 @@ static struct phy_driver at803x_driver[] = {
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
 	.link_change_notify	= qca808x_link_change_notify,
+	.led_brightness_set	= qca808x_led_brightness_set,
+	.led_blink_set		= qca808x_led_blink_set,
+	.led_hw_is_supported	= qca808x_led_hw_is_supported,
+	.led_hw_control_set	= qca808x_led_hw_control_set,
+	.led_hw_control_get	= qca808x_led_hw_control_get,
+	.led_polarity_set	= qca808x_led_polarity_set,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.43.0


