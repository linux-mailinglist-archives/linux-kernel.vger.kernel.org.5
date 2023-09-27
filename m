Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF7F7B0935
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjI0Prj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjI0PrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:47:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D70272A6;
        Wed, 27 Sep 2023 08:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8rOI+YsPFc2n6x8OhX252iCCG1J8E4JI78Ivbyq9vbIF2V3ILSNCGz0h7B9gHR4TOIftCuwcV08ITAeoqfzR8DNc/vuGgmR5Ef2JpDxQE2r0EFHMguEeyg/xT3OxZAbl6ld3OJv5X2uH7zIiVrKrE22jA3RHMPAdvQIC8iVYKy9zfqTsNt7ALzUPSHi2xNKWdUENCSZLq4XEo2WxzMknxxTLvXmSEWlBfGJAhsRPlL60BvoHZwBHbg79+j1RKxzJLz+GaJKWzcmhitSLVxlmok90e3KhLDJKH3/h7FZLHqmwPDrVyzYBEx7bNhuw+dF/32p6W6JzI2Qb7Y6A2xesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQAlRhYGBc+BdeIOEa/Xxa1+zL5eKt72JBoyw9E8DUQ=;
 b=QRNOrvR8xb3hXkpljtVOk0LF8ee0TkqFwJJBCSCgV0YXbzNMTlR/RkxJWyF3+mIzYxShQ438+u8JmrcRczXgD/R3Hy/+tSC6NF+uWMzLazKurSluZ/ngAjHsoWRm0IrTZ+xck7TBImlSHIbMa8mMzRfRor/oRlYa+z/0g6nhejwZchXnjujo/hOuPjRCj0iqb4bN1Yzwvm+EKdnDH/DzB82pItGwGElDowOR95PT9qhFYgU2DOdFKpHlrxrXK9Jww2hEEnGGJYUbnd3Eg7Q7eH+ECo3CRYCGvoELppfVy0f1XwXJvGiu+nPklsXAdhC1oV5ZiSmIjVZXek1zAjJU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQAlRhYGBc+BdeIOEa/Xxa1+zL5eKt72JBoyw9E8DUQ=;
 b=CjwjpmK1T7ddes31+nNfO9YM1khWR7Xxx7lV3pB2sLrpyqOSweAC6MtdBSNC08AXZBvRRjnM+zrf11w9ecHrOW5lQ4EOwuQc+GUKht9ocKaolLrgHaq8h4L1W5aGvOofiAkCWNsYCPa3I9FD5CbHC3LT8tmxlK9gwyC1ciKwCTQ=
Received: from BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::29)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 15:46:55 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::39) by BL1P221CA0016.outlook.office365.com
 (2603:10b6:208:2c5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:55 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:52 -0500
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
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v11 14/20] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Wed, 27 Sep 2023 17:43:33 +0200
Message-ID: <20230927154339.1600738-15-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2f7cd2-7fc3-4fea-5c28-08dbbf70f9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQqRpXnfA1eviIjwrATH8Cv4fm09+SQTkX2fGn3pLz+vVGX5HMBSLnJdGPeujes6+uT7p6EtrBRjeOCueC1gifSi5rUt8L+EwVfKQi5h2UU7LNKy3kvmCOsfezx9Yz4IzJK0r1jrUPZuYG10GVceNe0vsJqfgqOBmPxIeBmdRFeHeyghzswWwnHtozZhuJfD83RpKvwVkgGDyDbh1DHaY/rBaobUxB4LA65Djw+929J6ddOgX2BTbjo9nGqZxpkwQCPboeoZko2TtEwZGalVL39EngHDWipzXB9XZBaPya1+whpAf+/5qej9buAI7PZiZ7K8ByGUOBCbzECskeV0ziqhJYkKdZ81w+3qKi1o4WVwUHmzpHjh5OBF2v7yimDFn0H/eQ9ZcZOQsVCc53NkuXlPVug7DTEy63RwKLBdEcde8giUims/y3Tl6HkOeScKi6dtrwKTaDcztMmb80s0HiHZeSvKyA+BsVaslZ/rw6o8YHkKaAfmfFGnkl1keBrzAK7vZWXS9Svk+7YPwDonflWK0ARl+aSt5Bcuw3FlRfQwFnxrMZRWpRIbiqsXDtL0EvyYdaaxvSvZ6MFbZNMpNph0cRfwSHOOoBdvfSQz0zez8wDmFNnJvk8TJ5lomN3s7+nDk9DWmN1+p0WkcFZ5JX7sMwCF7/A7+6mYVvbpQ0s6vYcOBll+a/sf1GJ5miQEsbgVImSwiCuEXDMv8I3bdePe0BfmXHEqk1bf5jZZ7YyeR5dQmraFrECj97Df1ECVWR38RBq7F8MwF159X0Ci5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(316002)(82740400003)(36756003)(40460700003)(70586007)(1076003)(70206006)(2616005)(426003)(26005)(16526019)(83380400001)(356005)(6666004)(47076005)(81166007)(336012)(36860700001)(478600001)(54906003)(8676002)(4326008)(2906002)(8936002)(41300700001)(5660300002)(7416002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:55.2731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2f7cd2-7fc3-4fea-5c28-08dbbf70f9ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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

The restricted CXL host (RCH) error handler will log protocol errors
using AER and RAS status registers. The AER and RAS registers need to
be virtually memory mapped before enabling interrupts. Create the
initializer function devm_cxl_setup_parent_dport() for this when the
endpoint is connected with the dport. The initialization sets up the
RCH RAS and AER mappings.

Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
the RCH downstream port's AER and RAS registers.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2b8883288539..2af7ad77b273 100644
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
@@ -730,6 +731,38 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	struct cxl_rcrb_info *ri = &dport->rcrb;
+	void __iomem *dport_aer = NULL;
+	resource_size_t aer_phys;
+	struct device *host;
+
+	if (dport->rch && ri->aer_cap) {
+		host = dport->reg_map.host;
+		aer_phys = ri->aer_cap + ri->base;
+		dport_aer = devm_cxl_iomap_block(host, aer_phys,
+				sizeof(struct aer_capability_regs));
+	}
+
+	dport->regs.dport_aer = dport_aer;
+}
+
+static void cxl_dport_map_regs(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dev, "Failed to map RAS capability.\n");
+
+	if (dport->rch)
+		cxl_dport_map_rch_aer(dport);
+}
+
 void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
@@ -738,6 +771,9 @@ void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 	host_bridge = to_pci_host_bridge(dport_dev);
 	if (host_bridge->native_cxl_error)
 		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+
+	dport->reg_map.host = host;
+	cxl_dport_map_regs(dport);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cfa2f6bede41..7c2c195592d6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -221,6 +221,14 @@ struct cxl_regs {
 	struct_group_tagged(cxl_pmu_regs, pmu_regs,
 		void __iomem *pmu;
 	);
+
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
 };
 
 struct cxl_reg_map {
@@ -623,6 +631,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @regs: Dport parsed register blocks
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -631,6 +640,7 @@ struct cxl_dport {
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct cxl_regs regs;
 };
 
 /**
-- 
2.30.2

