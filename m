Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDD78CBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjH2SUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjH2STh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:19:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7B184;
        Tue, 29 Aug 2023 11:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zkxc+Gl1AfrezmyR7l5EOjcvc9JF4sOeqM6p6RvV8XKmZgzJ1b1Z3KkTLLU9IiTW4MR1b2nO+EdK3+XRo5XNshI2iZraOxwASM3l2VMPaCvr9rIvqCsbQTnsHa062RHK+1+QDJ25VcMmkkXNeMv+IfyqyyzpNdXHR/neXzg2QNp1UqMH2blEqtbLNIhGBjDb/i6/6vqQ5t/jVVCX6NynVy4GljnyiOh0AhaDwi7UEOGqvXe4guhjJhlYjt4iEAlZlDbTlrsh+GDnzjr1ynzDuaaMKf6ZGFDCTSb+Tmm0m+uSYG8AebyAzkZ0yQ6zgeZjNTaFEFK1wL6+sRivc72c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w/qQ0lc3lylwtkE1ZQ+H8PZshSMOtRS1Bm6V4qz37g=;
 b=HbAT5Mip6sL3NejA7PWLiTlD4peE+zODTT18qM/3LNU3yD1xd5EJRhlgZ2LSxjQUQZZRkhDoa4BWnNGHQSYuW2o1CYnfVGsikcqZx+fOFdzQv6LzJrzYOm09qYdwge8+MPOTyywtcQBunLd4FdcZO/pd9fpi+tSgN9Va43uPJ+zGxSOMkyimNyjb5poUYazQ69u6FYbuR14EnL4VNRbgHQE0tySIGtDcZOEVoiBIj1oiHiH3E/RGWQ581h+ineIkZT5L3F0FmUj/L9rCEcSRCg9AQRnKsfiSrZGW+EhBMxbS9l4FHWDvv7DXPChNsadb7TolzyKCf59Fnd3S9BU4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w/qQ0lc3lylwtkE1ZQ+H8PZshSMOtRS1Bm6V4qz37g=;
 b=sBFRQvmbmAzsWR9AVkIl8olSArTrElyT3jvJTazs1U5Yc231UoZi5nAss5VFYvx7kh1sYDKDontYHu+Pbkdn+BDxrsps9WAMRJrJSloETALJDmt0V7NXfMkvFjdZEljrbzCJIP0BqnNUyxk74VgpXgRkTOWZfUe+hK7ftiyDHXI=
Received: from BY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:180::44)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 18:19:30 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::63) by BY5PR13CA0031.outlook.office365.com
 (2603:10b6:a03:180::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17 via Frontend
 Transport; Tue, 29 Aug 2023 18:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 18:19:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 13:19:24 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 29 Aug 2023 13:19:12 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v4 3/3] remoteproc: zynqmp: get TCM from device-tree
