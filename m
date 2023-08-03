Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9801A76ECA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbjHCOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbjHCOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:33:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55402D65
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+dAAl7BqGyCHrgUvVciv+3PUwquG3Y9shzUbe0vZ4F4OLZB5ihl9R78FbIQPZzIK3+kN1t9SVmyg4MJL77syjFJnMnHV2DrhMBJq/iPwyVhOZ7ll9Vx+uhJA190n5EoQz/7tUP4mkWCIxwD5w7xBnb09dBYzEfkZhv4pJ1x0AZgZ/wJQ7TXKCinwXwDheSQgaQkZh62SL64lJdTuiAoPsNMFOyu9Ffw6Ftzn9Fx6OxUlNJWszWVBaYT24W6vjPZTuiAe/PcnMCE6sXa8S8lxTgRlIeDZrso93BxSSRhLtLBKvXrjOYnFZlcqSlTJwKDTddzvPki3qEdQ/Q/ftATyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nidXFovMwXMY+ljbF75xsPQS2gch+qdQ7STt1gVt8oc=;
 b=nTaBwSePPO6iKOrTosFiIa6FTktxs/oqIfSM1x6rMc7v3+efJ0GNSMyv9LTxbOPquTER0JZyx7DPCsi1ineVGjffg0qm4j1rRhXY3ETb75vmK4lnM0zLHakdf/j/kH1LxjZDGPp+3AzZLLuwewkvLqmZW3spMS8l2Whop0Oj8Sw5uLYLdqE/8MQdMTTKkttA2qK4TL1YiysMy18D1tlrH1rBfca05u1AreKzRq2eBoDLUxi6AEUPA/W9iEsV4sNQQ2kP+5Nl4lP68nLE8h/iyXmVrvec2PlV0bRkCoQyL/QntuReO0+eIbLyoR7ZdhOUL8j1jDQWsx1Nywc3S2CAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nidXFovMwXMY+ljbF75xsPQS2gch+qdQ7STt1gVt8oc=;
 b=L37UKtaUXrKR+xazpA/7KLXp8J+Y14Ppcfo8L+Kv0QrztRbvaz6kjhPp5UTFE4l1LV5VBbwtdqgTxlLItt7AGnf+Sqtk9leNToXJSi68KsxeqRoraw4eOQ847uy/0/8whcUqRERdATS9KXm29KrJDHZbAa1ojLaBoFRjXMOgCpU=
Received: from CY8PR11CA0015.namprd11.prod.outlook.com (2603:10b6:930:48::21)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 14:33:06 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::6c) by CY8PR11CA0015.outlook.office365.com
 (2603:10b6:930:48::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 14:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 14:33:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 09:33:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 07:33:03 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 09:33:00 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v5 2/3] vfio: add bus master feature to device feature ioctl
Date:   Thu, 3 Aug 2023 20:02:52 +0530
Message-ID: <20230803143253.7817-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230803143253.7817-1-nipun.gupta@amd.com>
References: <20230803143253.7817-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BN9PR12MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: b9727572-906d-4348-91c7-08db942e8d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYiQwqdv5IjdMzPCM78JvwTipCZIw9YRyhQ1Sh54UZR67Jhfocm2eYo7TmnAO4YtIm0U9Q0CPs137BRNNJKGtald/Rc2q8m27ddHz2JaklA/FXwoPa6sB2Kyyj378kn0Hm+xqLRNEU9HxXpe/Jtc0aTgpWQWKxvy2i/F2ijPhx8UQg0AWPWElqp6M26NXNGNFpiRpFej8QwgRA8RUIyHkYZKvFnm28nXLuigu7RCJZrDnSGrEh7a5vhisurMWD8FzxMRLLHo4tsYuZbkg0MyNsJswQCSqH4Bzt0QeI5yd91KNy8y7tD0lHuuAzqkjaStKO0QDkclJQoTfi3bVqrilMZSZ3a+OoewilvhkrNe+lrSi/1VULuVnqZfm499CYRtypR7d/0s5Avd3vzUV/h3TvfworZONTcQW0LXuZWtdi47nlTm+sB/6eJoiYFdH0iWnC3lxPL4v0lh3ipgToKx3NJV/URUk5lHCNPXoCnoo8tq6f+aErVzbysaDyz6Ys3Km1HI4O7sQHgcKmqCroKLcCAWbMMAI7Auyj223B/we8luZm+ElzYGfaXjTJ7YqaOCwDFJk9bGhGFP+pTG0/4nHO5oFBjXOg1gpa0uaGb9TMGaHQKTbSY8hBOjJMJQ33KU7/cMFJTigwIiycwBAMSI30Z9H7e3kX5ghYfHbue0RqcfjBoBQkwAGsP6cIPknCUVyc2t+C4ZnunG+JBFZLmXlS63AAb2DI7brkXX3PRaQjzd5B36grWW2rkiBQlOGnFYzXCl5lSxhwdWQltpzPJpaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(82740400003)(40460700003)(40480700001)(54906003)(478600001)(110136005)(356005)(81166007)(47076005)(1076003)(426003)(2616005)(83380400001)(336012)(186003)(26005)(8676002)(8936002)(44832011)(41300700001)(6666004)(36860700001)(316002)(5660300002)(2906002)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 14:33:05.9812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9727572-906d-4348-91c7-08db942e8d2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Changes in v5:
- This patch is newly added which proposes a new flag
  VFIO_DEVICE_FEATURE_BUS_MASTER in VFIO_DEVICE_FEATURE IOCTL. 

---
 include/uapi/linux/vfio.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 20c804bdc09c..05350a2f1eab 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1287,6 +1287,22 @@ struct vfio_device_feature_mig_data_size {
 
 #define VFIO_DEVICE_FEATURE_MIG_DATA_SIZE 9
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET, allow the BUS mastering for the device to be
+ * set or clear based on the operation specified in op flag.
+ *
+ * If the BUS MASTER of the device is configured to CLEAR,
+ * all the incoming DMA from the device will be blocked.
+ * If the BUS MASTER of the device is configured to SET (enable),
+ * device would be able to do DMA to host memory.
+ */
+struct vfio_device_feature_bus_master {
+	__u32 op;
+#define        VFIO_DEVICE_FEATURE_SET_MASTER        0       /* Set Bus Master */
+#define        VFIO_DEVICE_FEATURE_CLEAR_MASTER      1       /* Clear Bus Master */
+};
+#define VFIO_DEVICE_FEATURE_BUS_MASTER 9
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

