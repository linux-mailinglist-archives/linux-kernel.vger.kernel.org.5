Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80C762A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGZEUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjGZEUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:20:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCBA5B9C;
        Tue, 25 Jul 2023 21:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qra3j3Y2Bt84uI9mArcwYulDpPtgSh8BY0Nq0eQDFGfYsmlo2IeCjdus6nUnAwxeGQJWnUjqRz/hMAR+6tZDqi+wt9L8r0trm520BXW2/omfLjgCmU0SPVc0tbfd3nTtSVH2icfpAl9XJibgXmUs7+O+ffeBdjMmhoybhv9XhUOYWLBsAzKwAmOmc4KOdkUievD1XO06+UPTgL9u7agOomAuVdrmowKT+MKnXV5m9LV12DHhrkHvo0q5tORTytAqz8RJ7P01O9Ur37TOmjLcISm77++oBQ/o+Bc3TYhOXF8bDsrVOkWyeda29IYqgg1ImfHCSmG8U7lYa/imqnEqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5jSVvTfy21nexuFITYTeRJZPViozYwLNoQA6yut0bE=;
 b=F/14DRGxIniXezdfgCrCpsVo2hpRtTvEivsLcjiwAUg8q6RziN1uL7BA0VMbomdzcPcHXzbXNZOO36Tk418fEcKe/mixzZlZgCnkRfP1Dgkk/ALHUK9cppW1JSiOK090r3T/zCC9RZtax7Dgt6VHB2okAZjburWP3FgadWRnE1mG7c0+utjoxNL8yEYQmNq9IkR20bIiztYG87RsqydGApi3Hnipdxugs0CwBCDyYFyjXauHxLnSGHAvrJWVZV+GXHRSyvvw78X+OBvo3drqR0rOEZHUIWX1v+UNPE+B3djW0EuhF6O4GENQGw2zyoB/HXDvQTtDTfXKsn9m/4WFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5jSVvTfy21nexuFITYTeRJZPViozYwLNoQA6yut0bE=;
 b=p1LexOyjqnbBzq+FoyYzcoSDgywW22IRtWTdyv7SbeHEirH3FL36OYoWH91hMeTsAWdZD9h46MhKKMEgWLLv4yifLXvuFIqvs/oSz9lkYQx7hpze0akQ9VPXE86oYhr5UXLsWOlwEJaOwNTUk+gTh8FMccNMBZmeqOkuWx/DOV7p2bcC1KSEz24CgV5D/X4xbyOpoImkr+YGK++eH3MO6TibTy4yTI8wcIasfVgQJZunSgm93sH2wtcAWcLFHYp5ljDB0kNvePy7dBLTD+xL5Pk9TSSRKftnIaU0fFbSaiCSotj+29Cy+hgogRSWqpJBAo4X4fS+Ya+HWm05MJc0ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 59/61] mmc: uniphier-sd: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:39 +0800
