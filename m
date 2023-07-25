Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE5761CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGYPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGYPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:03:37 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0441FCB;
        Tue, 25 Jul 2023 08:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl7YTD5Vqff22z/rVmSkxcVI07HXH6MfyWXPRqmqL54Ph0nsu4QrNyKeqJTfyFEhLbFZyTFlqAXSW5RWxWkaz5EA2791Sc6ATxHVrNcgSelZvwGg0u4qxBGkSNT9uiWHqTllyVlNz5hFOCb1oMt2iyMPiuc6dW+jnz3Fync/Xe4h9uW8rjfcpn96D8jeiyyBK6HxGGn1HE5m13gIfONeklCExAfugo6dN2e9GUubOZ4bgmjTcv423Mk4rcYHjVP9+31oFDyUibqOl2Zf4sUAVeFkN2dC8sADZl6YG9BBZVz5dbO3If6g+y4SVLj6ZOAFS5gJK1PGAPX2zgWNVT6zYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICLZ/9nt3fWvMKEbAqfprVTqLnJ5sFkrxtoxWgeDiys=;
 b=X0ip+w9oxIfzaRz2ar/MI2vQXU3bj6EVEtMsHqj8ns7PABiazyDaNclaw31RGQIdY07L/tFpIgNqq/+0q6oiNMjRjLP62QLNXpqVoCYarDH08g5XGzWVHmB/QPsPjISbUbKhVsMYNGIEBgYko4po3DbaJegShkM22OIIzbfXoZaAev9kZ1S5Qih07HqeU8cm2AfR0rZDxY7bZR+k5CEegFeyqFoQKc2TQNTC6tk0D2RzVMGS9OnN5pIyx/9VruVCibZg75SJb3V/HXi7cbzZkP0+XTvCOrZ+9PDH0+hrzrxGJ815kCrRIA2VEam3HW2piRBPORVDbhrGqh/+y53l8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICLZ/9nt3fWvMKEbAqfprVTqLnJ5sFkrxtoxWgeDiys=;
 b=O9kQaeDscg1IvjtKobkN/S+K9FInXWlbmkqqNu23Nr1fleXkAdaZpl97+facoMdUxoauUg4zx8KdDMcqDLH/X8ftBeQP8JgA92uzoY/8T89z725kIltMPuhcXfWKnpprv4Cu6wFVOKcAIIYrQbRIKkFKiLT3xKToRyYgzbwQqNY=
Received: from MW4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:303:b6::35)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 15:03:01 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::21) by MW4PR03CA0090.outlook.office365.com
 (2603:10b6:303:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 15:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 15:03:00 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 10:02:45 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RESEND][PATCH v4 3/3] perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src
Date:   Tue, 25 Jul 2023 20:32:06 +0530
Message-ID: <20230725150206.184-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725150206.184-1-ravi.bangoria@amd.com>
References: <20230725150206.184-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a4b4ec-9749-463f-55ea-08db8d203d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyAkOb/OpG8PPitrqo91xGlEtwqb6HvhLyyHGw3fXcRm3jE/P6ZU4HljzkGuvd17sQhlVKc/m3cl1qUVxR4VOT3SUlVStgJMEldeQV+eff45nlKTzjZ6oDLGG+U5Jv1n6aGxY81RUZq2H2GYcK5+U7ZNYLqLvGGGEhYJ/PIxNhjqrBYgLC/rlXCa9OW2udOu8vNnWiTBqzGWmzP4up9yxgoCXYfbZ0BWJuwohSuGplr45RHb/vW82XwiCMHKCVPbJ/7Jzgu63RtTHaZQdNdXHLlrCuekZymYKPW7L6jPNxulEmY7hLJ7tAbWZSoupglx7LRS+oHTMWQFXNRHpFNE7PmGJuJl53qr5zvPpAl74kgIlyq8a2QcQE5PqGERRvmjIk9BQK/fBDS5g61FCSzxVvDwOykClJhoFFNEXEVSWeo8Ivs6DuVySVXImCRfsxyubI8ZExvTVkpkH5/OCXODVRDDhHELMh/5IKdVSscTKRmz4V3nHCYFyLYcYY5lJbqJLGw4hDkQPXH4iTQyq+eZhgEbDE4QhpAoCxvlUgLl7x6JZbZAzy+FcN4K0Qqa7HSNzHLU7u8PFig/47NwGtNsrnmLd8ceFb8qoapJTa+6bM03KPDQxSiSGgqAMtqnBePZIouQp0DF16/lJmd6Sa+uWY+t6mR5J3YtziKAkzDsw6Xg0+o/3PJYz6wmVqtpSq21AD/PfzhoJv6TWOhb8bW2U+SeCjMl+ubgDdfsiuNcjVbCl79sc5PsldPI3qnrChxAWIH0xSLUJOLuXbeIdWReCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(54906003)(70586007)(70206006)(426003)(2616005)(47076005)(36756003)(83380400001)(36860700001)(40480700001)(86362001)(82740400003)(356005)(81166007)(478600001)(110136005)(186003)(1076003)(336012)(6666004)(7696005)(26005)(16526019)(40460700003)(41300700001)(5660300002)(2906002)(316002)(4326008)(8676002)(8936002)(44832011)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:03:00.7066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a4b4ec-9749-463f-55ea-08db8d203d38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
limitations. Mainly:

