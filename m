Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379A3763474
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjGZLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjGZLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:02:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05A132
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGZ5YIlkVyGnGgk16NrjgRSQo4zu2XPhyadHXFouzk5jEGp+l4pGNmrXFfd09J5fUC8yCPvLGs9N6xaGZ5piqLea8o7zsTU47wG5Gesk0UnS4g33+c2ERJlkIZI7HlDyiJm7mmiax8QFvsjwzaOYecX0Nq1qkQAsmJA7+gwQXoKkEjqHlSy41fKzmVhx3Vsrxt2A6EuH0ZRHrGa1eJpr1IB5FfYMsYh0ZSx3gBZ0m55ODffJ3L87uazoNpMGh4BJ8XNvaBuZFaQQWhIPDkzcqZ3gaOCqKifEULwYNx/N8XDDu027aTk7RnllTnDJSCtoHiVv/zGKitU45bgjZRCQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZIqtYtIIOO+rcD+PHQDo/jy9dGKQFJllHRCMeBjJwM=;
 b=Qv/HMY04FuXCZYC1rCvW839dw7BRtDUcDz8FuyIs6Hp81OcaqSc+t/pu8zXx6BuQ/tXYNRMaWRuTlpCU6H0XPuaK2b3UXsFanP2qwm/zWUsIRxXw0o6nEcJjm+hgtvPSNSFhkr5Fyachfqx3USwRtUdEG1aGFD1AwyY2oL/zGbPK6aZB+BwhGNub/HdQmpTT8bE5y1zxqD8AEwim0rWlj8El2vEgNxMzePAVuzO8K0GcNJhMwW8p6BiJf7aI0V0vHLtFoUudNaVenCj0wXtvjXVSVpFaWq+gu3TgH9+PfHIxUjtj8q58A8ZoHiEQ4MH/GZzGwnlE1/nP60nkF9UoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZIqtYtIIOO+rcD+PHQDo/jy9dGKQFJllHRCMeBjJwM=;
 b=v4Nv++cGCSqOnVJcbPtACwEVui8c4yI+A+eAzzDoqscDmRnjiB/1nm/Fvj6DqwO5KWG2YWBL0b9qeCX6sJf9K2jUGVn5LBanC/zJtLnUaawirHthd1SODmvYJ1SvB0W1s3osn4OYc0dQyEd5SgNjgF9fLqy0OvGwlVprt2ApVVw=
Received: from MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 11:02:41 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::47) by MW4PR03CA0226.outlook.office365.com
 (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Wed, 26 Jul 2023 11:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 11:02:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 06:02:34 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 06:02:32 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH 2/2 v4] vfio-cdx: add ioctl support for bus master enable
