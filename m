Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5237647CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjG0HH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjG0HGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23DC2D59;
        Thu, 27 Jul 2023 00:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbOyQ+VUu2t0/Os8BuLYWWbB6tlsGoiAIDji9HyGtW+BDZ/FgAtCvVz95nu0S+l6Ibsad0BCA8OFG/WX0S+VY1pw1a/EFSuBQ3+RNAl8jPKHyPzxa/i5mL+wIrskP6vmUUMNKMZixz0AnCf2BPQhLtB3Qhke2DcsIuY9B179RZgtwrUVVTME6YqoRQYpCe8ncEMD7hapEUxHdlrSNZYneEKJKbNS69hE/yKNM6iNI+ZR12Jl7a6aTEYHnyqo1kuKgMekn0nUWpD+nKNgjh+UMC6jTwvSz2OtmsXTGnyN3vSo4L+AIhla6+CL8atLsyG5STA9/JV3LHgwIUEOyB264Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBSf/9i3zQclFjwDcshyOLYHhhekMTdzc9fBvxv+964=;
 b=Fwwpr0+nOEXHMJWoRAhTg9SFe3nz/ERDz5apA2PuR7vVutpZCSX2/J37UWx8dMeHZalcpJcRpV3Sh06+8umjzI+SYvXKlo8nqQjAuUjbnmmAWw1Wnz48rRMqQlqw9GdTbHvMHEsQa2yiEwmgcI+SF+C0FQeBqMh2+AE7vd+cXzJN8u7G1V/mFxvaldyHKm7D+SDgu966hOEOUCUIava65KBDftm75WzAWnv6mdkbLWbnDruV5q+GiMV8n647ed03UPWYiU5sDLD/2gMlD05ieBHSLyfpu50uHAz3IUl9W0SJLBbRjbkF1hvOz53sYhBoxUrn+1UZDnun1Q9myDuApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBSf/9i3zQclFjwDcshyOLYHhhekMTdzc9fBvxv+964=;
 b=E0A45lEIhWL3WS0w31B7u5Tjqbqc0Uylr5OKJBmv+4EV3W9LYxuEnE30xAqBfZJT+3LM9iuXM25SYFCXCsRKd1Cck/L5v4IwESnLldfU3F2w6PFxxh3TrTRJNhGODVv0CdDO/R00r4H48AUrckAa+J5MCbplHSkbTpgO5H42vEZrX6anl5XFCm8FfXSzztmdpM+pYspiH6Po1mXGyQN1fRY4YM5NaBVeid1wu++FGhaPQig4EZArsivx8uXznxognmOIu9mtev+daX84/81/p6oO0FEa14cC0Fzql3Vgr6lPiJ2W4h/O8/4IpujkWCiKgabstJ1kZA79qtFTLax/Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 37/62] mmc: sdhci-acpi: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:26 +0800
