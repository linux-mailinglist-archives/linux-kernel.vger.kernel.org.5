Return-Path: <linux-kernel+bounces-138353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B008589F012
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655312830CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAE159583;
	Wed, 10 Apr 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aMw+V4mo"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E545159570;
	Wed, 10 Apr 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745645; cv=none; b=eTnbpnh/ThTxTlzen3yyi8j18coH9C93VGvXnG8t5RlLlfufvr/uLTTO9YENtZvQw3VhkGYNaWN2Kp+63SjGePcPm8felAukH4G9vXjIRvuapEBnjiJ5TC17in4uj5POSkXP4V2Gi7Yc4v0jH2WQHcSVbFhf/QH2qcCxwDKPtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745645; c=relaxed/simple;
	bh=q1irJWxB8tD2HNGt1c41YE6Q6vsCNZ0KDdeT90xsXAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAR+f+I+6CQ11bwm2+w5a56jgLJ701c7hnRN6fPrwJu6k1Ko3fRzXUA3I42Wi7x97mFyNZxN7N8L/+7I8NC8BehZ6CxqnQCftuwkAsvhYSjDAG60p+vsjTkJUm11wCHkiZ52SLbyZNhwiJpRDFcsEgkzFAwr5QDO5fZF64cheNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aMw+V4mo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c5b08ac8f72611ee935d6952f98a51a9-20240410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y2nGKyYGIfib5EujU7UZEr+eGWw05GutWkxCpvQ21Ms=;
	b=aMw+V4mobUmmeILKulPalGX9Y/XpTv6AQvT7isvfy2OzKfvbQ5mgxgXmdORPwqWpOZ/GG9o3yw3c+cGVyIr9oJflJnwkLQ2V3yLVb9PVotwozFdrAMFD2GrkToals9O9+SIrX7JhxhdpyC/o/s7FOgakyVFW3XeUFfRQo+rNmWM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:67cc3104-0150-4da9-8026-5f97bdf694ce,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:eed58282-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c5b08ac8f72611ee935d6952f98a51a9-20240410
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2077058293; Wed, 10 Apr 2024 18:40:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Apr 2024 18:40:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Apr 2024 18:40:35 +0800
From: Zhi Mao <zhi.mao@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Zhi Mao <zhi.mao@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>, Heiko Stuebner
	<heiko@sntech.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, Alain Volmat
	<alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, "Mehdi
 Djait" <mehdi.djait@bootlin.com>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Bingbu Cao <bingbu.cao@intel.com>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <shengnan.wang@mediatek.com>,
	<yaya.chang@mediatek.com>, <yunkec@chromium.org>, <10572168@qq.com>
Subject: [PATCH 2/2] media: i2c: Add GT97xx VCM driver
Date: Wed, 10 Apr 2024 18:40:02 +0800
Message-ID: <20240410104002.1197-3-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410104002.1197-1-zhi.mao@mediatek.com>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.399800-8.000000
X-TMASE-MatchedRID: 4je3esFcrFmuhCBFl/b63m3NvezwBrVmK2i9pofGVSvvSbc8qoHu0V/2
	zKXxjR59dilmHfdk4Tzvl3F3WAnK8EgYkh+Pnbt/uIwLnB3Aqp2WHGENdT+VP8SiwizsgluQEXF
	HklABLo4L/rn9cjOlgV7bEojljVTyWELDcKwGO25AwvZYEy8IBQeCHewokHM/vDa284z78ydRUm
	37T3QxGdPcPSKth3KMrXycfZUapf3Ii7cjtJh/qO0yyL51qL/Recvjbu/xDjoICvU2ldz9nPG39
	9+Ui/tdDLpQmsyyTdHxKKMU+AEVB2DSz0Ilzxe8SxG/I0MjmF7m1SQ5tAvJowqiCYa6w8tvbspa
	lvknN/SshdvVUTn+vXkNrWD+KBWtkCbHRyY/mHh1e7Xbb6Im2juvYa1v2IFhRQ0dAChl/ly8KbV
	ax4fgHae3n2JYRI7aflkRI5fbnRK2hcz59QjjVm095hplj6TXYpovC7zX5q9GLFOR6NNrKUA80c
	np3WUbHOEcT8k/SUnEN6pAvUdaaxXfDcvxC40QQuFiD+xrWCzvkROLxAaM3Lqln+jYe7ZhYyRCC
	UIJqJD4TgXj1oYZ2cX5+MUrTWe6hrD3pNcSx1Yo19GoN4WoGPqtWPv3hAK2al05V6RMtNGjxYyR
	Ba/qJcFwgTvxipFajoczmuoPCq2f3HOOMOLv4plY9pu8EYtAVYT3VJVOBgvPISuleFpwTVlbUWa
	H89qG
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.399800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CD5922993DB11F85A4B44BB15E802D87827F4F74A06D0977CF35421BEA8C44EE2000:8
X-MTK: N