Date:   Wed, 26 Jul 2023 16:32:20 +0530
Message-ID: <20230726110220.26486-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230726110220.26486-1-nipun.gupta@amd.com>
References: <20230726110220.26486-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e985c0-61a1-4424-be15-08db8dc7d4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9FscsuZY2Od98uz2v2ocIprpjI6AMD3BZPMaRAGwHuckqzJb0PX7czUH5Igss/Zy2+WQsbhTpiUozFf/IpQ3U3F7WRJeKpJDu0pKARqieG9RFTk/SkUUibxzuC9gquGn30qt59QCxuXYFdSd7hz7en5I4su3LCc8dCXhunY2SSQSoi5CwJbeUg7xak3rCXMLqrJd3TcoL2RAopyWUuMNMR6gmqCVJFoWa97e31RnudKEE7aTkg4oK3549kz4tUtvIbbmBHxd7jr9ISrqUizdrIXZ+4EDT0Njd5RPOA16nLAF/BZksL0Wl6MxmzUOo1D2LknldlhgcM8oxYdPi8VdqgzylXA3R53g7cZ8ZSMLvRTH87zWLHnBo2rt/bNUnVjN9js0CjoVG89vikqI5J7kHilVw75XcGYXAjPS0NBc/c6/Sll5MwSmTUyXRConTMbXKIzTTcSn6Di68AndDM7KAT1J65V9YFZIQ1yj52Pykg1aDIieJbMniztRfB/Kfj42VjwBkRl3kplyZ3DGLsqU2CXsdF8qbZvGoFpp/gU5c1BeyYw417J+YiwVucuNqPpOPwT0Bxtw3Ch8N+BQQz2Q4DWMG3ZHcTAS9GIfYEDupmfUx3194zYlXIpbbZhg81BZsePBcku/NWPAqtj10BaCulifGGyQ3lmnuv+5BfubvCk54Uop48BeuSn01lnn8hJRi4oFYW2Ih2YdnLHS891/2G1DgDWibq1iURlsDmn4xtHSfS+/sDqxW6q1H2qyJXaU3UKxqoddr16Ij/r0nDyOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(26005)(336012)(1076003)(2906002)(186003)(4326008)(81166007)(36860700001)(356005)(82740400003)(426003)(2616005)(40480700001)(47076005)(41300700001)(5660300002)(40460700003)(70586007)(70206006)(44832011)(316002)(36756003)(8676002)(8936002)(86362001)(6666004)(54906003)(110136005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:02:41.3033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e985c0-61a1-4424-be15-08db8dc7d4ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add VFIO_DEVICE_CDX_CTRL IOCTL to expose control operations for CDX
devices to VFIO users. Support Bus master enable and Bus master disable
on CDX bus control.

Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---

Changes in v4:
- This patch is newly added which uses cdx_set_master() and
  cdx_clear_master() APIs.

 drivers/vfio/cdx/main.c   | 26 ++++++++++++++++++++++++++
 include/uapi/linux/vfio.h | 14 ++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index c376a69d2db2..c39a965716f4 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -98,6 +98,30 @@ static int vfio_cdx_ioctl_get_region_info(struct vfio_cdx_device *vdev,
 	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
 }
 
+static int vfio_cdx_ioctl_ctrl(struct vfio_cdx_device *vdev,
+			       struct vfio_device_cdx_ctrl __user *arg)
+{
+	unsigned long minsz = offsetofend(struct vfio_device_cdx_ctrl, op);
+	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
+	struct vfio_device_cdx_ctrl ops;
+
+	if (copy_from_user(&ops, arg, minsz))
+		return -EFAULT;
+
+	if (ops.argsz < minsz)
+		return -EINVAL;
+
+	switch (ops.op) {
+	case VFIO_CDX_CTRL_CLEAR_MASTER:
+		cdx_clear_master(cdx_dev);
+		return 0;
+	case VFIO_CDX_CTRL_SET_MASTER:
+		return cdx_set_master(cdx_dev);
+	default:
+		return -EINVAL;
+	}
+}
+
 static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
 			   unsigned int cmd, unsigned long arg)
 {
@@ -112,6 +136,8 @@ static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
 		return vfio_cdx_ioctl_get_region_info(vdev, uarg);
 	case VFIO_DEVICE_RESET:
 		return cdx_dev_reset(core_vdev->dev);
+	case VFIO_DEVICE_CDX_CTRL:
+		return vfio_cdx_ioctl_ctrl(vdev, uarg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 20c804bdc09c..5f6a58f9f8e2 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1649,6 +1649,20 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+/**
+ * VFIO_DEVICE_CDX_CTRL - _IO(VFIO_TYPE, VFIO_BASE + 21)
+ *
+ * Control CDX device.
+ * Variable op is set as per the operation required
+ */
+struct vfio_device_cdx_ctrl {
+	__u32 argsz;
+	__u32 op;
+#define	VFIO_CDX_CTRL_SET_MASTER	0	/* Set Bus Master */
+#define	VFIO_CDX_CTRL_CLEAR_MASTER	1	/* Clear Bus Master */
+};
+#define VFIO_DEVICE_CDX_CTRL		_IO(VFIO_TYPE, VFIO_BASE + 21)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.17.1

