Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED376479D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjG0HEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjG0HDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:03:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E18E30DF;
        Thu, 27 Jul 2023 00:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El5GI/FID4kj13Lqs37Mvf8hdiXhowWrjHmbvK3ibwFnGHBsSETzZ3mRKqaYWknZwTnLRFkvMpCEko2ssU4+0qoyRIrh9f1FsjoBLfzyAjoxHjPTUMU2/j7Wp9geSCwZDcHfy4EHyvbnmKPDMZSXWIN8p/xpQR3BjnIBWESpY+kwr42csJNRkRtR8DB/XcdB9xV6M75XQkWWov1NXuRDPYUuuThOYvx0g4BSnslPGiiWBrwHuHZWKy/CClSlYdBB8sPbctZYDVgHTJhNlThIfH6PsVSs8MeLJNS6U4lBvx40uGZTIGxivkvgXxC0+GpyA69YjwATCiE0lF1Wu06Rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwbBGaxbfpdU7ahifnwy37RYBYAlU62pqhLf97cjF/M=;
 b=lzcELnG9he/7mNylmxp2wmDugoIjVtsrBZxVB7oERMnY0HBFI5zpPmZW7h4SkVhhicCBJDoVJb4X4rl38nD4kXForciv0MaShS6qf3wDRJQkIdxdINiNScHUHfRc1dCLiPbcMFbE2MvNgxBfRQYTBZvEv0i0Kewe3bXxbWue+SQ8vuwblr66SHHGLPcL/0T7quG8ufqAn6mExh5H4+7o9bAPG38unzY+uB4EP9AOxGS6iixJluPMXkMlKn2N8ouJOHjnWAI5jberrWy6gTMMeyyogO0u1nFuidiiXfXTGJD0eiEHD9eggEjJOpxVYc67AKn+xu8BEkYiVQTidOyucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwbBGaxbfpdU7ahifnwy37RYBYAlU62pqhLf97cjF/M=;
 b=YnWL/TYB2On/rht9+tfrIsLdY/HiRqlOz8MbhgsWu5HQh89MfDLu+Gan8OYTstTOF8G2Ja4AZCO+jCqkn+HYqrTLb2seTsB2gKmTiBqH2mJYJKw4IUeBt5lqDPGK/FUPl9yyWVLE19lPEK1mr3ew/gA4imEXoyKDGWv3fNekHLemzrqi+fxCpubdHsdoIC2Z7hl2rldpxoIk4ZetCHg/b67h81eUcGJIEtnRRCClqqPyMC05HUp18yKR1JEbBJOXtwWx1nwZw0gE9vnXDx7JBmf53TPISsGvxUfa+iVWlVY5GrhHacHeWIQ8jLD0WGpnesMrpcX8ZjlWnRhBI56O2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andi Shyti <andi.shyti@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/62] mmc: sdhci-s3c: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:10 +0800
