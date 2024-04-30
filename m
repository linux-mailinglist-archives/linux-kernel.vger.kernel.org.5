Return-Path: <linux-kernel+bounces-163990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9FC8B76E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB7A283C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D177178CC9;
	Tue, 30 Apr 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LqUFn1ag"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47D171E76;
	Tue, 30 Apr 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483238; cv=none; b=YwBDKbkgSGL49XUXAUXgRIlhmYNnHvJeqnbjUuFiB9JZjtP5npDhat0kZxprIn++JiQCjR7AtME8b3zoQpXf6k9yKVC9cWQuuzEV/Bjkg+O9khzAbvvzjoFXx1vO19QKPWnlCRW4fuY4DpaV9QRXA6JpEdVNSvEFn4LfhG5R+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483238; c=relaxed/simple;
	bh=shcnDecdtrcZJxtGcCx+bjHH0dkyuIy1CTxyidS5aPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APBrfovj19TZaK9vC0O/AV9JttctodbSTl1J6niVvD6iSMuJ5BuIjTT/tCwKgs+VTxQrtSxNhNLx0ac6Spw0yJWPXBJEQma77bXlLp82HQ61BsCxUuov/G+knE2WBXS/iqBlDtdjJiD9l17N9GEO0Mqede7wlrs9QnruPFbBTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LqUFn1ag; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714483234;
	bh=shcnDecdtrcZJxtGcCx+bjHH0dkyuIy1CTxyidS5aPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqUFn1ag+BcnSqh0ZamZ1RJyCQGZIpExf2RUtdFq8IZGJpcmzIrhChi9Y2tH/BVYY
	 iGOTkL7kcqo+aFq3lFFqJx3vXnfSFbMvXZSmJSy6QnJS8fBAMVd2fi+wQZx6PP8Pel
	 BEJZLw/fIWfngE/VMhRubzxJT4dryDXgcgUqKGwKy09xp5buX8yvXYjBligDlQD6gU
	 Jv0PfDZGy04GZSr3A59XBFxR4iDPpjGk7e5TxsfFDSqlBns0r1wcH/8LQ4ssI4rq/b
	 bBmsB8hOvXSYDxdteT3hlQjEDa49bzZpYn5RwokICVroIqugR0l4CWhT5mljFsM43p
	 l7uNtRojMoO4w==
Received: from apertis.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D15637820AB;
	Tue, 30 Apr 2024 13:20:33 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org,
	sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v7 3/5] media: i2c: add MAX96717 driver
Date: Tue, 30 Apr 2024 15:19:29 +0200
Message-ID: <20240430131931.166012-4-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430131931.166012-1-julien.massot@collabora.com>
References: <20240430131931.166012-1-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver handles the MAX96717 serializer in tunnel mode.
All incoming CSI traffic will be tunneled through the GMSL2
link.

The MAX96717 driver can handle MAX96717 and MAX96717F variants
with the same "maxim,max96717f" compatible.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Change since v6:
 - Kconfig select MEDIA_CONTROLLER, V4L2_FWNODE and VIDEO_V4L2_SUBDEV_API
 - rename 'REG3' register to 'MAX96717_REG3'
 - Initialized 'ret' variable in 'max96717_gpiochip_probe'
 - remove max96714_v4l2_notifier_unregister and call the function directly
 - Do not store private pointer with i2c_set_clientdata since the v4l2-i2c
   uses it to store the subdev pointer
 - use dev_err_probe at gpio chip initialization

Change since v5:
 - set the driver compatible back to MAX96717F that can be used as a fallback for MAX96717

Change since v4:
 - make the driver compatible with MAX96717 instead of MAX96717F
 - Add the device id for the MAX96717
 - remove hw_data structure for now, it can be usefull later for handling different serializers e.g max9295

Change since v3:
 - Maintainers: align to the new binding path
 - Kconfig: better describe the symbol
 - store the v4l2_mbus_config_mipi_csi2 structure instead of the full endpoint in the driver private structure
 - use MAX96717_PAD_SINK/SOURCE instead of 0/1 for pad intialization
 - Removed incorrect call to fwnode_handle_put(priv->sd.fwnode)
 - Use unsigned int instead of u8
 - Allocate clk name out of the clk struct initialization
 - fixed multiline comment
 - Removed one unnecessary goto at the end of the probe function

Change since v2:
 - Use CCI helpers instead of recoding register access
 - add missing bitfield header
