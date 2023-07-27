Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929197647C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjG0HHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjG0HGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859944B8;
        Thu, 27 Jul 2023 00:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG8HdyImjNNEhkLXVK/kPMQVxcGFgh2OqAkvRTHd5tAAiVNDfdnmGnu5zAlRVvKbx8e/hszbK03pUXRH5agi8O7JPychybFEdKndLAhwjt7wNnTMVGNX0vA9k2JvxX26R2+EwUEeYaZUX+ng4ZwX7b8yfNnUNhHm14xVWSbb2cO2DF37tTqiP3+PQDmb5MKZKKyf0mhO3+5R1wMyDCKySWj8v0w5fmIomoE9N0yNwrKNVal/UH9gJ64mbpN/qlkM10KJ86KIX6rGo2tDKtTJkc3Ko+84fboInTvDk5RbZKlecx0Dxsjo12RecHJmbiSJQK9Z+9DS79daFrEO8+eiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds1a60oaC5v+9oM6ou+xAQphrPqkP3uRTm0nyn/ukQE=;
 b=FqAbsVjezv969l7BRLtEAaElOhSwFT75HJGpZ2mwlY+6SDRug64d8N+7zolTujx5GEcQvZOdJj1hiiCuq3+OuVTJFApHVJX08+pYCZfLPA2I77LC5JvQ7amqiYYk+PGVVAwuYpJG81Av3GcumoAf7Lxz5dwKhzRmscRU4c5mrdXWI41mitkouAVU+cPp8Y008Pb7yy99EOFFAoGPPOgzcsJAhLJfwtJK2RSrwdqyYkZ782UWVOtSGSWkpY21Ff7ny6DMqa0ZxIIdEw+ajp/mZ+zzOY2r7l/0vCs7hd+d7INL2bQtSf8rFmboWyIL2Y3QchyMjXaZ0Vj1j6YadwPiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds1a60oaC5v+9oM6ou+xAQphrPqkP3uRTm0nyn/ukQE=;
 b=aRXeThsRgFEwXG+4G69yKWRrTEfdqz6MaLpRO5urKzEXm2/zFgJhIvNtKWQCbxBbvFzLUV0iB+qElOZgEahmhEstpShFOF+ijxslsDbDb7Zy8AELcGn1Je77RgsXtqMD9T0nH1wk+YOMMks8IUAUgcGAKSYOt04HmoDvPUQ5jRWtEBQynYFT9TpQfIlTBy4S5aVgclHIfEMNXFD2gG6WYRBDws2Lskw4+IcH+w59glZ0LUXKIiNgEyNVZPPLCzfyHqyF8Y9GYhGM1CWJkxaA7ytq3smFffOgvI9GGR+ZHQcMc0PbUxsgEckSmuUs2B+2g97fWhRUyFK0q2kMXGy+7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 35/62] mmc: sdhci-sprd: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:24 +0800
