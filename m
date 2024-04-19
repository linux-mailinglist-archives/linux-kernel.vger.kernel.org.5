Return-Path: <linux-kernel+bounces-151440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B28AAF03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12991F22C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41212D1E7;
	Fri, 19 Apr 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vNEzt8gN"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C785631;
	Fri, 19 Apr 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531638; cv=none; b=hlns6o8qf6rguXX5m9jthJe3a/MK0JKs4vDGgsg+8MaUCJbd1Wb2Q3fq+XoC/h5L7XioulFNOe0r22a4bwGQ4+6jt3TXlnn+roEQr3JNqDz7VYW/sLLXmn/6SpeIvdMnSeqgM7gOFU3wY8N+gN0txDcO2HB0uG6hxXYSPZd4YlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531638; c=relaxed/simple;
	bh=56Q1GvrMEANl9StqKiIbbhZLSHxace3AEF3ByXxleNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEcLDa7h+9UWzergmA65MRaCfr1QGVYOqHfTVRPdivFNfTWjrulqip/rQsrqN0pn/yXAJ5aLrUQGVsnSx56RalkwD5VwCp2eeTZ8S8RdQf7wIi+j+Xd8QjuFliu3siaOoXBtb69hnVLWAloyRZYKiBkHYa9PQKCyDcFKItD6akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vNEzt8gN; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 70E78120007;
	Fri, 19 Apr 2024 16:00:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 70E78120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713531627;
	bh=SwCXRYMqN7ydhETDcDKhzDpt2pvZFRidCmTxvrbBgK4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=vNEzt8gN95BMTuy7a8XACS6dmHR/A04I8qruA83xgls2yQZiS41sg4Kix1kyrMugx
	 bigshaSOxsIjSoAJuCVr3FebpLr9h7qdw5vyF/VoeV7vzMcEigt8IMVVIzNgcbYw3v
	 Kwzyj78F+E+bJs8BVsypwyEVLukuMgfAU1g3aI8C1EL+ifhPqkMvxOS3BeTOPvO0lw
	 Z9FxiC3euCpK76/eBku+y0QvENzJdwv1nmmX9fulMXG+q4n1hTuQ/Ts16HBJTWcd5W
	 UOtQ548zCYPtRI9Idx0lX7mg2R80GCadQUq/OW0aI5ljwLMOyiVVRNaOG0dAiWavkI
	 caIIy4Ftb871g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 19 Apr 2024 16:00:27 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Apr 2024 16:00:26 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v3 1/6] reset: reset-meson-audio: introduce separate driver
Date: Fri, 19 Apr 2024 15:58:07 +0300
Message-ID: <20240419125812.983409-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184806 [Apr 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_smtp_not_equal_from}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/18 23:49:00 #24865988
X-KSMG-AntiVirus-Status: Clean, skipped

Typically, Amlogic Meson SoCs have a couple a reset registers lost in
middle of audio clock controller. Reset controller on top of them was
implemented inside audio clock controller driver. This patch moves reset
functionality of this controller to auxiliary driver. There are at least
two reasons for this:

  - architecturally it is more convenient;

  - reusing the code of reset controller for new SoCs becomes easier.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/Kconfig               |   2 +
 drivers/clk/meson/axg-audio.c           | 106 +------------
 drivers/reset/Kconfig                   |   7 +
 drivers/reset/Makefile                  |   1 +
 drivers/reset/reset-meson-audio.c       | 197 ++++++++++++++++++++++++
 include/soc/amlogic/meson-audio-reset.h |  10 ++
 6 files changed, 224 insertions(+), 99 deletions(-)
 create mode 100644 drivers/reset/reset-meson-audio.c
 create mode 100644 include/soc/amlogic/meson-audio-reset.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 29ffd14d267b..33614f8b8cf7 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -101,6 +101,8 @@ config COMMON_CLK_AXG_AUDIO
 	select COMMON_CLK_MESON_PHASE
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
+	select RESET_CONTROLLER
+	select RESET_MESON_AUDIO
 	select REGMAP_MMIO
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index ac3482960903..9cd6b5c3aa7e 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -12,9 +12,10 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
-#include <linux/reset-controller.h>
 #include <linux/slab.h>
 
+#include <soc/amlogic/meson-audio-reset.h>
+
 #include "meson-clkc-utils.h"
 #include "axg-audio.h"
 #include "clk-regmap.h"
@@ -1648,84 +1649,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
 	&sm1_sysclk_b_en,
 };
 
