Return-Path: <linux-kernel+bounces-11358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98BB81E519
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B6B1F225F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C84C3C1;
	Tue, 26 Dec 2023 05:39:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A44C3A6;
	Tue, 26 Dec 2023 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 7370924E28F;
	Tue, 26 Dec 2023 13:39:09 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:39:09 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:39:03 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<emil.renner.berthing@canonical.com>, <hal.feng@starfivetech.com>,
	<xingyu.wu@starfivetech.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [RFC 01/16] reset: starfive: Rename file name "jh71x0" to "common"
Date: Tue, 26 Dec 2023 13:38:33 +0800
Message-ID: <20231226053848.25089-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
References: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

StarFive JH8100 shares a similar clock and reset design with JH7110.
To facilitate the reuse of the file and its functionalities, files
containing the "jh71x0" naming convention are renamed to use the
"common" wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/clk/starfive/clk-starfive-jh7110-sys.c              | 2 +-
 drivers/reset/starfive/Kconfig                              | 6 +++---
 drivers/reset/starfive/Makefile                             | 2 +-
 .../{reset-starfive-jh71x0.c =3D> reset-starfive-common.c}    | 4 ++--
 .../{reset-starfive-jh71x0.h =3D> reset-starfive-common.h}    | 6 +++---
 drivers/reset/starfive/reset-starfive-jh7100.c              | 2 +-
 drivers/reset/starfive/reset-starfive-jh7110.c              | 4 ++--
 .../{reset-starfive-jh71x0.h =3D> reset-starfive-common.h}    | 4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.c =3D> reset-starfi=
ve-common.c} (97%)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.h =3D> reset-starfi=
ve-common.h} (75%)
 rename include/soc/starfive/{reset-starfive-jh71x0.h =3D> reset-starfive=
-common.h} (81%)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk=
/starfive/clk-starfive-jh7110-sys.c
index 3884eff9fe93..6e45c580c9ba 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
=20
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
=20
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kcon=
fig
index d832339f61bc..29fbcf1a7d83 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
-config RESET_STARFIVE_JH71X0
+config RESET_STARFIVE_COMMON
 	bool
=20
 config RESET_STARFIVE_JH7100
 	bool "StarFive JH7100 Reset Driver"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select RESET_STARFIVE_JH71X0
+	select RESET_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7100 SoC.
@@ -15,7 +15,7 @@ config RESET_STARFIVE_JH7110
 	bool "StarFive JH7110 Reset Driver"
 	depends on CLK_STARFIVE_JH7110_SYS
 	select AUXILIARY_BUS
-	select RESET_STARFIVE_JH71X0
+	select RESET_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Mak=
efile
index 7a44b66fb9d5..582e4c160bd4 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+=3D reset-starfive-jh71x0.o
+obj-$(CONFIG_RESET_STARFIVE_COMMON)		+=3D reset-starfive-common.o
=20
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+=3D reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+=3D reset-starfive-jh7110.o
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/res=
et/starfive/reset-starfive-common.c
similarity index 97%
rename from drivers/reset/starfive/reset-starfive-jh71x0.c
rename to drivers/reset/starfive/reset-starfive-common.c
index 55bbbd2de52c..dab454e46bbf 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Reset driver for the StarFive JH71X0 SoCs
+ * Reset driver for the StarFive SoCs
  *
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -12,7 +12,7 @@
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
=20
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
=20
 struct jh71x0_reset {
 	struct reset_controller_dev rcdev;
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/res=
et/starfive/reset-starfive-common.h
similarity index 75%
rename from drivers/reset/starfive/reset-starfive-jh71x0.h
rename to drivers/reset/starfive/reset-starfive-common.h
index db7d39a87f87..266acc4b2caf 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -3,12 +3,12 @@
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
=20
-#ifndef __RESET_STARFIVE_JH71X0_H
-#define __RESET_STARFIVE_JH71X0_H
+#ifndef __RESET_STARFIVE_COMMON_H
+#define __RESET_STARFIVE_COMMON_H
=20
 int reset_starfive_jh71x0_register(struct device *dev, struct device_nod=
e *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u32 *asserted, unsigned int nr_resets,
 				   struct module *owner);
=20
-#endif /* __RESET_STARFIVE_JH71X0_H */
+#endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/res=
et/starfive/reset-starfive-jh7100.c
index 2a56f7fd4ba7..546dea2e5811 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -8,7 +8,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
=20
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
=20
 #include <dt-bindings/reset/starfive-jh7100.h>
=20
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/res=
et/starfive/reset-starfive-jh7110.c
index 29a43f0f2ad6..87dba01491ae 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -7,9 +7,9 @@
=20
 #include <linux/auxiliary_bus.h>
=20
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
=20
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
=20
 #include <dt-bindings/reset/starfive,jh7110-crg.h>
=20
diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/s=
tarfive/reset-starfive-common.h
similarity index 81%
rename from include/soc/starfive/reset-starfive-jh71x0.h
rename to include/soc/starfive/reset-starfive-common.h
index 47b486ececc5..56d8f413cf18 100644
--- a/include/soc/starfive/reset-starfive-jh71x0.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SOC_STARFIVE_RESET_JH71X0_H
-#define __SOC_STARFIVE_RESET_JH71X0_H
+#ifndef __SOC_STARFIVE_RESET_COMMON_H
+#define __SOC_STARFIVE_RESET_COMMON_H
=20
 #include <linux/auxiliary_bus.h>
 #include <linux/compiler_types.h>
--=20
2.34.1


