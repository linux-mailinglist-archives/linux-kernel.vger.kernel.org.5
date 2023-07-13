Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BA751AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGMILH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjGMIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:10:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AC6359D;
        Thu, 13 Jul 2023 01:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8NcePqu9UGPJfWCI0D4nAukeB4NlnuF4KIDJzWBoSU6q1qQo3BobqlXnwfinetx8OFjy2iHQHPBXQ1O0xQCGNKmsEGExMvtqGTjKoReSMXdwicn/egkIkoiVbeXjrpek4/MOULCvCQX/PxP8BuL4WktM8grfVHvz/IXv619FChZ3UDcl0NJjLs8u39xsMnukFjMwthmsRF5KcWAE1+0WS0yVcwZ0saQeidK90YCKh75akPef+IpBjSgPsZ9XXRZKE+Y7IGkhmLR2r4+QGYXV2bIMtmpMYczbnErrBEYmCCiUrLVlTKeVAhccMbmrDUtXiMMwnyqEtokgF71UtaUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfkki4xoknH9pl2wMgN3/myZCKUOHnsaDhrfpsUGHGA=;
 b=YVm7rukifl1ZWnwIlvnl5HWgMkeIi0ZthyGBrF/StS3cDj2alu55YTBD6/j7xwzNNRajYOp4BXmGfT5ftHtQQB/mhKz8AfRDVV6uosgzyqNhkolaHlvodklyZg3Cj/feUtY3/k/u4o8fQfeV8iAwRul40gZIJFLuzjLbZGSxsM+qvGQ+JGxP+JElxl27gwhU+LDzfq6XN9llfvC+YszMAIyPNuDblQHrkWinaw9MFNsVj3MNrq1KzzFkx5y4NthuA8ZFNjyN75trKHNuuA+wjIw9/jYpUgTtp762KSaWikxd9ZuZIWMyPxaI2C2Abey8tO+LZoDYUkstd6cItn8j8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfkki4xoknH9pl2wMgN3/myZCKUOHnsaDhrfpsUGHGA=;
 b=LcGG7SrZYcjK1Rh44RUAQApCvsASkb5luXjdRlQEwmG9/gPn7hlng8CBrRcKyqjFP3h+urq9cUt91DnM1AlwT/SN2jBSPh72DQK0BM82x708AB05LZpUdFin5wGNv0jZ1TdJ2EmKibmrrjC57nnijVnRr63qy4bn0zM00mI7ONFpjS6rZxrTeIfJKdRs8zA6xt4vIgdY+yxlqvlL2N1lGmxSsXuzkyC3+8HggmelraEC7eCEamGlCGwDk8kG8Hc7vQFyDc4eJ6mnUvjLm2YBrKKGWSYC6BvIxvIK4hsx0keWVPE00a1W316980YExybLvb6Po5Pq9iL5SZBcuGQewQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/58] mmc: sdhci-of-at91: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:21 +0800
