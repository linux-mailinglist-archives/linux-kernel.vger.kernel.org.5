Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0774C77733B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjHJIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjHJIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:44:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED117211D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdfC8LJ8IBmR4HoTbIYyJWSppiqq6Fsh0mHGnQ6ceQSUhLNaVuducxozy1CCUUMImy0bh2HNHEezJUBGEgmaxc2GqZpUx2ly/1AbEboXerZ8xRR/VZrIcr25lJxCTOdywWa4+Ai5poUs4JkpO0CexbnEjQjl7BVRlaFUAz9+1DQ5DwgpfHADO8XSv0fcCzfpPs3Xco4yq30dIkY8vTsy1eeVX/akenn8DUwNSMH0+vqCcYfjbhEjaHZmHbIMznhf+tkTVYsAlUZWkXm0KmXdrQ97a/I6SOtR2Tka6EsaaDvaBGNN47+Qt/WG/AjcHXbVDFarMLRjhnfALu2PJA+W+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6j0r28OrlYdRKB6FnC5jMv+78o0wx6zAN2aCzzaGa4=;
 b=GTFWSeTD8x9ASKcLMyz0f4evbs2/XNRVOiN/LabPdElCeU/wZTzOPfLmEvqLa6DBwdyCo/qO3wWkQs8BIpRYO4twlzKpU59I1VOSIR6zmHW9H9R9EDi2I9Lv47tJNRgN2Tb8uKWZNwhCsCVkJVTDT+zA25jORjO2A3HnAFhrWcsdLD83XgxXNC9zl/d+Tkm8pC2N530WkedkQMZQj5+kQw2yDjCY7fkGe/Wp6csv/fh0/VrooEVA7TVDe9+J6kN2uaqaOgU/ids4PE1u84jlDcxVKedzoEe4SYI2GFK8VCozcAh7H292ShnTqPpz2yXs7Ms8BikBAyRCrCZs9/6ohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6j0r28OrlYdRKB6FnC5jMv+78o0wx6zAN2aCzzaGa4=;
 b=K8TQqKlGkht7PmUlaLfIMVYEPxuQnQsIZK4iUUo0JAHIxhTiUFVGoef1qJZyUoY6fza0ax3fZiH+yK2keT11LCPuRKhfKtqRL4iXi8U+xK/pi/v2SfKa5eTSBKFUCOZEaP732dkm1dRmK6gciMxhyoH5sUTkcJQHlh1BNMIxb/Q=
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 08:44:32 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::69) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 08:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 08:44:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 03:44:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 01:44:30 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 03:44:28 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v6 3/3] vfio-cdx: add bus mastering device feature support
Date:   Thu, 10 Aug 2023 14:14:09 +0530
Message-ID: <20230810084409.4922-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230810084409.4922-1-nipun.gupta@amd.com>
References: <20230810084409.4922-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a611710-a5e1-4943-72ad-08db997e04b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVlkOfYCWKiIpAAi/lcp4yKMcohVXiIkhyymwhmir9nJrAVw8bHYXGhibX9cBB6RQ2+uVTuTsFUo5gR5M9zA5rD+u0RHrC+soGhto23bR4Uq1FmMCwT/9EwGJNwWntliKy8aH5X1rJbRv/JCKIMk5J7UMSS9sqsy45k/Q9JuCsS3yKYcAeGavQn9PiGd/FZj5GfN0CAT6Ifi2fq/wAXUPa8CHy9V1+5CWos5tNE22cedg89+KlwwBxchB6KholjToz3704nguVXLqjVd44nW7u8ExmDN2WUZBEj+/JAVP590ps9yFlWDTEX5inbcCD5TlWWVX98TcyjXvGwUJfmTdgUfNO0EuuaMnB952ErHeR6nzgCij2DUNGto6lyTCd/7qZGM7D161VQFggI5AYRE1uInQnZ1NbElB2Ecj2Jzxd6cBLF0IWxLNUYEUAAdZHORTb7scAWorWSEnjjyM7t/xNnl+fAtWoHn8RYFHbtNhbsch+xw2GxgKYXrbT+DIvdg73gr0+kgxMgYdRQPsQ4Wp0DeQUCamHYAxRE275O7CLDxpi2yPsf52CmU7hOlXUh/nMEtd/Md/IwmmjV+WYqvU4oarP6mmT5NzVmKFBtNPJS9oLKO/RLNMSyhRmFxiAE24T1uAO7AyaDJhdPxwIql6XCU4E5lvV0DsjnvChdOjxrBdrKzXP57EjmJ60Y6NEEKX6h+3oxEzx3tDjJTAaDdr+sYu4c+ncJtselCGVTmVUkaPoYgVPwWup9tu0kslf3xhmrJsVlp0iPve5wWZ0/SWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(1800799006)(451199021)(186006)(46966006)(36840700001)(40470700004)(2616005)(478600001)(44832011)(426003)(86362001)(40480700001)(6666004)(2906002)(36756003)(1076003)(336012)(40460700003)(26005)(83380400001)(356005)(54906003)(316002)(81166007)(70206006)(70586007)(4326008)(41300700001)(47076005)(5660300002)(110136005)(8936002)(8676002)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 08:44:32.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a611710-a5e1-4943-72ad-08db997e04b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Bus master enable and disable on VFIO-CDX devices using
VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.

Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---

