Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427427629BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGZECE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGZEBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA8269E;
        Tue, 25 Jul 2023 21:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlcwkgcHGDI2TqPpiisMMeT0ZLIkpVHKVH/4Xxv+37Zu78HxGuRNmNL6qMCt0nL/68J2yC8uX9GfikSgVN/JwoXAudlQoSwEFJbKGfrig23w7BYl5ucAGwQWZty/IKPBwYHcMujVN/i685qEEy3bOuXnRaRR1MFVfTkmb04502tIJLaEf3Zq38VFnA3tsYK2We3EkvcBHcjaGtXksXXDBgEYLtUuC4MxvsDvFHam+LhGS4JO29Dqipu33MZgs7nTDB+HRWsTj7+SohFtX2224IRXf77tl5k9W3P+VbIdB47vmDeXdJuboVzGS3HC08gycLdoh08dHoXdzBVfQYEUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BDV2gitE9ZgnfS93zzj6+ruXHPsGkYOE2qo/yJJ5Ek=;
 b=h1cw918Yd1ry+EpvVr6WMXIxnqPwS8zYYGGNzt6U02ZzKEW5n3sVD3BUQvHh3rzqZ1GCJ8oAGJjgKApsqESYSVQ9QeqWedTzgG3NOz1QTSv1ZZAtJYtrLNLX2ODBesVzJpMRdNMMu3YwYVZVGn2sib7SeHWmsiEFBdKxGN/FBc4VA9es+TlimHZZRrT2qefNJJyDV8WqqXZxOlY/aHeqgzzz8mBQSBX2tYcyNXx0OaZ8J8MEt8bpMtuuSRiLv6W1KUnH7Iy/xdBMNx3bt02edPjeI7W2aK8500b19f5S0DoUAFbj7aJsYLEwhoT+SjcZHHqshoQWoQ2Au78WLX1O5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BDV2gitE9ZgnfS93zzj6+ruXHPsGkYOE2qo/yJJ5Ek=;
 b=qroh9Iixb1OsbPnjY51PEiFN7WWzI3lOuDikVcUJQKG2CZ4w1E1QD8HCPoOo3dKjHJ2SfEV5b4cyanRr/L8/gnBRZAV5YD0Yydxe2IoilVNq6RioCiLENmgR2PTmzPwzXEIsZ22dGPT2Wyq/Fxw6VKXCfM3GaPWUzRQZjVNesFP5Cf1UoFeiCRk8WibEuoXVMCzwzUpk51xRXa9rE5rjT7/XWp4/ysziIrt3cDIEZwYBo7MmzHU3GJQk5XYshlTLzBmO2p2M+8THSTi8tvMubb6Nc8XlGAtw7ZybnKS8NJ+1vswRmwfzAs41zJQTsk9NSFmYyJn9l/t6DOj4MSJooQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:00:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:00:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/61] mmc: sunxi: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:41 +0800
