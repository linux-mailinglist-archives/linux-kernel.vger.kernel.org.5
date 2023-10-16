Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3A7C9ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJPFeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjJPFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:34:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB7E6;
        Sun, 15 Oct 2023 22:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDo9/AomUqjuBwCcgb7TGRfhKQVklWGtvWosxgBMrqrTDr//7yrUcxRDIyFKhZeEao4Sw1pTq6O/YYg5avjXM+nJrieBJkzsMLQQndSdtKaOstpAcR9esaB+jSPSyLLViGyV8ejrNSvxzuN74402kY2w5HEHIFDyz/cZQN6uCIfD/zemkctQixoKVt6OYfNMftL8e/pTNtZEJK/K7tV5krQ758il4Cve38oyiVZ/PZjU/uilWyoN2sIKhOY2+uRtF1H08rPcmcoXpW4Zh1rkSGUICtZuL5dew5RzzA5NjrCe1KLp5QukjEFomXtRkUQdOnZxzaBcnmiCuLBYyKu8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=ApGyS4WakQlUTpPJXVHshZLenAWa22s4GGKtI0L6VrvWShA2Zp1SQUToxW8gK2MzDfWXPU9bO+0lmaUEpKxJgfkW4puTI+bdgdL3whZESuyUhc6cLHGTN7k3fNW4Dt7U0jE6AojyzhMSif4kdbkXUACQBGD5Naz6visB16r3zr+W6UbGzBXlkPWyAiS/8ckOSFLlEjQlvuImhzu6TuvDB0us7ZUqKHBSzPniKEevy/pftlHc/TmxBYeq7hbhNVZI50ldulumQBibYAt71asuhD3pZ/vFE0HntWD42LkbEbi/LX5NXTCCBBQxEEmLiHtKGMWrYdrc+jwRJx0TBqSvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=e3pEKWdX4tU+8OqD1qBIerNVUWoEMMg+QfpTUtxvJl49A94xfxs7YY+AzwRv7jQNVKrHg7cPionjWpy07NR/gok6ZMXT0gGoz2SJJKaFh6fu1Qudpl50hHVuHrJoFkPK8sBkDpsPdMpwzSdqEa0929DOAUhJv5HE42L+kvBazInsBnHIedAIaMYn+XCAY9nCscGxa5CaRj62+sSmrwiCeAfkdMzwfb9KksOrSnLCvdcUqdyQcRrxicRBlCrNOvnmuyF3EhgKYPXEG1iJvAohBuMg4rRsfMyURfItsgyjhurtsO4+rchlgUUmSKaYO1SCTPDNIOyKt2mjsPMSDKMbHg==
Received: from DM6PR06CA0021.namprd06.prod.outlook.com (2603:10b6:5:120::34)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 05:34:39 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::8f) by DM6PR06CA0021.outlook.office365.com
 (2603:10b6:5:120::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:34:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:34:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:34:31 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:26 -0700
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
Subject: [PATCH v5 2/8] soc/tegra: fuse: Use dev_err_probe for probe failures
Date:   Mon, 16 Oct 2023 11:04:05 +0530
Message-ID: <20231016053411.3380-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053411.3380-1-kkartik@nvidia.com>
References: <20231016053411.3380-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9739b100-a834-49b3-0c20-08dbce099784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBRKZELZzpFH10UvxHe0vEgypkH6Y911Kk0BctBFcXGaBZI5cogSodzvd4yCqrGBpk88KK4qWgmGDi7JeUBhWLHM00DZjVOX5IA+w0wc/T5wfmZB1VDfWaTvUqouGUuZk/GwNArAiSaVWU01hX0Nxd/B37bpyO/ZvKSC6VIpIRkns2K1C4rOcBdt5MwANFnf83oYhSJXoMq8OlO3c85HPestrOBNfKNi4dCetlUALD//aO3frin/l4KHshYgnB2g+s+2lBii6avVhM7iHOgb0JSBTG0WBGEtQ3cL+YzoT8To3Y6YSm2vHmDMnnAxf68u9CLhTWlkiSRjgbBYcaIUQnstiMBe1fFVAZhOPNfBd+iE8+gdLF6OgXiz1Zwr6vk82rzluqjjx8qbn/fihRvwqTaWdr38+sCXw40fhJW08b9ddCoIK3kLZPsH5BeWcWJ5kbBUMUqGmdkpCNyxsGXe8KuTy/Z28zA1+W3Zj29ZfG58zUGGomvco9hxhUbGLAiLSkAh7/BOI4BifO0VF1y5+6E8ntx9eEoLxKQZm8jg88jlwWYHddUpth8shT5KmgpswNBKJ+gtetXcvDmaabyI0sKvfToORdhGJ3ThlRXA48dhsP7heVRlE9CaXFnbpnYXOUImzMexKt12zr/VXY7nAJqrkgd0HVKU2SsbY7LhqFGYSI+q4b6LKQEQJqDLBEKqXh44Z2NT27/CyAp2WCndjWuxCOyg2RAfrT6mgCIna6A8R0Nibjf6wl19k4NeV8j8dnXx8EAorL0zNsjzbqLI2w+iAlhOjrev5VIDiK9cPtM=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(478600001)(6666004)(70206006)(70586007)(110136005)(26005)(1076003)(336012)(426003)(2616005)(8676002)(8936002)(7416002)(2906002)(5660300002)(316002)(41300700001)(36756003)(86362001)(7636003)(921005)(47076005)(36860700001)(83380400001)(82740400003)(356005)(40480700001)(40460700003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:34:39.3691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9739b100-a834-49b3-0c20-08dbce099784
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in tegra_fuse_probe() if clock/reset get fails, then the
driver prints an error if the error is not caused by -EPROBE_DEFER.
This can be improved by using dev_err_probe() instead.

So, return dev_err_probe() if clock/reset get fails.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index a2c28f493a75..98805885158e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -131,13 +131,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	fuse->phys = res->start;
 
 	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
-	if (IS_ERR(fuse->clk)) {
-		if (PTR_ERR(fuse->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get FUSE clock: %ld",
-				PTR_ERR(fuse->clk));
-
-		return PTR_ERR(fuse->clk);
-	}
+	if (IS_ERR(fuse->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");
 
 	platform_set_drvdata(pdev, fuse);
 	fuse->dev = &pdev->dev;
@@ -179,12 +174,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	}
 
 	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
-	if (IS_ERR(fuse->rst)) {
-		err = PTR_ERR(fuse->rst);
-		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
-			fuse->rst);
-		return err;
-	}
+	if (IS_ERR(fuse->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->rst), "failed to get FUSE reset\n");
 
 	/*
 	 * FUSE clock is enabled at a boot time, hence this resume/suspend
-- 
2.34.1

