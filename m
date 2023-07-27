Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45B0764781
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjG0HCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjG0HBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531A2727;
        Thu, 27 Jul 2023 00:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQk7J/btflcwKNSyLJsis62vKBpMBuuLgI3CZUU+yAINtqLIicEusbttmt7YyRA5Eyif/NB9VF/EvScmcmMrcqG2P3o7lS1kUbBxlM1JjH74+ryg2QtnBDMkgD6eRt3AUeN4Upwiz7BYwZ0m2kusE8NlDOM41+FXeykm6aQh/+gkFwSrycoqTP8P6aehbEJzI5GaLNVL4s8TqSHyB5d4kA//q3EJhcBhdmHD67VdVrgdPSCXE05GyIDfga3rdZ5C+TRtWWA3ZOsQTHHkZ+uhWgQW5uz8UiCQvldaBZzlov0GmOElWWjczAwosG222mHJjiB8jQ+76PFX8vcB93iz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjvydvAOnf9fdqZRVZUVRLRXIIaoxUyvKCR2No+4ygk=;
 b=Ddarg2Hk0u7sKmqRUAh7UsEZdqoEhGY0iGaOfcSyb/1j7Gu2vJ65wlOo+yN128ShXsvZtfoNA1BYY3cecEYxta+yeO74F7g1H2WY6etiyVaw2eNU+8aILEd0aFLE1L8tRZaQJMZCXXIVzDXgLvJvvUGzu1e0wtAqdFh2tlQVw5fKDIQaYZI6vwyQ+HzKrIAD7onNuy9GYbqHapyM6wsIV25EGRbEGZ2OvjcbovxOeIWnbm+4zGUloosrClBV4vwLlrB8GRw9/bH/OwKbwOo676qv949k1e9jo3q4Y1uldfbCRB1lHTi/lfIvGITF9m+LPw1c8C74z2MhIibv4V7BoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjvydvAOnf9fdqZRVZUVRLRXIIaoxUyvKCR2No+4ygk=;
 b=lEHToHZ2X6qBDugXZ6mkNEFchJVvZzN0PzxIzhXHWZxONFmI8W3LI3l0GrxwTr0+D9bco2a/cpbvnl9zZRNG47SMfbfPsE6ec9pVB6Zb3ADADAx7tLoivKNjElMlRnjSCqZKiDZV+4nJ0BGPgeJuzhN9DsrQS9fbYSer6trPevjLUh/TelvsuBIJ8UG86PsV/MHOJHunU06bZu8gFrT7on60PDm+2WqOTjDBLzuEnMe5rub65LtwxmMVgvmdReRFN4fd2TiUZERzQmXdvqwcA5TVEmU1XNlaGtK1xWXSWv1h4YbkKQgBQiE1PPMh6BLEDU4Xjm1X4iJzZ+ij+8c6qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/62] mmc: omap_hsmmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:00 +0800
