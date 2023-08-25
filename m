Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F82788848
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbjHYNS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245044AbjHYNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:17:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1BC1FF5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcSi/tdxhe0gPew67uzZsiXcXf73t5S1UkrvE3o9eKXpEHUsilIubdeh0OTablE8dAKBk0H/pjZefhDvkMRxo5UsmbncePGbf+Ao96Edy80gP4TObUKeNtQ/4eeuYAF3pJ48E8KTfKUa3WuArpTQk4BI6YXTHNYWpcVwJvi9bzQ6yhS8QrXM1EpnJMcxSW6EDcBSXwMxIodKZ8Tryrc/YawMWne9spxYIoj9IbyzF0i516AW5T+PKvB4eSkqZIFdE8gPP6g2BU/h8MXEaobydUgYIDqXfGGyozCL7oNrUFlPrKNnloP7mA4gF3NJrFGC6PA4/rf0R/oWkZcrIMfKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaO/XME6m7XVlc0yy2OPGDDSQt/cmr1vUhCr54D5Rq0=;
 b=dI9B/+O33qAp47lc3Code+FYxnXsqzREnAVQNpySmONnKlMuFTG/ian3HZPfdAYp77raLN2HjFbd9ef4uRFkip739hPxCpXpQt0RyAJADCYwdul6IDObi2Cxz+yNpR7rsXjJ1/L5bvLNOdDI/36RhElgNbeVnsMXiCOXZ3jpudFKMN4tIQqu0ZyIz/deZZf65BmuUueHw0ha1PJHgajjdDI4UXEzpL6hajW87fMViaDwcj6lA3d6GT0rV9NPyK6bdGEv8fuflRhE0o47pg/LsjB/vT52Mzezwo9hO9Br3cjVayxRBxzgqGEJLfz3EcwgJdVwnqUFXQSJZDKwp3eZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaO/XME6m7XVlc0yy2OPGDDSQt/cmr1vUhCr54D5Rq0=;
 b=H1/Ptf4OotZsjL0mhNMkgB+Wpkl1QBIgXakQr4tB7VnWW94retjnOp0224R6CIZhrBX6J9pp9jv99Py2QkBFinrQX3waYgkkkCaX0ExQJ6EOjOoNNo5PURhHQoPtfFXe6UiDA60SOULsjOlwYMfbpVRQ2SvpzH2NnStbI0HYZIA=
Received: from CYZPR19CA0003.namprd19.prod.outlook.com (2603:10b6:930:8e::27)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 13:17:37 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::20) by CYZPR19CA0003.outlook.office365.com
 (2603:10b6:930:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 13:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 13:17:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 08:17:35 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 08:17:33 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v7 3/3] vfio-cdx: add bus mastering device feature support
