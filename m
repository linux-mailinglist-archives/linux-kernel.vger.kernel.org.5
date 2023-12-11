Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7348180C5C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjLKKHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjLKKHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:07:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1C7F2;
        Mon, 11 Dec 2023 02:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn3I4gqlB/G0nsrOwagfYBCSXsQqcyIZVJVNtRkcxJqr4RyZB8JkxZFhw+lIR1I5J0BW7OOP2iW+aO+AbWeK1mnXCV6eczFTt8g9L/7keeuQQNDRqFKrNf7NA8Xr7+aSXL1KALvJX1K831P34etLrBrHAme2zhnN9hwvHGkjCDFulCHonPx2pnpaMRofOumnGtHErPB9V5gqNN8NUc+7ESqvPsF73QvjkpQguCbCe0OKxFj5bda2K6FgS9QlO7Pq/TNDuGU4uX+q40BzCe4l4RJzTzgaWUU1yh8ef/pFG8g/jCjWFvmrngk7WlYFJ/jc9qn9TBt2svZkZh3cGQ72fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq52/BRhNMPrtOhKdplDpcYxEvdAoNh+kljaM8Q1FZk=;
 b=AoWQx6fGDeEwd8A5yzggwpldEFeQPafxiNWINT0ki0gtQg2u68EUkiBfUuawci3f7FbonL/PuxFD179WzeuxsG8URzppxyqBRO2QZQXAy4pJ9xhG0obgmqRJn6QJdl3itSUOE9E7nq58LAplJPsh6ZFq+B+THqWwnrm2Xxr0vbH4dGsZJqA6IJAilG8+qYN+9m7l3sriAjCBgNJ+0kUmtT5Yoiqs23CuP6wFe2DLGR8TfEU5IYNPXxRe33FxDTCAhwCBPNPNzULaDgNFLxf5cn9eXCSe9roRFLAvK38mNGmHtktZzq63ANtLVlKSFSiunoAIZym+wMOF+a07u8yd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq52/BRhNMPrtOhKdplDpcYxEvdAoNh+kljaM8Q1FZk=;
 b=T1zDmIr93fYvmKIeP5kHkxkseoMAkYSrzSb46TBQ0H4f0TNAsv/W/aQ/H/C39efrxzawOfMFVSmoUNu0719h8YhdEaxBalse8wu68Sgoo1VeLtmGyFX6S6nYSVLxKM/Zykb7YswLC2f/LQOAqlfzJB2HHJC7QbJj6UaT7svExXI=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:07:41 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::e2) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:40 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:07:35 -0600
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
Subject: [PATCH v16 7/9] drm/amd/pm: add flood detection for wbrf events
Date:   Mon, 11 Dec 2023 18:06:28 +0800
Message-ID: <20231211100630.2170152-8-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211100630.2170152-1-Jun.Ma2@amd.com>
References: <20231211100630.2170152-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1294b020-99f6-4bd6-5093-08dbfa310295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg4zaXPnMGj0q/OnznlYEBYQ62sWW4+llmVxzfzCjrzzPipfif5lG/+Kvk0Ce9pQNdBsXlWq2UlwH+3ha7ZPK5387MBc+rKWCAG9wkLVJ6McBP/UIJ/uAuOh1nlHYJSQ6kmfNDAoarMkwPO0cVdFBBiMzIqj/hv9jg96NbZ6J32qmVNNEu3gs3HZATn4n3E+BgOCL8UDDKTMMme8ZVsH5Q6BnrSy5BO5ES6IM7vUDW5L9/VpHetWEExkz4C5tUZUEokraGhQ472xGZ6FumvwzqRfG1xeoo8N7XAwrIBjeqVqQEuH2mkB3b7YFJZSz4HONT9Kis4hpOl56FuWtX2kN8EoMwiVFD3qwRe1t7lnOD0BxkeqMP4Hm61WeQgUGjulq7c2WpVo3AbKHDNR+INmG5lgtalSl6LPt9CEcynw/0xWSzp5n/1T/NLq40BuBt+9HocP0PUrhYNERvsmLsbTPIqL1La8wpYnHPSjRw5Dtrm/Cz7n2v97gtCGgOLwRH71Y7rxX1iLq7xVyVU3qnDB0Vdv4Ujj6SJ/1SjFaDM8aHWnkpm7m6NQufR4bDJV5j1kAqCsdll31gtwj8VovFl0gMYOARsaH7kBB6tYHGHPC/4PDFIOHLPh5hMDoPJDBocuAaB0da5ZwjENk+twFY/PIXKU09qRNGkrUqHhbI8Vb5wiOsc67H2EPIV2Eu4UzZwoW3g6iNXemaCzAcunVCBAXpPZ+H5oq/5GtLx/YyFI9vYIlhiEw6p0U922Tnrk6thU+hhsPGWJxg2xkLsbkaU5XgfWV4z3s5aYW7/aM/NfVXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(41300700001)(32650700002)(36860700001)(16526019)(2616005)(1076003)(426003)(336012)(26005)(83380400001)(82740400003)(36756003)(86362001)(921008)(81166007)(356005)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(45080400002)(7696005)(6666004)(54906003)(70206006)(110136005)(70586007)(478600001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:40.5176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1294b020-99f6-4bd6-5093-08dbfa310295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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
index 2c7507cf256b..7049fa5c9cb2 100644
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
index 620e53cc3a61..24032c5bc883 100644
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

