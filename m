Return-Path: <linux-kernel+bounces-22267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD4829B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8FD1F22D27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841A48CD9;
	Wed, 10 Jan 2024 13:47:23 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2045.outbound.protection.partner.outlook.cn [139.219.17.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F8487BE;
	Wed, 10 Jan 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCxl7NYo8C+K0tSb2jg/sZU3sg7OEex6Gh7U0cLso4XIlbKJnFINHgInugANXjLHeYBTcDMwnbWQl8yx00y9AK1+RBqTREG4WxwCWpm8E1PnI0BQII4WXsKqoikpeh0As5I9GbLU4gOA3GVxf3XxrW0UtAmUJxYYUHlQ6bLpqXudBQtyBrOKB5IIqxq8kT9N7DUMtdO22UG8UEr/D52P8qM7IRBn93qvkppCUUemsQKI6uRQNkeSmfRBRM0+MgCdMnMZ0I4L7m04eleKuoZC9FRORWznI1R5WlsNsO6aipUMFS9Nxr+UiAZvJra7lEevg+v6Jh0rPeeBimadEjoukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnUzbTB4OPn5JdcT7n9MVAEUnb18HGCBPr/Ne+F0Qrs=;
 b=SzoHVbGzWod5GYoItUNPrd7eYcnbjl8XpsjjuRGKDoFotpyqQTY78rAQPI7F31vJyPp9FeRrg0QLWAkOfHFY9z5jddDOVoAhP9IjPYkc7fY3ZhujmY9jLYhmBmK0trZ5d5oMW/2fdgwtZGJbXocPnSmeGp1+6vYS9PuJ+uScwgJcjvU/t07xOqR7kszzOaEieazHWL2z2CKNVikZSLnxQY/FAwVB1WBD0/tVPj5AHbwzL9QygDV79tHnoHn+EbxZ3/0rMuJI3iXzc4nngkSfB59txOU0IYwZ17dR5So1qOHFCsoYjjsdcYMRYnvvq3SouIE1rPj1OS5HdZ21GFgmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0865.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:31:45 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:31:45 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com
Subject: [RFC v3 01/16] reset: starfive: Rename file name "jh71x0" to "common"
Date: Wed, 10 Jan 2024 21:31:13 +0800
Message-Id: <20240110133128.286657-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0865:EE_
X-MS-Office365-Filtering-Correlation-Id: 128f2498-042a-4fdf-80ce-08dc11e07d65
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M8gdmljNfmt5yBjxiGksPGDL/Dmb44sXLO0gYBLcQ9btHIPrpR3XpOHvCu/K2cno5I9+OnKZGKQ29PPWrsejTZWE7YyC1uBFLgAImWA65CMs1zRr+7+bNZXJhXtXNt7vMRg+ykJdIsCHqQYQAzRBgiGgQkStbQbxqn6xmcsudSz4Lso5vuEQBRGxh+nF4EaxTziF+pe9Kxk/qlH+FrgFYlkTetunbmZtqysm+CEPXQbdQ1M8KfiYALXPdRx/zuCkCNsRED86R/iMzV8wEA4MLgUTTfyQPrNueyGh1P4rTwQqlzDXj1yhaqQ2LFT8KQt6d6Vv8b3hZFGIGMGl58ZoF4DuNq4iA9xcMgxU6I/ywln6CNSweYjkNfXF2E4IiSMRIQB7MBpKxoHwFZFstovIsjHBO2LBH024fObLwv9iZXMS5dt/eRHAAqNIquYe8nn2gjnhxcQs4dBcwmk8DMnlKmyngUig+h6f7QZ7aIKwwwBS7sDwsF9zG7s1gwxLAcjJZtjL+nZ65oXq6gRnYuI3eoLsHSewQ6RB+pm/WjcynMgVX3KeH7Qr+K8z8UD7rhUJcUXFvHdwqTqA2Q8yLoKJCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39830400003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(6666004)(508600001)(55236004)(52116002)(2616005)(107886003)(1076003)(26005)(38100700002)(40160700002)(38350700005)(921011)(86362001)(40180700001)(36756003)(41300700001)(4326008)(7416002)(83380400001)(5660300002)(2906002)(8936002)(8676002)(66946007)(66556008)(66476007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxBfKY1cdrE6AumunfIFJjQoKcQYzMbYknismlNjHMuC7cG6JcPdQzyqCP7P?=
 =?us-ascii?Q?LaxWs5dVJyAnKkM2XPlkPGbAOY0H/qSJADzn7fkj/Fc67+rn1q8G8Vn9hvqe?=
 =?us-ascii?Q?JyWYm4EbVv2RyohdO+AS0ulYIOB+jKGylboBZKd3jO5x5ygfIT+9DqJM/JqS?=
 =?us-ascii?Q?HcBdY0I2Ar/GVjTDWHEERz93QHBJUHA4b5EJKGRsTpMXB4M3velEuENig5pc?=
 =?us-ascii?Q?2U/v1fPH5WbDMzMGrJUfF5eIBjTCz8aUrGnWue4jzKhTGjXSkqJ1nu6Tpr3/?=
 =?us-ascii?Q?h31+1DH6j5QDd6jzrTJ0X7bMERqcLdZacAl4RS3N53ABlg35jErLPFnmEobR?=
 =?us-ascii?Q?J9l1vIui+/fW7Fv8bEmc61XpxZyDcIkLC4JfGyf96P47DV7UYWljFpI6yXTb?=
 =?us-ascii?Q?1sBr6AOBS+rmJ+E413utj6NYewvkLQEjvs9p1fiNykAmSNkdf8HNQ712a/Ed?=
 =?us-ascii?Q?xyUWkTiOguA9RLr9r4K4T8O7nfKU2JLlcvi/lX+7MTQip4sht0RCZNO1e5/L?=
 =?us-ascii?Q?pl4EtLOg6GSmUSOtoRQ6KqediPoQ4yRonsmjBwzrMLgM4wfJWbDsGSYB7cfL?=
 =?us-ascii?Q?ggTluf/194ios4a5sbUJMF7Pq5QQ//T256TeVO3sxp8YTFQT5f/L6wpwp/D8?=
 =?us-ascii?Q?cwS3/k1WBWpc2XntMyoafkumVqMMZ0K1M332eRyIZjrjeYKg8qVtLK6IGc7K?=
 =?us-ascii?Q?sLtwZfZOIjL/SCEOpLz+3f4511BYZqtXQokCMYBzY6SnMnS+wHpGAv5K5rEs?=
 =?us-ascii?Q?lqiOWME+PKdnlFkBbk5XfuPYmVpa84echl9uc6em346vcmBp0xEXZXGKQVzg?=
 =?us-ascii?Q?DLlKDlemeuagbPyzCbEdKpVyzOwP8n+jLvqlJ/QfwNdBYArOhuU/GEvqta/N?=
 =?us-ascii?Q?tasPQR6Tht/vnvTvszP7W4H0Z8STMUu7C2fZdTngUilFkCEfk3JsU/6JBdJI?=
 =?us-ascii?Q?GIKKTg4c+InQZLToPs1+iBjpNi81cXuqFjmgaPk+Rj6dJ8RCgvpYJEeayHCE?=
 =?us-ascii?Q?r3S5jSCL6/LJSBD4QPEwtfVCQPFTFVE5FVQhel5nhSA2kH1oB/Qdd/ro++eC?=
 =?us-ascii?Q?nKnEgr/1NpD9CgkuUQCIczTasbf9l8NzjsUVnlq4b1XS+DfLSAOJSm6+2epa?=
 =?us-ascii?Q?1rus+Kl5YFlqA2EwsjlVqqHS0lbRs388AA8X5hTuWkWaWA43gT149SZJi3Z/?=
 =?us-ascii?Q?ZCgRBqQcRV6SflzMFhjrAgHqnQH9TF2BmG7dgSf4yiEUPH4iDbUfNkf2kN6L?=
 =?us-ascii?Q?E3Vz01lyi4lg523iHdrVqDbhl3U+4lM5c6BT00IDB8T5Z9mrGOjnFQMhzzIA?=
 =?us-ascii?Q?//9ewqwDwEvbUGe+tJOCU1HIQYpXxt0bzNXEamXeAXiNDaW6z7+m6BF5g7NK?=
 =?us-ascii?Q?o4D/e7Fpqe4Getm0f36+dBt0xd8CxUc3xjDoWzYGZmDNH9f0FiH1q6cxZU2m?=
 =?us-ascii?Q?PIV97C0jQ+U4Cu9Y4RYqflJlkumu/A889BXsLYrDPWQOEiPmOQ/ZBJ0CCJze?=
 =?us-ascii?Q?EHWgtZiZA0+3tZIgSh/tDqcughf3r+PmoOYFrEAE/x9h6B2oEU0HdNMbdqR+?=
 =?us-ascii?Q?rtJo5Dal+pLwU+u+gHmXhGoqdY5iTOkMLGv6zTVcY3ivgBq5OQlZMtboVYdJ?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128f2498-042a-4fdf-80ce-08dc11e07d65
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:31:45.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYJZ3NLWCfLPEu0F6awUqO6fJxAUTy6feqXm2GYBXcAdqhJLbKcztgLYrRpxzedgwnLdBBlVrZvkzXGY2mNOGD0W7wUobkmCbxiYHJWr0fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0865

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
 .../{reset-starfive-jh71x0.c => reset-starfive-common.c}    | 4 ++--
 .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 6 +++---
 drivers/reset/starfive/reset-starfive-jh7100.c              | 2 +-
 drivers/reset/starfive/reset-starfive-jh7110.c              | 4 ++--
 .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.c => reset-starfive-common.c} (97%)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (75%)
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (81%)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 3884eff9fe93..6e45c580c9ba 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
 
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
 
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index d832339f61bc..29fbcf1a7d83 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config RESET_STARFIVE_JH71X0
+config RESET_STARFIVE_COMMON
 	bool
 
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
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 7a44b66fb9d5..582e4c160bd4 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+= reset-starfive-jh71x0.o
+obj-$(CONFIG_RESET_STARFIVE_COMMON)		+= reset-starfive-common.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-common.c
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
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 struct jh71x0_reset {
 	struct reset_controller_dev rcdev;
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-common.h
similarity index 75%
rename from drivers/reset/starfive/reset-starfive-jh71x0.h
rename to drivers/reset/starfive/reset-starfive-common.h
index db7d39a87f87..266acc4b2caf 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -3,12 +3,12 @@
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
 
-#ifndef __RESET_STARFIVE_JH71X0_H
-#define __RESET_STARFIVE_JH71X0_H
+#ifndef __RESET_STARFIVE_COMMON_H
+#define __RESET_STARFIVE_COMMON_H
 
 int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u32 *asserted, unsigned int nr_resets,
 				   struct module *owner);
 
-#endif /* __RESET_STARFIVE_JH71X0_H */
+#endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 2a56f7fd4ba7..546dea2e5811 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -8,7 +8,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 #include <dt-bindings/reset/starfive-jh7100.h>
 
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 29a43f0f2ad6..87dba01491ae 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -7,9 +7,9 @@
 
 #include <linux/auxiliary_bus.h>
 
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 #include <dt-bindings/reset/starfive,jh7110-crg.h>
 
diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/starfive/reset-starfive-common.h
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
 
 #include <linux/auxiliary_bus.h>
 #include <linux/compiler_types.h>
-- 
2.34.1