Message-Id: <20230713080807.69999-12-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713080807.69999-1-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d836c1-3e99-444a-e801-08db83785e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Qq/bmvFN4VlDrj7TKH1XCVkVsf1DRLd1vvKRGAyJ8R0zlI1FJxGK90tpGHebsEcUOt6lJXBwAeH87p7/rkxClIxcoO2XApk3NPXbsadohJTa81RomypoBu/ps81CO4IhVKa7rTFNA4toCNItTArtgBlnxtV9cS430VuxCxguic9gzYgANs5fHL0rsn9nPKcEB4nTBNvr+B2+Y5lRYFyB7rY+SQgWiD4OPpV7YPiQxJ3zYolIdgN+EoUX40dWRLJpH/9Rfoggteeu1iuOtpp8FYOnA/uAN5xrRiVdzGUp8lO3y1HH3GPuQC/WC10UxpfqbzsBNZxxtYqC7QfyY0bJ9Cm3lU7rZm+qxUWTmIo4AHqez+DbI84w7rncnbeSAZKuHnGXSJr12ApFdRx1OrRiPjfY3+298xSzFcnueomKAl/36PxrGEIC9wnuECF16rFJQV2uxol9CukU/FmygePxHADSuiGe/Au/8c7996H/3gZ+fIEwLcxX6fvyJBX4lugJAu5dw8Dol5pFAbO689Qjeqnr/pOztJ6TDNUC0HPicbufQ9vJ48jCybcG6zo87n6Qtw4ZctHPY3/BvbyN42qMqCs+EGXSHSHeTSciOEnwO1pp0pTSLLfKwNehHprwa0kb9DGbwbJqn6OVjUPaQVcOX1jjhgQOeIZZbyunQEfMWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(7416002)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGFBVXdJUzlVMDNmTlpFc3pOUVk1R0ViMmNvTVVKZDFLWFFBR25KT3F4RnF0?=
 =?utf-8?B?TFJiK0RwU2VvZ3N5dW9SQ1BLYVlTQ1FaNWRkOU9kcXNCczJ6SUo1RGRsdEJS?=
 =?utf-8?B?Tzk5bE5BbnluVWdFR2pGdDFkQmthWHR2cThvWFpUZlpLWU00NGpvdE5MbGRG?=
 =?utf-8?B?UW5lRkVSSGpZOThNNEFFWGRJcjB0YnBjQlVFWHZWYzNpUmh6OExyOWViY1pM?=
 =?utf-8?B?bGQzYTVHR3cvUkM1ODRlQjY2aXJSRXBFN1RBNEh6RmpBa2FJTk9qejRVSlox?=
 =?utf-8?B?WldQQ2ZsbnNFemlmMEorVzhWSVFnRDR3L2phNE9RWW44ZlE2cHRhUjlXbis1?=
 =?utf-8?B?cDJ0eW1Zc0JKYjl3UVk4Wm9aUWpJZnZjUjZkWTRZVk5DWG5VNG9NSXBPak1M?=
 =?utf-8?B?cXZGNVF5TmwwYUpIVVJiSVI0UHF2eXMvSlNTV0tRSVkwNzJUMTI2UUxiVXFM?=
 =?utf-8?B?OFV4VnVoZ1JEWjgwSDRnVGFYRzVJdkUrWE40ZDM3M09jcThPWEx6TnI1OGRE?=
 =?utf-8?B?K211emRlQnRKSFlpaHJCR3REUTVURld4Mk9aeXNrbWkxbEYxcm02eEJnQlI1?=
 =?utf-8?B?YjZPN3VnZjRBVm9CYzMrSjExcE5oeXgyRmxMc1BVVERLWW1TbzcxT2M0Ykth?=
 =?utf-8?B?Y01GWFVIWStVbVM2RGJwWVNmQTFhSGJWTEk5bU5ORWQwNkpKY3d0RGtMWW5R?=
 =?utf-8?B?N3dBNHgyd3EzaXRLYjlQUTk1TXN3YlFkd3lWclg4d2htM0xVKytvQlRpWi9s?=
 =?utf-8?B?OWhaMmdxZEdxK01tR0RWZ1I4VmJPZTlhcngyYTF0ZFhRR1pTOHlyaUorZUpx?=
 =?utf-8?B?b3c0VjVGM0ovY3RYRURDVmJXR3o3b1g5NTM2bkFzYXcybkdlRUlPR1hCUE1F?=
 =?utf-8?B?N3dUVXZERFVjNzZqNzhrSmFqcEpaK29mNzNaTXI0NVIxN3dBVlpXY2hDNHNU?=
 =?utf-8?B?TlpuL29hZWxIUUtod2tVK1NPeHVKbFJMVXF5SzFNRXFLTmI1bXlCb3hJK3VM?=
 =?utf-8?B?K2I4TlMzLzIyc1ZrYWhHb1ZEZmtDQ1I4bytLYklzYnBIMlA2dmprSGkvRmpj?=
 =?utf-8?B?VnBXT0lzVGRtMk5jbjMwd1V4djFpSTNaQzk1STR1MHdOVXk0WVJkV3k3MFpk?=
 =?utf-8?B?SXdJeFdGTm1wSG5YU3dndUR5YTlqYXBIU2l5VGc3dkdHbk82RHB6TVk4SDQw?=
 =?utf-8?B?b012dmZvbXUxTW1MVzduWUdRWmdPUlR1c3c4a2dHWDNQZlRUaElCVWozejhk?=
 =?utf-8?B?dTE0LzRXTlVQNVh4TW5ocDFUSkhVYmRMSzVZbG9EZUVobG1tY1lXaFpsaERt?=
 =?utf-8?B?MXJvUHdRLzRqQnVvZzhmS00wbk56YzhCcUNQNmE1M0pvSjBEZFFPbDhYWUdu?=
 =?utf-8?B?U3U0ZFFnMldiVEZ1UGhabnMwMmJKWUh4ell6OUpwbkRiTGxGSC9DL21veGlG?=
 =?utf-8?B?amE1VHlGVDlOaVIvd2l5OEJUZTJOTzFwREVXUStiN1RFQ3QvS29NQUNnKy9L?=
 =?utf-8?B?d29qRG8yRjJibUNkOWpPM0R5RGptTXpSWUFWVVFqVVhGYkVKcW5ldis4Y2ZE?=
 =?utf-8?B?cUtjWExaOGN3cDFDdjhPMXhpdlJmVnV6Nlh3L0FlcFdsa1hCYXU3ZUlkZ09k?=
 =?utf-8?B?OEt4OHlDUnB1VVRlVm92TkVNSHEwc2pTMVlsQXlaTHh5S3dpVDR6R05acVpL?=
 =?utf-8?B?d0QvYWRIK3p6c0dOWEkwQkdTZ0lIUHA4eVN5Y253Yy9MbGtPTzNrUCtPRzBj?=
 =?utf-8?B?VVZOcFcvQndaUWtKNjI1dzhqMlRUQkc5NHhCalFnaC93Z05jL1Vhck5PRm1I?=
 =?utf-8?B?ODBCQWtjY1lKSGFhdExyZjlya3BqYXVoRGRPcjNtcXRtem54SDcvZC9SS3Fa?=
 =?utf-8?B?RWRxUlI0eG0yS1lRcjhHVkZMaTJtNXdsR0ZUNnRTYjRhaEU5RmhpV3g0OTll?=
 =?utf-8?B?dFZKSmx6SnNPUnRyVDg0VFdKU1R0VU92UWY1MVNVU1lFcVlJRndaVVNUTzRD?=
 =?utf-8?B?MHpDZllDMnAyVWcvR3NadmVvSFJBbzBYbjg1YXFLREFuaU4vWmE2clM2TzJ5?=
 =?utf-8?B?K2VzanAybDJ3bjl2WXZuU2FmSXVRV3R3THBiNHNCcnlyaW5wOUcrOGhrUmZL?=
 =?utf-8?Q?0VWn8h5MJlCziUkQ0/IszNf/M?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d836c1-3e99-444a-e801-08db83785e1e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:40.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnQXMIMJWNBS2EPq2fnGm0M78YBHwzdiL5JE/vUfN+csXfRSSvXkb4zBnYng36rHIxny9c+O5EmYZiEAVHsYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
---
 drivers/mmc/host/sdhci-of-at91.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index cd0134580a90..af5bc0caf29b 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -443,7 +443,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_at91_remove(struct platform_device *pdev)
+static void sdhci_at91_remove(struct platform_device *pdev)
 {
 	struct sdhci_host	*host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host	*pltfm_host = sdhci_priv(host);
@@ -461,8 +461,6 @@ static int sdhci_at91_remove(struct platform_device *pdev)
 	clk_disable_unprepare(gck);
 	clk_disable_unprepare(hclock);
 	clk_disable_unprepare(mainck);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_at91_driver = {
@@ -473,7 +471,7 @@ static struct platform_driver sdhci_at91_driver = {
 		.pm	= &sdhci_at91_dev_pm_ops,
 	},
 	.probe		= sdhci_at91_probe,
-	.remove		= sdhci_at91_remove,
+	.remove_new	= sdhci_at91_remove,
 };
 
 module_platform_driver(sdhci_at91_driver);
-- 
2.39.0

