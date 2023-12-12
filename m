Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6220480F1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377025AbjLLQCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjLLQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:02:06 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B4AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA9GwVNGwrQUhaeUG9X527WDsCF1Ce/6RcwJ0vDDk3TZXv1aDPfKSzlH26CsGdHv7b8EU9Bcdjr/zzOQV9cssI6BEWAD39TpWlZecoZ4P+mkvTX8rbQfSXwEXKk7p+tKLVTsIE6agP33t88GArZzE1BUX/N/gkXSLLRe6py8AvjzY+tSLb982xKr6ldSGZMIFTLBrtDzirpNSyYPksSfhoLkjVWY1d1MlLi6GCax+n/FJvI9xhTkvEz8kTR20HbBvoacJxtceCwkCVDdcSNLzA+uJRwb5ozlRfO8/xnig3CwD/KAWP9Az04A1qJBjEueJOn05+n0duwnmsL0L/mjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvVFgIcnPdCeXk70+pGgRUBYR91xAlnGJLYJHydkBZY=;
 b=LUAa80ug3bgNnOrY2JFh/4c9IC2Eu2Dhg3ZV5q0SlkfD1pEgM4mVBTdn+BMxREjglg5wnl9LosrVf5XHWk/DO3PevunpBPaArbSM6e+bnlFQPmiiVBWbcIL9vpZXWBYvo89zPyZX01nqE+k3eEK/YjZ4UsYA2oRx8uWP93LuX9pdyymjBgRQO9kauVU68aulDQhVs+MASprcA5oGka/6ig2CW01JuUdjrRSK4ww4mWBU/VkG2WwpR0Htm9pllwP2n+k8t+K0AmRPuoarTXNQP00PqYtQK0/tsa42Hr19zjO/Kux/3DXmyAC+l0rnXS32bcquiOgUpkuRVHiQUUDYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvVFgIcnPdCeXk70+pGgRUBYR91xAlnGJLYJHydkBZY=;
 b=OZqKLKYsOGK4tOdS2EAmgVHseULY/U8Q8AZdXXPfiJXHObhAHRWNz71f6eAqA40Jyvd8J09p7Gf8YEW6lB3kOJfFkWpA+fm87o0x9UA3yIapbNghN/WSJzjmLDOYGmHwvaPgN/difcKoQoabiTZcNhgVNgLVKARat3kIX3zWWuU=
Received: from BL0PR02CA0062.namprd02.prod.outlook.com (2603:10b6:207:3d::39)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 16:02:06 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::f8) by BL0PR02CA0062.outlook.office365.com
 (2603:10b6:207:3d::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 16:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 16:02:06 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 10:02:04 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <jgg@nvidia.com>
CC:     <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
        <pandoh@google.com>, <loganodell@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 2/6] iommu/amd: Add support for hw_info for iommu capability query
Date:   Tue, 12 Dec 2023 10:01:35 -0600
Message-ID: <20231212160139.174229-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 259eb8e3-a038-46eb-9818-08dbfb2bb065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Im8qmPCVYBG1LslKXJYq8Q3JF8o1FEdmxh0byLzDXyb3t4tHg8olT6loEGWEdVT9NV15nBN7logvrKLJq2IaFuw1yTq2vmtw0WEGlSsYIUX6XtXVGT/pDF9K3Cu2AZv4IU7Dj/SPzcOTzbzgqg9cHx/qeOGcdmqrwbA6pOXbOkLBKns52kQbH/T1hKLV9VO7lwDkAEkDG/hoXg/RmymL9Q778nhW8wKuNdZJ+Bv6NArcPg+0Oz+VUIMcQjjpQFEidy1SNTMI8bAW5Ff64o7aY2ppuD5cAeFTpSvBmlrIfNmlk7DpktLePUXlSd2nENa6TbRuzlrESwv6rPLjAoZz3LmfhkuVcG/RvBDlo/0yJAMkxkXj4Yz2mLTG9imri8Y7+A+b2bQmIVtzj6TqTKp5Sm7No6e22NOUZxxu1EZGO6G/R4BFk7epKpKWKovT3ysHsNQ1VxWqMk8Jottv+Au1RgfXG2KvNZBS3SPCKKPToCqRzA0Tbsd4/uPlTXnsZaT6tJN9rJTlMXF6jtTW4HA+rR0aNmRp8honj39SszNX/mC+rUE8BxAsKrvMUjI/YYcQsUK1YLrDKyKBW9zVR8WTzgnc5mVTlIHruWuHvEL3eRuGo8tjegyNc30ghFhJjBIb/4QhHrsWvk5RXFbjnSnFAdBcTp6mg203hNoXTdnYhLzybx0AjiOsvg6N2Kw9l4xHz4aWG7c0GG/tTDtocHZQ/kI5hRiNGCrYTvV5Uc0/GWUqloYZgtwRiIy/X51cL6rqDd1ORn4vhB9Q36mTyD2qd649KjXnZYbSaOYPiNjw+jA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(26005)(336012)(426003)(7696005)(1076003)(2616005)(47076005)(36860700001)(44832011)(5660300002)(8676002)(8936002)(16526019)(41300700001)(7416002)(316002)(2906002)(6666004)(4326008)(478600001)(54906003)(70206006)(110136005)(82740400003)(36756003)(70586007)(86362001)(356005)(81166007)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:02:06.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259eb8e3-a038-46eb-9818-08dbfb2bb065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
specify features supported by each IOMMU hardware instance.
The IOMMU driver checks each feature-specific bits before enabling
each feature at run time.