Message-Id: <20230726040041.26267-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba3f6ce-3a51-4f19-c4d2-08db8d8cea96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALd4vzLpCTgLlrooFKH2HPnGprtEEBSQjEVvatApTIprT1rAymjZrQqeGl4uFjMmQOYbPekNZAbJKTQEPbvVDZ4V8NGwBWhW73Wlq27tMxw2/BccxAq/MkxSER41S9ZV5HxSfUrkMA2DU/P9j/pEpkAIVEcLegclUjNfikwXF6rBy6RpQEL3365hK8akXEokVZJYkFpxN6PJevsEO5v9W+eLKBgK4zuXG4NpmRqChopxJ//zq+Lw5dMuftiPKoSntDgxsOE3ly6aNtFbQKzxa8atdztsaYytaWyeYnqS3ARpJOf8FSkv03cVBqhWPQbPg5/9L8wARNVul57YlJd6VeXGnWCMwmXDgYpnwH7kh0OQQAyhP0yHHQpilRpiNuDWPntnjDGHzdKDM4EQudVjHGELd7JOYUlNflzrwD9yT90QA9wrOmNM/HUm7zYIL/xAqFBaIto/scZyNDkTjMngqZNnXtwaigy47LiNGkw8dTzFvTNRcBaEV6WolHuOAj0IlHmrUtZKE2IQ39ZUicB1m3IgU9hi6/Jd03FQlWd3Bg/rfno0PM3rlvqnC6oDAb66iEn+GQvaj6cIXl5lJbDzvU8VaH8qrPCKIW6IDo7GKRkR8z5tz4z+jwi5d4fMO3xg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVp5dUF3VmhMWExsU2t2S3dZbVY3WTBRdS9RNkFjZDdhVUJMdXFYNTlFaHd5?=
 =?utf-8?B?eW5jbW1WUm9kaXh2b2pVYUhWUVBWZXhXaDU5aUYvNHhmbFRVWTBSR29la2dO?=
 =?utf-8?B?SnRTbmxQTTZ3TzZBRk1Qb3pnUGUwMk9naHlOVzFhWE04bzVPWitTOVhRZXox?=
 =?utf-8?B?em1DdDErclcrMDhPelM0ZlFXZGhRVDc0Y1ZGcm0wRHhrMGFQaG40UlBYTnA0?=
 =?utf-8?B?bENocGpUOXF5eFR0aCtXZTVRc251NTdQdlV0UU05Nm1YdFhvVnZBTHJ1UXNs?=
 =?utf-8?B?L0hlSU5DK1h2WS9HUHF4Y3dtRFZVRjJIa2VGQm9nQzV0K3hxcnFac25CSWNw?=
 =?utf-8?B?blNmeUd3d2Yvano2MDNFMnNyOVlYMmhkL0w3bU9SSnpRUzV1d1g3TVJwTFBr?=
 =?utf-8?B?Q0xjNlpmYWcwb2JSVFlFb2V4MnVnenJjUlpOa2oyWlpSb01EWWdtaHhsVUhq?=
 =?utf-8?B?VERTYUI5MXhwRDBNenM3bVVRdHRVYXNpc3poQm9YRjMrRWtudVpHYThacDlD?=
 =?utf-8?B?Sm5EWHlCTlhweGJ6MUhlRmlvaXlyWGtNY084eDZ1ZE1ycDBBbThQL2p5NVNz?=
 =?utf-8?B?MzExekcvS1VEVFU4VkhzQS9qTXhNUzloQVVXSm0vUVlKb2VIeTh5Zm1mL3lB?=
 =?utf-8?B?MXgrMHRXZnprTEUwVFZjbFp3eFdjMW1xZU9KYVVsT2FjM0dhamJFQ21Wbzc3?=
 =?utf-8?B?M0gwanN2SkJ4OE9aVWZtSWYwaFM2N3YrNS9ySG8xM2UwdzZHQksrRS9NQjl6?=
 =?utf-8?B?blNGWUFOZ0NJUkVkeVM3MThDYnEvclNic3RTM3RIa3dGOUo3WmZYQWFlS1FN?=
 =?utf-8?B?T0VyRXY4SXNWMkpQMmNicFU4eHZlN0lJMjdNc0Y3ekNJalIzMzd4YUlSNEtO?=
 =?utf-8?B?N2MwdUtxWnUxSENiYUtqRnpUR0Y2SHVYRTV6bmpDMDNGaWZNUGNTSzQxM1ZS?=
 =?utf-8?B?cFBpVUJ1L3lNbE84S0NmZmhsL2ttdW83UlFha3RXTlNSY3YvZWNsZ3JaR3hu?=
 =?utf-8?B?RE0rQytUS0FobmhjWTkrdi8zRzFVS01RU1BRVWFDVkZMazJmSUtzVC9UaU4r?=
 =?utf-8?B?L0U2UG5TQ3IxYUZ2NWJIVklFVHgyN090WTQ3WHRpUDQ5Y1ZORzNpRWVDdHo4?=
 =?utf-8?B?cDQ0aHVydFBxNGEwY2RUVVJyYWtaWlkzdDdiOG1hTW5lSU8xVEpKa1F5eUNl?=
 =?utf-8?B?VXZDd2tVNTc2aE9jOFQ4eCs0ZTQ2S3Y5L3RMb01MYlcwNGk1UFcxWTZ1Z1RX?=
 =?utf-8?B?ellLdnRNcENJRjRQZGVxaUlQWnhvdHRHTkxmaVZKa0RmTUNJYlA3QnI1bzdK?=
 =?utf-8?B?Nkd1YmFpSmFjU2lKQi9JZVJWclFDYkVpMkp5Yk9GQkNTQ294aHF1SjUwZy9W?=
 =?utf-8?B?WG1ZRHJYWlJJOCt1ZFZCc0pHYkgvYWl2Z3M5SjE4ZklBaERMUEh3T2ZPa0Ev?=
 =?utf-8?B?M0kweXJNTDZZbVRZYUE1TjZSTU1YTVBqaDMrcjZiS0xYaFdVZHhjUU5WS0NI?=
 =?utf-8?B?MGk0czdWRyttTk9XWGtuRXhFVzNpcXlCQk9wdnM1K212N2Z1WmlTWVNNUkFM?=
 =?utf-8?B?M0JJREsxR21Gb3JNMjh4T1E1K0RQTHJRY1BsSUdXZm9lNEM5RnQ4bmNFeW1H?=
 =?utf-8?B?SjRvTVh3bGdJem9kSG1rbTd6eXc0cVYyQ0UrYjU3MDRZekNDb1ZEd1d3SnNU?=
 =?utf-8?B?VEhKRkIxRU5ac2ZNL1BsdDdjdzM0QlVPQ3RURTFoSGJ4YmRkb3FyWnJKaGp6?=
 =?utf-8?B?SExnTXFQdWZORzloOW5aNWEvYnJQWjQ1dXJ5aDZtcXVlbFdkRXROOWxNVzM4?=
 =?utf-8?B?aGR6azQxZVc2M1hZdFVNNmNrZnRwZWIzTnNFSFZXVytLUC94N0tNVEdKcVI2?=
 =?utf-8?B?NkFycFgrVFdDQ3FXQ1FSRXlrUFBoaURUd1NaS04rSjZGdzlSNkpHU3RSOE1p?=
 =?utf-8?B?QlBoN0dHSTgwelhNZjZyVVo1cVpZbjRIc1VsNXFGOTlDdzBsUElPZTFZaGxU?=
 =?utf-8?B?RWo0YnBLRytLWWNpVFh0KytCSTRNY0tjQUcyczVndWU4TFplN2FQYzk5K3ov?=
 =?utf-8?B?MWRMUTdKSGo4ekMweUZHMURCSDYxbVVoUDVUd3Q3Sko0SmVQSU5ZSUt1KzZC?=
 =?utf-8?Q?iLZ9a5tto/BI/RS+TjIw4cF3W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba3f6ce-3a51-4f19-c4d2-08db8d8cea96
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:00:57.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGQOb7S5oFvM1sOBl45W4LjCrpWFQ2mGtpHKFHiuBXOzqbHiHyKoppRWEnudIkdVv0WL7XwWpujNuIdz7uu7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 69dcb8805e05..d3bd0ac99ec4 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1486,7 +1486,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sunxi_mmc_remove(struct platform_device *pdev)
+static void sunxi_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host	*mmc = platform_get_drvdata(pdev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -1499,8 +1499,6 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	}
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1556,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver = {
 		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
-	.remove		= sunxi_mmc_remove,
+	.remove_new	= sunxi_mmc_remove,
 };
 module_platform_driver(sunxi_mmc_driver);
 
-- 
2.39.0

