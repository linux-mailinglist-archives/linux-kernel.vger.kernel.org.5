Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B17629E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjGZEG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjGZEGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:06:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C53D3584;
        Tue, 25 Jul 2023 21:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRcr6GvyI6r+N4RtqYBgSteXfAGzVARxUlOMDpoYzNe+xPI7rSX3bBTE6I+s3NJYZEUctAbCSdbaFIMtvTgn+FWO9flTFwJlOh0aWixO4dYKeBMAN435bmzYhJRimVnqNoyRJfywoNO4cq2oqjmzyoFU9WAeAg0pZFUY95Kd4PvzAQh7GfIJE3BUBU6sHCjLnrhuJKcr22h/NBjdKI0k865XrfumTy4XAubMnLQEhxRC7QeYSj1wp1ttx+FN36vbIhfGxU4IKyU7pJRlrMd+4z5zmdKPKOs4vueKzGRf/jd0FMtxv8BGIX02uw06dePe9oLKUgffuhrcluqqnLjl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL+uaG/CbNsLa0Cs8xtMQR2BILGVMnWVziKyhMdPUBs=;
 b=XtfsNo9T6JbDoFwlNS2oDSYVSjtLjpWlQcWJP1uypSssT3IXmToaT3MrVt60+1NHZ9xwlnU7NgKHpaM2U+DNdNBLlJi3lEMLAa3XUG7o5f6tEjYoTp/V02uNHTmGy+Aow6rqUmqIcsJI+qJ6rgGCUVUOKpOReNCZC+f1mew/K+2bE/oP5APx71Y2J59CVTQtlwOkyRraNKv2Ss6tI+7+S961wbd/HstFYH64HzF1CQQwTFHZgDT8/zk0Hucwujz8WDGGiwI2qJi/BIJPVUBG0ITmIGPfD0Oeds05up/Ep3QoQOwlUsls/fR5xWFCgVO5RF1tFcZQGGpA3mvNjpd+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL+uaG/CbNsLa0Cs8xtMQR2BILGVMnWVziKyhMdPUBs=;
 b=eRk9lzqK/c4TbgffYiPVQ3xAMjZLkFoq3nlQ0LelWSdxzJWXvMMsvVN7R9oFjYYAj4QS7xv43bo1DhzWTZ38pvtdgSKvWEQnIvFGS2TeZzt/dSEAiNWTXc6LRMIPfbNBDP2yNsHVLhfeM/Pe8XZ2UdQ6QEuhsAtGhFgfg5nXoxamxnUISyZ+7NkqpGTzEnKaEgcaB86PuFOBYO4kh3kP1nkJW/8kkaBrAX3BNKD6JddOIcLMk7ug8aXrUjytVBdmJ1WsWH7Uvyy3HgPlJs66kBYZ6AdSfU7EIKj2MundfSa7GhRzdDtGKiMMpPcIwpSEob//I1WBjctHKC7Hb4SYbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/61] mmc: sdhci-of-aspeed: Convert to platform remove
