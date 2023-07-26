Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEB7629BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGZEBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGZEBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150711F;
        Tue, 25 Jul 2023 21:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RedkM1C7uYp2R3smU0+9TQi5TBSKzZu84cSE79PHHz0yPRlVrVYsbdt1wrOBBI2E/e0cUoVmpeJ0HEAhaa/Vh/jXSQPZvx1HbsLf8UepG+Ie8n3vg8zEL+8ihli8rYKz52zYVsKBd4JO7t0RqK7s5GJ3+hT1jL72CWhwCw/Hf8dZ0pwXBbdul7enyOmMk+8toRdg8XwEKFnHFkMhajdf0OviCIwfvxJrx0f8t4z8ZUmVGe6fZ0QzUiihruHLV+SE95fBPzk5e17mM9ilUGwUohM35X+KjS/HFg0N0hxKiX9jOd4KXTjkZDUbwj9ciLY8UG2VwKjARwBy21+CKI6xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/FEi+NHrJgVzPUdApTL1O5ZKA2lbL/MoTwujWdTFXw=;
 b=bAwip3MfudLL/+QGH96tG2BfCHBt96+cHcr/x1G7ahGtwvcoTDe6U1jkLTnqPnluPynZeH6t4bSIzsfcV8IudGYCh+BeV+mKaBVM3pGz4wxcoICJofb4795s4u8M0Vu5K9vmviYQnVAjJtZd30VXmDlyj4XFlUNmWCU8jGPCAx6ANr2ORaV00AByHwhEGJHms7i4Fgn4UAlg7DbiHfwYv3fqaQ3xjnuZqKC6bElF4yKAJ65LxZM8G+wJzlqE5hTlEM5RkkJdZe5XBBk8POkyhMyJyXk/QeNcTSVlQ+ukJmk7vjnPLD/GmzqHEs5Mg6WDs54n5QQJ4VyEcMKIUSNnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/FEi+NHrJgVzPUdApTL1O5ZKA2lbL/MoTwujWdTFXw=;
 b=eZHaAbbAXBLKAVQa5/YQHfdmjC4XXZSVYtcftVYwSJGQJN5VblG7IfKa+rnbszQosQiAh5jgpMa8y7EtVhVLNB4mvZsPKv0UvelmfRbjXo7g4WTpisSZL2Y358c+Y6OCeWy25C66/nXfoqcb9KGKWfi8zt8vOep/7nkMCKLpRKIq9oGsBXVypkWNfDmO/E+iiy3YvjTimHW3l5CcGr/YM4CveB31Wlkp6GPEeGxkw2sVnRN4gfiuyZHdVHEqrJIvxufZJlIiJ87ct53rMHWCOxturEQtmY9p1ka78MwM1HIzYgkVV6hiLXlrYM91sEkLmdiM9zIsiq2aC11GOUVsrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/61] mmc: davinci_mmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:47 +0800
