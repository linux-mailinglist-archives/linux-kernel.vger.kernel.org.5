Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4327CA50B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjJPKPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjJPKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C5E8;
        Mon, 16 Oct 2023 03:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIT4WsMFhP3IallIZ2B/15jEq8EMIS4ikeBpg4LU+SCfGUNtEMOsmHJ7MTL2XQkM5m+vhg39szOHEtp/deOjv42ZVLifvJD00aiJzDFACjH6zDNnw45whg4kzfRrKRL+Y/T7gHesV9od+rSdAK75xcXDSu959jrhv05sWTaBspQlkNexyvE8P+QEl/VL7+02LKSxlLj1N9umrDpep+NpBZ1aEdFtDxfr6Ie96+1ZW2o36mOevSn7BEfRjjYtdzSlWgvpNfFcgq1SKAjuRgRinVPd5/b39WlNgzTpGMg8UHBpS6YwvcJv/NMmh17ZCjTPmwmt9Kap+quqvShGQ9t6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=JBh0c33nL3u6mwZmQobKWSRLXhKs2GFzTB156NNi4riU2kVjBNkBRUhwNjwToNd1N4lA1QOEdZJ+hImlil92/OEq6yqJd7IaAOIAhWK4xLjUnGbvUTI9KWCLn7kOGJ1c1iuDmewtv62YYuNND3GbxxSKtlnYgZrX1lY/nQry1QpVtc3iAjElNvdDexG1WlcWo5zJV35Wm1vGPvvMkdEOL4PBPLwfiXQynQEFtieClnd0rtB2LZLeIRmSh4qWR6Z7IEKt9OtR/eK4njDsDHSsSVGxIsFUTKpQDj0gaclKEja27ke+4+Q5PPtIwfVO4uKrOYBA1MQfA1bd6+4cM8smBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=FA3H1Ue+8mb+mW4I5VAme3usDXqRdTAvt0fedEThqnsNDXtEGWDmkAjqGXQUFZviynNE7eKmvr18S5kyrMJlvU9bFavq+afLpuM2z6IKtf7sRiv4mmmvU49EKn1Qz13KxBwNWMd45TWLNAYl87sZGK6Jc0nIdiPKCiXoBuHrNh9BJxr7yElxcccDyHW/JMtHZK9Ls09rbtmz4+2FWhrE2+9a8AasvTXFY/ZWrwRnIA4g1q9ldPv2M4/qFUTefGPAw8M0PKO+63EvKG7YjLIoclIcPoumU8r93lB7EijewVA7doYkkzicDA5PmLcm4oxcd5s3rCGKIUosHbIZOXSt0Q==
Received: from CH2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:610:4f::27)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 10:15:19 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::f7) by CH2PR18CA0017.outlook.office365.com
 (2603:10b6:610:4f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:05 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:15:00 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v6 3/8] soc/tegra: fuse: Refactor resource mapping
Date:   Mon, 16 Oct 2023 15:44:31 +0530
Message-ID: <20231016101436.7146-4-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101436.7146-1-kkartik@nvidia.com>
References: <20231016101436.7146-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd79bd0-39f9-4aee-d389-08dbce30cca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqegj82AxvbaYC7S1nOfZo4psz5tEeQEZRhN9gFFtxvNBN7LakKD04bsVRk/xv5mzKebg1yHyWFEfJCAvWYPJjTISrS9jZQa//kFGmY37q27U+T9uPQXWXCu914/e2Sk9C2pogi7OKHUz0t4SWA6VFaQeaLcUNGRsIP7kQ8YVa7HqOimPt0b9jW6r8IK0pTaKdyUHwMglGVz1bUWP8++NU6Efdy3RzBOwZmDCYg+asTIH0T2VByEzci0d7iqZsY0GsqPQ7v1PJEqUZupOUZ98Xzi2aPSe7Jmq+oiL0QR4+wNyVnFDO7kGqsMCdfVFFU+lK2XgUnYpWkMON+stIbE+PwQh/OcAzvo639SVo6A9MGrfWxL7ab6bpOb1u3TjvWEhU4AzNiKAsOzIzeptqg8ntOZs9iWMbW2JoqnVcy3P8VbuGfCyYUCSQWZb7aHzAfChndbB5HLvxwNdDPD/869JBxFIknJX7DoFvPBw8XJB+vIqwW3P1+G+koGw+JvfGmd2g7nCefdc7s/+I1JtQz5UQPN2tsx3FQl1lwRi5a27DLtOOrAaQAtWE5R6CgQPjn9qHQGcbIXdbP6wTDC0Yw/ASAHprkCDe9hfOiiIMSjdr1xEOQFbfiH5VEZcyA8s9XoxeB9W+f8e3aZ3y/xsnh6YvBxO32vkBSKwkCzIGHSHh5Gt5AG8sIo3WCdvaTruyIVLIKLsvo1FLOPAFa7neWVu4SLaxK+B+MXXTUpPi4O1eooLO1I3s6X+da3/IPNDFe7Q6o72oS00KpqLbZA44OuEuum3Oi0tBMk4SFp2vJOuqlaViV3deEdz2wHfbWG08/5
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(7416002)(478600001)(41300700001)(8936002)(110136005)(70206006)(70586007)(316002)(8676002)(5660300002)(40480700001)(36860700001)(47076005)(7636003)(921005)(356005)(82740400003)(86362001)(2616005)(26005)(36756003)(336012)(426003)(83380400001)(6666004)(40460700003)(2906002)(1076003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:18.8535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd79bd0-39f9-4aee-d389-08dbce30cca3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

