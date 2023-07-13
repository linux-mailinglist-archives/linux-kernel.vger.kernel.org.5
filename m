Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51568751AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjGMILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjGMIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:10:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAA3A89;
        Thu, 13 Jul 2023 01:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hns1i5pe9/OdACZoN2eCbxr0gBMJOW5UxkZUrw04842zFoJpeLKhK/5vU36pHdmmldt1Uym7MNA2B32c55iH6DYhBK+n9N3uqhLMqXNdU+ILvq62ZX0gHW7xIFYdAzDJKWE4LcNX6dGhO/IId0bvitOZsE17+2kcR4qQa8jYZyxJ6Vu13qAK/g7RmCUcKFiWi0CYFY99QsjuSYegy8ZD7hnJI45yDD4p05Im/PsM1unONkTpij2LpTyq/voCs6g2dkSBH62HZcxZw7V0Ce6UsDWTgIRvA00fpOtJIR7BG9HKF5py13IoqSUcC/IAogwoR8iKoN3Mh/kv6QzUT+Xu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj+WD0ujQJJoGOzm0bS7zDFDRH08DzA9OwwXsON6vZ4=;
 b=gFXJ+LRDowomXfxKerpwvVEluxv7iish3VwoJYnWDoPNlp4xYK+jXclfFP2ni+1sW9OFBzc/iEjMSCEPgwx9OnEBMutp9EQ7BpvJ+XQYZ28xU6GjAAPBVzdWeh5m0Dt2uCp7F6mF5rDZDp6HvsseTiSqEYwPwwjRxeQYUnfyk9K9yoUah0yrKhWigGxTT/QxpNoHADez4XpHOfhIAbYFiFhWb9vr8Mmcl3t0hzfyhBtkncp3ONH8UfEDc93xyczoJWuqHWTpmUwgmX7jxMdTZUbuNZk1X8Z2+MJPVb/8yX5r3agsZrdH8B9J5nFHBUjJtnS0nKjhbxbr9mlpJ0MTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj+WD0ujQJJoGOzm0bS7zDFDRH08DzA9OwwXsON6vZ4=;
 b=p4SVItlmCwLHxYEmtHBY6K9BYUROGW4UPrxQRkAn40ij8e8Z2qOfvvXpN56jEJFeksyOJr8VyYgMfwLhwEcE8NNPObN5nbGmoRxHlQN0ZYe/rX39hDhj2xa2JxZ2TwnxsWFWyYYQ8m34rB5O8gB3MXnmRyGh2POtpDkiT74r78rAXJmYgoDhEoirfqLtSNnTt5kl0GGDGNmu2NH1o2yKs8UfZdaI5S7KYEIaJRixh6MFoGEsef5iK7ABLNeWFqn0Ed/Rh1M8jCeTqqejlDM2Wyd96YYXtnrKXQvJIAkXlMaTkEl11uJmjoVXybzYY3QbBg4zH8Cxa/OQ2eVV0vMWzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:08:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/58] mmc: sdhci-s3c: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:29 +0800
