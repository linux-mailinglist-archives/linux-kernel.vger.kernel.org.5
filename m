Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E630D7CE4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJRRcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjJRRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:31:44 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFFF3595;
        Wed, 18 Oct 2023 10:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKas5m+FzuMUUUSHt7WcYecUc+Nq+1FjLga9bfaF9bsOugmKqSZbZ7hST0FgTPiwsjhF3Jaea7sJl1uszpStWf3qfn4M4DnyEnmsBnOp74YAhDX6P8hspbmflCqxddDnbkeZNspt6YRqcz+MJtPdYzQoYPPvhdF7VTrpsEw2QEqN7Z1gVqA1B2PBuC+pdotdi9LZxYnMDKgQxSxK8PcuXNYv4QJ09q4V7WRkWWuadfb5YcoMmdt0nM49MT08BHWgTYOlrQUL7buCUyFuXKtdeEDK3y4VguYedRwI1Ak3x55WxhgiIximIlnyDJ9sxfnPB4HkkZjGZRCsJ8UtGL9TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjb+9q8+7vrJ15SqV6iRp4HtHEU3wR++60PEXfJVDSc=;
 b=D++Q+/Dy3agaGggUk5rEjHRBihrhJ+7g/uWs4Sy4MzpuvOdsxRqKaV29rl1qHkG6xaebfVtWB4A/ZGTSp8LOgLjxtznmvMrvyY5tv8kLWO9TOi0RQ0B1L2dDVvxzRkprcWLsCntS2Yog2oKDxhds/sLqX/0ZAXRQKYPbDN9qZhhWYa+2j11QSPEn3MEaBSET7WXS1nGBQfibwyoAVl494PBYZXVPE0A7/HI5nsSIUOIfcmDzmuEW4RRayrgBy3ptmlXtbXPS9US4gLZxkuF+Ixxdgg6Lb4NkuCMg6AThLU2y7BnZtSJcd6PsvWa7T0v1EfHBB/m5imTaQe7pjLXgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjb+9q8+7vrJ15SqV6iRp4HtHEU3wR++60PEXfJVDSc=;
 b=YfmgKqONJYTMejW2YH3nTuUgAA7JOhC+HojC9uZYCkRJydsDcwBBfbvRdZJtCSLLBbBgVWo1jf5Jo3WVWhAmq5pfq+JDZGde5WqkVtMBOO+O6+EZtDIHh+WG4jdCQfRzLv09ocdqgEbXf8/gKXJzD9bJ9gMnVaKI7FhX7cu2npQ=
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:20:01 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::f7) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
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
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:20:01 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:19:56 -0500
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
Subject: [PATCH v12 13/20] cxl/pci: Update CXL error logging to use RAS register address
Date:   Wed, 18 Oct 2023 19:17:06 +0200
Message-ID: <20231018171713.1883517-14-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4e9186-47f0-42ec-7b59-08dbcffe7654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8KmxwZwTxU4Dlwmdur0/zOu+Rn5P1uUUxwK97o4a8vsICLVB7iyuLWyadn2clCnZWdCvihV5Tk9J7hKWxg9WmmWguz9IougVjyTFRKrLC7KQJ6jYqrR/2CyDHRFITY22Pcl+zpmFtYxNKyGVPRQ5m8iPFrZ+NfLtK5ry9TFuSOdmVkCO30nc5SoP79BuyaM/KFYoLmAKD5cVtFNPApXmOpIjavvlnFpxVrFjGSzo3P/MSsVrL6EZ9wNMURivN4K7lPduirEcglWjptOBHXZY0Hdb64NmwnNM1sk5s/ZbRU5Dxtqfiid00+5LK9X0uSOAKHoZDa4l1KdK9ZoYv0N4gDPIGEiS5ssd9rjBtedbslEnItqkLgXwxUcNQqaI/iDuhEVzwssbFUzDJ9n6RhOdVjKyFeo8bbZTvTLYZyoDcjBryxypTP78TmFOgaL+tkP7hfLncHAV914ziivbQjM/YV/2Teor7H9NLwJDsiAlwZOXw+KXmOByM3XCQGwbDtV9jUsAExf8StTzvHyX9KM4irqEsWMqh1sAkFbNDmVxCUci7YhpQOZ8Xe2bKWsHNppcjSUHrilweNIypVdGXjH670fOAwEbn00jAgnLBnNTsR0iw00y71A8JVpiabIY655CB2ZDcitHxGzvfA001I6Uh5q+Zdu/z5RTyc6u3ZYs4i4jBacFy+49gqTpF+o+qCS4rdPkjqDU3i62gT4veFPOjlgqFQ76Us0bXU/Q0R3bTde510BsGp0VjQ3/PD32Qv8JAfCkGa6uwZPNONxuW5bRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(6666004)(82740400003)(356005)(81166007)(2906002)(54906003)(478600001)(316002)(70586007)(70206006)(7416002)(4326008)(8936002)(41300700001)(5660300002)(8676002)(110136005)(15650500001)(2616005)(83380400001)(1076003)(16526019)(336012)(426003)(26005)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:20:01.6010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4e9186-47f0-42ec-7b59-08dbcffe7654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index cbccc222bb91..d101fdafb07c 100644
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
 
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
@@ -733,6 +743,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
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

