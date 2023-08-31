Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8778F025
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346525AbjHaPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjHaPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:21:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F402E5E;
        Thu, 31 Aug 2023 08:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSb+bYWtlmXyOHKCDW0yxw+SoP6d8QZYpK0YaRj0vWTwNATm+0tjLdoe6YYxTamw2XD5ieSxBp266imvmLggWNK8qWYQWIk/Ga+2xzo2SqCKRyHTJWyqXQL04l+gztOfE/DRTu/mYrgfJFZ87DpeuJ0IbXhTwl00AlP+Vou5ZqFMgSIGjUGhI/VlhKPaigF+Ll87n3cN+Jxy2R2aVo7ZeAlSsvYNpmowlsapSLs9m3Yn0AUG4dLQBjWD7P9JF4QYQPAkV7POpLB2kLBC93mRRcQ1Z3GyLNfe5y1x4AofRSlfEajLgw5edxL4uV1QWYkD0MFkKNn7WSJP/beYQhbLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/+V7T4VGjo9read9sx1AAetl+wqpt56YUt+A9HeeTo=;
 b=PKSZ8K2v+bO35gymoNz8cvLlscD88Fi7vQAFvdvROU//KEnt7DhpvVumYzhsZex/K1Hcc6S7cRs5OI/ha5q+MuStw/hV/w5S8YUGCCNtJr5W/RX9dgTF/2G5nWdgeT/DQ8VaeUJ3ankPb2nATq0b+UUWvClS0ldVIkf9tM+JHlVCmbOF7CjTZOhpRLTmdiebKHMt4UZfq9O9O/r5QrD9R0KhkQMzJ066vcIPpaRRm9Lx7ZzDOPz9cEz5UvZ1cDZLsgC9SKCBdvG3daqBRs7Kl5/TCPYIxjy1eo11F5Lfbxz0pCplKh9DmT0eI961WBnQklv+sOnXCLdE/OqycEXNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/+V7T4VGjo9read9sx1AAetl+wqpt56YUt+A9HeeTo=;
 b=rMp7Q1K2vWJ6tSkzcUlTQLPwYECwXFDpu5ib7p0dgkECJMORjwicacmkgT79QbK+j/5ezZc+L3OgoZcl/gRivnM1jbBevnTTTAcWU2slEbl9GmCuZjaqyxmqrGfxWj7G5n7sPo3O7KVpPBOPDXSdSYJRE/h+OesW5xXKP3bi21Q=
Received: from MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::14)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 15:21:20 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::1) by MW4P220CA0009.outlook.office365.com
 (2603:10b6:303:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23 via Frontend
 Transport; Thu, 31 Aug 2023 15:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 15:21:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:21:18 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 02/15] cxl/regs: Prepare for multiple users of register mappings
Date:   Thu, 31 Aug 2023 10:20:18 -0500
Message-ID: <20230831152031.184295-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 6710e362-4a23-456b-8d14-08dbaa35ed90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKg3yDdQcP1wUx8I3PWvOtF6MlDd4EsAjKV1p2ai5464la2Wva7qwMJo+vTU9luUzxO5C9ulIowa+KWGAFPL8eI5pDlBcBeW1QXYhtc+SpHQfaik07SD059mMNkwZO24fN3QmDWXs2UkgDl5bBNfl183FB0QqQBoRboBCPxjXx4LkACCow4up+6HylWoCVpVKdTDajhd+baGqB5GF1ndaltCBOvEgbyWlG8gxvhC0srnPM5I19l4PPUSopctnl2RO9szAwvuat4KJLDli6/Ab3wPrPilQW2uy1YyQVVf32AvhiCF5dkhWqsv1Z63FftszDg21nh57mjGTzM8naq5XyCX1HNY5qewlMIa0I/Qf0tZUDRJDuGH/caks8IQGWjMzDyAZZXQnwmE4A8LFa9NjT4xJM22AtmfHXuBjEnNmnl7fmyegW/GjFr3ttnRh+TxNb1LWSfvElQM2fDB+Mf6UIPqt++QMMqu3y6m+xo7CGnXOdF/AtLWBUYt4MVxDZq02zqo8yxp24NX7GDoe2JyOMAosP+Mdw1lqFF8Y2tSfMWe15fE5dRvY+ejBQYILS0OaI8URRZwGa0zebKbi1UVt/FYFfQEDFIAtmyXHjO5uUGSG+8R3KA1Ww44MZzaHi0TABO2zCI/+xr4f1uqi94lS+B4BmKhxDIX/1RMN54yxNP5KeBRXtrEI/WgYZaEMT4tEF3Na4gJePVA6y+2MwJcljXSCKOPOHaKMcnkF/8eShyQR9LW4+pQZD1EASftbR05IaT5DKnp+5jnWGQl2te4nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(8936002)(70206006)(478600001)(110136005)(70586007)(7696005)(54906003)(316002)(41300700001)(40460700003)(16526019)(44832011)(1076003)(26005)(83380400001)(5660300002)(36756003)(2616005)(2906002)(86362001)(47076005)(8676002)(36860700001)(40480700001)(426003)(336012)(4326008)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:21:19.7156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6710e362-4a23-456b-8d14-08dbaa35ed90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

The function devm_cxl_iomap_block() is used to map register mappings
of CXL component or device registers. A @dev is used to unmap the IO
regions during device removal.

Now, there are multiple devices using the register mappings. E.g. the
RAS cap of the Component Registers is used by cxl_pci, the HDM cap
used in cxl_mem. This could cause IO blocks not being freed and a
subsequent reinitialization to fail if the same device is used for
both.

To prevent that, expand cxl_map_component_regs() to pass a @dev to be
used with devm to IO unmap. This allows to pass the device that
actually is creating and using the IO region.

For symmetry also change the function i/f of cxl_map_device_regs().

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c  | 3 ++-
 drivers/cxl/core/regs.c | 4 ++--
 drivers/cxl/cxl.h       | 2 ++
 drivers/cxl/pci.c       | 4 ++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4449b34a80cc..17c8ba8c75e0 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -98,7 +98,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 		return -ENODEV;
 	}
 
-	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
+	return cxl_map_component_regs(&map, &port->dev, regs,
+				      BIT(CXL_CM_CAP_CAP_ID_HDM));
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 6281127b3e9d..dfc3e272e7d8 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -201,10 +201,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 }
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
+			   struct device *dev,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask)
 {
-	struct device *dev = map->dev;
 	struct mapinfo {
 		const struct cxl_reg_map *rmap;
 		void __iomem **addr;
@@ -235,9 +235,9 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 
 int cxl_map_device_regs(const struct cxl_register_map *map,
+			struct device *dev,
 			struct cxl_device_regs *regs)
 {
-	struct device *dev = map->dev;
 	resource_size_t phys_addr = map->resource;
 	struct mapinfo {
 		const struct cxl_reg_map *rmap;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..ec8ba9ebcf64 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -274,9 +274,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
 int cxl_map_component_regs(const struct cxl_register_map *map,
+			   struct device *dev,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
+			struct device *dev,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
 		     struct cxl_register_map *map);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 48f88d96029d..88ddcff8a0b2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -827,7 +827,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+	rc = cxl_map_device_regs(&map, cxlds->dev, &cxlds->regs.device_regs);
 	if (rc)
 		return rc;
 
@@ -844,7 +844,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = map.resource;
 
-	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+	rc = cxl_map_component_regs(&map, cxlds->dev, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-- 
2.34.1