Date:   Tue, 29 Aug 2023 11:19:00 -0700
Message-ID: <20230829181900.2561194-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829181900.2561194-1-tanmay.shah@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 57be7a41-b788-4054-0cd3-08dba8bc7c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dCNeGUayjfu2nmDu9M+6Grf/eqDnqhSvn18Zz2zlyawvhIkKMWAh4TJ07ECcFXI+nlx4FOMGj9B18dHjkN249QqtiZFZqDkfVDZ6dl3+M2+qUly1Zg3HUyXl2MtBI5Uv1KjLLEbdh+DG4XFC/eZyJOWvW2PqigvRfjKtacJ61Yc4+Ou0ICf6o0xEooAcvh1XyLNbcrNqzZCEJIw6KS04QmldjW6XdtPqtc9ts9QNqEwEMuLhj4B/XaMEayKtOANIBe60rLfC2guwF2ktipc2JtzuCt1jDwsXreSezO6cHUS91AcNr6mCR+4m1N14Nd/oD7nTrO51y8PbYlmE7ga+mqV7DtpcJMUBR3kj+fnhsHo0/DkULcu2l/X/OG/bde0xGjQ3v48EA+mNYS9fjqa8K1d4gOtOqFdmrtM3bkVqUiVds8DoUwDNdGfwtGDF5E4WPy4NZRvBl/sBlkiqA6RXq7Pw9dyrO+nSg3uPx45pGyNGRMIY4vLN781zTG3CWuLfpM/zII8w3lxIFCInz84jaMcOAkQDNXkXsPFOlVP/s2kzHzKIaQPTpepXlCuZG4GsqQaGHTJyYqQKXcMSledZCxV5FPEwEkQTGMH6f6gwwWXzem2Aif2dhE3eGA0jvawjxAm73SCNapNYFHQpD0AV209JUH20lLTeYUU//LqHYxnpeL7Be9uz4SK26wdtAbm8ur2J2ILTBOneDs6DHJT/fUPBXDlRvqkp3D4QCUg1TcT0vkMaVgJYk5qbAOIKoQ8i5JklwJk2Xee5Q8jlyRxawQV0nywL3ikJDjvNHwQfzw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(66899024)(6666004)(110136005)(2616005)(1076003)(40480700001)(40460700003)(30864003)(44832011)(2906002)(5660300002)(6636002)(70206006)(4326008)(8676002)(70586007)(54906003)(36756003)(8936002)(86362001)(316002)(41300700001)(82740400003)(83380400001)(81166007)(356005)(478600001)(36860700001)(47076005)(26005)(336012)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 18:19:29.6979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57be7a41-b788-4054-0cd3-08dba8bc7c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new dt bindings to get TCM address and size
information. Also make sure that driver stays
compatible with previous device-tree bindings.
So, if TCM information isn't available in device-tree
for zynqmp platform, hard-coded address of TCM will
be used.

New platforms that are compatible with this
driver must add TCM support in device-tree as per new
bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
 1 file changed, 221 insertions(+), 58 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index feca6de68da2..4eb62eb545c2 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -39,15 +39,19 @@ enum zynqmp_r5_cluster_mode {
  * struct mem_bank_data - Memory Bank description
  *
  * @addr: Start address of memory bank
+ * @da: device address for this tcm bank
  * @size: Size of Memory bank
  * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
+ * @pm_domain_id2: second core's corresponding TCM's pm_domain_id
  * @bank_name: name of the bank for remoteproc framework
  */
 struct mem_bank_data {
-	phys_addr_t addr;
-	size_t size;
+	u32 addr;
+	u32 da;
+	u32 size;
 	u32 pm_domain_id;
-	char *bank_name;
+	u32 pm_domain_id2;
+	char bank_name[32];
 };
 
 /**
@@ -75,11 +79,17 @@ struct mbox_info {
  * Hardcoded TCM bank values. This will be removed once TCM bindings are
  * accepted for system-dt specifications and upstreamed in linux kernel
  */
-static const struct mem_bank_data zynqmp_tcm_banks[] = {
-	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
-	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
-	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
-	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
+static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
+	{0xffe00000, 0x0, 0x10000, PD_R5_0_ATCM, 0, "atcm0"}, /* TCM 64KB each */
+	{0xffe20000, 0x20000, 0x10000, PD_R5_0_BTCM, 0, "btcm0"},
+	{0xffe90000, 0x0, 0x10000, PD_R5_1_ATCM, 0, "atcm1"},
+	{0xffeb0000, 0x20000, 0x10000, PD_R5_1_BTCM, 0, "btcm1"},
+};
+
+/* TCM 128KB each */
+static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
+	{0xffe00000, 0x0, 0x20000, PD_R5_0_ATCM, PD_R5_1_ATCM, "atcm0"},
+	{0xffe20000, 0x20000, 0x20000, PD_R5_0_BTCM, PD_R5_1_BTCM, "btcm0"},
 };
 
 /**
@@ -422,6 +432,7 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
 				      struct rproc_mem_entry *mem)
 {
 	iounmap((void __iomem *)mem->va);
+
 	return 0;
 }
 
@@ -526,30 +537,6 @@ static int tcm_mem_map(struct rproc *rproc,
 	/* clear TCMs */
 	memset_io(va, 0, mem->len);
 
