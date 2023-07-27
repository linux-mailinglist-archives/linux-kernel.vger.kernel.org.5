Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755BD7647F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjG0HKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjG0HJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:09:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20725.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC514231;
        Thu, 27 Jul 2023 00:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfzChjqBbfIqi4Lsmdd/kNQx+FGdLKuFjy9GvACWIowbk3HNBCPH2rAQXiqcfOAyzoAqWr+2yPvP0ljK6GGkIqMSpxpGmlLbSKD6xhvnR1vJA479oV2mky3J5DBz10K5CkRTIdL5WELgfZl6e1NhtufiZcFgLnVRHcdzNHQ+vl5BUL3E5ZlloXv4jYQuioyMyRJKlajY0GOEh9UZ1xETrFycgkEvTMxydKLgGq8ujesEUAcnJ0wk/cAnmSO1a+o+eTeDqqYzuccdp52fu61Hqeh4FexLsjcbEWo7H0u0g5V1/yQVt4+Tr1CCkx9Aj9o0yYo4LgGs5RzHUwEx6/jG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiMupy/2gpTgAg4IecGGpHWMYbsCUu9rI2DrKBUHpxE=;
 b=TMuzxHDpITtc8dqMTsDSES2UIe9xd/hkmbhI3+tTkVT++dl8M1FLGFhS2XlIfbRnQPTgWGwF0l/Gtc3zpqQjribAzWrEK5QuAyThiaUeMSvaZ0dWt2gS255kkv4zPOuJsmdrwliMDRRFY+nkWYRvMDpDPPmRC2LUOKUeNLnIxoORJOQsFut994+qGSUcALhMUatnHqULQ/o8P6xS9imDCo8k2kABVkmOLQvKN9Ktle3fIqmkoxMgi5ZtX+HSsfzbZsOzgX8M46ufsFj0gPR2snXi/LfVLri7jpmVPcXOF5ThDnmZqAsCnlL+5HPNx+diStw2ZEK8aeA78LIu1cOYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiMupy/2gpTgAg4IecGGpHWMYbsCUu9rI2DrKBUHpxE=;
 b=H8rxWy56h24l4Tpd+STKcLcob3hajxrgWLDRf/PEBcllg/gwtUXl2UfMnOlFpZfD33oxCsG4//rabds259EUm73nJywQytpD53jQYedE+4d+rBnmqhM/AslBe5aD3UHr2DHQ2QJaer4/ASM4d4/WvdQ9I8GX/3e+hgGqcDid0EXrhzHGbW9WJeQg/8TTCa3WIDbvufWBHfIqZA61iTosYuwjDyeuV4MRP7wtwSfJ+IbhmXbNRbKoclE8Wr16EWeRei4ATEI2mF0P7tUxW0xoOGq8xRHS5Lxutwur6efOvZvOHR+mg9ZNOG4MWnx4vHGpyB7UBcOQsMKSWHSuIvg9Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 56/62] mmc: renesas_sdhi: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:45 +0800
