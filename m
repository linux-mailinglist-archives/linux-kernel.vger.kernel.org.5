Return-Path: <linux-kernel+bounces-24163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB68C82B873
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68894B24A35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268D6EA6;
	Fri, 12 Jan 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ju+jo7Ib"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A464B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR5EXCj1VxOCoguKeDVOmo6JkQwpwVAIKNpESdnER8EMy6M6nFem5tPKHYsKxkHEZD+UfMQ09BgYZ9Vwg5/yxjfl4/kc8kxNGIvkX0T0DXowogDND0CL049xGuXnFFql3hm+rN5DgMLkMdEYYcTaT1QAexxUNIdBYIzHyppCiqRxhhsnCja484MBkksbdlByqrVibqw1t09cfzLHRFRxM4Tbyu9E5VKdoQfrN8o8xiwPH3MDysmzyE+TRY8jfE/SmfNGNp4ZbXx8eW1xxOm++ihPG+d/DvAlDSOnYEe1FaoyWWzSEheiDBOaEsk5JFcR+PKJVq2OAz5pl7fl0EL/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y8nEdtKzpA8yEZ1sXPkwkN3aTjYmrgaBdWlI8n1g3o=;
 b=kbr915yLcGj57hM1sJ4dyiHz2EWfu+Tu1+qV/jUXrxmdD+KS8OEZmNyi+5vfqTXnW63Q+KAphlnRw0YrubHhTE4xShEYBc1GtS7iUn7KbU10gY1mH0+lv2k18OKvtg4uPtwCcjgV5j+/uqwobZ8upZyYOSlu91NI6da2o4hCwm8d7I9XHEbCbkFekhH6GI1Fxe0NSs3Wrp4OaBK3sizAYrBlfwNzvIKBw/i+E9tzJ69Ee1vxsQa+w4o2AsamXlNpBhLtMTR3GQtnokopZroyyEhtTC8bxu/eDXIpAhX03XQa38KxhbUWQYEeKTc8M8oArWewPvHW0uxFrA/Kozl4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y8nEdtKzpA8yEZ1sXPkwkN3aTjYmrgaBdWlI8n1g3o=;
 b=ju+jo7IbaNvw+6mc46xaWcNBEtPqDC4gpHEDH7D2Y1MIrRcES+/zEZ+syvL/uLQ1prJsfLsaqghcijpEUQJlcYdBkjmF72G82HbF61KMW6zQNjKblUpJAL5uFcc5l92VErG7soacgBc+WHDZZlabua/YAOl+aMx11cZmu32Sj4k=
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 00:07:06 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::c4) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 00:07:05 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 18:07:02 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 3/7] iommu/amd: Update PASID, GATS, and GLX feature related macros
Date: Thu, 11 Jan 2024 18:06:42 -0600
Message-ID: <20240112000646.98001-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: ba335f5c-149e-457e-19f9-08dc13026946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bv7sQ8HdMpiN6KH3UajU+7r1lwU634CIu26GqOmMraipedjk3uQZC20ORci3YPutGSixr1F1d62QplnW3+uhSYt1cx3ih4WCosmbDUDr1QDclGxFrf7OhX1Vy6SbtVdL5v0bFcqsFyd/jp2bUw6bRZVchaPXhZN0g7W687nYX4EjuhAWm2eARzNRK+XT2EaTl1PpIWGSQK9hLekzepkvO7oNzeQhoWIo87zzb8aWwNblTKjrZK6edfFXoAwb3cxX1jKx/1G2irH2hg82Fhv0rSvG4L1hcFUsXa+b/zMFrczsq8aCMjUtOpdJslfHnmMY7sA2ngIEffxCrGRfzCvjnrY1OvtsUnpNuZRfM0NRDqcMpziliVKJUqmBgIZ9dntLSLYUkQAANbo0NhILRXfTwPzTdw/CU/lW6jCm5yNs2vmLShG9dk7MPZWqGnsocG6Ocot4SmpRqWGUynw0Gm66znloKDWVFJoZESGMePY+481UCSSIdQVSi/yxqi5t5Legphfc9HTjWtXpLI06CprIGozjNKTQePXjaKdrIfUcLrwcxhPBOLov2hlGKDxWMitOoQCLRF8x2nd2IzYeSDBqvqU9YoZK3AIEIEKC1ScNF+zW+xR6uToaiQ3p0hU1jPNL0//clZhweGu9Lgus5rol3/S03+/bw/v1fmp3SYV+3kELdBUWrCRkPfKENVlrFXDDyRCxBBIGQWs5BFT76gwUlJVfmx1/P3pPfaejxko1uLTe6JNGiby+R2uSR3ChgI2d841Yj0H992kUI3we6HxTakjcvkjfYnWyCNdVW6sXmJI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(36756003)(478600001)(110136005)(86362001)(6666004)(81166007)(5660300002)(356005)(82740400003)(70206006)(1076003)(47076005)(26005)(2616005)(336012)(426003)(7416002)(16526019)(83380400001)(36860700001)(2906002)(8936002)(316002)(70586007)(7696005)(4326008)(8676002)(41300700001)(54906003)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:05.5425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba335f5c-149e-457e-19f9-08dc13026946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

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
index ff56c857f6ad..f8baa8d88832 100644
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


