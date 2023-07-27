Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E27647DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjG0HI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjG0HHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:07:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20725.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC37C468B;
        Thu, 27 Jul 2023 00:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0VC2JSKZMuMeKx/F6NU++nG214tV5/zro1CnIm7dL2OU8/kdJq/wIs9J5vafHVTw4VU5bwH7CnNfiLXCAmcHMnYSZOX72zmYYOFoMZZg+TcyP1DD7rJSAeg8L9iXuUUtXwn9PmEMaHk+ITCT+bUZZPZ0Nrk2OORv5dcp51cLseSjM2wa0b25nn6HUJQ6kLWuuoQVk91jCW16JXZe+z0/RvZGEWjCo8jZ240pzBvF6z/T3Feng8t3JU+uwQa+9YLajB4bwS0h1BpwCKfTxlApwFqvPdFuSGoXvzgKIDJWbo+9l/bj83WlnI+lPVxkVhQcbxzPaE1vc72l2Ch+TgBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi3BsQ5K6HMVxVVaKmclXYMikJ6itGQu0ZOMQX+rjdE=;
 b=aQIKWjyznAFrZJ1F1kavvTH4qrOpRnjskoRk42lUdiRovGiHSYIuDpAtBItewX870b0Jc4PSXQo3o/hDayEqlQluneYQ7P3yeImH1dnQOACMz3fJIN9BhbKK4XtNQeBM/5keLu7WNuPCLoP0RJwF+oZRzItpmSDbcuORKxXrCzwsBoietxBttyXzG9/YBS/8phAdlHOXz5I2G5h0EZdIIXRqxd6Yr0mbtYH8tndQCxCg0JU2UtBTejzuIzvA/0q+StLyH071lN5z93S8WWRfXbmTUYecICfdoS6QXWD53KooUtbwI0v+7SUrA55nJhlc4u64ueKkQ82TwctrkjsC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi3BsQ5K6HMVxVVaKmclXYMikJ6itGQu0ZOMQX+rjdE=;
 b=S+kUvWkgsUcfQBimio+7thiVFGCBtNRZaJvKOZFFTxzv+Nh3sHDnOs3+EQlY3CHL9NrGjWvAVz1Y5/b6sLcmWAlCsgzId5vN+LRR8JaSwYRoPq5fLgmAdaE9WkrxK5CiTl5rW+jx/gWsIv4Pa1Ed0xZwff8J1uUP67IG0BMR+KMc6qr2ftQNv5opMHWUWgGg1K07kZRmwMewZDQ5QkpVQC4kG4je5kuvAGtxBw0/XnoFGcQcjaOM9DnFPuWDg9aZMrevBvzEwsr7btDag01H7neSkKiMYLjCzKsEZL0e4NavNIoGbVmnwf653ikLp6vZ0HcFfRzn/DGFU3ACgWvB1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 48/62] mmc: sdhci-esdhc-mcf: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:37 +0800
