Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3770176696E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjG1Jy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjG1Jy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:54:26 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519591FF5;
        Fri, 28 Jul 2023 02:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOiRnEwmIcPd141xmkSnv/5xUTN3whEPvquUmMuaYvb1UdDkx3YBY0kcprFk/R+2yK4ycdeS8Ej+zYYFYH0HXikkKXqtqy5XOcAWbGjXei1zhN6lffGdc3uxCYf96Dmwqm0yRb5ythruH/psTUcTqyqCgF/ElRRf7Uda3HhrUtqjBq7ha1wfEwVGh2hO8gsqUKdu8lNwQoEsoGmurGwAjjmTddWQeH9zlU1ngmZZT8aOR5gMLZFA2UiCYe/6zRiOrVZxjkmgD6gcvuQb57F9pBlG9pw/nn+N4SDEdeZy8mbR2ziqR75gX+2jA3+n7NPOcSixP5AilTjGyAIa2dFW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMqa0n9bFoHl7hzK9wPRKnG5YOiXC3bMF5kUyIN0OUI=;
 b=goi9VraYl75aXH0sjn6QNVsXTsI97zsn9mlyo02g0S25SZiUcb8PbLUXcAMrINgEAgV65ZK9wd8Yo80r+na65bD2fhPbmL4GjDhZjG6o7Zd14/qPbEHjY1aaxnulw0xrXA2lMkTbu//o1JxEpb3VXxo7ZX310/dpkPrjFQxjyZAQAYAry4EfEEaQa9mhKAwbrq+fSV/nBfzTeYD/e2SPumrSDu8r5vX/y0bLpW5cZf1O1H6Zi3NaQfIuB3T3mOnVo/02yuw2gMdgk4AuE778/KAgXja80MER61eUyGAhaFr3sr2g/fVhY5bfP82s4TlYMkYo4Xg9TYY7TIzyaei9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMqa0n9bFoHl7hzK9wPRKnG5YOiXC3bMF5kUyIN0OUI=;
 b=TFY84x7iEv1ll3OQvYa9kQuKvCywyknT1sFfUOdmaKQPGFm6DZdv9aNzFOEFazzondBquFyxSkgp6DUxyUxqou5zmqI2lRoOlz5UiuFMzBLRaSvf+cHidvoSF9Pjzay97KaKMAe6rlrAeQeksLjBzIN7Ut18Uc4p8fhAVjE7NVShiMXNR25X+htEsGFD7Bqex1Ev+1kLR3YgW1ZJm8k+iJycRBKV5sZkC+d45Hv0YbEFasvF9LvMir55DtdoyzOPrGZkAI2kv6qRitJu8Ucusi1YKmYGJk+CdY0D/T2LGMYP6rXPADd24NiQu3KVUcqJ4vKWqYD6hwNe27WwwpG1Uw==
Received: from BN9PR03CA0670.namprd03.prod.outlook.com (2603:10b6:408:10e::15)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:54:22 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::2f) by BN9PR03CA0670.outlook.office365.com
 (2603:10b6:408:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 09:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 09:54:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 02:54:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 28 Jul 2023 02:54:07 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 28 Jul 2023 02:54:06 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 RESEND] EDAC/bluefield_edac: Add SMC support
Date:   Fri, 28 Jul 2023 05:53:47 -0400
Message-ID: <0512fa0c173f446b62e8503e0f308359b64aa679.1690537719.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: cca0665b-9a00-4780-c003-08db8f509e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFqvhz/mCyJRDjXJGpogorSdYO4lHTbvAJKrW6UJ9PrC4AJ2JbaDfB7umOsYEMFHYlbM+R++OBjea8/pCbUrdoqd1mUMJK+3q9yYpGAK8Q5jWUVmQu2/Uh3C+XRWSDctFPk+7vPE3cP+DYJ0mmE0cNXJQkMuN5/pH9v7wfRg9IT3QNLgIun/4qdlIzznzo7aHPUJ+cdkF/zifsvxlHdumsJWxVyBBN/Xs4/S4hoNgcRlQV57+3xSEZCwgJNdJKyLjnAAFwC/6pvOJnaKN5KNJVr8nGTkTIKHhugJn/h4CYNt5VAeO0CTdRLjTReW8qulvY9UQos4dye60GnGOAOLM+zq6i19kD15Oo3hmrQxX+usnpe8LGNZVNl28SizYaX/MSmKd0GfZc9XcD1zaDGhFiygJe9lX5uawAvWkkQMhh2PEBUUpP6MhhGM5lauaN+9alWWj34Ba9VW+4JJaTjJyxuKL+mVtZLnQbR2OBNMSwaZEvLBLPwEHfSK1Yx2B2gLal69cjfC5Z2vx46AgfxxOAv4Dc6m7NPfhUS4UPXPqNvJA7B/LWXnO2iOQDr0fxY1ruGGUm8Vlw2o6LWDm5QTdKLYZsp2GYePZvcE/oING5jU3A+j6VQiv4eis8GBh4tj3Gx+9iHm00dbWC0aCQrXRSrZBIRxctvRLjt0kedVxmkW3mo6h21o0C9H+HxGsWQRNjfiQZbV6P3kd8mKUAGan1G1pb7oe5d6dJmDVSDnEaV5RCbrIt9nvj5kga7kZhPa
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(36756003)(86362001)(2906002)(40460700003)(40480700001)(2616005)(426003)(83380400001)(336012)(36860700001)(47076005)(186003)(26005)(7636003)(478600001)(6666004)(7696005)(356005)(54906003)(110136005)(82740400003)(70586007)(8936002)(316002)(70206006)(41300700001)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 09:54:21.8059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca0665b-9a00-4780-c003-08db8f509e5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add secure read/write calls to bluefield_edac. The ACPI
table entry decides whether the secure calls need to be
used for accessing the EMI registers.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/edac/bluefield_edac.c | 176 ++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index e4736eb37bfb..cb9e42ef64d1 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -47,13 +47,25 @@
 #define MLXBF_EDAC_MAX_DIMM_PER_MC	2
 #define MLXBF_EDAC_ERROR_GRAIN		8
 
