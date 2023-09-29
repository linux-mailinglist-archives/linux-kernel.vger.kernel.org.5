Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AA7B2CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjI2Gtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjI2Gtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:49:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E61B2;
        Thu, 28 Sep 2023 23:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KffR4c+HPkUYbwmRJMdWAzZaSLYRuvbJXWwpVlGYBHesl88OMHJOKoOPd7qsqwoPrZtTtL8IBkYKj+KgEtkPprmltk4qrF9mkKZ5rku40aho9JnOoXfGO/trDkaw/iU5osTOf0mCs4BBMvhXo8ooJxOQqCiuf3nSUWJAiQEqgdJYBXcaAGLPD29QXNDjuPy5QekB1w0dzJNc5ewHkdmqhRW5LizaOOHnB9YA2FG095evUaQEnqGvJhkpnkXu1FyXn1IhtNhMqJ4e2vskENqj27Fv8h2jelyPyxop4QpM7LuAGhb6J6jXDV3pw9oJi7ePkkeGYyd54E5wfCSkFpp/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgNx1sk26Fi/rLxdQZ2p9EbG5jnFL2lOMM9Dy2C7shc=;
 b=Ym9BOlq16/8r5oYgPDXCyi3Io3pu2x8JzKLVPEzKmXPpj21w62heUY3JjX4VOwfKbkf4cMk+RlTXnzb1ODXpGIMMFkT+QJ1NYikCTj5tJgk2h9dqaePPAng5xMBVf3WXARfom8eT0ZCGHBMbApL1r2YD2VGJS8YIQ0YAUbdD5RIo+j0twaPTZd5IrCW/DfIt38+VTFK8cot3H/U6PvupdDMzS8VhnT21zWEAojXhE+7Dck/VcrLDOHVMN0ERWKkYkj55sa0FVGB7//5tTDhMj/kQboCrEq7GmLzya00eWl8VaIKSOpWJpwiEOV28bPriHGB9eB6C7R7668BNF/LUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgNx1sk26Fi/rLxdQZ2p9EbG5jnFL2lOMM9Dy2C7shc=;
 b=hvdvBo9WcXzLtUsSITG63rYYgbx6UdSDI6TdRfhFwAw4cv7sMiBBBWz58RRGEn6F6tsIdYGGz+6MpjbepUU/H4wYScorevy5PWx92YeR/doTwNn5v6y5mdFPuqPPq1IUHZZJv4f5+kmMRGogK9Gbsr98i1Ov5IcWH4cylU9oaME=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 06:49:30 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::d4) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.15 via Frontend
 Transport; Fri, 29 Sep 2023 06:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 06:49:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 01:49:28 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 01:49:25 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peter.chen@kernel.org>,
        <linus.walleij@linaro.org>, <paul@crapouillou.net>, <arnd@arndb.de>
