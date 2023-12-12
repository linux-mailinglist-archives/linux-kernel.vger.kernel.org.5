Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD61880F1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377281AbjLLQC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377226AbjLLQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:02:14 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC39F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:02:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly+bXBlxvin74UKo+TAby8MQ60q+a4yKE2KccX0czfEoOhgvkwxW1w/JNPZXq0Dx/dWvK12estfIp+EPuuKtRCUP6jKf7zLQgvl91NMOLxPggg0R3ZTvN1STQ4sMQ+IOCWNus33NYsk4m8FSURX6CZXWQPHFLkijIwnCMRzT39jDYjWVVL/RfSBC36uaVu0qVYWM0ZnRlRzqbdyoFK7jHem6gUMjN/+jaBivbggHCQqt04uzVaK9oiCxqbb9z7sefDOgR7+Ej8suGGMGLIOxJrZjjluhGbxghccOGrxm3s7SGyQLlztI6MRdzUc1GOX8rO8FoTcMjyTxHa8TiV+4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6VDxnUGupzhSbze1Gx+uztUEK1it5dGt3r44BSI1wk=;
 b=F8PNm4+kQ44RwbtfGWRPLMWNpU+C/LSiEzvtrYykcCtMEqtc5z4qiPPuvqWz40Hnn2HVta0VFUhNG5TwOvm4AH4YfsRejDoOgOT7WaCo9TPL06xhdpbm9E5E7pX6Ovo1jYi4RmYShnwJOxwtSgVTc9noBSsfsgBrguDDoqrPWqbojko+6PJwdjVblBYgvcIt29uQPYuUExUAGgWoL13xzASqtTLQUQjptsWMD4Bolr25OEsRvJcnka81B0EO3u1SJC/6RJDOFXc+RNIAevuRbgeoZRqf73dQJGCeXgLADimFtywmkf2L0vwrxrL3oE/6LFlXAPk0PjBGxcoKP7IN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6VDxnUGupzhSbze1Gx+uztUEK1it5dGt3r44BSI1wk=;
 b=EO3CP/o3wMCxT/TYaG9vFB9EoAzBEbmQAeFjf6Vnd8rXMU1AffAQc78hh4Xf+ZjZStCTlU86ac8gte2wPqB0UWsG/D+w9bcwimmmQ4IlzBLRegX7V/HyKH8hMcf155l5zM2w35XntI7FK4qDMxhE8crggnZFhu0hkyH+x/oTCaE=
