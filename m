Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9978925F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjHYXdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHYXdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:33:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6E2114;
        Fri, 25 Aug 2023 16:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb6N6I4mtdY7I+vUVqArybTIa79kNODknG8sbloOe9k6u/E2OBD+BffCYeqxp2XlWLl0BaxQPXmXg23CTRGys9l4rkwbBK8KEKYbGB/3iyUb8P3nWIySlBUCdlF02rTwD3hDojvxevxbUA+0Bf4TQgEisUkaHczRanweQBAc0FyGoWGZKzEvi3IAdn4T+8FNd/M4GpDgMIIo1nElwNGrRIAcosEovZLaafcUrAMcvY2+tJfcL5wVWw9OpjEuGaYZWu3j8gtEWtujxEnIzb58j7PtuE77Qys6V1Yqe+j/95RHfZMbAm8mOjMm3rA9QZWhc8dq9t31ZurCWxmoH0W5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKlpMDJDL9fWN792EBmuV7O/wcdDmYalrl04zaCbHe0=;
 b=dyLgRvJ5hMQxVbxCwexZDsGLVjVvKj8t/oFXn18TS/cX5jqnxHlFHwDLvHGpKvMLbmFIZ/LDk1AbGsug8q7jvQ6e61cUzIXFe1ojrARVgMYVx3lsY5rh+n9xck+/DnDpvV5pMeagvEozZcZZwRxAJvsMH6JLNYwWK29jDxgjflV/bJ6QAOHxMJxKAKHd2r+a1E+nItI2E++lEZCZssAbXjwtAWbKrXK7Wpy0aO0E8VNID3AukQYzs7bdmcfWF4F+/9CGLGjH3dmAx5BypBx1PupwgnkSLkt0CtOLOfJZBzRxzJIH0Ha8uarA6BjRQch+3DrpkI51JYea4LLNFi/6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKlpMDJDL9fWN792EBmuV7O/wcdDmYalrl04zaCbHe0=;
 b=BG2o22xpqmY2/FgH6PhloP8UGhfgEub+n4CXJDmMMNEVXJOQICHpJEl4TPDGURLYLv3GEG0o5hxxraoqResiWs3jddRMgq6yHFA/5zzvvDKRw1AyVwNJ2nhvNoQGH4OGCx9VxE8qc9UhuOvaiNnHR5T3NsTBTiol49fInH5hqTk=
Received: from SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::11)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 23:33:07 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::47) by SA1P222CA0165.outlook.office365.com
 (2603:10b6:806:3c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 23:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 23:33:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:33:03 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 03/15] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Fri, 25 Aug 2023 18:31:59 -0500
Message-ID: <20230825233211.3029825-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 2379d9d8-722f-40be-8b9d-08dba5c3a1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MWnvzybFrYyf9DO3b2XYpY8PJkEWC7cYyZT0pi92JKtV/UfDC3zxBweQ15qC/gBq/TCyzaFj1ipnvGFsgz2orj5cMf1/TBO2B5JmtQcwfQWk+CqSMV7Z1SCJdItiFxuh6b3zJZmNgWsnnRPvEZBfjYIaM6eOg8fg0G2gEQPc97FMpj/uJ0B6K7SjTuDO+HifdIcKqTkVK4Me7KL1t23MxuQ3UfVkCpWZB2XsMR09LUJCbbTJsUkPHXrnOdn7VSzGE369vsJyyc5xDmteCGvDSkY9KDvWJ9BL/NHjJ/Hu+qOG9QuBG/Wn/V3BqLdlbhqRz5wRVuTcMR70xQU763u8W6oDGl7WsRNn4i6Nh85vEvLvH+fYwtoqMVI1Vp/KFDsaxStyOdjCrKvPkflhqCF14WPABcjs06WOo5AFJ9YCB3Wp2npiGt5VuKU/qyhpFRmxDI++Yz7XWPFs6+EOiN8H8JOyLOvyN6R4Vb6ahSCxu0bsVDVZEJgQAv13p5mMk4w0vOMM2i9BLnJB0kwNbqXbGm4sgMC9m0EljsGrgDRLFQNa6DQZt8pqJOiCGS5WwepxLIJalYGvf1qVUgjG1VTR19Tni8Jmdkeus9EZiawwS/VZ7EHT+rS1ZOEF4X6+7l7EwEv0VZMQ7/cyI2uk3z+Srim48lEfLZ95xmiVxSWZNibS859Scby1Vg7ApFGTKkTyp6G6Tu4EDEHQhjQ0DzVx/Ljyg/7r3zwLuXk+rGhrEGIdnH3XtdK5x04IZOY9wUyf/phCejLYgHQxCf4vcwRHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(316002)(6666004)(36756003)(7696005)(70206006)(70586007)(86362001)(110136005)(40480700001)(47076005)(7416002)(26005)(478600001)(16526019)(336012)(36860700001)(1076003)(44832011)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:33:05.5314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2379d9d8-722f-40be-8b9d-08dba5c3a1db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

