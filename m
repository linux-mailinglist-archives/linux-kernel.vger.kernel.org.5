Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977637FD220
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjK2JPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjK2JPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:15:00 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F82118;
        Wed, 29 Nov 2023 01:15:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBzKmbr+/cLUOMc82J9cCturc3hOTZ1qs0HOubmfBwf/m+0kLjAMMd//S3XQwXnVrOkh2sL4DrEddjbotzynEmB0PzghMJLhDW3HnwzEUAkIGSVEranhMkhZTkrRmP5sMPIci3eeIowEUlFzYLUFHGuGt28C/dNkAn2haFW1uNUn2GXaJVIO2ln+fafUtXXahd6rnBCPweDIQA5s+4tkIbDIRw29KuAgZqagOGRQjfKHfcyhUcx9TFKlM8SCt8HzZZ0exN6IuKf3L8BeAfSx+6Twa7ExOnpq5uRfPPpgO9uA7JSXvR2TnMHbOR9wBRW70V6qg0LlfyHGJgsbER5Tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck0/Zec1rIA99wezp0Dn6dwNDDI5D2OZnYxse1/vjUo=;
 b=abN/y2HDYdBdErXczUYUP53inys2Cm36PkWGq3B0Mnfu4rFXcnMpi9H3Dn9T84UWvbDzZ78fl9tHJwcBkwT1WcZfh41SN89GBlIp6NOW0s4UqoIobNUfaMhS62HNrIetxyuVbWYwRh7KNs7NEHGJbW/Gqdnd8cwDwhtYA0n6oZg7Qus9fmU0WlsYKUInx1FYgx4RJzh+piPa75A1VFjQtKiFGAbM80g/Gdl0Y++Em26n0QjEqGgShD0uEd4Ux56jDnssWPUQpbNmc1hjwhJVuoOwiZGZ8F1rtIcV3HfSVnhA0G8jPQAw9cYKzzOaweKk5MLp44VeQUl7KuEwTumCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck0/Zec1rIA99wezp0Dn6dwNDDI5D2OZnYxse1/vjUo=;
 b=k5JXo8PvAsYHdPOAVHtIYeIaGW6XTpU2H6/AHch/D7WwQfgAlFeOaMyqnTfzvoCqb5tTAKIGGUQxhyv9nhLon88WeeBATQ1AvBJ4FXep9qLHmMON7p6vl0ZVTe+02z3oVWgFLkRESKz9I6ZXmUPXtIOC7Ix2okz0q9tAK418jyY=
Received: from MN2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:208:1b4::24)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 09:14:59 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::f8) by MN2PR15CA0011.outlook.office365.com
 (2603:10b6:208:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 09:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:14:59 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:14:54 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v14 7/9] drm/amd/pm: add flood detection for wbrf events
