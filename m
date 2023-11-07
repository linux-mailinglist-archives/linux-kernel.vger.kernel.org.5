Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3F7E34D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjKGF3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGF27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:28:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612D94;
        Mon,  6 Nov 2023 21:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLk+TLJ+FyaliNWFJYw3GJfi8LIMxAS1nITWpjGDyMFxtxYaSyRkoOU9FLiLG2du06jkIXV3ASinQ0qVhKQjfg75HF45TrrOl6pj04HM9/z5yZpy/o8r/RA5b7/ebwHwtimBURYiDEjQ3+n08+966Mk+CZkgN4oYL13Y5MLzaES6g6bJ+JQAh7Qi3I1SvzB70bKCGqzAmci8Nka+BrN7p9gZttbbozzxo944KBMaTmYtYnbBaQgJiODXR+RR7EW1FIUu9f3eDB9AJfknroQpWgELdog0anya16qWZKDBvkPwxw7Fil4c4uvODuDv9Aa0OZ4egnrJ/vMAgNkiDuu7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWkoOPQd9wEw4lwgt1r3Q9/dbemcT0u4OxkWteHSfQ4=;
 b=D8APz58DME25NTQwYX6SBj3Y/Kjg9XDdhPWQ6FDm5j5poOoUl6pQk6SOQtIu0RLfXWQAOT2iDyouR5igg3Wl/SYnSR7ly58p/sjWfY5E4DWIfvnpHkf5pw/qW7zI32wxrK6uNA4mR8Sp5Z7hlThJ+XKS8BVevEEl1TeNtT9M+vYHHGSxJiI9jJGWP/WljiNpa0wNpL2H0i5syKJI7xohdKySK7DhAnNmTwgOqKeLs46q0MyBXmQTTFC6UufR9DSSAiva4U1VPGGa6J7c0WwQX7GpttPV2Wn3tBI5L26XfQdRA0dkWne0406nteqFCrD7Wh716o3TTgg/S2FWRZWCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWkoOPQd9wEw4lwgt1r3Q9/dbemcT0u4OxkWteHSfQ4=;
 b=SjV/dtkeGvc9yCGAO2YaN6YnBT78HeWWG0v+dzieQaRX3tMFdBTo30Ar3Z6dh0umjA8sJerQJs6ZwkmKCGOMVjMErbLvNDcKkrKxtQMUcdtD5Z2HU1/hIfuDlqfNebJsBo2MgCX39cvxPjmnr49kdivVGmnk1e4u5XsYrLaocYh6zEEyx/u6v/8urXdgm63QKnMKScPU38/pBIJCQK6hlZZCTyWONP2ZkNXJpNb18dsrJBn6XcXORtrIzETljetuM07TvDp6mL7Nv3z38k4kSU7yhDQiyNBAXYLxCK8cf1TM5bFOGIrJZqtMtGQAGAPWV15T3PvhrkTvBeagJqvKRA==
Received: from DS7PR05CA0106.namprd05.prod.outlook.com (2603:10b6:8:56::24) by
 PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 05:28:52 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::c7) by DS7PR05CA0106.outlook.office365.com
 (2603:10b6:8:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Tue, 7 Nov 2023 05:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 05:28:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Nov 2023
 21:28:39 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Nov 2023
 21:28:39 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 6 Nov 2023 21:28:37 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <dmitry.osipenko@collabora.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ashish Mhetre" <amhetre@nvidia.com>
Subject: [PATCH 1/2] memory: tegra: Add SID override programming for MC clients
Date:   Tue, 7 Nov 2023 10:58:23 +0530
Message-ID: <20231107052824.29418-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 2105b388-b073-42c9-1635-08dbdf526dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+wD4Y3gyzP6J7Lvz9bTHHBuQX5ou/s/mBtTQko7hniweLocww3baAtJNMEO+p52x4wKefEgcxwlE8WWjAqpPhlgX4vtq+cTvA4wenpTngYkXrIqs5dvRgAYwNcHCEH2Vsk3GwKvrFrpk+yjhv+1odvEeh91PfJ/i4s2ZcbtJS2UnxbQ/zRYGT6kyM4QMUK6jcx0Rp21nep61aM6xcDEJAZoikgFlwprZ9TgB6MGtVlJulXtpLK4uI+GyQjF90YYvxVP9Zug8v3FUW5wB999jwkELoUu4ymOLALFOWZOki4sNszncXzkSs21oi0agWcrzcQRCHu4TTfHKaVZNVIeZJCoSxUhIA6DfyuRe827RyKOJXAPv6ZOgiHHTjclzbY1etqUoh4P3iC2TwG7k5Y/8Ld4u8cZVfkWDHp0mpi4dOo5zAcomVjnqsnLtnsTOGTfSefWkBwYa6U+lZXRhhwg/mK6nVLTGyfG3dRcnXZhH3vYr9ZmzApDV6oCgc46L7J6Y6lecQd9n9V/mlzZyItTXDKCHznX0+ldabYVpo/1ZiTwLEv/6N55vzLzTuNy3v9Yku6IhZRWnzOXl9gdx5p/ywD0/TL0kcwkEZ5yc74lZMPgxLMrjguEq2rztTrgCLY2K/xudpPNY+CjmEDNvZ4SVXVbEY3dqvipv8aQTCBwFJDAzLfHHIjkbz8zDh5jDi/jRl1Ee53jlsreqgPu2BaCPQ/b4orhiPwbpU/T9x2WWa9yVyFcIse/8bfwfksM895R
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(36756003)(4326008)(336012)(5660300002)(426003)(8936002)(8676002)(83380400001)(26005)(316002)(70586007)(70206006)(1076003)(110136005)(54906003)(36860700001)(2906002)(47076005)(41300700001)(478600001)(2616005)(6666004)(7696005)(107886003)(82740400003)(86362001)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 05:28:52.1932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2105b388-b073-42c9-1635-08dbdf526dae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some devices the bootloader/firmware may set up the device in
bypass. Memory clients like display needs kernel to program SID after
resume because bootloader/firmware programs the SID of display device to
bypass. In order to make sure that kernel IOMMU mappings for these
devices work after resume, add SID override programming support for all
memory clients on memory controller resume.

This partially reverts 'commit ef86b2c2807f ("memory: tegra: Remove
clients SID override programming")'

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 533f85a4b2bd..bd8cecc3cde2 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -68,6 +68,19 @@ static void tegra186_mc_remove(struct tegra_mc *mc)
 	of_platform_depopulate(mc->dev);
 }
 
+static int tegra186_mc_resume(struct tegra_mc *mc)
+{
+	unsigned int i;
+
+	for (i = 0; i < mc->soc->num_clients; i++) {
+		const struct tegra_mc_client *client = &mc->soc->clients[i];
+
+		tegra186_mc_client_sid_override(mc, client, client->sid);
+	}
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_IOMMU_API)
 static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
 					    const struct tegra_mc_client *client,
@@ -139,6 +152,7 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 const struct tegra_mc_ops tegra186_mc_ops = {
 	.probe = tegra186_mc_probe,
 	.remove = tegra186_mc_remove,
+	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
 	.handle_irq = tegra30_mc_handle_irq,
 };
-- 
2.17.1

