Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C06751B12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjGMIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjGMILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD992D65;
        Thu, 13 Jul 2023 01:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd4xOfunHO++9t3hLl614lWcVo5fMi51jyPpCU6qVnkAvsvR5q+ZEwOfTCAat1yqJQ3IuKAGec+RfXEh2r5MHHvBr6Kn3M91JRjRdH58UTw77w09eACKnKnqyz/UvFnAwCVTFEDbnespLYnsgw55SBCypPXT3Tm/M+xKGmjtA0bIAc1UMfOh6TV1eNVyyYtwoKgcyr1dYJfpFqzUDZO3FoEvDOBDkCZLH8Ti1FmaW1IVfPihsYN3/QQd1f89sFFc3W56wectviQSACzoyRkLdSZnIlQh1MDhOXEKc2mTQhigtua3MfbTfAOfoRRtsTWycUiQJGf7XvI2aYhwcLPC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHDYAo2K8eeOzGD2DOisszn6JuNtVDOiyeNXZmoz4Tw=;
 b=mvFGkg0rm1+yz9QJe2D+EhZisnrHexc7NrHIREKAg7RGipohb7Yf6yTYoaSynqQdF6tN4RfmJd2WNdqNBw2NyFD4+osaoBE51+gG/nI9ttXwC/53FF3KdGcC60f3yLfYqIdK9cmQXGi2m0jjIzYnxzFrd9NYIKKCxeguSbof+LXnwl2qAbTDU7NWMPoL2VnwbYaW0CX/f/TyTJhYDWLWvTjgb1NsyMAT9rV2LaCb9Zw1yFK9vFmCqxjFP3vU2Zg+bYXpT/jMBZTfoOCL0vlEHPhoLgRnnGxhR3dOGKY6da4/aPFOHqMQU1IMuzARN4LF2GXdEbpor88Kr7o0N3moSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHDYAo2K8eeOzGD2DOisszn6JuNtVDOiyeNXZmoz4Tw=;
 b=YhitGbkCA+/jQNUXdpWB9LbKPd8snPBTnwvKG0/y426yO+F3nDdNV9IQz8TkhRwpFWLLZiAKQQUk3bUXqJkBYiNuM1ESqw4altTjFrZfDW2TjlA9oJPBSzleRcywuLzI4/xW0cnQ/p3Pr3vCIYZsvLw7QTrKfslfTGVrWl6dHWwJm9sqtyB2YDW7wL2efoc9Ik1ZptGKFWRYGdk14O7dgbBcxDDtdVZ2B20PEZ6xj4Ld+xWaWLUWFKrVDXIGuOp5uJgBG4lgzsEOk96eihOUuLS7gyzXGAxWoWgEScGKW2rnLQvtQh9qpwtkpzzP4T78C4zT6uSbReKTdTResenQ+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/58] mmc: sdhci_am654: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:33 +0800