Message-Id: <20230727070051.17778-56-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: b45a852c-ee7e-4af2-6273-08db8e6f7542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xtIChDEQvE+RCJoRtpDjBTGb5Rj++t7ORJtFRqNqSbwx4PV2Mnbq+GEJa6YzCR1pFtOaySRZU5zda8fBx2fi9YERffq4PyOGUcp/Vz9DI9nySd//MRZmU892l+sGoPVNIgyQxcs9uwySlsQaSnnCuNQG6K4XlxVAJR5YbELReJFDVG8bVJ0/hOTL/RfXuPwaDP6MPxSA9pDLZxNNaA3nLeS0WiwQnpiJukIBZDFXMl8fp8iqT6IkvJW3FML6hbv+22V5/88h7/SgQrN7CB1p4+6exGYdJYcsGc/9Gb4WEdQhmKBUMFsfslLmXdEdmKL/DCiMZhkLMDEJjSxWvHjKJfWNyDVi80JgqkDvPW3XyQrVwajQbLjNe81FSgCGEbsCM371MKnr8dMwOPe3ZIXMrggJs89vAE6PN3eyVXIKwfmeZTxQInnBC+kjhrc88E4N65wiUaoZulIMylqOfi/t4QKFMCT0Gp4/5DCiNKDGWiQ+gjDO1ZmWtiUUs0ChjgCnyj6wMB3YLKtqxnX123j8tNR0zZYtJpvathS4d8MDxd4Hasiis9Ew6NODTbJDgtHYh23v//MO4t4Szbwm93pgYWL3j4aT0in3vWgzLF4JMPRahIWihfANs0EraZ34SX0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(110136005)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhLY2owdzJxSEIzNlRucUM0TVdKYXI1TDc1MUNkK0wrd1E5ZFVFRmxiZGFF?=
 =?utf-8?B?KzBNenpHZXhUcFcrSGVuUm8rM1N1Sko4MjRZYVRYSTdMNVpxL2lPRjJJVW5O?=
 =?utf-8?B?aEpoZm1lN0dzMTZOS1BIQStUYjNSY2d3ZUp1UTFhdlo3dHFGT0prNCs3OUZL?=
 =?utf-8?B?cE9jUGhhb1Q1YXAvRUFERkF2elhHbEVZenMrYXJySUREemdSUjgwUmhHUzVs?=
 =?utf-8?B?SUpjaUdReVhIbXZITm9RN2ZuL2x4ZFcwQURja3ZmQmFudXI0dFM0dE1TYm8r?=
 =?utf-8?B?TnRkUi9DZ2JaL3B4QzZLekk1Zm9xZStYdzZZY2ZhMWk0VkJpZHlRS3B6bFpu?=
 =?utf-8?B?NndHbHZPMUxkZkNtdzRCcjlOR0RDT2VMb0JhQ2k4TWJZNXFTb1lMQXJJZWVD?=
 =?utf-8?B?T0x3a1poM2ZCOW9pcE1wZHJibU1pdDZsU2k3QXM5Z2wwOGVsT3QxTXVJUTJL?=
 =?utf-8?B?TTRBM2RHSVcxNGFsUDNuQ1FRS0FVMUI1dkZiN3RoaVNvVllULy96aGpBYS9J?=
 =?utf-8?B?WVFHN2NpUGdwVVUwYWh5OFB0UkhjblpXdWNMS3EyRTZKaHI1cmxRZDlrK3ox?=
 =?utf-8?B?bTVCT0hqT1k0Si9BZzUxRGloK3kxM2Y4LzNxa0xhSUdOUkhINnNQMzB1cUpQ?=
 =?utf-8?B?eU80Q3kyMlo1SWNVMGZiWnl2OFEvWUdOc2ZPTUYvZlhVMm5qOWNDdkh6NDdZ?=
 =?utf-8?B?MisxdFhVWlArU0tGMVBTTDNoRzU2UHhVejZFZTNkOUdEU2pJVHFvY0RFUk0y?=
 =?utf-8?B?bHpQQVZqRjRxWkdwZVVmRTRPOTFCNThwQUgzOHdacDF4Q2FUL3lqWUxRVGph?=
 =?utf-8?B?Q3E0K2crdkp5M1FmU1dEM2ZvTzJtYTY5VkFJdmlQbURpa3RvdTQxNFdlbHhu?=
 =?utf-8?B?elk0bHBMa2I5eEhuTjBKSjNOSlRmZ2ZVVzU4YnNqaDh1U2hvVG13RytQa0NB?=
 =?utf-8?B?ZzE5eWgrUUJXaUFsNlhaSFNiZ3ZmOWZyOUNDWnlBTVAzNVZQUmxveitEcWZE?=
 =?utf-8?B?ZjBnaFU4NnRKYmUweHMwR05vVlZIQ05qUU5qM1YxQjlGV1UyWGVGWldWandK?=
 =?utf-8?B?N2hkY0toZ0hFOFdxc2JVMVk1MzFkWDJNUUJjZldxMGFLaitQWGhHNDRBa01M?=
 =?utf-8?B?Q21lSUVwVEtua0tBWGpmWlh4TUQxRHZxTjFtREU3QUhSd1JSYzQxRzJSSDBo?=
 =?utf-8?B?QVRBUmM5TmlNYks0SUYrem12ako3RmdPeTA5Nld0citvQ3MxVWttTVdYWGxC?=
 =?utf-8?B?MWJwU1ZvazlxQ2NKb3hXc0pRN1g1MkdzajVQWW1WdHVTRkFweHN2dUt0TjRK?=
 =?utf-8?B?NjUwaXprcFBmbXQ1THFYNlNxN3RGWE0rZk9La3dyQUdzQ0tyN1RYa2l5dDhB?=
 =?utf-8?B?RU9FTGFwRXVteWlad2xkRXd4MDRzcFd1Z3JvY1N5K1hyS0NKQXFHTVV6eVly?=
 =?utf-8?B?dzNsQ0t4YnFUTTFEbmd2aHlYNUFka0NtL0F1UDNBSWJUSDlZRFFDNWQ3dXh6?=
 =?utf-8?B?Y0NyblpQbjNXL0F1TjJNWlF0Y0J3VGpoR0hYWXpleGRKVGtMZHFVZW9HcTVF?=
 =?utf-8?B?MFlJV1VETkE1UkdUWWdoenkvNFhHMGhwV3lFenNJbUZxdGhWNlBRQUVGNWJw?=
 =?utf-8?B?U3FUKzRheS9yc3dveXFrd3NQeEE1cWxhZ1JhdnpUVUVxZmE0N1BLY0V1ZUZx?=
 =?utf-8?B?TENDZ3VtTjV5cGpXWGRyZ1oyNldYMWpVSzZ4bjZpZTl5UGwyNlp4bmU2ZVFZ?=
 =?utf-8?B?MU9QUnBlbzhyZGFpNHRVM1NaUzhtdEY4bmF6bFNrcHpqdzluVjhKVlFBeVc3?=
 =?utf-8?B?ZmV4b3RlRVc4TFBpeHBLdTRITmE1N3kxRXZCMWJmZFpydDZsWGRpNkcwY00w?=
 =?utf-8?B?ZHd4UEFTdVRkOVZRK1RRVXdlc0xQRGpuZmJQSWRmTXZCdDhIWEhiSUU2K2VD?=
 =?utf-8?B?cGYzS2pmYXdlS0V0cmZYTHRKQ3ExeHJzb1VCUDNIZ2c3U1liazVsTzRmQmxk?=
 =?utf-8?B?YnNoVlhSdkJxRUlMbUp2emZqd0lYVTYzKzlFOTc1OUluaFlPMWdoaW56Z01J?=
 =?utf-8?B?YVRQVXBXMkVRdmxPOHNwVW56cENSVGJRN0FIMjhMWlNlUTQxVHRYVURhUlg2?=
 =?utf-8?Q?tIXDidDns2G7pZtFcbYvwhGVP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45a852c-ee7e-4af2-6273-08db8e6f7542
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:36.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKprV2yE9sx7P62DoKB59z0D/zW05DYucwBBfawGHYrx7rMveSvq33zmLaziypk2fNjoDBbqALeW2+1RuJ1bBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi.h               | 2 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 4 +---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 68da3da9e2e5..c1fb9740eab0 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -101,5 +101,5 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
 		       const struct renesas_sdhi_quirks *quirks);
-int renesas_sdhi_remove(struct platform_device *pdev);
+void renesas_sdhi_remove(struct platform_device *pdev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 10dbdb4abc93..c675dec587ef 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1149,15 +1149,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
 
-int renesas_sdhi_remove(struct platform_device *pdev)
+void renesas_sdhi_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
 	renesas_sdhi_clk_disable(host);
 	tmio_mmc_host_free(host);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9ab813903b2c..d8efb8035b1f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -609,7 +609,7 @@ static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
-	.remove		= renesas_sdhi_remove,
+	.remove_new	= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_internal_dmac_sdhi_driver);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index b559ad38b667..248dfeef942a 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -470,7 +470,7 @@ static struct platform_driver renesas_sys_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_sys_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_sys_dmac_probe,
-	.remove		= renesas_sdhi_remove,
+	.remove_new	= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_sys_dmac_sdhi_driver);
-- 
2.39.0

