Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517727629FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGZEIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjGZEHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:07:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020BA4C33;
        Tue, 25 Jul 2023 21:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh5W0xiBJCF3WANhwgZzi+AmCkigtVOV20QbfUbEkOK3kucjD0bgI1apsqL+6zEdrga+3Qs5EA6T4sRbM5s7OSZiDqcU760lL047AbtYvgIIh/lCSXy8bKdKXFi1q/vAMeODl8NaBR3VqfJVdK35bZCEE2trlDEnC4CiCZAp99f2Exnfmvgs0DL1xC+ku1gRnh6scdlNRwUiuHeTOdh0qS8qWouKBvjtFuTceN2wsuzgmEP2ZR2tDz4VnMf2g3KsDQAL6mjiiCA07H6p0SKdztdttx+9ST4HLLJuPP/MkldDF1Xd9FEDixINXVD7Hcgj6I6KZWpXEphOEP+n4td4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojpLTgBzv5+ZNx3nkgEvgE/P4GpJkxrZ7R2nyuhf08k=;
 b=gxWc0SVul38YkHEGB6CtfTpa4KkHli3SLYgjN8/jyiyEkyn3j9aGIh3NvlYRGtAAbHAinvIjagJIsmSFnsXROV96NbcaahvA3eWFFzf+N9+i6TO2SCFhox7Ttk5AyGdXvwGFb/QAcvdfsjtb3tMOMPARlkzN4RhhIYU0+oO6rYuz1QeCYHK5GO7m3gplnZpi8vGJhhGiGeI4Hc/vdqM+YGbIa4uvEFGh7Guc5+KfoJBFFSrxwY+oZ/FSSngQMvvNpnghLPqA04weXuFMgS7BEwmtmnEGK7wgkjYZzJaR0ZtbsN64qYeTmrzpizEgfI4ZiJ161Klz+MlyrbBdgbKrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojpLTgBzv5+ZNx3nkgEvgE/P4GpJkxrZ7R2nyuhf08k=;
 b=XqR+bNrbpJrse062qN2STVA9mrFmZmXIFMdHiePX/VgvNQ63RZo9U+PeCvCCeOBq4cRMsnVhMtdXZVsJlP3lA05jncjUi7v1/r3i77NWKOuvylWQ3m7c33FldRGJV9q1qA3mjGMzOoK4iwJhw+EJLATcjpTgJbQIq3gZKyQqCADloho3UbzsOwiSh7l0LH0f6Pn2HYvrBeesRpUIf8lhvGfPYxr7UPnboFROwDsYDd8FHLgBonVFeEt1lKjK/WSb5bWr1pkHYUqYfceswcP1u3I86LfUUHRdOFousC0TjHTXOOSjyS0iEkQdc3/HFxKoJjqb+7l4fkDTyUlf3N6OaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/61] mmc: sdhci-esdhc-imx: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:19 +0800