Received: from BL0PR02CA0087.namprd02.prod.outlook.com (2603:10b6:208:51::28)
 by BY5PR12MB5512.namprd12.prod.outlook.com (2603:10b6:a03:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:02:12 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::31) by BL0PR02CA0087.outlook.office365.com
 (2603:10b6:208:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 16:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 16:02:10 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 10:02:08 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <jgg@nvidia.com>
CC:     <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
        <pandoh@google.com>, <loganodell@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
Date:   Tue, 12 Dec 2023 10:01:39 -0600
Message-ID: <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|BY5PR12MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8c8c74-9d1e-40b6-db34-08dbfb2bb2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7qpAN8pj4XMARlKXO5PhCvN5sboiPFRptC6Y2dEKegqDHCBcA/XjUBkGDV7Rubk7asP8GLQEpumbQQP54ncakv/8SS6zBDRtUZrfgKXDtWNMQLPDjHPWFVmyA3N8LLzlX1X4dVDwc8wR5QHif5WR7KyrSqP0hjJlWf6/VDTv8G+AmblycZH/pGYDE4C7++ElPkGjLUhL4kwzPQMamAo/+0hDfQjCfJZhD21BOuJif7oWIE6aZBTJPNyjNuHjzyaqa0/ts6OJsCxW1UKrrE54inGHD3+2hvmmAYww4fHczCX19jOLhDNbwMjvqy8rm7F7nHyycNTZISbEadSWdWN84HKNuSZjzRAaolsev3BDy+lUJWKUjqC3blu8bBhN5zwbVOyzDtR9jAG8BkdB3UTSQ+cTuVy9e9jslF39N5iU9Vy76O5qwkEExXjx55GObkEA91CujCzJp3Lb0p2AH8+NoagOfy/6KNvsfazWTKck3l7amUyrzHiPDjMu3IUtx+HnKtxXBKARHQGocsiMUNmXE8obBRl2XzaR67c/lsL03CwQVvpGPaFGjl2E+/hChD1Pl02VZXTOzVUEJg+Vx4sR+MZHPhomcgQiXXxfNDDrU8Uffey/7Dc1ZL7TKwSTfAjgOgxvLebXNqRqYXHVMfI0t742PKQTXTFBCyPGK/utZNzhmSZQmviKN5Wkl0YE0nYS1JMG1rkcKPWu6bXgHLtgFJ9vbBXn72KM1FF8OkeBk0yp6eBQAg60Ws8/Jdiv4PLcW9hBNkjzOs4zSIOkWDEi3iMSGflQJy2Z2oKQO86Lyg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(5660300002)(7416002)(2906002)(2616005)(1076003)(6666004)(478600001)(36756003)(7696005)(47076005)(82740400003)(81166007)(426003)(83380400001)(16526019)(336012)(8936002)(26005)(40480700001)(4326008)(70206006)(54906003)(40460700003)(36860700001)(356005)(316002)(110136005)(8676002)(70586007)(44832011)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:02:10.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8c8c74-9d1e-40b6-db34-08dbfb2bb2cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5512
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support nested translation on AMD IOMMU, the driver needs to
program DTE[GCR3 Table Root Pointer] with the address provided by
the guest via struct iommu_hwpt_amd_v2, which is passed as a parameter
of the struct iommu_ops.domain_alloc_user() with the flag
IOMMU_HWPT_ALLOC_NEST_PARENT.

Note that current implementation only support GCR3TRPMode for
nested translation, which uses GPA to program GCR3 Table Root Pointer.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |   8 +++
 drivers/iommu/amd/amd_iommu_types.h |   3 +
 drivers/iommu/amd/iommu.c           |  63 ++++++++++++++--
 drivers/iommu/amd/nested.c          | 107 ++++++++++++++++++++++++++++
 5 files changed, 175 insertions(+), 8 deletions(-)
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
index 55479a6efaae..6ea146a964df 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -7,6 +7,7 @@
 #ifndef AMD_IOMMU_H
 #define AMD_IOMMU_H
 
+#include <uapi/linux/iommufd.h>
 #include <linux/iommu.h>
 
 #include "amd_iommu_types.h"
@@ -75,6 +76,8 @@ void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 				   ioasid_t pasid);
 
 void amd_iommu_build_efr(u64 *efr, u64 *efr2);
+int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev);
+void amd_iommu_domain_free(struct iommu_domain *dom);
 
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
@@ -190,4 +193,9 @@ int amd_iommu_vminfo_alloc(struct amd_iommu *iommu, struct amd_iommu_vminfo *vmi
 void amd_iommu_vminfo_free(struct amd_iommu *iommu, struct amd_iommu_vminfo *vminfo);
 struct amd_iommu_vminfo *amd_iommu_get_vminfo(int gid);
 
+/* NESTED */
+struct protection_domain *to_pdomain(struct iommu_domain *dom);
+struct iommu_domain *amd_iommu_nested_domain_alloc(struct device *dev,
+						   struct iommu_hwpt_amd_v2 *hwpt);
+
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1b150e0cb689..c2055b476a97 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -114,6 +114,8 @@
 #define FEATURE_PASMAX_MASK	(0x1FULL << FEATURE_PASMAX_SHIFT)
 
 /* Extended Feature 2 Bits */
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
+
 #define FEATURE_SNPAVICSUP_SHIFT	5
 #define FEATURE_SNPAVICSUP_MASK		(0x07ULL << FEATURE_SNPAVICSUP_SHIFT)
 #define FEATURE_SNPAVICSUP_GAM(x) \
@@ -1058,6 +1060,7 @@ struct amd_irte_ops {
 struct amd_iommu_vminfo {
 	u16 gid;
 	struct hlist_node hnode;
+	u64 *devid_table;
 };
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8bf12674dc84..2a7e29e8c112 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -260,7 +260,7 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
-static struct protection_domain *to_pdomain(struct iommu_domain *dom)
+struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
 }
@@ -2526,21 +2526,70 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
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
+					   guest_paging_mode);
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
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
-
 {
-	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
+	struct iommu_domain *dom;
+
+	if (parent) {
+		int ret;
+		struct iommu_hwpt_amd_v2 hwpt;
+
+		if (parent->ops != amd_iommu_ops.default_domain_ops)
+			return ERR_PTR(-EINVAL);
 
-	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
+		ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
+		if (ret)
+			return ERR_PTR(ret);
+
+		return amd_iommu_nested_domain_alloc(dev, &hwpt);
+	}
+
+	/* Check supported flags */
+	if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
+		       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!check_nested_support(flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return do_iommu_domain_alloc(type, dev, flags);
+	dom = iommu_domain_alloc(dev->bus);
+	if (!dom)
+		return ERR_PTR(-ENOMEM);
+
+	return dom;
 }
 
-static void amd_iommu_domain_free(struct iommu_domain *dom)
+void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 	unsigned long flags;
@@ -2559,7 +2608,7 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	protection_domain_free(domain);
 }
 
