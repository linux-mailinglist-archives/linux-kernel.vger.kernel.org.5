Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA478A4EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjH1E3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjH1E2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:28:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E508111A;
        Sun, 27 Aug 2023 21:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbC/a6aribirU0+S7HxZZ+DkCBZxJDxBK+GbZLT8d/rVKH9gEWc6TdjId8UWKnK307bjWBK5Pqi5Hgsqfecvz7yC6PzsPEGs/z9PQKXMhPpXv661PcUOVCUPmCexU3GRdnDvU1QPDFCn++HKk1pQvpRnHC00Zqk0O8XisLtfkQij++CR6nV6lZNYkc8cA9VpEPHCyjuuiO+QggRtqeVbIJ4HqDl4WHUQOZjcFHHqLc5BNIg17BEynNB1JEUTFaLjUOSVIEx77bgb0GTf1DqzQiEeZmK2mT+myvl2XuL0DMXYFg55w7xhGJrWP9tm+VQicUFDcLdtLOl+eYVJ9hYLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li6EMMFFXhM9lFkH1TNgH9wjskDBJhv5LpSBKSg2pBU=;
 b=BoqD2erAFb3/Uoitdi1kT5pQKq0V1Bmmdk+cJYLNmCPg6/OPZnLP2j+U4xeLLfG+0Yf4JNVtBkFs+J+B88e6nldBh8kboVXKRw9M+vEfdseNwVoGIEuw7uIhjpi6W1HcaBhk4EiWvw+co1lrKvpt+xqBdO8jzcwBVQsoOHiLC4JZrQCvYdGWqG7+VqYkT7kLhfT22iuy7wIkbvhz981PrSi/ZB5bPYspRc6uWIeojiWPetMb8TS9/jMiqWoK3vhftx/jpcEID42v28HXidgSpyyQvAsSeYOLfymTL3CVXLh73C3794xkIV5dSjOCbtr02fSZbS/8Sxtptz6++NEkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li6EMMFFXhM9lFkH1TNgH9wjskDBJhv5LpSBKSg2pBU=;
 b=hrRm2jdAbv233M8xcduHJh0q2GK4h5zSly6gunvwxN3qMbxxHwAJepgzZTTbKsHKG3jfk8J/4lm1lYUIm6k1edlXGzHRLYODGJTImHjNlqfop03AYimHTCREQduhP7FVtgC+VrmICduyd4sjo/NH7LyA3K3lqCJ5Yryr3hHwHKQ=
Received: from CY8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:930:49::17)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:28:35 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::d3) by CY8PR12CA0029.outlook.office365.com
 (2603:10b6:930:49::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 04:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 04:28:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 27 Aug
 2023 23:28:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>
CC:     <bhelgaas@google.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iain@orangesquash.org.uk>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v15 1/2] platform/x86/amd: pmc: Adjust workarounds to be part of a switch/case
Date:   Sun, 27 Aug 2023 23:28:18 -0500
Message-ID: <20230828042819.47013-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1ad51f-2d5a-46c0-40b8-08dba77f3e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd6xnuYL4J/95Sx50r10S9YDJO4qXjt+f4eZ7fOAQRSOaM8mKdoUvBSh4KgO2qk0Pn8mGw886tVxXKBHcY2SCEDbOxsMTwG6RB3vB01V9NJMx5UkwyCR/+tZizNwxLInRuOlCpEOngJenBoD3yOWesJSB+uqU0NiIgCqnJVNDLr4nNBargqBT+QsFwUmgIETw/kfEnirTt44eKCcZuYX92lN7tiRuCHWgpv0MZjqKelxj51ER+qMeFCmGDpVd8/GPGwnG07UMR5Jv1YJxRx2BaYQwJK4M9J/7uLVGk94vkmfccgfYzG30fTdUmrwZUOtOgw58OKlOi2wwMMAW+0rJLL/A3lddzKoWs23/xqa72UvMz4t6qZ3T5hrHVSrPD72jblBWpgXBSYHkvigypiVpRzY1XsHw2VqmMAMMgLhUoH5iUpEUDEIQLaRU2uv+EoV90w7fc8+SBM7h/I2CBGxTyl2bNKKauuZrKi9Z7/hY7AKdK13VTF3Tx/p4qtLCzj6W6FJmiskAjhm9MLICrouPlmAgae0bIARgAg1HvLgIlQf+OgYhjLMnIoKpqkopVZXOAr2evduJbUP5iUsn3wZt+kXWJSY7Sn395eA3p4mW4Rd1YVVVepNE+UaqnIQpc2+l9Im+hlMfFxZjcqQ8DGDB/ZRDVhRAwYD8xMQs7JbWuPSV9Vd52VmU5V7xuX1nQdD0PUrjQRWC35WwtMrMnz5EkBXlJxezihUAdBfLGfX++xx5Let1d1SbhSANkHwNYGAL/13OgRfnT/MfEY2cw0YwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(8676002)(8936002)(4326008)(2906002)(36756003)(110136005)(54906003)(6636002)(70206006)(70586007)(5660300002)(316002)(44832011)(40460700003)(41300700001)(26005)(36860700001)(7696005)(336012)(2616005)(16526019)(426003)(1076003)(40480700001)(81166007)(82740400003)(356005)(478600001)(6666004)(47076005)(83380400001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:28:34.6818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1ad51f-2d5a-46c0-40b8-08dba77f3e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow introducing additional workarounds more cleanly for other
platforms change the if block into a switch/case.

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

base-commit: 4dbd6e61adc7e52dd1c9165f0ccaa90806611e40
-- 
2.34.1

