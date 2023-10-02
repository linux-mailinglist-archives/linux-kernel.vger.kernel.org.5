Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3C7B5BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjJBUGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJBUGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:06:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2220.outbound.protection.outlook.com [52.100.0.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73715B3;
        Mon,  2 Oct 2023 13:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9In1i08rOqIdRiyancrNynRFrbawjwZo3wetvG5bazoepqb0/WIterq0mmrLXdRiIaIAHiCGhIBpdfevmGS+6Q8lsucTw2n1qokDWdR+QXqNV1BisHcz96vH2dd2oe7COXlmIvfVcnHsf23IqN0BlvFb2extes4JrtQDNU9SzgXdk7wF7rnMg1bK3P9fPNWegH7HpifKZtNfs24Cw9HVVL6WrncbYIWjbaK91yP70mqU3Fi06i/M6Np0vMmdyrSTywelJJVFg/NZyzGP8ub1CGDYBjlVxwd4XLwYPXWS/O1cVhnZ76DPRqtaK6kT28YUnYqA4fBaAmuae/UhOdSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjs+CzyHENhNVIjt8JxPtm/DTB6YeEj6WaFm1IJxGZo=;
 b=cETh+Wow3INyLp6fgaOwYSFBzGXD+YfRRdlj5tP/BeiQWWEzY7OLUH8QSuD9J4b6HUd97IyAKQStE0A1XP2IFysOoVofe158+ZwzyF9mhF5FPalUMqW5agLZVOuWszMPlxsDQzzTmIg43aACb+mTjsJoWdCiynRazzW6ZnOXxn/YsMpgZPcYoVr7h/xrXpUN0VlD68LSdSu6XfOTy8GZXXmnpkpgFZzKb6bEiMZHcvQ2TSQNWGt4JhBv/uOR0WvGsaKZJFnwjv5SXR8nhfc2SQqqAWQkSPQ9GAjh0Ve2NwnNg2zJktw3mssFgHGDOAqvMdyN/eMoFfS/9b1wlvUdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjs+CzyHENhNVIjt8JxPtm/DTB6YeEj6WaFm1IJxGZo=;
 b=jrzk20Sv8KURU9MiUtD+sVSpecF+5Xz+34uFYzbyUZ8hHhr9xI2w2oJMQq6MQt/z1VJ/jeyhvm207QOLhxNICG3BZyNkc0254KPovxgcMEoI6OHXU3y96MhG6pHPDhgOgveWQ0lPp5Ygd0ZWzMwOmrfjhlruM7NlOZA4BE5Zgw8=
Received: from KU1PR03CA0039.apcprd03.prod.outlook.com (2603:1096:802:19::27)
 by TY0PR03MB8329.apcprd03.prod.outlook.com (2603:1096:405:19::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Mon, 2 Oct
 2023 20:06:17 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:802:19:cafe::1e) by KU1PR03CA0039.outlook.office365.com
 (2603:1096:802:19::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.23 via Frontend
 Transport; Mon, 2 Oct 2023 20:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 20:06:16 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 04:06:15 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 04:06:14 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 04:06:14 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5F45B64742; Mon,  2 Oct 2023 23:06:13 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <ulf.hansson@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <adrian.hunter@intel.com>, <skhan@linuxfoundation.org>,
        <davidgow@google.com>, <pbrobinson@gmail.com>, <gsomlo@gmail.com>,
        <briannorris@chromium.org>, <arnd@arndb.de>,
        <krakoczy@antmicro.com>, <andy.shevchenko@gmail.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Date:   Mon, 2 Oct 2023 23:06:10 +0300
Message-ID: <20231002200610.129799-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002200610.129799-1-tmaimon77@gmail.com>
References: <20231002200610.129799-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TY0PR03MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ab0702-6bda-48c1-2dca-08dbc383096d
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B4CEZ0z8wSrt76QXBY6GafHLuzBllvvDgT4/igLKOaR+Fqjk8xFVuQ7+97JT?=
 =?us-ascii?Q?x7TOqIC+F+/E5Xi720l6HqzbIoMke5dam/mrAO3WXVVHjFyvn7Uj/rcsMKyv?=
 =?us-ascii?Q?gh6vaZnOaIoyB03EG7QaPSfTUIRk+Lcglk+WkyqitIim3zR7Z7BPYbac9Be0?=
 =?us-ascii?Q?E4wqlROrRIj2mkSTZE2O3cGiOd/7HYkwaTwroSjYkZf6canqU+XpzYCZnCCe?=
 =?us-ascii?Q?d+oqK5h906gK/EZTzYBXYHiZHa6pBv4XP1FIRycM4CVKvnX3AS0qZmL5iMfU?=
 =?us-ascii?Q?EEquJjYcVVqk+ZuE55yLLIHRdgi8RELBiLhOSOmhoY2Va9WgiWtVnP2jxZ5j?=
 =?us-ascii?Q?TffkZunyQu4Cde892XopBijpicj4303P+RveDyJHW9kuWfVI++wAQWYpLUtY?=
 =?us-ascii?Q?SANxhm1bgpG6HBCT2yyjRDh4DWRkhIt/kGzZk8oYGgXThjCsiS2jnsO/3RkY?=
 =?us-ascii?Q?e8G7N3QQIV7jtHmvK3VNenjuTUB/rti5igHAkl85c2jLUzCS82k6w5YAN2QL?=
 =?us-ascii?Q?IPOsfTogBlH3GZraAD5ybuZ1dsJNqe4Z3tPvnr6sg/NCodYVJOcUGESNajGG?=
 =?us-ascii?Q?5BbqO3o32B5L1XPOnv1ni/5Ax8cvZCfNk63FROiJ0aG0a3Zu6ZSlkjUCxA75?=
 =?us-ascii?Q?oZAuifZIj4n0fe+mQnV+/rEpNGn4xjMJuTOa5TOo5PV95Dku212H0eSX8Np3?=
 =?us-ascii?Q?S51qinkfYXnccszJDsVgAUZZOgfFo06nUZWcL81xyRmy+jFRBLWOSw3G5aCq?=
 =?us-ascii?Q?V7KNwrQSQbklo9/xMM9HaodGXqbSEN9jbU78M2SlRRzEOPNWaM7fbFLfHvgP?=
 =?us-ascii?Q?sXkqVqiuHcdmTAMrvGuVVG8AZ3ZMAFXNfj1VElkrtB3UD1JCWHE88SngVuq7?=
 =?us-ascii?Q?25SOKhH5VKYmkPHSEZGLtGxhUeKZHccpivd0AxBQSv2264kshcPR+J6hVWEF?=
 =?us-ascii?Q?RN5pwo8ct6usP6Xf3DC3tqVOOtnTLwnqe0vEr+oQVdE=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(61400799006)(186009)(451199024)(82310400011)(48200799006)(5400799018)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(356005)(921005)(1076003)(82740400003)(76482006)(26005)(41300700001)(36756003)(42882007)(73392003)(6266002)(336012)(2616005)(54906003)(82202003)(42186006)(70586007)(70206006)(83170400001)(6636002)(316002)(110136005)(40460700003)(478600001)(81166007)(7416002)(34020700004)(2906002)(47076005)(36860700001)(55446002)(8936002)(8676002)(4326008)(5660300002)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 20:06:16.8870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ab0702-6bda-48c1-2dca-08dbc383096d
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8329
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton NPCM BMC sdhci-pltfm controller driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/Kconfig      |  8 +++
 drivers/mmc/host/Makefile     |  1 +
 drivers/mmc/host/sdhci-npcm.c | 94 +++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-npcm.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 554e67103c1a..3999d4fddc73 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -429,6 +429,14 @@ config MMC_SDHCI_IPROC
 
 	  If unsure, say N.
 
+config MMC_SDHCI_NPCM
+	tristate "Secure Digital Host Controller Interface support for NPCM"
+	depends on ARCH_NPCM || COMPILE_TEST
+	depends on MMC_SDHCI_PLTFM
+	help
+	  This provides support for the SD/eMMC controller found in
+	  NPCM BMC family SoCs.
+
 config MMC_MESON_GX
 	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
 	depends on ARCH_MESON|| COMPILE_TEST
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index a693fa3d3f1c..d0be4465f3ec 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
 obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
+obj-$(CONFIG_MMC_SDHCI_NPCM)		+= sdhci-npcm.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
 obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
 obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
diff --git a/drivers/mmc/host/sdhci-npcm.c b/drivers/mmc/host/sdhci-npcm.c
new file mode 100644
index 000000000000..a3045dd2ddeb
--- /dev/null
+++ b/drivers/mmc/host/sdhci-npcm.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NPCM SDHC MMC host controller driver.
+ *
+ * Copyright (c) 2023 Nuvoton Technology corporation.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "sdhci-pltfm.h"
+
+static const struct sdhci_pltfm_data npcm7xx_sdhci_pdata = {
+	.quirks  = SDHCI_QUIRK_DELAY_AFTER_POWER,
+	.quirks2 = SDHCI_QUIRK2_STOP_WITH_TC |
+		   SDHCI_QUIRK2_NO_1_8_V,
+};
+
+static const struct sdhci_pltfm_data npcm8xx_sdhci_pdata = {
+	.quirks  = SDHCI_QUIRK_DELAY_AFTER_POWER,
+	.quirks2 = SDHCI_QUIRK2_STOP_WITH_TC,
+};
+
+static int npcm_sdhci_probe(struct platform_device *pdev)
+{
+	const struct sdhci_pltfm_data *data;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host;
+	u32 caps;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	host = sdhci_pltfm_init(pdev, data, 0);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+
+	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(pltfm_host->clk)) {
+		ret = PTR_ERR(pltfm_host->clk);
+		goto err_sdhci;
+	}
+
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (caps & SDHCI_CAN_DO_8BIT)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err_sdhci;
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_sdhci;
+
+	return 0;
+
+err_sdhci:
+	sdhci_pltfm_free(pdev);
+	return ret;
+}
+
+static const struct of_device_id npcm_sdhci_of_match[] = {
+	{ .compatible = "nuvoton,npcm750-sdhci", .data = &npcm7xx_sdhci_pdata, },
+	{ .compatible = "nuvoton,npcm845-sdhci", .data = &npcm8xx_sdhci_pdata, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, npcm_sdhci_of_match);
+
+static struct platform_driver npcm_sdhci_driver = {
+	.driver = {
+		.name	= "npcm-sdhci",
+		.of_match_table = npcm_sdhci_of_match,
+		.pm	= &sdhci_pltfm_pmops,
+	},
+	.probe		= npcm_sdhci_probe,
+	.remove_new	= sdhci_pltfm_remove,
+};
+module_platform_driver(npcm_sdhci_driver);
+
+MODULE_DESCRIPTION("NPCM Secure Digital Host Controller Interface driver");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL");
-- 
2.33.0

