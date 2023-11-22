Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61777F50CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjKVThe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjKVThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:37:13 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B6F18E;
        Wed, 22 Nov 2023 11:37:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHtzz/2BB3ZawQkVQbrpqRyNK+AhpaPPj9IITuWEIoT71YwPRUNIBKozpmPumBmyXfGeqCMSiq6aE1tOyeH5WSPbmJS3R8R6NbkcLHNo1RwN6jN6/iHesjPUFf1Wn5y6cbrUjOT15bz3wxuX3MO49+WBVQTj3bdIGXCyQe3AzG/F+eAlbpYDF7ZGunJelv0hVTFWxpNaBMTP5TVQqTnyCGZXVkGMK1vT4KAC7DZcoaB8hbwbOhNI3NgPPRtjT6EVjuEOV/pF0dhablpgEVHDuUKXcp/ruHX1HUMfvMQecMH2yZ0ehXacxCdq1KM0S+z9O+lSOiEz1l2qqtwauUmXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtrPayVZQXBw67d+4Vj1Zu1D6nFAfbDFFmIDnkhafRo=;
 b=HY9wSgYnws9agRLFPzrNH38o5SqCx3/0lATXNlwPVkbMj7thGcwKyUILmu78d0t/64dQEa85o5vL6XSDlNV5Y7uBeoWnACK3dXkLP1eeRiOvgQuFMzRY3Nm4I/cQ9nIbcj4NR07qcCVb4iBahGzOBDYxhozxWeNYvAFexCLc1/epsjQ6rwbGFxY7VhpZluxCYRc/MZehar2C7MhU87jCVSLG+qp+Ojdly4rkGJVaDH6ClyW4JKdVkdC3dOdDR/zsRjKpgS9eCalWr+5lYZZABHwP4Q7rXxIVDHPDyczW4y+b2zOR6atuADUFm7bcVcTaDZK+KAlKktXNyP0cTia6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtrPayVZQXBw67d+4Vj1Zu1D6nFAfbDFFmIDnkhafRo=;
 b=If7gDa2o4PEl13g0XdAJN7eUKDnCOgJBfxMai2dd4sCSYJKA+Tu6kQOpIJPTvhsfyy4LqMl6V265lTnA7DkQ/geHOAoFsmwkmEWMoIen8UaSpq4D+mh34xzbwshT2LGpqYdNkU3rfQbZovIrj8HuOtL3HGQzKBzusJE4bsUEQi8=
