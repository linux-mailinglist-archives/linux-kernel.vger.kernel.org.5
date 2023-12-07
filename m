Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A0808019
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjLGFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:20:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48AD5C;
        Wed,  6 Dec 2023 21:20:57 -0800 (PST)
X-UUID: 638909f694c011eea5db2bebc7c28f94-20231207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Fyfpe3LxnuJLXOLQfS3NqTFfJcf+6vpMvtHX6idSYt8=;
        b=KBJ7eMZ2iiGWhgerPllAbHh0B+yHvU09xWXVm4XLawMY27+VMj4M+gbdh7Y3+L9HD9YD9ZYcbJ4NmlrWadHVu9w9v/Lc5SMU8ZboMVdppboc6XniK9PoZMBCK/zQNEkjXCoXetJKVd+mVVrF32U5CACidCO3CmuFRk6+RD5lQ70=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:942b7674-73f2-444b-bc07-0c2fc94bbe7d,IP:0,U
        RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-20
X-CID-META: VersionHash:5d391d7,CLOUDID:a8418173-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 638909f694c011eea5db2bebc7c28f94-20231207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <zhi.mao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1491346019; Thu, 07 Dec 2023 13:20:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Dec 2023 13:20:50 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Dec 2023 13:20:49 +0800
From:   Zhi Mao <zhi.mao@mediatek.com>
To:     <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <shengnan.wang@mediatek.com>, <yaya.chang@mediatek.com>,
        <10572168@qq.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <yunkec@chromium.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <jacopo.mondi@ideasonboard.com>, <sakari.ailus@linux.intel.com>,
        <zhi.mao@mediatek.com>, <hverkuil-cisco@xs4all.nl>,
        <heiko@sntech.de>, <jernej.skrabec@gmail.com>,
        <macromorgan@hotmail.com>, <linus.walleij@linaro.org>,
        <laurent.pinchart@ideasonboard.com>, <hdegoede@redhat.com>,
        <tomi.valkeinen@ideasonboard.com>, <gerald.loacker@wolfvision.net>,
        <andy.shevchenko@gmail.com>, <bingbu.cao@intel.com>,
        <dan.scally@ideasonboard.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Date:   Thu, 7 Dec 2023 13:20:15 +0800
Message-ID: <20231207052016.25954-2-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207052016.25954-1-zhi.mao@mediatek.com>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.129200-8.000000
X-TMASE-MatchedRID: aedjToEgQd2uhCBFl/b63m3NvezwBrVmtZN20SHV1TQ1LB46LFAAkpkC
        erFMaabiCs950MJfLPJ3BbhoDdNb5yWvhQBtQUwTyeVujmXuYYVt8bVUsmDsIcOtrkhuZC9WjBH
        2O7lhl4B1bIDWCCsKkFTgjYw60Qih04Pfv/O2KEWzLD5kmcW6ZHN3sLsG0mhu/NpLPdn/hppUPg
        hfcaHOSzBnx1tvMsBtHNuOxVLF0QeSjpyB+ma+j9azDXwdSzUbuIQDHu9PGw7zYcyIF7RSVajpY
        rigUiQ3N2IRtpTF1DEos+IRLhWj7yvslLrYzXFMy7TSWcbz49bsys6C/H9UTG2EP2rmp/BRVDN/
        CdcAG9YUs9xZCMJFN+j46M0Cp7U+IRQQr+cl8muJQ9k+Ypk5CXxx+w+7Q7ZmAG7pbFR9rLhg7KN
        1aqGhH7aep166WZWHHzPkRUbC6/hZT98H9cWYnKlrGQiTJwcET2fFmw5H8VM2/UwdvFG5IqEGKh
        m9baaNOfAiJ/eonC1kTkpOguG6le0JlY1IlZlqe5NWR5iixe25pw2tsxj4tOQ45nVtPqmxT7+T6
        IAaiDGscsnPFpii5TSbZepgD2nczB1CJ6qmdNqDcqdPJaBbt46ESGgCXvgowSq+a2pKSIyQ9bff
        /FVYS5/Kz5B7AHLJSMU+J0N0mgLa2uUBzc39c8FWmsryu9ZfIfyQNHR2nabiKUaoIhea7e/yRkW
        fD4AnQmkpakoAPV9EWVQMonl9oT8+trsQy4VMGVyS87Wb4lyusS9CiBzL8bgXYaR9pjVLee+psu
        SMY7p8tdBPpVc3DMv26Lv+bP0Ir78SC5iivxwURSScn+QSXq0hbOeGOMG1+gtHj7OwNO0CpgETe
        T0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.129200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 85B6D6009C50A641CDE9FA6DBE9FF7C52AD3050D5956F37C609223907B8D14B82000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.

Reviewed-By: yunkec@chromium.org
Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/media/i2c/Kconfig  |   14 +
 drivers/media/i2c/Makefile |    1 +
 drivers/media/i2c/gc08a3.c | 1888 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1903 insertions(+)
 create mode 100644 drivers/media/i2c/gc08a3.c

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 59ee0ca2c978..e2718bfdf369 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -50,6 +50,20 @@ config VIDEO_AR0521
 	  To compile this driver as a module, choose M here: the
 	  module will be called ar0521.
 
+config VIDEO_GC08A3
+	tristate "GalaxyCore gc08a3 sensor support"
+	depends on GPIOLIB && I2C && VIDEO_DEV
+	select V4L2_FWNODE
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP_I2C
+	help
+	  This is a Video4Linux2 sensor driver for the GalaxyCore gc08a3
+	  camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gc08a3.
+
 config VIDEO_HI556
 	tristate "Hynix Hi-556 sensor support"
 	help
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index f5010f80a21f..ec40dbd75e7a 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_VIDEO_DW9719) += dw9719.o
 obj-$(CONFIG_VIDEO_DW9768) += dw9768.o
 obj-$(CONFIG_VIDEO_DW9807_VCM) += dw9807-vcm.o
 obj-$(CONFIG_VIDEO_ET8EK8) += et8ek8/
+obj-$(CONFIG_VIDEO_GC08A3) += gc08a3.o
 obj-$(CONFIG_VIDEO_HI556) += hi556.o
 obj-$(CONFIG_VIDEO_HI846) += hi846.o
 obj-$(CONFIG_VIDEO_HI847) += hi847.o
