Return-Path: <linux-kernel+bounces-98118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AE0877554
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F057CB21BED
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D22C6A4;
	Sun, 10 Mar 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF02ln/q"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4472943C;
	Sun, 10 Mar 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710046351; cv=none; b=WxstoDnO2Q2s8epG1zhT8eZf1wi56LhXIGsrAfUKBVSPwZtDMJ6E6+aJGW3C4A4Ac/O2JoxKKI281MAGH9ZLTc9G9IZvRv7dFHCMu20yfC7maZD03ThlpLvQ7g624ICDDklDAp5KQVnu8xw7hX7r9Ux1DTy1gpyy5LR4l/wPSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710046351; c=relaxed/simple;
	bh=l4BGuQaSazeqlAvJgyULvmoJ+R4pGF6EhnlCeNvnzKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVXiQ3+vvxpdPrfg2zr0piZ2pmdrHVCBsjPThGD/aLRO2fhNcv0dRCYpPHuP3PxGUbqO0rO2SbQ8gUxANZRiID9/kPgz1JLCb4sl2fJ9kbtmk35EVtOgEOEi8YW8OzxJVL6PDPXxLE/WCZsUfU1BszFQ3KbVkNvBITMbLIWiRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF02ln/q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2842146a12.1;
        Sat, 09 Mar 2024 20:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710046348; x=1710651148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoZ0T/xvHWDAJteyB6NrD7pWluK6onYNLLkR78ehmyc=;
        b=QF02ln/qIcavlT6ZqqF0fKCmUHTvipihk9sJFcZhDaskPek5ahZoApfFXaJM59PIJz
         43gUAKsMDq70a3Y+kTvg67XfihtM8Rp8j1WeqQKCpIUtH6PdZHYNrwgNRJ7S/REic664
         APqYWlclVDQYOZSeRbf8l/Itxuro7BAQLyJiAonKCIpNb6LSY5ot+l/S0NemtRLr8VgR
         FThj57QcHz4xs4tKWhxi7v0gJfiigmkSxfSs0usOySQ4zjTzn0RMssVCTJVw/LiGxOd2
         DCZ/gWwQ5IZ81SAjD6oPAZp3VRUUFXbYduMavxNFZGBGAQpt+Pr7UjrJYrJOiwgbXc6l
         p0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710046348; x=1710651148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoZ0T/xvHWDAJteyB6NrD7pWluK6onYNLLkR78ehmyc=;
        b=FmiU+hwSjuonJYI2zwZ7ursHKtIlmAiS9O4Fk0cD8944hXoazTHGTaKFMUmENRTbYy
         DNclm5un9sdM6bKXbIYDir8jSy3e1f0mWTa3T9pWyE75znQWvMj0Syss/r8lTK7IUMMQ
         iCODIbgH4FkXYsXUawQqzCSxWVDTVWmT+FWSGxgbzzuLgcTBO6Iac7R/ymllz+jLjZSG
         KcjQsk2XIu6sJxEi/KtkPNDipaT9dKoh4TPoiWfyrAQFRCFK8spVyC8snz9z2HT8mJwo
         3c6c2/IijDHSDE9DfqmXfPNG1ReI1txc5JMsC4Lq9UCHr2RFQ+7zLDhCqjkBlFud5N9j
         CPQg==
X-Forwarded-Encrypted: i=1; AJvYcCVTEgNa/Ahzi8RJohHMBLAumIFhqfcoq722a//FR7+cl5GMnldhFxsH+1Dk2dAuW0oYb3hZauhrWROdOBV3IJ+Dn8mcramyKolaw7tp
X-Gm-Message-State: AOJu0Yyr14g2WGkTH0IdZ5UClh68wKCwQtl2RuKYEdjDvIa0pTrsMS4T
	0w28iVj+X8+KDjqsPCI5oCVTIn/MOQY5VYSF/dSbXtiZnH4RmABR
X-Google-Smtp-Source: AGHT+IHs+R8RwvPm4akdgBCZNO2ON1Vxa/lz9eEIk1B/kcxVscq9dK1G2laWbgM/kefti+VVkZ+c8g==
X-Received: by 2002:a05:6a00:1898:b0:6e6:4e6b:5a16 with SMTP id x24-20020a056a00189800b006e64e6b5a16mr4551598pfh.4.1710046348502;
        Sat, 09 Mar 2024 20:52:28 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b005dc48e56191sm1984659pgh.11.2024.03.09.20.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 20:52:27 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 10 Mar 2024 01:52:01 -0300
Subject: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for
 rtl8366rb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