+#define MLXBF_WRITE_REG_32		(0x82000009)
+#define MLXBF_READ_REG_32		(0x8200000A)
+#define MLXBF_WRITE_REG_64		(0x8200000B)
+#define MLXBF_READ_REG_64		(0x8200000C)
+#define MLXBF_SIP_SVC_UID		(0x8200ff01)
+#define MLXBF_SIP_SVC_VERSION		(0x8200ff03)
+
+#define MLXBF_SMCCC_ACCESS_VIOLATION	(-4)
+
+#define MLXBF_SVC_REQ_MAJOR		0
+#define MLXBF_SVC_REQ_MINOR		3
+
 /*
- * Request MLNX_SIP_GET_DIMM_INFO
+ * Request MLXBF_SIP_GET_DIMM_INFO
  *
  * Retrieve information about DIMM on a certain slot.
  *
  * Call register usage:
- * a0: MLNX_SIP_GET_DIMM_INFO
+ * a0: MLXBF_SIP_GET_DIMM_INFO
  * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
  * a2-7: not used.
  *
@@ -61,7 +73,7 @@
  * a0: MLXBF_DIMM_INFO defined below describing the DIMM.
  * a1-3: not used.
  */
-#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+#define MLXBF_SIP_GET_DIMM_INFO		0x82000008
 
 /* Format for the SMC response about the memory information */
 #define MLXBF_DIMM_INFO__SIZE_GB GENMASK_ULL(15, 0)
@@ -72,9 +84,12 @@
 #define MLXBF_DIMM_INFO__PACKAGE_X GENMASK_ULL(31, 24)
 
 struct bluefield_edac_priv {
+	struct device *dev;
 	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
 	void __iomem *emi_base;
 	int dimm_per_mc;
+	bool svc_sreg_support;
+	u32 sreg_tbl_edac;
 };
 
 static u64 smc_call1(u64 smc_op, u64 smc_arg)
@@ -86,6 +101,71 @@ static u64 smc_call1(u64 smc_op, u64 smc_arg)
 	return res.a0;
 }
 
+static int secure_readl(void __iomem *addr, uint32_t *result, uint32_t sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_READ_REG_32, sreg_tbl, (uintptr_t)addr,
+		      0, 0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		*result = (uint32_t)res.a1;
+		return 0;
+	}
+}
+
+static int secure_writel(void __iomem *addr, uint32_t data, uint32_t sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_WRITE_REG_32, sreg_tbl, data, (uintptr_t)addr,
+		      0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		return 0;
+	}
+}
+
+static int edac_readl(void __iomem *addr, uint32_t *result,
+		      bool sreg_support, uint32_t sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = secure_readl(addr, result, sreg_tbl);
+	else
+		*result = readl(addr);
+
+	return err;
+}
+
+static int edac_writel(void __iomem *addr, uint32_t data,
+		       bool sreg_support, uint32_t sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = secure_writel(addr, data, sreg_tbl);
+	else
+		writel(data, addr);
+
+	return err;
+}
+
 /*
  * Gather the ECC information from the External Memory Interface registers
  * and report it to the edac handler.
@@ -99,7 +179,7 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
 	enum hw_event_mc_err_type ecc_type;
 	u64 ecc_dimm_addr;
-	int ecc_dimm;
+	int ecc_dimm, err;
 
 	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
 				   HW_EVENT_ERR_UNCORRECTED;
@@ -109,14 +189,22 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	 * registers with information about the last ECC error occurrence.
 	 */
 	ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
