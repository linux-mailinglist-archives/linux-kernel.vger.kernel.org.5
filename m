Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00146762A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjGZEJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGZEJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:09:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::718])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49055253;
        Tue, 25 Jul 2023 21:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0743ghStL1fhL0oYcZkD2DecqPTFbAyV+j7JKpoto09YzIAtB9qHRBwAf8YDbH8AHhVR6BlvssG3YSK+O33tWO7FHAvrjkuxhzg/3TC077OmFK2L72mqov7TzUMwzzvU96+uycwGuS1967rHF9RKNgZ/fH1qB77bPEKiMRBUqbBxREWJ3ZUiUU3aAAVeGqnVts829mOELNA2k7S8WY13tZnNkKPmkZJDcMHnS3XLAgNWmId1DMKJ4SN8cRw4W9yCg+aIbRC/bbapRcIA/hfqEIx0JMuS0xbZeZ/q5Fdqmko88mHqS+MuprLd7utQKjm4xqzOMMglEJtwKmplVpmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT7qOQ62I2XJCm8fWlnztBkYfBsGaUpc/87KVtpwDDE=;
 b=Eib3BMpdi7j3AHhVkZ+1Oxl2qQGS11DeqOanpTtotzbg9dx5s45p9r5vExddV7MrmtjJffHhZYoAKn+D60BGFxGIa50p08t1hDoE9aNnN7XAVBvQNvxUB93omRX5GN51AoBcOEyuYChlFKa8KkJD3N6xChpeuv6HIPmBKTUH2DKITl0S4Xvd3/Oi30Z5M0A9yHTim+U6eLX4UxLiifpbpIdXr/nLhTB99ObM/hNL0J0ZHAmM5MzpQ8ZKlyRop0oRvAUfiX4Brvqw56cT7i6P4n42Kf3lsBJ5phxFSSZiKu+h8IKjiuieQnBaAtXm0QvW+//VUUNzDGKfeiUycc2IrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT7qOQ62I2XJCm8fWlnztBkYfBsGaUpc/87KVtpwDDE=;
 b=AjLoFDB9aFbTu9vqm3L7g0XZRXzKGaAdDoiwYQTl0QzohKaR074OhoGWQJOFSQg4N5xJf9WrsIOwJGl8slZEzsIAR18n5cW5mVfeGqoFns6PEtz6Mo02EQG/vwkQXwdeL53SSVZ1xh0z7WWa9r34ydsJhMKhSEbJ5DibmGANkf6JG+ji6bbnynIgUPYG4M3m+BcQTi0MiaW+B0sj8tsCNkGYltmMoF1Y6pVnHxMllQgUK+yclkpujpU2Yb4yJifuDN2cMWc8RReJxzUIOQwduhVHtN7dCL7/q20DGzm0Fc9Qvy7bX1jJ4pihJSyKfgwZxKNVw3DTgGyYkEpKyFH2PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 49/61] mmc: sdhci-esdhc-mcf: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:29 +0800
