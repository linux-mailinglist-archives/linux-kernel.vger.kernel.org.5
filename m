Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D57B84C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbjJDQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243266AbjJDQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:17:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D233F9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMpHJ1SafZl7LhBMdtWpoRArTTMu0OGHlDQ9PxDR5KBSxd8NFGqtppFqEujQyQbtxrjAlQARJw3uTvb/ccoTKGbsjyMbLZTuQ6uxVQ3nnssrAogjxMYoSGjMn/Gz5i3e1NpX5gFtauNHRH51VxlK0HG/TlDjhhq1x/wx+hYEV1ngbciPaw6rkhAs/hYfTYhkWJXse4eroUEKt1iJzLwB1qZgMbMWnVrx1fy6ydKaTml5HgBvo/e+bg5EtEs+KltzN/xQFTmQV409Mq2+w00oY1pkWclHmdZ8IMxPdrNaTFng33+zIz31SXwsihiGQyxWClLnbSA2lcL8QQ/j+xYQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es0jW7d0Zd06dExpQU3GJUEwE03uYLKyNmoJ9Sv5hnE=;
 b=JXz0j9E96uTQoMtsllK8rLQESQIOQQpAQHH1Vf+XhZQpr/10ZCSXS6NI9bJhfBq5i9+WRt8jWs2ZjlwgvYWWS0lZvZ0ecNdwPAaU/lkCJf3pMV7ZVf6d19IHq8W2uoL+GIfFQ3dQVfB8SC9492YObcQV30pfxU5G49N6MXMdiINEayPgRqBN/v3Xf9U3siIhrD3/Wt0MGeLbKS/966PB3jrzuRz37Lhoz1Wgsvjw0dQWGJuS0KPKE5i/91JPDX9r6aKwLprmFzF+mkX+A7uIj3/fa3EYiWaTfelq0TYhN/aNqEjp53o6qsNBMTqBdyb8VCLFITXygmQEn9QuqwE3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es0jW7d0Zd06dExpQU3GJUEwE03uYLKyNmoJ9Sv5hnE=;
 b=1BjxBJfZ9MFltMv5MbJRpLtUJ86uLBN1lwlucalESqdEiSInv9msRkJfOS8MxK1eUMHSVkC1V2CqBq7kQZPWPe/t7ZceupF7nrHqHP07rC/G+Y4mOVOKFxYq8IqMZ7gXi+NYwZB3fs8Ac7+t1HTmQ3NmZdq+7Lm1RByr97G/dUI=