Date:   Fri, 25 Aug 2023 18:47:16 +0530
Message-ID: <20230825131716.28610-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825131716.28610-1-nipun.gupta@amd.com>
References: <20230825131716.28610-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: ead35ba7-160d-424a-b31a-08dba56da6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcEGL3aHhh0OXy4ziOM97RYew2OZ2tJCfnKWtLv+T9mNgtmcWa1BxWb96fYB+vif6piqtzBn9uOWZZfOT/3panXIvOs04BbYyum5GcbNKZA0e4yCF1XRIoTsMHPViJlw8WGKBrPGrx/wpZocTynH67X9oX1Crmjy3mPwtsryiDGYaRa5GzrmwfDV6LefD4GJW18cJMcPMzH5djbXCCN87urIYiHS7lQBaOoMr3IUtTruX4hIMgR0TwmFy4zGLTEaCa4w6Gkwja46CxDzfgWwW3zcNe9gZBgGgn4Miv1xipFaAfAjIWEaCtMtd4dch5+eBPoRKP/uAAYhm6if5vW9/48Rp88fcLJJzmsXgXV6QYQKKKcF3BCKbYee/H3aDq3sAv8HCdTFum3AHyiNGARY48YKS+58Kv1UgHYNUoXmeI5L93OH7M6E8jZsonBt7/3zGI0EKWA0wqpBd8bNbKrWlWBX7j8Oe9yf4oLMV9yqBVGWjgZsxaCZcB00OUt2QyMjBZz5RaZF2mGfSyVMjDtND7CTzoR7eQrq2KU3S4O9Pp4YvQWjBwb3v+DIh91y5nZ1Ymj8eYZ5stLN7xPDCkvE26CQXlWZ/+bv7KE1XtATi3IAqWVvhNT06xqfzS1O6mhcNxOz67DU5hX25ZkG//VZmMsaoi6lYPdNMbFppSLn9G3YlifuWnf7u4g+FWeU3mpJbDpyJFdftB+qED30tyZaQdjaYrOXMaG71T5WSgIDmOi70wDo/uIKySU5QXGkg4i5+GXLLjbPQdYoEK86rwMDEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(2616005)(40460700003)(83380400001)(8676002)(8936002)(4326008)(5660300002)(1076003)(426003)(336012)(36860700001)(36756003)(44832011)(47076005)(26005)(40480700001)(82740400003)(6666004)(81166007)(70586007)(70206006)(54906003)(316002)(110136005)(478600001)(356005)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:17:36.7531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead35ba7-160d-424a-b31a-08dba56da6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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

Changes v6->v7:
- Add check for BME in open, thus resulting in correct response
  in feature probe.
- Set vdev_regions to NULL in case of error in vfio device open.

Changes v5->v6:
- Called CDX device reset at cdx_open_device()

Changes v4->v5:
- Use device feature IOCTL instead of adding a new VFIO IOCTL
  for bus master feature.

Changes in v4:
- This patch is newly added which uses cdx_set_master() and
  cdx_clear_master() APIs.

 drivers/vfio/cdx/main.c    | 57 +++++++++++++++++++++++++++++++++++++-
 drivers/vfio/cdx/private.h |  2 ++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index c376a69d2db2..53ed8e6c499f 100644
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
@@ -39,6 +39,17 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
 		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
 			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
 	}
+	ret = cdx_dev_reset(core_vdev->dev);
+	if (ret) {
+		kfree(vdev->regions);
+		vdev->regions = NULL;
+		return ret;
+	}
+	ret = cdx_clear_master(cdx_dev);
+	if (ret)
+		vdev->flags &= ~BME_SUPPORT;
+	else
+		vdev->flags |= BME_SUPPORT;
 
 	return 0;
 }
@@ -52,6 +63,49 @@ static void vfio_cdx_close_device(struct vfio_device *core_vdev)
 	cdx_dev_reset(core_vdev->dev);
 }
 
+static int vfio_cdx_bm_ctrl(struct vfio_device *core_vdev, u32 flags,
+			    void __user *arg, size_t argsz)
+{
+	size_t minsz =
+		offsetofend(struct vfio_device_feature_bus_master, op);
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
+	struct vfio_device_feature_bus_master ops;
+	int ret;
+
+	if (!vdev->flags & BME_SUPPORT)
+		return -ENOTTY;
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
@@ -169,6 +223,7 @@ static const struct vfio_device_ops vfio_cdx_ops = {
 	.open_device	= vfio_cdx_open_device,
 	.close_device	= vfio_cdx_close_device,
 	.ioctl		= vfio_cdx_ioctl,
+	.device_feature = vfio_cdx_ioctl_feature,
 	.mmap		= vfio_cdx_mmap,
 	.bind_iommufd	= vfio_iommufd_physical_bind,
 	.unbind_iommufd	= vfio_iommufd_physical_unbind,
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
index 8bdc117ea88e..8e9d25913728 100644
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -23,6 +23,8 @@ struct vfio_cdx_region {
 struct vfio_cdx_device {
 	struct vfio_device	vdev;
 	struct vfio_cdx_region	*regions;
+	u32			flags;
+#define BME_SUPPORT BIT(0)
 };
 
 #endif /* VFIO_CDX_PRIVATE_H */
-- 
2.17.1

