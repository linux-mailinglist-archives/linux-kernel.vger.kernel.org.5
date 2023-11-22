Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D297F5086
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjKVT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:26:30 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3741100;
        Wed, 22 Nov 2023 11:26:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWfKT69NiGN3IqTeAjsx5SpQnE0PESn98grC8m2e55/Lq5odEtEqHlWoLJWbiaQaDoO+kexfu5kZuGxzBrcZzcQ1kQSMIyj8btmIu5IMXI7Qw/RqZNS6x/65BaeF9F9hiYgpp3yv947bkXdvcEmJnGIJxYh+J089y7PWwwV5KOhhecVNUSVxGljRJobMzVz3ph6dZcsob2StVoCI1LqXYXpIGmoFOeZQZK9w3BXE1211g6z+gIlPA9FwGNSj/nHUrbdKOd4bQM7zjFx3+UCI48Looac1hDz2oKBSJUdtO0tWzLC6aI+J1EPQ54iB6E6RxMmoxTPUi9ZbOwQdQS/x+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5A5O4LEZ45C3U68dW1Id1scqawqLF6Z+fPLRd6MNdY=;
 b=klZwKV8BQrIHdeCrJcs7RNOGZRy3AKw0LHtfw+LgCTw2Q5WozMHBVPGrcV8Gt1Z1V5AzVdbZ3V13MFbX9p2Z505guO6os2esD0Tq6Yf2vnw+shfmUCma3slleoW3vCmBTcjmPQ7L8u/t8fi/pgU8MTxGq6K5bnJ62f1RpZz6PFAzlf+5ujH0VHgdelIpbrXJ8ikbPSeNYC8B9l6r7QUrgP83Fu1IB/lzlLUYdIcdxSsq0San+Z0kACWQlhMD1Zd8rSyNpYxyNeF4Kvp4ahL0AsrHjzvbRtD6+xkzKMd07tQpbyYcXGiLiSKxqLd0Vfx5eb4xTcEId/WKVZzFpWMy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5A5O4LEZ45C3U68dW1Id1scqawqLF6Z+fPLRd6MNdY=;
 b=XIOtIeEt9zNrVS05cEJxoaVVsxmCnqPSbt0PjzkxLv//ZEaH3+zQwHayR8RzzvyZAdFrhlbU6m7c6wKYKrR6/Ow8eqf3BZcZaCWfksZGjeLP51tLC7AxlT4D8StlQXcEuUNndkRz6iLd/JdgLqWnHwP9OtMKUjcTdmG4IUmCyHU=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 19:26:23 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::63) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 19:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.3 via Frontend Transport; Wed, 22 Nov 2023 19:26:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 13:26:19 -0600
