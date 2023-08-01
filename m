Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740E76B6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjHAOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjHAOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:04:22 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A032EDF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=M1Yju
        zXRP4zgDtxq9CrgtbTk9h2xmhL1mnC+3447Gy4=; b=Xs9WHmzLiHGOZ8HwKA3YW
        rPS/uNQ/UtsU0SysyxEj6hi6P9GQraX+004mSYJ1HCUQckKD1YIt+vtZ/6p/vcV7
        zpEvM4dh7qGeCLExBYybzZsel70HTgjUxdcAiDAyPVGrgh395LQHZucgiGMpiFOy
        d4JUJmmeQNdLoRQQFm4B4Q=
Received: from lml-Birman-PHX.. (unknown [112.96.224.101])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDXRClSEMlkjbCSBw--.1173S2;
        Tue, 01 Aug 2023 22:01:56 +0800 (CST)
From:   "Baojun.Xu" <jim_monkey@163.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     shenghao-ding@ti.com, kevin-lu@ti.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        shumingf@realtek.com, herve.codina@bootlin.com,
        povik+lin@cutebit.org, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, wangweidong.a@awinic.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        peeyush@ti.com, navada@ti.com, tiwai@suse.de,
        mengdong.lin@intel.com, Baojun Xu <baojun.xu@ti.com>
Subject: [PATCH v1 1/2] ASoC: tas2783: Add source files for tas2783 soundwire driver
Date:   Tue,  1 Aug 2023 22:01:44 +0800
Message-Id: <20230801140144.85548-1-jim_monkey@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXRClSEMlkjbCSBw--.1173S2
X-Coremail-Antispam: 1Uf129KBjvAXoWDCry8Aw18GFyDCrWDGr17Wrg_yoWrAryUWo
        Z3Wa9aqr1rJry7urWFkwn7CFy7ZrWUGasFgw4rAa98Aw48AFn0gay3tFy5Z3Z3Wryakw1x
        JryrX34fGr4rtrs5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3rWrDUUUU
X-Originating-IP: [112.96.224.101]
X-CM-SenderInfo: 5mlpsz5rqnv5i6rwjhhfrp/1tbiJhe+81v2slGhIAAAsz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baojun Xu <baojun.xu@ti.com>

Add source file and header file for tas2783 driver.
Update Kconfig and Makefile for tas2783 driver.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
Change in v1:
 - Add tas2783-sdw.c
 - Add tas2783.h
 - Update Makefile for tas2783 driver.
 - Update Kconfig for tas2783 driver.
---
 sound/soc/codecs/Kconfig       |   12 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tas2783-sdw.c | 1166 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2783.h     |  178 +++++
 4 files changed, 1358 insertions(+)
 create mode 100644 sound/soc/codecs/tas2783-sdw.c
 create mode 100644 sound/soc/codecs/tas2783.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c2de4ee72183..318ad867030c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -240,6 +240,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS2781_COMLIB
 	imply SND_SOC_TAS2781_FMWLIB
 	imply SND_SOC_TAS2781_I2C
+	imply SND_SOC_TAS2783
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
@@ -1762,6 +1763,17 @@ config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
 
+config SND_SOC_TAS2783
+       tristate "Texas Instruments TAS2781 speaker amplifier (sdw)"
+       depends on SOUNDWIRE
+       select REGMAP
+       select CRC8
+       help
+         Enable support for Texas Instruments TAS2783 Smart Amplifier
+         Digital input mono Class-D and DSP-inside audio power amplifiers.
+         Note the TAS2783 driver implements a flexible and configurable
+         algo coff setting, for one, two, even multiple TAS2783 chips.
+
 config SND_SOC_TAS571X
 	tristate "Texas Instruments TAS571x power amplifiers"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b48a9a323b84..3298dfa3b9d5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -276,6 +276,7 @@ snd-soc-tas2770-objs := tas2770.o
 snd-soc-tas2781-comlib-objs := tas2781-comlib.o
 snd-soc-tas2781-fmwlib-objs := tas2781-fmwlib.o
 snd-soc-tas2781-i2c-objs := tas2781-i2c.o
+snd-soc-tas2783-objs := tas2783-sdw.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tfa989x-objs := tfa989x.o
 snd-soc-tlv320adc3xxx-objs := tlv320adc3xxx.o
@@ -648,6 +649,7 @@ obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
 obj-$(CONFIG_SND_SOC_TAS2781_COMLIB)	+= snd-soc-tas2781-comlib.o
 obj-$(CONFIG_SND_SOC_TAS2781_FMWLIB)	+= snd-soc-tas2781-fmwlib.o
 obj-$(CONFIG_SND_SOC_TAS2781_I2C)	+= snd-soc-tas2781-i2c.o
