Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF27CE481
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjJRR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjJRR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20D1708;
        Wed, 18 Oct 2023 10:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjQ5QW7gluYaipPraPV+zGIc26bGclg2XU5Mejf7OGBQNFleK7PVASGeV76g/H3RFFlb+C4MiInXQuL7wCqjRKjiFm0U4wVEJQ/bgY2PEE8XoJNrobRCAM2q8zowb6qKQTReMHwOIWrwYzC303s80aqqEp1WHfdrAahSVKnJcau513VX4R7HNQQw+9UnQq5/Gv91TzaeUEgMmit0Hh2+ChxeLLcj129EmhsR8ebfdT9U/6r4EVAgRNt7ZoeapkVNCzzpUo6gQppjass/uxL+C9ijdfdAhFlQT5HS/QRDt8z84y1lTIXiIP+3n3mWFEAReLHDqCp2gS9zjBcP8nerQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeD0TqmjlVXjKVielApkR5g5JE+54c6o6acRDdh6RsY=;
 b=ZWQC57WqonrK16pC5cwZb+yR9u83eIFuXBaayPM5sPa+SsWrdP9dPx6XkbjR0/RiQLWzqInOT0c2EJonv//HVHCjDmJV9dYA3PrYTjcYSNGhdkxF4HG0JqJIRz7yTuNHVG3oiGOU78RRqOrJzxlGtu1JCpdhALyBOp37IeqevnKyPXwxygkpAXrQT+vlRiOvwaVYAXib+Gd7w6uunKX0pwBygQc6Qe4EByT437kFmkw995fcdi670MKj4CFhmyFo83HZjAHrb4v6OPWFfsSgnJc+vrjb9ZRwwnXxby9/MmWFOLAwvBjVQndn/QGn8hX+c29Qkv2nacn0aC5F9AKGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeD0TqmjlVXjKVielApkR5g5JE+54c6o6acRDdh6RsY=;
 b=tWrkWxyqVPX2jORMmwkaGBILBGCDIy1kEC7D9xcXKx2yhlM3dztmKHraKGKgReHsTJrrH21bkfAQlMQE+Wt0uLqmb/g/SE+7+YtZqzB/rpH5cDwvCDDrHM2zFV15FXYzOIXIlynmxdoCC5dRtuF3fMNckVK7Duh86KdwJR/AAqU=
Received: from PR1P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::8)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 18 Oct
 2023 17:18:58 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::17) by PR1P264CA0047.outlook.office365.com
 (2603:10a6:102:2cb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 17:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:18:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:52 -0500
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
Subject: [PATCH v12 06/20] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Wed, 18 Oct 2023 19:16:59 +0200
Message-ID: <20231018171713.1883517-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 55206f8f-e098-4897-5f3e-08dbcffe5049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWsBhzQL72TOYta+rfAyHm6KTGkDkXsQhYRsGgfMkkVcVIrI/89rphi5v9X2awMvrXqI070NM27jmo3949fj99jsfdEoHguOc48hQ6cT69TxQ/07vU30C9ohGxqZxtD9Ov5m5mfYJ2gbmXWWA3i5zj7TJSu1LdBc5irhyVqPygTiasNHWtKj8WIUR9TMSp2gIBq/sy+rElz1FTx0CZn8q5dSMCe4yI1lFngust6eWQhkrgkuJz16K54HKfXMF8Otg8T4PqONXVCn2MiPYDhHPLl+uELLrDlVuUp16yg6KWi/hIckHbSdr3F2PUxj2HJmewXxPa97ObImSqn4M18ibaZ5u5MdytJVAhIePi/q+oR8CCgF1O7SuxxOJ91dHkLcXMvuB6AKrFRDnd9DL88pvn4d4MlJ/UT1nWbp2Y/2wo93PgSuKWL6EzR3pJMDus2w2wIxgktlkWvKkzrG9JkiKlug0MwVmrRHvVaDwgNgHmCawJkMDhFXibDTpqJ/LDOmJ2fgxBuCB9hOMdy2uT28IoPvOROCXLSlqPUAx/f6XL11kmKDFvqGYQcW76OMmQXiqilnVcFnInE4dhF4oraJALbq/EcCxYJnUhy/mhLSxAAqu1JG3sjVfMHBokd/zOY8rFq1NsrnU4+e5mAPZ/mCGcv2Yq80wxnKue3xXWtzXAKAd3/DPNK86/Eag3XcvsPbOknUPppNIWxF0jWe5Pf8FzXAuAPjSBNMK/thRPS2lMMHF40te+pbt5BbIIFohtHRWO43mpSCbpnFmcWcyRKT1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(26005)(426003)(336012)(1076003)(16526019)(5660300002)(2616005)(81166007)(82740400003)(47076005)(40460700003)(478600001)(356005)(40480700001)(36756003)(70586007)(7416002)(41300700001)(54906003)(36860700001)(8676002)(8936002)(316002)(4326008)(110136005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:18:57.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55206f8f-e098-4897-5f3e-08dbcffe5049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as for ports and dports, also store the endpoint's Component
Register mappings, use struct cxl_dev_state for that.

Keep the Component Register base address @component_reg_phys a bit to
not break functionality. It will be removed after the transition in a
later patch.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 2 ++
 drivers/cxl/cxlmem.h    | 2 ++
 drivers/cxl/pci.c       | 9 +++++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..7e1c4d6f2e39 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1377,6 +1377,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
+	mds->cxlds.reg_map.host = dev;
+	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	return mds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..8fb8db47c3b7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -397,6 +397,7 @@ enum cxl_devtype {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @reg_map: component and ras register mapping parameters
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
@@ -411,6 +412,7 @@ enum cxl_devtype {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_register_map reg_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 	bool rcd;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f9d852957809..a6ad9bcb96b4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -835,15 +835,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
-	else if (!map.component_map.ras.valid)
+	else if (!cxlds->reg_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = map.resource;
+	cxlds->component_reg_phys = cxlds->reg_map.resource;
 
-	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-- 
2.30.2

