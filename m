Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6217647B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjG0HGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjG0HFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:05:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::700])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A093ABD;
        Thu, 27 Jul 2023 00:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF1y6zdQxyWutIiU3x+EildjwOF4AeBz+YPS7G9hNB8ni9Mv3yMXNECO3B5Y5SEL6QqRX81Rw+BYqb4tZkDsBWLugmJoWVq/XoYaDCr6MrvsfMkZd8gmWFAF/2Rp3I5zAimnwxLgKlkpLSZ1Z4a+a2yJ4SnSIVY14c6c6tQPAGM4Vp2UTZANb0duF6qY6qS1hdHnUU3zy2JGeHblXN75hiOqJw1RcDlFnre/027j+tNbqsIVCYsbPiyjYlDBn3kGBDtWPsjDCG89499P0PFHelPu6NRWk045moWQ7UGV/rICTH6mfJTWbytBn870GNdNk9wLgn7dm2MN/aYZw0TXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky6VZARD/+JhPhEudXHQb/Xqz7DgERGqgfv+ZV13owc=;
 b=jURD9EmBdSOX67XQCqiI52jxulKiuIkKVG+igE2OfT9VlXiG+agbXR+QOVvjORqUbam9ivTc0JlqKbj9IR1mGABtlo5fetw663rPjX1lSwybwJIG/I3sV+T34b54NreHvjgzuDaJ+vFoHvmWIQ/L2N1Kd1tG7fMAG4RgajnYuSm5AYv6gM9WU6mG0sefKZFcOMy0W/gxrslPo7U5twPzTg7odDXvHktxqMDsolBvGFh+SpJAapXtrV/ndLVPFGTkFdPlUULqiaJifGZ4bN3ftwPXDwUS9RTGfbtNVn3/W4eSzIVs591OpsaXKGBN0K9PBw+NEFnLaacNRD0viaizvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky6VZARD/+JhPhEudXHQb/Xqz7DgERGqgfv+ZV13owc=;
 b=N5lBB5hCooH5YyLMTlmX3XrlKIOmRRi9yPoIeCmzwlm6R/JnTTWFQwlq2Yn7NpKVmm8J9nIdU1FJnejKQGjJN1SkM9N5Bja4Tp6LVFbCe1JneawVB+vRbHtFoF/D3p1cnDBW6kuwaWBqWFuTExH37C8/Zhc0l/tG1KsbwDDYeQjlMwEduhD6M+mIwjBh28hZiJLsXWocvfe9MWLDtr8vPfb53+4cE8p3p7DaDTEFE5rQySZJDYFA1X8tl+GSVlDGdf4kdBcSO9F09AbIr0t/qEg4ICuk7hSqL38jcpxJDEAScoaMcMy5ur01pQ6vdlkfniJiqE7Vdk7W83+FPYn4BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 33/62] mmc: sdhci-of-aspeed: Convert to platform remove
