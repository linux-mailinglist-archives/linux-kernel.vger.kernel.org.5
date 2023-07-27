Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3F76478E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjG0HDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjG0HCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:02:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4761B3ABE;
        Thu, 27 Jul 2023 00:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9AzfFUttcn+qHrEEt9WGAWWvF1tflGVJXIlP3/UMrpuTTMkVUx7UWxaRi4h7Sro0GZ9Zh1xjpDzIT7lraPqu/eiEfzK/yydlIXE9j1RYBmlIpzMfCkQDsgbhmrq3+133LBmN+tXe6AgXTBdnMAwKEtKGvunW+2kfDlyehovcPC15LE3GojQ37jTjaVLRKVxK7ah/mmtvKbY+IyI/qQTHIikL8gy7VvmqRjfpwQgipj/iufaeE3OllpoGT6KbbJiPwTLl+uAYu46DB5DAmyypdWmIqK7z9J93A1ikxqpmCFNFZMbYeESFMXTG4hN9IiYnU799FPV+AMGAOqt8ZbxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4WNf4YdQgPLt01IdeoKmo0VQ8uGwhUq8MCThQTK3fA=;
 b=Cz/HwabeP498kwWVKSqAN/W+o0PXq10qiZ6soo5S49n6H83jqW3UR5qMx5HgbmbjSgjfdlqTUp+BEh5Usnn4jWr5JvXTb9fie5PcRJ23R1oFl2MjTgoyORBU5Y6TXWKUVSsLGDBDfHllu8kdtr5zdM4EYCd+4YIpfLIHeZSvqFmEB+DLfZeXarbpmdVkQ/8FwxJb6oi8cDC9nxDkc8mDm49p5xhzRrzXuDUx/pNW8lGEQW13XnZVxO6RqW+XvPfeVDOnDxQFjQCE8ldYEJpjhFxl7XvAj/KIB0hXiY9HvOyH2xheca9+f8TUMM8w1pTNNyb1OuW9prw2IDq9Vt6jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4WNf4YdQgPLt01IdeoKmo0VQ8uGwhUq8MCThQTK3fA=;
 b=U1EUq1L2whdYL+lb40QA7K3uR/sKp/IVmUAeehZm0IpBEgTGrxFkwmt3IiZr0WvAEiyOinF4kfC3tHyK77fEJdfQB22T6/ZfWwGJ8SZOJDy5s21723/SFj7aLOPX/n5Vedy/wu1C5OdlZjpfyu/f6xjYbkm72Elv426M1Nsp3GgukLNY00G62bOfZ9Z5Sa/8zApVWkJzedXA1awYIVDwY9BCLQg3H9RLBa+aZVKHOFJ47tQTM4zRWX24HKoFpnb98ESsd2Aj52w2eRpqFBZpTkCyABF38XlRTMLVH2kEnLJv+20tgOn9ZZUOzDU9qplTO/JDtPv9Hr9KS6n8lbL3iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/62] mmc: sdhci-pxav3: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:04 +0800
