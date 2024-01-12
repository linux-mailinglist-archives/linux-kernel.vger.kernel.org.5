Return-Path: <linux-kernel+bounces-24169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDA082B87A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CC7286D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7715E93;
	Fri, 12 Jan 2024 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rifU9/Ea"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE6258D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEMIl/xGuREu2T/aIn71vMrH7VypGdcb2evMYUrA4sfaWtHB3hFm8M5IWN5myXqt808OVA+ltz60qFQJlA4R5ONv9B5bBBtBU/BpiQ6F+exRMclbLZnIKVQd4UH3EAJhhUmUgipv9aH+4P0/5Viuabxrv2w238ZqBajMIim9MXfryz4y0RacTEIJUVGEhdDv8PSMQTjSs9E2BwnJUUGd1CPjtwe/BpEP1XZptG2W+DKNi7v1t1XaIjmnZx+wN72IGU3+L0W/IunxWuNWHkF4nlpyyupcmIrbKMD2hV1uYt5Cz26IeQiC55tzfgQhqT6IODejaY8JJSt3Vr8qSWEFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDjOCBYRs3Bi6DGtMMHqdaftKbkEZWu3pN2q3tgL7Pk=;
 b=PCGDVd4qBrNX/LziCT/fBXQ71uiMIH8Cx+0rhrr3ktVTa/Iq+A9b3MVpGiO2XXB3NYNlGfFgATwxMt/pgb8fA/ylOu6GgFumr66pXF4R5phF5aIkervboV0hZXBWEq88EVyVilv/qeTIH9XxJGApTLrkjbEW9SeAt9ojXPDepf/pdloFe9gez1k3mqK5+JVU+M+v1jOD2xoFnRYHm2ZXm6lxij8KHHByx1SsVWp92gIZ5QBBJ31j14GKFlU+XBD1L9uTnvDCmn/IWN1/0bfuJI40yMg5nCGUAgfFERPEVmNJcdanKnRAXMEJrdUacV9cEJe8jdsaFULno8s3wHybwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDjOCBYRs3Bi6DGtMMHqdaftKbkEZWu3pN2q3tgL7Pk=;
 b=rifU9/EaLmFo65sD6wx3RST5Y4u/rd2gPp3x8szeodaa3qZ2QmuzsxyuYYwx3rMRK27eLSHIIHDCzBYOcdsYXWvb7jpxWEvSynLBt/uawnGjeoQVYm8v3dd6ZoYbkXqyu3yaXmaUOZzOCuOacA9FDbvnzAiJRsoDrmCtLcla3mE=
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 00:07:09 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::31) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 00:07:08 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 18:07:06 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 6/7] iommu/amd: Add nested domain allocation support
Date: Thu, 11 Jan 2024 18:06:45 -0600
Message-ID: <20240112000646.98001-7-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: cc54c7fa-301e-43d4-7a26-08dc13026b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b6qJnSQnKoUqEF8chQSMDMyhK+DwVXPCrZSDe4WfvmnfbOzLGYwUrYxkxlt6Roc8FmOLWZSbxgN47V9kscx4NCR88A6KbIVzDQwOlz74jYXraUlAVzoOg8JxDR5VBnJoDFkpAVS4PbJPFDw+QfBTaodLVbWlx2IppK4xUC5LvicBcYQr4L2naOW8QeW5HCGspxdi5E4UFO7yLQVq0DtOx3CIc4vXtixj6UttQUfBbvpqAcTuk3Foe6vSQ8Vz2VEWKD/l0FmcGUFluHQf8+K8FGyhQA90gRRb0qj8eyo41uHbWEOcsYJg4boXL540ZV/TjedsgsVFlAkVaBsfYzCSuX0hlEOzN5fEqpKIoPcDXrPsSxcDudhvK2YWgpNupAOREHAoh3wXsRJDg8piWQrJ7VFMMNv3B0iEe0BDrweOcl8FpR026K10nIjAhlS1rC65jUnDbGSLTQqBMMIIiTk8gR/SbgpVHIKCLpZfh66+YkRqrpXPBNB3y5t+jAVrY0RBoN0MNLR/FBn8JzbV2hodCn7051PuNJFlAGwfgAkZvTRUqgQhe7mMqIdH5OeeOFI2BpKlutjs6hjA+OzO8V9o+kIomEqVpoQ0p20Nr293ZvBh5sR9U4sWb/gQFFYZaYZAGQXw3SEHKO3cpnpRwaxvuXJf/+70k06IkqeYh8MHXrzI30sAbWRFCpi8h3XTf6Qz9f1lCYApAaWoTExnvMoE5oIHn7B0Ql+7AMZ6Vqw0V1eZB4r67MwjgUMIIavbnDBRQxU0KhKZ186JvNFePS09IMCYyovr3IBiqTF2+N1v7V0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(6666004)(83380400001)(316002)(47076005)(70206006)(110136005)(54906003)(70586007)(7696005)(16526019)(426003)(26005)(1076003)(336012)(2616005)(81166007)(44832011)(8936002)(8676002)(40480700001)(40460700003)(82740400003)(36756003)(356005)(4326008)(5660300002)(86362001)(36860700001)(7416002)(30864003)(41300700001)(478600001)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:08.7144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc54c7fa-301e-43d4-7a26-08dc13026b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387

