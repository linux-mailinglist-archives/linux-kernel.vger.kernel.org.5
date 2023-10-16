Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC517CA509
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjJPKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjJPKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35543C5;
        Mon, 16 Oct 2023 03:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc9w8eRjHCWtN6Y+ktTpjsGb565hF/vl9SquVvV0bx/XAJN2HAtzji5GtsBakjX6F8FPzOnynZ7glztQYkX+Ss2uakaAHPYzPk8vYh2GXPeRDeJpinTEnf/7cuKPzkO/tiri2JqUQ3QfVc15OkpxMdLUlF50jHqTLHVKnJqWU0+R/lNp28qErEiej51qbL2dMdaU07N6seWE5eN/c9n6PZQLvjUs1DbdzgL+qKg63MX4A9Y5ioIRrqxvjvUFHBhQaw80qV4C18hUSDqvR2QeM4s9jObGLILBHbv66PlL//cR1g7KmDDO7DPDhaLiOSS6x5pdr5uNzbXT7l0aHn5j+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=LulEdkk2+C2/B0k9/H8iAHiR+NDDiyjMJdi2KEuOQbOdu2zFjeZWOb+rlKkChFgb4QGHLM3QhB3qsnK9eLd6W7shc6dUkmEpHw2etfubE3MuYTC3q0iUrMJko71VPD0yfhocuomODk0VhpHbOy/aFyh3GQiqH/Lhl9myKhP9X9UInBJx0I6Jp5rI8gkg5F79qjRuYd4Avo6nUglgbx4OuqN4WOkJn5DJbX86BlT01nN678l8s2+sMMUMpEY7OIEUxDuqVt1YlRQRR7TX0GaBE2z9OS1u4PR5do6IO6Dn1OSJJcc9AsihQumU8JMlHP3FIvs8NcKsrfinANoNRS2Cjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=MnGrAcP0tcR5pPtLUMTsx+/ysuI1BL0KCmkj9u6ru1D7HZJFje0k0R1eIY2ewQkkObpj72TIY4aNqBnjQaNqqTd4Tfp1BpOQmEHnn9JtYxzJAcFuvCAR1vZfMqjU+BUvEpQP5bYhT2ik2TfrMGddQ/q+dSM5p8rps9m3RHV7xSJvM2Hhp3EiAxyL21lGgoA6jgoBzAsfjr6OWI1z3e6BLlcJkGagClUiNXT3YZUP0sjToX3yCBjLoDQCprmNt+qU6LakxqymeJ4v999KYcbyJ49c0tseBmMue9LrpDjGCGsvsk0xePaz/k1iy4NsoCeFIMaJ6kdMpAL1qcapIR9mww==
Received: from SA9PR10CA0020.namprd10.prod.outlook.com (2603:10b6:806:a7::25)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 10:15:14 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::c7) by SA9PR10CA0020.outlook.office365.com
 (2603:10b6:806:a7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:14:59 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:14:54 -0700
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
Subject: [PATCH v6 2/8] soc/tegra: fuse: Use dev_err_probe for probe failures
Date:   Mon, 16 Oct 2023 15:44:30 +0530
Message-ID: <20231016101436.7146-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101436.7146-1-kkartik@nvidia.com>
References: <20231016101436.7146-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6d036a-5ded-4453-b75b-08dbce30c9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w69nCxV52EfcyVpKAt4Iz1Fp3xsxGR0JXfXuUrh+gRR9FF1fflVFzV5EbALnU3Lp5VkuxJxRDRBVxBabkvT7TkqbP33r4C3xSO6/q6cix8zXUgKx8zOvJiyb5FYx2ykRYrqlxeN/WzODPBmXJdhrq48c0vFP+D2bp1VjXQJ0zAnHuXSA1zcfViSBv99gpDsI2+yWn4bqbkVZ5TqC8a7VSgKWMsrOtci4HcXq9zkNtlPgMDx4xqbQJnqCh82kuP+4MmEECnMZUqX8+imCm+w3Kz+bSG2Ipk80ddNMYZ5hi0G2BvBifF4nOWH1na0JLZNZ1ZENCcRT0H01H2SRV6vb7VzaaiEms3mgImGdKJgQlUPljyto8Fg+TqbwelNJY+FjRASUOyIKpdhECDT2Y0SPINcb0AvEzWzzl/aPwojxQGT03kN7tg9BH1H3vB9gUogtuuTCtvtRMQ883vYpD3151JOxMMTvDDQxJvOeXiIexdRShtSuuubZs2532qejR+GEM8LeGFJEv+pfwyln+lsT2ygYfezIkxUXVNIYhCmm7sT1NSjpMsaXdfRQefbN+3n7RXTfr61T65Uo73NCJPYjwKaFM7qNvs/ILYn86otpWjGNz1TLmArI14r1AOUBrMe+Iy7CZcKLNI1KyK+5zugdlONtm0ojddnkUUeiURIetE2H7DJml0lNllUbN/Odq7nmsIBnq2rOE6eRVggOxgLRI3K5dGXwYIBCAX7rDYQRco55lv6Aijw6Fj34nY2ZACGuFAlIFjCW3HFKdf5l9oojFmwVDOPilcZ37knhWt8uqWU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(110136005)(478600001)(6666004)(70206006)(70586007)(26005)(2616005)(1076003)(316002)(336012)(426003)(8676002)(8936002)(2906002)(7416002)(5660300002)(41300700001)(36756003)(7636003)(86362001)(47076005)(921005)(36860700001)(83380400001)(82740400003)(356005)(40460700003)(40480700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:13.8680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6d036a-5ded-4453-b75b-08dbce30c9a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

