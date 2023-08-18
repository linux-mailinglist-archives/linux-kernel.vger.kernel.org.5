Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B666F780881
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359210AbjHRJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359211AbjHRJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921413C19;
        Fri, 18 Aug 2023 02:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMx/L9U+tuGMlZ1Ckg8peUeVmjbjc+TWfEJsaAImKL66bIfIQSbHfMByAzENlE1NAmmdtt3j5+jJ6UbtCU7GRbiTollUXUNG8k/NQCZcJ3fdYiQb6Ae23TeoHO8YCmU17IfyLX8kn82O319dctrVtzHP3NV+rDmi+iWZ9QDDWgu4hCB3KXj9IhwMxTjlxsrRiYJ5mn62+UgDCiYRGe0a0yNxn/eJC2r3VJXIUlreNpzf2PI+ECdrmbPmAPcz0wJesqw6KjfkEOYKqiUZWSqNNdYoU4NnZzbL8xT7NVKUXAAzFd6HEC8pMMZf44ooq/oPhALj1Gi89Vnot0z0YdoqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2sWHrJOyCa3WhDgcejfBQvdAekToSTPI1OoPnrEouo=;
 b=mTzeklzSAffxyD/G42BYa9UEAFrFh2lQC2ucvnVvVZMgboMwj/3eSKQNBciD9YUY+Lpod3PMlBrmPjE0bn8tcOGu9xI6Jl8a8r2hRK53ecyNMo5D678k8aqC2wYa76PhqKeXkaaW3LS8K3JHgigoPA1MLrUQMs9naS5FLyBEni6sJm16K8bRQ5v6f+OdoLTTlaGxgY7I33pBZdqbJ13zGCcCaGoxDf+Z0lhK7pGaDG1ysAbI5ikwqEBHgZYZdiDd/vdqUsyV8VEWx4rE60QouEOKqe3m8+Yfsmj1/bCJZcV9Z0WcnHtjo0OGU+K7G7Vt2yaRJ2GgmuVK/zPf87MZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2sWHrJOyCa3WhDgcejfBQvdAekToSTPI1OoPnrEouo=;
 b=faLCGCNcHw/NCcI47yR6PaezpwZ0oTZohAYyMemy3C/yVl63t9ICi9V/42/zRZa5l91+jxY0sDp/h3qItyQIxfJieyNG5ABGPZaQCr2pL6HnAni0bwmnRkS2spJQkARc+RZkE9a01I4boBCRHrGpCnyTBjkjkL/VOvsgX7WAuW57B2e6Q1Oj5Iw9Xj7ET/zbzdZzIH2HoCTfFmJfdTtrnNQpzk+b/dVhS3KP7tCWnbTdHsdzzKto3O7iXI/byvfzXG+P1YxVifWlQsWptj+16WDmidcI6zJijw4qnK7LTlKLQKV0s7CGGhtZth56FqxbdgxOkRvCHmSTzL8Rpv6nqQ==
