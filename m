Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFA7CB8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjJQC4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjJQC4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:56:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0645AD55;
        Mon, 16 Oct 2023 19:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnWldzLZH9o0IOiBTvU9PRpVhAn4mjBq4JPGsoNHney2hBZb57K7KdDEKz8mowebz5/p+A4cldpRE07fxxp0o7WxBC/xopBi9RSfx7896XUxOrpDjETXEzfm2VGz7ifrCFATDHb4ffm9NC51HVOFhAjkAyKqcjIlwFP6j71vx4P6KPMjhRxPMglQos6plAanGR0JlBJBMDrmF95Qv/4hiIWCYnw4kVA2GF4Lx3gePy2mBcB2P88buRR8IeL6R2gkm6beGmzhNR1x6VwMoK6rMJoUfKDL82WYQ64DTlJNtLgoB3jnu52K8WOPCl0VmdkS/rz5vCiGlvXsssvOJ3V70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MlQ3ji7axkBtYfpK9cQJg18jCHDVtYXaYYRO6KlaSs=;
 b=OzQUD1irhjJgLJgPja4Wq++4ohjHZGKZuDD7J77kPp7EnZzFwAE771zXscCeP+va7i9IWMcg7TLQuR11oETZL97VbtZ+3ZoA01uytK2z7/XtZ3h3+H9HJtgpjg/EUxViW1SWHfVMD4IVut175oLDiwu9YYK0nAR9ev+uCjj6sdMZs6EH9cZEF1lUGHQ+ZJOk/tpESYK7QpiqhY7jRUKyfWXieptdKmrl1QIyIRY6FqdUx/h9r2g6IUZOHQhqJNekMzALOQJogtBrB70AmCR+cO0xu9XUyO5ywpKL5XC5kb99yKxTbrpG9Q5AzstRDtITlGIrKK2n9sfWrYFw3CuOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MlQ3ji7axkBtYfpK9cQJg18jCHDVtYXaYYRO6KlaSs=;
 b=fOLfoz3NiOG2BdLB/rpdLC/z+ANDDTWyub9KTPQxUXYwwnRq2x6pXmztmR+zxN8BkUnM/lTiPN3p6CRTcMPkQs3Td60xovzk+1Lr6O6IuMEhiWFo3XGbO+uDfdjdF0td4QnauU+m6GUdYeu/4Faxl5p0+5CIIlI6clrS+Ak2JKI=
