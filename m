Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E439D76ECA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjHCOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjHCOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:33:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A55C30C2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/guKlrzTnkZuixQkpfcakmt0SnXCctfr8t2jKf8FamPpLl12IR/qkVsrPaMutF5TOEvwKMen2oLMIXyWoodfHMcxb1IuRWDxP1x3GmrxjzY/f7VtSoaJruSzJtRDnYmZfDpHbE33wX/bBBBkm5S9KxbcuaihblilB2svVce8g1F30So3vV/rYKc8TS42bnA0W4UVf0A4Ni5h4s54pdo8zriFWYpMvP1adUEpqVbKUIhUhzV3MKFLmYXOGDT48j2q+XKwq07tmPDzVUx4ZZEWSa0DVKV+uJy7syRvQA0JDMrWVVlxyAo5KCx1BAZZoNZ46xb0Odo9s6d+1pUuSbk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4bwOTGjojPmDtBETmBHZsBQZ7TjvY8a1Tqeo5zAv8s=;
 b=VVSwWwXNLtY+sTtCPdpPocNXPSArbTk6z7UDsZOCuEnJ+VFyZdLMB860rszs4H+hCbWYRtma/YKUYmvkiAar74K5RUoznllYmQX3jTpQseb0Sj4bUDjql3tjzeg8cS2CXcSRpUQIksKstbpBPDpWXM06Hc8SCUOJnyARgKP/mSw2EHqiOWRFtV/AY6QSeVnmpjly53IqFwcgO+D8ORV3RQhZh2DaJuq0nJmBs/c7grME+2rVA3Nu8X8Ajw6/RDWhn3NnpIGmCwtuSgFv4fLvDkAXJGdDE6ZqQ9jFpGVZCAF3BfHpMOQ0RGGv5i85ERRQqRzD2TVqvcnHrOjT6S13ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4bwOTGjojPmDtBETmBHZsBQZ7TjvY8a1Tqeo5zAv8s=;
 b=TEK4A+bdRnTryfG+WeOU2H4UcjKnUHD4HuD++wW2nDjPViLFlzUTXjcbYZ5XYAtGo9GibxuQ271C/f+dC5Pee40Ka6z2XLE/mza+ziwYvY73ABHRpAfUrbzoSGKQ9svx8tGUL7OOoQ/mjCwiZW/EXOv1GHqP1iUvWtU0r4r34W4=
Received: from MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20; Thu, 3 Aug 2023 14:33:08 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::a2) by MW2PR16CA0056.outlook.office365.com
 (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 14:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 14:33:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 09:33:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 07:33:07 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 09:33:04 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v5 3/3] vfio-cdx: add bus mastering device feature support
Date:   Thu, 3 Aug 2023 20:02:53 +0530
Message-ID: <20230803143253.7817-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230803143253.7817-1-nipun.gupta@amd.com>
References: <20230803143253.7817-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fd247d-6a4c-4d6e-5e43-08db942e8ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AootwSpsHvNz4dt6+OVpx5j4GTuhPzP6untd9Lzm6jdr7KxCstjZvEenYVCMi/xo+coqm7nJtUsbkSbm9q/uWuhnsIfDEkKwfl8Jtn5XZimcfBepFji4jZrO6G2uYnrzOgvnuQenuSWdTIJy2PoGhdh1bq2HR4/rsr8uJrYYG50FYyofk12K0SUyJTAZ2gVbu0FuS7jfqmDiGkVe9cVNX9l6miXdcYjAKYVcsH02tBWps9XL1DXdNWPeBy1mnck8D64YVIxgbK90XtD+ycuobjyXVBAocw7Uruw30c+ejSx8/yhHP6LiPW0aeXlhs2+km6LGlKcXAMU+ucOv+18xRpGvB2b2dazW/QY8Jc7KoJvUThfU6+jviw2jmWEmwXXdv1WFF8hRbFA/axINls8usElLCMXDJskVN1sXReRB62nii9wppufxsvA7lSCczgy+fx7Q6LWrJvFYpeZO0ZaDInuo3PeMIEmLa2993NFdBrJ143BUc3FDe4KIScmMmqWdcMFQgVRy5zIW/45uyFcYNO7KYnGfr03d2J8ONfUdbEZyKmNoMJG0OtBQAj94fCuRcZab+6tLOCmig2w7oKXHPImHvxr0nas10refydmRQQ9nBhMXY+gfBJRfuLtjqDEzfw2kkHA4KUqb08x79spwT1ezuYW+JHGtaZyT/qLAc4Q7wGpAPFdgEcfo22sgnHEaTK8FWHzqkghTtgOhGoordCfSyDTJo7F+6LmyOSg3jhuSiGNLrpYIM/awJpdInrbWLULhU1Y7ZjxUkZpB1tAcWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(86362001)(36756003)(82740400003)(40460700003)(40480700001)(54906003)(478600001)(110136005)(356005)(81166007)(47076005)(1076003)(426003)(2616005)(336012)(186003)(26005)(83380400001)(8676002)(8936002)(41300700001)(44832011)(6666004)(316002)(36860700001)(5660300002)(2906002)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 14:33:08.4128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fd247d-6a4c-4d6e-5e43-08db942e8ea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Changes v4->v5:
- Use device feature IOCTL instead of adding a new VFIO IOCTL
  for bus master feature.

Changes in v4:
- This patch is newly added which uses cdx_set_master() and
  cdx_clear_master() APIs.

 drivers/vfio/cdx/main.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index c376a69d2db2..6420cf6eb2f9 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -52,6 +52,45 @@ static void vfio_cdx_close_device(struct vfio_device *core_vdev)
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
+		cdx_clear_master(cdx_dev);
+		return 0;
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
@@ -169,6 +208,7 @@ static const struct vfio_device_ops vfio_cdx_ops = {
 	.open_device	= vfio_cdx_open_device,
 	.close_device	= vfio_cdx_close_device,
 	.ioctl		= vfio_cdx_ioctl,
+	.device_feature = vfio_cdx_ioctl_feature,
 	.mmap		= vfio_cdx_mmap,
 	.bind_iommufd	= vfio_iommufd_physical_bind,
 	.unbind_iommufd	= vfio_iommufd_physical_unbind,
-- 
2.17.1