-	/*
-	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
-	 * while on the Linux side they are at 0xffexxxxx.
-	 *
-	 * Zero out the high 12 bits of the address. This will give
-	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
-	 */
-	mem->da &= 0x000fffff;
-
-	/*
-	 * TCM Banks 1A and 1B still have to be translated.
-	 *
-	 * Below handle these two banks' absolute addresses (0xffe90000 and
-	 * 0xffeb0000) and convert to the expected relative addresses
-	 * (0x0 and 0x20000).
-	 */
-	if (mem->da == 0x90000 || mem->da == 0xB0000)
-		mem->da -= 0x90000;
-
-	/* if translated TCM bank address is not valid report error */
-	if (mem->da != 0x0 && mem->da != 0x20000) {
-		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
-		return -EINVAL;
-	}
 	return 0;
 }
 
@@ -571,6 +558,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 	u32 pm_domain_id;
 	size_t bank_size;
 	char *bank_name;
+	u32 da;
 
 	r5_core = rproc->priv;
 	dev = r5_core->dev;
@@ -586,6 +574,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 		bank_name = r5_core->tcm_banks[i]->bank_name;
 		bank_size = r5_core->tcm_banks[i]->size;
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
+		da = r5_core->tcm_banks[i]->da;
 
 		ret = zynqmp_pm_request_node(pm_domain_id,
 					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
@@ -599,7 +588,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 			bank_name, bank_addr, bank_size);
 
 		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
-						 bank_size, bank_addr,
+						 bank_size, da,
 						 tcm_mem_map, tcm_mem_unmap,
 						 bank_name);
 		if (!rproc_mem) {
@@ -632,14 +621,14 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
  */
 static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 {
+	u32 pm_domain_id, da, pm_domain_id2;
 	struct rproc_mem_entry *rproc_mem;
 	struct zynqmp_r5_core *r5_core;
 	int i, num_banks, ret;
-	phys_addr_t bank_addr;
-	size_t bank_size = 0;
+	u32 bank_size = 0;
 	struct device *dev;
-	u32 pm_domain_id;
 	char *bank_name;
+	u32 bank_addr;
 
 	r5_core = rproc->priv;
 	dev = r5_core->dev;
@@ -653,12 +642,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	 * So, Enable each TCM block individually, but add their size
 	 * to create contiguous memory region.
 	 */
-	bank_addr = r5_core->tcm_banks[0]->addr;
-	bank_name = r5_core->tcm_banks[0]->bank_name;
-
 	for (i = 0; i < num_banks; i++) {
-		bank_size += r5_core->tcm_banks[i]->size;
+		bank_addr = r5_core->tcm_banks[i]->addr;
+		bank_name = r5_core->tcm_banks[i]->bank_name;
+		bank_size = r5_core->tcm_banks[i]->size;
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
+		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
+		da = r5_core->tcm_banks[i]->da;
+
+		dev_dbg(dev, "TCM %s addr=0x%x, size=0x%x",
+			bank_name, bank_addr, bank_size);
 
 		/* Turn on each TCM bank individually */
 		ret = zynqmp_pm_request_node(pm_domain_id,
@@ -668,23 +661,28 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
 			goto release_tcm_lockstep;
 		}
-	}
 
-	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
-		bank_name, bank_addr, bank_size);
-
-	/* Register TCM address range, TCM map and unmap functions */
-	rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
-					 bank_size, bank_addr,
-					 tcm_mem_map, tcm_mem_unmap,
-					 bank_name);
-	if (!rproc_mem) {
-		ret = -ENOMEM;
-		goto release_tcm_lockstep;
-	}
+		/* Turn on each TCM bank individually */
+		ret = zynqmp_pm_request_node(pm_domain_id2,
+					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		if (ret < 0) {
+			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id2);
+			goto release_tcm_lockstep;
+		}
 