---
 MAINTAINERS                  |   7 +
 drivers/media/i2c/Kconfig    |  17 +
 drivers/media/i2c/Makefile   |   1 +
 drivers/media/i2c/max96717.c | 928 +++++++++++++++++++++++++++++++++++
 4 files changed, 953 insertions(+)
 create mode 100644 drivers/media/i2c/max96717.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eea74166a2d9..cfaa904ace59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13426,6 +13426,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
 F:	drivers/staging/media/max96712/max96712.c
 
+MAX96717 GMSL2 SERIALIZER DRIVER
+M:	Julien Massot <julien.massot@collabora.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
+F:	drivers/media/i2c/max96717.c
+
 MAX9860 MONO AUDIO VOICE CODEC DRIVER
 M:	Peter Rosin <peda@axentia.se>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index c6d3ee472d81..9918195e09ba 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1575,6 +1575,23 @@ config VIDEO_DS90UB960
 	  Device driver for the Texas Instruments DS90UB960
 	  FPD-Link III Deserializer and DS90UB9702 FPD-Link IV Deserializer.
 
+config VIDEO_MAX96717
+	tristate "Maxim MAX96717 GMSL2 Serializer support"
+	depends on OF && I2C && VIDEO_DEV && COMMON_CLK
+	select I2C_MUX
+	select MEDIA_CONTROLLER
+	select GPIOLIB
+	select V4L2_CCI_I2C
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  Device driver for the Maxim MAX96717 GMSL2 Serializer.
+	  MAX96717 serializers convert video on a MIPI CSI-2
+	  input to a GMSL2 output.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called max96717.
+
 endmenu
 
 endif # VIDEO_DEV
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index dfbe6448b549..9e007116f929 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_VIDEO_LM3646) += lm3646.o
 obj-$(CONFIG_VIDEO_M52790) += m52790.o
 obj-$(CONFIG_VIDEO_MAX9271_LIB) += max9271.o
 obj-$(CONFIG_VIDEO_MAX9286) += max9286.o
+obj-$(CONFIG_VIDEO_MAX96717) += max96717.o
 obj-$(CONFIG_VIDEO_ML86V7667) += ml86v7667.o
 obj-$(CONFIG_VIDEO_MSP3400) += msp3400.o
 obj-$(CONFIG_VIDEO_MT9M001) += mt9m001.o
