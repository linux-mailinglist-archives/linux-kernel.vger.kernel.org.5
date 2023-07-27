Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3517764799
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjG0HEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjG0HD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:03:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0D30CD;
        Thu, 27 Jul 2023 00:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU9w8CswZOLv+NIayUbWeV+ITuVFJFuptpIi9EXQG4Iz1YjRXnGAf2alf80M3HudD9WciIK7IRmDtmjbY/PykgPq8JgF+eI9ne49Z7XgwcgF4D/Nd1COtyqpe5ehEdNXkeSCK2MQg+0cUY61pa8nIHTufXCt9ZgAsVK/MKm8mfUq7F3G9tszki/sP8+DMhwA3uJGfY0ZGH2qxuh2tPX6ircJvjwhaPaLIPpxbs0vx1ANrlWHrQrB3+06ZMnM67cXCQOWnnxsyYpBQp141O7nCsEVPlzIzPh4HgLKVim+zpoZr+UZii2zUZrDlEISbCFA4FTb0QxvDKqTBNqv4jWn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTCEmJzZRC/a6SHh4C2nbpGEXcRFJ6SVNGbm/AwkaN0=;
 b=Kfu9VKKUKUJQwFbvihCHRIej4xPqQ13yTsu11eDCFC7YItQTW5hqWEMlh//rdXWPso64I5xZY7duw0uT6EaPmLhIWMI6ad6xDXIhwnr3z0U5BswnPRAd7DBgkSk2TbKxpGT9lz+toX0OxufGJQtRXZNS9uohdpJYqHm5s19wmgl9XRROeWLgvCaRiE9wYUzoZiPnYnwYJPJk/uSKDQdptIRymks96bFEc3tJqPsZXWN8ukuykZgjaqQr+4xsA5MhFIKWKGvjsH/J6X+CezJ4TY3zGNDtYc2XPW2C/J1l1Bp4puH1DLzaXXF+TzV6ALEyQ0RlABdIXq3zgD8Nel7blQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTCEmJzZRC/a6SHh4C2nbpGEXcRFJ6SVNGbm/AwkaN0=;
 b=ReVjkWZjMTv4Z0U0aR8zmGIyvSVu8jHc2V3POb/fhEX5fSpvkzaeemiZjLFUoR8aQ9uewQTBAQCqGiKaPHk6xvIUffzn3C6yPL6XJ5Mf0GH8TK9zuI4q09Tzfm0ANphzzwnZn+H2ar0dIeFnVQ/XFY/Z3a/aa3LMT7GKCyW+n76MnXDFZqGCH14+KSB048KJUm90vGBX7+hgl5Xkse+S32s5i5a/Lrr109EDYXhEQEdy91h58xUcy2j+UjSowotIT1VMnRoex0mvoAVWC2ZeXokQbTeGXT/Je4wrtBSUXgGrTKI1mfXQYs3ahz8quoBMGz5rjgsp6QpId9MTdD98Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/62] mmc: meson-gx: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:08 +0800
