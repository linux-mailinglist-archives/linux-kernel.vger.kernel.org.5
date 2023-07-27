Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2E76477F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjG0HCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjG0HBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292EC26A0;
        Thu, 27 Jul 2023 00:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVfW2sr3IwycqqKat5ZV5NY0b+4QqsFvrySu/LDu9Vi5eHBWM53vjyR0t2uqwWOeB3c+FeMqgC7vkATjsinHPui0p0uqTS4Z30Fpj/kIKJcZW85io1O6+Db2o/bE4TduAjwmRjRyHXQ1GuLhXytCWLmAg6fonPRycsh/cKxfzrlwDvQukYI6YIo6UhkWa4u+qCVzw6bd6kUJAseanPLj2lNIkJ9R0fahwcLEWTILqcqSGNgfplCczq5WfgG2TbYLc1ybPSBPkcpfD51Hd/HLNKQq2A4E9OuBUXQIDA3Eu2LcodOSxkgnxiezqpUMXjWlQI7+nVvPRQx7Kh+NwGnPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEbCcoNdzo8jW2C3o99v+KZXBqHVRnLu+pxztFMKspQ=;
 b=l0aEWHfkjsmIDp3mnT82JX2fcsxoriOqkVG6QY+lhp1NRlG7ROfIOQYXFeH71Z8dXJ3QdIffj+XViY2yv8VKtLpZmNWu+KOUYteC2lMcJzZPXnXlBKjlLFi5r2MR6SDxNCS3ig0tQ0i6W8R3OrwOSL/ut80ZyPZGmEexjgorN0dNcLJCu5UdjqOPrfqYMKfZTeduYjUJMx/gPtd7w3r0hJ3XBRRD18oqXSfUnsuWgOsd9ZM1C1ysCC9Abc/AGpSV8mPr9v0paEux2k6X6sSRGrcreC05ix95JJEr2qBYf4DZVqmaM6ttcQfnvyoQmkSLNoPCgMBmrHoZVDjz4OgOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEbCcoNdzo8jW2C3o99v+KZXBqHVRnLu+pxztFMKspQ=;
 b=GPnQh9Kj/aJI8+EnY0UJGk0tGM0ewglZsdnmJix4XfwrScOBIDNukynsVw7OEHFKOxH3c8Mja4cPKAN4LQQHNQH2AfOKcZNPfwyq3f2FDmveJIrz1AxiIoyzLPSUFh8Qz+r5AbwSnN6ayBIE+HtGtDPid/nEd7x+rYK3cl9VgoywqolfqIdZlV/0WSV/zFY/NGjZxbOTZVfgJ2qn/gpsMM+v6DRLVCPP5pz+TWpYXVnAJmZI2yEUW1kI4en/HyPFUrskqYz4aYYyBDL19rqyr5YkehUrx0bUoy1jereLZT1BP/rnwe8zsD5U2kxeRu9YPIgcHRunpRYFlhSSrXYDgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/62] mmc: sdhci-pic32: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:58 +0800
