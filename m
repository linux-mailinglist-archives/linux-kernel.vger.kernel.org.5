Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE1751B52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjGMIPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjGMINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F62724;
        Thu, 13 Jul 2023 01:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6p4PAqt0K4KnEtXbavfQPtiiHb9AqaD/8zFt3Zo3aaOoz1eOudqma9Wjd5M1VI6IuoiOzCoAqXu5MrYDBZeVTkappP7ds71bvbxDqLwMhyGCRfy9TErVV55t1boLsEYIW0QBmkFfMHCUvM5vi6ig7ZK3YNwYoJEZPfLUiN5fMFgvuGFuyMG68vqi7JZcjHI/8iQD+ohBH7Rfxj7/wEJIFtWgBk0NNQm5hCqQsp3JdQEzzC3ixh4+/BMS6j1kl/JlGOPLqYhiCtlR3xpVyqGbAP3KZ8vSBUPatEpiKEWmo0CTlOmghEN7g1uQQ39yZUQ6YPwE12fNpBR1YYP7IWN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkSQcIRpO9SN+/pqpfb45OlxvpHWWTo36AUup9m79dw=;
 b=LhZC8qe6r8bpEUU/4pPeN5nt6NIwtskip+oGrfrU24CL6eCaHqPfjeYnHES9tDZxKirxgr3b0elhlJv23h29XVMiIKz3GCxdETTtLY0U40N1ZxYLgVUFimNiYXzydA6EewJnGuVFnOsUM5D+GkEhIJ0PMe3GWiK4A+G4J9a78IOKexf85djUjc2N1W4YP4VnqzSazR2LQaMO5p4Qh7lwQBymZweA2+JXHmNJD3FKQBNHCefcWzW3IiqLWFXr5B4cplZ6adY5ocWY88o6ZQTJJ42ZWvCVVFWj3soREXJQviw3LaTsoHh5Lq/Klv85+5rqBCYOB34LtvQj7OKz2Yx7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkSQcIRpO9SN+/pqpfb45OlxvpHWWTo36AUup9m79dw=;
 b=JByY01VZDKyYHT8U1apfQXT7ZVWAxmeurB402TUVYy8vhoCaR+ZzmQHykOMlqiyWc58bO11Dh51RXiiYRYumE/nZAg0Vobd7UivHKWKVFA+1HB4TNyvLj5FxtjJ2HNYZHl4LxqQ+URFEjY+VfTEkE+DiSX3o95qG9tx8qMDQnMYprjKoRtAJUu/jF27QafTwDpARcP2NNWS+SxoPVXlbeZdsVuZT/S4s5u8qiC+rk01xut3bolRBGszOX0MIxq5vFoHVuoQQiNKMcUpN5ec/g9gKfNveuwJn+lU6V/W0cOSokB8jzhAoGFfw4YqEalvhaF0Wm4O4Dov4CTrrUNVpCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 50/58] mmc: sunplus-mmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:59 +0800
