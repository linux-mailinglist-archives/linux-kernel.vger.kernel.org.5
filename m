Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423077647C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjG0HG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjG0HF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:05:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726844A0;
        Thu, 27 Jul 2023 00:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrRkVKHEoxamx9QXYM5DjP7JvZYT6rylLnkwqbCe62vIUzy7qVxQ5p0pVeiQoCOsXDtSsfFmivbn/h8uGpZn7L2Kr8tFuwTYeZ1C1bgpjnMHLlTwXss7PjT7h1SiUQEZRgnbTWL1SvS0l6uNz85jMXuUtiFK7qkbFyzRw4LZVuB++ZItgAZp9BoNbf92cEQcVjQTVGudycJ/KkZFH3ZMF2xo9pHtWecZZ1iWvV6s3KXLj4xZ2ljFciHebPzzC11TdXqLrxQHYkq38oQglQHiKbqt8gbpJ+ulk+AH1NM6mgDFyNW9rbcE9jZ9lHD0TEC9TRQAiqQp6txefYFp06RhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km5SLI9CwGIZCQi+0pIE2z3vwwmcgtBqTHQpN6fP90g=;
 b=ePTjRbphOzp1xBq4Ik4JgqYyTq/Zoos3pemFweUIr7gqKHmxECDqwdFILrLNmmVSO7Wmqpsn2ubosBoMvngE7bkdNs0w4SVxUSUi1RRRq/pwwETZKRFxxf8GfpzNZOWdm91A8NL7uWBsg/AEpI3mH8g6CxQpkp6knl5X+RGYcKp4ir6FOmdB9IoxMsH48BNjHBDuz48ZquZj6CmTtiLGxenAg4bu83J2J7Kx+Nw8GotArMD/zzhzO4j1jdZIAcSK/2JQVQZkN0sNTRwmX0HsmmK+6NTu13X8TFQJ16iBy3Blj3TFmb61r19+l0j6+p4uc3/JB4FhZVCGY3dwq2KW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km5SLI9CwGIZCQi+0pIE2z3vwwmcgtBqTHQpN6fP90g=;
 b=LG0fl5uWqI07gVDrSSsxev8xPeFsLo0BoI5OP8IrW7wMdTgRhKfzWYy5dSv9HTmoDTqI2QwwQ6r8EmdW24PV2Wlhcsu9yq2lBQW4vCzPsBkj9bKcE5TT/k1bq7vtdTSgPNFBjpE6+TJgpf10xfiUankEWdL/GcVGjQfx8Jhpxz5N7D45uE6YvspTVm6YhrGvMRMt6UHRShvown2EquvSekOWGIykKGaHwW+/azW8+hgjYWuU6wLA31RpdXYc+wliKCTsHS/1OWLShFYJ8wXSYybsx/FsjtMiJD2xgOqjAv8IWXpMIHzfFvuRsfxIfAZFz6+hyWP2W9XwEDyjVIHBSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 39/62] mmc: sdhci-msm: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:28 +0800
