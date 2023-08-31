Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7372678F1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbjHaREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346856AbjHaREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:04:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488410CE;
        Thu, 31 Aug 2023 10:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR8ENDLwKYUjtQuaXNiHoJ1+jCXHC+caljLjgsnAsIDDQaDDPgFfV7hyztRblohI1VDNKoalgF6smyzzL0w0MgN/HHsW/uoE22pXV3f/I3gQaBVegomoqb86pmR0yJl8PHCoU2ncq2RpAuew/CALo4TlSi0knWZCwLuJqK0Bs7DcVTgDQYVn15/ZZPK4ajokrBHim5S563KL5CK5kq1zDtC6tc+0u8PGH3og9o+z4TG02NXq9iw20TahxMRb0Chqcylmd76HZ8bbEaqNLYhI3YlolAB+WaoANuIRB+moK+b24pA08yT/rSQBlDyQ0cabdWjOfNT4oERVInUsGmLlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrropQhLceQl7tGToOfeISiMGtGWPfSCW9YAyl/WFo4=;
 b=ZI/XhxUFSNJaZ3uCwi8W2vHV1r7kTYa1ggQ/dGT6zFQYvCF9f+9HWYXVCJuU+LO6LxCKIRTIWex0Wnwg+OH5j4aG5Wtk64etqmHj7PpEscBkTRMiEq9d/cyyfP7PazKjki7v7Dz7uIZ2nBUAEV91iQ2qglzXH6aby1P7CyRk/AYoNnhcujFnoUs+hOpISFgsmxyUK+E9UmNaxL7E+zEwjnBOz14vMJzuq5zUtE/qFn/stXmqsA2k7mTWWB1Dcx3XZ4ux2u+ABGQyVdRrDhAS6GQVlIooxxCbCgBPLvJ6Wcs95nEGNaxZaEZy6ofRcVe1QEqsBTu2cWmfuSCJV3bV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrropQhLceQl7tGToOfeISiMGtGWPfSCW9YAyl/WFo4=;
 b=uhNSg2F+Gi59VoBIgM8/5iIYuZK+CVbH1TZXMvVhK8TwIh0my+azS4yNRv5nvQGAi2GLrNuTR7CwoguRqSuM8l7YhQkzWynSFLtM2OfK/gOaTmJFEtJC7Sejh8DJof2uILVl7F6qI+gPR24yrSsluPq1/oGHjY1Jm+np4hPEs4E=
Received: from PH7PR17CA0031.namprd17.prod.outlook.com (2603:10b6:510:323::14)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 17:03:34 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::66) by PH7PR17CA0031.outlook.office365.com
 (2603:10b6:510:323::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 17:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 17:03:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 12:03:29 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 11/15] cxl/pci: Add RCH downstream port error logging
Date:   Thu, 31 Aug 2023 12:02:44 -0500
Message-ID: <20230831170248.185078-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a67cb5-a3e9-47ed-017c-08dbaa4435af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RIGUsqiZK71Ts5dNRwjVFcjQI+mUMmMmCrWiOsa7cY4f4DtTdwsAsJJErJuLqOrtrG1YKa0TaHSN1nryeq+B7yZv1NwUMbVPNIbtr9nXj/ddvMAdOGpCoun09OCY/MGhDzPIIpzuCUcmFON4AiFSGiA8eIk//qNUaG55az7EJ5N6siKq+H/NgmVJr/xHuTuiNal/guoGJD8l0LLHWxKnnle1h541n+3brmAEzX2RFXPH8JpiHkyllLQjNznqB+FBeIgd4Td8BJgnnRTlu2hGSDnOnNj5jdgAKZtqMrW6H4mnfRXPtRriwMzDjT7KgPaqoubb7fMLJwF2bsAgnLSQ7zXzZrMYAqKF+EftEXKMRVFY17uF2gd1p+DAuHpquPM/hp9nNDec86lL9fu0gZLwUaAzfW7mCq6LZ4uIhIBkwNlE5NX2EwzCHJrZSe44tEVqGV4srGqzKH4LlQCpb0fcTFNlmbaopNCWSeqDJGMJljYO7Qo9bWjZEo970QcnMc0mlsjxAbWECKuzdcwR9XZZgMzUhzRWn5MhjlGh6DBE1nPdrm02W5bYWQcv6CTrv4eC11ilQ1cgj215ZEIsRzlrwPRVVbaze/F4bUdJcPhL48pDLnNU8wgf6QkTWtwddX4UmUF1esQNIy3FpDqJzUR985sb8wqlq4wCLUhMvJFt7n1qooHBs6QXNI/S5RpbsCdVyngbb16XDQHl7mPmPrLZWX6rIybkgeAeeKCYo9cQ9eEmlmAFHFhFJWOcWphO7Q1Vxn5lAYv8C80l1+hKMV0vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(6666004)(2906002)(5660300002)(86362001)(316002)(478600001)(7416002)(2616005)(47076005)(4326008)(8676002)(7696005)(36860700001)(44832011)(8936002)(40460700003)(26005)(1076003)(82740400003)(40480700001)(41300700001)(336012)(426003)(36756003)(356005)(83380400001)(81166007)(54906003)(70206006)(70586007)(110136005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:03:33.7435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a67cb5-a3e9-47ed-017c-08dbaa4435af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCH downstream port error logging is missing in the current CXL driver. The
missing AER and RAS error logging is needed for communicating driver error
details to userspace. Update the driver to include PCIe AER and CXL RAS
error logging.

Add RCH downstream port error handling into the existing RCiEP handler.
The downstream port error handler is added to the RCiEP error handler
because the downstream port is implemented in a RCRB, is not PCI
enumerable, and as a result is not directly accessible to the PCI AER
root port driver. The AER root port driver calls the RCiEP handler for
handling RCD errors and RCH downstream port protocol errors.

Update existing RCiEP correctable and uncorrectable handlers to also call
the RCH handler. The RCH handler will read the RCH AER registers, check for
error severity, and if an error exists will log using an existing kernel
AER trace routine. The RCH handler will also log downstream port RAS errors
if they exist.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index edfee8035820..1c40270968b6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -728,10 +729,107 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
+					  struct cxl_dport *dport)
+{
+	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+}
+
+static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
+				       struct cxl_dport *dport)
+{
+	return __cxl_handle_ras(cxlds, dport->regs.ras);
+}
+
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	int severity;
+
+	port = cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	put_device(&port->dev);
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_rdport_cor_ras(cxlds, dport);
+	else
+		cxl_handle_rdport_ras(cxlds, dport);
+}
+
+#else
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+#endif
+
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
 	cxl_handle_endpoint_cor_ras(cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
@@ -744,6 +842,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
 	 * CXL.mem operation, and will likely crash the system. On the off
-- 
2.34.1

