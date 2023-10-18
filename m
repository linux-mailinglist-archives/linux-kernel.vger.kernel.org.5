Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B87CE4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJRRcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjJRRcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:32:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE0530DD;
        Wed, 18 Oct 2023 10:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGW9SFnUR638xmZMdx+0qNPgULsprNYk1vQ8ZmfWlSDA9Xr9aFNKTYFK/vkKZiQ47pZl3TsoYz7QE/KNQ0NCTvfgUe7/lLHr+Gz26Zv67u2nw9sKt/RXtlC1FPe9o97hfHRuzGmeKsfh4sDgmdfKSaEk5DgdM0KQilZGW7Kk504LidQD3OSveHIwMcyym4tVRscCw8PFwgSCqOU1Qt231Dy3aDlOT3PUmKIly/ETEYS/Yt/xcM0RE0ehZf+h6LJDM7l5viFBVSfrM4/JELTQ9RclW4h0qVg1TzzawzZzk1fHILEWvDeuaHoJsszjFrB0zPmQ9E5aSftYO8XfhBYYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzLKdHzELpATSnIHowrrl7C2VHnJBDvxzs4mMRxd4YY=;
 b=AhWUtaFiKXYL0sXBumy8iIzC9af6VIffbnie8IvABeQgcEgtuQL2U2zZzNWQmB4+TW+BFGTD+Lg5O2eFQ3j/CVgZSN4aWGuBsiv58xy6sj0143fOmX+1NuaR/cXGXc5LPkHzRE7uIgsYsEQlvAtb8s5C1YKqT+rPDUAtQPA4GJfyZ3KAnKo8uFmamrZLQ3YqxNf0h3Wly7LdKK28KJLVJuCE3X5J0lKlhNJe8WjSS2sTzToEKUoiAU8QasSkzg/VtXQ/Nrb8WC07mywJE8P94cUvrx6A3ft2tz9eF0Xb33C1yjp56uIVTJLyQLExvxpRo21uUmK9xmTvknyvZvjAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzLKdHzELpATSnIHowrrl7C2VHnJBDvxzs4mMRxd4YY=;
 b=VzNH1j90BMJyP678vcP18OU+pUEF/duq9zTZ1bsjGyHxk4M1QfCdcu95uTxP9Nk5J1IGRMPUdJow0KJ8ImrEahoLBaf7c4omHKoLOku+3W4OVFvGwVL6Ph8GOFnMR+ICuw0Wu0CCU/tvTcizIQ9s6VuWkRwZ59x3nknWRV88kqk=
Received: from SA0PR11CA0183.namprd11.prod.outlook.com (2603:10b6:806:1bc::8)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:18:12 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::6c) by SA0PR11CA0183.outlook.office365.com
 (2603:10b6:806:1bc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:18:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:08 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 02/20] cxl/core/regs: Rename @dev to @host in struct cxl_register_map
Date:   Wed, 18 Oct 2023 19:16:55 +0200
Message-ID: <20231018171713.1883517-3-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018171713.1883517-1-rrichter@amd.com>
References: <20231018171713.1883517-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5562c569-9f3d-44b4-a843-08dbcffe34b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDACd2Jp+LDZC1XHYf+End9PrA6/Ot66atcTsE995ab3uNvd4Se8VJH8FAkrENORX3M4mI4asi05oVDoDrOIeDpazQRMLU3VDCchtMGHWzVSVnocFLgpMgZoq43NcBxr7b9E45qBA1seaMMqH/fad+TE3YgeUaYqdvu6DfYtwy5EgGxc4Dn8NrsHoAe2F74Tl19MEUUfLGKNa1K9uRzDazMhYLUcqtPLy9D29IQCQtu8E/FcALNXpDdu7v53IsubyN4i1JUKvOWDK/V9JXr+U8IEXr9ZGW096rvoOknVb0ktwOGEbjEoVoWkFZcwU5lNF6zm19QqdBLkFCNiwdNuZOA171YfH09e7G1zI0VZZPPiVSm3nxPqOSSFC3HT4kTf+4pcYMYLqPzBTygeI1CQxRziMbJRTCCn7zqV8B/k+mFtw9wcefRKixPrsR+NQ6HrqmPqmgmCLJtvfglrmBojXB3m9kDYlyRm3TevlYkUD8RyLU+1eT53skZojy+ZsCJGGAUviz4MKOfP8ZFpbKV9F79Hhy0O8LYumL8LgqjvMH3R92Z4I9LxOYs2mz5EFY8YtxNYh4KPWKa2P1/BWaXIUGgflcFCI/6IhWmhVhEPoftdjsbCBTHCKNp04v4vBwJ5U8Kp94ZzOSE31aKgCsGyR3EscHEOIki6xNR/aOl/DDZjLw4KK2jsim1WDtl/3LKb+yWbCst3dXEfMbVV/FubPJmYEvS2Jw3cdHSbuKJ5vc3tXzxj2DEQgaLAFCEMjXDsRShsRJvDqV/qZQVKqNDy+pbNMw7eTqcuTP5Oj+oLJcQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(5660300002)(36860700001)(2906002)(16526019)(6666004)(40460700003)(83380400001)(426003)(26005)(36756003)(336012)(2616005)(356005)(81166007)(921005)(47076005)(82740400003)(7416002)(1076003)(316002)(110136005)(70206006)(54906003)(6636002)(70586007)(8676002)(4326008)(41300700001)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:18:11.5591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5562c569-9f3d-44b4-a843-08dbcffe34b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary role of @dev is to host the mappings for devm operations.
@dev is too ambiguous as a name. I.e. when does @dev refer to the
'struct device *' instance that the registers belong, and when does
@dev refer to the 'struct device *' instance hosting the mapping for
devm operations?

