Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5C78F027
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbjHaPVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjHaPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:21:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B657410C0;
        Thu, 31 Aug 2023 08:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVyXXiL3p3uVT12sRbl2pIP1moZ/Ul/d8uG24QqwE9LQRCFTkpQejzUmSyNsJ3HgUjhk/FRnyOJYcEWcT5W/NVu0TAg3pQhtZTAg4MKgYuZ49/hZ+rP6nWUlyYDHicG0JSgJ7x0KwbJRAswJDfmiGygKc21UClXym8QMeeznhAG5w944YhwLODHQSy4BE+YcJo77zvsFoaSpEadtz4LaAvnKDqYWOijJni56FQWHIMbt97p7FkanZRcrC2B5BPfxGms4sUawWUnsb/snioEQmx/qnyw27bevE2ZcbLPAaxKlRCFi51h8DFJ08yLsbOPCmTh08BZnzR4kepa/j+Npug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKlpMDJDL9fWN792EBmuV7O/wcdDmYalrl04zaCbHe0=;
 b=myDcGJQA5uaMywE9EClV48rOIQBm/3YrvfSfAdHuDhKP64ajMIv1IA1qvun68GeTLBHi/NiExQW/fS2Ve11w7ManXzuTD2ie6sKDWx99qQoYhr3s+wG2GuN9JUYpC+8sz+xogZs/mpzDzhcwS4XE0mz2YjVe9m6ex005ntZ4hABtdkHOp/kisK4Hpw03xZ1v/aMjWc5IuMrJXNQTalChfmrU/cWdsiMfprKljySMYZ5kOqssYx8LyVfW5ltCQm8Cn1dPTL3AVDfu+znutzxRcnMV/iLg7Ar8I10BCjGJh9KeqjRaSrphWQP4YMw3+F1g5QRXmXQt0FmGxGQ9zg6mLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKlpMDJDL9fWN792EBmuV7O/wcdDmYalrl04zaCbHe0=;
 b=fpwv1BdsRrZHSR5luhZAUpsq6GBS5VY19f4KGmFE/AUkX+AP/wdNrYoU+aYxZpqUI1FHajgSzFFvc7+VeasqHIJ5xu1FxX+qTcuJV/cHqggYKKr+y8R+lQLGP9IJ/mpm53G5k6bkdXH0fHNK3vFcTAhPv0y7ztNyAsllFsZHu/E=
Received: from MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) by
 DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 15:21:30 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::31) by MW2PR16CA0010.outlook.office365.com
 (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 15:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 15:21:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:21:29 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 03/15] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Thu, 31 Aug 2023 10:20:19 -0500
Message-ID: <20230831152031.184295-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc8ffae-ea59-4405-ead0-08dbaa35f408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQAAejFZcPOf+v9qLHfWMWgWF+RhUsCFjxdp0YWwneYt53RhTyDqyejkaF2cr8Qfbk/zOk5y1WtaJeCXchOr8g26CrpACdmgNz+ZdilVi2cn2KWHrMqC6Jb543ddncOjt4vCNDyPJ7PFfSRJVTrbAVWH2aDygVgVPMiIHFupplJBUo55C5uBXnbWfad1KXRUPKGmanmmy7CjvX2+NGczNyHF4RIFokTUx8ZvT12Oh+CTyZ6sEtZG/S59ycqDRH2BZ+H/c2ftuOwMkyPbQxuJhCYDE+rx0rDAbBE5X6f97ZV1XpzaoiGNsiyjir2uKxMLAZVaAapFroIRAMtmwU9b79AnYzRm1/iQQlwW6fzMxXHr/s4uNJoSsmOUVpsdGD6G0tv52QzjQzTtta1k9fP0wzC5+6xiTonjc/qZ8I9qV5EMenMoVQkcQ/DNgLDlTzoACKldpCWJkAzbBt4l08lrDZJTaGhZw8g80Q4p9L4XX5wmUGy44zjjOwadVADKVa55fv1jt/nAZioijU1YONz+TAjsVemTlhOLujjvnObgT1lAW2XJJcFzkMdkwx7UbfwXd6WvT9rt+cRmB1NaUk8cfaXhQwkpUJURkvLh8qLh0kb887t1Cvs5BvgPO4NTDF1JZCstxMXl0ZTw023gzSyPJrs16XZ66hnapzKnR2hNdWYSrPOcgH1JfeLHxompBgtK6m1vx+AKMPMWa6rtwlYUtrEbeP5vl1vEkWKlAQ57KZ8QGB/TRj9DDgwc96EOxULbNdVhAHMkzWQJwO2x+hYi3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(356005)(82740400003)(6666004)(7696005)(40460700003)(36756003)(36860700001)(86362001)(81166007)(40480700001)(47076005)(1076003)(2616005)(2906002)(426003)(336012)(16526019)(26005)(83380400001)(478600001)(110136005)(8936002)(70586007)(70206006)(8676002)(4326008)(5660300002)(7416002)(44832011)(41300700001)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:21:30.5708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc8ffae-ea59-4405-ead0-08dbaa35f408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

Same as for ports and dports, also store the endpoint's Component
Register mappings, use struct cxl_dev_state for that.

Keep the Component Register base address @component_reg_phys a bit to
not break functionality. It will be removed after the transition in a
later patch.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c |  2 ++
 drivers/cxl/cxlmem.h    |  2 ++
 drivers/cxl/pci.c       | 10 ++++++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..4c4e33de4d74 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1333,6 +1333,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
+	mds->cxlds.comp_map.dev = dev;
+	mds->cxlds.comp_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	return mds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..607ee34b0ce7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -382,6 +382,7 @@ enum cxl_devtype {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @comp_map: component register capability mappings
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
@@ -396,6 +397,7 @@ enum cxl_devtype {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_register_map comp_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 	bool rcd;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 88ddcff8a0b2..f8ad601b314e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -836,15 +836,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->comp_map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
-	else if (!map.component_map.ras.valid)
+	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = map.resource;
+	cxlds->component_reg_phys = cxlds->comp_map.resource;
 
-	rc = cxl_map_component_regs(&map, cxlds->dev, &cxlds->regs.component,
+	rc = cxl_map_component_regs(&cxlds->comp_map, cxlds->dev,
+				    &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-- 
2.34.1