-	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
+	err = edac_writel(priv->emi_base + MLXBF_ECC_LATCH_SEL,
+			  ecc_latch_select, priv->svc_sreg_support,
+			  priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC latch select write failed.\n");
 
 	/*
 	 * Verify that the ECC reported info in the registers is of the
 	 * same type as the one asked to report. If not, just report the
 	 * error without the detailed information.
 	 */
-	dram_syndrom = readl(priv->emi_base + MLXBF_SYNDROM);
+	err = edac_readl(priv->emi_base + MLXBF_SYNDROM, &dram_syndrom,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM syndrom read failed.\n");
+
 	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
 	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
 	syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
@@ -127,13 +215,24 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 		return;
 	}
 
-	dram_additional_info = readl(priv->emi_base + MLXBF_ADD_INFO);
+	err = edac_readl(priv->emi_base + MLXBF_ADD_INFO, &dram_additional_info,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM additional info read failed.\n");
+
 	err_prank = FIELD_GET(MLXBF_ADD_INFO__ERR_PRANK, dram_additional_info);
 
 	ecc_dimm = (err_prank >= 2 && priv->dimm_ranks[0] <= 2) ? 1 : 0;
 
-	edea0 = readl(priv->emi_base + MLXBF_ERR_ADDR_0);
-	edea1 = readl(priv->emi_base + MLXBF_ERR_ADDR_1);
+	err = edac_readl(priv->emi_base + MLXBF_ERR_ADDR_0, &edea0,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 0 read failed.\n");
+
+	err = edac_readl(priv->emi_base + MLXBF_ERR_ADDR_1, &edea1,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 1 read failed.\n");
 
 	ecc_dimm_addr = ((u64)edea1 << 32) | edea0;
 
@@ -147,6 +246,7 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
 	u32 ecc_count, single_error_count, double_error_count, ecc_error = 0;
+	int err;
 
 	/*
 	 * The memory controller might not be initialized by the firmware
@@ -155,7 +255,11 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	if (mci->edac_cap == EDAC_FLAG_NONE)
 		return;
 
-	ecc_count = readl(priv->emi_base + MLXBF_ECC_CNT);
+	err = edac_readl(priv->emi_base + MLXBF_ECC_CNT, &ecc_count,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC count read failed.\n");
+
 	single_error_count = FIELD_GET(MLXBF_ECC_CNT__SERR_CNT, ecc_count);
 	double_error_count = FIELD_GET(MLXBF_ECC_CNT__DERR_CNT, ecc_count);
 
@@ -172,15 +276,19 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	}
 
 	/* Write to clear reported errors. */
-	if (ecc_count)
-		writel(ecc_error, priv->emi_base + MLXBF_ECC_ERR);
+	if (ecc_count) {
+		err = edac_writel(priv->emi_base + MLXBF_ECC_ERR, ecc_error,
+				  priv->svc_sreg_support, priv->sreg_tbl_edac);
+		if (err)
+			dev_err(priv->dev, "ECC Error write failed.\n");
+	}
 }
 
 /* Initialize the DIMMs information for the given memory controller. */
 static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
-	int mem_ctrl_idx = mci->mc_idx;
+	u64 mem_ctrl_idx = mci->mc_idx;
 	struct dimm_info *dimm;
 	u64 smc_info, smc_arg;
 	int is_empty = 1, i;
@@ -189,7 +297,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 		dimm = mci->dimms[i];
 
 		smc_arg = mem_ctrl_idx << 16 | i;
-		smc_info = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
+		smc_info = smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
 
 		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
 			dimm->mtype = MEM_EMPTY;
@@ -244,6 +352,7 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	struct bluefield_edac_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[1];
+	struct arm_smccc_res res;
 	struct mem_ctl_info *mci;
 	struct resource *emi_res;
 	unsigned int mc_idx, dimm_count;
@@ -280,12 +389,40 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 
+	/*
+	 * ACPI indicates whether we use SMCs to access registers or not.
+	 * If sreg_tbl_perf is not present, just assume we're not using SMCs.
+	 */
+	if (device_property_read_u32(dev,
+				     "sec_reg_block", &priv->sreg_tbl_edac)) {
+		priv->svc_sreg_support = false;
+	} else {
+		/*
+		 * Check service version to see if we actually do support the
+		 * needed SMCs. If we have the calls we need, mark support for
+		 * them in the pmc struct.
+		 */
+		arm_smccc_smc(MLXBF_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+		if (res.a0 == MLXBF_SVC_REQ_MAJOR &&
+		    res.a1 >= MLXBF_SVC_REQ_MINOR) {
+			priv->svc_sreg_support = true;
+		} else {
+			dev_err(dev, "Required SMCs are not supported.\n");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
 	priv->dimm_per_mc = dimm_count;
-	priv->emi_base = devm_ioremap_resource(dev, emi_res);
-	if (IS_ERR(priv->emi_base)) {
-		dev_err(dev, "failed to map EMI IO resource\n");
-		ret = PTR_ERR(priv->emi_base);
-		goto err;
+	if (!priv->svc_sreg_support) {
+		priv->emi_base = devm_ioremap_resource(dev, emi_res);
+		if (IS_ERR(priv->emi_base)) {
+			dev_err(dev, "failed to map EMI IO resource\n");
+			ret = PTR_ERR(priv->emi_base);
+			goto err;
+		}
+	} else {
+		priv->emi_base = (void __iomem *)emi_res->start;
 	}
 
 	mci->pdev = dev;
@@ -320,7 +457,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	edac_mc_free(mci);
 
 	return ret;
-
 }
 
 static int bluefield_edac_mc_remove(struct platform_device *pdev)
-- 
2.30.1

