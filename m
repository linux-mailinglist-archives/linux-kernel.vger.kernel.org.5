Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374E27629E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGZEGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGZEFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:05:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B8744B2;
        Tue, 25 Jul 2023 21:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8sQ6w9gfdCxpqz0OClo+a5WFJUcgJNGHuugP9N4FpwwvSAjVtECYu64kbGqajFjTiEEjvHkOs30phSHse8Xz4lEdbUjRz4d2heaxySiekGDuWgHGZMX+IMsAIzhOmKuga20Owkd43e5R9MtjgvjqRPZT3KbQeWawX8D832oMWdOmtR55bIgjLU4wEE+ZBfbR/IEJwPB1Zt0y8d/m4HQY/4xRuHxleIPE40vZKSKnBlHFoEftq5TCIZKAObvRMCQX1fUac/OXO4Ind/BOJAI51E8fC1mgj1GvRmtziqMgIaIt9ts3hp2NUd9wQZoOmF3SXPdQt0AHy/y4S1z48webw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhm7E5b0BhQaVKkDpkGl0RYRyNYlwsawA1ZXX7nIng8=;
 b=dn3yjxBb0pf3F2RiZQrHw8S0q4HFffAiU8r213aYAxAyYzFyH+PTUcw7D8Y+Az9KzdMJ2QvnA1aiRL3RxcZFat5ZbFgqhkgN7Kx3KK2reM6FP7IM9dEOC+AFdNoZzpZTAiQd4fqxBF4agBReuOOjUiuXOGoNEP9CXhOJ69SQtCxbtjZoo96csV5PuXBtTSSwihnm9jVD1nxOiQP6XyeHXfIco5ddg6FIDwjUO+6YQfRnNl5PTJi6O3tYqApIFD+/Dw6MGmP5hIZ3p65B2BeFcLF+JLBCUAo3AfJt0zP4MKOvhzc4q9E7JKobnQaisUT5vpTvQSNJqvOiWK7bPM13Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhm7E5b0BhQaVKkDpkGl0RYRyNYlwsawA1ZXX7nIng8=;
 b=nzKuqcDSlGq86Kvd0xyiF2LpkGKaPcvoR+8wJCgi9nDPBuavvsutmz4f60ZBh09jWeUfUin7N8kgISYeuqleKoSHxoOcoWWSgW2vGPBTXuSRXXBVoYE+JtbuVp2cebOqMy25SaEQDyocGI6E8wlbuP+2eiQNoWRDsdVru3XQvtMOfpX/mdlzE8+ilhlgttPupjQlB26qZuSgwF0+vCRsO2EkgKT7ftHz22jGcmPxKqJlDSgZKnMWYDdFMaPNbZAaPBbiFfOiU3ak14l796VFDlsTmyn0Kuz/VVWEZu7WHFVyD05LF5VLuUMRj0w41NS2W+5KBfCHwqMJ0nxeddNE9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/61] mmc: f-sdh30: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:05 +0800
