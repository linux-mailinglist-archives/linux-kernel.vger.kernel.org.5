Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A498797401
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjIGPcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjIGPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C0F1BE4;
        Thu,  7 Sep 2023 08:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0GQiYjyCBfteWehSCBzBXcMfFFzl/C4/xfrc2un7nZyhntI8QJODRf+zVxMciuNtYAoSD/iTYEV6TOztp0Ef3C6JuTKTq9wh83QtJpQVeA5IyF3HVI0EkHWwMPUOYSnQNkOqhYdYtbAcutIDdspB7aInxckdwDsIVoWd6wiqnU6BqLIbi75O57Wg0UgB0ObMZSUoPb3OCgZh7Ym1lHr36+yu9qJzh+OQ9YGVmXDIx+Jek3AaSqhrtNU8WsomTyoFM1S6OWX8V7FR6LSzRiqxHDuVzQbUskhA816NQgUz7weDtQ3quAKrIYTuaC430qgBPCzlG1mVK771lnvprOnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+Fro14rgalH/06qabhLwOLhxQnp+Tg6JsjLLk27Cig=;
 b=d8nouGHqxgY5DP9hCzICDOUxt4AZ9eCSNGMNPQrEA1AYLu2YLMkalPX+YxOXoqZug9zIyFAYjx6j+YUnK+AwBT6Ydj2Ex/AEpacqJHKHAgNqBj9QqxBm4uez1ozyF9jJ7xCOTBmS3kjgbIqm8prZiCyjGgrg9X6nUaQ4k5H6MeBolma0+BMAQqbzUvBg+ZWy9mT0CcvXqCMOuYkuJ97RyzxFN0EOP9Ag2wibosIsdbm865urqio8GRh6a3fIy+jgDrdUJLzywUslOUOmtXDgcT8T0tJsdym7bjK+QVGA38au/7D9TPErejDFmc1mxD6UqsL9hwbWLQy+n+4vUjZJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Fro14rgalH/06qabhLwOLhxQnp+Tg6JsjLLk27Cig=;
 b=FI5YYvmynlRfLsdhPPkDOvw+w8Q0HwcD/+tmBHl4/MDC8iHl+48iM47nCFrCZJluKYBjrq87jhaXixd5SXOkqvkaVWn5idknyEQ4hDzDsQAO8YBOuYNgztCkSvVJrqS7u1s3rWuaM62UJL1YB1CSV+ZAe9pmE3cH7PZcaT7o2uQ5NSD5zHvoukjumXgGmItHzYs5LgdJFdAi1WDTq5sqYp4eXcpnH8ynFvRou4PHYLDU/sANfkRtpRpzZUQoCV70S3TTK5pkGZAYe33tkMP5+niCFa8IccHWQmbH8EGG71AEshBXRcyEQhYawvnwURq+unReRBEyZqnFvbcNgN+dwA==
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:11:26 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::db) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.1 via Frontend Transport; Thu, 7 Sep 2023 07:11:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 00:11:13 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:11:09 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Thu, 7 Sep 2023 12:40:48 +0530
Message-ID: <20230907071052.3906-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907071052.3906-1-kkartik@nvidia.com>
References: <20230907071052.3906-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: d2395b22-e498-47ca-3d45-08dbaf71a688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gcPo/qZ2JRywCWbO/45FR5FLceWjT9gcwgkNam/u2iduH4sJSK7rTRrzNMRgsaB55NAOQlaxQH+h4238rGkXFqcKc1K0CVhwBN9KFGmVUX2GDDVimVb1nc0mPiNcY1fHwC75wGFBpchy09BklVfSHuHP+cA0bNPTxkrWCNaWVdjIa9kqQH51+yNnZwr7eJ5KGy49YexQ1XqvZxTbnwrZat5nemiyFXockX4HWszni4gnSqa/IpBEU8hf3f5wCEGHfxeYhdvWKb3TDJA7dQT7yRXCXSNokjnFKLh1Z6d2hDGDLkL1Txfgx9aj3LnSkbuU35jtEyarwc3TaEGvcVuT60FHFEUDfcYry2+yhXfxE745ceya4FOM74eZXA6ANmyL2e2xKM67/iReeKYAlN8DoSfNMj99V1mK64nejAViakS7OIm3nkWEbdYteKNEFVh89ZqKx9xBR9eZ+fzklUD/gONKSvQCi1yFDZnuFDcv8rXFsaqDni9eESPFUYCse9LrOT9/Lee2kUOJCpmBvrUW8vT6xlU4BXNn3T+sLDlIofri4BdLlO1DKqB0idFYi5DhWhyISy6qmjlYd/vFhbejEe9YosWM0c2FfRsj+VmiujymBlEckis27y/McSlzjWwwEC6uKp27X6YYh5SqCOsFk4huCBBSoeJEQr0WCocYceDOaM/3vw98aQlVnMhzbe0LZaVZznZBVQOXipPMwwrFvsuehxAyXml8XOUBjG8py8ZbcHCcQ3DeYDUqMxK5gQV
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(478600001)(6666004)(110136005)(316002)(2616005)(41300700001)(8676002)(8936002)(26005)(336012)(426003)(5660300002)(83380400001)(2906002)(1076003)(36860700001)(47076005)(356005)(70586007)(82740400003)(921005)(70206006)(7636003)(36756003)(86362001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:26.1606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2395b22-e498-47ca-3d45-08dbaf71a688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to ACPI support in Tegra fuse driver add function
tegra_acpi_init_apbmisc() to initialize tegra-apbmisc driver.
Also, document the reason of calling tegra_init_apbmisc() at early init.

Note that function tegra_acpi_init_apbmisc() is not placed in the __init
section, because it will be called during probe.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v2 -> v3:
	* Fix build warnings seen when CONFIG_ACPI is disabled by moving
	  tegra_init_apbmisc table inside #ifdef CONFIG_ACPI block.

v1 -> v2:
	* Update ACPI ID table 'tegra_init_apbmisc'.
	* Add comment to document the reason to call tegra_init_apbmisc
	  at early init.
	* Fix an issue where acpi_dev_free_resource_list() and
	* acpi_dev_put() were not called if
	  acpi_dev_get_memory_resources() returned 1.
	* Update logic to fetch memory resources in
	  tegra_acpi_init_apbmisc().
	* Fix build errors seen when CONFIG_ACPI is disabled.
---
 drivers/soc/tegra/fuse/fuse.h          |  1 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 72 ++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

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
index 06c1b3a2c7ec..e2ca93de6c1f 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,9 +3,11 @@
  * Copyright (c) 2014-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
@@ -180,6 +182,12 @@ static void tegra_init_apbmisc_resources(struct resource *apbmisc,
 	}
 }
 
