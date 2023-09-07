Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9B7973CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbjIGPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbjIGP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:28:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE151FEA;
        Thu,  7 Sep 2023 08:28:01 -0700 (PDT)
Received: from DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) by
 SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 11:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObeByF7vTHTgFEboUQqY67bN15EhTh2+/vf8ffMJ0SWS6KzKpg8UUNQMDpqPIQkrdJ160ABpkG6IS2mFHK5YzrclYI1EA4jIA45Bn9zP3LdKsQAJB2FoJAWo9pYcCeETdYvjtATafuTvxo8kxLzNVIkUZsBveOADV9mNOUxRVyXLg0ql1bNaW521FrmSBQe4zpCa7Td5XjWfncLdyPFRLEEA/QA2I0MOx67fxEk31NsWtR2myuoOQHVBQhd2Ywj92eBwubSRvBkDBL2cHoUONmQ7Jk92MANSsXSiVMSCIbocbSxDkdsYfh5yAaqR3CmaeyfZh6BPSbsWKGuI7zXHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppq6CO8wFQVbkAdAX17TikKf5eDCdVr6YeJmx3yZrIM=;
 b=mQ82s/pskk3qukETU09bPSl/tS9TvbAXPItZ43LIC0ifU3H5IG700B40Mc2S8xVQxTyruZ+lcEuNlpU3MyihEaPTo3x08RRF/j+16C0o6C9EQaZBas7S91BzsEVXNDWzIscgPiIordlz9l/wZjeSVO4xBZcZ4Xfl5LgUoA4o+KXPOIAJNfT4D1LB2yMrFZE2iGS/snYw4EGSuqVvWY2JhpU4Ul20pHDwwBHrqhyvnTcEw38QukKPORTbbJL3gFvOCn+JF1XUUpxdx8N7i4BW7dzevKFy3iHbvq8Qu4BifkiPqD/UxJyXN2+N7L54NBCpHVogkdTA7+U1ctC0xC+fZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppq6CO8wFQVbkAdAX17TikKf5eDCdVr6YeJmx3yZrIM=;
 b=Bm5tsICucSSToBQBodXg7zoacGgGS/wq7ppf1GoaKxRv2lFQ9gTHv1pzUJMiLuePVOcKqEiAANKajGnXEFoqkBbQmtbb594gMoN7LS1ck7HDKobePkPAhaKiZ3Xbtq71KEMJDtAStrERG47nU8I2CWeJ9Y0b2tVqxZqtwTJ1o8oGW3SjgFRSz58YwXstaC+dPqDT9GaOPlHcxDjgaUN1Q9lGbCzLeBFoqG8DT3uuNazWB3sJCATBWV+1xQAvuBfrXYl2kOyr+JMXgXc/CUShKq1WWJM/A+T7gxN+DM41yUFf/ID6NdVB8jFiGsc2OuEMqHeORq/TXMWqSutc5gfhlg==
Received: from SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) by DM4PR12MB8475.namprd12.prod.outlook.com
 (2603:10b6:8:190::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 07:11:47 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::1e) by SN4PR0501CA0112.outlook.office365.com
 (2603:10b6:803:42::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 07:11:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 00:11:33 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:11:29 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] soc/tegra: fuse: Add support for Tegra241
Date:   Thu, 7 Sep 2023 12:40:52 +0530
Message-ID: <20230907071052.3906-7-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM4PR12MB8475:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ca552b-92ab-4293-6803-08dbaf71b317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xxnx4CDFwfCxiHntuK7f2hO2XMOIaJf0Om6MEeLAWnbh3jf0Vnq2yflrW/bG4HUY66fUfG7mi1b1QZxVy7sWe64RfWzIiSXgY3d/obzK78ezxr5nqCTJQNMNtv3y5lWQKYKaIcSmOMiFYlNLL+1iORhMlc6bZgtB5wXROzwbk5W88EyjucNMqNYywScVVUnJCdhVR2xrthr/sDzJDIUNGi6LMQozh92wx4NxAPl4eIpoj3h2NAfx2SuFmxAokRcAwLn3k2wrdgRgExW9/eAYLOXTpvnurT+smxXmf7Gbh3zFh4auWwQM21uE5L9O7+dfg1kBwtJtwwP+nN+Qf09LIxTWrrekXX15QVNJqFnnyaBln3rBAWoVnrTGHRMkmo3vIzkZ/mwgIATKqqEHMCAbE8TykoS4Pi1vnQxSI7scKHUeSRxWnxdSOMLtlpisXPwXUq3ygrHqdWN5mhYQ4J/UUHvLRdwWmi9xfqeMvMMM2a4GAVmfW580dbSEq6qVQsA0lmIVd7LXASuVo0j7whZGfiWLfG7PhiF1dZPwja4rWnhHAy5R+XEfZ3/0S1+jG/PkYIVwF/VMlM8ToT/dmm9yNq8I1ufkHhgryxQpCVSrBlCwBElyCZr1suWVcmmllLBA1brphuiETqZgvrT+TTo4DkMkcH0ZRgzkOa0abF+QiWmLQh1IfpsjdZG79c/+gzHZ2zClCyvV35Sob1rtiuu5qJe0wlzrN29+r+wGPwblQDqC3Zq54+1fzWYMgxbB5e6WsE3W4//uRGHu+s1hZYHjEA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(5660300002)(26005)(70586007)(316002)(70206006)(110136005)(41300700001)(40480700001)(356005)(82740400003)(921005)(7636003)(6666004)(1076003)(8936002)(8676002)(2616005)(426003)(478600001)(83380400001)(336012)(2906002)(47076005)(40460700003)(36860700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:47.2471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ca552b-92ab-4293-6803-08dbaf71b317
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
X-OriginatorOrg: Nvidia.com
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Tegra241 which use ACPI boot.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v1 -> v2:
	* Removed few entries from tegra241_fuse_soc which were
	  initilized as NULL or 0.
