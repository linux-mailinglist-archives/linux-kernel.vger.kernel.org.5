Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7267F80F1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377095AbjLLQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377012AbjLLQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:02:06 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0079AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eueI6ilIItTX3/4/hNGanLc4gMNwanCrWz4ZaDLukkkr245Uf1l78nAFjWce9/KbxpIBcSqWBLx8Ei4GENfrt8QYXcU26iUys7sC6LCd/fbCx0d5WSMlAhMm4FPr4VOhyXQxsd2Pqt4RcPwVsNrllvmODS5xafWPpluvpNLj1HWz4hnPl0QMK8ETGNDnF2+YWuI2s0Iwqi/PZgxPPGM8KHg5tj/tUwNM+FMs6JlsvM5yNQ1a19uZg6GoEpKMx5nkdpMu1DBU4JOVS4Dny10wE2oeDYOGhDBJcvGjFGhddTSRSPu39aw+U4BH1+ydPtvkaaY3KzWsNTApNQM0GfZdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaJ6i7yqeoZpEAZ2MYKLsjJDAS2jqfRLLkob0r5ulcI=;
 b=LmIZdahltD5oxDZiBgcJuZyLXJyiC9gbpgIGIPEcbNKD5gBHWtZ4nKFzS90467B0PaAzIloBELuRzfWXp3jbRnItb1jpdBM/EfIjekwR0JHMySbDkaLK2QdOwVyWa+8+/20GzIPuuIBIBUPhvfnpkiBS8FwC3SjxC4RWInJuRJC4vAKUNuNc47ahQkhqYEBkLNbVlenZjLaYmpiLUry75PvTPB+FQsfySATYE4kpA140N+HSAtRDakAxFXSTBWK6LUftEDGuphBhsOxJwo2BCQSJVrbhwQ/IFJQcUNKOUj2lyvQKGIakzyLjCjh+UwKCCKjci+31S2ZcU8rrphpBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaJ6i7yqeoZpEAZ2MYKLsjJDAS2jqfRLLkob0r5ulcI=;
 b=f414OM/7qTSAUjzMRDC73ZIYf/khtTTLgPGTSr5NrUIijvoOWVrwocswrNw8Bdy8p725gaerLcpBnOXGr5hpkFHL3t9wSdscqEBrlwf6U4IG2SUj+oTMkff3ZrcFsF8QXOlIMmR6tVvShHLSH91Bedb9B9HKAVvIa6qDaLYG+qk=
Received: from BL0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:207:3d::14)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 16:02:05 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::ee) by BL0PR02CA0037.outlook.office365.com
 (2603:10b6:207:3d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 16:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 16:02:05 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 10:02:03 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <jgg@nvidia.com>
CC:     <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
        <pandoh@google.com>, <loganodell@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 1/6] iommu/amd: Update PASID, GATS, and GLX feature related macros