Changes v5->v6:
- Called CDX device reset at cdx_open_device()

Changes v4->v5:
- Use device feature IOCTL instead of adding a new VFIO IOCTL
  for bus master feature.

Changes in v4:
- This patch is newly added which uses cdx_set_master() and
  cdx_clear_master() APIs.

 drivers/vfio/cdx/main.c | 46 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index c376a69d2db2..bf0e1f56e0f9 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct vfio_cdx_device, vdev);
 	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
 	int count = cdx_dev->res_count;
-	int i;
+	int i, ret;
 
 	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
 				GFP_KERNEL_ACCOUNT);
@@ -39,8 +39,11 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
 		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
 			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
 	}
+	ret = cdx_dev_reset(core_vdev->dev);
+	if (ret)
+		kfree(vdev->regions);
 
-	return 0;
+	return ret;
 }
 
 static void vfio_cdx_close_device(struct vfio_device *core_vdev)
@@ -52,6 +55,44 @@ static void vfio_cdx_close_device(struct vfio_device *core_vdev)
 	cdx_dev_reset(core_vdev->dev);
 }
 
+static int vfio_cdx_bm_ctrl(struct vfio_device *core_vdev, u32 flags,
+			    void __user *arg, size_t argsz)
+{
+	size_t minsz =
+		offsetofend(struct vfio_device_feature_bus_master, op);
+	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
+	struct vfio_device_feature_bus_master ops;
+	int ret;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(ops));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&ops, arg, minsz))
+		return -EFAULT;
+
+	switch (ops.op) {
+	case VFIO_DEVICE_FEATURE_CLEAR_MASTER:
+		return cdx_clear_master(cdx_dev);
+	case VFIO_DEVICE_FEATURE_SET_MASTER:
+		return cdx_set_master(cdx_dev);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vfio_cdx_ioctl_feature(struct vfio_device *device, u32 flags,
+				  void __user *arg, size_t argsz)
+{
+	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
+	case VFIO_DEVICE_FEATURE_BUS_MASTER:
+		return vfio_cdx_bm_ctrl(device, flags, arg, argsz);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static int vfio_cdx_ioctl_get_info(struct vfio_cdx_device *vdev,
 				   struct vfio_device_info __user *arg)
 {
@@ -169,6 +210,7 @@ static const struct vfio_device_ops vfio_cdx_ops = {
 	.open_device	= vfio_cdx_open_device,
 	.close_device	= vfio_cdx_close_device,
 	.ioctl		= vfio_cdx_ioctl,
+	.device_feature = vfio_cdx_ioctl_feature,
 	.mmap		= vfio_cdx_mmap,
 	.bind_iommufd	= vfio_iommufd_physical_bind,
 	.unbind_iommufd	= vfio_iommufd_physical_unbind,
-- 
2.17.1