In-Reply-To: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10066; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=l4BGuQaSazeqlAvJgyULvmoJ+R4pGF6EhnlCeNvnzKo=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl7Tx2lmdamXCVs5ALeJxgsnxY8F7oaIWMmT9rO
 g0ygxuXwnaJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZe08dgAKCRC7Edu60Qc7
 Vm9mB/9kyLWVn4upz2Kkt8piFqPYC0ao6sBZIwOuLTCjxWtrs8L8Qrc+RnJCQqvbejdo86TbmmE
 a8oTCGY/ydl0YVDvApoW4NXOGtuoaEYRqIr+KhD5MdO0jfgnZVTtFsal1GhxOnteL0lH/JKGU0R
 gjdXNdEu/tRdsX+vSCuus/zKlN+B3I0BiYE5LAFGSSgFRAA8ltsedrdd4XKFpq6Yd0Y8rp1G9Mi
 pH1loaAeeF8e1j4CawuY6371VQVc+ptXNbr+2qVEPG02bEKThrYCmN2OwGi7Ci+z0c1QBh8uLtV
 rQ1SpAdLIKsiFkqIVJ2nG0CxbHezTWscMHd0Rg5duDUyb9Hf
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

This commit introduces LED drivers for rtl8366rb, enabling LEDs to be
described in the device tree using the same format as qca8k. Each port
can configure up to 4 LEDs.

If all LEDs in a group use the default state "keep", they will use the
default behavior after a reset. Changing the brightness of one LED,
either manually or by a trigger, will disable the default hardware
trigger and switch the entire LED group to manually controlled LEDs.
Once in this mode, there is no way to revert to hardware-controlled LEDs
(except by resetting the switch).

Software triggers function as expected with manually controlled LEDs.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 270 ++++++++++++++++++++++++++++++++----
 1 file changed, 246 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 5ccb1a3a149d..e45773fec17e 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -191,31 +191,21 @@
 	(4 * (led_group))
 #define RTL8366RB_LED_CTRL_MASK(led_group)	\
 	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
-#define RTL8366RB_LED_OFF			0x0
-#define RTL8366RB_LED_DUP_COL			0x1
-#define RTL8366RB_LED_LINK_ACT			0x2
-#define RTL8366RB_LED_SPD1000			0x3
-#define RTL8366RB_LED_SPD100			0x4
-#define RTL8366RB_LED_SPD10			0x5
-#define RTL8366RB_LED_SPD1000_ACT		0x6
-#define RTL8366RB_LED_SPD100_ACT		0x7
-#define RTL8366RB_LED_SPD10_ACT			0x8
-#define RTL8366RB_LED_SPD100_10_ACT		0x9
-#define RTL8366RB_LED_FIBER			0xa
-#define RTL8366RB_LED_AN_FAULT			0xb
-#define RTL8366RB_LED_LINK_RX			0xc
-#define RTL8366RB_LED_LINK_TX			0xd
-#define RTL8366RB_LED_MASTER			0xe
-#define RTL8366RB_LED_FORCE			0xf
 
 /* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
  * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
  * RTL8366RB_LED_FORCE. Otherwise, it is ignored.
  */
 #define RTL8366RB_LED_0_1_CTRL_REG		0x0432
-#define RTL8366RB_LED_1_OFFSET			6
 #define RTL8366RB_LED_2_3_CTRL_REG		0x0433
-#define RTL8366RB_LED_3_OFFSET			6
+#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
+	((led_group) <= 1 ? \
+		RTL8366RB_LED_0_1_CTRL_REG : \
+		RTL8366RB_LED_2_3_CTRL_REG)
+#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
+#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
 
 #define RTL8366RB_MIB_COUNT			33
 #define RTL8366RB_GLOBAL_MIB_COUNT		1
@@ -359,14 +349,44 @@
 #define RTL8366RB_GREEN_FEATURE_TX	BIT(0)
 #define RTL8366RB_GREEN_FEATURE_RX	BIT(2)
 
+enum rtl8366_led_mode {
+	RTL8366RB_LED_OFF		= 0x0,
+	RTL8366RB_LED_DUP_COL		= 0x1,
+	RTL8366RB_LED_LINK_ACT		= 0x2,
+	RTL8366RB_LED_SPD1000		= 0x3,
+	RTL8366RB_LED_SPD100		= 0x4,
+	RTL8366RB_LED_SPD10		= 0x5,
+	RTL8366RB_LED_SPD1000_ACT	= 0x6,
+	RTL8366RB_LED_SPD100_ACT	= 0x7,
+	RTL8366RB_LED_SPD10_ACT		= 0x8,
+	RTL8366RB_LED_SPD100_10_ACT	= 0x9,
+	RTL8366RB_LED_FIBER		= 0xa,
+	RTL8366RB_LED_AN_FAULT		= 0xb,
+	RTL8366RB_LED_LINK_RX		= 0xc,
+	RTL8366RB_LED_LINK_TX		= 0xd,
+	RTL8366RB_LED_MASTER		= 0xe,
+	RTL8366RB_LED_FORCE		= 0xf,
+
+	__RTL8366RB_LED_MAX
+};
+
+struct rtl8366rb_led {
+	u8 port_num;
+	u8 led_group;
+	struct realtek_priv *priv;
+	struct led_classdev cdev;
+};
+
 /**
  * struct rtl8366rb - RTL8366RB-specific data
  * @max_mtu: per-port max MTU setting
  * @pvid_enabled: if PVID is set for respective port
+ * @leds: per-port and per-ledgroup led info
  */
 struct rtl8366rb {
 	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
 	bool pvid_enabled[RTL8366RB_NUM_PORTS];
+	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
 };
 
 static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
