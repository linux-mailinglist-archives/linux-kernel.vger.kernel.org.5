Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498C27629C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGZECL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGZEBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E7268F;
        Tue, 25 Jul 2023 21:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6RDGwOGAYNmTgJrraLjT46Zz4R4JSCyGb7c+TMfOh9YW8KCg0bdA+wuVgcM5RFvY3yreDyjVxpmkororJUQ7V41h/bNccgH4fjeYE1c7LH6FJQZjZUvCWBGr5gvx1wplZE/Vn7GK4j3l3Z424OO1/+V/Slg5m1DVOkysXAeVcKQD3Rjixa5+wkDzcLVSc7ZuXaX7+IYzDVdBGsfkmUIJ5t7RU7DezhR/lGgi12qzSq+NttiiiE0b0wdOFAZE3hFxmtV0gkMwhWvPup8oSCVMkXjwHrlmMPa4OTbrjx3WmpGhOBm0Ogy6OHcAkHusD4P/UuX/UsVaoo0on0zcNHEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGmVUJSjL3qqF2yxLWtGfO+5IKk70aRQaFRf9uXQRf4=;
 b=dXFbkOZ4I32kg5M/H8jO3UsL2v73bQqxFHzOXAmFYHLU7vS0PIHj542+apTEqP4XlXFgMf3AKBA2xAGi5hrDU0IEA1ZKuRMX3RPPhWcZ+9Dv4bC+dz2j0RuXICvsHLv5chbv968DGAryKqaU6cIdDfskDCPJxvr0W/zVFk+3+yOi/ySaMhJwdOfhdwshXDht+yrEA8CZWvwyUPmlalKsAL6ebmbm6d1lWHIu0W2XBZKBpCw3WiXTxcLSaNcF530Wxu+O47fEMpr0r7WuYbOjxfHJnCh8qVSTOd+3tk9oHLCDGvn6rAUWUtsXfA0ayV1/HvfF0KYzlVXyt58teyNP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGmVUJSjL3qqF2yxLWtGfO+5IKk70aRQaFRf9uXQRf4=;
 b=aouJiSuYZojI3EhVijF7uNSdmhFEgLeVguKxHE5D19t7NfAX2+Dh/BQ83wHKKn9L0ADaJRx7xfISOBCPw7EV3Xlnaa2Jpy0hmba7Mjp/LaVAwO5E+/YSqQN65pJFiUh+v5EWODXhCxW5a94rofNX4BzOP4fSKKNIerCGmMzhfUpzT9ptFxRtQJW8/rz4lLPktWDBBkLdwkWdQEeRMCsWAM4m1HTcQYNu/z+jdD1Q/AB+B+iOHo3lX5YYIVJcPXRTznM3y18O3CZCyVMwC0/WgXXojig4h70ojCTKtkv9ugL387Hp9sf5q3FcrSjQlscIwlGO4ojrSWYviY1SHWii2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/61] mmc: sdhci: milbeaut: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:50 +0800
