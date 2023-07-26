Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0BF7629DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGZEFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjGZEEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:04:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101D469C;
        Tue, 25 Jul 2023 21:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLfu9+Qs/BNPffXQB/Dp3MMPWkVYDSDbojNbyWJqyS/ajwWlLXsTD9NDINuNH3raoPTkuOePmUoHeciG2UWeCGWQ7cmLjMwXN0//9TzOSpQoNGza1ppozw0RZzQj+TRMlaHRuxzoIX2J56Nh6+S+eonPTTM362+iyAaRQkF7lRgH4F8FwDWxj6qic2Y694XCZF3mxWTvizHCweJWIeDpZ3sD4ICVzZy76gNT2yViKQQ84MfUk0wl1tSa4LWIzvHORkm1SIpR2VEt/+1kOuZWD/hIcJrN4Ccpv09N/wzClh02LxwqqnOMkOFJ0jdaELrCBqNwTBBGYPhm321xTb7FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QwyjiAPoUwvuuL+fTQzivWNofmwHauOj0YWTiKbAgA=;
 b=PkH+X9z7iwL26R28YXdG16DtJ1d5+jzCrK44jy9TjvIpq3GRDXzkfiAiNw8Xj8ike+RZgq7Dk1RdpFc4I/ZGIQzP4fVDPYWQVlA4mTRiNBbjsPkObKPr9FcZ6wvC+MDW60ws+1VIMFD4zvXm0Y9zH2RsY+0QnvyIl5oVmWDVzfOK1VdkuLg9CcHAKy8VkVqN1gda2kug1bSWMLMIffk/oweOA1JzNl79Q55FdN04BMHGH1vJhL2rSIlX3REtp2j6yH4IiEMNr/WIyUpUnuTHEIc4t+1is2rd+VupH6bBiA/OFkqm4vQnBt5K/iZ9l2BkyyrGZ1umTN/2tnKLCTceQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QwyjiAPoUwvuuL+fTQzivWNofmwHauOj0YWTiKbAgA=;
 b=Q845ViZ17YoLnlQCaht+nsTaVOyqWtnXWG1VPVtYYTcRFUrTk1TafAic3gxXvibninb/Z6p1bVhCh81laf/DpmqOwJMcvRprvZFm7pdD78nwUMyZe51YVCUhGEr26nm1ZgO715Ietd5gCGOx8ERqiVBIOn9RpCub5WHPhii2vIrhbg4zSYmT9HYLRzm4N7Cf/nylsK3n/t+SyQ8sgOygYnSKJRMqIr/BKzppAKmNvyzH26GtO5TOWChB+hkK2bIhGBH5FaHnV0fOB4pN510rP1aLdlFzoZnF7MIJe8+U1Ssc/C1+QgI1I+4puv/Vxe5ZSx9J1uU+caRIG6Cje7LwLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/61] mmc: rtsx_usb_sdmmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:03 +0800
