Return-Path: <linux-kernel+bounces-125423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40668925C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B66284A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E02413E048;
	Fri, 29 Mar 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Y53RKE4T"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AD1369BC;
	Fri, 29 Mar 2024 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746001; cv=none; b=EssI4mzRC2dFGRD8GGwg5AXR8vCmFaRDy3Rs+rlslnszAUklzUd0PNKGmogw/75Iiq0f2vmrquWoN5i6g//Mmd4V/jlq3RwxCcV8kHu3l/UkRK27/8HjbMK9J5CociP7VaA1bgVcC4Zd4lqOfaJcFzyP1ADLcXqZqOmia1EhSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746001; c=relaxed/simple;
	bh=Ox2cNPByqEJHsjNawdPO+laP0M1WFYULmzfW66fYiVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6YLfvYBurSOEc4/KHyvfKAMCV5KXER09FIqLn6vfortyQZyMyw1waRKTnp+Q8nhoQJiKpegPHNNcgzdkGsDtFm8lVCwcb/rTTW1ZxbyuCnMFPhiaxQLx0bfb9ghaMFdo56XQTr9/U08aPqo+apxEvjbfI1bOdfAOhVEpWhVrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Y53RKE4T; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4D53F12001A;
	Fri, 29 Mar 2024 23:59:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4D53F12001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711745958;
	bh=Nf5RaLrQGu7qZj5BAPJHkESbeN+Soja9Az2F0PkLz3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Y53RKE4TJLsTxErJ5oOyri4AzdYcGQaQPBK/NHpah9G1kqvw+ceNeq/ZoZtwuplI6
	 CNr4Ez00WbmHbtmak7wUB9gvp98mTNJeDN9SiTGF4C0bTAWAXHxcZhnSCC/hXEyJz+
	 9FkUXsvRtk9OgBCpbWQdCSb9nSKYgnHaCvptILZTpLzdcm3ulS6+k7r3GW3aeVH17q
	 YxB0o3iwhzJvcdnfgwIAr7JLvoesKPpaHQuDNL3cbRZRCssrtLm1e1CceN0DsgID2X
	 9Sdby2p4/pMwrbwmYb1ZtppIMpfDXl52X+bTR0cDa7Atm7I9c9oYrQePrx9yIGvRt3
	 yKtSaznFvHQfQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 23:59:18 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 23:59:17 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 6/6] clk: meson: a1: add Amlogic A1 CPU clock controller driver
Date: Fri, 29 Mar 2024 23:58:46 +0300
Message-ID: <20240329205904.25002-7-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329205904.25002-1-ddrokosov@salutedevices.com>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184500 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

The CPU clock controller plays a general role in the Amlogic A1 SoC
family by generating CPU clocks. As an APB slave module, it offers the
capability to inherit the CPU clock from two sources: the internal fixed
clock known as 'cpu fixed clock' and the external input provided by the
A1 PLL clock controller, referred to as 'syspll'.

It is important for the driver to handle cpu_clk rate switching
effectively by transitioning to the CPU fixed clock to avoid any
potential execution freezes.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/Kconfig  |  10 ++
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/a1-cpu.c | 324 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/a1-cpu.h |  16 ++
 4 files changed, 351 insertions(+)
 create mode 100644 drivers/clk/meson/a1-cpu.c
 create mode 100644 drivers/clk/meson/a1-cpu.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 80c4a18c83d2..148d4495eee3 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -111,6 +111,16 @@ config COMMON_CLK_AXG_AUDIO
 	  Support for the audio clock controller on AmLogic A113D devices,
 	  aka axg, Say Y if you want audio subsystem to work.
 
+config COMMON_CLK_A1_CPU
+	tristate "Amlogic A1 SoC CPU controller support"
+	depends on ARM64
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_CLKC_UTILS
+	help
+	  Support for the CPU clock controller on Amlogic A113L based
+	  device, A1 SoC Family. Say Y if you want A1 CPU clock controller
+	  to work.
+
 config COMMON_CLK_A1_PLL
 	tristate "Amlogic A1 SoC PLL controller support"
 	depends on ARM64
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 4968fc7ad555..2a06eb0303d6 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_AUDIO_RSTC) += meson-audio-rstc.o
 
 obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