Received: from CY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:930:8::25)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 09:31:02 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8:cafe::15) by CY5PR03CA0030.outlook.office365.com
 (2603:10b6:930:8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 09:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 09:31:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 02:30:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 02:30:46 -0700
Received: from localhost.localdomain (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 02:30:41 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.co>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Fri, 18 Aug 2023 15:00:23 +0530
Message-ID: <20230818093028.7807-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818093028.7807-1-kkartik@nvidia.com>
References: <20230818093028.7807-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA0PR12MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 779b516b-20b4-4dac-c197-08db9fcdd6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1bMFUqolnt4l2EbzOa4+dAH3fQXJQFYC3vc+3TMIEEGSaEDjqiVipl4uUy/+MaFokz/GMkP4FpqeLnnmSDQS6ixkMAA3okwq0UO4FrWOC4MfaS+ayxDVYCTvLUAF3mSg9MnTHKUhPF+0o8myL7JyJgOn7WOAmJg7XoGKWWdzeje2NLOBkk6vYxx577hoQMR63NsM5d1rYI2V8ZsVBLpueRLiwwSjfD56pVODrPHSeEHZuGzKrcVoCtJHT0qoG4M3jrZkwNcI6DF1o87ceSc9/hHOGM0d5PeRf9QtGDmDR4fekPe19ePHAqssC6EwUgg3QocONS6jayozthr1fvr4U7bI+8sUWiMvUtLTFfpz9/pN/gj1Vz4bEYejvFeMBjE+O0lo0wI7/2ufRfxy8lqGf9XstMoQRQNU5mzFbTv6Hijvzezsdg8Iu8Ar7EU1F3wSQAQNIWpGWcNX1BIKxDCzjHm5fxg7useQGD4rLMy6myCANyjlbBbdj753Cjn8Or3pvm5T/teBVYyiKURUOSc1eNu2ASS12VQfJFTORA1pMdqY0ImBFcOGbjm1m4pFbqykn0jqCgkekTPtVv3BxijUK7rHNWwVkfScu4dpc5idQpvteM8SRd3dQIyz4/Qae5W+rTzOT+7cqRgGj6vcdm1JLI0LLxETFhy/ILuzwuG+vMmET8feaXfNoLTIrln1+P05X9ZUT4cbZ2wUqx6JQwE3NCqaV6PvtEKJ8ilWa6SpenGYaEtVtLoK33t84H7oiG27X9h5QEeGJPVo+HyBzdPCg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(7636003)(921005)(40480700001)(2616005)(5660300002)(110136005)(70586007)(478600001)(70206006)(6666004)(316002)(26005)(1076003)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(7416002)(426003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:31:02.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779b516b-20b4-4dac-c197-08db9fcdd6c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to ACPI support in Tegra fuse driver add function
tegra_acpi_init_apbmisc() and move common code used for both ACPI and
device-tree into a new helper function tegra_init_apbmisc_base().

Note that function tegra_acpi_init_apbmisc() is not placed in the __init
section, because it will be called during probe.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse.h          |  1 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 73 ++++++++++++++++++++------
 2 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 90f23be73894..a41e9f85281a 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -69,6 +69,7 @@ struct tegra_fuse {
 
 void tegra_init_revision(void);
 void tegra_init_apbmisc(void);
+void tegra_acpi_init_apbmisc(void);
 
 u32 __init tegra_fuse_read_spare(unsigned int spare);
 u32 __init tegra_fuse_read_early(unsigned int offset);
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index da970f3dbf35..79db12076d56 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -120,6 +121,11 @@ int tegra194_miscreg_mask_serror(void)
 }
 EXPORT_SYMBOL(tegra194_miscreg_mask_serror);
 
+static const struct acpi_device_id apbmisc_acpi_match[] = {
+	{ .id = "NVDA2010", 0 },
+	{ /* sentinel */ }
+};
+
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
 	{ .compatible = "nvidia,tegra186-misc", },
@@ -160,9 +166,28 @@ void __init tegra_init_revision(void)
 	tegra_sku_info.platform = tegra_get_platform();
 }
 
-void __init tegra_init_apbmisc(void)
+static void tegra_init_apbmisc_base(struct resource *apbmisc,
+				    struct resource *straps)
 {
 	void __iomem *strapping_base;
+
+	apbmisc_base = ioremap(apbmisc->start, resource_size(apbmisc));
+	if (!apbmisc_base)
+		pr_err("failed to map APBMISC registers\n");
+	else
+		chipid = readl_relaxed(apbmisc_base + 4);
+
+	strapping_base = ioremap(straps->start, resource_size(straps));
+	if (!strapping_base) {
+		pr_err("failed to map strapping options registers\n");
+	} else {
+		strapping = readl_relaxed(strapping_base);
+		iounmap(strapping_base);
+	}
+}
+
+void __init tegra_init_apbmisc(void)
+{
 	struct resource apbmisc, straps;
 	struct device_node *np;
 
@@ -219,23 +244,39 @@ void __init tegra_init_apbmisc(void)
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
+	tegra_init_apbmisc_base(&apbmisc, &straps);
 	long_ram_code = of_property_read_bool(np, "nvidia,long-ram-code");
 
 put:
 	of_node_put(np);
 }
+
+void tegra_acpi_init_apbmisc(void)
+{
+	struct acpi_device *adev = NULL;
+	struct resource *apbmisc, *straps;
+	struct list_head resource_list;
+	struct resource_entry *rentry;
+	int rcount;
+
+	adev = acpi_dev_get_first_match_dev(apbmisc_acpi_match[0].id, NULL, -1);
+	if (!adev)
+		return;
+
+	INIT_LIST_HEAD(&resource_list);
+
+	rcount = acpi_dev_get_memory_resources(adev, &resource_list);
+	if (rcount != 2) {
+		pr_err("failed to get APBMISC memory resources");
+		return;
+	}
+
+	rentry = list_first_entry(&resource_list, struct resource_entry, node);
+	apbmisc = rentry->res;
+	rentry = list_next_entry(rentry, node);
+	straps = rentry->res;
+
+	tegra_init_apbmisc_base(apbmisc, straps);
+	acpi_dev_free_resource_list(&resource_list);
+	acpi_dev_put(adev);
+}
-- 
2.34.1