To support nested translation, the parent domain is allocated with flag
IOMMU_HWPT_ALLOC_NEST_PARENT, and stores information of the v1 page table
for stage 2 (i.e. GPA->SPA), whereas the child domain stores information
of the GCR3 root pointer table for stage 1 (i.e. GVA->GPA).

Modify the current driver to handle the domain allocation with type
IOMMU_DOMAIN_NESTED. Also, when allocating the child domain (with the
parent domain is specified), keeps track the parent using the struct
protection_domain.parent.

Note that current implementation requires AMD IOMMU GCR3TRPMode feature,
which program DTE[GCR3 Table Root Pointer] with the GPA provided by the
guest via struct iommu_hwpt_amd_v2, which is passed as a parameter of
the struct iommu_ops.domain_alloc_user().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       | 10 +++
 drivers/iommu/amd/amd_iommu_types.h |  6 ++
 drivers/iommu/amd/iommu.c           | 96 ++++++++++++++++++++++++++---
 drivers/iommu/amd/nested.c          | 75 ++++++++++++++++++++++
 5 files changed, 181 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index f454fbb1569e..447cb6bb48eb 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o nested.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 4118129f4a24..bb25d7c3bff5 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -7,6 +7,7 @@
 #ifndef AMD_IOMMU_H
 #define AMD_IOMMU_H
 
+#include <uapi/linux/iommufd.h>
 #include <linux/iommu.h>
 
 #include "amd_iommu_types.h"
@@ -182,4 +183,13 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 extern bool amd_iommu_snp_en;
+
+/* NESTED */
+struct protection_domain *to_pdomain(struct iommu_domain *dom);
+bool amd_iommu_domain_is_nested(struct protection_domain *pdom);
+struct iommu_domain *
+amd_iommu_nested_domain_alloc(struct device *dev, unsigned int type, u32 flags,
+			      struct iommu_hwpt_amd_v2 *hwpt,
+			      struct iommu_domain *parent);
+
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f8baa8d88832..db77b050a496 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -110,6 +110,8 @@
 #define FEATURE_PASMAX_MASK	(0x1FULL << FEATURE_PASMAX_SHIFT)
 
 /* Extended Feature 2 Bits */
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
+
 #define FEATURE_SNPAVICSUP_SHIFT	5
 #define FEATURE_SNPAVICSUP_MASK		(0x07ULL << FEATURE_SNPAVICSUP_SHIFT)
 #define FEATURE_SNPAVICSUP_GAM(x) \
@@ -535,6 +537,7 @@ struct amd_irte_ops;
 
 struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
+	u64	trp_gpa;	/* Guest CR3 TRP GPA for nested domain */
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
 	bool	giov;		/* Track DTE[GIOV] */