Message-Id: <20230727070051.17778-21-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8a5957d9-1f5e-429f-7df9-08db8e6f51b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya2dLncvJs0eWmm2AK7SbhpT93Vk23AZuvnI+BwuSloLOqxsGZpEbWiPYYcJDCRujU6gWCZvVsBq5A25sCP1ua+OWcvfUlLlOpLnmqUbDgMK/ZlXD7tJtpK2+VAHv9ENYLhRZ5ALdFpTwbl0uhCQK5HcIhVurMymrgPvFejyZdWtHMYbm7OfLfnwJeuH+OfU0hfghEcNAz9aEI7zPzoOxNtWIcQX9CTyl4BvT2s/TzzuxM2UiFwr250bxhB4jE668356m3HYKqvNgVb7+aOdxcTBoJIdVkt4uoc8D33WfkYm+TP+Jv/vnqBZLycXlbwSr4ibdZ9mtbdsuWCHJdiibhCu1hdOzTMtbLnzZDXltysvDQMjrF7NDiqwednK0F28560bU6d0E0tN6Ck16IRDCqfNwGa8jmNhNT7lnGBNHrL+ts/br7WQk+69YbdQXwq5stGbqRD/XFyYz/Si0NpI/4+cU0o0GWcx1bPbPahIGECKP0s/+Xz1OsDpv9R3fW6GePYlKSKg0bXXbWsrpwBMqknHTbEPuhKwU69Qi7RhFYikb5dfM6117WjlT8F0YjKcwccb781ErlGzg8FbkSXZeHAfQQRrTihRgqZeMKJ+9AlPG5KZuHObRg7GUlZl4/W4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpHb2pVZHVhemJFOG14bGs2Wk1jZkNXK2wwRi9oYnhIUkx6RWplNHRRSzlT?=
 =?utf-8?B?ZzFoM3BuQWJ3c2lWR1l4ZTUweENkOXJvM2tKVC8yRWZhcENXNFJHbjhLRmZ2?=
 =?utf-8?B?czNPalE1RFY1aldNMUN3ZXY4QzMxVHlIa05LVzk4dk91NExYVjRIRVNrUlB3?=
 =?utf-8?B?ZVVtaHJMNWJYWENqRGQxL2NBbUlHelEyUUlvTWVYaDNCa2lhUjVSKzBxTTRu?=
 =?utf-8?B?NU1vVDNUVlpQS1Z4UEpJY29iaEU5aG1zUStnZm1PdXBNckk1OWl0TlZmeFRX?=
 =?utf-8?B?OXI4K3dvUms1TEtxTGxlb0ZEODlQSWxQd3ZmQSs4M21Sb0tZWmdLeW5pVGIw?=
 =?utf-8?B?dGl4aDc2WVhDeitCTGxJUnlLNHFMckVkR1dyck4wL3g3bWRaVWlpb2pUWEJU?=
 =?utf-8?B?QTBHRDJ0UHZUWGNLa2hMSUR1Q09XN0dFckdFOHVBNytRT0kwZnFKT0ZsK3Fk?=
 =?utf-8?B?VkoyeEhoMWs4QSt1bjY3SWwrQTg1SnExTjRhRGJLVTJaME1QS2dlT2w5QXdu?=
 =?utf-8?B?dmlkVzFXR0NQTVp6YzI4SmxRcDR4aFlUc1R4TklhQ2NKMkVhTWFONzB2SVA5?=
 =?utf-8?B?N0ZQbkY4NFppcXE0T25rMGI0LzhZaXhtRGRhUm8rMmMrRjVYY0srNlFtcnY5?=
 =?utf-8?B?MHVxNklBR1dyVDJrS0tWRHovVXk4ZE8zYXo0Vm5JcW1PR1F1cnVISGxOOHNK?=
 =?utf-8?B?d1hwMjdxOU52L0tvaTFNbTA2emhzeXdwd3pVQWYzUUpkVlZQaE0zeU1XQ3cx?=
 =?utf-8?B?WjVVL1RERjIxS0JFcTVXQzJJdVl0YmJVUGNPNzFLcGNZT2FPSkJNZmZDVzRW?=
 =?utf-8?B?cFFhNnAwRndvdXVnUEMwcSt2cTFpK1FKdDdUK1dIRE1JQnJGbUZJZzBLck1m?=
 =?utf-8?B?L3NSTVJobHJUcm5GN2RLNk1VeFZoQ3FzbmtZMkhjVTZxRkplVUdWU3hPcXFZ?=
 =?utf-8?B?U0pBR3hiaVY0WHBCeVQxU1hQVXZON0pIMzB6eEdlVEtwbUZqSStvWTY0VjB2?=
 =?utf-8?B?emFxYkp6anptR2htUjl4VGZmbUpWTHFxMDlqMEtuS0k1VW1XZVd6cUFpTW9v?=
 =?utf-8?B?WUJXR2VnQ0p5ellhVnNuZ2ZlMFJyWWdsVWQ2bTdyejh0cFRKaFIyZVVSYUhn?=
 =?utf-8?B?QXVjMmNRQkkxZ2IrenFXN1I5aUJOMXlpWkM1bVVRT3RZZHJ2Y2p4SzRkN1FB?=
 =?utf-8?B?TUMzNjljdFFIbCtrWUV5bHhCSGVhS3B2eWRFWm9tMWRoQ0pZc0hRb25GcE9X?=
 =?utf-8?B?TjArUmdtaGxsZFlUU2E0QlhtYzRoV2pCZHRBeTd3cEx4VDc0c2hvMnluT0tX?=
 =?utf-8?B?TjZkaVc5VHE3STYya1p3ckcrMnVQQkhwNGlob3FkV2Z1c0tMRmxwclgyRXlP?=
 =?utf-8?B?ckhxcCtuQStrN2tsK1N0MDdFRmgwTzdybm5PY1JGR3loSks5NUk1RHIvenc0?=
 =?utf-8?B?eE1EUUt5bkJSTmlhOHRFdzhDSjc3cEcxQkdudndhblJCSU1SakdNUmhJb2VF?=
 =?utf-8?B?UGRWQkNIR09HNmxYV0JUa2VZaHh2My8vbmZtd2lKcEdEY3puQVJQUHZ4YTVF?=
 =?utf-8?B?WStVRWlOSjB0d3BGS054REZHMUI4dWxIRnFWeVkySlBicVhNVzVZTVQwWFJh?=
 =?utf-8?B?dXpVa2t6UHpIR2xrVTd3Zkxqemdpd0VlZnYvMHc0Z1k0NWNkaVNNdldkVDBr?=
 =?utf-8?B?blRxdFRtSmpEV1BlYjVvTGdWTjlSYi9lUGNMeGI4LzhoVnVKOEtQU3l3ZW9Q?=
 =?utf-8?B?aGFOUkRJQnRMNVBLL2JSWVRpR3VyZXczaWl4cVNBcDRhMno4MHdIL0ppQjZC?=
 =?utf-8?B?RUVuaVJMM3JJMWp2YUhEc3hzNjlzRUJIaEh5TVNTZVg1VWR1WnluVjJkMG1h?=
 =?utf-8?B?cTZVVXlhWnZDOFJhaG9vekJheTllak5BeGRndWM0Wm45Y2hMUUlVejRMWUNI?=
 =?utf-8?B?MEJKVjFkb0ZLMGREcVkvUTRvVStVdm1SeW1tM0lnWW55LzdVQW1KVmk0QjdP?=
 =?utf-8?B?ZjhsWTRUeXp1ei8yWkRNY09idHJvL21qQVNLNXI4V21JMmVyRUZPckdaOE5M?=
 =?utf-8?B?OEs3UFNZNEdudkJvZE4zWFRHWWRKUFc1Y2trajBoZ1RmY1pVbWxlRC9XNkxR?=
 =?utf-8?Q?5fsh65ALHfhITlv/RWnerWmIW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5957d9-1f5e-429f-7df9-08db8e6f51b0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:36.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tteKqgKH7X7tIiNEa4vTYfbcyU83SIu+5k4JYYh4/KlWYxkB2z/kIwcCphXd57a7PZK5N0rMai/sLmMUBgvjBA==
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
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/mmc/host/sdhci-s3c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 504015e84308..b61f12d328e0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -668,7 +668,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_s3c_remove(struct platform_device *pdev)
+static void sdhci_s3c_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
@@ -688,8 +688,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sc->clk_io);
 
 	sdhci_free_host(host);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -776,7 +774,7 @@ MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
 
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
-	.remove		= sdhci_s3c_remove,
+	.remove_new	= sdhci_s3c_remove,
 	.id_table	= sdhci_s3c_driver_ids,
 	.driver		= {
 		.name	= "s3c-sdhci",
-- 
2.39.0

