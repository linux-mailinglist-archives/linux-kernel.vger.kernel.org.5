Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6CC764773
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjG0HBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjG0HBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9226A8;
        Thu, 27 Jul 2023 00:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh5bLWAVK/JEBE1WOI9kiYHZB1+uavj4ilI/IaeAvaUfVrwOddHtu+sXI/2SfZrbZkWxY9oTyR3gyMvmmHnv0kasjEnd99B3k6FGa8lLE89flvtgtDOZYTbWuoZ/PwbU4Eg2e296vyURnsd18z2iFR33P/O3Lwp+xQT7JFJW1YCXlS5+7I+iojlQUc7jHpeWTNk+/6oij9vz69/Hg4qX6fYj/GBIy64o3Wv+jXx4lN0npnWyj7WtxiuQ0Q3YEFXuRN24EMAFb7nVdbK9vWcvq6JzB3FTaVk+zt3V+YiQ4LA4wi7Kb+CoKhoy453BXN3VYZZGbnsqXk46S/gjRORVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QdurEMlGIZsmiqW8S2xEYZCcDPaCpY8fWT4ehR5P58=;
 b=etbIZOC+HxYEBIVdsKAgak6csW4ZTo6fZWebwB/s8TddLdfnSCf4FteupS6QHwgZylmkWCo15AlZ+rGsJbnhiIjj7H6FqnhfNVZjLn6d4FUB4KAinVIW9JadbEpFLh1bsfAzJ6OSy/psE4qgCYiV+EpZMcYLBUwuyNYn48yD6aofoPwOEf9s2DQUdFbG3hId+0cMgAx+t1/jyBRWpQ7Xm9MY01QAs01aGwIaZJabfcJ1OW1N4zPsSrZwhHy/tQ400zHScjoeDjfPgPQ2OG9D2CJrd3W59dDgcwsHdteVEZH5nvPrENrYWaa1P3TOTlCY1VCXOBpFkZIkpQYidDDobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QdurEMlGIZsmiqW8S2xEYZCcDPaCpY8fWT4ehR5P58=;
 b=IyHDCuqrz2YOHS2j9lwl1i0zdOqLZuB3oQy2Z/6jlr8lVcRf7+L3D7SGltKmVgvubsV8kFLC2AAbiimVV+hTtJBzBHUAZkl35TuSqMSQMgzRFeZMymIq0L5pMQqFnKbiCkActi5uqhbrCcOIX7ex37xM44Q4sQLgW0i7r6tJ6aI3gvgEfZTdbkXrrvdeLyCz4pSavITaLisuGUgY9GcQnix9+6nfKRHFCJc1DphYTrV41L225YrrBJIER0u/sgSxVkX+m4PeBGOkovxM23M3GcYMgQ6TYa6EDH1lEEjY6Mr3LpVjMy0IykX5DrV7KszmDj6cXJwf42pwOaU+oJkzQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/62] mmc: bcm2835: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:51 +0800
