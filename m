Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D77629F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGZEHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGZEHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:07:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::700])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C833A9E;
        Tue, 25 Jul 2023 21:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPPCNJ/LrNLvZJ0UDolt7lfm93qpB77gnNf+uQLBQmQ+zTYwf3ob3OVFN8orfUTiZGSG0x7RQ5w2z5QTiq9y+Fn5kzeD0/3rntqItDn6UFmOkRYWwsBC7Z0/XdJU2D8t0ntaHGWg7ljwiEyU6/tOkvrc78peDI7EJq+AAI/x/0eW84hXc3fd5NK67RV80iYo4IM8geju9Elh3t1ba3U/9CKdyNArkA/rQ2bpVYe+XGtNNuneUlzwOCmFBe3JBREEo8GtdcyrMW8scKt7F6h9O81uVFPt/suIBOT5L+vqF/Jr+ZcEJuk39jrQWCGpI8AdnEv+nf8tHsSPqcCna3dFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqLHw9NdBMcVTHEOA1IaAb63aa7Km95uMTjhpgdnf2w=;
 b=A6Fo7jvTFmzPTiZMnf99xtU775P2N/M5/X84Jqspvvs5vgAaN6yiZnicRowwJO98I1ukt3c2DxH9LkWu+5fXvp2wOUPFvm1mRR0SDYzhHj/Xvw9I7nvHMgNjyYV0b4X1gXhbIA4sPgjRVDpu1is8bntjUnf4YsV6zExgzl2615ZEJ54GBcnvtS6WbM4diLiBgySn2d4qU4M9kAXZuQzT/bUo9ohAUGsU+/MskZ8wMnBg7otz873WV2kJaPSCOXEVb4iPgeboWv5KCouO5Zz3knIdgohkqIzEx4azjRmpq9tvFWEMrZZexlaTp4rtAzO2XOZxMf79s9H+t++qJz2c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqLHw9NdBMcVTHEOA1IaAb63aa7Km95uMTjhpgdnf2w=;
 b=PmtQFItbhCGE2SRU92nXJFTTepqp8R0Y5jhJ8966P3Tl2Ez8/9kT9WiCqvgO4Pjq5X52pnEI/IJ9GwstBVAEdRTchQw8/TS49RGGUz+O6rX90/vYKMaKhL7nmYCtW/nnpUCxwxCjnMXd/7GKo6/vQ5LOvxKdnlGE3E96Q5f5U37AVyhZNE7SjfrKhDfqsyRZRdCt+1duYhUhg1L876prMms5VrBYlR4mT9SedQQmjWUBzD1hxespe6qKRVtx3njMwmUG3+AGoYlAy4p5w9Pebqvoy0c1eigdbSrwQDvoASbz5dg36HSb+6+v7QdDMilC3Obe46SfQFEomyEPp0kDYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/61] mmc: sdhci-omap: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:12 +0800