Message-Id: <20230727070051.17778-48-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a6310f-b0f6-482f-c96a-08db8e6f6db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZJNecrEJYWQ+v0H+c9ZEG3vuaV60lIPxCfPe9DwVgox4nHSpDu3cQdgqWV9BFTCIQgkpHGVyxj3eNf3/7IQsIAkLdjQB5aLC8qcxhTD15bRAwDvojbEwFFkGrvfpAEoGuJI5XxfP/3H8dQw3bp42iBuGKBLKbwL+GjCkqUiqnkVZsi9rdqPy4NPJih6VVIWyIuI6/WHtHzcrFFzBSFB1qqfxgau0dyxfnPrfzkDhAx/BecEMXRStyQxTcW+pTj5+wKC/385xsgzXdZklvMuEPNcujxvSqVmkqbxgVu41Qakh1XuWPiDB9npmiIRY9Z0GCJa9ZiUk2It0BE3G5TkvDgm4GKSypxRV5XgimIB9OsCGqR/b+wXU+qKW1uDZ11EtqwIHPYgtrCtA0rYhOUrWWOq9epIGzb6Acw2saG4gUHqEJRvmOFNrbr/5TvdO1TnK9HIN+au8ZMrVzrldX0oZzh2wWzgrI0V2W8Omq5FmwLxAEZpSLe+xrkAEoR8ObPvfTjcDLRKS0SsrLSmgvsOM+rUs1zbYXG1lPeKxEc0HPNo9+ruyGqaQAsf8sAXR/3xJEQ4u0A3T6pJxhO9eVzjnspVtBnz1flq18y0JxamUxEq2Pqr40WZzSj42je8SSBs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6666004)(110136005)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdLZUQzZldwc3dxaDBpdnY4OTVhWHlzVGdVTW5ZNzh0dUxERGxxdXdjZDd1?=
 =?utf-8?B?VFJJa2ZBNjQxeGl6MERReGozN281Y2M1TllNODd3VmZ3eDFiRGxWbGxOUWZ5?=
 =?utf-8?B?c2xIaEZ0M1A0aDRLblR3UU5kQkovYlZYak0vazBaQmZzaERVeEFybTlpbGor?=
 =?utf-8?B?VVlVVjF0eVJuY0lFT0FOdU9QVjJmaG1xMkxQZkNDcWpHRW5iN21Nc3Zva2xW?=
 =?utf-8?B?dFRVM2Q2Z2ZXWTFhVXZ3cEttcVI2MHNLeTFyU0RsU1BuQm8xZS81OWFSUmdF?=
 =?utf-8?B?ZlRwdVJqNy9kN0t5d0xtaVFtbzU2VHkxakJZVWRWckQ0Z1oxb2FYWE0wNDNk?=
 =?utf-8?B?bUxUNm52dXdyaEEzaWphbjVnSCtKUFV4YzRzakFxaEExeGZWbEx3NmtjdVVY?=
 =?utf-8?B?L3RoYzIvQUdJeis5SkVPTzRmWDdUakhRQVNocWg5VmRZdGVWRlpHNmEvTExx?=
 =?utf-8?B?MXJLQUZvUmNEaGR4Rm5oUkp0RldGcUhvczZ6MXJza3RFN05nQVQ3Qjk4VXlX?=
 =?utf-8?B?Tm9qbnY4ZFViaHFrRHJWWmF2UW1qZzJwc1ZyOVlKUDZFb0hqYnZKK3NwUDE2?=
 =?utf-8?B?RzBHV0FGa0VyZ0tObm9qU2FkQW9JWjZjaHhtZHhEVmMvdlZwUDJLWU9Ia09q?=
 =?utf-8?B?YjRhb1NOWHVNSlpNSmRTWFh3d0RuenNzcy9IVkpwUDgrS0dHK0tMNzQ1WU9D?=
 =?utf-8?B?Rk5saXJlM3lRRFZUazhzZGc3anRxdVVUSUJhaG4rbzNqejROVFM4WWVRbmt0?=
 =?utf-8?B?aDdqNEJSSzFEWGRoV0RielZDcm5GTzVzVWk4RFJ2WTdxdjJJR3pFT0cxSWVz?=
 =?utf-8?B?a0Rod3VjR21ISFQ5UnJSZkhPNllqaEl3cW9QSVZteTRpb0Q2bGFnd1Ixay9v?=
 =?utf-8?B?QlhKbXMrSlRxcEZUc05iay95My92NzAzNW4xSjJjZ3BINWxQM1B5S1dGWEdi?=
 =?utf-8?B?VUJheXBKQzlrd3M4ZEJWbDBLbkdGSjZtZGtLRC91U2c4MVBRQk9MbytqR0ph?=
 =?utf-8?B?c0cybTlNTWJ5SCt0Y0RLOTcrWE9GVmxiUDFOWW9aL1FhYU1lYTdISjNxaDVQ?=
 =?utf-8?B?Q0xsenIvMEFBcDViRk1VMDBKaEd1cGpTK0lkcE1qWXBwcElCNERLa0YzZmtp?=
 =?utf-8?B?dHdyTXRyblJGRUtuRmE1YWJJOGJrUm53WW1mekRTb2htcDlPRUN1WXc4SkI5?=
 =?utf-8?B?ajJUa04zcW15SnJxTFROcG9vdlNScWJ1cVNhYm5Dbnd5MHlhcVhqcWpkSlBm?=
 =?utf-8?B?TGVCd1VYZ1grenRSRmNhWEwvVUJ5S0ZDWkxWVzNwSm8zUUMxWlBCYkVtUVNY?=
 =?utf-8?B?UlFOcjNPUjQ2VjNyS254UndVMm80OGtDSW9DS2liTS9ZQ2ZOQ0p2RWRPZ0pn?=
 =?utf-8?B?bzdYNTBOOHRHMlhTZ3Z1Um9iQUFFWjhYZjk3aXlkVmJLUVpNQ3JBRTNpUVdF?=
 =?utf-8?B?N3IwYm4rUng1Tml1by9rZVVYY3NTcVd4NFc1bnRLc0tVQ25kd1dueXpRVW03?=
 =?utf-8?B?a0g1VG9sUHNnNFAxcmJ1cWlHbW1HYWNHQzN3Z2hjbjNyekUyTkpOQUt0c2pV?=
 =?utf-8?B?MkRUS0RMS1hMRzRueVRIWWVuNHZ6czhUckpxbWZBSnFZa1hiQk1DQ05UWUtq?=
 =?utf-8?B?QnR3a3lYUzhtbUpaTzhzOGlWand4eDlNLzRhNlVtR3VKNHVhbkVIY3ZSaDJY?=
 =?utf-8?B?K3VaYWt4RVZ3Vk5vME1xMUpackVESVJvbCt5T0NDdFZUWmMzMm5sd3pVYytO?=
 =?utf-8?B?MU56cFFoM1pnUW54N2FmMWQ1cHNpNzdZQnJEOGUwYzhLYVY3L2o5R091L3M0?=
 =?utf-8?B?YTM4RkpSLytSU09Fa3R4Vmw0YS9Mc3JwWFUvOEdaYitUQnVzSFoyZ3BSbm5r?=
 =?utf-8?B?RGZuVXBYR2hreWE4ay9XQ2JNclNSVUNCaHU5MEIvYTlVamEzQWFyQmlhVGF3?=
 =?utf-8?B?S0NxeU9JY0NSa0ZaTEhVL25jMWl3OEVZdFBBTEp0NmNnRDI2emZZMTBkcFNI?=
 =?utf-8?B?N04wdDZUY29ES1VQOW9EZG5nZHE5elh0b2l5bjNaYkx5Q3VFUzQ3MzZvaG5H?=
 =?utf-8?B?cnZXTE5VZjNEZDlSOEVIYlpUc240Yi9xdEZCMklKNGg1WVNIMi9uTzFzd2s2?=
 =?utf-8?Q?8F20K+DRvK/LYYVGW3vGlpR0C?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a6310f-b0f6-482f-c96a-08db8e6f6db2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:23.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6qZtsKcX/P9EELv9oY++AMTPNF7ymWakIX0YNSh0fnZiqJA+zeazMdrkmuCgGqTLeMa11PszLRpzJgisnGC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 05926bf5ecf9..a07f8333cd6b 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -489,7 +489,7 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
+static void sdhci_esdhc_mcf_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -502,8 +502,6 @@ static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
 	clk_disable_unprepare(mcf_data->clk_per);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_esdhc_mcf_driver = {
@@ -512,7 +510,7 @@ static struct platform_driver sdhci_esdhc_mcf_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sdhci_esdhc_mcf_probe,
-	.remove = sdhci_esdhc_mcf_remove,
+	.remove_new = sdhci_esdhc_mcf_remove,
 };
 
 module_platform_driver(sdhci_esdhc_mcf_driver);
-- 
2.39.0

