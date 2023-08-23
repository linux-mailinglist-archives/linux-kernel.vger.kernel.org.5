Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2734786035
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjHWSzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbjHWSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:54:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FF5E6A;
        Wed, 23 Aug 2023 11:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE3zO4qKqNe5hVpRjLOXAGJ6oUqJwe91P+e01W7EtkNoZvvm/hFbBV+Vls4uPw/sCK8l8QqrqDYF/tZzigEiaVkZvmupR5NbY/pbea2zPGILD9+w9yXFeRpGgk+Wt6EhwvqpV9lHKC0pF7BY7YEkx2ZoYSy4+wSGYrpAYJT9j90LpuWhpw2NWpDjmRQ6gxvrsmhknvcNnEhNv/E1mOJ0aQeJjjbavLp65M8C7C/oxdrhex0Vp2Ut0cz0wE8R8B+PhHQY0yoKE1NSBTBOSm8wgO/sZSI4tiKrlSlWnFDSThYX9Ru8pDHiTe/3EkeFfLk35HoW4PJLGeGImhDaRR193A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9+URE0+Djsd35B61yuzNJXjybfDfFxQ0kagAB4h0EQ=;
 b=ZO2xAos0tlP2/DCQa5lgfheDGPW6QeZQQoSZ2JGn6nFYOKJtjRlHmo4VntYAPnaeC+QzYpjFvPy2ho4krPRvusdxOEvxOfF8p7H4o+MKd93sHYkIT5/RVc2sX6E/6lBJSWJq4jbLTusaGlTeTEgIqf1XgSvShTiXBJNYXTgKzoENpmCCleV2RuNBLmOyZZt64VD/v1CGrkrLGeG1+KlW9q8ldA89JK66lsc3Cyg9WGGWK9JytDbvmklScFmVxlbbAkPNpHoSkvJ3/LFHDPkKvL499BJNpIBWlEcMMYS/GgYN8ANfwRPIy1BcpJUHcENa8FYeTJZU6GEj867SoltoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9+URE0+Djsd35B61yuzNJXjybfDfFxQ0kagAB4h0EQ=;
 b=goWx2/ESgnwFAEFHfPDo3HIPAXDbYz/sgoC+akLOgKjew5awdUjtHO+41Bng6p+uiPXgMAPyT5f8w8MG5kUwLipnYqdvIlONEYbCVIg1eeo523ws2aYBdw/mn8nNxVqS6exMDBI8HCw1Pbh3rOsoDmiDw1HF7zCjKFgnhce3wEM=
Received: from DS7PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:3b7::10)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 18:54:38 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::9a) by DS7PR03CA0095.outlook.office365.com
 (2603:10b6:5:3b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 18:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 18:54:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 13:54:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC:     <markgross@kernel.org>, <Patil.Reddy@amd.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] platform/x86/amd/pmf: Fix a missing cleanup path
Date:   Wed, 23 Aug 2023 13:54:21 -0500
Message-ID: <20230823185421.23959-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 1789366a-3f6d-4b8a-dc90-08dba40a66fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8Bh5vksF/5bC6J9Q1GNXtyRKMQjvyG+paUdwBeE2K1xrA+DlYV1Q6etHtMKn3gmQTLwM6Kfl3dh4zXaOSQxFwFFSbokApx0YApdda3Zw3bk/nw9dn2Ijltdq2FUHulRn2L6JLXYsJHg5rPA265/i3GHCHrAhz1wDI7HQ0RGNb0LwlKrwAkuQA3Dj9IKEw4d0ouDs/o+vOxV5wwK5dz6jAy/Lltrlqr/7WJbLAGFtOXdh9Uhj6f1XYSLvi9W449EzZ1T5A+LAM910/X8guRh3JUu9drUxM65LcZpjkH/EIVan/cldEEl/Z2Vnf+AJa0elVrw47hsWbSZRHR8eDyfzgm+by7LWI4ZmUepFhhRtPmfS0D8letLdJKriga1aNqt56sfjr7+LWEPzaO23d/4SYyiDYxziiK2a83H3vjGAy3HBodvzWfdtkwlKn76fuXyeDqnklPSYfPQYmN49WJKiWQsie4OwWxa3iq0erQcvz77wgMI3nhKrs7aDU/m6u+blSbjzgsvkPhJ7N508IkgiQ23mk2EnX+fgcU8rBT8hGVh/bciwGYqgTHElmAAG6qX4YytXGz0Avwyj5/8ue6J5QzlsNGZZ6n6CDFfm8Rq8yZ6rldE/1sUw0mapC9KDVPKhRgD5bmvuojweMEuC7cJm86NUD3kf46qH4cDLlDO3qq0uA8hL/StuelcqOCYmPD8z18Q2rrlycT4wmdH6YBfMzLcHPzqQQvmPw+KcOrMqOZlm4Q31cU1LtpGUKvtX7NvZhjgzt4D4Cnw2gWxJVZu2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(70586007)(54906003)(6666004)(8676002)(4326008)(8936002)(7696005)(70206006)(36860700001)(26005)(16526019)(2616005)(110136005)(478600001)(316002)(5660300002)(1076003)(44832011)(41300700001)(426003)(336012)(83380400001)(40460700003)(2906002)(36756003)(40480700001)(47076005)(356005)(81166007)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:54:38.6308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1789366a-3f6d-4b8a-dc90-08dba40a66fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems that support slider notifications but don't otherwise support
granular slider the SPS cleanup path doesn't run.

This means that loading/unloading/loading leads to failures because
the sysfs files don't get setup properly when reloaded.

Add the missing cleanup path.

Fixes: 33c9ab5b493a ("platform/x86/amd/pmf: Notify OS power slider update")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 7780705917b76..8f93681c5c9c5 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -317,7 +317,8 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 
 static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
 {
-	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR) ||
+	    is_apmf_func_supported(dev, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
 		power_supply_unreg_notifier(&dev->pwr_src_notifier);
 		amd_pmf_deinit_sps(dev);
 	}

base-commit: 65c6ea33e7f63799090158866cdcfdfe8d63ce16
-- 
2.34.1

