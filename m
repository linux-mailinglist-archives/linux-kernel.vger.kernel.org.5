Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19509751AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjGMILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjGMIJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD00358E;
        Thu, 13 Jul 2023 01:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfPAw7FDxJqtTd3EOlYvSvqY2okeKJAXK/eEcRYoOZTCpiaR/VYoKa/0SLkdGO4IHOsroiTXZqBNJ/XlspcGi/X0LTBL3oPKxfvOgnDvw/CXf81O7oaSG3cnUILb9Qm72DbAnXnhHSL8BdGEwYFdIC/MsuG78uGtOSiUSz6f+63fRNWDgkrfuvEh9PbQFf5kGlTXxPbLVWusZVOqHqP3BdIklFlHjL4+9buGHFXEGu5JRp5RhEqzLBAAv1hMaF3/WUVxYm1qS2gNeabbI3/p3BnUI16AAe4gVVNNKyY0OMDxLy1U5BheWyyN/sCIbyqU9NRXjKuLP4zdrPNcBH25yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmsUH21Sitgu80/p1tFfJIH7tg7gkEnk91pBdItWAUc=;
 b=FTEY3w+V8q8FGR3VDgeNTlOi0abdobeyjNL9e/3QEn5Tgspb7wQ6hFdYdqNZj6qGI/3q55gMx2MAOt5u7bUtIrtgvhDstqbW1zCwR5hBpVLUhG3vDGPR+BUyZc1rKCQIkyt75Jl1JQT1PX0ZQ1FJcDjc3TdmR7n2QsCGUMBPSylCjukBZwZMu7kd+89yVzGwhk0Fv2yKo9dUGuoTHNbrRtDWuQq5X7/wwe62sY7O7aWYJzK1VaOlX91JwxiQknu4KCd6x+BUixJWCAH6unHYuCFm4a0BiPJgYw0KY95pjPO6L/0Yiu6zQTXviRLm/poW/Cyo1Cujr9Raaelmz6iWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmsUH21Sitgu80/p1tFfJIH7tg7gkEnk91pBdItWAUc=;
 b=ebJZxWGlQJc2f5xMiqvZu/kKtt8ehVUiHy92uKgOHvuv6hZ9fxyYa0NLPK57eQsd1si1xG0p9k4vAwXZTa2YJezlXvFm1V8Xfq5zkL6/wSdDOSitlEkzYUBbSsEUNNV1QWgrwXOmzGsBif15Ur/eVUfntpYXyhhq/t0Yf0zcgtRgV53EsPJDyAfOg2ti0PDDciB6TqFsksBMoWFHUjOFP7avWmJAfwHGLRQPqd8hnr6m6x+yzq6jvtcbsUPR3TtmFoeQZ110mwrk00NsA4X3JkrXIKghPbUuQgiEBscrUYspWqC5wPbSsE4UAebMcfwg+GGKIbbcNQxpOc2hQ72FLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/58] mmc: omap_hsmmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:20 +0800
