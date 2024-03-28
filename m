Return-Path: <linux-kernel+bounces-122261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382288F463
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7174C1C29C27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419F286AD;
	Thu, 28 Mar 2024 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="V5FzICn+"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578D210FB;
	Thu, 28 Mar 2024 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588201; cv=none; b=YjW/nRzDpEvHSC+KtFq33y8IFw9MhHQrv952iD3vt6sBbNjBvLtQPkYc+EUY1jWtUGqNLyyn9M4PSXwufKHWNK60WucwQI9SpPoG4zIiIJMxsio0OyGtJIleAvBr55HbqqbAmg9s1QRsCpv7w8vJGXd/32TdHS03gdPsXHZCxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588201; c=relaxed/simple;
	bh=QgV+Xw9NbQEO6idqHDJtYJNVbDwVxFgW0gvsSbHMu8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU5fhwnHG0a4a31T3gD0kl+oEHbZE0c8b0CjNncda9V7ZVMR16znxT5WlhhZw3a6nztSyc+MJl1L0Uqvzq7nYMxr6IZJkn0H8Qph4G2JyMJJRVE583UTwz/9+NuU3yTeBu4/Ti9E6cVL2P23mdAVN+MM6zUFVgIaWv+/mMpjuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=V5FzICn+; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1FB2112000F;
	Thu, 28 Mar 2024 04:09:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1FB2112000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711588190;
	bh=gLbD9tc2pn1QeC2j87RMdeV5jO49713zgVqzzHkHt5E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=V5FzICn+/Q1eqKSq7NtDLR+qohNpWb+0nYESA22njBrgUT/znT33ePvaRXTt33BvV
	 ichiLMqztRc/k5Zibv7fiEqK2sFCkYCvXU9+zf1xa73Jx51g/Z85vtjYsJg99duedn
	 UtwpojeHVr6nBQe4u2dO0Z3+1E9zwyTe+iTR3hQd/uhqI7N8N0LbVnTvnxU97/L17K
	 mNA6g2nhYflMH4mzS9j4xg2lGcS88NuQpU21z3hwHqLLK2CPZ+DyuQ54FkDXVS+23w
	 nzegsA7ZcgZCwYz4ntP8fK8Kayb2enlWbuD5daOS6+PEoV5wXMXaxX3qPVOgOLtRjg
	 gnEsgX+udcrfA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 04:09:49 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 04:09:46 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v2 1/5] clk: meson: axg: move reset controller's code to separate module
Date: Thu, 28 Mar 2024 04:08:27 +0300
Message-ID: <20240328010831.884487-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184457 [Mar 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 13 0.3.13 9d58e50253d512f89cb08f71c87c671a2d0a1bca, {Tracking_smtp_not_equal_from}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/27 22:31:00 #24479773
X-KSMG-AntiVirus-Status: Clean, skipped

This code will by reused by A1 SoC.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/Kconfig            |   5 ++
 drivers/clk/meson/Makefile           |   1 +
 drivers/clk/meson/axg-audio.c        |  95 +----------------------
 drivers/clk/meson/meson-audio-rstc.c | 109 +++++++++++++++++++++++++++
 drivers/clk/meson/meson-audio-rstc.h |  12 +++
 5 files changed, 130 insertions(+), 92 deletions(-)
 create mode 100644 drivers/clk/meson/meson-audio-rstc.c
 create mode 100644 drivers/clk/meson/meson-audio-rstc.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 29ffd14d267b..d6a2fa5f7e88 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -48,6 +48,10 @@ config COMMON_CLK_MESON_CPU_DYNDIV
 	tristate
 	select COMMON_CLK_MESON_REGMAP
 
+config COMMON_CLK_MESON_AUDIO_RSTC
+	tristate
+	select RESET_CONTROLLER
+
 config COMMON_CLK_MESON8B
 	bool "Meson8 SoC Clock controller support"
 	depends on ARM
@@ -101,6 +105,7 @@ config COMMON_CLK_AXG_AUDIO
 	select COMMON_CLK_MESON_PHASE
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
+	select COMMON_CLK_MESON_AUDIO_RSTC
 	select REGMAP_MMIO
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 9ee4b954c896..88d94921a4dc 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
 obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
 obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_AUDIO_RSTC) += meson-audio-rstc.o
 
 # Amlogic Clock controllers
 
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index ac3482960903..990203a7ad5c 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -12,10 +12,10 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
-#include <linux/reset-controller.h>
 #include <linux/slab.h>
 
 #include "meson-clkc-utils.h"
+#include "meson-audio-rstc.h"
 #include "axg-audio.h"
 #include "clk-regmap.h"
 #include "clk-phase.h"
@@ -1648,84 +1648,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
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
@@ -1745,7 +1667,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct audioclk_data *data;
-	struct axg_audio_reset_data *rst;
 	struct regmap *map;
 	void __iomem *regs;
 	struct clk_hw *hw;
@@ -1807,18 +1728,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 	if (!data->reset_num)
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
+	return meson_audio_rstc_register(dev, map, data->reset_offset,
+					 data->reset_num);
 }
 
 static const struct audioclk_data axg_audioclk_data = {
diff --git a/drivers/clk/meson/meson-audio-rstc.c b/drivers/clk/meson/meson-audio-rstc.c
new file mode 100644
index 000000000000..2079d24c40f4
--- /dev/null
+++ b/drivers/clk/meson/meson-audio-rstc.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/reset-controller.h>
+
+#include "meson-audio-rstc.h"
+
+struct meson_audio_reset_data {
+	struct reset_controller_dev rstc;
+	struct regmap *map;
+	unsigned int offset;
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
+static const struct reset_control_ops meson_audio_rstc_ops = {
+	.assert = meson_audio_reset_assert,
+	.deassert = meson_audio_reset_deassert,
+	.reset = meson_audio_reset_toggle,
+	.status = meson_audio_reset_status,
+};
+
+int meson_audio_rstc_register(struct device *dev, struct regmap *map,
+			      unsigned int offset, unsigned int num)
+{
+	struct meson_audio_reset_data *rst;
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rst->map = map;
+	rst->offset = offset;
+	rst->rstc.nr_resets = num;
+	rst->rstc.ops = &meson_audio_rstc_ops;
+	rst->rstc.of_node = dev->of_node;
+	rst->rstc.owner = THIS_MODULE;
+
+	return devm_reset_controller_register(dev, &rst->rstc);
+}
+EXPORT_SYMBOL_GPL(meson_audio_rstc_register);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/meson-audio-rstc.h b/drivers/clk/meson/meson-audio-rstc.h
new file mode 100644
index 000000000000..6b441549de03
--- /dev/null
+++ b/drivers/clk/meson/meson-audio-rstc.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __MESON_AUDIO_RSTC_H
+#define __MESON_AUDIO_RSTC_H
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+int meson_audio_rstc_register(struct device *dev, struct regmap *map,
+			      unsigned int offset, unsigned int num);
+
+#endif /* __MESON_AUDIO_RSTC_H */
-- 
2.34.1


