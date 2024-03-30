Return-Path: <linux-kernel+bounces-125760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA54892BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498612835AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B403984D;
	Sat, 30 Mar 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b="WS2FelSU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b="WS2FelSU"
Received: from mx104.easyname.com (mx104.easyname.com [77.244.243.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87581C0DEF;
	Sat, 30 Mar 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.244.243.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711811981; cv=none; b=SCmPVFfHeSiKUPNOAUWZa9X2Sd1CvnlbfEkai1qlU7X1vKslq+EZycZ7c2SrOAY48m/sgDZRaWVBzYVtgd6tnANaCg+oCmEKj95TInRhJZwj8ipev5tz8U/RaoPoqvwJ8m4x5CeeIf0xIyo+MvTRMrAbiz4iS2d8xIe9tPeRVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711811981; c=relaxed/simple;
	bh=T6BNvRK2/qKQ44MhwAdR61PguKYEhe6BMmvj57cClck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNi5JGt4xuTTSQOEaYjxQC3zHLMUusdlbIMjBI6TscMbYUvxusUb/Y+MA+0nKmCKxTVTIqQfzjrjy6RxHPsELQjc/WLuXjneTf4kZM1TXWgJa+yQo+di33ux8sybQDFeY06ifDCdFi1yXJsb2fHoZ5raaZQlnjgk6JJG+5qMXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paroga.com; spf=pass smtp.mailfrom=paroga.com; dkim=pass (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b=WS2FelSU; dkim=pass (2048-bit key) header.d=paroga.com header.i=@paroga.com header.b=WS2FelSU; arc=none smtp.client-ip=77.244.243.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paroga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paroga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=paroga.com;
	 s=easyname; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZvjVCv6tx6IWR0JEWMMNFqOIGJ1YPrQjwnbxKPpcxE0=; b=WS2FelSUA4u3/d0BLllAWXpp9/
	W7CZqLMsya8CJoEnCHXmiTIYsyWai7MAy4EJ79UyzjV1Obf9X19Gm75De+tVrtZex9oNduvknWAcY
	aH7wcBir86YAPeImeNt6hzDGi9XqHSrl0BBcNTNETy8QCJ77xry+IsPFdf/0kG0qao2ZhD/DB/OC0
	SpIF0dDWmnbxHKfPuHXUhcn7TrGTLE1YD+bst+t2vZ66hjAuR4McrXiAMbZtfYtLNaTjcmOpPD3K0
	qIgk5aivkE+1bFDJt9ZtuWfGRS9YMvlj0ob8U819EyclkxeNYEeOq9BwY7bVrSc9LbNMyCIpCy8TV
	PUXfrbHA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=paroga.com;
	 s=easyname; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZvjVCv6tx6IWR0JEWMMNFqOIGJ1YPrQjwnbxKPpcxE0=; b=WS2FelSUA4u3/d0BLllAWXpp9/
	W7CZqLMsya8CJoEnCHXmiTIYsyWai7MAy4EJ79UyzjV1Obf9X19Gm75De+tVrtZex9oNduvknWAcY
	aH7wcBir86YAPeImeNt6hzDGi9XqHSrl0BBcNTNETy8QCJ77xry+IsPFdf/0kG0qao2ZhD/DB/OC0
	SpIF0dDWmnbxHKfPuHXUhcn7TrGTLE1YD+bst+t2vZ66hjAuR4McrXiAMbZtfYtLNaTjcmOpPD3K0
	qIgk5aivkE+1bFDJt9ZtuWfGRS9YMvlj0ob8U819EyclkxeNYEeOq9BwY7bVrSc9LbNMyCIpCy8TV
	PUXfrbHA==;
Received: from 84-115-225-203.cable.dynamic.surfer.at ([84.115.225.203] helo=localhost.localdomain)
	by mx.easyname.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paroga@paroga.com>)
	id 1rqaBv-0002RN-58; Sat, 30 Mar 2024 15:00:23 +0000
From: Patrick Gansterer <paroga@paroga.com>
To: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Cc: Patrick Gansterer <paroga@paroga.com>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 2/2] backlight: Add new lm3509 backlight driver
Date: Sat, 30 Mar 2024 15:59:25 +0100
Message-ID: <20240330145931.729116-3-paroga@paroga.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330145931.729116-1-paroga@paroga.com>
References: <20240330145931.729116-1-paroga@paroga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Easy-Autoreply: EN

This is a general driver for LM3509 backlight chip of TI.
LM3509 is High Efficiency Boost for White LEDs and/or OLED Displays with
Dual Current Sinks. This driver supports OLED/White LED select, brightness
control and sub/main control.
The datasheet can be found at http://www.ti.com/product/lm3509.

Signed-off-by: Patrick Gansterer <paroga@paroga.com>
---
 drivers/video/backlight/Kconfig     |   7 +
 drivers/video/backlight/Makefile    |   1 +
 drivers/video/backlight/lm3509_bl.c | 340 ++++++++++++++++++++++++++++
 3 files changed, 348 insertions(+)
 create mode 100644 drivers/video/backlight/lm3509_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 230bca07b09d..3614a5d29c71 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -373,6 +373,13 @@ config BACKLIGHT_AAT2870
 	  If you have a AnalogicTech AAT2870 say Y to enable the
 	  backlight driver.
 
+config BACKLIGHT_LM3509
+	tristate "Backlight Driver for LM3509"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This supports TI LM3509 Backlight Driver
+
 config BACKLIGHT_LM3630A
 	tristate "Backlight Driver for LM3630A"
 	depends on I2C && PWM
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 8d2cb252042d..8fc98f760a8a 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
 obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
 obj-$(CONFIG_BACKLIGHT_KTD2801)		+= ktd2801-backlight.o
 obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
+obj-$(CONFIG_BACKLIGHT_LM3509)		+= lm3509_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
diff --git a/drivers/video/backlight/lm3509_bl.c b/drivers/video/backlight/lm3509_bl.c
new file mode 100644
index 000000000000..ab57f79ffe23
--- /dev/null
+++ b/drivers/video/backlight/lm3509_bl.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define LM3509_NAME "lm3509_bl"
+
+#define LM3509_SINK_MAIN 0
+#define LM3509_SINK_SUB 1
+#define LM3509_NUM_SINKS 2
+
+#define LM3509_DEF_BRIGHTNESS 0x12
+#define LM3509_MAX_BRIGHTNESS 0x1F
+
+#define REG_GP 0x10
+#define REG_BMAIN 0xA0
+#define REG_BSUB 0xB0
+#define REG_MAX 0xFF
+
+enum {
+	REG_GP_ENM_BIT = 0,
+	REG_GP_ENS_BIT,
+	REG_GP_UNI_BIT,
+	REG_GP_RMP0_BIT,
+	REG_GP_RMP1_BIT,
+	REG_GP_OLED_BIT,
+};
+
+struct lm3509_bl {
+	struct regmap *regmap;
+	struct backlight_device *bl_main;
+	struct backlight_device *bl_sub;
+	struct gpio_desc *reset_gpio;
+};
+
+struct lm3509_bl_led_data {
+	const char *label;
+	int led_sources;
+	u32 brightness;
+	u32 max_brightness;
+};
+
+static void lm3509_reset(struct lm3509_bl *data)
+{
+	if (data->reset_gpio) {
+		gpiod_set_value(data->reset_gpio, 1);
+		udelay(1);
+		gpiod_set_value(data->reset_gpio, 0);
+		udelay(10);
+	}
+}
+
+static int lm3509_update_status(struct backlight_device *bl,
+				unsigned int en_mask, unsigned int br_reg)
+{
+	struct lm3509_bl *data = bl_get_data(bl);
+	int ret;
+	bool en;
+
+	ret = regmap_write(data->regmap, br_reg, backlight_get_brightness(bl));
+	if (ret < 0)
+		return ret;
+
+	en = !backlight_is_blank(bl);
+	return regmap_update_bits(data->regmap, REG_GP, en_mask,
+				  en ? en_mask : 0);
+}
+
+static int lm3509_main_update_status(struct backlight_device *bl)
+{
+	return lm3509_update_status(bl, BIT(REG_GP_ENM_BIT), REG_BMAIN);
+}
+
+static const struct backlight_ops lm3509_main_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = lm3509_main_update_status,
+};
+
+static int lm3509_sub_update_status(struct backlight_device *bl)
+{
+	return lm3509_update_status(bl, BIT(REG_GP_ENS_BIT), REG_BSUB);
+}
+
+static const struct backlight_ops lm3509_sub_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = lm3509_sub_update_status,
+};
+
+static struct backlight_device *
+lm3509_backlight_register(struct device *dev, const char *name_suffix,
+			  struct lm3509_bl *data,
+			  const struct backlight_ops *ops,
+			  const struct lm3509_bl_led_data *led_data)
+
+{
+	struct backlight_device *bd;
+	struct backlight_properties props;
+	const char *label = led_data->label;
+	char name[64];
+
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
+	props.brightness = led_data->brightness;
+	props.max_brightness = led_data->max_brightness;
+	props.scale = BACKLIGHT_SCALE_NON_LINEAR;
+
+	if (!label) {
+		snprintf(name, sizeof(name), "lm3509-%s-%s", dev_name(dev),
+			 name_suffix);
+		label = name;
+	}
+
+	bd = devm_backlight_device_register(dev, label, dev, data, ops, &props);
+	if (bd)
+		backlight_update_status(bd);
+
+	return bd;
+}
+
+static const struct regmap_config lm3509_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_MAX,
+};
+
+static int lm3509_parse_led_sources(struct device_node *node,
+				    int default_led_sources)
+{
+	u32 sources[LM3509_NUM_SINKS];
+	int ret, num_sources, i;
+
+	num_sources = of_property_count_u32_elems(node, "led-sources");
+	if (num_sources < 0)
+		return default_led_sources;
+	else if (num_sources > ARRAY_SIZE(sources))
+		return -EINVAL;
+
+	ret = of_property_read_u32_array(node, "led-sources", sources,
+					 num_sources);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_sources; i++) {
+		if (sources[i] >= LM3509_NUM_SINKS)
+			return -EINVAL;
+
+		ret |= BIT(sources[i]);
+	}
+
+	return ret;
+}
+
+static int lm3509_parse_dt_node(struct device *dev,
+				struct lm3509_bl_led_data *led_data)
+{
+	struct device_node *child;
+	int seen_led_sources = 0;
+
+	for_each_child_of_node(dev->of_node, child) {
+		struct lm3509_bl_led_data *ld;
+		int ret;
+		u32 reg;
+		int valid_led_sources;
+
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret < 0)
+			return ret;
+		if (reg >= LM3509_NUM_SINKS)
+			return -EINVAL;
+		ld = &led_data[reg];
+
+		ld->led_sources = lm3509_parse_led_sources(child, BIT(reg));
+		if (ld->led_sources < 0)
+			return ld->led_sources;
+
+		if (reg == 0)
+			valid_led_sources = BIT(LM3509_SINK_MAIN) |
+					    BIT(LM3509_SINK_SUB);
+		else
+			valid_led_sources = BIT(LM3509_SINK_SUB);
+
+		if (ld->led_sources != (ld->led_sources & valid_led_sources))
+			return -EINVAL;
+
+		if (seen_led_sources & ld->led_sources)
+			return -EINVAL;
+
+		seen_led_sources |= ld->led_sources;
+
+		ld->label = NULL;
+		of_property_read_string(child, "label", &ld->label);
+
+		ld->max_brightness = LM3509_MAX_BRIGHTNESS;
+		of_property_read_u32(child, "max-brightness",
+				     &ld->max_brightness);
+		ld->max_brightness =
+			min_t(u32, ld->max_brightness, LM3509_MAX_BRIGHTNESS);
+
+		ld->brightness = LM3509_DEF_BRIGHTNESS;
+		of_property_read_u32(child, "default-brightness",
+				     &ld->brightness);
+		ld->brightness = min_t(u32, ld->brightness, ld->max_brightness);
+	}
+
+	return 0;
+}
+
+static int lm3509_probe(struct i2c_client *client)
+{
+	struct lm3509_bl *data;
+	struct device *dev = &client->dev;
+	int ret;
+	bool oled_mode = false;
+	unsigned int reg_gp_val = 0;
+	struct lm3509_bl_led_data led_data[LM3509_NUM_SINKS];
+	u32 rate_of_change = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(dev, "i2c functionality check failed\n");
+		return -EOPNOTSUPP;
+	}
+
+	data = devm_kzalloc(dev, sizeof(struct lm3509_bl), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regmap = devm_regmap_init_i2c(client, &lm3509_regmap);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+	i2c_set_clientdata(client, data);
+
+	data->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(data->reset_gpio),
+				     "Failed to get 'reset' gpio\n");
+
+	lm3509_reset(data);
+
+	memset(led_data, 0, sizeof(led_data));
+	ret = lm3509_parse_dt_node(dev, led_data);
+	if (ret)
+		return ret;
+
+	oled_mode = of_property_read_bool(dev->of_node, "ti,oled-mode");
+
+	if (!of_property_read_u32(dev->of_node,
+				  "ti,brightness-rate-of-change-us",
+				  &rate_of_change)) {
+		switch (rate_of_change) {
+		case 51:
+			reg_gp_val = 0;
+			break;
+		case 13000:
+			reg_gp_val = BIT(REG_GP_RMP1_BIT);
+			break;
+		case 26000:
+			reg_gp_val = BIT(REG_GP_RMP0_BIT);
+			break;
+		case 52000:
+			reg_gp_val = BIT(REG_GP_RMP0_BIT) |
+				     BIT(REG_GP_RMP1_BIT);
+			break;
+		default:
+			dev_warn(dev, "invalid rate of change %u\n",
+				 rate_of_change);
+			break;
+		}
+	}
+
+	if (led_data[0].led_sources ==
+	    (BIT(LM3509_SINK_MAIN) | BIT(LM3509_SINK_SUB)))
+		reg_gp_val |= BIT(REG_GP_UNI_BIT);
+	if (oled_mode)
+		reg_gp_val |= BIT(REG_GP_OLED_BIT);
+
+	ret = regmap_write(data->regmap, REG_GP, reg_gp_val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to write register\n");
+
+	if (led_data[0].led_sources) {
+		data->bl_main = lm3509_backlight_register(
+			dev, "main", data, &lm3509_main_ops, &led_data[0]);
+		if (IS_ERR(data->bl_main)) {
+			return dev_err_probe(
+				dev, PTR_ERR(data->bl_main),
+				"failed to register main backlight\n");
+		}
+	}
+
+	if (led_data[1].led_sources) {
+		data->bl_sub = lm3509_backlight_register(
+			dev, "sub", data, &lm3509_sub_ops, &led_data[1]);
+		if (IS_ERR(data->bl_sub)) {
+			return dev_err_probe(
+				dev, PTR_ERR(data->bl_sub),
+				"failed to register secondary backlight\n");
+		}
+	}
+
+	return 0;
+}
+
+static void lm3509_remove(struct i2c_client *client)
+{
+	struct lm3509_bl *data = i2c_get_clientdata(client);
+
+	regmap_write(data->regmap, REG_GP, 0x00);
+}
+
+static const struct i2c_device_id lm3509_id[] = { { LM3509_NAME, 0 }, {} };
+
+MODULE_DEVICE_TABLE(i2c, lm3509_id);
+
+static const struct of_device_id lm3509_match_table[] = {
+	{
+		.compatible = "ti,lm3509",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, lm3509_match_table);
+
+static struct i2c_driver lm3509_i2c_driver = {
+	.driver = {
+		.name = LM3509_NAME,
+		.of_match_table = lm3509_match_table,
+	},
+	.probe = lm3509_probe,
+	.remove = lm3509_remove,
+	.id_table = lm3509_id,
+};
+
+module_i2c_driver(lm3509_i2c_driver);
+
+MODULE_DESCRIPTION("Texas Instruments Backlight driver for LM3509");
+MODULE_AUTHOR("Patrick Gansterer <paroga@paroga.com>");
+MODULE_LICENSE("GPL");
-- 
2.44.0