Message-Id: <20230726040041.26267-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b0f6ada-7026-4f4f-2516-08db8d8cf15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrBSyRdWwYTDrYE8OmlFYaZ4Lh31XP3WBxouB4pbT9MkoLHGChvocqmuCBX8VVZaSRNCor3kHXWnIv82aIG9LkInMveKyBQ3E0nXG2jsUWec27rf1L9gqV3GeM1FdHDFtX/a/QN2Ne7loK/IKbxezQqWNfyTYZwUIBV9IEC09CoWmfJoERYFHWoyqhldFClDkwIGnhQFmcipIYGrE/13VYX5xBouyPoxnhFSeoctsQkU35y/2fx2gq2MFuTSzZvVbpDIE/93AFCayjcVEiK2U2BIYCFWpQ5pnYRV06iL/iMKXgHd7Sy+6T5/2vYJNOHr86WtVDbJMnWyLKiOlJPuw2+d5eBQnHR/FLdOnYjnoKvNI+gfZscBfkeJg+Zzb576pVcDYNf8al/V/AjLSzg/4mSvF8zMA7YoO0daruLc3ktMvMOc01IojroyRGwV5KqHAXfUtrMUjMNk27aCEHb9iQYmiJ9aGD/oDTuP9UV7ssyDqKMtWtKQFNRHEJya/W6p+UwTQuanAEqdadRKvzMkEV6aA4u+H2Zse0Dlu1KtNMiV++48I/hPx8f5rLDWH0KEYsNj0Lh1xD8r/CEsRCOtshPJA3jywzEI+ojNZNr36faTnZIijjL7MvMrF1Ast9He
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGU0Si9QUGQ5eWR4QzVBS1FkR2xzM2JiT3YzejZ3K3BDak9SNEs0R1NFQWls?=
 =?utf-8?B?eGFPQXNURXo3SmJyd2FGWi83clh5SUROTWo3QUtwbTZsRHV3UTRLUXg1dzZz?=
 =?utf-8?B?MkJySDBuR01OV09Rb1pKSWNzd3RpZjVGQWpPcFMyblZpZFFTempqUUVNZ1hX?=
 =?utf-8?B?dlQzRW55ODJiak9EVEFNZUNrMHZrUitFYmM1eEp2QkVTdUUrK3p0bXBtTks3?=
 =?utf-8?B?WGhvMEhSbHRPUVo1TFVNZlB3NmNJQXZGcnNzSk9IcFdDbHZQZDVYa25zaUlO?=
 =?utf-8?B?TXluWDkwT1NyQXZuZUhNYkFsUWNLeXg1RGhiNjUzMXdKY3VKMjVHZ0M4Umw5?=
 =?utf-8?B?Z2ZQV0g1NE5pN1FGbnFhNDBDQzVydDk2TU94Nk1PWXJnRmJzWDIydkhmbzNT?=
 =?utf-8?B?ZVVuM1A5ZnhHa2xqNmtYY1N3U2tuMkx5ZnBCOTEvLzJLTzU2a1FJQmU4bkF2?=
 =?utf-8?B?Mlk0NGNuY2RMVkpnSW53OWtSVkRVbktLTVViS3RtNHNCNVorcU1MR0FHWWwv?=
 =?utf-8?B?QVdtV0JCS0lMeFFjT29KVXhOblhOcXlLMXBvVmpvNXNGbmFUVjlrbnNZY3NT?=
 =?utf-8?B?T0FUTFpOZHZKbTl1clVSRmlBdTR5citJWWNraVpCTkplTHZnZEJ2TWNhc0Z1?=
 =?utf-8?B?dnBOeDhMb1VUbzhLT3NrcEZBUWRzZ2Z4dFBRNG1mOVdxRXZZWCtjS2hHWlNo?=
 =?utf-8?B?QzJVRXpNU1NSUXkxdDBDRmlDcGU0ZEpZVG1wTGYxclRlNXhuc0RhNHloSU8y?=
 =?utf-8?B?cFErenBOWHJGa3BKaVhxQ0xVaVYvQitGV3B4eGptSGRCUkxOZlRuZ1hNZEU3?=
 =?utf-8?B?ODdnb1dyMnlLSnZXTWswVElyUEt1NVIrazR6MVBiSXMwOUVoVXo1aG5zd1g5?=
 =?utf-8?B?NFFzWndLQy9SdEVFSzAzaTYzVDVnWHQyT1lFTFNQM3I4WnY3Z0R2NGZIS3B3?=
 =?utf-8?B?dS8vdzFhVTV6L0ZheVROU0I3d0VkQ2tyQUVxc1JWWlhFNzFXOWY3SzJyZkVM?=
 =?utf-8?B?RTJJemlYQkQvUzlzQXlyWmhIaFN4NS85N2NlanVscTR0YW5WTEkrcEVTNFc3?=
 =?utf-8?B?dHFyWjNEL2ZyN254blBpMDE2SVhaM3BuSnNNV21yUnhobWNRR21lTGZMNFF6?=
 =?utf-8?B?SHd5dEpCeTczUlQzZWd5bkFQNnFuQldvMHNCamkxZkptLytLRTRyWUZWVW9U?=
 =?utf-8?B?R0dza0FpM2dJeVgxTDEvTjR5ZGpCNWtLNGZSQkhxL0NGdy9YZHZkb1dtcTla?=
 =?utf-8?B?azhZallvOWk3WUN5Tlp2TEZqRUlJNThQSk9SRXJyWkI1MmJRVkx5dm5nYjZU?=
 =?utf-8?B?VzRZTnAxUTBBd1dmMUZjb2JFbjZ6YXVvK2p6MWpac2lPMnE3dVM4UVVuU3Jp?=
 =?utf-8?B?amdEWkgzd1g0Zm9HckREVzB1ZjhoMDZaSnQ2T2VjamFlREZXZGVJUXdHM0RT?=
 =?utf-8?B?K3ZZeGZiSFFvQTBHOTRMQXlOLzZ5R2RjYUw4SWhER2Q0QWFPTWIxMk54alFq?=
 =?utf-8?B?OVJZUG8rSEJ6ZVVLQ2Jhb1p4SGNMYU1DMHRuMy8xWUUzanZ0V1QzaUh1UUZa?=
 =?utf-8?B?Y1pOODR1Ukx1M1ZwbFFoTXFHcmFycklpM1U5d2J1MW1kbVJJaUQ4S1pNZFdx?=
 =?utf-8?B?VTJUNVo4MVVpR2ZoZEFGbGFrNHNMTUY3ZFZLY2MvSUdzbDlxeXJkeFpPbXd6?=
 =?utf-8?B?Z2tTSDVlZHI0R09GZXc5WUdLYkNDa2VyK1BuZi9ibXhZRjZHZE0wRmtOdU1J?=
 =?utf-8?B?RHJxYkF4YWlDdzBhUWJXYmNkZzhkWE1NK1FPQnhPT1FtNnBOYUZqb1RTcFQr?=
 =?utf-8?B?VzIvNmNYaVJNRzBYWVhpekJ2bGMvbmMzT0lvMmRic25nVEFxdzYxUEVqS3RX?=
 =?utf-8?B?citrRHJvMHZJOUl4cVJWcFJKeTdSWWR0M1prOE5yTTBya2Q1TDB3WU9OKzRr?=
 =?utf-8?B?M0t5RlNPaE9HU0RGYkt4Z1k4YTdkcFVrNlBwdGRIUWM4RVMzcFpyUk1iK3NW?=
 =?utf-8?B?TjB6bXAyVjBsdEk4a2dGeEdHNW9RVnZkejlMaU1EOVQwOFdXRVRCczZkWnhs?=
 =?utf-8?B?bEVZYTY2Qk80QlBIRk1Qck1wYUNzNXRNM2ZjNUZBQlNIaUVmZWJoSmhwUkhy?=
 =?utf-8?Q?OC0oM9579qJBPdfFe6JfiG1Q3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0f6ada-7026-4f4f-2516-08db8d8cf15e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:08.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfobKk4+O4AR51y7PMHxo83Xdi4Vev8ekuil77Q2YbfBuWge4iRqemG66pkIplOgTs/RaCaBzXhJE6y/dn72VA==
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
 drivers/mmc/host/davinci_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index fb686c0d171c..3757e4ebb614 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1345,7 +1345,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
+static void __exit davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 
@@ -1354,8 +1354,6 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
 	davinci_release_dma_channels(host);
 	clk_disable_unprepare(host->clk);
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1402,7 +1400,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-	.remove		= __exit_p(davinci_mmcsd_remove),
+	.remove_new	= __exit_p(davinci_mmcsd_remove),
 	.id_table	= davinci_mmc_devtype,
 };
 
-- 
2.39.0

