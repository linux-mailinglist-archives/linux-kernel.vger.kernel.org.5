Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249CE7CCCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJQT7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbjJQT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:59:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC441ED;
        Tue, 17 Oct 2023 12:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvRB6VKrXQ5iDf0PMos6vqiZH1Axdlo9k293eGXJifgscxax0VZdPfbcAHrMcxPjebDxwoa8nYP7qRJEWyja1M5ugShlu/feyzfwV8x5qfmZvDgjVCHDTecjk3s/nRVgdXkGFZju3tuHHoARO3mZgrl52s3Cm5kl/OUZvDDOTa9Luz+p+askEKJqY1sDT9eOOHI4YhIex5Wipdp+iv/Y0nFqozen/1sysAjlv16tDoNqaAEmWYcsPIuVOTcy6yws1+HHGLRlIERdxIrx19nrII+OijuhqkQNN3pu3Pv3DAdc+A+hECuGeQvi2ItwPXDPFiCGi2zsFpYO/zRUjxLkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNRjPulufXFSaNHnufAyrwtCSIhKi2goE9YlsVSIbHI=;
 b=OZrWig57PjThiZMAJxUtoNHXDryY0YCX4EPWOxrMFpAwKA8PHUxuhkPqfxHRe5H5lX2/pVAkv6bEHQTmB/guRYt4EkIcAu1h2vnOLl0l14VST2Rg2my3Dle1+8P/jmtAilhA4DCqmJ4Kgc5ngj49FWgz7kOY2AV6t/3LVbddH42WRcgDka3P6sD9GqLYYLSMPbXlAxOB/Ea/3rF/gOnLmaHtZE5idXfwnZ3yxwj4Vt4PpJ/aBtAiIFfFh3+gE8wfjvYMa/1X4D0FHocgJR4z2yoRNIuErrP6ajPWh3azCmfTRIZH/dO29k/YgMgayTR5bMF4mgVbkjzWyQkItPGVjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNRjPulufXFSaNHnufAyrwtCSIhKi2goE9YlsVSIbHI=;
 b=pVw7krE0prKw2ebOaUqHZ1ssGZHIb80JviCmw2zuLz5DCu8pd1aKWOeFsz/6O935i4n0B3K3sso28e4ZiUEX2j3UsqsF0naRmjED899FnyrlsmZJyQ8XHH8P+12adL2ucMqTqwHKqxlzRAWzPZNE5HvzFJRh0KLSmFsRF0kdbvs=
Received: from KL1P15301CA0060.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::22)
 by SI2PR03MB6757.apcprd03.prod.outlook.com (2603:1096:4:1ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Tue, 17 Oct
 2023 19:59:27 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:820:3d:cafe::4) by KL1P15301CA0060.outlook.office365.com
 (2603:1096:820:3d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.3 via Frontend
 Transport; Tue, 17 Oct 2023 19:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 19:59:26 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 18
 Oct 2023 03:59:25 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 18 Oct
 2023 03:59:25 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 18 Oct 2023 03:59:25 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 4F90D68E43;
        Tue, 17 Oct 2023 22:59:24 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 42D1421CFCCF; Tue, 17 Oct 2023 22:59:24 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <xu.yang_2@nxp.com>, <peng.fan@nxp.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v7 3/3] usb: chipidea: Add support for NPCM
Date:   Tue, 17 Oct 2023 22:59:03 +0300
Message-ID: <20231017195903.1665260-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231017195903.1665260-1-tmaimon77@gmail.com>
References: <20231017195903.1665260-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|SI2PR03MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3460edd0-919c-4555-7ec9-08dbcf4b9121
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Anr+MLMwFEqWA0liQ+X9zck7e46yb/knNY8aduF07o3lPf2uXK3LXh/nUaBtPmsjfsO54vo34iU+0tOTP1NIB6H/gNzABTsm/wuBlvDQq3liRKVjmIoCcCk/2JPfGLsdLbq7vGvfHtFm8sd2mbR3rC3gmW+aJJzTn6nOJ9tPryUz4m/twwLgkYqyZB8gtXY1qkd1tQinKm/Xb8L5RfidZE34/9RcpxzwmCUiK6reiv10uVurFXz4tebfTks8ozzlEp5B8GRGy0nwN/msEHlwVoZSD+0dzViwovymUKvXTsUdRSnFfIDSvUE6D3IS4HFPjQto14aMZmWk+rDYiZcJyer+MwLoJZLp1sStWqLfad4E+crchUT8EEu+8a5khJ/CGt7oXxYXvW7cxcgMS+vNw8C0+u0DSTgVedF7pHTL/iHn/uCOU/uym98wWtxjqaR+IyLBu6+cw3jp4QqI6SN7bdhlCjNGAeWhe3mDrfikX0ghEO6GwF511aSbod81pyw8gwrhmaLA+C5HaKDTWKBMzjZW2K4CkUatLeEg4eSQMNgoAd8PNDZsQs8/2n6al4E/u5A+ZAIBmfDHyJI+Wd2MIlfj+PZq0Wkg2VULcv5QxXqVSp+ttZCSQJhJTJZ7htwhjIeZ+B3TNGuSPosfCn2jkgOZVbE1e17C/PLNYUiOI2PmBMlHK4nTK0fSomWSDL6kW7qWp8szzvGAZ+YV6AOrBGbd52JEQcIk6UvzXZOTCRhe8XC6ZUOGbLRiKQOn30Q/0pmEQR0/itnuvCEIMN7H/MnRDFjP/grpCstjRG4710KevLCkMLy/gF9sKDBNM4u/FLId4gXVA1rZIHOjLAshFSNx27Bl6991D4uqNfRlM+c8Fo+hcbnv3TcSLAvbsEDEZ7/ardmb8XdvOtDQyOfiLQ==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(48200799006)(61400799006)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(1076003)(40480700001)(40460700003)(6666004)(47076005)(82202003)(2616005)(921005)(36756003)(55446002)(83170400001)(36860700001)(356005)(82740400003)(7416002)(73392003)(83380400001)(81166007)(26005)(478600001)(336012)(54906003)(42882007)(8936002)(6266002)(8676002)(76482006)(41300700001)(42186006)(5660300002)(70586007)(110136005)(70206006)(316002)(4326008)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:59:26.6976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3460edd0-919c-4555-7ec9-08dbcf4b9121
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6757
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton NPCM BMC SoCs support to USB ChipIdea driver.
NPCM SoC includes ChipIdea IP block that is used for USB device controller
mode.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
---
 drivers/usb/chipidea/Kconfig        |   4 +
 drivers/usb/chipidea/Makefile       |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c | 114 ++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index c815824a0b2d..bab45bc62361 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -43,6 +43,10 @@ config USB_CHIPIDEA_MSM
 	tristate "Enable MSM hsusb glue driver" if EXPERT
 	default USB_CHIPIDEA
 