-static int amd_iommu_attach_device(struct iommu_domain *dom,
+int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
new file mode 100644
index 000000000000..332f7efcdc92
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,107 @@
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
+static struct amd_iommu *get_amd_iommu_from_devid(u16 devid)
+{
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu)
+		if (iommu->devid == devid)
+			return iommu;
+	return NULL;
+}
+
+/*
+ * Note:
+ * Host-DevID is stored in the per-VM DevID mapping table,
+ * which is indexed by the Guest-DevID.
+ */
+static u16 get_hdev_id(struct amd_iommu *iommu, u16 guestId, u16 gdev_id)
+{
+	struct amd_iommu_vminfo *vminfo;
+	void *addr;
+	u64 offset;
+
+	vminfo = amd_iommu_get_vminfo(guestId);
+	if (!vminfo)
+		return -1;
+
+	addr = vminfo->devid_table;
+	offset = gdev_id << 4;
+	return (*((u64 *)(addr + offset)) >> 24) & 0xFFFF;
+}
+
+static int nested_gcr3_update(struct iommu_hwpt_amd_v2 *hwpt, struct iommu_domain *udom)
+{
+	int ret;
+	u16 hdev_id;
+	struct pci_dev *pdev;
+	struct amd_iommu *iommu;
+
+	iommu = get_amd_iommu_from_devid(hwpt->iommu_id);
+	hdev_id = get_hdev_id(iommu, hwpt->gid, hwpt->gdev_id);
+
+	pr_debug("%s: gid=%u, hdev_id=%#x, gcr3=%#llx\n",
+		 __func__, hwpt->gid, hdev_id,
+		 (unsigned long long) hwpt->gcr3);
+
+	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(hdev_id),
+					   hdev_id & 0xff);
+	if (!pdev)
+		return -EINVAL;
+
+	/* Note: Currently only support GCR3TRPMode with nested translation */
+	if (!check_feature2(FEATURE_GCR3TRPMODE))
+		return -EOPNOTSUPP;
+
+	ret = amd_iommu_set_gcr3tbl_trp(iommu, pdev, hwpt->gcr3, hwpt->glx,
+					hwpt->guest_paging_mode);
+	if (ret) {
+		pr_err("%s: Fail to enable gcr3 (devid=%#x)\n", __func__,
+		       pci_dev_id(pdev));
+	}
+
+	return ret;
+}
+
+static const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev		= amd_iommu_attach_device,
+	.free			= amd_iommu_domain_free,
+};
+
+struct iommu_domain *amd_iommu_nested_domain_alloc(struct device *dev,
+						   struct iommu_hwpt_amd_v2 *hwpt)
+{
+	int ret;
+	struct iommu_domain *dom;
+	struct protection_domain *pdom;
+
+	dom = iommu_domain_alloc(dev->bus);
+	if (!dom)
+		return ERR_PTR(-ENOMEM);
+
+	pdom = to_pdomain(dom);
+	dom->type = IOMMU_DOMAIN_NESTED;
+	dom->ops = &nested_domain_ops;
+
+	ret = nested_gcr3_update(hwpt, dom);
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

