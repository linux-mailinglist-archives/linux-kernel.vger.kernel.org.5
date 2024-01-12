Return-Path: <linux-kernel+bounces-24167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C245282B877
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97BB1C23AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DED4A16;
	Fri, 12 Jan 2024 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pkhFsy2J"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0811111A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMObaykG284d+Q45TBMKsbwrz5SSNvpLyFPrAxYuELbQvjcUQU1mH0AMOotW9ku+jRJbHCmHnvSs1SC9rYuSdqgBEVB2C2BNtbKZhy0IAfPdjh21/XJaZbzIt2FIV4K0Ukd/+47oXT/rfRZQs9xtlbb1u7PPMDCEIqMX7T7C2PiU0l16mWoy3HiDsI1K+UycBoaEcf91PE0lIClJ2kyFYIzj2mN2VAHhpsiPHpSbQFxOlOlC/v7XogPTJUGbypzD3lIWnuNr8lg/ShPZNXNbkMtYoPMfcb4cxZ4dqIfCD6123TURC6evkQWfVSCiEP8IIMiWn7P5kMYRnhj/djCjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzC8bJ/HzCXiCVZ//dlwjp9dSTOOyGwaoh7nyIg3cyw=;
 b=dBaEAk4ArWhZLZE04Rpu4Qk1XxGCzmF4V4JHoDslknl5MgLgXIi8xKxCgahFpQecnY9irXHHrA571b7vR0siw7RR5guUnZS1LSKzve7+4oaXQ+BwCcukPba/pdB0bsQM39EwRROBpQiV5HNEHofhVUrH52aUGaNBomfEXyELDm9c+AaNKX7MXRdsvr49B1D/oUCFzO/0fJED9dgy2nHlBrYYIfPP4jJfndziy98PDStaO/uXnN6JV4Z69X7G9Yizp5nj30AGfv3amJ5Q99bXmXwe9gQHLrvE5c9JamZQmkid2isYQpBzfSZIK9zFE7+gKqIMDQzzlrgF6T+6TfV45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzC8bJ/HzCXiCVZ//dlwjp9dSTOOyGwaoh7nyIg3cyw=;
 b=pkhFsy2JjRZSDgC7x88OgeuB57Ilz7YCzlg20eBqfYZkerXeRXw/g2CjpjLp7dZP+UARqObaT7Nl9n2i+IndZNZ+GkUsjVSz5rcL3M78jKGBBBQTCDMRY9vmm9sVV5AnsUxmt86s32VI72GOMSqG2jV+sZpkScggV4F2Og2Ia7Q=
Received: from MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::31)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 00:07:07 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::d7) by MW4P223CA0026.outlook.office365.com
 (2603:10b6:303:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 00:07:06 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 18:07:04 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 4/7] iommu/amd: Add support for hw_info for iommu capability query
Date: Thu, 11 Jan 2024 18:06:43 -0600
Message-ID: <20240112000646.98001-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2417fa7a-53e8-40ff-c4e2-08dc130269d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kyX9CwBJO/IryG6oQk7wdAPCnjJHl8Px1vLjJ6r7yDU4+caBl79HNks1FRnLYGURe4MqrIbhbGnC3OIj7Mg+Y0QrA8CHxy17IG890efHMJHf+DWu+sXwc7ipudwyQDP62Cg7B1y5a0vuR9CzpKTiyMIs/9IMcHjY9XfZzQgBSxQTBLWiTDAPfbkUOYmUCISG1kbYlciOaoDz+O5aMMmLvdWq92CUf9EmybKLL+ExOor5wtgXXdcdEsZmAC8smwAaBiXY0FeNMu8FsGRy+JvVXJjTeosRpbaXf3jR05GY2upOq923CqTXK1Pj7FmZSFM8c5NVVQl2hO7wpHCtvIRstj4jJq412WtK2RqI8Q9gB+1/tLmqO2cw2tQgjm4jwsYGL6PYbcQgXdDfuvLv3B49foOJ8ekjdnm+jRQ5wCfkqKjvCqxyuVr75Bb16y1Px3iRTF/ktK9HHQius2JxWG4hNw6atm0F7vZzImZGBVy9FUUoT61vDUIkd7XBrwY5EnMI37ry5rlZfhROmqhIClyjip3fanXzAk3iVOOJairnv5BG6UT3HSgV/QnPMtKpZza+2VYMJ7LHOrr1f4fqzLnwjH28JARsWD3X6D66vDV19SQrtEo8TuPMJD9Wy8H/NU7GjPhBxVHGhU9ZvQgWFDJ2dk0OPLxeMe8oV0ciYnuTgYeMAbIZ6qHyhNUf6kFAixkc+jXzeaBEHlIgwYjeKjnArt6cvaW7Wyyy2F5WnPJQYg1R4qMX0QexLCerhn5mcZQYYyHfvDkr/ID3CO7lMe2l22lcRW/vj5mpkcP5i03s3V0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(70206006)(40480700001)(40460700003)(2906002)(7416002)(44832011)(5660300002)(47076005)(8936002)(6666004)(4326008)(7696005)(316002)(110136005)(41300700001)(54906003)(8676002)(70586007)(426003)(81166007)(356005)(86362001)(1076003)(26005)(336012)(82740400003)(16526019)(478600001)(36756003)(2616005)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:06.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2417fa7a-53e8-40ff-c4e2-08dc130269d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447

AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
specify features supported by each IOMMU hardware instance.
The IOMMU driver checks each feature-specific bits before enabling
each feature at run time.

For IOMMUFD, the hypervisor determines which IOMMU features to support
in the guest, and communicates this information to user-space (e.g. QEMU)
via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     | 36 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h  | 20 +++++++++++++++++++
 3 files changed, 58 insertions(+)

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
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 71099e5fbaee..134f4af921dc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2849,8 +2849,44 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+void amd_iommu_build_efr(u64 *efr, u64 *efr2)
+{
+	/* Build the EFR against the current hardware capabilities */
+	if (efr) {
+		*efr = 0ULL;
+		*efr |= (amd_iommu_efr & FEATURE_GT);
+		*efr |= (amd_iommu_efr & FEATURE_GIOSUP);
+		*efr |= (amd_iommu_efr & FEATURE_PPR);
+		*efr |= (amd_iommu_efr & FEATURE_GATS_MASK);
+		*efr |= (amd_iommu_efr & FEATURE_GLX_MASK);
+		*efr |= (amd_iommu_efr & FEATURE_PASMAX_MASK);
+		pr_debug("%s: efr=%#llx\n", __func__, *efr);
+	}
+
+	if (efr2) {
+		*efr2 = 0ULL;
+		pr_debug("%s: efr2=%#llx\n", __func__, *efr);
+	}
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
index 0b2bc6252e2c..9901b9f4abe2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -474,15 +474,35 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * struct iommu_hw_info_amd - AMD IOMMU device info
+ *
+ * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
+ * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
+ *
+ * Please See description of these registers in the following sections of
+ * the AMD I/O Virtualization Technology (IOMMU) Specification.
+ * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
+ *
+ * - MMIO Offset 0030h IOMMU Extended Feature Register
+ * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
+ */
+struct iommu_hw_info_amd {
+	__aligned_u64 efr;
+	__aligned_u64 efr2;
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


