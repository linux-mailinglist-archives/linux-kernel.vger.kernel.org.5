Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC37804A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357686AbjHRD3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357693AbjHRD3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:29:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE54215;
        Thu, 17 Aug 2023 20:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtSv6fNliDkehon22S3hvibPS103afIxwzZAd/4o+cXq7eTcaXO4r6uLosAR+Dpij/cgD6Ju9OO/O7oaHXqJZJvsd0iyRIEqEpOb4vNz5JHCFaQhPW624CyUxSEhMsaU3JoJHO9PibKbg/EqD5OB2SgNYLmQ5IzWgl8GbTg0qUaxdDYmSpjQKhxInWocUNTG0PyuJwNN8dBaUqebzOnC4S0G4Iie1qH+sSXlnUcWdPf0BMiDvNY/QSMQKQhV9sdXAxlRFOX/9l5NAWJAQqt1+psZMCQTQGy92okc5lrDqNkx2eHnXYzWFXPWm7gRw5Ck4f+Q9/MVLSD5KYpxAQO5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8Hscxn8ZgxQps3zBA83N/ExdTvKtToIXJFt9xJw+Zg=;
 b=l7j2s0TkUODRu8LmK8Tx+AaCzUIJj5mPJrNZ18LsTWCsDj/91e+OTQjxZEJIhvwSffdSt70Xn8CseByywKl0w5lstK50TPYwqJodt6cdqDDcxKgh2IxzMEoffiaU4LKRJzEMVC4Sd8GikSisopb6TBg6P9l9rfwgLNNHtIwy8Kw6BamAQonzXAA8E6eTNu3NVurs56emtF8Zv1KupIV652Ss+BSE/wHNX/T050YTGpsDI3bl9Yytl2QdVQKIk4LmonkcSXySgnTMIu42cjNAw3JvKxTl/c26XuRdYAVNbnmx2hxDvWLK2EbYXTLZBkeTdklIqa73ynlVx7u8m4xhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8Hscxn8ZgxQps3zBA83N/ExdTvKtToIXJFt9xJw+Zg=;
 b=PAAgeQ5rsaOrvdja9OqxS1FiuRKFKd1Sz2tHRao/PwbjGnF/pUdpB9i+TLbBwnFscTwLap0IRc59QXMDrMVerPpfi4uuXK9GgEqjsKNEDioAyLVhpJhJTC0Sz2zgL3+2PtbXITLyR18KRlXgVtoiy7Ovot6Qlf9NnsaRiHqCF60=
Received: from CH0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:610:77::14)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 03:28:15 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::65) by CH0PR04CA0039.outlook.office365.com
 (2603:10b6:610:77::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 03:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 03:28:15 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 22:28:09 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>, <andrew@lunn.ch>,
        <rdunlap@infradead.org>, <quic_jjohnson@quicinc.com>,
        <horms@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [V9 7/9] drm/amd/pm: add flood detection for wbrf events
Date:   Fri, 18 Aug 2023 11:26:17 +0800
Message-ID: <20230818032619.3341234-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818032619.3341234-1-evan.quan@amd.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: b53ccf30-857f-4e88-4819-08db9f9b2895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hk3VRESQPh78VaReotmpyLr1XsdBYxP9fcoFT9fyApHqd9zcnXo72Ytm5fSE/TDlbc6PNTzDeVPuxC7kHUAIVNjn2bIvPCKJOM4CN15YsPLcXiif8c6RrZcogqqjvk7sf3lrSX2ZvAlZrSDoR9YwiimcIPqXH2QFW2lYyhJzsoqdffoWaW7ZB1JJg+UfaYWUMlxEqj8qpDuAJeiVR9FRagkvp1GUV8t2qMZtWWxS8THDu94HIDbEO0cBBIARgU/wCkCnI1G91vO7NTrd6dRW4ue/Cddj41QBINMwOz6oqaXIuZcQm7aScre00V/cjEazSxLJSHCcAkmsKTAiKmg75m9AwKOxEHdJ7mJAnxWi2WbqxFE1f+vlKQTYsks3uo1fmRPqZISGH3bzfBgrGVJhN9dxRCT6LagSRUWhyFzHzvqmgZfkiPSP/Lmz1d4Vylfmj+OtpzZkkCFRISjHFmXV/KhWYW3Wwgquqe3wHcFXZzjuMpqXCp1J0BJd1vy6AFqSKlPYcqZ+0G2HMmHefPcH7+k3xfX2FaizdWHIZ+YRAEBZCnOtBT+DGZBBwQpKC/R+H6C+i5dUYdaUEGI6Ekh0FlwH5m6ydTGlN1xn6tgGv6rSh5bTMICu1+0aKAqExy1CSwRLCv6ZXUdJZsFewMo1w8+eY6ClBGLNV4Hel+LQ0nMgppJbaOGQk9irb8gchO8THeCWnXEv2SDBxAlFzgQAFD56CaEE1onry2G8YIE6HkOdyEEhJuCT4b3zh5U/f1qqrV1+u6mZLH2egt68pPM9BRrS8h9ZbniVn7RdhbRbv2JqJcgZYRARmVj10hNnRLAIxka6V1JdjH0QBG8Jwv7BTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(83380400001)(26005)(86362001)(7416002)(336012)(40480700001)(478600001)(426003)(7696005)(6666004)(2616005)(1076003)(36756003)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(70586007)(82740400003)(356005)(54906003)(70206006)(81166007)(316002)(921005)(110136005)(4326008)(8936002)(8676002)(47076005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 03:28:15.2051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53ccf30-857f-4e88-4819-08db9f9b2895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To protect PMFW from being overloaded.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 31 +++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 704442ce1da3..6c8bcdc17a15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1318,7 +1318,8 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
 
 	switch (action) {
 	case WBRF_CHANGED:
-		smu_wbrf_handle_exclusion_ranges(smu);
+		schedule_delayed_work(&smu->wbrf_delayed_work,
+				      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
 		break;
 	default:
 		return NOTIFY_DONE;
@@ -1327,6 +1328,21 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
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
@@ -1357,12 +1373,14 @@ static void smu_wbrf_support_check(struct smu_context *smu)
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
 	ret = wbrf_register_notifier(&smu->wbrf_notifier);
 	if (ret)
@@ -1373,11 +1391,10 @@ static int smu_wbrf_init(struct smu_context *smu)
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
@@ -1393,6 +1410,8 @@ static void smu_wbrf_fini(struct smu_context *smu)
 		return;
 
 	wbrf_unregister_notifier(&smu->wbrf_notifier);
+
+	cancel_delayed_work_sync(&smu->wbrf_delayed_work);
 }
 
 static int smu_smc_hw_setup(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 244297979f92..4d5cb1b511e5 100644
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

