Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0471476E8E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjHCM4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjHCM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:56:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CF81712;
        Thu,  3 Aug 2023 05:56:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so1141411a12.2;
        Thu, 03 Aug 2023 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067403; x=1691672203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3ple4OSeNdJkn6uiTDcaJJeocinYcIQHMwXct35YLI=;
        b=OKR2SxXy4MeMEAUDzZDpx3WKaFmtNJYlKkui3jhJeO9dm3Nv1EvAUrmXLbLZ2RpLPU
         ImsGFJy+0V+nSecQoh/UgNyZdUd0goWRd4Xf2KNGlxM4igijC7uUrFnJ6PKE6z83jDZe
         kYfiRwYkSal3kV45IS5VXQCj5xtIPkPnBiA3HPHR9xBWaOdkPUwOQ8y+MbNZso1v6Je+
         2jHkieNgy3drWuhpRKo7o3fcvrCne/8lJHVynSf6muIEeHg17Hm7RVQXDM0jzgli9oUm
         ioGLzPcGRIFpLp0RISlYvnAPwdex6T/Xo/xiSoh5pqdsc5e9Sqr21rvbSDwb+ZRNatfv
         iVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067403; x=1691672203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3ple4OSeNdJkn6uiTDcaJJeocinYcIQHMwXct35YLI=;
        b=SoL5pS8bHd2fOT6YqWB/AjIE6+GdHJ+ev2yFl5+ci8oWWuOMvj21jmIFWHp0tMftOe
         D0tgxVGHjeBXgP81cwIL5yyCU67hZTXX9ZR9U/+pHzhdT0CeV2qV2VMdnW1P25jbhgqY
         muCifJKPi/ulj8e9PJDnTxhne3mNGuApfboBm99OhZNiM9+B2lLebhKNu5X2zD3Phc/q
         CUE41gUt4UZdvSFgo9y1vVwML9LBWUe/a/iK90qRoA5kZZ2ZWOUNAiUyh6KQQDPFGIAl
         IoNIIsd8oxobmrfrcriJOdwkPTSTU0x2nGByLlXX82uoMzxSdRxNhtekzI5Uu0YBrSvX
         QpFg==
X-Gm-Message-State: ABy/qLaXp7JC3zNMYf+gj/qS0ZgearMSP89D3v+BHpn8Bdpx9EQmD1mh
        9xH/Yl57CRvs9MaEufcrNDU=
X-Google-Smtp-Source: APBJJlHKnAJwjXdnhqt/b7QEuV0x4Zt+CB6Pj8dGnSdSrcxIPvTpisuZ5D60Dw+EFAkqnsv8yAG9gA==
X-Received: by 2002:a05:6402:1353:b0:522:3a37:a45f with SMTP id y19-20020a056402135300b005223a37a45fmr7044877edw.21.1691067403542;
        Thu, 03 Aug 2023 05:56:43 -0700 (PDT)