Message-Id: <20230727070051.17778-39-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebd6aef8-6ee5-4147-b2a0-08db8e6f64d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKtsxXqBGSe7s8f9/ibhccb3492unw8jK/arkaEKvkJqfizEsMavQ2GWHCmtfYY9/ugTNTKE81k7hP5GY459OQwtyg3FU96hwSf0KPET4yG8zCDdZNAvGwrTpctuBFabDTw8n3e9QzmgK9Pb9loeLAqIHfqOW2fLahVNq9nHtS2BnjeSL4vyVVSviZ/+0HB0uHoK0GpRu3t+T2gMHrEGXS3//OUF/XSHyW48s0qPKrCoxQPp8HKJZ6y3kjgAIoRpsYySW+3snOhd36UM7187iLbgFZmTp0u1QnmT1+aGFNhvQUpgXv5rTGhIe/pF5mads7Lz9BrIBY3cOYJL/IJA/5ByvGmLqC/Qx5f4vm4mJA3NQ5QexBcA07vaUjhP2P5+o48EmrulMFsZ+xqUzBd1mDmrJdrr8oOhNqV0mpDoXu5b30T4LL3UcXMNpZmwvzMpLdT9bv9zbmeJjN0RRJTago0JLMddT8c2LxDQt9Kai5Muj1XalIiiBKfSILuu8jLLe4bCpFuBS0GHKL7x1h70Vh5zaEI+kPzLYL1Y/dmRFESKFPgTKAetvq6B+zKax39sMrCv4fosHZCQs5gdwoDuEtUSmnqXU2gjdVbJZl+uclPjLWHvBoAyBE8OsCGeROQP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(66574015)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVtYlJhQVh4T29MVDdBY21FQ1poUnRxZ2ZrZXNvWkcrb1B6ckZoclliSXlz?=
 =?utf-8?B?b0xxSHhrdFR2enFxUndCSUZoL1o5aDE0M01SL2s3RXZpNW1HY1dGNFNqM0E3?=
 =?utf-8?B?Y0NXekFQRlJTVzNPWVE3RUhxa1UrSXRRTEVqOGRhU1FobTRyV2QydHJ0WUZ3?=
 =?utf-8?B?UXlxNFk5TW5jOWhhaVk4U09DMUllbWRtMit1QUNwRCs0QlpRZ3pOTGw5MVp6?=
 =?utf-8?B?b2hWcUV0bGZqK3pZM29sRzQvMzRhTm9NUnMyaHQ2Q0IxcXBERm9sVTBQa3V6?=
 =?utf-8?B?U2FoSmpONjlpRTMrNDhybm5sb3VUYVIwWlc3ZGlaYzV4MUhMTUNzRklkWTN3?=
 =?utf-8?B?NjgzVk9pamVJV2ZtVzFoWlFQLy9hOWZVazBNWHZqc0NiRzR0MVpzR0xlQk1t?=
 =?utf-8?B?MC9GOVNVaVZoSlQ1ZVdCY1Y5eUlPMUpiYjZDdUZtY0NWNUk5cVZrM2U5UENp?=
 =?utf-8?B?NldxMlpia0RUd2F1VExIekZ4S05TNG45bmxNRzZjNGVoWUFnNWlsVTM1ZUtB?=
 =?utf-8?B?RXQyMmdjYUh1dWVIMFZYWDhwQXBza0R2MTRRNDhpc2dHTUNUSno0eHRocjFh?=
 =?utf-8?B?N3RQUWpSWGNZMm14Y3hHM1A1clg1WGdYanl0cS9aVzBGTVhmTDhKY0VCaEdV?=
 =?utf-8?B?Y0wza1hoanZLblMrNndyUm9lZHZaTkwvdUU1OG5YOHBWUk13UG1FcXVrcE5G?=
 =?utf-8?B?czh5cEYvRzlQQ0MyaDBzOWVNNnJ0OWV3MlNjcmhoOVlXSlJVL05KUnFXbXRU?=
 =?utf-8?B?a05uRUR6UlJjYXltRkZIbUFOYk9pS2UvNHhHUmVTQnlYM0ZrTkJGKzM3YU9B?=
 =?utf-8?B?T3NnWWZuQmdsSm9aMmlsZ0ltdmtZNUxHZ2J5Ri9kSERIaWJleWd5S1c3VVpu?=
 =?utf-8?B?N25yVk15L2xLZ1lreStJWS9iK3czR3R0SzQ4SnBFU2YveGxaU3FJK1pKQzEw?=
 =?utf-8?B?SVBHV3lhMmh5dnZ0eUZpMDBadFJyUVkvOE9tUjZPeE04MWQySGFYakczZWJs?=
 =?utf-8?B?eFZvMWhMMHNhQVI5bEpiMGxsaWxPN1gxQkR1dzBCRitoakQzNHA4Q3c5TUZZ?=
 =?utf-8?B?UjBqSHhyQWt4ZUh1VFpDNElqUXZSR29SKzQxMkRDcnBiZDRVRnFST1I2YWNr?=
 =?utf-8?B?WElPY2dPSUMveWtVc0JhZmhIQjFjYVJoSjM2KytQVDhKSU80SDg4UktaNlBt?=
 =?utf-8?B?V0dXMkpzYy9xdTJJczdHMENBTCtzeGxNeC85SGxaNWpzR3NhVWpFcXFIWUw4?=
 =?utf-8?B?MG5wOEdmVndxMDVsWWdUU2VQVXk2d2dXWFVzNFZ5N1hGaDVmUy9lWU9DMXkw?=
 =?utf-8?B?VWFKdXR0d09VMnpWd2ZhVHUybXp4TXNXc2FkdjhDTzZKbTBjM3dVdUNzTnJ1?=
 =?utf-8?B?WllIc2Z5NCtwWjE3WUp5SzVodDVyVFB4Y3dISnJnSmxLRlVyTnJHMllFaHFl?=
 =?utf-8?B?NGVsL0w5Zy9SMnNWQVZscGc0eml4UXgwc2xBR0w2c2lTMjJIa2tHQnNKMEZN?=
 =?utf-8?B?by9MVVZzcWY4RFVsTFlLSlRjanNzNUNWaG9iMU5rU2NmWklYcVI0MTZMelFw?=
 =?utf-8?B?bU5aRWsrNk9ZTnZjLzY4SnZ6K1JGVzNDVytLdEVRand0ZWhFbnp2bnh5V2Q3?=
 =?utf-8?B?U2FORERKMVRkMlBMemxHMzBGdTZ3ZW9ydHFXNWFuT2pYQjFTZW5NVGlWcENt?=
 =?utf-8?B?eWJ2T2hacTF5ZjVZV0d0YVlsL2pnaW8vcHE3MC9HMTJNU004NDJ0Y3dnTnJL?=
 =?utf-8?B?Zk11TVYrQTVkS01HSnh1RUZiSFdoVTlQbmdQR3BDMEgvQUdacHB6THZzRTBm?=
 =?utf-8?B?VDVvbis1ZTR5RFZHc1lXelplTjRRZ3QzWjVnU3Z1OGxGbENNaWQ1NlNROHFq?=
 =?utf-8?B?bnMwUGRWc3grSkI0NkpCamlsTTBnU1RhZ09aZTJUNThHY0pabW5tbUNBV3VL?=
 =?utf-8?B?Q1piNWowQXlNQWtNbUJDb2VTZU9tL3hFOER4QmJVL3BTWHZRWmRWVW82STdh?=
 =?utf-8?B?QktWL3ArRDJNWjhWK0FicURiZE9icjQ1T0hmNVIyMDNZNjFKQjI4b1JHeWth?=
 =?utf-8?B?Y3FvbEpzVE54UzRnNkNOekE1VVVtOHdseFVFazhtU3UwN21ZQmlzKzd1OTgv?=
 =?utf-8?Q?qQaHgoCq/XqjyNCI5K77XxNG2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd6aef8-6ee5-4147-b2a0-08db8e6f64d0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:08.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/v5oBPRnWDVpQKHQi87fnp2GlnSk69uvAjuYbxSIcA1XZUTPFTsPcy7T3lJPgXubBccH6cTRvMTpPt6M8urjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 1c935b5bafe1..80e376802ee0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2668,7 +2668,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_msm_remove(struct platform_device *pdev)
+static void sdhci_msm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2687,7 +2687,6 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
 	sdhci_pltfm_free(pdev);
-	return 0;
 }
 
 static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
@@ -2740,7 +2739,7 @@ static const struct dev_pm_ops sdhci_msm_pm_ops = {
 
 static struct platform_driver sdhci_msm_driver = {
 	.probe = sdhci_msm_probe,
-	.remove = sdhci_msm_remove,
+	.remove_new = sdhci_msm_remove,
 	.driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
-- 
2.39.0