Add a V4L2 sub-device driver for Giantec GT97xx VCM.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/media/i2c/Kconfig  |  13 +
 drivers/media/i2c/Makefile |   1 +
 drivers/media/i2c/gt97xx.c | 640 +++++++++++++++++++++++++++++++++++++
 3 files changed, 654 insertions(+)
 create mode 100644 drivers/media/i2c/gt97xx.c

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 56f276b920ab..fcb330cebfe0 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -759,6 +759,19 @@ config VIDEO_DW9807_VCM
 	  capability. This is designed for linear control of
 	  voice coil motors, controlled via I2C serial interface.
 
+config VIDEO_GT97XX
+	tristate "GT97xx lens voice coil support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	select V4L2_CCI_I2C
+	help
+	  This is a driver for the GT97xx camera lens voice coil.
+	  GT97xx is a 10 bit DAC with 100mA output current sink
+	  capability. It is designed for linear control of
+	  voice coil motors, controlled via I2C serial interface.
+
 endmenu
 
 menu "Flash devices"
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index dfbe6448b549..af36a7aa3d12 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_VIDEO_DW9807_VCM) += dw9807-vcm.o
 obj-$(CONFIG_VIDEO_ET8EK8) += et8ek8/
 obj-$(CONFIG_VIDEO_GC0308) += gc0308.o
 obj-$(CONFIG_VIDEO_GC2145) += gc2145.o
+obj-$(CONFIG_VIDEO_GT97XX) += gt97xx.o
 obj-$(CONFIG_VIDEO_HI556) += hi556.o
 obj-$(CONFIG_VIDEO_HI846) += hi846.o
 obj-$(CONFIG_VIDEO_HI847) += hi847.o
