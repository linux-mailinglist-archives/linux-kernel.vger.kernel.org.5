Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F107C5171
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbjJKLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbjJKLRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:21 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A194;
        Wed, 11 Oct 2023 04:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFYhdcANQPHz4IVV9NkYO3yXIdlP/wC7TPGYW/9Y70MYNtp4t9+J+xv6qbzRFR5RNMigFAe3OEAdw1UZeIIcNUjuCJPiB3dDySxqndBydzJJXvU5S65n1cOiqZG1W3kzZkl0pLsnsFV2g9FSBd0LhAfIM8q2Fc8XACbs0zX9zi9FSFnnqSZky1Yn5gAuFRMecOXzwbElvUGfzaFpZk4QSU5TtwxLDb7NCql0sOFOxX5Tvk9OZU2vt1fTJxaJGNJvPykdeRAZWt0wlYRrSSlsxhc9uELyDGgEeKyfOejUU71RQ9sKDvpvr9IJCGwFq6xwAe3g3GffPz3CvSJvU9kF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=X3M+e896WRdpydrK1O0ADRwMXv7TZ0Hul/GfnDCx+82B+avS4F8EUb0B8aY3kF68VddU1qxQZp7gQJs/k71sG2wKZeN6vNcsc7R278HE4eDffCx9IsoXDcpcUV40EBGJ26wJH10WklDgEAtgPLkq9AlqD/6aKFJLRgwQhs/dG8qVdQKX0ikVnbCakI4DDP1wiEDBMPc370SQeQ3RQ2Zi1HmsGuNcE4G9n3jEbSdagDyC7RZ+YcMImTnFXkQWDzrxZXTF45ZPBj8zty19enQZVUderXodyZML5j1hZBxESVNANUKYxf1VB1PE2XkTkNBzUyEIBFuALuDyRbNKooy9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=clApeNA8EBuCA0WWhri2kWLZU1ddv8cJQZfT12M9TsnBqD02Em0B4MGLs/YiPfEvclT8l0CWvGArlfYUMG0lo7ZtLlBt3iY6WHakzuS7wEogq+Ps/MaEquhM2RzMUUIeP+61kQK5kENMXXpW37vuMCCLIl63DcpyqcHxZyF+MxHIY6wforDzMRIlZAZ+pKqPv3GCSumUGIQ7NfNoBOLACm1j7otCMYiTlt6WN4c2fhlj1Hvlw7jqihycDxc77MnxAmzjUk0bHit2V0HHFVYJZZZNdwzc0eKiXFcapdM0HXYfmvlB30MVx7eJ+ThwZGHVhS8JXu0kCV5kdALU6VwI2A==
Received: from DM6PR02CA0098.namprd02.prod.outlook.com (2603:10b6:5:1f4::39)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 11:17:17 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::c3) by DM6PR02CA0098.outlook.office365.com
 (2603:10b6:5:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:05 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:16:59 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 3/8] soc/tegra: fuse: Refactor resource mapping
