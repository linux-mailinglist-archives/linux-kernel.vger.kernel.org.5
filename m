Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705A67B0943
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjI0Psu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjI0Psg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:48:36 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893822CB84;
        Wed, 27 Sep 2023 08:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz7WSDXgFHpcq1MxQ+GLFP70rU+f4zJIlB7fdl8kya8QY1+wDKgou3kHucBp+KcStcIv/7qCjzwP+0/lx888cpBHISa8/CSW0WpadX7E6rOTpsOsPjwfgl6EWe9kN3GApXSxcWGCnClCpZnAZX4IK8W97Y53ywr9xXbCXGAIJ7FNxYxN3172UmlrhkBLWWzylpVBmXhn9B7mj9TGkCzckPBWaMWnGCAK80uRjg/SPFC8uzdbI76ThoC9lstRUvVcr08lVik3dcGkm3V5Sphy61/6uX4mwkHYjbAPF8lQ1kjyqGHgVNlF3iN46U6jgx5N57AvEc6kjMTgpn8sPe6ghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgmxzE91/Y8CVse7GAXkYVZqkj2HZN+TVXdLm/OLf4w=;
 b=eLyuWcr67KKXjeW/CSCYQhnFg85b2dV2x/LEXS+7BwpVkLImX8qhPc3e3f6BwdczTBuq0Jd/C8SCLMWv8AY3mGJzPTnivOrnUYBX3BIQL43vTxAiR4Au1PnZOoiBxM1cVpOCI1mWeJG/G3hD4JrDhRGMjMDKmKyH0E17v0u7rvB3h1wSicLoGtmAuOej03C5JkAEXXe5+gErOm8GhcqVHcdgWyaH4XK4+uyviEdfte9rpkjLmz+GaYxNPLMXHMzT6aFdyF5xkXxrMlnT90JxV7fN59KtbLN/w2JuKO9VMciWbNy3wYtX/036UVjzwqunh+NSn4CSu5bMk1U5FSPeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgmxzE91/Y8CVse7GAXkYVZqkj2HZN+TVXdLm/OLf4w=;
 b=5Pg/1dUyfStEMO+izPuvmkKYPacwI2hmkYWyCdTF7SIKnJP3VI9lbYS60TNjqJOk71m4mnscURWFqUjTlZkHpsRGfopHB7HWJ4J/94SnyoZOjaTRt3fqIT3tP939UGub25P5+oSGp5RRlPWAtJ304NoQaOt3LXyufkBKdtwGk6w=
Received: from BL1P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::30)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:47:45 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ba) by BL1P221CA0018.outlook.office365.com
 (2603:10b6:208:2c5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:47:45 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:47:35 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 18/20] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Wed, 27 Sep 2023 17:43:37 +0200
Message-ID: <20230927154339.1600738-19-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 11afa12b-e572-48cb-e95f-08dbbf7117cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z55Ao5BMt3B63wpzpWWmxiwBTckF5BjFWD6Yef3rqAsRyQx2uOK2CJVQK31z0+TeQtoKd+Dy6WMzvMCuz6QaMhFtFkiG86YGi+HCDgM64pe9fRF0l8fDdWAnDb9Zi1M2JnO8XXzcnk0jbxdz6wZ7mxn1u9ScX61JAvVrM8fo3SHlUWA0kYJmmTEyiom5I2XObvaK91vh+okRK62/MLDKFMXTlUNUCKy7iqCUxkFiFq8nFrEDvFy2I69oi1rG10fM2r+rDAlcxH5epWqJkfTs177OqpZvefzyqfhd3uNwOnEs4kR5pOkqyPxCMKN0hhIauohzpG2yLr19LcM53ax+Jw1IE8DfQbLrlf03oOYvuXsFMkt5cgWfdDqDzECujXv2G1cm84FTaZRV1fhq9M5E8dMJ11WdJEUXtBvEN+YXTvvA+hbOm2quiiqdZ5EsPeYRan9RdMqLZvUF4w0ubKtle12sTq5bqOEcr9MRQkKKPc0lu5oeqEHEQcr88yuUgnsft/qaxf8NzbjBh9dw6b3OYy9bypW6hbggn2srGDbFK+U0V+nRp7wumIxdTkg9ufEPlCOzePMrtwGbaQMuElqry0pQpDoJZ2vowfVNinjAvNA1PMJYdWHRwmdyoVgZSWudthTudK2zzRopI4WugQp07+hU8TAswlC+2CUE5VHSp1IHVg6MGHjQ8lHljtcUxvvDmA4RRNkt5JOU3RT/bBkNQUsQIf48PrcAnHl491RIucD9JFZxwConnhAF89nlRIgRZqwVjY+LzwouIlAX836D0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(478600001)(36756003)(2616005)(26005)(356005)(336012)(426003)(83380400001)(82740400003)(16526019)(81166007)(47076005)(36860700001)(5660300002)(40480700001)(54906003)(70206006)(110136005)(7416002)(2906002)(316002)(70586007)(4326008)(41300700001)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:47:45.4299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11afa12b-e572-48cb-e95f-08dbbf7117cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 9f420733996b..de63cda8f453 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -936,6 +936,30 @@ static bool find_source_device(struct pci_dev *parent,
 
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
@@ -1015,7 +1039,39 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
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
@@ -1415,6 +1471,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
+	cxl_rch_enable_rcec(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.30.2

