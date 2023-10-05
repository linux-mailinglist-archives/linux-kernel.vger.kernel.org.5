Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7B7BAA17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjJET0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjJETZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:25:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2219.outbound.protection.outlook.com [52.100.0.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FE4100;
        Thu,  5 Oct 2023 12:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeH4BwtieHzFp/k/f0ecqkU7FE8KjaJF1Om5uScl32H36tfZmhBQii8LsEpgSf/CaoRmuNr0d8lBokVzdCbGfyVj64rIVQlmEjupZqjJsjpQODvbnQZZUlU4cHflpnTjmC8Fu1vUWyJFj+L/ZdqjAweleDLVqedK6W9v9TKNA/2Vs10VPG4lzE3x+OCJZh3UcOXxZFeUXzmpJNEG5dzG3CyFYPXmR4bAgxT60sLNFU/zGj7pmtYhQUs5GUjy/wxzaCBF5ih9dnbm4Jhwj9axTrvpEODNyqchIRti7Ws50v3HUxlc95Y/E3MT/mOpfcRiLTOq/JpGw7+C782pX7Ogqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=GHeBhwnPD+Vo4iQdDnwsUl4i3WWjQ0M+4EoEIo5o5GO8kvhJX2IhevmL4H/gM5SOgJCf5z+RhpF8C298Ab/DkjMMkVz1Wt1Yp0jNWX3Igu87UZMSDe/Iq2cmdiEXx3gAcxjU/c0W7SHhuywo6ZVOlMROnv8xXkrgy+8gAwa7OO7Zl+dC5CYjkFo9kFxOn6pmCHnMJSUdIM2XPIXxTIUjsGTZyuYs4uRvQHDNwMY9Svc24vPtAyqvNux8w386e8I7vBtruZuwNgrvFYIYkC9iOpTnOoonBmkBcfsBbsN0H2l40LkzJgvFSXoi5FCBZedzRJVzjlaSjiJT2k9HW4ieQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=NdUSMV+ag5YKikEOLdI04I48k+Vyz5VbKOAQg06VggI8Xtx4b5wCu8SZAo+zWKqzmLj3C8y8qNygfcmvFHRuU6p7xBIwfluc3BKkwTJ/MI4Zs12fTiCfKF2kXmqrKooFdqzgKeVs4+ipTNv3mJHk1wm7nqG5Rd6E8BXtts3dJgM=
Received: from PS2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:300:56::35)
 by TY0PR03MB6906.apcprd03.prod.outlook.com (2603:1096:400:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 19:25:34 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:56:cafe::76) by PS2PR06CA0023.outlook.office365.com
 (2603:1096:300:56::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Thu, 5 Oct 2023 19:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 19:25:34 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 6 Oct
 2023 03:25:33 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 6 Oct 2023 03:25:33 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 37A1863A29; Thu,  5 Oct 2023 22:25:32 +0300 (IDT)
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
Subject: [PATCH v5 3/3] usb: chipidea: Add support for NPCM
Date:   Thu, 5 Oct 2023 22:25:29 +0300
Message-ID: <20231005192529.162785-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231005192529.162785-1-tmaimon77@gmail.com>
References: <20231005192529.162785-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|TY0PR03MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb5b761-b2d9-4e77-1a79-08dbc5d8d8e6
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QWV4nT2hWi6CTQBXqMik4gOCHG1mYbhxPsdnslqhbMfxRjSrhWjKkIkTm9j7?=
 =?us-ascii?Q?KHA5p7FZYT8v2omCBWeSWdI39fMwDoDztT53QbM4cvSQHN/qW+zFOgsLVyzx?=
 =?us-ascii?Q?nrBvXbJYzJ6MrOFLoStkc9ORzHnI+FPCKjZYkijl2clMMold4R4DvtiOYMZ6?=
 =?us-ascii?Q?O96edmvzEzafxl5FM8cdK9cD11ZquLPFvgcGhRmJe/9YisninXLWgRWi+Nmw?=
 =?us-ascii?Q?UMVLHgah9LRmNxQEwVsmOtStEhlskbTNRVE4cnDmgJxBW/Hyq/o8ubjOc+Ld?=
 =?us-ascii?Q?TLRQcbX9JUVVQj83wxM1Rm7fmw5VaCz1S5CRq3lM4YB7eUSXmYGpSXo9mS8P?=
 =?us-ascii?Q?qkX0vkhGtiOAPtyHOWXKixU0QFoTD2At5XvFYJvkU2AsN/AE/aDFO3JAeksY?=
 =?us-ascii?Q?yDMltgWvCktZbJMG/pIp9giMQ2N9A7unOfhKvHi3/NQjwaxdaD2mCqcTAS/w?=
 =?us-ascii?Q?v8KRNaVslSdWR1QpNLWCU8zzOaTqB9OUwBRxMMSIllK2mj2M3iEAoNqdifvz?=
 =?us-ascii?Q?IMQvOR4ezNrNcSwtEBR8/gub7V8jUlSiZlWMJticLDm+qKOtOM782QPlF/MX?=
 =?us-ascii?Q?AZkVpAnVe4JarmPq0jfw06PHtWexzQPeL4pf1pa75lr1t+RGHCelbQmMzroI?=
 =?us-ascii?Q?4/xPGNmU6CrEzDSy45WggWhlpPEucUvjYsM6WZu8LHLBf7gtct40tdo2lSLg?=
 =?us-ascii?Q?txXt7mrUUpgaHh3DRSCruM8Vg/jUap5ne5TXR4IN89HIrdYKddBpTUQ5BFOk?=
 =?us-ascii?Q?Hx5drodwT7aHXrEfklCLciK6xP1VOUba9rbqh0tqn9GoVU/Hp06HYxqQkkPN?=
 =?us-ascii?Q?CdkPXKd2ZLabR7WKP1apHhnL8WHpIsm6SymM4bZ1ZcCs58K9Dmu98ywZ/FEu?=
 =?us-ascii?Q?1PzHjhBHF1PCW+X5w+TgUWYy0AZ+sZFvIPlg1SKt3uZzzv9w6EtyHuiXwHOp?=
 =?us-ascii?Q?A4jJouokQXyRXRFGjTJgTomdoGLGASATEyaT4vik0Rc=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(61400799006)(48200799006)(186009)(64100799003)(82310400011)(5400799018)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(6666004)(76482006)(478600001)(34020700004)(81166007)(36860700001)(55446002)(47076005)(83170400001)(921005)(356005)(82740400003)(2906002)(7416002)(83380400001)(6266002)(42882007)(73392003)(336012)(2616005)(26005)(82202003)(1076003)(36756003)(54906003)(42186006)(70206006)(5660300002)(70586007)(41300700001)(110136005)(4326008)(316002)(8936002)(8676002)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:25:34.5311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb5b761-b2d9-4e77-1a79-08dbc5d8d8e6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6906
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

