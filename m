Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897FC755768
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGPV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGPV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:26:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4222E52;
        Sun, 16 Jul 2023 14:26:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98de21518fbso557969766b.0;
        Sun, 16 Jul 2023 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689542812; x=1692134812;
        h=content-transfer-encoding:in-reply-to:cc:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POXA56Il76dp0eiCiw4I4SDe9WUNGSDj9JSS6IaF5Sk=;
        b=Z6Z8PMu/WqyVsaSfPXkce8O5+hFuDlEc/bsMFfjVbRPWjoUR7CcUJ5IwsBnkAg4Nop
         YHk0/j/qgJZ8Wx98n8pOUtgeyhIYCMB+oQ7GUkF5U4+2FAyb9bI9WP2g4L6lPCDiwM8j
         +szN/W4xQUfpxHCBBaYjrz0amqB8m47TTjdrQySl8Vlsn2DRzmFmtl1Q33ZhnnR9+Vaq
         yiTSk0AlLACf46YzjqfCyL/4gz8vy5XuQlghlHMYE5ResQprU+1Kpcm3vQaoQ29Bkr/Q
         aZG0ZjfpE75Xos8lLaORyzXRYs+dtRUHgnO4fZfpoFKe8IEilfQUIMonm7jvj/22qiJj
         gJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689542812; x=1692134812;
        h=content-transfer-encoding:in-reply-to:cc:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POXA56Il76dp0eiCiw4I4SDe9WUNGSDj9JSS6IaF5Sk=;
        b=cII0NKA8v9+Ccg2wp4lZQx/x63RsLyViS3GBEVuszh8E06P2Mo2ymGTBirDYkN7X1u
         smPRqVjMP2gvljOE5mVfdgx2xUkApuKTdcrHoV7pIPDs64lNKcUeotAx2lo/ZmbcFWTy
         ID6PNqYgBReW/pCurdNxv4zC0KoYmSyvPxski9vH+JlELb63vQYq440iJzE8+foNqCbC
         u0SuSeDCb1KP57nU1J2dIQdn+WoYLhdhscYaqm+sKwjT/fy6jVaGIs0R4I/2gA60V4Z7
         7h1GXnpFckxa/qpyMY9u4MQdYkl5711Rwhwkc/OBOzQLBiau8tKwLumblh76CezO/1d6
         0aHw==
X-Gm-Message-State: ABy/qLb7Hdp6cg1urZV1H72ogvfosEy6HyETZ43XQxHKLEEACiLk04d7
        gKElLNKfB9BFj1BlkQo6BkA=
X-Google-Smtp-Source: APBJJlH9Z1mtkgqyEKYxxCC1KLObmyPg1qnulrwhIqFsKMFUMREDu7OkA2z9cSoyy/EhlmLpW0NA+A==
X-Received: by 2002:a17:907:2bd0:b0:993:e695:b589 with SMTP id gv16-20020a1709072bd000b00993e695b589mr10312668ejc.20.1689542812147;
        Sun, 16 Jul 2023 14:26:52 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id op26-20020a170906bcfa00b009892cca8ae3sm8251895ejb.165.2023.07.16.14.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 14:26:51 -0700 (PDT)
Message-ID: <75145a12-a85e-e553-d32f-3212357c4a7e@gmail.com>
Date:   Sun, 16 Jul 2023 23:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrea Collamati <andrea.collamati@gmail.com>
Subject: [PATCH v2 2/2] iio: add mcp4728 I2C DAC driver
References: <cover.1689541455.git.andrea.collamati@gmail.com>
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrea.collamati@gmail.com" <andrea.collamati@gmail.com>
In-Reply-To: <cover.1689541455.git.andrea.collamati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcp4728 is a 12-bit quad channel DAC with I2C interface.

support for:
  * per-channel gain
  * per-channel power state
  * per-channel power down mode control
  * per-channel vref selection internal/vdd
  * store current state to on-chip EEPROM

Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
---
 drivers/iio/dac/Kconfig   |  12 +
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/mcp4728.c | 635 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 648 insertions(+)
 create mode 100644 drivers/iio/dac/mcp4728.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 3acd9c3f388e..fa1516f6a285 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -389,6 +389,18 @@ config MCP4725
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
index 000000000000..b4e939281c31
--- /dev/null
+++ b/drivers/iio/dac/mcp4728.c
@@ -0,0 +1,635 @@
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
+static const struct i2c_device_id mcp4728_id[] = { { "mcp4728", MCP4728 }, {} };
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

