Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6A7C9ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjJPFeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJPFep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:34:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84993F7;
        Sun, 15 Oct 2023 22:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8CvTD65LUD8MyWcR2q3gonBCbXfAcNOrS9VYwv2HMzyDaWUyCjm7VqrDJCSobk+f9cQPH/vEUbjPa8z4RYzb5IXuFrOCi7bvpSROz9iZA89ODK86T1SV+8+154F7EOPUMbiN5LC9gq0VU0n2PStXPcPLG7j/+FGh3y/8iqoer0Dm8IptuSiItSY4UP14jrCxs7kFl+Z9yrXfRXmrtNbC8E1Tlz/RG9Pgp2mKQozKKev8hi/SrJjti5HGR5+gu3wZhNCSp6oNHLMaqarsE3z8r+S6LxG/yZ0nZbExqwKRKgQO1SFXAL2WHpsMSYBtigB91PZIEWxm1L/7BpgmeLXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=mamLsGc4sQXGfXU3fvBtlclFn+hMi9J9fVSOGZ51vInwG0Qo/VdL8x3iOOA41ZdKI/p2qGWe5VzYx8Suq26DXVfFfalG5dfpGR6zAUs96tZ51H9gllxLO/4omu619XoFTN4jpvAac8SlwDr6csFCeR8hebiY6En8sLEvNFSs+3A5hTAngHFm8LiZZUfEXb3luTOD4T01j9aKdvICvLbGo9RPbG7WSsa2fNyRI6dlEKrDOyBqctJ7cFU0gM3YJu1DcN3Eyv1JA5PeWhm0nP4rV+c4ApVc7b4pxbtgCHE+DkSuqLsaJzl7XEJIsvhC8CXhKr1bfqYwIBKRmuDVbeFOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=K+GhkQxbcfKSNRGLK2HBCC+W3h6ffp88FVuxE3dcImy+FaOURQ/MPE5RLcllQr4XPLTSXzXuBicfaOorMZdXcWB4zH9fQCI3zrrwbeQ97RPF/TJ1BseAH/GQVxfXSXF8HTnT5WSOk+5FEXbTpeh81R+e13TNKUDgfsPzIJET6bU6j+tYKny+0GzRnh00muoBKMWKjRnku3t/cIaeX8CeoBON1WTWVix1MJLvXBvUWVt9KD+hrGbESwJfzifGSTvl1XTxv+10sH/gk/YsD0KQKbgTTqjfLpmd05ZldRSasb4HJaVsFBPEnM6Dx/A601JOMycVCfSnVR8+tvkCzxTv6Q==
Received: from SA0PR11CA0086.namprd11.prod.outlook.com (2603:10b6:806:d2::31)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 05:34:41 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::b7) by SA0PR11CA0086.outlook.office365.com
 (2603:10b6:806:d2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:34:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:34:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:34:37 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:32 -0700
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
Subject: [PATCH v5 3/8] soc/tegra: fuse: Refactor resource mapping
Date:   Mon, 16 Oct 2023 11:04:06 +0530
Message-ID: <20231016053411.3380-4-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053411.3380-1-kkartik@nvidia.com>
References: <20231016053411.3380-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: c31fbd33-0181-405b-5e6f-08dbce0998ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AG8YG7fENyNvGKJaTkKKwFAnu66pRMOcQVhSaXZypKL9hT3KqYrl3tyHBgt+kG7XGuF5cRR6pLXP+zlOs7eqZ5cT4vIHNVUJDY5veHSW50pW6qWFw2C81Tox4TcwZYZ7HD2KI9WK1JzeUpuJeJYuFVFNmRreoPmpGRzrh7l0BYfrtnEYsrz2RKD7k/kJM6jE2LLJRkaGxkvLjC7ZHeD3fosobslClm3MsU1J+ykgCG3+4phCSt8xepRuImV3oLibt2zLIQsjslmhBmbIJaNoCKO4GttAIyh2yeB1CyavfFzimWaeIWNEuClVKrXOWr6pnW3hAO04q9Z95bpq29nBwuz9CtbI2P0TMla22RlkR+Y/s/GuM5MXE4YN/LQRKsxrksJ5qAJkh4vdWYpEZ+qM72F+zskbmqvDRII3R6d+OS2PoBrPigW8Iu1F1ZhmmK0dHIBFU3B3+SvJyphtt8XRKP+KMP/16Y6n9OHtHuvNtgjLmMzYDRkCr0ZI6Cx+UgOqcBQLpmX+Ql9M+6AL1v2DASH8SQyLq/hnzPcH/TWr/d5DFx95LKCOBPMrgwF0SsCUa65q5NuK99+QEfneDfEIWRA7MtPQh77K3dmLHXPF7iuri0kKOHGUOZZAKByNLqy52M9G3JmrXUZbloe3ZX9hV/KOGCDGIu3xprGdmmex8G6T9sUeVQY0KSLXB4RGr2eR+6PSvasFcMTmHNQjUMpenr0O1CzN9IWtS4pmNnYdMVD5b0hRi1p0Ez6E4ry2bdHJEWCC7gxrUAHKACfT21CNh/v1R/QESRqR+cHuLKISoCYkFTHnPMRzqik7tROIm7TI
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(478600001)(70586007)(70206006)(110136005)(316002)(6666004)(47076005)(356005)(921005)(83380400001)(36860700001)(86362001)(82740400003)(26005)(1076003)(2616005)(336012)(426003)(36756003)(41300700001)(5660300002)(7636003)(8936002)(8676002)(7416002)(2906002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:34:41.5339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31fbd33-0181-405b-5e6f-08dbce0998ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