Message-Id: <20230726040041.26267-25-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a1632a-d276-4db4-de02-08db8d8d0503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iLf6+/ENwXJ9+ap24z1s666yHwt0FRaCMjX0iAfaYQHLTLoc4UTy0pQ1bvHtgHH2XtHALvsgB5HNVJnbplUikUTuNtDq9gTD8EW8V1iDWfVDudt/Smh+oJ3B0EsQ3SKuMSoDTX7Yt0PwYZPiRP0Cm6BjnBDKsv5FpKwbVhQpOG0Wh6NWwBq5JyEup51QrSI/gvn/qkLFWPRh5cO92TcYcl/HVc+sVS2K2e097/1vPohaM8H8JxWfT9WMA9ZkE5l8n4/5Ruhuyp8Ko9WZAp/TLg97aCK/HfdxlrmX0YD+k+wK+VxuKLE9WBkRNvSZOP+tXjIR8ylDxR+kpc5PZJiCWgzs9FEYVRE5RZ9F9RBKD+ahRiquIZpJaTh/vpvgn2Ep++p082Tw6paZaIx7uGGvU1ps2gXmDr7TgWYURB6i9zcxZyjltAQ6SRLLO5VVtL4rVjEefNBcROLFSWDVg3iWQ9UdqDFRHvwjyB2KtrjHtLZvR1Vyik5n0xWH6a8dKE1mKuYJFxKQ0lu8H7aatjttDJyAqkd/nwMuuUMb+bMdAD+c4d4UNzbNnv378ZY3WK+HkATlj7iGt3omLAaRiTnsqo+HHsIw97V8oPF39siVSf+BXlSjCcwZjxzdpcS+3W8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJtM2VFWlgyUkxHb0Y5b01tdDVoUk5qZ2t5VUxBa09DY2VDMFBwTjVzcW80?=
 =?utf-8?B?MzZlRWp1Mk13aldveUorcklUakR0czgvUDllVUVmZ05QTm4yZXgwd2RreE9y?=
 =?utf-8?B?ekc5VTBBc3RxYW85bHZpd1A5NFVwbTl3cVEySUUxd3IyMExvRzlUYjNSVjVY?=
 =?utf-8?B?Z0tXdzJJZFI0MW1aUm9STEtEUVZ0aGwvTzBTbUdjU0V1S3E0emZ1TFhWczky?=
 =?utf-8?B?UVBtRm9PQWZOV3NIR0RCZngwd21wSzR1dHd0aWVVaE4vZlE5SjllMFFVVkxC?=
 =?utf-8?B?K29wYzhpVjBhT3pOS2xlNW54Y3o4aE91ZXdlOG03alMxYzdYckFzbHNTRjBo?=
 =?utf-8?B?aVJFNC9XM25zekxYVkpBUG5ITGJpT0RtblBUQmE4Y1FMNGpNaUpGQVF4dGsr?=
 =?utf-8?B?RTcySnNDSFd5cE5sbDFDc1VyV0plWFVPdkJQUHp4d0I1VW5RY09YbmdqVHdZ?=
 =?utf-8?B?RHFldFRIRFhwSlNXeXF2TzBaZEZMczU3MjJZbXhYQVpPN083UTNTYTRvT3Fk?=
 =?utf-8?B?Uk5ySkw5VW80ZUxYSy9ma3U2K3NzNVV2M0lzTVhrQmVLVFM1WnRrMFg4d0tF?=
 =?utf-8?B?OWRqdDdKOThNSWFGekl0am9TT2RVTHlxcGN5ZlZnOGhmWUtYYmJodEw4cXhH?=
 =?utf-8?B?SlB6UGdLWDlvYUpOcitIQ3ZYclg5SVdCeTBKSmlvTHNZSjV1b1BhTlBRRmsr?=
 =?utf-8?B?aHNCOEY2dWIraXFrWmp2TGxDbzNaQkpBeGUxQjdkVitxbEQ4T251VEU2SU5y?=
 =?utf-8?B?TGpSMFJ4dE9hT1h5SHRZNHFiak5DRTJ4Tng2S2RBTVdnVnpZbWZQaE1ZZTRK?=
 =?utf-8?B?MS9qVUczQWMrWEs1d3A5cU9iNm1odUFzSCtwM01MVEF1QTdUdmNPUGpaN1ND?=
 =?utf-8?B?cXZuQ0x4VE5zdnVIbllFMzhvLysxSjRsNFcrMEwwcGFidnk1ZXlmckFYN2tW?=
 =?utf-8?B?aHBiVkNqL0JIWDVXaWE5ek5XOUU4dXA1a2ZueFVrRkU2dGpweHJzVG1oTFNy?=
 =?utf-8?B?aU5YMExlZFUvczRpaENyL2tKaHM2OGExbERpSUdFYzVxcmJKMFhXd0I0SzNh?=
 =?utf-8?B?VFNNUExZK0hxVzUzQUVVa1BJcjMwZ3FHcW1CbTFZOXpJdkZIdDh3d0xrMWJV?=
 =?utf-8?B?L3FObUZyLzYzc2FOdEMvSmJ5dlBqZkgzWXFMQ1FhdW84TGFOZGhEQzIwWXJp?=
 =?utf-8?B?WUdSQnhmZCtIYk5xTDQ0dnBoTzlTSW51VndHRGJlMm90eWJNL1hqSnJkWkhq?=
 =?utf-8?B?Z1dMS083TTNwL0U1azhuVnJYditHZklleVZmTG4zWVhZUUllY3l6ZU5XUTVH?=
 =?utf-8?B?U0paZ2lNVDNveENKbzhjRXBJNkFZSG1LV3h1aFFSUFUzeVVXdTJSUmN0Vm83?=
 =?utf-8?B?NzBiRmVxZkk4dGpDSStQeFBGZzZYSUlZcGV6ZjlTenJqbytJRzJWT3phTnVJ?=
 =?utf-8?B?R0RlbjQ5ZTRVdFZ2eUVPNGdIWWc3K2xJNzhZNmM5RmhHNFhXTWdIR0lVUDZS?=
 =?utf-8?B?em1tWnZBUE83YlZwV0RyWFBaUUpzV0RPOGlpdFNjNlJaV2RjdS8xWC9FN3ZU?=
 =?utf-8?B?OGx4aW0xdkpEOFNDMndFcTRVZzE1S25YbUQ4UWNUa3BybkFmTVE5SyswLzFM?=
 =?utf-8?B?RkNtUFVzamNjczNZZ1BEaFBHTUNxVHh1bGwwSjFvbVlUWmNCWTlIdFRkOFJy?=
 =?utf-8?B?bWRZZitJM0pMR1gwT3BDMHVrR2o2UHVmRW5wRmlyTXUyM20zeHhEdWliNzh4?=
 =?utf-8?B?MWpnZkFuOHBoaXV6NWNrL0tQQmJsVVhtcnZhT0ZqbzBBTFd3U1g0djJSQVdF?=
 =?utf-8?B?b3pXd25VcEJlVndYOHFVbHVPeDUvbUFGbElZVEE1dWpFY0dHY1crdks1eTh5?=
 =?utf-8?B?Tk5kVzhKRExQMmFrSjhzUEhxd2lIYlZBYnNhK0lXMm1DNlFYd2JxSm1uRnBv?=
 =?utf-8?B?eGZQa0trMVlRTm5QZWR1YjBnS3hrQmF2d0FYVkhqTDAyUmcwOW41d3h5aE9O?=
 =?utf-8?B?RkhEajBlVCsvRWFHYW9zcnlmeGQyRzhEaGVIUTl0aHJVcGlVUXRxUklSc3hQ?=
 =?utf-8?B?cmNWTmZGRVZEcjhIZDlwbXE5dU9iTVlxS3lZVFh6cnhkS2VuVnBEZlh3QnA5?=
 =?utf-8?Q?Z6e69B2TVF8zdqQCNTrlGJ5d8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a1632a-d276-4db4-de02-08db8d8d0503
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:41.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/PKT+6xr4DtI9tLkg4rpkIXD0hwzrEITmXGXv1wHUcR37/Woz8+YKV5s3K4QaiIebvtYZYMfLkTIl1jdHmGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index b01ffb4d0973..840084ee72e6 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -206,7 +206,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_f_sdh30_remove(struct platform_device *pdev)
+static void sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
@@ -216,8 +216,6 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_iface);
 
 	sdhci_pltfm_unregister(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -245,8 +243,8 @@ static struct platform_driver sdhci_f_sdh30_driver = {
 		.acpi_match_table = ACPI_PTR(f_sdh30_acpi_ids),
 		.pm	= &sdhci_pltfm_pmops,
 	},
-	.probe	= sdhci_f_sdh30_probe,
-	.remove	= sdhci_f_sdh30_remove,
+	.probe = sdhci_f_sdh30_probe,
+	.remove_new = sdhci_f_sdh30_remove,
 };
 
 module_platform_driver(sdhci_f_sdh30_driver);
-- 
2.39.0

