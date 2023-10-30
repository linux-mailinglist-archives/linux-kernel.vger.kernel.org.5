Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ACE7DB41E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjJ3HVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjJ3HUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:20:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB41B5;
        Mon, 30 Oct 2023 00:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB1uyYnqPX8CqBplQLukywwQqhf1GhurG1Rdcy2XFByp0sIPjoWYjtew1L2joXZRkVt72oznNvczSvDyj1opzCsw8iNbeKn7u9W85P7SEVAUV++hoJGt1VpSOWr5cCdh9fe/Jz323kKZaZQSLGow/PJr7SYUC8lABmO9JuYr3Y74PcmkMDd0AoEkppVdvL9EJ9nKCaRBg3vS7el1ColjogQSe4GCylPFusKdJY6DzxI+42T7p6REcNU7OrHDcp3NJruso+S4L4N0wCCjf55O5l+uxZ1kEGdWxjiaqmoGheFo273AkaHg2uBV1iU4u3riDzNtOUUNIqcWKmNXsczS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVfFf0p+8wgOM9uC4lch3z24GlPHt/hE37lsHB8eMOU=;
 b=mTpSoxOqctG6k0IbBEDbsDRGj47P9XvkTjPXKIW9S8t0KGl1VGGQuXUjbyDKd8SoOXgrWlOOav2HYxJKos4IBF42bbe6VW3HjmMdFIPV+et5e2mXHmip9rxcQQ4KRs2HTc5KuIg+CyZHcfOkhoObxWGGjKrbIIT/iKlqhejThf4RB4ndAw1Vw5ctBy+hJfSz8P96/QZAxPX9cOq/1qeV+pchD0cbe0/kyTH+kXyL6DGNIK8fONt2e3t+BxGqKFRRTHWDO0kSMMP/VCToOjsuwN6dxdU6RbVtCNmGiTIIIE2kR+p1RG8zk5FzPPGPRoOFT7CiXl6daGBKUDsYP3PhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVfFf0p+8wgOM9uC4lch3z24GlPHt/hE37lsHB8eMOU=;
 b=oB3N5h3bZj9hzxC0npsyttx3/VaH9E0Uy6JoEeDQ4P6DJhmraPzPwewP/Z+cyq9zUCSMfo5KsRrDKWBGb9g0MuMMD3FLsJE00gd9Wqu35fi5w9opppsedSdQdBCW8oXNv7mWdhRo7MgDF+/B+/FqD56Sgrta2ScfauGN6YRwNYk=
Received: from CY5PR15CA0190.namprd15.prod.outlook.com (2603:10b6:930:82::8)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 07:20:15 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::57) by CY5PR15CA0190.outlook.office365.com
 (2603:10b6:930:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 07:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 07:20:14 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 02:20:09 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [Patch v13 7/9] drm/amd/pm: add flood detection for wbrf events
Date:   Mon, 30 Oct 2023 15:18:30 +0800
Message-ID: <20231030071832.2217118-8-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030071832.2217118-1-Jun.Ma2@amd.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc9f035-230c-41f5-2561-08dbd918a92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GltRWmZoOIuD6HxuakJSZMPj4YvSl2TEVqQW8qIwjQSHVpxPgHryD6E54lJVczvHLadHDQDujlW//kK9/IceYstVVBlo9uoY/v/EIEOE20nUfbt9WtSVjTRivHw3+RzYUSRBFSe6pkJdwxUzX3nFqY54SPZPzKcnGY/Ma1M6D82X87m2AjhcVO0MUmeMN1yHRDznXbYeydbw7YSDWL00oUzMaYsCKcg7pi6C+bsv0sLjBQkBsCmIOEC44PTgMyF0iTCpqA5ClupA/QUKn/SK65QNV2GwTCbcO0Y11Dem8OCaAjDiFTXkDh207PN9JrYfFcdJwQ5ecH8Jl9zMxgv/E2/UYMF5sZWf1+d4o7ExNLIVg3FmQVKzdcCAp2ABVr/0zsY30vETJvntQuqvq0QFsxHYIO7zk2e4S7NKX62TkamSW6gDKTmlQS7HlnZbxlTckj+wPjgYxpkktsoVmfHSi5fEUYqtJkc8FIiZ3PkEw8MTf0gCV6ro62vAaGT1x33zPD3EJ7E4f3zPbfTYQ/RnwppeTy5z812fL6RH4RLfe9joR5OW1fp60kwYQCEoU/xw3eBHd5+nEYiXRIDMk/MUQbeEBj/rWk8afqG/Uktyzr5djo8U+SR+CCEc5XRjimYbQuI7LMqVTTqnd4UfCcN627rl4Jfiw6UDpsIci7V2FeDhy+UqHqraD87kOS7s2xAyL4EqKp6JFEvgbymr3OjJW5h2B9MZXT3zr7DPnW64Swxs2aiSV34tpe0qdAPiVF/rEu5jRB814EAxHXXUFojkuQS/vsQz3v1YPZJzaJqkUnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(40480700001)(40460700003)(1076003)(83380400001)(336012)(26005)(16526019)(426003)(32650700002)(356005)(82740400003)(36860700001)(81166007)(70206006)(2616005)(70586007)(316002)(110136005)(5660300002)(7416002)(54906003)(4326008)(8676002)(8936002)(6666004)(7696005)(41300700001)(2906002)(478600001)(45080400002)(921008)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:20:14.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc9f035-230c-41f5-2561-08dbd918a92a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 29 +++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1553e175019c..2dbfcd7d0ef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1316,7 +1316,8 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
 
 	switch (action) {
 	case WBRF_CHANGED:
-		smu_wbrf_handle_exclusion_ranges(smu);
+		schedule_delayed_work(&smu->wbrf_delayed_work,
+				      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
 		break;
 	default:
 		return NOTIFY_DONE;
@@ -1325,6 +1326,20 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
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
@@ -1354,12 +1369,13 @@ static void smu_wbrf_support_check(struct smu_context *smu)
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
@@ -1370,11 +1386,10 @@ static int smu_wbrf_init(struct smu_context *smu)
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
@@ -1390,6 +1405,8 @@ static void smu_wbrf_fini(struct smu_context *smu)
 		return;
 
 	amd_wbrf_unregister_notifier(&smu->wbrf_notifier);
+
+	cancel_delayed_work_sync(&smu->wbrf_delayed_work);
 }
 
 static int smu_smc_hw_setup(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3a183e73e9de..5e62b7474c20 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -469,6 +469,12 @@ struct stb_context {
 
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
@@ -569,6 +575,7 @@ struct smu_context {
 	/* data structures for wbrf feature support */
 	bool				wbrf_supported;
 	struct notifier_block		wbrf_notifier;
+	struct delayed_work		wbrf_delayed_work;
 };
 
 struct i2c_adapter;
-- 
2.34.1

