Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E47B0928
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjI0PqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjI0PqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF65272A6;
        Wed, 27 Sep 2023 08:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8CMnBgPyIQVaD8gOLHmRkJZLzhVCQPQb+3mDXFadT2D6twxY4FFf05PSQC9tcfgzokiFm87vvDGsLWiUdn2+/55GLIUnzR7s4A7JgZ6A/ma/g+VlYuDL3pZpa8/nyzN+nAqzsIu3OtQJr5JohLYS2f8cpCZiEMtseGhk8FZSoXoxYhucpqYvb7pXazPlMDevrXP3ehbC6JvalaSawkt637GCde48/9IbsR018nLMHIP/yETDdiMcc5+QdPgc7eYhICEVdTfEHUEZlwZCrkQ+TYMqFUsMIA4ZmpLEUuLZ2IPjAbdajDz/RESX4MRJOPYqJp2EuD5KlNDLiP72M5+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkLEBjrOG8SXs78gX6EqHo7C7ByYb/JIipaJZpwx96c=;
 b=Ww8I5Lg3587s0AdS7bIPXqf5yUCE4ShllC7G7L13xwolC5TyK6IxunNtKVnjAWQ1Xl9XibN55SkF9pwbArlNm+PMeda7MMcICtKyB18ucvJ2tXRJssNcjfG/3lFAkjOTDkU07snjJSlMBLDhFeK8Y/cztbhyNOEMoKc/0P0kdi6z2W6Rcfqg3H6OTWpJkGvIDTrJnh7IbAfpASKiS8ZjtohK8oAKAbLRKYzUM3VYunboAxjCysyQbr52Z+buSQqhXjdGRBg1Yu+2dDDk8MtlHJTBv08F9jIVdtRQB5dyFHuxkNk4JYOpH/Xfea6gOoKKo9jWSkpaMlgFAtTLpKTjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkLEBjrOG8SXs78gX6EqHo7C7ByYb/JIipaJZpwx96c=;
 b=srWWYy3uU4f5uRr731U933j8ooXYdwrdw05weaNzpDAVybLGgcfYYYZ7aRkaNBHsjDJjJVWALzcJ10PeY/rUv3WuLLZFCahB4i1oR04SUYHpYfMQikm/WwwYQbUZdwWo1CZtQNRsJB5qiGZXoNf8NwPhajgxjQQeKbM2LQ8Fc+g=
Received: from BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::17)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 15:46:08 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::53) by BLAP220CA0012.outlook.office365.com
 (2603:10b6:208:32c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:02 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 02/20] cxl/core/regs: Rename @dev to @host in struct cxl_register_map
Date:   Wed, 27 Sep 2023 17:43:21 +0200
Message-ID: <20230927154339.1600738-3-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230927154339.1600738-1-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: b02ef264-23bf-4e0e-76b6-08dbbf70dd4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DU/nzUIrx2lrQ9NxwAmGp3ykcwcGfweJcMlSi9+aGjcFPPMH4yFv0O5EQsmvhL7S2cdqstuXpFVCFkkNKdCnRx4BBlfloF2rPh6jqmd/IBsZ4gtIJ9aUTHgr7bT09LnUjcWXBLsAEzqdIKDO/jB3S5QJOLxUBu21Zc9Is3eWKiyahg7q52HobaFk5dS1Qxu8UzeAhNi7SKlOG4RPVFwTmezy2QWN8o6WuiFNWnYHJvxHEbrrjCJPvG9e8C3DbRnsKQ3W9pv2ECCGCMHIon4qtn4s51HM3W7WD0JjEbCEGsF0UHy8lmjWkYXj1uIlSBGP3Y150DxafZ9BY0u1n1fehxUfKCfWvChzO89sD3kijWIq9L5wyjY+b8Lq5xoXS8X/Cyrh/s2m4SW2aL3QCbcjieB4ONq/YUwNEMwHXjmKrOErr6rMVxwVVEMFa4yHS1PteHgHxBJDt7uSc3Jx5wV+KxTmKTG2oDw52MFC40cFVhVPn0sM+flQ4BFA4ig6P2s/jH4m8+7Ur05MLh7ectY/Cu5wR58NuciWvIb6Gvzc4qR43NHPwwl5wSnt8gq2ZMoj4OwMziABXyKeVhFimIWkoHOdtol8YFO2CUECkfFDQyHP0GKvAx5p8B4MLASmrm+hd8OKabZhuYQqO69X1JAlEEM1ZWoJbCASXRqoLS2p0EqBU3Bw0HY2gqHp2X9YdcUDqjHUi5e+oZE08dzvjwfsFlKuCjlA9gaTM/2Q5qW3GscaQEWx1R+NFXRNiZzky4b0kqECna+Ye3FHOeyWcZWKx1LWV/84jHdwewdyN1NzMzE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(1076003)(426003)(2616005)(336012)(16526019)(26005)(7049001)(36860700001)(47076005)(36756003)(82740400003)(921005)(356005)(81166007)(40480700001)(40460700003)(83380400001)(110136005)(70586007)(70206006)(7416002)(2906002)(8936002)(54906003)(316002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:07.2475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02ef264-23bf-4e0e-76b6-08dbbf70dd4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

