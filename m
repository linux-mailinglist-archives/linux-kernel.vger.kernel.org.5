Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD575B328
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGTPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjGTPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:40:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C809CE;
        Thu, 20 Jul 2023 08:40:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso1311873a12.0;
        Thu, 20 Jul 2023 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689867620; x=1690472420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUx3A8FIoBB53S84tpBJAoTnFo/vG6V58ims09IskbU=;
        b=DQ8XICGXeqrGQ8WWcGo9kZZInA4eiX4DddHhm9KzvESJ9yeZFcp1797hsSGdcUQLJv
         CGlImLM/FZ9CJCLC9mcbb2ydxDhm1ARtx7CCVMeKxnvVsxHzLpfJ74t9/nWYAcIZH0Kl
         wwNmFs2Nx9xdbk0+TGFoRWDUDC8p4S42qusLrPb9OPeuecGb8JpAxLufT7V7L9SIzqIm
         KROcdAYjaVv/zyBiFEjnsZm4zpbtUr8NvJm1DXF0vB56SpCwIS8EAXIcRmIkeqdeUPHo
         EZaKQ8MrUnzv0Fe63e7XtpJ7QSvyMDw0daogGMeM8N71oE2mptfsbIsnx3kUshaklcY7
         bbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867620; x=1690472420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUx3A8FIoBB53S84tpBJAoTnFo/vG6V58ims09IskbU=;
        b=JXGZYDFFj3/YU51/Dv/JuKpNmPchza6tvBC7bEOsI/p95QIdcoFPrwkqo6HNH1J4dr
         M2apxQBEx0ix0ZIyhDrI2IWA2zk/c0nxjpNA+jk/DHMlR4Nz4zYskOxsCYuzhYz7MSfG
         pYQNLilafzbBILgYxzkoQCFj9d2quikM81+C5cj9HX1acNNKlxSujJqbBXwP6P2rV+ak
         27sXoWIukp3Ot6rOdbDgfNSB2VyrjN51i5vl6Ls0m61G2Xits6GuQ/BkitNFfLVWHhHj
         Q8wwWSKk4n9phmlRCE+qOVzDNy50w4Du0sgYCrnMeThpfestsRfRbMWJgvcZHzKhgOla
         fIYA==
X-Gm-Message-State: ABy/qLaBruoBsqgjGbjA9u20jwKII+JuypE35C8hMlGFDyfg0LTezefD
        yAEvA+bNXWjd7G+73t5PsartDJWZNp6Egw==
X-Google-Smtp-Source: APBJJlHplKDbuUkVe25Xs9Kl/TFAtbBqdWlxEazUFRzoaJga/D4rKF3Qsbn0uNZP4a2xJoFbZmniVw==
X-Received: by 2002:aa7:c6c8:0:b0:521:788f:66ff with SMTP id b8-20020aa7c6c8000000b00521788f66ffmr2364108eds.23.1689867619845;
        Thu, 20 Jul 2023 08:40:19 -0700 (PDT)
