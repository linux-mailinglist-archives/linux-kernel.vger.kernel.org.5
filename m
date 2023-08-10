Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8C77733A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHJIod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjHJIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:44:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB110DC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blCZMNksac5n7FKaK4w1BgZcSI9PReUPXZXDb2eVOjChBLNOQJD4GhA4qb9ati/slmDWEJougCQPR5pQaRGxLmoYSaeB3VPaHhnl+jWzWFdZ+IvkynCzkgz3WkcYVAOYLGKCUuTqY5FcB+pphYv+hc+lraWQCRPgtOlJkKDDGFbAhkqfJ1WFQ2n2jKQGFsNfOr7Ll4xhoq8DQlreSSltOZCwD7uO07k1S4OzebV3sedYlDi5w91zAscHEQ/u72graWGRIGpji5NITLioTnjKHD9VluFQM4P7xmixJ+7vepotEmWj4TnjHWNRBWepfz4XV92GA6RHa6AO/XBxBXICfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3Lm3jSVWPw1SSL1NJQVfGdGRuXjzMkMUjbcJwk7O5U=;
 b=N/O6fbFMdTkQsZXr1q2dltf4wtRbr1zy/R4AYYCoDvtWlW8T5TxVC4F+x39xlHTe2AChh6nobYebPYPQ6285RjYMRcngQ7J+X345jIZFylWXmvj3oOXY0EreNadOIiA74p2x6TwnR+CGoqmQ/5xNG2e5dSoN6W/NTcoznpYozHai4k/nX8W8wcIMp4tgaJqxuDBNvdccANCbNQMd2gNm3nBjorSMy/PcFGOspOK4JOFTr/19itqCkj65UCz3vzF0VEIqEfN+p7yEAYShziscFoMNRHN6E3PrTXijKbUGnvOyHSrsEapXaLwPE6K6Lka1jq2DcecJTfVJx8cL9LRtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Lm3jSVWPw1SSL1NJQVfGdGRuXjzMkMUjbcJwk7O5U=;
 b=xjtPrkh1zgJyveTebwU7VCzin/xZixg8FaM5mQ33PBkvnSWMkiGA1B6GvgdJjvymSrWLWVR0Q3XD/x76ZPHsWMUcXaJZl03WCc5qOael+x1287uvgbBnzFLCL4ItmuWN+bqCrchDvfgBik+UaMJ9LRDx2pxTJach5YcP1gqay0Q=
Received: from DM6PR11CA0033.namprd11.prod.outlook.com (2603:10b6:5:190::46)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 08:44:27 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::eb) by DM6PR11CA0033.outlook.office365.com
 (2603:10b6:5:190::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 08:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 08:44:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 03:44:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 01:44:26 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 03:44:23 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v6 2/3] vfio: add bus master feature to device feature ioctl
Date:   Thu, 10 Aug 2023 14:14:08 +0530
Message-ID: <20230810084409.4922-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230810084409.4922-1-nipun.gupta@amd.com>
References: <20230810084409.4922-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BL0PR12MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab3052a-a057-4142-361c-08db997e01a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXDimDa1kS9jgilNoXh878J9TrJfR9CS526M3D3ZHaefVAPhnypDZGJkg4UetISIhyUMohiL319FSKneXRGnjZbiDuGBmQzuVG6mlQuf+OSdCBBu/5lZqT8Qszcmdea2KVNdl8+mosTKyiYs/EWm/7Z2+55tyW6RK9uxQQqbVkKcwO29B66APC3S05fTiPgOGUpch6eZ+gVWtu73pYulfvsq5cdvC6l+mTWA+QYCt9BkuYl2bYqtXc7zfXpq7xKeJQEnx9LgqXhUa1xSxwkt5ubfUrvOHSKIPktMEySb9bC7XFTiLZyzGqoivVaOVqCQ+Dad2hCMEk0qAGiJl0HNgEtfA8N7hY47JohndppytHdTqT1qYkKIqyoQJe0pexUZZ5UwYTZ6fj10Hi8QCGg4zA9GWHUHtX6YZKhc/4pNHwAM+OvNR+rdywf9/2jEZX9qd3YYg2b3IBveRLkI0GIolqfoBPlCfWbzv5Zfqq1xDlh/AdJLTfTp5U0B1e4y/X9AAqgGL2C+VXAv9xZcxh+AFoKEI0kUvHPqoy90/0i2KTo4oK7D3eIrmwHlVORnK8IYAR/9NUQMukPuwi/bXSqjNyInuY4+ktpzNamOmt+7kj8ebSnNen2EQqrJPmgE8vfUTTi1cqg4AviUb6POAXKaS8lJ9AJieoqCe6ten6WJ7dNsJzXQZVzUnXLmsLTIsc5/HPRKP3fiPDit3I0EWBu6ObFJOwNocKpR5bIJZBSLIH9V5jgCJWqpMnA3NSkrUnPAWUuPfitoEh5OEl55715LFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(186006)(82310400008)(1800799006)(36840700001)(40470700004)(46966006)(336012)(44832011)(82740400003)(5660300002)(40460700003)(356005)(81166007)(426003)(83380400001)(2616005)(47076005)(2906002)(26005)(1076003)(36860700001)(41300700001)(8676002)(8936002)(6666004)(40480700001)(36756003)(86362001)(70586007)(70206006)(316002)(4326008)(110136005)(478600001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 08:44:27.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab3052a-a057-4142-361c-08db997e01a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

