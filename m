Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20ED780884
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359246AbjHRJbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359243AbjHRJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AE33AAB;
        Fri, 18 Aug 2023 02:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXOgGUVOWKC5MA7nJRLbiUpR4tphyFLKQrjiClt2jGUSKxk47+ohEWnWzDRO5JDD6UJ/BOxq1HC8qzd0U9PeHmbBSNupo8gOocjGlUDMGFUTt8Gbenn/13TWpK9VadMzWfwL22ri2EzKzJQMiJ3RLk4VXM345Ze+xmYpE9yCgpY3jxqcbFWvSOLY4zMVsHXHfU7xjQQMf8z72Y63P84WWtccLnBsdX9GXwb2azHphJ9bbb5KDgGpOLEcrgs3bvbhs6OJSYGdWpfbVn7Ts3nbfqfFJX/bxj9CrJIbxdq+N7qyBQX16RyBcdX6LUqV/7ccEJRksmyLHVQu82avsBuGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quiPIy6wMe8z23pZP7p28aAe2k8z7cIkXiaklGSzG+Y=;
 b=APo6PPJ7y2ty4U7fMRLebfR1XoKmCim3UecCoGgB0m72Iit1fWPKqn7FtUV3MhYOD81WK/EULKSfI5+WVK+Tef1qUHHjlB/ybNti+WNsQcPE6BnQBGmSUE0x1JhxPohp/PNhhevfoiPS5tPDxR6C6udgU6MF1IIGuKmNUvaenOuDdxQh1dVnRwOhNFBsWYJVc7Z0oWLX8Ogrnt6LMUiGwNnqSvkRXPYXJMQv6kWdYN8L00aL1iAM054+MX4hxkXlK7ropAicYP703KlIUpavAF+ThmNx6Hu2rHE9hVfQpejqu/XMffO+AYhFkuyzRPqYUnxh8yj1/Cu8QCeDPLPu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quiPIy6wMe8z23pZP7p28aAe2k8z7cIkXiaklGSzG+Y=;
 b=fd5mweIvmaPilwrfQXXw+1k3k+rcOfw27u35qlf+nzoZgygJkYEqdvWw09E+wEeNlOTqSHvx9W6fz6Z/C8+UpWUCYnFqANp3lB4Yuv1FrSwgrIjdtobaiNmDUeVBQ9nlaI58IvFbjB2CM5LIse8C1qyldUSMRF5wOBff2jL2XjrAoPNAqXxUOZ6/bYLDwCsQff9YupCDo46Gow7gdfXaMYixMq14hb374ELe6WMPDcc35nJOmhablkGktkwQ5o1wsUEQyCrLoSR+ac6V0tuozKOyHCy3ZevrZp7Y274pnEGau22tPztG2MBAYUEYd2jUCOBQtCFw/aVBm7iQI/Y58g==
Received: from CYXPR03CA0069.namprd03.prod.outlook.com (2603:10b6:930:d1::9)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 09:31:10 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::1b) by CYXPR03CA0069.outlook.office365.com
 (2603:10b6:930:d1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 09:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 09:31:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 02:31:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 02:31:01 -0700
Received: from localhost.localdomain (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 02:30:57 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.co>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] soc/tegra: fuse: Add function to print SKU info
Date:   Fri, 18 Aug 2023 15:00:26 +0530
Message-ID: <20230818093028.7807-5-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dffb8f4-fd32-4ded-2065-08db9fcddb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofvqcEYJQcz+hDLbzZdb6OSjgmqlF4iMUJMWgexNA1k5ddXSrgdWjZDheNz93HrPV02xqwe0e4NwQFyg/0j1h4U/GgJIV/UpSGw+si0qLpNUREyveAZPn+UARDp6RT/9zEIDYn1JG3e7BOkAZ+0l3ahBv9MqibMJMnWhqzv8n/xLX7pZD3BVbYIdo4ENjnHmQIAtWWXA7COhvb11XVEzhNXq5vI9sQYvqg/fItcVXyGQaChOgB4L3GF43j3xzoSZ8pSXIYddMZh7856JmxNic7E6IuCR+OjDQlqrFqr9xWF8uXg7XQlvQKokcLA5mP0Tg+TnzncaAKMiasIhe/GfiDjg4PbuGKCHE4mcpf5YCzLeMPSzez93OBKB67nvLtsm84usu6ftXKvAH+r9pgcQcYoOZy+rbzoiXEH9JTs9Qaqnw3lrRqRQzukfnumRDIZviOEZoChKd8B7ZmeMKd4StdxFuddQcFKd8VjsR5Go6tcmfx+7HIPl+Ss4d9plBUEhvn1AnsCyjGy3dlDPm8Yc+ZSHx347iFIu7y/0B1wr1KYWdylolrgZao6xcuJl52Vtw2d3qaJAXJCRIXMeNWCjQkIi5H05sZzV/lsVattl6AAQf8JM0qgzEOuE1omQd/3CTvhl1Y7N0mqzceWwnF7Y63AVnF1cem6lSY267Lt145w3nO+ySr9vtShAenujoh79A8A0WTC+CuA7ISiHjr8FfQNjXn4pherHci3j4GWFRzcB0X5IPrzWjX67va6R6q4dFmAK7r/MIadUDPC5ZU+ypw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40460700003)(40480700001)(83380400001)(8936002)(8676002)(5660300002)(2906002)(41300700001)(26005)(336012)(1076003)(6666004)(47076005)(36860700001)(426003)(2616005)(478600001)(7416002)(7636003)(921005)(82740400003)(356005)(316002)(70206006)(110136005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:31:10.0855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dffb8f4-fd32-4ded-2065-08db9fcddb71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_pr_sku_info() to print Tegra SKU
information. So, it can be shared between tegra_fuse_init() and
ACPI probe which is to be introduced later.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index bbb1a5c4823b..70e8eeddcbd9 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -166,6 +166,16 @@ static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
 	return 0;
 }
 
+static void tegra_fuse_pr_sku_info(struct tegra_sku_info *tegra_sku_info)
+{
+	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d SoC Process: %d\n",
+		tegra_revision_name[tegra_sku_info->revision],
+		tegra_sku_info->sku_id, tegra_sku_info->cpu_process_id,
+		tegra_sku_info->soc_process_id);
+	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
+		tegra_sku_info->cpu_speedo_id, tegra_sku_info->soc_speedo_id);
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
@@ -528,12 +538,7 @@ static int __init tegra_init_fuse(void)
 
 	fuse->soc->init(fuse);
 
-	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d SoC Process: %d\n",
-		tegra_revision_name[tegra_sku_info.revision],
-		tegra_sku_info.sku_id, tegra_sku_info.cpu_process_id,
-		tegra_sku_info.soc_process_id);
-	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
-		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
+	tegra_fuse_pr_sku_info(&tegra_sku_info);
 
 	err = tegra_fuse_add_lookups(fuse);
 	if (err) {
-- 
2.34.1