Received: from colla-nuc.fritz.box (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7cfd3000000b0051de018af1esm910827edy.59.2023.07.20.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:40:19 -0700 (PDT)
Received: from colla-nuc.fritz.box (localhost [127.0.0.1])
        by colla-nuc.fritz.box (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 36KFeIeZ119650;
        Thu, 20 Jul 2023 17:40:18 +0200
Received: (from colla@localhost)
        by colla-nuc.fritz.box (8.15.2/8.15.2/Submit) id 36KFeInS119649;
        Thu, 20 Jul 2023 17:40:18 +0200
From:   Andrea Collamati <andrea.collamati@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrea Collamati <andrea.collamati@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: add MCP4728 I2C DAC driver
Date:   Thu, 20 Jul 2023 17:40:03 +0200
Message-Id: <3d08130fcb093fea3f755848690db9b2c8e1cb75.1689857295.git.andrea.collamati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689857295.git.andrea.collamati@gmail.com>
References: <cover.1689857295.git.andrea.collamati@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP4728 is a 12-bit quad channel DAC with I2C interface.

support for:
  * per-channel gain
  * per-channel power state
  * per-channel power down mode control
  * per-channel vref selection internal/vdd
  * store current state to on-chip EEPROM

Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
---
 drivers/iio/dac/Kconfig   |  11 +
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/mcp4728.c | 638 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 650 insertions(+)
 create mode 100644 drivers/iio/dac/mcp4728.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 3acd9c3f388e..93b8be183de6 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -389,6 +389,17 @@ config MCP4725
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4725.
 
+config MCP4728
+	tristate "MCP4728 DAC driver"
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Microchip
+	  MCP4728 quad channel, 12-bit digital-to-analog converter (DAC)
+	  with I2C interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mcp4728.
+
 config MCP4922
 	tristate "MCP4902, MCP4912, MCP4922 DAC driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index addd97a78838..5b2bac900d5a 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX5522) += max5522.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
+obj-$(CONFIG_MCP4728) += mcp4728.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
 obj-$(CONFIG_STM32_DAC) += stm32-dac.o
diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
new file mode 100644
index 000000000000..39237dba27ba
--- /dev/null
+++ b/drivers/iio/dac/mcp4728.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for Microchip MCP4728
+ *
+ * Copyright (C) 2023 Andrea Collamati <andrea.collamati@gmail.com>
+ *
+ * Based on mcp4725 by Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * Driver for the Microchip I2C 12-bit digital-to-analog quad channels
+ * converter (DAC).
+ *
+ * (7-bit I2C slave address 0x60, the three LSBs can be configured in
+ * hardware)
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define MCP4728_DRV_NAME "mcp4728"
+
+#define MCP4728_RESOLUTION 12
+#define MCP4728_N_CHANNELS 4
+
+#define MCP4728_CMD_POS 3
+#define MCP4728_CMD_UDAC_POS 0
+#define MCP4728_CMD_CH_SEL_POS 1
+
+#define MCP4728_CMD_VREF_MASK 0x80
+#define MCP4728_CMD_VREF_POS 7
+
+#define MCP4728_CMD_PDMODE_MASK 0x60
+#define MCP4728_CMD_PDMODE_POS 5
+
+#define MCP4728_CMD_GAIN_MASK 0x10
+#define MCP4728_CMD_GAIN_POS 4
+
+#define MCP4728_MW_CMD 0x08 // Multiwrite Command
+#define MCP4728_SW_CMD 0x0A // Sequential Write Command (include eeprom)
+
+#define MCP4728_READ_RESPONSE_LEN (MCP4728_N_CHANNELS * 3 * 2)
+#define MCP4728_WRITE_EEPROM_LEN (1 + MCP4728_N_CHANNELS * 2)
+
+enum vref_mode {
+	MCP4728_VREF_EXTERNAL_VDD = 0,
+	MCP4728_VRED_INTERNAL_2048mV = 1,
+};
+
+enum gain_mode {
+	MCP4728_GAIN_X1 = 0,
+	MCP4728_GAIN_X2 = 1,
+};
+
+enum iio_powerdown_mode {
+	MCP4728_IIO_1K,
+	MCP4728_IIO_100K,
+	MCP4728_IIO_500K,
+};
+
+struct mcp4728_channel_data {
+	enum vref_mode ref_mode;
+	enum iio_powerdown_mode pd_mode;
+	enum gain_mode g_mode;
+	u16 dac_value;
+};
+
+struct mcp4728_data {
+	struct i2c_client *client;
+	struct regulator *vdd_reg;
+	bool powerdown;
+	struct mcp4728_channel_data channel_data[MCP4728_N_CHANNELS];
+};
+
+#define MCP4728_CHAN(chan) {					\
+	.type = IIO_VOLTAGE,					\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = chan,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = mcp4728_ext_info,				\
+}
+
+static int mcp4728_suspend(struct device *dev);
+static int mcp4728_resume(struct device *dev);
+
+static ssize_t mcp4728_store_eeprom(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	u8 outbuf[MCP4728_WRITE_EEPROM_LEN];
+	int tries = 20;
+	u8 inbuf[3];
+	bool state;
+	int ret;
+	unsigned int i;
+
+	ret = kstrtobool(buf, &state);
+	if (ret < 0)
+		return ret;
+
+	if (!state)
+		return 0;
+
+	outbuf[0] = MCP4728_SW_CMD << MCP4728_CMD_POS; // Command ID
+
+	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
+		struct mcp4728_channel_data *ch = &data->channel_data[i];
+		int offset = 1 + i * 2;
+
+		outbuf[offset] = ch->ref_mode << MCP4728_CMD_VREF_POS;
+		if (data->powerdown) {
+			u8 mcp4728_pd_mode = ch->pd_mode + 1;
+
+			outbuf[offset] |= mcp4728_pd_mode
+					  << MCP4728_CMD_PDMODE_POS;
+		}
+
+		outbuf[offset] |= ch->g_mode << MCP4728_CMD_GAIN_POS;
+		outbuf[offset] |= ch->dac_value >> 8;
+		outbuf[offset + 1] = ch->dac_value & 0xff;
+	}
+
+	ret = i2c_master_send(data->client, outbuf, MCP4728_WRITE_EEPROM_LEN);
+	if (ret < 0)
+		return ret;
+	else if (ret != MCP4728_WRITE_EEPROM_LEN)
+		return -EIO;
+
+	/* wait RDY signal for write complete, takes up to 50ms */
+	while (tries--) {
+		msleep(20);
+		ret = i2c_master_recv(data->client, inbuf, 3);
+		if (ret < 0)
+			return ret;
+		else if (ret != 3)
+			return -EIO;
+
+		if (inbuf[0] & 0x80) // check RDY flag
+			break;
+	}
+
+	if (tries < 0) {
+		dev_err(&data->client->dev, "%s failed, incomplete\n",
+			__func__);
+		return -EIO;
+	}
+	return len;
+}
+
+static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp4728_store_eeprom, 0);
+
+static struct attribute *mcp4728_attributes[] = {
+	&iio_dev_attr_store_eeprom.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group mcp4728_attribute_group = {
+	.attrs = mcp4728_attributes,
+};
+
+enum chip_id {
+	MCP4728,
+};
+
+static int mcp4728_program_channel_cfg(int channel, struct iio_dev *indio_dev)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	struct mcp4728_channel_data *ch = &data->channel_data[channel];
+	u8 outbuf[3];
+	int ret;
+
+	outbuf[0] = MCP4728_MW_CMD << MCP4728_CMD_POS; // Command ID
+	outbuf[0] |= channel << MCP4728_CMD_CH_SEL_POS; // Channel Selector
+	outbuf[0] |= 0; // UDAC = 0
+
+	outbuf[1] = ch->ref_mode << MCP4728_CMD_VREF_POS;
+
+	if (data->powerdown) {
+		u8 mcp4728_pd_mode = ch->pd_mode + 1;
+
+		outbuf[1] |= mcp4728_pd_mode << MCP4728_CMD_PDMODE_POS;
+	}
+
+	outbuf[1] |= ch->g_mode << MCP4728_CMD_GAIN_POS;
+	outbuf[1] |= ch->dac_value >> 8;
+	outbuf[2] = ch->dac_value & 0xff;
+
+	ret = i2c_master_send(data->client, outbuf, 3);
+	if (ret < 0)
+		return ret;
+	else if (ret != 3)
+		return -EIO;
+	else
+		return 0;
+}
+
+// powerdown mode
+static const char *const mcp4728_powerdown_modes[] = { "1kohm_to_gnd",
+						       "100kohm_to_gnd",
+						       "500kohm_to_gnd" };
+
+static int mcp4728_get_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	return data->channel_data[chan->channel].pd_mode;
+}
+
+static int mcp4728_set_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      unsigned int mode)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	data->channel_data[chan->channel].pd_mode = mode;
+
+	return 0;
+}
+
+static ssize_t mcp4728_read_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      char *buf)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", data->powerdown);
+}
+
+static ssize_t mcp4728_write_powerdown(struct iio_dev *indio_dev,
+				       uintptr_t private,
+				       const struct iio_chan_spec *chan,
+				       const char *buf, size_t len)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	bool state;
+	int ret;
+
+	ret = kstrtobool(buf, &state);
+	if (ret)
+		return ret;
+
+	if (state)
+		ret = mcp4728_suspend(&data->client->dev);
+	else
+		ret = mcp4728_resume(&data->client->dev);
+
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static const struct iio_enum mcp4728_powerdown_mode_enum = {
+	.items = mcp4728_powerdown_modes,
+	.num_items = ARRAY_SIZE(mcp4728_powerdown_modes),
+	.get = mcp4728_get_powerdown_mode,
+	.set = mcp4728_set_powerdown_mode,
+};
+
+// vref mode
+static const char *const mcp4728_vref_modes[] = {
+	"vdd_ext",
+	"internal",
+};
+
+static int mcp4728_get_vref_mode(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	return data->channel_data[chan->channel].ref_mode;
+}
+
+static int mcp4728_set_vref_mode(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 unsigned int mode)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	int ret;
+
+	data->channel_data[chan->channel].ref_mode = mode;
+
+	if (mode == MCP4728_VREF_EXTERNAL_VDD &&
+	    data->channel_data[chan->channel].g_mode == MCP4728_GAIN_X2) {
+		dev_warn(&data->client->dev,
+			 "CH%d: Gain x2 not effective when vref is vdd, force to x1",
+			 chan->channel);
+		data->channel_data[chan->channel].g_mode = MCP4728_GAIN_X1;
+	}
+
+	ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
+
+	return ret;
+}
+
+static const struct iio_enum mcp4728_vref_mode_enum = {
+	.items = mcp4728_vref_modes,
+	.num_items = ARRAY_SIZE(mcp4728_vref_modes),
+	.get = mcp4728_get_vref_mode,
+	.set = mcp4728_set_vref_mode,
+};
+
+// gain
+static const char *const mcp4728_gain_modes[] = {
+	"x1",
+	"x2",
+};
+
+static int mcp4728_get_gain_mode(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	return data->channel_data[chan->channel].g_mode;
+}
+
+static int mcp4728_set_gain_mode(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 unsigned int mode)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (mode == MCP4728_GAIN_X2 &&
+	    data->channel_data[chan->channel].ref_mode ==
+		    MCP4728_VREF_EXTERNAL_VDD) {
+		dev_err(&data->client->dev,
+			"CH%d: Gain x2 not effective when vref is vdd",
+			chan->channel);
+		return -EINVAL;
+	}
+
+	data->channel_data[chan->channel].g_mode = mode;
+
+	ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
+
+	return ret;
+}
+
+static const struct iio_enum mcp4728_gain_mode_enum = {
+	.items = mcp4728_gain_modes,
+	.num_items = ARRAY_SIZE(mcp4728_gain_modes),
+	.get = mcp4728_get_gain_mode,
+	.set = mcp4728_set_gain_mode,
+};
+
+static const struct iio_chan_spec_ext_info mcp4728_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = mcp4728_read_powerdown,
+		.write = mcp4728_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp4728_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &mcp4728_powerdown_mode_enum),
+	IIO_ENUM("vref_mode", IIO_SEPARATE, &mcp4728_vref_mode_enum),
+	IIO_ENUM_AVAILABLE("vref_mode", IIO_SHARED_BY_TYPE,
+			   &mcp4728_vref_mode_enum),
+	IIO_ENUM("gain_mode", IIO_SEPARATE, &mcp4728_gain_mode_enum),
+	IIO_ENUM_AVAILABLE("gain_mode", IIO_SHARED_BY_TYPE,
+			   &mcp4728_gain_mode_enum),
+	{},
+};
+
+static const struct iio_chan_spec mcp4728_channels[MCP4728_N_CHANNELS] = {
+	MCP4728_CHAN(0),
+	MCP4728_CHAN(1),
+	MCP4728_CHAN(2),
+	MCP4728_CHAN(3),
+};
+
+static int mcp4728_full_scale_mV(u32 *full_scale_mV, int channel,
+				 struct mcp4728_data *data)
+{
+	int ret;
+
+	if (data->channel_data[channel].ref_mode == MCP4728_VREF_EXTERNAL_VDD)
+		ret = regulator_get_voltage(data->vdd_reg);
+	else
+		ret = 2048000;
+
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		return -EINVAL;
+
+	*full_scale_mV = ret / 1000;
+	return 0;
+}
+
+static u32 mcp4728_raw_to_mV(u32 raw, int channel, struct mcp4728_data *data)
+{
+	int ret;
+	u32 full_scale_mV;
+
+	ret = mcp4728_full_scale_mV(&full_scale_mV, channel, data);
+	if (ret)
+		return ret;
+
+	return (((raw + 1) * full_scale_mV) >> MCP4728_RESOLUTION);
+}
+
+static int mcp4728_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = data->channel_data[chan->channel].dac_value;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (data->channel_data[chan->channel].ref_mode ==
+		    MCP4728_VREF_EXTERNAL_VDD)
+			ret = regulator_get_voltage(data->vdd_reg);
+		else
+			ret = 2048000;
+
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;
+		*val2 = MCP4728_RESOLUTION;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+	return -EINVAL;
+}
+
+static int mcp4728_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > GENMASK(MCP4728_RESOLUTION - 1, 0))
+			return -EINVAL;
+		data->channel_data[chan->channel].dac_value = val;
+		ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info mcp4728_info = {
+	.read_raw = mcp4728_read_raw,
+	.write_raw = mcp4728_write_raw,
+	.attrs = &mcp4728_attribute_group,
+};
+
+static int mcp4728_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	int err = 0;
+	unsigned int i;
+
+	data->powerdown = true;
+
+	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
+		int ret = mcp4728_program_channel_cfg(i, indio_dev);
+
+		if (ret)
+			err = ret;
+	}
+	return err;
+}
+
+static int mcp4728_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	int err = 0;
+	unsigned int i;
+
+	data->powerdown = false;
+
+	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
+		int ret = mcp4728_program_channel_cfg(i, indio_dev);
+
+		if (ret)
+			err = ret;
+	}
+	return err;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mcp4728_pm_ops, mcp4728_suspend,
+				mcp4728_resume);
+
+static int mcp4728_init_channels_data(struct mcp4728_data *data)
+{
+	u8 inbuf[MCP4728_READ_RESPONSE_LEN];
+	int ret;
+	unsigned int i;
+
+	ret = i2c_master_recv(data->client, inbuf, MCP4728_READ_RESPONSE_LEN);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"failed to read mcp4728 conf. Err=%d\n", ret);
+		return ret;
+	} else if (ret != MCP4728_READ_RESPONSE_LEN) {
+		dev_err(&data->client->dev,
+			"failed to read mcp4728 conf. Wrong Response Len ret=%d\n",
+			ret);
+		return -EIO;
+	}
+
+	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
+		struct mcp4728_channel_data *ch = &data->channel_data[i];
+		u8 r2 = inbuf[i * 6 + 1];
+		u8 r3 = inbuf[i * 6 + 2];
+		u32 dac_mv;
+
+		ch->dac_value = (r2 & 0x0F) << 8 | r3;
+		ch->ref_mode = (r2 & MCP4728_CMD_VREF_MASK) >> MCP4728_CMD_VREF_POS;
+		ch->pd_mode = (r2 & MCP4728_CMD_PDMODE_MASK) >> MCP4728_CMD_PDMODE_POS;
+		ch->g_mode = (r2 & MCP4728_CMD_GAIN_MASK) >> MCP4728_CMD_GAIN_POS;
+
+		if (ch->g_mode == MCP4728_GAIN_X2 && ch->ref_mode == MCP4728_VREF_EXTERNAL_VDD)
+			dev_warn(&data->client->dev,
+				 "CH%d: Gain x2 not effective when vref is vdd",
+				 i);
+
+		dac_mv = mcp4728_raw_to_mV(ch->dac_value, i, data);
+		dev_info(&data->client->dev,
+			 "CH%d: Voltage=%dmV VRef=%d PowerDown=%d Gain=%d\n", i,
+			 dac_mv, ch->ref_mode, ch->pd_mode, ch->g_mode);
+	}
+
+	return 0;
+}
+
+static int mcp4728_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct mcp4728_data *data;
+	struct iio_dev *indio_dev;
+	int err;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg))
+		return PTR_ERR(data->vdd_reg);
+
+	err = regulator_enable(data->vdd_reg);
+	if (err)
+		goto err_disable_vdd_reg;
+
+	err = mcp4728_init_channels_data(data);
+	if (err) {
+		dev_err(&client->dev,
+			"failed to read mcp4728 current configuration\n");
+		goto err_disable_vdd_reg;
+	}
+
+	indio_dev->name = id->name;
+	indio_dev->info = &mcp4728_info;
+	indio_dev->channels = mcp4728_channels;
+	indio_dev->num_channels = MCP4728_N_CHANNELS;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto err_disable_vdd_reg;
+
+	return 0;
+
+err_disable_vdd_reg:
+	regulator_disable(data->vdd_reg);
+
+	return err;
+}
+
+static void mcp4728_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(data->vdd_reg);
+}
+
+static const struct i2c_device_id mcp4728_id[] = {
+	{ "mcp4728", MCP4728 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mcp4728_id);
+
+static const struct of_device_id mcp4728_of_match[] = {
+	{ .compatible = "microchip,mcp4728" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mcp4728_of_match);
+
+static struct i2c_driver mcp4728_driver = {
+	.driver = {
+		.name = MCP4728_DRV_NAME,
+		.of_match_table = mcp4728_of_match,
+		.pm = pm_sleep_ptr(&mcp4728_pm_ops),
+	},
+	.probe = mcp4728_probe,
+	.remove = mcp4728_remove,
+	.id_table = mcp4728_id,
+};
+module_i2c_driver(mcp4728_driver);
+
+MODULE_AUTHOR("Andrea Collamati <andrea.collamati@gmail.com>");
+MODULE_DESCRIPTION("MCP4728 12-bit DAC");
+MODULE_LICENSE("GPL");
-- 
2.34.1