1. mem_lvl_num doesn't allow setting multiple sources whereas old API
   allows it. Setting multiple data sources is useful because IBS on
   pre-zen4 uarch doesn't provide fine granular DataSrc details (there
   is only one such DataSrc(2h) though).
2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
   c2c (c2c_decode_stats()) does not use mem_lvl_num at all.

1st one can be handled using ANY_CACHE with HOPS_0. 2nd is purely perf
tool specific issue and should be fixed separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 156 +++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 88 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7d29be0a279b..6911c5399d02 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -728,38 +728,63 @@ static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
 	return op_data2->data_src_lo;
 }
 
-static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
-				 union ibs_op_data3 *op_data3,
-				 struct perf_sample_data *data)
+#define	L(x)		(PERF_MEM_S(LVL, x) | PERF_MEM_S(LVL, HIT))
+#define	LN(x)		PERF_MEM_S(LVLNUM, x)
+#define	REM		PERF_MEM_S(REMOTE, REMOTE)
+#define	HOPS(x)		PERF_MEM_S(HOPS, x)
+
+static u64 g_data_src[8] = {
+	[IBS_DATA_SRC_LOC_CACHE]	  = L(L3) | L(REM_CCE1) | LN(ANY_CACHE) | HOPS(0),
+	[IBS_DATA_SRC_DRAM]		  = L(LOC_RAM) | LN(RAM),
+	[IBS_DATA_SRC_REM_CACHE]	  = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
+	[IBS_DATA_SRC_IO]		  = L(IO) | LN(IO),
+};
+
+#define RMT_NODE_BITS			(1 << IBS_DATA_SRC_DRAM)
+#define RMT_NODE_APPLICABLE(x)		(RMT_NODE_BITS & (1 << x))
+
+static u64 g_zen4_data_src[32] = {
+	[IBS_DATA_SRC_EXT_LOC_CACHE]	  = L(L3) | LN(L3),
+	[IBS_DATA_SRC_EXT_NEAR_CCX_CACHE] = L(REM_CCE1) | LN(ANY_CACHE) | REM | HOPS(0),
+	[IBS_DATA_SRC_EXT_DRAM]		  = L(LOC_RAM) | LN(RAM),
+	[IBS_DATA_SRC_EXT_FAR_CCX_CACHE]  = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
+	[IBS_DATA_SRC_EXT_PMEM]		  = LN(PMEM),
+	[IBS_DATA_SRC_EXT_IO]		  = L(IO) | LN(IO),
+	[IBS_DATA_SRC_EXT_EXT_MEM]	  = LN(CXL),
+};
+
+#define ZEN4_RMT_NODE_BITS		((1 << IBS_DATA_SRC_EXT_DRAM) | \
+					 (1 << IBS_DATA_SRC_EXT_PMEM) | \
+					 (1 << IBS_DATA_SRC_EXT_EXT_MEM))
+#define ZEN4_RMT_NODE_APPLICABLE(x)	(ZEN4_RMT_NODE_BITS & (1 << x))
+
+static __u64 perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
+				  union ibs_op_data3 *op_data3,
+				  struct perf_sample_data *data)
 {
 	union perf_mem_data_src *data_src = &data->data_src;
 	u8 ibs_data_src = perf_ibs_data_src(op_data2);
 
 	data_src->mem_lvl = 0;
+	data_src->mem_lvl_num = 0;
 
 	/*
 	 * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
 	 * memory accesses. So, check DcUcMemAcc bit early.
 	 */
-	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
-		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
+		return L(UNC) | LN(UNC);
 
 	/* L1 Hit */
-	if (op_data3->dc_miss == 0) {
-		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_miss == 0)
+		return L(L1) | LN(L1);
 
 	/* L2 Hit */
 	if (op_data3->l2_miss == 0) {
 		/* Erratum #1293 */
 		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
-		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
-			data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
-			return;
-		}
+		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc))
+			return L(L2) | LN(L2);
 	}
 
 	/*
@@ -769,82 +794,36 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	if (data_src->mem_op != PERF_MEM_OP_LOAD)
 		goto check_mab;
 
-	/* L3 Hit */
 	if (ibs_caps & IBS_CAPS_ZEN4) {
-		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
-			return;
-		}
-	} else {
-		if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
-					    PERF_MEM_LVL_HIT;
-			return;
-		}
-	}
+		u64 val = g_zen4_data_src[ibs_data_src];
 
