Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736317CE48D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjJRR35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjJRR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE92121;
        Wed, 18 Oct 2023 10:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGs+wW8Y9G2/GiGKIZkKrnjSRTeL5BlzZIsYUs8dhzLYl21w2Fc4eY112gEcZwPEe0rJ+3eNMQ4+RV51ivRqREtUbthxlsUd2ZRt17DBQ66o3x4uq289FqycLj/AtSUWSTB1XrYtM5g/0ki1Zf7YZSl4L4StbOFmRigXfl9oWN+d5W2ON81q/+wl0yYyZ+f/1HHeUbKNsgEbKxxDpS71E5tQwLknUJJRhIxT7reOXIbP/lHARvdyOEYkENDiWh6syPlQVw2Z9MB9EG6A7B9ibx0nezimWyRpw3OEaS/QlBzsUMjuUCyXkAFasu2Knt3dgV67+d0FTX62AUXkHawASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCP/pWOdvSlcAkAy1hynVuPUWlCUHIObdOAE9gQykmA=;
 b=atM4QLEglU0+D6sjlW5Y9WiNHDpnT+1hOgIpRevzfGAMZ0xIxyUjKk7Vaco+YmkYkUpMBkv91xnhFzJ7W2NzSW4g/5oHPKtP+BSG/hzKFpw22ZyQcRqFR/cmXFQY50LLeTBj2eeLUPTMxXb6vQ+WcOX9oPm3w4tcP+vHLNbchIJWUfNUzwz5gi14l34mhpBwm9HmssMPvZgTBxOqq3sp6fqLtybfdnEe0dC1x725knWt8G6MH7e9QQYNQXvgFMxyScKV3Nk8aUrhsVO9aMWFDd/yz8zqafHWfsger+TX+qnLsrCZ6L6TiGUPR7QAB0tbw1Jk+r3rRE8YJ890Qqb4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCP/pWOdvSlcAkAy1hynVuPUWlCUHIObdOAE9gQykmA=;
 b=sIUr1rSx/4qW6u8Vn1WcEUJmnvZGsbvwVhDZdiA5+3eyn1D9k2g8gxnuuG/kxn/36Cdp3oqdl6NCBfZF9GPJhLSLw+fkQKR0GqEg6Vl/v3z2HZBDBjaO+mkBlI7BTsvJdl0kVBS/YFHaDk+lrYS+C2MOCzGSFwHaHcdBOiBo5qY=
Received: from SA0PR11CA0187.namprd11.prod.outlook.com (2603:10b6:806:1bc::12)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:20:04 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::f5) by SA0PR11CA0187.outlook.office365.com
 (2603:10b6:806:1bc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:20:04 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:20:00 -0500
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
Subject: [PATCH v12 14/20] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Wed, 18 Oct 2023 19:17:07 +0200
Message-ID: <20231018171713.1883517-15-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|BN9PR12MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 901b0365-a43c-4d02-2e15-08dbcffe780b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch1S69fTX51eAqYsRr6xMmrQTnGK89PDsplU98UsUeSX+26xYN0nWg03BlStM+uyiVRGptPS0y+nsFv7XeH2U0a7Y3EMZBrPeUFk6c3Qj5GgFkQuKG+jYcJHzHkIciHifN1Njo/8UBr/6n84uJLNJk42kd9PJ+G6L2ITnmqWoB9He5cTbRgMRqbIfsAR8WT7gpw27S005KL42F3hA1yOGSMHPCxkVr+ItlYN5/iAf9XT7NJIWSZxDFZYKBcIvjDenzz2wj/96vnPhewaco7DNxCAtPIKJ/QOOQIebC74qqCsrHbIPlJSmCoxL/tjAI4u1gwN5qYlnngDpIydEBJG6m5QxWyNPGC90fwxFmeQkJezw3rYpXptLQoegDjxCUDbPkYmO31eoqXnYKtNqTusgT9ZgaVG7tP4rhMP7hX4CLy850BHM3+z77E3AZulgAE2+43RcQlkucn8OBLubWGeO2M/WPAlmwBe3Bny8lBLykUMCeGfYRXwwxTFjTCMU9MD9VCcy7xgNKLe89lux9opn8/+zyCxDF6XPW/jAiXO1mqsW2s03CUddjnYRWTr1tE8ye3kYJLlxy00ZF1EA+bXb4oATMDIzmdibkkbE7RNj3JFFXgc653SH6sQKabRocCG64Bl9FVymRRlWWaACuvEVmgLrwen1O1i+a/QltQB5E7L5OwgiL30KbZ8PZmxv8MEF6cYJpFkwzzbchB2p+wfnAsv1atxuwAmkIgE0O+zQBx3MqdhORwT1GD2cZw33wVCNMY/jv9K+BzWjFC86MWcuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(26005)(1076003)(426003)(8936002)(16526019)(2616005)(83380400001)(336012)(36860700001)(316002)(7416002)(5660300002)(47076005)(41300700001)(4326008)(8676002)(2906002)(82740400003)(478600001)(70206006)(54906003)(110136005)(70586007)(356005)(81166007)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:20:04.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b0365-a43c-4d02-2e15-08dbcffe780b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
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

The restricted CXL host (RCH) error handler will log protocol errors
using AER and RAS status registers. The AER and RAS registers need to
be virtually memory mapped before enabling interrupts. Create the
initializer function devm_cxl_setup_parent_dport() for this when the
endpoint is connected with the dport. The initialization sets up the
RCH RAS and AER mappings.

Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
the RCH downstream port's AER and RAS registers.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d101fdafb07c..3b4bb8d05035 100644
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
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
@@ -738,6 +771,9 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 	host_bridge = to_pci_host_bridge(dport_dev);
 	if (host_bridge->native_cxl_error)
 		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+
+	dport->reg_map.host = host;
+	cxl_dport_map_regs(dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cdb2ade6ba29..3b09286d9d52 100644
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

