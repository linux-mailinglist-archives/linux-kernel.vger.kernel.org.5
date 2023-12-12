Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4480F1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377109AbjLLQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377067AbjLLQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:02:08 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6FE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtvayVBtQe4rq+EChi/gUPv75tgAgmNv57FV6SqvJ4XUJhdCGs1a2bVurBGc3YIUMmuHRk2Ts1Ik8r260nmHN7cRIkTKPmcm5FdAWIRYShy84r/Y8kzvM6Nsku076/tw93kickb94BAE1O9+nQH6uSmTbsTWBIuj6nMPlUF/qB39mX3x/b0Rnl4qgXM8CT8+lFlSqy20XL/Gawp+lDkdwuK9p9kxguO8Gu/at7O5u5fUTJnrqC69Z6h/jQYSM+yGXF2WQ04dnuJVrDM0IIOkcodA5YV/gx7rABa0mr1RAsZcK8J821HZpsA0tQ6hvcIsORtYQGvZFZMtmuAK86K++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUFLSNQg7aQQMVuKUbAGPiamZbXRs4qJEBIyaa8j4mw=;
 b=LOE4WYgwnOb4N3In/RIxbV/fYw9ULxpsTcOF4a90GMzwvbjDmXJoRC5+lbSgVHV+yB6GJMAFrOvvdRCO+ho80VJcGFwnWrn1ULBseeyFqAd9yLJqnNPiSChAZdkuD/W67WyJdUPArGU6dt1KE7bo8xUPTK9MA+b6UBsCayS4HrLCD14cg+Ob5YotKlVjvx6Uf+hFkP2A23/HEUAwtWlSc58YNhMRbM2iSFHKt5oMarh4uVoiXC4FroIpv0KBF6ND+d55ZBTu8kecDxo0rbXw80yMnKP87rIAiuKrovsZmsShDoZ26KzcvbsnrLykrUAFsZaHHONJZPpgTfjonOI6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUFLSNQg7aQQMVuKUbAGPiamZbXRs4qJEBIyaa8j4mw=;
 b=KQU2+yPJhZaDTB0VJvfjp/1dnpC1VM57GdY0WCeXsVgr0OuHAIt1EfYfXJ90sDKYm5VtTajFeqiADwGi89eN/BPhr8S7R/D4QpBb9kO5EEQV6qMhiSU+DSiWZd0yba9rtPlPxRZacSgsMdv9cg+6C8M8i2OfT8seflZerwGOFlY=
Received: from BL0PR02CA0082.namprd02.prod.outlook.com (2603:10b6:208:51::23)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 16:02:08 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::82) by BL0PR02CA0082.outlook.office365.com
 (2603:10b6:208:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 16:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 16:02:08 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 10:02:06 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <jgg@nvidia.com>
CC:     <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
        <pandoh@google.com>, <loganodell@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 4/6] iommufd: Introduce data struct for AMD nested domain allocation
Date:   Tue, 12 Dec 2023 10:01:37 -0600
Message-ID: <20231212160139.174229-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 458474e1-6094-4236-e91e-08dbfb2bb195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbGD6Q1vdGQqPY420R6ynfKrCU3INPasRH1yRpgs1Yh5NeFNiOEw4K2H2gmqRGqUxlLYD/uZnxe/2KLgzjBji1azdXtL7Yi/bIgHCSdbxPc0i8MG8O3A/Wqo0WAHgD3TG6uqWBMtGEbmdOUxIxm3IzZl0KujzGRKlmLto7UxQdHbP9FwJ7yCpy7xunDN+YRiTt3FHyPFQRQMUv66vS1UUEWk46U0CDJpSsbU4ROFu7ZUcG+Xkg66Q/7qwF0pGPQ0PVC9YccIfRRD317vCtSxffMvL7ufhxAN4BGChnjgmduH1Vp57Ah4j6WCq8bbezkk7gHm3tEdxhajsEbRJHKL+Y8NpR8sOjMck3265kHvON4X2HM4yFMOTpmLj+C9MZ4GU1Vua0o9Mlxm2l77W/tBReeGWWPNNtveJ+t/RV4i2dyz4wB3xDtLBNafUUsaCqBgp2H8SK2YLl3d+xasDmNlTTxtu2w0UYNOeFrsJR4PyYrLIVeVl1p4LjKMt8x/7kmyHvuzBKfFukbbhKo/yoz2dUhhKmZB3cmdEPDTGa6gBva33PLfzuHcbhbNqAwgvfzPGCVbm/q2N5gJSYwD1phoohU+Fr2YIKhsdS4q9grPrGRhWfeaGybpI9/IA3juRYIABFHNC/kPxNLuUzKWDT+5e7SWla6WJJEpfJ8AjijOKKPj8POZeKRmWSq3zcQxpcBPOGDCFbXp8W0nMLhMzW1cFxugINBeOB0SW6H4ns1yse7zvbh2x3juhxQcHEC6X+ZKB6Q+GA1WFjkB/VfCPEy51zPTTXNwp8GUzyGOTgTJub8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(336012)(26005)(7696005)(2616005)(426003)(16526019)(1076003)(6666004)(36860700001)(5660300002)(47076005)(44832011)(7416002)(2906002)(4326008)(41300700001)(478600001)(8936002)(8676002)(110136005)(54906003)(70586007)(70206006)(316002)(81166007)(86362001)(82740400003)(356005)(36756003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:02:08.4145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458474e1-6094-4236-e91e-08dbfb2bb195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce IOMMU_HWPT_DATA_AMD_V2 data type for AMD IOMMU v2 page table,
which is used for stage-1 in nested translation. The data structure
contains information necessary for setting up the AMD HW-vIOMMU support.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index bf4a1f8ab748..e2240d430dd1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -389,14 +389,37 @@ struct iommu_hwpt_vtd_s1 {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_amd_v2 - AMD IOMMU specific user-managed
+ *                            v2 I/O page table data
+ * @gcr3: GCR3 guest physical ddress
+ * @gid: Guest ID
+ * @iommu_id: IOMMU host device ID
+ * @gdev_id: Guest device ID
+ * @gdom_id: Guest domain ID
+ * @glx: GCR3 table levels
+ * @guest_paging_mode: Guest v2 page table paging mode
+ */
+struct iommu_hwpt_amd_v2 {
+	__aligned_u64 gcr3;
+	__u32 gid;
+	__u32 iommu_id;
+	__u16 gdev_id;
+	__u16 gdom_id;
+	__u16 glx;
+	__u16 guest_paging_mode;
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
+ * @IOMMU_HWPT_DATA_AMD_V2: AMD IOMMUv2 page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE,
 	IOMMU_HWPT_DATA_VTD_S1,
+	IOMMU_HWPT_DATA_AMD_V2,
 };
 
 /**
-- 
2.34.1