Clarify the role of @dev in cxl_register_map by renaming it to @host.
Also, rename local variables to 'host' where map->host is used.

Add Fixes: tag as the fix in the next patch depends on this change.

Fixes: 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c  |  2 +-
 drivers/cxl/core/port.c |  4 ++--
 drivers/cxl/core/regs.c | 28 ++++++++++++++--------------
 drivers/cxl/cxl.h       |  4 ++--
 drivers/cxl/pci.c       |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4449b34a80cc..11d9971f3e8c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -85,7 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 				struct cxl_component_regs *regs)
 {
 	struct cxl_register_map map = {
-		.dev = &port->dev,
+		.host = &port->dev,
 		.resource = port->component_reg_phys,
 		.base = crb,
 		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d4572a02989a..033651a5da30 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -691,14 +691,14 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	return ERR_PTR(rc);
 }
 
-static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
+static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
 			       resource_size_t component_reg_phys)
 {
 	if (component_reg_phys == CXL_RESOURCE_NONE)
 		return 0;
 
 	*map = (struct cxl_register_map) {
-		.dev = dev,
+		.host = host,
 		.reg_type = CXL_REGLOC_RBI_COMPONENT,
 		.resource = component_reg_phys,
 		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 6281127b3e9d..e0fbe964f6f0 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -204,7 +204,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask)
 {
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 	struct mapinfo {
 		const struct cxl_reg_map *rmap;
 		void __iomem **addr;
@@ -225,7 +225,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			continue;
 		phys_addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(host, phys_addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
@@ -237,7 +237,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs)
 {
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 	resource_size_t phys_addr = map->resource;
 	struct mapinfo {
 		const struct cxl_reg_map *rmap;
@@ -259,7 +259,7 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 
 		addr = phys_addr + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
@@ -309,7 +309,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 	int regloc, i;
 
 	*map = (struct cxl_register_map) {
-		.dev = &pdev->dev,
+		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
@@ -403,15 +403,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
 
 static int cxl_map_regblock(struct cxl_register_map *map)
 {
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 
 	map->base = ioremap(map->resource, map->max_size);
 	if (!map->base) {
-		dev_err(dev, "failed to map registers\n");
+		dev_err(host, "failed to map registers\n");
 		return -ENOMEM;
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
+	dev_dbg(host, "Mapped CXL Memory Device resource %pa\n", &map->resource);
 	return 0;
 }
 
@@ -425,28 +425,28 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 	void __iomem *base = map->base;
 
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(dev, base, comp_map);
-		dev_dbg(dev, "Set up component registers\n");
+		cxl_probe_component_regs(host, base, comp_map);
+		dev_dbg(host, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(dev, base, dev_map);
+		cxl_probe_device_regs(host, base, dev_map);
 		if (!dev_map->status.valid || !dev_map->mbox.valid ||
 		    !dev_map->memdev.valid) {
-			dev_err(dev, "registers not found: %s%s%s\n",
+			dev_err(host, "registers not found: %s%s%s\n",
 				!dev_map->status.valid ? "status " : "",
 				!dev_map->mbox.valid ? "mbox " : "",
 				!dev_map->memdev.valid ? "memdev " : "");
 			return -ENXIO;
 		}
 
-		dev_dbg(dev, "Probing device registers...\n");
+		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
 		break;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..b5b015b661ea 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -247,7 +247,7 @@ struct cxl_pmu_reg_map {
 
 /**
  * struct cxl_register_map - DVSEC harvested register block mapping parameters
- * @dev: device for devm operations and logging
+ * @host: device for devm operations and logging
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
@@ -257,7 +257,7 @@ struct cxl_pmu_reg_map {
  * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
  */
 struct cxl_register_map {
-	struct device *dev;
+	struct device *host;
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 44a21ab7add5..f9d852957809 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -484,7 +484,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 	resource_size_t component_reg_phys;
 
 	*map = (struct cxl_register_map) {
-		.dev = &pdev->dev,
+		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
-- 
2.30.2