Message-Id: <20230726040041.26267-49-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9890010-9db0-4489-4369-08db8d8d1e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1IW+v+vJdTiPZfDeONYNb2raq80F0cq3HQsmjP3DpCfSAfgp5Pqv9PRwECZ6C4LdQTxbcfWXcDGEp3gt85SdnoXMq5tFqLiamxHsw4zz2afVYfDuG7lKHhKKmMu/Ly2VXLqsdNOsnYyHXBEXrS73EQy6h+VcXwn+7d1XvOmKZ6zr7Or8x7wlk79NGoUt+VfP8OahTaFaKOI6WmJhOGrKN9b33l5Nto6SuDX/kqLxF5nJrjfw9eB7R6Er3lvfublZTU/doWpnT5WqTthuzoG+46Mc/pg1IHMQT0CPYIsBjQXsYyZA07IooJRwKNYU6rf1o8zCwxIQf7A7lrCANA4dup9RMmOyYY7+BkQcMcHqbwP19Con+X9T8LJY2mgETRnZrrPdCgM996B8jazI3ELO9jx6Ld9zILsXTV943k/9rIgMfNeew8uFvC/4Z7GMSPo5jwyzyXuEXeYKm4Xc7+AFsWGb5F2q9pYNWuHKoK3FEJtOMUvq0VQpYg2V4hDkydXlfi6hiVPs5WF9WQNnKXc/09JL+0A7H3oDMCLrv8sSHLQ8dezg8qscAPqODWL4QdYqv/jUdByoL71t/kr4Y265oXSz+ErtWzBN0XuIB38dndn0jy9lABLIllXYyBeUQo4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlvTDRrUGIrV212ZWdMOUhEaGZ2dlhNUzgvSEp6MUFEazBTZ1VSVkMzNWZX?=
 =?utf-8?B?c2ZDN3BMTk1nQjNxUmZYQkdDdE91c3k4c2NxbHg0c0ZXc2w3TkZUSVFaUnQr?=
 =?utf-8?B?N0E1dGdEeWt5UUFiV0dTNytkZWNzTWZoYWtLTnNFdktoaStmYWxFMVJCcEFY?=
 =?utf-8?B?bUo3MXd1VGdiZTljNGxnUDMvVFVPaVpzRjFmRFFuQjNtKy9NTmE2OFFOTkJE?=
 =?utf-8?B?NGk4T0gzZjd6K2RuYkdRYWVzQTYrVmltb29oNmgramFqWU9oNjVhclhFQTJa?=
 =?utf-8?B?TG9jSzZjNy9uRGlhdkJmVzJXUWl5cVM5bjArQXVpM1M1QnliSFFoajZ3K090?=
 =?utf-8?B?NHBOeVdOckFLS1RpZHVua0RBbGFxSEZKTEZBMi9LQmhMS2tYMFpORERzaTZr?=
 =?utf-8?B?SFhRQmQ0dmJ3UGFSYldRVDZlQjNZNUdSQmt2NEY0c3VweHBhV2pJWDRBZTAw?=
 =?utf-8?B?bHlwdlczRnBBNnM0NUZlZ2VxZ2FCbEV6ZE4zYTAyM080SHdlVnNTSzlaQ3V1?=
 =?utf-8?B?OWhMWWlQRlFSR3l5VVFTaFJ4YktBQnk4Nno2RnhmZWJDMXFZUklXT0JMR29Z?=
 =?utf-8?B?K1VoYnAyQklSVzI0ZEFCdlNhN3JDcEcrQjV5N21JK3A3V1VSWXBtUkVndFVi?=
 =?utf-8?B?SzUrWldrRGFOYlNPdG1laHJOak1FUDBqT1kxVGZOWUl5SVVTOHdId3oxaS92?=
 =?utf-8?B?NEdZODM0Z3FZQlZBdEdNeUkwbnV0cGlqVlA1aG04TGR1WCtiY3QzTTMzNytk?=
 =?utf-8?B?MGNrVTVkZ3AxMy9KZnF6R2NuRmRTWHRBbVFXS2xzMzJ4UTRibE8yK0NVbnpE?=
 =?utf-8?B?YWI0cnNteWw1Q3l0dldaWitFclVyUFkyMkcrSHRRZEZCd3hPMkNtbEVMTVVI?=
 =?utf-8?B?dS9IdjU5aElncVNKeUVzak1pa3lVTTZsTUx4OHJ1VHUrVmovd01zdGN1M2h5?=
 =?utf-8?B?aU5FMEYxdjFJMm92dzMvaERzaEZjRUFmOEVFczU3Zk55Ym54T0tKbGY3L2pl?=
 =?utf-8?B?ZncxbndnOFNoUXF3dXY2T3hvb3BxenBXcWNJQ2l0QTVjLzhHbWpmOU1yTDhk?=
 =?utf-8?B?NThLb1lzWSs5NmFmYmtCOHFXeWcyTFhBSkxFRGtpanJKZkw4akNTc3pkSWpP?=
 =?utf-8?B?NFVSTmowcldBNHpFTHExUCttWDN0ZEJqdTk5S1FEcUl5bndhTDZEQ2MvUjBo?=
 =?utf-8?B?TVhHKzBWVVBpT2kxcmJoNmU0WVdlem5qZkF0bjRXVXBERVp2bDVuckdDZSs1?=
 =?utf-8?B?T2FLSHdkTlBiV05XbFZCbWo3L2Rxd3ZBbkFiYUhCcmMxVzUwRU5BdkNrOTJn?=
 =?utf-8?B?SXkvM2FrZzFyWnVXZGNNNVZNaCtqMDRqTWZRWVFNdEVJZnlSanlSN1RwOTIr?=
 =?utf-8?B?U2p3NTAyVXVRb0pETStqMitGK3hrSFNGT0JoVlFzMWJ6eVpFVURSaGJPZE0x?=
 =?utf-8?B?anRncVIxSDVLYUhRbTFFMkxLUmtKWHRTT0h2U3lINjYyU2ZVYnpBMUNaeWZv?=
 =?utf-8?B?R1JUY05uS3JhOVErTDh3U3BYM2lsR0J1ODJhenYvNStoNkdvM0xJdGIxS0Fr?=
 =?utf-8?B?ZGwwdkN2SUNzR3pGYk1YeDFVcnhsSUx6MFd1ZnRLc2UrTGZacUNiUFBmbHhL?=
 =?utf-8?B?Qyt6RmVJY0JEVmYxVDZBYTBYNTRWTk5wSXdKWkpDaTYrSC9lYTFyOGtLdnVj?=
 =?utf-8?B?S1NBaGprZU5CamtrcGFONnlyOFVjMkVNQXF3U1FBQXZjV3pySCsrdnVCTUxY?=
 =?utf-8?B?MVozbXJRMy9ZUmNtTVRuTzhHS21Lc0l2ODZNLytrc3NDK1dtZDZqSndWL0hm?=
 =?utf-8?B?cnFVQUVyeDZoMXY1SXVBOGMyMHRMQjNCdXF6SXVFU3RXSGNnUFRKcjFDeFA2?=
 =?utf-8?B?SWtwdFJUMjZTaFJqWmppUFJQSFRRM1hCZUdTb1daQ1ZGdkYwMjhqVjVzU0Ex?=
 =?utf-8?B?TUJDc3JiaTc4QTRPV1dBMUQ0ZytGc1JjYnZTdGlvc0kxcnJiU3FCbGtuYkox?=
 =?utf-8?B?dEVDMkthcENyS254Z3JNalBLVXVTblArRUlaUDZ2SzNFaS84elRFMzRPb1N0?=
 =?utf-8?B?Q1JyKy9HMWRTUFNvVzdlR0VRQWhPZ3JNL2QzNGlLNGlXWmZiaksyUUpBcVVZ?=
 =?utf-8?Q?ReAvyCI+mqod3YzkaezaOWYmi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9890010-9db0-4489-4369-08db8d8d1e93
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:24.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e6/KT1yLzCuutA7LTshaDm6CJd7CQMXvjbkehI05pG/DvMqSoAvaGyZ9yeZ/uI3msAxpWwltp2FhVhQFFMRPw==
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
Acked-by: Angelo Dureghello <angelo.dureghello@timesys.com>
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