For IOMMUFD, the hypervisor determines which IOMMU features to support
in the guest, and communicates this information to user-space (e.g. QEMU)
via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/iommu.c           | 38 +++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        | 13 ++++++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 108253edbeb0..4118129f4a24 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -72,6 +72,8 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 				   ioasid_t pasid);
 
+void amd_iommu_build_efr(u64 *efr, u64 *efr2);
+
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 14f67a8cf755..956fd4658a4a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -100,12 +100,15 @@
 #define FEATURE_HDSUP		BIT_ULL(52)
 #define FEATURE_SNP		BIT_ULL(63)
 
+#define FEATURE_GATS_5LEVEL	1ULL
 #define FEATURE_GATS_SHIFT	12
 #define FEATURE_GATS_MASK	(0x03ULL << FEATURE_GATS_SHIFT)
 
+#define FEATURE_GLX_3LEVEL	0ULL
 #define FEATURE_GLX_SHIFT	14
 #define FEATURE_GLX_MASK	(0x03ULL << FEATURE_GLX_SHIFT)
 
+#define FEATURE_PASMAX_16	0xFULL
 #define FEATURE_PASMAX_SHIFT	32
 #define FEATURE_PASMAX_MASK	(0x1FULL << FEATURE_PASMAX_SHIFT)
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4e4ff1550cf3..c41932e9f16a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2822,8 +2822,46 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+void amd_iommu_build_efr(u64 *efr, u64 *efr2)
+{
+	if (efr) {
+		*efr = (FEATURE_GT | FEATURE_GIOSUP | FEATURE_PPR);
+
+		/* 5-level v2 page table support */
+		*efr |= ((FEATURE_GATS_5LEVEL << FEATURE_GATS_SHIFT) &
+			 FEATURE_GATS_MASK);
+
+		/* 3-level GCR3 table support */
+		*efr |= ((FEATURE_GLX_3LEVEL << FEATURE_GLX_SHIFT) &
+			 FEATURE_GLX_MASK);
+
+		/* 16-bit PASMAX support */
+		*efr |= ((FEATURE_PASMAX_16 << FEATURE_PASMAX_SHIFT) &
+			 FEATURE_PASMAX_MASK);
+	}
+
+	if (efr2)
+		*efr2 = 0;
+}
+
+static void *amd_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
+{
+	struct iommu_hw_info_amd *hwinfo;
+
+	hwinfo = kzalloc(sizeof(*hwinfo), GFP_KERNEL);
+	if (!hwinfo)
+		return ERR_PTR(-ENOMEM);
+
+	*length = sizeof(*hwinfo);
+	*type = IOMMU_HW_INFO_TYPE_AMD;
+
+	amd_iommu_build_efr(&hwinfo->efr, &hwinfo->efr2);
+	return hwinfo;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
+	.hw_info = amd_iommu_hw_info,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.probe_device = amd_iommu_probe_device,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0b2bc6252e2c..bf4a1f8ab748 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -474,15 +474,28 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * struct iommu_hw_info_amd - AMD IOMMU device info
+ *
+ * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
+ * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
+ */
+struct iommu_hw_info_amd {
+	__u64 efr;
+	__u64 efr2;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
  *                           info
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
+ * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+	IOMMU_HW_INFO_TYPE_AMD,
 };
 
 /**
-- 
2.34.1