Date:   Wed, 29 Nov 2023 17:13:46 +0800
Message-ID: <20231129091348.3972539-8-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129091348.3972539-1-Jun.Ma2@amd.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: e64844a2-b090-4a45-679f-08dbf0bba931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sl9m8+h1dmjxIBlngOIXwJRUGLRngULI0/o6qc3aVLbYy6Xc636BGGo+e7CPcUe2QAqxEFNORM1iNBRpPXOERUM6WJYbiD0I1s/PJRbbTizJA52cNytCH0KwtgErZnkNXbm73hsd2GP7Rp4pgESDgaKBr+PAv+H/mi6VJm56kv7sYH2mbg+tGYtLZb0CVEGkuGobVIfvFJr/lGGXnEkIf3xF0I75VsgwOo/0Cli6LgeuIavxgOqyI/0/UW+C5e8ldbQyNfk+wyyPZcZPliJGOFS9byvJeJunZX3ppRLoCxJzfdZpQHdlb79tPCSOW9XqQ8hO1zIkAijTTPoubuGaUJ0wTSq3MhI3AkmY/RhUKslUR7H+YBsQ/9EoUnbMc4XMX7/Cx4jNNFrdIhpZHgZwCK7N2FztyO7qNvt12LLZCRolCfhB474Lg5Yv1hZn2/HSCcjOGlggWxsyCxgxqfZG9ANNVGkK240IPiNvcoNDE8/4T/xs+HVPntmGuT0rCWWQ6fqYrIOWF4ekheNndrWPgu4ZtZ8oMTnLpwt6ZjPjqFV+k7a2rhp9HlSmHwF9zI2WmQrpzHo8LsaMdLUR4ThTKe86V9zu22yvVLpPY2AuNz1pZjPqFtiFNJWuCeARAx2D/w+jp8S+Fd0pfaaoY3XNdOSmFWyw9hDN20SO0llNlhvRBSGV8nS11fTvqnJDQ6MGvK+XUjYJ/f3tOVmsfc0AWwWDwp1gS5F8bWwwF/k9XqXBroXOyrQHLbeRXa2fDowlJ8djnt/UaxR3xMpYkXEi7xdXD0yyqOVl9B3BzOnKaoc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(40470700004)(36840700001)(26005)(83380400001)(81166007)(356005)(32650700002)(82740400003)(8936002)(4326008)(7416002)(45080400002)(6666004)(7696005)(336012)(426003)(36860700001)(110136005)(70206006)(316002)(70586007)(54906003)(5660300002)(8676002)(478600001)(86362001)(2906002)(36756003)(40480700001)(41300700001)(921008)(16526019)(2616005)(1076003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:14:59.0726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64844a2-b090-4a45-679f-08dbf0bba931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <quanliangl@hotmail.com>

To protect PMFW from being overloaded.

Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 29 +++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a03d0e9961f6..b7ac9a460f3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1410,7 +1410,8 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
 
 	switch (action) {
 	case WBRF_CHANGED:
-		smu_wbrf_handle_exclusion_ranges(smu);
+		schedule_delayed_work(&smu->wbrf_delayed_work,
+				      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
 		break;
 	default:
 		return NOTIFY_DONE;
@@ -1419,6 +1420,20 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+/**
+ * smu_wbrf_delayed_work_handler - callback on delayed work timer expired
+ *
+ * @work: struct work_struct pointer
+ *
+ * Flood is over and driver will consume the latest exclusion ranges.
+ */
+static void smu_wbrf_delayed_work_handler(struct work_struct *work)
+{
+	struct smu_context *smu = container_of(work, struct smu_context, wbrf_delayed_work.work);
+
+	smu_wbrf_handle_exclusion_ranges(smu);
+}
+
 /**
  * smu_wbrf_support_check - check wbrf support
  *
@@ -1448,12 +1463,13 @@ static void smu_wbrf_support_check(struct smu_context *smu)
  */
 static int smu_wbrf_init(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
 	if (!smu->wbrf_supported)
 		return 0;
 
+	INIT_DELAYED_WORK(&smu->wbrf_delayed_work, smu_wbrf_delayed_work_handler);
+
 	smu->wbrf_notifier.notifier_call = smu_wbrf_event_handler;
 	ret = amd_wbrf_register_notifier(&smu->wbrf_notifier);
 	if (ret)
@@ -1464,11 +1480,10 @@ static int smu_wbrf_init(struct smu_context *smu)
 	 * before our driver loaded. To make sure our driver
 	 * is awared of those exclusion ranges.
 	 */
-	ret = smu_wbrf_handle_exclusion_ranges(smu);
-	if (ret)
-		dev_err(adev->dev, "Failed to handle wbrf exclusion ranges\n");
+	schedule_delayed_work(&smu->wbrf_delayed_work,
+			      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1484,6 +1499,8 @@ static void smu_wbrf_fini(struct smu_context *smu)
 		return;
 
 	amd_wbrf_unregister_notifier(&smu->wbrf_notifier);
+
+	cancel_delayed_work_sync(&smu->wbrf_delayed_work);
 }
 
 static int smu_smc_hw_setup(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 84f0f53397bb..b0d85ccb7d8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -472,6 +472,12 @@ struct stb_context {
 
 #define WORKLOAD_POLICY_MAX 7
 
+/*
+ * Configure wbrf event handling pace as there can be only one
+ * event processed every SMU_WBRF_EVENT_HANDLING_PACE ms.
+ */
+#define SMU_WBRF_EVENT_HANDLING_PACE	10
+
 struct smu_context {
 	struct amdgpu_device            *adev;
 	struct amdgpu_irq_src		irq_source;
@@ -575,6 +581,7 @@ struct smu_context {
 	/* data structures for wbrf feature support */
 	bool				wbrf_supported;
 	struct notifier_block		wbrf_notifier;
+	struct delayed_work		wbrf_delayed_work;
 };
 
 struct i2c_adapter;
-- 
2.34.1

