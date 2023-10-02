Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D783A7B5B77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbjJBTly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbjJBTlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:41:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2228.outbound.protection.outlook.com [52.100.0.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D735A9;
        Mon,  2 Oct 2023 12:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiZNzBpngPjVe7Cnowt/x6tWW44gLSFrSRR8/0OXiewFmr2OarPVNlr2p1aCGwpQ9jeB37+fbB/1gZEYssY3ign+Jo6Vn5/55gcUTQaMtL4kp6AKXdQo9R2ErEg+ym4V3ZN57alPZZ2jJhjwWNrV4icj16k0+pIK4q6mY4mPOI6+scesOXBcG9vmCumAdooRH8soBKXkSKydfujfV+9frH1p2eUxLKsxWbWWlJptNJZNONx/ulhv6W3wF6yWzdcpTXcjxs8Cg6hqvXjKuiZ1EzLA2zK1AIdSecXnRsMRWVOAyAqa3qETlZDVB0mArPjdVyuf3hKGPtpFIfLxXuQEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj+QuVNTs3oG/87Dd2sZlBhijGZuBp+vHV9rd+xrPAM=;
 b=Tw8iTj+14BzbiVuyy6Wi/Q/UUbsAwgrgd2cPWUgiEGewFioSyrF1wr/SBpwEGL1zm3x3LMz6nqbnZ6uzeErCD3SRdHhiHLWR9lro2Pv79FZtTw0epP6ywvOOQqPAtVyOS7nyNpLJkKDOr/7NPht0rLikJzLR6V7fcIIqMSdnBvwL2Vqe7YX0LTH6lNOy6MfduE82ox3S4cl7Ykva66bnex0I2pq9nS5QPiPePhOhJo6hkvhR9vZ1BKIAFCT5ZfBI1WhLv4K8c8Y4EztLO6KfnQzNH+4zpRcpITf8elnatI/nlxXwmSz5iFAravavk4XVJn1ziSe9kTrD8Et1quTftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj+QuVNTs3oG/87Dd2sZlBhijGZuBp+vHV9rd+xrPAM=;
 b=kr56qvnEqkrgp/kMIOllXnHScceN9Oqr/DdmmPcXYJID7/L5P1k37n95KMFyD7/hYNaFPpc7s5uTN8YPDnD0Rkn1RaJNwZfxYl21mt7t8ayjp154ThFStklXUK2tc4/6SWgNBCl4N43niLqFpSUS00IDN8MyoG2/HPIpGiI5J7s=
Received: from SG2PR04CA0213.apcprd04.prod.outlook.com (2603:1096:4:187::11)
 by TY0PR03MB6449.apcprd03.prod.outlook.com (2603:1096:400:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 2 Oct
 2023 19:41:43 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::62) by SG2PR04CA0213.outlook.office365.com
 (2603:1096:4:187::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 19:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 19:41:42 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 03:41:42 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 03:41:42 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 03:41:41 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id D8DE264742; Mon,  2 Oct 2023 22:41:40 +0300 (IDT)
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
Subject: [PATCH v4 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
Date:   Mon, 2 Oct 2023 22:41:38 +0300
Message-ID: <20231002194138.125349-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002194138.125349-1-tmaimon77@gmail.com>
References: <20231002194138.125349-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|TY0PR03MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 7373d67c-23aa-4823-0e8e-08dbc37f9ae2
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H6hjOMoTp0MDmpRgOHt+6L6S46MkUEhYI5Mpgs43LxvlciFgCbsN8Jbo2X9o?=
 =?us-ascii?Q?zAqJb9n2K2c0I1t9fBNTkZQQtthJwau42nBCPx0vZfbUUiLbZZAtP0tOfKXD?=
 =?us-ascii?Q?+jcz59suckW/vJgy0k1E3VHvxEXSjZMprTLYBzvYN8+chYqWeZfU+dG/wN2F?=
 =?us-ascii?Q?fwptEfMQQJT1IzJq/+NOtnf/5RLm5aR/LWcsAmqNGWl3OiTDQwH8EVke30Ig?=
 =?us-ascii?Q?lySUS77BNVMmIQWXTibupBuLOIQ2BffQiB8EHKC0hxKgGJ7yqsGyFMJa0p59?=
 =?us-ascii?Q?E0b6Dei0mD0Q75A4wBLqEkmylip/SymPqzeXNDE1H68rYsbihHWNPcPuN5mL?=
 =?us-ascii?Q?m2R0rZegWn4NaQpUBnJ/Gi4beujZu2a5Iqi+ehrfF04vk5jCxgouYWxlkGve?=
 =?us-ascii?Q?m/BDg+QI1wfV8Va3tBR9ZO44ZINpoP07X0jPMxom0Zxsy1nJY7g/tB42UdJZ?=
 =?us-ascii?Q?ryzDu2TuuvZmCZl+eJG0A0+7gB4QOwh/5V6hw2LPqqy3MlH5DXeUp0JR7VN4?=
 =?us-ascii?Q?qPX5mSgb3xr5ljzNVD+xF0nlmwLb50cnViTJLi77AgsDSCkzIFazJHn15nuM?=
 =?us-ascii?Q?NbS3yjJQ3JEBQ/zV0UU76ytW6CUb03djLwzAry/1VZoQabu6wHNoS4E+G7nd?=
 =?us-ascii?Q?0Dx1VmiEI4BgsxsLOQbJdvxuT4soDPuZkvxLIaF+OsxWv/hQT6DgMY/bQ9IM?=
 =?us-ascii?Q?mjjEGAxVouvBNiVoLkdJQ/nxoJ5PTv5ymCyV3uBFYHi5SfC4VxHlF62wKZXS?=
 =?us-ascii?Q?bPO+uNt2rqMLig0XlXFTVijOyoXSOmsboUrzr83jnv6PpBJyfo/1SZsriyl9?=
 =?us-ascii?Q?MINDdyPM90iFh+gG+icH3ilpmzurwYmoWNrQdGBglMUOA+9xvGBmWlEIPTug?=
 =?us-ascii?Q?KkJT9xgzsE7AWO4WZTnWBy3BKi2QD3vUP2CJ0AMut9o3wGqZAlsZEp3SSR62?=
 =?us-ascii?Q?jaaZVVbBr61FdSFUH/DRHlM38eERhXqm5hMBbtz7qq8=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(48200799006)(186009)(451199024)(5400799018)(64100799003)(61400799006)(82310400011)(40470700004)(36840700001)(46966006)(83170400001)(40460700003)(76482006)(110136005)(73392003)(1076003)(2616005)(82202003)(336012)(6266002)(8676002)(26005)(36860700001)(42882007)(34020700004)(2906002)(5660300002)(47076005)(81166007)(8936002)(7416002)(4326008)(478600001)(54906003)(70206006)(41300700001)(70586007)(316002)(6636002)(42186006)(55446002)(356005)(82740400003)(40480700001)(921005)(36756003)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:41:42.8732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7373d67c-23aa-4823-0e8e-08dbc37f9ae2
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6449
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
 drivers/mmc/host/sdhci-npcm.c | 96 +++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
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
index 000000000000..73bf6f3fbcc0
--- /dev/null
+++ b/drivers/mmc/host/sdhci-npcm.c
@@ -0,0 +1,96 @@
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

