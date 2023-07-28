Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD076765B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjG1Tag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjG1Tac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:30:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F330D3;
        Fri, 28 Jul 2023 12:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0fho2DhQArKhWl34R8dCZsyOEwd4g1TsD8661JPESWCqmatYWwa/wRVnO4WwZvIScRoqeEAvDkgpPCBMI0DPqXD5j/QdMb/XZDuGENpcMN6nOQ0aIsMaVfRRN2wlnVR+etsmcwuvUum7yz75EKkuU1HCEj9kRNdXpO+76rClzsu4Y4Qhb3bS954PGwnXi3eHWMBDBFH2+OfXXhrVn+W2P8+HAYl3cgTz4M6lCe/3ASnfmKWRGeLRKR1ZKWcdBFB8mXv3IV30m0ZbuMLaY7t/R7r2ZURCc773rqWXrCuWfhVJAZIXo0QahIREHVZtjyJThXeB3gHQvxJBFeMNV39Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6j//YMTMjyUerN41o/M7QIV3sj+rEbqaGhoPchgDxU=;
 b=QP7ueJy4NFtD3DmT6sxoo3blsLwIeVuGBGjIubUXsyLfDVAPrKP8C45bK8kjiGps0cNdcYOu6DnXmJBNDIAeVEUmRFTAs4doM1buYnzq0cDWrwIRaxmFhx39ItxAhgrqwMIUfDqwBZoFGERqYFZSD15wRtStrE6LOHMrCD+trx6f2F1bC3i58LMcbvKauRTKZ8sz0xWk7GzFMyiBU05k6js1FDlIyiBWvQ5fEJnLVWp6wK/dEqcIVQwMidy6gFDTzIY0v+t5WPI3P38o6HVKjP0m2//8vGfAbHTNDmmhn2PgzoJffJTJ2ifFHtcKUvWW035aop2mi31T1oLg+jvT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6j//YMTMjyUerN41o/M7QIV3sj+rEbqaGhoPchgDxU=;
 b=vX826wmKZBz00ORk/Mz/J4Y+6130CWQoGVS+bpnVIHHXW78y1l4QMLXZKFS3puczLUU2JVzinrQnRJnBBZ2asHF42S6WlsjW/4rIrX0BMkE32knnwbVJq211V+5kMMp14CzDLviJ5aBd+aWEGuLOVQgWAmM7YkabhddVRGX0Fpk=
Received: from BYAPR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:40::14)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:30:28 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::18) by BYAPR04CA0001.outlook.office365.com
 (2603:10b6:a03:40::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.35 via Frontend
 Transport; Fri, 28 Jul 2023 19:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Fri, 28 Jul 2023 19:30:27 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 14:30:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Subject: [PATCH v2] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
Date:   Fri, 28 Jul 2023 14:14:08 -0500
Message-ID: <20230728191408.18141-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 426d179c-1303-45fc-0de6-08db8fa118ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ttaL3vRvcioz9oz8Ze5tvwHTzzAXsjzWvDrdxF6bGE5L26WIPxo5YpA0+OHBSEksZXPY2ntVCshZnSHGbXVp9P+MeE6xH72x2EovSN/E9hvyLEWz+QZ+9YQqNXdT6INBN+sQmlJTk32eLbhRicLNgsoWOxIQIbyFbaifkQm43GIi+jFfQ6wO3QcMHa1Gze+Y9d7C8QlFiuJhQBzikaLhooJRxa//wsjWXkEjB5XmT7LbkilT9nfvUfeWvua98NFOkeJ/hKAx3hqViY8+vRby1hp/BwPamr4Jzj58nUit/iVqKVvGrqVRF6oQIBTegmY7duZkKR4f5ZpRWFD5hqjGAazR/8kJ1NBvV+JC8rbbWihyygXI4bn/ssAE/YuluwY1dBCXIzW+Ka4ezWL4xcijAD41tEnswDI5WZtsGH/ffy1kB3325mh1IUY3NfMnwGc1k858I8NcoFAEC8CS9cOPUKtZQ30WuIlDxPzKyiJpNtrNW4piO7kPtxU7tKyuKQVnqljJ736eVqau1LcUAlP1Gc9qrVh4ozWVZD0eDKLTVTu8I0PcuAL9oDumjjDK4jQQzBO5AMXRxK3+7EBAEkmEEs83mdPRSIa7LQ5O3Ay2uLLUsSdjpjXswtTyNNXE1iYXdTkhu/uGYHh6cGPPKfkHwKvoVJze9ItjjC7iqab0DUYkaN51HUbEK2JYxR6Er6Xk7/l0Q56JzNEPbG0qVqIQfdn2xcdhdQZopScV7ORtt89aqPk7Zy9Fex2dkBfsjMYLkhSPwcTU/jaZazbb8rMwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(26005)(356005)(1076003)(54906003)(478600001)(82740400003)(186003)(16526019)(336012)(426003)(81166007)(6666004)(7696005)(47076005)(70586007)(4326008)(6916009)(2616005)(83380400001)(966005)(36860700001)(70206006)(40460700003)(5660300002)(44832011)(41300700001)(316002)(2906002)(8936002)(8676002)(40480700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:30:27.2255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426d179c-1303-45fc-0de6-08db8fa118ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Yoga 7 needs to have keyboard interrupt signaling polarity
is incorrect in the MADT and the value from the DSDT should be used.

Reported-by: August Wikerfors <git@augustwikerfors.se>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217718
Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Level->edge
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 1dd8d5aebf678..6ff788223f332 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -481,6 +481,17 @@ static const struct dmi_system_id lg_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lenovo_laptop[] = {
+	{
+		.ident = "Lenovo Yoga 7 14ARB7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -494,6 +505,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ lenovo_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, false}
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.34.1

