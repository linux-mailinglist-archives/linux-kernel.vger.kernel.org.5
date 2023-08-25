Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B5789269
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHYXeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjHYXeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:34:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8D26BB;
        Fri, 25 Aug 2023 16:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y58ZREMtV5Uu9NPiuUlykIO8lxKKGTPVeJEwu0TRm2Fc05Z6yIxs4U9RVR0S40+wLtuZNlwe4OGjhcPofSHThxHiVBFkymEWnJQ8lMvCYbjsWdvoZ/UqvuOjlz79D272OKO0skCaaXXj1ziZ2YocsQKLIR+wrjo6pdO4vwj4L+/GUT8ynZx8COykJPFgMwb4DlSxZItWd0GJMVJ9qQKAGSg1chJbK/tw1rvMdmMLHPb6JJXuyz/GaV3D2d65RQWh68NCl9mbhO/nk7E3DhZEvbd9knM/BmPAiq602XpiVEp53vDcJpeVekMb1q+A2/odNb2bKCuwpvXA1T97FO1bxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22swpCBrB4JtUoKYDJMG5Bon9IKAGBSs78uzHU4Uuo8=;
 b=AFBmtW3hmQsEaLPGymCwt+b2E9hF4yh2CJRlU9g+iixMkM1xY7EoML5I8MqVQ+W0xktwf40q75bz8xWVJGzo/aeNik+38EQERKI8ofo0JernbjbAIT8A2T5jpIW35gdXmnsVbaw2MtQFrFX6I7ablHjBVJTpfZnAf0H98UgODxbLUCsMnOsHFCZs2Mn8J9qUxc1j9IymzRCx2SyaGEQfdKeD0tpU9olywdZRbZvRSDnw6YCp4xVlzh9Pe3WyoSq+hVnRu/cArx5v2qbsYWJelnCYqejZKrYLfd6M/RlurBi8wv54t9l2dP2Nv1uB0aKE5bohXNrL+/bbkLQnS5a/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22swpCBrB4JtUoKYDJMG5Bon9IKAGBSs78uzHU4Uuo8=;
 b=3zPfD8HxhgxiymCnvk90oFWcR/Q940iXCWArF48ykip4g9rThenu8B18M3gQ9FeQ8iVRGp4CpFhxNX1UuTPVlRZphJ9GkGkuTkThQ6vch2KlV8HgGJWRkn+CMI0WNSCgLYtBP7rsLmo0dav9/axEZbc2wf9WxbN+MTVaLc/RUw0=
Received: from SA1PR03CA0018.namprd03.prod.outlook.com (2603:10b6:806:2d3::29)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 23:33:48 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::62) by SA1PR03CA0018.outlook.office365.com
 (2603:10b6:806:2d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 23:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 23:33:48 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:33:47 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 07/15] cxl/pci: Add RCH downstream port AER register discovery