-	/* If registration is success, add carveouts */
-	rproc_add_carveout(rproc, rproc_mem);
+		/* Register TCM address range, TCM map and unmap functions */
+		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
+						 bank_size, da,
+						 tcm_mem_map, tcm_mem_unmap,
+						 bank_name);
+		if (!rproc_mem) {
+			ret = -ENOMEM;
+			goto release_tcm_lockstep;
+		}
+
+		rproc_add_carveout(rproc, rproc_mem);
+	}
 
 	return 0;
 
@@ -693,7 +691,12 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	for (i--; i >= 0; i--) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 		zynqmp_pm_release_node(pm_domain_id);
+		if (pm_domain_id2) {
+			pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
+			zynqmp_pm_release_node(pm_domain_id2);
+		}
 	}
+
 	return ret;
 }
 
@@ -800,17 +803,23 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
  */
 static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 {
+	u32 pm_domain_id, pm_domain_id2;
 	struct zynqmp_r5_core *r5_core;
-	u32 pm_domain_id;
 	int i;
 
 	r5_core = rproc->priv;
 
 	for (i = 0; i < r5_core->tcm_bank_count; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
+		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
 		if (zynqmp_pm_release_node(pm_domain_id))
 			dev_warn(r5_core->dev,
 				 "can't turn off TCM bank 0x%x", pm_domain_id);
+		if (pm_domain_id2 && zynqmp_pm_release_node(pm_domain_id2))
+			dev_warn(r5_core->dev,
+				 "can't turn off TCM bank 0x%x", pm_domain_id2);
+		dev_dbg(r5_core->dev, "pm_domain_id=%d, pm_domain_id2=%d\n",
+			pm_domain_id, pm_domain_id2);
 	}
 
 	return 0;
@@ -883,6 +892,137 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	return ERR_PTR(ret);
 }
 
