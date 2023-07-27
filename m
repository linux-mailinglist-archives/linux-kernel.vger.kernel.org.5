Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2D7647B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjG0HGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjG0HEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20725.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8923AA5;
        Thu, 27 Jul 2023 00:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQYhB4tsjPc9HPdaHuHpmIx6o0x10O/8xvLIiC0xJMs951rX6v0+shLqXL+IjyQLmBryHGG51fZYnGVprYXVybVsarmCtlLnt8DAvK7G/Jngtere3n0tS6DwDMTp0n64J7aZC/FYXQ65+b+f2yxJjrbsKBO+yJ7JD6XvnFKuGoDc1I2JyezYHBUZYPZhe/m6/fww91cc8Pd2yspNegfek4jCnuz5Xpe5CGUox/4k95Ge3Zv518rT22lyR/kvABhjc9P1CajKa3WBPxB1DLZyhlv2TXalCjB6MPbBFlhEpFdk+8qEgcGiKO0vwP5x9pCg4y9B97itaTyJMGGgCFm3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXZpNO+3dmb0lnQ8WXsQM3rNh0ZF61gf7J5F6UfMTHc=;
 b=Mm1hh4DG49UzQGFE5yPO6cUP0WuUqvtmswJWwzHecWIKzQ1vUDcQTu8CL6jzvFbczd5ttiWyuWfhhbixA1sVBMuym0iPxp+cJAmGnWKLk/prVjWfBy6/U26oOIgXsaBD8Yd0k7g+RC3Mhn3dHQ4taM9WWnhLBU6hi2GbjbHgfWT9HqBOJESaMWRbrIeFe6jT0t0olioP/jtHRs6W7jjNWJuooQ19AuIb+ODtX29A3H4QC5Ux/zjFFe7dSOG0zZ3DO/4ItlqB7ebbSBpT1y41PlM7mFbxRdRRDbFOiwIThwfWsYrvaOwDgMGEorxGFtLPoUErjuz04fKClgF8xPrQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXZpNO+3dmb0lnQ8WXsQM3rNh0ZF61gf7J5F6UfMTHc=;
 b=jB7EGA3+6DdO+UuEIO+yCElpuv1WdFo4D6AkgNZUH+7GgjDSrmQpYYgW5V9rk3lQd020qjulIo1S3THzyF/sZ9FlOY+rWSqVFpyfECAcSPtgDv2l4B/dCIU52cd+/Goo4AZ2BQ7GH3RPYaWpjx1v2c+Kra4l3xN4dzYN4OEPyhn9gdxFoUDACj+iYiud+CHtAZ12Vir4jwHuC3tN93rlYHhVKEjESuFEQrNKrbOqmcW9jQEW4ZBoRmPrJoLr0jWBFbyKdTVeanMciiIZkec4xJcOlXEPuVnScSb99lki+Tu8SNLa9drxmjGrTl7FnhFPCAMzYpSMao6NaCPBo/NmLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 49/62] mmc: sunplus-mmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:38 +0800