-	/* A peer cache in a near CCX */
-	if (ibs_caps & IBS_CAPS_ZEN4 &&
-	    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
-		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+		if (!val)
+			goto check_mab;
 
-	/* A peer cache in a far CCX */
-	if (ibs_caps & IBS_CAPS_ZEN4) {
-		if (ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
-			return;
-		}
-	} else {
-		if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
-			return;
+		/* HOPS_1 because IBS doesn't provide remote socket detail */
+		if (op_data2->rmt_node && ZEN4_RMT_NODE_APPLICABLE(ibs_data_src)) {
+			if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM)
+				val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
+			else
+				val |= REM | HOPS(1);
 		}
-	}
 
-	/* DRAM */
-	if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM) {
-		if (op_data2->rmt_node == 0)
-			data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
-		else
-			data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+		return val;
+	} else {
+		u64 val = g_data_src[ibs_data_src];
 
-	/* PMEM */
-	if (ibs_caps & IBS_CAPS_ZEN4 && ibs_data_src == IBS_DATA_SRC_EXT_PMEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
-		}
-		return;
-	}
+		if (!val)
+			goto check_mab;
 
-	/* Extension Memory */
-	if (ibs_caps & IBS_CAPS_ZEN4 &&
-	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
+		/* HOPS_1 because IBS doesn't provide remote socket detail */
+		if (op_data2->rmt_node && RMT_NODE_APPLICABLE(ibs_data_src)) {
+			if (ibs_data_src == IBS_DATA_SRC_DRAM)
+				val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
+			else
+				val |= REM | HOPS(1);
 		}
-		return;
-	}
 
-	/* IO */
-	if (ibs_data_src == IBS_DATA_SRC_EXT_IO) {
-		data_src->mem_lvl = PERF_MEM_LVL_IO;
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
-		}
-		return;
+		return val;
 	}
 
 check_mab:
@@ -855,12 +834,11 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	 * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
 	 * MAB only when IBS fails to provide DataSrc.
 	 */
-	if (op_data3->dc_miss_no_mab_alloc) {
-		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_miss_no_mab_alloc)
+		return L(LFB) | LN(LFB);
 
-	data_src->mem_lvl = PERF_MEM_LVL_NA;
+	/* Don't set HIT with NA */
+	return PERF_MEM_S(LVL, NA) | LN(NA);
 }
 
 static bool perf_ibs_cache_hit_st_valid(void)
@@ -950,7 +928,9 @@ static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
 				  union ibs_op_data2 *op_data2,
 				  union ibs_op_data3 *op_data3)
 {
-	perf_ibs_get_mem_lvl(op_data2, op_data3, data);
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->val |= perf_ibs_get_mem_lvl(op_data2, op_data3, data);
 	perf_ibs_get_mem_snoop(op_data2, data);
 	perf_ibs_get_tlb_lvl(op_data3, data);
 	perf_ibs_get_mem_lock(op_data3, data);
-- 
2.41.0