Received: from BY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:a03:1a0::34)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 19:37:02 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::22) by BY5PR16CA0021.outlook.office365.com
 (2603:10b6:a03:1a0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 19:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 19:37:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 13:36:57 -0600
From:   Brett Creeley <brett.creeley@amd.com>
To:     <jgg@ziepe.ca>, <yishaih@nvidia.com>, <liulongfang@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH vfio 1/2] hisi_acc_vfio_pci: Change reset_lock to mutex_lock
Date:   Wed, 22 Nov 2023 11:36:33 -0800
Message-ID: <20231122193634.27250-2-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122193634.27250-1-brett.creeley@amd.com>
References: <20231122193634.27250-1-brett.creeley@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ebfa90-00a1-4f7d-35cc-08dbeb926698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/qUPyZzXd7QLHLZA1OMo00o3amjtuOYkQzaHq27h/asdzplHRnKTnp1OAvhQT+0aYRN3AKR9LOTnYiwSKjMzXE8ryZiF9bUNozRt9NvONS3lLEV3mHh7JZ6otLFx7aI+CO4MWsK4cr9qXKJUqz7erdrUlR5PRFI5SOy8QOnQeq6WgmdtsOsoPa0oLbKwARfywvcnC8aMcNiAieVTlMiZJ62SW2kDYRVnOa4Qnzb99dCgIBDn/GNzItqhnFXVJl/nuPr6SHoEQ2za2qovHqSCAWWARHS87ccW+NU9Mp0nm3jck/mbmzO2QY/URMtNZYZaktBiE9E7apU4A7ut9Xak9p4nRjOMh4p7F8btsvkxFgSRG1DLTknBHd+b8MF7vyuab/oWzoNB68XfJL9bIK29027Qfo97SgI2LUaxyv3R4LAklfUlBR8TdSBLIAxhM5LoINf+59i6J8U9wKGe4fF/SXV1+n3Aj6I6NSJZNLjjmGknfVBEUVTlaBLeJ7Ec6XDEvFZ+FFDVnJty8w95g3a8dElekd6WSbBkmC/DU9BjVuroA0WjJSyOLQeRSJWs5dAFCSZy1GoxCrGoL1DmVBDJKEAuOQnB4AM67YB/8gbwD565PYA2EhCiiIgtcad/WYyu0wIKd4MEaGCUxL8zheTCGMeEnoAGvMo8V3HFyXbZGMddJ0LIh+QIo9geWbp25VkcRjSIZ4KUq2GF69mO/z3O9OPNyb99x0+jytNwizA9aLv2Eexv2sor5ky6EYJWBHxBDcRkM+uQCf5Bx+zWg+Ztw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(2906002)(5660300002)(44832011)(8936002)(316002)(54906003)(4326008)(110136005)(70586007)(70206006)(966005)(478600001)(45080400002)(8676002)(6666004)(40480700001)(426003)(36860700001)(16526019)(336012)(26005)(1076003)(2616005)(40460700003)(83380400001)(47076005)(81166007)(36756003)(86362001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:37:02.0342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ebfa90-00a1-4f7d-35cc-08dbeb926698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on comments from other vfio vendors and the
maintainer the vfio/pds driver changed the reset_lock
to a mutex_lock. As part of that change it was requested
that the other vendor drivers be changed as well. So,
make the change.

The comment that requested the change for reference:
https://lore.kernel.org/kvm/BN9PR11MB52769E037CB356AB15A0D9B88CA0A@BN9PR11MB5276.namprd11.prod.outlook.com/

Also, make checkpatch happy by moving the lock comment.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 13 +++++++------
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h |  3 +--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index b2f9778c8366..2c049b8de4b4 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -638,17 +638,17 @@ static void
 hisi_acc_vf_state_mutex_unlock(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 {
 again:
-	spin_lock(&hisi_acc_vdev->reset_lock);
+	mutex_lock(&hisi_acc_vdev->reset_mutex);
 	if (hisi_acc_vdev->deferred_reset) {
 		hisi_acc_vdev->deferred_reset = false;
-		spin_unlock(&hisi_acc_vdev->reset_lock);
+		mutex_unlock(&hisi_acc_vdev->reset_mutex);
 		hisi_acc_vdev->vf_qm_state = QM_NOT_READY;
 		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
 		hisi_acc_vf_disable_fds(hisi_acc_vdev);
 		goto again;
 	}
 	mutex_unlock(&hisi_acc_vdev->state_mutex);
-	spin_unlock(&hisi_acc_vdev->reset_lock);
+	mutex_unlock(&hisi_acc_vdev->reset_mutex);
 }
 
 static void hisi_acc_vf_start_device(struct hisi_acc_vf_core_device *hisi_acc_vdev)
@@ -1108,13 +1108,13 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
 	 * In case the state_mutex was taken already we defer the cleanup work
 	 * to the unlock flow of the other running context.
 	 */
-	spin_lock(&hisi_acc_vdev->reset_lock);
+	mutex_lock(&hisi_acc_vdev->reset_mutex);
 	hisi_acc_vdev->deferred_reset = true;
 	if (!mutex_trylock(&hisi_acc_vdev->state_mutex)) {
-		spin_unlock(&hisi_acc_vdev->reset_lock);
+		mutex_unlock(&hisi_acc_vdev->reset_mutex);
 		return;
 	}
-	spin_unlock(&hisi_acc_vdev->reset_lock);
+	mutex_unlock(&hisi_acc_vdev->reset_mutex);
 	hisi_acc_vf_state_mutex_unlock(hisi_acc_vdev);
 }
 
@@ -1350,6 +1350,7 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
 	hisi_acc_vdev->pf_qm = pf_qm;
 	hisi_acc_vdev->vf_dev = pdev;
 	mutex_init(&hisi_acc_vdev->state_mutex);
+	mutex_init(&hisi_acc_vdev->reset_mutex);
 
 	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_PRE_COPY;
 	core_vdev->mig_ops = &hisi_acc_vfio_pci_migrn_state_ops;
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index dcabfeec6ca1..ed5ab332d0f3 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -109,8 +109,7 @@ struct hisi_acc_vf_core_device {
 	struct hisi_qm vf_qm;
 	u32 vf_qm_state;
 	int vf_id;
-	/* For reset handler */
-	spinlock_t reset_lock;
+	struct mutex reset_mutex; /* For reset handler */
 	struct hisi_acc_vf_migration_file *resuming_migf;
 	struct hisi_acc_vf_migration_file *saving_migf;
 };
-- 
2.17.1