Message-Id: <20230727070051.17778-11-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d4eaba1-4d70-42f5-f7db-08db8e6f47ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4/6BkalZYL+Wg+qjSluOIIZYqqqP5CiizClEqR5TP1vY7gZkOaVLep1OoSe5w8Gc31B4aUnyz5W0kwQmxRT5CIboKdPA56brs7HPdSC5dmVOr6VasCrg8IRKbr8YxX2Q4EmAjfpJj9g+HJ79+Ovuj8tVKM1WwDzsSE08XEO0MBmA9HL7oH1n9ORVeWIR/9BbQM+X5mffprCn+NgZfQwzQYceh67M6vK9yJaT8GC5XOasqZLEfjUFjU/pUOKCrVsz9sJPcBBo2f296BYB5cRKYBXuTXnhqjhbuI5D7KMWYEaChCalhwR+ilOTb9PsxuySeUaZ19k573Ewlt6He2iuS63Pgb4rlCPfEQcDJ2+cv0c++HQkaGduMOL1irBM/E0cilhmzhB5cszcHbjjko0T0roXvA0EWX2tBlssAeAm2MurVrz5sJUee1jaFDRk/Xm5+xzgPTt+eAZa2jFQjtOa2WIuVPTGqvPZeIXHpDcMzt7Uub0/PCQF5JYt6Sjoabg0t9mvuiLPSYjcSDrPEjKIy1zjRuj3LxLBcxYP1nwRYJRQ45n+wAUrGEjKGi/QmscKdkXCD7uvfWa2VCsUflMx+ywXRWZHIECHeptVp1CVuZj6dkFjE3pfnJhrWAj4kJC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(6916009)(4326008)(316002)(54906003)(66476007)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFcxVlVGd0NlRTg4V09lTmFwUzBGSXpPa0Mwd0plazNDNmlrRlNObXdtc0tl?=
 =?utf-8?B?TmZsbTVzdERncUE0ZmxKTGhjQjQ1bnB5eVB4UVhIaHdINjJPSDc1ZjIyNC95?=
 =?utf-8?B?TmpLVnNUNGlSMlZOcjVYMkZFSlV6aDFtdWRBRjI4SjlxUTV0RGdLQVZUcSt3?=
 =?utf-8?B?NHdFUGh2NzArL29LZERQVkhmbGpGTjY5TlAxdmhRc3JlM053YXBsZ255dkJG?=
 =?utf-8?B?TFZpS0I1bU9qRXpnWWtiYzdKVjlIUDhyNVlrSkxqL0pWLytlM0dDV3NYdU1K?=
 =?utf-8?B?UWxnQWJRTE1tcEZFRHhvcXV2MEVNZk5xYVd4b2t3alg3U21nVjlOcllxQTV5?=
 =?utf-8?B?TXZ2SS9xbGRNTnlLcktnbmIzZnRHU2hESnIrUkZTZkc3dTRIQm1ubVhPazJW?=
 =?utf-8?B?UEkzc3dNWUZIaWlRRW9zZnQ2VWtsVlNhczVvS0p5bEVOdDZGc3RxYm9GS2w4?=
 =?utf-8?B?TDVoM0EyUS9NNmttUGRkcEQ1eHhQaTZIaEdBN2tYSnE0RWd6TnJCMldhbUxy?=
 =?utf-8?B?L1hCalNiblFZZlhNLzdqRjFNOUx6WHVsMU9aVGtIQ1l2eTg3aHo1cTU5ckpi?=
 =?utf-8?B?Q01nR2xOQlkrYWo1aDZ3b0pDR3B2ZUpLZmVWNmdVUE9CS0ZDZUFkU0Q2bUtl?=
 =?utf-8?B?eVRub3duQ1g4SFdzTlBMcG9aTDd3UVpEVTNMRUZwR2VPR0JtOGJZeXNxNGdI?=
 =?utf-8?B?UHduZlpDbHVZUzFNYXhPSEpYOHpRUFNCRmlBelR6UUdhZ1VzL2kwREdQUEJu?=
 =?utf-8?B?QlVkMWhScjFBbmZlVzNhd3NVME0zbEVLTFB2RlFzWUFRNlNVTVpMOW1ybU1m?=
 =?utf-8?B?WlJzeDFnZjM3ckVwVHNpSy82QUduMXN4N2ExbkUxTHBvcmFiK1ZzSzA1QjZE?=
 =?utf-8?B?bFZNdzJaVjRUNzNONlk1a01peGtIeHFkR3lKOFZhZ1hycXVsNnFGMUVPQytU?=
 =?utf-8?B?UkF3SWNZZG9IY2RmMW5JcjBvazUxNEkzMG5Ic05ocXhYeTZUUUk3VlFnTmxJ?=
 =?utf-8?B?Ujl4bEhRNUdUcXJwaXNEUFBZdmtXNnpleEZWRGlLWCtWbTFJdWg0c3cvQ0R6?=
 =?utf-8?B?MFplbmdwTWpFbHNpQkhOLytLd2VKQWUrVk1uUzU1T1FDR0Q4OWl4dWVJS2JW?=
 =?utf-8?B?dW90bUR4S1AwcTR2K1dvWXpIYlB3TnprTjE0aCtDZmRrUll3c2lDaHZLQjBQ?=
 =?utf-8?B?MWNuRGxFM2UwZlV1czQxYS8rWXFiYjRzSnpJajl0RjlLZGxIbHh6TWp1eG1H?=
 =?utf-8?B?WENnYkF5bzV5SUFwcE5IRkhNVkx1RFhqSllwaG80VktRMnYrVmN4M1ZkNU1R?=
 =?utf-8?B?V0h1RUZiREl4ZXA2SUFJRkxpRjI0d2VpWlVJajhxWWpwTW9nVWkycEFpbFZJ?=
 =?utf-8?B?WTFWNnRkTkNGUkFQZEg4Q28xUlMzbXA0bzg0NGtrVDFHeUtWZ1pLTXp3b29i?=
 =?utf-8?B?Q1B2UGtLUzN2YUYxU3JUeDZPUzFOOVMwTThDY1M5bjhQV3V4U0tseWEwM3FW?=
 =?utf-8?B?allhamVTUU5TU3B3bUlJcTZTcWdxcUc3VGcvdndGV1VoMzlxVGxZWmNOdEow?=
 =?utf-8?B?N0xhbjVvY3VRK3BHV055akg2Ym11TGc2WkFvSU4raE94OVoyTENDMWI2UGhW?=
 =?utf-8?B?dDNuRDRtYXBJTjg1T0RrSzcvSHpaeElNSjB6MUZVVnF3andIRVJDYjkvcFR3?=
 =?utf-8?B?RkZnNE56QTJPbEdkVUMxWmdEUEpUQ3dRY3dhempjcDBMck5TamZ3QXZ2bU04?=
 =?utf-8?B?WWZtYWt0MjU1eXBJYm9Tbk1HdmgxNktPSkpBeUhkdm9uWVNjclNTNVk3b2lI?=
 =?utf-8?B?UHZIVkJLeGJWSG1iRWQySTFITDRLNVh0WVl6MkljdU52eTc3TnBqOWNtSCtF?=
 =?utf-8?B?dkFNSTR6NW0xK08vWHN0RHNyOU1laHJDZENqMUJOdzd6R3NWekhNaFd0WFhW?=
 =?utf-8?B?ZDBqaXhpQ1FEUURHNUxxdHRlWTREMDdDRWRQcDkyUU1ONkhOVitKZW1OR1pJ?=
 =?utf-8?B?VC9xVVpicENrVUNUeDU1cVR6bW5VNTkvcEQ1dkVScVRSczI5UHdVQmdmWkl4?=
 =?utf-8?B?MWJpWHBZVHlWem1XVjh4RGxPSkdIcENpaFBjWEZuVk9FQXdaYXlqcGQzQU9v?=
 =?utf-8?Q?rmzvSVhuePrseyzOmPDakT1mc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4eaba1-4d70-42f5-f7db-08db8e6f47ad
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:19.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXt12BNbAVUDkkROB568b0HAmx9IN55W+CMC8i6Em6judpS9f4APWqG5lljGlNmDFuAhnSF+jOYlNdmbfuqfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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
 drivers/mmc/host/omap_hsmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 93de00a06aba..e120aeb869b8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1979,7 +1979,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_hsmmc_remove(struct platform_device *pdev)
+static void omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 
@@ -1997,8 +1997,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->dbclk);
 
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2123,7 +2121,7 @@ static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 
 static struct platform_driver omap_hsmmc_driver = {
 	.probe		= omap_hsmmc_probe,
-	.remove		= omap_hsmmc_remove,
+	.remove_new	= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