+/**
+ * tegra_init_apbmisc - Initializes Tegra APBMISC and Strapping registers.
+ *
+ * This is called during early init as some of the old 32-bit ARM code needs
+ * information from the APBMISC registers very early during boot.
+ */
 void __init tegra_init_apbmisc(void)
 {
 	struct resource apbmisc, straps;
@@ -244,3 +252,67 @@ void __init tegra_init_apbmisc(void)
 put:
 	of_node_put(np);
 }
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id apbmisc_acpi_match[] = {
+	{ "NVDA2010" },
+	{ /* sentinel */ }
+};
+
+void tegra_acpi_init_apbmisc(void)
+{
+	struct resource *resources[2] = { NULL };
+	struct resource_entry *rentry, *tmp;
+	struct acpi_device *adev = NULL;
+	struct list_head resource_list;
+	int rcount = 0;
+	int ret;
+
+	adev = acpi_dev_get_first_match_dev(apbmisc_acpi_match[0].id, NULL, -1);
+	if (!adev)
+		return;
+
+	INIT_LIST_HEAD(&resource_list);
+
+	ret = acpi_dev_get_memory_resources(adev, &resource_list);
+	if (ret < 0) {
+		pr_err("failed to get APBMISC memory resources");
+		goto out_put_acpi_dev;
+	}
+
+	/*
+	 * Get required memory resources.
+	 *
+	 * resources[0]: apbmisc.
+	 * resources[1]: straps.
+	 */
+	resource_list_for_each_entry_safe(rentry, tmp, &resource_list) {
+		if (rcount >= ARRAY_SIZE(resources))
+			break;
+
+		resources[rcount++] = rentry->res;
+	}
+
+	if (!resources[0]) {
+		pr_err("failed to get APBMISC registers\n");
+		goto out_free_resource_list;
+	}
+
+	if (!resources[1]) {
+		pr_err("failed to get strapping options registers\n");
+		goto out_free_resource_list;
+	}
+
+	tegra_init_apbmisc_resources(resources[0], resources[1]);
+
+out_free_resource_list:
+	acpi_dev_free_resource_list(&resource_list);
+
+out_put_acpi_dev:
+	acpi_dev_put(adev);
+}
+#else
+void tegra_acpi_init_apbmisc(void)
+{
+}
+#endif
-- 
2.34.1

