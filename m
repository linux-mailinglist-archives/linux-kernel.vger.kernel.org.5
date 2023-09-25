Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1B7ADDCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjIYR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:27:14 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A1101;
        Mon, 25 Sep 2023 10:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bol7epGd2wqEAld4i7AlThHeY/gSC1AR1sw1D3O/+bivQQ6jVX6PdpUOlKFSQEsx+RqWtec3M41mBcOsGDfXw95bOa44uzChlWQbBKClFaooMwKN2U1ViyEv4lZsDI5inDz1RURJO3Ir/T+vFPvCXzaKxo+Sc2F4/mGiHCT2+ythStOFQrJLOAhIjFTwMTPQM9i9KYN65NJqjmRJWVZTP2WpsI8bNPjkiOfE8E7gj1Sl32J9yP7vGHH8YNBulq77fLeEuQAY2WfSy+B/AdSuhb0XBZWr8qExGNtsSSt3DbjI7HzStdw+HK7chKpoEplWWzq0ggIxYFxeWsuXsxoXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqpmdxANGDlQIOwiMpn/heYrA9rELHCgFY4p1Nz7umA=;
 b=TwvISiml5tFbvKLwghjrjwR/qbTwDaOUuf20RpRHDraSizcwAoVLYU0s6kns1r/Njt+fSJxr/xMxEmcqvx27fYtLOfvi9TlP6bWuX/JKmsM6jnk/5Hkl/+wBj7lbgoGyJFqNNU5H9nlrf9qWhjc9/m2RSDGff2E73k86suY1gRMEPyqN8tiLFQgu6x0+PKhZrcnuCHlHspu9BcFShByNoa0XXyOGH3rnFA0JqUjmljF6ICR71Eh2pdNullrMMAfMP6eb9Ay2Xvch7vFeOTBlwdA5uvVvnU9OhNFR2HTuvoqLYjon+eJTUrVk3u4dDKeNRQS/I9lezMdKg+k1o7vF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqpmdxANGDlQIOwiMpn/heYrA9rELHCgFY4p1Nz7umA=;
 b=nXbAhV4qtHzuOVQeQ6xst9ZxBwuM8UCk58RLZ3xaMwSSkITAuYw1isTvgIhWT3iT5NhH9SUf+JleBg+muwHuxRQcDP4CdkesW0ts3QC9nsPoq8xKDl1/r05Qv7mh1GMV9bK6fAfvl+6PBNrm4wVYi9HVFVPozyBn+O5PwmGdQ6E=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 17:27:05 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::fc) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Mon, 25 Sep 2023 17:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 17:27:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 12:27:03 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 25 Sep 2023 12:27:02 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <mathieu.poirier@linaro.org>, <andersson@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH] remoteproc: zynqmp: change tcm address translation method