Message-Id: <20230727070051.17778-19-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b45d1d8d-42b2-4a97-118a-08db8e6f4fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85bdBFipXxlgLKe7q09VQn91rhXt1lWOFnHfKMqVc1RSWBz3v97ar4725j66zKIdoV+bs3oV+adS4g+rBHr3BI6Vto8vEBr3Z/29HpABVqxMAsQhl4GlprYQWPtpA9qbUHgG78u5y0cPpo0Bt+IPH1x4qG0lylXMspCJ15VGk0O6xF3+AiaJpqgvVAXR2YZE0kLvZ0Jlbj5PjFtswZwQqjzddIajcbzJlchbyhdUxcnh6QrXI+gAGeY4hmQ5NFfO/9IxUdO/91IDAQ0c+PWYoQ1C0aTp/Mu/hXpnUTHK8DDW0POv45mA05DdACy0f+IV41xLFBZA/B+c81BrK/qiKLp2gIma18kJvPL9UaqwJI2ze8bUOs9q3M089gzYHgUA//eCxb/JEO11EeiDWW2wZewd0qnpJ1bKDktg77khvyhk1o1dYKqtcf/A2m6VXEZuNzCDF0pvjGMeVeiXI4Hvolf+15DcASy/dZ+H2iXmq7MsJu4e6UiCO4S5OO/gl1r1gpH6FAzBhYYwLzZ2f75MrDeMn8+2D3CUS4r/7gF4me1QA4HpH7xgWn27HoFyOruDtxtRgZyDk8Ab2IjpDJboQxDf7xLGtnECsp3XqqHItAAWJ3udhzLhAziut+u8iMFZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(7416002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpqUGhKd00wMGVEclNudFQ2NDl6R1ZERTgrZWhDUU8rdkRjMlVUVS9lVG0w?=
 =?utf-8?B?RlIvSndXbEpEVzh4WTNiR3orSWJodUY2aDFjVm5PS1JzbEhEK2gzblRGU3dl?=
 =?utf-8?B?NC9aZmpXOEwwQWRVNmpMVTkrYnhDRjkxYXA0UHkzUlpMd3J5L1R5NUdQNEJJ?=
 =?utf-8?B?WUQ2VDVqY1Y2SG1VQzEyTHZWK2llUncweXZnT1BXSUEyWldIVThSL2txSlFV?=
 =?utf-8?B?dXNpSHNreU80UUQxRWE0T1lIN1lUenprUmkxcXZmLzJGd25IMEhXRFNESFFN?=
 =?utf-8?B?SVRPVUxyb0ZGZ0xFMUFUVUxNakJxZ0hhVHNvamgzUTQrVGJrbThXaGdnMjg4?=
 =?utf-8?B?TVhrYU1sb2hkL1ZrMTFpUjAwNEN6SkljcjNZcFRPVTQ4eXpuWFIwUXFac2lq?=
 =?utf-8?B?SnhtQTJDam5vS2U1MHExblhwdG4reWhzdVFBS0hGVi9DT1dmd3k5SHlGTWV6?=
 =?utf-8?B?T1FQTm1rT2hGTEdWbzlJMkQ4V3VxWHBQUXNnODg0NVI2Q0JUUDlqWUZkMHNw?=
 =?utf-8?B?RXJyc1Q0VTB5QkxjQnVOVkd3M2ZaRGFjSUVmR3dKclVzZGR1MVJSRnNZbTcy?=
 =?utf-8?B?M0hBVldZekE0clhEcm5hWGl2a1VRdGg5ek5ucmJvZUwvKy9TektpZks0Zjk2?=
 =?utf-8?B?RXlNTGtuMUFjaElBYXFYYnB0UVdGdzQ0VmdIbTE2bkpYczhQUlkzZksrcmg0?=
 =?utf-8?B?cnhrTWNXV3A0YTQxOFpIY0lPSmFNSEVjZkFtV2lERVp1YVNNM20xdngwN3g5?=
 =?utf-8?B?UllEOWFXOVF3VmJLZ0xhV0ZqQ2ovdk91N096YXJocTFmTDZ0TCthcXBWQThU?=
 =?utf-8?B?TmRtK09lK0I2U1FyNG4xTjI1NGRWUEdXSGdVNWh6VXpVOXVUcWpYbjZjMnYy?=
 =?utf-8?B?YlF0MXBQNThPVEhxOG5xQkhKUlVhczBOaERBbm0yOGxwVWVRRm83WmRBam16?=
 =?utf-8?B?Zk1sS1hRUVlUY2NEVHFzWE9qcm5wclYyaWNlcEhyY1dYQmY4Zjc0Szk2TWtO?=
 =?utf-8?B?Z2NrelBRZWJzVkFxMDBQUDh0Z3Fua0JrWDVZYTZyOHlqc2hhajc3Ym1Nazk5?=
 =?utf-8?B?SnhwTDM1QWhDMkhEZmJyVUl0QjdLc0RLR0ptaVU3RGlyY1plME5UYkkreU1H?=
 =?utf-8?B?NU5EYXJDaEFUYldVazZLaTF4RGdCczFJTGxsUXpUOG9UVFZnekNOZkU2ZVVJ?=
 =?utf-8?B?Q3ViVExEaDZZc01uQlZqWTlEcGRMUmVUTU9BT1lCbDlINHkrb3RCY0Q4Q2Np?=
 =?utf-8?B?aXNDakxMazF0WDdldGNwc0wwRC9ZMzJqQWFOR0RGZ0k2THZlbUUxSEtyR1hZ?=
 =?utf-8?B?WFpERzV5eTlZbjdBaEFsL3ZmNjcyeVNzd3ZZb0lLT1k5L1YwUW1LV1pIWUor?=
 =?utf-8?B?TGxydktkdFFTSHBPbW9EY21EamN4MkRTV0pIdjE1ZTJISEtpbDJWN1JjZ216?=
 =?utf-8?B?NlhrRVY5S0hWRGxiSUg2NlkvSlA3aXk3aHFOeFRpQVVVRjJKT0JUSWpLWVVt?=
 =?utf-8?B?MDBaSG1Cc2FHamJkUFRZZ0lMaW9melZnKzBZblBHMk9OYlZQaXh4cTJmek5S?=
 =?utf-8?B?bGtoZ3djaG8ySC9TbEJuZDRZSEUrdFZNQkZjOVBhSE10c1RaZGVVb2VXckVH?=
 =?utf-8?B?VGJEWEdYbTc1eG1WNTVYQXZIaDBNVmd0b25qOURHdDZKQW1PbXJkK3QxMmNS?=
 =?utf-8?B?RGFjSzUrbFVtK0xsZElGS2hCL0RvRVd6a0wveEhKRzBBVDkzcS96bjQwV1FZ?=
 =?utf-8?B?V3RQTUx4U3R5YVROdjM5bnhjUzh4TUkzeXZlNFptSjNUdHZMU1YyZG9jSml3?=
 =?utf-8?B?Zit4VXhmdjFUN1JXNDVXZUhOenZ1T2xCUTQ4RC9TRzFjSU5lVE1iazY3eXc4?=
 =?utf-8?B?eWpMWE0zZnhmS20vaGtvK2dpeUNUY20waGgzY3YwZGRxOTllS2ZZcDc2aGpW?=
 =?utf-8?B?SGtrNmJ3RFBoeS9JODRQL294WTBXOWQ4OWkrTk10VFdubGtETStBMVEzUmM5?=
 =?utf-8?B?aDFDUFZ4MUplcXloaFFLdEhaYUJJdlAxS1JUUEVieUlJTGVvaFZLbWRXMDF3?=
 =?utf-8?B?Y0VrUk9RRVNlTmMzbml5RXZSY2JrOXhQaEZGa2xjN1dBZ09uT2FFTFFPUS83?=
 =?utf-8?Q?heUzSlUy2tuJrV+26IQz1rf3s?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d1d8d-42b2-4a97-118a-08db8e6f4fa4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:33.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrVm4GwDhCOIG/TevFu+MkR/Y4kSRrudbHSOqReu5P3Z8wicv/3fj9vWFgt5X3aggvdUcUNxOdQ24WTZyTkV6Q==
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
 drivers/mmc/host/meson-gx-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d652374f37b2..a2601d0ece71 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1294,7 +1294,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_mmc_remove(struct platform_device *pdev)
+static void meson_mmc_remove(struct platform_device *pdev)
 {
 	struct meson_host *host = dev_get_drvdata(&pdev->dev);
 
@@ -1305,8 +1305,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	free_irq(host->irq, host);
 
 	clk_disable_unprepare(host->mmc_clk);
-
-	return 0;
 }
 
 static const struct meson_mmc_data meson_gx_data = {
@@ -1337,7 +1335,7 @@ MODULE_DEVICE_TABLE(of, meson_mmc_of_match);
 
 static struct platform_driver meson_mmc_driver = {
 	.probe		= meson_mmc_probe,
-	.remove		= meson_mmc_remove,
+	.remove_new	= meson_mmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