+config USB_CHIPIDEA_NPCM
+	tristate "Enable NPCM hsusb glue driver" if EXPERT
+	default USB_CHIPIDEA
+
 config USB_CHIPIDEA_IMX
 	tristate "Enable i.MX USB glue driver" if EXPERT
 	depends on OF
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 71afeab97e83..718cb24603dd 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -13,6 +13,7 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
 
 obj-$(CONFIG_USB_CHIPIDEA_GENERIC)	+= ci_hdrc_usb2.o
 obj-$(CONFIG_USB_CHIPIDEA_MSM)		+= ci_hdrc_msm.o
+obj-$(CONFIG_USB_CHIPIDEA_NPCM)		+= ci_hdrc_npcm.o
 obj-$(CONFIG_USB_CHIPIDEA_PCI)		+= ci_hdrc_pci.o
 obj-$(CONFIG_USB_CHIPIDEA_IMX)		+= usbmisc_imx.o ci_hdrc_imx.o
 obj-$(CONFIG_USB_CHIPIDEA_TEGRA)	+= ci_hdrc_tegra.o
diff --git a/drivers/usb/chipidea/ci_hdrc_npcm.c b/drivers/usb/chipidea/ci_hdrc_npcm.c
new file mode 100644
index 000000000000..e4a191e02ceb
--- /dev/null
+++ b/drivers/usb/chipidea/ci_hdrc_npcm.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2023 Nuvoton Technology corporation.
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/usb/chipidea.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/reset-controller.h>
+#include <linux/of.h>
+
+#include "ci.h"
+
+struct npcm_udc_data {
+	struct platform_device	*ci;
+	struct clk		*core_clk;
+	struct ci_hdrc_platform_data pdata;
+};
+
+static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned event)
+{
+	struct device *dev = ci->dev->parent;
+
+	switch (event) {
+	case CI_HDRC_CONTROLLER_RESET_EVENT:
+		/* clear all mode bits */
+		hw_write(ci, OP_USBMODE, 0xffffffff, 0x0);
+		break;
+	default:
+		dev_dbg(dev, "unknown ci_hdrc event (%d)\n",event);
+		break;
+	}
+
+	return 0;
+}
+
+static int npcm_udc_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct npcm_udc_data *ci;
+	struct platform_device *plat_ci;
+	struct device *dev = &pdev->dev;
+
+	ci = devm_kzalloc(&pdev->dev, sizeof(*ci), GFP_KERNEL);
+	if (!ci)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, ci);
+
+	ci->core_clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ci->core_clk))
+		return PTR_ERR(ci->core_clk);
+
+	ret = clk_prepare_enable(ci->core_clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable the clock: %d\n", ret);
+
+	ci->pdata.name = dev_name(dev);
+	ci->pdata.capoffset = DEF_CAPOFFSET;
+	ci->pdata.flags	= CI_HDRC_REQUIRES_ALIGNED_DMA |
+		CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS;
+	ci->pdata.phy_mode = USBPHY_INTERFACE_MODE_UTMI;
+	ci->pdata.notify_event = npcm_udc_notify_event;
+
+	plat_ci = ci_hdrc_add_device(dev, pdev->resource, pdev->num_resources,
+				     &ci->pdata);
+	if (IS_ERR(plat_ci)) {
+		ret = PTR_ERR(plat_ci);
+		dev_err(dev, "failed to register HDRC NPCM device: %d\n", ret);
+		goto clk_err;
+	}
+
+	pm_runtime_no_callbacks(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+
+clk_err:
+	clk_disable_unprepare(ci->core_clk);
+	return ret;
+}
+
+static int npcm_udc_remove(struct platform_device *pdev)
+{
+	struct npcm_udc_data *ci = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	ci_hdrc_remove_device(ci->ci);
+	clk_disable_unprepare(ci->core_clk);
+
+	return 0;
+}
+
+static const struct of_device_id npcm_udc_dt_match[] = {
+	{ .compatible = "nuvoton,npcm750-udc", },
+	{ .compatible = "nuvoton,npcm845-udc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, npcm_udc_dt_match);
+
+static struct platform_driver npcm_udc_driver = {
+	.probe = npcm_udc_probe,
+	.remove = npcm_udc_remove,
+	.driver = {
+		.name = "npcm_udc",
+		.of_match_table = npcm_udc_dt_match,
+	},
+};
+
+module_platform_driver(npcm_udc_driver);
+
+MODULE_DESCRIPTION("NPCM USB device controller driver");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.33.0

