Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89275AED8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGTMzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGTMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:55:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA926BF;
        Thu, 20 Jul 2023 05:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8qpsf4vm+3M9XC3FYQPsEWoBKQQrQd1jEo72DMhxoq4CdmkAsHuoHkdExzT0nuJV2x6O5k3796S/Q6QowbEPBi/j8jMid1vBfmWUK+fpXKAEIGGF7KHqSRDeb8PLRFklJExxzEBsdt/5OBflZdk34/NrshoK+M8MLgDF4BErugqqaBYi30tECjNeTLAputrR4zNtSjsLX4JMsKYtXeJPGjFajW/UKHSvLhm2D1/4UtQy5bcWEizEg9tgTg8vPcLUFozAnJiSiZxh6kz6YhjD3A3CNsF73HrX8N48/PrN/C/07TB5vUPvz73Aqo3FX6hcpP1C78K60KgtxKbQ22m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id3Ep6tox7jziFtgXSfdfgpg6msnemBUMm+8mCJC0ig=;
 b=IszMwCxTqUmZQQ6jSrKZHAl+VDnkedklrpq+74jK468M+G3KOCUvNyNOl75lda2heLUXDp408cJitdoSRXpu2Pm0nosNr2DL8D4ZtcIp/Vij0XR423yjKaRiSVLpoRM7gyjU8dwkWsKIAJvVfTRxFVhYhzFeT0twtuku/5s6yBvbgAZUiAB6DdxKZYqdSuEpfE3fMva+Rakb7MkjEA1Bx5wy+Vm7K36z2PJQXBOOVW3kXOhToqw5levhL9gs546PfhOrSLk6nRx8XBOIdvw/BEaCxIjnz81zC176hM9YqNYqnedkT3d/mNJCdaXbYpK58kPXFzcBt1/sG1axBxR63Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id3Ep6tox7jziFtgXSfdfgpg6msnemBUMm+8mCJC0ig=;
 b=R9bkj+unnx+Zqve7VZoMrXNgOC9RS3uqi/vrxLKmK1H7WnsJdGrKXtD3f9xvnCcHQ+MhXMFXQU4epplBcBBRKiSvCQDzj68YZrLdeogOo2GI73XxtP4jnYEUS4uMgDGeqXjkkuSvRtmo7H16mEMFnQLVWYYRlMNApwtPEfv7fyk=
Received: from BN9PR03CA0313.namprd03.prod.outlook.com (2603:10b6:408:112::18)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 12:54:57 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::f2) by BN9PR03CA0313.outlook.office365.com
 (2603:10b6:408:112::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 12:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.25 via Frontend Transport; Thu, 20 Jul 2023 12:54:57 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 07:54:54 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <nchatrad@amd.com>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 5/7] EDAC/amd64: Add Fam19h Model 90h ~ 9fh enumeration support
Date:   Thu, 20 Jul 2023 12:54:23 +0000
Message-ID: <20230720125425.3735538-6-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720125425.3735538-1-muralimk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: d9109e6d-632d-4bfc-0b09-08db89208587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAgUJEUm9IDeGm8vLvJNwhuDiTF58I66uif4PCLOxYF7V8+KlsdrMp5aqNn653EEtYGWyefGZuA375upXztiigMiDC1xu7KBO0Mg8YCcWo+buhvorp1zXMhXo4NoQfNqAk8H2bYjO5KmzamJZiJQas92+R7h5qktyZ2PVljksdWXPcLyMqewlwB6+rPwD/77Tk8LbvM9r9KLkishyv1/2Lxn+DFQnS7QdFl8KBhW7w2HKhmgkZyC+sU/gBvQePuioelqQDt7qzqywS4RyjILbaj2QWlDXIg8g0owBBe8UdSEsCrsjVosG900YQbQrLy57rVGw3dvyNwLe2yjR0JBN+2TKxYyQHUDklOloFco6pdSFe2bmgfU6H+iuGPQJToxHwK+qIsAbQ5WVQHKDVNZYfl0UOYe5dg+9qZKUVkyowCUIZ/ILzSsLS3PRjsEO29qdaiebHDCRqJ2QAbSylJeGCBc/58AqlKMfeiWNSE5pFbLrgbdWAO9NO912Y2nrYeylqJCeOODZ/RgrDGqUXey8QNeiHaXl+hu42Cuvu26Um82zSTNkY0v87gkGM6N2XljPqPP3jCk+Cg9SwaUyNJWAM7h+W6M5pO8kqAFmO0X6RZjoCU3gvcTXZitvawZvhGpdvuwmlahl44Pvki8SSTjB/v9YNyTUYg+e2843rSNEU4gYIvHyuHpg3CkkTC8ji8Ag6vViMQIy87h6BkZxDnz9IFTkaIXKYoONkpaeHO7FrxGKlDOPO7Oy/8hh/CMq7ksTCD7l/++ilZIg1nu1xN8eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(478600001)(83380400001)(336012)(1076003)(26005)(41300700001)(40480700001)(186003)(110136005)(54906003)(8936002)(8676002)(316002)(356005)(2906002)(4326008)(7696005)(36860700001)(70206006)(6666004)(81166007)(40460700003)(2616005)(426003)(70586007)(16526019)(5660300002)(47076005)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:54:57.4767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9109e6d-632d-4bfc-0b09-08db89208587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add AMD family 19h Model 90h-9fh. Models 90h-9fh are APUs, and
they have built-in HBM3 memory. ECC support is enabled by default.