Message-Id: <20230726040041.26267-59-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77260e1e-3cea-48bb-c51f-08db8d8d28d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kS/072Ljm+QuZ3gkGCffYjgIRNrcJ9DcHAz9hpUY8S14vurIsNoYhZOIVoMjx2H/FJmjhH7JoJxtFIiV2/i4MY6LRHIWuvlsqz2ELxyoNHBTwUm24g0Xg6vy0YT7yN/VQiNlU50h1Gbjqsl1EbONEVRdgQWeaDT+lU9PkvkvQBe2j+7sDAU3M7xNfwy7Py3zEe66L79Tw92mNoRYHuUCGs2pkK9MIcFDO7GpSMEJCt0DAqnvbsde4/sC5SsAFAJyI48FbpRF80jVFbe3UAAq8E+9czHmsXe3Jadj2ZfThLIAzUn0x4apw49Xk3CUzIxVg4TdsT1/H2U8XHzdA/vy2pQq0UBg42WNpVpRz7bodnDou2zj+ik0m4OjjNyOZi6/WKyZ2YbyrLHGxd4Oz0opXCk/MUPPNBJRmG9fdpPv2RDOCMJQMVz/KsAUjVeSb9/T/FU4IB4nn+YGVQtS3iLkUfVtKBVpKDUBoqGAdNafGaIxuZERZjTrb2CFvNA9VhMmWGjgvlASjaJuDSqNdERM+99FgxbOPmaaj3+Y4tyimnNDWaQkuA0RQ60udgxiOIQ1g8j98o6J0eaQ7FXtZw7c+X65aTrHtWHaIoMyQK0paB1Xxj6wifssXTsqytYanoX8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NWeTAwK01lcTFpdDFqOC8vOXpoYkhVZThwOWpkNUJuQks1UEQzL0xVd0pH?=
 =?utf-8?B?WWNBQndIencra091eFFIZVVFRXJtQzNHUlllZDhVVXcveU45OS8wV0tGQlRQ?=
 =?utf-8?B?b2x1TzhXMGJObUhLTW0rNzhJTzVFWWkydGRkYUE2dVNacmFXMEJ1ZE1xSUR1?=
 =?utf-8?B?TWRWd1JweTRxZk1NUmFiSmROckZCQmNLenVJbGczMk5naDI0RlBLU1pPYlZY?=
 =?utf-8?B?bW1rSWxycE85cnV1Q0ltaWFDRmZLNFN6OExkQUJEMGwwME5MaXMxMWt5TDVK?=
 =?utf-8?B?WUlqL2l6TldOcVN5dmRibXNtdzJIM2JiamwyYXdvWktyZHlrcFpzNEd3Mkhr?=
 =?utf-8?B?cVJlcHNTQXVBMzFha2hTYXE0NXo1d1JqcXI0S2lRK2YrNEF0azNEVW16ZGtv?=
 =?utf-8?B?WGhWSEVSdHJsNmJwdDBCbXpCaS9UMkNwOVFXbTBmQjZJNE50bEdiRThIVnV4?=
 =?utf-8?B?d0ZLSjR2eGJLRFpjOUVmQmMwdGpsTXZlM1pBbEVBVlVzVGM3bEl1MHV3NXpN?=
 =?utf-8?B?YlZzWmJuN3dzYVNhWDMxMkswM1hScVpOemJSVmFQUUg5V01nK0hWZW5jcFA4?=
 =?utf-8?B?bzRYZFN1Zy9qWHdGUU1FeDhIUGpMVVJIcjlJeHY5dXB1QkNJdGh5R05SK2hh?=
 =?utf-8?B?dHFGNFRlY1hoNThWM1BkSjFOWEI1R1ZFVVAvL045RTJPVFhtUmo4YkcwTHBO?=
 =?utf-8?B?RXkwcUs5WjVWSWFCTXkzNmpWZmgrY0VCdzgrYXVUVE5SYjRab2RwamRCQTJp?=
 =?utf-8?B?SDIzb2E3djc5MmhvTlJxVGl3MlVRcytyMWNNd0I1bTJVTldWQ3kvU2F5RnhF?=
 =?utf-8?B?NUp3Q1VCa0NPNHFzTDFWL0tXOUZIa0gybkxWbzJHNjNpVlZpUjkwc29scUtu?=
 =?utf-8?B?Nm9LNGQxK2ROUTdUUSt0MHNNZ3VZMmZUTWsycDExY0YwcXdhcTI0V1lOUWs0?=
 =?utf-8?B?WGd1WC9kWXdON3puVTh4UFBROGQ4dnBDeG5YSXJRZzN1enBnNmVtM1FrUlhQ?=
 =?utf-8?B?U1JQYzJQR0E5bXBJby9hNFZ6aWZiNXNpelN1d0U0M1k0RCtqV0pOa2hMR0pl?=
 =?utf-8?B?VnE5OWJGU2JNQjhqSU5YVTVOY0Ric3BtWDdEZDhoTHdVTEZSWFArR1NZTHFZ?=
 =?utf-8?B?alJrN0NtWXFkd3p2eHU2anNMeW1QTFNXY3pFMlBmeHhrRVlTRHltSG9hdC9p?=
 =?utf-8?B?SVp2STFuS1AxUGF0Q0JCZ29Ca3Y2TUdHUFI1eGxJUnNzQ1I3WEpsVFc3eENI?=
 =?utf-8?B?cmVqY2JOZ0M2OTBBOTZtcisrbWdXOU9IelFoUC8zV0U2TUJ4UFUyV01BRVFV?=
 =?utf-8?B?Q2E4bjN1KzBHcjhIWU5Jc0Fpc2FHSi92ODZVQlB5bjBGR2Z2WkFZckh2UUJz?=
 =?utf-8?B?dHV6WjV0WXlaSDFDckdHa2pzWndFRGs1ZlVtWFJHdGdCZnVLY2hsOHNLVVdk?=
 =?utf-8?B?d2JvUTRRWGtJUFE3MWdyTjdndGZicnhabVNpWUtZNjA4cUcwbGRQU0NzTGFk?=
 =?utf-8?B?YTNhd2xHb3VUVU9kY2dtTmgwNi9Kc2R1dDJIUVphMEEwTkh5MDgxbkxKNStF?=
 =?utf-8?B?L0xPMUErRzlNOWNyTmFES1h2WHRDVkhFdGNWTUxRTWRoeHV4dFVIbW9Sbmo2?=
 =?utf-8?B?bGU1MXFJY1h6YitHOGRyV3ZxTkIzRGlCOFNzV2d6NUhma0UwTHluNEpuK01D?=
 =?utf-8?B?aXdmd2UwZHVpWUJoZzFicmxYZVNmM3lIbFk5R1lFRkVmTk9zd0RnRmZnZnF0?=
 =?utf-8?B?NDhKQVlQTk5sNTc1VUV0RE5NTGR0K3RkRWxHY0s4UXZ5NWJ6aitkenBOd3E5?=
 =?utf-8?B?SnlWVGJUMXJONFY5YzZpZVFCcms4a0Q4b1IwaUR1R2JXQ2pmOVJSanlyVXR2?=
 =?utf-8?B?alBvZlA1SUFIN0xvZ0RXclVLazkzRHdSRlJiWXVVSE1Wc0x6RDFhV0RDRXBw?=
 =?utf-8?B?TVlxUmMwb3FZVlZOOC95NHFUcTczODhKaDhIWFArNnF4aExSdXVkc3Rhbi9n?=
 =?utf-8?B?cnh2cjJIZnBJeWtXK0Nvb0xqRjM0bXhSZXQzU0t2b1R2a1VWTHpTQWRnNFVH?=
 =?utf-8?B?WVFZVnFYMHM1Qk9HSUwxaXNFbE1sZGJ5R1lOb0I3TmRGdVBBVGp4MktDL0lj?=
 =?utf-8?Q?hlZ0igw1KzA0QHUYnGiVIyao9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77260e1e-3cea-48bb-c51f-08db8d8d28d3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:41.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA9diAx8kMtmcQ4RVlwGZy4aLJ48rKAME1kPN2SBTEr8MC8Me2QwinKFdTF6tNNZpI/03iIK+4s6yyl0veVieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/mmc/host/uniphier-sd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 61acd69fac0e..33a4d1c6ef04 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -727,15 +727,13 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uniphier_sd_remove(struct platform_device *pdev)
+static void uniphier_sd_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
 	tmio_mmc_host_free(host);
-
-	return 0;
 }
 
 static const struct of_device_id uniphier_sd_match[] = {
@@ -757,7 +755,7 @@ MODULE_DEVICE_TABLE(of, uniphier_sd_match);
 
 static struct platform_driver uniphier_sd_driver = {
 	.probe = uniphier_sd_probe,
-	.remove = uniphier_sd_remove,
+	.remove_new = uniphier_sd_remove,
 	.driver = {
 		.name = "uniphier-sd",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

