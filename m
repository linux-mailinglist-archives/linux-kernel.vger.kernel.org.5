Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2B975C3A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGUJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGUJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:49:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429AE3C3F;
        Fri, 21 Jul 2023 02:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+lVj+3eWb+bFCcTtJGts6pIaz8UCVsGW2cV4r4z66wXOvV8kwujLa4OG6QjihqMCg84zxeVq7RpChisu6uwc6w7/GxaOIzBk/lWgHH0amIc9HD6TJEuGx2YRcZIbPhoFxXdXxV/Oo3nJYFpjVjqVTNalaw/tf3pqTAdofwZGFwKSQ+DPpS705GI1uYPGYGFFYw7sqKo9EafoYU2Dxa++hTJbbtnbUlWJRcTQ/2UMsjiYdTLKak2DGTWIihKN91mYfMD4pON4nEuYWswF9orHBnJoDtp9qNtrUGnSBayYB6Pj3VRENcIGYeT4v44dnGX0hkF70NeUs4vRCoyke2BRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeiyD3bTqLrfzoM7xfEdmd/j0Zm3deDKudXtSJLhE+I=;
 b=WCpqD2AEpT8/3olPfwTv5xk6ScKgb5hubI2/D5DTPM9X/hts5vp6CiuFxer+axzVVBKvBER3UCOJWSSX+eCMaZpUouzeryb+TL5XYIHXl/1EVLoN8SNkksQcqVzaVJJQdkhQREmpapbbfCwd0vJqWLBNZdjEoAWliAWJfmlaRyIpamxgZcMalHfzsGXAO2MDJSH/5SRVSXP4VxfC2xPLPUeXRiaAFLWzDW5XMoTx7GBecM5EihfBI5Lx3E/dHYSpaQyviqtk3B5G+cMRmF6aJORHyYvPoz3yCZ0h+uCT7LGRNFtT8wqALvhHZg8Av+pwOh5N1TPLiV2URyMoRMXU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeiyD3bTqLrfzoM7xfEdmd/j0Zm3deDKudXtSJLhE+I=;
 b=nRJX5RyMKvOloZaQkT9IEwsGRUR+ybLYByRN+fBaBtxjuoHil+hXmT3eMWSBYM+/D0AK+szA6eschxIU6MW/cBzP1xgfEzFoUQR5aROrycb5nrP/RhRp4Ktjdl5ELrB1vYj6IwwLBc3N1IRPBTVfSAUmuru7LcJoCT4QlLOsnKPRVPRHqDfXmyGhwp4ttCGj12gx+OXGdZq/xHT7gOn1BvEsGdX+vL/g+bEF1EA+ADCJJD8LcWsF8RNHyKgn6h74STBNYgw+dE6gcTGsVEIFHwxzNBuluPz2YPKDNbW7wjTpdXZAqkngMluKHXV3iV8RvBUB4q06GABgXcTcj9r0vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 15/22] thermal/drivers/mediatek/lvts_thermal: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:34 +0800