diff --git a/drivers/media/i2c/max96717.c b/drivers/media/i2c/max96717.c
new file mode 100644
index 000000000000..1ea76f922bdb
--- /dev/null
+++ b/drivers/media/i2c/max96717.c
@@ -0,0 +1,928 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Maxim GMSL2 Serializer Driver
+ *
+ * Copyright (C) 2024 Collabora Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/fwnode.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c-mux.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include <media/v4l2-cci.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+#define MAX96717_DEVICE_ID  0xbf
+#define MAX96717F_DEVICE_ID 0xc8
+#define MAX96717_PORTS      2
+#define MAX96717_PAD_SINK   0
+#define MAX96717_PAD_SOURCE 1
+
+#define MAX96717_DEFAULT_CLKOUT_RATE	24000000UL
+
+/* DEV */
+#define MAX96717_REG3    CCI_REG8(0x3)
+#define MAX96717_RCLKSEL GENMASK(1, 0)
+#define RCLKSEL_REF_PLL  CCI_REG8(0x3)
+#define MAX96717_REG6    CCI_REG8(0x6)
+#define RCLKEN           BIT(5)
+#define MAX96717_DEV_ID  CCI_REG8(0xd)
+#define MAX96717_DEV_REV CCI_REG8(0xe)
+#define MAX96717_DEV_REV_MASK GENMASK(3, 0)
+
+/* VID_TX Z */
+#define MAX96717_VIDEO_TX2 CCI_REG8(0x112)
+#define MAX96717_VIDEO_PCLKDET BIT(7)
+
+/* GPIO */
+#define MAX96717_NUM_GPIO         11
+#define MAX96717_GPIO_REG_A(gpio) CCI_REG8(0x2be + (gpio) * 3)
+#define MAX96717_GPIO_OUT         BIT(4)
+#define MAX96717_GPIO_IN          BIT(3)
+#define MAX96717_GPIO_RX_EN       BIT(2)
+#define MAX96717_GPIO_TX_EN       BIT(1)
+#define MAX96717_GPIO_OUT_DIS     BIT(0)
+
+/* FRONTTOP */
+/* MAX96717 only have CSI port 'B' */
+#define MAX96717_FRONTOP0     CCI_REG8(0x308)
+#define MAX96717_START_PORT_B BIT(5)
+
+/* MIPI_RX */
+#define MAX96717_MIPI_RX1       CCI_REG8(0x331)
+#define MAX96717_MIPI_LANES_CNT GENMASK(5, 4)
+#define MAX96717_MIPI_RX2       CCI_REG8(0x332) /* phy1 Lanes map */
+#define MAX96717_PHY2_LANES_MAP GENMASK(7, 4)
+#define MAX96717_MIPI_RX3       CCI_REG8(0x333) /* phy2 Lanes map */
+#define MAX96717_PHY1_LANES_MAP GENMASK(3, 0)
+#define MAX96717_MIPI_RX4       CCI_REG8(0x334) /* phy1 lane polarities */
+#define MAX96717_PHY1_LANES_POL GENMASK(6, 4)
+#define MAX96717_MIPI_RX5       CCI_REG8(0x335) /* phy2 lane polarities */
+#define MAX96717_PHY2_LANES_POL GENMASK(2, 0)
+
+/* MIPI_RX_EXT */
+#define MAX96717_MIPI_RX_EXT11 CCI_REG8(0x383)
+#define MAX96717_TUN_MODE      BIT(7)
+
+/* REF_VTG */
+#define REF_VTG0                CCI_REG8(0x3f0)
+#define REFGEN_PREDEF_EN        BIT(6)
+#define REFGEN_PREDEF_FREQ_MASK GENMASK(5, 4)
+#define REFGEN_PREDEF_FREQ_ALT  BIT(3)
+#define REFGEN_RST              BIT(1)
+#define REFGEN_EN               BIT(0)
+
+/* MISC */
+#define PIO_SLEW_1 CCI_REG8(0x570)
+
+struct max96717_priv {
+	struct i2c_client		  *client;
+	struct regmap			  *regmap;
+	struct i2c_mux_core		  *mux;
+	struct v4l2_mbus_config_mipi_csi2 mipi_csi2;
+	struct v4l2_subdev                sd;
+	struct media_pad                  pads[MAX96717_PORTS];
+	struct v4l2_async_notifier        notifier;
+	struct v4l2_subdev                *source_sd;
+	u16                               source_sd_pad;
+	u64			          enabled_source_streams;
+	u8                                pll_predef_index;
+	struct clk_hw                     clk_hw;
+	struct gpio_chip                  gpio_chip;
+};
+
+static inline struct max96717_priv *sd_to_max96717(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct max96717_priv, sd);
+}
+
+static inline struct max96717_priv *clk_hw_to_max96717(struct clk_hw *hw)
+{
+	return container_of(hw, struct max96717_priv, clk_hw);
+}
+
+static int max96717_i2c_mux_select(struct i2c_mux_core *mux, u32 chan)
+{
+	return 0;
+}
+
+static int max96717_i2c_mux_init(struct max96717_priv *priv)
+{
+	priv->mux = i2c_mux_alloc(priv->client->adapter, &priv->client->dev,
+				  1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
+				  max96717_i2c_mux_select, NULL);
+	if (!priv->mux)
+		return -ENOMEM;
+
+	return i2c_mux_add_adapter(priv->mux, 0, 0, 0);
+}
+
+static inline int max96717_start_csi(struct max96717_priv *priv, bool start)
+{
+	return cci_update_bits(priv->regmap, MAX96717_FRONTOP0,
+			       MAX96717_START_PORT_B,
+			       start ? MAX96717_START_PORT_B : 0, NULL);
+}
+
+static int max96717_gpiochip_get(struct gpio_chip *gpiochip,
+				 unsigned int offset)
+{
+	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
+	u64 val;
+	int ret;
+
+	ret = cci_read(priv->regmap, MAX96717_GPIO_REG_A(offset),
+		       &val, NULL);
+	if (ret)
+		return ret;
+
+	if (val & MAX96717_GPIO_OUT_DIS)
+		return !!(val & MAX96717_GPIO_IN);
+	else
+		return !!(val & MAX96717_GPIO_OUT);
+}
+
+static void max96717_gpiochip_set(struct gpio_chip *gpiochip,
+				  unsigned int offset, int value)
+{
+	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
+
+	cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(offset),
+			MAX96717_GPIO_OUT, MAX96717_GPIO_OUT, NULL);
+}
+
+static int max96717_gpio_get_direction(struct gpio_chip *gpiochip,
+				       unsigned int offset)
+{
+	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
+	u64 val;
+	int ret;
+
+	ret = cci_read(priv->regmap, MAX96717_GPIO_REG_A(offset), &val, NULL);
+	if (ret < 0)
+		return ret;
+
+	return !!(val & MAX96717_GPIO_OUT_DIS);
+}
+
+static int max96717_gpio_direction_out(struct gpio_chip *gpiochip,
+				       unsigned int offset, int value)
+{
+	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
+
+	return cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(offset),
+			       MAX96717_GPIO_OUT_DIS | MAX96717_GPIO_OUT,
+			       value ? MAX96717_GPIO_OUT : 0, NULL);
+}
+
+static int max96717_gpio_direction_in(struct gpio_chip *gpiochip,
+				      unsigned int offset)
+{
+	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
+
+	return cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(offset),
+			       MAX96717_GPIO_OUT_DIS, MAX96717_GPIO_OUT_DIS,
+			       NULL);
+}
+
+static int max96717_gpiochip_probe(struct max96717_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	struct gpio_chip *gc = &priv->gpio_chip;
+	int i, ret = 0;
+
+	gc->label = dev_name(dev);
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
+	gc->ngpio = MAX96717_NUM_GPIO;
+	gc->base = -1;
+	gc->can_sleep = true;
+	gc->get_direction = max96717_gpio_get_direction;
+	gc->direction_input = max96717_gpio_direction_in;
+	gc->direction_output = max96717_gpio_direction_out;
+	gc->set = max96717_gpiochip_set;
+	gc->get = max96717_gpiochip_get;
+	gc->of_gpio_n_cells = 2;
+
+	/* Disable GPIO forwarding */
+	for (i = 0; i < gc->ngpio; i++)
+		cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(i),
+				MAX96717_GPIO_RX_EN | MAX96717_GPIO_TX_EN,
+				0, &ret);
+
+	if (ret)
+		return ret;
+
+	ret = devm_gpiochip_add_data(dev, gc, priv);
+	if (ret) {
+		dev_err(dev, "Unable to create gpio_chip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int _max96717_set_routing(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *state,
+				 struct v4l2_subdev_krouting *routing)
+{
+	static const struct v4l2_mbus_framefmt format = {
+		.width = 1280,
+		.height = 1080,
+		.code = MEDIA_BUS_FMT_Y8_1X8,
+		.field = V4L2_FIELD_NONE,
+	};
+	int ret;
+
+	ret = v4l2_subdev_routing_validate(sd, routing,
+					   V4L2_SUBDEV_ROUTING_ONLY_1_TO_1);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int max96717_set_routing(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state,
+				enum v4l2_subdev_format_whence which,
+				struct v4l2_subdev_krouting *routing)
+{
+	struct max96717_priv *priv = sd_to_max96717(sd);
+
+	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && priv->enabled_source_streams)
+		return -EBUSY;
+
+	return _max96717_set_routing(sd, state, routing);
+}
+
+static int max96717_set_fmt(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_state *state,
+			    struct v4l2_subdev_format *format)
+{
+	struct max96717_priv *priv = sd_to_max96717(sd);
+	struct v4l2_mbus_framefmt *fmt;
+	u64 stream_source_mask;
+
+	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE &&
+	    priv->enabled_source_streams)
+		return -EBUSY;
+
+	/* No transcoding, source and sink formats must match. */
+	if (format->pad == MAX96717_PAD_SOURCE)
+		return v4l2_subdev_get_fmt(sd, state, format);
+
+	/* Set sink format */
+	fmt = v4l2_subdev_state_get_format(state, format->pad, format->stream);
+	if (!fmt)
+		return -EINVAL;
+
+	*fmt = format->format;
+
+	/* Propagate to source format */
+	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
+							   format->stream);
+	if (!fmt)
+		return -EINVAL;
+	*fmt = format->format;
+
+	stream_source_mask = BIT(format->stream);
+
+	return v4l2_subdev_state_xlate_streams(state, MAX96717_PAD_SOURCE,
+					       MAX96717_PAD_SINK,
+					       &stream_source_mask);
+}
+
+static int max96717_init_state(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state)
+{
+	struct v4l2_subdev_route routes[] = {
+		{
+			.sink_pad = MAX96717_PAD_SINK,
+			.sink_stream = 0,
+			.source_pad = MAX96717_PAD_SOURCE,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		},
+	};
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
+
+	return _max96717_set_routing(sd, state, &routing);
+}
+
+static bool max96717_pipe_pclkdet(struct max96717_priv *priv)
+{
+	u64 val = 0;
+
+	cci_read(priv->regmap, MAX96717_VIDEO_TX2, &val, NULL);
+
+	return val & MAX96717_VIDEO_PCLKDET;
+}
+
+static int max96717_log_status(struct v4l2_subdev *sd)
+{
+	struct max96717_priv *priv = sd_to_max96717(sd);
+	struct device *dev = &priv->client->dev;
+
+	dev_info(dev, "Serializer: max96717\n");
+	dev_info(dev, "Pipe: pclkdet:%d\n", max96717_pipe_pclkdet(priv));
+
+	return 0;
+}
+
+static int max96717_enable_streams(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *state, u32 pad,
+				   u64 streams_mask)
+{
+	struct max96717_priv *priv = sd_to_max96717(sd);
+	struct device *dev = &priv->client->dev;
+	u64 sink_streams;
+	int ret;
+
+	sink_streams = v4l2_subdev_state_xlate_streams(state,
+						       MAX96717_PAD_SOURCE,
+						       MAX96717_PAD_SINK,
+						       &streams_mask);
+
+	if (!priv->enabled_source_streams)
+		max96717_start_csi(priv, true);
+
+	ret = v4l2_subdev_enable_streams(priv->source_sd, priv->source_sd_pad,
+					 sink_streams);
+	if (ret) {
+		dev_err(dev, "Fail to start streams:%llu on remote subdev\n",
+			sink_streams);
+		goto stop_csi;
+	}
+
+	priv->enabled_source_streams |= streams_mask;
+
+	return 0;
+
+stop_csi:
+	if (!priv->enabled_source_streams)
+		max96717_start_csi(priv, false);
+	return ret;
+}
+
+static int max96717_disable_streams(struct v4l2_subdev *sd,
+				    struct v4l2_subdev_state *state, u32 pad,
+				    u64 streams_mask)
+{
+	struct max96717_priv *priv = sd_to_max96717(sd);
+	u64 sink_streams;
+	int ret;
+
+	sink_streams = v4l2_subdev_state_xlate_streams(state,
+						       MAX96717_PAD_SOURCE,
+						       MAX96717_PAD_SINK,
+						       &streams_mask);
+
+	ret = v4l2_subdev_disable_streams(priv->source_sd, priv->source_sd_pad,
+					  sink_streams);
+	if (ret)
+		return ret;
+
+	priv->enabled_source_streams &= ~streams_mask;
+
+	if (!priv->enabled_source_streams)
+		max96717_start_csi(priv, false);
+
+	return 0;
+}
+
+static const struct v4l2_subdev_pad_ops max96717_pad_ops = {
+	.enable_streams = max96717_enable_streams,
+	.disable_streams = max96717_disable_streams,
+	.set_routing = max96717_set_routing,
+	.get_fmt = v4l2_subdev_get_fmt,
+	.set_fmt = max96717_set_fmt,
+};
+
+static const struct v4l2_subdev_core_ops max96717_subdev_core_ops = {
+	.log_status = max96717_log_status,
+};
+
+static const struct v4l2_subdev_internal_ops max96717_internal_ops = {
+	.init_state = max96717_init_state,
+};
+
+static const struct v4l2_subdev_ops max96717_subdev_ops = {
+	.core = &max96717_subdev_core_ops,
+	.pad = &max96717_pad_ops,
+};
+
+static const struct media_entity_operations max96717_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static int max96717_notify_bound(struct v4l2_async_notifier *notifier,
+				 struct v4l2_subdev *source_subdev,
+				 struct v4l2_async_connection *asd)
+{
+	struct max96717_priv *priv = sd_to_max96717(notifier->sd);
+	struct device *dev = &priv->client->dev;
+	int ret;
+
+	ret = media_entity_get_fwnode_pad(&source_subdev->entity,
+					  source_subdev->fwnode,
+					  MEDIA_PAD_FL_SOURCE);
+	if (ret < 0) {
+		dev_err(dev, "Failed to find pad for %s\n",
+			source_subdev->name);
+		return ret;
+	}
+
+	priv->source_sd = source_subdev;
+	priv->source_sd_pad = ret;
+
+	ret = media_create_pad_link(&source_subdev->entity, priv->source_sd_pad,
+				    &priv->sd.entity, 0,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret) {
+		dev_err(dev, "Unable to link %s:%u -> %s:0\n",
+			source_subdev->name, priv->source_sd_pad,
+			priv->sd.name);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations max96717_notify_ops = {
+	.bound = max96717_notify_bound,
+};
+
+static int max96717_v4l2_notifier_register(struct max96717_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	struct v4l2_async_connection *asd;
+	struct fwnode_handle *ep_fwnode;
+	int ret;
+
+	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
+						    MAX96717_PAD_SINK, 0, 0);
+	if (!ep_fwnode) {
+		dev_err(dev, "No graph endpoint\n");
+		return -ENODEV;
+	}
+
+	v4l2_async_subdev_nf_init(&priv->notifier, &priv->sd);
+
+	asd = v4l2_async_nf_add_fwnode_remote(&priv->notifier, ep_fwnode,
+					      struct v4l2_async_connection);
+
+	fwnode_handle_put(ep_fwnode);
+
+	if (IS_ERR(asd)) {
+		dev_err(dev, "Failed to add subdev: %ld", PTR_ERR(asd));
+		v4l2_async_nf_cleanup(&priv->notifier);
+		return PTR_ERR(asd);
+	}
+
+	priv->notifier.ops = &max96717_notify_ops;
+
+	ret = v4l2_async_nf_register(&priv->notifier);
+	if (ret) {
+		dev_err(dev, "Failed to register subdev_notifier");
+		v4l2_async_nf_cleanup(&priv->notifier);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max96717_subdev_init(struct max96717_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	int ret;
+
+	v4l2_i2c_subdev_init(&priv->sd, priv->client, &max96717_subdev_ops);
+	priv->sd.internal_ops = &max96717_internal_ops;
+
+	priv->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_STREAMS;
+	priv->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	priv->sd.entity.ops = &max96717_entity_ops;
+
+	priv->pads[MAX96717_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	priv->pads[MAX96717_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
+
+	ret = media_entity_pads_init(&priv->sd.entity, 2, priv->pads);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init pads\n");
+
+	ret = v4l2_subdev_init_finalize(&priv->sd);
+	if (ret) {
+		dev_err_probe(dev, ret,
+			      "v4l2 subdev init finalized failed\n");
+		goto err_entity_cleanup;
+	}
+	ret = max96717_v4l2_notifier_register(priv);
+	if (ret) {
+		dev_err_probe(dev, ret,
+			      "v4l2 subdev notifier register failed\n");
+		goto err_free_state;
+	}
+
+	ret = v4l2_async_register_subdev(&priv->sd);
+	if (ret) {
+		dev_err_probe(dev, ret, "v4l2_async_register_subdev error\n");
+		goto err_unreg_notif;
+	}
+
+	return 0;
+
+err_unreg_notif:
+	v4l2_async_nf_unregister(&priv->notifier);
+	v4l2_async_nf_cleanup(&priv->notifier);
+err_free_state:
+	v4l2_subdev_cleanup(&priv->sd);
+err_entity_cleanup:
+	media_entity_cleanup(&priv->sd.entity);
+
+	return ret;
+}
+
+static void max96717_subdev_uninit(struct max96717_priv *priv)
+{
+	v4l2_async_unregister_subdev(&priv->sd);
+	v4l2_async_nf_unregister(&priv->notifier);
+	v4l2_async_nf_cleanup(&priv->notifier);
+	v4l2_subdev_cleanup(&priv->sd);
+	media_entity_cleanup(&priv->sd.entity);
+}
+
+struct max96717_pll_predef_freq {
+	unsigned long freq;
+	bool is_alt;
+	u8 val;
+};
+
+static const struct max96717_pll_predef_freq max96717_predef_freqs[] = {
+	{ 13500000, true,  0 }, { 19200000, false, 0 },
+	{ 24000000, true,  1 }, { 27000000, false, 1 },
+	{ 37125000, false, 2 }, { 74250000, false, 3 },
+};
+
+static unsigned long
+max96717_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct max96717_priv *priv = clk_hw_to_max96717(hw);
+
+	return max96717_predef_freqs[priv->pll_predef_index].freq;
+}
+
+static unsigned int max96717_clk_find_best_index(struct max96717_priv *priv,
+						 unsigned long rate)
+{
+	unsigned int i, idx;
+	unsigned long diff_new, diff_old;
+
+	diff_old = U32_MAX;
+	idx = 0;
+
+	for (i = 0; i < ARRAY_SIZE(max96717_predef_freqs); i++) {
+		diff_new = abs(rate - max96717_predef_freqs[i].freq);
+		if (diff_new < diff_old) {
+			diff_old = diff_new;
+			idx = i;
+		}
+	}
+
+	return idx;
+}
+
+static long max96717_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *parent_rate)
+{
+	struct max96717_priv *priv = clk_hw_to_max96717(hw);
+	struct device *dev = &priv->client->dev;
+	unsigned int idx;
+
+	idx = max96717_clk_find_best_index(priv, rate);
+
+	if (rate != max96717_predef_freqs[idx].freq) {
+		dev_warn(dev, "Request CLK freq:%lu, found CLK freq:%lu\n",
+			 rate, max96717_predef_freqs[idx].freq);
+	}
+
+	return max96717_predef_freqs[idx].freq;
+}
+
+static int max96717_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct max96717_priv *priv = clk_hw_to_max96717(hw);
+	unsigned int val, idx;
+	int ret = 0;
+
+	idx = max96717_clk_find_best_index(priv, rate);
+
+	val = FIELD_PREP(REFGEN_PREDEF_FREQ_MASK,
+			 max96717_predef_freqs[idx].val);
+
+	if (max96717_predef_freqs[idx].is_alt)
+		val |= REFGEN_PREDEF_FREQ_ALT;
+
+	val |= REFGEN_RST | REFGEN_PREDEF_EN;
+
+	cci_write(priv->regmap, REF_VTG0, val, &ret);
+	cci_update_bits(priv->regmap, REF_VTG0, REFGEN_RST | REFGEN_EN,
+			REFGEN_EN, &ret);
+	if (ret)
+		return ret;
+
+	priv->pll_predef_index = idx;
+
+	return 0;
+}
+
+static int max96717_clk_prepare(struct clk_hw *hw)
+{
+	struct max96717_priv *priv = clk_hw_to_max96717(hw);
+
+	return cci_update_bits(priv->regmap, MAX96717_REG6, RCLKEN,
+			       RCLKEN, NULL);
+}
+
+static void max96717_clk_unprepare(struct clk_hw *hw)
+{
+	struct max96717_priv *priv = clk_hw_to_max96717(hw);
+
+	cci_update_bits(priv->regmap, MAX96717_REG6, RCLKEN, 0, NULL);
+}
+
+static const struct clk_ops max96717_clk_ops = {
+	.prepare     = max96717_clk_prepare,
+	.unprepare   = max96717_clk_unprepare,
+	.set_rate    = max96717_clk_set_rate,
+	.recalc_rate = max96717_clk_recalc_rate,
+	.round_rate  = max96717_clk_round_rate,
+};
+
+static int max96717_register_clkout(struct max96717_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	struct clk_init_data init = { .ops = &max96717_clk_ops };
+	int ret;
+
+	init.name = kasprintf(GFP_KERNEL, "max96717.%s.clk_out",
+			      dev_name(dev));
+	if (!init.name)
+		return -ENOMEM;
+
+	/* RCLKSEL Reference PLL output */
+	ret = cci_update_bits(priv->regmap, MAX96717_REG3, MAX96717_RCLKSEL,
+			      MAX96717_RCLKSEL, NULL);
+	/* MFP4 fastest slew rate */
+	cci_update_bits(priv->regmap, PIO_SLEW_1, BIT(5) | BIT(4), 0, &ret);
+	if (ret)
+		goto free_init_name;
+
+	priv->clk_hw.init = &init;
+
+	/* Initialize to 24 MHz */
+	ret = max96717_clk_set_rate(&priv->clk_hw,
+				    MAX96717_DEFAULT_CLKOUT_RATE, 0);
+	if (ret < 0)
+		goto free_init_name;
+
+	ret = devm_clk_hw_register(dev, &priv->clk_hw);
+	kfree(init.name);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register clock HW\n");
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &priv->clk_hw);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot add OF clock provider\n");
+
+	return 0;
+
+free_init_name:
+	kfree(init.name);
+	return ret;
+}
+
+static int max96717_init_csi_lanes(struct max96717_priv *priv)
+{
+	struct v4l2_mbus_config_mipi_csi2 *mipi = &priv->mipi_csi2;
+	unsigned long lanes_used = 0;
+	unsigned int nlanes, lane, val = 0;
+	int ret;
+
+	nlanes = mipi->num_data_lanes;
+
+	ret = cci_update_bits(priv->regmap, MAX96717_MIPI_RX1,
+			      MAX96717_MIPI_LANES_CNT,
+			      FIELD_PREP(MAX96717_MIPI_LANES_CNT,
+					 nlanes - 1), NULL);
+
+	/* lanes polarity */
+	for (lane = 0; lane < nlanes + 1; lane++) {
+		if (!mipi->lane_polarities[lane])
+			continue;
+		/* Clock lane */
+		if (lane == 0)
+			val |= BIT(2);
+		else if (lane < 3)
+			val |= BIT(lane - 1);
+		else
+			val |= BIT(lane);
+	}
+
+	cci_update_bits(priv->regmap, MAX96717_MIPI_RX5,
+			MAX96717_PHY2_LANES_POL,
+			FIELD_PREP(MAX96717_PHY2_LANES_POL, val), &ret);
+
+	cci_update_bits(priv->regmap, MAX96717_MIPI_RX4,
+			MAX96717_PHY1_LANES_POL,
+			FIELD_PREP(MAX96717_PHY1_LANES_POL,
+				   val >> 3), &ret);
+	/* lanes mapping */
+	for (lane = 0, val = 0; lane < nlanes; lane++) {
+		val |= (mipi->data_lanes[lane] - 1) << (lane * 2);
+		lanes_used |= BIT(mipi->data_lanes[lane] - 1);
+	}
+
+	/*
+	 * Unused lanes need to be mapped as well to not have
+	 * the same lanes mapped twice.
+	 */
+	for (; lane < 4; lane++) {
+		unsigned int idx = find_first_zero_bit(&lanes_used, 4);
+
+		val |= idx << (lane * 2);
+		lanes_used |= BIT(idx);
+	}
+
+	cci_update_bits(priv->regmap, MAX96717_MIPI_RX3,
+			MAX96717_PHY1_LANES_MAP,
+			FIELD_PREP(MAX96717_PHY1_LANES_MAP, val), &ret);
+
+	return cci_update_bits(priv->regmap, MAX96717_MIPI_RX2,
+			       MAX96717_PHY2_LANES_MAP,
+			       FIELD_PREP(MAX96717_PHY2_LANES_MAP, val >> 4),
+			       &ret);
+}
+
+static int max96717_hw_init(struct max96717_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	u64 dev_id, val;
+	int ret;
+
+	ret = cci_read(priv->regmap, MAX96717_DEV_ID, &dev_id, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Fail to read the device id\n");
+
+	if (dev_id != MAX96717_DEVICE_ID && dev_id != MAX96717F_DEVICE_ID)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "Unsupported device id got %x\n", (u8)dev_id);
+
+	ret = cci_read(priv->regmap, MAX96717_DEV_REV, &val, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Fail to read device revision");
+
+	dev_dbg(dev, "Found %x (rev %lx)\n", (u8)dev_id,
+		(u8)val & MAX96717_DEV_REV_MASK);
+
+	ret = cci_read(priv->regmap, MAX96717_MIPI_RX_EXT11, &val, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Fail to read mipi rx extension");
+
+	if (!(val & MAX96717_TUN_MODE))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "Only supporting tunnel mode");
+
+	return max96717_init_csi_lanes(priv);
+}
+
+static int max96717_parse_dt(struct max96717_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	struct v4l2_fwnode_endpoint vep = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY
+	};
+	struct fwnode_handle *ep_fwnode;
+	unsigned char num_data_lanes;
+	int ret;
+
+	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
+						    MAX96717_PAD_SINK, 0, 0);
+	if (!ep_fwnode)
+		return dev_err_probe(dev, -ENOENT, "no endpoint found\n");
+
+	ret = v4l2_fwnode_endpoint_parse(ep_fwnode, &vep);
+
+	fwnode_handle_put(ep_fwnode);
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to parse sink endpoint");
+
+	num_data_lanes = vep.bus.mipi_csi2.num_data_lanes;
+	if (num_data_lanes < 1 || num_data_lanes > 4)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid data lanes must be 1 to 4\n");
+
+	memcpy(&priv->mipi_csi2, &vep.bus.mipi_csi2, sizeof(priv->mipi_csi2));
+
+	return 0;
+}
+
+static int max96717_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max96717_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client = client;
+	priv->regmap = devm_cci_regmap_init_i2c(client, 16);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		return dev_err_probe(dev, ret, "Failed to init regmap\n");
+	}
+
+	ret = max96717_parse_dt(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to parse the dt\n");
+
+	ret = max96717_hw_init(priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize the hardware\n");
+
+	ret = max96717_gpiochip_probe(priv);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to init gpiochip\n");
+
+	ret = max96717_register_clkout(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register clkout\n");
+
+	ret = max96717_subdev_init(priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize v4l2 subdev\n");
+
+	ret = max96717_i2c_mux_init(priv);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to add remote i2c adapter\n");
+		max96717_subdev_uninit(priv);
+	}
+
+	return ret;
+}
+
+static void max96717_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct max96717_priv *priv = sd_to_max96717(sd);
+
+	max96717_subdev_uninit(priv);
+	i2c_mux_del_adapters(priv->mux);
+}
+
+static const struct of_device_id max96717_of_ids[] = {
+	{ .compatible = "maxim,max96717f" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max96717_of_ids);
+
+static struct i2c_driver max96717_i2c_driver = {
+	.driver	= {
+		.name		= "max96717",
+		.of_match_table	= max96717_of_ids,
+	},
+	.probe		= max96717_probe,
+	.remove		= max96717_remove,
+};
+
+module_i2c_driver(max96717_i2c_driver);
+
+MODULE_DESCRIPTION("Maxim GMSL2 MAX96717 Serializer Driver");
+MODULE_AUTHOR("Julien Massot <julien.massot@collabora.com>");
+MODULE_LICENSE("GPL");
-- 
2.44.0


