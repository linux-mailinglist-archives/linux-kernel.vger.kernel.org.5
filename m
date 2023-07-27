Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50707647C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjG0HGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjG0HF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:05:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F38449F;
        Thu, 27 Jul 2023 00:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk4yMts3YIBZc0JbunUycCnqV/qq3KFhyc+MPdEw6y8r4FzPuuBOcEU+6XpV6Iv5LZ1lnPVpx9PTKM66AhxMKS59pLOfZuAqoNswoQjrEGEH30m6uwP4qNIzPv/FcINH4Ivv6+OhtqPO2ZdSaGEPKl9y0ZYiSocSvRLng9RLgFPpka77zrXUdDwx8ff5iEHfXvm6LfcShEVdff3xwBB7Wa8AB13Th0IUTYDs7MbHp4Gu8CA8LjJQtUVW9N9DIO+u4gc7vgG1toCMik6NHuqPuWOzrts9g1b8DrjmCqO9cj5YM5PxFNggLJur+Z53mci89ggIQ8VxQBksA9DIRs0N/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPSNTeLXONTEaPi57VHL+ynklrh9VhUEOFx1sXYVmls=;
 b=gKCWw4ZWnLA0z7BDvyV/jZnwe8r8bIGRjoK5PNmKxnB9wAUnv3YH7MpFYanVLbhrYwwan5HowfUH5A7bEhnUJAXHfRicPgYEiHav9mxpUbxSs8+u8GR0QrDJj3NiOGgBcz/40UIxFMzFdr4/SFibeuyeHHV2UPrw5F+9gPpE4x0Eq18L1qCfcX12cCSZFnqH1otfZlFgXbi64sjaypn82reqQs7tWJMPKB62oPqxETF20fOJN3E3fofwyadTxeyQaov8rZKpixKDgzRrliNAKv0bpuFuC5S16uUNHrN5LoL/k1eOz1UmxCzPd5Uf4VrvamY1/NirlCg9S6r8X5ULLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPSNTeLXONTEaPi57VHL+ynklrh9VhUEOFx1sXYVmls=;
 b=LdEFq3I2t+yiRRqbfKyQvW6vXgITdpxgoEvX3GPTdd9T0saTIvH49Tjp8Ba8ss19cHU+tiEvBpoagnvWj+SCpFBWH52c7hZR6mW2zDNO0ScQX+C28HDs2UzMYhQmseTEDihRZkHC7vnA6YDFm8QfeaeJvCFshGBqIFNBYAWDrVqNC2wS4qTWtHRGP+QT5vp+7TTMZLgQrNiSbvBDoinFt9ITxBjBDJTPpZg44h3aOQaqWbF/ecEG+HPNaW9NwDVyyTvFkcv5KBHJlnTpGk9dzp+SGQBbFdoZtIBDv1UccIBlYKqllqhl8tfFG1YXcw4h0d4XbWzYa7WuAcNYZU48Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: [PATCH v3 38/62] mmc: sdhci-esdhc-imx: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:27 +0800
