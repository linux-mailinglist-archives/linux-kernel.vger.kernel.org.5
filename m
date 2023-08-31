Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541BC78F02B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbjHaPWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjHaPWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:22:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF9E74;
        Thu, 31 Aug 2023 08:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eevgLRQQ+Zc0V2UtAwxphkWGdn67hvoYcD03hAjc5sdGKyAkwB7DXywZdoqv00SnwaeOy+4i9kTtSAEBs7JwLbmW5z1jWvE2At1Z87AKWeT4zKCsJkRovelMyS0xvFEQbVwdp6ZJho/iGgzGrJzPbMvQzUVtvpgJrSUtksnVYVli4p02AskOX8Z59JXObt4uHurzw5oiY9Ovrsa7Gf4gX4z6zm6r7ggIuz+SjY4p9wRoDZ6Zep22R5adBeWY8wMdsGFQ/f3zDeBAoFq7BM844TGsCjfruAJwSXwxv9S45aTO8ePMzoeTEc7FGHsFdG/duEgeajw2pQs1bnosjMy45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez/GtIEBkZtSlarHIWr7C1gHp8BkLT1hF52qsJuG3DQ=;
 b=FGozI13qNp377cD8lWdAIBOS5a2T9NTZr2B/l+wsn4N15hSofSlNBWo1X1mTBkb/026+M/waQOr2tASF6zw/ABEQwfZ9Naki+9SKZ3YNhsPD8X/Al4uBo2OlGI83aqQi5rOOPT0M/clvZUmp0O605l0tF+aOAryoG3iW6+Bh19ahYqT0km6GxhCmOR5wL6b2AA6A3M0wFgjIAbZraJfiA1YpxZh+ZTu+hrViPKmFAVnvNaR48WsRqxS2EULoPlsM3DELek7SVCjqWrTdb5I6BDgfIl8mJn+tjzcBYM1Wl7WhT0eaquDOBnRrErIwxJmE0mDi1SlMhFBeIoIviY3yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez/GtIEBkZtSlarHIWr7C1gHp8BkLT1hF52qsJuG3DQ=;
 b=LZgTh78c9Ehvk8W0a5RBYXinfFXRE5PgnhOml+YkFFvXe8o+eMd61Rzwa0QtrQxs6mGMf0Tx2mnOwM4R93NO16LZ75io4WBB7EUDzszFECHXtx101hSrMNWcvqdZO51rh6kJPIDvbHs/FOc/+/L2X0QXO4p5mw4Oe4Y4teQRY74=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:21:41 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::b) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 15:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 15:21:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:21:40 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 04/15] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Thu, 31 Aug 2023 10:20:20 -0500
