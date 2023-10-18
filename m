Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB87CE4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjJRRcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjJRRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:31:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAEE358B;
        Wed, 18 Oct 2023 10:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAd4ujOMQ2Pw1IerVt7XSbyrW4evwcM/ff+SDWijqPbmbP6DB54gi66F8qm26yFB9fBAOnj8QxM1ShZhQ+0+4flpK1tvDFHPqMpZdKd98lIx6ltSeTpUYxQHwzqz8RVF2C9PJfXLDzVpj/l5k5nTLUUBSDgXsBj63FqCgCEfRLhf8MdOCLwmr0c5JXWGqIzaO8WtkDaGHYNIzeG9EvXTKzDn3r1G30Xtm//HRe2P/JDZzW28c8CEuSAkDHL6K6/ev9FcajxEF6HIDC8JC+vjYo/b6RXT1dbFBRxABaU2G4nUC7zfnX/oA0h2Yv3N7kNF3MKEeFprb7w7JKQaKNcokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl5nvBL6Vf0T0Bs/KWKnwDDXuIzIjJb4YX1QAHT6vmU=;
 b=OJbrCQsW0/bR4vTXO8MN95r5nSypIVkNSaG/xGnnGKDmypkByqDy6wyEqxl0zntj6Lzs2Q1XCauoSdje9qX3DMroG8zutTfOiuPWJeirXp0LplcaqtfeXU1vYhUC5lz2x9/bsS3V8vEscrYhpa37wRVnC+6d+Arf5WoZFTqz2b0iFSfEOTtB/n+0g0ELnxDRrPecH7/ytKSz1rMoqzyz7/NeUt27OAdiYZCha3/Ni/qFiJf8fLhzfw8rpuBzoGFF+c1yVNVDENsauyv3Rj5CZDhlCWnYbPnQ6OK9ng8NlP/2cEiLbUld/wMZc37d1bxanKL52bFJBpH5sgXvWkqFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl5nvBL6Vf0T0Bs/KWKnwDDXuIzIjJb4YX1QAHT6vmU=;
 b=y2QMeK/WiB4lYhA+u1+hIWF1tBTbpozLtYUm47WK6qInb+DpSwdyc6k5MiUNoZxlqQxDq1nYrIgn+h24ROZsTHiPt6QLiWZwgnAuvqrQawlS5rjkBDT75ZtaZX7cWzTS9RS9DKtsUiByygIZLjzEKyaIrvD5tNkCVnURpXmjvEA=
Received: from PH7PR17CA0054.namprd17.prod.outlook.com (2603:10b6:510:325::18)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 17:19:56 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::7d) by PH7PR17CA0054.outlook.office365.com
 (2603:10b6:510:325::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:19:55 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:19:48 -0500
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
Subject: [PATCH v12 11/20] cxl/pci: Add RCH downstream port AER register discovery
Date:   Wed, 18 Oct 2023 19:17:04 +0200
Message-ID: <20231018171713.1883517-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3a658b-b461-405c-0607-08dbcffe72f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abQUH2TTt2Jexn1zBkuJaUrXEhaDesxhtEKCnZVSH+UNoiGsDZjMt+Yxj0pWDu12xzeqhyh9yf68FMNuvnXBzFY1JSuzjKr0nK4DBBp4hjYJX3bJyiw83BAY8GhYv8x0x42h2ZFF2pjHUxH7R4BoJVRvNHdQUSc+bdRWntGwKMD/cvLIFO0TgbjC/a1FMi442f9a3Gto2PosL0ji2R/C7Hb9pFRfoRvmPIvDJ7kaBipMsSvMoA66+y24oWOrATD1jDZxyZicXkks/zdmG3HKjHAEL0F4OTpJ2wQ7MPAvUhqXNr2uF54UQFnNxE37i9SOQKvzZDnDju3NeHWdfkoM5d/tmzem9ra8iRHhgUlnzJJX7FjQCVDZb0ap7YEg74NqOTlAy8LxlOxsviVcxlUAML8IFlF8BN6eZNdiUKQUffWXsg3OIh6ci9Nu7OZFRFqycFo3ftzQyxnTp1dAzjn1z13Lox+C/8fE63gMxTNUJlMBh6pYqEA+TE2G53m/XIp5gnAl3S/gLrpEWR8NbCIy3n4zq9OAlTCHfFtW+s36DWvZ2psXB7oUTlvQmerJB14QVY9UKXOTelyRpPJCzhkpiToV8x3Oqo+yd/QpGOSVpR42ZwNKzJOA37CftyAddu+Ag6RwmBHKbofk/5HixzvD4Zzo1ze9AHizlnuvfyfTAMe1rHhfbGdUfkhiZT7Vu6L0DGjy4uvPkzMURBbZFTUCedNFlcj12A5pbt3J+cJVkuGV6godXdphhSxBJLB6EsaDQcuZMy7MZF3W0uOuQOUIJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(4326008)(40480700001)(47076005)(336012)(36756003)(82740400003)(356005)(426003)(1076003)(81166007)(16526019)(2616005)(26005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(110136005)(70586007)(70206006)(316002)(54906003)(41300700001)(6666004)(7416002)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:19:55.8157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a658b-b461-405c-0607-08dbcffe72f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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
 drivers/cxl/core/regs.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

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
index 7c3fbf9815e9..cbccc222bb91 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -722,6 +722,12 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
+	struct device *dport_dev = dport->dport_dev;
+	struct pci_host_bridge *host_bridge;
+
+	host_bridge = to_pci_host_bridge(dport_dev);
+	if (host_bridge->native_cxl_error)
+		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e0fbe964f6f0..9111ceef1127 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -470,6 +470,42 @@ int cxl_setup_regs(struct cxl_register_map *map)
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
+	if (!addr)
+		goto out;
+
+	cap_hdr = readl(addr + offset);
+	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
+		offset = PCI_EXT_CAP_NEXT(cap_hdr);
+
+		/* Offset 0 terminates capability list. */
+		if (!offset)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+
+	if (offset)
+		dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
+
+	iounmap(addr);
+out:
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

