Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5E7647EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjG0HJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjG0HIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:08:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A049FA;
        Thu, 27 Jul 2023 00:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgbjmGfMUG4FyTuiT1cw74YlwgVpH/bY7/1m7Ogc5bu+c8XBNvVurO7tXERO0MPktQq/Ef1w9b2OTZelrBOm8ZmoMB/8SIbAvpsSSV1TClWGeqhr4Kd04CGe6rtSK2laAgXZIyJI4CYVh0qzS4SY5OHndJx6AkzU6GQpsIvS7aPHCFNA2tAuus4k1JZks1oNrposB2+vSEV+WWB3aY94wkLUoRdQs0qW3QcweBY+iTJTKWgSp5b1ajPKVhZpRE7c/uKH8QRek+OLb2xYde9SfS9AtQjFIr3Pll6tZ52DUsWDhAiRDFUSUD19DmieTj4CsC2U860X3yh6wKq55VeKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea1uyoB9OAes3hLHcB2QP8c9cVmAH7ysXueKFlnpsyY=;
 b=csrNYWkiadUz/0eUNkFOmJurBiJqlJRX0whvRK39TPhXOqm14Rc36ZrBX9Zt8hQ5cZsQx6wLYIzS7djVaUKjhhyYOIWRGdruaIGBJexPwzoR6LAV9uAIRo1WU8qpBkKdrOyvF1fjZTz0MVz30Y7A31524yPlKUz1SAkdG2e/GWL2Q7waAvMrMelblaIpONAsdwKz0Lg0hhR3q85fezTRcjDLajG5fEhjb1rOYXe3bc4dDds6Z7lB7LydDcK+2KOVRL9e0HuwtK0+xsw/iMQrZdc3VSMHB4+giG36YL93qNaMhPRSxbxvvGip2OPU8GO59x14bmbGJYPDfarybtbL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea1uyoB9OAes3hLHcB2QP8c9cVmAH7ysXueKFlnpsyY=;
 b=Hn3q31PsTVEgtF4Ub00cSV6fkhzqM8PuvcnpcE7C6H71OPzLsVVrl5DByv99wuPYdC+9ZhjimX/pUMClKhCz0pusYuAEZ0ULS+FdfQHAV35m6DUR8f5OzRxx8Doa1+AEUpcTz66SPhMpce0D+ixDOz0u6RSwfeqn3MgQzjov9KSjzYefEqYKzpJnAtZENPiZs/skrtcDGKGYohLDW6DCuFcVcWsN4DrQLSG79DB83oVCeHmKQz8U153MfoidpCT7lOSn1oA+FfCK5TIYjGnYmRrI67HD8t0qPIKkvdeUGZyClVlIR+TumneMKO0yAfITQ2mYIHDLE6amlafGgqk8rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4152.apcprd06.prod.outlook.com (2603:1096:301:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 60/62] mmc: sdhci_am654: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:49 +0800
