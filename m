Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35517B0937
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjI0Pr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjI0Pqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A92272A7;
        Wed, 27 Sep 2023 08:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li2jxgjl//IPKVSlY9LJwPGq9USzLeQRqWdx8bmT7E0PajiZJK9jdPDv7ZLf/giHYZrHDEantZjYQTodGuARBlnTdCLQ9Tzf/sbV/zasDuRIH4aH4Tf9ZHda6+iESizg6jJLaWnCdF6GHVLKVsuoUNroy6xxP+baPP+ol4QksObJa2CdJLyeqG4H+W6i/JdVTT2MYa3avfhc7DCIuQcLEiWJ6Dvg6qLyX6n38LkfPu4b8lC0H06Lew8QP7vc/2F+D0KhfXk8H8H2XEBsNc+FV7xvF2SoC09OXhrE7gsd+aZ2FiHR+gJVKV2Gc8J5NzrwaPRjj3+3eVA86W4evSerJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGKgniNpJFS9YbLdjmtCw4nqN+3EXACRrIBgxwXpQyU=;
 b=RzkMGF2DmRAIr6r0QFkAo9Qukel410dzpj1E/dlovS55poSpm7erPeEAk47S+YdqlCwqZpp/3d7ecBglZ1dVQEufkEZ4KK32+fK/aAjfzbfgqFAyzPHpYLwD27ub1HDIWkoQH/QpRx1Jep0esj4K46szAMNZNS8iQSnIfyJwnALnlUq9bHycalZ1X/OVZmnzcMfy/UU682wx4WICukdLItZm79lcHO71/bEysswR+H+jiIuVUWmJFcXgQS3+eVepX+yxKs/a/AyyGKyBmHxulIdk5zf+oUCV1PnHGJWwvApFopCd+e+2wC6mIKayRjw3rfr9BnusZ0a5UG77m6lCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGKgniNpJFS9YbLdjmtCw4nqN+3EXACRrIBgxwXpQyU=;
 b=giMp3aEEq3a1cIiwWccezmbko4wQHi2YXYeK0R5nH4KuzQ4LZHB3GC11mgHdIDYsaez0YThJ2eWV800fNECnUbGjaZ6mXAAThdg39lHec6yYyRVgtBiqPoPwiLMDQMhPH7sd17dW/nARs9bc/u77xoS0p6YzGiE2RA2aiXgdrT8=
Received: from BL0PR0102CA0042.prod.exchangelabs.com (2603:10b6:208:25::19) by
 MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 15:46:52 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::56) by BL0PR0102CA0042.outlook.office365.com
 (2603:10b6:208:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:51 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:48 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 13/20] cxl/pci: Update CXL error logging to use RAS register address
Date:   Wed, 27 Sep 2023 17:43:32 +0200
Message-ID: <20230927154339.1600738-14-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: f1500f99-1442-454a-b6f6-08dbbf70f7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nwlbn/UHu6rbAeMIwiR1Zix5wrp+8e2gDxDk/sfIU4wQWNAS7NsMqxY/MFIc7E52qNYjhZ+rztmoCoGi1wGRFV8L7KQW1EvICZEXjIfnyloLzn/nhJN/tObD5LUtoYCyqb10LHNz2aZRVXZobCRehGIlAFTHi69LHUbtZXjOhOOuvHmNbOnPwnInsZCOFr6qUc4y9LwhnC3CFtkTR7CAL/5u5BWIA9FioKb8WAtf+ufm2LZCQpX2IB2jpzDDSZxtLaX2ExN+2toamyjX9bIiaRgBMKSi7hDVD5tB6YIJQg5TaNL5H3SRZ6NkV63H4zGI3KENRpJnp4NE+12xYWFueeveY2cqAMKFv4D5XDmue1dliNS7HGpVC5XEOw3wYag3IErwiG9M0jgjdDn6A4mit9VanaV2tnsX3MKDdvi8mUMvqHDoeFoaU/iewWxmDKhque1Q+mVr2ZVS+eDhVyHxvFatswODqW6fibvAgpXPicv/YoonAIZWprXjfPSrQqpmITC8r46odnMdOJNePKtaHyfMfzbtPzawCXFHEZ6WohKFEJ+oiV/XaAelFm5c29ihglp18acEcFp/QzdvJ19NcVdMJ9upotSmDmSodIenKj1IjwE6mg1WSGvLi7IZgCpBM1DweXyJ3uu6ZJsBXKUxEM6WMyVarJVvcGRwMhWl8wy/48Sa9pY3w+vGlqafNh3F5M18EGjRye/kHrO0CSdb8c/fFo39b7lcnRJlBrL3+4owJfTgYI5ZkiM2aU68hv0gP8q8odmpnx3PIQDRei5s6sgOfdK+quzwbrEVoHRLRqWDdkezxmPeX4flZ+s5vc4u
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(26005)(6666004)(478600001)(2616005)(16526019)(356005)(36756003)(336012)(426003)(83380400001)(5660300002)(82740400003)(47076005)(81166007)(36860700001)(7416002)(40480700001)(70586007)(110136005)(54906003)(70206006)(15650500001)(316002)(2906002)(41300700001)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:51.7481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1500f99-1442-454a-b6f6-08dbbf70f7d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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

The CXL error handler currently only logs endpoint RAS status. The CXL
topology includes several components providing RAS details to be logged
during error handling.[1] Update the current handler's RAS logging to use a
RAS register address. Also, update the error handler function names to be
consistent with correctable and uncorrectable RAS. This will allow for
adding support to log other CXL component's RAS details in the future.

[1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 44 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4c6c5c7ba5a3..2b8883288539 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -646,32 +646,36 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+				 void __iomem *ras_base)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	void __iomem *addr;
 	u32 status;
 
-	if (!cxlds->regs.ras)
+	if (!ras_base)
 		return;
 
-	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
 	}
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
+
+static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
+{
+	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+}
 
 /* CXL spec rev3.0 8.2.4.16.1 */
-static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
+static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
 	void __iomem *addr;
 	u32 *log_addr;
 	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
 
-	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
+	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
 	log_addr = log;
 
 	for (i = 0; i < log_u32_size; i++) {
@@ -685,17 +689,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
+static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
+				  void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
 	u32 status;
 	u32 fe;
 
-	if (!cxlds->regs.ras)
+	if (!ras_base)
 		return false;
 
-	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
 		return false;
@@ -703,7 +708,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
 		void __iomem *rcc_addr =
-			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
 
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
 				   readl(rcc_addr)));
@@ -711,13 +716,18 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 		fe = status;
 	}
 
-	header_log_copy(cxlds, hl);
+	header_log_copy(ras_base, hl);
 	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
 }
 
+static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
+{
+	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+}
+
 #ifdef CONFIG_PCIEAER_CXL
 
 void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
@@ -733,6 +743,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
 
 #endif
 
+void cxl_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+	cxl_handle_endpoint_cor_ras(cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
+
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
@@ -747,7 +765,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	 * chance the situation is recoverable dump the status of the RAS
 	 * capability registers and bounce the active state of the memdev.
 	 */
-	ue = cxl_report_and_clear(cxlds);
+	ue = cxl_handle_endpoint_ras(cxlds);
 
 	switch (state) {
 	case pci_channel_io_normal:
-- 
2.30.2

