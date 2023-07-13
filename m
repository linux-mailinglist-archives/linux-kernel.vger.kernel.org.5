Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575CF751B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjGMIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjGMILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9172127;
        Thu, 13 Jul 2023 01:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gptmkRAxe/UpnN44/zZmnghqPXf/agolPrkfF1JVul+lluLQTjaJ4S8Xthjx3RQy8brASGpLeME12I7IJkhfLiJxQUfkNKfB/H80v1Iyhoyg3oUA4lw9Y9QpyGKCaDc3/OhKSyX1WrESVX1IdVIKksi8pm+uHsw4u+sKRFyIFSXDUQgAeOBcVJlzojaGHG5m+awdKncp8gXIrN0AjXWbRLeow9x6CViBXoEKxlwPfFslFCsKZ0MJHX43OAKe6CLziogig4+s1qtPKVEaGkT0icY1zGA14RHy6Dhh/IrOcLWWj1JI8djJgGP9Oq6zk82kp1krk/RP4FrCmpgL4kG4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw4Pv13PwJyGo9i5NmSf9Iol6jil3qv/WJ4az+CnkgE=;
 b=PG6Qtgyfte8vMQV7dYUbataEdiI28+eGQRgFrj1F8g4B7vP9xI0o3zGDjpUFvIFwNNXk+4ZonqBHlzEnAU3fgSA4SkSd2HwTgx4/RPuseib+qWwe5DB/Hiy6jXsXVTv42jrqPdsCqjcHYTz8waZk8l8CgfkbYf6RkEJM9wrRuYt5NkoGWuRqNACaKxIpGT+jcqA3S7hN2XJTvxchUYjv5E9cAxfObzAd1UOqzlJGatQo1t2oOwThKBgHGXXH0V7nCNIiRjP1y3RnDpdS5Cq0wlsZzJn5d+Y5ED+5u5k/bbhs5VGLsiGiQon3HR/jvUxaV8D7n1ajr19BuStIoYsAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw4Pv13PwJyGo9i5NmSf9Iol6jil3qv/WJ4az+CnkgE=;
 b=gvwt/1gAMHxs/97yF1e2BWZ4Fsk+GXZK925vONP268NFIEQYZ16loLlqA3t6ANDkeELcEujwKjGyk1S9KwTVvArOpDJ+2dqU6RY/losGZKavmAgMIEumrG0Sep93H9DGDKxyGSOGNcwTUbPgZWiU05A5kcFeduiy0SpQ8bpMIrWbbzWS5wb5RIr0N8mPq5TRG5MEbf/hHjnPvFla4GfMm3ImzNj4s3V+AJSuPQXSx1huiFYY8krF63786Y0TYePJuxj+1CxqnMBq8vwYyxNdGkNt2/mt2h/MNml4+qj8cRMWBlFvReVhUSAR7GivxghJo6LV+C725eIhY/vp5rQ4iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Robert Richter <rric@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/58] mmc: cavium-octeon: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:39 +0800