Message-Id: <20230727070051.17778-37-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0508ce-8815-4f5f-9058-08db8e6f6224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7+9hD/nJRmruY7gioIpTxgwUpMaxfpH2x9SBI4rE/7jJJB1rfRCCsCpAF3n3hIWkHX4mtZ+aHwHYC8uGMnsRbQQ2nFspX1Jjpd7F90BhoRlGqHjJG0CJmXpu+ec1QDMU8WyAMO0VUJw3vW6Zy8PfzRTfiRAFuGVcVVZbwLNO7IdMHcq8L28gC+wUK8PlILI9fZVevndxZhrpw15s0X/F488G5Ufje2ODQiyvb1nuPU8ndPLbLtaf12o0rgxY7C7X4pv6Xy4CDK7jXV31Y7NP1bUacWoYjuvRpOLkhnbziGRNTQQZK+AmprL/72WtHQKbwO/MQMTYVBgpp8rQVw8aeN2VTyHG66+r7veZguIip7MBD9i0x5FrPW5AhWGBVau4UL0pIiGK5Y/HenIf0mm0RyBvB3Pzy9ehnWRD12UwG5yLFI4cYXANRCqOkmrGi/PwX5bT8qWe+ZRigt0G8x1L/dYO8+FH3Hykc99N+nD2mcPgPVZRZNn327+GVwq81napJu88+PVzbyBEwo/BZ18+JgRyM1b3jGtAUaDnPxHe0KEwoGK0fsmgYbWo/K5s2MXH0cEzkYiWGCy8S0fgTLfTy4p4ipo9tsEugsLnNUdwqbSepEECvPrQUbPJudhDAj0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFh1ekZTZ3oyYjJzS0VLM3pBeXZQMnIxK3I1OGhtK1hrTnpZUFZFOHRPNUlh?=
 =?utf-8?B?R1luVmhnR05OQklYZ2N0OGdZRHZ4d3hKYWZydkRXcnJhNm9rL2cxYWlRaDlG?=
 =?utf-8?B?eDNlc3hSd0NwbXkvM3pQN1dWRG4zb2MrdXpMR2ttc2xWeTd1L2tVbU4wckpi?=
 =?utf-8?B?VWRQREJPTXNac3RReEE5cHRadEZwdkxETXBZMG9kMmdvQzZSeFlYSWwxV2gr?=
 =?utf-8?B?bEp1YXY0bTNqaGxyRlZPZjFlMTI3WHpIWGczbUFLN21iUWI0VTFLNm5TTnBi?=
 =?utf-8?B?TVJNSzBmSTZkaUllWWhYcGJ3ZHl4WDRRS05iYS9lSVZCM0YvUVlyRGJEMWEr?=
 =?utf-8?B?T21ubFVNa2pmT29ES2kvT1RRZ1EyQjJyVDdpUW5rSm80VXhFUVY3eU5WbHZs?=
 =?utf-8?B?NEc0VFI4K08wZTR0MUNPNWJmTnpmSzExQm96UUVkZGNKQlB5dlFnVDVrMlNY?=
 =?utf-8?B?c283VC9PTHljdXFGK2dhc3JPUXdoSUo1bDdQazkvclBrNktxQTc3ZTJxQnJG?=
 =?utf-8?B?V2xKOXJYQWY0ZXE3eGQrVHJ2N05Ec1dPRjNpVDdGTldIKys4SkhGb2s1bUFX?=
 =?utf-8?B?azk1eng2S0t1bWQ5WGNWZ2dHZ0R3bGUrREswVFB4MitaeFlaWFAyWDV2clgv?=
 =?utf-8?B?MXgxeUw0N0ZsUitQOTFmeHNEUEMycjlObTQ4L0xLbVRNcjc4UUdjZzhDZlZW?=
 =?utf-8?B?eWxIUnRGMi9jbFNEYmxWY2RUeGFYK0Npakk5bnVER1JrOTFXaEM3d3hIQnE5?=
 =?utf-8?B?c2FRYUI4dWdUU2pYOG0wcUtSTjB2K0sxZ3JqYjdCOGZDYU9HclZibVY2Smlp?=
 =?utf-8?B?TFFIWHFydUl3amlKaXpTL3dCdmlHTjc4aksxM1BkYXd0a1lCQzYvYkN5TzQx?=
 =?utf-8?B?cW1qK2p3SGxYWVMwRkJzTjFLeEhVaHNVK25GY3ZNcGE5ZWljWWJNMkJ6ekxT?=
 =?utf-8?B?N3JUNGJML1YxZDR4eTRQOUladjhYclBKNjJDZ29rNW5QVFNYamJrNUNrWTNw?=
 =?utf-8?B?VGtDZHhkUHc3YjJuTi9pa0ZIVklsNWxKTTJUZERWM0NGTTZ1cTJYQUVEUDdB?=
 =?utf-8?B?cy9iT2RpS05SbmNGVkVOUk9JcmswVFVLL2tRaXh4MWwxSVpqY3dCQ2dqdnM0?=
 =?utf-8?B?RlBOYW5IYWVxTlpSaDdtK1VRdjF3S1lVSXd0Ym1WMVIxYTdvR0JsVVhYbGdK?=
 =?utf-8?B?by9PSk9Sd2p0OGhrMmxsa1RLY1FNUnJzRVVnb1ZINUZlU0F4ZVRDT2kxNHd6?=
 =?utf-8?B?bzFuMWxYVG5sTUNEY1hCTDBvK3REL2JpU3ZKTWl1a09WRmtwaUVtMWNIUWEy?=
 =?utf-8?B?ZDhoUTQ5VU00ek9HWDVUNExXbHpoOWN4NFNhcTYvTk50Q3FnYVRlUUl4UEp3?=
 =?utf-8?B?cnlyQmVDdDdWS1RBUmdrU1huQnV2eU1BREpkejFtN2M3SHdxV1R3MDJzTEQr?=
 =?utf-8?B?WXVEUzdyMlltR04xR3YvdWpkUlkxaFBRRzZWNVFxUG0yaWFxQ2xBY0VMOEQy?=
 =?utf-8?B?N3RNTFltNW9oRkdDWG5vd0tsL0R0ckI5N0Iza1J4M2dYRzV1N3VnTWU2dGRS?=
 =?utf-8?B?MFVFM29hWXV1R3pzV0pDL3ltN2NTOFJPaWRjZkMrTWNxTWoyZnFaanNMYjlK?=
 =?utf-8?B?OUdhQk9uNGtxUHZ2WkFYdEptUlpOekVBSDBZWUtkZmY1S0xTRlk4S2N2Z3NK?=
 =?utf-8?B?ZThKVUZvRGZxQUR2dktmTk1IMnNDVzAxRUE1Nk1RanFxQnV5ZE9vRU42WlZw?=
 =?utf-8?B?dWc2ZVlMZUU4WEFtTExUckNzdWozWCtpMGlHQ0ZhcFNZeE11RUxtRWk3OTZv?=
 =?utf-8?B?VXJZc1YwZks1WkZwQ3BTdEY1Ni9aVWV0SWNDRU9ZUmJ1N0hmZVZJTG5sZFpi?=
 =?utf-8?B?NEZZMTh5elRUVUtsZERKbjhYcmhOK2NQU1o4SU42WU1qNmNOa0F4bi9PTlJP?=
 =?utf-8?B?dXJ1TEJMRE5YdGdjdUptcmV4NnV0Mzdkc0lYTDNPaWhYcDF3OXBMaEVrYnVF?=
 =?utf-8?B?V1E0ZVVRK2FsdVUvNk1vc0NPU2h0ZDNyMy9PbWhZWTFNTDh3R2k4SjRVSFI3?=
 =?utf-8?B?cHBaTHdQN1pwR2JPaVdZYzliOUl1U3FXNmR2cTBhem03dm4vRi9sZFU0N1Vv?=
 =?utf-8?Q?VuvUDpYJpDb8/0bOIIpDabm8n?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0508ce-8815-4f5f-9058-08db8e6f6224
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:04.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3gWQHulfwxG5uPOEFU2t5fkPE0isoZz0tjeVFCN7dtH+ywAmXtm0UD2W8hy+fNaE66fs2Yuzd8RDri1N7QPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
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
 drivers/mmc/host/sdhci-acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index edf2e6c14dc6..acf5fc3ad7e4 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -917,7 +917,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sdhci_acpi_remove(struct platform_device *pdev)
+static void sdhci_acpi_remove(struct platform_device *pdev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -939,8 +939,6 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
 		c->slot->free_slot(pdev);
 
 	sdhci_free_host(c->host);
-
-	return 0;
 }
 
 static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
@@ -1033,7 +1031,7 @@ static struct platform_driver sdhci_acpi_driver = {
 		.pm			= &sdhci_acpi_pm_ops,
 	},
 	.probe	= sdhci_acpi_probe,
-	.remove	= sdhci_acpi_remove,
+	.remove_new = sdhci_acpi_remove,
 };
 
 module_platform_driver(sdhci_acpi_driver);
-- 
2.39.0