Message-Id: <20230721094641.77189-15-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230721094641.77189-1-frank.li@vivo.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d904bc8-9024-4a37-107c-08db89cf8179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t015E/Zo7+fHIPTgrQeNUiz6oINhAOxuanpCEG12+n3L75kBoK1fbHoh8fPKZI86I2iPRcVjV0aRHUd4YUCmcXgLbmBmyatqGBfW17z0wlpW/lbq/vdNpFspZklKY7WzpsOa38fwrQZTNlg+24RvxhY3tF0PlRbd/3O0uk6Mtdx+ZI0XOKgc8Khzuz52zEQZJesncrP4dW3rmQAIbF+Lhit5XdbF27HFyUlgqZcDugpSulK9kSg/i1OIWU6nVGkf87ZEFcZ1rkQdxFmqGirW+XWYZA5tqttzF77WZWrENZtkDGKN+CtN/IJbDi9WLNUZTT+DObULU32/lwam5TDS/TzIRtZQb7bz9BX735zN7VXNpMgL0SmNXBheOuFVSCDIg3vjsHwoqKV/epQf+LZj6An35gbOYQ/w+a3LPcF4YORwjnOAP1Oqh9hqtPlYt8rbrekZyEyV1MKz/X0PO1SPYmgNqLQoBIO6zwZE+3G8BYV7pyZEEUjNj52/Q7PjKKRzvuCMjPwexdrjnxyqf+5hxwb9D9Seh92qgXJdtPnTyMmMxfeqPgHAa4DnsHT1a1OhXN+wwkIJWIrlfOYsjID+f2t1kMUr2IVr7InhhLbiNasVMtTdISrDHPgHm1fhQ9cm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNodUZpRXBiRFVFRHFkc0ptM1lkbVVwYXFBY1NOemJiMGEwUEdsT0tWTnlJ?=
 =?utf-8?B?bnBsVlVxb1dVcGQ1UUprdXArUUZxbXREckcrQTRMOEtLUmFNUmlrNTQxTmVH?=
 =?utf-8?B?VUs5UU04bU5iL3R0NURiY3BGTDdZQStycitySWUxY2RTTWxqWWxDNGpkb3B0?=
 =?utf-8?B?bkcyNitMZFJ0NlFGb3Z4c3RTbnYxeVpubTh4bC9zT3VNdEJ0ajVHT0piTkpQ?=
 =?utf-8?B?c2pEaXdYc2UyaERiNzVhTzBYTE5zUGVaSC96b0k5aFk0UlE3bmNaTGVEUEJw?=
 =?utf-8?B?bGxUdTdTMDZ6dTFTTG1mdTZqcS83RWdoZlZ2RGwrdE9UemZRNlAwRGV0eS96?=
 =?utf-8?B?eU5CcExhbnhCMVpES2NUeUJIZW9ZUFpUYS8wWmFITmdld0lLOFhRTStocVlh?=
 =?utf-8?B?RnVIaXdBS3ZvZVlFOEtDeTNGY1AzdzJUTmJyditHWW5IbnByVThQR1lvTlNj?=
 =?utf-8?B?ZFVIUUhpWThZU2wrdXhYbVVLWGRDMThXSzh6a2VXbzk0ZjlWa1ZVUzNHcFdo?=
 =?utf-8?B?eVkya1dKTTFLUFRQcFg3REx5YjdNUWlKbnE3YVEzYTlrbklMRTk2ZGpwR0RJ?=
 =?utf-8?B?R1JHdXJ3ZnVXQkZRdVJoaDZmdllBYU42QVlFYmZUWDJWYTdra3dxbGQ4WG95?=
 =?utf-8?B?eDRlczQ2ZDFPaGJndzlNTDRZRHp1MzZ4VzZZZjVCODgvV2xTbjZ0RHRWZ1lE?=
 =?utf-8?B?ZUdGOFNhYVUwOUMrUmlWdHVzQzV3UU9CWVZoSlBldkxuZUJ4WFovRldNVFNK?=
 =?utf-8?B?aEo1bHMvOTVldFNRUkpLbkEvZFpXUWVTS0lOOEVQTUJmYTd4VXg0Zlk3emxW?=
 =?utf-8?B?RlhoOUFsTW1CekF1V0hpL3ZVZExlQk0wMGJkUGlHdytHOXpwRlVxMHlsMzQ2?=
 =?utf-8?B?M0N2STVGUXloNzBqVDA4aEgwNElURG1rTVB4b3dROWZER21aSGxrWkNaKzFv?=
 =?utf-8?B?UFNUbzFFZW1MTGNnZjZyNHhjVmRmSXIzdDNrWmN1TFRUb2xBTWt4SitUd25X?=
 =?utf-8?B?QkMvQmdHakRqdUVWKzJ0bzhmY0t5NENma1JFN3hoNkNxODhnNFl3ZHovQU11?=
 =?utf-8?B?RzFkWEN0UndBeVFIdkxseWxOb3QycVZPQWRHNmFkeXBhaW1CZjdYWW5BV25s?=
 =?utf-8?B?ZXg2Yko4bVEzU25NTzJtYUJTR29Na0NiYmtqdmZWUmZZYnQ5WnlDVGpjdG9R?=
 =?utf-8?B?STNjV2EzU2NmT1E0NzVWb1dKM1ArS1owdjBsYnRNSVhXcEFCL2J5Y0txazlN?=
 =?utf-8?B?R1JnMDNMTXVoMVRmUUlTVTJZRXk3SFBYaHlpVTVxYmp4aVp2NkxUNko4dmNo?=
 =?utf-8?B?YTR2cEtvaG5ESmFzYzVlSVJZY0dTZU1DdHdvY3BETnk2R1o0UWpybFo1RC9L?=
 =?utf-8?B?MmsvM2N1bjdZTVdnM285R2kyc0dFemNmWTRTbVpUWFNwSHJvTUF5YmtpUGMv?=
 =?utf-8?B?ZXFHczExY1FIWTdhY1BOU1doQXllRHBYc2hzVGsyNE5ML0ZYRFhJN3NZcWx1?=
 =?utf-8?B?NjdmN09ZVjdUeGZ4UUhKNW5uTXZ0dnIwT0JCRndDcEFMeC9BLzQ2VDVRd0dH?=
 =?utf-8?B?ekRDM1Y3ZVNWWGVnajRzL0p1UnJQTHZ1RkxSL0tHTHQvNkZ1bEdwSFdyL0pu?=
 =?utf-8?B?eHBUTUxnYTh3NFdCK1RZdExxbVc1UjJqOGM5dVRCYzNBczIrUjJDZE1tOWU0?=
 =?utf-8?B?eXhxZlRRaXBBTExyTVNBZU9HQ3F2WVFpRXpOSDdUaFhBcVIwa2NYMTA4d2Nn?=
 =?utf-8?B?MitlMVRGcTMxV2lFV2VYdVpCWHAybnc2LzlwQ3kzOE9ObXBjK0ErQU1SMWJx?=
 =?utf-8?B?cGQ0Q3liVURjWUxlaHFNdE0rcytpb090N3hKcWFIYk9xRnJHUWdkWHc5R004?=
 =?utf-8?B?VHV3N0ZRbllGMUZoSXh6RGZ1OEkyUllIb3BKMHA4ZUZybXQ2ckh2WWRBcFdG?=
 =?utf-8?B?aDhKWkJQbFhxbFkxbVoxaS9iY2FhMitpRlU3Y3dWSnFxdVpjcVhjMkROQW9J?=
 =?utf-8?B?R0VocGFmTkQxWk91UWpCbnBOaUV6N3lWSWRjQ3h3SS8zYkhnSEl0eTVDdVUr?=
 =?utf-8?B?bndvREVTZmZRaGxnS3pxWkw0VkNjTk91SmpxYXdJWUx6d3BsOFQ1Z2twaktW?=
 =?utf-8?Q?qFPlNKLSAzOkXJ4mJDe4TuHC0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d904bc8-9024-4a37-107c-08db89cf8179
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:32.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTvBotaaKSb/ON42nH/mgAJX+8h/eVhrzkoDGf+xjt2N8yJI/UorZQbPb/ITZlLEPRRcww4xieqye/X4yakTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d677..1e12410820df 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1148,10 +1148,10 @@ static int lvts_probe(struct platform_device *pdev)
 	 * At this point the LVTS is initialized and enabled. We can
 	 * safely enable the interrupt.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
-					IRQF_ONESHOT, dev_name(dev), lvts_td);
+	ret = devm_request_threaded_irq_probe(dev, irq, NULL, lvts_irq_handler,
+					      IRQF_ONESHOT, dev_name(dev), lvts_td, NULL);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
-- 
2.39.0

