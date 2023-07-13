Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE8751B09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjGMIMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjGMILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447E3AA4;
        Thu, 13 Jul 2023 01:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EywDNqgdnw2nrkH9QAjMOwx0bGAVohk1QRDAEEGpvWoID6vrYr0uGaAMayCKRC7jnUQNLnBd9Bv//wc259BjtjRNGdx1A2lSu95Nt6ydFMpQhoULANi4VuhHIE/Zbg7wxIrx0D/6vmSxiAWKjESo0HKlHtQ5zT1DEH43Z1LAu+ie9oHJocrAYIG1vMgEm68/Y+3ReUGDiqnybTeXr9oQB9g2o05OeVcVKFsGau6xBdopMVcQ/ZKBO85S+FiwHNdmwEnGf3Zzh5btJhj9josVaEarkz2+aPnE3WQ4o+mSfffEFa9jS+DNdQrssNiuinULGblhSoctQB9HwhKI4YFmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nPOwPKYNeq/2Tv4iqOeh7ZkKMvKEp8wvhNPamOgGPQ=;
 b=I3TJgN1a8bFE2ZptqIWShtIWyZfFEzXLil1Y2SPFhQg2VIuAHenuZJJ/9pbyg6FuQmh/M7nH5jDGCgndYCQvUb8TNWx4Iog7e0smDwNLxZvHGmb2jm91VdejD93RFsXAPO8iMTXHCuKQ5BUXmOi5fWNr3ZmOKUE1jvz7QefDpltc0zdeKl6TgbsRVt7HDVVGHcSG6p7mPrH5Kdu2fMakHv7NgkOi82QL4GHCB84xf7uuC2qDht/3JNPpTbi+qqR3fk83Akt5kmipiOGHHkvPloeBehHZ9a8CySZazeTejDK0oHQyZmPpMXL5W4TtoH/c7615IoLoGUrzyC/Sa+MUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nPOwPKYNeq/2Tv4iqOeh7ZkKMvKEp8wvhNPamOgGPQ=;
 b=JPI+7T8r2UV+uF8XiR7KtxjpoQEdq4Q8MhCh/QH/+eQn13uNtfNWqrRZwCTg7mM4Gsj1S6rk9+Wimq27MKtQhfn29XzRWKlfy49ZInVfOxrP/IdpDGukDKt7cciUnFTr2QGEfUZEWmbe6lEQpLezeGyE1Ejmy8C3Jute/Wss/KRo1NWmiS+OeaUMn9dl59dx9eZTuPy/5xWj47BmoGKdZe9gLg+/RMTfRVSqCN0cUcksGhr4ro2B8V7R/L0fxEqMa6HBLbysR8xSFFOBt0cLyqrVUYQRuZ9wRFmKhiPSjXBWwxn+JVY/+YCw81QH2h3NBaoD5GV1VWtqVjgH+i8IvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/58] mmc: xenon: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:28 +0800