Date:   Mon, 25 Sep 2023 10:26:48 -0700
Message-ID: <20230925172648.2339048-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 0968eef8-cb19-44f9-cc08-08dbbdeca2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MIxOC2rwD/ghq6iaR2UfWmvAbuF75kx1b2etCZpVprhXYmrIoTKwHnACb8wlxnk+xhh2JbIGtm/dOs1GX5LU6wEKMBQdkMopl64flFLDgcmdHZb2Iav3JNJGf9pyG6AS1c6+B1Y+LD8CCG7uTiLdnfNZr9xiGCMvYYuLxPD0A7GyMqgGcWoOVuXyoEvPbY/SCf1XbKbIqA3Eo/b0NfudEyh3WZqF6RxueLPSDyPY3JNmGJ28z/ixXjrXR7WSblIki3/jRiVQYkU20OgIluHjmnlAlicGl2UcFRgaNH8T2EZh9iBAr59eKGKDzEwaP5N6aLIy/h3KE8OaeDteim5d8TXdGg8dlhv36Uv6twzwjViccCSWfrnZK5JQIPprXf+sm/Dnfak9+Kh9ABjhxOLy1ONVai4zKLcfZb3KImcFWQWneVxXYipeniAq6Z3cLy3QKJZmgQdlKSZcwH2hNojUJYKR8HZ0bnX6RVg+KwwRLVqUJd1Dbu7LH5gcFwCX91ut/hXG6/Pop4fKdZ1sTOcMm0OCXfHJxrt9YyZe4Vj1XQhRPaUhMFa42H4aGu3V4CixsnyNTjOj9SX4idoo69fiYmoBi8TBUZU8Wj4rY8E4jNKvGVOn6cLOeIrSZDSs2EMwGbGzm6IwbGCWG5esV9mAAgyONGa9LUOgdYVRNaB9ZXqlaDQKoBwgP4hC52Hq8ESVaOiY8qkCuPkV+kAqXBgZY6v31jt1rD4OKgEDw1WSe7sH79Q3ZXC3R1VHiNLgHxmyO05DY5qimvPQl/LuA8NeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(1076003)(47076005)(83380400001)(356005)(6666004)(82740400003)(86362001)(426003)(336012)(5660300002)(8676002)(4326008)(8936002)(36860700001)(26005)(316002)(70586007)(70206006)(40460700003)(110136005)(40480700001)(54906003)(44832011)(41300700001)(81166007)(478600001)(36756003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:27:04.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0968eef8-cb19-44f9-cc08-08dbbdeca2ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce device address in hardcode TCM table.
Device address is used for address translation.
Also, previous method(hack) to mask few bits from address
to achieve address translation is removed

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 58 +++++++++----------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index efd758c2f4ed..4395edea9a64 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -39,12 +39,14 @@ enum zynqmp_r5_cluster_mode {
  * struct mem_bank_data - Memory Bank description
  *
  * @addr: Start address of memory bank
+ * @da: device address
  * @size: Size of Memory bank
  * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
  * @bank_name: name of the bank for remoteproc framework
  */
 struct mem_bank_data {
 	phys_addr_t addr;
+	u32 da;
 	size_t size;
 	u32 pm_domain_id;
 	char *bank_name;
@@ -76,18 +78,18 @@ struct mbox_info {
  * accepted for system-dt specifications and upstreamed in linux kernel
  */
 static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
-	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
-	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
-	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
-	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
+	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
+	{0xffe20000UL, 0x20000, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
+	{0xffe90000UL, 0x0, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
+	{0xffeb0000UL, 0x20000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
 };
 
 /* In lockstep mode cluster combines each 64KB TCM and makes 128KB TCM */
 static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
-	{0xffe00000UL, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
-	{0xffe20000UL, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
-	{0, 0, PD_R5_1_ATCM, ""},
-	{0, 0, PD_R5_1_BTCM, ""},
+	{0xffe00000UL, 0x0, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
+	{0xffe20000UL, 0x20000, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
+	{0, 0, 0, PD_R5_1_ATCM, ""},
+	{0, 0, 0, PD_R5_1_BTCM, ""},
 };
 
 /**
@@ -534,30 +536,6 @@ static int tcm_mem_map(struct rproc *rproc,
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
 
@@ -579,6 +557,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 	u32 pm_domain_id;
 	size_t bank_size;
 	char *bank_name;
+	u32 da;
 
 	r5_core = rproc->priv;
 	dev = r5_core->dev;
@@ -591,6 +570,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 	 */
 	for (i = 0; i < num_banks; i++) {
 		bank_addr = r5_core->tcm_banks[i]->addr;
+		da = r5_core->tcm_banks[i]->da;
 		bank_name = r5_core->tcm_banks[i]->bank_name;
 		bank_size = r5_core->tcm_banks[i]->size;
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
@@ -603,11 +583,11 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 			goto release_tcm_split;
 		}
 
-		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, size=0x%lx",
-			bank_name, bank_addr, bank_size);
+		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
+			bank_name, bank_addr, da, bank_size);
 
 		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
-						 bank_size, bank_addr,
+						 bank_size, da,
 						 tcm_mem_map, tcm_mem_unmap,
 						 bank_name);
 		if (!rproc_mem) {
@@ -648,6 +628,7 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	struct device *dev;
 	u32 pm_domain_id;
 	char *bank_name;
+	u32 da;
 
 	r5_core = rproc->priv;
 	dev = r5_core->dev;
@@ -679,11 +660,12 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 			continue;
 
 		bank_addr = r5_core->tcm_banks[i]->addr;
+		da = r5_core->tcm_banks[i]->da;
 		bank_name = r5_core->tcm_banks[i]->bank_name;
 
 		/* Register TCM address range, TCM map and unmap functions */
 		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
-						 bank_size, bank_addr,
+						 bank_size, da,
 						 tcm_mem_map, tcm_mem_unmap,
 						 bank_name);
 		if (!rproc_mem) {
@@ -695,8 +677,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 		/* If registration is success, add carveouts */
 		rproc_add_carveout(rproc, rproc_mem);
 
-		dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
-			bank_name, bank_addr, bank_size);
+		dev_dbg(dev, "TCM carveout lockstep mode %s addr=0x%llx, da=0x%x, size=0x%lx",
+			bank_name, bank_addr, da, bank_size);
 	}
 
 	return 0;

base-commit: 1a93ced18d7b81be39beba26b1c168ef21c8d0ad
-- 
2.25.1

