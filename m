Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A17750FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjGLRZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGLRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:25:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72310C7;
        Wed, 12 Jul 2023 10:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncSxqc3PbigZ8saddftz1s59wjzw5DSHaflIrr/AicuLulUEI3yErZ+OihnWJ1S6+qERe7vdvASf9hOqDsdG3URIfO0HxidgrK8kY+vMkwon6y6rkFcF/FV1zcSej43saCN5D9b/Z2bwZIaJjvP7u4IdAynDFMMGRS3l1z89iZaUPDMv19vurJDQM0eYElovDhF9W/XnNsqE808ynhyvH6VmtlEycMn4s5Z3WBdbioR8q9oFbBQMPTR4ECX+G0K8l5Nr3QSoHsljGQggNO1LAXvNxL3smiW6QLrxxIK9hYJbrcw044dTvZ0NxwKeQJwgpT0E/hqX18aKghJ7tNo2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5MDyXAbmFQUgfM8+VsB3Zax5vJVDyZaEm3n7ts/bHI=;
 b=mPWBwU6Vgo2KCB2O6JfWE0kGTz8k5UpKCx31oY1z8R2Q/0RQLtLDO8AyJxgIdA+okq4HxDNutSWNfoAJUPDyuW1cxcYR/CgldIBRBTuw1w7RHXeCiDXA/Le9WCWOe+p+uXj5RQTVM7JhjaTyjz5ijf1QS4EeEZh2qPtrOz6OFBifWGKJzRKFCeohAdY3J+mHcpgmREvH9IYx46N2n6zClWQvuoZ5fn8euHgaXgrNC5VZYfxqn2iDj2TBXznoD5E6fl7zb3kzBuXEydpIpJxMzwtwS2IorLpHjGXp43TiEfWDyj2nn+dr1j3pG3v51D/zxj4zrBe5pUQs9RKzoCaaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5MDyXAbmFQUgfM8+VsB3Zax5vJVDyZaEm3n7ts/bHI=;
 b=PjCMjtHcKqDvjloftYcQcekKH6jT10x0z4RTd5jopuF1bQo/kJ/DVyhi61+dWqNaaQz+VeyY71PgiEa7pXsJLZpYOAr71NbzKzuXFD0WgZImTB416TAxVO41rTFcvg4Pn9Ne6e92OhdnyUOz2zM3ktP/QcBlO/AaIGQtB4JzG5E=
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 17:25:15 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::e3) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:25:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:25:14 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: thermal: Drop nocrt parameter
Date:   Wed, 12 Jul 2023 12:24:59 -0500
Message-ID: <20230712172459.20275-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 83da859e-1dde-4f89-9a1d-08db82fcf4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMjsGtK2r9bgKFmrej/Jc6Jq8wKaNBPVF3gYpPXnhG5pjZUIRqxtSwlLO3hwf9l58qtLI02pn+Tlf1xN1FcyxhwaIBqzxiEFbPK62nhMq5sfojg3eio6f/ykbRaoSL4p8WzIphubLecdaeWJxRqV2sKecTKKRhRhXRijUP6CivTaQ2vQO28vI5UqGdx8rpKb7DmsBmRC9NSGFw0o0enGE7LmhO3aT4tYUMfFIeBxpsoLdNfndxnz89EwYtZrMVzrvdmswGzD4m0aFSlpKHE/lNr5jeJITlVaqnaQosTx0Uxv1WUa0tlxGQIrIlaQmX9eHt79DxCZsujk6aTdFIQ6hfTpeVZmEsUblXDpBmwph02eUrVxk2a3YIucD3p30LSh2qT+cAMiZe2GeP0HLPy3Eu9JCB9zCDaZJRr39XVGQOUvtssr80nPxkNTqOZoLw7UObdiLNYGbm4KMOBMhVJ3TybHrAYczTKSHtfnk0DujmRAmf8EXh7cx/TjyruIfhsoTP8czfoNUxsnm+BL7bHGIKN8tkXJ32uLbZWRgDsx1ucbHqAxochf8c/uNyxNkREQrIcNWwyxTGs0ONdtmV2wM7UdXiZN1UoU9ij1Vu+HkJ7Mrr7lf4qvJL2WnU5o1UZsV9g8kZBuvrRiOPzieFnIVP6eJgyovMbN2Dw6KaOXGm1Md6daHMenywpAB49sTOQh9a4yce7ToY/0LmkGfbYKXmtXfjMXn6LQXKClT9vMeRVuhydC++ZIiJg5QiYqBGE8gFpqLAr8NmV/Ges8DtcKbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(316002)(41300700001)(8936002)(8676002)(478600001)(54906003)(7696005)(70586007)(6916009)(70206006)(4326008)(36860700001)(83380400001)(44832011)(1076003)(6666004)(426003)(336012)(47076005)(82740400003)(356005)(81166007)(82310400005)(86362001)(40480700001)(36756003)(40460700003)(26005)(5660300002)(2616005)(2906002)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:25:15.0138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83da859e-1dde-4f89-9a1d-08db82fcf4a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `nocrt` module parameter has no code associated with it and does
nothing.  As `crt=-1` has same functionality as what nocrt should be
doing drop `nocrt` and associated documentation.

This should fix a quirk for Gigabyte GA-7ZX that used `nocrt` and
thus didn't function properly.

Fixes: 8c99fdce3078 ("ACPI: thermal: set "thermal.nocrt" via DMI on Gigabyte GA-7ZX")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 drivers/acpi/thermal.c                          | 6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41c..2de235d52faca 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6243,10 +6243,6 @@
 			-1: disable all critical trip points in all thermal zones
 			<degrees C>: override all critical trip points
 
-	thermal.nocrt=	[HW,ACPI]
-			Set to disable actions on ACPI thermal zone
-			critical and hot trip points.
-
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f9f6ebb08fdb7..3163a40f02e30 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -82,10 +82,6 @@ static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
-static int nocrt;
-module_param(nocrt, int, 0);
-MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
-
 static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
@@ -1094,7 +1090,7 @@ static int thermal_act(const struct dmi_system_id *d) {
 static int thermal_nocrt(const struct dmi_system_id *d) {
 	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
 		  d->ident);
-	nocrt = 1;
+	crt = -1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {
-- 
2.34.1