Message-Id: <20230713080807.69999-11-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1e2f10-0310-42c5-f347-08db83785cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bh22jU7U956oW3Lxr9ThNSwu7z5J9UjDN98GtJgCY/JztAFx38OoxV4PZEZ/28NM2WUyjNS/vWma+hF32eZK9T8G8xpc6QDau66b4yNLTg6UrZdeTRrawnya0qKvRuZ6nCPSGflepqdunc297Qgncl+++MyCBl0w0/Yd1x7dOuSZp8612UjFMvYUANUwCSGWITsEwHbV0WQpT6Svv4TBEBKbAFgnLjviPom5PuGPtthkEhMmaPT0ELQiUsUSBAcfkUkw8iLTsHATglsZU/0D1CeGqqo6fymj3m2cpyiCyoCH24zerKUk1TajIhIZpCI54C4KS8Mi5JdCotX4/eJ1mgn0CxuE3okBGLinWbFWoqc0H2Lju+0M7FKdvqD1Xm4znbMl4/ZWBL0dl2jfkkzF8PVJ+CQrYBhDBwfqoAKFfSsFROl4P2AZ1ykk5iaffEDfDf4TnqqU+nkGRdWdvaLDk6znl8+1s/4pEMKqAIhQm3iCUX8c0YU9kd/TBSJL72kC/WuQA6HDypUv9lDWQhQxI9JrhKq94UZrzEAwb1OkDRq0jRMRhNvsVTsSjVDHxH9oMPYdjdV8vQ3ncbChPTR9TRECkHy0QZLjEk27YuP3M10CXps+W5MPr7/BGxBm1ylXlYBXiKMuSjAtorsg1NEeZvBJPMCdxu6Oh7J+/rOWf6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(6916009)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1kQld1TVlqbEtncHA5Z1NlYXpQUFk5Zk4rYnpyNm9WVmdtaEw2NDhKUk15?=
 =?utf-8?B?NXVHYURoZUNXOU1VK05HdzI0Q1ltR3o3WGk1dkxDNDFuZlVIVTFuMmxOUnNT?=
 =?utf-8?B?ZFZ3em9CcERFMGppbmJGLzdSY3dIOTBEOGc5SEZVcUxyQlUyL0taaWVRNnFJ?=
 =?utf-8?B?NnBFZ1RiekUxSFkyT3RBWHpvZVA1bXYzSHg4WURGNnN4QnBNd2VwUkNva0J3?=
 =?utf-8?B?Uy80WkF4NkJXdTNRUnBWblV2RXAxWktUK0NJcDRFdmN1ZFFtcFJTcFN0djFr?=
 =?utf-8?B?UmJ5dHZ6aE9HYklEMUU1VnZsdzFDSGNxbTRNZ2xvbUVzZHN1SERNRzNWNm5J?=
 =?utf-8?B?Qmh1QlRmQkVqRTVXbEVKeFJ3Y1c4NXh6NU9NeG1hMFozbitLQjhraGF0eTF6?=
 =?utf-8?B?aklqQTRYRWE4clZpN29NSjNzRFAwUlpnWE9GV2VjS2FCVEpHSmYxRTFZTS90?=
 =?utf-8?B?TkVrR0IxcUtLWSt6TkxlZUtiQjNNb2hENUxabHVYeW5VUjY0WHZpd0hlYlla?=
 =?utf-8?B?TGhRZnNpV2E4R1p0YWpLSjRNTGxwTkpWb0J3MDBYdlg3dXdzcGxBbER2TFQ2?=
 =?utf-8?B?YWlrRDFPK0FycUNoajdRMUI1dTBHaW5lRzlSMWxoVFdJK2xlbmIyT3RzZWww?=
 =?utf-8?B?U2VWTnBzVUdnYjB6Sms4UTJkQTJYbjBrbzlHQkE1MXZSZEErNlJuRjZqM2Vw?=
 =?utf-8?B?b1ZCYjR4WTBCeUMyc251ZmEwRDNicUNNWG9qWTRuaU1USXBIdzNNVFFsWUVN?=
 =?utf-8?B?Wk15S25aQUR5MC9XY0tNOUtiZytBMnFaOXpXNHhNYjJpTzlrUWg1akhZWWZJ?=
 =?utf-8?B?WSt5WGFJWUk0Ykd6SjhWSW9xVFBrWVNOOGlEQ08wYmdKcHRyTmhZczJNWFJO?=
 =?utf-8?B?UlNDUFZMOTV2eVByai9nN1BmL3Nsc0EySU1xcTJaeFhVVzVSK1VTcmVBZGw5?=
 =?utf-8?B?eFcwN2hhUHEzNkVvc2N6TERTeDJGMnNyMVdxYm1XS28xVTVjSWM5N3YrcDQ1?=
 =?utf-8?B?Z2RCT25KdWtXTmtkRXFacjNYTlVPL0VGU2NmeVBpczR2V3h0QzJXNDhUUzlE?=
 =?utf-8?B?VC8rUnpHdTNGVCtWcGhrRU40WXFxZ0lleEVLU3ArMHhiUGNCQlZGK3prZWdP?=
 =?utf-8?B?ZEZYNFF6L2szZXhJYmZRYS9KZ0V2YWZCdEN1VmNvS0kyZkUzb2RyS1dCL3hn?=
 =?utf-8?B?dE83OVN5cmdMSDFaTURrNFZFcDE4MjZOc1pOTGhlSmxESlFPZEh6Qk9RTk1j?=
 =?utf-8?B?YytkSFM4Q1pkdFhZbTNTTWVPMWlUSWxxVGtuVzdHbERCN0NuUHN4Mkl0Vmta?=
 =?utf-8?B?ano3cHRZZTZDQkpWZTQxNnB0dW55eTgwb0F2WVkvbHczVjlBaWt0a0hZcmZH?=
 =?utf-8?B?NjB3RU16anVZOFdUVDVXb2RvbWswS0czWHVIMkd4QU01RUxPV1Q0NjJkN1FD?=
 =?utf-8?B?Z2FibllJYnJZaDdEdUo4Y0EvZVBPeXlJa1N4UjdkVldua0JTM3JnQmFVK2Nw?=
 =?utf-8?B?K2dnWndKOW45MnFtejlEN2xQYXg4YWxQZi8rd3lhOU9vN0FqZTFJOTVkYTBU?=
 =?utf-8?B?M3p6UHJNaXlCc2J6dFNDR0FLeFU0a2JVV1dxcHNkUmppblRGVTd6SldVdnlF?=
 =?utf-8?B?S3YyYkltTUdPVzZQNXRTRldSOC9SL1ZVeUVKY0lFM0M0dEw0MDhvVkFmcVp6?=
 =?utf-8?B?dVpQa3EyU0JINnFMaWQ5bzBOTXpkMjE0UmNJb0xDVzd1MHR5N1hPS3VJT3Ez?=
 =?utf-8?B?RXl0dlRqM3NveU5wRVFVRUIzVWoxY1JINFgwNlFkNFdLbkhLLzg3SmY1TUlr?=
 =?utf-8?B?MzJsNzNLd0dSbmp4S09oKzlhUjQ1aGRhTXNPMG1CMzdGNC9lSXVTM1pNc0JY?=
 =?utf-8?B?blNsY3JreXhFK1AvYmpRdXdTZjIzOWZvWFBYRUZVWmsyVmNUZDB0UmdmQm41?=
 =?utf-8?B?R1J2YWQ0U0FKMEZxSkdQWWw4dUFLRU5xOXpTa3BZQVVoUW93LytKTHBKM1hi?=
 =?utf-8?B?dU9kcUx3Q0VkbmZPS1JJdFNlbm1aNkRUN2p2QXIvM3lwd1l6WFVtY3VNcFJp?=
 =?utf-8?B?eHZXVW9WUjFBYndaTG1ickxseStlRGxGQlJsTnBQb0tXcml6QnVFMVpWeXNC?=
 =?utf-8?Q?Gdagmt8I4J7c8PNO/PYa7IdkF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1e2f10-0310-42c5-f347-08db83785cd5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:38.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1L9GhxRrKx4CHXcQO+2NBzZUrXhj1s6tXrJ/z4ZmXDWRi7LOgyuGtvkPE0TydMma5lRopx45EU7lAQRq7P8sA==
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
 drivers/mmc/host/omap_hsmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1e0f2d7774bd..c5a7bba3549d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1982,7 +1982,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_hsmmc_remove(struct platform_device *pdev)
+static void omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 
@@ -2000,8 +2000,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->dbclk);
 
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2126,7 +2124,7 @@ static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 
 static struct platform_driver omap_hsmmc_driver = {
 	.probe		= omap_hsmmc_probe,
-	.remove		= omap_hsmmc_remove,
+	.remove_new	= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