Date:   Wed, 26 Jul 2023 12:00:14 +0800
Message-Id: <20230726040041.26267-34-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 9543a5d9-0198-40b5-68eb-08db8d8d0e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8nFtWWDBxNme8NahD5mEtI8z/qWLXeyf5s5aIihpay1XlVsVhWi7LSVpHDSdaHrnJ7kT7Yk2xPz7cqANqBy/yhUaBTt1wAZS8H/M3Cild0aBWZDaVmLYxu/Ke16tRsNYbwm46CzSObAxAvQChVAiYUv72mw7TjZMzO/Y4g8MwNctTvZ+IpGBus9yB3njUv8AN1qMlb2Wg48OxJnowL8x6iaTU6Z5F9c9f7+pgK6ciSwYWVTqbZi+21nm7Ft1qJSvGB4/FZ1cuPTNGLuL/hnRUsxE8vnPih2cU5pjFF6iBzEKLg31yZPsSvx+Cywt72xLHG1bUcAnOmvCCdxAQ5X8GlGJTKNxWO+XUy/B8LVlg2IJlrBZU8CLVK1I708ZSX7UlDLJ5yPDqUc6eXz+WHT//kkYaHvEAeyxZIa8FcG4FXnZCiPMiDh/QVczqyOah9C3Unk4LeBZdpA1UUQPkkpVvL2LV1HWNa+dr7s6oA+LsILTBjKo/wlOCgp9UXZ6XUsLKnrgV9k/bLRG0Pyo/90vyTARJAV6ykEuxV0uqQ14axsKOEBykXpiypxN45HJXPXMDLoj5XQkYdAlAOqmzBonkxuJS4S90YoTegxrJo4YKgOex9N/Ej7PeEAXaLC4dlS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVYxSjB0RkY4MUIxbnRCdk1FTTdENkt0WlErTDhTZndKZUREbDV3RW9iRnFI?=
 =?utf-8?B?eG5LbTZmQkRZck9LYkhIaVZDRnFFNU9tTmloaFZwWkNuTklQc2Vna2I5QzFx?=
 =?utf-8?B?L25PMjZNYVpHaHFyNHVGWXhjS01IU2FaVnZqS2VCb2Z6aWJzTndGd1NZb0V0?=
 =?utf-8?B?OGY5M2FVakkxcTlFWkVmTGJXZWt0Q212T3pQWk5kR2tQOGhlZlBTc0NUYmQy?=
 =?utf-8?B?bHRYdU5EOXhJN1VRYmVMZW1IN1hvWkFUUVVzeDBPVUZtd3BHa3dVZWlaUllZ?=
 =?utf-8?B?MGViWDJPbGlUeThRaHhYZHhKTXZDRm5Qa0YxYjR5bm9XazBPemZpeXdJdUF2?=
 =?utf-8?B?QmNZS1pNTTFtQVhiUG83amhtL1VjVWNOV1paWW1ZaHNCRVhJcTNRN0RFNFBO?=
 =?utf-8?B?TUlFVlVrTmpnK285MTFacS8zazBJbXRlNGtzektGMndKQmRWVHp1SmFyakgy?=
 =?utf-8?B?ZVQyK3VaNjRhMWtMZ0xPOFZ5WTlUN1hHUTV4TS8vcjJlWlJ6OHB4VmR5NWdO?=
 =?utf-8?B?QzhMbWlSMlhlV3E2Vk1QdTJJUHBGQU15RENHa1FtUGVqR3ZPSS85b1EyNnZR?=
 =?utf-8?B?bzFkaEh3c3hHNFFtWGRveWNLZXJndlIwRjA2aEVzVDMzRGRoZmpwY2dDUzdq?=
 =?utf-8?B?Wmg0U0IxYXpIVjRSak41YURuKyt5anBwTUp1UkV5enFmc1NkRXN0WU54RkNN?=
 =?utf-8?B?TlVFVzhHL2R4bDl2YkMxVGtoNnhpTm5qaHpBMFZrVjFuOGZEaGtoc3pyYm1w?=
 =?utf-8?B?R2o1SVY1NFRDMndLL3hIVllqZmYvMGFldUlRTDlaNm5VMjErN2hubXlLRjhO?=
 =?utf-8?B?dTFXQkEzbVI5WW9FZkErWXBqOHlWaDA0T3pzUlVFNVJrdDdVa0pvVy9xL1ZS?=
 =?utf-8?B?ZnFvRzh5TGxHZmFwU25yMDV6M1RWelRDM2tqeUhZQUgwMWxvRTBhN2xVM2h4?=
 =?utf-8?B?eXVDNGFTVnFnZGJuaHE0alRQR2J2eU0vNmsxNnVnM3RreDcxS3BTRWpaWVVK?=
 =?utf-8?B?UnJXblJBeEdYTlNyWHAwUjRsU0J1ZWFneUJraFNvUlFXNlBzVG5HK05mRTZy?=
 =?utf-8?B?UkNpd2VvSmRXbFBTQlc0R2tYRnNndmJ2YnZta25DNEFycCtVYVp3TEx6cnhr?=
 =?utf-8?B?U3FQcFRxOGFrUzFzdUFINkFHMVZhOWlDQk9zdkR5TXovVlMwZlNzcGNpbkhz?=
 =?utf-8?B?LzAzTFQ4OUdlUW9kQkovZSs4QXpTaWpuWVJTTjhnU0g4ck8xNzk5OWdsOUVo?=
 =?utf-8?B?azBjcldZQk5NQkJjWTZOMG1WcVlLeG5Ja2tvTitYL3BVWjNjV01TL2kyb0Fo?=
 =?utf-8?B?QlpxdmNFWXV2aEJjeHdWR0JrdWpVTy9mOGs1UUtxMm0yMFlsWERoZnFtVFhG?=
 =?utf-8?B?ZHhhN0JubzJKZ2FBNDlJZ2dNZUpNVVpOcHhQQytXOVpOQzJvMmJFYzc0Z0tK?=
 =?utf-8?B?d0YxbThlVGJsRGp4MW5nZmxjZnpPYmgxTktIQ0tOajRsajZMZE1tcHp1Nkdz?=
 =?utf-8?B?SVlpdnBQUHg2T3FVdFhycnNaTi8rWWZRb29kcC9rQ2I0cFUzRUY5VnlDa3hC?=
 =?utf-8?B?dUs5Nmg3d2ljRy9NZ0cvQ0hZK2FJd2g5QW52c25iZGNhdWsxUlg4eVdlbHFw?=
 =?utf-8?B?dVpRdFF5bW41RGpENkZ6TEhlVEdoVTdUVUNOdEhEeTNTMXF4TEd2amcweENP?=
 =?utf-8?B?bTFxOVNPTGNxckp4V0txa1ZveWxNT0VBTHpPNkdRN1hZOHZpUkJhdmpaQ2tU?=
 =?utf-8?B?T2hsSlpFME1Cb0NRNkIxdXViSmVwT0F0ck5DWllZWkI5QlJXTUkvT1hIWVE2?=
 =?utf-8?B?ZFN4WGs1S2tpbU1NTDJLQUlxUmFwZ3hiTjlOUDFYRDNmQVVKbndFd0JROUM5?=
 =?utf-8?B?b3h0cEF3aTV6eXdaZlVWVDN0clFaSEtxU2VVaWN3UVZmVy9CVnV4dUNxUGdn?=
 =?utf-8?B?ejV5WGQ0SGVMclZpWk0zcEFUb0czU2tIOHlIdzRnMS9BdyttOHBqbGZQY0JK?=
 =?utf-8?B?RkFjdU1QQjExQlU3aDVWT1VHdC9EQ2IyY2RuemdiNngwTVpTV1FnWE1VT202?=
 =?utf-8?B?cDdwbVY0eS9Ta1dNbFA1ejI4NWVuWDl4MUNXYVFZamV2MUQ3bDJsZ2tFeDRV?=
 =?utf-8?Q?V/xTTTub1ALajujy7m0dwPkm9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9543a5d9-0198-40b5-68eb-08db8d8d0e1a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:57.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Paimdoq4VWZcXlmYtKQ7daiCGmdUnYltTeKTn/2ChHOwc5G2cxg40kJpj/4an8YsV5Lr7C8L80rIK9OxHphrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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

