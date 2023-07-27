Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319207647A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjG0HFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjG0HEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D53C33;
        Thu, 27 Jul 2023 00:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0xuvlytLoXBy5w2zojFl4u50zLrLhFOBmwkqi2aOnUrYZwcbqIC+GtDENNB8HwHboYppRPddA5tDh6pWSx+Yrd1pNRqwwty1sWay462R2N3GCf/Sl5B2+lxBjfUa0aA3+M0oUibA29lTBdS6+Q4WyVbovArQ529VsjlA/BdpyjcYaTDoOWPv9BwPIIqEr55S90yIidrvxu0J/kEFK2BP6InApgZNSbu3FLU+A+a+OsjO1o/TrajQkwKXQI1zUihwUCEarMlKuBPJzBxPFo4On8SXSq3Plr5Xs0GOH/M76qIJhTgD+++3Qxqs7W5x1IVXgGVxAkzTHXvJK6BMIKNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFCZMSRT/SLHSwmQ+mf73xOp7pZuv/jxv4saUj/q9f4=;
 b=Ys3tBQsN/0r2lteBBV+pCXnp1rVS8kTFqESmFe92GvfRswoBY+3C4PmVVrS88Q3jERPA65915z/FGHlIOKCRTW/iR5bP0zEmEU00uJwjSFmGDXR0ZwRxZXNA0Ie1iiGgNq5hPRzFE8dpMoQ8jdbYe/owno/hJD2k4GVFf+LvCtDYtm7tsHyl/DTs+4b5Rr3o6h0Mz4Dek1Oa6id9aPncXpAzLyESHLiL85UV09DY9pGis0LAMix5QE+MVL0gZsm8dGj9xKhdXaefHaBTqMSKA+qfE9G6hLrKdsOgfZwqzxgqoPHgv34URQGy28LDG/JXfxwW9ATfuTlPypdVGmKfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFCZMSRT/SLHSwmQ+mf73xOp7pZuv/jxv4saUj/q9f4=;
 b=aHKYzMMn8vsWRrcA02yqGmTqYYlFgUkGJtzFHCpu6wY8yfpFvjikrAO3dpK1a1HU0Ey+q9dDdIgcaZYcoSjrIMglx5UV4LUXIoPYCUjcZoVyQ2NR3UBRuK6F35hrqHTCNbAReXlHGjjm5olkFnjz1ZQi0rFTeGCWxlxnUBdtP4Sq9EomfI2T80uH8EmUMtAoAncGOHKVPErRJIy07cYaVINFIAhZiz2EF4K/SdbJC5ElblY05xksmS+eZB9ko53yazkQ3aBza2DTHU0qCfeoukcx82bCbVX+ZFfIHWfcfHTXc1moPtTC4k1AU2uNkZclZbx5WK+9o64dhgYPYHAERw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:38 +0000
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
Subject: [PATCH v3 22/62] mmc: meson-mx-sdhc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:11 +0800
Message-Id: <20230727070051.17778-22-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 975d2e4c-819f-427b-3a0a-08db8e6f52df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVdGWq4akomqHsZBIIzsj3nEx+3qHjv0PJx2WHR3lUhDRAOhLcU6LTheaqNRLtUdEDq/+sPprimsyolBGXTX41pJblT3mk7dqLXm86f6FVqF3QY6MdVEnE59H2j85GKwOlzOEtL/s+QM130JHOoPu1ij6dy7NfWuMhkC3Jy2Ueeu5kGBTyVeMs1Jdn3Uf1LSGwny2r+hVR31azyFyYG8Krp+eOMHOn5HT00jRrUjZymmEJkem+xn9iOxsBhK+eSwjMLEUE2GePZVpVrtA2E1z15PyXXSu3R12qfZTdsCbEXiuLZAY31U0bbfZ9ZvitxBKPx3tfxJ5kgCoV2sT8oPffXgnvhK020nTQWN9Y3NTAU5OvmO+TvDVnBYW93BKBci9GEzPznytue6IzKrBH/jblNUy2QEM9hxdLEaJjvh9WHlcrKp8PNf/8GkYwiNpjFIcvYmpueGZjvDxTxcL2Y7ZYTBufMUl4dC1evOiLTe44o9eoGFARYVwc7dEuy2qm8DkIz3rHVmtvkxQXgQCbLqm2r1AqYlGyxixPzYDiHIb01Nl20Kr+QFkMkOJs9tVHE5e1usWOGaumnZefmDGYK0EokTvgu4m4D3ppo8fOxKR3use5w0535cDPTGpeaETHhf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(7416002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1cyYTF0VGVaK1g1Titlc1h5L1RwV25SMkd4UVR1MitaZnRPL01XbjV4K3A2?=
 =?utf-8?B?b3VSWlBWTzJ2VXh1TmNqeHFCQW1vakIyOFdMcjdFUkN1RTNkRng2Ty9rVU5i?=
 =?utf-8?B?U1A2WDIzWm1nc0k0SXBPZnZXa3R1aC95UFdOa2dzc2ZDLy91ejB4NUZtMStM?=
 =?utf-8?B?WStpQVVmZzk3c1JYZEt5cFFqVnhLbnkwLzlhU2JYUG81N1NqTFBoREc2YnRZ?=
 =?utf-8?B?RDdoaERsZHR6bGtyeFIwNE5rNUJrMDRlWktHTFJZM3FSMmhZdVBVSm0xdWRu?=
 =?utf-8?B?eGVWRG52THNaWCtnbkhTa1NLejFGb1I1dmdRenV1bFBvQnRlR1NvNG1PVC9I?=
 =?utf-8?B?NG1tNVVaNmVGalhzZ2VYMU5QNEFtY0FTbzFJMnUzVW9PVCtmSWpiTUFkN2k5?=
 =?utf-8?B?ZlZXclBXQkVHYW1sWTFZUUNXTExnM0hkbjhXZmRwZGlab1BhbmdYUmVPN3ZT?=
 =?utf-8?B?Y0pPbkVlbnJMWHQ1azlXaC8yaEhQOUlEZlNBbmcwSFMwSWppc2REZDFlNHRi?=
 =?utf-8?B?K0U2MzZZeHA1eEpGNzRsc0w3UGRyS2ZTL2lDa0Qybk0xTUw0cUFkNnFIbzAv?=
 =?utf-8?B?QU5IMnN0WWE5c3pndXV3Nk9hNCtDajJZdGVWSnA0TXV1cEdVMmFTNE9HYnV0?=
 =?utf-8?B?a1l0TFh2UlNKa3hqT1BDcEQ2UHVwRjNCMFU0TGNVQ2J6K3R3dHRYQ2djMjVF?=
 =?utf-8?B?b0hyc0c5ekJHUHZTWXhub0Vta2Z1L2x3WHJVYzBDRnFuazZybUVxemVONGFU?=
 =?utf-8?B?NnRUV0hzcEtJTUNhRUJvUHNsL3FJcDE3RDNxSHhROVBxemlPS2VMMmFvM0x2?=
 =?utf-8?B?T2c2ajdMWTRqb3VVd1llUmlXVjdmSnJRL3FtVGNmRnFhcFpsTTZFcUEzdHNh?=
 =?utf-8?B?ekxRdTdxSUFIQWl5MHBpUWJseHpCblh6c2NUSHQ3dXJoWi9WbUVySlMxVEM0?=
 =?utf-8?B?TlJPNnhFVkZxSTJOT3FCUkJoWGtBWTZlUlE2UlZsT2FDS2JGelM4VUdzVzZP?=
 =?utf-8?B?b3htNlFkajhIVStlUngxNEhvckQxZUR1eHJOcmpkRVU4N0kxZVNKaU1LREJM?=
 =?utf-8?B?ZUtnaEQ1K0VIUTYxQ2pBT1hOMzF1dktLSHByMkwzdktYaUJqWUIxZWlSRklr?=
 =?utf-8?B?Wlp4eVkvVlQvZ2NqNE52aHU3YUNZNlNXa3dudnJlUGYxeUk2MU5zYVV1VVNV?=
 =?utf-8?B?WFFSMWZMTVJrclVRWURWeTRsUGVacGRDNGJaMkR5Uk5KTWVndlp4eHM2cDNX?=
 =?utf-8?B?anVoNnljT2FFbWZyMXBRVm4ra0Y3VGFKc29GYTkrT1RBM0ZQNlJjM2p3eTRy?=
 =?utf-8?B?RDZ0RnhGT29CN3ZBMGZaOXZPdHZCdWlKcXc4cjgrWXJOMW12UFQ1MWZqdjda?=
 =?utf-8?B?M1lQT1pjeUVyUTN6VVFUOE9tWHBnUlFZRCt1Y0N6NjdyVlNCb3pVMUtQOU5R?=
 =?utf-8?B?MzJIcW9XdnNOb0Y2VitJbTRod2FucXdTVVhWdXVvTEpvTzlyblZLUG5YVDJv?=
 =?utf-8?B?SGJpRFNhM1pJeXFud09DNnF1cTlOenpGK0xjYlo4Z0NWMXAzekJzQ0pUaXFL?=
 =?utf-8?B?RnREdmlvN2FKTmp2SEZlbVpiNDZVRmE4dTlLTWtVdGl3NjllZHRuUnVTSXA0?=
 =?utf-8?B?bXE0NzloWHErNmVHbXdlSzVTZlFUWWhQRXNxZTd4VldhaWs4ZFVmTFdic0d4?=
 =?utf-8?B?c3kzQlAwQzl0SDUxdWtDdWlMbXJPb0RsSkVBYUZCN3ZaRFhSV29rWTN5ZlJv?=
 =?utf-8?B?a3NKTDJWZXZvTWNNMFdzNVVRTGRkaFN0K0ZrbkpNMXRIYi9MdjRqd25vNTdn?=
 =?utf-8?B?aVdJNmVyZGFiM1djdnZFQzNwaGZEYUZ2a2FZNXdCYys5cFlqS2JJZEc4cVYv?=
 =?utf-8?B?Z1QvZGtNQ3cyWlBoam9mczNPRUxlbG9QZldDZm0xNmhRc3JmRHlrVHJ1Wnpk?=
 =?utf-8?B?VVJqVmRjWDZOSGQwRFUrMUx2aEM4dkFhclpMSEEyUE5jcUpmWGw0bDliYU1U?=
 =?utf-8?B?TnVKazhxbmViTXZHRVFFWlByVXhHQjgrWk5tWVllUVlSS2hOSUdiWUlTTWhE?=
 =?utf-8?B?Zm1mT1Yvb21zRFF2eFdSbG5IdTVqL2FQbGUzZ1cyN0ZRblhPRTlRVC9LZjlC?=
 =?utf-8?Q?vGsnaoWYm+ZJG86r7rChCvbTn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d2e4c-819f-427b-3a0a-08db8e6f52df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:38.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwcuav/qDZvd6vKhbYhM1B09d1fLpRGw/FzzGuprUDTkoVcFzgak/WOohEIky1iJeQxcMEedZIuRNIEGpB5euQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 97168cdfa8e9..528ec8166e7c 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -880,7 +880,7 @@ static int meson_mx_sdhc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_mx_sdhc_remove(struct platform_device *pdev)
+static void meson_mx_sdhc_remove(struct platform_device *pdev)
 {
 	struct meson_mx_sdhc_host *host = platform_get_drvdata(pdev);
 
@@ -889,8 +889,6 @@ static int meson_mx_sdhc_remove(struct platform_device *pdev)
 	meson_mx_sdhc_disable_clks(host->mmc);
 
 	clk_disable_unprepare(host->pclk);
-
-	return 0;
 }
 
 static const struct meson_mx_sdhc_data meson_mx_sdhc_data_meson8 = {
@@ -925,7 +923,7 @@ MODULE_DEVICE_TABLE(of, meson_mx_sdhc_of_match);
 
 static struct platform_driver meson_mx_sdhc_driver = {
 	.probe   = meson_mx_sdhc_probe,
-	.remove  = meson_mx_sdhc_remove,
+	.remove_new = meson_mx_sdhc_remove,
 	.driver  = {
 		.name = "meson-mx-sdhc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

