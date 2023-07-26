Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806E07629C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjGZECP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGZEBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4741BF2;
        Tue, 25 Jul 2023 21:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlPRj5kaBhVAXZhijrNOl9+WR1LUNPc9HMdyap3C/Tc5PMw8/or4o5RxVy/JhYIc3ysrsBbiRmxF+NWcpnDTgpBfpL9BeI/CUIEjlQkaJsp5wFyxzS7nzfZJhQwLJipjWALTFINLfJdCLIYdqv/lCnLFAC5YFmBYGhHR/uYG4cH13KWeh1RzkeWDLnkcCIvMqWiibt3i8Al5McXnO6US4lp0WopABh/LYMNV/ZTpSY+KqmmzUYpEBZ9URi6XhSC9dHCdaXWCz+hnWe5qeIV5CZHGECVObX2kFZq4Y+mScTvJhGmqBCHU0pfgj5nFlEFrjGgcia7UG6O1PhPime7gBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df1DKbWeg+xqkSYPtOjL8RorXDmDCAUtgwB9kJK//H0=;
 b=dOlRFHjbXSfRtfMrPLL0EZkmj+D6/Hse8xEMCAz7SuoRdlgc+Gs81FbF3wD9h48xdUW/spT0n3BBazSz+BoBAgpEUSuTGV04ZOi4BhC8tUYsPUjnWTHytLHhwvb+pona5BQ8JpwjP1GLUfkOLHqw8/HUUqk71BL9X+ecEya2t3wg/3VlP9LAbd1H6bhPVuyIPWk+HnXnPbtDnX930jGi1qGHJgCrVFo4sABeqrXXpfjGUnYruAplWohRzr8fwtVf/8RucElyQLz4wT5r1kgMEo6qu+N5mgIYHsbaflt9/G6QnUqb/geY+HLg8Iovpy8CI03yyhibTpN3OAok4sAT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df1DKbWeg+xqkSYPtOjL8RorXDmDCAUtgwB9kJK//H0=;
 b=PupFyPMKH+vsGTMU9kT2SpTvFBGVzJ5XELDhpU1FsiLRKV7gOa1B30wGGBXhJgg31aUxzMM+7SgSMZjz25gdTE59VjVygobpiw4b0MUCO9VvUshmo8dy8RAFwwJAyFvq4F8dYxFuU8UCH54pBmwdap9xa5dW2eMECu2h2zc8lvzXPtHeBPQlLZ/mo6ZwPKG71ITfCtv2hoazEJ9p1Wtprya0kIkR663oCbKAe12Hn84CqBsnSaqJKLbcj8XXEQShS7MHOve5EyiN0B7Lk8bQbc89ug3ViC02S6+VcRNfsP4xfvNMuOKrgLQiG5d1FXfMaLb22Hq7trJ28vk7O7CuGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/61] mmc: sdhci-pic32: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:49 +0800
