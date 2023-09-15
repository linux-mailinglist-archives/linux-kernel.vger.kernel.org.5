Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385F27A14E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjIOEzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOEzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:55:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4812710
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5W3yDl6tqEnOj68EpaVfuj1vyKc75xxGOe2Ov7HBsYmuCl8UTkTmbFS65Yd90s/Gmq5C4BhnYlGmmvivwVIjJ+kUOCi0sEN9gRktO1j13KehkbZnuzpsWfQx/f58r160UuFFRQOEJRw1uFahT/ObNy0nTI0rzUqzo5d7bAY+CUS4mg4rdxnN30K4TrPQBiSGWgTMidH2cid5N2EgnOLsvOsEgXb0NBRIBve6mr3BE/69iPQ5MmXtCoeXnpZa2U1Kr6ZSA9crM5+4RFy4JWKtp2uHFen/tS4Ghl8bidvevmWn/gIU3a04kPiygjRR4y5lyOUhyDeXtuWLNQAwS/PxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqyDlYkLguiypuhViCXOm5TpvHK3PjOwSh0lLfq6OJU=;
 b=Z8TuXzbr+pSob2lpzL1va/zKw9c3LiVHEm4Kq9RzLU2mg74057MUkF5CzcE2iGwHoi3s9FNXTAd5jDtlZMUdT8abLHqGSUDVLMihK4rBAjSdtiBNTuX6AkXKHPOf79b1fkNOVjxN1ER8+xUQHUz1z2h0005fxGnrQGsX1MYYeiwU0Iafp9EMCVV9oo3ZB2w/7pVAKZGjE9USV0Zc9o2+LCexXCdEWx0d/zGE7ppS7Kt8EMsdXaU1bU7w30y4sUTiIEs69e/V48eh2AepNlTIPnpvYZL6JLWnxiBqY+YyEKLskHmiQMDCfQzs/0EJQ+SjssGOOxTrDXm6JDr5t0J6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqyDlYkLguiypuhViCXOm5TpvHK3PjOwSh0lLfq6OJU=;
 b=NjW5vCAsCsSLnwkyIzJD3VVdcVRlxSHYIEZowspZ+j9Qj6JfPfEGUH0hroARFtIKRRjBwAtwirpiTzawl13Yc5U7DulYk3uuIa+Ugcc9YybicWynzlhvqeHiOTdYPaQL1TV+HzThwV4JHG68odGlrSPhqyp6Tf70j1yEI/mmHN8=
Received: from MW4PR03CA0118.namprd03.prod.outlook.com (2603:10b6:303:b7::33)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 04:55:07 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::a6) by MW4PR03CA0118.outlook.office365.com
 (2603:10b6:303:b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 04:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 04:55:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 23:55:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 21:55:02 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 23:54:59 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, <srivatsa@csail.mit.edu>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v8 2/3] vfio: add bus master feature to device feature ioctl
Date:   Fri, 15 Sep 2023 10:24:22 +0530
Message-ID: <20230915045423.31630-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915045423.31630-1-nipun.gupta@amd.com>
References: <20230915045423.31630-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: f44eed17-aad6-48b7-91e7-08dbb5a7ee57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LehUsQFVC1wXdi59RhpAHo7AykBsRcvh5DLvB/fk3SbYaR6ydZjozV44Y7IrgyEfqEMRH3vKp9yDktUgEQi5bIdGoVLKKGOQhox7MUox3CRZ6RIytv6olTraY99KB8i04Sd6bzpR0QtH6n7GhnNJCur7Xsclo1Q7Xy1jjUY+bH5vLJx/vqRyOQJGDgRG7vCnZHLlzquOr0epBtEJfKd++M30mdVwUeaxMuV1/hIShbumhL06YUSC9BiIchiDWSawQsrc9BOiyQ2s8+4ZjhUjyqS6wRnskL9BQrEuOhcgZo8311ebBcUTfuADBJMYEZGUX93UywxONmdWAcCJalVwileq5vV+zt/FI1ZRDs/eLlKWkSV2I0Ul5jiNNOSD+ODfyyzBkYGzvWXK8m2ZygEUWdfhaneFPonsyyqXQm0/r/E7akJ7wabUho7bFj/J87ikyqyAsCmKWtIXgPO1sRdn2Jc4KsPJ3PtkjlOCV0dgx5+miUSla5VG1Vxb59tJ6G5+8svc8fappMj71fFvZ+JBoCokATfDJ3N9g5ZvVRGpv6m2H/ENcys2OJZQyG2/aI/ldyvjEDvGRgW6TyIST29ojEmQlhGlMCzCmPNm602TsgdrIYsytM+GHgcd+ZHtKXLZvNISz0ba9KbDsbun6tge42s6t3BaPsjh2PD+UvxPhzsM1xNMeYEQqcETW7jvaME+BRq3QPpWhLPKdlqwu2dWYTaxON2F7hIWWdFAQqpAkAfRGc/PBwKnXh03dv6B0JJ3yd+/uSr8kNEVmxwZwAYWAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(82740400003)(5660300002)(70206006)(81166007)(356005)(6666004)(70586007)(36860700001)(86362001)(40460700003)(47076005)(40480700001)(478600001)(426003)(26005)(44832011)(41300700001)(1076003)(83380400001)(8936002)(36756003)(4326008)(2616005)(8676002)(54906003)(110136005)(316002)(2906002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:55:06.4220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44eed17-aad6-48b7-91e7-08dbb5a7ee57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add bus mastering control to VFIO_DEVICE_FEATURE IOCTL. The VFIO user
can use this feature to enable or disable the Bus Mastering of a
device bound to VFIO.

Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---

Changes v7->v8:
- None

Changes v6->v7:
- None

Changes v5->v6:
- Updated description of VFIO_DEVICE_FEATURE_BUS_MASTER IOCTL
- Used 0 for clear and 1 for set bus master operation

Changes in v5:
- This patch is newly added which proposes a new flag
  VFIO_DEVICE_FEATURE_BUS_MASTER in VFIO_DEVICE_FEATURE IOCTL.

 include/uapi/linux/vfio.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 20c804bdc09c..6858cd80d597 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1287,6 +1287,27 @@ struct vfio_device_feature_mig_data_size {
 
 #define VFIO_DEVICE_FEATURE_MIG_DATA_SIZE 9
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET, set or clear the BUS mastering for the device
+ * based on the operation specified in op flag.
+ *
+ * The functionality is incorporated for devices that needs bus master control,
+ * but the in-band device interface lacks the support. Consequently, it is not
+ * applicable to PCI devices, as bus master control for PCI devices is managed
+ * in-band through the configuration space. At present, this feature is supported
+ * only for CDX devices.
+ * When the device's BUS MASTER setting is configured as CLEAR, it will result in
+ * blocking all incoming DMA requests from the device. On the other hand, configuring
+ * the device's BUS MASTER setting as SET (enable) will grant the device the
+ * capability to perform DMA to the host memory.
+ */
+struct vfio_device_feature_bus_master {
+	__u32 op;
+#define		VFIO_DEVICE_FEATURE_CLEAR_MASTER	0	/* Clear Bus Master */
+#define		VFIO_DEVICE_FEATURE_SET_MASTER		1	/* Set Bus Master */
+};
+#define VFIO_DEVICE_FEATURE_BUS_MASTER 10
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

