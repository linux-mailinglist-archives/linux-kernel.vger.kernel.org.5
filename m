Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92278CCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbjH2T27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjH2T2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:28:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D57EA;
        Tue, 29 Aug 2023 12:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdKbxNCN2ltaFPX6tVWxfFFC6jgslXggzpSLTcdrdh+Qv4COn/LKOblac27iqMrB7u52fZrRytme0di000D50Wtv80QtOatMrjg3jtCSx9WkI1NvX/KRikzp8hCyIjeFjYevTFuTFD8cYJG82Q2N7whps5SClydARrXTq9EZvX7a9tZTDug3NuyXMBASKKngV5mUpkDjv2DTMGecAWYayprUFJEVScY92rkrQSNkgjzKbutsJO7RTVmpyy8vOvHH2lQlt9W54XRi1DgDmHS+eUB09M8hTBhNIlEf4KjqLnp7SM0iy6kT4QvQh/n739lLX6snfw0xU99fD2tuRroHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E3pSx5yEUnalhqiIzqGKLnHV0nZ9+NqoJSOFIguhMw=;
 b=MgLs2FdmTVcmZjSC5OxtD2d/Gj/nq3DTkolGOr3frRfFxUtcMJl6Hab59eFLtDBrkvFlSyasxcH+I2XocuNQmNIMRT3DPlTeMKmKDOhFs/d5bDIDbcAQ4YrFdUZ7siSQCEelopViUWaFdZJqUkFpaU3/dvhiIoRfF/Yh+wvdSYcuoPk81cnW2rEO9qEmquPzKGXHVRJaYIi9dtbkeq7uGvpIl2QBVEr2HI34A7+7sbO7baj+g0XRVGWzNp+JrZDmF8vLzcvjJ8lx5f8OfDXPMBbApopTmXAxoaniPKEMvBZMz7kJGO/h98JKxcxPIt4UD1B1hAaiSRkvITgcbpquyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E3pSx5yEUnalhqiIzqGKLnHV0nZ9+NqoJSOFIguhMw=;
 b=RpNHlM6OA6lKOKPii3wRuwWQDWhEnKyX5f4Q9u+QT/rDze1U4vrc0fu4d0WQxUL8sd2cwxbIhlCRjnMhGMoI54+MCT7NypY+4U6Cx/c1LX5jCltPNdV7IPvVXdQhlSdKUomA9wdXKdWkSSbwSV3OJcUjfDlJlXF8iBNRtG6aaMU=
Received: from CY5PR19CA0059.namprd19.prod.outlook.com (2603:10b6:930:1a::9)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:312::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 19:28:32 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::73) by CY5PR19CA0059.outlook.office365.com
 (2603:10b6:930:1a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 19:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:28:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 14:28:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <hdegoede@redhat.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <Shyam-sundar.S-k@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v16 2/3] platform/x86/amd: pmc: Adjust workarounds to be part of a switch/case
Date:   Tue, 29 Aug 2023 12:12:11 -0500
Message-ID: <20230829171212.156688-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829171212.156688-1-mario.limonciello@amd.com>
References: <20230829171212.156688-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b3b1d2-03cc-46ed-2f3c-08dba8c62180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1V8TkGrXTC38qM8e8CUInRv3E1hI53Li4ijU8C5NxQ6ENoLZlzzfkKQKTJ+2pVygFhdQ1TFGjF1+H3I+/ayYnv9NJPVjJPXrqKEQVUqCVzIVr/K0Jr0lT9NECTyUZG2rc5I92CKgSUtx2mfoqJ0jnCN2Ofr0/LRdwCaPN4mIeNu5En4OlJl/GceYa8R6l0SVaeo+8KZeeh6oA2cBh/8ioNuk3qU0Pm1sNTNSog40MElW+dZXnmblRm3gaQxO78EpbQkTiWRayL56ets0Wlqvxa6cNpng9smtiPK2Fux1rGpeGNwfeILWoZDb2DjUD5zekh+GZk3g62XCXfmTLJ9Y43c0A1FwwFUuaibr74DMuWTJiPs1uFcunBZUv6gJBzCNqQh8IllAXPHlc/wAHp8ZcNMNhbGfvgj6bHLCOHiP9U/5v5z5I+1Pohe37GPKGG2HNw1xw/c7sgkEH1KYAU+td+WntSkSKDL153mdCqN6e0HjGs5SMPVcqn1kJ0saXZ9r8wAbTuPhKs3/QzoyRPchRg6RxTsaJZygmg+720HFDbzdmPvwYKlog2IJSxHPotTWCQqQaw5WKhmrQXf8qTC/E6X4tgKMk7f5hhadLJv3DKk3tCP2SVIKZPlTtkFj0TBYijlKK1cjMG1EtFZUjiwTBRf65nmj8bchpu5sOEJ2+1sTxrb1OjYopAguey/9SlZ3N+gJ/M5OhUhTrzE28nIGPaz0NwTw3b/d3hOcjNVPmrm7tvi/ZglN9fgRVy5Vouj83DpNXmNqCWL4V8chFzU2fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(7696005)(40460700003)(36756003)(40480700001)(86362001)(81166007)(36860700001)(47076005)(356005)(1076003)(2906002)(26005)(426003)(336012)(16526019)(83380400001)(478600001)(5660300002)(110136005)(70586007)(70206006)(44832011)(8936002)(8676002)(4326008)(2616005)(6636002)(316002)(54906003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:28:32.1003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b3b1d2-03cc-46ed-2f3c-08dba8c62180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow introducing additional workarounds more cleanly for other
platforms change the if block into a switch/case.
No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index c1e788b67a74..eb2a4263814c 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -884,17 +884,20 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
 static int amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+	int rc = 0;
 
-	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
-		int rc = amd_pmc_czn_wa_irq1(pdev);
+	if (disable_workarounds)
+		return 0;
 
-		if (rc) {
-			dev_err(pdev->dev, "failed to adjust keyboard wakeup: %d\n", rc);
-			return rc;
-		}
+	switch (pdev->cpu_id) {
+	case AMD_CPU_ID_CZN:
+		rc = amd_pmc_czn_wa_irq1(pdev);
+		break;
+	default:
+		break;
 	}
 
-	return 0;
+	return rc;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler, NULL);
-- 
2.34.1

