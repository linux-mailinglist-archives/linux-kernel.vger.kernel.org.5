Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D5806F28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377828AbjLFLxN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378213AbjLFLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:52:50 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D119AD;
        Wed,  6 Dec 2023 03:52:14 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6CC2B24E308;
        Wed,  6 Dec 2023 19:52:13 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:52:13 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:52:06 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>, <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        Joshua Yeong <joshua.yeong@starfivetech.com>
Subject: [PATCH v1 15/16] reset: starfive: Add StarFive JH8100 reset driver
Date:   Wed, 6 Dec 2023 19:49:59 +0800
Message-ID: <20231206115000.295825-16-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [175.136.135.142]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add auxiliary reset driver to support StarFive JH8100 SoC.

Co-developed-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                   |   7 ++
 drivers/reset/starfive/Kconfig                |   8 ++
 drivers/reset/starfive/Makefile               |   2 +
 .../reset/starfive/reset-starfive-jh8100.c    | 102 ++++++++++++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 drivers/reset/starfive/reset-starfive-jh8100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 87bcb25becc1..ed728f013d32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20771,6 +20771,13 @@ F:	Documentation/devicetree/bindings/clock/starfive,jh81*.yaml
 F:	drivers/clk/starfive/jh8100
 F:	include/dt-bindings/clock/starfive?jh81*.h
 
+STARFIVE JH8100 RESET CONTROLLER DRIVERS
+M:	Sia Jee Heng <jeeheng.sia@starfivetech.com>
+M:	Ley Foon Tan <leyfoon.tan@starfivetech.com>
+S:	Maintained
+F:	drivers/reset/starfive/reset-starfive-jh81*
+F:	include/dt-bindings/reset/starfive?jh81*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index 29fbcf1a7d83..88d050044d52 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -19,3 +19,11 @@ config RESET_STARFIVE_JH7110
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
+
+config RESET_STARFIVE_JH8100
+	bool "StarFive JH8100 Reset Driver"
+	depends on AUXILIARY_BUS && CLK_STARFIVE_JH8100_SYS
+	select RESET_STARFIVE_COMMON
+	default ARCH_STARFIVE
+	help
+	  This enables the reset controller driver for the StarFive JH8100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 582e4c160bd4..ede1fc1c9601 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_RESET_STARFIVE_COMMON)		+= reset-starfive-common.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
+
+obj-$(CONFIG_RESET_STARFIVE_JH8100)		+= reset-starfive-jh8100.o
diff --git a/drivers/reset/starfive/reset-starfive-jh8100.c b/drivers/reset/starfive/reset-starfive-jh8100.c
new file mode 100644
index 000000000000..84f3781a22a5
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jh8100.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reset driver for the StarFive JH8100 SoC
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <dt-bindings/reset/starfive,jh8100-crg.h>
+#include <linux/auxiliary_bus.h>
+#include <soc/starfive/reset-starfive-common.h>
+
+#include "reset-starfive-common.h"
+
+struct jh8100_reset_info {
+	unsigned int nr_resets;
+	unsigned int assert_offset;
+	unsigned int status_offset;
+};
+
+static const struct jh8100_reset_info jh8100_sys_info = {
+	.nr_resets = SYSCRG_RESET_NR_RESETS,
+	.assert_offset = 0x1B4,
+	.status_offset = 0x1B8,
+};
+
+static const struct jh8100_reset_info jh8100_sys_nw_info = {
+	.nr_resets = SYSCRG_NW_RESET_NR_RESETS,
+	.assert_offset = 0xA4,
+	.status_offset = 0xA8,
+};
+
+static const struct jh8100_reset_info jh8100_sys_ne_info = {
+	.nr_resets = SYSCRG_NE_RESET_NR_RESETS,
+	.assert_offset = 0x2BC,
+	.status_offset = 0x2C4,
+};
+
+static const struct jh8100_reset_info jh8100_sys_sw_info = {
+	.nr_resets = SYSCRG_SW_RESET_NR_RESETS,
+	.assert_offset = 0x28,
+	.status_offset = 0x2C,
+};
+
+static const struct jh8100_reset_info jh8100_aon_info = {
+	.nr_resets = AONCRG_RESET_NR_RESETS,
+	.assert_offset = 0x104,
+	.status_offset = 0x108,
+};
+
+static int jh8100_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct jh8100_reset_info *info = (struct jh8100_reset_info *)
+					 (id->driver_data);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
+	void __iomem *base = rdev->base;
+
+	if (!info || !base)
+		return -ENODEV;
+
+	return reset_starfive_register(&adev->dev,
+					      adev->dev.parent->of_node,
+					      base + info->assert_offset,
+					      base + info->status_offset, NULL,
+					      info->nr_resets, NULL);
+}
+
+static const struct auxiliary_device_id jh8100_reset_ids[] = {
+	{
+		.name = "clk_sys.rst-sys",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_info,
+	},
+	{
+		.name = "clk_sys.rst-sys-nw",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_nw_info,
+	},
+	{
+		.name = "clk_sys.rst-sys-ne",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_ne_info,
+	},
+	{
+		.name = "clk_sys.rst-sys-sw",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_sw_info,
+	},
+	{
+		.name = "clk_sys.rst-aon",
+		.driver_data = (kernel_ulong_t)&jh8100_aon_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, jh8100_reset_ids);
+
+static struct auxiliary_driver jh8100_reset_driver = {
+	.probe		= jh8100_reset_probe,
+	.id_table	= jh8100_reset_ids,
+};
+module_auxiliary_driver(jh8100_reset_driver);
+
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
+MODULE_AUTHOR("Sia Jee Heng <jeeheng.sia@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH8100 reset driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