Date:   Thu, 27 Jul 2023 15:00:22 +0800
Message-Id: <20230727070051.17778-33-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a24d2538-caee-4288-e14b-08db8e6f5df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEldcW3C4DL4Ne1aYPGoF6kK/pcTDSQqE4JOFGTmpVt13r679qt4OjiWicWYIqUzvJq8JKBOtdmT0r20+wCVLj9VRjdibK8UaEmRRqeYwkCd+6XA6iFTfaDuRhncLa7fEkXUV71mxshcnpgQqq0ymMSjrYTchgKd/E9oviQJDTcaded6D8EosLsCUI/k29OsIPF8cqCebE++pt0Qv6ypCIy+gEL5/1oBqNtu32G1BIwyQGwD1gKi+phr6550h2I6Lh4WsYSkvRSuhuHRtf8KGkSHrnk6dQzyM1koNQA8qrhh3s+2S3Kr69jyDJeZBAiSerGOOVCd+V8R0lEeCc9EMUHKef3bliYIgeftBFLQ15K5PFBpuVfseUxvvSEzcNMxnv14kOFWeM6k61WlF+ZwJ3g+r+zXsyAMuiaGfI4c8Sxa7OWA5vZYrTRwY7DFugVwCH2saI0/vogF+9CXXrb7/P7DiNIt2khGhwOKqLz4BfR8BhUf2NzBZWVwQDmn3qIDn9qP0Zx3C6evX9GaxE/h5FxZY05GEeN3MbTHzpM3E9OIqIlDtjGIIzSHVHip2NrouEaMHiYeJqA95ibQHQWqggKDrpjNU/4V7eSIvRJ+Hcz+SYNZcKgUXr7cvJiH4PxV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(7416002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEE1TDVoV04zV3kyS3Q2ZGxHdGw3Mlh2SHZXajNIcll4eU9QQWtnbWlPNnph?=
 =?utf-8?B?SnNCUXE2R2xESmt4VTVGSkYwRVM1bE15VXFzSGIwY0xDRS91R29QczEwclVk?=
 =?utf-8?B?bmJYM1oyRC95YW5RSE9paSszMVVvRWlZZnErbzQ3ZlBnYmlLS2NJSjhHUmxG?=
 =?utf-8?B?NnFBN1NIQVpYS3o4VkdxVDNPeDhuOTdHSmdrQUxnUWlmaVp4blZXVlA2bjVZ?=
 =?utf-8?B?N2x2TTVEUGF1eUVPOG1QZ3M5ZkVJa210VGRCRVA0K3ZVcmNpRGUzYWhTY3hC?=
 =?utf-8?B?dE41L0FWeVN4azBRUkUzQzE1b3FjWnZqYUVJQlhINW1UWmdaQndJY3lIaGxi?=
 =?utf-8?B?UDZIWEg2SmtxZnB1RkhWcU9ENWZWVEhtSC9na3owbVFjU05EOWFYRzBDZWhQ?=
 =?utf-8?B?THg5Q0EzakRSSlg3Y2JPdndmWmpZRWZON0tjRHVmanBlNDM1MVo0WmIrVWh0?=
 =?utf-8?B?R1VYekNDbkNqWHN5OVNJRHZjZmNVK2d5TTBFWUFuamFybUFiRVIxZXRGM1dI?=
 =?utf-8?B?bmxSZXorSU8vQkRPZzJtS05nVjJlVmpyc0NnNVNxMllHVnR3RmlueFJDdkxn?=
 =?utf-8?B?Nm54YWU2N2xqbkFuUnJpYjlEa2FFV3lvcU85OUJMaUV6VC9ST2IzbVJQeDVw?=
 =?utf-8?B?VnFXdmNHN295RUNtY0NnL21OdWhQU2txa2tFbGFHbTJUZXFBQVNFaEt6Zzdr?=
 =?utf-8?B?eDFSUmZ2S2tIWTVQNlpJbHArNERGSHA3Rkx4TXN2eUxsakZ4OGtkYTNiUzdH?=
 =?utf-8?B?Q2djSWNQeitTR1d0YS9DSHFLbDIxSkk1Uld3V0RSS0V2TkhRc2VYdTQ3ZXM0?=
 =?utf-8?B?cG5kai9aVmJpcSt5S09QK09nOFhHWUtONjFsc1lReVBOcHVmTUZQdTVob25J?=
 =?utf-8?B?Wmp1b0U5RytkUEFjZnZjaUJHaFlEWGs4K3kxSzNVSjJrR3plc3crL2s3OEhK?=
 =?utf-8?B?NTNWdXZRR3o5WWtRY2xQWG1KaGphVXlZNmpiNEhjd3crLzNITmtzVVI2NGFm?=
 =?utf-8?B?TExKWlJrS3RJejN5eVNNNHFpNjJuNFRVNDFQRFZiQ3NVbWVxRmR6K21uY0Nv?=
 =?utf-8?B?dnI1QW83cFFPeHhnYnpoRyt0UU0zZW1YSGV4VVR4QklPUEZKQkQyRmxkd3o4?=
 =?utf-8?B?UFp0S0R4NkRtTzQzSUNUQTdMVjd2U2F6d1JxYWZoZEE4REhJc2VkZy80M2pG?=
 =?utf-8?B?azYxSGczQzcrSmNvY3lteWUvT0QxV0c0MEZVcEg1bjhObXNnTWcwcTFmVnZY?=
 =?utf-8?B?ZFM4U1Bvenlac3hjVTdCU2cza3VpYUxEakkrUUFicXdDQStHYThocDBCYXJz?=
 =?utf-8?B?TGxKVkRBLy9IekJkTHJzSTN0OU9qRGJKWWlwK1lHL2JVT2poeWtKci93WVBC?=
 =?utf-8?B?WnVlV1poNGJlakttZ0h3N0hjNWcyZFdORTkwbkVlTWdVdlBMcDhpSkJLRXE5?=
 =?utf-8?B?WXlrY3BxU01BL3ZyV0h1UFBDeTQ1TzJlTEgzVmw0ZG56L0V1MVVqWnYrOVcy?=
 =?utf-8?B?TmxXQkNSRitTWkhOeUkvNTlwck9lL1FpMlI2emdVTjlFSXlkZ09pSEkySVlR?=
 =?utf-8?B?UmtmVkJxUkViNEhoK1pxcDZsOU5EZjRyUjM3ejJpcEdBZW5pUzFCNDNkM2x3?=
 =?utf-8?B?bTVwdTJxdTBhT1B1WjRHdzNwcnBIS3FkS2tRZURFTHJJZ3MvTHo4Z2NWT0xn?=
 =?utf-8?B?bTc4bjF2emxBQkozQUhYSzE2UnhzYnpFSi9pbnFjT2NLM2c1TXJSY1FsTTRM?=
 =?utf-8?B?aEJ0Z0JvZ1NOaWl6eFYxSWNXMjZLN0hmZEVuTWVSZWRtcmZscHd6MEFaKytH?=
 =?utf-8?B?L2pXM01TMThITTlmeDlMd2psTTk2MFVkYzFYdTJWbngvQTBGMVdNb3pneUpB?=
 =?utf-8?B?R0tqS0MwcGh1dnJ4Y3pRRGw2YzNJZXhoaUtqQ0lrOFZMcTFqOHkwWnpDY3Ba?=
 =?utf-8?B?LzZrWmRLRkZwZDJjMDNBRGRwR1luUzNUZ05od215Q0pZZHkxODRMcHF5WjM0?=
 =?utf-8?B?M2NFNW9MSTUzTUtPTHVkM1dMOVZMRG9YNTVxN0ZnRlZ1YjFJSW5pMTFFUWhM?=
 =?utf-8?B?SVVzWkFpZmNrcGc3Vmx1U2VneWMyaXNKdWwyeHV5MldGeXJ0aVd4V0JPa2tk?=
 =?utf-8?Q?nlHJhbNXQ59YSozILcxH1pxa8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24d2538-caee-4288-e14b-08db8e6f5df3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:57.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQrPUbk+4XE1Esq4cjs3HG4fCUhRQe1m+ffc55Vfhw2oGgf4ImVhDcHCESo1s+sAqbMQszaCEJ7OVJAr75dG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index b4867bb4a564..42d54532cabe 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -450,7 +450,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int aspeed_sdhci_remove(struct platform_device *pdev)
+static void aspeed_sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
@@ -463,8 +463,6 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
@@ -520,7 +518,7 @@ static struct platform_driver aspeed_sdhci_driver = {
 		.of_match_table = aspeed_sdhci_of_match,
 	},
 	.probe		= aspeed_sdhci_probe,
-	.remove		= aspeed_sdhci_remove,
+	.remove_new	= aspeed_sdhci_remove,
 };
 
 static int aspeed_sdc_probe(struct platform_device *pdev)
@@ -573,13 +571,11 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int aspeed_sdc_remove(struct platform_device *pdev)
+static void aspeed_sdc_remove(struct platform_device *pdev)
 {
 	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
 
 	clk_disable_unprepare(sdc->clk);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_sdc_of_match[] = {
@@ -599,7 +595,7 @@ static struct platform_driver aspeed_sdc_driver = {
 		.of_match_table = aspeed_sdc_of_match,
 	},
 	.probe		= aspeed_sdc_probe,
-	.remove		= aspeed_sdc_remove,
+	.remove_new	= aspeed_sdc_remove,
 };
 
 #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
-- 
2.39.0