Message-Id: <20230727070051.17778-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c6bef073-633f-4054-eaf8-08db8e6f45c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeaDDFbW71kzryDpyvJKg//LPhFcSgFzmIuPUUWXvCiE038qOiqDOZ7oA6q2kTclGI7sWpjyfUT2gp2BIEdJUxYCSSQ1RIjpGvgexCT0WyZnZeJipzedANzWpeQyDp0UNeBWU7gcqM04UEeKH6p8F3cDhy0nHmQP2U3ccDsRNsF8glgSYoWd/YeZH4d85CzsbOc72klvLENGqLD2gSMtN27KY3YF2FuGKytSIBW8ngsfr4IywNBdfT5V1kbjYEKd82ODFknO14tvG37bKEQGCZmdCDzf6GAYpYfJWLS6Kzom0Uq1k4qA/wvQ5d33GItF4NaACBpuVWFjp0l9hDcweSz69gTxsPLr1BV6zs3svQUqdXe4+Jr18hEpnMM6lXSin1Zw0iAhyd53hIjuxHs2y6BWjZzTN1kA+fAIgUymhIC/vWLZv7YyzVAfxewJ6HRW9qHU/EDpLC0VQkaQR9FcOLOXMcNX8Zglst8WLrB4+wudBC34/YdDliJj90L+A0GqbZuO+RFaW9nGzR1EDvz1ShCkGDzt8b6yXCEd4a4qHCj2lOCJOHrHj0PRtV9BQwY5RBUtThgxtjR6Lw0lZTNZw4Zd2gzzvylkHzaodAuPFCHEG/5y9ZaAd6YLOb0JcJbP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNXK3c4VGN2NGllWTkwMGdVL0g1bENNYTBGUUxyUVdaUWhpOHpacFp6Y1RS?=
 =?utf-8?B?a0ROMXhhT0dSa2srclVYeG5TZFk2eFRDZkhKL0UvNWQrUHc3RDZaemFXSEVE?=
 =?utf-8?B?NFNObmxwWlJkcnpZOFUyRkgxaFA3TlowcHpPVEttN3ljeXQyYWQwZyt0Q1lV?=
 =?utf-8?B?NStnOXlJVEk1M0dtdXUxYjlMVkwzaUFlOGFpekMrV3FXRE9Oa2p3M2NCeHln?=
 =?utf-8?B?Tyt5UmFCVkpPMWk5UTRLWUR3aFVxTWh4ZU51blMzdzNYWnV6T1JkbVd3ZER2?=
 =?utf-8?B?NkdpaE9tVkUvN21pWDdXRXFwK1oxanJBazFQaGQzT1N0YTJ4M09kR2tHZWFC?=
 =?utf-8?B?VnNxcjdtNEluT1JVY09ZU3JYQnozeEx6KysrdkFFVUdydEVNN243aVFXaExX?=
 =?utf-8?B?dmU0ckt3dGgwN2ZIZk5GZFgvbmRlWmw3aVhPZDkvZWNGVE5GK2ZqeFlYblE5?=
 =?utf-8?B?MGNZMkxkR3lwREVvRmJGcERkUUNkUjAzdkt2bndZbmNiY00xT2ZJZ2dUeFVG?=
 =?utf-8?B?dzIzaGhHM3pjQjFQVUJLcFBuK0p1bXpHemhTRlVkdWZTeFVCVTBKZGpuT3hD?=
 =?utf-8?B?VzY4Q3VGREZuUkhwZWNYOTFucFQwOGNFMURFMGV0OW9aZ3ZTYVdnZnRnSUNO?=
 =?utf-8?B?Z255VmZ0blZyWDNwUVJwZG5jSlZwWXQwTjZVTjlHbGxES0MrdC93d3NmT2NG?=
 =?utf-8?B?djBnNEJsdmVMSUZWTmdVaTdsditEb0FtWWhrWFRyYnRLNm1jZzVrYWp4N3M2?=
 =?utf-8?B?QVFNSmY0aU1xemNtME01MVFJVSs3cXgrRk1XbGR3QnJBeG9LT3FWWTM2b1hT?=
 =?utf-8?B?UTZiM2Z5TXNoeUQxeHNLWS9TR0NLblJrem1ZbG1xRzl1K0t4Z2xncTg0Ni9v?=
 =?utf-8?B?citGbXZpMTlWMEVvYTArQ1lQMGZCTlYvVGQxK29YZWZ2c29xVTRHbTE2a29k?=
 =?utf-8?B?MWk4OWRkZFNnNnFyUXdZcnNmSEl4aDlIVDhuMmdlQUc3eTJRSW9maEZKYXg5?=
 =?utf-8?B?d1NmbEpWZFNTSm1qSWliaTMxeWVJeDZNUVdlcHhWRE44MHdNaU1lR0lwdFFF?=
 =?utf-8?B?VU81aEhYeVcrOG1Vd1IyTWwvWnhiRHhwOFg0eTA3UHZtZ2JxZ052VkFXTVpM?=
 =?utf-8?B?NGJiZDVuWStjODZ4STh0bER2U3V5dE5OSG4yeVFwUzdadDlZOTBtR296QXU3?=
 =?utf-8?B?enFwU1gzRTljMSsrdGNlNTFHSDJCb2NCWlhyOUZJaERwY2YvZy9BUTFuMlRR?=
 =?utf-8?B?NjRkZHpmckExeGJhQmdxRE5RN0wveVJFYi84eUtLQ1V1YjlaQXh0T1lTcFox?=
 =?utf-8?B?Szh1SmJseEowRUs0ZVFOdXlJTVpvalJXTVdIQmR3a0MydE9YUnEyeW5sT1Zz?=
 =?utf-8?B?L2pMclJiVGlhdmNKSCtBRHhxbDBZYll4OWtpZ2oybVVjUklVakk1SUFuVXp6?=
 =?utf-8?B?V3hIS2F3SStUODNhTHFmNmxBS3E3ME1Kd05RS2ZJdm5SZVVLUWJicXdPUWdr?=
 =?utf-8?B?cHhvYVZUZDk0Y3lUN24xbHRQbk44S1pSS1dnS0JicHJHTzlQWlQ5Vlp1czJR?=
 =?utf-8?B?OTlTdG1GeEFpU2hlcndQbTRlaGlYU3k4UnBIMGZ1WCt5Z21ZSFIwT1JGWS95?=
 =?utf-8?B?MmdxYWU0Q0FzQ2UrdktBOVdXeXExbnBnNHdtUmV5R1YrTWIxK2ZYQmtkeWh6?=
 =?utf-8?B?NXhMcDRDZlhjRFMxc1ZCejUyVFNZNE1aeTM4MnZNSkptMnNaQ2JDN1p5Vit3?=
 =?utf-8?B?cVlMcUFWdmwyK0RsRFRwYWFEUWpVNHhDL0ZBZExEdkR2TWxMNnNET1drY0tk?=
 =?utf-8?B?bnJ2N0VjNmw0WDhuNmRDamkrWXJLTG84ZTk2NUhBZ3U5TGMwUmdhSjFITG5w?=
 =?utf-8?B?bUEycTNYVTVYcExxQm9laUhKWitJWEI5N1NnOXZFM2hJMEczYWt2ZmpWZ1VV?=
 =?utf-8?B?Y3NReDVzYVhEYzd5NEhxS2tSNVdwd2o1ZkRqaDVJM0pJU3R4VXBORUM2UWdh?=
 =?utf-8?B?bEQrUzc3dmFiL0tYL3RxMnlzTUhxTWRxV2RxSmxhQVIxeksyTkxWUjAwRkVK?=
 =?utf-8?B?Y2VrdjFtZDNRaUJSSDBrd2M4a1l5eU9jYWY2bm1xZVRYc3ZjR0YyOUUvOFFC?=
 =?utf-8?Q?kZHu9hL0rLfaNX+PcEsF2rt3m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bef073-633f-4054-eaf8-08db8e6f45c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:16.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4ij6G1mFklyrK0VQtykPsstzP5Sg7AwpxysH9jn30xzBrPxxEb/Uq05mOSYYmxLrL9CmhkzgNBqNtFBHUyNKQ==
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