Message-Id: <20230727070051.17778-15-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b98ce56-cbc3-459b-cade-08db8e6f4c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h02ss6hO0pivW5YabyHVw+4QxAONs1wDih0bDSDzHuBS8ii21daYyWOMMdBjpSF6v/jhgommdQ3l2xOGOp39uXX0scjhE1xfiYszEyNwr02dEPsxK3VQWf2laxTruZmYXaFbdcrjyJ1isBfrDjNsBJSF7K7JdefprVkPVm3gSpJBe0cOCxHTiFFTf32hAtF+EvKx6Tg812o0gP3dPvomH4gz/rglHByalwwFRTQ+2MleiyPiQPXgeSe65zCZLOJYlBKULd0u3q1HId1+45K1JqweaMmdVeB58J60ufU3BQXrZDeMfwyrQNQlsmXbB2ww0Pq2/TsiIidAxSU9tTHjXg1GOg87S8TRKhy5Mm1ZCj/TyAfls9FQUBs+k2Mwzafs4juz/9/4uT4Mzx2atGPuKw2tK9vsxCJJzE6Ka4S0WDtcNgajN+stAsIYyqcx7He8g4zVe3byhXm/OOG0sthI6LmcH1OwpRJz6GoBWBkdJknlp9Tt1wbO0LzAoSd2DQ1ThCC3MfuL4Z7cN9Q5EyIlAoqTe08rP8s1KCk/h5gD6PifnpcrLSeTbBpZhLhPS5/szDQlo31UQLzCgddmCzpSgPzHfyErTrGAxsa1YPqs4LHqHDstYXJZr3kTAmB6NsfN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJOcEFvZEozR2d1bm1Qbk90dHg1TGNrb2RkMUZhWi9HR1dLYnlJd05ubUNK?=
 =?utf-8?B?TmthY2grN1lQN3FzRDJvWHNYS09kc2EyTXRKL3BaNEdwc3BaclQzSnNNQlBj?=
 =?utf-8?B?WEhsaTZTeitRUmwyQU9xSU5scTJWUEJ2cm9aUmlUTjdaYkl2bG5qT3B6bGlB?=
 =?utf-8?B?RWJFMU9UMTZwajVOUCtsVzBBRWpZVzBKN1ZtejJIV21kVXhmbDFqd2NiL2lv?=
 =?utf-8?B?WWl1KzFrZ1daV1BXME9rbjBZNFNDYzNBRmp1OXE2MnFYS3dEQlZJTWFhbEpS?=
 =?utf-8?B?b2RFU29Zc3dUNWhDZ05XMUFVUlNLSjBJcXQzYWwvVThXOCtTY0RLbnZjWWh3?=
 =?utf-8?B?ZWdMUTQ3S3JlOHhqTU5oQ1dqbm9jY3lBaTJXMmpSWDgwYzU2SElIT3l1RnNJ?=
 =?utf-8?B?NU1YdmJoRkRPYkhXYS9iTG91dzlxSVE4Qm8xV3NaT0xzOGJPeE90Zk50NHNi?=
 =?utf-8?B?NzQvVmpGU0dkZEZiQ28zRmQzR0VTSWRRMUhCejlFZzhROVNOQWMxa3RCK1dD?=
 =?utf-8?B?TzZjdjBrcHBVRFdZSTVJYkhxd0c4ZkI2ZkV0czVkQlc0b2hmVXpLbEpRVWg2?=
 =?utf-8?B?Z1Y5ZlFHTkU5R2VDODkxUXY5eVVOd2VwSEdXbEcyTXlxTFJPRTdjYkZDa3E0?=
 =?utf-8?B?VkN6bGdJUDhycUtvbHp4ZEh5R1AzeGd6cmdJL0xxR0hGaU1lVWJVc2taTko1?=
 =?utf-8?B?dGFsZEFlaVlOdU5kVkQ4bWdMWDdvWXFYbG5HeGZmR0ZJOGlKamRidldyZVdH?=
 =?utf-8?B?Y0Q0RHBpTDRrQWNlbHJBbG9GYjlzN0pla09kN2pNVjRtaUJzS1BJVVZsRkNh?=
 =?utf-8?B?OEdNTERGS2I0SysyOXZIdWNkeGZtZ0pZNk52RDhIbTRjRHVqNVUzZUwzemU0?=
 =?utf-8?B?V0RVa0kzeTdiREZ5bzdvUm1YMWhpL05zZ1dTdjlOMU1FbHBMN3JCQ1pCdjJn?=
 =?utf-8?B?d1o1NWJRZ2FJcS9ISUloUlVyWlV6WXNmK040RGVSemFmbFYwbGh2blFpTUJU?=
 =?utf-8?B?SnBDM21FcW1BK2FlV1RhRFJNVXhNWXM2cml5Y3ZzRWhGMkRuWEl2ZjZ3RVA1?=
 =?utf-8?B?Y0w2dlcwdlRzbWdSQmZZYU5iRWd4dFFrTndkV29rdTJjamNMaVNjdE1Pc1F3?=
 =?utf-8?B?Yk4va2hVZUt2WHA1dnpwa3Z1YjQvQmh4eVE1UnZJNHFGY2IxK205SjBOMGlx?=
 =?utf-8?B?TkswUVFKaXNDTWNhRWpwYmovUi9pTGlRUWJzM3BYZmVnVmNxZnhVS3hVV3Nh?=
 =?utf-8?B?eTM3ZU1QZUhuc2lMN3duUWZlYVB1VG5JYkJlMERjd2VwMXoyd3phZm43enBB?=
 =?utf-8?B?MmV5SlVoaUZScUIwYUxMRGx1MWZOaE91SFFuNEI2UXN5S3Z4WnJFempLcHA3?=
 =?utf-8?B?QllNeFYyck8xVitqaDlLTUJ1c1FMT2ZlL1pEQklMUFAxdUtBbFNabTZUZ0gx?=
 =?utf-8?B?TlZGUjhNUjRnWE5UcHRmaGs2QisvMXFnSGdSWmR3VDcrTlNZbVZKTnFYc2o1?=
 =?utf-8?B?SjNiSGRzSnEwdnZHWlBNU203ZGpXclZiUU5BMEU4RkhhR01jOWMycE1naTZY?=
 =?utf-8?B?Y3Urb2ZnTUdyNnFWYVFRRVFsd21OUm9TTWtET0N0UDY2U0R2cjJmOVhoOVFB?=
 =?utf-8?B?NkJlOSs3a3BRU2RQam83OE9JcngzWC9EVmN3QjQ0NlFXbkVHWkNKSm5FZnRO?=
 =?utf-8?B?VzFrUGJkSk9DTFpUbnU2K2FnTG15R3NyMHRuV0FmVFJMM3plZzQxalZmYjVC?=
 =?utf-8?B?dTUrR25jUEJMVXJ0VVRlSGs1Y1JYWmNRalYybGZxZEpDZzNidHROMVQzUmJH?=
 =?utf-8?B?OVRiVGxjZU9PWldaRDlrLzBjNTZyN21HUHo5SlUzdGtGWGVlRFRzdFZFTnhS?=
 =?utf-8?B?dVZkaVV4bzZRVkgxc1U5S0trT0xGbWpQYmx1S3c3VnhsUTNCZ0xLRVROUloy?=
 =?utf-8?B?dkZJclc5Z0dOdTZ0QVkvc3RpQXpqMEVONGcvamhNUi9UbU5ST0FHYk9Najk2?=
 =?utf-8?B?TGRsQnRmclg4NWRlbi9GVVNiZTY0KzRiYm9lWWMxMG5UMTNjYy9MdWtXZ0dE?=
 =?utf-8?B?WHc5Z08veWQ2WWNtT1hGOGhNM1paQXdnM0lydGswVEJiK3crTUUzb0ljdUsx?=
 =?utf-8?Q?XFmyk1uEdmftpKDKh8GXh8ywq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b98ce56-cbc3-459b-cade-08db8e6f4c04
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:27.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEKD/f9k5v5LirrsBbH7hX8+JYBdJmIca8Fu5fquWf+VQ0tcPcx+szRRqetmumIaJRMgr+aXfu2h2gCCTapk3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e39dcc998772..3af43ac05825 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -470,7 +470,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_pxav3_remove(struct platform_device *pdev)
+static void sdhci_pxav3_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -486,8 +486,6 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pxa->clk_core);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -570,7 +568,7 @@ static struct platform_driver sdhci_pxav3_driver = {
 		.pm	= &sdhci_pxav3_pmops,
 	},
 	.probe		= sdhci_pxav3_probe,
-	.remove		= sdhci_pxav3_remove,
+	.remove_new	= sdhci_pxav3_remove,
 };
 
 module_platform_driver(sdhci_pxav3_driver);
-- 
2.39.0

