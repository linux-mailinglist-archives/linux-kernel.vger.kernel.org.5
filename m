Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C766C752093
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjGML5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjGML5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:57:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7009D2715;
        Thu, 13 Jul 2023 04:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxlXNQnWD8wXt12M/zQu5ctXB5gg+DShnbVzSzrsd8K0MIhCYEipfs7BliB+JZSj5kdocE/8E26Fyeo0xWq7zIWGp9G8eZNj+2PFtUVzy4DlON00gmNJCvzV5C2O/fms+S4VR/qpTH6Jv/IXTiDU4ZXPzZsJlKl4yg4EF7jUN9HCTVr2T4Z0YMajQ6E+vSQw3o5/oNu5ZSS6p/lTSrqGkVQva0yJQFCJ6iM/w6Bb7kiK3TRLsWWB7iAzb1KW4ft7TFjBWhwJbztqPStVgAl/dQZ/kNo3OZIvrQxKQ6kVTMqdsY4QZTA0VMiy1nMcvelQmlZjXcm7YVUZcWcEH7HN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzygF6itKHUQzD48/rkMZtcSdaE9lX6nfqG44bmkTOY=;
 b=geplGJJxfSAwmvI4Qqd14BZ0mO7DFxyxBcTKepqQsT16+H8LscnjQGQ8d2n8sKFUZ6Ek1iwZfjT9V9cwTML38tjAbuIPEhjTOYYXkdGU1S48dFGb+8FvrS9MbIQjLPwv2KvA/vIRd41IG8mMVWDoIuWt+ggCZ5/Rb8F8/QDntZD5+RSHLYAAtUShNIfK9gUAO7zsB43hbfJQIS0VkoccfgTF09bwPWi8U6/kXNNOQHevJw3wFhlfrZQwVSBqgA4SHMAPQb81ltwLHsJiqNP+bY2cSlWX5MOK+8KZxmpMlgO9Ku3Q7A7N81Ndxdm552TuXDict5sQNPzJmwhEF7Pv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzygF6itKHUQzD48/rkMZtcSdaE9lX6nfqG44bmkTOY=;
 b=zCBlRRLC3Ier0Ily8nmSTxi605e4fF1CKP9W0IAWb5/lf6YDSy7EeGh5hyVrbhJeWS9M9afxLWAK3KZ5l3FlGqdMnsmsAbu9C6cszsWFEtQk0zzGsvfZkM5jYcRvckQSgBkhQde6Z6afGE+kOfnP9daO3t8GkVg96pwzD4U7lnfTOi7EjuVXZUmXBr1UnB+2fAIHlaVdn0NmlX4t9wCPraLVJxMQ/CPCH5WjTtmmBhrl5Bao7N8TI2w6U+yVyVdm84/S6AjjKqOl6aBvuWcTYB5tdKgrGmYVruZQaF38yQRT/lNS15dURNvnjf0sZzAiJp8l+vzOpDthSJN4wMGvtQ==
Received: from DB7PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:10:72::32)
 by DB9PR10MB5503.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:306::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 11:56:52 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:72:cafe::ec) by DB7PR03CA0091.outlook.office365.com
 (2603:10a6:10:72::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 11:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 11:56:51 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 13:56:51 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.128) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Jul 2023 13:56:50 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        "xingtong . wu" <xingtong.wu@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 2/2] leds: simatic-ipc-leds-gpio: add Elkhart Lake version