Message-Id: <20230727070051.17778-60-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: be7a9570-4a16-4db6-bea2-08db8e6f7a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVrZ+K9OvOpUmae369NymOq4bn+eqzZBBQKOyNIUJKHAx5C0+KmrFgPAhYWr3jQ6gewTqHxm9SzJtoDAt4oh7DfSva3jFBMaqKm5T92Otl1qUWvdQY0FNfE1zESJA2ZoZkq+b0LmUc0XEZGusvqTwkjwJEGNIFSWPYn/lpMOBolZuUAEt+4ycbsAUkdzVHULcOd2t0sDvGs6kbnxfH7ZHD3xxKX7qrFneW+LWVT/CrJjQGfyaQmTGlR2W+L2RJjPgoUEr92qEz4DGtctPyoAwRZeWz8h7vXbM2lDv6fTaQFQRJjE6pxj8uvygUjy9ZiH2eHqBH9lOgUwh7O/qW5HSOSppyPeH3jbqEXpoT+7AoI8slp7N8NJvjP3SwKijQHIHTpQGHSIEiBkZ6/lt/bL3/x0r6ase8KnNIOskaqi1evtmmQkhHj7SKGnkVaW1xnZSIrVgwA8WAkitl1C9jnFhFSvC9LReoJhevOlX2ZbzMDAn3B1nSmnyoNTM3SgnENCE+syRmBDCSyWCv1fpCdOBbuOi0xFkgVS39zd4NGnt5ow/CiRPielv1Fb+nrWpbfpy0jHhIT1T/DoGM5Wp8vDCwf0PRlbMXI8YBp9U7FoDZCw5zYvVnOCeiFLxLEY1SFO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(451199021)(6486002)(478600001)(52116002)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002)(66556008)(66946007)(4326008)(54906003)(66476007)(110136005)(186003)(2616005)(5660300002)(316002)(8936002)(8676002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxUbXp2bytyM2MvMmpDZHRPU1dmamtvVStCaVNEZjRhZVZBZnliQ2ZrWmlw?=
 =?utf-8?B?RUJkd0JxcWtoMUhIUnRPVnFVS3FnWVpDSG9SNm56TWtLYUc1Zmh3YjdyTWtY?=
 =?utf-8?B?VVlNRG04cElaU0tSRmVBQ0ozZHBsYXBMeXk4OTZIeCtUdE1VS1RUVDlvenZR?=
 =?utf-8?B?MGs3Qkl1R2Q5MHBFVzUxd0oyU1pmVXI1ZGNyWnJ4clZlbzFIcFJNUFhrTXgy?=
 =?utf-8?B?eE16VFhQUDJqQWJSWGJQTGhkUVpjcTlLZ05ZSU9DNTB2T0g2d2RBVStDbjdB?=
 =?utf-8?B?T21nNzBqNDNPb3VvcFJDaFZEanZNN0JHU3hCUkVZejNHRXRLckpHdHQrK1VT?=
 =?utf-8?B?dGRyNXBvM1U3akJTMFppZUpaY3pja2RDMGVvWXl6NlJOL293OGt2STZLOERX?=
 =?utf-8?B?V1BZVERFLzJPUkEvQ0IxQUNsWS9EMkRobENoSXZ6NElIOFhFMjQyVFpPZlpm?=
 =?utf-8?B?N1BxbmNTWEdrbXFpUGhOMlB0Q0dsY1hwT3BFUEk0aXB4OVNEQVl1cy9RL2x0?=
 =?utf-8?B?T3h4THY5dUtXOXB3elVsbXVLM2tkT0t1REl3ZlNhck1FdGc4YmFGUlFyRnkw?=
 =?utf-8?B?c3R4cDMvZHUydE82bjBKZGdGNkY0ZWZocHFLN0VqSEhtQlNsMHNyNVgxc2lu?=
 =?utf-8?B?THpxdFI5cVkybGpVbEpPemZrZ0J5UFpsb2YvK3Y2dHFGem03cTRoeGVWcERX?=
 =?utf-8?B?cjhIMEs3dzZ3c2xOMGM2VkJrdk04VWRhME5qSjBXUzEycE9aRlI2ZTN2OHpv?=
 =?utf-8?B?SmwxZ1lwMjhXNjY3dFhnYlkzY2k2ek5KK1FVckpZTUJ4ZXlCNlZVYU5jZHBs?=
 =?utf-8?B?TVJWSkNqOUU3VnJrMUZ3UmdZOFF2dkZKOCtWVFY3SEdiRGc4ZFhwL0JHZEpI?=
 =?utf-8?B?bDZIU2ZoeElKbXo3L1RBWmt5amJhekRWNXNIOUJwUzFCQWZtOEF4ZWsvZnlP?=
 =?utf-8?B?RFFwRDFMOGJ2cWRXWGpIbjVUK1ZxQ2xZdFRXMm42ek80UG1aeWJtaWdJM05a?=
 =?utf-8?B?SmpvMUtQQ0lHdzEzczFubzZ3ODhkY1pjb3VmV0pSZlVrdzV4WkloL0NGTHFL?=
 =?utf-8?B?MFlCVStXcE4xSjJGUzlvQjJxTEpTVDNhalQvSmcyeUM1QWlHa1lmQ2NCZTFo?=
 =?utf-8?B?VWJSU0N1aHlQbEIyeHl0b1owbFNCOU50VVU5ZGZDZDQyQWtsMjJrMDFTRGdt?=
 =?utf-8?B?WlBZRjRFcmVIRTVYSGxqdUEveTB4d3M1TmZES1J0WFp6YVZ6OHNHRkY5RStN?=
 =?utf-8?B?VXNEUThkZWk5aFhwcVcranQ2S2tQQmw4UWp6bk9pWUdxMi9YZnFQaGdKR0Rt?=
 =?utf-8?B?LzlIbnJZS3Q2bzJiaTZrVUJENUE4RnREaEpQVmVnVHBGWFp5NStPTnpHNUZ2?=
 =?utf-8?B?ckdwenpFbUtleU82QlROS2NLME5NTGd1eXEvUkVwaDBKckJyaC9NNU1jTlZ1?=
 =?utf-8?B?dk82YndKRHZSdnE5UkFPdmQraVdwN3FQU25INlBYN21LMG1UK2xVdDB5RzVV?=
 =?utf-8?B?ZjBDbzBPS2tPZTVpMzRFRXJ6Q3FMWnVuS2liZUtrbHQ2bnVYN3ZuKzhEaFFG?=
 =?utf-8?B?T05nOEhqUkh3UWdhU2pJYm0yQlgyV01CVHFUWmdNNkxqaVAxVEJnUFZjVWto?=
 =?utf-8?B?dTFxVlNNMzNrenMwZ3RjWDZSYWxYUi96Q3hmMDRxWFBLeStYYStkY1N5dWtE?=
 =?utf-8?B?b1FnS2JpcUdFM3dQR0RDOURJaXp2eHprSGlZT1A2bmo0blU3QzJpZVdndHlJ?=
 =?utf-8?B?TlowVFlXSmJ0KzUzc25CSzduV2dYS0Yvd051R0VJVHRTTzIvZjQ4SDFiYzNa?=
 =?utf-8?B?d3czc1dEcE1EVUZNTnp6eDI4MDZGUm1oeXdOdncxa0Q0aGxIUWZZVWcvRmRi?=
 =?utf-8?B?bUE3aTFEOFQrMjhOeSsxRkZDcjF4dUNUaFpBTXVFNUNBcnp2b2pTY0NKbEdJ?=
 =?utf-8?B?TkZFaEc5L1p4NEZwU1ZoTTdSVy9Ga2l3cG9QYlJsSG4wOGd5WitSY2U5L09H?=
 =?utf-8?B?eGVKUnhpNFlaYlQrZmtTY2RMTTNSWFZhZlR2eWJ1My95YWNqVzNURzAyY1c1?=
 =?utf-8?B?QVNHQUZrMVQ4Y3NnY040SDVsYWNzNFQvVHBQZzJyY25yZG9GcjQ2MU01WGZy?=
 =?utf-8?Q?izMm8yZdDBRroXT88lMHB1SBW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7a9570-4a16-4db6-bea2-08db8e6f7a6f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:45.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqlMwAEra4lAqjyvVDHWctf6k4zkM7lUv4z0QDextpF5I6Mh6pTIq108rYffm86asQ9BWMhXP/8PVPIrN8vP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4152
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
 drivers/mmc/host/sdhci_am654.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 1cc84739ef2f..c125485ba80e 100644
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
@@ -882,7 +882,6 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	sdhci_pltfm_free(pdev);
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -994,7 +993,7 @@ static struct platform_driver sdhci_am654_driver = {
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
-	.remove = sdhci_am654_remove,
+	.remove_new = sdhci_am654_remove,
 };
 
 module_platform_driver(sdhci_am654_driver);
-- 
2.39.0

