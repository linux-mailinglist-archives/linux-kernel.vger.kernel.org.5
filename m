Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAB788843
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbjHYNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245124AbjHYNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:17:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916C2120
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUN3sQcTHuTnThPvqwRnC+/luyLaj8wQN6+JbSp0EpnhVGsVTkPGxAS4fgPGtPqMDmHcMVmbgPsPvNvzrHLUtjr3jbfclWYq+DEWjjWUNJ/f+xtqn2gV7gjA0tvpF7OdVkpbneqi4j6x1p7SduRMlyoCLi0JjSNKXbGW1KmzEtKqXWkxSnDvtn9in4hvZxapU8GreoZtZe04BCE38lAntIUY2yt3RHuhPWpieWgtxpRINczFyTabtvVWeMlFTKkIucW/Jf0WLWDs0Urs/tZdtZC54Yvj6/M21+qByjOUg9btPhnPwj74i+sCUn1oDSSLbmyOXZTBtsuum53VqBBe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79KwsFA72ozRUgzUVPv2kw5MaLUWnH0VZZmfxnMUBn8=;
 b=ZK80MEsYjmUxEIQjFCOfePlCJInMtjFyrrBcIG94cOWowL3oej9/MsbAN6AJ8W8P5SHrxth8pCOY4tO8ksYZEdfGRa3atlzZwNf3KgraJuRAvqWa74uM3QfaCMzhq+QsY4E638VieGc+LtZ0OANxN2rbHLJjuNbZ+j3eB8u40Xjut5jMwwzE3d4Bwx32JBqX/pyk5V1yalzcYRJTQmxikiBFIVjiCEnnifFJLt21wdKE2CeGDuC4qloYKJGaXijinlqdcDrzcoixiVVYPYzQQ+BxR5tiGGOZyxdCVkNnCYqcIptMToKdlNVDXE7PRHFvzJW7yCJcYI2PScGMZgYu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79KwsFA72ozRUgzUVPv2kw5MaLUWnH0VZZmfxnMUBn8=;
 b=vcRqZAkEnGFbFAnicFeeXh4U/cS9ufX39QoZ/BcI0ajBj6zIPa59eVH+Z/qv/L6fPtnQ0fnuBHChYnijzmQnqGSuzFbZHb88/uCxqQ50k/z7JglBhCcFGj3uwGdb0LAbm3HiVMh1KNCh5rsA735Ad9dRbI1MJhkEu2W95LoCiSU=
Received: from CY8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:930:49::29)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 13:17:34 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::df) by CY8PR12CA0036.outlook.office365.com
 (2603:10b6:930:49::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 13:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 13:17:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 08:17:31 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 08:17:28 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v7 2/3] vfio: add bus master feature to device feature ioctl
Date:   Fri, 25 Aug 2023 18:47:15 +0530
Message-ID: <20230825131716.28610-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825131716.28610-1-nipun.gupta@amd.com>
References: <20230825131716.28610-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e7e362-6a9b-49e2-c30d-08dba56da505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWnDw1mcnSV5UoyyiM1yMomTJ0ETYk0W2o8WvRVHJ2Wwi9HaRpzpUIauul2j58PwcX37kfOYH4Ju025OP+auDxRR0PKFq4l/KcX3YLrRDEl+7EZNXQIt0ASkZ1cCNpBuUR3myX/OTdwDGO0ghTBPZYD7sZQ1BOeCd0CDH1VkVx3+q+jEy4yTCihOUdeDVJ0IBcYoMn8VB1k5CDOu1V27svF6JoTciews2UXeSo+j0DB7kZs7Q8ba8S+b8FewxbBDwssc6YzX4DPVPsmYVHViLrnXqyliph3CkHqRImV6bcbagASuQJalfFr/0m1GoSe52vMiDL22PO50b/pKyX9knbboKNYeXQHew8HjLG2icZDBI7AWVHAHUP/zogAPdOx7oa9gD6IRQCZIkwhqBUW8wW4XtGSZCbqSrW0u7Lkhf946zqSSXS5fEGQJvsyKV7zpfSbbg8Ab653NGnI1aXLgrrkRp1OBE1YMRHa9AWYgxhk54ERlk+S5iKHM+0eSSJePL4DRFRNI5OGuONGGtWZarbaENdHEtstYdqiBu92NvJc0fBGBC7znUogIVQM8X/9LHqMFM04b4UqMSz/RmQrPGOwRLQHkQu44fpSp6WWIT5epRXI/bLaXRXOSQypavqLeF4Sa0ftqiIfNVRjVzsGfDKOCmvlYlN1IpKMXcT0H9xr25be1lWOcf5QbSehoiTcYHcZIKUQPVn5F/5TrasiqZMRNqk/Bfjw/77yIhNHUSqHNm0Cen8NNAn5P9YqlfKkzCo84gBnFy1pFiuGliKiw8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(356005)(82740400003)(86362001)(81166007)(36756003)(40460700003)(6666004)(8936002)(54906003)(40480700001)(478600001)(26005)(5660300002)(4326008)(316002)(70206006)(44832011)(70586007)(110136005)(8676002)(426003)(336012)(83380400001)(36860700001)(47076005)(41300700001)(2906002)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:17:34.0599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e7e362-6a9b-49e2-c30d-08dba56da505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