Date:   Thu, 13 Jul 2023 13:56:39 +0200
Message-ID: <20230713115639.16419-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713115639.16419-1-henning.schild@siemens.com>
References: <20230713115639.16419-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.128]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT055:EE_|DB9PR10MB5503:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e4dc43-fde7-4ae1-b3eb-08db83983ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4EfetF0T2MPcKCYA6l/CU7LtJEQWkWUJIOU8F8xH4NhcucJsFnpL3ZqTPsDJf/ClBvYvOCGBlyjgxXNlyNgsRGfPatH3lmg9WDR5K2giEZZx2D5oxKIs0jCYecreQidH5MhXZ3S1jm5nL12sDWqaqSyzfD+ngg5zCfceJeHo7vU1m6Aw+zV8q/HIv3ClydG+aoP7q25RQ+LRYq34xRNuoxZ0bRcjAZA3CW6RnRP3tZSXk+Sqst24CTiDuyK7Eu6WZwMG0Tg2QZYghp9LjK9zRExxqxmDSadjYDLGoKS93f2gCi7UrjLWMR/U0vGzgYPyE9Ki9yYgHUexZTSdDHWb/14H6qaXHeseQmMfzKuZFVIaFuFftAL0INy3lChofPTEB6CmFQxWBPDzfWxTHvwEHguyNTqtiLf9Zc8F4IT4l06D3Yg4YoMnWv+68dpbwItQOW12nGKepJtgMv05HaySmAa/KCp/piwWM+Th/WnYc8GS8jJo7solGZuy+GC3wiGcyNmVwdzBlxsXqCmbd31Q9sVTpHZrXwfgiZW4BwOzOvFjFk7WAO2RNWy48wg3fV0hoa9KStQgRI6IGq+suohSCj/Vi3vNB4Aut4FCg+gBM18FVnuvw1nOJPTIZ97l0MTbE2HpC4RWeSIra1rv+q3nSSmbNOn8le82e8894Rigbt7sELir8Qr9SgTqtw5+DgO4V72cU84dJ1iwAD7FcwBFGBqh1LI1jShZwyiCvGTNwhAcn5FdG/DnCM41Fe7uv8Y
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(44832011)(70206006)(4326008)(70586007)(316002)(41300700001)(2906002)(478600001)(8936002)(8676002)(5660300002)(110136005)(54906003)(36860700001)(6666004)(40460700003)(1076003)(40480700001)(107886003)(26005)(186003)(16526019)(36756003)(336012)(47076005)(82740400003)(82960400001)(7596003)(7636003)(356005)(86362001)(2616005)(82310400005)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:56:51.7251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e4dc43-fde7-4ae1-b3eb-08db83983ef9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5503
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used for the Siemens Simatic IPC BX-21A, which has its LEDs
connected to GPIOs provided by the Intel Elkhart Lake pinctrl driver.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig                   | 13 +++++
 drivers/leds/simple/Makefile                  |  1 +
 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  4 ++
 .../simatic-ipc-leds-gpio-elkhartlake.c       | 57 +++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 44fa0f93cb3b..626ab18ac09d 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -34,3 +34,16 @@ config LEDS_SIEMENS_SIMATIC_IPC_F7188X
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called simatic-ipc-leds-gpio-f7188x.
+
+config LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE
+	tristate "LED driver for Siemens Simatic IPCs based on Intel Elkhart Lake GPIO"
+	depends on LEDS_GPIO
+	depends on PINCTRL_ELKHARTLAKE
+	depends on SIEMENS_SIMATIC_IPC
+	default LEDS_SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens based on Elkhart Lake GPIO i.e. BX-21A.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds-gpio-elkhartlake.
diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index e3e840cea275..783578f11bb0 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+= simatic-ipc-leds.o
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE)	+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-elkhartlake.o
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
index 2a21b663df87..c552ea73ed9d 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
@@ -57,6 +57,7 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_127E:
 	case SIMATIC_IPC_DEVICE_227G:
+	case SIMATIC_IPC_DEVICE_BX_21A:
 		break;
 	default:
 		return -ENODEV;
@@ -72,6 +73,9 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
 		goto out;
 	}
 
+	if (!table_extra)
+		return 0;
+
 	table_extra->dev_id = dev_name(dev);
 	gpiod_add_lookup_table(table_extra);
 
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c b/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
new file mode 100644
index 000000000000..6ba21dbb3ba0
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Author:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#include "simatic-ipc-leds-gpio.h"
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("INTC1020:04", 72, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:04", 77, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:04", 78, NULL, 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:04", 58, NULL, 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:04", 60, NULL, 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1020:04", 62, NULL, 5, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	},
+};
+
+static int simatic_ipc_leds_gpio_elkhartlake_probe(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
+					   NULL);
+}
+
+static int simatic_ipc_leds_gpio_elkhartlake_remove(struct platform_device *pdev)
+{
+	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
+					    NULL);
+}
+
+static struct platform_driver simatic_ipc_led_gpio_elkhartlake_driver = {
+	.probe = simatic_ipc_leds_gpio_elkhartlake_probe,
+	.remove = simatic_ipc_leds_gpio_elkhartlake_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+module_platform_driver(simatic_ipc_led_gpio_elkhartlake_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core platform:elkhartlake-pinctrl");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
-- 
2.41.0

