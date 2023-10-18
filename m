Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1EA7CE49E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJRRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjJRRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:30:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30E1FDF;
        Wed, 18 Oct 2023 10:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlWItJhPMWN12YsH4ZyfXaPk8Plv7CESdPycz/uf1wH9NRMu9qKIwx/8RrrN9QcHxGYGQpxYEdGDCNX4o2nvqZTk90TxojQJmaX/R2pdDf3W2v0D69hrrgmhIfrPnMV7Utc/cthVHs8tdjY3T/8/WeXJGu1gmRMp7/u0SwoZFfu0jdIuj8/YAA2ax7xWHrUZMcZNs5nO5NdN3OBXX7hP/1W4RznwJg/UHQTjlyvMXzBjlRZLPFaUeHP4pfGtZk1A4EPmyp90LK4CaREFILYcfgRj3iErrG0J8LDm4cNzW4yrIfu6hsz6kvJMcPRpPb4ivueFyQd0VcxXcbu6QALIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSvQupq1zPeqA9EIKfhGUCfDPjvZA5Z8vWp/24P1mRE=;
 b=j1TY485lbFX0F7R/e46E3x1fw47bIqiQocGxdd9+oIJdeEUPnAO+cM2Yf6Q+vPq+Dv73gsDgkU07S0821/I4U01OoIV0HrgHaSLG8bYG2pJw9TxRbOWhKV+v0BHCRwlqtUhZGBbw0cq6VyhhrBEZly9V85jPOnsYCU5hoTHtsbSmG1RnBAxJ3/PNkwlcknElxTVgBSPQkYY/UiCTr11IKPerHMxWkaLY0AxWdXnEXKHHgs2eU8PTRQ1jH6IjSX3dJfDQxlS8WMLIr7rlU29W9ds/CUg4w6/v+iIn9ctdoSw4f7W/fnx82r2xin9pqV5OZwvyIzT0onWPjRco0LBKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSvQupq1zPeqA9EIKfhGUCfDPjvZA5Z8vWp/24P1mRE=;
 b=dwYi+nC02QPz6FeLLTdDo83l7M3Iybb5mcoBw8JKGJfnU+10c0mStYkXsjOtRtl1RCG9fW78f52mEG9mEHSX9yBACpahPrESveSgPuAl+tgSGxkhcNZdTmHi5eDZUb8UN2MqMnYgumS4IL0fDSXS8Vu13a8RMk4x/u3xQY6+Vik=
Received: from PR1P264CA0037.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::11)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 17:19:07 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::cb) by PR1P264CA0037.outlook.office365.com
 (2603:10a6:102:2cb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 17:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:19:06 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:19:00 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 08/20] cxl/pci: Remove Component Register base address from struct cxl_dev_state
Date:   Wed, 18 Oct 2023 19:17:01 +0200
Message-ID: <20231018171713.1883517-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 775c70e5-b2ba-4780-adab-08dbcffe5568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awhaj71lPlJGNr2eVG6LVQtKr7bahsQnB/ymXbwpUp3Ld5ynSwsXU5Y6bPzoUT+e61u3ekZWohUIshtI4zcjeImTktBtqu/Me9KfEM3XJzdhoigt7Rhuy0o8iEgULGWhi2mHVZKbZ2H5JeXzEvZEk2uu5hpo53TSGxa1xyKdZlS+PSQgVQt5sP9f+RgE1aHdrvNibVBtm9fla88D6lWgjgKGipWWJvVUOLjPOEFznN3Uej2GknVFLub2cfbpzVB/ZG/rYrIT7BTEeVR9UXSXKCzrkqAajLrk1HKk0b0mhMmNz4pw8OHCwkgaD2XgsEuG3XATaJcHrP5iaVaSNV+Rcg5xCqeePHh4OG35tP03+TKcFlRdQxhBnSo3TXWllaNsX/9SJn0BZawRvz1BOfHMLQsh96vm574GNY2AEBfM8pmkhY76SpucRTy9iJt5gmt/gnfLAa8kqQBWoDbtBgE3usPfziBIXFthBSVUzxsM6E2nlEZ0FleO/NM88gWa6u2fmaXKpXaBdTZctKkqDbFg/w98u/OnyXVhGPor5s3kHDQBXIdJ5aFzTgKlfEDCO+CYZzCiK23WySI9i5WlDg8iXznfgD6QJayGp6LRWLaalV9D6nf+WbrZxADIAlvHk4lvS9gPgHkcj3augHiIxE3tsG3ryy6nOPQiJZAYBGC/F0h3mpDRPlpponC/8uKa3/DiifBNicjBANQVfSoU8BvZCMH4G4iCf6J6xGiK9AhZ9GSbCjlTouIse5rwBk9q3/ktUqC2PikUH8d4qB9LI+ru8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(316002)(70206006)(2616005)(70586007)(426003)(110136005)(478600001)(54906003)(2906002)(16526019)(4326008)(5660300002)(8676002)(26005)(7416002)(41300700001)(8936002)(82740400003)(47076005)(36756003)(83380400001)(36860700001)(1076003)(81166007)(356005)(336012)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:19:06.3998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775c70e5-b2ba-4780-adab-08dbcffe5568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @reg_map instead. Remove the base address.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h         | 2 --
 drivers/cxl/pci.c            | 3 ---
 tools/testing/cxl/test/mem.c | 1 -
 3 files changed, 6 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8fb8db47c3b7..cfd287466fa8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -405,7 +405,6 @@ enum cxl_devtype {
  * @dpa_res: Overall DPA resource tree for the device
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
- * @component_reg_phys: register base of component registers
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  */
@@ -420,7 +419,6 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
-	resource_size_t component_reg_phys;
 	u64 serial;
 	enum cxl_devtype type;
 };
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a6ad9bcb96b4..037792e941f2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -834,7 +834,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->reg_map);
 	if (rc)
@@ -842,8 +841,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->reg_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = cxlds->reg_map.resource;
-
 	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..aa44d111fd28 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1423,7 +1423,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	cxlds->serial = pdev->id;
 	if (is_rcd(pdev)) {
 		cxlds->rcd = true;
-		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	}
 
 	rc = cxl_enumerate_cmds(mds);
-- 
2.30.2

