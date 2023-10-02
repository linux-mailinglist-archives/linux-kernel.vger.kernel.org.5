Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6497B584E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbjJBQOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbjJBQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:14:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2231.outbound.protection.outlook.com [52.100.223.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B994;
        Mon,  2 Oct 2023 09:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTGEpg2ap/ngFDkC78gN87eBP+UEtORc1Tb1UvDhjiKYY/rXYkTHhLJlVcuOd94shTRMpOpN4LJ80zKsvbunY5y7w5alF0SYmcvwDk3KPY94JCe3nJ4Z4FVz8OEqgrl9mvZNWZWRHRkSjZ3PN/0QQOea6//4rCbDeDY4JhTZiZYVKkK6rYaiIx0Jhd5A/Yc+S7WFRMQPK9+KkBlUiDeSQ8tdxp2OQRdQ3uBGsSrC4Haz6BNijohWgttJi+69eTECxPDEMJBb7HUn01nos4WxogCtd3eHQYaqVxe9z2NiZIpQRFOqUDCPnGTkbR3iD2kWeHBvN1iRx4iDG/Dmwcs5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=SSxdlO50cNzFAJiIwCvZQwWMMY6cxE92muaI5SnwQxWC5BDCQ3O/regCAUWySDPnWNtjtocCtPIgsbi92zooKG2Dhhjm3U2+4oZcW259hf+b8Vlfya5Mois+UIgPI/Sz18AEVSJZOqw3QQ5tFG2g4R7xq1yejceAGt9L2JVXL9M6vrSyWq6vB84rbrAdCGIDjOgyMizZXwl/FmTPOT8E0Mre1iU7O2kVWB/VCsD4Nj7NYUvZOrdH06kYDZiw+GNxcWC2OFb+DjnLlH2oPee23j91kWnorO8glqox/WJtDuSPoT17D1Zq+bf6OgZVRMEog68BA1PhFvYRZLd3TaOfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=Zpym6puI/IQm2mlBej+4B0cb4H3q5gaYaoM312yDbvVNlyqQ/3cJXI6EA+YhHbrhJkhF3wtdff42P5aX87GD8iYJUbLrQpa9Xkss1SBFhalvVrgiJUWkQP2p7AtcE3h38yZ4on78Pn6set4hVe77MTEfEqq+0T3JvlK35+LHqPc=
Received: from SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) by
 PSAPR03MB5525.apcprd03.prod.outlook.com (2603:1096:301:65::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.29; Mon, 2 Oct 2023 16:13:55 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::97) by SG2PR02CA0048.outlook.office365.com
 (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 16:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 16:13:54 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 00:13:54 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 00:13:53 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 00:13:53 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 9520F64743; Mon,  2 Oct 2023 19:13:52 +0300 (IDT)
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
Subject: [PATCH RESEND v3 3/3] usb: chipidea: Add support for NPCM
Date:   Mon, 2 Oct 2023 19:13:50 +0300
Message-ID: <20231002161350.64229-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002161350.64229-1-tmaimon77@gmail.com>
References: <20231002161350.64229-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|PSAPR03MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: a3956aaa-fb42-479f-eafb-08dbc3629350
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?njeA9KQ+z0dsEbEICYwRYDCLodtzFEeXscZIgh1/BiqgtZ0UDELvpNoTz4He?=
 =?us-ascii?Q?EaukhFbeAmqKuS9M7LPc74Pjj0ki583HONPK9SEVHHTR5ozltAXHIR8DeUcf?=
 =?us-ascii?Q?Cyb9ALQmK+6/mVZld0TDa2H/2fZ+t47Q+KaGUSl5U2+6P2Bz30VoPqGWpNHP?=
 =?us-ascii?Q?mw8Wv7y7dC1cAl1W3QqJvBkVPARMAhnHbnL0VC4GywhLDMfn5oF2tZOowG2b?=
 =?us-ascii?Q?ucfpJnLDT2KORwR8GWPW3W30rH8d+0MniFrWsqTPxHS+eFV5v5KqMOArZzGK?=
 =?us-ascii?Q?vyTUMlU/3w65bPv3SLpr2eZ/6A8RBZm11BpFIIjVEZkxxLMnQRlnyvzI4cLt?=
 =?us-ascii?Q?XVQnnjNYaXfdK3sY0E0AFagGemj6S3m+98necN88HIG+Wwd3BPJQZxXlYth5?=
 =?us-ascii?Q?Myx9Bm70cJ5EcKQNv1wCA11iEJJGD61uVfQ+sYw2Hz3x759GehFWMhRw5ASp?=
 =?us-ascii?Q?Y+Fy1O636F2y6g4LxQchJWMGjoOrwVYLvdPyNCT2rD+GtotFHQGccckJuOWW?=
 =?us-ascii?Q?wy/ZrYGsscPrIt0JZNcBv8jnUSCHSyuCFYdaOkbQfD0Lz66SGhoLLRDC/L2C?=
 =?us-ascii?Q?ql2D6lYQKp0Ilti9c13OUtIOMoPf5TbO+Em4vtXNR6VfT/YnPojTKq46lI50?=
 =?us-ascii?Q?AoRjR17eP5NXGcF0k2AOJzLTPvluYUWFZ08GEZk9/iz2n6Tb8GjSQ3kCyDVH?=
 =?us-ascii?Q?99Jm5en+w21Srg+xcUOr7KalNCl8IW7dytn7ejGGC4UdCgOmBwpysD+Uq3g0?=
 =?us-ascii?Q?wwZ1eF390SDJ+X4pbH48CZsQDm4hTiolIMxAC79xJAQ9uivBSuwT5HApcrI8?=
 =?us-ascii?Q?aWgoezuGYva8M7d6u2F7DX4PODnCqvik57fk1GULvqLurLXRKynVHi7zupTx?=
 =?us-ascii?Q?vYcVf6LZnTV5pNDtH6m/dZDWQdbsdFkKedvy+8726ZqcRHy8IMX0SaGXDbO8?=
 =?us-ascii?Q?7O78sBr+CpgbHkvr8Y8m4TYzbqoerzMsqZfEjWRRF8c=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(5400799018)(82310400011)(186009)(451199024)(61400799006)(64100799003)(48200799006)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(478600001)(76482006)(47076005)(34020700004)(36860700001)(55446002)(81166007)(82740400003)(356005)(83170400001)(2906002)(921005)(7416002)(6266002)(83380400001)(336012)(42882007)(73392003)(26005)(82202003)(1076003)(2616005)(36756003)(316002)(54906003)(70206006)(42186006)(5660300002)(70586007)(41300700001)(110136005)(8676002)(4326008)(8936002)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:13:54.7728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3956aaa-fb42-479f-eafb-08dbc3629350
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5525
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

Add Nuvoton NPCM BMC SoCs support to USB ChipIdea driver.
NPCM SoC include ChipIdea IP block that used for USB device controller
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
index 000000000000..37b64a3dbd96
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
+		dev_dbg(dev, "unknown ci_hdrc event\n");
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