Message-Id: <20230727070051.17778-2-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 0138aed2-a23f-49db-9c5d-08db8e6f3f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZG76KbSoD9pwyH+hBC4G5gyzXMYWVQYRe1Q3RjlCVFizCio7tQA3zt693Zm7U+VMSnJtSjbsV1N53vsOd6phlSS+lPL5pJTAO7WsXbCImr3jRMhqBs1Dy9m9yb3jC2RwORwz4on/P+ZXflQq7VGReJvOzFCjjLyDt/BOFK5+8zW2S6zR/SEY84UcaNTeUrNxbA7cwMSpg1Trw8RbzJEhk7YSOxo5TKmWbRBfoxwpiin1jPxlrQv0uVKT3QYgRW0nWmX+uX9MGd4917IxYpudKGtoK/T2wrJkbCIcHKyXTepBmT2FMo+mW1PrQ0ZPgbvIwrFpl9Wby2vzrwvTaPrRHzLe+cmVu0uBF1t5EN4kajMgOkmjr35oOkXm3Og/Xv0gzBAC6LfVhYwBAb2gy+SpUV88yijOgSuVxuaK76WQWJn9XGBY4ndMbOvfpo5dmZ4FqOqSc7wiEI168EfYREzjDwwxocI2jS4FnLvxCsH7VUn5SCpL9e46aB+NmgHYHSYD9UjpSjt/QlODf1t9+lX8nNB4Y3aaawPRWUoTZzVALB5sEH14e2b0etDv4/ITAj8QRRiFQOHFqWSzFN9R3uQG0qW0Oa8SzR7Z9GqxklpMOlqpnEIiY+qHWhxg90wLRdV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(7416002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lwWFJjWmpxckxzTzFoTGxjMm1scm5xNW5mZDA1dkRaYlEzb3A3STY0U2ZD?=
 =?utf-8?B?L1BZaStSUWhwOFoycDNQK3NlU3RyTkZPZmNSNTRoUGJOWjNvRFZNMTZWSWJI?=
 =?utf-8?B?aTdHMHVFZUlvT3dUNytERU1WRkExU1ZyTHpPcmZxeTM1Vnk2NlAyd1IwS25r?=
 =?utf-8?B?SjBNVWZTZmo5Rk5LNGtyV1AvdlRYcFhMTXY0WFd6aGRqMFpqTUx5cmNPc2JZ?=
 =?utf-8?B?eFJyOW9iUk8xWEROZU9WVjEvM3ZiYjAwMEN2djRpaVlmL24xcHhFQ3VXWFJm?=
 =?utf-8?B?anU1b1Y5QlF5SjBFaG5UN1hpNmtHd0gxTUVKd1kzSkFhZSt0SVl5ZnpsQVhC?=
 =?utf-8?B?ZSt3Y3d0MHFyTW1yRG40ckxZREE1ajU1MGtUSk85bUFTbWo4RkNjd1VVN05v?=
 =?utf-8?B?ZWJaTDBlbXdDcTRGT245c3VkSWIrcUd1cmFCcXRkTXJ4MTMwZWxvdUxtdTE4?=
 =?utf-8?B?M2NlUlhycGpjR3NLQndnRzhrdk1qTGhUR0FFWGlod1BSeGZ6dWJDem5GS2lD?=
 =?utf-8?B?Zyt1QzFmaUhvUXNsdlhrSk5nZnphNnVtRFRZK1g1dWtqZHpaei9NT2NNQjFP?=
 =?utf-8?B?VDJ3Y0gxbjlidjFOWFBlQnd0Ukg5Mndyd1hCbzRBU3ZjMmdsY1pVd3ZMckM2?=
 =?utf-8?B?OWF4UVZMTE1EemptcUJyQ0NDYUNPQzU4NEU1U0tZTFZLaWR0cFhDdk9URjlt?=
 =?utf-8?B?TUxYaXVZTldHUGpCVDUyb2ZPdFVRSThnT2JkRlV1QUNrK3hTWStqTE00Wm1D?=
 =?utf-8?B?czNia2phYW5RdGRkN3I5U1psZU1TUHY5SXNXL2NRemZGMmhMOFVZdHFKMWhP?=
 =?utf-8?B?bHNRc0czbmUrNWJSQ0FDd1Jla01XdjQ3RkVjUHdRWE0zWWlscXhBdVFKbTFs?=
 =?utf-8?B?QUVQcktNdnlXalJCM3VaY24yWVhEekNldU1TdTdQSkl2WEdHdWxlc3JuZmlK?=
 =?utf-8?B?TWRiSmsxRE5UVkRLWk54eDFwNERSbEdYbkVGa2VKbytPTDdYd1JJaWsxQ3Jk?=
 =?utf-8?B?SEI0bi82b3FYK1pjZzIzMUVMYjViRXBvUEMvLzdiOS9JbUczbm1iKzBDK2hY?=
 =?utf-8?B?NTdFd2kvWHFKVmhKTjZnQ3RnVzlhRWtHd01SUDZCOFhvWjZjWFZaMHlqbTlE?=
 =?utf-8?B?L0VHYkkvMW5LYkdEYVZWZktSNTk1WVB0ZWFibHV3K2hGT3ZFbVlKTDJMOTkx?=
 =?utf-8?B?N1dPc2JINFpFcUhYdFg3b2pzVG93M1FiUEtzbjN2VjZIVVU2ekthWitHWUNn?=
 =?utf-8?B?T3RVdldUeXUxM1UyYTBrMUdDZEtySGtzcjdhTTN2ZzZQVUhCVE9XcXVUYmFR?=
 =?utf-8?B?bW1DaTMyTUk0b2tXdWVmd3RHYnFZNm02YlZCRGVtaEd3eGk1NUhQNldRWDY0?=
 =?utf-8?B?RU13NnlQS3VOb3NjcDNSbmUzMHRuRVlDaWMwUnVHOW1yV2V2WWJKNEM2bUR5?=
 =?utf-8?B?Tk4vaEtHL1FQQWc1bXFyL2VDdHJWRWcwTmNuVEdPaWsyRjJlVXVkWTVCNFU2?=
 =?utf-8?B?b2Z0ODliQlB1ejZzZi9WZmhhdS9MWjRTVFlnVXhia0EyS0lqNklHWTZIUzFX?=
 =?utf-8?B?bzlEOEx6ZjJKMnNJdlNaZE5vS3lqRW5QbmpEeDlBMi9Nd3FqbHNTbm1EdE1u?=
 =?utf-8?B?N0k1eXVOTFVncXhMeVN2dkFvSys4ODNjeDUwSzA2YkN4Wk1UeWt3NzY0Z3lp?=
 =?utf-8?B?cnpCRmNNSkU0d1lUSXprL2tyUENYWHlBYld6VlhFaTZoV3BsRVl0Mk15VzlE?=
 =?utf-8?B?M0kzeE1yL2pQKzdKM2I1U0ZRNDlYOGFlMzNmOHgwVFIzNCswcktZZStzenVj?=
 =?utf-8?B?SFpCb2lwYm1kSEpSbVVYam5nOHJNTGNhKzV2Q01lSXAxWE9qdkJxbnpVTWsy?=
 =?utf-8?B?NHRhbnlVcERPQUlwd09UMXBOUlR0ekltRkxxdENsZUozam1jODJTaWZibWtV?=
 =?utf-8?B?VlFsS0N0SWszZzVpcjJmcDdnQmZyeGxmeHZDeEp1bFpKUVpqNmpXV2ltTmZh?=
 =?utf-8?B?U3o1c1R6WGJ4eWFvL2p4QWJuR2F5M3NDV1AzRk9lOU9vWkRNcTFILzBDT1BD?=
 =?utf-8?B?L2FvQVpVVnhpVEhvVVh4MmY1bDBXSyt0cnllKzFGZ2xkL3ozVnNPb2U4Rndy?=
 =?utf-8?Q?NVweFEXt1BNjnQjcix7MyhEgo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0138aed2-a23f-49db-9c5d-08db8e6f3f2d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:05.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPhGKlukEo87AaMGy3jUccm54hayZrwfpuhE4mb7WG18Ytl7/D4aLzHF3ziZpA5hqfaK0wN5RALsN9tR9Wgz2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mmc/host/bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index eea208856ce0..35d8fdea668b 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1431,7 +1431,7 @@ static int bcm2835_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_remove(struct platform_device *pdev)
+static void bcm2835_remove(struct platform_device *pdev)
 {
 	struct bcm2835_host *host = platform_get_drvdata(pdev);
 	struct mmc_host *mmc = mmc_from_priv(host);
@@ -1449,8 +1449,6 @@ static int bcm2835_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_rxtx);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id bcm2835_match[] = {
@@ -1461,7 +1459,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_match);
 
 static struct platform_driver bcm2835_driver = {
 	.probe      = bcm2835_probe,
-	.remove     = bcm2835_remove,
+	.remove_new = bcm2835_remove,
 	.driver     = {
 		.name		= "sdhost-bcm2835",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

