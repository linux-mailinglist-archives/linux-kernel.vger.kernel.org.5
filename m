Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6143F765A25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjG0RZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjG0RZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:25:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA3830E8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRQJY5NhbmGEq7UW1NqqfrSCq7dKIZHBNa1/3RHI2cb43Ul2wDPeU1u7ee5TKVTuah/w/+Xq2gsvcZn9jb+StJqRqe6MdlZO9PbUMnouZvI4YpI6BYVsvLvzS3n18YKF8qRDJ2MKun0dZaK3JwBcFiVB1+O6oKfesBfB5zbZvBPM2gcMH9Gyw7MUxvNisw3CimkkhK4XBHLzYTqtOi49Ho/ji0jCPniwwWi5HE06exLjD73j70R6j5CiuGSGnnRJ514cIWnnV7mYErWPUM0Wvi/BgSnOHYpZ7+sgnSRQozySN59plf3/CyGmtThDm+9jL7nD5c3u4nZ+EXBOLTyoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBNxB6fKcsvU0vqexNHWVhVtnGjnZwJbLJ6L8xsTMOw=;
 b=h3R8rlGPbtaA6z0h2SmMinxt2yPIHxIb4GMPiCMAsqv4ppxc2fHUtPosBybEiqGrs9K/iXNUEELHA9yQwu4iFKvVYSobW2rVNcaPoW6N/JNUF0kkoFh2Z4i59fVNdMPnHQIwo7RnrZy/XNLRbQH4TCXJS9I7cMBk5+ZFRlCquT14p7yXr2fvMfaLajidPaZBDBj8IkmSYgzIJHEHgfE3hmknnNkAGvYHD2WvJbj2KG2m58ZL59rek3nnAsBuCK3tRKK/slIJWyNOeEkOI7H2NcHKiPZnSBGJqVEx/PjVdq68Uc73Gg7yZBRWfir6ENkmkHLuU/H7+2RSINAHAaqh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBNxB6fKcsvU0vqexNHWVhVtnGjnZwJbLJ6L8xsTMOw=;
 b=oc0OfdaYRNRu8jOm1fNNSiTCACX9RoMH9kG7z21i/t/L+zXH1+HObuP2QkWuqaZrOAth8Se//5kMg6LmcmDWAd4KgW3/ptONKoGvKGgulcHQO9HQeHqiRBR1NJxCpY6HowDZg/az3UNiEq0zY7S7tW0+ybxG05sLgNQ2B9SIz9MGpEXzIYkLoEm0QauUKNU6QYYbV+oGfYX8PscaeAc8YnBhCIvetUyKHCehDj467AHkMPi7KbpPWaAVtKzAUvtnjPk0k2BljLImQq7TO1Y1ubdIGwckzfeuWlLRDNsDc5TIkP+8gjsULBnwVfAxdVthek1w+ctdaGt5nC2802ncRw==
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:24:56 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::82) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Thu, 27 Jul 2023 17:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:24:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 10:24:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 10:24:42 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Thu, 27 Jul 2023 10:24:40 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] vdpa/mlx5: Correct default number of queues when MQ is on
Date:   Thu, 27 Jul 2023 20:23:46 +0300
Message-ID: <20230727172354.68243-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: b94676a5-c84b-49c7-385b-08db8ec6656a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyZFvwjuxgYFfSKE4ya4xybwaYPIWtdjFBTe5w5K6Ay4QE9A5meVwSqftJXms1X7uI6za0+tSQkA+tDWmYmubdtIqfvYbEoYe8dWLt7mRBjWDKJpnHA4gd9HpmgMU5ZzP9VFahUQ0XB1LyLn1A8ZgOLtVN6v641Vsk/X3RJ5Ad4YU0wUlvNJjiRQP+li06fO4DRga2oWj62h1jESIe2pK62SSq9HwDwqSLr3skEUvuxfs5XG6rk74gM99yTp2lYT7Y3zHohTAK6SoQh41GcGENxrYbv3TQOPQ+0O92kjN5Ap8b497AYHUkE2KhwxRmiMCKrnmhZStR4RTOiCpnVV8e1UnK7j5/JD/wCwNN24wzRkgeEQ/yQZ8oeH6Zz4bjmjWmCOS0Fq9Ql8Rq7wvo+7SpGFZuU0Wkla58pPCYcti042ZrfJ+YYhFOoyyJzSdR07UKbA5EIltfVX7CXKLFPLu0fwIERGPKZ2AMOFYXs6i1IilRgX6g3F4UrTWauF6bPYhjS7S5O6OWvI/WJVykiFU1/3Q2LNONTV1l8tw0UXrK9LUTONDdJumufcF8ceUcEaD3TgkcCJGJ22ju98oImAu/hfYJLyc2Rw3E3Z2BjXc8U6q4S/ChLGWut7SWlPL7c18W5xxOO+woesm5IiHloFEJimsVY6e3cwik3wKH6bJYWEUMIVFANwME3VcuKJLzOJfAEbm+0fiD27qFlWd4WX/wT+fQB5h+8nNyrM/7pp2o6D5bCV9PaL+Lied0Pi8tvf
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(2906002)(316002)(8936002)(8676002)(5660300002)(40460700003)(41300700001)(36756003)(40480700001)(86362001)(426003)(110136005)(54906003)(478600001)(82740400003)(66574015)(26005)(7636003)(356005)(1076003)(336012)(186003)(70586007)(2616005)(83380400001)(70206006)(36860700001)(47076005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:24:55.8248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94676a5-c84b-49c7-385b-08db8ec6656a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard specifies that the initial number of queues is the
default, which is 1 (1 tx, 1 rx).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9138ef2fb2c8..6b6eb69a8a90 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2517,7 +2517,15 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	else
 		ndev->rqt_size = 1;
 
-	ndev->cur_num_vqs = 2 * ndev->rqt_size;
+	/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
+	 * 5.1.6.5.5 "Device operation in multiqueue mode":
+	 *
+	 * Multiqueue is disabled by default.
+	 * The driver enables multiqueue by sending a command using class
+	 * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
+	 * operation, as follows: ...
+	 */
+	ndev->cur_num_vqs = 2;
 
 	update_cvq_info(mvdev);
 	return err;
-- 
2.41.0