Message-Id: <20230726040041.26267-32-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1927a0b-59cb-4a48-6a0b-08db8d8d0b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXxoFi7EEnnvgb6Vkza+dHXokHCSBivMqhjtMJjGOyuZwU2nJ/1KiNLwbXTG4rsE/znU+3tv9koS2KvhsdA0A5/osP66UDkQ330FVX9BE17UhBhu3kYfJLPJtYth+QATAp11pOggwSbscFVfLUs+RvKFtNYa6/O/A2QiGsA32N4eS+eXnT9DQ9nwIjB46Oqp3eqmyRYz5RNUqii+bGnOZbAPFOwPUU/pOtnn5QEZCXBHDdML/gB4h9RIB9AKkUsFlMgJz5DxsWR2ZoKJSqliRqOLEYM2MDYHuC0KcnTZ9s1dvChpWXo9fqvSO3qA1bcGPgDANZPN7Z0s42Jv34NqHp71s7s42a6hX+zRjTT14QaSvERx1tjyLPZpEKwySTAe39CYCdMtvJc3ALhrGG+pQVE416SOvGXjpebLRhPr0aJxEEVibFV68GveAKnLPxKrtExKTmRob0sHBXOfewbUZYIcWErmX4ceGNGr1fi18EB0WuhXYfC7Abgz7aSK4XMMKgHMM2xFwbTI5dRFNxl0XDetuqfvK0hjp/IJmVlESfqAGaGRDLuKx0twQjwmmLASMi9ATXeY1ngmLqcOcbzvWDeL5A6Xt1nuXYWYmB7WvgoNE+05KRfqy13OydssL9WV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RStYUW9tcXkyeHorZUZHNXZjVXNyUEZLRmI2UDB5YmRTUzJrUFBTUVFkcFRk?=
 =?utf-8?B?d0tQQnh3SVRrTW9aT2NtQm93RDNLT0N0UTFvVXBqcW5iWDFqbnhuSmtudHF1?=
 =?utf-8?B?NUQydGtHN0lMWnJHM0k5NnErclVYa05oSG96TmJqTDlPTERmcFgybUU5MFJk?=
 =?utf-8?B?Nmtta1lGbC9GNDZFaXJzY3I2eWtXUXlQZHZuY3pnKzJ6Yk1RWlpZdmNWMkV5?=
 =?utf-8?B?cUdoVDhic25zakE2bUFDWVJjRW12b2ozN2pxUkJwckpGUklRUVRMMmZIZDVm?=
 =?utf-8?B?Z0dnbHZQL2twMEVrVk8ybXRPSjJUWUtRRyt3ZG4zc2lVZzRNRmpPS1FBRHpv?=
 =?utf-8?B?L3hicU9zelI4Y0YxSm1YcEpJWkQ1TWhHRUpXT2ZmbEpVWGU5K2NmNFdzbDhZ?=
 =?utf-8?B?a3h1NExrUlJEYWQ3YVAvWDRvdStHN1g0RXg0YjV3L0VraUduaS91cVkrRUVK?=
 =?utf-8?B?U291K1RHc3dUV3JwbFVaSkkyNnE0NWE3UDdMRmhpbGpLVDNJVTg1L2VoMmlB?=
 =?utf-8?B?UXhTcG5lV0ZCODRHcytRNEEvZm5XdGN3WjdqazM3Nm1PalB2MVE0MW43aDds?=
 =?utf-8?B?Wms5Z2FTVkZ6QmQ0QTdMRTVCdG5Ed04rR0pXWWI4T0JXSG12SEYyL3ZML29i?=
 =?utf-8?B?cmZidjQ5bW44NUllanFyMzFxaTczMk9CTFhTYUVodWkyODRWOXVKMmhuTlhE?=
 =?utf-8?B?QlI5VjJaWk1DaGtPRFBoWU9qbnhaV1F2VE9TYklXQjl2T051YlVKVVhyWmJD?=
 =?utf-8?B?WmpXaWY3VXdPUWc1bUxpUGF5MVlZUVd6ZHNjN05nZU5Ka2pQRGltVXBEUHU0?=
 =?utf-8?B?TXZydzk1MDdmV3lZLzdMbjJwN01vUVFjVmYrSVJhNDBsMTVYUXdQcU1QQ1VV?=
 =?utf-8?B?alY2NkFQZlBmLzYySTZpTFBvcXBiSUlTbEZiWk9tWk5Ja2pFc0w1cklCTFZr?=
 =?utf-8?B?QXdzNUlkclRoNExwUGp1WHQrZU5yUElvek9ZNGFvb09jdWR3MHpjRGMzSnh3?=
 =?utf-8?B?MkNzUlhzOGRrdGFCWENvTGlqdm8xRWFGYmFob1IzZGtReVJUaDhDbGdYOWhn?=
 =?utf-8?B?SHc3NFQrS0hOTVE3NHF0Q0NQUlRxVnpQN2pIYWwvQ2xTQytDalJmTXd6emJu?=
 =?utf-8?B?ZzZpWE9ObWh2cEtjdlBsdnpEcjl3YjQ2ekJOUlJ1MWxuRCsxMllaM2d5Qkxz?=
 =?utf-8?B?ZWF3Mzl6UGJTRUY0eGJPREc0YlIrOE9kTnhqOGxWQXB2dW4wbUtCc3Uzb0F2?=
 =?utf-8?B?SDVPdFl3VmFlOTBzT1FrcVc4SldMTEc1MjJScDhqUzRJMEl6NkdlKy9ObFJ3?=
 =?utf-8?B?K21TK3ZCQzJtMnlpTG1WK2FzcGEra1ZOb3pDd3BrU0VVSHA1V3B1c05ySEJk?=
 =?utf-8?B?OVRZM0psNGFyUTgzaElZR3U3YWdKL1h1cFZOWWwzdkNIQnVFcU83MDJTZ2tv?=
 =?utf-8?B?RjNmMmFFaGZLZkpvVTRRTTZFNCtDbCtxL1NleXlCYkdnYUZsZ3hGb1ZZWHhq?=
 =?utf-8?B?OWx1ZWNxN3M4NTRmRkpKTFEwVWIrQ0UrVmRjV09QYS9iSDNRWnpQNzJXcDFN?=
 =?utf-8?B?ajV0amlESEJIM01SRm1vTDFsZnMzVjBLWUNmam83MDhZdWdmMDFWN0NvVFc0?=
 =?utf-8?B?bVBURVVuSklnWVcyMkZEejY4TWxTbENobThGbTh1MkpmOUVDS1E1OXZOTTFk?=
 =?utf-8?B?dXBYWldEWjJHUWJmVmkzaDRoMzBlem5MRDRERFhONU5nNnA1alRtMW9RNFJX?=
 =?utf-8?B?UTFOT2tXY1pPUExFcExES2VZT0xIcVRsdUg3aE1ROHRlK29FWm9YNTlOUVcz?=
 =?utf-8?B?eUo2SkZqVVlvVUdtK0tYSTdSMk1MeS9jNVUrVVdVMGlnQzMvSE9PTmRzdFVW?=
 =?utf-8?B?eS9rc3VsT2pUOUpjSDZsLzhKV0V0MlRiaVFyR0ZlRkN4RHBIdSsrdTlsMFM4?=
 =?utf-8?B?NTgwbmxqMXB0NWdyaVdJTGZjMCtTc2piT1ZLU0dwMDZFUmI4RnRjaEhpNmtP?=
 =?utf-8?B?YlA0MkVtN0JqWGRqMEViTWVOVU0zcXlrU0YzMkpvZ0VPcHlkZnVuUnlYazBv?=
 =?utf-8?B?aTJuWHZGRStocUNMQmNLNlJ3ZmFLVS93TDFUaXBjNThobGJCN1JVRk1idk13?=
 =?utf-8?Q?krMHbgSworbodF2knH2AjRXh2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1927a0b-59cb-4a48-6a0b-08db8d8d0b94
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:52.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fx3Iwgo3bNluQYOrlal14rRFZY217JDZ1PdprAmV/HlHH0abJNHvNupYIlyymo00uMHvkLzuZ9DYwDtHMD1GQ==
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
 drivers/mmc/host/sdhci-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8ed9256b83da..6aa77eb4a3fb 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1394,7 +1394,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_omap_remove(struct platform_device *pdev)
+static void sdhci_omap_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -1408,8 +1408,6 @@ static int sdhci_omap_remove(struct platform_device *pdev)
 	/* Ensure device gets disabled despite userspace sysfs config */
 	pm_runtime_force_suspend(dev);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1478,7 +1476,7 @@ static const struct dev_pm_ops sdhci_omap_dev_pm_ops = {
 
 static struct platform_driver sdhci_omap_driver = {
 	.probe = sdhci_omap_probe,
-	.remove = sdhci_omap_remove,
+	.remove_new = sdhci_omap_remove,
 	.driver = {
 		   .name = "sdhci-omap",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

