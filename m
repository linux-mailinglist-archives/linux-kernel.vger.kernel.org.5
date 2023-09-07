Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAAC79781E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbjIGQmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242250AbjIGQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:41:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB07DA5;
        Thu,  7 Sep 2023 08:43:19 -0700 (PDT)
Received: from CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 11:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie1zl5kHXOSTDI4GaMnvOQ/btsrEsIRIDL0RSOsOYNntaLlOEL57lTLMz3AFTH9xwKvSherwTtM5QspE1RnIYTPvoC6CUT+fCFxiRit2FcYr/v4vvO7lavRAk/EJO+yKOQoOfkZjsEegRYXLzUEvs1027Wv8JZxMoZ4eF10KyAUYs0tLYiTtlbb8IWcjuZAFOjEQmT6OOaScymhMvYh7ZP03w0UGn2hu+MXiF70ylxIywtah1QeVeaJEej/4/+sn6LPuFlJ2Mn1OIMTeDkIOCBGdlVuPQ/KLM6fAQbKEV3QdllpmBMZo2XTt1LWC9YzGzQMKeHgbZQkneR+K8upuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6yM3VE0tv5pQ8BVuS0AJ1/7AvdPZBH/9zuRr6rl8aI=;
 b=I4LavYW7aEi4GCaDxuVMGJ320unef9/dO3hXpjYErDNn9zKv4t5cHcBO4nfZq4uy9/mmAGQ/geufZ3vPQtFZ6lWU39ak8ZZBLjir00ItW4jdbMvyJGBjTQaipe+Oyee1QPiTXR19j+GKnJfIYmY0QBlSWUfkCUL7ZdKRg/yxe6md51i9ZiDK14byJf9kyLyV0sj5Qx1AhqhegZy9xwMjwW621cT1ART2BCG188D1eaEwNCq2MH1U/M7mGmKuvoEceyB55y379PkmRNucbHX5E7n1R+EBh8zOegaBRWZL9d1ANV5vvFOZeMzeeyPtEZQbtWsRO5jhO881re2UeS1ZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6yM3VE0tv5pQ8BVuS0AJ1/7AvdPZBH/9zuRr6rl8aI=;
 b=Maj9u6/vkXoggI676UfJks1ckLGAVAshn3VxqeBl+Qw8x83GKl3jCi1iekTdgicV3nv85DposPBBHuuvBq61UTp4q9qqm3UZe1EKcqRIhk/yNMPyZNW6RwxcyFz04j9ckg0rr6zQ8ttochBocTni+sxK/gcjuIUF8cJmQdHHSmEP0AV1q1hZLdlY0vNV4uSMOo14cF8zmBtag37gXoVALoku2mFDt+VxXxtScVS4ytqDgv3OJjVLRCTIr8azs99riE1qaOn7ky1YD7AwM9s0csVIIPJja5gJv9+mhZWYKP0jjWtXT7zeeb4eXrK03XgwZgXgDXCblIbkxmotRpYVAA==
Received: from MW4PR04CA0206.namprd04.prod.outlook.com (2603:10b6:303:86::31)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 07:11:34 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::96) by MW4PR04CA0206.outlook.office365.com
 (2603:10b6:303:86::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.1 via Frontend Transport; Thu, 7 Sep 2023 07:11:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 00:11:18 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:11:14 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] soc/tegra: fuse: Add function to add lookups
Date:   Thu, 7 Sep 2023 12:40:49 +0530
Message-ID: <20230907071052.3906-4-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH2PR12MB4890:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 10586d9a-3001-4a03-4311-08dbaf71ab07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbNZa+mRRqbLsOC3LENKn3/PiG8tHFrlRcxW11j2rOEs8Tk8BfJxA+Njbl1gLTMxoH7xQ4epBw2ilq2qZLCtOMjKKKCj8K4LboH3+Az8QSHgGm4UyNEzQQODN59V3SDk3V+qOiPKkV+QjLXCw6PlPP9Jbjf/LK9/oGoKLR+Vw3/NxgJ+GvdKTYaLrppAt9b+rtulM9IDh6C9letgzLm6sCVkiFtzhtMHhuh1tRBaf+j/X5+qyMQokx964iiJmjPskrSOPxswBrN1+i4dcgroDTflF0JYvkZ8ts6vPqhWdcUz3uBn9mwvjbz0jD4iB/FGN5+5NIdUcRHAZt6FXX+UwsU96FOLkbC7QRgg/FMvN9zCKki+z4h0yHGAIl+oknUUxQlpC4yUsB9zChkXdrr4oH+lhIhKjVnxZiRmxpZl7jam3PYoRHpUgkGFEvJMhp2K46Id+HBPoQQBb8O5JFH8YYkhU3DwaLaP3Z12LkU1XEisi2oQ1LoabK5niKoYnpIPVvmzRm2QTc0B2QzeqHqoyNjL1SNn+pD3N4rHnMPTcFexiyoXWc09VyX7rAcp9wsxaquklvGxkp94cKcI3JBQTzl37g9EsRHmn65VQp192eF9d4Qo21HqUvDBYKT2Ll1u75Cb8iH5HEgp9GliTbOggg9nn0orGgdNfjJFOtcmYEb4C68JWs91/deXPWn1Ciz23iC0PJFKr6G8eWu2HmQkzwKKEE3hvR1RUIEIl75cVcGapNP3HemKPsShukQTWQoV5iK2mw1iM4dv82bva2wSHg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(26005)(6666004)(70586007)(70206006)(110136005)(41300700001)(316002)(40480700001)(1076003)(82740400003)(921005)(7636003)(356005)(8676002)(8936002)(5660300002)(2616005)(83380400001)(478600001)(336012)(426003)(2906002)(40460700003)(36860700001)(47076005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:33.7039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10586d9a-3001-4a03-4311-08dbaf71ab07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
X-OriginatorOrg: Nvidia.com
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_add_lookups() to register Tegra fuse
nvmem lookups. So, this can be shared between tegra_fuse_init() and
ACPI probe, which is to be introduced later.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v1 -> v2:
	* Use size_mul to calculate lookups array size.
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index a2c28f493a75..821bb485ec45 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -113,6 +113,24 @@ static void tegra_fuse_restore(void *base)
 	fuse->clk = NULL;
 }
 
+static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
+{
+	size_t size;
+
+	if (!fuse->soc->lookups)
+		return 0;
+
+	size = size_mul(sizeof(*fuse->lookups), fuse->soc->num_lookups);
+
+	fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
+	if (!fuse->lookups)
+		return -ENOMEM;
+
+	nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
+
+	return 0;
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
@@ -407,6 +425,7 @@ static int __init tegra_init_fuse(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	int err;
 
 	tegra_init_apbmisc();
 
@@ -504,12 +523,10 @@ static int __init tegra_init_fuse(void)
 	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
 		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
 
-	if (fuse->soc->lookups) {
-		size_t size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;
-
-		fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
-		if (fuse->lookups)
-			nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
+	err = tegra_fuse_add_lookups(fuse);
+	if (err) {
+		pr_err("failed to add FUSE lookups\n");
+		return err;
 	}
 
 	return 0;
-- 
2.34.1