+static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
+{
+	int i, j, tcm_bank_count, ret = -EINVAL;
+	struct zynqmp_r5_core *r5_core;
+	struct of_phandle_args out_arg;
+	struct platform_device *cpdev;
+	struct resource *res = NULL;
+	u64 abs_addr = 0, size = 0;
+	struct mem_bank_data *tcm;
+	struct device_node *np, *np1 = NULL;
+	struct device *dev;
+
+	for (i = 0; i < cluster->core_count; i++) {
+		r5_core = cluster->r5_cores[i];
+		dev = r5_core->dev;
+		np = dev_of_node(dev);
+
+		/* we have address cell 2 and size cell as 2 */
+		ret = of_property_count_elems_of_size(np, "reg",
+						      4 * sizeof(u32));
+		if (ret <= 0) {
+			ret = -EINVAL;
+			goto fail_tcm;
+		}
+
+		tcm_bank_count = ret;
+
+		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
+						  sizeof(struct mem_bank_data *),
+						  GFP_KERNEL);
+		if (!r5_core->tcm_banks) {
+			ret = -ENOMEM;
+			goto fail_tcm;
+		}
+
+		r5_core->tcm_bank_count = tcm_bank_count;
+		for (j = 0; j < tcm_bank_count; j++) {
+			tcm = kzalloc(sizeof(struct mem_bank_data *), GFP_KERNEL);
+			if (!tcm) {
+				ret = -ENOMEM;
+				goto fail_tcm;
+			}
+
+			r5_core->tcm_banks[j] = tcm;
+			/* get tcm address without translation */
+			ret = of_property_read_reg(np, j, &abs_addr, &size);
+			if (ret) {
+				dev_err(dev, "failed to get reg property\n");
+				goto fail_tcm;
+			}
+
+			/*
+			 * remote processor can address only 32 bits
+			 * so convert 64-bits into 32-bits. This will discard
+			 * any unwanted upper 32-bits.
+			 */
+			tcm->da = (u32)abs_addr;
+			tcm->size = (u32)size;
+
+			cpdev = to_platform_device(dev);
+			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
+			if (!res) {
+				dev_err(dev, "failed to get tcm resource\n");
+				ret = -EINVAL;
+				goto fail_tcm;
+			}
+
+			tcm->addr = (u32)res->start;
+			res = devm_request_mem_region(dev, tcm->addr, tcm->size, res->name);
+			if (!res) {
+				dev_err(dev, "failed to request tcm resource\n");
+				ret = -EINVAL;
+				goto fail_tcm;
+			}
+
+			memcpy(tcm->bank_name, res->name, ARRAY_SIZE(tcm->bank_name));
+			np = of_node_get(dev_of_node(dev));
+			/*
+			 * In dt power-domains are described in this order:
+			 * <RPU core>, <atcm>,  <btcm>
+			 * parse power domains for tcm accordingly
+			 */
+			of_parse_phandle_with_args(np, "power-domains",
+						   "#power-domain-cells",
+						   j + 1, &out_arg);
+			tcm->pm_domain_id = out_arg.args[0];
+			of_node_put(out_arg.np);
+
+			dev_dbg(dev, "TCM: %s, dma=0x%x, da=0x%x, size=0x%x\n",
+				tcm->bank_name, tcm->addr, tcm->da, tcm->size);
+			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id);
+
+			if (cluster->mode == SPLIT_MODE)
+				continue;
+
+			/* Turn on core-1's TCM as well */
+			np1 = of_get_next_child(dev_of_node(cluster->dev),
+						r5_core->np);
+			if (!np1) {
+				of_node_put(np1);
+				np1 = NULL;
+				goto fail_tcm;
+			}
+
+			of_parse_phandle_with_args(np1, "power-domains",
+						   "#power-domain-cells",
+						   j + 1, &out_arg);
+			tcm->pm_domain_id2 = out_arg.args[0];
+			of_node_put(out_arg.np);
+			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id2);
+		}
+	}
+
+	return 0;
+
+fail_tcm:
+	while (i >= 0) {
+		r5_core = cluster->r5_cores[i];
+		for (j = 0; j < r5_core->tcm_bank_count; j++) {
+			if (!r5_core->tcm_banks)
+				continue;
+			tcm = r5_core->tcm_banks[j];
+			kfree(tcm);
+		}
+		kfree(r5_core->tcm_banks);
+		i--;
+	}
+
+	return ret;
+}
+
 /**
  * zynqmp_r5_get_tcm_node()
  * Ideally this function should parse tcm node and store information
@@ -895,12 +1035,20 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
  */
 static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
 {
+	const struct mem_bank_data *zynqmp_tcm_banks;
 	struct device *dev = cluster->dev;
 	struct zynqmp_r5_core *r5_core;
 	int tcm_bank_count, tcm_node;
 	int i, j;
 
-	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
+	if (cluster->mode == SPLIT_MODE) {
+		zynqmp_tcm_banks = zynqmp_tcm_banks_split;
+		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_split);
+	} else {
+		zynqmp_tcm_banks = zynqmp_tcm_banks_lockstep;
+		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_lockstep);
+	}
+
 
 	/* count per core tcm banks */
 	tcm_bank_count = tcm_bank_count / cluster->core_count;
@@ -951,10 +1099,25 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 			       enum rpu_tcm_comb tcm_mode)
 {
 	struct device *dev = cluster->dev;
+	struct device_node *np;
 	struct zynqmp_r5_core *r5_core;
 	int ret, i;
 
-	ret = zynqmp_r5_get_tcm_node(cluster);
+	/*
+	 * try to get tcm nodes from dt but if fail, use hardcode addresses only
+	 * for zynqmp platform. New platforms must use dt bindings for TCM.
+	 */
+	ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
+	if (ret) {
+		np = of_get_compatible_child(dev_of_node(dev), "xlnx,zynqmp-r5f");
+		if (np) {
+			ret = zynqmp_r5_get_tcm_node(cluster);
+		} else {
+			dev_err(dev, "tcm not found\n");
+			return -EINVAL;
+		}
+	}
+
 	if (ret < 0) {
 		dev_err(dev, "can't get tcm node, err %d\n", ret);
 		return ret;
-- 
2.25.1

