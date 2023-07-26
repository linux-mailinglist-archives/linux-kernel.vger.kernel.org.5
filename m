Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330AC762A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGZEJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjGZEJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:09:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339A75262;
        Tue, 25 Jul 2023 21:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA+hdyhg/a8cDbkVoRjN2zHpyilkXQ5efhPfKk76v2fd7OZZ2ku8VUFvLgeoz++ZwVB3LSueV7as172CvmGRwVzGUtlCMMDylrhOwMWsIrSZ6WHH2RYsF8u3LV90oztkRagbHN+9rNqJYHdtsBIB88UD7pRflgrfUw6ihshSYYGrqxEiGCSuKUlPuKgUyDzPfPh4hKFd4MyRiJWUWbYYRiNGGEltxTsqfLpCivoGWivl41FAZJ5pD6nNqElc2y/JGYJin57oopolEx5Xv6qfbxA+9fuy0nl4SBVqBFtg7SVSeRCKDcutIZmFA9yt9Fcj/IQqVkVwfyjTEIGByne1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXZpNO+3dmb0lnQ8WXsQM3rNh0ZF61gf7J5F6UfMTHc=;
 b=aQpA2g8jUjsdR+XeLlcHbwGCnzy6uvCGrudt9kFFrqLC9a9ktjA128MqyofEfnXg8/t8GEtF83OOSMgE17dQ5afqVUT6Oa8eZIviBjj7h0ti6SoM4i2Jv0sMaA22IGuO8xn9+vt9U/2mKIwiZ6+YAyMaQGV2srhiXWfVO8nc6b+6Q7Sw5IQLfCQbI44DCXeDYgYJaWQSZlWFnrmEnyc7gcl1UPJ+LSVyJDpiKNsv2+bNxAy27TgV+GrgG0GUlGRgLhlLYIPPQwUahsyh10+LyCAK2sxPrIbmaxvrSXdXLmYSkzRZVifYGr9TsVF5WNDsAM4/7l70Vcp/6ED7QrAlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXZpNO+3dmb0lnQ8WXsQM3rNh0ZF61gf7J5F6UfMTHc=;
 b=m2NgVrAQrCpDuo26SIUaSbLqhvPV2ohQy2ngiS04+/Jazw3Qs9S3ddfrI6sIMIphQUoyM1Njjg3th+jtDk/F5BOvDZrk62zSYaejzNpZT2r0um72g+9jo7cZn8xH9Ctv0FCwMDDv+upcV3i6PamGvF6d8yl0FGCpLd9ye9uQKOBVj5C5Xar1L0DhZ1uV/aLYJbxlxGDotxfT80xTxoEeJTX9fvhEltO3gTDgYd7hxSnZOUPUbmC8ksIAch3aFQwIHtbfwa/jMen90KveCOoDxvnlNxoS6vjogZGpwsSIAUenZXPFpkG8B+fKQwh13QrIkvKeXdi2yosK5QLyzPwmWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 50/61] mmc: sunplus-mmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:30 +0800