Message-ID: <20230831152031.184295-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831152031.184295-1-terry.bowman@amd.com>
References: <20230831152031.184295-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: e48fbe66-603f-433a-0455-08dbaa35fa92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7SNGLReTDuq9QzDfxd3Ehuyajj6YdI2eCeoJCOY2sQK3iu3NGuHh0BT5s6/7bYtcwhNkrhn1jtMi63Ni5gLrdiZ/GHq7tEWvmdsy3FvIHrGtVMgCqIFGi+PNRHbCHd6WJonyB+n67tbEN9wamuUDV8lA8LFetc76vBYlKqak2dwk6iUQpbMpmw2NiDxGInmugoDfTwfNOOnJl+US0gKBO/I0BPviCQ41zCdB/tbiuDXOZaQxaYh4FhafrNVb8ZYKH81W7MRPDp508FLgtS3ZCrVrd4wzcsUxUpGRXl58sqe4KBE1n0zFIfEUxUyjxHaC97zXDW5qLCn3EnpHWvrp/BZy2eUFTG4HRfsWQNaBYkp4iSkOsn9mQF/+7sviBMUSi8sTPHrDDvGa5w7UWh8gt21NC4FxQ+/QwYesgJnJ0DrW9RanYljvmZ28SQZBlrL8G6Y3viR6IME774kfn6V6HDJJE97f/CtRXuxIf/rMFmV8I0GwIawTWu6kwGkvMCeKAh4CmrdMyvnFDYsJY1klueLN4hVC1mqX25/mCQzlMP5Z52rnbsnJ864cyV4rqWqTugh9esbZQkx385tLQIQ7Mn+XTWJjvLQ6JtCXc3GQnd2BRV5NDoDqzAfjY1cFmgEHndMRvygM57ebzE9WIHP6XB51achD9fetvG6kxHHhkjMOskYJpLBOUNs+T3qrnISN7HzHIumxlkrCtGRgclECFMLGRNXKIL0XCVYu68HS7+gojHwHCrmeFI0U14eesqj2oAp6vXb4aUsbZpWLVytHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(6666004)(2906002)(5660300002)(86362001)(316002)(478600001)(7416002)(2616005)(47076005)(4326008)(8676002)(7696005)(36860700001)(44832011)(8936002)(40460700003)(26005)(1076003)(82740400003)(40480700001)(41300700001)(336012)(426003)(36756003)(356005)(81166007)(83380400001)(70206006)(70586007)(110136005)(54906003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:21:41.5512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48fbe66-603f-433a-0455-08dbaa35fa92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

Now, that the Component Register mappings are stored, use them to
enable and map the HDM decoder capabilities. The Component Registers
do not need to be probed again for this, remove probing code.

The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
Endpoint's component register mappings are located in the cxlds and
else in the port's structure. Provide a helper function
cxl_port_get_comp_map() to locate the mappings depending on the
component's type.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c | 65 +++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 17c8ba8c75e0..892a1fb5e4c6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -81,27 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
 }
 
-static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
-				struct cxl_component_regs *regs)
-{
-	struct cxl_register_map map = {
-		.dev = &port->dev,
-		.resource = port->component_reg_phys,
-		.base = crb,
-		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
-	};
-
-	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
-	if (!map.component_map.hdm_decoder.valid) {
-		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
-		/* unique error code to indicate no HDM decoder capability */
-		return -ENODEV;
-	}
-
-	return cxl_map_component_regs(&map, &port->dev, regs,
-				      BIT(CXL_CM_CAP_CAP_ID_HDM));
-}
-
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -146,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	return true;
 }
 
+static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
+{
+	/*
+	 * HDM capability applies to Endpoints, USPs and VH Host
+	 * Bridges. The Endpoint's component register mappings are
+	 * located in the cxlds.
+	 */
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
+
+		return &memdev->cxlds->comp_map;
+	}
+
+	return &port->comp_map;
+}
+
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
@@ -156,7 +151,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 {
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
-	void __iomem *crb;
+	struct cxl_register_map *comp_map;
 	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
@@ -165,19 +160,29 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	dev_set_drvdata(dev, cxlhdm);
 
-	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb && info && info->mem_enabled) {
-		cxlhdm->decoder_count = info->ranges;
-		return cxlhdm;
-	} else if (!crb) {
+	comp_map = cxl_port_get_comp_map(port);
+
+	if (comp_map->resource == CXL_RESOURCE_NONE) {
+		if (info && info->mem_enabled) {
+			cxlhdm->decoder_count = info->ranges;
+			return cxlhdm;
+		}
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
 
-	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
-	iounmap(crb);
-	if (rc)
+	if (!comp_map->component_map.hdm_decoder.valid) {
+		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
+		/* unique error code to indicate no HDM decoder capability */
+		return ERR_PTR(-ENODEV);
+	}
+
+	rc = cxl_map_component_regs(comp_map, dev, &cxlhdm->regs,
+				    BIT(CXL_CM_CAP_CAP_ID_HDM));
+	if (rc) {
+		dev_dbg(dev, "Failed to map HDM capability.\n");
 		return ERR_PTR(rc);
+	}
 
 	parse_hdm_decoder_caps(cxlhdm);
 	if (cxlhdm->decoder_count == 0) {
-- 
2.34.1

