Return-Path: <linux-kernel+bounces-22276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14E829BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9A41F25274
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23494C60E;
	Wed, 10 Jan 2024 13:48:32 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2085.outbound.protection.partner.outlook.cn [139.219.17.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575E4BA9D;
	Wed, 10 Jan 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3WuTMMhk9YXFux5EoMxZoZY1HP/PvX9QDaNPjwp291DnPBeX5MHiJ5AzCHl2GGRMfEMaM6EXfoCPcK6DfC0jMTrvVMYlL4CXpcFkfNMgoZ6g2XMjwf+hCa6FmQZTBmD4JQxdH79vqGQl6Y5L5IEhO9O3InUIh1O/W5KE1vJAHJZ9WGpGLHWqKH073QBWawWCnxvJOtTxdCaMtgj8whXVtDh1g7Va8uyq4gObubVGvQCYhEVXKt0KFIB39MaP0a6oelZiWpI/YNtqW1MkkPEC5IukHGDjIXUiokQqQTbnOTkLnQRez5EPu4cQsgER7VWGwcJVJM/Q9J263QJCMGdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO8QgPB0DL3mNzO74IYllMWQSIgnCbvtWOpkstTomR8=;
 b=bj4RHGcE7oZBCErxpHWhZ1CFb5Q6T9WrqS+NcpsSq3oE6+e84lW6f+UdL0iK5xwmD9L0Ne/NRCCHNb1LYG7XlO0rSflNvegGsEP6JX4Gpwv2UJ71sD7HYy0sbdvAis9KHc+fSdrC32IcoNPmkUnxSHdGM9UOU0s+I94eISYoIbm/lJJ77bMG17aoJfT17mLnw0HsNXXmMUafRsOurp5dzVqGLK2X2nZDvI3NQgW30NvbErFethKZ8uDfwU6ePgXMHa7DiMZ9/w3m62UEwoDj/eOuAGhZVZH7N0I3BWtxfNK9bI96KRh3QUaDRFuOQUW1w/JoePOSXMwGvAOl7nkYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:38 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:38 +0000
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
	leyfoon.tan@starfivetech.com,
	Joshua Yeong <joshua.yeong@starfivetech.com>
Subject: [RFC v3 15/16] reset: starfive: Add StarFive JH8100 reset driver
Date: Wed, 10 Jan 2024 21:31:27 +0800
Message-Id: <20240110133128.286657-16-jeeheng.sia@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0626:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f06df8-1f59-4d99-1072-08dc11e09cbe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IK/FKAHbPXIfDEbw2o0H6fxY0JwJ83+UJ/xjdV8eixfbxy/HLriAMWRcHaz7fiSW57IpUO+/kH6PLNRvx+wnHSi20jGMgK0lbDCN4+Aa3q2l+7WZOLGtJyMAGUlHrXZhZH9wrOsWHdJAdhbZYDgmG934Weg6NAPa1FqbHMA6XcGuYoJyAk2Zh8ZSV0SQjhFcKMz5Ftt9aX0xhyMaQkqdrPGNN6yUnizWe9w2sA4+Q7V5J0hfjIYcvyfZPTfsNo2hrEwGe2S4QbchJE23C64SfWsHzZ8pJnSEGBhighr2SIpRoNdqKNSRNPgPWipjBCmf4VpJIHYlG8u1QxgebidQz/ZBWhWmVNTheeP9CPJitepk6AULYlCVeM3VSikkIgcC0vc5q4eMumHniDytRbKos+KsNmQuJZlVLEpHtK4n5GDRFBnxAEOCoqCr9uqXCZysQFf/FGwqsCDy6l1oTF9Zphh++dHl8Oc4nEsz0kNXgE+iR3QpRjXEJMmynwsXjDtDKEcy4qE7cRawQ+xSR6NPTL6xM4CuVrr7iCZ+bQFoBULUzbeiXXjh78SElABtQ28g0cEuoRGIp7uz5POWaCGlDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(107886003)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrbUYTYvpKMo2+TttEdIKIZOtnvXAYbhv+wduPONwx+wgVH+o524Kbay68tu?=
 =?us-ascii?Q?s5GS8A471VzSf/SXQ5BQCxBu5pDbS+x3hwdReKAsJBPtwh5xHQwZjNh9TNML?=
 =?us-ascii?Q?V1DZz60a8MHgyrqk9+zet9Dh0zSkchHdc0IQAJ/WwtAwqh0SBcJBH/LRf9f+?=
 =?us-ascii?Q?VROuiNB6lU29Bk3sg70bIat3W5ivgtE9alUwqiOjftOiD/oxkm9gcipK2EKh?=
 =?us-ascii?Q?lYlLokYiVfecixL1RlJgEtH2rtioy079Co38YJy2NhIdZZ41eYetZecvg9Q9?=
 =?us-ascii?Q?tQuw6mSdQ9Vpm4DxAnna7agUfYnAShjVsmW94LXm/U33kAssYn5A1qG9KrVj?=
 =?us-ascii?Q?Zo+h4TzIBFvnia9dCr3TDWuhryhQckeSW/WupmIho0cl0VdLmwSA9cmMSHNX?=
 =?us-ascii?Q?GUrY7ieHTQn3ylYLBR8sVUsLv9OenbnpmBneF3EVX7NeoPNLT7sk98eKjwyo?=
 =?us-ascii?Q?dlOf/yQVF4NRSYlfCsaW/KAsbesPVThUi4xiXAFS8CrD0i8I2XefF1c/vbPz?=
 =?us-ascii?Q?50Tt7Af659CyucQY85jcieT/sZ9PPFSBR91Nr2ML0ul4P2DPY6BrH+a5tV1/?=
 =?us-ascii?Q?YgMsVlR/Duj0zab7nvlsIPKAVlrU7cQc3A76HTJUu3B8e1Tc7eCwQMOMPUYS?=
 =?us-ascii?Q?LcSqHTAQGDLjvPgG8V4CkrgwWr0o4EqhL+IERo3h5vnFVU0igpPhBc5UA/RN?=
 =?us-ascii?Q?/FDJWztIgKEk40bBpEQ3AgFhQ4uOAP6J5Uf1hL6x/mv+JFU1UdMs70V5q94N?=
 =?us-ascii?Q?4V9ruRsyhLUlkp4V3oOuiO3DdVCR6FdsKXNt/Bh0lL+PuuhhB7g+jqKSrpee?=
 =?us-ascii?Q?gs2MdhrF7MCNHGRVCSgh/lBFydq5Q0SM+IFkxmPxOWTwGB33b0UuBkkWqRb+?=
 =?us-ascii?Q?1efdFHdGLBtfK6bWM9u2WeXQJP7sEGgBrF9P4QS1qJm0sSxzu+pZtxuxAb5o?=
 =?us-ascii?Q?wKERzPCyDrZM0vrcSjJFg1zggOQzkLBVdr93BHDFmn89mHYonMxfnYYcKvuh?=
 =?us-ascii?Q?+1JtWTq7hM8UoIahlSTpsq5AQks7ApFyDPdBybzzt6H7j1vG0uK9NLMB7b4c?=
 =?us-ascii?Q?GmN/Y5gR8ywifyovo16I/DtsgIu77BzJwSY6PwWEeACUqlNX+iJTkNALXE+k?=
 =?us-ascii?Q?aJefKECeTjoR8q/3Q1M8O13p/JhvHw7l0zbzdlhrmsSARySotEitCiJleEP6?=
 =?us-ascii?Q?+r3zI9C/KMXQTNWNuKMmX9Wx8dBhwPajmemsWSopThdz6LfUl6SNdyWamBz7?=
 =?us-ascii?Q?4JF5I9rqtTrdrJFG6vn3P0Q7c29kRXf+GPwq8Q1UoYd7TUZZYa9LikwH/Qp8?=
 =?us-ascii?Q?kGDQtFrcpoT5cf1Mz5MHISLlmNbuobafxkFqa3lG7u4fZ/EoobAR+x1VIptx?=
 =?us-ascii?Q?I0cZD+bvQQNn1WfA8TeDGqtUfKw8u7FXXrg0ODVV/HohNJZgJ2lBf6XEoWmB?=
 =?us-ascii?Q?b2hHNbzryz95TMtdFQnpOsImspu2JoUrTEPPNFnceNMJYnFTZnIsmCCDtfqu?=
 =?us-ascii?Q?7Bg9osYrLtMP12+D5DM7fPHkdYZPrHJmDDbRe7S98XtmNUAkoA4EK474S5dC?=
 =?us-ascii?Q?WU9hR7JqBvMNCod7rsZJgKN2nTh/SIayG7PXpKid09hHYG99jw3HYocyc8py?=
 =?us-ascii?Q?gPfS2D/tj8v8NB2v/r4AUf0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f06df8-1f59-4d99-1072-08dc11e09cbe
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:38.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riynAunmpxO78lkCC2f00nG9127gQC23hyCnUm6KAmrzRD9FZWo5UlvHZyBfnTWOMJUxUzAIVeqSqpMeKMVafsS1Td2/RQQrfTagsp88j2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add auxiliary reset driver to support StarFive JH8100 SoC.

Co-developed-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                   |   7 ++
 drivers/reset/starfive/Kconfig                |   8 ++
 drivers/reset/starfive/Makefile               |   2 +
 .../reset/starfive/reset-starfive-jh8100.c    | 108 ++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100644 drivers/reset/starfive/reset-starfive-jh8100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c5d563594e34..d74cb78cbb90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20738,6 +20738,13 @@ F:	Documentation/devicetree/bindings/clock/starfive,jh81*.yaml
 F:	drivers/clk/starfive/clk-starfive-jh81*
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
index 000000000000..a14418653608
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jh8100.c
@@ -0,0 +1,108 @@
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
+#define JH8100_SYSRST_NUM_RESETS	(JH8100_SYSRST_HD_AUDIO + 1)
+#define JH8100_NWRST_NUM_RESETS		(JH8100_NWRST_MERAK1_TVSENSOR + 1)
+#define JH8100_NERST_NUM_RESETS		(JH8100_NERST_DUBHE_TVSENSOR + 1)
+#define JH8100_SWRST_NUM_RESETS		(JH8100_SWRST_DDR_TVSENSOR + 1)
+#define JH8100_AONRST_NUM_RESETS	(JH8100_AONRST_IRQ_CTRL + 1)
+
+struct jh8100_reset_info {
+	unsigned int nr_resets;
+	unsigned int assert_offset;
+	unsigned int status_offset;
+};
+
+static const struct jh8100_reset_info jh8100_sys_info = {
+	.nr_resets = JH8100_SYSRST_NUM_RESETS,
+	.assert_offset = 0x1B4,
+	.status_offset = 0x1B8,
+};
+
+static const struct jh8100_reset_info jh8100_sys_nw_info = {
+	.nr_resets = JH8100_NWRST_NUM_RESETS,
+	.assert_offset = 0xA4,
+	.status_offset = 0xA8,
+};
+
+static const struct jh8100_reset_info jh8100_sys_ne_info = {
+	.nr_resets = JH8100_NERST_NUM_RESETS,
+	.assert_offset = 0x2BC,
+	.status_offset = 0x2C4,
+};
+
+static const struct jh8100_reset_info jh8100_sys_sw_info = {
+	.nr_resets = JH8100_SWRST_NUM_RESETS,
+	.assert_offset = 0x28,
+	.status_offset = 0x2C,
+};
+
+static const struct jh8100_reset_info jh8100_aon_info = {
+	.nr_resets = JH8100_AONRST_NUM_RESETS,
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
+		.name = "clk_starfive_jh8100_sys.rst-sys",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_info,
+	},
+	{
+		.name = "clk_starfive_jh8100_sys.rst-nw",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_nw_info,
+	},
+	{
+		.name = "clk_starfive_jh8100_sys.rst-ne",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_ne_info,
+	},
+	{
+		.name = "clk_starfive_jh8100_sys.rst-sw",
+		.driver_data = (kernel_ulong_t)&jh8100_sys_sw_info,
+	},
+	{
+		.name = "clk_starfive_jh8100_sys.rst-aon",
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


