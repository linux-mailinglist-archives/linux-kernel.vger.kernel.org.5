Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F58049A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344283AbjLEGBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjLEGBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:01:12 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C1C0;
        Mon,  4 Dec 2023 22:01:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUFfgkB3KhAo/JxtdZKmDv4N9AfLJptAAfh2lMDQv9Lv5xqvNx65IZmjMRQY2Qd8l61BkdgVuev2eW9IznJ+83zG4i0scD5qYZTKFC/0piX1LnNld3MyJXS6mqu8UtEPQiez5bdRGzSMRZd4glgkpTtafg1HgLzBUhP7SyZG+uPlncE+lPOg9c84Dj0BQ7pmbL4apJmPr8kxhMvogvMEDNdkkqVxpc0myF+a+xluiDYO6nY8OY15QMonFe5pidtjdHLJGib5Sude0qO5guKulEgl1Q+PYh6v+PJkJCxK6jjsEd2ATayn3ndqz87v+cT/gEnOSjZoacXxUnW2ZNZpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGDUnf3thIZTWApbl3Q/eLgKEzL53lbGx9rbLEskH/k=;
 b=bNXToCwsOqTynqTlnmMrxlFxULLRSMuJr82c2wHeyDQT2NSguJCyH1W9NKrobAM2cb2jZzyHjyL/nBOujj0fATgR6E4O5dwaFEpjZn8cJFCM3FslR20En1XwGMpoAeGjbFI0Am4yJFP3C6wAdDS6OHACrHS5NIw2P1jR/RRBvpvQp45M5xiuFCSwL06n2b0fu3CB/yJhq8FSuqWhilQBNhXo2jRYozvffJjcpHw9m2ksmk9Bdu8fnfBcT3isX73XaWx9jjM+lXW0camoi6TIrEn5MeSUiLLNsBSLewfvoF7hBzcineDu1QbCDIsNApKDXS/rSsuGp9eblARHyQsfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGDUnf3thIZTWApbl3Q/eLgKEzL53lbGx9rbLEskH/k=;
 b=PVEw7jCZi8+7VFOdfJseoyOzqKHsbZVihTfxtQJrTManjMNCwrqs6QC8GxyIm+LL06SPw7hNQ2ZJ7Bg7oCYtI2iEWqMa6vqDvYVbNzEohZWi6guhQsYrfZfh8lb0uidUYxFOhfK/yxJdtJGnk5X+54PYWV4uh43LF6UMxEMOR3nCSIvjsDMcu60UcqV8xUI2jO+mJ4w9GaUL9hc7Rb0D/7BmozM1Cf4BEQzYeKA06qNbm3JTtpUGCDK81pitlBqkjRWtsYa84UIjo0argL3N+26Zx0tlu+ZA6W7HVHHnprA83P4SWvG/Slyo+DXRNXFNnSVC5uXr0lr0jRTZNJHM2g==
Received: from BL1PR13CA0142.namprd13.prod.outlook.com (2603:10b6:208:2bb::27)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:01:16 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::a3) by BL1PR13CA0142.outlook.office365.com
 (2603:10b6:208:2bb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Tue, 5 Dec 2023 06:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:01:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 22:01:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 22:00:59 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 22:00:57 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <amhetre@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <rdunlap@infradead.org>, <sfr@canb.auug.org.au>
Subject: [PATCH] memory: tegra: Protect SID override call under CONFIG_IOMMU_API
Date:   Tue, 5 Dec 2023 11:30:45 +0530
Message-ID: <20231205060045.7985-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 479b2d5c-2f74-4d9e-214a-08dbf55797c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0J70BUGTjrUGcWm60DOnDYjndqdudwlmYpL/b/kuDnr5A0ZAFjsPp16X7ISKou9/Sq/g0PM+E1VcR3868zsfMpaFaTy8bJcX4tTY5UO+G8c/qz5e6leUrOJZzR3LASplk+pYCUVA0ckcchv+scQVUQeNDRC2ZHdOnapG1QPehWM+0tY3pnLXsKxugQ4UgxYHnSo7H33x0Lo8FDgV7GTSgwdvqxMhHRTyAxYuKzmQw6bNRBK/8IeVBIaFHNHZcqZtP9gWvYX+Ylwam7dSRKbovVrtNdDD5J+YB35coP68OTBi6FXS2PFtfI4FhDFOp5JsfVPg9JTQwgqhFzTyeZkkBYankkwlj7AwDY23dGHt4ISwYYCKjZxzCA4MgboxtFqwv4upM41iHSXwforgXMPQJLDuHqvuVFM2YYXt80TUcq3xoYIRq4IZ5FZkdvG/wjjb4y5xs14XZJp0C/FBgtbgrMHfao5aUmU0tPqdy/21XUs4Td/kSFLY4B1l0fAY/1v2qd9HdhQzhs63e30Yb2+maOCkk6t4cRboEImFjIcu9QWJQYvZAA2JF1tEO6yblOryQXNbNq/ERVHEpDHN0LZDeDHa9AhyMB52brAWgPvJkTqpc9UCnTeV/ZrnqTrWc4QhvKvtUdgJENvjV567lF2D+lFEhxEcteQ7Dy8Al4rENhCOsjtPaAxpSV6Uvt5/f2MC0ulHV+DDgZpnIhoNkhcAbEIQIHQQbqMuofc3NBCqtgXXEd3P42ke0NnSvCznY3Fy
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(110136005)(54906003)(70586007)(70206006)(316002)(6636002)(478600001)(40460700003)(6666004)(5660300002)(41300700001)(36756003)(2906002)(86362001)(4326008)(8676002)(8936002)(1076003)(2616005)(36860700001)(83380400001)(40480700001)(47076005)(7636003)(356005)(26005)(336012)(82740400003)(426003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:01:15.8093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479b2d5c-2f74-4d9e-214a-08dbf55797c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra186_mc_client_sid_override() is protected under CONFIG_IOMMU_API.
Call to this function is being made from tegra186_mc_resume() without
any protection which is leading to build failure when CONFIG_IOMMU_API
is not set. Fix this by protecting SID override function call from
tegra186_mc_resume() under CONFIG_IOMMU_API.

Fixes: fe3b082a6eb8 ("memory: tegra: Add SID override programming for MC clients")
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index d1f1dfb42716..0ff014a9d3cd 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -141,6 +141,7 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 
 static int tegra186_mc_resume(struct tegra_mc *mc)
 {
+#if IS_ENABLED(CONFIG_IOMMU_API)
 	unsigned int i;
 
 	for (i = 0; i < mc->soc->num_clients; i++) {
@@ -148,6 +149,7 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
 
 		tegra186_mc_client_sid_override(mc, client, client->sid);
 	}
+#endif
 
 	return 0;
 }
-- 
2.17.1

