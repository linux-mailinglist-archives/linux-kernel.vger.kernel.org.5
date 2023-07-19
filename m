Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8023B759A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjGSPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGSPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:46:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0EC197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLBwhQc5C+8JerkmcuNmznFnMZVdxXJwaEiZ4kkoSc0mfNjkmTehNB6LWIKKkOMFneHeUFPZQ0F05Rfw2AHy22Y1vWA1zG2ehXVssi2/7GChg8ce7aErDAYm3LHnTZ6nFYcm50/k7oWFHtqWQhLr1yt6qjnwrxAFDZl0OxEe+nu5r5mYglduum4kUEFsPIbxXKqDeJ0WxvqYIVrSTnmN5rqwBGBJqYkvUJLIo+YbtL6y6R3nFxC5cEbozBJdPZwsxmmtw/D4xiETylUqJAJjPszKJhk1X6x7ncbnQbpUxWOcNOFhVBM3rS89oBbijTqvpe1Et/EpdWCPFSPOp2Bc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwFHN4LgfAzesEJxLK1D05PiChMjwS8zFFNhav/KoVk=;
 b=F3BH6sZpNK88aiz4kxx29+z5yCjfbet+qm89oy0eKtoq0oOaQFWqbuewIdJ/G/SKC/SwGfPzOt9LHoIiZE2QVKP8Mo2pBjAQnf5v5yI+Jzp4fc6kX1xPmgnu6ucq6nTS8DtLfu6D+K070J7ATbhUqjziEvOFCcSSjqrZP0b8uJmfRUSkuQCsCk+3Djed44cYwWkQnGR7k2GAehEB3fkhT96pcFi6nLeb1R7HuXLvEW0/nq0zSKZZ+EhipYpa21n5KdbOZ+oUzYUdWTExZGY+6dV6XsZSmG86NP7IpMNsSURE3hOr1KCzt7fOGH6TmtwTZpQjGqAgUofPUhL/zAFqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwFHN4LgfAzesEJxLK1D05PiChMjwS8zFFNhav/KoVk=;
 b=YZrj2teENL49aPFsq5rk4rCl1iMtU+oFrPy4sqpjP2Iw2FD2Ceupyq4EQfUs83+ihtG1S0D19Z++yPi8gOPp9ivoeWMkH0ziHLPqQjXkBOuAq6cpAakRS/eUz20nXDffsKeEFJ+NXBDJTFGGXFkmx5Qq6XaAkl+g3pVGLx1NwQEwwPa3A4HgxFndxgwdPkyQ+Wa8R9Ba9LgHnEgt6jaJsofbWJuDUGN8DQjJ/H9MUJA57zcrzZH2YMhvS5uK8CnQRkZPkcZD3XfCamKkdiy2ns+Hz39OXdkp77lm6iVzSYvseeOWcKLPkijTm18AlS7+WyyMz81z4FDKtyF6HuR3Xg==
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 15:46:16 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::5a) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 15:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 15:46:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 08:46:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Jul 2023 08:46:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 19 Jul 2023 08:46:02 -0700
From:   Feng Liu <feliu@nvidia.com>
To:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>, "Feng Liu" <feliu@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH v1] virtio-pci: Fix legacy device flag setting error in probe
Date:   Wed, 19 Jul 2023 11:45:50 -0400
Message-ID: <20230719154550.79536-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: f59bb9e0-5fac-47d2-4b69-08db886f497c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UgJYj9AAZYikFnyzl6paVGtvvESAu+lD93LU53QuxI/DDyJ0z+lo2VKghe7e++BC9cIha4PIphLaVW2QVjTDdsi34tLsgSxfux/wgduQ43I0OwoGKbVIxLAtQEnE4hKooCo8F3jsVLLYDP/Vqmhg830Kmeci7JH9IG6K78Wm/bnY60Yz084jf8dMNRe/iam1spBOcD+S9tc3v+EKOhc25mLVUCryRAzDy3IYi8Ux+p7ANbRxamPQI9Sy9TC/pV2BHUPd9EeZtvbcRuSy3RC8toJJKMYZf7QHbT34Dd1YnI1cnqTRpC3byew8v6FJgLCzWM6hs3lZ1IJZPkFtrhzF38In6y8M8eY7hc9iVwHHpmtcoZRX9hXwue0Qeko9A+9sZlOVSjwIKKbRLfoBBThQdKuctsCpVkzjxBRsVlE34jOhPVXvu+umP5l1GAXs66z2JSFMJFsuAuP14YMGOPYF3t7UVZfD58VNoycWOfu93paZv/A7KvPDninXhAO6NT/IkLeal5ZxAg5J3c6J3rtbO64hrcHLWb/0SBkoeihbq3Dd0Pz+P+vESAOq6eHOnrvQJD8P9DlBl4zmmTBNqm5OJB22PUuy8HeJdci/wmWC+PUk2dXJj/yLbrUzh/BNUExM1zfYBCymHQ4843moMKubvX8DcNy7TCm58oy5JUo1eScDq9JvWzl/K2kvkzx207fzbJy3EsRdWt2xuAaaFHK9HtqfGckZ9+6vC+tA9emRZzsg8+G7eUZo0A6ltRI0FHv
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(478600001)(6666004)(7696005)(110136005)(54906003)(426003)(47076005)(83380400001)(40460700003)(40480700001)(86362001)(70586007)(2906002)(1076003)(36756003)(186003)(336012)(107886003)(2616005)(82740400003)(316002)(356005)(26005)(7636003)(41300700001)(70206006)(36860700001)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:46:15.7749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59bb9e0-5fac-47d2-4b69-08db886f497c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'is_legacy' flag is used to differentiate between legacy vs modern
device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
However, due to the shared memory of the union between struct
virtio_pci_legacy_device and struct virtio_pci_modern_device, when
virtio_pci_modern_probe modifies the content of struct
virtio_pci_modern_device, it affects the content of struct
virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
the 'is_legacy' flag to be set as true. To resolve issue, when legacy
device is probed, mark 'is_legacy' as true, when modern device is
probed, keep 'is_legacy' as false.

Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 2 --
 drivers/virtio/virtio_pci_legacy.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index a6c86f916dbd..c2524a7207cf 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 
 	pci_set_master(pci_dev);
 
-	vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
-
 	rc = register_virtio_device(&vp_dev->vdev);
 	reg_dev = vp_dev;
 	if (rc)
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2257f1b3d8ae..d9cbb02b35a1 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
+	vp_dev->is_legacy = true;
 
 	return 0;
 }
-- 
2.37.1 (Apple Git-137.1)