Received: from colla-nuc.fritz.box (host-79-26-241-62.retail.telecomitalia.it. [79.26.241.62])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7d388000000b005228614c358sm10135110edq.88.2023.08.03.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:56:43 -0700 (PDT)
Received: from colla-nuc.fritz.box (localhost [127.0.0.1])
        by colla-nuc.fritz.box (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 373Cugaf207740;
        Thu, 3 Aug 2023 14:56:42 +0200
Received: (from colla@localhost)
        by colla-nuc.fritz.box (8.15.2/8.15.2/Submit) id 373CugVe207739;
        Thu, 3 Aug 2023 14:56:42 +0200
From:   Andrea Collamati <andrea.collamati@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrea Collamati <andrea.collamati@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] iio: add MCP4728 I2C DAC driver
Date:   Thu,  3 Aug 2023 14:56:35 +0200
Message-Id: <a0933003ed3c855f9d80d6ce0a40add2b6f0ba36.1691066050.git.andrea.collamati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1691066050.git.andrea.collamati@gmail.com>
References: <cover.1691066050.git.andrea.collamati@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/iio/dac/mcp4728.c | 626 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 638 insertions(+)
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
index 000000000000..ba3eab349b0a
--- /dev/null
+++ b/drivers/iio/dac/mcp4728.c
@@ -0,0 +1,626 @@
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
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#define MCP4728_RESOLUTION	  12
+#define MCP4728_N_CHANNELS	  4
+
+#define MCP4728_CMD_MASK	  GENMASK(7, 3)
+#define MCP4728_CHSEL_MASK	  GENMASK(2, 1)
+#define MCP4728_UDAC_MASK	  BIT(0)
+
+#define MCP4728_VREF_MASK	  BIT(7)
+#define MCP4728_PDMODE_MASK	  GENMASK(6, 5)
+#define MCP4728_GAIN_MASK	  BIT(4)
+
+#define MCP4728_DAC_H_MASK	  GENMASK(3, 0)
+#define MCP4728_DAC_L_MASK	  GENMASK(7, 0)
+
+#define MCP4728_RDY_MASK	  BIT(7)
+
+#define MCP4728_MW_CMD		  0x08 /* Multiwrite Command */
+#define MCP4728_SW_CMD		  0x0A /* Sequential Write Command with EEPROM */
+
+#define MCP4728_READ_RESPONSE_LEN (MCP4728_N_CHANNELS * 3 * 2)
+#define MCP4728_WRITE_EEPROM_LEN  (1 + MCP4728_N_CHANNELS * 2)
+
+enum vref_mode {
+	MCP4728_VREF_EXTERNAL_VDD    = 0,
+	MCP4728_VREF_INTERNAL_2048mV = 1,
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
+/* MCP4728 Full Scale Ranges
+ * the device available ranges are
+ * - VREF = VDD				FSR = from 0.0V to VDD
+ * - VREF = Internal	Gain = 1	FSR = from 0.0V to VREF
+ * - VREF = Internal	Gain = 2	FSR = from 0.0V to 2*VREF
+ */
+enum mcp4728_scale {
+	MCP4728_SCALE_VDD,
+	MCP4728_SCALE_VINT_NO_GAIN,
+	MCP4728_SCALE_VINT_GAIN_X2,
+	MCP4728_N_SCALES
+};
+
+struct mcp4728_data {
+	struct i2c_client *client;
+	struct regulator *vdd_reg;
+	bool powerdown;
+	int scales_avail[MCP4728_N_SCALES * 2];
+	struct mcp4728_channel_data chdata[MCP4728_N_CHANNELS];
+};
+
+#define MCP4728_CHAN(chan) {						\
+	.type = IIO_VOLTAGE,						\
+	.output = 1,							\
+	.indexed = 1,							\
+	.channel = chan,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|		\
+			      BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = mcp4728_ext_info,					\
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
+	outbuf[0] = FIELD_PREP(MCP4728_CMD_MASK, MCP4728_SW_CMD);
+
+	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
+		struct mcp4728_channel_data *ch = &data->chdata[i];
+		int offset			= 1 + i * 2;
+
+		outbuf[offset] = FIELD_PREP(MCP4728_VREF_MASK, ch->ref_mode);
+
+		if (data->powerdown) {
+			u8 mcp4728_pd_mode = ch->pd_mode + 1;
+
+			outbuf[offset] |= FIELD_PREP(MCP4728_PDMODE_MASK,
+						     mcp4728_pd_mode);
+		}
+
+		outbuf[offset] |= FIELD_PREP(MCP4728_GAIN_MASK, ch->g_mode);
+		outbuf[offset] |=
+			FIELD_PREP(MCP4728_DAC_H_MASK, ch->dac_value >> 8);
+		outbuf[offset + 1] =
+			FIELD_PREP(MCP4728_DAC_L_MASK, ch->dac_value);
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
+		if (FIELD_GET(MCP4728_RDY_MASK, inbuf[0]))
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
+static int mcp4728_program_channel_cfg(int channel, struct iio_dev *indio_dev)
+{
+	struct mcp4728_data *data	= iio_priv(indio_dev);
+	struct mcp4728_channel_data *ch = &data->chdata[channel];
+	u8 outbuf[3];
+	int ret;
+
+	outbuf[0] = FIELD_PREP(MCP4728_CMD_MASK, MCP4728_MW_CMD);
+	outbuf[0] |= FIELD_PREP(MCP4728_CHSEL_MASK, channel);
+	outbuf[0] |= FIELD_PREP(MCP4728_UDAC_MASK, 0);
+
+	outbuf[1] = FIELD_PREP(MCP4728_VREF_MASK, ch->ref_mode);
+
+	if (data->powerdown)
+		outbuf[1] |= FIELD_PREP(MCP4728_PDMODE_MASK, ch->pd_mode + 1);
+
+	outbuf[1] |= FIELD_PREP(MCP4728_GAIN_MASK, ch->g_mode);
+	outbuf[1] |= FIELD_PREP(MCP4728_DAC_H_MASK, ch->dac_value >> 8);
+	outbuf[2] = FIELD_PREP(MCP4728_DAC_L_MASK, ch->dac_value);
+
+	ret = i2c_master_send(data->client, outbuf, 3);
+	if (ret < 0)
+		return ret;
+	else if (ret != 3)
+		return -EIO;
+
+	return 0;
+}
+
+static const char *const mcp4728_powerdown_modes[] = { "1kohm_to_gnd",
+						       "100kohm_to_gnd",
+						       "500kohm_to_gnd" };
+
+static int mcp4728_get_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	return data->chdata[chan->channel].pd_mode;
+}
+
+static int mcp4728_set_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      unsigned int mode)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	data->chdata[chan->channel].pd_mode = mode;
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
+	.items	   = mcp4728_powerdown_modes,
+	.num_items = ARRAY_SIZE(mcp4728_powerdown_modes),
+	.get	   = mcp4728_get_powerdown_mode,
+	.set	   = mcp4728_set_powerdown_mode,
+};
+
+static const struct iio_chan_spec_ext_info mcp4728_ext_info[] = {
+	{
+		.name	= "powerdown",
+		.read	= mcp4728_read_powerdown,
+		.write	= mcp4728_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp4728_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &mcp4728_powerdown_mode_enum),
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
+static void mcp4728_get_scale_avail(enum mcp4728_scale scale,
+				    struct mcp4728_data *data, int *val,
+				    int *val2)
+{
+	*val  = data->scales_avail[scale * 2];
+	*val2 = data->scales_avail[scale * 2 + 1];
+}
+
+static void mcp4728_get_scale(int channel, struct mcp4728_data *data, int *val,
+			      int *val2)
+{
+	int ref_mode = data->chdata[channel].ref_mode;
+	int g_mode   = data->chdata[channel].g_mode;
+
+	if (ref_mode == MCP4728_VREF_EXTERNAL_VDD) {
+		mcp4728_get_scale_avail(MCP4728_SCALE_VDD, data, val, val2);
+	} else {
+		if (g_mode == MCP4728_GAIN_X1) {
+			mcp4728_get_scale_avail(MCP4728_SCALE_VINT_NO_GAIN,
+						data, val, val2);
+		} else {
+			mcp4728_get_scale_avail(MCP4728_SCALE_VINT_GAIN_X2,
+						data, val, val2);
+		}
+	}
+}
+
+static int mcp4728_find_matching_scale(struct mcp4728_data *data, int val,
+				       int val2)
+{
+	for (int i = 0; i < MCP4728_N_SCALES; i++) {
+		if (data->scales_avail[i * 2] == val &&
+		    data->scales_avail[i * 2 + 1] == val2)
+			return i;
+	}
+	return -EINVAL;
+}
+
+static int mcp4728_set_scale(int channel, struct mcp4728_data *data, int val,
+			     int val2)
+{
+	int scale = mcp4728_find_matching_scale(data, val, val2);
+
+	if (scale < 0)
+		return scale;
+
+	switch (scale) {
+	case MCP4728_SCALE_VDD:
+		data->chdata[channel].ref_mode = MCP4728_VREF_EXTERNAL_VDD;
+		break;
+	case MCP4728_SCALE_VINT_NO_GAIN:
+		data->chdata[channel].ref_mode = MCP4728_VREF_INTERNAL_2048mV;
+		data->chdata[channel].g_mode   = MCP4728_GAIN_X1;
+		break;
+	case MCP4728_SCALE_VINT_GAIN_X2:
+		data->chdata[channel].ref_mode = MCP4728_VREF_INTERNAL_2048mV;
+		data->chdata[channel].g_mode   = MCP4728_GAIN_X2;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mcp4728_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = data->chdata[chan->channel].dac_value;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		mcp4728_get_scale(chan->channel, data, val, val2);
+		return IIO_VAL_INT_PLUS_MICRO;
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
+		data->chdata[chan->channel].dac_value = val;
+		ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = mcp4728_set_scale(chan->channel, data, val, val2);
+		if (ret)
+			break;
+
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
+static void mcp4728_init_scale_avail(enum mcp4728_scale scale, int vref_mv,
+				     struct mcp4728_data *data)
+{
+	s64 tmp;
+	int value_micro;
+	int value_int;
+
+	tmp	  = (s64)vref_mv * 1000000LL >> MCP4728_RESOLUTION;
+	value_int = div_s64_rem(tmp, 1000000LL, &value_micro);
+
+	data->scales_avail[scale * 2]	  = value_int;
+	data->scales_avail[scale * 2 + 1] = value_micro;
+}
+
+static int mcp4728_init_scales_avail(struct mcp4728_data *data)
+{
+	int ret;
+
+	ret = regulator_get_voltage(data->vdd_reg);
+	if (ret < 0)
+		return ret;
+
+	mcp4728_init_scale_avail(MCP4728_SCALE_VDD, ret / 1000, data);
+	mcp4728_init_scale_avail(MCP4728_SCALE_VINT_NO_GAIN, 2048, data);
+	mcp4728_init_scale_avail(MCP4728_SCALE_VINT_GAIN_X2, 4096, data);
+
+	return 0;
+}
+
+static int mcp4728_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	struct mcp4728_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*vals	= data->scales_avail;
+			*length = MCP4728_N_SCALES * 2;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mcp4728_info = {
+	.read_raw   = mcp4728_read_raw,
+	.write_raw  = mcp4728_write_raw,
+	.read_avail = &mcp4728_read_avail,
+	.attrs	    = &mcp4728_attribute_group,
+};
+
+static int mcp4728_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	unsigned int i;
+
+	data->powerdown = true;
+
+	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
+		int err = mcp4728_program_channel_cfg(i, indio_dev);
+
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int mcp4728_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp4728_data *data = iio_priv(indio_dev);
+	int err			  = 0;
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
+		struct mcp4728_channel_data *ch = &data->chdata[i];
+		u8 r2				= inbuf[i * 6 + 1];
+		u8 r3				= inbuf[i * 6 + 2];
+
+		ch->dac_value = FIELD_GET(MCP4728_DAC_H_MASK, r2) << 8 |
+				FIELD_GET(MCP4728_DAC_L_MASK, r3);
+		ch->ref_mode = FIELD_GET(MCP4728_VREF_MASK, r2);
+		ch->pd_mode  = FIELD_GET(MCP4728_PDMODE_MASK, r2);
+		ch->g_mode   = FIELD_GET(MCP4728_GAIN_MASK, r2);
+	}
+
+	return 0;
+}
+
+static void mcp4728_reg_disable(void *reg)
+{
+	regulator_disable(reg);
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
+		return err;
+
+	err = devm_add_action_or_reset(&client->dev, mcp4728_reg_disable,
+				       data->vdd_reg);
+	if (err)
+		return err;
+
+	/* MCP4728 has internal EEPROM that save each channel boot configuration.
+	 * It means that device configuration is unknown to the driver at kernel boot.
+	 * mcp4728_init_channels_data reads back DAC settings and stores them in data
+	 * structure.
+	 */
+	err = mcp4728_init_channels_data(data);
+	if (err) {
+		dev_err(&client->dev,
+			"failed to read mcp4728 current configuration\n");
+		return err;
+	}
+
+	err = mcp4728_init_scales_avail(data);
+	if (err) {
+		dev_err(&client->dev, "failed to init scales\n");
+		return err;
+	}
+
+	indio_dev->name		= id->name;
+	indio_dev->info		= &mcp4728_info;
+	indio_dev->channels	= mcp4728_channels;
+	indio_dev->num_channels = MCP4728_N_CHANNELS;
+	indio_dev->modes	= INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id mcp4728_id[] = {
+	{ "mcp4728", 0 },
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
+		.name = "mcp4728",
+		.of_match_table = mcp4728_of_match,
+		.pm = pm_sleep_ptr(&mcp4728_pm_ops),
+	},
+	.probe = mcp4728_probe,
+	.id_table = mcp4728_id,
+};
+module_i2c_driver(mcp4728_driver);
+
+MODULE_AUTHOR("Andrea Collamati <andrea.collamati@gmail.com>");
+MODULE_DESCRIPTION("MCP4728 12-bit DAC");
+MODULE_LICENSE("GPL");
-- 
2.34.1