-struct axg_audio_reset_data {
-	struct reset_controller_dev rstc;
-	struct regmap *map;
-	unsigned int offset;
-};
-
-static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
-					unsigned long id,
-					unsigned int *reg,
-					unsigned int *bit)
-{
-	unsigned int stride = regmap_get_reg_stride(rst->map);
-
-	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
-	*reg += rst->offset;
-	*bit = id % (stride * BITS_PER_BYTE);
-}
-
-static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
-				unsigned long id, bool assert)
-{
-	struct axg_audio_reset_data *rst =
-		container_of(rcdev, struct axg_audio_reset_data, rstc);
-	unsigned int offset, bit;
-
-	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
-
-	regmap_update_bits(rst->map, offset, BIT(bit),
-			assert ? BIT(bit) : 0);
-
-	return 0;
-}
-
-static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct axg_audio_reset_data *rst =
-		container_of(rcdev, struct axg_audio_reset_data, rstc);
-	unsigned int val, offset, bit;
-
-	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
-
-	regmap_read(rst->map, offset, &val);
-
-	return !!(val & BIT(bit));
-}
-
-static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return axg_audio_reset_update(rcdev, id, true);
-}
-
-static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return axg_audio_reset_update(rcdev, id, false);
-}
-
-static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	int ret;
-
-	ret = axg_audio_reset_assert(rcdev, id);
-	if (ret)
-		return ret;
-
-	return axg_audio_reset_deassert(rcdev, id);
-}
-
-static const struct reset_control_ops axg_audio_rstc_ops = {
-	.assert = axg_audio_reset_assert,
-	.deassert = axg_audio_reset_deassert,
-	.reset = axg_audio_reset_toggle,
-	.status = axg_audio_reset_status,
-};
-
 static const struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -1737,15 +1660,13 @@ struct audioclk_data {
 	struct clk_regmap *const *regmap_clks;
 	unsigned int regmap_clk_num;
 	struct meson_clk_hw_data hw_clks;
-	unsigned int reset_offset;
-	unsigned int reset_num;
+	const char *reset_name;
 };
 
 static int axg_audio_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct audioclk_data *data;
-	struct axg_audio_reset_data *rst;
 	struct regmap *map;
 	void __iomem *regs;
 	struct clk_hw *hw;
@@ -1804,21 +1725,10 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Stop here if there is no reset */
-	if (!data->reset_num)
+	if (!data->reset_name)
 		return 0;
 
