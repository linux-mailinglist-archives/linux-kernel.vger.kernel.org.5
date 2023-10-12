Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A4C7C7A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443066AbjJLXBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443038AbjJLXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:01:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2213.outbound.protection.outlook.com [52.100.164.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F73C9;
        Thu, 12 Oct 2023 16:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgOpL/ysJCUF0p9lbOWrZ4/tVXSc1IQ6NLZXVLtXAxXXq6L/CuMsAOPazVfTYXmNElZyJBaPxl4yGHen7QdTrrpNjZqKKOxpE2sQhfoMWFKV8G6fNd+VEqAaj3z71iOGex8zx5I3RLxfA0c+DEZzWyc2281s25v+R2MW6Iv3J8WYffvmcXeDTSxTdOgER3hv8ij4hn5XVWSUzHpyUc84EqWNRBjMB6WllXY+50z/uj+/3Ackfgm5dmbdzo4Q2pRHp2l45KrLCfv54xL9DjfWDxpvaoqMgXujA9ncH3u2Ob7BRJTl8V199WdOBcv6W2TnT8jxfF8fS9s1Vijsx4l3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=SP2wkCigrSjoeWn5dQWvYWEnzcIexY5k2D+BfaPOugsYOJ7pkdbqgrJHu5clYvxW8q3hxfHNCz/qDNJTgbHbzKaAjIdFJlpssD9XxhA0x1i371R9ktfCl/jsQAn73R90/SfQbAihDvN8vmcx6aoyQ888KGNh10+RBex55fmfjkw9VW+ESJ/xcyoJ4ZKS0zugWKPmKNQtusB1SSk75IFuoOZMxz4pru+ANdkRn2/z9aOhNn0gaMzS5i2BKZzSoZUEMRH9w+smqWoynAD2R6ShfRoPPWuClxqmQ1DVPwvECB/rsXMr89pP+sCyVTQr1sx14Dcvdv2C1Q7kdxMwpMmAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=mLIluoo1dIC65547QrHCIkekEY3UD9nbF+MhHcECWqmVAzoUGR3hNnCQ2L9xbRxt7h49ykV1heD55MhdrcYvLWvmkA8eWH8xjv1UYsyjGtU3hmyJUWUQvQx+3kZDuS5GNujNvnR0SHd01x/KS/FMtKB6grTl0xE33JfLy+b+VeM=
Received: from SI2PR04CA0001.apcprd04.prod.outlook.com (2603:1096:4:197::12)
 by PUZPR03MB6048.apcprd03.prod.outlook.com (2603:1096:301:b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 12 Oct
 2023 23:01:05 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:197:cafe::f1) by SI2PR04CA0001.outlook.office365.com
 (2603:1096:4:197::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 23:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:01:05 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Fri, 13
 Oct 2023 07:01:03 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 13 Oct
 2023 07:01:03 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Oct 2023 07:01:03 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id E91BA68E78;
        Fri, 13 Oct 2023 02:01:01 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C15BA21CFCC4; Fri, 13 Oct 2023 02:01:01 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v6 3/3] usb: chipidea: Add support for NPCM
Date:   Fri, 13 Oct 2023 02:00:57 +0300
Message-ID: <20231012230057.3365626-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231012230057.3365626-1-tmaimon77@gmail.com>
References: <20231012230057.3365626-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|PUZPR03MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: d7847b67-6607-4a00-d8db-08dbcb771d26
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CSigZHrJTJ0Fl4A8IY37PBznPDLGsuPYy7oHFuTeTs6wjaNmklK3dTy23OCt?=
 =?us-ascii?Q?dxMEfWZdKPdR9iRTIczvcIhdMJY9j4NYFN0WNUiTQIeqWN1+s/PSfzHlKbEs?=
 =?us-ascii?Q?a/0ZedQYwcxhVn3M3j0DxmK7Pnkp7qNGUDCHFD0zxoCzBf5ouqnPbCqQ1/4m?=
 =?us-ascii?Q?in5k5bwDm3wowisbxS3Z8eYTdq4/EdbgwQ2bNXf6+Mn6tG47S2KxhJAO77ZC?=
 =?us-ascii?Q?soRXcwhS6DWNwlWVhgb8m53YFiz5agxKlwJVXDEVvcutbg4PucdQoK+SKY0L?=
 =?us-ascii?Q?kLbGt5cdMxzQ6d+KIHWa0WT2/e8y+8tFtjaaZxC9b0SEvPYTwyBpfp8jn2fW?=
 =?us-ascii?Q?NEE0bx4XcmCW4U1Wf4Y1PvxaQ5bcSI6QDVVysaiNi70lrxHg4cCtgxn93KqM?=
 =?us-ascii?Q?ey6nzjG/YXlacYVcny5KfBLuw5mR+pE1pV3wlyXXHhYyN/HeugKh8yDLrS9P?=
 =?us-ascii?Q?NmALrxkLlyMmzLhkE7JL0nwqaImnWO+jC1GFx2jlBpLYJ8J/T+P2mlX5av8P?=
 =?us-ascii?Q?Y03xUlSDu8XdRIzWdm7fX44SozGcIc0yIJhs8mekOwp4D8hx5QHcl1iGF0LN?=
 =?us-ascii?Q?AbwASa01oyOQb0j54fett3ee4d/olRosad5Tcngaj5nRQnHWVy88g1UsyB7T?=
 =?us-ascii?Q?M8GetsR9gKFL412d4zrwGzPEXf7K7S4GA0CYKyvWmBX1PwUaeDe+FSTyfNFb?=
 =?us-ascii?Q?Gkt6eyJv28NS7mbGOt2qhptWNEf3Ggx64phz0OsSSOyXt/3Ibt4Lpv39NT1l?=
 =?us-ascii?Q?WwZtG7j54WKwUgwDsEq2PN4ywu+uvLbDO5qVgz7e5Yqnf6BZU495FW1v9bH2?=
 =?us-ascii?Q?pG3x5tALtP9OPmeldJocOIIAxORzyyJJVTCoDwm5FGXJiweBEgLubKzLvtCA?=
 =?us-ascii?Q?nYmKZ1VrbEHcV++5wdGiOf5p/a1ZmsIxrOM0a/gco8joQjINTDU38FLIH87z?=
 =?us-ascii?Q?894haq8ZI8GP060RVqpodttdCHFWPTuifVoWWrqfQN8=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(5400799018)(48200799006)(61400799006)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(7416002)(478600001)(40460700003)(2616005)(36756003)(82202003)(26005)(1076003)(336012)(73392003)(42882007)(6266002)(2906002)(356005)(81166007)(82740400003)(83170400001)(83380400001)(55446002)(36860700001)(47076005)(34020700004)(40480700001)(6666004)(4326008)(110136005)(8936002)(8676002)(76482006)(70586007)(70206006)(42186006)(54906003)(316002)(41300700001)(5660300002)(45356006)(35450700002)(84790400001)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:01:05.3376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7847b67-6607-4a00-d8db-08dbcb771d26
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6048
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
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

