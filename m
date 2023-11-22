Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF757F5096
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKVTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKVTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:32:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D419D;
        Wed, 22 Nov 2023 11:32:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFh1iUnHmVG9fM/Tidmt32bYq1K9yyhF/cd7Nld5KUsKd7DXwV7zzPC/PEJ4CGk1H9MTE4eQYWPGWUuH4fBo/adjM36/BPksBJPjAbJAAhLVwWfGFrEJQpkLRQX5AuLQn+OeJhUq+o4URuPCaZ0BrjJkCwYWLBQX0Yw2CYZ1TnSa6kBzm0cz9Xh6GftAjcLSryy6ouq9mIRmkxxsgOw17dsPnmyad0WIOwAzx5PMwYH0EaPRopOlPbQd3W8jXtExm93WrkxLy4GOFlumC4kRTmqyTXGT1OI0vpBvU8CtHBwpjKwcsPXFnPYuTnhvObTczDqAd22bDopmEkeLEJsQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcw8ubx4/O/7VVkvW5lGzzS4CJMRXDnsGILAAGYHdLc=;
 b=Xfl3QFAud0DloKzQhUDpBcvKrjMNgX1o8CfrCpJlckAN4OKs3eWtjV9qg1o/2gATnQXnWdR892wb/9rdiOlEVsbbOfeE8XZ0tGbO0ClZRr5eBKH9JSKYUUh7eLvtExZ1kkaIpmguf7e9fz5nzq3YZLYk1whW63a6Hxinh2X1ZKBDRvYbcpd58dPIqES+YfxIh16TIvYFg52MrQpln57+wi+Wd7tbAqlhJBsJxvPmTT+lpQx53zRviMDYTQbmN46ZlJN7BSNweAgR0ui/8y6Q9nY0fBZfpUFeK3FderjyyAcolN9eaBcs7BgEE9ikjQddNUv62Yf5KJSEsV5DuoaT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcw8ubx4/O/7VVkvW5lGzzS4CJMRXDnsGILAAGYHdLc=;
 b=hTprqL5OW/zSD1GqakINLUvQwOCIB/TEXieBKGuuke3XTyhA/dlKcur1bte+Eck7BCLIzH0g3uwEld6y5+MqzL2MH0Pdf4aOLcZ+TF9j8atOWsNMQKWDlUlUs3lYfojHvRCb7ldJO8nnIHnnkQvjG5VLMp1JjtDrfohis1hb7PY=