@@ -569,6 +572,9 @@ struct protection_domain {
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+	struct protection_domain *parent; /* Nested parent domain */
+	u16 guest_paging_mode;	/* Guest paging mode */
+	u16 guest_domain_id;	/* Guest domain ID */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 134f4af921dc..51716fa5ccb5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,11 +77,16 @@ struct iommu_cmd {
 
 struct kmem_cache *amd_iommu_irq_cache;
 
+static int amd_iommu_attach_device(struct iommu_domain *dom,
+				   struct device *dev);
+
 static void detach_device(struct device *dev);
 
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
+static void amd_iommu_domain_free(struct iommu_domain *dom);
+
 /****************************************************************************
  *
  * Helper functions
@@ -191,7 +196,7 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
-static struct protection_domain *to_pdomain(struct iommu_domain *dom)
+struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
 }
@@ -2367,8 +2372,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	domain->nid = NUMA_NO_NODE;
 
 	switch (type) {
-	/* No need to allocate io pgtable ops in passthrough mode */
+	/* No need to allocate io pgtable ops in passthrough and nested mode */
 	case IOMMU_DOMAIN_IDENTITY:
+	case IOMMU_DOMAIN_NESTED:
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
@@ -2423,7 +2429,12 @@ static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 	return iommu && (iommu->features & FEATURE_HDSUP);
 }
 
-static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
+static const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+};
+
+struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 						  struct device *dev, u32 flags)
 {
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
@@ -2454,7 +2465,10 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (iommu) {
 		domain->domain.type = type;
 		domain->domain.pgsize_bitmap = iommu->iommu.ops->pgsize_bitmap;
-		domain->domain.ops = iommu->iommu.ops->default_domain_ops;
+		if (type == IOMMU_DOMAIN_NESTED)
+			domain->domain.ops = &nested_domain_ops;
+		else
+			domain->domain.ops = iommu->iommu.ops->default_domain_ops;
 
 		if (dirty_tracking)
 			domain->domain.dirty_ops = &amd_dirty_ops;
@@ -2474,18 +2488,86 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 	return domain;
 }
 
+static int udata_to_iommu_hwpt_amd_v2(const struct iommu_user_data *user_data,
+				       struct iommu_hwpt_amd_v2 *hwpt)
+{
+	if (!user_data)
+		return -EINVAL;
+
+	if (user_data->type != IOMMU_HWPT_DATA_AMD_V2)
+		return -EOPNOTSUPP;
+
+	return iommu_copy_struct_from_user(hwpt, user_data,
+					   IOMMU_HWPT_DATA_AMD_V2,
+					   __reserved);
+}
+
+static bool check_nested_support(u32 flags)
+{
+	if (!(flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
+		return true;
+
+	if (!check_feature(FEATURE_GT) ||
+	    !check_feature(FEATURE_GIOSUP) ||
+	    !check_feature2(FEATURE_GCR3TRPMODE))
+		return false;
+
+	return true;
+}
+
+static u32 amd_iommu_hwpt_supported_flags =
+	IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+	IOMMU_HWPT_ALLOC_NEST_PARENT;
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
-
 {
+	struct iommu_domain *dom;
+	struct iommu_dev_data *dev_data;
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
+	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
+
+	if (parent) {
+		int ret;
+		struct iommu_hwpt_amd_v2 hwpt;
+
+		if (parent->ops != amd_iommu_ops.default_domain_ops)
+			return ERR_PTR(-EINVAL);
+
+		ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
+		if (ret)
+			return ERR_PTR(ret);
 
-	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
+		return amd_iommu_nested_domain_alloc(dev, type, flags,
+						     &hwpt, parent);
+	}
+
+	/* Check supported flags */
+	if ((flags & ~amd_iommu_hwpt_supported_flags) ||
+	    !check_nested_support(flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return do_iommu_domain_alloc(type, dev, flags);
+	dev_data = dev_iommu_priv_get(dev);
+
+	/*
+	 * When allocated nested parent domain, the device may already
+	 * have been attached to a domain. For example, a device is already
+	 * attached to the domain allocated by VFIO, which contains GPA->SPA mapping.
+	 * In such case, return reference to the same domain.
+	 */
+	if (dev_data->domain && nested_parent) {
+		pr_debug("%s: Found exist: protection domain id=%#x\n",
+			 __func__, dev_data->domain->id);
+		dom = &dev_data->domain->domain;
+	} else {
+		dom = do_iommu_domain_alloc(type, dev, flags);
+		if (!dom)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return dom;
 }
 
 static void amd_iommu_domain_free(struct iommu_domain *dom)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
new file mode 100644
index 000000000000..1addcb21a38c
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
+
+#include "amd_iommu.h"
+
+bool amd_iommu_domain_is_nested(struct protection_domain *pdom)
+{
+	return (pdom && pdom->parent != NULL);
+}
+
+static int nested_gcr3_update(struct iommu_hwpt_amd_v2 *hwpt,
+			      struct protection_domain *pdom,
+			      struct protection_domain *ppdom,
+			      struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	pdev = to_pci_dev(dev);
+	if (!pdev)
+		return -EINVAL;
+
+	/* Note: Currently only support GCR3TRPMode with nested translation */
+	if (!check_feature2(FEATURE_GCR3TRPMODE))
+		return -EOPNOTSUPP;
+
+	pdom->parent = ppdom;
+	pdom->guest_domain_id = hwpt->gdom_id;
+	pdom->guest_paging_mode = hwpt->flags.guest_paging_mode;
+
+	dev_data->gcr3_info.trp_gpa = hwpt->gcr3;
+	dev_data->gcr3_info.glx = hwpt->flags.glx;
+	dev_data->gcr3_info.giov = hwpt->flags.giov;
+
+	return 0;
+}
+
+struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
+						  struct device *dev, u32 flags);
+struct iommu_domain *
+amd_iommu_nested_domain_alloc(struct device *dev, unsigned int type, u32 flags,
+			      struct iommu_hwpt_amd_v2 *hwpt,
+			      struct iommu_domain *parent)
+{
+	int ret;
+	struct iommu_domain *dom;
+	struct protection_domain *pdom;
+
+	pr_debug("%s: Allocating nested domain with parent domid=%#x\n",
+		 __func__, to_pdomain(parent)->id);
+
+	dom = do_iommu_domain_alloc(IOMMU_DOMAIN_NESTED, dev, flags);
+	if (IS_ERR(dom))
+		return ERR_PTR(-ENOMEM);
+
+	pdom = to_pdomain(dom);
+	ret = nested_gcr3_update(hwpt, pdom, to_pdomain(parent), dev);
+	if (ret)
+		goto err_out;
+
+	return dom;
+
+err_out:
+	iommu_domain_free(dom);
+	return ERR_PTR(-EINVAL);
+}
-- 
2.34.1


