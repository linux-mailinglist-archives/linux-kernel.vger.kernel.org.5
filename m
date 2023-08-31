Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8465578F1A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346840AbjHaRDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346841AbjHaRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:03:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5322A10D3;
        Thu, 31 Aug 2023 10:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV28jVzevrDkg8Jv+LxYD6DJDNn1Dz5gGPJwHAZxm1L7e5NTVyQOU6m3gLfcmYs0N9OTLLJnw+diGdN4mdSPZkNUMhnbIvW3jkfjJRzqUgn+W/1YayolpsiET7yk+Jwk3iq0gCMBsvm1W8+s1Tr3NWwZhMxreLn0giUAvJzovb+RzsENFEznnk1hggNwC6NFTpiqSD5lu0DVlPD6Eq6gJ5ZXvqKnADlQTC0bnAluQQp15FYc6qYy3a5n4TeadtGLyNySmqwghw4Vcvc19zCV8iNeIjHHLQYmUzskaXFeMilz/79wz/y5YDvK5WtDW9gOld9gY9f8klF64DVMzJHnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQPBspj1nicTMKGofQ24VjrSI8sbSqFGkzE/N0x+rdE=;
 b=ftjtqxCIz/hdXnxA4UsDTGMpyMmdMviHDe4gage+eW7AFucXcThFWDWU++oATTWJc/OKYejZF6tqxcMKGZ/eJa2tQbg7lSReBciz3NFQvtA0f6r2STPLMwd9tl7v41LY7wibG5b/NxOMgE1FDQ+3T4b6WiinOJ+Ylw1WL7C18jJe92FzyXuEJSn/RTUR1ZEmKNnrMBh6ObDQIkSrnLSCu2yAD1vNHVQzF7nL4e227rWUw4Uzt6kyhCXXBaAhQlGz34kB1tGErcCRLOGBbumI8dHD2wvimO1m4CD8TuS9SKfOaK8S3z8yU77J5XA3gg9Tm5UBctY/nQ5ogLfzjPd+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQPBspj1nicTMKGofQ24VjrSI8sbSqFGkzE/N0x+rdE=;
 b=X5wkcsRBkEgt+6FYbix1MQPSESsDqqcJRtrosFXoGC6rQX1ziNSB54tAEcu0X+UzdFq0NfzD+GLI/eCng6tRfwBBZHv58+KnkP8RbsAW/ZlPMT+I3LOK4eEy2kKBC6y6B+8TvL2ktquHPtswkkT/71yfEsZoMv64b7u6Z2AQ1Vc=
Received: from PH0PR07CA0053.namprd07.prod.outlook.com (2603:10b6:510:e::28)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 17:03:21 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::f2) by PH0PR07CA0053.outlook.office365.com
 (2603:10b6:510:e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 17:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 17:03:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 12:03:18 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 10/15] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Thu, 31 Aug 2023 12:02:43 -0500
Message-ID: <20230831170248.185078-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6d0c16-444d-4b19-9f1a-08dbaa442d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkIfwnV2VKEFY2gNKJCzPzm+2ZUZ9254F+95OYh779yqaMxnt94WobrExdne5tJVmwDskX99fITGsEYrPEjg1Tny2ABZ3BaOyg6Hoj24QRp30f1dTStDQK1BEjFIj4+YuBN0SYbrs35mlbZe3i14kirOgFIpM+TQpg4eG++7ud/q2XS0kJmpxPzkRN/R1dX61MDac2pW8xqzAbNGNRLtNATdlqhC1DbAISgg4Knfxp5uPtWL4JgExpcXjW0824IyhIDPHR8hfQgkL2q6nPgoohpzrOyKkXDoQ8saCQfJ8hvYaO1Cfyv/hlMf7FfCqbXpKsYHALunwCRyW+Esjw8Fa8OgR2A/9PocPDJug1ZNFPNIQKJXye7/obx1//NOhqDaLMqu+ZD3/Es6aV/dtIsHDEG4IzOMK2GCr5ev6OouzK/wtvmZmzwdzlvdpjfCBIhSL4jZS9ULr3fSMARNB3oh98zuml5oUl2X4s6Oywzwc8euWMoX1Xl7AvZ00/uXYRXfmPO6WPn8wFTNP9/YCm9i2NamhW1ko1bKrQ3yVkC7uEp2Mc9Gw4fq0gCRzNdqoj3Ss1+L/fRSNCWoL9nmgHW4tIQjYbsZsnShaIO66Ur81uazTFax+ZN6TOiJl8X+27YQagvbW4wz8uxRYs0GOkOVrDyc1S1fO5c61VCdOZOCORO3eVk6r++jiURHxWSoP+uzkXJlGM0Irq1h9VCZwwDxbfoikXzej/PcGkRH9aG4IUml/suI2GocK0AT1CYU55eRhSuuPuRLzCixvJAW07jK7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(316002)(4326008)(7416002)(426003)(336012)(16526019)(2616005)(2906002)(47076005)(86362001)(44832011)(5660300002)(83380400001)(36756003)(1076003)(26005)(36860700001)(40480700001)(8676002)(8936002)(6666004)(82740400003)(81166007)(356005)(7696005)(54906003)(110136005)(478600001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:03:19.9457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6d0c16-444d-4b19-9f1a-08dbaa442d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The restricted CXL host (RCH) error handler will log protocol errors
using AER and RAS status registers. The AER and RAS registers need
to be virtually memory mapped before enabling interrupts. Update
__devm_cxl_add_dport() to include RCH RAS and AER mapping.

Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
the RCH downstream port's AER and RAS registers.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxl.h       | 12 ++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 45f8846d8c8a..2a22a7ed4704 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/aer.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -949,6 +950,37 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	struct cxl_rcrb_info *ri = &dport->rcrb;
+	struct cxl_port *port = dport->port;
+	void __iomem *dport_aer = NULL;
+	resource_size_t aer_phys;
+
+	if (dport->rch && ri->aer_cap) {
+		aer_phys = ri->aer_cap + ri->base;
+		dport_aer = devm_cxl_iomap_block(&port->dev, aer_phys,
+				sizeof(struct aer_capability_regs));
+	}
+
+	dport->regs.dport_aer = dport_aer;
+}
+
+static void cxl_dport_map_regs(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->comp_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, dev, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dev, "Failed to map RAS capability.\n");
+
+	if (dport->rch)
+		cxl_dport_map_rch_aer(dport);
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1008,6 +1040,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	cxl_dport_map_regs(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index c8562cdbd17b..5cb78b76c757 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b4383697180f..251cda10c283 100644
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
@@ -273,6 +281,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct device *dev,
 			   struct cxl_component_regs *regs,
@@ -625,6 +635,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @regs: Dport parsed register blocks
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -633,6 +644,7 @@ struct cxl_dport {
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct cxl_regs regs;
 };
 
 /**
-- 
2.34.1