Received: from BN9PR03CA0854.namprd03.prod.outlook.com (2603:10b6:408:13d::19)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 19:32:43 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::a) by BN9PR03CA0854.outlook.office365.com
 (2603:10b6:408:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 19:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 19:32:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 13:32:16 -0600
From:   Brett Creeley <brett.creeley@amd.com>
To:     <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH vfio 1/2] vfio/mlx5: Change reset_lock to mutex_lock
Date:   Wed, 22 Nov 2023 11:32:02 -0800
Message-ID: <20231122193203.26127-2-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122193203.26127-1-brett.creeley@amd.com>
References: <20231122193203.26127-1-brett.creeley@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: a5865340-9ccb-41ca-dda5-08dbeb91cc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzUs0bSDDnUpkLBE7y2dPNO4VHYtHHUBJENCCeeFlNmKfB6TJJ1CyXunw/dLCHAtcqTAJb/WJJGC+ZQNWsJUfqkUvu6rHtR+1Wx2P8/zn8jzqjv8KucgXmq/6efwVF/aZMx6fMTC3SM05vp3Xr4MZkJTTgzhFIyaBeueok9pzIUgsMjL7T4217QPa6RRX7OyuWudzy93zmyHT9iClwK5kYdY9JE3Bpf2EKf5F1YaKo+cDP6SmzVCGYY252XphQSAMUELONhjWIkqYKZ7FTVJsUU8pszcb3/g9taEXgl4XHURWQV7z5rzuCFE07UJ7J+VsKCXseze5WQGEevBupP6kFelzf8ZMyvzF+oI5T7vigkHwmQAtl4VZ5d8RiQyHiHBwj2N9xyOnHuDbgJC4cnUOWPtJGWLZoHEO2ylVINiW9GdQydU5kiVdKYPfMWY6L8y9e3CWr/uoXHEjVrM3CSYioheclh8dxjaSjdNRBpoTkf56wOsg0ZycurWZmX9AMzBF31BERtwyU2kjAdhpBf9n+Edd82GgNvbvGYnS1gJwtf+GuZruI+rw6dxBGkN2y0rnaE/7wiEMy9CEy4HlWHsuzXNjr49il8g3hTZQEG7jxrD+5dbhIaZMnRdd4rjCEG2zakAfBm60NrYI6J9BZSPRlbM0bhAMU0Z/4SAqT/K9xZOJSzFJl9yD0ZfvGoCAMWrHwDWky0GoshjS8MpriEc1rMs7EHQIr9Gi3iDt2WCl3PG5VuC7UD1vNeeGn3KR6WYQbzpg3/OBDFGBAvwFc7fNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(316002)(2616005)(426003)(336012)(16526019)(1076003)(26005)(36860700001)(82740400003)(81166007)(356005)(86362001)(36756003)(83380400001)(40460700003)(47076005)(54906003)(8936002)(4326008)(70586007)(70206006)(110136005)(5660300002)(41300700001)(44832011)(2906002)(8676002)(6666004)(40480700001)(966005)(45080400002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:32:43.1102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5865340-9ccb-41ca-dda5-08dbeb91cc32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
 drivers/vfio/pci/mlx5/cmd.c  |  3 ++-
 drivers/vfio/pci/mlx5/cmd.h  |  3 +--
 drivers/vfio/pci/mlx5/main.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index efd1d252cdc9..5cf68ab2bbd7 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -202,6 +202,7 @@ void mlx5vf_cmd_remove_migratable(struct mlx5vf_pci_core_device *mvdev)
 	mlx5_sriov_blocking_notifier_unregister(mvdev->mdev, mvdev->vf_id,
 						&mvdev->nb);
 	destroy_workqueue(mvdev->cb_wq);
+	mutex_destroy(&mvdev->reset_mutex);
 }
 
 void mlx5vf_cmd_set_migratable(struct mlx5vf_pci_core_device *mvdev,
@@ -238,7 +239,7 @@ void mlx5vf_cmd_set_migratable(struct mlx5vf_pci_core_device *mvdev,
 		goto end;
 
 	mutex_init(&mvdev->state_mutex);
-	spin_lock_init(&mvdev->reset_lock);
+	mutex_init(&mvdev->reset_mutex);
 	mvdev->nb.notifier_call = mlx5fv_vf_event;
 	ret = mlx5_sriov_blocking_notifier_register(mvdev->mdev, mvdev->vf_id,
 						    &mvdev->nb);
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index f2c7227fa683..1cfd126724a2 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -183,8 +183,7 @@ struct mlx5vf_pci_core_device {
 	/* protect migration state */
 	struct mutex state_mutex;
 	enum vfio_device_mig_state mig_state;
-	/* protect the reset_done flow */
-	spinlock_t reset_lock;
+	struct mutex reset_mutex; /* protect the reset_done flow */
 	struct mlx5_vf_migration_file *resuming_migf;
 	struct mlx5_vf_migration_file *saving_migf;
 	struct mlx5_vhca_page_tracker tracker;
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index b6ac66c5008d..689edfd750e1 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -1284,16 +1284,16 @@ mlx5vf_pci_step_device_state_locked(struct mlx5vf_pci_core_device *mvdev,
 void mlx5vf_state_mutex_unlock(struct mlx5vf_pci_core_device *mvdev)
 {
 again:
-	spin_lock(&mvdev->reset_lock);
+	mutex_lock(&mvdev->reset_mutex);
 	if (mvdev->deferred_reset) {
 		mvdev->deferred_reset = false;
-		spin_unlock(&mvdev->reset_lock);
+		mutex_unlock(&mvdev->reset_mutex);
 		mvdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
 		mlx5vf_disable_fds(mvdev);
 		goto again;
 	}
 	mutex_unlock(&mvdev->state_mutex);
-	spin_unlock(&mvdev->reset_lock);
+	mutex_unlock(&mvdev->reset_mutex);
 }
 
 static struct file *
@@ -1372,13 +1372,13 @@ static void mlx5vf_pci_aer_reset_done(struct pci_dev *pdev)
 	 * In case the state_mutex was taken already we defer the cleanup work
 	 * to the unlock flow of the other running context.
 	 */
-	spin_lock(&mvdev->reset_lock);
+	mutex_lock(&mvdev->reset_mutex);
 	mvdev->deferred_reset = true;
 	if (!mutex_trylock(&mvdev->state_mutex)) {
-		spin_unlock(&mvdev->reset_lock);
+		mutex_unlock(&mvdev->reset_mutex);
 		return;
 	}
-	spin_unlock(&mvdev->reset_lock);
+	mutex_unlock(&mvdev->reset_mutex);
 	mlx5vf_state_mutex_unlock(mvdev);
 }
 
-- 
2.17.1