Message-Id: <20230726040041.26267-23-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726040041.26267-1-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d669155-5e32-4496-70fc-08db8d8d02f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lk6DxO98cHo1SC4UIUtEU8zZsAxOxN6uVxkAlf+rnZgNmWmVA9D9j2CsL8crFDIMTTZIbJDI4hbyy7ipkJBlnj5piTC0rAjnwCPEFSHupv5YoRGgKBVOHPUNud5oC3Rkjvr7/KlikXyu1EbZ/vqyJ5Eydnbrj+JrdL/y1ljAa/WnLCiMRy+oNxiX+wogZb60R9SqYAUyq++o6PODLs+jKG4wBkRCdS/4k05Z4vZmq/lA2I1xAWzJYqYEZhBk2vZVZB00Ak6wvqR8F36Tm1UTzoDfW5MJ9vBYyZd3rBLEKvdUUrEcxv7epjPcktyIZd3mOpGVQFlqdl6hWvPYc80reUhkhR/V0tfDY6GdOF3m3jhkBmWUbu+KY4lQM4D2vLqLw8g9r4My9gRVLVddvuCzWkQPEolwjYb9+m38/viqOpOV0cZJl8Nhlerv2psf6S3HA28sypBmuGyYYJg7ZcfSU/Z585rhDd/6cnw2r3OeLTijrpk4loqRaUcF56KueGQwYdI56+dI8LlIcUXDjZa2G7F0e9TO0rvPDQmCfkaS4ebcKeFMqnKH9VTptpPW+JLr1oSe3tlgvI6MRn6eXCzywoSO34SBGEwgx5xiMzY5oG58J7YtJyOd1EXv/wgNMwcR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(6486002)(52116002)(54906003)(66476007)(316002)(6916009)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFMM2NaN0JUZXZRVWFKeHBBcDhWR0hnNStuc25YWUtzUWpTR2VwOXN6dFF3?=
 =?utf-8?B?c293bFE1cGVieEo1MVhLY3hmcVIxMzcwYWVsVkJKRWtWeFdMUjNaTng2V0Fx?=
 =?utf-8?B?Rm80cC9XeHNVY0VPcWc2QWlReXRNaGhLN01UNiszaURMQmFzY1BPSDZNenZl?=
 =?utf-8?B?UEg2NlgxbHNncVhVRWJoaUV1OWtlRElwbnBZV2Q5dVhkSStZcGVNck0zeHBu?=
 =?utf-8?B?N1N6VktwbkR5RzJpVE9BSEw5WWY5THNQVVRPNkg1SitSK1ZSWDUvYmdRZ2ll?=
 =?utf-8?B?cC9hNm8rcHM3cW56N1E1L0VpdEJJbTAwT0NoUE94S3JYa3pwS2kvWGVIaU1p?=
 =?utf-8?B?RlI2SVhyWXNyOWJ1Q3JOUWRkYmhvTy8wbmJYTGVZenZGcUhSbVp5emdJcGdo?=
 =?utf-8?B?NVo2cHhQQmN3Q2N6cmxsSWt6WUQvWEFXdlpmWUxpaENqL3duWnBRSzh5UEhS?=
 =?utf-8?B?YmhJQ2dTeFE2dStPdGJNSTBaMjlPVVVoVEZOOHFWK3Z4UWdCZ3BlTWJyZm12?=
 =?utf-8?B?azAweG1VOGEvT2lXZVFJZ1ZUeDBySFhaa1J4SzB1ZzBUbWJVSlBIR1lmZTla?=
 =?utf-8?B?TjNaQTlocTZRdVdyaEdZK2UyTTRMNFUzYUZOUFU2RU0wTnJXZ2pBRjFMY3Vo?=
 =?utf-8?B?UEwwYSsvV2Zsc2w0NVJBR0NOMllPTXltT3BTemdkUlF5aHRBMzlYZlNBaEk5?=
 =?utf-8?B?b1dGN0FHRVRxNWZlQzB1aUMySkhoUnFNejRXcEhNSkVnbmtmN0E2U0xBQ0ZQ?=
 =?utf-8?B?Y281R1VTNmdabk84VkZLS3FuVit6UHVhbEw3ZFd2bTlLZ0pPOGRUa0RFR2E2?=
 =?utf-8?B?OXNIV0NuWi80ODlpSW9Qc3JIaHo1c3k2ZnBTdzR2UmhmWndqRTJzZzVQb2tR?=
 =?utf-8?B?Z3FyR3lTTWZNNXVjNDRRMG9nZExFb0RyUmYwcTk5QXRId093VmZDeklnd0sw?=
 =?utf-8?B?ZjVYZTVDNGxxVEZTVU4zSGdaZmxwTkdpUnk3bjhZK05IQXhoc3JDUnV5ZDMy?=
 =?utf-8?B?US8vczhGN05FYkx6dlJ1NXNRbk5PUXdRMW1IekZRMkgzSkQ2OGwxVktxVXpK?=
 =?utf-8?B?ZHA1b3FzRUtUNFpmOWFBL3VISlp1VHo5d05TTTBrTGUxTjBBbDdGOGZDOXpC?=
 =?utf-8?B?cEhhdDhsNXNjd0hRYWtRSTkwZU5za0Z2L0RKWDROY1pFL2U5YkNTVDhyR24z?=
 =?utf-8?B?aFVCOURGYXhERkZSd0hHNy85dWV0eFF1TkUvMHBteDBZOC9yWjNVOHlBaC90?=
 =?utf-8?B?N2VqeENPUUZzNTUvMTFzRXZkN0lwcDZXY3M0RjdjM0drVlZyOHkvM1V5VHFJ?=
 =?utf-8?B?NFNyVWF3dXRCU2VEMmREdG4vcXdDRDRqdnZNTllRdjFCVWt3REpERjQza1Jn?=
 =?utf-8?B?ZXJKUUxlcmNyQkZhQ1BJcENjOGp0OE9CNW9Ua2JjSFc3RUJsRTJZb0swRlFn?=
 =?utf-8?B?TE5OWUpjQUFxR1ROVXNzbVpBSmNab2gzK3V3T1VRUE0zbFgrZmM0cklMZlZJ?=
 =?utf-8?B?Y1ZuVUhjdUJ3VndhMXFyb0ZyY3pOc08ySC8yQ29OeTQzN2NySG52Yk1zTStL?=
 =?utf-8?B?ZWZSWEZVeU1uT1JBZmthSkZtaU9Hc210YXlhSWZrVnZjTlR3U3pUdlgrRDVT?=
 =?utf-8?B?Sm5IelBobWJUbGh5S1NLV2d6MHllVGNoaG52VXBZVFI2eWpxK0tCbldXUnZQ?=
 =?utf-8?B?V3IzZTJaSnJZMzRDa3l1cUFnbFR0Z2FsdXFkb3lUNUM5aGwxWk4ydWxlRTFX?=
 =?utf-8?B?cm9ObDRkdWpSS0NHckdXa0d5NHNkd0pNWEV5alEyNk1BZHhocmFzczJ1MGIr?=
 =?utf-8?B?cGhVY05LdWxyVnRtd2ZvTWcxS3p5MnhXSFVEWTBpYmtyTHdtTWVRdzFQaGZp?=
 =?utf-8?B?M1dEZ1dVcVoyQ0Z5YXBMcSswOXZHRzJXRmFpK2x2ZlYzSzN0cHB5MmRxV3I4?=
 =?utf-8?B?QVBINzlrYks5MFdJNUprcUJPTnFqaVdiMjdBNDhnMmNvMkFONld3UDluandS?=
 =?utf-8?B?NXNMUUpFOFpaMmJMK2dkMTRDOS8xM1J2UUg0ZWtsbzVNMWx3djd4aUZWZUdr?=
 =?utf-8?B?UGpPcXdKSTUxOEV4QzFQZmNaR0liNzNsdTd3eDg2SDROVXlzcjkraHRnandC?=
 =?utf-8?Q?djlcOwAoyJ9cusnX0BiLMtGAJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d669155-5e32-4496-70fc-08db8d8d02f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:38.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 651XlgwWR74ma3d+owc5ldBzFPf9etPZI4iC4e0qSDNJ9HwD+RVQoaV68nEZRpCUZEOmG3cTpuIfiRjS/bIaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/rtsx_usb_sdmmc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 2c650cd58693..ded9b6849e35 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
 	struct mmc_host *mmc;
 
 	if (!host)
-		return 0;
+		return;
 
 	mmc = host->mmc;
 	host->host_removal = true;
@@ -1415,8 +1415,6 @@ static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev),
 		": Realtek USB SD/MMC module has been removed\n");
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1455,7 +1453,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_usb_sdmmc_ids);
 
 static struct platform_driver rtsx_usb_sdmmc_driver = {
 	.probe		= rtsx_usb_sdmmc_drv_probe,
-	.remove		= rtsx_usb_sdmmc_drv_remove,
+	.remove_new	= rtsx_usb_sdmmc_drv_remove,
 	.id_table       = rtsx_usb_sdmmc_ids,
 	.driver		= {
 		.name	= "rtsx_usb_sdmmc",
-- 
2.39.0