Message-Id: <20230727070051.17778-38-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee10a6ab-ae4e-449a-a610-08db8e6f63b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uob9SX7imQAdPQD/G2QEkdGOg2mH+jdz7EQONmVVS1w838kjlr29i89xV4zSPq7T+jJDzkipDSSJ8x77kbJ6ySv7LV/HaQ0a9EhhQYFMUxBkYW+sQLjpcNTfzwDVfQrzbqXfpUbowU3Dozm3173pvGHnIPH3aZxxZmiNA3e4FyEIxJNTmfKxoFleSniLNgiSMuGPr2w+ihMc9Qs+4TCgxs+GkSZ5uYaeM3UC3RTuM1DEyvZH/tj1gCC7MXqUapll17WSxk6BR6jDruJfnpf8KuFr8biGfwxHWRYf8VMzwh71jPKMxrWx2CPZq928RKvVeXCFr8qwYPftd855kZXZEmfBy6wBmM3G+0tCW02W9Of5bBOtNap/7Oe+OPBYbchJ3udhlZs9a0UFKI7swFe4DQGUC908QCm7aYaVwhk09nIejjuh5bvZPsJA34HuyuOBqTr5phXnPxQrWjYcFR2JGBMFKkUiz1JOUPPG8CNqH0Z5f+ElKdSEuQwpOn/Ysl6a1vJ2UWjDULMZmY3ohOU3JIhRiijI4TzLO6DEc0G191oeqCwr1PiKNCM5kVrShvv1XKbmym5+XF6b6X42/zXjvOvstRECp/LQ1zAMJe5uVgz0xc6JuCbOoSR1ULkjSxXr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(66574015)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(7416002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blN6TEJIcHBVN3hldWRpMDhGOUlFTmlDeEh6OTlTMUh3dnAvREVDL2tJZ1ln?=
 =?utf-8?B?TXBPNHd5aUpJdXA0dStSMjE1eWpubjAwRWk1dHk1eDhNRVRQNTNrc1NXcVg5?=
 =?utf-8?B?V3BEMGNZeGpPMFpvcCtUSDRJb0NhQlk4Q2ZUN2xMdmljdE5wUXJSRU1yZVJy?=
 =?utf-8?B?by8zN2p6N3hBRFVBQUs1RUlxbS9CSk1hMm5GcjV6MXNVNTl2SEVDSFFDRE14?=
 =?utf-8?B?aEZQSzRpYmxpejlhQkZRcVhheFhKRVd2TjMvQ2dmTDRhbUJpSDM2SHpCeUpj?=
 =?utf-8?B?d2x4eGhDVlZldTNzQS82ell6WER1anlHQlhWUUtObDBNQytRMkFpekhFYmlD?=
 =?utf-8?B?YjNBWnVYakx5ZHB5UENyLytkZ1ZhNVhzOFc2YldoeEN6Mkc4V3dZL3g0S2ts?=
 =?utf-8?B?VjFEckpwNHBRTU1pTnNDQXhRRllUQ0tmUmRzZjcvNUx6d1hWTWo2OUpabDEw?=
 =?utf-8?B?RGU3V01CVU9uSkFZTXR2ZzEycFZLZ3J5TVU0QkdzdDU4bU50WnEvMSsxMEF6?=
 =?utf-8?B?VUk5b1FMME1lUWt5UU1MdXFvZGlGUEI5QUxxeGp0c3VDRUVsMFRKUW5JMzlw?=
 =?utf-8?B?Z1JYQ2xsN0ViZE1HTGNZUmFGRFNMVEtDcHFUako3N1ZzRVdvUHNTZ1RLb21h?=
 =?utf-8?B?c0VlaUVkTlQ5SVFTZ3JoTDVOT2d6M1hoWUtmdVBCbHljbERrZGdWWEt4MThD?=
 =?utf-8?B?QUxseWJqbjhoSDFna0hoVU1TamVXbysyZE96U1hIZSsrVDg2ZEh5YkZJeFY5?=
 =?utf-8?B?c05jWTdieXVVQ2N0d0RvU3RkeHMrbXRYS0UyNVlFOTJ5UUJFMmFiV2dxNThD?=
 =?utf-8?B?M2JmcGc5VXVJTk5lcUdzZVlXOFJyS2lOZ1NaSEdiQmJuUDIzOU5oTGxCc3hi?=
 =?utf-8?B?dkpuNWM1Q2VTUm4zSVZaZlhTS2FZK2FlWFBrdTV4b2ppMUJ3SHM0T2VsRDMy?=
 =?utf-8?B?NDl0ZmtNVGJMVzBzd3psL3NGT2hNdVhrUDV2SGRmVzdLeUdiQkdDYlYzUTJn?=
 =?utf-8?B?TUhrRFpGOU0yaHd4eVRHMDJScW1HYlpFZElldm1wVDkvVUx2SHM5elJQU0pY?=
 =?utf-8?B?UkNheWV5RFJvalMrcS9hUFl6aUJtcVltTWZGR0Nwazk1NlBuSG8vTTgvMWdF?=
 =?utf-8?B?dUNtSnhvT1VIcnIrdFEzbk5XRWtOWjdBTzVMNUNWVTc5ejBDWjErMUk5ak9V?=
 =?utf-8?B?RGtJN2JyMWxSMjFPb1A0T2JUMG83UUcxWHljRjB6Znd6REp6WXBBVDlySWpB?=
 =?utf-8?B?Y1djMFRSd21COTltTG10K0VuZ1Z3U1hWMEVXeFJaTlJCWEQzSkY3aEFOK0RB?=
 =?utf-8?B?M0ExRVJVMytNWTVtaFJXL1ZrbkNWZXZQcm1sWnZkaGxMK1NKWVNaRy9KSGE5?=
 =?utf-8?B?QkFNV2tiaHd0RHNxdTN6RE5OQ0VKTXBjYXVwcTZka0t1LzZicnN3dUdPNWpS?=
 =?utf-8?B?cSsvMy84NVNuanphejRjcjlaKzdaMjBVeXB2LzNiWGs4WmZoT2JoRmlDV2E4?=
 =?utf-8?B?Snc5QTdEQ1BQTWMvWjVPN1h0b2I1UHNHZGhZOENpU2xyNk8yWitHNGpDeXdo?=
 =?utf-8?B?TS9MK0U0MXMwSjVUSDdrV0pUa3JSaWV0endHRm5FdWpGY2dlWFJXSkdIOVBv?=
 =?utf-8?B?dVBZeFpmNXRRZkRrRVgrQTV6VnhVVkZRYmQ5WURENlRlOFZQQVpneTRJeDJy?=
 =?utf-8?B?N0dvWXhwbDlpR3BQY2d1MnNrWHZYbUsvQTNmR1NNcG9ISU5NYXkwMlNQaVhn?=
 =?utf-8?B?dkJQT2tpcWk3eGk0aVY0MmFtU1hMNkJ1cGZkZENreFh6L091RytXVFEzNkFU?=
 =?utf-8?B?dENHelNyNG5CM0t1QjZTSFgwSTdkcW5FUFBXNkZ2WFdQK2hUeWFmUGY4cFY1?=
 =?utf-8?B?QkhYeHNvWnQxcjVLNXByQ0NSK1l2MSsxdldHR2RMSndNVDA2cGNuOE5laWV1?=
 =?utf-8?B?Mnc5b3ZFN2x4ZnljRVVGU213ZCt0eEJ1U2RHanRXNDdpck9EYk9Zay8yZFVq?=
 =?utf-8?B?VXE4czJzbFJyaDBmK2ZPNE1EZDQ3REFuUDNrbGc1d29JZjF6RC8ySGQyRlFa?=
 =?utf-8?B?SDZQa01Sbi9zVUpDODVNT1BTMUF0ZjYvWDBWbkdmTHpwajlvZUJzbUFmeVJ6?=
 =?utf-8?Q?T5ma4I73FsQkyXPk2vuiDu5dP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee10a6ab-ae4e-449a-a610-08db8e6f63b2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:06.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkKM38RbTZJ399X2+EDPjZfd4j84cM+tgkTg/E/86ZTNB5Zxe+QVEtFzr2tl5221htEPRQ+LpBEZ+TA6anmAyg==
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

