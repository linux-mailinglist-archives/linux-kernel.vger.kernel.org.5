Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0303F78F1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbjHaRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbjHaRE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:04:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A24185;
        Thu, 31 Aug 2023 10:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa3bjVYrMv6FFcX23/AZlUyV9OYkedZs52Jxz449F5oJNYA73A2XLvN8236u642OJMcXqXgSz/s3pqHtvDGY7j2z10a3RPVkZF2LhsGbZDD8qb7V5r2dW2I/ekyICkVBhmjch7F4/rFTq5eQi4RzOBmcvqguYEe4me8kCOGruIkDSILWW+KoLd1Qf0ZIMY375S7tSDJAIuuKa/ePGxugypC2Q9uFAZY1Vbjbo9ofhcPbK5B15upPy55G42FwaCMota/DPn7DzB1zIrIOWX6eeTbL57STMDQdgQIH+SEJpe/fLsu35NHKCE5d2qRzROHHGwOSYR3sFqAHRmhB4D7mKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omEvIhe6j83LbuOyZ/SUqwoTimOun3G14ApcXP+8OxY=;
 b=nNY539jmlHZFx4bQdjp6jYop/bya4a6vHYM6I6+RB4+iSeb8J+o9/+LXamqMTeoW5LJPd3QKiR5nll6bFjblH8ZFFy888Bf731Ptmk8VcjJxdxlw1ribBfP61ZWmmYa45kBl8kd5uoJd7VkgaCeUGAMDJBPs9Mrohi37lIlwg+Ro1IcA2BPhHKtDYxLF74I5VE+xAe0mnQncuRkHcPAgwTN0nzdl1P/8wDZm8HYJmouGKo0d5ICKgdHGIdGMdAhkaQFg/JYWek3yJZNqRjawmEV1Axw2me+F5pfhN8oNxZBoP+S7E8A+G4ifthEnp98aGtrSHg79TQwuiEZU7UOG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omEvIhe6j83LbuOyZ/SUqwoTimOun3G14ApcXP+8OxY=;
 b=qIvLivNuWAu0YsqH3DMqpQdIX8GO+/eOmUHU8j+D9/8KHewlI2RT5u2eJhFE7SIXuInVc0VCeIesdE1nU3sk6L5W/SewXUTQ4zm8c7/Z2V0OkMrfhDR/EiX6dsXMkendE/aXEgmYtEUabU9iajo4Jl4XEtssAfQ2GXKTgh/h3zw=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 17:04:07 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::d7) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.14 via Frontend
 Transport; Thu, 31 Aug 2023 17:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Thu, 31 Aug 2023 17:04:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 12:04:02 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 14/15] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Thu, 31 Aug 2023 12:02:47 -0500
Message-ID: <20230831170248.185078-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831170248.185078-1-terry.bowman@amd.com>
References: <20230831170248.185078-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|BN9PR12MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe746cc-f40d-4f4e-ac0a-08dbaa444932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAE+79CzgqiHJZla8ChxgZjH7eRsk8AHQDLLiPq/7wJb92KxSjegvhPdr83FCdDCcd5SB8KNkQ6VGuMndUHmyTraKc5slgNdUXu9/RD1BmGhjFO0H1UINcTB/ogJLqegsctN3f1q2xyo4ub34SDvwGM8XzL49bz9ozgo4GF04YZw1etH2O5AXj/35ZT1g5CXoeRb2VUVuh1TtQRGWA8eqr0kwp35y4mWb0bRmpR+yBnFE2H6ccktC6rz0In1FXp1U5gRN/K/HsbbQPdTiGbqjVkKBMIO4kpmPnwcBNzZBRYGfkVZgLAUzkrRUkMQZsQCQ32mSDZ9TOnihC482VnrYFzTMZqzy++KGOaCwlfme5VK7YZcFFQRy/lwV/OMJ1E0Vxin4XDSWfv5u0KKwJ3+sDCay4bw5zbUy1P472Ep0v4b5S6kJEb4lZCGTwXTWI+z/oUs51IVaLTvJQIOOxBAG8ulvkVMxnNFmwmFat3UQQnNjEWqy5Wl/gKw5oKMFHaVUTnH8kJhYdd/Gley4NXCqCawfg48vOBGto3Z4ts44DRb28crKcZoGjrksgNYUBsEF+GZj+eqzNgcVdhJnGLvb8LuQgKv7SYFjp4J0pogZfTMJLvKGur20dxdtkQABHNuyqKis6wmZjUflLkD2sswrChzgwTGsVOj1AgEuXj/GYFCD+9S5+ntxXA0qtNs2/MsjYbRpUDMoKP8tPWwzv+7HXutBsca58eePehFuo9BwnaOwcxoasGYdXovlmhuGc+6WifjNDExf5OpfdvxObOl6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(478600001)(81166007)(356005)(83380400001)(82740400003)(26005)(16526019)(336012)(426003)(47076005)(36860700001)(2616005)(1076003)(40480700001)(7696005)(110136005)(6666004)(5660300002)(7416002)(8936002)(54906003)(40460700003)(36756003)(2906002)(44832011)(8676002)(316002)(41300700001)(4326008)(86362001)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:04:06.4519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe746cc-f40d-4f4e-ac0a-08dbaa444932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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

AER corrected and uncorrectable internal errors (CIE/UIE) are masked
in their corresponding mask registers per default once in power-up
state. [1][2] Enable internal errors for RCECs to receive CXL
downstream port errors of Restricted CXL Hosts (RCHs).

[1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
[2] PCIe Base Spec r6.0, 7.8.4.3 Uncorrectable Error Mask Register,
    7.8.4.6 Correctable Error Mask Register

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pcie/aer.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c354ca5e8f2b..916fbca95e53 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -948,6 +948,30 @@ static bool find_source_device(struct pci_dev *parent,
 
 #ifdef CONFIG_PCIEAER_CXL
 
+/**
+ * pci_aer_unmask_internal_errors - unmask internal errors
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Unmasks internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask &= ~PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
@@ -1027,7 +1051,39 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
 }
 
+static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
+{
+	bool *handles_cxl = data;
+
+	if (!*handles_cxl)
+		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+
+	/* Non-zero terminates iteration */
+	return *handles_cxl;
+}
+
+static bool handles_cxl_errors(struct pci_dev *rcec)
+{
+	bool handles_cxl = false;
+
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(rcec))
+		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+
+	return handles_cxl;
+}
+
+static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+{
+	if (!handles_cxl_errors(rcec))
+		return;
+
+	pci_aer_unmask_internal_errors(rcec);
+	pci_info(rcec, "CXL: Internal errors unmasked");
+}
+
 #else
+static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
@@ -1428,6 +1484,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
+	cxl_rch_enable_rcec(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1