@@ -809,6 +829,208 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
 	return 0;
 }
 
+static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+				      u8 led_group,
+				      enum rtl8366_led_mode mode)
+{
+	int ret;
+	u32 val;
+
+	val = mode << RTL8366RB_LED_CTRL_OFFSET(led_group);
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_CTRL_REG,
+				 RTL8366RB_LED_CTRL_MASK(led_group),
+				 val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
+{
+	switch (led_group) {
+	case 0:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 1:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 2:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 3:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	default:
+		return 0;
+	}
+}
+
+static int rb8366rb_get_port_led(struct rtl8366rb_led *led, bool enable)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+	u32 val;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_err(priv->dev, "Invalid LED group %d for port %d",
+			led_group, port_num);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
+			  &val);
+	if (ret) {
+		dev_err(priv->dev, "error reading LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
+}
+
+static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_err(priv->dev, "Invalid LED group %d for port %d",
+			led_group, port_num);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
+				 rtl8366rb_led_group_port_mask(led_group,
+							       port_num),
+				 enable ? 0xffff : 0);
+	if (ret) {
+		dev_err(priv->dev, "error updating LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	/* Change the LED group to manual controlled LEDs if required */
+	ret = rb8366rb_set_ledgroup_mode(priv, led_group, RTL8366RB_LED_FORCE);
+
+	if (ret) {
+		dev_err(priv->dev, "error updating LED GROUP group %d\n",
+			led_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
+				       enum led_brightness brightness)
+{
+	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
+						 cdev);
+
+	return rb8366rb_set_port_led(led, brightness == LED_ON);
+}
+
+static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
+			       struct fwnode_handle *led_fwnode)
+{
+	struct rtl8366rb *rb = priv->chip_data;
+	struct led_init_data init_data = { };
+	struct rtl8366rb_led *led;
+	enum led_default_state state;
+	u32 led_group;
+	int ret;
+
+	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
+	if (ret)
+		return ret;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
+			 led_group, dp->index);
+		return -EINVAL;
+	}
+
+	led = &rb->leds[dp->index][led_group];
+	led->port_num = dp->index;
+	led->led_group = led_group;
+	led->priv = priv;
+
+	state = led_init_default_state_get(led_fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		led->cdev.brightness = 1;
+		rb8366rb_set_port_led(led, 1);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		led->cdev.brightness =
+			rb8366rb_get_port_led(led, 1);
+		break;
+	case LEDS_DEFSTATE_OFF:
+	default:
+		led->cdev.brightness = 0;
+		rb8366rb_set_port_led(led, 0);
+	}
+
+	led->cdev.max_brightness = 1;
+	led->cdev.brightness_set_blocking =
+		rtl8366rb_cled_brightness_set_blocking;
+	init_data.fwnode = led_fwnode;
+	init_data.devname_mandatory = true;
+
+	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
+					 dp->ds->index, dp->index, led_group);
+	if (!init_data.devicename)
+		return -ENOMEM;
+
+	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
+	if (ret) {
+		dev_warn(priv->dev, "Failed to init LED %d for port %d",
+			 led_group, dp->index);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	struct device_node *leds_np, *led_np;
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
+	int ret;
+
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dp->dn)
+			continue;
+
+		leds_np = of_get_child_by_name(dp->dn, "leds");
+		if (!leds_np) {
+			dev_dbg(priv->dev, "No leds defined for port %d",
+				dp->index);
+			continue;
+		}
+
+		for_each_child_of_node(leds_np, led_np) {
+			ret = rtl8366rb_setup_led(priv, dp,
+						  of_fwnode_handle(led_np));
+			if (ret) {
+				of_node_put(led_np);
+				break;
+			}
+		}
+
+		of_node_put(leds_np);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
@@ -817,7 +1039,6 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	u32 chip_ver = 0;
 	u32 chip_id = 0;
 	int jam_size;
-	u32 val;
 	int ret;
 	int i;
 
@@ -1017,14 +1238,15 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 				   0);
 
 		for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
-			val = RTL8366RB_LED_OFF << RTL8366RB_LED_CTRL_OFFSET(i);
-			ret = regmap_update_bits(priv->map,
-						 RTL8366RB_LED_CTRL_REG,
-						 RTL8366RB_LED_CTRL_MASK(i),
-						 val);
+			ret = rb8366rb_set_ledgroup_mode(priv, i,
+							 RTL8366RB_LED_OFF);
 			if (ret)
 				return ret;
 		}
+	} else {
+		ret = rtl8366rb_setup_leds(priv);
+		if (ret)
+			return ret;
 	}
 
 	ret = rtl8366_reset_vlan(priv);

-- 
2.44.0


