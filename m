Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74AB7B010F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjI0Jzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0JzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:55:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2246.outbound.protection.outlook.com [52.100.223.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D013A;
        Wed, 27 Sep 2023 02:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMGxEXVhz16r/2LW+d6g7XBljXbziIqrYpS3lTLis70sVjX5sCtg86CuX6uHwpgfV6j+849QitwKvHOCdcVF2FLB1MavuLRrN8pTMb0HjPbG8rRigvKpGgEapSgQczg6dkAjFt+YkONgXa32dmzrHxV9YIf0Oo+5wMz2glL2vh0rrFSv1QLMYWZaqJFZjz4GJ112HkKKIyRV5COR+8p+U0Zo2IUyH8gMcBvns6PAdIiKCrfW1Q65nbOseh2QK9zDfZqBYpALr5nHSFMReSw2gbiUJ8OSmYSp7tYxlMaCX1l97ome57omTBxy+2yepHu9FV/1O6yRet1gJCNQf7aIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl1VxRhdRvz/y2QkA9nIu8cIMgWvkU4Lt6YJykCjsSw=;
 b=jqesLbuyvXlpKsYGjaVJ0vhTiZSARnHKbtfHUvESNWDT9IK9pE73ceXxu5SQWDPw3BipHNaakz9glWjiEFfA+lUhWyRDuGSY64hQLHPQ+9JuUC1ZKmHj54BroCNDtiZxZVuxw87aqAlvbsxFJ9rSX9eteYW19vwT5b9ddXo5EMbzeIIKk4DdZXFBrAWK3enD9bjEikuKWUeUuLTGacBRkMJJEoyb/qjuvJUuCyndzZOrOr4x80TL4OWeJJlAH23lffy5dTGmS2Fzoh3JaSMhVoggB4N+c9tmB4r2WPOeXHtKT/1RUnOFYGtfBUmYAlmBzrfZSUeeZFmRJrFhTeI1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl1VxRhdRvz/y2QkA9nIu8cIMgWvkU4Lt6YJykCjsSw=;
 b=fV0tOQ484KNlMoQDcZVjUC6MY9ENnOSSVGil0uNFlai0c69Q/Gc1FcXD6L0xt+fOeTjI2ueJxAOb4sMdoFug6FSjNtS+U8/V6dbq7G/VYszfvTEnvAkJcxnFnyzTyVVOMaskX6ItHc1nFsgBf3N9oR1AK1utlrLwrcwNQfLn6dw=
Received: from SG2PR02CA0107.apcprd02.prod.outlook.com (2603:1096:4:92::23) by
 SI2PR03MB5579.apcprd03.prod.outlook.com (2603:1096:4:12d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 09:55:19 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:92:cafe::75) by SG2PR02CA0107.outlook.office365.com
 (2603:1096:4:92::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:55:18 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 17:55:13 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 17:55:13 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8E17864740; Wed, 27 Sep 2023 12:55:12 +0300 (IDT)
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
Subject: [PATCH v2 3/3] usb: chipidea: Add support for NPCM
Date:   Wed, 27 Sep 2023 12:55:09 +0300
Message-ID: <20230927095509.267029-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230927095509.267029-1-tmaimon77@gmail.com>
References: <20230927095509.267029-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SI2PR03MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: 485a96b0-d541-4bbe-1282-08dbbf3fdb86
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uKGEUaE15Vo1B9YV5v3t18EmQBDDumsGxU5XI4RjwxjZc2XCo1TvrVqHb8GJ?=
 =?us-ascii?Q?OOyo+gFRexEFiNqvGVwd5yP7V3i9AMvi6SCzcgF+qR3QHQHY9VsvN1hNDxie?=
 =?us-ascii?Q?0d23KGP40D5rW0Gk4VHHv8wc0dn/Lt+1uIpTF/Xf9a9Q5AP3ucrrqV9Nbut9?=
 =?us-ascii?Q?eBRX6k+YNPAk1KkR54rvBTTQOkm/qDIYatPV9amc2dI4LpyFJ7ZgKrSuszOe?=
 =?us-ascii?Q?GjSh+rzqIJcBkOPKujHXgfvMEN9W0z0NKuPuxs7RH1r4OO2DSZjBUEb5DES1?=
 =?us-ascii?Q?gqmXVk+IbsCeV7TKGjVzyu5blxYl/K5A8cQOws4zUj1J4Y2M5BqvmLUEaP+D?=
 =?us-ascii?Q?bGMzNx9udmXYDJ7w6fPGkpId8fJYnbgZ6nDpjywbYsaYgBEjbY2qoOAbWLVw?=
 =?us-ascii?Q?ijkAZRgC9f2idNGD90hp2KOaexO9l8jyIM02biyxkmamLCaoGLsYMY88CLxM?=
 =?us-ascii?Q?zYaht3WM/OMClsAzUk5GhW8gjSNvuaoWAftF/H10irkzrbsiN0tue8M86jSQ?=
 =?us-ascii?Q?wsT0fUcuIzUprBju+nLxN4GaZXu7u/PpstKW3QBYPQMftl2WuXPndLN8xUDz?=
 =?us-ascii?Q?aLuu32jaBUYF1PLAJRfJ73ek89Yh8VTi3uuBupkhTunAXJs3SzTa1Mn6tGl4?=
 =?us-ascii?Q?xF/7WDtXAYrwOYISJjt5ysNhdaQZCZ9+gCXJu8xloUGOIi5Dz3/glDm39xh3?=
 =?us-ascii?Q?Lh9L75YCpK3yThHo7wm7/x0hZ2h/iMpviIX05iQSk7/uPUUVN3Q4Cjds3kT7?=
 =?us-ascii?Q?EjFJ7k4S3Ww19dvSf2kF2oo6ver3pYroQM1vx5SUkhjSbvqs3XEquUHArWjr?=
 =?us-ascii?Q?BuY4jXcuFDhpfRKc2R462Vhl44R7dovf1RBS5vL5hgxUnJM4eyGSVC20AffU?=
 =?us-ascii?Q?4tbzvUkr+M+ZyQ3aj00EP5jmSa14tRzftmBLbhD5MPzACILEUmXL0cR8W2fc?=
 =?us-ascii?Q?G3YHJ3/x4xeu3x14BB9jcF/Hp7dHmZY/Et1psL9rXV4=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(82310400011)(186009)(451199024)(5400799018)(48200799006)(61400799006)(36840700001)(46966006)(40470700004)(8676002)(6266002)(4326008)(336012)(5660300002)(70206006)(70586007)(8936002)(73392003)(26005)(42882007)(110136005)(83380400001)(82202003)(40460700003)(1076003)(54906003)(2616005)(478600001)(42186006)(7416002)(40480700001)(316002)(55446002)(36860700001)(41300700001)(34020700004)(83170400001)(2906002)(81166007)(82740400003)(921005)(6666004)(47076005)(76482006)(36756003)(356005)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:55:18.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485a96b0-d541-4bbe-1282-08dbbf3fdb86
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5579
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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
 drivers/usb/chipidea/ci_hdrc_npcm.c | 117 ++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
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
index 000000000000..4169855e7940
--- /dev/null
+++ b/drivers/usb/chipidea/ci_hdrc_npcm.c
@@ -0,0 +1,117 @@
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
+	if (ret) {
+		dev_err(dev, "failed to enable the clock: %d\n", ret);
+		return ret;
+	}
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
+MODULE_ALIAS("platform:npcm-udc");
+MODULE_LICENSE("GPL v2");
-- 
2.33.0