diff --git a/drivers/media/i2c/gc08a3.c b/drivers/media/i2c/gc08a3.c
new file mode 100644
index 000000000000..5a9580f97807
--- /dev/null
+++ b/drivers/media/i2c/gc08a3.c
@@ -0,0 +1,1888 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gc08a3.c - gc08a3 sensor driver
+ *
+ * Copyright 2023 MediaTek
+ *
+ * Zhi Mao <zhi.mao@mediatek.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <media/media-entity.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+#define GC08A3_REG_VALUE_08BIT 1
+#define GC08A3_REG_VALUE_16BIT 2
+
+#define GC08A3_REG_CHIP_ID 0x03f0
+#define GC08A3_CHIP_ID 0x08a3
+
+#define GC08A3_NATIVE_WIDTH 3264
+#define GC08A3_NATIVE_HEIGHT 2448
+
+#define GC08A3_REG_TEST_PATTERN_EN 0x008c
+#define GC08A3_REG_TEST_PATTERN_IDX 0x008d
+#define GC08A3_TEST_PATTERN_EN 0x01
+
+#define GC08A3_STRAEMING_REG 0x0100
+
+#define GC08A3_DEFAULT_CLK_FREQ 24000000
+#define GC08A3_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
+#define GC08A3_DATA_LANES 4
+
+/* for 1920*1080 */
+#define GC08A3_LINK_FREQ_207MHZ 207000000ULL
+/* for 3264*2448 */
+#define GC08A3_LINK_FREQ_336MHZ 336000000ULL
+
+#define GC08A3_RGB_DEPTH 10
+
+#define GC08A3_FRAME_LENGTH_REG 0x0340
+#define GC08A3_VTS_30FPS 2548
+#define GC08A3_VTS_30FPS_MIN 2548
+#define GC08A3_VTS_60FPS 1276
+#define GC08A3_VTS_60FPS_MIN 1276
+#define GC08A3_VTS_MAX 0xfff0
+
+#define GC08A3_HTS_30FPS 3640
+#define GC08A3_HTS_60FPS 3640
+
+#define GC08A3_EXP_REG 0x0202
+#define GC08A3_EXP_MARGIN 16
+#define GC08A3_EXP_MIN 4
+#define GC08A3_EXP_STEP 1
+
+#define GC08A3_FLIP_REG 0x0101
+#define GC08A3_FLIP_H_MASK 0x1
+#define GC08A3_FLIP_V_MASK 0x2
+
+#define GC08A3_AGAIN_REG 0x0204
+#define GC08A3_AGAIN_MIN 1024
+#define GC08A3_AGAIN_MAX (1024 * 16)
+#define GC08A3_AGAIN_STEP 1
+
+#define GC08A3_MIN_SLEEP_US  2000
+#define GC08A3_MAX_SLEEP_US  3000
+
+static const char *const gc08a3_test_pattern_menu[] = {
+	"No Pattern", "Solid Black", "Colour Bar", "Solid White",
+	"Solid Red", "Solid Green", "Solid Blue", "Solid Yellow",
+};
+
+enum {
+	GC08A3_LINK_FREQ_336MHZ_INDEX,
+	GC08A3_LINK_FREQ_207MHZ_INDEX,
+};
+
+static const s64 link_freq_menu_items[] = {
+	GC08A3_LINK_FREQ_336MHZ,
+	GC08A3_LINK_FREQ_207MHZ,
+};
+
+static const char *const gc08a3_supply_name[] = {
+	"avdd",
+	"dvdd",
+	"dovdd",
+};
+
+#define GC08A3_NUM_SUPPLIES ARRAY_SIZE(gc08a3_supply_name)
+
+struct gc08a3 {
+	struct device *dev;
+	struct v4l2_subdev sd;
+	struct media_pad pad;
+	struct v4l2_mbus_framefmt fmt;
+	struct i2c_client *client;
+
+	struct v4l2_rect crop;
+
+	struct clk *xclk;
+	struct regulator_bulk_data supplies[GC08A3_NUM_SUPPLIES];
+	struct gpio_desc *enable_gpio;
+
+	struct v4l2_ctrl_handler ctrls;
+	struct v4l2_ctrl *pixel_rate;
+	struct v4l2_ctrl *link_freq;
+	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *vblank;
+	struct v4l2_ctrl *hblank;
+
+	/*
+	 * Serialize control access, get/set format, get selection
+	 * and start streaming.
+	 */
+	struct mutex mutex;
+
+	bool streaming;
+
+	/* Current mode */
+	const struct gc08a3_mode *cur_mode;
+};
+
+struct gc08a3_reg {
+	u16 address;
+	u8 val;
+};
+
+struct gc08a3_reg_list {
+	u32 num_of_regs;
+	const struct gc08a3_reg *regs;
+};
+
+struct gc08a3_link_freq_config {
+	const struct gc08a3_reg_list reg_list;
+};
+
+static const struct gc08a3_reg mode_3264x2448[] = {
+	/* system */
+	{ 0x031c, 0x60 },
+	{ 0x0337, 0x04 },
+	{ 0x0335, 0x51 },
+	{ 0x0336, 0x70 },
+	{ 0x0383, 0xbb },
+	{ 0x031a, 0x00 },
+	{ 0x0321, 0x10 },
+	{ 0x0327, 0x03 },
+	{ 0x0325, 0x40 },
+	{ 0x0326, 0x23 },
+	{ 0x0314, 0x11 },
+	{ 0x0315, 0xd6 },
+	{ 0x0316, 0x01 },
+	{ 0x0334, 0x40 },
+	{ 0x0324, 0x42 },
+	{ 0x031c, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x0344, 0x00 },
+	{ 0x0345, 0x06 },
+	{ 0x0346, 0x00 },
+	{ 0x0347, 0x04 },
+	{ 0x0348, 0x0c },
+	{ 0x0349, 0xd0 },
+	{ 0x034a, 0x09 },
+	{ 0x034b, 0x9c },
+	{ 0x0202, 0x09 },
+	{ 0x0203, 0x04 },
+	{ 0x0340, 0x09 },
+	{ 0x0341, 0xf4 },
+	{ 0x0342, 0x07 },
+	{ 0x0343, 0x1c },
+
+	{ 0x0226, 0x00 },
+	{ 0x0227, 0x28 },
+	{ 0x0e38, 0x49 },
+	{ 0x0210, 0x13 },
+	{ 0x0218, 0x00 },
+	{ 0x0241, 0x88 },
+	{ 0x0392, 0x60 },
+
+	/* ISP */
+	{ 0x031c, 0x80 },
+	{ 0x03fe, 0x10 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x80 },
+	{ 0x03fe, 0x10 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x00a2, 0x00 },
+	{ 0x00a3, 0x00 },
+	{ 0x00ab, 0x00 },
+	{ 0x00ac, 0x00 },
+	{ 0x05a0, 0x82 },
+	{ 0x05ac, 0x00 },
+	{ 0x05ad, 0x01 },
+	{ 0x05ae, 0x00 },
+	{ 0x0800, 0x0a },
+	{ 0x0801, 0x14 },
+	{ 0x0802, 0x28 },
+	{ 0x0803, 0x34 },
+	{ 0x0804, 0x0e },
+	{ 0x0805, 0x33 },
+	{ 0x0806, 0x03 },
+	{ 0x0807, 0x8a },
+	{ 0x0808, 0x50 },
+	{ 0x0809, 0x00 },
+	{ 0x080a, 0x34 },
+	{ 0x080b, 0x03 },
+	{ 0x080c, 0x26 },
+	{ 0x080d, 0x03 },
+	{ 0x080e, 0x18 },
+	{ 0x080f, 0x03 },
+	{ 0x0810, 0x10 },
+	{ 0x0811, 0x03 },
+	{ 0x0812, 0x00 },
+	{ 0x0813, 0x00 },
+	{ 0x0814, 0x01 },
+	{ 0x0815, 0x00 },
+	{ 0x0816, 0x01 },
+	{ 0x0817, 0x00 },
+	{ 0x0818, 0x00 },
+	{ 0x0819, 0x0a },
+	{ 0x081a, 0x01 },
+	{ 0x081b, 0x6c },
+	{ 0x081c, 0x00 },
+	{ 0x081d, 0x0b },
+	{ 0x081e, 0x02 },
+	{ 0x081f, 0x00 },
+	{ 0x0820, 0x00 },
+	{ 0x0821, 0x0c },
+	{ 0x0822, 0x02 },
+	{ 0x0823, 0xd9 },
+	{ 0x0824, 0x00 },
+	{ 0x0825, 0x0d },
+	{ 0x0826, 0x03 },
+	{ 0x0827, 0xf0 },
+	{ 0x0828, 0x00 },
+	{ 0x0829, 0x0e },
+	{ 0x082a, 0x05 },
+	{ 0x082b, 0x94 },
+	{ 0x082c, 0x09 },
+	{ 0x082d, 0x6e },
+	{ 0x082e, 0x07 },
+	{ 0x082f, 0xe6 },
+	{ 0x0830, 0x10 },
+	{ 0x0831, 0x0e },
+	{ 0x0832, 0x0b },
+	{ 0x0833, 0x2c },
+	{ 0x0834, 0x14 },
+	{ 0x0835, 0xae },
+	{ 0x0836, 0x0f },
+	{ 0x0837, 0xc4 },
+	{ 0x0838, 0x18 },
+	{ 0x0839, 0x0e },
+	{ 0x05ac, 0x01 },
+	{ 0x059a, 0x00 },
+	{ 0x059b, 0x00 },
+	{ 0x059c, 0x01 },
+	{ 0x0598, 0x00 },
+	{ 0x0597, 0x14 },
+	{ 0x05ab, 0x09 },
+	{ 0x05a4, 0x02 },
+	{ 0x05a3, 0x05 },
+	{ 0x05a0, 0xc2 },
+	{ 0x0207, 0xc4 },
+
+	/* GAIN */
+	{ 0x0204, 0x04 },
+	{ 0x0205, 0x00 },
+	{ 0x0050, 0x5c },
+	{ 0x0051, 0x44 },
+
+	/* out window */
+	{ 0x009a, 0x66 },
+	{ 0x0351, 0x00 },
+	{ 0x0352, 0x06 },
+	{ 0x0353, 0x00 },
+	{ 0x0354, 0x08 },
+	{ 0x034c, 0x0c },
+	{ 0x034d, 0xc0 },
+	{ 0x034e, 0x09 },
+	{ 0x034f, 0x90 },
+
+	/* MIPI */
+	{ 0x0114, 0x03 },
+	{ 0x0180, 0x65 },
+	{ 0x0181, 0xf0 },
+	{ 0x0185, 0x01 },
+	{ 0x0115, 0x30 },
+	{ 0x011b, 0x12 },
+	{ 0x011c, 0x12 },
+	{ 0x0121, 0x06 },
+	{ 0x0122, 0x06 },
+	{ 0x0123, 0x15 },
+	{ 0x0124, 0x01 },
+	{ 0x0125, 0x0b },
+	{ 0x0126, 0x08 },
+	{ 0x0129, 0x06 },
+	{ 0x012a, 0x08 },
+	{ 0x012b, 0x08 },
+
+	{ 0x0a73, 0x60 },
+	{ 0x0a70, 0x11 },
+	{ 0x0313, 0x80 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0a70, 0x00 },
+	{ 0x00a4, 0x80 },
+	{ 0x0316, 0x01 },
+	{ 0x0a67, 0x00 },
+	{ 0x0084, 0x10 },
+	{ 0x0102, 0x09 },
+};
+
+static const struct gc08a3_reg mode_1920x1080[] = {
+	/* system */
+	{ 0x031c, 0x60 },
+	{ 0x0337, 0x04 },
+	{ 0x0335, 0x51 },
+	{ 0x0336, 0x45 },
+	{ 0x0383, 0x8b },
+	{ 0x031a, 0x00 },
+	{ 0x0321, 0x10 },
+	{ 0x0327, 0x03 },
+	{ 0x0325, 0x40 },
+	{ 0x0326, 0x23 },
+	{ 0x0314, 0x11 },
+	{ 0x0315, 0xd6 },
+	{ 0x0316, 0x01 },
+	{ 0x0334, 0x40 },
+	{ 0x0324, 0x42 },
+	{ 0x031c, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x0344, 0x02 },
+	{ 0x0345, 0xa6 },
+	{ 0x0346, 0x02 },
+	{ 0x0347, 0xb0 },
+	{ 0x0348, 0x07 },
+	{ 0x0349, 0x90 },
+	{ 0x034a, 0x04 },
+	{ 0x034b, 0x44 },
+	{ 0x0202, 0x03 },
+	{ 0x0203, 0x00 },
+	{ 0x0340, 0x04 },
+	{ 0x0341, 0xfc },
+	{ 0x0342, 0x07 },
+	{ 0x0343, 0x1c },
+
+	{ 0x0226, 0x00 },
+	{ 0x0227, 0x88 },
+	{ 0x0e38, 0x49 },
+	{ 0x0210, 0x13 },
+	{ 0x0218, 0x00 },
+	{ 0x0241, 0x88 },
+	{ 0x0392, 0x60 },
+
+	/* ISP */
+	{ 0x031c, 0x80 },
+	{ 0x03fe, 0x10 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x80 },
+	{ 0x03fe, 0x10 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x00a2, 0xac },
+	{ 0x00a3, 0x02 },
+	{ 0x00ab, 0xa0 },
+	{ 0x00ac, 0x02 },
+	{ 0x05a0, 0x82 },
+	{ 0x05ac, 0x00 },
+	{ 0x05ad, 0x01 },
+	{ 0x05ae, 0x00 },
+	{ 0x0800, 0x0a },
+	{ 0x0801, 0x14 },
+	{ 0x0802, 0x28 },
+	{ 0x0803, 0x34 },
+	{ 0x0804, 0x0e },
+	{ 0x0805, 0x33 },
+	{ 0x0806, 0x03 },
+	{ 0x0807, 0x8a },
+	{ 0x0808, 0x50 },
+	{ 0x0809, 0x00 },
+	{ 0x080a, 0x34 },
+	{ 0x080b, 0x03 },
+	{ 0x080c, 0x26 },
+	{ 0x080d, 0x03 },
+	{ 0x080e, 0x18 },
+	{ 0x080f, 0x03 },
+	{ 0x0810, 0x10 },
+	{ 0x0811, 0x03 },
+	{ 0x0812, 0x00 },
+	{ 0x0813, 0x00 },
+	{ 0x0814, 0x01 },
+	{ 0x0815, 0x00 },
+	{ 0x0816, 0x01 },
+	{ 0x0817, 0x00 },
+	{ 0x0818, 0x00 },
+	{ 0x0819, 0x0a },
+	{ 0x081a, 0x01 },
+	{ 0x081b, 0x6c },
+	{ 0x081c, 0x00 },
+	{ 0x081d, 0x0b },
+	{ 0x081e, 0x02 },
+	{ 0x081f, 0x00 },
+	{ 0x0820, 0x00 },
+	{ 0x0821, 0x0c },
+	{ 0x0822, 0x02 },
+	{ 0x0823, 0xd9 },
+	{ 0x0824, 0x00 },
+	{ 0x0825, 0x0d },
+	{ 0x0826, 0x03 },
+	{ 0x0827, 0xf0 },
+	{ 0x0828, 0x00 },
+	{ 0x0829, 0x0e },
+	{ 0x082a, 0x05 },
+	{ 0x082b, 0x94 },
+	{ 0x082c, 0x09 },
+	{ 0x082d, 0x6e },
+	{ 0x082e, 0x07 },
+	{ 0x082f, 0xe6 },
+	{ 0x0830, 0x10 },
+	{ 0x0831, 0x0e },
+	{ 0x0832, 0x0b },
+	{ 0x0833, 0x2c },
+	{ 0x0834, 0x14 },
+	{ 0x0835, 0xae },
+	{ 0x0836, 0x0f },
+	{ 0x0837, 0xc4 },
+	{ 0x0838, 0x18 },
+	{ 0x0839, 0x0e },
+	{ 0x05ac, 0x01 },
+	{ 0x059a, 0x00 },
+	{ 0x059b, 0x00 },
+	{ 0x059c, 0x01 },
+	{ 0x0598, 0x00 },
+	{ 0x0597, 0x14 },
+	{ 0x05ab, 0x09 },
+	{ 0x05a4, 0x02 },
+	{ 0x05a3, 0x05 },
+	{ 0x05a0, 0xc2 },
+	{ 0x0207, 0xc4 },
+
+	/* GAIN */
+	{ 0x0204, 0x04 },
+	{ 0x0205, 0x00 },
+	{ 0x0050, 0x38 },
+	{ 0x0051, 0x20 },
+
+	/* out window */
+	{ 0x009a, 0x66 },
+	{ 0x0351, 0x00 },
+	{ 0x0352, 0x06 },
+	{ 0x0353, 0x00 },
+	{ 0x0354, 0x08 },
+	{ 0x034c, 0x07 },
+	{ 0x034d, 0x80 },
+	{ 0x034e, 0x04 },
+	{ 0x034f, 0x38 },
+
+	/* MIPI */
+	{ 0x0114, 0x03 },
+	{ 0x0180, 0x65 },
+	{ 0x0181, 0xf0 },
+	{ 0x0185, 0x01 },
+	{ 0x0115, 0x30 },
+	{ 0x011b, 0x12 },
+	{ 0x011c, 0x12 },
+	{ 0x0121, 0x02 },
+	{ 0x0122, 0x03 },
+	{ 0x0123, 0x0c },
+	{ 0x0124, 0x00 },
+	{ 0x0125, 0x09 },
+	{ 0x0126, 0x06 },
+	{ 0x0129, 0x04 },
+	{ 0x012a, 0x03 },
+	{ 0x012b, 0x06 },
+
+	{ 0x0a73, 0x60 },
+	{ 0x0a70, 0x11 },
+	{ 0x0313, 0x80 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0aff, 0x00 },
+	{ 0x0a70, 0x00 },
+	{ 0x00a4, 0x80 },
+	{ 0x0316, 0x01 },
+	{ 0x0a67, 0x00 },
+	{ 0x0084, 0x10 },
+	{ 0x0102, 0x09 },
+};
+
+static const struct gc08a3_reg mode_table_common[] = {
+	{ GC08A3_STRAEMING_REG, 0x00 },
+	/* system */
+	{ 0x031c, 0x60 },
+	{ 0x0337, 0x04 },
+	{ 0x0335, 0x51 },
+	{ 0x0336, 0x70 },
+	{ 0x0383, 0xbb },
+	{ 0x031a, 0x00 },
+	{ 0x0321, 0x10 },
+	{ 0x0327, 0x03 },
+	{ 0x0325, 0x40 },
+	{ 0x0326, 0x23 },
+	{ 0x0314, 0x11 },
+	{ 0x0315, 0xd6 },
+	{ 0x0316, 0x01 },
+	{ 0x0334, 0x40 },
+	{ 0x0324, 0x42 },
+	{ 0x031c, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x039a, 0x13 },
+	{ 0x0084, 0x30 },
+	{ 0x02b3, 0x08 },
+	{ 0x0057, 0x0c },
+	{ 0x05c3, 0x50 },
+	{ 0x0311, 0x90 },
+	{ 0x05a0, 0x02 },
+	{ 0x0074, 0x0a },
+	{ 0x0059, 0x11 },
+	{ 0x0070, 0x05 },
+	{ 0x0101, 0x00 },
+
+	/* analog */
+	{ 0x0344, 0x00 },
+	{ 0x0345, 0x06 },
+	{ 0x0346, 0x00 },
+	{ 0x0347, 0x04 },
+	{ 0x0348, 0x0c },
+	{ 0x0349, 0xd0 },
+	{ 0x034a, 0x09 },
+	{ 0x034b, 0x9c },
+	{ 0x0202, 0x09 },
+	{ 0x0203, 0x04 },
+
+	{ 0x0219, 0x05 },
+	{ 0x0226, 0x00 },
+	{ 0x0227, 0x28 },
+	{ 0x0e0a, 0x00 },
+	{ 0x0e0b, 0x00 },
+	{ 0x0e24, 0x04 },
+	{ 0x0e25, 0x04 },
+	{ 0x0e26, 0x00 },
+	{ 0x0e27, 0x10 },
+	{ 0x0e01, 0x74 },
+	{ 0x0e03, 0x47 },
+	{ 0x0e04, 0x33 },
+	{ 0x0e05, 0x44 },
+	{ 0x0e06, 0x44 },
+	{ 0x0e0c, 0x1e },
+	{ 0x0e17, 0x3a },
+	{ 0x0e18, 0x3c },
+	{ 0x0e19, 0x40 },
+	{ 0x0e1a, 0x42 },
+	{ 0x0e28, 0x21 },
+	{ 0x0e2b, 0x68 },
+	{ 0x0e2c, 0x0d },
+	{ 0x0e2d, 0x08 },
+	{ 0x0e34, 0xf4 },
+	{ 0x0e35, 0x44 },
+	{ 0x0e36, 0x07 },
+	{ 0x0e38, 0x49 },
+	{ 0x0210, 0x13 },
+	{ 0x0218, 0x00 },
+	{ 0x0241, 0x88 },
+	{ 0x0e32, 0x00 },
+	{ 0x0e33, 0x18 },
+	{ 0x0e42, 0x03 },
+	{ 0x0e43, 0x80 },
+	{ 0x0e44, 0x04 },
+	{ 0x0e45, 0x00 },
+	{ 0x0e4f, 0x04 },
+	{ 0x057a, 0x20 },
+	{ 0x0381, 0x7c },
+	{ 0x0382, 0x9b },
+	{ 0x0384, 0xfb },
+	{ 0x0389, 0x38 },
+	{ 0x038a, 0x03 },
+	{ 0x0390, 0x6a },
+	{ 0x0391, 0x0b },
+	{ 0x0392, 0x60 },
+	{ 0x0393, 0xc1 },
+	{ 0x0396, 0xff },
+	{ 0x0398, 0x62 },
+
+	/* cisctl reset */
+	{ 0x031c, 0x80 },
+	{ 0x03fe, 0x10 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x80 },
+	{ 0x03fe, 0x10 },
+	{ 0x03fe, 0x00 },
+	{ 0x031c, 0x9f },
+	{ 0x0360, 0x01 },
+	{ 0x0360, 0x00 },
+	{ 0x0316, 0x09 },
+	{ 0x0a67, 0x80 },
+	{ 0x0313, 0x00 },
+	{ 0x0a53, 0x0e },
+	{ 0x0a65, 0x17 },
+	{ 0x0a68, 0xa1 },
+	{ 0x0a58, 0x00 },
+	{ 0x0ace, 0x0c },
+	{ 0x00a4, 0x00 },
+	{ 0x00a5, 0x01 },
+	{ 0x00a7, 0x09 },
+	{ 0x00a8, 0x9c },
+	{ 0x00a9, 0x0c },
+	{ 0x00aa, 0xd0 },
+	{ 0x0a8a, 0x00 },
+	{ 0x0a8b, 0xe0 },
+	{ 0x0a8c, 0x13 },
+	{ 0x0a8d, 0xe8 },
+	{ 0x0a90, 0x0a },
+	{ 0x0a91, 0x10 },
+	{ 0x0a92, 0xf8 },
+	{ 0x0a71, 0xf2 },
+	{ 0x0a72, 0x12 },
+	{ 0x0a73, 0x64 },
+	{ 0x0a75, 0x41 },
+	{ 0x0a70, 0x07 },
+	{ 0x0313, 0x80 },
+
+	/* ISP */
+	{ 0x00a0, 0x01 },
+	{ 0x0080, 0xd2 },
+	{ 0x0081, 0x3f },
+	{ 0x0087, 0x51 },
+	{ 0x0089, 0x03 },
+	{ 0x009b, 0x40 },
+	{ 0x05a0, 0x82 },
+	{ 0x05ac, 0x00 },
+	{ 0x05ad, 0x01 },
+	{ 0x05ae, 0x00 },
+	{ 0x0800, 0x0a },
+	{ 0x0801, 0x14 },
+	{ 0x0802, 0x28 },
+	{ 0x0803, 0x34 },
+	{ 0x0804, 0x0e },
+	{ 0x0805, 0x33 },
+	{ 0x0806, 0x03 },
+	{ 0x0807, 0x8a },
+	{ 0x0808, 0x50 },
+	{ 0x0809, 0x00 },
+	{ 0x080a, 0x34 },
+	{ 0x080b, 0x03 },
+	{ 0x080c, 0x26 },
+	{ 0x080d, 0x03 },
+	{ 0x080e, 0x18 },
+	{ 0x080f, 0x03 },
+	{ 0x0810, 0x10 },
+	{ 0x0811, 0x03 },
+	{ 0x0812, 0x00 },
+	{ 0x0813, 0x00 },
+	{ 0x0814, 0x01 },
+	{ 0x0815, 0x00 },
+	{ 0x0816, 0x01 },
+	{ 0x0817, 0x00 },
+	{ 0x0818, 0x00 },
+	{ 0x0819, 0x0a },
+	{ 0x081a, 0x01 },
+	{ 0x081b, 0x6c },
+	{ 0x081c, 0x00 },
+	{ 0x081d, 0x0b },
+	{ 0x081e, 0x02 },
+	{ 0x081f, 0x00 },
+	{ 0x0820, 0x00 },
+	{ 0x0821, 0x0c },
+	{ 0x0822, 0x02 },
+	{ 0x0823, 0xd9 },
+	{ 0x0824, 0x00 },
+	{ 0x0825, 0x0d },
+	{ 0x0826, 0x03 },
+	{ 0x0827, 0xf0 },
+	{ 0x0828, 0x00 },
+	{ 0x0829, 0x0e },
+	{ 0x082a, 0x05 },
+	{ 0x082b, 0x94 },
+	{ 0x082c, 0x09 },
+	{ 0x082d, 0x6e },
+	{ 0x082e, 0x07 },
+	{ 0x082f, 0xe6 },
+	{ 0x0830, 0x10 },
+	{ 0x0831, 0x0e },
+	{ 0x0832, 0x0b },
+	{ 0x0833, 0x2c },
+	{ 0x0834, 0x14 },
+	{ 0x0835, 0xae },
+	{ 0x0836, 0x0f },
+	{ 0x0837, 0xc4 },
+	{ 0x0838, 0x18 },
+	{ 0x0839, 0x0e },
+	{ 0x05ac, 0x01 },
+	{ 0x059a, 0x00 },
+	{ 0x059b, 0x00 },
+	{ 0x059c, 0x01 },
+	{ 0x0598, 0x00 },
+	{ 0x0597, 0x14 },
+	{ 0x05ab, 0x09 },
+	{ 0x05a4, 0x02 },
+	{ 0x05a3, 0x05 },
+	{ 0x05a0, 0xc2 },
+	{ 0x0207, 0xc4 },
+
+	/* GAIN */
+	{ 0x0208, 0x01 },
+	{ 0x0209, 0x72 },
+	{ 0x0204, 0x04 },
+	{ 0x0205, 0x00 },
+
+	{ 0x0040, 0x22 },
+	{ 0x0041, 0x20 },
+	{ 0x0043, 0x10 },
+	{ 0x0044, 0x00 },
+	{ 0x0046, 0x08 },
+	{ 0x0047, 0xf0 },
+	{ 0x0048, 0x0f },
+	{ 0x004b, 0x0f },
+	{ 0x004c, 0x00 },
+	{ 0x0050, 0x5c },
+	{ 0x0051, 0x44 },
+	{ 0x005b, 0x03 },
+	{ 0x00c0, 0x00 },
+	{ 0x00c1, 0x80 },
+	{ 0x00c2, 0x31 },
+	{ 0x00c3, 0x00 },
+	{ 0x0460, 0x04 },
+	{ 0x0462, 0x08 },
+	{ 0x0464, 0x0e },
+	{ 0x0466, 0x0a },
+	{ 0x0468, 0x12 },
+	{ 0x046a, 0x12 },
+	{ 0x046c, 0x10 },
+	{ 0x046e, 0x0c },
+	{ 0x0461, 0x03 },
+	{ 0x0463, 0x03 },
+	{ 0x0465, 0x03 },
+	{ 0x0467, 0x03 },
+	{ 0x0469, 0x04 },
+	{ 0x046b, 0x04 },
+	{ 0x046d, 0x04 },
+	{ 0x046f, 0x04 },
+	{ 0x0470, 0x04 },
+	{ 0x0472, 0x10 },
+	{ 0x0474, 0x26 },
+	{ 0x0476, 0x38 },
+	{ 0x0478, 0x20 },
+	{ 0x047a, 0x30 },
+	{ 0x047c, 0x38 },
+	{ 0x047e, 0x60 },
+	{ 0x0471, 0x05 },
+	{ 0x0473, 0x05 },
+	{ 0x0475, 0x05 },
+	{ 0x0477, 0x05 },
+	{ 0x0479, 0x04 },
+	{ 0x047b, 0x04 },
+	{ 0x047d, 0x04 },
+	{ 0x047f, 0x04 },
+};
+
+static const struct gc08a3_link_freq_config link_freq_configs[] = {
+	[GC08A3_LINK_FREQ_336MHZ_INDEX] = {
+		.reg_list = {
+			.num_of_regs = ARRAY_SIZE(mode_table_common),
+			.regs = mode_table_common,
+		}
+	},
+	[GC08A3_LINK_FREQ_207MHZ_INDEX] = {
+		.reg_list = {
+			.num_of_regs = ARRAY_SIZE(mode_table_common),
+			.regs = mode_table_common,
+		}
+	},
+
+};
+
+struct gc08a3_mode {
+	u32 width;
+	u32 height;
+	const struct gc08a3_reg_list reg_list;
+
+	u32 hts; /* Horizontal timining size */
+	u32 vts_def; /* Default vertical timining size */
+	u32 vts_min; /* Min vertical timining size */
+	u32 link_freq_index; /* Link frequency needed for this resolution */
+	u32 max_framerate;
+
+};
+
+/*
+ * Declare modes in order, from biggest
+ * to smallest height.
+ */
+static const struct gc08a3_mode gc08a3_modes[] = {
+	{
+		.width = GC08A3_NATIVE_WIDTH,
+		.height = GC08A3_NATIVE_HEIGHT,
+		.reg_list = {
+			.num_of_regs = ARRAY_SIZE(mode_3264x2448),
+			.regs = mode_3264x2448,
+		},
+		.link_freq_index = GC08A3_LINK_FREQ_336MHZ_INDEX,
+
+		.hts = GC08A3_HTS_30FPS,
+		.vts_def = GC08A3_VTS_30FPS,
+		.vts_min = GC08A3_VTS_30FPS_MIN,
+		.max_framerate = 300,
+	},
+	{
+		.width = 1920,
+		.height = 1080,
+		.reg_list = {
+			.num_of_regs = ARRAY_SIZE(mode_1920x1080),
+			.regs = mode_1920x1080,
+		},
+		.link_freq_index = GC08A3_LINK_FREQ_207MHZ_INDEX,
+
+		.hts = GC08A3_HTS_60FPS,
+		.vts_def = GC08A3_VTS_60FPS,
+		.vts_min = GC08A3_VTS_60FPS_MIN,
+		.max_framerate = 600,
+	},
+};
+
+static u64 to_pixel_rate(u32 f_index)
+{
+	u64 pixel_rate = link_freq_menu_items[f_index] * 2 * GC08A3_DATA_LANES;
+
+	do_div(pixel_rate, GC08A3_RGB_DEPTH);
+
+	return pixel_rate;
+}
+
+static int gc08a3_read_reg(struct gc08a3 *gc08a3, u16 reg, u16 len, u32 *val)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&gc08a3->sd);
+	struct i2c_msg msgs[2];
+	u8 addr_buf[2];
+	u8 data_buf[4] = { 0 };
+	int ret;
+
+	if (len > 4)
+		return -EINVAL;
+
+	put_unaligned_be16(reg, addr_buf);
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = sizeof(addr_buf);
+	msgs[0].buf = addr_buf;
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = len;
+	msgs[1].buf = &data_buf[4 - len];
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	*val = get_unaligned_be32(data_buf);
+
+	return 0;
+}
+
+static int gc08a3_write_reg(struct gc08a3 *gc08a3, u16 reg, u16 len, u32 val)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&gc08a3->sd);
+	u8 buf[6];
+
+	if (len > 4)
+		return -EINVAL;
+
+	put_unaligned_be16(reg, buf);
+	put_unaligned_be32(val << 8 * (4 - len), buf + 2);
+	if (i2c_master_send(client, buf, len + 2) != len + 2)
+		return -EIO;
+
+	return 0;
+}
+
+static int gc08a3_write_reg_list(struct gc08a3 *gc08a3,
+				 const struct gc08a3_reg_list *r_list)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&gc08a3->sd);
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < r_list->num_of_regs; i++) {
+		ret = gc08a3_write_reg(gc08a3, r_list->regs[i].address,
+				       GC08A3_REG_VALUE_08BIT,
+				       r_list->regs[i].val);
+		if (ret) {
+			dev_err_ratelimited(&client->dev,
+					    "failed to write reg 0x%4.4x. error = %d",
+					    r_list->regs[i].address, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int gc08a3_identify_module(struct gc08a3 *gc08a3)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&gc08a3->sd);
+	u32 val = 0;
+
+	gc08a3_read_reg(gc08a3, GC08A3_REG_CHIP_ID, GC08A3_REG_VALUE_16BIT,
+			&val);
+
+	if (val != GC08A3_CHIP_ID) {
+		dev_err(&client->dev, "chip id mismatch: 0x%x!=0x%x",
+			GC08A3_CHIP_ID, val);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static inline struct gc08a3 *to_gc08a3(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct gc08a3, sd);
+}
+
+static int gc08a3_power_on(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+	int ret;
+
+	gpiod_set_value_cansleep(gc08a3->enable_gpio, 0);
+	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
+
+	ret = regulator_bulk_enable(GC08A3_NUM_SUPPLIES, gc08a3->supplies);
+	if (ret < 0) {
+		dev_err(gc08a3->dev, "failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(gc08a3->xclk);
+	if (ret < 0) {
+		regulator_bulk_disable(GC08A3_NUM_SUPPLIES, gc08a3->supplies);
+		dev_err(gc08a3->dev, "clk prepare enable failed\n");
+		return ret;
+	}
+
+	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
+
+	gpiod_set_value_cansleep(gc08a3->enable_gpio, 1);
+	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
+
+	return 0;
+}
+
+static int gc08a3_power_off(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+
+	gpiod_set_value_cansleep(gc08a3->enable_gpio, 0);
+
+	clk_disable_unprepare(gc08a3->xclk);
+
+	regulator_bulk_disable(GC08A3_NUM_SUPPLIES, gc08a3->supplies);
+	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
+
+	return 0;
+}
+
+static int gc08a3_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (code->index > 0)
+		return -EINVAL;
+
+	code->code = GC08A3_MBUS_CODE;
+
+	return 0;
+}
+
+static int gc08a3_enum_frame_size(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_state *sd_state,
+				  struct v4l2_subdev_frame_size_enum *fse)
+{
+	if (fse->code != GC08A3_MBUS_CODE)
+		return -EINVAL;
+
+	if (fse->index >= ARRAY_SIZE(gc08a3_modes))
+		return -EINVAL;
+
+	fse->min_width = gc08a3_modes[fse->index].width;
+	fse->max_width = gc08a3_modes[fse->index].width;
+	fse->min_height = gc08a3_modes[fse->index].height;
+	fse->max_height = gc08a3_modes[fse->index].height;
+
+	return 0;
+}
+
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+static int gc08a3_g_register(struct v4l2_subdev *subdev,
+			     struct v4l2_dbg_register *reg)
+{
+	int ret;
+	u32 val;
+	struct gc08a3 *gc08a3 = container_of(subdev, struct gc08a3, sd);
+
+	ret = gc08a3_read_reg(gc08a3, reg->reg, GC08A3_REG_VALUE_08BIT, &val);
+	if (ret < 0)
+		return ret;
+
+	reg->val = val;
+	reg->size = 1;
+
+	return 0;
+}
+
+static int gc08a3_s_register(struct v4l2_subdev *subdev,
+			     const struct v4l2_dbg_register *reg)
+{
+	struct gc08a3 *gc08a3 = container_of(subdev, struct gc08a3, sd);
+
+	return gc08a3_write_reg(gc08a3, reg->reg, GC08A3_REG_VALUE_08BIT,
+				reg->val & 0xff);
+}
+
+#endif
+
+static const struct v4l2_subdev_core_ops gc08a3_core_ops = {
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+	.g_register = gc08a3_g_register,
+	.s_register = gc08a3_s_register,
+#endif
+};
+
+static struct v4l2_mbus_framefmt *
+__gc08a3_get_pad_format(struct gc08a3 *gc08a3,
+			struct v4l2_subdev_state *sd_state, unsigned int pad,
+			enum v4l2_subdev_format_whence which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_state_get_format(sd_state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &gc08a3->fmt;
+	default:
+		return NULL;
+	}
+}
+
+static int gc08a3_get_format(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *sd_state,
+			     struct v4l2_subdev_format *format)
+{
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+
+	mutex_lock(&gc08a3->mutex);
+	format->format = *__gc08a3_get_pad_format(gc08a3, sd_state, format->pad,
+						  format->which);
+	mutex_unlock(&gc08a3->mutex);
+
+	return 0;
+}
+
+static struct v4l2_rect *
+__gc08a3_get_pad_crop(struct gc08a3 *gc08a3, struct v4l2_subdev_state *sd_state,
+		      unsigned int pad, enum v4l2_subdev_format_whence which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_state_get_crop(sd_state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &gc08a3->crop;
+	default:
+		return NULL;
+	}
+}
+
+static int gc08a3_update_cur_mode_controls(struct gc08a3 *gc08a3)
+{
+	s64 exposure_max, h_blank;
+	int ret = 0;
+
+	ret = __v4l2_ctrl_modify_range(gc08a3->vblank,
+				       gc08a3->cur_mode->vts_min - gc08a3->cur_mode->height,
+				       GC08A3_VTS_MAX - gc08a3->cur_mode->height, 1,
+				       gc08a3->cur_mode->vts_def - gc08a3->cur_mode->height);
+	if (ret)
+		dev_err(gc08a3->dev, "VB ctrl range update failed\n");
+
+	h_blank = gc08a3->cur_mode->hts - gc08a3->cur_mode->width;
+	ret = __v4l2_ctrl_modify_range(gc08a3->hblank, h_blank, h_blank, 1,
+				       h_blank);
+	if (ret)
+		dev_err(gc08a3->dev, "HB ctrl range update failed\n");
+
+	exposure_max = gc08a3->cur_mode->vts_def - GC08A3_EXP_MARGIN;
+	ret = __v4l2_ctrl_modify_range(gc08a3->exposure, GC08A3_EXP_MIN,
+				       exposure_max, GC08A3_EXP_STEP,
+				       exposure_max);
+	if (ret)
+		dev_err(gc08a3->dev, "exposure ctrl range update failed\n");
+
+	return ret;
+}
+
+static int gc08a3_set_format(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *sd_state,
+			     struct v4l2_subdev_format *format)
+{
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+	struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_rect *crop;
+	const struct gc08a3_mode *mode;
+
+	mutex_lock(&gc08a3->mutex);
+
+	crop = __gc08a3_get_pad_crop(gc08a3, sd_state, format->pad,
+				     format->which);
+
+	mode = v4l2_find_nearest_size(gc08a3_modes, ARRAY_SIZE(gc08a3_modes),
+				      width, height, format->format.width,
+				      format->format.height);
+
+	crop->width = mode->width;
+	crop->height = mode->height;
+
+	fmt = __gc08a3_get_pad_format(gc08a3, sd_state, format->pad,
+				      format->which);
+	fmt->width = crop->width;
+	fmt->height = crop->height;
+	fmt->code = GC08A3_MBUS_CODE;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
+	fmt->quantization =
+		V4L2_MAP_QUANTIZATION_DEFAULT(true,
+					      fmt->colorspace,
+					      fmt->ycbcr_enc);
+	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
+
+	format->format = *fmt;
+
+	gc08a3->cur_mode = mode;
+	gc08a3_update_cur_mode_controls(gc08a3);
+
+	mutex_unlock(&gc08a3->mutex);
+
+	return 0;
+}
+
+static int gc08a3_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP:
+		mutex_lock(&gc08a3->mutex);
+		sel->r = *__gc08a3_get_pad_crop(gc08a3, sd_state, sel->pad, sel->which);
+		mutex_unlock(&gc08a3->mutex);
+		break;
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = GC08A3_NATIVE_WIDTH;
+		sel->r.height = GC08A3_NATIVE_HEIGHT;
+		break;
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		if (gc08a3->cur_mode->width == GC08A3_NATIVE_WIDTH) {
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = GC08A3_NATIVE_WIDTH;
+			sel->r.height = GC08A3_NATIVE_HEIGHT;
+		} else {
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = 1920;
+			sel->r.height = 1080;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gc08a3_entity_init_cfg(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_state *sd_state)
+{
+	struct v4l2_subdev_format fmt = {};
+
+	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY :
+			       V4L2_SUBDEV_FORMAT_ACTIVE;
+	fmt.format.width = gc08a3_modes[0].width;
+	fmt.format.height = gc08a3_modes[0].height;
+
+	gc08a3_set_format(subdev, sd_state, &fmt);
+
+	return 0;
+}
+
+static int gc08a3_set_ctrl_hflip(struct gc08a3 *gc08a3, u32 ctrl_val)
+{
+	int ret;
+	u32 val;
+
+	ret = gc08a3_read_reg(gc08a3, GC08A3_FLIP_REG, GC08A3_REG_VALUE_08BIT,
+			      &val);
+	if (ret) {
+		dev_err(gc08a3->dev, "read hflip register failed: %d\n", ret);
+		return ret;
+	}
+
+	val = ctrl_val ? (val | GC08A3_FLIP_H_MASK) :
+			   (val & ~GC08A3_FLIP_H_MASK);
+	ret = gc08a3_write_reg(gc08a3, GC08A3_FLIP_REG, GC08A3_REG_VALUE_08BIT,
+			       val);
+	if (ret < 0)
+		dev_err(gc08a3->dev, "Error %d\n", ret);
+
+	return ret;
+}
+
+static int gc08a3_set_ctrl_vflip(struct gc08a3 *gc08a3, u32 ctrl_val)
+{
+	int ret;
+	u32 val;
+
+	ret = gc08a3_read_reg(gc08a3, GC08A3_FLIP_REG, GC08A3_REG_VALUE_08BIT,
+			      &val);
+	if (ret) {
+		dev_err(gc08a3->dev, "read vflip register failed: %d\n", ret);
+		return ret;
+	}
+
+	val = ctrl_val ? (val | GC08A3_FLIP_V_MASK) :
+			   (val & ~GC08A3_FLIP_V_MASK);
+	ret = gc08a3_write_reg(gc08a3, GC08A3_FLIP_REG, GC08A3_REG_VALUE_08BIT,
+			       val);
+	if (ret < 0)
+		dev_err(gc08a3->dev, "Error %d\n", ret);
+
+	return ret;
+}
+
+static int gc08a3_test_pattern(struct gc08a3 *gc08a3, u32 pattern_menu)
+{
+	int ret = 0;
+	u32 pattern = 0;
+
+	if (pattern_menu) {
+		switch (pattern_menu) {
+		case 1:
+			pattern = 0x00;
+			break;
+		case 2:
+			pattern = 0x10;
+			break;
+		case 3:
+		case 4:
+		case 5:
+		case 6:
+		case 7:
+			pattern = pattern_menu + 1;
+			break;
+		}
+
+		ret = gc08a3_write_reg(gc08a3, GC08A3_REG_TEST_PATTERN_EN,
+				       GC08A3_REG_VALUE_08BIT,
+				       GC08A3_TEST_PATTERN_EN);
+		if (ret) {
+			dev_err(gc08a3->dev, "test pattern enable failed: %d\n", ret);
+			return ret;
+		}
+
+		ret = gc08a3_write_reg(gc08a3, GC08A3_REG_TEST_PATTERN_IDX,
+				       GC08A3_REG_VALUE_08BIT, pattern);
+		if (ret < 0)
+			dev_err(gc08a3->dev, "Error %d\n", ret);
+
+	} else {
+		ret = gc08a3_write_reg(gc08a3, GC08A3_REG_TEST_PATTERN_EN,
+				       GC08A3_REG_VALUE_08BIT, 0x00);
+		if (ret < 0)
+			dev_err(gc08a3->dev, "test pattern disable failed: %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int gc08a3_set_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct gc08a3 *gc08a3 =
+		container_of(ctrl->handler, struct gc08a3, ctrls);
+	int ret = 0;
+	s64 exposure_max;
+
+	if (ctrl->id == V4L2_CID_VBLANK) {
+		/* Update max exposure while meeting expected vblanking */
+		exposure_max = gc08a3->cur_mode->height + ctrl->val -
+			       GC08A3_EXP_MARGIN;
+		__v4l2_ctrl_modify_range(gc08a3->exposure,
+					 gc08a3->exposure->minimum,
+					 exposure_max, gc08a3->exposure->step,
+					 exposure_max);
+	}
+
+	/*
+	 * Applying V4L2 control value only happens
+	 * when power is up for streaming
+	 */
+	if (!pm_runtime_get_if_in_use(gc08a3->dev))
+		return 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
+		ret = gc08a3_write_reg(gc08a3, GC08A3_EXP_REG,
+				       GC08A3_REG_VALUE_16BIT, ctrl->val);
+		break;
+
+	case V4L2_CID_ANALOGUE_GAIN:
+		ret = gc08a3_write_reg(gc08a3, GC08A3_AGAIN_REG,
+				       GC08A3_REG_VALUE_16BIT, ctrl->val);
+		break;
+
+	case V4L2_CID_VBLANK:
+		ret = gc08a3_write_reg(gc08a3, GC08A3_FRAME_LENGTH_REG,
+				       GC08A3_REG_VALUE_16BIT,
+				       gc08a3->cur_mode->height + ctrl->val);
+		break;
+
+	case V4L2_CID_HFLIP:
+		ret = gc08a3_set_ctrl_hflip(gc08a3, ctrl->val);
+		break;
+
+	case V4L2_CID_VFLIP:
+		ret = gc08a3_set_ctrl_vflip(gc08a3, ctrl->val);
+		break;
+
+	case V4L2_CID_TEST_PATTERN:
+		ret = gc08a3_test_pattern(gc08a3, ctrl->val);
+		break;
+
+	default:
+		break;
+	}
+
+	pm_runtime_put(gc08a3->dev);
+
+	return ret;
+}
+
+static int gc08a3_try_ctrl(struct v4l2_ctrl *ctrl)
+{
+	int ret = 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
+	case V4L2_CID_ANALOGUE_GAIN:
+	case V4L2_CID_VBLANK:
+	case V4L2_CID_HFLIP:
+	case V4L2_CID_VFLIP:
+	case V4L2_CID_TEST_PATTERN:
+	default:
+		return 0;
+	}
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops gc08a3_ctrl_ops = {
+	.try_ctrl = gc08a3_try_ctrl,
+	.s_ctrl = gc08a3_set_ctrl,
+};
+
+static int gc08a3_start_streaming(struct gc08a3 *gc08a3)
+{
+	const struct gc08a3_mode *mode;
+	const struct gc08a3_reg_list *reg_list;
+	int link_freq_index;
+	int ret;
+
+	mutex_lock(&gc08a3->mutex);
+
+	link_freq_index = gc08a3->cur_mode->link_freq_index;
+
+	reg_list = &link_freq_configs[link_freq_index].reg_list;
+	ret = gc08a3_write_reg_list(gc08a3, reg_list);
+	if (ret) {
+		dev_err(gc08a3->dev, "could not sent common table %d\n", ret);
+		goto error;
+	}
+
+	mode = gc08a3->cur_mode;
+	reg_list = &mode->reg_list;
+
+	ret = gc08a3_write_reg_list(gc08a3, reg_list);
+	if (ret < 0) {
+		dev_err(gc08a3->dev, "could not sent mode table %d\n", ret);
+		goto error;
+	}
+	ret = __v4l2_ctrl_handler_setup(&gc08a3->ctrls);
+	if (ret < 0) {
+		dev_err(gc08a3->dev, "could not sync v4l2 controls\n");
+		goto error;
+	}
+
+	ret = gc08a3_write_reg(gc08a3, GC08A3_STRAEMING_REG,
+			       GC08A3_REG_VALUE_08BIT, 1);
+	if (ret < 0) {
+		dev_err(gc08a3->dev, "write STRAEMING_REG failed: %d\n", ret);
+		goto error;
+	}
+
+	mutex_unlock(&gc08a3->mutex);
+
+	return 0;
+
+error:
+	mutex_unlock(&gc08a3->mutex);
+	return ret;
+}
+
+static int gc08a3_stop_streaming(struct gc08a3 *gc08a3)
+{
+	int ret;
+
+	ret = gc08a3_write_reg(gc08a3, GC08A3_STRAEMING_REG,
+			       GC08A3_REG_VALUE_08BIT, 0);
+	if (ret < 0)
+		dev_err(gc08a3->dev, "could not sent stop streaming %d\n", ret);
+
+	return ret;
+}
+
+static int gc08a3_s_stream(struct v4l2_subdev *subdev, int enable)
+{
+	struct gc08a3 *gc08a3 = to_gc08a3(subdev);
+	int ret;
+
+	if (gc08a3->streaming == enable)
+		return 0;
+
+	if (enable) {
+		ret = pm_runtime_resume_and_get(gc08a3->dev);
+		if (ret < 0)
+			return ret;
+
+		ret = gc08a3_start_streaming(gc08a3);
+		if (ret < 0)
+			goto err_rpm_put;
+	} else {
+		ret = gc08a3_stop_streaming(gc08a3);
+		if (ret < 0)
+			goto err_rpm_put;
+		pm_runtime_put(gc08a3->dev);
+	}
+
+	gc08a3->streaming = enable;
+	return 0;
+
+err_rpm_put:
+	pm_runtime_put(gc08a3->dev);
+	return ret;
+}
+
+static int gc08a3_g_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
+				struct v4l2_mbus_config *config)
+{
+	config->type = V4L2_MBUS_CSI2_DPHY;
+	config->bus.mipi_csi2.num_data_lanes = 4;
+	config->bus.mipi_csi2.flags = 0;
+	return 0;
+}
+
+static int gc08a3_g_frame_interval(struct v4l2_subdev *subdev,
+				   struct v4l2_subdev_frame_interval *fival)
+{
+	struct gc08a3 *gc08a3 = to_gc08a3(subdev);
+
+	fival->interval.numerator = 1;
+	fival->interval.denominator = gc08a3->cur_mode->max_framerate / 10;
+
+	return 0;
+}
+
+static int
+gc08a3_enum_frame_interval(struct v4l2_subdev *subdev,
+			   struct v4l2_subdev_state *sd_state,
+			   struct v4l2_subdev_frame_interval_enum *fie)
+{
+	const struct gc08a3_mode *mode;
+
+	if (fie->index != 0)
+		return -EINVAL;
+
+	mode = v4l2_find_nearest_size(gc08a3_modes, ARRAY_SIZE(gc08a3_modes),
+				      width, height, fie->width, fie->height);
+
+	fie->code = GC08A3_MBUS_CODE;
+	fie->width = mode->width;
+	fie->height = mode->height;
+	fie->interval.numerator = 1;
+	fie->interval.denominator = mode->max_framerate / 10;
+
+	return 0;
+}
+
+static const struct v4l2_subdev_video_ops gc08a3_video_ops = {
+	.s_stream = gc08a3_s_stream,
+	.g_frame_interval = gc08a3_g_frame_interval,
+	.s_frame_interval = gc08a3_g_frame_interval,
+};
+
+static const struct v4l2_subdev_pad_ops gc08a3_subdev_pad_ops = {
+	.enum_mbus_code = gc08a3_enum_mbus_code,
+	.enum_frame_size = gc08a3_enum_frame_size,
+	.enum_frame_interval = gc08a3_enum_frame_interval,
+	.get_fmt = gc08a3_get_format,
+	.set_fmt = gc08a3_set_format,
+	.get_selection = gc08a3_get_selection,
+	.init_cfg = gc08a3_entity_init_cfg,
+	.get_mbus_config = gc08a3_g_mbus_config,
+};
+
+static const struct v4l2_subdev_ops gc08a3_subdev_ops = {
+	.core = &gc08a3_core_ops,
+	.video = &gc08a3_video_ops,
+	.pad = &gc08a3_subdev_pad_ops,
+};
+
+static int gc08a3_get_regulators(struct device *dev, struct gc08a3 *gc08a3)
+{
+	unsigned int i;
+
+	for (i = 0; i < GC08A3_NUM_SUPPLIES; i++)
+		gc08a3->supplies[i].supply = gc08a3_supply_name[i];
+
+	return devm_regulator_bulk_get(dev, GC08A3_NUM_SUPPLIES,
+				       gc08a3->supplies);
+}
+
+static int gc08a3_parse_fwnode(struct device *dev)
+{
+	struct fwnode_handle *endpoint;
+	struct v4l2_fwnode_endpoint bus_cfg = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY,
+	};
+	unsigned int i, j;
+	int ret;
+
+	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
+	if (!endpoint) {
+		dev_err(dev, "endpoint node not found\n");
+		return -EINVAL;
+	}
+
+	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &bus_cfg);
+	if (ret) {
+		dev_err(dev, "parsing endpoint node failed\n");
+		goto done;
+	}
+
+	if (!bus_cfg.nr_of_link_frequencies) {
+		dev_err(dev, "no link frequencies defined");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(link_freq_menu_items); i++) {
+		for (j = 0; j < bus_cfg.nr_of_link_frequencies; j++) {
+			if (link_freq_menu_items[i] ==
+			    bus_cfg.link_frequencies[j])
+				break;
+		}
+
+		if (j == bus_cfg.nr_of_link_frequencies) {
+			dev_err(dev,
+				"no link frequency %lld supported, please check DT",
+				link_freq_menu_items[i]);
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+done:
+	v4l2_fwnode_endpoint_free(&bus_cfg);
+	fwnode_handle_put(endpoint);
+	return ret;
+}
+
+static int __maybe_unused gc08a3_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+
+	if (gc08a3->streaming)
+		gc08a3_stop_streaming(gc08a3);
+
+	return 0;
+}
+
+static int __maybe_unused gc08a3_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+	int ret;
+
+	if (gc08a3->streaming) {
+		ret = gc08a3_start_streaming(gc08a3);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	gc08a3_stop_streaming(gc08a3);
+	gc08a3->streaming = 0;
+	return ret;
+}
+
+static int gc08a3_init_controls(struct gc08a3 *gc08a3)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&gc08a3->sd);
+	const struct v4l2_ctrl_ops *ops = &gc08a3_ctrl_ops;
+	struct v4l2_fwnode_device_properties props;
+	struct v4l2_ctrl_handler *ctrl_hdlr;
+	s64 exposure_max, h_blank;
+	int ret;
+
+	ctrl_hdlr = &gc08a3->ctrls;
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
+	if (ret)
+		return ret;
+
+	ctrl_hdlr->lock = &gc08a3->mutex;
+
+	gc08a3->link_freq =
+		v4l2_ctrl_new_int_menu(ctrl_hdlr,
+				       &gc08a3_ctrl_ops,
+				       V4L2_CID_LINK_FREQ,
+				       ARRAY_SIZE(link_freq_menu_items) - 1,
+				       0, link_freq_menu_items);
+	if (gc08a3->link_freq)
+		gc08a3->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	gc08a3->pixel_rate =
+		v4l2_ctrl_new_std(ctrl_hdlr,
+				  &gc08a3_ctrl_ops,
+				  V4L2_CID_PIXEL_RATE, 0,
+				  to_pixel_rate(GC08A3_LINK_FREQ_336MHZ_INDEX), 1,
+				  to_pixel_rate(GC08A3_LINK_FREQ_336MHZ_INDEX));
+
+	gc08a3->vblank =
+		v4l2_ctrl_new_std(ctrl_hdlr,
+				  &gc08a3_ctrl_ops, V4L2_CID_VBLANK,
+				  gc08a3->cur_mode->vts_min - gc08a3->cur_mode->height,
+				  GC08A3_VTS_MAX - gc08a3->cur_mode->height, 1,
+				  gc08a3->cur_mode->vts_def - gc08a3->cur_mode->height);
+
+	h_blank = gc08a3->cur_mode->hts - gc08a3->cur_mode->width;
+	gc08a3->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &gc08a3_ctrl_ops,
+					   V4L2_CID_HBLANK, h_blank, h_blank, 1,
+					   h_blank);
+	if (gc08a3->hblank)
+		gc08a3->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	v4l2_ctrl_new_std(ctrl_hdlr, &gc08a3_ctrl_ops,
+			  V4L2_CID_ANALOGUE_GAIN, GC08A3_AGAIN_MIN,
+			  GC08A3_AGAIN_MAX, GC08A3_AGAIN_STEP,
+			  GC08A3_AGAIN_MIN);
+
+	exposure_max = gc08a3->cur_mode->vts_def - GC08A3_EXP_MARGIN;
+	gc08a3->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &gc08a3_ctrl_ops,
+					     V4L2_CID_EXPOSURE, GC08A3_EXP_MIN,
+					     exposure_max, GC08A3_EXP_STEP,
+					     exposure_max);
+
+	v4l2_ctrl_new_std_menu_items(ctrl_hdlr, &gc08a3_ctrl_ops,
+				     V4L2_CID_TEST_PATTERN,
+				     ARRAY_SIZE(gc08a3_test_pattern_menu) - 1,
+				     0, 0, gc08a3_test_pattern_menu);
+
+	v4l2_ctrl_new_std(ctrl_hdlr, &gc08a3_ctrl_ops, V4L2_CID_HFLIP, 0,
+			  1, 1, 0);
+
+	v4l2_ctrl_new_std(ctrl_hdlr, &gc08a3_ctrl_ops, V4L2_CID_VFLIP, 0,
+			  1, 1, 0);
+
+	/* register properties to fwnode (e.g. rotation, orientation) */
+	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	if (ret)
+		goto error_ctrls;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, ops, &props);
+	if (ret)
+		goto error_ctrls;
+
+	if (ctrl_hdlr->error) {
+		ret = ctrl_hdlr->error;
+		goto error_ctrls;
+	}
+
+	gc08a3->sd.ctrl_handler = ctrl_hdlr;
+
+	return 0;
+
+error_ctrls:
+	v4l2_ctrl_handler_free(ctrl_hdlr);
+
+	return ret;
+}
+
+static int gc08a3_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct gc08a3 *gc08a3;
+	int ret;
+
+	ret = gc08a3_parse_fwnode(dev);
+	if (ret)
+		return ret;
+
+	gc08a3 = devm_kzalloc(dev, sizeof(*gc08a3), GFP_KERNEL);
+	if (!gc08a3)
+		return -ENOMEM;
+
+	gc08a3->dev = dev;
+
+	gc08a3->xclk = devm_clk_get(dev, NULL);
+	if (IS_ERR(gc08a3->xclk))
+		return dev_err_probe(dev, PTR_ERR(gc08a3->xclk),
+					 "failed to get xclk\n");
+
+	ret = clk_set_rate(gc08a3->xclk, GC08A3_DEFAULT_CLK_FREQ);
+	if (ret)
+		return dev_err_probe(dev, ret,
+					 "failed to set xclk frequency\n");
+
+	ret = gc08a3_get_regulators(dev, gc08a3);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+					 "failed to get regulators\n");
+
+	gc08a3->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(gc08a3->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(gc08a3->enable_gpio),
+					 "failed to get gpio\n");
+
+	v4l2_i2c_subdev_init(&gc08a3->sd, client, &gc08a3_subdev_ops);
+
+	mutex_init(&gc08a3->mutex);
+	gc08a3->cur_mode = &gc08a3_modes[0];
+
+	ret = gc08a3_power_on(gc08a3->dev);
+	if (ret)
+		goto err_mutex;
+
+	ret = gc08a3_identify_module(gc08a3);
+	if (ret) {
+		dev_err(&client->dev, "failed to find sensor: %d\n", ret);
+		goto err_power_off;
+	}
+
+	ret = gc08a3_init_controls(gc08a3);
+	if (ret) {
+		dev_err(&client->dev, "failed to init controls: %d", ret);
+		goto err_power_off;
+	}
+
+	gc08a3->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	gc08a3->pad.flags = MEDIA_PAD_FL_SOURCE;
+	gc08a3->sd.dev = &client->dev;
+	gc08a3->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
+
+	ret = media_entity_pads_init(&gc08a3->sd.entity, 1, &gc08a3->pad);
+	if (ret < 0) {
+		dev_err(dev, "could not register media entity\n");
+		goto err_v4l2_ctrl_handler_free;
+	}
+
+	ret = v4l2_async_register_subdev_sensor(&gc08a3->sd);
+	if (ret < 0) {
+		dev_err(dev, "could not register v4l2 device\n");
+		goto err_media_entity_cleanup;
+	}
+
+	pm_runtime_set_active(gc08a3->dev);
+	pm_runtime_enable(gc08a3->dev);
+	pm_runtime_idle(gc08a3->dev);
+
+	return 0;
+
+err_media_entity_cleanup:
+	media_entity_cleanup(&gc08a3->sd.entity);
+
+err_v4l2_ctrl_handler_free:
+	v4l2_ctrl_handler_free(gc08a3->sd.ctrl_handler);
+
+err_power_off:
+	gc08a3_power_off(gc08a3->dev);
+
+err_mutex:
+	mutex_destroy(&gc08a3->mutex);
+
+	return ret;
+}
+
+static void gc08a3_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct gc08a3 *gc08a3 = to_gc08a3(sd);
+
+	v4l2_async_unregister_subdev(&gc08a3->sd);
+	media_entity_cleanup(&gc08a3->sd.entity);
+	v4l2_ctrl_handler_free(&gc08a3->ctrls);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+
+	mutex_destroy(&gc08a3->mutex);
+}
+
+static const struct of_device_id gc08a3_of_match[] = {
+	{ .compatible = "galaxycore,gc08a3" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gc08a3_of_match);
+
+static const struct dev_pm_ops gc08a3_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(gc08a3_suspend, gc08a3_resume)
+	SET_RUNTIME_PM_OPS(gc08a3_power_off, gc08a3_power_on, NULL)
+};
+
+static struct i2c_driver gc08a3_i2c_driver = {
+	.driver = {
+		.of_match_table = gc08a3_of_match,
+		.pm = &gc08a3_pm_ops,
+		.name  = "gc08a3",
+	},
+	.probe = gc08a3_probe,
+	.remove = gc08a3_remove,
+};
+
+module_i2c_driver(gc08a3_i2c_driver);
+
+MODULE_DESCRIPTION("GalaxyCore gc08a3 Camera driver");
+MODULE_AUTHOR("Zhi Mao <zhi.mao@mediatek.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