From:   Brett Creeley <brett.creeley@amd.com>
To:     <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v4 vfio 1/2] vfio/pds: Fix mutex lock->magic != lock warning
Date:   Wed, 22 Nov 2023 11:25:31 -0800
Message-ID: <20231122192532.25791-2-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122192532.25791-1-brett.creeley@amd.com>
References: <20231122192532.25791-1-brett.creeley@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7b33fb-0c08-4219-bd36-08dbeb90e9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eqveIM8iW2bwGZlRXwxswzMsqors4oUZb82k0TiIlaCHBSGCpb94WJxoC4vyzdWVI6hDSOTJe7ooHubSEEemqcBJvYetoekQr4J6PeC6P4S+70xIUG2hLkMKLBpTkdTY+aqp+UivLxXb/dnhAHnsw2Y+xVRnwiT845VHCKO4x5SB1OqhR0bWcQMNw+Fin3SMb0TmvbXFPYyhHbOQe0BNP/7gYeBxhQzXjMxJ3BMhY4gSK0fgIO0Q5ktkqi8/0h4rQnqpHZO4HpCUO1n6+MoW1u0unkx+5hljpWW03C5VuSLRPzeDoVbgfQJCU6QVK+Z/JxD0yUcjH/YEMU64YgaXz+g6K6eQ75Z7ZYlsgrYJyTiK+lPebVh5NQRMtCyqFioe6pmJGfclb5IaDPVxYoCz+OqgDU8V44QDaW3tu39uHeD8QxHEjC5KYlYAIFNFi1pKghpiT+bCYE0swiH+txCevcxc/1cEGPYpWNyDrK92+6M97I6HCECFVDAz0ppXeUwk0cYx54xPehAM0lS5banKApOcL71a/Ca1XgMVSbEyk2tAjVVMLrspfHG9GNq3xGvfN45yUzRkDipjnvHQsF9K/095Hw2aKhOaYXxvmeToqxF/6HqW2ptRNoDQ2LTW3KzkURszqAD+zHlJJOGdOFyJ/xjpKNb6uUTFPow1/BPpnlc4j40qTXNyi8Utgc2zb/ERIOjgPf1/CLQ4QjX3mZet0GOp1aXmXerHLbWgaMP7AM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(426003)(336012)(83380400001)(26005)(36860700001)(16526019)(8676002)(4326008)(47076005)(41300700001)(44832011)(5660300002)(2906002)(478600001)(8936002)(54906003)(70586007)(110136005)(81166007)(36756003)(70206006)(6666004)(316002)(1076003)(82740400003)(356005)(2616005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:26:22.9205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7b33fb-0c08-4219-bd36-08dbeb90e9b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following BUG was found when running on a kernel with
CONFIG_DEBUG_MUTEXES=y set:

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
RIP: 0010:mutex_trylock+0x10d/0x120
Call Trace:
 <TASK>
 ? __warn+0x85/0x140
 ? mutex_trylock+0x10d/0x120
 ? report_bug+0xfc/0x1e0
 ? handle_bug+0x3f/0x70
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? mutex_trylock+0x10d/0x120
 ? mutex_trylock+0x10d/0x120
 pds_vfio_reset+0x3a/0x60 [pds_vfio_pci]
 pci_reset_function+0x4b/0x70
 reset_store+0x5b/0xa0
 kernfs_fop_write_iter+0x137/0x1d0
 vfs_write+0x2de/0x410
 ksys_write+0x5d/0xd0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

As shown, lock->magic != lock. This is because
mutex_init(&pds_vfio->state_mutex) is called in the VFIO open path. So,
if a reset is initiated before the VFIO device is opened the mutex will
have never been initialized. Fix this by calling
mutex_init(&pds_vfio->state_mutex) in the VFIO init path.

Also, don't destroy the mutex on close because the device may
be re-opened, which would cause mutex to be uninitialized. Fix this by
implementing a driver specific vfio_device_ops.release callback that
destroys the mutex before calling vfio_pci_core_release_dev().

Fixes: bb500dbe2ac6 ("vfio/pds: Add VFIO live migration support")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vfio/pci/pds/vfio_dev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
index 649b18ee394b..8c9fb87b13e1 100644
--- a/drivers/vfio/pci/pds/vfio_dev.c
+++ b/drivers/vfio/pci/pds/vfio_dev.c
@@ -155,6 +155,8 @@ static int pds_vfio_init_device(struct vfio_device *vdev)
 
 	pds_vfio->vf_id = vf_id;
 
+	mutex_init(&pds_vfio->state_mutex);
+
 	vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P;
 	vdev->mig_ops = &pds_vfio_lm_ops;
 	vdev->log_ops = &pds_vfio_log_ops;
@@ -168,6 +170,16 @@ static int pds_vfio_init_device(struct vfio_device *vdev)
 	return 0;
 }
 
+static void pds_vfio_release_device(struct vfio_device *vdev)
+{
+	struct pds_vfio_pci_device *pds_vfio =
+		container_of(vdev, struct pds_vfio_pci_device,
+			     vfio_coredev.vdev);
+
+	mutex_destroy(&pds_vfio->state_mutex);
+	vfio_pci_core_release_dev(vdev);
+}
+
 static int pds_vfio_open_device(struct vfio_device *vdev)
 {
 	struct pds_vfio_pci_device *pds_vfio =
@@ -179,7 +191,6 @@ static int pds_vfio_open_device(struct vfio_device *vdev)
 	if (err)
 		return err;
 
-	mutex_init(&pds_vfio->state_mutex);
 	pds_vfio->state = VFIO_DEVICE_STATE_RUNNING;
 	pds_vfio->deferred_reset_state = VFIO_DEVICE_STATE_RUNNING;
 
@@ -199,14 +210,13 @@ static void pds_vfio_close_device(struct vfio_device *vdev)
 	pds_vfio_put_save_file(pds_vfio);
 	pds_vfio_dirty_disable(pds_vfio, true);
 	mutex_unlock(&pds_vfio->state_mutex);
-	mutex_destroy(&pds_vfio->state_mutex);
 	vfio_pci_core_close_device(vdev);
 }
 
 static const struct vfio_device_ops pds_vfio_ops = {
 	.name = "pds-vfio",
 	.init = pds_vfio_init_device,
-	.release = vfio_pci_core_release_dev,
+	.release = pds_vfio_release_device,
 	.open_device = pds_vfio_open_device,
 	.close_device = pds_vfio_close_device,
 	.ioctl = vfio_pci_core_ioctl,
-- 
2.17.1