Message-Id: <20230726040041.26267-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2090779-55c8-4c6d-c23a-08db8d8cf3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94mWmF6BEXjC32Y+jBnbE770+FWGLS8/nU2LYaGfjJugNIbtufydom0L7mDAQGo/DsSjI768LXYlUyLwJBiFWZxDGVm1n7bDurJ0CF6wGJzZQdrt6r4mIsUKAiOUpQM1gXLcWOEohlFeOKw95P1HNNgxg0EOZEa447DnlxgyL4/dalnqOc3v2P08j7Y49dWnqnJOi12+ckfHrWy2aq4N6qZbw2foxaJjuLBjaP60/Llbn+WORQH3dVpIzCiGNb0CkTGfZSoloMkITuYlRguXXJJ6sh0icjXHtWo5QaUo+Rury2B5bIXtyb4Va2BhFxmtsUYRVW3rgs5oCFtVqLJx8ndpO0OFCqgaUmuON4Qq2PQrHdSSr3Hmn0f7A+3wyUg/VDWW+QIR2ULct19SDoKV+jy7/n+sLQc8E80X5A4WJV5ESWm/M2Klcjs5zFz7BzCqRJ+BjPnHl5HDFndHG0Sn0zC8N2Y4pAR4890RNNIlbiYMp2Cl8nR8fnmNC4+YQWg17C9Q0jENSxGVr37nmXIYWM+pdELq+eDjfTWtr7bTclmuZ8pnU3f50oYvr3PAn5GNTP8mkkIcb7VhOz481feHEQHzTsIykFb7NoZzJgo4f3JnuPGckfZfyuuwEoHv1YdB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxOc3RYc2txWjZtOUdWZHAwZ0pZa1ltVTBjazJ4L0JGWngxVExpVHdsVW1S?=
 =?utf-8?B?bWMyekt4dndlRUlNbURua0JRdjlEcVhXcXFya3dpUFQ3TVVqN1dOQjdNUWVP?=
 =?utf-8?B?cThpTldnRnlJMzVRVUljSUpTNEx3VHMvcDIvdVo5R2lsT05odzQrT2lHeFRE?=
 =?utf-8?B?c2JlblRiSnZ1OFYwOG5QS1Z3VnY3VCsrcFVhZWw4Yk1oSmgxRWJIT0ZpMzk4?=
 =?utf-8?B?cC9UdTUvMFp4T3RCZHNZSkYwWTgxblBCTTlhQ0dtUERIdExnMnlKRTRqUVBN?=
 =?utf-8?B?OU9BajcwMW9YK2NqR1FPZ25ZN3JTWDR4OGs5K05XSnFERUJpYmVxWnNObGYv?=
 =?utf-8?B?OXlKQ285ZUU4M1JEb0k0OUZXVkJGRVpWNDdKOUt1eGRrcyt4WGtBaG5zRDJx?=
 =?utf-8?B?ZTJJa3Vjb0x1akJ2VHE1ZHdxdzJjNFd3bFluakNMSnhFRVFORVUvWmFhQTNn?=
 =?utf-8?B?TGhjQ3R1TUhqaGhMdzIyRVp6ZEVTUDlHM2RLY0N3YlVhenZCS2NWeWdCaUh0?=
 =?utf-8?B?L3RPUFNzdkhhWWUxdjluNDRnMEJOdnpMVm1QVW1oamwwaGFrZ0w1R3VjOUZG?=
 =?utf-8?B?VE9PTWRvWFlqSW5tbFM5UUM3bzBYRDZicHdxV0pxQmpqSFExcWdCMXR2c1Yr?=
 =?utf-8?B?ckpGdTdJWDdDZDRNdVdpY29TUlFaT3RTM0ZFNzVQWUFNWDJwNkdxTG90aHlY?=
 =?utf-8?B?M0hGQWllTUFTTlh3T2drNjd3dFlMdWdMZjJlYnlmV1QzS25LeE95ckJJdUNS?=
 =?utf-8?B?bkhrWElTYmErTmFYZkdCcEZMSU1zTnliTFl1YzVpaGRnMXFXOVdwOVlzM2pu?=
 =?utf-8?B?d2hRdUY2VVh5ZGFnYVdIcStrYzlBT2J3K09wRU5vSk0yWFdvazNtYkhwV0Zq?=
 =?utf-8?B?cjRKM0UveFBWNkloUTVrTHlTSHZ4QlVjWmxyV1dGVS83b3NCZkZFRVZvUFF2?=
 =?utf-8?B?cWpOZGkvTEpjYXdYNUJBbE0rbTBML0NIK1RqckZ3dlNZTElxanZ3U25aelQx?=
 =?utf-8?B?ZGRkVFdRZWxDdklENkJ4anlvRk5QNTdodXJCUDdNZjBHYm1GL2czMEkzQmhZ?=
 =?utf-8?B?NW8rQUdTV1lUNERHdmNkSzlndXY4ZCtoa3M0NjhkMjBpNTc3Sk9vQ29HZjR1?=
 =?utf-8?B?bFJSaXg1ZlpadGJZVGRadWZQSVFkU0dOTkYrS1p2QjhZVWlGQllSS1BuS3B5?=
 =?utf-8?B?S2tnYjlWaXJaaEVrY0x6Q1dlcld3Y0hiZ1ZqMzYzaW10Q2xjbE5wQ0U3ODQ4?=
 =?utf-8?B?Wi9FUzl5YU5Ydjh4Y20yaGR6dUNjeWd5OE1HaVgrR0F6aERheXNLUlJlZ2dC?=
 =?utf-8?B?dnVMdytBTEJsSkZzb0M3NU16RDRnb2xzamhYaTRCZ2JoVmhrWVdiNHppRzgw?=
 =?utf-8?B?QnZjb0FTWkFDTEhSamhmbHdUNnh2U0N1RmRwQ2t5WW50ZVAwS3lmNXVRenRo?=
 =?utf-8?B?N2tOUGhKTWdXWjAwWDBSMElSZW9qSk5RRmMzT1NVbEpVNGIzajloZ3lrbENL?=
 =?utf-8?B?a0szbnhlZEs0cUJoc21lQzlYUDdHR3hXUEZTNHp1WEpmYVAwdWVrSzlCdFVz?=
 =?utf-8?B?b2krQUhJSWE4NmJkZFpwMS9UZ0JCTVBLcVdjUUt3WWtmb1pwSWZ4d1QwNE9B?=
 =?utf-8?B?dWZtZjc3cWw1aGl6N3BSaWxad0M1c1U4UzBEc1pCc3lyTUpHTkJ4T0dEM285?=
 =?utf-8?B?QTFadjVrWEZ4M0RHcmtYTVJvUFhIWUxZQnpMSlV3bVk5bHBpK0xTaGE2ZWVS?=
 =?utf-8?B?SmJJSFo5M1NxaVlRdUtPWTFPTUpBTjJzdTdxRGcxbmgxeG9IeGd1anpvYU9G?=
 =?utf-8?B?L28vdWRTUyt1VWdJTDBGa2xxQXhIb3lUZG5SSm0raEtzZzVWNUJweExaL2Nv?=
 =?utf-8?B?YWhzdU80QitVZFRZVmdWTDFKdjBYbnk4K29NaUJYbHpIejdkamk1d08yOGJ5?=
 =?utf-8?B?QU5UZHluUllLSWw1WjB2NDFjMzhpV1pWdE5MY0N4bldiTW1MMDBQWDJCbjRr?=
 =?utf-8?B?ZVJBV3NoVGN0WlVyVFZKLytMR0dTQ2NaQnNnVVgzSWdrNThtV1V6N2RlRitZ?=
 =?utf-8?B?V3Q5djRnZXBZcFFPN0xWczZTVXdiemR0TVNzWGZiK2ZVWDUrNTlQVTdDV2Iy?=
 =?utf-8?Q?Oz/XywoQPRMfTQnQ+7snIIuRz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2090779-55c8-4c6d-c23a-08db8d8cf3e1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:13.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XadAvm/ctYxHikaGSEO4I0VX2B5oy5TqIL2G3A6/LMNagKRRkZmwneFb/NgtEdhrGNJJaBP3bYQpSidvNjhqIw==
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
 drivers/mmc/host/sdhci-pic32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 6696b6bdd88e..7a0351a9c74e 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -210,7 +210,7 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pic32_sdhci_remove(struct platform_device *pdev)
+static void pic32_sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
@@ -221,8 +221,6 @@ static int pic32_sdhci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sdhci_pdata->base_clk);
 	clk_disable_unprepare(sdhci_pdata->sys_clk);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id pic32_sdhci_id_table[] = {
@@ -238,7 +236,7 @@ static struct platform_driver pic32_sdhci_driver = {
 		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
 	},
 	.probe		= pic32_sdhci_probe,
-	.remove		= pic32_sdhci_remove,
+	.remove_new	= pic32_sdhci_remove,
 };
 
 module_platform_driver(pic32_sdhci_driver);
-- 
2.39.0

