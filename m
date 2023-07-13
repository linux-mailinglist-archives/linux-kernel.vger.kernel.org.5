Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4EE751AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjGMIKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjGMIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C392736;
        Thu, 13 Jul 2023 01:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZv7+kMjtN201aXRChf2u5May7uxLbzY+v/dJa03El7lGMpe+juujvGSxsr7D4mFBoWbyuGPVQhOqByMLFpjXUKyOWJHqMQkisxd/aaR0F7LY7qleTDQgipy2S2XZF5QiiCZ+V0TwZZy+B7Cw8Z22huIx97MIub6Ne+UYiuMOQ1tQHZs+T2qFFMd0fru+6RsQZ0wX5i/UUmSpde8xirJtOsIRvZ7bLWH2GWWPqTlYyjrv4fnwgpqnARNeZyFV7O675h5eEMWoEURYLm+IuSou8FZz+tGjFe1YqA7P+jOJZC6E6VhGdSr09gWu6cJ5ApwvF3na7zuKveD1mCZXXlUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x0hkJ7rBcNQc6MBaHii9c4fVow/2SAqZ/ObTvOr/Ks=;
 b=JuOUJzM98B63erEgVTmqpkt+alJYrgRJ4lr3I7+nkgR+hGuleB7ZW2HEoE+1wDMiOTdltCfBGeARpBIaGJXeFYRoDjvuq8B9oBEx9/gE9f1YIKQjZG+gcCqh4ZnSkKsfZqn+rKbaOL26adeI6JwTD0YOh2Qb0brwUpOTFMuTvS+e28zzJivzJe0Qj6QnDAy03ppT30OGC63/HxkpgzYNKObwP6JLcyd+1IcJ7aZazqoDvLyIzbulvg30nWlhIGCVrS3N7vqPwjICaiGjwrFyCRWmztuaKBngvmjA3+S/ca+yUAPvDttaChtgJS9/oy+cFLoss8jElWVySrTK5WDvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x0hkJ7rBcNQc6MBaHii9c4fVow/2SAqZ/ObTvOr/Ks=;
 b=W19GC5vf6MitdKMn0/oQ2UAeyHy8NHvlE4HHcP3b5KYUHUKIrt9sPx0j20gPTqM9knzX2ddonO6Z3ZW9oA90BdFQbzls40jQswWjPgb/2gdc8+OiS4Ap/oywHkG6xfSKV/ZVg+OJQ0hPJJTmTGlumanowQ1hLBbhQAZHTj9xuj3GVSI3r+k2esXEs498AP7Stnf4ej41y7NpK0V52Zi38Q6arjgLglrhvXygx0EBL1Q6uVwtR2tpFZBx9Hb84f0uxYXGYU4rMBZ4PCun7lBosdFQUsK6K8JNXsXSUeGauzjdyx6AaEUV27tbB4dEh3kPQETCL8htykoKL7xdzl+BHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/58] mmc: sunxi: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:10 +0800
