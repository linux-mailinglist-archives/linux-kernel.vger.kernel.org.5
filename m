Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6046B78925D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHYXde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjHYXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:33:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FBD2114;
        Fri, 25 Aug 2023 16:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN7YpM61ScrIPD0ZqMxrLEnX7YWZCxhk9Ofz0IlrINiVJhf+fDaY2VvW9bnef3L9i6gHVXHvnkjzj8QEveujZaO4PFh81d8YwlhzRTMJ8q/XxkeznNEZp1hd2htUeu1ec5LCt5JK1x20qcTNPAABgr9B1GggaAXCz1oB+EFxqS2b42LPxZjGocxhnocPjU6R7qNxylN+8jw96DKpKuUgJ1Kmdzj0NwZWYR3viB1qJvoRToBKEQbowNQTda/dmkR6IvusrbVTcesr/FljLnxuRPOrODxdRn27FUPmMW7Hu1tMUDUKMWJFwJSu2VVwTa0cfelSjQxiN/5LGMiY1oR+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgg1Y9NYkQQlAypZ3mejX5mXhLZcQCqhttGh1FfK68o=;
 b=BhjoZTXI6mA8rfPQ4jiFXt2lSavQi8GvbLLVvaV+FqRZ9n5bpkkiocpannlGMUzIwmtH0KHn0C4HylhftPmm7fuo09pyhmBkaSk7PdMCcnKmiNoAmN34qFp/jumoiun+K5A26aMaBVwWJlAsPxMqqN3WVzTLpKiRwgILJI4qZoMhw79g4tn8H4N95GqvlEnPMrgR1gMHr1x60LrAq3xGR3x86Byx+OK0t1tpWWyqOB2eqoFrOlnMfqiOFMX2bCMzC+7fe8Dmc5Io4s9hH0acyToPgnzoSqTzzCpTbPgOKLCFTF5DPlCpd9U/yT9/AqI59rF17Io0xjrbp015BBXBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgg1Y9NYkQQlAypZ3mejX5mXhLZcQCqhttGh1FfK68o=;
 b=JFdzYFzIUPvuazeHBq6wik/uR3b1/QCAQM8IPz23gcsq/qYvxfNk2YdL8bOKrJuVjiI33xdM0I16DI1H5WFJEcIDHPWKrSCTSFOwocvXcDmeumwhjbcUI1PGp+WMkVjef1JlgvqgDYW4w9thE1rBZOr3t+b2CQ9WKWYwu0mORug=
Received: from SA9PR13CA0120.namprd13.prod.outlook.com (2603:10b6:806:24::35)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 25 Aug
 2023 23:32:56 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::c0) by SA9PR13CA0120.outlook.office365.com
 (2603:10b6:806:24::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.20 via Frontend
 Transport; Fri, 25 Aug 2023 23:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 23:32:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:32:52 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 02/15] cxl/regs: Prepare for multiple users of register mappings
Date:   Fri, 25 Aug 2023 18:31:58 -0500
Message-ID: <20230825233211.3029825-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825233211.3029825-1-terry.bowman@amd.com>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: d0320372-253d-460b-d81e-08dba5c39bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4Heeb5GuqX2UWHSUvt55uK6sJJK0l+tGceLZoTNcxpnEG306Nk26ccpq0ui/IUO7VMkNRrT3nCk/oR7g4n7pEpD7gRHs3bW//KCIUC/y2tKCi18Rs39hGR5Jgwd5PdLqAT/eAxt+z9Mj9o2X0FnNbGud054Yme1wkzUvfqKtxW7dZyopL0HoeBPfs27wQzB/tegn4oId19ZOacPY+fI/HqxyflOp17gxgwZqtpDOF/TO4PAzmzKU7v+wx7krje1SFzkHxj1BMGmLd0AaIu0Ekme82K1KTN29rKna1RCoF3K75hxwnot4pnL09QcacqGzx9WWfCv+ozGOCIEpIP+NzEWeqR8OeBstA4JTSa3An4D7POKUyO3+eVXFJj1U6Y6BcNjGYb9qYD1XoQHufOrAieRMrBjlCrveHgZthq154CI3ebpfhqwQCydp7DSdY/ma/ogjDoqcNDiCJW32KaAqjrtPn+F/7sdPmaFbh7MkgoBLPFftMAd30dSgC1avXeQSufddodWop9N/h+g8mUsopbpsxxn3aHPbx4w5RXei4/dp1BN5ywLdCuzIyFrSeCWOGAObpNDk/hG4xtRfrlhMfHakmNFNcMJNH5gdARWgQeyyBhrsiD990Y27QN0F8TUQlxUseCecuzgmXIpxNBvFtWnmIWtG5C+Wbfe7J7vLdabHG2MWm+lu3JnmNO/6FQN4K8Q6cTy7AuUCl42J/K0Vs57Pt0rSvK2w0WXzM5I3VsybtropEO3XZHTmun3TFgBc7KxeIG+2QpXiA2sZN0PIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(7696005)(478600001)(426003)(83380400001)(2616005)(336012)(1076003)(2906002)(16526019)(26005)(7416002)(41300700001)(316002)(54906003)(8936002)(70206006)(110136005)(70586007)(44832011)(5660300002)(4326008)(8676002)(40460700003)(36756003)(40480700001)(36860700001)(47076005)(82740400003)(86362001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:32:55.6283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0320372-253d-460b-d81e-08dba5c39bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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