APU models have a single Data Fabric (DF) per Package. Each DF is
visible to the OS in the same way as chiplet-based systems like
Rome and later. However, the Unified Memory Controllers (UMCs) are
arranged in the same way as GPU-based MI200 devices rather than
CPU-based systems.
So, it uses the gpu_ops for enumeration and adds a few fixups.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/amd64_edac.c | 65 +++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 597dae7692b1..45d8093c117a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -996,12 +996,16 @@ static struct local_node_map {
 #define LNTM_NODE_COUNT				GENMASK(27, 16)
 #define LNTM_BASE_NODE_ID			GENMASK(11, 0)
 
-static int gpu_get_node_map(void)
+static int gpu_get_node_map(struct amd64_pvt *pvt)
 {
 	struct pci_dev *pdev;
 	int ret;
 	u32 tmp;
 
+	/* return early for non heterogeneous systems */
+	if (pvt->F3->device != PCI_DEVICE_ID_AMD_MI200_DF_F3)
+		return 0;
+
 	/*
 	 * Node ID 0 is reserved for CPUs.
 	 * Therefore, a non-zero Node ID means we've already cached the values.
@@ -3851,7 +3855,7 @@ static void gpu_init_csrows(struct mem_ctl_info *mci)
 
 			dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
 			dimm->edac_mode = EDAC_SECDED;
-			dimm->mtype = MEM_HBM2;
+			dimm->mtype = pvt->dram_type;
 			dimm->dtype = DEV_X16;
 			dimm->grain = 64;
 		}
@@ -3880,6 +3884,9 @@ static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
 	return true;
 }
 
+/* Base address used for channels selection on GPUs */
+static u32 gpu_umc_base = 0x50000;
+
 static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
 {
 	/*
@@ -3893,13 +3900,32 @@ static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
 	 * On GPU nodes channels are selected in 3rd nibble
 	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
 	 * HBM chX[7:4]= [Y+1]5X[3:0]000
+	 *
+	 * On APU nodes, same as GPU but with diff base 0x90000;
 	 */
 	umc *= 2;
 
 	if (channel >= 4)
 		umc++;
 
-	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
+	return gpu_umc_base + (umc << 20) + ((channel % 4) << 12);
+}
+
+static void gpu_determine_memory_type(struct amd64_pvt *pvt)
+{
+	if (pvt->fam == 0x19) {
+		switch (pvt->model) {
+		case 0x30 ... 0x3F:
+			pvt->dram_type = MEM_HBM2;
+			break;
+		case 0x90 ... 0x9F:
+			pvt->dram_type = MEM_HBM3;
+			break;
+		default:
+			break;
+		}
+	}
+	edac_dbg(1, "  MEM type: %s\n", edac_mem_types[pvt->dram_type]);
 }
 
 static void gpu_read_mc_regs(struct amd64_pvt *pvt)
@@ -3960,7 +3986,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
 {
 	int ret;
 
-	ret = gpu_get_node_map();
+	ret = gpu_get_node_map(pvt);
 	if (ret)
 		return ret;
 
@@ -3971,6 +3997,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
 	gpu_prep_chip_selects(pvt);
 	gpu_read_base_mask(pvt);
 	gpu_read_mc_regs(pvt);
+	gpu_determine_memory_type(pvt);
 
 	return 0;
 }
@@ -4142,6 +4169,12 @@ static int per_family_init(struct amd64_pvt *pvt)
 			pvt->ctl_name			= "F19h_M70h";
 			pvt->flags.zn_regs_v2		= 1;
 			break;
+		case 0x90 ... 0x9f:
+			pvt->ctl_name			= "F19h_M90h";
+			pvt->max_mcs			= 4;
+			gpu_umc_base			= 0x90000;
+			pvt->ops			= &gpu_ops;
+			break;
 		case 0xa0 ... 0xaf:
 			pvt->ctl_name			= "F19h_MA0h";
 			pvt->max_mcs			= 12;
@@ -4166,23 +4199,31 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
 	NULL
 };
 
+/*
+ * For Heterogeneous and APU models EDAC CHIP_SELECT and CHANNEL layers
+ * should be swapped to fit into the layers.
+ */
+static unsigned int get_layer_size(struct amd64_pvt *pvt, u8 layer)
+{
+	bool is_gpu = (pvt->ops == &gpu_ops);
+
+	if (!layer)
+		return is_gpu ? pvt->max_mcs : pvt->csels[0].b_cnt;
+
+	return is_gpu ? pvt->csels[0].b_cnt : pvt->max_mcs;
+}
+
 static int init_one_instance(struct amd64_pvt *pvt)
 {
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
 	int ret = -ENOMEM;
 
-	/*
-	 * For Heterogeneous family EDAC CHIP_SELECT and CHANNEL layers should
-	 * be swapped to fit into the layers.
-	 */
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
-			 pvt->max_mcs : pvt->csels[0].b_cnt;
+	layers[0].size = get_layer_size(pvt, 0);
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
-			 pvt->csels[0].b_cnt : pvt->max_mcs;
+	layers[1].size = get_layer_size(pvt, 1);
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
-- 
2.25.1