Message-Id: <20230726040041.26267-50-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c8fb908-75a9-4a3f-def0-08db8d8d1f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mq4kNcY2Rabcmy5l1Yq9e7TQHsknvBsbZ4vKFDkQKv8xRYW/Qf04i9t96TpVabXWYGpg+h3cAXC7x8i4MK+LYnLXC+B4HDmPDpIe/W0txQ+HPBydz69RwZWzrEXcqqMCoKI9T+J76aZocljIa1bGBqgB7KhuxDj+woh0bgJ1Z8B7/hxMQPO1sXP9qDQi14BR1SR9cogL0wSMzQIcW5S3JlL9QMYe8pLUAUk36znffJd0ht/vHlEHkOnEEFA+u+PYM3olwmZAZcpcs0Z0qvhwd7Pvyv7Uyyllnn90ef9nxK+m2Pm7yA3M8aWhI20DlnO1Ra0s4KDk72sQXYfocE4qJcsQtcoJ6PTQJWt7YSB4lIegPFhEevv9TN4+CD8dUZGokCFmSj32YDLMM3uYisuMz/hfgRhZIB8sYK6p8d2qsdL9gP9v51xjd4UriVZvT2A+7XG9J4AYQI4bDjXMdwgeFn5vf3x+U0LfAo9g5ZDSThmL8TqrHUF3ZoD1YhNIqNdGtLT2eaNccWJ4CAJxCd192D/GbzItUWcW6bhjMjbI9cC0s89weOewNBHGKUjLE998hj8jCnBrUunaycb54RvjgbPGMTQ+/aQ44LSqg8CXikcCbhOw9Fyb4abuBAZs7gmq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2RHMHZZbjVxc3BrRkJSbzdpV2pvVXFFdGVrOGt2Qzc5TWVubldNSjIvK0tm?=
 =?utf-8?B?Zk5ZdGI1ckZVSGpBTDZ1MGVDY29qODI3YkIxaWZUc1k2N3pJL0N3eE1ZdnV2?=
 =?utf-8?B?N3lNYkdUOFIrSTNyMUc3MU04OXE4NWtFMElJVVIwQ1BQY2p5c3k5NlZzT2Fr?=
 =?utf-8?B?UlBNSTBkY0NkaDd4UnJGV1BOK2E4WndkLzAzNldDanZHZ2FYeUR6MFd3elBi?=
 =?utf-8?B?akI1QmZKUVVuMXFnZzV6N3lYV1l0Tzh1eXFXMXY5aE1uajR1RWd6QW54eG9R?=
 =?utf-8?B?ZHdYQzNpZWVTTlk0S3dzeklrd2RsYzhvNzJOSGRpQ2JKZW1XMkRrcjN0a3Jq?=
 =?utf-8?B?Zkp3T1BEcEl6Z0p2N2oxUUFrcDJ6MlVoUlhJbFNjZVJLT2owRjJPenFSYWlE?=
 =?utf-8?B?c1ZSWWwrdnFRQVVkcTkxSDhNNmgrMWhwY0VqalZMdy9SVitJeTk1MUoza2JT?=
 =?utf-8?B?NVZBY0Y5cGI3YnVadlBFakFGZ1dTUEs4ejBFRW1uQWQwV0R6U0tOejU4OTRK?=
 =?utf-8?B?VUpLMmRDSzVQVm9IdldKbWhleU01TG8vWk1rTGJ4YnI1M2tKeWJVQmcxVVRK?=
 =?utf-8?B?dlQ1blB6U3dsK2FMKzlROGlUOGRpUmp6VTlHRnNYMXU3TmNsYmV5bUhZV0dW?=
 =?utf-8?B?ZHpSeEk5TzFTY1J1ZVV0NW93enhFNjNWMVpmTTJnQ0gwV2hyOXh1bUZNK2Zk?=
 =?utf-8?B?NGZEQythYXlmOFN3VGdrT1JVZHZJb1N1MGVIOUZyVlpsTmc2RmVGTStDd2FM?=
 =?utf-8?B?Z3VwUzJpaDQ4OUc3N0l1Y3Vka3R4M243QUdTOXBwbHFzdGU1R2d6SmZad0xV?=
 =?utf-8?B?ZlZFNWxSa1pKdGpDc25RdHpZK1FTVVdaWUJKM0pVbjVVR1l0ejFLMXY1SGhP?=
 =?utf-8?B?c0NrcFozLzRxUlh5R0hEMjN4bVZxMVRpTnRxaTJYR0VaQTBiUlBQWmdwR2xV?=
 =?utf-8?B?dXJ2b1pUYnQyU3Z4U2xMeDVXaFVNWWp6YXFrWklMajlFNVExTkxmTElRcWNF?=
 =?utf-8?B?Q1VxNENTb3dZWnR2UTVWK2pMb0V6ZHg4U3hYNlorcjJVaWV5aWsxazdiemsv?=
 =?utf-8?B?YzNzWjhTVTZpVXd0YjhIemsxNFhTUXYwUnRONDJpdTYwdytnc2xJRlFzL0Yr?=
 =?utf-8?B?RGlub1VlcTJYOWtkb0tlQXQ1OGUzaWZYd3FQaUNCNXBacTU4L0taRU1FODho?=
 =?utf-8?B?ZzVybWhHVDZsVm9UMHZQcU5IdU1jVEVWMnMrcTIxbERSOVZ3UERyazQ3RC95?=
 =?utf-8?B?Q25YOWVPYTVmUkc1ZElHQSt1YjlQUzQzZnlGSEVjdFNIVlF3QkdBakljS05C?=
 =?utf-8?B?aHdKRDN5d1NMRGM3Q2QwVjhIdmxrRGc5eW9wSXErb3BhWE16M1htcmlCbnhF?=
 =?utf-8?B?c2gvY0ZiVTZLNFo1T1Q0blJmclVHZU43WXlkYVZlTWhmR1c1ZDQwYklINHBp?=
 =?utf-8?B?b290blhLalo0TFJ2YVdkMWhQTjdmSkZJWktOaURiRlhxSHlaZEVqU2RSOGpD?=
 =?utf-8?B?RnltcXdUVHVaRVd4VUVCeXAxeTdTUjgyTnMwa08xTUp2WUtLbTdVTmNjZ2Zs?=
 =?utf-8?B?V09yQ1pOUzcxNzFHd2YraGhHdXM5aCtqSi9UeVdFb1ZXYnZPZ0NJZ3VzOHFC?=
 =?utf-8?B?bHdsUmhTeXcyVExTbmJ6ZEdReWx2S1R5enF5T1Zmb2JRTzMwcE9ybTJpNGx5?=
 =?utf-8?B?MkhSbDVzbkdlcXdSRHBGUUZwYVpWS0I4b2ZtdlFZR3RZaGFzQlR1S0ZJd1A1?=
 =?utf-8?B?UmMwa3U0TTBXaHNFU0ZTNTArN0JKTVNKalNSMGVMZTUxMW9PVTJOaFRBTWl0?=
 =?utf-8?B?eDhPN0tsZlR0alNqR2drQjJYT09nT0psUTdsNndOcVkwTDh2ZDNXcUJGS2Y3?=
 =?utf-8?B?NGNyMGhRN2JvVUdxK2RzVU84YzVSSWg4aFV2cEg0WkVZRmZicnk1cDk1VGNP?=
 =?utf-8?B?YzV0NEkvVnRDaFRHWURERjN1d3FNQzNzWkZ5cWhBbm1pVkJHYUNYSDU2QkY5?=
 =?utf-8?B?bWNCenhxUFRjU0tJbzhIUVNtNVMxckVKMUltRUxpSlNkUHRUM2xyU3crTzBG?=
 =?utf-8?B?Vm5CWUNHczlVYnFlWmFrMTYvWjBTZTFTVVNpUGoxUGJmVFZURHRsRG1DVDFM?=
 =?utf-8?Q?JNkNpZytCbO7g/ycv2lNes43Z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8fb908-75a9-4a3f-def0-08db8d8d1f7c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:26.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwTZ3mOQxBRNs57HVc/fR+IeonEKqRb1IH44AvwbUQ/m+wbgCCbiF9I80iwE9RLF4oswvYyGqj6zYiekhvtufQ==
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