Message-Id: <20230727070051.17778-35-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 871047a0-c260-4daf-211a-08db8e6f6037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7hR1tpvQWjPqc1xJ+qhIwu9YW0/5KI1Xia/6B5HIExbM0Pc5Y4P4suhGNV1Mz7nHVx382Z90/s4qdY/lhpPx08F2Uwa57Z/3PWdlw2tfKPPMCSYumw6uB0LG7mgU0VdO+bBxQs6gt5uBrlTMFbP5gdZGX7J+8LQTB8pztUs3b1Lj2ANf9uh097k/J2PxEY8F95s3JeQaES3AS4OaQpzVxQN9yzQyJv1G7W4XqHc7XtWxn2AaaWaVurl7IXM9nhhVbuEY265tl3adqDphvIHvQiIpecp2hhQyQaz/kxOs75M0q1MfaCnioFkb3b+Hud+hN6GGzyKPLxB7AYgSpwBRTQsMYOkPrJRKp4yNWC+Fnfdwe2X79VD6eYO/YAQewg8uaNfHSmRh+xJomAHgCzfKzg2zFSyP1Zj+9PO5imhoini+bY2Y59S/XtpcpJdx6rmkZwHciIphV45cgqWWCqQqCPEtXS6ig4WTtvncNjy5oOpQW5mx+hnrSBAfxPwT9WN7SrefWYC/Cpy81O4om7mfQKmb+NopJI1TScut9vyCvjJo04XRUSp9gEKyF0KD06+gUcVqO2CMXZex6vdf2B2iNiG+ntE04EoS/zjdHdHA/aChB8q/kVFZit982OLv/jt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJVRXN0SzNnME0wM3UzVlpNRSswUi9tWUx4NW13aDlieFZlQWNyYm5BSHpp?=
 =?utf-8?B?Y1dmY0IzSlkvT0RQVWs1a1VwQzBWQlV0N0N0RmdGTU5vL2w4d0kxeXY4N204?=
 =?utf-8?B?NzlEQTZTWC8vMEE3a1pBOVRuSFZ5UCtJZjlMUGFUYXl4dkdEMStWY3BBb2hj?=
 =?utf-8?B?UTA4enVrdXhvWXhmRlptK2xHc05DTzJnaGFac1M4cHNFVlp4WkxMaFhkTVlu?=
 =?utf-8?B?OER5TDQxRk5WVUhhVm5kNWhMRkVUZnd0UTZwaHdJUWEycjA0Wi9FMmJaQUFO?=
 =?utf-8?B?M2ZNWWtqM2Z2OFYyNk51cTExTDNIME42MTVQNUpTNFFnb0pyRmhhaUUrbEtC?=
 =?utf-8?B?OEQyTncyYXVoczM4YzJFTHRScFN6dkZKRWNLSkwyR1AzWXhWTm1tSjUzVno2?=
 =?utf-8?B?bWtMTFAyOTVERkpYRGt4d0VXUkRNeGxjbUcxYnRYNndVZ1l6OENEUkJQUTJE?=
 =?utf-8?B?dm52UFZ0ckhmTml6ZEdIdy9ia0hrZlVJeTAwZlp4Zko2cXlFbXV3S0VyRCtD?=
 =?utf-8?B?bklEc2lWb1krd3JjdXdUWkk0WUl1MXZmdjlIWDNRS1FZaFViMHk1elV6cHpT?=
 =?utf-8?B?UHhWMjJUMXRaaGV4K2lrRW4ySGxHTmk3M1VlOGV6NzVoR2lsNDFuYmxTNnNT?=
 =?utf-8?B?VS9CL3NJS1Q1eENjYytVdUNxQlM3UWV6NCt4VEtFczkyc2FnbHJQSzlpVFRM?=
 =?utf-8?B?RVl6d0Vmc2phaUF6ZmJsSzl3OS9EeHlkWUNNYUlmOE4yblUxNnkvTGtYZWRF?=
 =?utf-8?B?bWcwYXZraUpzeW1obm5JUzlDbWNkYVRYQm9pVWRZV3lWZFhNQTlZRFozdy9W?=
 =?utf-8?B?V3R6dzZYWEgwRnNvV3dzYVBZS3FEMjV4a011ZzNIR3BoOWVPTC90cm9FWE1Z?=
 =?utf-8?B?WStWREJKb0N5cElzeWpqeWJzK0xPUDJDNlpCY0F6bVdkRjBGSGFPSFhnRlV6?=
 =?utf-8?B?dTNpQXR2eE1pd0hNdXJPMkNhZ29OckdhRFVXcHYxZlhrNVlJK1lld2RRMklD?=
 =?utf-8?B?ZWVhR1N6a3hhMkQvYUt4MHVyOW1PajBOZFB1RjBTbzdRTVQxU2xRbVNxZ0pS?=
 =?utf-8?B?Vm9rQ1pEOXhLSnluUHMyN3V0bnRyK2RnSWNsR210OVdQeFdMWVo5Um9OdUo2?=
 =?utf-8?B?Vk9oOERpbXpZR1BsVkpRVThZZjhkTUV2d2k5VWI0cVU4RTRibzB6Q3BTZUUw?=
 =?utf-8?B?L0dxK01oSzRmdlZ5eWNqQUZ6bjZxZlo3dERTMTdHWlFyUVcvOTZMWHI0SlRY?=
 =?utf-8?B?WUlHRDVPOTJwUHluUFE0VVlYK2dWM0FrVVVKTGNtZzBDcXZjcHFvc2Z0ZXNO?=
 =?utf-8?B?S1ZnWE40UjVndnVDRW5DemlTc3pycW50VlpkbU92S0ltdkhDMFVGS3BlUGth?=
 =?utf-8?B?L2dBQm1teCtsb2lXSTZ4ajBGdXBOV0k1M0R2NVZWVDRGMDNHbklKSjhWT0Z0?=
 =?utf-8?B?MWpKa3J1ZC85YzlkOUJZUlBsZEt6RUppWllYKys4dktoZ0J6ZWpibVNuc2Fl?=
 =?utf-8?B?Tmtzc0FkNk9IalU4TStscHlKclNRYVhOOEgyWGczZmI3TlhtMDJ6Z1dCSFk3?=
 =?utf-8?B?ZVBMUnBrUzlpc0swYkJLTmdvaDJ5NEE2RVc1MC9KSVg3VUgzUlAzWEczUHJK?=
 =?utf-8?B?U0djYkpIVXVYdm9Wa3RLcDZwMVNLM0tTdk5nZE1Sb2VLZUNEa1lLbFltOE5L?=
 =?utf-8?B?VnkzVEx6QnF4UlpISzV5NnBOUzZaT2Q4OHdiaS9CREpSOUxTd29NS1VvcFEz?=
 =?utf-8?B?U2k3YlRVWnVoc2VjQWRQOWtST05ESGhrODRjZDVDczZpVmFUZ09tbnhwcXZM?=
 =?utf-8?B?N0krZnBISXNidyt2N1c3cEVNL2hiOWZBOVZLZS9tNWIveHV3QXJTTTgxeVZP?=
 =?utf-8?B?eDRicjNyclZTU28xU01KQTdPR1pLWFhRcXhwWkwzNjNkQXllNmRBQytVUXNw?=
 =?utf-8?B?d1gvWXJmNUUrNzdaTVlFYjN5aWFtT0tTQWE4LytZWm4rZ21OVWg5cjArd1hB?=
 =?utf-8?B?VktSQTd1czF3RVNWeHNrblBWU3FKWUFSaFpWS09RSjU0L01DWFlWcUpnTGZ4?=
 =?utf-8?B?UGViK2ZITTlqeTU0MDNxM0FHaG1EbGpNMXg5MXpaSmVBSnMxTDBnKzNzd21U?=
 =?utf-8?Q?yBH57JlyHwabVFruRcGAXKxk8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871047a0-c260-4daf-211a-08db8e6f6037
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:01.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBEGAPt8I4uNL20YaK2TfZNDPiFCmCC0yASEpV5MxDsQL1q5nU+01XTZpNk9lxIQ9Ppkm0Qzzwh5ipJr8DQpYQ==
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
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 7f4ee2e12735..379cb3892757 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -720,7 +720,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_sprd_remove(struct platform_device *pdev)
+static void sdhci_sprd_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
@@ -732,8 +732,6 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id sdhci_sprd_of_match[] = {
@@ -800,7 +798,7 @@ static const struct dev_pm_ops sdhci_sprd_pm_ops = {
 
 static struct platform_driver sdhci_sprd_driver = {
 	.probe = sdhci_sprd_probe,
-	.remove = sdhci_sprd_remove,
+	.remove_new = sdhci_sprd_remove,
 	.driver = {
 		.name = "sdhci_sprd_r11",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

