Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96245764792
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjG0HDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjG0HCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:02:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABE635BE;
        Thu, 27 Jul 2023 00:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwLZKQjR+6Nv8usu67LsgfOu/8p7Imfm2FODupOMSbQVWcGr7chfaLpjc56mImZcrArb7eTxEASfhoWAtsOyrW2tBkcF/38YbdpbqVZTLMowHeE99d9Q4jRtwbNislhnIs9shslee658qmS0Qd9+jgUH0aMHHA5X5LuRV5K5abeggl/NDRt+mxdB4EO5eOkyRGemGzL43RBYcODVQrun7y41jTSEnHwmRq9l9BsP0PT8nKK+T20A6lxL2aVwYTsLFNxJL/0ELPIvx4bo/+kmzLwAjeHuSp5g513GZWioua39gXeHVqvRTkmx7X3X2z24Fwv3BcRpeNbd/551kN8xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkUpr7l0pDttVGz3kqCsUAr3ho/CgWL/40WVT1faxUc=;
 b=kJyV/MPUN1oRj2J1aW8eWPtnjG6O2punnaEGaa9Ma4ndWaxS7sf79FUWdK4qcdBp78YXzAXmrk+haAUFR/qcdVKewwdFEhXSEFt2ncJ+b9e6URiaynyiegxnIQtfNViSd5JAs1NOXp2FNh/cB51C2U6T+udZK0w5BZmHAD8Ox0wox5MpOdejtG1mpl0ZZAea+/OPo8QZ+pOoJ0vwWJpsAgW0urh3NUlbR7CnWj8nC6cqAiCfltIXqKpqL6HAug/bgw2r4uQFvZG4k/ixR/OQTXJrh/itsSHbXIaLOnj9NQHDM19kcCGS+HkSVR3GDse3zj4fZXwGL6sxiYWIt109zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkUpr7l0pDttVGz3kqCsUAr3ho/CgWL/40WVT1faxUc=;
 b=jhQ6khd9k++xU90d7Vk+JEu88fdUUbVUnZNtyVRYN2iylhy0NFpAdBLdrZswsmkRU0KnCPDWBJp/ZMGCIqqviMgnyGltYBTvbw+nk3Hjqs7IkwsE6yG59jxV7c6YeZXd3gLTVyAlJRhTM1C/HGWGfRtSWBFR7QS4TI2NgwS51xvuSueJ1zvyOdBZo/lw4mS4+Cljj+dtxSDtEJEr/L7CjEf2KeZA3zkLFobCdcAL4hYfaevXQ83F0G2BZCZZUlcUZo76uY8XIZEbHVj+AsSqcpcOMfcVDjLN4XDJi5yJALdZShyok0K4ZQrgjj4zIeoa6bqAb/Q42DIu9tikm32xiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/62] mmc: dw_mmc: exynos: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:03 +0800
