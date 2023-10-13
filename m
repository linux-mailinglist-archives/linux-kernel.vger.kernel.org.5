Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110A17C7D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjJMFfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:35:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191BB7;
        Thu, 12 Oct 2023 22:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoGCsdIHiNLOwhqreuoinhtt5NMGPDVQm6qFUeTpN60KAvVxFIsQ8+JeV6LD0W4oI/+V6xFFMHw6p9fpESTbCfrerwymYZaRWsdtMBT2PoxEjEsmi5Po6qT4mNz7RipdXgLbONdKmBguJ2wA/hJK7J2q0/frhsITKr313aHnkSfd5yZFQZPcf6IvfKiNiST0SCgecgacQRu+iSwoT6Y7vXwkG3wHTliNYGc300RUArsNXtEbsNKnupg0Z4mN88NsJOhhYVbyF16WxSc34Jc9uXObRGFybuyg/qEdc0oGafBqDm9F+VHuRtfbh1bSK9eLs41VXNrNK9EXmkbP3nuDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A6RRza928wD7KaoX7zuxAi4uSkpVvCBYqnjZCSskXo=;
 b=flcqISoTmdsf3K4JZ4Zn4IrTA/16HTTaFB0ByaKY678mGWL0A+nphbCIdK8nL0t/fuBjsmF3JlGjbhabDyKbLhSH7pZOueHYGgTqKpNBn8i+PiiQYjmo1D1m+xF2mimf1H8qVJMPPtRVZNuKGkiTRCSB25mw0ypHV/6PvgFWSxMv8mygdft3JCaJJ0ASNhwxdr7sGlGmEtnJF5bAKaaqC1TH1P4BzqunskeRP+tFKakNLdPm0MjftFb4eO5xLRCFMDlOSqZD4s8jKuqQBjEfiqgbs2VG/jmImmW9TYPW7HT/txwKF8b7UHAWoftWFy/OWRnXcZVQhMZLd5XTC3Hw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A6RRza928wD7KaoX7zuxAi4uSkpVvCBYqnjZCSskXo=;
 b=GjVMEydfZaFEBG37j5n4mCyQyy9KD0St5nejobnk2u/B+cA+KN3V+3o7bDQBOxPrpPWHKChygQmzD66LpgMDc7qh/z3Sc7MMfQYoQUXje+dL7XWK3BAiK0Jx1SM7EBFQPxewHWvKekwyXmlbEQcUR6TzhKU1heccd0yh9k3L6Bo=
Received: from CY5PR22CA0023.namprd22.prod.outlook.com (2603:10b6:930:16::6)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:34:57 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::a) by CY5PR22CA0023.outlook.office365.com
 (2603:10b6:930:16::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 05:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 05:34:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 00:34:56 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 00:34:54 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: dwc3: core: enable CCI support
Date:   Fri, 13 Oct 2023 11:04:48 +0530
Message-ID: <20231013053448.11056-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f1dc4d-5379-4674-0059-08dbcbae22ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI/OqtQOSlw+212eVrcugX/qTGEXrClXMFaXmK6oeosGtHO2xQH5Qq9lxSSnaQ3zRTW/oO8QbU2o7h5AwHUD+7vewtDNQ0essJesQY5Ja1x7yo9z1ihgMZE/eeDAJPR6ojZfMIxbTeTqkk1GuTk4+3tIdbkwJbjXN+HE4SBYKr+5ETTRr6T7YeyJ7j5WndGwQBFvdxW1sibcmqkOnsqFFtCz8IWTu9Fpe2V6d5bAt2kDN9VwBoI7otN88v38IrWCWux6ZJo5xDZK5W0O97I/jBAXWvPrQ+pyfwFND/hXiMNWndjidsmW7oawfYogXTUMJHK80T+ITCeK8SJHlpTq0yS/f3bdRjQb1LDwgz/uEMmF8jbNiemoqQUQDOgsnQ+/cbij8SDlNdANthVewcnatm8JBQDNGdCQCj1Ie+yyJ7ihHW7+/pHc/R/d3D/nEiIsVr3nHiuFkfTCI2sfvwwIGPHtp1t094esjObs39rFWgCs6yeZldzO4IPM/u15Ct+kT5Do9jc3kDW1MYxFCRTlvrJTI3gFilvYS88pe32GDvLde6R4lBAjUTWURdxQFoqmNPN8gWRphLSmIPZzY+/R6bwqHHYQ2nW2NQG9wVHKVuhRLPlKBjhZnuiSvD98if70sozw4kI7HgELhANufXAFDFGwStRF6jHGV9URj/sO6g4NiZwGHuKmiFU2+RtGZ27p4Ps6THv28lGbiWYtDBVUhG0bhNHzEDkRPjBe4CkY1BQ55YWPqsvzYH+STQr1DLBFoAlqA4LgC1QbDuEix3MEzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(8936002)(4326008)(8676002)(54906003)(70206006)(70586007)(110136005)(966005)(36860700001)(36756003)(356005)(81166007)(86362001)(82740400003)(47076005)(2906002)(83380400001)(478600001)(40460700003)(316002)(44832011)(41300700001)(5660300002)(40480700001)(26005)(1076003)(336012)(426003)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:34:57.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f1dc4d-5379-4674-0059-08dbcbae22ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GSBUSCFG0 register bits [31:16] are used to configure the cache type
settings of the descriptor and data write/read transfers (Cacheable,
Bufferable/ Posted). When CCI is enabled in the design, DWC3 core GSBUSCFG0
cache bits must be updated to support CCI enabled transfers in USB.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
DWC3 Register Map Link:
https://docs.xilinx.com/r/en-US/ug1087-zynq-ultrascale-registers/GSBUSCFG0-USB3_XHCI-Register
Register Name	GSBUSCFG0
Description	Global SoC Bus Configuration Register 0

GSBUSCFG0 (USB3_XHCI) Register Bit-Field:
DATRDREQINFO	31:28
DESRDREQINFO	27:24
DATWRREQINFO	23:20
DESWRREQINFO	19:16
---
 drivers/usb/dwc3/core.c | 17 +++++++++++++++++
 drivers/usb/dwc3/core.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..fc6892c63abf 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
@@ -559,6 +560,20 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (of_dma_is_coherent(dwc->dev->of_node)) {
+		u32 reg;
+
+		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+		reg |= DWC3_GSBUSCFG0_DATRDREQINFO_MASK |
+			DWC3_GSBUSCFG0_DESRDREQINFO_MASK |
+			DWC3_GSBUSCFG0_DATWRREQINFO_MASK |
+			DWC3_GSBUSCFG0_DESWRREQINFO_MASK;
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+	}
+}
+
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 {
 	int intf;
@@ -1137,6 +1152,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..bd937025ce05 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -173,6 +173,11 @@
 #define DWC3_OSTS		0xcc10
 
 /* Bit fields */
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_DATRDREQINFO_MASK	GENMASK(31, 28)
+#define DWC3_GSBUSCFG0_DESRDREQINFO_MASK	GENMASK(27, 24)
+#define DWC3_GSBUSCFG0_DATWRREQINFO_MASK	GENMASK(23, 20)
+#define DWC3_GSBUSCFG0_DESWRREQINFO_MASK	GENMASK(19, 16)
 
 /* Global SoC Bus Configuration INCRx Register 0 */
 #define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
-- 
2.17.1