Message-Id: <20230713080807.69999-24-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713080807.69999-1-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 277b7b33-df12-4cfa-5435-08db83786b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +x+S437nTwxX02ZwkVSRhFsg3Wao0XejI2PypPGy0t8IdqqhpP0dG0wJ3nJpFobYHitWT0zKPZnH0q28aTjcvQYRMMtKJsXucE3wboLFKFWRKXA0EtG+WiI07X0wGheEvG4NA46Sp/ay9fRQejwnFhjK7GUv7HUb1UcCI6a9y4aabS2HHZITpBFfstLLMCuyhoQjxrCtBwV4Bv9M581Jnjj7HaUSkxf9wmYU4sop49jGTIRPXohg4twy49bm+uMYzD21df/sl/UtzfEqY9AyUaO/yalBSb86LOiZyqxaTFBZiSMxPSlqWb8L374CgH6MZj6y95QBQ3lKvMK2VLEXso8mi5ckKIhl8nu1YuG3Nbg8yI6EpECsvvk14ilvZYfRu7GCtpkqDuKU4Wk9JD/yL2CCGLHqlAiKyvY+dzAk7yvCSEAt6wRj9IbNlz3wiD1J4++ps+3VIlybTz/4j6+x1nQwmYZJ08R5GHBfDd0lG8oG8zYTSW+vv/Oo0cREJs5YQwquOee7Mx5HRKtCwvaDBrjTQKhv8p3c3YhPAEM/LvXWgP9DyCZDpUdmdpo5vg2psvOhJaUcBF11ls2pHjbGpjFNfKqHU3VZc5F+aVV7ynSpz/dKK/td52zLnz6yNV3f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtqR21sNHZTOGFaY1BzTWFERUFEWUNhRHA3Mkw3b3I3T2RrOTBYR2FiYUI4?=
 =?utf-8?B?TGErYmdXOEM2ekhtWHNsZERHKzZJYSt5T2h6WDQwRXoxRnJPbW5xWXdFWmNx?=
 =?utf-8?B?TlNmU3p5WVhFLzA2OWlCcXNBMWZVbUJMTW4zU2N0QkJFUmwwVVltMkY2eFRh?=
 =?utf-8?B?bUVDTkttVmNBeU84Sy9rRnRTZEsvTTA3TVhSL3Q3elhKSGJ0V3JUL1A2ZHMv?=
 =?utf-8?B?MVNxZHpXNHNsb2xjcmYyT2lXSjI4YVFoN2RQbXNnemlwRjZsUkRaeUtkTHVJ?=
 =?utf-8?B?cDhxZHdReGIwOTRFMlJNblF5V280L3dlbGNxeitHSnlnZHNYNUg5L2p0Tzgv?=
 =?utf-8?B?VVprbGVhbGR0YWdCRWRhUDJ2cGY3dmZ6cGJuUDRBaFlOcDZkQjd3NFU5QjNE?=
 =?utf-8?B?ZXFYYWhBQ3NUaEFzVTZJeWhqdWRUejdFb0h1aFpBTkg2ZzhjMWNZN3NSWkhP?=
 =?utf-8?B?RVJFeWtTTEZZT1hYMWF4TUk5M1dyc3NFZFN4ZkVtTjBPQkNYdFIyNkxQdkNT?=
 =?utf-8?B?R1NPK2FnT2ZGTnI5Z3ZKdmtNM3psSmVlazFudnZvcHZhbnVQWENRMm8wVjVt?=
 =?utf-8?B?YlBrVTI0T296NkNBa0VtQThBNDE5WDkzVVR1R1RtR0RPcFdZclU3Z3AwYWQ4?=
 =?utf-8?B?TmxhMEtUaFdsaHBKMlNMdjgwcUQrWlNsS2lxR3lERlpyMG13WDFacVFxNFlZ?=
 =?utf-8?B?OWgrZnJoTUcxUTFkUHhjVzloMUw0V0hlaThjTlJzcVJCaEtyaHhMMjZYUnU5?=
 =?utf-8?B?Wmppd3JyUkVqT0pVeTR4SHBCSlFybXRxS3RMMm9zWncrOWw2OG9Fa3Q0cnZy?=
 =?utf-8?B?K1d6c1FTTmZNUW10a2xhZXh4eXBBOFl2R3dWallRdUlxcVI0d1UzNWJLVHdC?=
 =?utf-8?B?TmdJbUhSNm04ZzZGYmNqcjFlcE0xTG1pL2lCV05PRzdZOGxFWGJFTWRpRE5G?=
 =?utf-8?B?WkN3RlIwVjBaMHpQRTVnRU5RUTJHdkl0aS9IRngrUUZ6NW1XeS9tN0pMQUdE?=
 =?utf-8?B?QXBzM1o3bFIxVTF6V0M5VnNpOTMxWEZiYm40UUlWS0ZXQy9GUkdhc0FzakQ0?=
 =?utf-8?B?aGF3VlQzQ0pucktlcEpDM2d0YzZ6ZnhLOVhpVnIwOFhwWTFPckRNMFpob254?=
 =?utf-8?B?TXMzWk1JZ1pOMGwrZzVBZXQ2MStaUnNjRHRBQjdxS2xPMmw0WHAzZG1EcmNk?=
 =?utf-8?B?ekJBS21tMlZhTEszdEZpK3huT01mTWsxTmtwWi9RbWZOZmltV1JKbWVOcGo1?=
 =?utf-8?B?SE03YUk4cnFZWlhZQ2Q3endGLzZPQUNpaklTWkM2OVY5dlhGZnBzZjRiUWJ0?=
 =?utf-8?B?MWRETzhqcjZoV0hNZnRVWnByTzIrTEhXeWFIU1ZBODBLdjNjUnhCN3hzNDBO?=
 =?utf-8?B?VmlSMUU1SkJ3KzZZU0RIcjFaekRwZ21BUnpJTTVDY2VjT21uZDIxMmM4QzZh?=
 =?utf-8?B?UkppNGJQMFNwN3ZFOFIyOHVhYVY4cnYxcmdkK0l1c3NvVTNjemxVUXdJeENu?=
 =?utf-8?B?cTRXMExJc2xrWmo3VHN1VlYyZldwemhON29aZUdxT1VZUGUrSGx1OEJvQUZs?=
 =?utf-8?B?SitIVm9OaUtlUzJ3YmJZT01Da1kybDB2Tmx4QndsTnRhOWdiSnpCUWFMSXVG?=
 =?utf-8?B?TWtBclJkWlZ2eVBKeWFkUHZQeWc4WWlEOFVKTzZGbE5MSHJvQ1JzM0ptVFdj?=
 =?utf-8?B?ZTJpWjdFUllKeFdzdkZ5RnoyaGhZeS92YjFZNHJQVVFSSi8wKy9BbDdvSzFW?=
 =?utf-8?B?VGpVa0p5RHR4bUJ2UnZlZUdOSGhSYVQzM1BtWkRwYURDZGZUYXhkNFlQN2tP?=
 =?utf-8?B?eEtFUEprazc3K3FQalN4Rkt3aTV4bVVRS2tnTEVPMHhQZUZZbFNXWmdPWUNv?=
 =?utf-8?B?THFpMXJXZCtkWHR1Qm1PRUQ2aFdKRmxicnQ5SlBMYmNWYnpMa0kvSU04TXV6?=
 =?utf-8?B?NGs0RDJIYTBDcTNvYS9RWUFLU1pqakJhY1pQNnlQZ0RQNEhKU05USG5jNUwz?=
 =?utf-8?B?ejNpSUxTVkpCMWxmNHZpdURIcE9ZNXZLT0N1ak13bEZycC9ZMVgwSDBZVkVS?=
 =?utf-8?B?dWpITnllUVFhV056Tmx6ZFJySXlQd2J6bGdIMEpYK29qUVBPWkdKVDd2Nlhj?=
 =?utf-8?Q?g76eYyoZAQvBz7NRGWP7qm1RW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277b7b33-df12-4cfa-5435-08db83786b9f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:02.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /K5Vnb3ZxFsRNv0nJ5pzMWUaTovl0D8E0oMnuCHT7eGHiStehfMnZ4nMfMOz5bSj2jTTS2NjBxysOkxeJDtJsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/sdhci_am654.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 7cdf0f54e3a5..3cfaf7dca274 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -866,7 +866,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_am654_remove(struct platform_device *pdev)
+static void sdhci_am654_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -874,14 +874,13 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		return;
 
 	sdhci_remove_host(host, true);
 	clk_disable_unprepare(pltfm_host->clk);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	sdhci_pltfm_free(pdev);
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -993,7 +992,7 @@ static struct platform_driver sdhci_am654_driver = {
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
-	.remove = sdhci_am654_remove,
+	.remove_new = sdhci_am654_remove,
 };
 
 module_platform_driver(sdhci_am654_driver);
-- 
2.39.0

