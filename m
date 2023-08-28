Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1378B047
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjH1Maw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjH1MaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:30:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75AB191
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE/nQFONjbWCrPfZuBPzul1WWhdmMIByFOCuK2RdywXDUvW9lIMmYjEvx7DpQSsGr4dFptVyt8/3JiGIRS3+Qd5nXDFAxVgGc0l9mLjsiFzEM7XUMyGPwtob49qe12csAvPnAHLWkOri5HolOwOb02qtbDdNGrqUTVfT0G3FZTbXgA3ZwRh7GnMH0tOU4K2TSJ8lTbwSFNC+7dp80owle8jQWfJKMrfphJ1exOLkuOkR8j2rbwYG9qci0xpuEFkSed1UiQUPbnjJyVzA3+pvIIhPhMfbuDugBI3gemYC0OO9g4GzirrQFEQ/aEoy00NIos/VZMdEeeqvJ/mXuMg8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gVoyx+EIZoho+YFlFtYwxUf8gMbfU5+r/HlOrYPT6E=;
 b=HOekNo4dWx0CYajnnUMxvV3R2Y/5l0I2/40ud0A7Q0iTLWRU6PK3UORsvhUvxpLEZRBRZs1lNgo+32wAucTj2amc2YEd3K3aWsSPfh9wylTQyRJ3HaS1Ttf5bMBO3E1WzHcL6aXPOHb7JJ4TmAUclFd31takH26IRuxD+BGAC8mIkCmqpMXOoXi9ndBDsPriYRyENp7N8wxHJtHa57uaDvpG3S4Tgvt8gy/uiPqXq9fRsytnPGUA55tF9qPcSwzah//DODWKb/rW/yXLud3PV6V5Q5SqbUxbdwaaySOgJ7Gx6N0oc9SKGHP+HtppDWk5VL18ZepwSNEM7jjU5KUG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gVoyx+EIZoho+YFlFtYwxUf8gMbfU5+r/HlOrYPT6E=;
 b=QfOo+lMm+r3pJAXpxJ7XzVHB4OGwSqmXWOv//5zYDhtH+LWT05DUqoQNiMinki14y38i4qgbET35OSEJ7cmFymY1ZWmb3iIMeDYVHY01cmDMMBEwwuJg59RwdEcuhgDNgfgv/PP3R/7UOb8lfDatFbl1KqX0A/NnqjKwluqrVUw=
Received: from DM6PR07CA0118.namprd07.prod.outlook.com (2603:10b6:5:330::31)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:30:05 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::72) by DM6PR07CA0118.outlook.office365.com
 (2603:10b6:5:330::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 12:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 12:30:05 +0000
Received: from rtg-Artic.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 07:29:27 -0500
From:   Arvind Yadav <Arvind.Yadav@amd.com>
To:     <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
        <shashank.sharma@amd.com>, <Xinhui.Pan@amd.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <Felix.Kuehling@amd.com>,
        <amd-gfx@lists.freedesktop.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Arvind Yadav" <Arvind.Yadav@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v3 7/7] Revert "drm/amd/amdgpu: switch on/off vcn power profile mode"
Date:   Mon, 28 Aug 2023 17:56:14 +0530
Message-ID: <20230828122614.3815122-8-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828122614.3815122-1-Arvind.Yadav@amd.com>
References: <20230828122614.3815122-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5e11a1-8f69-4ea2-04d3-08dba7c2821a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pg2e8+ADbnP5ggZg/P46QkglybnWOYmnnae4JGniBsn8OaGlR8Un5Y8ef3oK5fYT8kiiHsozYtGGdCpv9ivecmfRCjSlg07DMwrcZE/qMfhH29/l/s+zXbZUApZSbNN08FWDFm39ZcE1QPJidbOOHfsatjrSxkHuPLs5L33SOHt+vepjYOiZgc2/495M1eC/qO2y6EIqGKB3gdc4FG4XJlgRi8zq/apHj8T9ggzZXr/HGt3hvRx2YULppdx3cBXCf7q+RgQ58nMqw2jZiQyQSnf5e4QTc7wpGQjRwyjPIAWfRutTjZchHZNRb5OmZJtn9LpejDxZ5MmfN4E35M9/8oLaqmINSptBGoZ8SlUJlQw4l7q0HcRLFDONcUA5jNi6Aq6Oa/1OX4NbKkl4wZSCkQTFrvAJHjcDZxSehKdXD3GBD9rBSRLtzxOwLtmaDk7ihME+8M2uP17z5t7lS5IdC+kx/xHH1RVhkAlSpc2KhdNEcS0+U9A6blZ7YBUHVpEl1utIDOM4guF2JZFaIKrf6hcT555WMDJ/SZQwjy7g937399Iv5zqJ2i8FBz1vtzulhb+91SfYJr3D0iWWk8qRWC9Ek68mZlSIE/EKA+//wO1YQ3DzgDF6/OqKWYqnjILhtZlKdBItOZQXFq8N/yobb5/UDs5PutTFTK1z3eS0WGMV0BfVfTGKTP/Jb6mokqZoQtz0AlYNPAXc6lRwZu2e1wiXsLLFJhLNROZIWwUW2OLaMwZ9dpsvbbCMKmSwJG7ZnHnxn41uMXC9F3L9FBZeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(6666004)(2616005)(86362001)(36756003)(40480700001)(40460700003)(82740400003)(356005)(47076005)(81166007)(36860700001)(83380400001)(1076003)(2906002)(16526019)(426003)(26005)(478600001)(70586007)(8936002)(110136005)(8676002)(4326008)(5660300002)(70206006)(316002)(336012)(41300700001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:30:05.0200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5e11a1-8f69-4ea2-04d3-08dba7c2821a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5ce71f59bb9bd3d8a09b96afdbc92975cb6dc303.

Reason for revert: New  amdgpu_workload_profile* api is added
to switch on/off profile mode. These new api will allow to
change the GPU power profile based on a submitted job.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2d94f1b63bd6..70777fcfa626 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -363,7 +363,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		container_of(work, struct amdgpu_device, vcn.idle_work.work);
 	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
 	unsigned int i, j;
-	int r = 0;
 
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
@@ -392,10 +391,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				false);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
 	} else {
 		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -404,16 +399,11 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int r = 0;
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				true);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-	}
+	if (!cancel_delayed_work_sync(&adev->vcn.idle_work))
+		amdgpu_gfx_off_ctrl(adev, false);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-- 
2.34.1