Received: from PA7P264CA0525.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::8)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 16:17:39 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10a6:102:3db:cafe::2b) by PA7P264CA0525.outlook.office365.com
 (2603:10a6:102:3db::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Wed, 4 Oct 2023 16:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 16:17:37 +0000
Received: from rtg-Artic.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:17:33 -0500
From:   Arvind Yadav <Arvind.Yadav@amd.com>
To:     <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
        <shashank.sharma@amd.com>, <Felix.Kuehling@amd.com>,
        <Mukul.Joshi@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Arvind Yadav <Arvind.Yadav@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: get doorbell's absolute offset based on the db size
Date:   Wed, 4 Oct 2023 21:46:52 +0530
Message-ID: <20231004161652.3082-3-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004161652.3082-1-Arvind.Yadav@amd.com>
References: <20231004161652.3082-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4908ca-1ee0-4e37-9eb1-08dbc4f56cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rg7DPFDVxPuC0AFbjdO9zFXOctuQup99qJ1Yeii2pXfYK6lbGem8HwpocJ6cXcBu0kKWgJ++T7uuE/ND4lVqdD/oYQNDa3xfuMVNfOnv4o+F6lDQoUsVwsXyJjt6VVAXFYpfeEmRxJbPaPYKvOMPv/qK2jqILTdnql/nbsQeDH8WZ9Y4YLXj4P0PWZ255jxA003TVG1Mx9TSwxkrorTsp+Xw2aI+kx+io0LirMs5bbSStHVKUArg6EXCPEVGRPJMXjsE786IsoUM8t2pWSxvWjKSSxzTmMI9iReIZU45cHway2EC4Rk3jE9+eFdWw6MH5ozWswvH5zAZNByL9cA5UtyApFDon5hWTGCW7u+xCOgShCCG+vMFD0UQr3q2LvMnEzo7eK5HwvGFA26B101amYYxLsLKaWibMECxZiZfZ+HJ1TizOo9snM9hBHIR610B5LRU6kv/L5S2VEKwHt6huDl/rcOig7/5A69tSdOHvJjEQR4rl6fcgg4LHJ8hsf3eMgso1QfOQ/ztayTP6pjV10OzhYd8y6mZd6oC/Zy06UD/JPxsXrkmj1wlEcpdxK5W0NuZgbYF9dE7NDlWVJG9wHz436Pl5dutBUH43y1hq1W5UC5djQwsEgKkZNOqhgvc5PJ+MXpPsOPF3VCR21aNGIInWHrT3c5d3jsYcvhyUkE+LANVQDAek2N3gvfsOEVzGxxjYZrdNSqo2d/vrk8N485A5REdC9kJJNKaMA8zIzEuV8OXlKEDk4Xck0pTeAjlheeqHO4+mRgvy02CRI4ogQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(5660300002)(82740400003)(356005)(81166007)(6666004)(7696005)(86362001)(2906002)(1076003)(2616005)(36756003)(478600001)(40480700001)(16526019)(26005)(8676002)(4326008)(36860700001)(47076005)(110136005)(54906003)(8936002)(70586007)(316002)(70206006)(83380400001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 16:17:37.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4908ca-1ee0-4e37-9eb1-08dbc4f56cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to align the absolute doorbell offset
based on the doorbell's size. So that doorbell offset
will be aligned for both 32 bit and 64 bit.

v2:
- Addressed the review comment from Felix.
v3:
- Adding doorbell_size as parameter to get db absolute offset.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   |  6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c           | 13 +++++++++++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  |  4 +++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0d3d538b64eb..690ff131fe4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -346,6 +346,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 			     uint32_t const *restore_id)
 {
 	struct kfd_node *dev = qpd->dqm->dev;
+	uint32_t doorbell_size;
 
 	if (!KFD_IS_SOC15(dev)) {
 		/* On pre-SOC15 chips we need to use the queue ID to
@@ -405,9 +406,12 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 		}
 	}
 
+	doorbell_size = dev->kfd->device_info.doorbell_size;
+
 	q->properties.doorbell_off = amdgpu_doorbell_index_on_bar(dev->adev,
 								  qpd->proc_doorbells,
-								  q->doorbell_id);
+								  q->doorbell_id,
+								  doorbell_size);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 7b38537c7c99..59dd76c4b138 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -161,7 +161,10 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
 		return NULL;
 
-	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
+	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev,
+						     kfd->doorbells,
+						     inx,
+						     kfd->device_info.doorbell_size);
 	inx *= 2;
 
 	pr_debug("Get kernel queue doorbell\n"
@@ -233,6 +236,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
 	uint32_t first_db_index;
+	uint32_t doorbell_size;
 
 	if (!pdd->qpd.proc_doorbells) {
 		if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
@@ -240,7 +244,12 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 			return 0;
 	}
 
-	first_db_index = amdgpu_doorbell_index_on_bar(adev, pdd->qpd.proc_doorbells, 0);
+	doorbell_size = pdd->dev->kfd->device_info.doorbell_size;
+
+	first_db_index = amdgpu_doorbell_index_on_bar(adev,
+						      pdd->qpd.proc_doorbells,
+						      0,
+						      doorbell_size);
 	return adev->doorbell.base + first_db_index * sizeof(uint32_t);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index adb5e4bdc0b2..010cd8e8e6a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -375,9 +375,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * relative doorbell index = Absolute doorbell index -
 		 * absolute index of first doorbell in the page.
 		 */
+		uint32_t doorbell_size = pdd->dev->kfd->device_info.doorbell_size;
 		uint32_t first_db_index = amdgpu_doorbell_index_on_bar(pdd->dev->adev,
 								       pdd->qpd.proc_doorbells,
-								       0);
+								       0,
+								       doorbell_size);
 
 		*p_doorbell_offset_in_process = (q->properties.doorbell_off
 						- first_db_index) * sizeof(uint32_t);
-- 
2.34.1