+obj-$(CONFIG_COMMON_CLK_A1_CPU) += a1-cpu.o
 obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
 obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
 obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
diff --git a/drivers/clk/meson/a1-cpu.c b/drivers/clk/meson/a1-cpu.c
new file mode 100644
index 000000000000..5f5d8ae112e5
--- /dev/null
+++ b/drivers/clk/meson/a1-cpu.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic A1 SoC family CPU Clock Controller driver.
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include "a1-cpu.h"
+#include "clk-regmap.h"
+#include "meson-clkc-utils.h"
+
+#include <dt-bindings/clock/amlogic,a1-cpu-clkc.h>
+
+static u32 cpu_fsource_sel_table[] = { 0, 1, 2 };
+static const struct clk_parent_data cpu_fsource_sel_parents[] = {
+	{ .fw_name = "xtal" },
+	{ .fw_name = "fclk_div2" },
+	{ .fw_name = "fclk_div3" },
+};
+
+static struct clk_regmap cpu_fsource_sel0 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.mask = 0x3,
+		.shift = 0,
+		.table = cpu_fsource_sel_table,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_fsource_sel0",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = cpu_fsource_sel_parents,
+		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap cpu_fsource_div0 = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.shift = 4,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_fsource_div0",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&cpu_fsource_sel0.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap cpu_fsel0 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_fsel0",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&cpu_fsource_sel0.hw,
+			&cpu_fsource_div0.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap cpu_fsource_sel1 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.mask = 0x3,
+		.shift = 16,
+		.table = cpu_fsource_sel_table,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_fsource_sel1",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = cpu_fsource_sel_parents,
+		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap cpu_fsource_div1 = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.shift = 20,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_fsource_div1",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&cpu_fsource_sel1.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap cpu_fsel1 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 18,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_fsel1",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&cpu_fsource_sel1.hw,
+			&cpu_fsource_div1.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap cpu_fclk = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 10,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_fclk",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&cpu_fsel0.hw,
+			&cpu_fsel1.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap cpu_clk = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CPUCTRL_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 11,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_clk",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &cpu_fclk.hw },
+			{ .fw_name = "sys_pll", },
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	},
+};
+
+/* Array of all clocks registered by this provider */
+static struct clk_hw *a1_cpu_hw_clks[] = {
+	[CLKID_CPU_FSOURCE_SEL0]	= &cpu_fsource_sel0.hw,
+	[CLKID_CPU_FSOURCE_DIV0]	= &cpu_fsource_div0.hw,
+	[CLKID_CPU_FSEL0]		= &cpu_fsel0.hw,
+	[CLKID_CPU_FSOURCE_SEL1]	= &cpu_fsource_sel1.hw,
+	[CLKID_CPU_FSOURCE_DIV1]	= &cpu_fsource_div1.hw,
+	[CLKID_CPU_FSEL1]		= &cpu_fsel1.hw,
+	[CLKID_CPU_FCLK]		= &cpu_fclk.hw,
+	[CLKID_CPU_CLK]			= &cpu_clk.hw,
+};
+
+static struct clk_regmap *const a1_cpu_regmaps[] = {
+	&cpu_fsource_sel0,
+	&cpu_fsource_div0,
+	&cpu_fsel0,
+	&cpu_fsource_sel1,
+	&cpu_fsource_div1,
+	&cpu_fsel1,
+	&cpu_fclk,
+	&cpu_clk,
+};
+
+static struct regmap_config a1_cpu_regmap_cfg = {
+	.reg_bits   = 32,
+	.val_bits   = 32,
+	.reg_stride = 4,
+	.max_register = CPUCTRL_CLK_CTRL1,
+};
+
+static struct meson_clk_hw_data a1_cpu_clks = {
+	.hws = a1_cpu_hw_clks,
+	.num = ARRAY_SIZE(a1_cpu_hw_clks),
+};
+
+struct a1_cpu_clk_nb_data {
+	const struct clk_ops *mux_ops;
+	struct clk_hw *cpu_clk;
+	struct notifier_block nb;
+	u8 parent;
+};
+
+#define MESON_A1_CPU_CLK_GET_PARENT(nbd) \
+	((nbd)->mux_ops->get_parent((nbd)->cpu_clk))
+#define MESON_A1_CPU_CLK_SET_PARENT(nbd, index) \
+	((nbd)->mux_ops->set_parent((nbd)->cpu_clk, index))
+
+static int meson_a1_cpu_clk_notifier_cb(struct notifier_block *nb,
+					unsigned long event, void *data)
+{
+	struct a1_cpu_clk_nb_data *nbd;
+	int ret = 0;
+
+	nbd = container_of(nb, struct a1_cpu_clk_nb_data, nb);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		nbd->parent = MESON_A1_CPU_CLK_GET_PARENT(nbd);
+		/* Fallback to the CPU fixed clock */
+		ret = MESON_A1_CPU_CLK_SET_PARENT(nbd, 0);
+		/* Wait for clock propagation */
+		udelay(100);
+		break;
+
+	case POST_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+		/* Back to the original parent clock */
+		ret = MESON_A1_CPU_CLK_SET_PARENT(nbd, nbd->parent);
+		/* Wait for clock propagation */
+		udelay(100);
+		break;
+
+	default:
+		pr_warn("Unknown event %lu for %s notifier block\n",
+			event, clk_hw_get_name(nbd->cpu_clk));
+		break;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static struct a1_cpu_clk_nb_data a1_cpu_clk_nb_data = {
+	.mux_ops = &clk_regmap_mux_ops,
+	.cpu_clk = &cpu_clk.hw,
+	.nb.notifier_call = meson_a1_cpu_clk_notifier_cb,
+};
+
+static int meson_a1_dvfs_setup(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk *notifier_clk;
+	int ret;
+
+	/* Setup clock notifier for cpu_clk */
+	notifier_clk = devm_clk_hw_get_clk(dev, &cpu_clk.hw, "dvfs");
+	if (IS_ERR(notifier_clk))
+		return dev_err_probe(dev, PTR_ERR(notifier_clk),
+				     "can't get cpu_clk as notifier clock\n");
+
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &a1_cpu_clk_nb_data.nb);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "can't register cpu_clk notifier\n");
+
+	return ret;
+}
+
+static int meson_a1_cpu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	struct regmap *map;
+	int clkid, i, err;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "can't ioremap resource\n");
+
+	map = devm_regmap_init_mmio(dev, base, &a1_cpu_regmap_cfg);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "can't init regmap mmio region\n");
+
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < ARRAY_SIZE(a1_cpu_regmaps); i++)
+		a1_cpu_regmaps[i]->map = map;
+
+	for (clkid = 0; clkid < a1_cpu_clks.num; clkid++) {
+		err = devm_clk_hw_register(dev, a1_cpu_clks.hws[clkid]);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "clock[%d] registration failed\n",
+					     clkid);
+	}
+
+	err = devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, &a1_cpu_clks);
+	if (err)
+		return dev_err_probe(dev, err, "can't add clk hw provider\n");
+
+	return meson_a1_dvfs_setup(pdev);
+}
+
+static const struct of_device_id a1_cpu_clkc_match_table[] = {
+	{ .compatible = "amlogic,a1-cpu-clkc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, a1_cpu_clkc_match_table);
+
+static struct platform_driver a1_cpu_clkc_driver = {
+	.probe = meson_a1_cpu_probe,
+	.driver = {
+		.name = "a1-cpu-clkc",
+		.of_match_table = a1_cpu_clkc_match_table,
+	},
+};
+
+module_platform_driver(a1_cpu_clkc_driver);
+MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@salutedevices.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/a1-cpu.h b/drivers/clk/meson/a1-cpu.h
new file mode 100644
index 000000000000..e9af4117e26f
--- /dev/null
+++ b/drivers/clk/meson/a1-cpu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Amlogic A1 CPU Clock Controller internals
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
+ */
+
+#ifndef __A1_CPU_H
+#define __A1_CPU_H
+
+/* cpu clock controller register offset */
+#define CPUCTRL_CLK_CTRL0	0x80
+#define CPUCTRL_CLK_CTRL1	0x84
+
+#endif /* __A1_CPU_H */
-- 
2.43.0