-	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
-	if (!rst)
-		return -ENOMEM;
-
-	rst->map = map;
-	rst->offset = data->reset_offset;
-	rst->rstc.nr_resets = data->reset_num;
-	rst->rstc.ops = &axg_audio_rstc_ops;
-	rst->rstc.of_node = dev->of_node;
-	rst->rstc.owner = THIS_MODULE;
-
-	return devm_reset_controller_register(dev, &rst->rstc);
+	return meson_audio_reset_register(dev, data->reset_name);
 }
 
 static const struct audioclk_data axg_audioclk_data = {
@@ -1837,8 +1747,7 @@ static const struct audioclk_data g12a_audioclk_data = {
 		.hws = g12a_audio_hw_clks,
 		.num = ARRAY_SIZE(g12a_audio_hw_clks),
 	},
-	.reset_offset = AUDIO_SW_RESET,
-	.reset_num = 26,
+	.reset_name = "g12a",
 };
 
 static const struct audioclk_data sm1_audioclk_data = {
@@ -1848,8 +1757,7 @@ static const struct audioclk_data sm1_audioclk_data = {
 		.hws = sm1_audio_hw_clks,
 		.num = ARRAY_SIZE(sm1_audio_hw_clks),
 	},
-	.reset_offset = AUDIO_SM1_SW_RESET0,
-	.reset_num = 39,
+	.reset_name = "sm1",
 };
 
 static const struct of_device_id clkc_match_table[] = {
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7112f5932609..98106694566f 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -138,6 +138,13 @@ config RESET_MESON
 	help
 	  This enables the reset driver for Amlogic Meson SoCs.
 
+config RESET_MESON_AUDIO
+	tristate "Meson Audio Reset Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	select AUXILIARY_BUS
+	help
+	  This enables the audio reset driver for Amlogic Meson SoCs.
+
 config RESET_MESON_AUDIO_ARB
 	tristate "Meson Audio Memory Arbiter Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index fd8b49fa46fc..8ee7a57ccf03 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_MESON_AUDIO) += reset-meson-audio.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
diff --git a/drivers/reset/reset-meson-audio.c b/drivers/reset/reset-meson-audio.c
new file mode 100644
index 000000000000..aaea9931cfe2
--- /dev/null
+++ b/drivers/reset/reset-meson-audio.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/regmap.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/reset-controller.h>
+
+#include <soc/amlogic/meson-audio-reset.h>
+
+struct meson_audio_reset_data {
+	struct reset_controller_dev rstc;
+	struct regmap *map;
+	unsigned int offset;
+};
+
+struct meson_audio_reset_info {
+	unsigned int reset_offset;
+	unsigned int reset_num;
+};
+
+static void meson_audio_reset_reg_and_bit(struct meson_audio_reset_data *rst,
+					  unsigned long id,
+					  unsigned int *reg,
+					  unsigned int *bit)
+{
+	unsigned int stride = regmap_get_reg_stride(rst->map);
+
+	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
+	*reg += rst->offset;
+	*bit = id % (stride * BITS_PER_BYTE);
+}
+
+static int meson_audio_reset_update(struct reset_controller_dev *rcdev,
+				    unsigned long id, bool assert)
+{
+	struct meson_audio_reset_data *rst =
+		container_of(rcdev, struct meson_audio_reset_data, rstc);
+	unsigned int offset, bit;
+
+	meson_audio_reset_reg_and_bit(rst, id, &offset, &bit);
+
+	regmap_update_bits(rst->map, offset, BIT(bit),
+			assert ? BIT(bit) : 0);
+
+	return 0;
+}
+
+static int meson_audio_reset_status(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct meson_audio_reset_data *rst =
+		container_of(rcdev, struct meson_audio_reset_data, rstc);
+	unsigned int val, offset, bit;
+
+	meson_audio_reset_reg_and_bit(rst, id, &offset, &bit);
+
+	regmap_read(rst->map, offset, &val);
+
+	return !!(val & BIT(bit));
+}
+
+static int meson_audio_reset_assert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	return meson_audio_reset_update(rcdev, id, true);
+}
+
+static int meson_audio_reset_deassert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	return meson_audio_reset_update(rcdev, id, false);
+}
+
+static int meson_audio_reset_toggle(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	int ret;
+
+	ret = meson_audio_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return meson_audio_reset_deassert(rcdev, id);
+}
+
+static const struct reset_control_ops meson_audio_reset_ops = {
+	.assert = meson_audio_reset_assert,
+	.deassert = meson_audio_reset_deassert,
+	.reset = meson_audio_reset_toggle,
+	.status = meson_audio_reset_status,
+};
+
+static int meson_audio_reset_probe(struct auxiliary_device *adev,
+				  const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct meson_audio_reset_info *info =
+		(struct meson_audio_reset_info *)id->driver_data;
+	struct meson_audio_reset_data *rst;
+
+	dev_info(dev, "%s, reset_offset = %#x, reset_num = %u", __func__,
+		 info->reset_offset, info->reset_num);
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rst->map = dev_get_regmap(dev->parent, NULL);
+	if (!rst->map)
+		return -ENODEV;
+
+	rst->offset = info->reset_offset;
+	rst->rstc.ops = &meson_audio_reset_ops;
+	rst->rstc.of_node = dev->parent->of_node;
+	rst->rstc.nr_resets = info->reset_num;
+	rst->rstc.owner = THIS_MODULE;
+
+	return devm_reset_controller_register(dev, &rst->rstc);
+}
+
+static void meson_audio_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static void meson_audio_reset_adev_unregister(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static const struct meson_audio_reset_info meson_audio_reset_info_g12a = {
+	.reset_offset = 0x024,
+	.reset_num = 26,
+};
+
+static const struct meson_audio_reset_info meson_audio_reset_info_sm1 = {
+	.reset_offset = 0x028,
+	.reset_num = 39,
+};
+static const struct auxiliary_device_id meson_audio_reset_id[] = {
+	{
+		.name = "reset_meson_audio.g12a",
+		.driver_data = (kernel_ulong_t)&meson_audio_reset_info_g12a,
+	},
+	{
+		.name = "reset_meson_audio.sm1",
+		.driver_data = (kernel_ulong_t)&meson_audio_reset_info_sm1,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, meson_audio_reset_id);
+
+static struct auxiliary_driver meson_audio_reset_driver = {
+	.probe = meson_audio_reset_probe,
+	.id_table = meson_audio_reset_id,
+};
+
+module_auxiliary_driver(meson_audio_reset_driver);
+
+int meson_audio_reset_register(struct device *dev, const char *name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = name;
+	adev->dev.parent = dev;
+	adev->dev.release = meson_audio_reset_adev_release;
+	adev->id = 0;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, meson_audio_reset_adev_unregister,
+					adev);
+}
+EXPORT_SYMBOL_GPL(meson_audio_reset_register);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/amlogic/meson-audio-reset.h b/include/soc/amlogic/meson-audio-reset.h
new file mode 100644
index 000000000000..279c6a2197ec
--- /dev/null
+++ b/include/soc/amlogic/meson-audio-reset.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __MESON_AUDIO_RESET_H
+#define __MESON_AUDIO_RESET_H
+
+#include <linux/device.h>
+
+int meson_audio_reset_register(struct device *dev, const char *name);
+
+#endif /* __MESON_AUDIO_RESET_H */
-- 
2.34.1