Date:   Fri, 25 Aug 2023 18:32:03 -0500
Message-ID: <20230825233211.3029825-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: a31edfc4-d1c5-4a14-f7f7-08dba5c3bb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1UOIukJWzeeYswaL5Dng2vsfCc7Z2D9m2muIwXTFs1rc/02xvZICxTmtzXP9gaK5D3+gZ2UJAIqthZCXpTilqhrRAx2DRFZIFHhdpcz7swxRH17ox+A+/juhYNliz/g3MMAfTQOsPjuYp6ZPXH0i6vEW4uK9yqZY/HJ0fAFp6Ggt1Y6XAXMp/K0qqxooNT9DQPvov3wgBzs8xbnq8E9m78a3CNLk2dV7cN4Ds7W4wEG8oz4kr3GlGsZiVBJE0lwa+Rjl51gaGIr6eR5LKDHj6IYuYSfl68+QY7C7dnV6dcOH/8aphec60erBkqBTiYMpE7t1vu9oqS51aVE8MRKH+9vwJGXVtX/1vg9xM9OzE9AysaYxXqageQqu4OgdSqJAVWspjZe0QTKLNLzIawnUeJdeglWbwx/YK+dsJJfMHpAYf3WWnpA7nlWQ6IoLCWpCNaVHx/zAHVmkm4oyUIToS1loQ1fz31a/8JmShDSwHT3Jc+Kr3D55DQ9Y3ElTBujcT9eMzZMF4FLFMy4DOS8ney/tL0PRBEveVMAVMJVpPdMcZrTLTAg95wl9oGA5GSBAKi0syIY7nm9l8/bcawO4NALSNxFTI7yJacMFE/XRBOPk3Pb0JwpTwhtBWk8/l2HBrZ3nThDrRh+6slKyVIbCYlzP8okAd9zrRlpN8w+wNAle1uWBTgK2sAxIkkSZpuhbqyXMoQA4PULX5TZHCQNcgOfuwY1Epp2JM8IHpylvuj/nal55VEgNQGxb2YW6dTsb0gRNXdSN9qtjDchrYN3Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(81166007)(356005)(82740400003)(40460700003)(8676002)(4326008)(8936002)(7696005)(54906003)(41300700001)(6666004)(316002)(36756003)(70206006)(70586007)(86362001)(110136005)(16526019)(40480700001)(47076005)(26005)(478600001)(1076003)(36860700001)(44832011)(336012)(7416002)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:33:48.2939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31edfc4-d1c5-4a14-f7f7-08dba5c3bb5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restricted CXL host (RCH) downstream port AER information is not currently
logged while in the error state. One problem preventing the error logging
is the AER and RAS registers are not accessible. The CXL driver requires
changes to find RCH downstream port AER and RAS registers for purpose of
error logging.

RCH downstream ports are not enumerated during a PCI bus scan and are
instead discovered using system firmware, ACPI in this case.[1] The
downstream port is implemented as a Root Complex Register Block (RCRB).
The RCRB is a 4k memory block containing PCIe registers based on the PCIe
root port.[2] The RCRB includes AER extended capability registers used for
reporting errors. Note, the RCH's AER Capability is located in the RCRB
memory space instead of PCI configuration space, thus its register access
is different. Existing kernel PCIe AER functions can not be used to manage
the downstream port AER capabilities and RAS registers because the port was
not enumerated during PCI scan and the registers are not PCI config
accessible.

Discover RCH downstream port AER extended capability registers. Use MMIO
accesses to search for extended AER capability in RCRB register space.

[1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
[2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/port.c |  6 ++++++
 drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 45e7e044cf4a..f470ef5c0a6a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -73,6 +73,7 @@ struct cxl_rcrb_info;
 resource_size_t __rcrb_to_component(struct device *dev,
 				    struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which);
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 
 extern struct rw_semaphore cxl_dpa_rwsem;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 99cf5cfbbcb2..8dd9a44e8a7d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -978,6 +978,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
+		struct pci_host_bridge *host_bridge;
+
 		dport->rcrb.base = rcrb;
 		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
@@ -986,6 +988,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 			return ERR_PTR(-ENXIO);
 		}
 
+		host_bridge = to_pci_host_bridge(dport_dev);
+		if (host_bridge->native_cxl_error)
+			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+
 		dport->rch = true;
 	}
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index dfc3e272e7d8..c8562cdbd17b 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -470,6 +470,41 @@ int cxl_setup_regs(struct cxl_register_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
 
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
+{
+	void __iomem *addr;
+	u16 offset = 0;
+	u32 cap_hdr;
+
+	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
+		return 0;
+
+	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
+		return 0;
+
+	addr = ioremap(rcrb, SZ_4K);
+	if (!addr) {
+		release_mem_region(rcrb, SZ_4K);
+		return 0;
+	}
+
+	cap_hdr = readl(addr + offset);
+	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
+		offset = PCI_EXT_CAP_NEXT(cap_hdr);
+		if (!offset)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+
+	if (offset)
+		dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
+
+	iounmap(addr);
+	release_mem_region(rcrb, SZ_4K);
+
+	return offset;
+}
+
 resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which)
 {
-- 
2.34.1

