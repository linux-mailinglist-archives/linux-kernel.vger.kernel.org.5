Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA7764780
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjG0HCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjG0HBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E3F26A8;
        Thu, 27 Jul 2023 00:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlA0BtWEaoC+EeE2oNqRU4v2wiXOWXmFXllqb+fWEA4qRy89jY4LNc1RUmzYQB9G6f3bf/bY8LcKEVAABW1q1U7BUJVXTx5iXtYdLScjwa14q/vuwy+62h97N6e4f52EC2mNMjUdKyOuYr6eMF8iWYUSQHKuZRnIPStAZdglmNlF1nla9ZDWLW/ne5OYjTF26/7TCM9Qz1O+CemslWiZy8cuXeaUC3fSadSDCfCpyLKjfQshPlbXkVCiNtn+QzRgGFdlOgpMZQo0I7K6wi5svLQyuZkdDhM007jJxQMGZH/xuM1byOenulOVI9owXz8BpLmFJ8ATo1RLf0DZV90pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4JU8APsrhrkPun4Q9xIy3FDPUIcIdpxAJYFh5ztE9Y=;
 b=Q4Z/RCVQKdjsOURHO6bDGMQxuw0ThwH7qbmbu97fXERTemcqcJDddL/lWCwytQXaSMNJJ39E0W1wHz8HfwJhMHUqDJAHh4xi7X+CXXMBUTH8VWREhqN/pge3KHc2cv/FJNCQblQkTPP6R/oIAe26q/pyBitr4dkYMv+v3twrDYFv34mMB1SUIRNqWNYwWyx5r37MjsD4TDct+IT8HF/KtBHYgU4R6KXE3ltn9n42TSLhNnASNFkMVLgojjiDtLvKIs7HMZeN4DyRuTbAoXtKtfilAK/tc4+J34SuBHt2w7polS8v5/N1Q5NXmj/0ClDGBG9MnhFVK9SpwYN3TfaR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4JU8APsrhrkPun4Q9xIy3FDPUIcIdpxAJYFh5ztE9Y=;
 b=YZ4EHclvN33bMd4dSDUvs13CAjhk+vLm2BG44nnWsURUbIcLZWum5CoSqpviFRKm+wiMMS5XcDEZogPW3R6GEuzeasf+q0dqZuc6r1rV7jRVYuI5z/e7DiZ2gUJiVCtEk+EFlqRM2g9BAcoEz00MesH3Pqd7omGtZs7GNs9RyFlaY8wZ6BbmZwhXO725rc/cQ04dRNPhUzNuT9RunpcVL0zKy8s4RIscIeqWaiybRmouqU9N8DIrdmYfbPto5TcmXmM2gaflCD5UNDTjn7DzQtdDEOal3nbG27BUCx8t+9RB6gcIfosc/Bjjpk/JqNRP+e7YrBvE1tdicU+3/CYedA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/62] mmc: sdhci: milbeaut: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:59 +0800