Message-Id: <20230713080807.69999-19-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: c1511211-cccd-4a6d-46f9-08db837865b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6f2K60YY3n8MkM8nW6E/VWJTwF6reYO0KrTiKeZqaubntkbuTexAP5HzihpE1A7XdbU7fIkNC2nV83Sk/5eJpJF2B/4FKlDhOpfqSCRRiI1fUgtX2/Wl5i10LV2CSL8u5s3OzweECN3uTAWkrlK5hnJzRm+AkPGj5E8KPEHfw9IYotZuQrWMD1/xvZZtqztbhVaOXnK68jG+u+pM/Bh0VQnV6Bq3cCWiMKj0PLmUHOrx5hGJR7ldcwbH5EP9CPTJkBtMmrOR1DVkY80JZspxy3SrwfvPDsWvzN5ATeIrAhI9q8zI6Eeamt1DHOPJ/XFYxh9HmuOsw0k5XWJA2Fjp8ievhLwDw9AqweVc3RkkHFWMm7n9KBpUALHlr0ZYY5zbS+U8lcy/MhbVk0nNYrwyoZYjYXaQXfq8UcMLgclAwKz8F56QW3VYwOx9fWIuwnTFJ9XHVys4c5qJHJh8T7/vv7SVUcxAxKDUYh0iHOg7DNAhOMkJr9VNzTJdMyOmMCPAWq0bU7yTz13rHJzt1hvn2vH5rl0bxOYgJiOYIotc9HWyl8tLRU6ogu8llozHKrWXxKQdDSeBI6Si/dhTTcg8kgaJDZtbQXSbfoAeU3eb4RlGH27ldzJ9lpKcKMN4URG6jgJs8izE6XomlKxF/OC//ah2unsYac7fS1MwOSWjc4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzZERTYyYXI2QmljWXpTckozOG05STBlbWp4TDRoK3V6bWlQeFU1ZjdmSGx3?=
 =?utf-8?B?bFpiZUNwb0tEN05RUXB5eUZ3RmtQQWpLdjh6L3l3eW5FN1dGajlTSkhxYXcx?=
 =?utf-8?B?TVpjU1VXa3RtdGxvbTRsWjRsbm14SjhyVzZHSGdCcHk1RmY0RGNZTEZKY1di?=
 =?utf-8?B?MnlkWTlGZ21nSmFpdGNicHJySjlJVGdvajBBdGpZWUNOY0hkWVRHa3ZQOUpi?=
 =?utf-8?B?dDFaQ2trWFlwZmluOG5wY1BodEJIbEtWYVZmUzQwaWs5M2w0TmdNSXRieHVx?=
 =?utf-8?B?Y0FOTmdwdFRDeWYwNTB5L2pSQXNocERpNGRKSlREZnp2Vm94TUUzb0Jrbjh2?=
 =?utf-8?B?SExVVCszTmFoUGlwNHpJNkVHTGtJRmtjQldCN3dPcENDNU5hdENEdmVsYTJS?=
 =?utf-8?B?TE5raS9sS2MrdVd5ZG1tK3lQYldwYWkwZmxSL0ZTUzYzNHU1VUdldytXVWFp?=
 =?utf-8?B?VlFxNTdkY2hTNTJhUDBwSk1QalBTd1BGRW5pZ0J4NDVhVW53QzZUVjliTFRY?=
 =?utf-8?B?UENiV0xpZmE5QzgvMjQ2NTUvTm80QU40Yk9La0dFbW1zQytMNGZjT2VUUXZa?=
 =?utf-8?B?dGRsWmIvcWZkajhlSXJWV2Rud2ZGMkFHR3ZNVHBLZ2lRYmxPUVBycU4zbmdV?=
 =?utf-8?B?bVErRWZMWU5lTzFZaEo0WWZkY3Q1YzNsY0U1L3VvNFlzRzcrWUUyV21aN0pl?=
 =?utf-8?B?LzJmckE1N292cHg4YWhKZGxHL0dwbE9QYVBUS0t0MklZeUxMNE1rRmVoWXVM?=
 =?utf-8?B?UzMrUGdRRko4VEFKSEhES0MvWElHU1lVY2o5OHg3d0tBcXRlMWUyWnhOR1lK?=
 =?utf-8?B?VGNMMkpRMU1TR3o3NnpudE1nOHA1WHlBSW94Q2RhR0NIY3VkbmZuUGhHM0xp?=
 =?utf-8?B?NVVmanJ2YkN4NWNzOHFrekxSNkptVVlNK1hPMnoraEhQQlJIQ1ZlSWVHQWx0?=
 =?utf-8?B?VmN4RHRqOFNjRzV2QkdiWmh3cGd1aE1GbWg4R09GMk5sZnYwM05rUjg0SnFs?=
 =?utf-8?B?T2FZTjhsV29LQVAyQklMRmZ3RVlTWE9qNjRwNHpOTlMwTTVMMVhsTTl1OFpV?=
 =?utf-8?B?aGYyLzN1Uk1Ea0h4U0tqVVoyRmY3SWNlZkc0ZHRkYmpGMFdUNEszVGYzejh6?=
 =?utf-8?B?eTI0d2ViMXJSbWwvQTZsNzRrNGpPR2F0Q0czZ3VhdGNBL2FwQlJlNks4S1R5?=
 =?utf-8?B?MC8vMVVPZWg1Y3hUaFplWkk4WTRVcFNNeXJ6eGtoM3UzRXpGYVREUm5sekl1?=
 =?utf-8?B?SFBiVFlVL1ByaFBzQTR2VGV4V29zbUNmSnJQR282S0djWXNBZi9kdS9BMnNt?=
 =?utf-8?B?c2Yzd0lHUU9DaDF6cFNkWmNqeFl2NnRCVWFKR1RXRGFrK2tTbXhxSUNXa09a?=
 =?utf-8?B?WGpJQjZ1NkRPT2VkMVowWFZIVitzTHJHMXpPcW0rQzBGT1ZpOFpLQ3V3d3Jp?=
 =?utf-8?B?ekh2RWVhR0oyUFZWRW5JOEMvRkgyMithSGNqRFFhVUFKWWgzdERpdHcwSFZa?=
 =?utf-8?B?UjFVTFVzYzloZDFRc2FnMWVBMVRYQlRkbkJwcnc1ZXp0UUY2dGttREhsUVVs?=
 =?utf-8?B?elJjbVp3aEEwMnpEUFNsV3pjRXhXa1hieFltZ3o0QXpuS3NWWThFQ240Wmt5?=
 =?utf-8?B?L2JjdVhYTGNCRzRBdkZRTHA1VkJNUFprUjY0WlU2bzVqek1VVjdHQmVDTENE?=
 =?utf-8?B?QWprWjdLaWhEa2pPdm1pbncxSFNuZGJKWVh6Qkh2S1djeTdTVXdabUNHdEhX?=
 =?utf-8?B?SmVLZW44bE00ZGIxNnFZWjNZWktKMFJIY3ljWU9CckErdHJHaGdnTnB2cUlm?=
 =?utf-8?B?VTVzTWl4SnhERGN5bGxJSmxGYUhlOTMzMUh4M1lXaFN6QkVKYXdUaVRDaHBD?=
 =?utf-8?B?S0N5cEdEMDlsZ3JaZjhZUkNPZ1BpbEJjeWltbWt0YU1RSmwvZExDaHVxeUJ0?=
 =?utf-8?B?SjVFUkc5SXExcHFoRmIxNUUvZkhsaWIvVFhuOXc2aVhVTFFyM1pDR2RaNkp1?=
 =?utf-8?B?enRyL1c3WTYwMWhZOGFZZlBZOHRPSXJSKzFZSEtiMzFmWktwcndsZmplb1Vz?=
 =?utf-8?B?YlJQQXNMSXB1ekM1V1NWVnpKaGJUV3NZMEU3TlJXWlMvd1ZBQUJYT3hKQ0lt?=
 =?utf-8?Q?XwSuejtEzXl7y/JsVa0jkOh3T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1511211-cccd-4a6d-46f9-08db837865b3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:53.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwmnY6vdx/jGnXIMar4a/x4xuGESPA1YDgzLVdsedXrd92CZhB/yV1jUyLei2XU/F60MEG+FIy2UO0VaD9kaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/mmc/host/sdhci-xenon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 08e838400b52..25ba7aecc3be 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -578,7 +578,7 @@ static int xenon_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int xenon_remove(struct platform_device *pdev)
+static void xenon_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -595,8 +595,6 @@ static int xenon_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -705,7 +703,7 @@ static struct platform_driver sdhci_xenon_driver = {
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
 	.probe	= xenon_probe,
-	.remove	= xenon_remove,
+	.remove_new = xenon_remove,
 };
 
 module_platform_driver(sdhci_xenon_driver);
-- 
2.39.0