Message-Id: <20230713080807.69999-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: db512120-bfe8-4c39-1183-08db83785293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UKwO+dP6G2m8w5g3hTGmJPt/aV3i33bHH0XyWvUwk4zTTNA7eOcf3V8XJYlRhFWWXyVgcxyYsiSmE9lwmCA2l3zgCUx2eTOdIk0sNpsiwDsMGOtNYDyCifcTieZuKxVcqrGxo6gv0lp8lwifw5yp/c71md8lw682CJg/7Xolvh6q19VySjmEv3Xt6nIFo0oaTYqB0fk+npsmdo40XKViB5E7l461rRUJXt91EFBUgEywCtIDiT8X4Nt7srUue0SxdrIkLUQirui+AeHEMol5xg8a1aJC22kYNbSpLBsKM9GfY9Af01mNdLDhB5EAcIYhpw8Mzmz4Vcv+499IIn/flipxNMPbkzGqorCNDq7hzENDCvj4tYVnUJZVZlpkfKyxeEXIugx20bh/9arc5Gkvc9hlyq6bQ2ueT+BVOPjnGw0GpXjP18jv5z7lDvr3f6IcFrfF7EOxvxmH+gLlWWHBYhabDsrxL0l8jUl3fyraszRm0mTvKOyjkbAw/HYl1u82KyqIju70iyg11/NQ1lXimdru1JwwiEAe+knPJSH6hiKy0AWbUQcfLcxfmhHmnPVnWUlg+xZ/DTuIQPJhUxkkshmggZ7H0Rc3emOonUrBsmoZOyFN6pYX6tAx532uyccGVz5rOsz6QXI+lrcxAfmLHrbqIIyYJy6hoPL2sVkwis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTkrMnQyQW5RUG42eHlPdkVLK2EzRmxxS0tMTE9CLzZRQnFTblcvSEpRZEx5?=
 =?utf-8?B?MGFTUXZrUG15TzZxV0xqQjNDV1lqSm1YRWpKWXE1THJqRlhwT1V4cVBMdkpP?=
 =?utf-8?B?clBFNVFweUR4anQxZlJYbThWUEVBYzFYOVJHajlBZmRDUGFlNURpakN1MDFK?=
 =?utf-8?B?NlJ6L0lsbGtWV0hPaDdMTStJdVg2YXNsRnh0K0xmZWd6dTZ2TDVDWDhyUHRN?=
 =?utf-8?B?NnRHY1ExbmRpMzU0MWhYNzlCZEJyY1VQR1VKVVZVbGxiQzBZYkpmdzFLS095?=
 =?utf-8?B?V094MW9ITXdTNjI3OERYN0ZFTE81cENqTnlJaGRRQWpTKys4RFJhZzdWVEt1?=
 =?utf-8?B?U3RzVmY5d3VGZ3hya3RMT3RYNnRvcVcrdTFrRi93OGZoRTBlYkhNbHpvV2ta?=
 =?utf-8?B?Tm5yaGlHSCtrRm5HZkFEZC8wc0JxWGIwODd5QWRGcGIrR3lzUzYyRW9MRmZE?=
 =?utf-8?B?SnBtV1d4TTloL2VLMnNHcWMyZ3VwVSs5OFVwaFRRUDY3cnNNYkFWMWE2Q0ho?=
 =?utf-8?B?ajRMTzRIM2pRenIyUld1ejBNZDhSd01VRzRGSW95aTNQbHNrRDN6TG03YUti?=
 =?utf-8?B?bHhUYndvbVF2c2lvRW1JQlAwUDRLd1U4Q05LZkkxUHBZUndNZW9pMmsvNXQv?=
 =?utf-8?B?UG9VUWZsVmpHem9QcXA0ZnJrcDBObXdpNzl2L2loNGtNUmlhcHhtZC9ZSHFN?=
 =?utf-8?B?cSs1dGpCajhIUHArZi92ditaOXgvQjMxVjh3TGlkTkQxcUhucDlKc2lVRCtm?=
 =?utf-8?B?Q2s0aUdCK0xwZElBR29vMWRyRTltV01QL3Q4dFd0MXNYeEVpQ1JIZ1ZmSXhv?=
 =?utf-8?B?RXVCUGVjTmpSdmFaRC9kT0ltUnI1REZuVXZLV0RmbzF0bEM1TGI3ZzU0NEVF?=
 =?utf-8?B?aFpzd3F3Y25tUmhsc2p1bzVLU0tHbjFUbTZXeXhrSG1jRXordFFQMUJmZXVF?=
 =?utf-8?B?Rm51WXdFYVR6TFdlOWFVSWJlRFJrczNEQm5qNEQ3Y2l3dHMyekJyRkF0SnRi?=
 =?utf-8?B?d1hBN01zSStjdDZ4d1BKOXlrWDdVcGlsQnE5cG1rTWVIUEVaTEkwSDRaRlJn?=
 =?utf-8?B?OUdIQWx2bzhWQjgwZ0hqdWFHMnZIb0tpMlVCUFBrWmtBeWZ1VlF2WlJFS1o5?=
 =?utf-8?B?YUhpQ2w0VDl3Vk8xYUROZ0Jib25mNkF3c2U0MzQ0OEtUS20zSXdBb2N6Vytu?=
 =?utf-8?B?S0x3UVNLdUpBa3JQcFFlYVFkdWlNbWV3bEJqbjFvT05LYmRoQldJSmpLaGxl?=
 =?utf-8?B?TU5rbkVSb0owakRCdXlyRzdGdElXd2VSSXlnaEU4S0xqbE9vc05Nc0I2TFBI?=
 =?utf-8?B?bGI2M2NydjQvazN0Nkg3cGhGZkQyKzl5ODEvYXUzS3FXRnhZWURFYjB5OUE1?=
 =?utf-8?B?ZXhyWnUxMFdtVVVqSzlZWHJLWVVhVDVXT3Fma1Arbi9GZW9NdGhXbXMxTnF2?=
 =?utf-8?B?VThXbGRqbklKWmxrZWd3M0I3bjZkNVJjY0NoanlMNitrK2Rya3cvcStoS0Fi?=
 =?utf-8?B?TVlTV0pyR2ZmUmNQZCttd3J5V0UxY0FDRktKOEFhRGFER1VPOGJiZmhQTVpq?=
 =?utf-8?B?Q0ZnbklqZWVueVJReUxjZDFTQzV2ZTBoZ3crTXlTem8xTGRES1dnSXZIMk9N?=
 =?utf-8?B?U1JXNHd5c09ldExjdm9IQmhWQngzaXRNWDdaUjJtMmZNNmhzay82cEVqRjdl?=
 =?utf-8?B?QWVDblhHbUtEeGxocFh3S0dRMXo0T0swb1Y3MUhON2FNMEhUS1FRK2NEeSty?=
 =?utf-8?B?N0tMZUdLSTJPOXhjb0RWQ09NYWo1TVREMno3bmhSYy9rU1A5VHhVWmdTakdK?=
 =?utf-8?B?MlFHWHREc09FUk1VRGx6NEZSYXFMMkxuUkhDbTJFd1FPWEpUNEdKY2Y3dGZw?=
 =?utf-8?B?Q2pNOWZRMGQyV0p0Q3UzTUhHZVZXZE1wSTAzSk03UXpBdW9tdnZPYWVHeVIx?=
 =?utf-8?B?b2VsWEh5TlEwRHVDaXB1N3dtV1dqRkRVcFl0Q0ZlNHljYTY2NkdwdWFYQ0Iw?=
 =?utf-8?B?OEd3THNlR2E4VllvVG9vQm5VT2RyNzJPOEZlcWtaQVBodFJkdHl4RTQyZEx0?=
 =?utf-8?B?R1Q0cWhWRnM2UVpSZ1NWTWE1aHpOTElDVFBnUDUyaEZhNXBkK0ZQZlF2MU9t?=
 =?utf-8?Q?gYQgnUcf3X492aY9/53Jn5FZZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db512120-bfe8-4c39-1183-08db83785293
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:20.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mBtp1KRGiq1i2IlJzhT2uRt3+oEoXmS4z1okyAKNWGwtXeQIqOqX7n4j8aZeQmfJy5t3OOFE3Vf+eAtZMNIpg==
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
 drivers/mmc/host/sunxi-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 69dcb8805e05..d3bd0ac99ec4 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1486,7 +1486,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sunxi_mmc_remove(struct platform_device *pdev)
+static void sunxi_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host	*mmc = platform_get_drvdata(pdev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -1499,8 +1499,6 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	}
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1556,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver = {
 		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
-	.remove		= sunxi_mmc_remove,
+	.remove_new	= sunxi_mmc_remove,
 };
 module_platform_driver(sunxi_mmc_driver);
 
-- 
2.39.0