Message-Id: <20230727070051.17778-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10ae0dac-0a7e-4a0e-47b5-08db8e6f46d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cX1sb+/h95KeivzdjfXnoFKL7WK2sLrp+Edg9vSTHuEcL6scTQfeerkC/ryyFDBfqfAs+242UBu2wPoLvCs7tbRUgEU+xPWAY3VoNOU9aKN5jpu6yx/z2lepUPBZ1cpyg3kv8UJLzkrnx+Rmb9+mzfhER3zTn+nelEM5wRa69pbv8UUInhrB97MBCsa+HlyPRnkFmJfMbAfeTD6P7uFipLdC9eUWWB3Y3ASmDg+i4+jQUFj0MPIGYVl6QhyVu04hGTdbnYn+yClVsM90Kv4Abx0ADr6XqelRd855C92ZmSRVNhj6hqWWgWSEHUfNQNBkS999Ir3+tL6siHzvEUKL+iqizvDmNOgd/JsKiH8E3ggZcFJz9ipJ6KObi67gIhrBe0tBl3WvhbI1+piNu+3yyKIAs7bkCw0sPfU0e3GhfGSn49FGf7lQ93KPzB7veHADp9V19UnStpm2io7DOvdv5FXMKoU3VJWe7fTUhor2i2GQ6BaFnX49JFAYnnrkhrd0kHFu4dmtk2/ln0EGBYd1poPZhZ/jDVHZBvh7eF/GCqUO5sDjPxgGhpsBdP705tNqvQE8XRNcgFRkGbTNkzV9GkCL4iJuvxlKLWngPFHy7LV8reeY7Df0m+oFXE51NLv8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDN4OVhzUnpMOHZ2d0FMdkFmZlc3NHdsVmFjeDMydDl2dUNGbXQzU20vVThY?=
 =?utf-8?B?U0Mvb3Z1aG81MHU1SVlrUkQwSEVUeGhVcmVSMG56cGd4WnJGQVVOb29EUG0r?=
 =?utf-8?B?cjNPVUtXdW9yYXhXVDhGcURSK0JDcDJhTHZlc3Z0dzdENUdsVEM1cFd0Tmho?=
 =?utf-8?B?NEN4Y0pGb0NGNVZmaWh4ZURUaVpKSzVOeHg3N1BybFVqbWc3bWlPMVhCdFBa?=
 =?utf-8?B?U01PWmtZdVNKazhINmxNK3U2UklEdHRwdzJvNUlVRmtBbm9BSTVlMmw5SUNn?=
 =?utf-8?B?NXZsWm5ZNzRDMFdqdW9pMVFZWFp4dG5ia3Y1TGptRjZPMk1oYnNUYU5jQThp?=
 =?utf-8?B?ZXBzV2NuYVlSUklEMW4yZmQ3Q3ZNTFlYQ1dVdWtWbjRqVldtTEVkMzc1V1da?=
 =?utf-8?B?RzhmVjgwc0NRTXlpdkFVUVBrcmxQWnpHbk5LREtoZHd1RG5icStpWUxmVGVJ?=
 =?utf-8?B?aWNISDVvanRFNFYycXBDS1RJeTJvTTdtVGpVaWJobWtWNXUzYVhENkgvYmcw?=
 =?utf-8?B?K1dFcVFhRW1BZjY0SmtsZTBVMHEyeUlIbGh4Yk1rTlUwM1lvK3UvZUNjclJk?=
 =?utf-8?B?RjRtWUk1TllKZWR0OWhabmMvMThjNTlCSjZrbnhoeVZOUmRpczRiaGgxZFJy?=
 =?utf-8?B?OWpHcnlxb1pieFVtOGtjSDFhOVNmbGEydjJvR2ZoMlQ4K0Mrdlgva1Fnb0U5?=
 =?utf-8?B?aTNpRVJsSTJVSEh2dDNDUmtPc3c3R3hCN0N6UWs0Vk5DTGxrVDlYK05uTmk1?=
 =?utf-8?B?WGdaZ2pBeFZKcWNSYjBZRjhpdlN0NHZiOFYyQVVsMGlabHQvZWNOTXRmZ0xh?=
 =?utf-8?B?cE14QktGckphZlp0RTljZlFIa01relQxT3Q0KzkvYVZVVGRyUlgvRkoySFFl?=
 =?utf-8?B?dTFtd1BZaWRVSzdNVXlQUmdwcTM0bnI4TkhhYUZyRmlRQSszSTlMN1loK09J?=
 =?utf-8?B?T1JodVlrOWZqaUMxaDNRU3NETHdDam14S0tQYnFDdVBCNmlPNjZKVmhoZHFy?=
 =?utf-8?B?S3NLbXUrcTgwN2pjWXorRWJOMmhWRkhnZ084Nyt6N016VVVxWDA3WnY4RGxi?=
 =?utf-8?B?TldGVWpsaVAwK3JwZkk3T3BrZWtXT0dWTCtpajRsK1VVc2NOMWpkMmFnNmlY?=
 =?utf-8?B?d2ZqWHZmSXFMYjVoRzJUSDhJckgxRGNva2xGZ1ZyejFxTTVYTFZYYnpxbmpP?=
 =?utf-8?B?TndrcFd4UW94anNUT3J5UTRId0VPT3BVZEMzLzViOFVCZlNpSmF4MjZkVkJw?=
 =?utf-8?B?dk83QkhDS0JJWHc1WFQ3TTdDYzdUeWJtSGJDVVpudWx6N1V5UmJDQXVQb3g1?=
 =?utf-8?B?QVp4akMwbHhKazNrUGJiRDh2QVVzWjV1YlZaMlcxMW9WZ1VmdElqYnNNTy9m?=
 =?utf-8?B?QW9DZ0ZPR1pkRFRyY3hLaEtoMUZZOTdNNTNrVnpLbk5nSVRocXp4SnhZSFVE?=
 =?utf-8?B?MUVISm5kbzdJN3dKQ0Y3YWxPdGNwd3kxSDdHVHdTNDhBWVN3TXQ1M0NlUkRt?=
 =?utf-8?B?MzZsVVBadXhDYjVodXlMN09YaEVxVFZmcGp6b2xOdHNnTncyeHd3MDBYT05r?=
 =?utf-8?B?OXVOWHpKSTV2R2lDNnpod1lid3h6MFRMZ29XcHAzeW84cjhxMlBLT01BS3ps?=
 =?utf-8?B?QWdlODluaFRLQk1DTS91UitWa1lxK09CTFBNU2xyclZ5TGNxSndNOExGYjFl?=
 =?utf-8?B?eEVnclNSRE9FWE5ieTRsUGsxWngvR2twWjluaUQ4M2FhOSs5Y1JWbmcrbWRi?=
 =?utf-8?B?cFVXVTlBVlRNWU40NkpPVFQ0UVo5Z3V4YUlFdmsyVStLSUFWNjhQT2lrOXJY?=
 =?utf-8?B?YXpuM3lWaEduWHREcVBtemtaRS9lOEpqSlhDaWk2TTQ1WGdkei9JdlRMVkhF?=
 =?utf-8?B?YmJ2UmNvOEhqY2dTbllBUWtuUkQvTWUrQzc3RUJOa3pJY3lldm9NWGQvY2Jo?=
 =?utf-8?B?M2x4TzVtVTJRNzRZVGVDSVNHSmhJTkpnTjBlcGRTdnhyZ0pxaFNNb0ZlQ1JT?=
 =?utf-8?B?V2RxeWpsb0pWMjJKZmJrZDlEZ3dyd2dNbnlPWWNOUHF0RHUyZGgwaXF6ZTRX?=
 =?utf-8?B?a1ROemFXM0tmbnBuK1NkUkg5VTBkNTY4T2psejZ1ZmVzR045YnJkM2cxeGcy?=
 =?utf-8?Q?ICrvz0/uYrz8IB0pN6KbEXZ76?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae0dac-0a7e-4a0e-47b5-08db8e6f46d0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:18.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePt8gonIoXTx+GxTnma+72AoJJ7BLeqwy57obaW67kjGTHX+feo/SC2mgOQKiCbmmpHlXxG9R9pf4AtJ88qhkg==
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
 drivers/mmc/host/sdhci-milbeaut.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 148b37ac6564..ee4514c90eea 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -313,7 +313,7 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_milbeaut_remove(struct platform_device *pdev)
+static void sdhci_milbeaut_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_priv(host);
@@ -326,8 +326,6 @@ static int sdhci_milbeaut_remove(struct platform_device *pdev)
 
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_milbeaut_driver = {
@@ -337,7 +335,7 @@ static struct platform_driver sdhci_milbeaut_driver = {
 		.of_match_table = of_match_ptr(mlb_dt_ids),
 	},
 	.probe	= sdhci_milbeaut_probe,
-	.remove	= sdhci_milbeaut_remove,
+	.remove_new = sdhci_milbeaut_remove,
 };
 
 module_platform_driver(sdhci_milbeaut_driver);
-- 
2.39.0