Message-Id: <20230713080807.69999-20-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fad94694-dbd7-468f-c2f3-08db83786705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5M78pAHMTAg9MEBEyIAOVpp2xzemk7fXkhf1TM1KMA/C1ulOe6vAhx7HeSJ/z2+0AZgW30tbjZsIzB6X52xyMV7wqF7kglsbW9uIhzvwN3PLxihhc9AOfz9S1tQNp1mu1NJD8BtyxcWaLEF7sjvgEUg91/AXiPUk6qVzGmWcO6RJD+U4yrZgbYgiMhelBNa1ITm7y3lxWbbtPhdq7JyaoakLSlsAy9z9wQ9x2B6IEFEce5w7RcwnAS/P7ae21D9NPqY4Vg7yq3/Du7oyybwwKpM/y4SsrCSkc8Gx4hhZjxs2BNXW5Us1RpJoAj3XfZ2hvjptpT8QItMG4V6UTAZz35wB9oYsOx2exekq2TbtU9dZF6Eb9ZpggkDQN/TU70oFOHWb1lHaFowtpSnfKHzDg8MEp1m02Ik8G5aQcm2lvKxZ2VNdP6ErPwPNS5tCvfxCV9M32ac/FiXHGQ/fZiWYJStHF/EHa4iafV6fZQIOVFbMd8Ziox4Dtry4jVJ7SQqesVSAPTYNl7cYJHdxftnPshsP68HiorFu1KEA4R3AEzC71O5Xuy7qg0uq+dlAN5DCtlq/UcxYnopPOorr10dptmFEmvNz+o8aPbQn0oBGPKhnrwsBvw7Qqk9F2HKyjGc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUMvOUo0WTdYdWZCWlptZDJmWGhvbkRUczVGWnRiQnpjQlc1RjNRNERiMUZC?=
 =?utf-8?B?a0RBME1Oa2xqY0lJcVlSL1RmK0xOQ3RvSkpGbHYwNE5rYXByaDZuREVtckJU?=
 =?utf-8?B?OEE1VHphQlBZSmFLa2FpSDNFSWhwSnZyeFFzUzI4dG1SMTc3TElwQ1kzdm1W?=
 =?utf-8?B?M0l6OE9qL1lTd3dKbm9IQUpFQm1ZOWhGQlNzck0vbjgvM3k4UUpGVzY5bE1X?=
 =?utf-8?B?UjkvWVI2N09ZeVZpK3RzYlNVdkY0WnZKUjRueXdsVTBvZTJIOVRiMHNWdzI1?=
 =?utf-8?B?T1VIS0NUYVlDejdXbVAzTEJkd1JDa0s1RTYwZDkwcVJHZXZqcnNmMUVJSUVM?=
 =?utf-8?B?Q241UUFjUG03dVVnbmZWV1VNTGxEKzJXYXFVWFUzSHVsNFVyNmhMdlhpS0lZ?=
 =?utf-8?B?RmhCTTJGOTN3RGhQQWFaNGIyMUVUUG0rVUx4NVExbFdFSWgyOVdJcFZoSzdV?=
 =?utf-8?B?ekFDZUpwVk14NDVTQ0dkT0F2NXlQOVR0S0gxRmFDQUcrNk1SbmFIVmQ1MFBK?=
 =?utf-8?B?UTRVM2xTaHlhMi9BaHRxRWdiemM2Yy9Xd2V2c2UrdnFPUEhMTHFDNWVvZlNO?=
 =?utf-8?B?aklWSWcrcXNKWFFjYWRnNEgyMlhXbkE5TzFLK3UwS1gyalM3SExrWlhNNkVZ?=
 =?utf-8?B?aHNNRDFMTis5RmZ6SWNoSWZZMTQ5TURDMlAwaVBVaHFlV2VTcURSOXBzOFhI?=
 =?utf-8?B?Ym1vTEZJOXlXZnpOZm9iTFhtWjNYR0xTbVFYL3BwOWdBMzVXRUhEUlRsNUZH?=
 =?utf-8?B?RHZld3FacCtXeFlHaUtWSk82aFl4Yy93Z2MxaHVmMU5NeUlaWGVnaVordEwz?=
 =?utf-8?B?NUxvMWF2TVdYa0dBUnlYRmNwdEliMXZrK2k3akhUekg2VzZpV25pYXJySlhr?=
 =?utf-8?B?d0pkODErd2xMczJHTU9hbThQZFV4MVNVYW9peDg3eWtoRUpkMTZDL21tb1hR?=
 =?utf-8?B?ak5tUVYzWTR2UEtLSFZubngyWmNqQmJiY29NWXY0cXpaWFVoRWd0SVptcE11?=
 =?utf-8?B?c1RhWko3UUdod1YrWWxXMDVmRFplM3p1bk5YZEVpQWtYWGQ2MmhJenpVMHFr?=
 =?utf-8?B?NjhTMlR6dTJkTXpYMGlsZ0svQlpwNWpQZGtGWkVuUFdVMkZwcHFrdFlPWFZ0?=
 =?utf-8?B?U0N3dG1MQmc4WkVEQWM3dnJhLzloNlhTcndpNmxWam1QR0FCbmhIQU5Ec1lB?=
 =?utf-8?B?Z1hQck9WeEFLa1AzUFZtL1F3Sjk2RzBzNVpOOHAzbUhyZ2VVTy9PQ0E4SWdY?=
 =?utf-8?B?Q3ZVRjF1NUpRY2VYSUlQNDFkVnlROHVZemJtdzdDbjkvbHdQU2IxdFdDQWdR?=
 =?utf-8?B?YklNUUZ5OFlHMzV0UkZpUUx1RGlyUm9WbnFkMVZOZXRZdTBTa2hNUFJDSUtq?=
 =?utf-8?B?OWw3RjBpQWRuTFBLOFBtY1dRTVZxdHp1NjBsY1ZwK21VaENyMnphTml2MEtJ?=
 =?utf-8?B?VlRpaXRYRHNxWXNkZm5Ub3ArbG5RdDhQT3ZlQjdjb3Y1c1pBTTJsN1hNaXda?=
 =?utf-8?B?ZDhvM2doVGY3R080eWxVWUFwUHZkM3pGY0dPMWF2dGdiM2w2cnBiSzJUYUlI?=
 =?utf-8?B?UTZxT2UwNzdGU0o5WCt4SzdrN3lHbjJjZW41dWgvaXRpODJQT2o5blBFY3gw?=
 =?utf-8?B?QTJCY0EwQnNFckZma0MzWVVxeWRUR2J5OEpDR21oMlNleEJJbndSNXF0Rnh6?=
 =?utf-8?B?aXE3L3I0emhLRFVhQXBjU2FIMWE2dXJBS0hxcUhXdVhmcFUxbDJYQ3d0YjB4?=
 =?utf-8?B?K2J0OE5vZE1xNU1FSjBWQ0tYd0hqUG1QaWMxb0RQSnprd2xpTzBodDU5R2lS?=
 =?utf-8?B?eFNMemdjeklxamhUY1Z0S3VoQTZJcHlldUtTVnVEbjF4UndheUdxTjg5YVpx?=
 =?utf-8?B?RmYxTWFOUUYwNHVtZkd2cnZ4cVpvaFp4cldEdzJQSHdraHFmTGlDRTc1VXp2?=
 =?utf-8?B?WE5adU1GbVF1bm1MQzJ1cFlJY3RkOGFrWGRGcjIvUlJ1NUJlazBaZzhhM0hw?=
 =?utf-8?B?Z0xaYzMyS2JyaXphaUFvRlBIVHV3MVFkc2swTzRqTG9yTTRiUjVxWmUwUG90?=
 =?utf-8?B?MmN6MjZNWXM1MFQxSWZxNU1hd1c4TyswSHA4MHNCVEk0ZTNRVWNNVmZEci93?=
 =?utf-8?Q?8lzlWSE5hzCuF5Y8o9l9ICMw/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad94694-dbd7-468f-c2f3-08db83786705
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:55.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp396nc/7IgariRgPUVWfL3jCTr9FNf+G/0uF8mSZu5N+vbQjRw0S8A5RXNWbo60LnwaP1R3Y6lFvGoS4I62wA==
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
 drivers/mmc/host/sdhci-s3c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 504015e84308..b61f12d328e0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -668,7 +668,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_s3c_remove(struct platform_device *pdev)
+static void sdhci_s3c_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
@@ -688,8 +688,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sc->clk_io);
 
 	sdhci_free_host(host);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -776,7 +774,7 @@ MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
 
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
-	.remove		= sdhci_s3c_remove,
+	.remove_new	= sdhci_s3c_remove,
 	.id_table	= sdhci_s3c_driver_ids,
 	.driver		= {
 		.name	= "s3c-sdhci",
-- 
2.39.0

