Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69812792C25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354213AbjIERHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjIEQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:46:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198AA44B2;
        Tue,  5 Sep 2023 09:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt0c6hklP8/VOGrxitN55VNt3lfI1r1rWDIuwoShYADWQFkOjVztGYkApDl3+Cu9FIS4LfqIEkBGUa8LED7c04Uq9D/gEVKpNDBa+XNUUQBXLsn+LsmJzVgMqgj9BYSLLY0Iy3O6KfCDmF9bDAbSg0EAV9GAAd3OXDi2aC5oASOrbUB86ih8gujGvZycLXrbDGUOxtoXQKF8Z81NA23xzQReB5YJUCz59R63I1dyEjP06/55bTQJzP521D4r1wnOoLqBSENuPIrKAe1c+SJ7SUuoxZW9/kyZUK5eSNcX1dkazUiPLKPqwfCI7qsO6s2phJT0gTQaFXhN7YL6X6uUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGa+F45dRl1GhgDFs8eZ9qml8t/WIYcdx45wv/RJ7X0=;
 b=cnTZcLQLUyBBcBxn2GvG9PNc/3mIMyHvpctip7iKDROKHFvuo3VBpKqQYcbJP2uOIYIohMR5CoOWDXUJjhsKmFkedUxXlbCr8s8C+3EnJWxSnJz02dSrFlU0ssS9oIzPCeRZBA6bTcxAGgI7FzWTMW9maqoIh5v0pl2AoAkMwPz6nUDcdjMFiLIuPSWc9z4ZxeHORkdE3HNJDhe8j/D8S8+t7PI5WwdOVKjcfM9zMQzkS0NVsNr51Aq2oEKCXxpnHJDLSJz+qR0D2M5t87jadi+FxB4jdufM+qrH91D51fk1IUhqCaqvKu5pZZ5wdGXyKgHn+VMVbTJNzwEdrPncPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGa+F45dRl1GhgDFs8eZ9qml8t/WIYcdx45wv/RJ7X0=;
 b=cIcfipu9WF7/PD6ddIfq5J6aShj+ze3FUK8AfiFXOj6Fi1/NIhSi26bUXc5090pRx953CWY1xkrd2gk+uSV6vy/R/KKq0LCokF8mk4buR/vZDPrAy0lB3rZMkUjz4pBny14C/73vRbNctSDlvNMamE3ZQE5h62nDkfQ1u1ipBgWmIYUlAvj+C5xWE2YFeJq+URqJpxwZBDXS7Sb9laeTKjjG8txI7FQ37ngp+g6dLF4aG3g6rmwxY77bPutjclKaB5VwbqUuhTfKKupBCKHlyptFFPJ+l5Mwcg2lFzpKY69Uw1j+mYkZPV2HyWfVO8QwnBIbd8oja8mk/U30qCw31Q==
Received: from SA9PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:21::23)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 16:36:36 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::23) by SA9PR13CA0018.outlook.office365.com
 (2603:10b6:806:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Tue, 5 Sep 2023 16:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 16:36:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 09:36:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 09:36:25 -0700
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 09:36:19 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Tue, 5 Sep 2023 18:28:20 +0530
Message-ID: <20230905125824.2947-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905125824.2947-1-kkartik@nvidia.com>
References: <20230905125824.2947-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 32276f45-38a2-4ee1-9c7b-08dbae2e455d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJBUozi51uJZ0jmdv8W9nR3hQD/XPCGC1HZzomdhu86bM7XNoEweDJj20ZUqmWdbTFas5w+aeBP0uKlbEBmd3lMnFQXXOLzATc1rC8QAl3ykDWMvgmE3UZEaoZUHIFVG/2EMbqZg0Yl2e+McTsQFHk/RA2CHd6OsBMhXMJATwefCm6WF35FwmjTRuNxN2zZwdfhFYcTs744smx+8NSxA8IblxukJ5FyTN9mc/N3LAXeeyWy/ETioNR57NXi6jVh4vXKwQKStSV8PenX2Pm4EZjRlRg4Erbsgj4b7Y+9N8ws5AO/0Jh9z9wnTYXqHBetxKe+IXEWFW3xYZUtMwK6bpNdlvwXAey3nJHgweEVv6WDLnHM9acDdE5xE83dXt6NAm31+sdcGeoj3Q9mHHp/eFxEwcC+OKSqLtv7qu3iXmzR+YuLqcaWEuY/cLwNDg3TP8FMOSckuXoLGEYC/vbuy9enuks3u4DOrbBaDyihlQO1dPfdrnQbYQHdJFddqoH5BVWrV+DfJnouqDJccxB6hufYSKoxqHBKaZ8PKKhfEsCDIagYQ+UPRLG0xBKxFwsBoh4vsy7z4Z6/eL4pf9jgroYTP2mm3JurDJriXjVVx1O/WBAvNInqH/ubIlgNSCZ6SDz9w5x/+yiAZTf7BD0T7Yj74KeoIlZaYr+BcyLJdiOcrBqcrryfGwITkOpEVoqoPSwlW0RQ1XUxomnk2Jf2TAeuka6/+lFEAYG8/RkJFSiCGT1q97GXvR3RyeFu3p4Ji
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(36860700001)(40480700001)(7636003)(82740400003)(356005)(921005)(5660300002)(36756003)(86362001)(40460700003)(41300700001)(47076005)(26005)(70586007)(426003)(70206006)(2616005)(336012)(1076003)(478600001)(6666004)(110136005)(8936002)(8676002)(316002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:36:35.7298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32276f45-38a2-4ee1-9c7b-08dbae2e455d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to ACPI support in Tegra fuse driver add function
tegra_acpi_init_apbmisc() to initialize tegra-apbmisc driver.

Note that function tegra_acpi_init_apbmisc() is not placed in the __init
section, because it will be called during probe.

Signed-off-by: Kartik <kkartik@nvidia.com>
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
index 06c1b3a2c7ec..ce8c3c25b6a6 100644
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
 
@@ -128,6 +130,11 @@ static const struct of_device_id apbmisc_match[] __initconst = {
 	{},
 };
 
+static const struct acpi_device_id apbmisc_acpi_match[] = {
+	{ "NVDA2010" },
+	{ /* sentinel */ }
+};
+
 void __init tegra_init_revision(void)
 {
 	u8 chip_id, minor_rev;
@@ -180,6 +187,12 @@ static void tegra_init_apbmisc_resources(struct resource *apbmisc,
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
@@ -244,3 +257,62 @@ void __init tegra_init_apbmisc(void)
 put:
 	of_node_put(np);
 }
+
+#ifdef CONFIG_ACPI
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