Date:   Wed, 11 Oct 2023 15:04:07 +0530
Message-ID: <20231011093412.7994-4-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011093412.7994-1-kkartik@nvidia.com>
References: <20231011093412.7994-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e27101b-97e9-4cb3-aece-08dbca4ba0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WtDv0FERGxkVe1bYwAi3UpEsh5iV2SHiXjoKXQYA39EUtAV+EDyAmdWSqn5nxwUI/+YOLAsniomDl9Rf1sA/+rrQ6zyogLtjDxw73tcoicZCrtIHdGJcA1hRDtglZr1lQ+h1ZlLe5VeRKo84XT5iUoYG1F5Yllcw7bffLVWzKqEeZlFjPWH0yD8kaj8e58Y+sVYnOiCwfPWvnMIKfkXCkC/sVQo4aqopPmNEkCW5V0UvJerzPMa78NoU3Edj98peULo2xLlUSqrNE9GDZlwaI/FUbOCJrBqUNXlqqVcY5nAYINaE6uwbKabaxLSJ5SdITCyvZjGPbUaV4zyHy3JGy6dXf+nvo2VeYDSvflURFrE0Gsth7ZDtM4tWuZV2z8/YlVfcq9hH8pSTZqO7l3P2QS4g+XDS12Z3fSAXweXlGxDSLa56poW2E4MB1g0dnF9e9Jh84ZWJBx1Bd60N24LFnhdtxMaIWIw1lSS5F0eWFzzNY00PBv9EiBS6f2St8dJT9pMGq/6xXdq2v2uYqwUrf6NGT4wobRUU0fyt9lEdUNc2986A14qEwwEI/51zLQ9y7t95eq0jZ1P1mEl9EY9f0/8E8bRHS54JS7e/B3ehIbaVSr0JKXvchd5gP5TYiVBAXE/cfPEIQHgJGFyb4QFjnb/2ZPrlAHvqXBI5gB0NpgdDHvMzveB92GIxePtQXonyH3umF9AgzzoujbiJ/l5rCvrD5lIRmzq0uBkpz+Slo7EW1ig8NjeU6wAiV6jWZ3QIxH1Wu9hB9wA2DvgehqAeQXsxiTXVRTqQt+s+K0zJSY8zxuTnXh6VPOFPPnF3qI0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(8676002)(40460700003)(5660300002)(41300700001)(110136005)(316002)(70586007)(8936002)(70206006)(7416002)(86362001)(40480700001)(83380400001)(2906002)(336012)(426003)(26005)(7636003)(1076003)(356005)(36756003)(921005)(2616005)(36860700001)(82740400003)(47076005)(478600001)(6666004)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:17.0449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e27101b-97e9-4cb3-aece-08dbca4ba0c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for adding ACPI support to the tegra-apbmisc driver,
relocate the code responsible for mapping memory resources from
the function ‘tegra_init_apbmisc’ to the function
‘tegra_init_apbmisc_resources.’ This adjustment will allow the
code to be shared between ‘tegra_init_apbmisc’ and the upcoming
‘tegra_acpi_init_apbmisc’ function.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 37 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index da970f3dbf35..06c1b3a2c7ec 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -160,9 +160,28 @@ void __init tegra_init_revision(void)
 	tegra_sku_info.platform = tegra_get_platform();
 }
 
-void __init tegra_init_apbmisc(void)
+static void tegra_init_apbmisc_resources(struct resource *apbmisc,
+					 struct resource *straps)
 {
 	void __iomem *strapping_base;
+
+	apbmisc_base = ioremap(apbmisc->start, resource_size(apbmisc));
+	if (apbmisc_base)
+		chipid = readl_relaxed(apbmisc_base + 4);
+	else
+		pr_err("failed to map APBMISC registers\n");
+
+	strapping_base = ioremap(straps->start, resource_size(straps));
+	if (strapping_base) {
+		strapping = readl_relaxed(strapping_base);
+		iounmap(strapping_base);
+	} else {
+		pr_err("failed to map strapping options registers\n");
+	}
+}
+
+void __init tegra_init_apbmisc(void)
+{
 	struct resource apbmisc, straps;
 	struct device_node *np;
 
@@ -219,21 +238,7 @@ void __init tegra_init_apbmisc(void)
 		}
 	}
 
-	apbmisc_base = ioremap(apbmisc.start, resource_size(&apbmisc));
-	if (!apbmisc_base) {
-		pr_err("failed to map APBMISC registers\n");
-	} else {
-		chipid = readl_relaxed(apbmisc_base + 4);
-	}
-
-	strapping_base = ioremap(straps.start, resource_size(&straps));
-	if (!strapping_base) {
-		pr_err("failed to map strapping options registers\n");
-	} else {
-		strapping = readl_relaxed(strapping_base);
-		iounmap(strapping_base);
-	}
-
+	tegra_init_apbmisc_resources(&apbmisc, &straps);
 	long_ram_code = of_property_read_bool(np, "nvidia,long-ram-code");
 
 put:
-- 
2.34.1

