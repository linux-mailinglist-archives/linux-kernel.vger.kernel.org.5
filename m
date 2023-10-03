Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171EF7B6708
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbjJCLBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbjJCLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:01:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2234.outbound.protection.outlook.com [52.100.0.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EFDB4;
        Tue,  3 Oct 2023 04:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2enKtkEK37iBfKjMVdvQpN5OIK+7p/kDVqxf/a1ejGvSZQkoYRxdo/3bpSBmFUwHnKBnFejVfljYrnY0dYxF1A0oc8YNIr5o8sIoN8PB/VebHzt19vz196hp27yIgoJeKoPvviXrFYyAwE651HjAw2gSHVRrzAaVzbbf6XQ2tF4lFnxEY/kufD5F8SVjCFF2VBcvptJ0YXeCR8XkJFMoyR3rttwNyEGaVA8tQU4rKELN+yrjexFYAW1LRXTHk/TfWhJ7BODRG6XRbJCPKB2mQ1tRCvxYMPjSH0kWO20e5MjPYVamD0WYvAYKJGM/goXmUGsgCCeol0J+G75E8hDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=BW7IFAfpitSeG+hfIVBP79CoIq2mxxhwaH9LEblxsjaG8puJzd815upy9F4CZqDRpP9WHdmAWzrzrHWiLkoeBGcieo8llHKwOLef0sbwLF1W68GMCZnGfZyTTi7SwN/HpWg5JgBba5pi03jxIBX9tfHq+ABEZSLsc3/3xmUzxqD4xirGeASj7LykoL756Rj3E3MTHj3L5xK5YzD7RZn9g3H2GSuq6LpS12m+p1MYjBAkyI/UKu0TO9cXHyBfij/FsFRjpQuC1B3JhibNwIgmSwwWeRD3Hw6RS4H6vcxF1WmGWe9cxIzTT5uRYGjnnH3QLkZEpDuM0CtjTh32HVInpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqdhpXuqvc/cGbndu9wJ6COlL/RiDHNa5WUr+9UxfMg=;
 b=YUndTv85kF2pN31uT5UR8pUhbXrZkDCcYKTFH7ntNqYKb9Ts8eMKVmV3F8NYLMW0ByJha4RwObTPikjpU6kNlSgrset8xkTXXUuhP5rs8ybJbrJkiE9hKmqjrh/AXKPiocVqc1rE/wWI0zCWu/tTx7XtdJIXbeGPYyeA+ECXves=
Received: from SG2PR03CA0121.apcprd03.prod.outlook.com (2603:1096:4:91::25) by
 KL1PR03MB7599.apcprd03.prod.outlook.com (2603:1096:820:cc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 3 Oct 2023 11:01:39 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:91:cafe::58) by SG2PR03CA0121.outlook.office365.com
 (2603:1096:4:91::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.21 via Frontend
 Transport; Tue, 3 Oct 2023 11:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:01:39 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 19:01:37 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 19:01:37 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 19:01:36 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 24ED664740; Tue,  3 Oct 2023 14:01:36 +0300 (IDT)
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
Subject: [PATCH v4 3/3] usb: chipidea: Add support for NPCM
Date:   Tue, 3 Oct 2023 14:01:30 +0300
Message-ID: <20231003110130.229711-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231003110130.229711-1-tmaimon77@gmail.com>
References: <20231003110130.229711-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|KL1PR03MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 88298096-062a-4c2d-0c67-08dbc4001ea3
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7MohIyX9Kg7RvZvA+j3iGhr5EvAS123iqLiczgKChNkWbZxdrs6ZVsVkElD/?=
 =?us-ascii?Q?crzpBUItKlI3DoYzu2xRLJZ/NZhBRGLn7qaeh0p1+Cpfs8m2XxPKMk8yNTdN?=
 =?us-ascii?Q?41FmIqw8ImlUprV02NJmGnSbzTYhmqusdftF1SG0WXF1fL7jKwW7r9fHvJRw?=
 =?us-ascii?Q?0Rk8zJLhgFgO/2T0usv6qORix8bNVBsJ4T6vZiqDcWcjktShEFgdTUtPK2d2?=
 =?us-ascii?Q?F0k/S9eKSRS4PL6v5EvluEVs9CyOOYBiWsMK4Yw3uRBwd4YMM/1fymLZlEbK?=
 =?us-ascii?Q?Lne+kozVyhnlvTHMzB75ZCKt9LJni2qlBBmC0nXa8Kqxj6jMIFrUymtPlVse?=
 =?us-ascii?Q?wtGrBMWO1UMlDwrSn1uEfsprMyPdkdb/k0GtX8ei/JtM7ivSqZp0NtZbnpJ3?=
 =?us-ascii?Q?iZWDjaAdugUB0PGJibuTSQeG5dL1cV9BCeQc3vEZQXTEyYKKIrE56qYQ6HG0?=
 =?us-ascii?Q?HPkmw8QMgiisrjeRN03wpwCMdPvLWgkzkJTl0Ht6rsAcNpI96qRy65oLjKrX?=
 =?us-ascii?Q?wY8/KoF1MvQ8C324c4y28cg1XMVdQOW67q5wk4N9D5UJa7Wen08r19tZOfMr?=
 =?us-ascii?Q?JmUzeVfns4VnikHEqa2RNor0y0Z+hJMpLpZ8x+StHj9s4ejO3gOMoB3nAJps?=
 =?us-ascii?Q?b22FJ9JZJ6DuySgkt6vEUT8bxdANwQgWQlN9hox1VELXNXe2dkk2n1SulCjV?=
 =?us-ascii?Q?1hBcM7DLe2p/NWL0nWL9J1IAUnsEMB3r07R3JSK1Cqc+3oG4WruxPg2Ys0vq?=
 =?us-ascii?Q?+oSmowPf25Udi37AFYhP+u1aSRU2ZlaSEeRQ35CH3EVSdftgJMWE8SIdGRmq?=
 =?us-ascii?Q?If3g8am2l1KXe/cuhlh9mXrIIdATRsimn8R474WU0A0mokhLpju+7SpZvKNi?=
 =?us-ascii?Q?ntm3zqNR/xdlCxJz5h4rfNAdSZZzmGAVzQoV6D9OC008QoXzo8cYvhQ2PUob?=
 =?us-ascii?Q?Ai+PqSzaB4V3R4Z6/QDX+oIa7QkxRf3HuGAlpnVWzG8=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(61400799006)(186009)(64100799003)(5400799018)(48200799006)(36840700001)(46966006)(40470700004)(2906002)(76482006)(7416002)(8936002)(4326008)(5660300002)(8676002)(42186006)(41300700001)(40460700003)(6266002)(356005)(36860700001)(110136005)(42882007)(54906003)(2616005)(40480700001)(70586007)(1076003)(81166007)(34020700004)(83170400001)(47076005)(82202003)(73392003)(336012)(70206006)(83380400001)(55446002)(26005)(316002)(921005)(6666004)(478600001)(36756003)(82740400003)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:01:39.5165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88298096-062a-4c2d-0c67-08dbc4001ea3
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7599
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

