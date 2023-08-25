Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45AC789270
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjHYXgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHYXfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:35:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5FF2D68;
        Fri, 25 Aug 2023 16:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq1BHnNwRh5wr5F9eXJAG7ohdLqVk69/Vv2c3bgxMrHkkSmQLr3tPH+9/xtYNMThpjNHd0rAAVpNW9qRtcHEMpCN48bcUD3G84KMtk2SsovvdXksdDJsNrjccsIiSs5AvBspp1Sp+6QIq2JiPf1Rr87xx0obnfiDqg7SNBhlHkWTmzuGNYO+gFs6GsXOHiYIjQCyE28wKk4JoBPUww+INJTwoLus0rRCMv36YeoGsgoXWu1evhtxkQ0Jwzf4iC8j4vvkHT6GOFf4Sq/rFbXU84A/6qJwpjQIly/h96TUyLgIbY03e8ypyUzed/pgr8u73NrhFol2zQvE+hP9ANPSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrropQhLceQl7tGToOfeISiMGtGWPfSCW9YAyl/WFo4=;
 b=gKQgV36KlnW/fvinZ5xyx2lbtEZYjRo14WeeBxGjWEGqbg59lYlmn0XVsnT45ovuV95LkwIz04X2ZZjLp9MVb4IqkzQDDMvQEGzFvkvlHOt/eeM4F+n3AkU70utVro9zvURFZl8NX6Y7xWvuzo99SyxLaVk2FFaq6zFdTrP4NFKgpZews59LaIxpzXIrK72wJlPdZJPKYFOSJRGAguVtKM9NhC/lPRPAbZYogoIB1rIury2qNAODoeI7gE/TsZaauA6i5l8NJFAKuaAkTBCx/4O48KtY/QaKM8rLelLGzwBPCj6Txme7rg+2mtgbEMsSkKZ9qsWPqAQu4bVJmh2lJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrropQhLceQl7tGToOfeISiMGtGWPfSCW9YAyl/WFo4=;
 b=hmNIgBGAsoN0uHSH4BifGrsM7Snu19KS8hTlqIjq5rozA8OcHSDuP6jaCfsY4cYN+mktP3d8bmqvlbSgUv4ENTQ9JKSOVwON7BTzEALFcZ3mxRxCZa2UQMwq2kPJPaZCxwn/SgEbRk47aaHR/KOK2CD/UUTLi2qQqoQsPp9Jihg=
Received: from SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::23)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 23:34:34 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::c6) by SA9P221CA0018.outlook.office365.com
 (2603:10b6:806:25::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Fri, 25 Aug 2023 23:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 23:34:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:34:33 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 11/15] cxl/pci: Add RCH downstream port error logging
Date:   Fri, 25 Aug 2023 18:32:07 -0500
Message-ID: <20230825233211.3029825-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e31e5b9-4d6f-492f-d9fe-08dba5c3d681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ollb/4oOhLBtFN2HqX6U82+vBIww9EjyBP68gWCzum1LaF4050kRh00YYqiNFC/fJjEkRb92OeZ1WAwduf6sAAPqBivbUwkmSTlip2ul+wfuSSrDgBQqiDNjLbHcIYWzWPBwQ6/ubunuuuBQtuZhjPu10LJudfvXEOh/1t02yOtNCfNFhyZbMNH8k4OYYp3ClyN8B5pKp51+222GiJjvnFjmmvwpvwWk51Z5xuSz9kL+Xgu8+zXNkjufBnDNE0m/TjA/RAE1wr/18Nndybfr7euuHwYh21WI7qj31f/lz04YcASOXDF5jrtcv2KSGXPbAl2WKqldVRLHlKjmBovO1F+P/MtZvhGNHfBfXdL89za3qPU5uW6lU653u3ghTR2MBajQj9dwc+pJPLMpbEypgNfgdUKwB8XJsbNyljQHUwkyLe+8juJKZvax6jPg8SPCE4iM5SyUMxSQUVLdS6atsQk5QGzv6ze/jfztKgBVPARfl4uyITWnlKX5uI8YQZtBM5aicnm2XdiPKe2vFgRnPTwMkXtTSz+Ts4mhgGpB2qJX4NBNngqsuO97RZ50jR8torl70vUMHdjDs1CCLlDrpoveTuh5uaiurOEgFdHvzg7wjMmA883zZWV6OAkHW+klR5X/qZiJ7vZf0tUV8gqELRbu9czpOIQGOa09Hpth8CiFjB3GWGxcOjx8A/A8M+nU94noJmKDrtT+6Vgyti+8f4vc+izAp0tIQYTBGLRbk5SvV/0Lw8kS+aZJGKub+ekzmZzR0rafTQHZY0k3BvhWXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(82310400011)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(1076003)(5660300002)(8676002)(8936002)(4326008)(2616005)(16526019)(26005)(40480700001)(316002)(41300700001)(2906002)(70586007)(70206006)(54906003)(110136005)(7416002)(44832011)(478600001)(7696005)(81166007)(40460700003)(6666004)(36756003)(47076005)(36860700001)(83380400001)(336012)(426003)(86362001)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:34:33.8472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e31e5b9-4d6f-492f-d9fe-08dba5c3d681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