Message-Id: <20230713080807.69999-50-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfe7e13-0bea-4aff-6b38-08db83788749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qYXY39w9weRl1RvJOYKrRxKg+xwRctkUQDYejvi6jXPJlQWwf9MT4xIZR/gl4WEoXiaPFN23jHP6cFGhZipYHcVbIk+LueoXwG+go+lTxkqguQa30fn/3lOzTFbNvTp6lq+quLONEmIaRVbpevGJlWbx24LBpEk+T1Lj4AlM/7gO/OHMJOTPM2mkYMo4vLoB2Y+WJGvXQr4ouYas9ddDa/9ctO30+u5pSoJ7yHerFKXAVT4d9VH2//TVsKFbW/vvmtMkco+nbPXS4jyinAv3USe3KYM6extL22Xcq4A93bCa6m9SgK99/tgRwTv9JqYGBZeeGmEyfUZo9fyZgX5How8pLpOvuAqt/QwpLA/Mv+0/0FVqv/He0mxmq1iOHwU2i73btyxn1GWfB7Y5A7EnRcWUA0LOWRVo20q0cO7aAca2BpnpigXeRHFOuedQd3Ufj4MZ9nnwVMMdkG8RUXCN6AvurGK6izmjTXd14mOLnyHi2ODK9GNDc8G4cW2pZpIqVzZSCZWLt/6lOKPEJY2wO+4ZvUkNfal7sy/vqI8WYIoBpCHaQgmHHTEv1rNg0CWE9aLFVJod5emSnAkZYRV9e6KKGUyhTscBHGe9IwYcf4mLn6GBebQ+r0d2hAaCfXw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWVGVWVydGJkVTR6T3Nia0RRZ2JsNmxQWlIxbnVWd1hUWUNRK25FdVdENlc4?=
 =?utf-8?B?QlRBVXl6TE9aUzRXMnBIVnd5L0lTMU5rSE5UMHBESkovdXNXanNYNm4rUkxv?=
 =?utf-8?B?dG5YQ0syTkVnNTJVTE5mdEc3K2l2LzNtNXFOSG0wTVI4dklyMVZ4dnFDQ0RE?=
 =?utf-8?B?VENqL1FaR0pQeXpZdjYvUkMrMkRYdXlidktRdTFpN3JpU1NWMkdJTG1VQ2xm?=
 =?utf-8?B?YkVTbFBabFkrSzAzS2IrUmxqSkVJSk5vTFdFZjRSNTVRaXIxMWRueHVnM2JS?=
 =?utf-8?B?c3VQZHAwM2FoalVFL3hzUkxSVG1rL21idm0vaFNPaU1XYWV6WkQ4cFdSUUc5?=
 =?utf-8?B?ZzU5RW43UWtUOW1WakoyK2FlUE1YTjZoNVJmNWdNOFpnWk9tNEVWRUN1MFZi?=
 =?utf-8?B?VjUyMVIwa3R2ZTk0eHFvZHhUWkI1cEg1YVYwdFNKL0pXZ0hJcmFQdVQ4UXRk?=
 =?utf-8?B?dnRqT01RY3lKYkpEcUJFSFVQdUtieUNEMmFqaXBVSkw0L1BjWkxveHZxTjM0?=
 =?utf-8?B?NkNDZHpFbW04aWFZZXlzV2NzS1NMVFBTVEdBdFI5bTZzWWtSdjJKZDlHdDJn?=
 =?utf-8?B?ZUF3L1BqREM0T0JHWndGUVZad1VqUXNuUEcxdlE5dWJhOFd1MHd4KzlIRGJw?=
 =?utf-8?B?QkkvMzkyRXFtTVhlcDFrWHhpVGlGclRnVnBUMlF1bnR0bm5FaFUzLytDUVRR?=
 =?utf-8?B?UG53QXVzdUxFNFcyVmlETC9LeFBuT2ZiekdkRS96K1hMalhUa0U0ZUNhM1hh?=
 =?utf-8?B?WDByQ3BMYW9iSU5NSkU3QWJMMWZYWWl6VkwxM0ZxM3h0Q1Y3ajdvUlh5REYv?=
 =?utf-8?B?OEQvQWthT0pOaGQ0NUMzTGF4a0ErVEJjSkVpcHRZQmJpTjN4cVAzQWR4WXla?=
 =?utf-8?B?UFlFR3llMkh2M0QwZjlIeUhXcVMraHdkUW5oVWRxM2hudU1Dc2RCVHpiaTJa?=
 =?utf-8?B?V3NDaGUwN0N2dXNyRGN2TFZXbUJZVElJYzNvMm5mY2pqVTNnZC9lN2dPRmhw?=
 =?utf-8?B?YWZwclFpQ1lWcFQxSGlMaFdGaVJZRDRTbnBNeW9IdllYUUhuRC9uWFozcEp1?=
 =?utf-8?B?cTBwWEs5eXBkRWNsZEVIaElnc1VUUU1ubmFwZzdBRkhVNWNqRHd0WEhhbXhi?=
 =?utf-8?B?c0NUTGpldnBjZ3VJQWdqcVZYZVV3N2JNVWliUTlRN3NRdTBLWUJ2Y290aFpk?=
 =?utf-8?B?d3NHRlhwd0tqamt2Y3J1ZGowMFcwSnRBTWZUZEl1Q0luY0RpdGJYUW5LQXQy?=
 =?utf-8?B?U0ExcHVZdi9GSzZTSTN0U0NlOSt5dSs1bXdnUmlqOWEwSXZpVy9adUlFekxD?=
 =?utf-8?B?dzdXVVZpN2FTSnQ2akN3ekgvUUYwV3dVTDE3LzRlOHhKNitQbDJMOGRiSmpY?=
 =?utf-8?B?aTFJZlkyTlpKNWZWN0hYQTgvYklORVEyZnVvYjJlaDRKM3hHTjFOZjZ6Nnlr?=
 =?utf-8?B?dkVQQnVCVnNNVEtzbnZpNHVNcjUzUDFKTVZZcS8wMS9GalNLOVJuK1lNMXdC?=
 =?utf-8?B?WDRlWHZpUjl3Ym5tQk5JQ1dTTy9qRWFwcGprdXczMm9lVW9tcFlXaDVBU0RY?=
 =?utf-8?B?L2ZHREx6QVFMUnIzRHZZTTdQK2lIWVBwd2VXaThMdEI1bHdvNWJ2ZzdDbmZp?=
 =?utf-8?B?UkpUalNZTDhaOEdRV1NwTmJ6VTBKaGp0NXZMcEJxTEdIbG9aV3hTK2UwWUJ5?=
 =?utf-8?B?RjV6TVZMQXRiS1cxMG1FTGVzY3Z0QS9sQm56VFY4S0ZreWxWSW5OOEk1TTdi?=
 =?utf-8?B?VHNjWWQycWZISHUvajNmMXdSSWV5Wi91SFJ4RDBRRWxwOFY0bGNNZWFtbTlU?=
 =?utf-8?B?NVJFeHlQSEJ5YkhlcUxDZXEraXBCaTFHdWRWNW5qelAyNU5xczhIRWtDTWp4?=
 =?utf-8?B?dEQ5VHlqT3NUaGwxUmJ0eU04YW5Oak1nOFlUcE1rS2dnZHh2dlZJNExIbmxH?=
 =?utf-8?B?cWlKT0tVWmlqV05RcHE4OHB3dE9kL2JyaTIwaGMycm9seHNuUE4zWTNSWGw4?=
 =?utf-8?B?WUtSWHdNdTFMaVc0L3Z1UUlFbEtiQ25zYUVBWlBEOVFYN0JONHJkS1R6UFNQ?=
 =?utf-8?B?TGZhc0N6RW1sck5sZ3N4MnBnWmUxQ0YxdHR0V1NIaHk3Yk9BdW4wc3ZqcTVQ?=
 =?utf-8?Q?nTaws7zsqup092DkmJNAhxKQU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfe7e13-0bea-4aff-6b38-08db83788749
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:49.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTb/VrSVdNgVNnccGu6pmVW1i4W/gEhihU2OmYE7yN8F+HYQAgjMlKNzKTvWaLy1j0Xej3ZQJ3uvuAdyYhiSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
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
 drivers/mmc/host/sunplus-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index db5e0dcdfa7f..a15371e98fd9 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -938,7 +938,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spmmc_drv_remove(struct platform_device *dev)
+static void spmmc_drv_remove(struct platform_device *dev)
 {
 	struct spmmc_host *host = platform_get_drvdata(dev);
 
@@ -949,8 +949,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
 	pm_runtime_disable(&dev->dev);
 	platform_set_drvdata(dev, NULL);
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static int spmmc_pm_runtime_suspend(struct device *dev)
@@ -985,7 +983,7 @@ MODULE_DEVICE_TABLE(of, spmmc_of_table);
 
 static struct platform_driver spmmc_driver = {
 	.probe = spmmc_drv_probe,
-	.remove = spmmc_drv_remove,
+	.remove_new = spmmc_drv_remove,
 	.driver = {
 		.name = "spmmc",
 		.pm = pm_ptr(&spmmc_pm_ops),
-- 
2.39.0

