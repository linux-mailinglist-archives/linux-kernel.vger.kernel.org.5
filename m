Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E420762A22
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGZEMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGZELf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:11:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF759E6;
        Tue, 25 Jul 2023 21:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgAsCjfdC/TUybPe7ZxwmyGgNKzdlDO0oxtyHwxw1C2EnQqX2kGjFrsGkFCd4PIHLW+6FsYvJ4CaK3FW3RrPM3ZSJlHbJO6f61Lbb0nTH4z/Oi4RrY8BPXXPL5uhoK/XKkTM8x/k+RMI9HwR1sx68Ok1ipk1pBAATl8L70bF/tL0NkHAaOG/0hb1ZDQf78TRhWvX1U3AQ9lHSvrQwDVYAew3pTFhOrQ7kC7WB8ceYoiqqQtsZ8c74wOCIszujg2zrfpWpr7US7it0NjcIGCOMIEB1/ME+Q38JsNK53O2GtgUUwD3UcKz14y0Yng8sz7KTuYUprXl9qO6cK+xe4UXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJjqUjgHWeahu5kEIR/X9k3lXldr083Lgzi2wWxD1eo=;
 b=DejwugKGuIOnjmGLkiLQov4/9RwJa1yW3zMn0jeDYg/tW4JM0/5mYwWoWHbo7GHTmjQIeTCXCVKYx73H2vL654ltkgqGntZi2s6or5HlsNHUnOe7zX1Dwl9wYND3iX2GxgD+vRqoDhcs5fNIsaqi6sksMgLAK15dmO0wvTYbQ8QSJHPWWQdnbkhSXTiikyLvZ8lHMKCLTP70OduovhC/jDLsNwWGkC26GKxKC2vNwp2ktbHtH+OGU4aUFo0ub1V0NHhhTLUJif2yEfQpDHz7ZPQ5WSLPTNdfMnFjMA+lIjLIIZQ2mN+ZqatnMS3rXd+87uM0cQmxotYZmqITiQaGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJjqUjgHWeahu5kEIR/X9k3lXldr083Lgzi2wWxD1eo=;
 b=dYCKlaJKIj8PCUaW1/Pn4s4RQShxCdV+PdA6BdZftg2Ym8SSgbeEbO8FLjCFNfEPK+qpS83sCGtfzBqILy+4VMdZB4b1AgmkeeJy3/INu7/r0Bz88vCEwFr/vQN6j5dYOitoqCDNBt4G1KL7i7qV2vL5ZdGsyCH12P6cAVo2wJL+WY4TggQFs8y8rYCUY/HhFgXVbeg+j3oKBpfwnNEzWCnJkDC7mcq0rQrx8cSt4h+yt8RcSEebbYvjmG9xRMPcVKGhz4Nj7vBiFIhZK+MAJvFt/7qm9jcd/1xLTvHJYVfLz4cWAFScqps/7akjhY3SMw6u8vf+XUcmzmrn+b8gzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:03:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:03:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 61/61] mmc: sdhci_am654: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:41 +0800