CC:     <piyush.mehta@amd.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [RFC PATCH 3/3] usb: phy: Add platform driver support for ULPI phys
Date:   Fri, 29 Sep 2023 12:18:52 +0530
Message-ID: <20230929064852.16642-4-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929064852.16642-1-piyush.mehta@amd.com>
References: <20230929064852.16642-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9c92a4-5f31-4d12-8583-08dbc0b83af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6zRwJJb3MpGu6OlPziYJXLLEsFeG7epjDN/GCPActQy240sw3HdfhMt1oQU1wo6a4FJCBnzPhhjaYfwSkxU50wNkYGHZ+QDbRskcaew9D7DtnRKDlhAs+VVOOGYq20kT0Irg4HeoILkmoQMfCtSX7hx49QMBaW/FRX9xnSxr/PVVuzhVMsmmxy1kBa1SNY5Yn6Qm5eXY9b2FczRjxmwbjWebLnqnbFJUwFyABWRBUZVLMBMF/TwJGptpQ1mHsL/t2QttHjQFKQXRx/xaYdPGt9mO7gtnHjzbI6XdjC26f+OzAWWG2y4TsVhs+40+VTlnajpsNb+Lxdtzxev7xmmDYXY8JIRKGSZgvN2RZGhf2HVuNkqeC+pn3Bx85Jb7vHh0GdiwUmQx2DUqA/2ezFrqRW4AbwLnuoxg3MeeAu7SgqqkQR0eLF7Hl058XrGeIp391VZfuDh2Uxaz01TqoiGY0QujlcdX470PEFksQwA3Ot3+1AhiSzVqNpW4D4JzGm9YGZo9S6GDVr8GlKthkxBxTMD0qt/Yg63mhNaWAmjnWktli3awTKWIt101ctxrQAukupNOwLCsffE/jRYT4aGz5ODDScS+7EdkWv8q9CNDbOqMsBpkyQQv3V25YtU5e8xZOjOA5Di0sT2KbZ/bmqJVqeJ5PlqgKdNZ6AijIo28s6a11o3MuKvqSbrDozf5SD3AZzbkeAMysfs0nZusv2rAkU4qokdp0ZG79uXsno80M/XtrheULhV9kB1cvB8rsQj9mGs7yIBoBCoEGvxU82GPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(6666004)(2616005)(356005)(81166007)(82740400003)(1076003)(41300700001)(316002)(36756003)(26005)(54906003)(86362001)(70206006)(70586007)(110136005)(44832011)(5660300002)(2906002)(336012)(426003)(47076005)(83380400001)(7416002)(4326008)(8676002)(8936002)(36860700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:49:29.7894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9c92a4-5f31-4d12-8583-08dbc0b83af4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added platform driver support to ULPI Phys for Zynq. This modification
enables external five volt supply to drive 5-volts on VBUS. This signal
is or’ed with DrvVbus. Some Phys requires ULPI (OTG Control) register
DrvVbusExternal and DrvVbus bit to operate properly to drive the CPEN
pin/ external VBUS power supply.

The ULPI viewport provides a mechanism for software to read and write
PHY registers with explicit control of the address and data using the
usb.VIEWPORT register. Zynq platform access ULPI PHY via viewport.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
On zynq platform chipidea USB controller is capable of fulfilling a wide
range of applications for USB 2.0 implementations as a host, a device, or
On-the-Go. The USB controllers are integrated into the PS IOP to bridge
between the PS interconnect and an external ULPI PHY. The register provides
indirect access to the ULPI PHY register set. The ULPI PHY register I/O
interface uses Viewport to access PHY registers.

In current approach we have extended generic ulpi phy driver and made it a
platform driver. This solves the problem, but would like to know if it is
the right approach? Here, we are modifying the phy-ulpi framework by adapting
the platform driver to fulfill our requirements. ULPI PHY register read/write
should be performed via ULPI framework using read/write API call.

The another approach would be to have access to the ULPI register via
viewport flow by creating a new platform driver at path "driver/usb/phy"
using "phy-ulpi-zynq-usb.c" source file, where the source driver would be
particular to the Xilinx/AMD zynq platform. And binding patch [1/3] would
be specific to Xilinx/AMD-specific.
---
 drivers/usb/phy/Kconfig    |  2 +-
 drivers/usb/phy/Kconfig    |  2 +-
 drivers/usb/phy/phy-ulpi.c | 90 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 5f629d7cad64..38ae5458528c 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -160,7 +160,7 @@ config USB_TEGRA_PHY
 
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
-	depends on ARM || ARM64 || COMPILE_TEST
+	depends on ARM || ARM64 || COMPILE_TEST || USB_PHY
 	select USB_ULPI_VIEWPORT
 	help
 	  Enable this to support ULPI connected USB OTG transceivers which
diff --git a/drivers/usb/phy/phy-ulpi.c b/drivers/usb/phy/phy-ulpi.c
index e683a37e3a7a..61e15a19ea8c 100644
--- a/drivers/usb/phy/phy-ulpi.c
+++ b/drivers/usb/phy/phy-ulpi.c
@@ -13,9 +13,16 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/usb.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
+#include <linux/usb/phy.h>
 
 
 struct ulpi_info {
@@ -39,6 +46,13 @@ static struct ulpi_info ulpi_ids[] = {
 	ULPI_INFO(ULPI_ID(0x0451, 0x1507), "TI TUSB1210"),
 };
 
+struct ulpi_phy {
+	struct usb_phy	*usb_phy;
+	void __iomem *regs;
+	unsigned int vp_offset;
+	unsigned int flags;
+};
+
 static int ulpi_set_otg_flags(struct usb_phy *phy)
 {
 	unsigned int flags = ULPI_OTG_CTRL_DP_PULLDOWN |
@@ -240,6 +254,23 @@ static int ulpi_set_vbus(struct usb_otg *otg, bool on)
 	return usb_phy_io_write(phy, flags, ULPI_OTG_CTRL);
 }
 
+static int usbphy_set_vbus(struct usb_phy *phy, int on)
+{
+	unsigned int flags = usb_phy_io_read(phy, ULPI_OTG_CTRL);
+
+	flags &= ~(ULPI_OTG_CTRL_DRVVBUS | ULPI_OTG_CTRL_DRVVBUS_EXT);
+
+	if (on) {
+		if (phy->flags & ULPI_OTG_DRVVBUS)
+			flags |= ULPI_OTG_CTRL_DRVVBUS;
+
+		if (phy->flags & ULPI_OTG_DRVVBUS_EXT)
+			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
+	}
+
+	return usb_phy_io_write(phy, flags, ULPI_OTG_CTRL);
+}
+
 static void otg_ulpi_init(struct usb_phy *phy, struct usb_otg *otg,
 			  struct usb_phy_io_ops *ops,
 			  unsigned int flags)
@@ -249,6 +280,7 @@ static void otg_ulpi_init(struct usb_phy *phy, struct usb_otg *otg,
 	phy->io_ops	= ops;
 	phy->otg	= otg;
 	phy->init	= ulpi_init;
+	phy->set_vbus	= usbphy_set_vbus;
 
 	otg->usb_phy	= phy;
 	otg->set_host	= ulpi_set_host;
@@ -301,3 +333,61 @@ devm_otg_ulpi_create(struct device *dev,
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_otg_ulpi_create);
+
+static int ulpi_phy_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct ulpi_phy *uphy;
+	int ret;
+
+	uphy = devm_kzalloc(&pdev->dev, sizeof(*uphy), GFP_KERNEL);
+	if (!uphy)
+		return -ENOMEM;
+
+	uphy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(uphy->regs))
+		return PTR_ERR(uphy->regs);
+
+	if (of_property_read_bool(np, "external-drv-vbus"))
+		uphy->flags |= ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT;
+
+	ret = of_property_read_u32(np, "view-port", &uphy->vp_offset);
+	if (ret)
+		return ret;
+
+	uphy->usb_phy = otg_ulpi_create(&ulpi_viewport_access_ops, uphy->flags);
+	if (!uphy->usb_phy) {
+		dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
+		return -ENOMEM;
+	}
+
+	uphy->usb_phy->dev = &pdev->dev;
+	uphy->usb_phy->io_priv = uphy->regs + uphy->vp_offset;
+	return usb_add_phy_dev(uphy->usb_phy);
+}
+
+static void ulpi_phy_remove(struct platform_device *pdev)
+{
+	struct ulpi_phy *uphy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(uphy->usb_phy);
+}
+
+static const struct of_device_id ulpi_phy_table[] = {
+	{ .compatible = "ulpi-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ulpi_phy_table);
+
+static struct platform_driver ulpi_phy_driver = {
+	.probe		= ulpi_phy_probe,
+	.remove_new	= ulpi_phy_remove,
+	.driver		= {
+		.name	= "ulpi-phy",
+		.of_match_table = ulpi_phy_table,
+	},
+};
+module_platform_driver(ulpi_phy_driver);
+
+MODULE_DESCRIPTION("ULPI PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

