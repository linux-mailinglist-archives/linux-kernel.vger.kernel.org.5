Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6187A7CE4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjJRRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjJRRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:32:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0083592;
        Wed, 18 Oct 2023 10:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQz8djnEkCrd/q1HRF1jvnBdDO2siIh8Ai3u+5UVBM31r2gmBV6H3Q+vSbm41FswJlxetrWs10WD6WO+Skpj+kTd7Ku3WbaKUlYgbElTOBhkcxRvfWFOgfOFR0Fz+hhj53Z6oyXyhuhiz/DsFhE1EmrSSTzazWS+VrklEwqgym8dzBnFvQrLjQpKNI0Mr9abD/hZ/lMkMvh4v/cWHCvn4SotlyPDD6ht6Dmxp/0mQhwlZBI37cElKcEyOZ6EwApbYk9Q9oVrOA6C10UTP0wKegmK0CHUhFTbqTn47sjCdQeKEiOHmikmPaoRUzCVLhlnxd59hJ1v82aGZbw5kiElRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OQKVGh3EZ/j+8iwVEPWfT+hqonAJDDZqGI8hLrumcM=;
 b=F/Ugye1EUinNCLEGTP0VT2NihJmgHxrWTBn5FcTb2siRiam8FvJbj4UOF3/NkWXY7gwDM8zzGXfiAZjz1C0b8T3CQ387ZnpV5F5j/lksmnZT/YrUNLeo3df0QDSWG3mXaFmU69u6HHCnAa+6aasL0n9Gmn+j3ezPTsF9Brr51GceFEORwC05ZGickJx+wKFBbFctfydxwLYLiVjUKjWciZ77rZtlHqW2K1JYBBt4jd9wx6O/1OGJMN3VRBpECRAnovrxw/P5N+VIF9vTybNM3DTLlkOIEMp7i3tkytL012dnezJHDx9pEVRw4ADjcR/GgRYPLP95ms6sIybJ+RFuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OQKVGh3EZ/j+8iwVEPWfT+hqonAJDDZqGI8hLrumcM=;
 b=y6jsoUawkF660MO2zOx8MJDEtZz25mSND+Beml0WlNOq9ayHr2ve0WNyulDmNQmeShhBThYGhz421RBdZGNkL4lGWth3uxOgm+V8LwQRm1w9jf8Xt01/WrmKcbOWEB83cgt+kO+MUkoj+/av0vjPFsZWXS71XhZsRhs+v2BWxT8=
Received: from SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:20:01 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::3) by SA0PR11CA0186.outlook.office365.com
 (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:20:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:19:52 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v12 12/20] PCI/AER: Refactor cper_print_aer() for use by CXL driver module
Date:   Wed, 18 Oct 2023 19:17:05 +0200
Message-ID: <20231018171713.1883517-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e9582f-8ba2-41de-5aeb-08dbcffe75b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYEN+XP1Ly/xvnRz1HX47knYDC/uFvO9kbk9aUH6BzTip85n5Aovj+d2fSY75MYSaQWTVIgVivmkfvQE+MZJW5SclSNJkzFhxTRJ31hSfPBN3iXi8S+UWgx7fJT9D2hmWEJRKxzJ8KuOMs6mEF3TXMWv9/G9R4so5VHpVI2uAUcyZOIiOflSQiEiSSKrN4sMZAfMJJsdnBnwXVdlCPyaEe7c7+MZBcOzv7L9mDG6tQo2yw65DCA8jv0YNtZgNZPO7gV1ka8UZLC9f04FRe+hfR3YIrqy52jwJDhUZ07oLrKpHVe/73Z3e3Z21cUqMsCieSRAu7vfWRz/fpm5F7TJBQYIus8H+aJG7+l6qOSNOOx/Ivy2M+I3mkXOiITGovG0DDl9V69P+VTp0NYDorV8hyRW76xzMG8NdUa5vOjbaIegLOmyuZ3z32FYzM+A86ZIz5KdO3gztJDAZWlRCC6hsb2HkHaalyZheOKejFyO/QcJOwJROzNOpON/aIegcJoXYiO+vd5NijRSr5HnRyRBaVL5KA8Kevpw2sLpagJv97MW6l2XAWUh9gePqRFwV8O1Vdwmkjrf7L0ZrAYePGcM7zBQtjBfa7v3Yiy8SXR5DlM1H8duQUu50VsAV4x/e00bQZL6E8dpXp7HIC/L/lT4NgvH+9FMD3BUDAz5vuxgJfxWv6t9G7KfzVgsUC1i3gtlwb4P3Y/qpAXcOaZb0O61CpveO2kxt1gMCX4xYv9a7NMc2e/3sxvosS3YalgxkLJMuuMDlu6aComhB/jyQQzHt8sjfKJo3n27FjgFuroesm8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(478600001)(5660300002)(70586007)(110136005)(70206006)(83380400001)(8936002)(8676002)(7416002)(2906002)(41300700001)(6666004)(54906003)(316002)(4326008)(336012)(40480700001)(47076005)(81166007)(1076003)(26005)(2616005)(16526019)(356005)(426003)(82740400003)(921005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:20:00.5385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e9582f-8ba2-41de-5aeb-08dbcffe75b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Terry Bowman <terry.bowman@amd.com>

The CXL driver plans to use cper_print_aer() for logging restricted CXL
host (RCH) AER errors. cper_print_aer() is not currently exported and
therefore not usable by the CXL drivers built as loadable modules. Export
the cper_print_aer() function. Use the EXPORT_SYMBOL_NS_GPL() variant
to restrict the export to CXL drivers.

The CONFIG_ACPI_APEI_PCIEAER kernel config is currently used to enable
cper_print_aer(). cper_print_aer() logs the AER registers and is
useful in PCIE AER logging outside of APEI. Remove the
CONFIG_ACPI_APEI_PCIEAER dependency to enable cper_print_aer().

The cper_print_aer() function name implies CPER specific use but is useful
in non-CPER cases as well. Rename cper_print_aer() to pci_print_aer().

Also, update cxl_core to import CXL namespace imports.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 1 +
 drivers/pci/pcie/aer.c  | 9 +++++----
 include/linux/aer.h     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 41a8aa56cffd..802e85321a63 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2101,3 +2101,4 @@ static void cxl_core_exit(void)
 subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9c8fd69ae5ad..6593fe3fc555 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -759,9 +759,10 @@ int cper_severity_to_aer(int cper_severity)
 	}
 }
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
+#endif
 
-void cper_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer)
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer)
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
@@ -800,7 +801,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
-#endif
+EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
 
 /**
  * add_error_device - list device to be handled
@@ -996,7 +997,7 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		cper_print_aer(pdev, entry.severity, entry.regs);
+		pci_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
 					 aer_root_reset);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 29cc10220952..f6ea2f57d808 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -51,7 +51,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
-void cper_print_aer(struct pci_dev *dev, int aer_severity,
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-- 
2.30.2