Message-Id: <20230726040041.26267-39-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a480c50-3244-4a0e-2f03-08db8d8d13d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itUbjkEO4zZXJDKYJ5XKGOc0eHjlweu+/kHS+hwqgL/VrIasvJXfELWpO34T/i7cwnmRmtKEU3lgrbYSuGJUuE13B0/bnm2XKvZq96/MZwy8/vKawFmYxMhvKxhGaAJLNozJT/EujJ6k7lbT4Ey5OB16UeMqqV1+XxOY0DcEybuVkAd3qHiK4+XAgPnPeYztaOVPeEDApP7sfuDzuyx1Bdbc2JZl38c9YUKnvtQzmv8bQhIXTKz49JEU4n0b7JOqzGSZ6N75ImDcI9QCi6vO5KTRTAHc93NPQRqsIsdqbKn03I4Q4BNXr3v/MiIURu9d0H2SvnfsGhHRRkRf+2Eaa5My2HBCXz91M9Je+c+hix8Yh0jAQQqTTkoAfRjVZzNgtssEYQ3zl8WxTwGAd06xPGdNuZDHyqWo1K6sJUMH9+3fsGIL5AblP2NB8ghs/7F/CT0U51hWuGu6yPHH3JNWedoBR2eTeUBxSSgVRYHaCrbtPJAP0nuWpAAZP6SE19aoR8dC77c/2dnJ7v4YgQeQ5FIq7Vv1a0cJmxavbLAZ7omWNVtK9ixQPyFts+0HYyyvA4t8DDst04KHib6J4V23UdFinXlAo3D2tUittdlOxoyiSL1YVfdMvtIUpDcZUBUZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU8yYTk1M0tCWUUveXVBVUh0MlVEUmp4VDR5UGh3WjQ4VVBLUHBwdXR2c3VB?=
 =?utf-8?B?dlNkeDJzVzFhMUpsWHFlSzNRQW52YWRISXArdmVvYnFaUVZPcnRKMDl5eTBi?=
 =?utf-8?B?d2owVmp0L1pJdHRFbmRsOHN6d2J3RFNiMElFalBMdFZkY3NoNURGS0NSQTZN?=
 =?utf-8?B?dVpwb0hiRzV0UnhIRnE5TFM5VzNIdmYyYi9WR3FCcnY5TDZMZWdQSC9GUWxE?=
 =?utf-8?B?QkU1UUFzZWpvNk1rMmt1SDh2NWNoK2JML3Q5dWJHN0gwOXp1eVFGdTYyajFh?=
 =?utf-8?B?SWdJOEhWdHkxcEFlOEdBKzg3bjNZVVBJOVlzWmNLWFlMbVBaYk5SZkhmNlRL?=
 =?utf-8?B?WUJYeFQyOVZXZzVkblJnaFUxZDhDemp5MWpJWHZpM3RtSVg2UEFaMnVCbi8z?=
 =?utf-8?B?MXR6eHVjQTVVemh4UFlJUW1ZbXh0cXRZbzVSMXUrdVdKazVWWS9hRk5oMG43?=
 =?utf-8?B?UHg1RGVYVHllY29OUjVlM2hLR3k3YmF2VzR2V2hCYmphSGx6bzd4Q1hScVVU?=
 =?utf-8?B?TWE0TlZOZ2ZYaDlXMVlJSEE0dFhSTWFvMXR1UXRoUU10ekl1aGMwcGswYXVu?=
 =?utf-8?B?WnlKNG9HYm8vMzMzV3dZbXBnUzh4Lzh2SVJONU9JczlVZFJYbW5VMDBZR3dk?=
 =?utf-8?B?a1AxcW9tb051ZFFkS0hnZ3NUSFI1bmhzZjI0b0tWRE0zcEQwUDhYdmZ4RWFa?=
 =?utf-8?B?cnhHTytzK2xDYTlab0E3a3g0NnZYNlp5SysxNCtyWkVjRTM2UGx5MHJsbXJK?=
 =?utf-8?B?bEtQd3NzU3BMWDJZa200NHFQbXdqaWhCc2JqTkxENEErYkVWVjdBQjM4SHVJ?=
 =?utf-8?B?cTl5Y1ZWazZLbWQrbUJwWU9PQ2ZFSFEydzkyQ2ViRC90VzVJYlozaHczcU9w?=
 =?utf-8?B?Wnd2emZJZklEZHJ2UEUwdDVkbUdpcFo0NHBSbjcyVFkvOEpmSE9sMzZOZ05V?=
 =?utf-8?B?MkJBVllydFMyWndSOUlZRHlENy9TQVNxem9qalJ2OUMyS05GUW9acWgvcVNO?=
 =?utf-8?B?VGREOHYwZjQwdThKdlhkQnRGTTVGS01OSEp4V1hMbGZLSUhXMDhNcDhkbFpF?=
 =?utf-8?B?QjRiWDF5N2JlWm5qbnpBNU0wSS9ramVUc1ZSRy91Zyt6ckc4N1lUaEZFVmt3?=
 =?utf-8?B?bnVQaldOZ29jVElrMmtZTTVwTEFaU1JXdysvQzIwOUdPUENoVVRRZmhTaHUw?=
 =?utf-8?B?MlhqTStYNThzSGh3ZEhONGN0WW01d1hpQ2RGRXVvRkRKM1NtQXZPS3VxWGxj?=
 =?utf-8?B?bHQ2ZHMvYklndU1zK251VVVDWDhmdEY4TE5xb1NxVGUvb0laNG9Ea1IxRVhx?=
 =?utf-8?B?U01HQ3ZGeCthVk1PRDRSR2dhVGtkdFp4Ly93ZDRGMENIS3JKRUZ2NnlBVDBH?=
 =?utf-8?B?Z0cxZkwzWDVHbWg5cHduc3c4d3JBaXNJWGxVYkVqUXZNUDJ1V3NqWFdyTko5?=
 =?utf-8?B?SndIRTByU3hpNnV4c0VSNmtZSmVBT3YrK0U0dWh1Q2VVN3F4RTU0QUEvNTJ4?=
 =?utf-8?B?Q2k5M2UrdXdMeENjYzV0Uzc1UldMeGhGL3lWWXExeFdyWC8rS0R3ZFRtTTRk?=
 =?utf-8?B?NnY2Y29STTc1cktBNjNBTWhWQ2xLNHVTQTVZN3J4cVdadnlXMEQyNi9VUzd4?=
 =?utf-8?B?cHJiTTZpc0YwUWprYjU4U2dCS2hhbVkxVS9KWGxFODcxTlI0WCtjSDErOUVl?=
 =?utf-8?B?QWhZQ2Q0SkVZMVlQRmN5ajlNMVViVVRCc2NVdnZJbGJrVk1EMUFaandyL0NO?=
 =?utf-8?B?M1NxM2VLMFlzWHdjZUowNk02b0lkSW8xeVJzWVJ2THp4VUdhWEg1YWpqMGcw?=
 =?utf-8?B?UTE4anhTQ0IwOERza2MwL3JxejhLamI4OVlFdGEvUG5KTGZDdmJEVGptVyt0?=
 =?utf-8?B?VFhpZ2tGbURzTXkvSnh0bWcvek1XclhOYkRISXhkZXA2c1ozT09BVzhqQkhE?=
 =?utf-8?B?dlNSVGo1WlNMandNSTBxL0YrWkpuNnBLNW9GNmVHa3g5WEhxa25YaUZUbHox?=
 =?utf-8?B?YXBRczBzcXd5bmdmUGlueThzUFNvOXZnT3JxVEJyazdrVkRxb1RJdTZUU2xx?=
 =?utf-8?B?a3JKYU9kN09lamdGR0lDbHF4K2lWa2NCbXZhQXVTckFGQ0srNS9rTFRqb1hB?=
 =?utf-8?Q?Iwx499ChSTz4ni4PAliQDMqU9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a480c50-3244-4a0e-2f03-08db8d8d13d9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:06.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEdxugz02KiGPYpZA1W4cadtHhAtloN/qBMSOquU9d4DKGgWIRQ6Jy4cp+VE2laxW1si5ZLCcVaVm8bBUxxo7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
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
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index eebf94604a7f..e882067366da 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1802,7 +1802,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
+static void sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1824,8 +1824,6 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1986,7 +1984,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 		.pm	= &sdhci_esdhc_pmops,
 	},
 	.probe		= sdhci_esdhc_imx_probe,
-	.remove		= sdhci_esdhc_imx_remove,
+	.remove_new	= sdhci_esdhc_imx_remove,
 };
 
 module_platform_driver(sdhci_esdhc_imx_driver);
-- 
2.39.0

