Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0167B59D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbjJBRvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjJBRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:51:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2240.outbound.protection.outlook.com [52.100.164.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB6EE1;
        Mon,  2 Oct 2023 10:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPFGyhGmFlNLjjw0PtZzDxS/9UR5cOap0RrWGq3PNCR727X3ctjbbEIBmcgiPU+9GllOdwWq/3BVuw5xEUsoiiwUblxHEB8mXBnFeE9MTsmSgHVSLLiaQM4oIgCImVwqv+W6rVB7o+oOm9Kja+6XRvgR+OhHd9XPRw4X7hcmo3RjErA81zGnNcwpXr0pLXmXg0jhOe+bfc72+oXra0/5O8mal7PYL7yWlODKgWzrFbYQWNgVMBlrxIQg0yqumvDTTdeUgWkiT91hVoKa++gNqgSAjstkxl8Zj+qKH3zNJIeGi4SQUX2PAdgnTwZuya+XePm6cD28AN49uAxf/gYeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNdCNyEyfuQDtFJE3Cjrvnh7+4h91mtJqxr4SvCDxU8=;
 b=aphAqqrW4VFfBH09RlRGKMQJKVDo65qHng7MFKwVHRURPA7BL6sCUTuFnf32YaFQ6TQLoKFs+qZmTrC2ixdvnR8DMyZtSYRX6WgNtMRDeQf+HY4lj2AV1AnKFb5F7pAsp/lkMEZMuT+3DqfTWhLY0wywNE/7MW9ZIziMCFUym1jIi3/2TN6WKNA7xku3k4dioS9CxmNu90uPELhx4ngdBQS8w9eA2dgPtyyff9INDdx9pVnalu9LdPfEFIbkL0N4qd80btz0NnSYbpS6pxvvj8TND6DtFZw/Ciiqr00mYjmDPYEsmoezse8XRnHZ40v3eps4zMtwM4sY0OQDWy4i2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNdCNyEyfuQDtFJE3Cjrvnh7+4h91mtJqxr4SvCDxU8=;
 b=fRVO3goujv4a/QqVzN/gLslmlpXOuK5wM6KtzOPxgGIZ2uc4GOwfa81uIGe8qwr+KJcgtalf89nsop1XsTjDNtPIBnflF9M3QmdDXXyuR9Cf5esaZnojsRvG3UNwz1dgCZpOXmv9HnSHXcA9witBivHn6j3f5DRjYrXAmWi6hrg=
Received: from SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) by SEZPR03MB8184.apcprd03.prod.outlook.com
 (2603:1096:101:19f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 17:51:00 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:193:cafe::3b) by SI2PR01CA0047.outlook.office365.com
 (2603:1096:4:193::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Mon, 2 Oct 2023 17:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 17:50:59 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 01:50:57 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 01:50:56 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 01:50:56 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id BBFDE64742; Mon,  2 Oct 2023 20:50:55 +0300 (IDT)
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
Subject: [PATCH v3 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Date:   Mon, 2 Oct 2023 20:50:52 +0300
Message-ID: <20231002175052.112406-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002175052.112406-1-tmaimon77@gmail.com>
References: <20231002175052.112406-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEZPR03MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 493b3bc1-0c9a-49af-6aa5-08dbc37022e2
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ntk3xqhcErfoMkyK/9L3bCLRm4E0dxVt4qAVcXjlZDQWZ6Ek020qRAQXaNiy?=
 =?us-ascii?Q?hocGFTTezJi0Fuu4/+M4aT8DXN+NpIx5Eulq+rA1ZZWcUGllqcqvXbL3JJ5p?=
 =?us-ascii?Q?PaTbzC6uV2IfW+hdzyQd8NRM5tgORIKR6SkckgPbe6BReaQaDqWsWKOImQCc?=
 =?us-ascii?Q?VtQoF0F0qLvJ5cupgzozzaD2bUh3GLDmA/+TFZumOicZR1dkwnnWtYYsGnY8?=
 =?us-ascii?Q?lDoBCjwUgEDq6XWEcJgslBHTvtaiFW14K2Zy2SuS/j5rfxBLKxwxZT/37kjz?=
 =?us-ascii?Q?fAzFuiIu2jIOqqn63WpIGxuH8IZbgPmcMppKzrJ8E4dyD/VFmgvwMKFfco7M?=
 =?us-ascii?Q?8PxWyN776mVV4N6odYqyjltnATi1r+eIvY8deyebrHaOxq+rc6A+CoaNgo+g?=
 =?us-ascii?Q?FZu2y4Z2PY41zrKumEiZy1lBv2HOx7Gh4bJSARFR0Xk02ES5QEo0Gibrvlob?=
 =?us-ascii?Q?KUP7c12jWFR1uwKJnItLHwPCIUYMRHQ0Ei9rYsbya7FlrMPTs6Sg24Q5b5oG?=
 =?us-ascii?Q?2woDKJuXhijxRbFI7vQbLgKREv9E4EJob1+ns5YelJch5db+PYBObVHX9Oyk?=
 =?us-ascii?Q?CutyQo/5CGz6qPF3V9eDupFFM5Arfpl0YXGfUtxkUsX8XTSoWhcc9yvESXzF?=
 =?us-ascii?Q?bf4jIAC/+Nx0pKf5/s+bkX0bX48qS9rSAlY96grxTQC+DyFRG2zoBXePC0cm?=
 =?us-ascii?Q?qK3hMP/fbb+sLXqj/HPbbT/9vb0sXZIEFmyx4BEUtvZ7fvYGu20QZ8yvy+V1?=
 =?us-ascii?Q?i1ZRl+U0SpYuZedV50IzdERJhSrLbiCvNGiJrBTOAz0a7IOL5BVgZhDNuBmo?=
 =?us-ascii?Q?4OnxRAfDKOrtgvSq0s+oOz0z57A3lh64LrS2Jg6C0OxE9wWqKsFRUtvOfaqg?=
 =?us-ascii?Q?+YdkziI4wyR50NdgAwiDCkZvn9hE5d3rlcTKY3tYt99G2/DDX3o/Y179jXAA?=
 =?us-ascii?Q?18ca9oqUQaun+6DhSuooJ1dVic+z7d6dfJjk1F+TbaM=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(48200799006)(451199024)(61400799006)(5400799018)(36840700001)(46966006)(40470700004)(8676002)(34020700004)(42882007)(40460700003)(55446002)(76482006)(2906002)(6266002)(6666004)(81166007)(5660300002)(921005)(36756003)(73392003)(478600001)(82740400003)(47076005)(356005)(40480700001)(83170400001)(4326008)(8936002)(1076003)(2616005)(82202003)(36860700001)(41300700001)(336012)(110136005)(26005)(70206006)(54906003)(6636002)(7416002)(42186006)(316002)(70586007)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:50:59.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493b3bc1-0c9a-49af-6aa5-08dbc37022e2
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8184
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
 drivers/mmc/host/sdhci-npcm.c | 99 +++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
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
index 000000000000..59ccadb05aa2
--- /dev/null
+++ b/drivers/mmc/host/sdhci-npcm.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NPCM SDHC MMC host controller driver.
+ *
+ * Copyright (c) 2020 Nuvoton Technology corporation.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
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
+	pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(pltfm_host->clk)) {
+		ret = PTR_ERR(pltfm_host->clk);
+		goto err_sdhci;
+	}
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		goto err_sdhci;
+
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (caps & SDHCI_CAN_DO_8BIT)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err_sdhci_clk;
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_sdhci_clk;
+
+	return 0;
+
+err_sdhci_clk:
+	clk_disable_unprepare(pltfm_host->clk);
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