Message-Id: <20230713080807.69999-30-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 0394a9d1-0157-4325-5165-08db83787178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jxo0T1P4S7chyv4HdKf1mXjv72yLDasIvM9K4RvqpYu/bPp7aA9XlSYaa3f11j66TK8qW5AJvNi14lpNsYwD7/SGf/Y5yGOPqPDj7R2GxPk8gapUiVvmMM8u6fWQf+FpjCr2rHpqkhJ9XlYX/3VKw6IrL/MiS9myL27ltP4SYUtgYkOBggiGqwX8qK+C32NI/vzNOgSGKGymhPXWBBq6bIIPmr6U2BgtuhokSVDjrIYNdDfwhSeixB1bR54PIbahKEkP7sp3YnrHBObbWz0jumuF0TqxidpvFPLiQzf94Z5BUOrRhtnAtZuKmTVNQEUcTTj+QSYkp9zEeGFw1PbMgMxfeZEesfgrcQQECCv2sxu3oRWvAq5s5oDki62GZu5U+SeH1y9OgZYBPRMISCNwzBSrwtf+ta0aeIj1irc0W5w9frFFYfvu/Zo1Vk6ls+5MMMzP1Lu6mDb58e53W7LEPojlIjuIMyKOL7hr/HB56fB/aF1XiVla858lLwHviB7Z2qbkwdOgs8puVPGGq1E7Ktl/bOKY+UHoPV73g41ug85luzkZFBLXvnMLbyaZuAAbwA0c7BsUn9PbKJ+6caMHnGa8lJwsT9z23HG+pXlc0Gk9NtPN9eiMUYBUkhqov1we
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFlCSUFDN1lHS0VtY1Z5VUVmNndGR1JhWmQ3N09mNlQ3VkUxL2hiTm9mRG9t?=
 =?utf-8?B?dFd0VWpGQnAyRXlCNEVnY081VlhqVVMyRzlsS1o1ZFZXZmFVSE10L2lhcC9W?=
 =?utf-8?B?b3hrTHBlRkFOMURVZEI3RUV2QjBzTUZjTWptaDJDZW1VcmFBWW1EUUF2a3k4?=
 =?utf-8?B?eGlDN1ZFR2JZeWhTZzlMU3g3eCt5RHIxZG9JSFE5TGpNSkFXZlNZMGcvU0Yr?=
 =?utf-8?B?emZDQVpzcXdqbXJwa0U3ZVZEeEV3L0hzR2NRczQ4RkFwZ3VPMXpDKzVpYjN6?=
 =?utf-8?B?TmRjSzd4Zk45VmR6UGVzUTVqOXZqNUhjbXdST3FJTEkrSGpYdzlDd2hVQ3hm?=
 =?utf-8?B?ZHBTUENpVW9ibkVpWkV3YmRGTmk3aXArZVNSZGQxNU5sT3orQy96S2JlTVRq?=
 =?utf-8?B?aElscEpzM1hNYlJoejI2VnNGSkx5RklWb3ZHNE1tQVN1VjZnYk1Ec3NlMGJa?=
 =?utf-8?B?R0kwZCtmT0I5TnB6dzhSYnlOMGhCUFJlM3N0a2Z1dmZxY2U3cmcwSHlwOWZW?=
 =?utf-8?B?N3FJOGNFUEo4L1p1b0E2M2Jtb0NPNi9Kc0VLUjZsaGN3YnVLTEdRYm5xYVF1?=
 =?utf-8?B?amtBMCtTdjhwQlpRVC9ocVN2N1NSR3hMSzlRM0xxV3NjQ2pRYU9XN053NzBM?=
 =?utf-8?B?RmRVTms5MXgxOVVuelYxUHY5OGtjM3ZHNWttd1Fud2lvU0FoOGlXcWFUYStV?=
 =?utf-8?B?aVNjdVh5MUxrRjg2NjJnem5Eb05HUmRIZ0FqKzViUDJyV2dXM1JzekdKSUhO?=
 =?utf-8?B?b2cwVkR5OHlFZVFKWG9jd1NURTd4TW8rcGh3SzI5Skk1T042VVJCR3ZJSVhY?=
 =?utf-8?B?cU9oYjF5N21pc1F4WjhyTGRwYkc2Ymd5WmEvVkM2ajZwSi96VEJTck9zM2Nm?=
 =?utf-8?B?dy9LQ2xuVWt5ZnNxRTdrVnZmcU5VbWVqd01FRUc2SDRNRWdzMDkvZ0drV0Jm?=
 =?utf-8?B?bWtlR012am0zMXhoN3dmT2NYbnFNSmdPY1dRRVdCZmZrQXcyT09HSlJzbWps?=
 =?utf-8?B?VGNCbi9rckxaN3VIUFhUSzdwRTl1dnFDRFdQc0NEd0lWVHBEWncxTmY5SnV2?=
 =?utf-8?B?U2ZpSUg1V1daNGduN21jWDRJUXEvTzR4YVNoR3BlVFlFb2FZdFlLaFBBNGxF?=
 =?utf-8?B?Z096SmpwdHZUZ0F2ZEV1b1oycjgvcG5jU1VSYUVEaDlOREgwb3hyNjE5ZVQv?=
 =?utf-8?B?S0NVZ3pPSUFlak1MV3RqblhSMzFPcWlmUDFTa28wT1RXc0xDVi92UnlFaFpv?=
 =?utf-8?B?WkhCQTBNMFVmMlAzQ2c0RXptaC9qWWZ4WDJTSEdsYVVGVXNyalQ5ZllBNUla?=
 =?utf-8?B?eVNmcUZSbm8vOXZTL1RDTER1QmFSbUhmRFFTMnBncm5nblRocTFVU2pyYllW?=
 =?utf-8?B?czdGS1NNZHNxekw4bkxrbE5vYXg2YndVT2hjaVZWZ0hLR2sva3phU0hvNzVO?=
 =?utf-8?B?WGk3aDJ6bUdoOVpHSjRzS3dDQnV1TUs5bnJzaXk2SW1tZlBsTW5FdXl5Ujd0?=
 =?utf-8?B?Q3F6TTR1TG5iaDZnQWtEaUlzSkFQOHhjQkF6S2p2TkR3cWcxc2QwVzNxc29a?=
 =?utf-8?B?TzdBSnZVTkVQVWVIWThFUWY2NDBCdmkxUFpZMzlRV3NaNEc2Y0hQZFNOc0cz?=
 =?utf-8?B?TGw2MU9sc1VmVkZNOVk3NXpQTFUyS3VkRXdscURjcndtR3RiQ1RDeWMyNHBa?=
 =?utf-8?B?QUpjQmFzMGFldktjLzdsRTNBbmM4NmQybGdOMTBWU3JieFZ0YksxUWIyS0hk?=
 =?utf-8?B?aS9IbEx6QjM3OFMycE8vb1MrU3ZUNVNjbmRyb0c3RkJCNDB1QjdKd2FXejQy?=
 =?utf-8?B?SmlIelg1L1g4eHRvUXo4by9na1J5M094U2NCa2NGQnNXZW12MnE1SWhFMzBR?=
 =?utf-8?B?NWZTc0xvNmJuaE5pSWdPczRjWFM0VlZBUXk0SXZENlI5cGVCMk1GMmo0M1RH?=
 =?utf-8?B?bVRMN2p3VE5Kc0pZM2dESU5rYmhQOU9EYUFyRmJMeUVxVlZUVEozR0JZaEZJ?=
 =?utf-8?B?NVNKZ1Z1dXZucWhDRlBUdmdoYlZiMzk4bHJjYjF1VnhZSlBKTnN2Mlc5OHk5?=
 =?utf-8?B?SGg5ckNRelpaTytjWDlKZUp4cWtxYVFxN0lpdTRVN0M4ZnFpMGdVRXV4em1U?=
 =?utf-8?Q?1ts2fMlfCTMokfFA1Kcv6ZX28?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0394a9d1-0157-4325-5165-08db83787178
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:12.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB30iq6msy3mkFA7nuVDQEEL91CywknPCAN6oS0UrSjRXxpE6Hehn+ps2p1dIaA5TaZDk0YWC2nnw0DZ16Zw6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
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
 drivers/mmc/host/cavium-octeon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 12dca91a8ef6..d526868b30f6 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -294,7 +294,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int octeon_mmc_remove(struct platform_device *pdev)
+static void octeon_mmc_remove(struct platform_device *pdev)
 {
 	struct cvm_mmc_host *host = platform_get_drvdata(pdev);
 	u64 dma_cfg;
@@ -309,7 +309,6 @@ static int octeon_mmc_remove(struct platform_device *pdev)
 	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
 	octeon_mmc_set_shared_power(host, 0);
-	return 0;
 }
 
 static const struct of_device_id octeon_mmc_match[] = {
@@ -325,7 +324,7 @@ MODULE_DEVICE_TABLE(of, octeon_mmc_match);
 
 static struct platform_driver octeon_mmc_driver = {
 	.probe		= octeon_mmc_probe,
-	.remove		= octeon_mmc_remove,
+	.remove_new	= octeon_mmc_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