+obj-$(CONFIG_SND_SOC_TAS2783)	+= snd-soc-tas2783.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
new file mode 100644
index 000000000000..93b1e7a1f311
--- /dev/null
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -0,0 +1,1165 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Texas Instruments TAS2783 Audio Smart Amplifier
+//
+// Copyright (C) 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2783 driver implements a flexible and configurable
+// algo coefficient setting for single TAS2783 chips.
+//
+// Author: Baojun Xu <baojun.xu@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw_type.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/crc8.h>
+#include <linux/crc32.h>
+#include <linux/efi.h>
+#include <linux/firmware.h>
+#include <linux/of_gpio.h>
+#include <linux/interrupt.h>
+#include <sound/soc.h>
+#include <sound/sdw.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+#include <sound/tas2781-tlv.h>
+
+#include "tas2783.h"
+
+static const unsigned int tas2783_calibration_reg[] = {
+	TAS2783_CALIBRATION_RE,
+	TAS2783_CALIBRATION_RE_LOW,
+	TAS2783_CALIBRATION_INV_RE,
+	TAS2783_CALIBRATION_POW,
+	TAS2783_CALIBRATION_TLIMIT,
+	0,
+};
+
+static const struct reg_default tas2783_reg_defaults[] = {
+	// Default values for ROM mode. Activated.
+	{ 0x8002, 0x1a},
+	{ 0x800e, 0x44},
+	{ 0x800f, 0x40},
+	{ 0x8097, 0xc8},
+	{ 0x80b5, 0x74},
+	{ 0x8099, 0x20},
+	{ 0xfe8d, 0x0d},
+	{ 0xfebe, 0x4a},
+	{ 0x8230, 0x00},
+	{ 0x8231, 0x00},
+	{ 0x8232, 0x00},
+	{ 0x8233, 0x01},
+	{ 0x8418, 0x00},
+	{ 0x8419, 0x00},
+	{ 0x841a, 0x00},
+	{ 0x841b, 0x00},
+	{ 0x8428, 0x40},
+	{ 0x8429, 0x00},
+	{ 0x842a, 0x00},
+	{ 0x842b, 0x00},
+	{ 0x8548, 0x00},
+	{ 0x8549, 0x00},
+	{ 0x854a, 0x00},
+	{ 0x854b, 0x00},
+	{ 0x8558, 0x40},
+	{ 0x8559, 0x00},
+	{ 0x855a, 0x00},
+	{ 0x855b, 0x00},
+	{ 0x800a, 0x3a},
+	{ 0x800e, 0x44},
+	{ 0x800f, 0x40},
+	{ 0x805c, 0xd9},
+	{ 0x8002, 0x00},
+};
+
+static bool tas2783_readable_register(struct device *dev,
+	unsigned int reg)
+{
+	switch (reg) {
+	case 0x8000 ... 0xc000:	// Page 0 ~ 127.
+	case 0xfe80 ... 0xfeff:	// Page 253.
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_UDMPU21,
+		TAS2783_SDCA_CTL_UDMPU_CLUSTER, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_FU21,
+		TAS2783_SDCA_CTL_FU_MUTE, CH_L):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_FU21,
+		TAS2783_SDCA_CTL_FU_MUTE, CH_R):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_PDE23,
+		TAS2783_SDCA_CTL_REQ_POWER_STATE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_PDE22,
+		TAS2783_SDCA_CTL_REQ_POWER_STATE, 0):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tas2783_volatile_register(struct device *dev,
+	unsigned int reg)
+{
+	switch (reg) {
+	case 0x8001:
+		// Only reset register was volatiled.
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config tasdevice_regmap = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.readable_reg = tas2783_readable_register,
+	.volatile_reg = tas2783_volatile_register,
+	.max_register = 0x41008000 + TASDEVICE_REG(0xa1, 0x60, 0x7f),
+	.reg_defaults = tas2783_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static int tas2783_sdw_read(void *context, const void *reg_buf,
+	const size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct sdw_slave *peripheral = context;
+	u8 *buf8 = val_buf;
+	unsigned int reg, bytes;
+	int ret;
+
+	reg = le32_to_cpu(*(const __le32 *)reg_buf);
+	reg += TAS2783_SDW_ADDR_OFFSET;
+
+	while (val_size) {
+		/* to end of page */
+		bytes = SDW_REG_NO_PAGE - (reg & SDW_REGADDR);
+		if (bytes > val_size)
+			bytes = val_size;
+
+		ret = sdw_nread_no_pm(peripheral, reg, bytes, buf8);
+		if (ret != 0) {
+			dev_err(&peripheral->dev, "Read @%#x..%#x:%d\n",
+				reg, reg + bytes - 1, ret);
+			return ret;
+		}
+
+		swab32_array((u32 *)buf8, bytes / 4);
+		val_size -= bytes;
+		reg += bytes;
+		buf8 += bytes;
+	}
+
+	return 0;
+}
+
+/* Convert for LSB or MSB. */
+static inline void tas2783_swab_copy(
+	void *dest, const void *src, size_t nbytes)
+{
+	u32 *dest32 = dest;
+	const u32 *src32 = src;
+
+	for (; nbytes > 0; nbytes -= 4)
+		*dest32++ = swab32(*src32++);
+}
+
+static int tas2783_sdw_gather_write(void *context, const void *reg_buf,
+	size_t reg_size, const void *val_buf, size_t val_size)
+{
+	struct sdw_slave *peripheral = context;
+	const u8 *src_be = val_buf;
+	u32 val_le_buf[64];	/* Define u32 so it is 32-bit aligned */
+	unsigned int reg, bytes;
+	int ret;
+
+	reg = le32_to_cpu(*(const __le32 *)reg_buf);
+
+	while (val_size) {
+		/* to end of page */
+		bytes = SDW_REG_NO_PAGE - (reg & SDW_REGADDR);
+		if (bytes > val_size)
+			bytes = val_size;
+		if (bytes > sizeof(val_le_buf))
+			bytes = sizeof(val_le_buf);
+
+		tas2783_swab_copy(val_le_buf, src_be, bytes);
+
+		ret = sdw_nwrite_no_pm(peripheral, reg, bytes,
+					(u8 *)val_le_buf);
+		if (ret != 0) {
+			dev_err(&peripheral->dev, "Write @%#x..%#x:%d\n",
+				reg, reg + bytes - 1, ret);
+			return ret;
+		}
+
+		val_size -= bytes;
+		reg += bytes;
+		src_be += bytes;
+	}
+
+	return 0;
+}
+
+static int tas2783_sdw_write(
+	void *context, const void *val_buf, size_t val_size)
+{
+	const u8 *src_buf = val_buf;
+
+	/* First word of val_buf contains the destination address */
+	return tas2783_sdw_gather_write(context, &src_buf[0], 4,
+					&src_buf[4], val_size - 4);
+}
+
+static int tasdevice_clamp(int val, int max, unsigned int invert)
+{
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+	return val;
+}
+
+/*
+ * Registers are big-endian on I2C and SPI but little-endian on SoundWire.
+ * Exported firmware controls are big-endian on I2C/SPI but little-endian
+ * on SoundWire.
+ * Firmware files are always big-endian and are opaque blobs.
+ * Present a big-endian regmap and hide the endianness swap,
+ * so that the ALSA byte controls always have the same byte order,
+ * and firmware file blobs can be written verbatim.
+ */
+static const struct regmap_bus tas2783_regmap_bus_sdw = {
+	.read = tas2783_sdw_read,
+	.write = tas2783_sdw_write,
+	.gather_write = tas2783_sdw_gather_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static int tas2783_digital_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int val;
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	int ret = 0;
+
+	/* Read the primary device as the whole */
+	ret = tasdevice_dev_read(tas_dev, &mc->reg, (unsigned int *)&val);
+	dev_dbg(tas_dev->dev, "%s, get digital vol %d from %x with %d\n",
+		__func__, val, mc->reg, ret);
+	if (ret) {
+		dev_err(tas_dev->dev, "%s, get digital vol error %x.\n",
+			__func__, ret);
+		goto out;
+	}
+
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+	ucontrol->value.integer.value[0] = val;
+
+out:
+	return ret;
+}
+
+static int tas2783_digital_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int val, ret = 0;
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	unsigned char value = 0;
+
+	val = ucontrol->value.integer.value[0];
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+
+	value = (u8)val;
+	ret = sdw_nwrite_no_pm(tas_dev->sdw_slave, mc->reg, 1, &value);
+	if (ret != 0) {
+		dev_err(tas_dev->dev, "Write @%#x..%#x:%d\n",
+			mc->reg, val, ret);
+		return ret;
+	}
+	dev_dbg(tas_dev->dev, "%s, Put digital vol %d into %x.\n",
+		__func__, val, mc->reg);
+
+	return 1;
+}
+
+static int tas2783_amp_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int val;
+	unsigned char mask = 0;
+	int max = mc->max;
+	int ret = 0;
+	unsigned int invert = mc->invert;
+	unsigned char value = 0;
+
+	/* Read the primary device */
+	ret = sdw_nread_no_pm(tas_dev->sdw_slave, mc->reg, 1, &value);
+	dev_dbg(tas_dev->dev, "%s, get AMP vol %d from %x with %d\n",
+		__func__, value, mc->reg, ret);
+
+	mask = (1 << fls(mc->max)) - 1;
+	mask <<= mc->shift;
+	val = value;
+	val = (val & mask) >> mc->shift;
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+	ucontrol->value.integer.value[0] = val;
+
+	return ret;
+}
+
+static int tas2783_amp_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int val = 0, ret = 0, max = mc->max;
+	unsigned char mask = 0, value = 0;
+	unsigned int invert = mc->invert;
+
+	mask = (1 << fls(mc->max)) - 1;
+	mask <<= mc->shift;
+	val = tasdevice_clamp(ucontrol->value.integer.value[0], max,
+		invert);
+
+	ret = sdw_nread_no_pm(tas_dev->sdw_slave, mc->reg, 1, &value);
+	if (ret != 0) {
+		dev_err(tas_dev->dev, "Read @%x.%x:%d\n",
+			mc->reg, value, ret);
+		return ret;
+	}
+	value &= (~TAS2783_AMP_LEVEL_MASK);
+	value |= (val << mc->shift);
+	ret = sdw_nwrite_no_pm(tas_dev->sdw_slave, mc->reg, 1, &value);
+	if (ret != 0) {
+		dev_err(tas_dev->dev, "Write @%#x..%#x:%d\n",
+			mc->reg, val, ret);
+		return ret;
+	}
+	dev_dbg(tas_dev->dev, "amp %x into 0x%08x by %lx shift %d.\n",
+		val, mc->reg, TAS2783_AMP_LEVEL_MASK, mc->shift);
+
+	return ret;
+}
+
+static const struct snd_kcontrol_new tas2783_snd_controls[] = {
+	SOC_SINGLE_RANGE_EXT_TLV("Amp Gain Volume", TAS2783_AMP_LEVEL,
+		1, 0, 20, 0, tas2783_amp_getvol,
+		tas2783_amp_putvol, amp_vol_tlv),
+	SOC_SINGLE_RANGE_EXT_TLV("Digital Volume", TAS2783_DVC_LVL,
+		0, 0, 200, 1, tas2783_digital_getvol,
+		tas2783_digital_putvol, dvc_tlv),
+};
+
+static void tas2783_apply_calib(
+	struct tasdevice_priv *tas_priv, unsigned int *cali_data)
+{
+	unsigned int reg_address = 0, i = 0;
+	unsigned int *reg_start;
+
+	if (!tas_priv->sdw_slave)
+		return;
+	if ((tas_priv->sdw_slave->id.unique_id < TAS2783_DEVICE_ID_START)
+	 || (tas_priv->sdw_slave->id.unique_id > TAS2783_DEVICE_ID_END))
+		return;
+	reg_start = cali_data+(tas_priv->sdw_slave->id.unique_id -
+		TAS2783_DEVICE_ID_START)*TAS2783_CALIBRATION_SIZE;
+	while (tas2783_calibration_reg[i] != 0) {
+		reg_address = tas2783_calibration_reg[i];
+		tas2783_sdw_gather_write(tas_priv->sdw_slave,
+			&reg_address, 4, reg_start+i, 4);
+	}
+}
+
+static int tas2783_calibration(struct tasdevice_priv *tas_priv)
+{
+	efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
+			0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
+	static efi_char16_t efi_name[] = L"CALI_DATA";
+	struct tm *tm = &tas_priv->tm;
+	unsigned int attr, crc;
+	unsigned int *tmp_val;
+	efi_status_t status;
+
+	tas_priv->cali_data.total_sz = 128;
+	/* Get real size of UEFI variable */
+	status = efi.get_variable(efi_name, &efi_guid, &attr,
+		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
+	dev_dbg(tas_priv->dev, "cali get %lx bytes with result : %ld\n",
+			tas_priv->cali_data.total_sz, status);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		status = efi.get_variable(efi_name, &efi_guid, &attr,
+			&tas_priv->cali_data.total_sz,
+			tas_priv->cali_data.data);
+		dev_dbg(tas_priv->dev, "cali get %lx bytes result:%ld\n",
+			tas_priv->cali_data.total_sz, status);
+	}
+	for (int i = 0; i < tas_priv->cali_data.total_sz; i += 4) {
+		dev_dbg(tas_priv->dev, "cali get %02x %02x %02x %02x",
+			tas_priv->cali_data.data[i],
+			tas_priv->cali_data.data[i+1],
+			tas_priv->cali_data.data[i+2],
+			tas_priv->cali_data.data[i+3]);
+	}
+
+	tmp_val = (unsigned int *)tas_priv->cali_data.data;
+
+	crc = crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
+	dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
+		crc, tmp_val[21]);
+
+	if (crc == tmp_val[21]) {
+		time64_to_tm(tmp_val[20], 0, tm);
+		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
+			tm->tm_year, tm->tm_mon, tm->tm_mday,
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+		tas2783_apply_calib(tas_priv, tmp_val);
+	} else {
+		dev_dbg(tas_priv->dev, "CRC error!\n");
+		tas_priv->cali_data.total_sz = 0;
+	}
+
+	return 0;
+}
+
+static void tasdevice_rca_ready(const struct firmware *fmw, void *context)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) context;
+	struct MYSWFTFile *p;
+	unsigned char *buf = NULL, value_sdw;
+	int offset = 0, i = 0, num_files = 0, img_sz = 0;
+	int ret = 0;
+
+	mutex_lock(&tas_dev->codec_lock);
+
+	if (!fmw || !fmw->data) {
+		dev_err(tas_dev->dev,
+		"Failed to read %s, no side - effect on driver running\n",
+		tas_dev->rca_binaryname);
+		ret = -1;
+		goto out;
+	}
+	buf = (unsigned char *)fmw->data;
+
+	img_sz = SMS_HTONL(buf[offset+3], buf[offset + 2],
+		buf[offset + 1], buf[offset]);
+	dev_dbg(tas_dev->dev,  "Got %x:%lx.\n",	img_sz, fmw->size);
+	offset  += sizeof(img_sz);
+	if (img_sz != fmw->size) {
+		dev_err(tas_dev->dev,
+			"Size not match, %d %u", (int)fmw->size, img_sz);
+		ret = -1;
+		goto out;
+	}
+
+	while ((offset < img_sz) && (num_files < MAX_NO_FILES)) {
+		p = (struct MYSWFTFile *)(buf + offset);
+		tas_dev->m_swftFile[num_files].m_vendor_id =
+			p->m_vendor_id;
+		tas_dev->m_swftFile[num_files].m_file_id = p->m_file_id;
+		tas_dev->m_swftFile[num_files].m_version = p->m_version;
+		tas_dev->m_swftFile[num_files].m_Length = p->m_Length;
+		tas_dev->m_swftFile[num_files].m_downloadAddr =
+			p->m_downloadAddr;
+		tas_dev->m_swftFile[num_files].m_startAdress =
+			((char *)p) + sizeof(unsigned int)*5;
+
+		ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
+			tas_dev->m_swftFile[num_files].m_downloadAddr,
+			tas_dev->m_swftFile[num_files].m_Length,
+			tas_dev->m_swftFile[num_files].m_startAdress);
+		dev_dbg(tas_dev->dev, "Write %x into %x result : %d\n",
+			tas_dev->m_swftFile[num_files].m_Length,
+			tas_dev->m_swftFile[num_files].m_downloadAddr,
+			ret);
+
+		dev_dbg(tas_dev->dev, "Write %d :%x:%x:%x:%x:%x:%x.\n",
+			num_files,
+			tas_dev->m_swftFile[num_files].m_vendor_id,
+			tas_dev->m_swftFile[num_files].m_file_id,
+			tas_dev->m_swftFile[num_files].m_version,
+			tas_dev->m_swftFile[num_files].m_Length,
+			tas_dev->m_swftFile[num_files].m_downloadAddr,
+			tas_dev->m_swftFile[num_files].m_startAdress[0]);
+
+		ret = sdw_nread_no_pm(tas_dev->sdw_peripheral,
+			tas_dev->m_swftFile[num_files].m_downloadAddr,
+			1, &value_sdw);
+		dev_dbg(tas_dev->dev,  "Got block %d :%x.\n",
+			num_files, value_sdw);
+
+		offset += sizeof(unsigned int)*5 + p->m_Length;
+		num_files++;
+	}
+
+	i = 0x50;
+	while (i < 0x56) {
+		ret = sdw_nread_no_pm(tas_dev->sdw_peripheral, i, 1,
+			&value_sdw);
+		dev_dbg(tas_dev->dev,  "Got device id:%x\n", value_sdw);
+		i++;
+	}
+	tas2783_calibration(tas_dev);
+
+out:
+	mutex_unlock(&tas_dev->codec_lock);
+	if (fmw)
+		release_firmware(fmw);
+}
+
+static void tasdevice_config_info_remove(void *context)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) context;
+	dev_dbg(tas_dev->dev,  "%s was performed\n", __func__);
+}
+
+static int tasdevice_dapm_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *codec =
+		snd_soc_dapm_to_component(w->dapm);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	int state = 1;
+
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+	dev_dbg(tas_dev->dev,  "dapm event : %x\n", event);
+	if (event == SND_SOC_DAPM_PRE_PMD)
+		state = 0;
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT_E("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
+		0, 0, tasdevice_dapm_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SPK("SPK", tasdevice_dapm_event),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+	SND_SOC_DAPM_INPUT("DMIC")
+};
+
+static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
+	{"SPK", NULL, "ASI"},
+	{"OUT", NULL, "SPK"},
+	{"ASI OUT", NULL, "DMIC"}
+};
+
+static int tasdevice_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	int ret = 0;
+
+	return ret;
+}
+
+static int tasdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+	int clk_id, unsigned int freq, int dir)
+{
+	struct tasdevice_priv *tas_dev =
+		snd_soc_dai_get_drvdata(codec_dai);
+
+	tas_dev->sysclk = freq;
+
+	return 0;
+}
+
+static int tasdevice_set_sdw_stream(
+	struct snd_soc_dai *dai, void *sdw_stream, int direction)
+{
+	struct sdw_stream_data *stream;
+
+	if (!sdw_stream)
+		return 0;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	stream->sdw_stream = sdw_stream;
+
+	/* Use tx_mask or rx_mask to set dma_data */
+	snd_soc_dai_dma_data_set(dai, direction, stream);
+
+	return 0;
+}
+
+static void tasdevice_sdw_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct sdw_stream_data *stream;
+
+	stream = snd_soc_dai_get_dma_data(dai, substream);
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	kfree(stream);
+}
+
+static int tasdevice_sdw_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tasdevice_priv *tasdevice =
+		snd_soc_component_get_drvdata(component);
+	struct sdw_stream_config stream_config = {0};
+	struct sdw_port_config port_config = {0};
+	struct sdw_stream_data *stream;
+	int retval;
+
+	dev_dbg(dai->dev, "%s %s", __func__, dai->name);
+	stream = snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!stream)
+		return -EINVAL;
+
+	if (!tasdevice->sdw_slave)
+		return -EINVAL;
+
+	/* SoundWire specific configuration */
+	snd_sdw_params_to_config(substream, params,
+		&stream_config, &port_config);
+
+	/* port 1 for playback */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		port_config.num = 1;
+	else
+		port_config.num = 2;
+
+	retval = sdw_stream_add_slave(tasdevice->sdw_slave,
+		&stream_config,	&port_config, 1, stream->sdw_stream);
+	if (retval) {
+		dev_err(dai->dev, "Unable to configure port\n");
+		return retval;
+	}
+
+	return 0;
+}
+
+static int tasdevice_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tasdevice_priv *tasdevice =
+		snd_soc_component_get_drvdata(component);
+	struct sdw_stream_data *stream =
+		snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!tasdevice->sdw_slave)
+		return -EINVAL;
+
+	sdw_stream_remove_slave(tasdevice->sdw_slave, stream->sdw_stream);
+	return 0;
+}
+
+static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
+	int direction)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tasdevice_priv *tasdevice =
+		snd_soc_component_get_drvdata(component);
+	int ret = 0;
+	unsigned char value_sdw = 0;
+
+	dev_dbg(tasdevice->dev, "%s: mute %d, %d\n",
+		__func__, mute, direction);
+	if (mute == 0) {// Unmute.
+		// FU21 Unmute
+		value_sdw = 0;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			SDW_SDCA_CTL(1, 1, 1, 0), 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "Unmuted %lx %x\n",
+			SDW_SDCA_CTL(1, 1, 1, 0), ret);
+		value_sdw = 0;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x40400090, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "Unmuted %x\n", ret);
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x40402090, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "Unmuted %x\n", ret);
+
+		// FU23 Unmute
+		value_sdw = 0;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			SDW_SDCA_CTL(1, 2, 1, 0), 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "Unmuted %lx %x\n",
+			SDW_SDCA_CTL(1, 2, 1, 0), ret);
+		value_sdw = 0;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x40400108, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "Unmuted %x\n", ret);
+		value_sdw = 0;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x8002, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "Unmuted %x\n", ret);
+	} else {
+		// FU21 mute
+		value_sdw = 1;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			SDW_SDCA_CTL(1, 1, 1, 0), 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "muted %lx %x\n",
+			SDW_SDCA_CTL(1, 1, 1, 0), ret);
+		value_sdw = 1;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x40400090, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "muted %x\n", ret);
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x40402090, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "muted %x\n", ret);
+		// FU23 mute
+		value_sdw = 1;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			SDW_SDCA_CTL(1, 2, 1, 0), 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "muted %lx %x\n",
+			SDW_SDCA_CTL(1, 2, 1, 0), ret);
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x40400108, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "muted %x\n", ret);
+		value_sdw = 0x1a;
+		ret = sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
+			0x8002, 1, &value_sdw);
+		dev_dbg(tasdevice->dev,  "muted %x\n", ret);
+	}
+
+	if (!tasdevice->sdw_slave)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops tasdevice_dai_ops = {
+	.startup	= tasdevice_startup,
+	.mute_stream	= tasdevice_mute,
+	.hw_params	= tasdevice_sdw_hw_params,
+	.set_sysclk	= tasdevice_set_dai_sysclk,
+	.hw_free	= tasdevice_sdw_pcm_hw_free,
+	.set_stream	= tasdevice_set_sdw_stream,
+	.shutdown	= tasdevice_sdw_shutdown,
+};
+
+static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
+	{
+		.name = "tas2783_codec",
+		.id = 0,
+		.playback = {
+			.stream_name	= "Playback",
+			.channels_min   = 1,
+			.channels_max   = 4,
+			.rates   = TASDEVICE_RATES,
+			.formats	= TASDEVICE_FORMATS,
+		},
+		.capture = {
+			.stream_name	= "Capture",
+			.channels_min   = 1,
+			.channels_max   = 1,
+			.rates   = TASDEVICE_RATES,
+			.formats	= TASDEVICE_FORMATS,
+		},
+		.ops = &tasdevice_dai_ops,
+		.symmetric_rate = 1,
+	},
+};
+
+static void tas2783_reset(struct tasdevice_priv *tas_dev)
+{
+	int ret = 0;
+	unsigned char value_sdw;
+
+	value_sdw = TAS2873_REG_SWRESET_RESET;
+	ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
+		TAS2873_REG_SWRESET, 1, &value_sdw);
+	dev_dbg(tas_dev->dev, "%s TAS2783 was reseted.\n",  __func__);
+	usleep_range(1000, 1050);
+}
+
+static int tasdevice_codec_probe(struct snd_soc_component *codec)
+{
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	int ret = 0;
+
+	dev_dbg(tas_dev->dev, "%s called for TAS2783 start.\n",
+		__func__);
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+
+	crc8_populate_msb(tas_dev->crc8_lkp_tbl,
+		TASDEVICE_CRC8_POLYNOMIAL);
+	tas_dev->codec = codec;
+
+	scnprintf(tas_dev->rca_binaryname, 64, "MY_SWFT_x%01x.bin",
+		tas_dev->sdw_peripheral->id.unique_id);
+
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL,
+		tas_dev, tasdevice_rca_ready);
+	dev_dbg(tas_dev->dev,
+		"%s: request_firmware %x open status: 0x%08x\n",
+		__func__, tas_dev->sdw_peripheral->id.unique_id, ret);
+
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+
+	tas2783_reset(tas_dev);
+
+	dev_dbg(tas_dev->dev, "%s was called end.\n",  __func__);
+	return ret;
+}
+
+static void tasdevice_deinit(void *context)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) context;
+
+	tasdevice_config_info_remove(tas_dev);
+}
+
+static void tasdevice_codec_remove(
+	struct snd_soc_component *codec)
+{
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+	tasdevice_deinit(tas_dev);
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+}
+
+static const struct snd_soc_component_driver
+	soc_codec_driver_tasdevice = {
+	.probe		= tasdevice_codec_probe,
+	.remove		= tasdevice_codec_remove,
+	.controls	= tas2783_snd_controls,
+	.num_controls	= ARRAY_SIZE(tas2783_snd_controls),
+	.dapm_widgets	= tasdevice_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tasdevice_dapm_widgets),
+	.dapm_routes		= tasdevice_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(tasdevice_audio_map),
+	.idle_bias_on	= 1,
+	.endianness	= 1,
+};
+
+int tasdevice_dev_read(struct tasdevice_priv *tas_dev, unsigned int *reg,
+	unsigned int *val)
+{
+	int ret = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	ret = tas2783_sdw_read(tas_dev->sdw_peripheral,
+		reg, 4, (void *)val, 4);
+	dev_dbg(tas_dev->dev, "%s, read %x from reg %x. Result is (%d)\n",
+		__func__, *val, *reg, ret);
+	mutex_unlock(&tas_dev->dev_lock);
+	return ret;
+}
+
+static int tasdevice_init(struct tasdevice_priv *tas_dev)
+{
+	int ret = 0;
+
+	tas_dev->cur_prog = -1;
+	tas_dev->cur_conf = -1;
+
+	dev_dbg(tas_dev->dev, "%s was called for TAS2783.\n",  __func__);
+	mutex_init(&tas_dev->dev_lock);
+
+	dev_set_drvdata(tas_dev->dev, tas_dev);
+
+	mutex_init(&tas_dev->codec_lock);
+	ret = devm_snd_soc_register_component(tas_dev->dev,
+		&soc_codec_driver_tasdevice,
+		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
+	if (ret) {
+		dev_err(tas_dev->dev, "%s: codec register error:0x%08x\n",
+			__func__, ret);
+	}
+	dev_dbg(tas_dev->dev, "%s was called for TAS2783.\n",  __func__);
+
+	return ret;
+}
+
+static int tasdevice_read_prop(struct sdw_slave *slave)
+{
+	struct sdw_slave_prop *prop = &slave->prop;
+	int nval;
+	int i, j;
+	u32 bit;
+	unsigned long addr;
+	struct sdw_dpn_prop *dpn;
+
+	prop->scp_int1_mask =
+		SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
+
+	prop->paging_support = true;
+
+	/* first we need to allocate memory for set bits in port lists */
+	prop->source_ports = 0x04; /* BITMAP: 00000100 */
+	prop->sink_ports = 0x2; /* BITMAP:  00000010 */
+
+	nval = hweight32(prop->source_ports);
+	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
+		sizeof(*prop->src_dpn_prop), GFP_KERNEL);
+	if (!prop->src_dpn_prop)
+		return -ENOMEM;
+
+	i = 0;
+	dpn = prop->src_dpn_prop;
+	addr = prop->source_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[i].num = bit;
+		dpn[i].type = SDW_DPN_FULL;
+		dpn[i].simple_ch_prep_sm = true;
+		dpn[i].ch_prep_timeout = 10;
+		i++;
+	}
+
+	/* do this again for sink now */
+	nval = hweight32(prop->sink_ports);
+	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
+		sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
+	if (!prop->sink_dpn_prop)
+		return -ENOMEM;
+
+	j = 0;
+	dpn = prop->sink_dpn_prop;
+	addr = prop->sink_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[j].num = bit;
+		dpn[j].type = SDW_DPN_FULL;
+		dpn[j].simple_ch_prep_sm = true;
+		dpn[j].ch_prep_timeout = 10;
+		j++;
+	}
+
+	/* set the timeout values */
+	prop->clk_stop_timeout = 20;
+
+	dev_dbg(&slave->dev, "%s was performed.\n", __func__);
+
+	return 0;
+}
+
+static int tasdevice_io_init(struct device *dev, struct sdw_slave *slave)
+{
+	struct tasdevice_priv *tasdevice = dev_get_drvdata(dev);
+
+	if (tasdevice->hw_init)
+		return 0;
+
+	if (tasdevice->first_hw_init) {
+		regcache_cache_only(tasdevice->regmap, false);
+		regcache_cache_bypass(tasdevice->regmap, true);
+	} else {
+		/* PM runtime is only enabled when
+		 * a Slave reports as Attached
+		 * set autosuspend parameters
+		 */
+		pm_runtime_set_autosuspend_delay(&slave->dev, 3000);
+		pm_runtime_use_autosuspend(&slave->dev);
+
+		/* update count of parent 'active' children */
+		pm_runtime_set_active(&slave->dev);
+
+		/* make sure the device does not suspend immediately */
+		pm_runtime_mark_last_busy(&slave->dev);
+
+		pm_runtime_enable(&slave->dev);
+	}
+
+	pm_runtime_get_noresume(&slave->dev);
+
+	if (tasdevice->first_hw_init) {
+		regcache_cache_bypass(tasdevice->regmap, false);
+		regcache_mark_dirty(tasdevice->regmap);
+	} else
+		tasdevice->first_hw_init = true;
+
+	/* Mark Slave initialization complete */
+	tasdevice->hw_init = true;
+
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put_autosuspend(&slave->dev);
+
+	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
+	return 0;
+}
+
+static int tasdevice_update_status(struct sdw_slave *slave,
+	enum sdw_slave_status status)
+{
+	struct  tasdevice_priv *tasdevice = dev_get_drvdata(&slave->dev);
+
+	/* Update the status */
+	tasdevice->status = status;
+
+	if (status == SDW_SLAVE_UNATTACHED)
+		tasdevice->hw_init = false;
+
+	/* Perform initialization only if slave status
+	 * is present and hw_init flag is false
+	 */
+	if (tasdevice->hw_init || tasdevice->status != SDW_SLAVE_ATTACHED)
+		return 0;
+
+	/* perform I/O transfers required for Slave initialization */
+	return tasdevice_io_init(&slave->dev, slave);
+}
+
+/*
+ * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
+ * port_prep are not defined for now
+ */
+static const struct sdw_slave_ops tasdevice_sdw_ops = {
+	.read_prop	= tasdevice_read_prop,
+	.update_status	= tasdevice_update_status,
+};
+
+static void tasdevice_remove(struct tasdevice_priv *tas_dev)
+{
+	snd_soc_unregister_component(tas_dev->dev);
+	if (gpio_is_valid(tas_dev->rst_gpio))
+		gpio_free(tas_dev->rst_gpio);
+
+	if (gpio_is_valid(tas_dev->irq_info.irq_gpio))
+		gpio_free(tas_dev->irq_info.irq_gpio);
+
+	mutex_destroy(&tas_dev->dev_lock);
+	mutex_destroy(&tas_dev->codec_lock);
+}
+
+static int tasdevice_sdw_probe(struct sdw_slave *peripheral,
+	const struct sdw_device_id *id)
+{
+	struct device *dev = &peripheral->dev;
+	struct tasdevice_priv *tas_dev;
+	int ret = 0;
+
+	dev_dbg(dev, "%s was called for TAS2783.\n",  __func__);
+
+	tas_dev = devm_kzalloc(dev, sizeof(*tas_dev), GFP_KERNEL);
+	if (!tas_dev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	tas_dev->dev = &peripheral->dev;
+	tas_dev->sdw_peripheral = peripheral;
+	tas_dev->chip_id = id->driver_data;
+	tas_dev->sdw_slave = peripheral;
+	tas_dev->hw_init = false;
+	tas_dev->first_hw_init = false;
+
+	dev_dbg(dev, "%d chip id %x for TAS2783.\n",
+	peripheral->id.unique_id, tas_dev->chip_id);
+
+	dev_set_drvdata(dev, tas_dev);
+
+	tas_dev->regmap = devm_regmap_init(dev, &tas2783_regmap_bus_sdw,
+		peripheral, &tasdevice_regmap);
+	if (IS_ERR(tas_dev->regmap)) {
+		ret = PTR_ERR(tas_dev->regmap);
+		dev_err(dev, "Failed devm_regmap_init: %d\n", ret);
+		goto out;
+	}
+	ret = tasdevice_init(tas_dev);
+
+out:
+	if (ret < 0 && tas_dev != NULL)
+		tasdevice_remove(tas_dev);
+
+	dev_dbg(dev, "%s was called for TAS2783.\n",  __func__);
+	return ret;
+
+}
+
+static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
+{
+	struct tasdevice_priv *tas_dev =
+		dev_get_drvdata(&peripheral->dev);
+
+	if (tas_dev)
+		tasdevice_remove(tas_dev);
+
+	return 0;
+}
+
+static const struct sdw_device_id tasdevice_sdw_id[] = {
+	SDW_SLAVE_ENTRY(0x0102, 0x0, 0),
+	{},
+};
+MODULE_DEVICE_TABLE(sdw, tasdevice_sdw_id);
+
+static struct sdw_driver tasdevice_sdw_driver = {
+	.driver = {
+		.name = "slave-tas2783",
+	},
+	.probe = tasdevice_sdw_probe,
+	.remove = tasdevice_sdw_remove,
+	.ops = &tasdevice_sdw_ops,
+	.id_table = tasdevice_sdw_id,
+};
+
+module_sdw_driver(tasdevice_sdw_driver);
+
+MODULE_AUTHOR("Baojun Xu <baojun.xu@ti.com>");
+MODULE_DESCRIPTION("ASoC TAS2783 SoundWire Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tas2783.h b/sound/soc/codecs/tas2783.h
new file mode 100644
index 000000000000..0fa5b3855b51
--- /dev/null
+++ b/sound/soc/codecs/tas2783.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2783 driver implements a flexible and configurable
+ * algo coff setting for single TAS2783 chips.
+ *
+ * Author: Baojun Xu <baojun.xu@ti.com>
+ */
+
+#ifndef __TAS2783_H__
+#define __TAS2783_H__
+
+#define TASDEVICE_RATES			(SNDRV_PCM_RATE_44100 | \
+					SNDRV_PCM_RATE_48000 | \
+					SNDRV_PCM_RATE_96000 | \
+					SNDRV_PCM_RATE_88200)
+#define TAS2783_SDW_ADDR_OFFSET		0x8000
+
+#define TASDEVICE_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+/* BOOK, PAGE Control Register */
+#define TASDEVICE_REG(book, page, reg)	((book * 256 * 256) + 0x8000 +\
+					(page * 128) + reg)
+
+/*Software Reset */
+#define TAS2873_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x01)
+#define TAS2873_REG_SWRESET_RESET	BIT(0)
+
+/* Volume control */
+#define TAS2783_DVC_LVL			TASDEVICE_REG(0x0, 0x00, 0x1A)
+#define TAS2783_AMP_LEVEL		TASDEVICE_REG(0x0, 0x00, 0x03)
+#define TAS2783_AMP_LEVEL_MASK		GENMASK(5, 1)
+
+/* Calibration data */
+#define TAS2783_CALIBRATION_RE		TASDEVICE_REG(0x0, 0x17, 0x74)
+#define TAS2783_CALIBRATION_RE_LOW	TASDEVICE_REG(0x0, 0x18, 0x14)
+#define TAS2783_CALIBRATION_INV_RE	TASDEVICE_REG(0x0, 0x18, 0x0c)
+#define TAS2783_CALIBRATION_POW		TASDEVICE_REG(0x0, 0x0d, 0x3c)
+#define TAS2783_CALIBRATION_TLIMIT	TASDEVICE_REG(0x0, 0x18, 0x7c)
+
+#define TAS2783_CALIBRATION_SIZE	5	// int data number.
+
+#define TAS2783_DEVICE_ID_START		0x08	// Unique id start
+#define TAS2783_DEVICE_ID_END		0x0F	// Unique id end
+
+/* TAS2783 SDCA Control - function number */
+#define FUNC_NUM_SMART_AMP		0x01
+
+/* TAS2783 SDCA entity */
+#define TAS2783_SDCA_ENT_PDE23		0x0C
+#define TAS2783_SDCA_ENT_PDE22		0x0B
+#define TAS2783_SDCA_ENT_FU21		0x01
+#define TAS2783_SDCA_ENT_UDMPU21	0x10
+
+/* TAS2783 SDCA control */
+#define TAS2783_SDCA_CTL_REQ_POWER_STATE	0x01
+#define TAS2783_SDCA_CTL_FU_MUTE		0x01
+#define TAS2783_SDCA_CTL_UDMPU_CLUSTER		0x10
+
+#define CH_L	1
+#define CH_R	2
+
+#define TASDEVICE_CRC8_POLYNOMIAL	0x4d
+
+#define MAX_NO_FILES			100
+#define MAX_CALIBRATION_DATA_SIZE	252
+
+#define SMS_HTONL(a, b, c, d)		((((a)&0x000000FF)<<24) | \
+					(((b)&0x000000FF)<<16) | \
+					(((c)&0x000000FF)<<8) | \
+					((d)&0x000000FF))
+
+enum channel {
+	top_left_Chn,
+	top_right_chn,
+	bottom_left_Chn,
+	bottom_right_chn,
+	max_chn,
+};
+
+struct tasdevice {
+	unsigned int dev_addr;
+	unsigned int err_code;
+	short cur_prog;
+	short cur_conf;
+	bool is_loading;
+	bool is_loaderr;
+	bool is_calibrated_data_loaded;
+	unsigned char cur_book;
+	struct tasdevice_fw *cali_data_fmw;
+};
+
+struct MYSWFTFile {
+	unsigned int m_vendor_id;
+	unsigned int m_file_id;
+	unsigned int m_version;
+	unsigned int m_Length;
+	unsigned int m_downloadAddr;
+	unsigned char *m_startAdress;
+};
+
+/*
+ * This item is used to store the generic i2c address of
+ * all the tas2781 devices for I2C broadcast during the multi-device
+ *	writes, useless in mono case.
+ */
+struct global_addr {
+	unsigned char cur_book;
+	unsigned int dev_addr;
+	int ref_cnt;
+};
+
+struct calibration_data {
+	unsigned long total_sz;
+	unsigned char data[MAX_CALIBRATION_DATA_SIZE];
+};
+
+struct tas_control {
+	struct snd_kcontrol_new *tasdevice_profile_controls;
+	int nr_controls;
+};
+
+struct tasdevice_irqinfo {
+	int irq_gpio;
+	int irq;
+};
+
+struct tasdevice_priv {
+	struct device *dev;
+	struct snd_soc_component *component;
+	struct sdw_slave *sdw_slave;
+	enum sdw_slave_status status;
+	struct sdw_bus_params params;
+	struct regmap *regmap;
+	struct mutex codec_lock;
+	struct mutex dev_lock;
+	int rst_gpio;
+	struct tasdevice tasdevice[max_chn];
+	struct tasdevice_fw *fmw;
+	struct tasdevice_irqinfo irq_info;
+	struct tas_control tas_ctrl;
+	struct sdw_slave *sdw_peripheral;
+	struct global_addr glb_addr;
+	struct calibration_data cali_data;
+	struct tm tm;
+	int cur_prog;
+	int cur_conf;
+	unsigned int chip_id;
+	bool hw_init;
+	bool first_hw_init;
+	unsigned char *bq_params;
+	unsigned int magic_num;
+	unsigned char ndev;
+	unsigned char dev_name[32];
+	unsigned char rca_binaryname[64];
+	unsigned char coef_binaryname[64];
+	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
+
+	struct MYSWFTFile m_swftFile[MAX_NO_FILES];
+
+	void *codec;
+	unsigned int sysclk;
+	bool is_glb_calibrated_data_loaded;
+};
+
+struct sdw_stream_data {
+	struct sdw_stream_runtime *sdw_stream;
+};
+
+int tasdevice_dev_read(struct tasdevice_priv *tasdevice,
+	unsigned int *reg, unsigned int *value);
+
+#endif /*__TAS2783_H__ */
-- 
2.34.1