Message-Id: <20230726040041.26267-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3060b5d-09b7-474f-bd66-08db8d8cf4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8R3niK/KwdqiYbcLa/Jcp6/5u/eKTE6nj3Agyuq43xOrR7QXqk9FZkohWmJydeQGrf5MYrrQZgHR8GjOwS0T4QuSqNHdASDz/UNx4h39ezNN5F5GVkzUC8QgHVLsaPy4ZC/qd5P7XIAeE6lxEc3ZqdK0N83NjfzbGsTGYcjpo/apndyyVQ4u31rSDFF+HKtsu4gTEuQnA8/3ThJN3AeIsaTLpJP8expZHcqYROGra1351HH+vbilb4YTYy2859tP5y64B/QUnBVPahL9wW3X05rrp6fCTZVL5dgtLUj6YxmekTHEmLFdsoLVNBij3VsW98DXG4DVfXEsh+Jcp5uw7BL2pSuroJCHS/cZni1i8zfscxCWyxZq8n3WplW1/fuFp1Yl1+nGxFSuzerJc8xriW59mc6Xi47666Js82qyKctBoa3GtlAgkRu1QaTRAjTpeLFpBb0RB4LlhITAhYBRXrD8m8ox1k9Q9rl+gIi7pJJHxydRzzUNo6CeH2vZozqDJ3cy94kGgaoZ7Md0IH84+Y7+1bk968yYe+bd+L5xhDbAvpgBdlxOTJ42u4EGvRxOQYASMpvfLtqDfzqM/+QUDXxT3dsXCdRSiI/L0kNzR1ubUFU1dYAf19oOcxcTdMg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVh2Z21FSlhSMHN1TjZrN3hLT1JpLzlpSHBxUFp4RlJ5blU1TzNzRmVwbFU1?=
 =?utf-8?B?QmRyNkRCdTdMcTdmTXJKTURGQzErc2pLLy9yYXU3RExBY2MzbjJzZG1ZMzZo?=
 =?utf-8?B?N1hNWThUOXVEVGpLQW5uS3lzd0pGdEtGWkVwdE4wQW1NNitLby9Mb2Q0R0VW?=
 =?utf-8?B?cTExeUdIdHRQendlaWJBeURMMkVBYVBlck5iTUUzUTRCWXlkMmJSMmIwRmUy?=
 =?utf-8?B?L0RyQ0FocXRrTUlBN1JMUS9VN0pWR042c0hoVFZSbHVULzF6QXdQSllxYzdE?=
 =?utf-8?B?SzkwaGowcS9wT1lmZlp5UmRhZDVTb0lST3NEOGFDQUZDdGNxb2h6NERlcXlY?=
 =?utf-8?B?YVplY0xnSHE3THlUR09QTUVqOFZ2ZjN1dkswSmJmakZNVEdwRnlLb1crL1Vk?=
 =?utf-8?B?ZTlMck5wS2pKSFo5a2Qvdk5tYVQ1LzhrZzVXOWJpdmtpVnZKdXVjWDFZdzRJ?=
 =?utf-8?B?UlNDRWhia2xMKzZCTjBHWXpSSjNhQytJaElNSnVGYkdzdUxrKy9Bc01iaVpo?=
 =?utf-8?B?NkxaYkJ2Z0dxMWd5Z0s1WGNqWVlWUHF0cEd4VUZNcWlXamgzRFY5d0VkbUhJ?=
 =?utf-8?B?UlNFRkJhQmZnL1M5MzRmbzQrQ0I4cnQ1eXVFT2FHajZrUFNXdzA0VWcwL0Iz?=
 =?utf-8?B?Yjd2RFdqdGovTWFBSmZXN1REeVRTOC9ncTVOeHhqWW5lVG16SVJxWTZQdEQ0?=
 =?utf-8?B?OGZsak9mczRlWFBkVFFGcTBibjAzc1J0bTJwSW9WSFBiZlVwYWkrVk1qQTk4?=
 =?utf-8?B?TTdNdldCVTgrd050V0JyNytwNDE4QmZINUorYnRNR1dhUG42WlkrSDVUNkRn?=
 =?utf-8?B?bDVEVDByN1VpVXZYbjViQmhNWnhGc0dRakJ3YUFnWExKTUhpanpQeXhVbmlH?=
 =?utf-8?B?V01UNldRYm95ZXdVRUNXOGVYYTRIZTJnMEt3SkliRE91OWJBeG5KZ3czY2Fa?=
 =?utf-8?B?cE1iNTl5MFUzTzNCNjFuT3ZKVVVBL2NVNlVBRHJFOCs2NVZXZzVCZFdUYUpa?=
 =?utf-8?B?Qk5mMkx6Tld1UjR0d21RRmFROWg2TTdTcUp0VVB0a2I1bjh0SkIwSDlwRlFz?=
 =?utf-8?B?SE56cG1pSzBON0dHNXI3c0hjeklIeUNTaloreTJVWXZ5bUI4Qy9ZTkYxSWEx?=
 =?utf-8?B?WXlHM3l4QlVkWEplbFp3WDBpeWQrNG1qbW9PUUlGcnRRaDlhRUtVWmE5dXhp?=
 =?utf-8?B?OCsxQkRJcm5mR2EyV2NBTUVxRWlkSmdQWFdjaWRodURLYVcwZjdoeWtJZlRP?=
 =?utf-8?B?T2VXclMvc2xGbGxaWmZZTlR2cWszMXhzelEwNW5FSHhXNWllekRydDd5eVRY?=
 =?utf-8?B?Y0RqNk96a3JqWkxkWXhkbGd1ZWx6bm96UFRVZ2g4WVZkTk1iUVlPUnJYNWRk?=
 =?utf-8?B?SEdWRUpNV3pGMzROQXVNZ01kRlBVZXNaWTVVUzgvWXVGMmRiZW56TSs1OWNn?=
 =?utf-8?B?TWdrV1A2ZVVwYk52RnhPc3haclRRdHNtSFNYeWtQTkR3NG1oVXU5ZHI3UjVk?=
 =?utf-8?B?QUdpSW5pcnBOZlVsQXF0RDg2UkJpa3F6QVd6S3FSZ213MlJPdzFMdUQzMCtu?=
 =?utf-8?B?YS95QjdHZE9mVzlHWW56d0VWMHozbnI4ZjRzVHQrT1o5VkNwT3N4bkdXaTkz?=
 =?utf-8?B?V2gxdjFxZ0wzTVpYU3JvOGVOdG1ueEYwZk8xOW13WU8yZFpmY3V1R0RTYTJK?=
 =?utf-8?B?c0tzQks5eEpUbktWZlBhZFdYOXoxMmpxeE84eVJMN1EvbTdqT2oyMnpDakxs?=
 =?utf-8?B?R1pMVVJQM0ZMUEh2UFpHOFphSHJSZktKNm1zWUQyMXJzZ3ppOWk0MVFFbS9T?=
 =?utf-8?B?TGtjZWtOVEIrL3F3dVkxNnJpR1Bia1MyajhoNUwyVDF6WldlblhwWVdMSXlo?=
 =?utf-8?B?MjlvR0g4d2pQYXErWi9idURuWGVHV1F0L1dwZ2FkVUg1NDVDci9CaHY2bUxC?=
 =?utf-8?B?c3UwUlpSbVVmbHBkRUQxSHdTNzFSeHNOdnlLUU5hdWtkMWRVbEQycWRDSDc0?=
 =?utf-8?B?bnlKVHhkSVhiT3dLSVgvOXFzamMxZit0djJ6ZnA2ZGNhWHE3QmpFQ2xPTk9j?=
 =?utf-8?B?aWFEZmVBcStYMzBoeEVRMGFScC84Ly9zcSs3QTYrMU5DT2RkRjdiam9JQkRO?=
 =?utf-8?Q?nGim3FbmUq9AUY6feW5DxALA0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3060b5d-09b7-474f-bd66-08db8d8cf4ec
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:14.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fo6SFANs8pguOoX8V31eybIUYYyhIwjX4h78o2aIFOcFiQrXns2QvBRj9tloZQoQkgIRAqMHy0UuXS+MjYORpQ==
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