---
 drivers/soc/tegra/Kconfig              |  5 +++++
 drivers/soc/tegra/fuse/fuse-tegra.c    |  5 +++++
 drivers/soc/tegra/fuse/fuse-tegra30.c  | 21 +++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h          |  4 ++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
 include/soc/tegra/fuse.h               |  1 +
 6 files changed, 37 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 6f3098822969..5f5d9d663fef 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -133,6 +133,11 @@ config ARCH_TEGRA_234_SOC
 	help
 	  Enable support for the NVIDIA Tegra234 SoC.
 
+config ARCH_TEGRA_241_SOC
+	bool "NVIDIA Tegra241 SoC"
+	help
+	  Enable support for the NVIDIA Tegra241 SoC.
+
 endif
 endif
 
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f35f9651a653..eb11465e8092 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -172,6 +172,11 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		case TEGRA234:
 			fuse->soc = &tegra234_fuse_soc;
 			break;
+#endif
+#if defined(CONFIG_ARCH_TEGRA_241_SOC)
+		case TEGRA241:
+			fuse->soc = &tegra241_fuse_soc;
+			break;
 #endif
 		default:
 			return dev_err_probe(&pdev->dev, -EINVAL, "Unsupported SoC: %02x\n", chip);
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index e94d46372a63..34fcc23a6449 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -678,3 +678,23 @@ const struct tegra_fuse_soc tegra234_fuse_soc = {
 	.clk_suspend_on = false,
 };
 #endif
+
+#if defined(CONFIG_ARCH_TEGRA_241_SOC)
+static const struct tegra_fuse_info tegra241_fuse_info = {
+	.read = tegra30_fuse_read,
+	.size = 0x16008,
+	.spare = 0xcf0,
+};
+
+static const struct nvmem_keepout tegra241_fuse_keepouts[] = {
+	{ .start = 0xc, .end = 0x1600c }
+};
+
+const struct tegra_fuse_soc tegra241_fuse_soc = {
+	.init = tegra30_fuse_init,
+	.info = &tegra241_fuse_info,
+	.keepouts = tegra241_fuse_keepouts,
+	.num_keepouts = ARRAY_SIZE(tegra241_fuse_keepouts),
+	.soc_attr_group = &tegra194_soc_attr_group,
+};
+#endif
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index a41e9f85281a..f3b705327c20 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -136,4 +136,8 @@ extern const struct tegra_fuse_soc tegra194_fuse_soc;
 extern const struct tegra_fuse_soc tegra234_fuse_soc;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_241_SOC
+extern const struct tegra_fuse_soc tegra241_fuse_soc;
+#endif
+
 #endif
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index e2ca93de6c1f..c72bdb3e4e2c 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -64,6 +64,7 @@ bool tegra_is_silicon(void)
 	switch (tegra_get_chip_id()) {
 	case TEGRA194:
 	case TEGRA234:
+	case TEGRA241:
 	case TEGRA264:
 		if (tegra_get_platform() == 0)
 			return true;
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 3a513be50243..8f421b9f7585 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -17,6 +17,7 @@
 #define TEGRA186	0x18
 #define TEGRA194	0x19
 #define TEGRA234	0x23
+#define TEGRA241	0x24
 #define TEGRA264	0x26
 
 #define TEGRA_FUSE_SKU_CALIB_0	0xf0
-- 
2.34.1

