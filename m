Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEE17B0939
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjI0PrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjI0Pqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C4272B3;
        Wed, 27 Sep 2023 08:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYeJIidc90ue51lzIW1V/FRdaRPMPZ3VvRPlrUk0MSxS50lfovjObihKVh+pIm6HxnIPvdJ4NxKSzcDkeFmIDMCfYjItogdYx7LY5HW1OHQR2wceIQvfHuHR3jkIJc+4iuDwJK9EmAAqW/zz5BuRJjWzpXJmHnPuf5PXqFZHC6pz+FtSyAwD0BMU+Fe1MEScvc9GmKATFXTpbZWR8jZHAwHWOwFjHiiYljcy3xQueQOkIb7LXoKjT/UAMvm3MpgqF9xrPZMr9v7VFH/7Alx/EEl/qrNHyA8VutYE3eeQWPjoA0g3xumb/f934gWL3qCqp95GiLuF+o8e8utmVAzvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GF7jjy5WUg0w37DpYh8hSuuj+++fYpvWSfcolAU3DQ=;
 b=N1sU+F9wwDuKrry/63MtqVe5QNgZuPuGOcu6LPLfq/0a9Xzwk6h/HdvbP8l5vqOg0u4uwGkTcW8KP5a280oGUuPQItG5W3P+MP1pKPRQzRNCHuDu0Pc7SWujCyu774QyWSRMslyjIEbDIWu9NjhftJpXdCV9dPEeF7gEExMEOfn2G4x8IMbMwdSrwrHntGueTF5gx7EPXof+50CGlSppMnTq4HKBuK33AU//iZibC7cXqI05/mbZp3eqPBOCeJytQMaWrokH1Xut4zJ8K44AbmZ50NHM7KNWYhtrqvhhKui7mdAd3NzlH7Lu9zRsIrHsjQNJQ5R+xXC3wFg89Q0r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GF7jjy5WUg0w37DpYh8hSuuj+++fYpvWSfcolAU3DQ=;
 b=qUZ/Uktbcbp1ePVKeUCloAR1L8tlH+A4+i5IM65jO9VqaILKEHIH29zZhj6lzfkzR7gJ/u3ZrW+UeMjXEiqhRZwjTyw0/qjleKElO+p5uL2il6+pJmt1o4zR6AsM8TAI5YDWV++y9nHSfXrrhWSxSkw2pRhwH3QZuu+3Gb6wi3E=
Received: from BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::24)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 15:46:44 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::d8) by BL1P221CA0009.outlook.office365.com
 (2603:10b6:208:2c5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:40 -0500
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
Subject: [PATCH v11 11/20] cxl/pci: Add RCH downstream port AER register discovery
Date:   Wed, 27 Sep 2023 17:43:30 +0200
Message-ID: <20230927154339.1600738-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0727db-41b1-4328-44fc-08dbbf70f325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCmGO70Jx1z6OQQJIqfBX2FDU1t9nJnaqeDL2OU34uxazuqErgOLBtk7+0R9esZ4cRe4a+JDTyqsef1c9vGoS7TMUoYAN/gjmouc4ZMbjpgy10xKuNAKVWvdv8q5OCy2I+mFkkYOqgyZ2iSSPoaLE+4JmH+FY1H5gCiJYZVCGBBdpa4bWxB3h6fO82v/ugaLuDVyCBd+zrvO4cZz0aW7I0QPxZ13j//fin5bIFz9E5QN2TT0eDT+nXWcLfIrkDga61hnMunXExWOHwhoNaV5xzlOpTXYOqMVJQ9ZOQIgEK8jgKuWgAIdMq+6JgUUxtuGFhPzabZj1gYm8R1JISPg8fcl3XGLpU7V3xTBtubmjFGeu55czChvJCPKx95nZV1FTKdApHqFmNsXjZ6za8XmrtlrEGh2bz3J3DSe2NSqCO/DSWgFfI7yVjx+uiLAK5WmUXVvGaZdsGcjcEyl1vmpoT2z4BvVV5KFnLKMgliuwgRwAztwb6UikOTYZK6iVe0SoSuVuZtYYExpQldZiZ9G8qVchfg5Jsgm/fWs+YU6nHlMVy5aAcUQaKwXSsfH1f3s1NMs80/B4Kt38pJWSiPKa5/wGySpSznMrVsbElQEXB0Dli54X0wzORIzWPaSF7QzazY5XJrg6LuUIJr2HbGNcI/uAuYwG97Vfhvltev5QzTLA0Wq4npTyzkV89EJpHxinCLN0zgO0MYLCiorYeXTBPjQtEpTMrZmLeXYsnWDYbtsetNMxSaKKZtxiyJWUR0doxwT7JzQpqDyqRUVMoJKjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(83380400001)(16526019)(26005)(1076003)(2616005)(5660300002)(426003)(336012)(8936002)(8676002)(4326008)(82740400003)(356005)(81166007)(36860700001)(47076005)(6666004)(478600001)(70586007)(40480700001)(70206006)(110136005)(54906003)(41300700001)(316002)(36756003)(2906002)(40460700003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:43.8667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0727db-41b1-4328-44fc-08dbbf70f325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  |  6 ++++++
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
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6ba3b7370816..4c6c5c7ba5a3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -722,6 +722,12 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 
 void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
+	struct device *dport_dev = dport->dport_dev;
+	struct pci_host_bridge *host_bridge;
+
+	host_bridge = to_pci_host_bridge(dport_dev);
+	if (host_bridge->native_cxl_error)
+		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e0fbe964f6f0..6e502f02899b 100644
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
2.30.2