diff --git a/drivers/media/i2c/gt97xx.c b/drivers/media/i2c/gt97xx.c
new file mode 100644
index 000000000000..d91314b872fa
--- /dev/null
+++ b/drivers/media/i2c/gt97xx.c
@@ -0,0 +1,640 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Giantec gt97xx VCM lens device
+ *
+ * Copyright 2024 MediaTek
+ *
+ * Zhi Mao <zhi.mao@mediatek.com>
+ */
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <media/v4l2-cci.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+/* gt97xx chip info register and name */
+#define GT97XX_IC_INFO_REG CCI_REG8(0x00)
+#define GT9768_ID 0xE9
+#define GT9769_ID 0xE1
+#define GT97XX_NAME "gt97xx"
+
+/*
+ * Ring control and Power control register
+ * Bit[1] RING_EN
+ * 0: Direct mode
+ * 1: AAC mode (ringing control mode)
+ * Bit[0] PD
+ * 0: Normal operation mode
+ * 1: Power down mode
+ * gt97xx requires waiting time of Topr after PD reset takes place.
+ */
+#define GT97XX_RING_PD_CONTROL_REG CCI_REG8(0x02)
+#define GT97XX_PD_MODE_OFF 0x00
+#define GT97XX_PD_MODE_EN BIT(0)
+#define GT97XX_AAC_MODE_EN BIT(1)
+
+/*
+ * gt97xx separates two registers to control the VCM position.
+ * One for MSB value, another is LSB value.
+ * DAC_MSB: D[9:8] (ADD: 0x03)
+ * DAC_LSB: D[7:0] (ADD: 0x04)
+ * D[9:0] DAC data input: positive output current = D[9:0] / 1023 * 100[mA]
+ */
+#define GT97XX_MSB_ADDR_REG CCI_REG16(0x03)
+
+/*
+ * AAC mode control & prescale register
+ * Bit[7:5] Namely AC[2:0], decide the VCM mode and operation time.
+ * 001 AAC2 0.48 x Tvib
+ * 010 AAC3 0.70 x Tvib
+ * 011 AAC4 0.75 x Tvib
+ * 101 AAC8 1.13 x Tvib
+ * Bit[2:0] Namely PRESC[2:0], set the internal clock dividing rate as follow.
+ * 000 2
+ * 001 1
+ * 010 1/2
+ * 011 1/4
+ * 100 8
+ * 101 4
+ */
+#define GT97XX_AAC_PRESC_REG CCI_REG8(0x06)
+#define GT97XX_AAC_MODE_SEL_MASK GENMASK(7, 5)
+#define GT97XX_CLOCK_PRE_SCALE_SEL_MASK GENMASK(2, 0)
+
+/*
+ * VCM period of vibration register
+ * Bit[5:0] Defined as VCM rising periodic time (Tvib) together with PRESC[2:0]
+ * Tvib = (6.3ms + AACT[5:0] * 0.1ms) * Dividing Rate
+ * Dividing Rate is the internal clock dividing rate that is defined at
+ * PRESCALE register (ADD: 0x06)
+ */
+#define GT97XX_AAC_TIME_REG CCI_REG8(0x07)
+
+/*
+ * gt97xx requires waiting time (delay time) of t_OPR after power-up,
+ * or in the case of PD reset taking place.
+ */
+#define GT97XX_T_OPR_US (1 * USEC_PER_MSEC)
+#define GT97XX_TVIB_MS_BASE10 (64 - 1)
+#define GT97XX_AAC_MODE_DEFAULT 2
+#define GT97XX_AAC_TIME_DEFAULT 0x20
+#define GT97XX_CLOCK_PRE_SCALE_DEFAULT 1
+
+/*
+ * This acts as the minimum granularity of lens movement.
+ * Keep this value power of 2, so the control steps can be
+ * uniformly adjusted for gradual lens movement, with desired
+ * number of control steps.
+ */
+#define GT97XX_MOVE_STEPS 16
+#define GT97XX_MAX_FOCUS_POS (1024 - 1)
+
+/*
+ * This sets the minimum granularity for the focus positions.
+ * A value of 1 gives maximum accuracy for a desired focus position
+ */
+#define GT97XX_FOCUS_STEPS 1
+
+enum vcm_giantec_reg_desc {
+	GT_IC_INFO_REG,
+	GT_RING_PD_CONTROL_REG,
+	GT_MSB_ADDR_REG,
+	GT_AAC_PRESC_REG,
+	GT_AAC_TIME_REG,
+	GT_MAX_REG,
+};
+
+struct vcm_giantec_of_data {
+	unsigned int id;
+	unsigned int regs[GT_MAX_REG];
+};
+
+static const char *const gt97xx_supply_names[] = {
+	"vin", /* Digital I/O power */
+	"vdd", /* Digital core power */
+};
+
+/* gt97xx device structure */
+struct gt97xx {
+	struct v4l2_subdev sd;
+
+	struct regulator_bulk_data supplies[ARRAY_SIZE(gt97xx_supply_names)];
+
+	struct v4l2_ctrl_handler ctrls;
+	struct v4l2_ctrl *focus;
+
+	u32 aac_mode;
+	u32 aac_timing;
+	u32 clock_presc;
+	u32 move_delay_us;
+
+	struct regmap *regmap;
+
+	const struct vcm_giantec_of_data *chip;
+};
+
+static inline struct gt97xx *sd_to_gt97xx(struct v4l2_subdev *subdev)
+{
+	return container_of(subdev, struct gt97xx, sd);
+}
+
+struct regval_list {
+	u8 reg_num;
+	u8 value;
+};
+
+struct gt97xx_aac_mode_ot_multi {
+	u32 aac_mode_enum;
+	u32 ot_multi_base100;
+};
+
+struct gt97xx_clk_presc_dividing_rate {
+	u32 clk_presc_enum;
+	u32 dividing_rate_base100;
+};
+
+static const struct gt97xx_aac_mode_ot_multi aac_mode_ot_multi[] = {
+	{ 1, 48 },
+	{ 2, 70 },
+	{ 3, 75 },
+	{ 5, 113 },
+};
+
+static const struct gt97xx_clk_presc_dividing_rate presc_dividing_rate[] = {
+	{ 0, 200 }, { 1, 100 }, { 2, 50 }, { 3, 25 }, { 4, 800 }, { 5, 400 },
+};
+
+static u32 gt97xx_find_ot_multi(u32 aac_mode_param)
+{
+	u32 cur_ot_multi_base100 = 70;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(aac_mode_ot_multi); i++) {
+		if (aac_mode_ot_multi[i].aac_mode_enum == aac_mode_param) {
+			cur_ot_multi_base100 =
+				aac_mode_ot_multi[i].ot_multi_base100;
+		}
+	}
+
+	return cur_ot_multi_base100;
+}
+
+static u32 gt97xx_find_dividing_rate(u32 presc_param)
+{
+	u32 cur_clk_dividing_rate_base100 = 100;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(presc_dividing_rate); i++) {
+		if (presc_dividing_rate[i].clk_presc_enum == presc_param) {
+			cur_clk_dividing_rate_base100 =
+				presc_dividing_rate[i].dividing_rate_base100;
+		}
+	}
+
+	return cur_clk_dividing_rate_base100;
+}
+
+/*
+ * GT97xx_AAC_PRESC_REG & GT97xx_AAC_TIME_REG determine VCM operation time.
+ * For current VCM mode: AAC3, Operation Time would be 0.70 x Tvib.
+ * Tvib = (6.3ms + AACT[5:0] * 0.1MS) * Dividing Rate.
+ * Below is calculation of the operation delay for each step.
+ */
+static inline u32 gt97xx_cal_move_delay(u32 aac_mode_param, u32 presc_param,
+					u32 aac_timing_param)
+{
+	u32 tvib_us;
+	u32 ot_multi_base100;
+	u32 clk_dividing_rate_base100;
+
+	ot_multi_base100 = gt97xx_find_ot_multi(aac_mode_param);
+
+	clk_dividing_rate_base100 = gt97xx_find_dividing_rate(presc_param);
+
+	tvib_us = (GT97XX_TVIB_MS_BASE10 + aac_timing_param) *
+		  clk_dividing_rate_base100;
+
+	return tvib_us * ot_multi_base100 / 100;
+}
+
+static int gt97xx_mod_reg(struct gt97xx *gt97xx, u32 reg, u8 mask, u8 val)
+{
+	u64 read_val;
+	int ret;
+
+	ret = cci_read(gt97xx->regmap, reg, &read_val, NULL);
+	if (ret < 0)
+		return ret;
+
+	val = ((unsigned char)read_val & ~mask) | (val & mask);
+
+	return cci_write(gt97xx->regmap, reg, val, NULL);
+}
+
+static int gt97xx_set_dac(struct gt97xx *gt97xx, u16 val)
+{
+	/* Write VCM position to registers */
+	return cci_write(gt97xx->regmap,
+			 gt97xx->chip->regs[GT_MSB_ADDR_REG], val, NULL);
+}
+
+static int gt97xx_identify_module(struct gt97xx *gt97xx)
+{
+	int ret;
+	u64 ic_id;
+	struct i2c_client *client = v4l2_get_subdevdata(&gt97xx->sd);
+
+	ret = cci_read(gt97xx->regmap, gt97xx->chip->regs[GT_IC_INFO_REG],
+		       &ic_id, NULL);
+	if (ret < 0)
+		return ret;
+
+	if (ic_id != gt97xx->chip->id) {
+		dev_err(&client->dev, "chip id mismatch: 0x%x!=0x%llx",
+			gt97xx->chip->id, ic_id);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int gt97xx_init(struct gt97xx *gt97xx)
+{
+	int ret, val;
+
+	ret = gt97xx_identify_module(gt97xx);
+	if (ret < 0)
+		return ret;
+
+	/* Reset GT97xx_RING_PD_CONTROL_REG to default status 0x00 */
+	ret = cci_write(gt97xx->regmap,
+			gt97xx->chip->regs[GT_RING_PD_CONTROL_REG],
+			GT97XX_PD_MODE_OFF, NULL);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * GT97xx requires waiting delay time of t_OPR
+	 * after PD reset takes place.
+	 */
+	fsleep(GT97XX_T_OPR_US);
+
+	/* Set GT97xx_RING_PD_CONTROL_REG to GT97xx_AAC_MODE_EN(0x01) */
+	ret = cci_write(gt97xx->regmap,
+			gt97xx->chip->regs[GT_RING_PD_CONTROL_REG],
+			GT97XX_AAC_MODE_EN, NULL);
+	if (ret < 0)
+		return ret;
+
+	/* Set AAC mode */
+	ret = gt97xx_mod_reg(gt97xx, gt97xx->chip->regs[GT_AAC_PRESC_REG],
+			     GT97XX_AAC_MODE_SEL_MASK, gt97xx->aac_mode << 5);
+	if (ret < 0)
+		return ret;
+
+	/* Set clock presc */
+	if (gt97xx->clock_presc != GT97XX_CLOCK_PRE_SCALE_DEFAULT) {
+		ret = gt97xx_mod_reg(gt97xx,
+				     gt97xx->chip->regs[GT_AAC_PRESC_REG],
+				     GT97XX_CLOCK_PRE_SCALE_SEL_MASK,
+				     gt97xx->clock_presc);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Set AAC Timing */
+	if (gt97xx->aac_timing != GT97XX_AAC_TIME_DEFAULT) {
+		ret = cci_write(gt97xx->regmap,
+				gt97xx->chip->regs[GT_AAC_TIME_REG],
+				gt97xx->aac_timing, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (val = gt97xx->focus->val % GT97XX_MOVE_STEPS;
+	     val <= gt97xx->focus->val; val += GT97XX_MOVE_STEPS) {
+		ret = gt97xx_set_dac(gt97xx, val);
+		if (ret)
+			return ret;
+
+		fsleep(gt97xx->move_delay_us);
+	}
+
+	return 0;
+}
+
+static int gt97xx_release(struct gt97xx *gt97xx)
+{
+	int ret, val;
+
+	val = round_down(gt97xx->focus->val, GT97XX_MOVE_STEPS);
+	for (; val >= 0; val -= GT97XX_MOVE_STEPS) {
+		ret = gt97xx_set_dac(gt97xx, val);
+		if (ret)
+			return ret;
+
+		fsleep(gt97xx->move_delay_us);
+	}
+
+	return 0;
+}
+
+static int gt97xx_power_on(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct gt97xx *gt97xx = sd_to_gt97xx(sd);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(gt97xx_supply_names),
+				    gt97xx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable regulators\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int gt97xx_power_off(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct gt97xx *gt97xx = sd_to_gt97xx(sd);
+	int ret;
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(gt97xx_supply_names),
+				     gt97xx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "failed to disable regulators\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int gt97xx_runtime_suspend(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct gt97xx *gt97xx = sd_to_gt97xx(sd);
+
+	gt97xx_release(gt97xx);
+	gt97xx_power_off(dev);
+
+	return 0;
+}
+
+static int gt97xx_runtime_resume(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct gt97xx *gt97xx = sd_to_gt97xx(sd);
+	int ret;
+
+	ret = gt97xx_power_on(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to power_on\n");
+		return ret;
+	}
+
+	/*
+	 * The datasheet refers to t_OPR that needs to be waited before sending
+	 * I2C commands after power-up.
+	 */
+	fsleep(GT97XX_T_OPR_US);
+
+	ret = gt97xx_init(gt97xx);
+	if (ret < 0)
+		goto disable_power;
+
+	return 0;
+
+disable_power:
+	gt97xx_power_off(dev);
+
+	return ret;
+}
+
+static int gt97xx_set_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct gt97xx *gt97xx =
+		container_of(ctrl->handler, struct gt97xx, ctrls);
+
+	if (ctrl->id == V4L2_CID_FOCUS_ABSOLUTE)
+		return gt97xx_set_dac(gt97xx, ctrl->val);
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops gt97xx_ctrl_ops = {
+	.s_ctrl = gt97xx_set_ctrl,
+};
+
+static int gt97xx_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	return pm_runtime_resume_and_get(sd->dev);
+}
+
+static int gt97xx_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	return pm_runtime_put(sd->dev);
+}
+
+static const struct v4l2_subdev_internal_ops gt97xx_int_ops = {
+	.open = gt97xx_open,
+	.close = gt97xx_close,
+};
+
+static const struct v4l2_subdev_core_ops gt97xx_core_ops = {
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_ops gt97xx_ops = {
+	.core = &gt97xx_core_ops,
+};
+
+static int gt97xx_init_controls(struct gt97xx *gt97xx)
+{
+	struct v4l2_ctrl_handler *hdl = &gt97xx->ctrls;
+	const struct v4l2_ctrl_ops *ops = &gt97xx_ctrl_ops;
+
+	v4l2_ctrl_handler_init(hdl, 1);
+
+	gt97xx->focus = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_FOCUS_ABSOLUTE, 0,
+					  GT97XX_MAX_FOCUS_POS,
+					  GT97XX_FOCUS_STEPS, 0);
+
+	if (hdl->error)
+		return hdl->error;
+
+	gt97xx->sd.ctrl_handler = hdl;
+
+	return 0;
+}
+
+static int gt97xx_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct gt97xx *gt97xx;
+	unsigned int i;
+	int ret;
+
+	gt97xx = devm_kzalloc(dev, sizeof(*gt97xx), GFP_KERNEL);
+	if (!gt97xx)
+		return -ENOMEM;
+
+	gt97xx->regmap = devm_cci_regmap_init_i2c(client, 8);
+	if (IS_ERR(gt97xx->regmap))
+		return dev_err_probe(dev, PTR_ERR(gt97xx->regmap),
+				     "failed to init CCI\n");
+
+	/* Initialize subdev */
+	v4l2_i2c_subdev_init(&gt97xx->sd, client, &gt97xx_ops);
+
+	gt97xx->chip = of_device_get_match_data(dev);
+
+	gt97xx->aac_mode = GT97XX_AAC_MODE_DEFAULT;
+	gt97xx->aac_timing = GT97XX_AAC_TIME_DEFAULT;
+	gt97xx->clock_presc = GT97XX_CLOCK_PRE_SCALE_DEFAULT;
+
+	/* Optional indication of AAC mode select */
+	fwnode_property_read_u32(dev_fwnode(dev), "giantec,aac-mode",
+				 &gt97xx->aac_mode);
+
+	/* Optional indication of clock pre-scale select */
+	fwnode_property_read_u32(dev_fwnode(dev), "giantec,clock-presc",
+				 &gt97xx->clock_presc);
+
+	/* Optional indication of AAC Timing */
+	fwnode_property_read_u32(dev_fwnode(dev), "giantec,aac-timing",
+				 &gt97xx->aac_timing);
+
+	gt97xx->move_delay_us = gt97xx_cal_move_delay(gt97xx->aac_mode,
+						      gt97xx->clock_presc,
+						      gt97xx->aac_timing);
+
+	for (i = 0; i < ARRAY_SIZE(gt97xx_supply_names); i++)
+		gt97xx->supplies[i].supply = gt97xx_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(gt97xx_supply_names),
+				      gt97xx->supplies);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to get regulators\n");
+
+	/* Initialize controls */
+	ret = gt97xx_init_controls(gt97xx);
+	if (ret)
+		goto err_free_handler;
+
+	/* Initialize subdev */
+	gt97xx->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	gt97xx->sd.internal_ops = &gt97xx_int_ops;
+	gt97xx->sd.entity.function = MEDIA_ENT_F_LENS;
+
+	ret = media_entity_pads_init(&gt97xx->sd.entity, 0, NULL);
+	if (ret < 0)
+		goto err_free_handler;
+
+	/*power on and Initialize hw*/
+	ret = gt97xx_runtime_resume(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to power on: %d\n", ret);
+		goto err_clean_entity;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_idle(dev);
+
+	ret = v4l2_async_register_subdev(&gt97xx->sd);
+	if (ret < 0) {
+		dev_err(dev, "failed to register V4L2 subdev: %d", ret);
+		goto err_power_off;
+	}
+
+	return 0;
+
+err_power_off:
+	pm_runtime_disable(dev);
+err_clean_entity:
+	media_entity_cleanup(&gt97xx->sd.entity);
+err_free_handler:
+	v4l2_ctrl_handler_free(&gt97xx->ctrls);
+
+	return ret;
+}
+
+static void gt97xx_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct gt97xx *gt97xx = sd_to_gt97xx(sd);
+
+	v4l2_async_unregister_subdev(&gt97xx->sd);
+	v4l2_ctrl_handler_free(&gt97xx->ctrls);
+	media_entity_cleanup(&gt97xx->sd.entity);
+	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev))
+		gt97xx_runtime_suspend(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(gt97xx_pm_ops,
+				 gt97xx_runtime_suspend,
+				 gt97xx_runtime_resume,
+				 NULL);
+
+static const struct vcm_giantec_of_data gt9768_data = {
+	.id = GT9768_ID,
+	.regs[GT_IC_INFO_REG] = GT97XX_IC_INFO_REG,
+	.regs[GT_RING_PD_CONTROL_REG] = GT97XX_RING_PD_CONTROL_REG,
+	.regs[GT_MSB_ADDR_REG] = GT97XX_MSB_ADDR_REG,
+	.regs[GT_AAC_PRESC_REG] = GT97XX_AAC_PRESC_REG,
+	.regs[GT_AAC_TIME_REG] = GT97XX_AAC_TIME_REG,
+};
+
+static const struct vcm_giantec_of_data gt9769_data = {
+	.id = GT9769_ID,
+	.regs[GT_IC_INFO_REG] = GT97XX_IC_INFO_REG,
+	.regs[GT_RING_PD_CONTROL_REG] = GT97XX_RING_PD_CONTROL_REG,
+	.regs[GT_MSB_ADDR_REG] = GT97XX_MSB_ADDR_REG,
+	.regs[GT_AAC_PRESC_REG] = GT97XX_AAC_PRESC_REG,
+	.regs[GT_AAC_TIME_REG] = GT97XX_AAC_TIME_REG,
+};
+
+static const struct of_device_id gt97xx_of_table[] = {
+	{ .compatible = "giantec,gt9768", .data = &gt9768_data },
+	{ .compatible = "giantec,gt9769", .data = &gt9769_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gt97xx_of_table);
+
+static struct i2c_driver gt97xx_i2c_driver = {
+	.driver = {
+		.name = GT97XX_NAME,
+		.pm = pm_ptr(&gt97xx_pm_ops),
+		.of_match_table = gt97xx_of_table,
+	},
+	.probe = gt97xx_probe,
+	.remove = gt97xx_remove,
+};
+module_i2c_driver(gt97xx_i2c_driver);
+
+MODULE_AUTHOR("Zhi Mao <zhi.mao@mediatek.com>");
+MODULE_DESCRIPTION("GT97xx VCM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