Received: from BYAPR04CA0036.namprd04.prod.outlook.com (2603:10b6:a03:40::49)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 02:55:46 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::50) by BYAPR04CA0036.outlook.office365.com
 (2603:10b6:a03:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 02:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 02:55:45 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 21:55:40 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>
CC:     <majun@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Evan Quan <quanliangl@hotmail.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v12 7/9] drm/amd/pm: add flood detection for wbrf events
Date:   Tue, 17 Oct 2023 10:53:56 +0800
Message-ID: <20231017025358.1773598-8-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017025358.1773598-1-Jun.Ma2@amd.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: a1729c32-3924-4154-ad13-08dbcebc8f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwQ/+YaFMMt5cRQlaqBvffUx7/wDJk0U1bFaYGlbJ+W9zEohgxgUU73o07RcAtKA00w0OJy1+JewX2cnK4hgvOU+Oc+B6L5R/1SvGLsgYUGpOtUG5j9TFn8aDhfwNYchy/Q05aZYnqK8K6Rmrzu5DOLk6c/Gwqb0RnrOvYXzYRF/cRRoZlp2FQm0dI2ii0fm3H7fqO7tYdQ7yfCpPSnmU1tN/BQ70nkdeihg8q3TYN8XVt4XvKOUWXsju5NUOE/kpiI52iHFqpm8jILpWcnOLYjzEffBUJfrcaUQEA7EIdeZIfF9ZYpoTBBWOIWVE429M0AbRoheS5szrcJXAH5bQmNNgl1e25SeUuRWtF7MAi+534z2CJuoqtNLlLYZDRxewirT8LFN81cMGl/BDpqwaD8xI2Dv8DAYKDu2fZtMqcz4g7frcAyDuc2yoWdXNUDC3K83KkDBnLLLWPVEHtwjvcc3WTajYAmQ6MfzMmw/FFayaoY1pONwDgAPA+fRtQbnUCfyTxrVaD1GTulxsKbI6/A083euVA7o0kaAtWlBekbphKB6FNi1jDpZ16zgHSNwZPWuHK9owFfkmo90HRtAcmLcr69WNHCnsaJ21ki8OlDoFPt7WMxVxvxSfORrM2u66Yk1AYPtkEnSfOGZ4MDD3Huj1aQviJDfqGgoNI0KDUoUW7lhyzprI3VtxFrul4YaD5ZImYekAxFUefyUjJaA8fcztanSUz3930y1NfgG4Fqua9I+tPqskhQZ+E+hTKHLkuaeIFEIFbOXjsptqTaQDgCRK9kNgVT7qHe4kYU/5mg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(6636002)(478600001)(54906003)(70206006)(70586007)(45080400002)(316002)(426003)(1076003)(110136005)(336012)(2616005)(16526019)(26005)(6666004)(36756003)(7696005)(81166007)(8936002)(5660300002)(8676002)(4326008)(7416002)(2906002)(86362001)(41300700001)(921005)(356005)(82740400003)(36860700001)(32650700002)(83380400001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:55:45.3680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1729c32-3924-4154-ad13-08dbcebc8f38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 31 +++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d52cd7ed2868..b470f7b7c91d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1319,7 +1319,8 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
 
 	switch (action) {
 	case WBRF_CHANGED:
-		smu_wbrf_handle_exclusion_ranges(smu);
+		schedule_delayed_work(&smu->wbrf_delayed_work,
+				      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
 		break;
 	default:
 		return NOTIFY_DONE;
@@ -1328,6 +1329,21 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
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
+	struct smu_context *smu =
+		container_of(work, struct smu_context, wbrf_delayed_work.work);
+
+	smu_wbrf_handle_exclusion_ranges(smu);
+}
+
 /**
  * smu_wbrf_support_check - check wbrf support
  *
@@ -1358,12 +1374,14 @@ static void smu_wbrf_support_check(struct smu_context *smu)
  */
 static int smu_wbrf_init(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
 	if (!smu->wbrf_supported)
 		return 0;
 
+	INIT_DELAYED_WORK(&smu->wbrf_delayed_work,
+			  smu_wbrf_delayed_work_handler);
+
 	smu->wbrf_notifier.notifier_call = smu_wbrf_event_handler;
 	ret = amd_wbrf_register_notifier(&smu->wbrf_notifier);
 	if (ret)
@@ -1374,11 +1392,10 @@ static int smu_wbrf_init(struct smu_context *smu)
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
@@ -1394,6 +1411,8 @@ static void smu_wbrf_fini(struct smu_context *smu)
 		return;
 
 	amd_wbrf_unregister_notifier(&smu->wbrf_notifier);
+
+	cancel_delayed_work_sync(&smu->wbrf_delayed_work);
 }
 
 static int smu_smc_hw_setup(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 39c1620d68c9..d396a18fe0f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -480,6 +480,12 @@ struct stb_context {
 
 #define WORKLOAD_POLICY_MAX 7
 
+/*
+ * Configure wbrf event handling pace as there can be only one
+ * event processed every SMU_WBRF_EVENT_HANDLING_PACE ms.
+ */
+#define SMU_WBRF_EVENT_HANDLING_PACE	10
+
 struct smu_context
 {
 	struct amdgpu_device            *adev;
@@ -581,6 +587,7 @@ struct smu_context
 	/* data structures for wbrf feature support */
 	bool				wbrf_supported;
 	struct notifier_block		wbrf_notifier;
+	struct delayed_work		wbrf_delayed_work;
 };
 
 struct i2c_adapter;
-- 
2.34.1

