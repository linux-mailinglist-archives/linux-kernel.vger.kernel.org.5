Return-Path: <linux-kernel+bounces-103870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1087C619
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5784628290C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A810788;
	Thu, 14 Mar 2024 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="olAfs4U+"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B3DF6B;
	Thu, 14 Mar 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458588; cv=none; b=lB5XbHSGjk6K91yQc22GMw8rMLgInrITgAFKSRLRd9Rei0iLXZ+Ff2iz+6TSyUH8WW4iTa2sNfKFbLhna1UOcTL+IG2P3pXVHyLaY4bRN+CLoS4Lb5gCC05bu+3nqBPrUSMyh/wJua5B1U0mGRyDgJFTXJ2pjTdL1esDhOLTbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458588; c=relaxed/simple;
	bh=QgV+Xw9NbQEO6idqHDJtYJNVbDwVxFgW0gvsSbHMu8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBzg8FVS6KJ/naf1s6N5KHWY5rCBYT8nDSIHCY4tRlE7LUYkV13rIQgXfgJ8drhtRX3SapPiOOHBSWrbwWceXZHppq+qJOx2qvPtpht8kjzvE1KUfELVI8Zx2orKhU8jxHmKjF/MamYOC6+bF/F3D79DMNhzm6u7ro6XLS0ZGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=olAfs4U+; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2C36110000F;
	Fri, 15 Mar 2024 02:23:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2C36110000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458581;
	bh=gLbD9tc2pn1QeC2j87RMdeV5jO49713zgVqzzHkHt5E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=olAfs4U+XHSt8Jjd8Kt9sbP4C31rhs/GCY26OiVHdADa4Y7Yp2XPE0JKjjsd9lW6v
	 0cKI4H9dXCsXKID7URpBSBeYnTuS32Ueu5oVaUM5/dzdYScIhPKj2WkVZT7EYkEt9r
	 I29pzstQtiDxer98h7IzQDdZcuVt57HKUu/eAukhxAZVCX2SOD76x3NTz06BFeFwR7
	 RVvEljeL67R7hbxAOX9BtnzOQPd8S/XntJr3dNVx6xShjJrttCn1fGVg0oiQkhV0vu
	 BcATVRWw3lAOtQ+tUOVXGMTiEQ+O1vHTO7hxkDCGqsWCyWwucLDfu7BQTi/OCQFwks
	 RZL3jDyEKIsJw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:01 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:00 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
CC: <kernel@salutedevices.com>
Subject: [PATCH 02/25] clk: meson: axg: move reset controller's code to separate module
Date: Fri, 15 Mar 2024 02:21:38 +0300
Message-ID: <20240314232201.2102178-3-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
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