Message-Id: <20230727070051.17778-14-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e061deea-7ecb-4a3b-7d04-08db8e6f4b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2v9sJvDmURFaue5Nsb6ti7tDfSOzAugC+0Yxbm17FvXukV2zvIKbHCJQ76LBhM06Jplw9Jc/lR/kG7SWF9CQRwdh9F2H/zW0b2BjiukJ7Y99g3bPVAFy5/vty6wbpH182NSJbdvOeLx9OfI6FYALTDQwL8wk+yaLYsHi4kVt9K4xRH29OkjvfxmBTCp8qo07c46dP/tFW/dhLLLOTUpdDYz9LD5WJlk/KblqnZGHk05USswFBjiMTacVKDhDPdTSlbDB5O6WdjhrOVhREFPIcThcY03Rc+yO/uD4wpZozq3RxBN85mTD9W95YF4N+UgPBeT/HkwY9nJWkUdj24Ueu/Gnk4zKFIDWTE5jaSdG4Zm7uXewh6+8/VRnGuxgRQ/oi9EVJAed7TZwUabHxSBEhAo/L8jOG3abdfHvvEk0t4eogAdYoHK1idLitiUydSs3oAPaQr+9Z7qq2oD6CwRrNAeY6wJl4D/7t09D+Fu06uNovAVqYTN+zxrdwH7IZ+S0I9upWS+mkLfN+nTolMpDU0CtGFNuCsb4jtUHXpO6VA5GCfMHUGJ4kenVmm1BJEkiuQ90b7W3DVu0kAPUQokRtkVfrqs6VMTTw7ovduvNDp85hHua/rkSCBrub6VFL0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(66574015)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clBDWXA1WGxkVXdQYndhVUR4eTUySE9zQW1OOWQyY1RGY0x1SS9BYS90Nmgy?=
 =?utf-8?B?ZjRsZThHWEJHWlorR0cwNHphMUs0RkpLWVNvWW84cXIxOTBjRmFQc2JOcWwv?=
 =?utf-8?B?L3FjWTJ5eXJ0RkJ6QmNNS1g5N1F0aVNxUVlmSnY5QkhNZ2JXcXRMek12V3po?=
 =?utf-8?B?RExZdlEzVkxaNTNUZ3JWTVBnZXhVZkZlSXFYR3FJLzFaa2EvZHZsZGRXQ0t5?=
 =?utf-8?B?ZGtZNWQxemYvRWdoMDN2czNRR2pvaXlRbWNidFRkWTVEblNoc0tTbkZwUHly?=
 =?utf-8?B?TURmeUhIZEk4MW80WjVsa2JLM3RYSXl2K3U4Q1VNcUJkYzl6Y1dqM0tEVHFL?=
 =?utf-8?B?ZXE3ajVaaXNFRlFVUGdwdUxjclNST0xadUR6akFVOGhOYjNpTzZlZ0lsVG5z?=
 =?utf-8?B?cDA1WVFObld4c3FDTzgxWi9YK1F4dmNpMUtuczhZWWhRNlEvUm1FRTd5Q3RS?=
 =?utf-8?B?WEZYRVVQSHRKQXdqL1BDSmJ5bXMzY2xaTzRHd2lRZVVHQUFqcmh4aG9Id1Jl?=
 =?utf-8?B?YWRTakNJTzNVcVZkUk90azBZeUx1eUN5c2k2U0F1UkJpL0s3cDE0Q0Z0ODNC?=
 =?utf-8?B?bnM1VDdxSml6T0lxNk5tU2kzQjVQc0xBcnhDQkhYb3Vld3FDbmRBeWo0Nm1R?=
 =?utf-8?B?YStyR3dOZGpWOHBrVFNKQVBtTEd5amxReWpyQk1sV2ZKRkViS2FadE16TUY5?=
 =?utf-8?B?enNETzhCb2FRSTRkSDNvekJTSVVyMWtvcE9VRCsyenYxV09qOXdnejRYWGRK?=
 =?utf-8?B?Ui9KMUN2dDlSa3A3bnJydkRHTEFHWGFUNmVOYStCWVUveDRSbG9MM1lHeHh1?=
 =?utf-8?B?SE1xMlFPWlA2bm9xV081WW9naFk5L2h5TW53MXl0UEJkZHRidEpoKzRJVUh2?=
 =?utf-8?B?UzRGQTNSRFNtYXhia0dIZTFob2FyU04rSGt6ZGI0Sll2M0MybjBwYWxYY1FR?=
 =?utf-8?B?ZXlVR2I1VUFUTTFmeTFSY09YVjVpN2QyeG9Rd2RWbU1Na01iTmFUUVE0dWVF?=
 =?utf-8?B?cEtqWGVwSHMwWkNpTnYxeStJeElWTHNYNGlyK3lzYmdkd01yMm9kQUtxd2VG?=
 =?utf-8?B?YjRWNXpRNllna3VOeDZrM1FJaDlrcmlscEdyeUxSWUZvd3VML09UcDIyZEtt?=
 =?utf-8?B?K2lCbHlOTUphVGgvbHFjTTB5SGhycWhOM2hnZ0p3MXlLYkQyYlNTSkpqUyt3?=
 =?utf-8?B?S1g4amxHaXBYT05uMFBJSmpEaERlWGM0NW1BdDVQTThhQXBhRW4rM3F6N1V5?=
 =?utf-8?B?MWFqSG1zeVd4RENuZFNRTUVLNWlnZlliRTk3cGp6ZGlyd2x3aktEQUpLd0Nh?=
 =?utf-8?B?eTdyQnVQUTRLWVd4OEVia0VFV2huZC95VXVsV3pYR2loQXRSU0k4MkIweUxF?=
 =?utf-8?B?SjNVQkhHZUF1bkg5YldzZERETkZkb2txbGdHdXZFcjBsM3FJWmxuako0UlZp?=
 =?utf-8?B?MFc4SHl2WlZoSmF6eEZScTQ0SVg1V1EzNXRhaFZVb0VnMkN5NklHa0FTaFdR?=
 =?utf-8?B?Zkl0UFdqUmtXZlpUYUFDRko1WndaeWJpM0RNSWdUYWY4QmdYRk9ZSzJFbVRZ?=
 =?utf-8?B?aHlVcms0dW9nRGRhUFgxcUJZbENyNmVkMWZla3NOdG9YT2pEaHl0bTY5RXc0?=
 =?utf-8?B?UlUxZWo0YmQxV1BlMlZieUcra1p0OVJXME8vR3JORzBKdGZsRVZhZ3hMTjNw?=
 =?utf-8?B?VmRtYkk4eUtzZHl1N1c0TFc1ckV6cUQvRUpPQ1BUNWxJc2ZzVDFITzhDNFFh?=
 =?utf-8?B?enNEOU43bDJLYmNuUTBBVFlxZDdDTUx5VmprcjZhb3Exd29pbUNqQXpuZVg2?=
 =?utf-8?B?eWgxMG52ZjlRNTVRRSs4UDM4ZWJLc3FQeTBIem1FTzBLYlRvbGpVbmV4ckFk?=
 =?utf-8?B?Q2dGbjEyby94Qk1raUlhTmNlYTlFVExkdGd0QnhlanBtMGpuYytyclBHeGUv?=
 =?utf-8?B?Um5aR2VwcGtESHc4a3F3azdiYTFFYzEvZGVmRGlIWk1BY2wrRVp6TDJ6ZUdt?=
 =?utf-8?B?TnJSZHVRckZMZGpzdmdHR1JQek1OQ1gvYnZqcDIyUjVCRXNJSm9QWkpyd3l0?=
 =?utf-8?B?T3NycVBkSXFvQUdSd3k4MFdJVmFwMW5sQjV5bTlkNDY1RkdPWDBmR3NTMWFq?=
 =?utf-8?Q?KgodFKJx+4eBRSXaf0NtZ5XtI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e061deea-7ecb-4a3b-7d04-08db8e6f4b29
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:25.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NePyVc5xAxRTJ+tcQF0leY1lWNvcCLZU9Ad3Ckk1gBLGQ6wwkgb9udYr4uZkRtEvo7p74vlTy7VBleDKx05RQ==
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
 drivers/mmc/host/dw_mmc-exynos.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 9f20ac524c8b..698408e8bad0 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -664,15 +664,13 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dw_mci_exynos_remove(struct platform_device *pdev)
+static void dw_mci_exynos_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
 	dw_mci_pltfm_remove(pdev);
-
-	return 0;
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {
@@ -685,7 +683,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops = {
 
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.probe		= dw_mci_exynos_probe,
-	.remove		= dw_mci_exynos_remove,
+	.remove_new	= dw_mci_exynos_remove,
 	.driver		= {
 		.name		= "dwmmc_exynos",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