Date:   Tue, 12 Dec 2023 10:01:34 -0600
Message-ID: <20231212160139.174229-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 96aeb359-6461-49b3-147d-08dbfb2bafe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHdhS27qTeKzis+U2tbplak2RUP2gAoNS3YLWomaFdYHWpzbitJJkWK602YniFfna/D0nYt0g7LKWpy59MnAN8bfRDtXnThw13K9tCNH+uiIcGKnB4gNyYpKGOwuXawmSVY33UdCnS9RClKsN+z9o/TZ5bx9lKkIvQHin9Gk8c8xrrgJp6Keab0WFaFcfyFDrgNCSIBtCP3D2kdspdxsrJ9hS+GRUSVT4RhNUT+xqPULwSUB+4kkUEMl8vC8atMvcqiJDknbhaBIWjxhIboNeUQmti6I1HezkEJL2CiBKIQEk/bWfwAH5LqdMCRzQ2e7CEUoLnN3iwitjRMUyDQ7Q/EW9LFTagb8TEpSbL4+Hc1aRiyXs/XadHxLSJMZgVNNwHj8kGCvyehOq6TVwytuaDiTajX454783sWHPGsmSadtw+mDay2nPnGBLkdhQ88712zBOplaZBWuwrO+F2xs94JY7gummRNAqkB/Si5YhBbAnYLHb1y1wQREx8U31C7J0bD16keJ/ElqLFRULmcAVC0OKehBymfB6x1fP7QUhIqu/SmZNLyn+xtBQQAzVqHXcvHzOmrwvQXan5RxbRXTXnqD619jeogs8JIqIs311MBDwJUoAf7fTRuKY64kfb5STzGCOemwdXZHyuDeUKdAjR4oCoSx3qH4Zjl5tTGFCIusAN03kCG3QKtOxpJZW6rbSFteCEbJljjlfdhUvsNeNUYurqy3SG+7ZMM6h9DBRjX46DiY5BC3Z69G4H8+qvTc6q2+xGv1kyGsuMu1fJf312i6lps0Krj25rLJWz3eOBE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(8676002)(8936002)(4326008)(2906002)(44832011)(40480700001)(316002)(40460700003)(7416002)(5660300002)(110136005)(70206006)(70586007)(54906003)(478600001)(36860700001)(26005)(336012)(426003)(36756003)(1076003)(7696005)(6666004)(41300700001)(2616005)(16526019)(81166007)(82740400003)(356005)(83380400001)(47076005)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:02:05.5452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aeb359-6461-49b3-147d-08dbfb2bafe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up and reorder them according to the bit index. There is no
functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h | 13 +++++++------
 drivers/iommu/amd/init.c            |  8 ++++----
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bbed268e8abc..108253edbeb0 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -106,7 +106,7 @@ static inline bool check_feature2(u64 mask)
 
 static inline int check_feature_gpt_level(void)
 {
-	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
+	return ((amd_iommu_efr & FEATURE_GATS_MASK) >> FEATURE_GATS_SHIFT);
 }
 
 static inline bool amd_iommu_gt_ppr_supported(void)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3dc39bbc05fc..14f67a8cf755 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -93,8 +93,6 @@
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
 #define FEATURE_PC		BIT_ULL(9)
-#define FEATURE_GATS_SHIFT	(12)
-#define FEATURE_GATS_MASK	(3ULL)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
 #define FEATURE_GIOSUP		BIT_ULL(48)
 #define FEATURE_HASUP		BIT_ULL(49)
@@ -102,11 +100,14 @@
 #define FEATURE_HDSUP		BIT_ULL(52)
 #define FEATURE_SNP		BIT_ULL(63)
 
-#define FEATURE_PASID_SHIFT	32
-#define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
+#define FEATURE_GATS_SHIFT	12
+#define FEATURE_GATS_MASK	(0x03ULL << FEATURE_GATS_SHIFT)
 
-#define FEATURE_GLXVAL_SHIFT	14
-#define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
+#define FEATURE_GLX_SHIFT	14
+#define FEATURE_GLX_MASK	(0x03ULL << FEATURE_GLX_SHIFT)
+
+#define FEATURE_PASMAX_SHIFT	32
+#define FEATURE_PASMAX_MASK	(0x1FULL << FEATURE_PASMAX_SHIFT)
 
 /* Extended Feature 2 Bits */
 #define FEATURE_SNPAVICSUP_SHIFT	5
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 959820ccfbcc..e84c69fe13d4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2080,14 +2080,14 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		int glxval;
 		u64 pasmax;
 
-		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
-		pasmax >>= FEATURE_PASID_SHIFT;
+		pasmax = amd_iommu_efr & FEATURE_PASMAX_MASK;
+		pasmax >>= FEATURE_PASMAX_SHIFT;
 		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
 		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
 
-		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
-		glxval >>= FEATURE_GLXVAL_SHIFT;
+		glxval   = amd_iommu_efr & FEATURE_GLX_MASK;
+		glxval >>= FEATURE_GLX_SHIFT;
 
 		if (amd_iommu_max_glx_val == -1)
 			amd_iommu_max_glx_val = glxval;
-- 
2.34.1