Message-Id: <20230727070051.17778-49-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f76511-c70a-4270-2938-08db8e6f6ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9XUME3szuqM09seQbNp5zr18IQqDqJKjwRN4mCSfFmXd1vDNQsFvF01Cg1VJJsgse9xFp/RWrolBJrIBzdYlFvJ2GvHlr69pc732zqWYSFCBgogpv7G5JGQmKnHcoHsBcJkEtmxbc6OudclXWF6Dv27m8HwdifVIhLnvF6ANSBMbG99mX1w0S/JD70UWiGpTwfaxV5JEzPcv85dVyaAPuW8Upq+eRgcgTiqck62/Dy6WV0wbHqeNvz9ra/73Z6nrwCZgk6+5rDn2fauAHXBPYI8c4uUrueaDmebUJTdKWbLoRO+7R3Bn3BMiVOTyftWmfQoLCgMOrqOWhboc2y92oznxDDudDVhwzc3jCa/3fYonHV0Rw1SmfW4WXQ+fajnHs2A/jeCi5Ry2PUDrpgUKTtz3oFdHW1PKziAPHobPOVgefYzkMaEfY+gVRGgjODWgEu1ldU/BchgDmttm3EWFKT9Ndr4dIPE1tCwCMefo4yIQ9kF38UBgWGr1AQzkQ1bSBoBW3C3EuO1j9tX1bF3BH8fiw3hkI0mvm0jljlESMEhh1TmNMLd1ENnRCtAn093S5uJR0QXugTYuce1P0dz8MX8sWmpQHPD66lnwnrjT9YhPY1VticvALS2C+xhtI5V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6666004)(110136005)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66574015)(66946007)(8676002)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dyt0SkY4M1E5cTdkTXh4LzN1WktDNmJURXBGc1A0SGdpdHBoSDhQa0VNS083?=
 =?utf-8?B?d3A4M1Z1N3FiaHYySytGb3QzNXc1dGwwK2NYeFFvVXFvTFBWMWF4a0FZeHl6?=
 =?utf-8?B?QTM3cnJtRXlVY1ZJTHB1d0lJTXNERDA1ZkhTMGkvem9hNE95ZWxtd0hWTEdB?=
 =?utf-8?B?WjFIa2xCclNHeXp0QTVFVlN0MHUrZlh6VUpxY1g5MUJhcmViTGErZjhQdXRu?=
 =?utf-8?B?ODVyWDF3R2VFaGJBNm1rN1BpNVdONitKRlE4bzY0R0FHanNBdStQdWxJZHNG?=
 =?utf-8?B?NUxhRnIvT2dScW4zanhYYm85Tk8zT1lRa3l5NklNYm1qWFBDVEhkZEs5OFYy?=
 =?utf-8?B?WUNWR3ZtVE5MVFJmd0Vtakh2OTlleFBIODQwQllOSFVPSFI5KzdwemgzZzBW?=
 =?utf-8?B?UFZMTjArY1JqNTVRbklVMncyRlNxNFBzNVQxZDdUUG5MSWZrRGIvYStXVkxK?=
 =?utf-8?B?aFJRZXplQUpuMk9uOUZWY3dBR2NhVGFLTTAvVFgzZlZ2QUNPckNNZjlJOHJS?=
 =?utf-8?B?QzRWUDl2MUhDZHgyYU5ZTitTdEk0TnB6cWRMZEQ3SUZkN2o4NzRNMTB6MWE0?=
 =?utf-8?B?OFFJR1hwS29OR3J0SnhBTlBId1pHd0xNNWduRm9helBuVFR2T1lIeStGK3lR?=
 =?utf-8?B?VUpNQmlwZnZlL3k3VDlsMUFiV3NHOWVXenRmRmljWUtYYzVxN2VjTnZoMFRJ?=
 =?utf-8?B?ckVRWnBGOTFpWjFqakxPMGJCQnN6U3I1UUpTZWFpZnM5aFdzRnlyME5uNHNk?=
 =?utf-8?B?WVlVMGJWYnRzd0loWkVtTnVocGxsOCtMUW0zckF6OHRnTzFtV1JzSWtYay9I?=
 =?utf-8?B?QTlmYStzTndPem5jVXBvSUtlZWJyM3gvUm5pWGpVVnlabmRxb1FmQk84TkNY?=
 =?utf-8?B?WFBQYzBVRXhVUzZBTU1DUk43YVRNYWRYOEFJZC9ZUkM3Yk8yNTVobDVtdEZx?=
 =?utf-8?B?YTkzUVVyZzJKNFJHS1NoRy9kelpVWXQ0WjlRL09PUnpaQ2dqdHBCS2ErTVR6?=
 =?utf-8?B?MTBPZEp6T2t0ZUlRMUV6OFBvajVtZ3FxcmlsRi8zOHVBUUpJWnFwem04Z01x?=
 =?utf-8?B?TnNpM0xNeGl6WCtWUlF2L2RxNTBKKzltSUxod2s5a3MvNWJNL0FpMEdEWXdV?=
 =?utf-8?B?bnpRME84Q1JwYnpEVGdmbVdRTEJFU2w0VEltL2NZNmNGMkN6YlNiU2RVTHBV?=
 =?utf-8?B?SzJ1T25yL0JsejliN3dFUzE3eldhenVkUXhpcjQzSFRTSm80V1VMRlRrM0ZR?=
 =?utf-8?B?Z0dRK2Q3RkNSczV3OC9NM1IxR2JEQ3prTkpDckRFY3FvNnFxVWplWWJVRWZk?=
 =?utf-8?B?OGg5akE4OWdoY2RUTHIxU0d3bTVHTTBKN2VBSkFQTW52bUtvZUFmZFZvd2lp?=
 =?utf-8?B?Wi9RQWpqLzBBSlF2RU5NOStGdjhFMTd1NDVLVzdTc254UWNuOTNkMUFVVFJV?=
 =?utf-8?B?bmlFSlZXVFpVdk8rUXpTbFdGU3ZzR3dEM3FZbVJSaGszbUlNWW5nRXpDK0d3?=
 =?utf-8?B?YmhIaDRXbFYxMUJyRWlqMENCN1BjaFYwRDJuWWsxWHhNYzNTa2hMMDRkckdP?=
 =?utf-8?B?czQvSmVsRlE1Y3NicnZ0SUZOYU96eFIzNGI1eVdlWG1yRkQyanhKdmtOKzdj?=
 =?utf-8?B?dTdXWVl6VWg5alBtTnhIZWNIQWRYQUpHVjZ5YzIzUTJGd29EYUN3MjVrcU11?=
 =?utf-8?B?RDU2alByY3NVa3FCRCtxaVZtTnpYQ09MQ1Yva01NVmkzMWhWUkJvem9yMXg1?=
 =?utf-8?B?bm9rSDMxemF1TFNzWGZoamxkbThLbEtnWWxtWElKdzJaWmhzNG51Zkl4eHR5?=
 =?utf-8?B?Ykp3RlFwV1pjYXBHeURlTHQ0eDNVWGc3QUIrbFhKdDBXOWlXRi8wZTloQ2FD?=
 =?utf-8?B?OWxidkFzQjR6WElOTEJDMmtCSGR0VVFZL0FDQ0dQbWZsd3RJbTdYV0d2RWN2?=
 =?utf-8?B?ZXFHVzBLd3lsck5JQVVoblkxWlBYQUxucmtCWThQTDVtS09LY2xIdVluNzJt?=
 =?utf-8?B?dGVZSFZVc0tWSWRtN2JhUkZXQmJnNGNSVko0ZVczYnpSL21VY3NvdVQvYndI?=
 =?utf-8?B?am5veERNaXZpYVJGNjhTUEFDbXJkNEVBdUpzQ2VTQzJTamM5QUlhSmozYndC?=
 =?utf-8?Q?HiP/8wZfbi9YAQEp5C9tI+0wN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f76511-c70a-4270-2938-08db8e6f6ea1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:25.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE0FBfdW1sZ9P3UAMt92hos8nO00lyTGfn5acWmdggWgK16/3peod/ZMGQyXc0W4DQseexsX5+vWCmgZKQ411A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sunplus-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index a55a87f64d2a..2f30a683a17f 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -946,7 +946,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spmmc_drv_remove(struct platform_device *dev)
+static void spmmc_drv_remove(struct platform_device *dev)
 {
 	struct spmmc_host *host = platform_get_drvdata(dev);
 
@@ -957,8 +957,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
 	pm_runtime_disable(&dev->dev);
 	platform_set_drvdata(dev, NULL);
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static int spmmc_pm_runtime_suspend(struct device *dev)
@@ -993,7 +991,7 @@ MODULE_DEVICE_TABLE(of, spmmc_of_table);
 
 static struct platform_driver spmmc_driver = {
 	.probe = spmmc_drv_probe,
-	.remove = spmmc_drv_remove,
+	.remove_new = spmmc_drv_remove,
 	.driver = {
 		.name = "spmmc",
 		.pm = pm_ptr(&spmmc_pm_ops),
-- 
2.39.0

