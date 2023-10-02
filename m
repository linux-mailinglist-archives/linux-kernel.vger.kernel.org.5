Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B38C7B573D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjJBP7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbjJBP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:59:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2224.outbound.protection.outlook.com [52.100.164.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79C1B3;
        Mon,  2 Oct 2023 08:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6NwQW3ivnSW2j1Es0EM5sFUPoyqQOfp/HpjqS3lDwfCSVaGRHnC/waxgDBimUSkuRhA15r/JbEhRNzMVxtVHmh8Cyfd6JMuXAKGXRDDc44Stms30r6131jfWxCrAwOOOMNjMrJvsnUDeZSkK90m2tOLE2qPpBeTeLKNHa9vJl8SISCYDi/i9ZSSsPTT/+x1s9ro+j2CMWtXuWqYs5gZUmHJdflh4kfDJDE+1Yc7oTVaFjGzqR9DBFV/lKWPl+n9nJARmEMi3yDUS4OTXZJKSRTi6Mk7Gq0Bj9Ivv+3cySAGOQ5NOyAoPlLKYxkzjQnizRzbFFuDH9h8OfADg9fivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY3mmZOX6+NuVUK0TfSQk+Zm3wTl+hP59tz8YV4141A=;
 b=hSAuvMJGWcAEpNARLUQY1SpWhvOdGH7ZUUCem/svoP7e+B2ys8bR8/vIvWCuj6riu84l14ikzQfFTWpZpkN1DxWi3Z2uww6lfU4TAAFgjxy7LoyCk3oG7GRBswEoTzREk0zLBnC4rPz4cagGb1KhfeqLoDB6ysRAWUB46yu0IOCUQI+p/oyRaxMzLdTFLI5qGViVK218ECTElXyB+o/HQUA6DB16d2a2wEOiOcPu+gJxuELf0fkIcFf6ilO8fP1z9PCsuD3WgDJta4OlKVjnnNrV6QoAdpqVxeE8RXxTWKdTsVivLu42YDFxC8NDGkYP9rEu7ELJ1HGvV8Tb0axo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY3mmZOX6+NuVUK0TfSQk+Zm3wTl+hP59tz8YV4141A=;
 b=dlP9Lg7IWw+hnDM94zbadwL3vUd9fCqHbHIstaShyBKVW4oUYFyiLaJmluCzj+d+vaG1RFpuOf5oJTcs/r6i0NxRaaaw+RARU83JaxY3AGf0K51+6J0SmyHckY8MO31rMAwLvMkQglwgssbIaKTSZ4wmFozEVr6Bx0mI1mKdV0I=
Received: from SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) by TYSPR03MB8027.apcprd03.prod.outlook.com
 (2603:1096:400:478::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 15:58:54 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:8f:cafe::64) by SG2PR01CA0139.outlook.office365.com
 (2603:1096:4:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 15:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 15:58:54 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Oct
 2023 23:58:53 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 2 Oct 2023 23:58:52 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 0725664743; Mon,  2 Oct 2023 18:58:52 +0300 (IDT)
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
Subject: [PATCH v3 3/3] usb: chipidea: Add support for NPCM
Date:   Mon, 2 Oct 2023 18:58:48 +0300
Message-ID: <20231002155848.62198-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002155848.62198-1-tmaimon77@gmail.com>
References: <20231002155848.62198-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TYSPR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: b90eaa14-acb8-4318-7796-08dbc3607a89
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eivbs6KvISzbUI3diMU5+kuvk51dBiOXCI0wKix34Y64fkgHUvQvAsGExD00?=
 =?us-ascii?Q?DzDY2+cnt9mFHx3ZRWcCkcc6YR1a66dJhP0vUdydrKRko0NelyxFxemCGttA?=
 =?us-ascii?Q?Z5eO8WwgjGgFq1z5lPBSJ07L7CzknCOpNit7oAS1wnSfB0r0GwknE83NjuzF?=
 =?us-ascii?Q?VIm8i6NwXx8BmlgbvO9vkwz/1NcTmI7vYV42aphqnEXGbPF3pp19l4DU2iBG?=
 =?us-ascii?Q?IX1CYt2Ha7Sy6Ic8gkUvFuECfcHVUi7slWVPNf6SA1RzO0tjfLdUuQBPRJdV?=
 =?us-ascii?Q?TlWr0FR0IlbU/eSv/67AZ+11GCIibyNt3J1bZvVUp+UKxvlI4WRtIHJV2QRT?=
 =?us-ascii?Q?RKRPPpfIVSiilrNo+768mfmt413GGE2o7dIp2lzKvg66WVlOPGg0i/v+FxST?=
 =?us-ascii?Q?vt6dLUrNTTA6bd/t81q/hNQ93GuftFmBT0RzqMogEgbdiDgAuCu8S+XF1YwZ?=
 =?us-ascii?Q?xHphMrdy3UgwP7zitT80Ct8iHGuU5cE6u9JjFGQETdrxSBrfvwTsktfHApln?=
 =?us-ascii?Q?7I1J6LjLPPDcClJzpGMOVpRgKYoPgexM6XbVb1x5M0MguMDK1t1kx36BZRdI?=
 =?us-ascii?Q?0JNtgAhshO1BY2oG2noW0AKeERocGCcy2/MmgJRe43reBxsQNoIpN57XjZem?=
 =?us-ascii?Q?jkVTVBZfFioSullt+3dEWdpnbvVZbt8qmrCGf0JihQwchZFiRv5S/GXezGke?=
 =?us-ascii?Q?vwRc+7SzcFgqC8pJ0W9KovjF7+pLa4FyeiYOu/cUVSCYzt2hI6rQnO3/x6cz?=
 =?us-ascii?Q?YK0PiNk/NxccZpTZPnka5CgXuGibkczT5VZ27mm313qCQo+YZ9/Kvz+Iu3Ik?=
 =?us-ascii?Q?sU6I3JDaZpGGRrUuskB1qAyYUJpkxB06+3vZVihVT3OsrcHH78GX9YTrqZPH?=
 =?us-ascii?Q?Ry70DtH20Wh1OdgK3xuBEzArfXp4je0mMCnVQlb9kYAEeBNIaTt1ndvqdlMv?=
 =?us-ascii?Q?x2wzMREoJbOmAo4ZvAIl/zmDxgzPEGlb8MU63LDJHho=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(5400799018)(48200799006)(82310400011)(61400799006)(36840700001)(46966006)(40470700004)(83380400001)(40460700003)(40480700001)(478600001)(6666004)(34020700004)(36860700001)(55446002)(336012)(921005)(356005)(82740400003)(81166007)(83170400001)(7416002)(2616005)(47076005)(6266002)(1076003)(26005)(73392003)(316002)(82202003)(42882007)(36756003)(2906002)(8676002)(41300700001)(4326008)(8936002)(54906003)(42186006)(110136005)(5660300002)(76482006)(70586007)(70206006)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:58:54.2069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90eaa14-acb8-4318-7796-08dbc3607a89
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8027
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