Message-Id: <20230726040041.26267-61-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bc3305-0b5d-4b90-25c2-08db8d8d2a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n63cqTxZRuX5C1c58SSmh8ZcPuWf0F27TU04u7WOrmce7VpeXxft/bWrUlusJr9UUI0+5Xq6LzAsEeLxwkqxkwCA6ITl4IsCzoVOSNp3OC3ZwCpsjjMWhlXgiJUj2L1HngkVuMdTWWit5InONPFEkq4alA4u37oxPFJGXEvXfttq6HAbFT7fgrjX0nSLrRnEo4AfgvJo3kGfjts07n1hQvWbQ4rhP/BNF6Wf7z4ww+EvjKU2D2nKiPvfmdG7UIsIE/NCkgtjboobQT6zklD48+q5chyWBNtBovO3n/JlNynir64ph481Dss6Wv3vTCkEkguHokqRoDw/YXX+CDTYe3/Du2Xla+isOhyOvV89kI2zFDvbjKntmDkyDeFomz1CbEpRHV0+CSDWib1tVqxbJXvc2n8Ir7awRvM0gWDvjbknhkBxk643KDbjoc/rDs1C5+Z5u9NtWgnpJ2k2ZJzeY0pCtjz+KUt4Un/fSlTm/Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnhuV3FpMTN4S2g3M0I1NndxTlRwR0dNZmtvTUU4dlAxNm5WaTUyYU83MU5r?=
 =?utf-8?B?NGRwZk1hNkkvNkJZSndEMlBXamRCRmlxYmRPTGRPYi90NHRpMWFPMmJWOXlJ?=
 =?utf-8?B?RStZblhtWWFZMzBkQWk0VkpaVHJ0a3Bra2NiY3Y5MnQ1T010YzcyV0c4VUpu?=
 =?utf-8?B?SU5Pclk3SGpuYU03bi9ZbE9sZXlCRzd0UWs1dDhHQ0dPcUI1YnFTT0xTNlh6?=
 =?utf-8?B?UG1xSXl5YzhqWlJsV2lwTkU2WTJ5SnhPaHI3N0R5V3d5V3JZT0ZDckNMQTRi?=
 =?utf-8?B?K0JMRTdJcWlaZkVKRnhmdEMxaCtZYldJbm9SaXVtcEdLaVpCemhicTZIenN3?=
 =?utf-8?B?aTVteEc1amRqOVE0RHhLaWJveS9pZjNSdXNZUkM2VlJ6ZU5Jd2MwWHhFTVdU?=
 =?utf-8?B?SHVQblY0aVR4aE1LSWZXQWV6by80Z1dQMkpjcVdRcXVvQUprbDRVNVgzbVli?=
 =?utf-8?B?V0Fpb2pNekRWK0paQVRuS2p1MjlvVWNNS1hDN053VGhsa3NtTWpGYWwwSVBV?=
 =?utf-8?B?eFR0UURZcDBMeEp6VElSOG90TXhsQzVCb3REN0JyMDJ1anNuU3FGTUNpbHpT?=
 =?utf-8?B?VThybEV1cmNzTE56V3FObEsyRDJSbFE4cC9OL2Z1TG5EcnIxdUd2a29PY3Bu?=
 =?utf-8?B?WTA4L1R2bTNodW01Z2pUOGtVeG8xVDNuRGh2azhjaFRDUzZVa3huVWJFM016?=
 =?utf-8?B?RitEaXMza0hqL2NxL0c3WWM2S3lFL3ZFb29rQ1hLTmdvdUJSOVk3SnFBd3lu?=
 =?utf-8?B?SStVOTJQWi8wUk9SdTU5di92YjBPQWExbXBUSFRNenRCbXNFT2xnQ0V4ZkFz?=
 =?utf-8?B?TDN6MmZsODZkdlF1cytwMGE0R1BncHU2VjJZWHVuaUwxZ1RHd2E4RzJOVE56?=
 =?utf-8?B?NGVvUUU4QlFIUmFjaW94SEUrRS9BcHRLUzRlZ3RTTjNqMFYwWmFnMVptN01i?=
 =?utf-8?B?MTdOQ2RtbmVYbGE3cEt2NnpoVFRLM2dDWk4vOEVQdC9ZRVpiK0w4aXZmSUNa?=
 =?utf-8?B?ekVid0lCa2lCb1NFUzVkdlR6U0JUQjd3YUorT1h6YkRhZTlXN2ZxMXB0c2Q0?=
 =?utf-8?B?K1hwRjdxU3E4c1JCMThoeEhOTzlIN2N5QXNEVFdkbGEzK3FGZ2FvL29QS3lo?=
 =?utf-8?B?cmNlV0Zyb1FZNjV0MFR1TVBSalAxODZucHpIV0NEbWszSWVDTE1PUkpVb3JP?=
 =?utf-8?B?YTN3TS9SaFV0Z3NLZmxoZGdWKzJNMjBrSWsrWExGbGUyV3NWTHFEdy9QYnAv?=
 =?utf-8?B?TnRJRHkzZENZOXR6bVJhSksxK3VrVUw2TGhuMUhNRXA3L2k4RWxwaGUreWYz?=
 =?utf-8?B?WDBLTkg2MlBHc2h0VGM2Z3J4a1JUcmJxMXhrZmh2emRIQXJ6TmFXNFFacTdE?=
 =?utf-8?B?L1FwYjZWTXJpVlBOS04rOG8rZGVVZGs0dzc5UXB2UXNnRzVLdThZUHlUQjhP?=
 =?utf-8?B?TVBPNTdXMVZOOGdZNlJmdWVzQzZPZWxXbHZsaFdkNE5maDI4bWZ0L0plbWJH?=
 =?utf-8?B?Z2pwVGVwejZKRW9JQnliRDd1dVpSY0cvYVFGTVBQS0tVOURrdUp6SmM2ZkZV?=
 =?utf-8?B?ekdoTlhmTk9HNSs5Y0xRbkJVUE5RVzZUaVhJQTBpb3lBcHI1TDZqZU44Yitz?=
 =?utf-8?B?Qnl5cXZlTHczeCtGdDN2OTdJRmFjTXZzN3RUdE1YeUNERjRXR2JDbFZ4RFg3?=
 =?utf-8?B?WE1jdkpObVhtYWxJN0o2MjlvaTNHK0RwRlh4dDZnaGRmVU8rTy8ycm1yY0sy?=
 =?utf-8?B?UW1VRlQ1QVIyRFFGdHdBUHhBVlJWYXB3em9DbE1jV3JST1dhWFBMUEd3a3Z1?=
 =?utf-8?B?bzVLQmdRUmlKK2pHOFdBR0hFQjM4L3JoZWMvYmJCaFhUM09lMUtpc0dwdndz?=
 =?utf-8?B?Sk1kNklpd2NrdEdrZmVVT2hkc28vRDFCbFl1K09xTjR0bXNmMktWdnpSdXR6?=
 =?utf-8?B?YmdadGFzOVJYMzRKd2hDekVkQ0g3RWJZaEcxVG5uTkZHRlJlT2hVZS9vZjZV?=
 =?utf-8?B?Ui9ta284anFHbkg0UUJ4OE5Wa0hGeDhSb1FVOFczaVZnYUg5ZUdIRkNZbkRt?=
 =?utf-8?B?cEdwSGxwNm1HVjQvK0VuSWNLYVZEVzVNTEprWVNlRUpLeE1zaWNCL0lacnRv?=
 =?utf-8?Q?oymwm7zNeO2ofhcaHHYxz7CPk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bc3305-0b5d-4b90-25c2-08db8d8d2a8f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:44.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMCkyedP41wVUv3Adej1EieyyD7LzSzNalaygVgfMYvYHfpKuhkADKWJ0va4cNYo+b78S11q6GNFPv2l5Kb+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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
 drivers/mmc/host/sdhci_am654.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index abe83736d396..a6ff09ead28f 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -866,7 +866,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_am654_remove(struct platform_device *pdev)
+static void sdhci_am654_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -880,7 +880,6 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	sdhci_pltfm_free(pdev);
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -992,7 +991,7 @@ static struct platform_driver sdhci_am654_driver = {
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
-	.remove = sdhci_am654_remove,
+	.remove_new = sdhci_am654_remove,
 };
 
 module_platform_driver(sdhci_am654_driver);
-- 
2.39.0

