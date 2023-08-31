Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364F78F02E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjHaPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjHaPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:22:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646F10D5;
        Thu, 31 Aug 2023 08:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAhsC5I1V1qYFQKBh7Em/kZYVOfqVJSHWUd3rnCSfTA2PxsDT/tX0Yy8uU/leJ0W/xev+0oBP1Tmp6yFysS03JXp2bFzR4GPSpxFeFKX+c4XZ0bmECKJdOcagBEvjJOjdIxDXVDLUHcvW/+0J21DXcEcnqwgsyET3STeN26yKnfzLZDnvzURpVgy/K/Y3K1Xe6mFdd0dOyi6J6pNPxV5SUDM53lL47bGj07sGgMPa8SZR8chL8sPGukBy98I3oM4pv9jtlkTOQnuY+R0LM091dsBy/VG05g0XsXMK9jcGi6Vv6O0bjxpBavEG2L//e8rIbn92ISRfhQKpkh6UBnLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjhxeWmooZgDt0YNaed47YGpM5qYtRJmnSjV1avFr5E=;
 b=MXleGspxDpAfc4WWW52424zc+r2y8lZRrX9M3EISbkR7J35gUPo8xRaiVMe7Dt0W0yUCv1Kyk4eqvFp3Z6fnUKaW7iZ3goWOM0TNiKZXnk4FdZE4ToPI/WNSiZC0R2aaBQOA/wYzqcsOpSKQ0u3u2qjIwHRFZ5I9PrBwP86c2bJpjY7gv2r4iiXgUrhlj636oR86zvuIMyCOo7bWi5lK8Plq6uF5FuJ5SZqLRrlDgw5KFEAKMldnZurJu9uerjIEVcVlQ8IUonUaTj8CT4mF1+aWGrGwLJybnCj1joyAsXS7cvI6FETFQZTc4v08z0HoL3AWc4QyGz4sYTvUAHujdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjhxeWmooZgDt0YNaed47YGpM5qYtRJmnSjV1avFr5E=;
 b=kf7WFxzYyQL9qteCIVt5l101iSIaVpn8ECpT6LNRoPezWyUp9vJlWhZFXgcWqlzOxJZfuJU5HMjR4Ljh0F+vZpbc1xLZRU4HwsnHLLbpFTa+r3tqMZ9rK29fGXGmPFPwmwQq9/IF5C1GKbNZfV/gxi3DoiBsAXB2349MmAOWiZw=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:22:15 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::3d) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 15:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 15:22:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:22:13 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 07/15] cxl/pci: Add RCH downstream port AER register discovery
Date:   Thu, 31 Aug 2023 10:20:23 -0500
Message-ID: <20230831152031.184295-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831152031.184295-1-terry.bowman@amd.com>
References: <20230831152031.184295-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 797607b8-caba-4ebd-7567-08dbaa360e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1WjPdnbUNtUanD4u7Okwqah+hPWOdpmX0SkQJtwAo7QFv9+V1jpKVDBFqINtZ6q3iP2lOU7ziDGQDJtkcA1ZBQfN7BCxq+Mf/So3Y6JoBzkBGYipZL/wE+FnwMlHKbz7jAxyanT8vIt4eg4FCId5JftPvUpqO+VtcHlQLdifgteR8iAgfKDyvGHMQNsK0qTSLaLSENcjS4R+uXtFUSpYRk1rtELy29uGKvm+fL9XaGWhdW0D08WEFQWgFMO29ttu8Sz0Ualj/ky4LUsZ9BnnaOlj6LlL6CyArMraEjhQ4f0YEYyQObbfevY7gT6nTM4mFKHS2QSuzv6XqwWR0cwEJCZcD2bxxRE5mc1O2K/v7cpvF/8Lqp2lr+pjYah7TTgbNpmzL1WKUrii/p1FGH29WK5wNRxJ06uIkWlzyAG/cK54BUH6ur3YJA9q+fIrJJs02Kf5GUcIG/qDyeRrD4l3DVGvqulhi4REE4aSy7tI5KfH5dvqq9dNvewrBDh0Z5ISIYLsFowlq8bbnYUBlDSoYo+P6p3RnjDsy3+tpLXZKq/H83wTL5xp5t9Zlech8nMq8Q3Aadee5/+W4/+qnOzLIz1B9l4k+v6HCYOVA//fzTXxivTLD/EnWlBYZdaD1C1KoNAXFm7jK9RQSryg8PephaSvBIn32H8h2Ti5cNqbbu319p9yzh1lXhSpWYE5DeCvobLH5TeEtFrHNA3XqDoApt8gFLB+Skzn+SJkw3zxE7Oa8KaBMKi4/5mhERfxAN03v4p6mbJW2ypfiF5B8HEHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(82740400003)(36756003)(41300700001)(336012)(426003)(1076003)(26005)(40460700003)(16526019)(356005)(110136005)(70586007)(70206006)(83380400001)(81166007)(54906003)(316002)(478600001)(6666004)(2906002)(5660300002)(86362001)(44832011)(8936002)(2616005)(7416002)(36860700001)(7696005)(8676002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:22:14.7063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797607b8-caba-4ebd-7567-08dbaa360e57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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
index 9151ec5b879b..da4f1b303d6c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -979,6 +979,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
+		struct pci_host_bridge *host_bridge;
+
 		dport->rcrb.base = rcrb;
 		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
@@ -987,6 +989,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
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

