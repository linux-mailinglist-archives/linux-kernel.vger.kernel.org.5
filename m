Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0797764784
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjG0HCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjG0HCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:02:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30E2D59;
        Thu, 27 Jul 2023 00:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoPNkdNf3CwBF8fpYaiIjivGUhuAvSL1Q+fswItYF95l1wJn6hyZTK9nWa042TEgmU/T7GUO7ekbxL0csiFmQdeWMrSoiHWYta13N9aFXCJXpry2pWlso9LK+j681M0EBjRQo6EI0dkcTOlgyEecmsOevHFaExgWxGZrtcbksohwFmUxL4e0i2JqqlI4BtLqz06pe40UDvSGTGiUrBjGNRNmFsiSUoycn0k3UQ3afKnlt9VkUuY5OKGimZT3R6VykLY0TLbC4CpXW6YRglfNj4zoWzTap2IOBdGWceiTdWR79lj4sQisPZbU+7zBrv+Ty5myCxErfIk8OZve/tDaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOU6V6CM4hDWvK8Wspv66nRWzHcyqIZmd9G62GfyWvg=;
 b=hztcn4MBj7Cj6blueolPyd5+6VNLPFBdigPSEhOL1j+8B6f1G1INBeaW0ZYp5ydVHmrN/ytsY0CVfZsdJortCwrkEiMpTi8n9QENiV4rLqJ0zbOmuFOzgIqIOfeZ9fjqCC1BEbUFBr5weJN6PUbJHBLQB7lpY9MiiCXiwn4tALfQU0HAf8KNk5tRMHFlG+wQBNFlG1HQZB0Li2BKfBs4vfzpvwmfaLScFwr+yz/dCKqQUWiJebB4IMJo/oQVmKNyu1kr2ScPDHzvEEb7iPrVHaT72sn/j2QsAIWG7WAGCC5XJH6EJ5NShUrTXAhAAzgcTJlMjb4kmetK6Y1He+iMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOU6V6CM4hDWvK8Wspv66nRWzHcyqIZmd9G62GfyWvg=;
 b=F1nQSZvNtlxnABkzwvxiM0QQLI+q96F6VAJAtYbnOLMJlDlNK9YO+o8U+QbzMLGi2RIFONF0D2BrpX1SHjRfBSobGEj06RjwbSwSu97ZOFrjV0RHc1tGzLhrvkC452kz9nZfNmgeEYsTo1bin2xrrkEI5A6oGXdqpNnOQwQLdHR7qqKYXCcewB4ygnXvu1jhkd/Uu2ZaOCa/1g2heMJnDUCCBmsBNsCtHbKva7sO9jqWd+45nNynVWtP/4whVzfMR25G2agC4PDm3oX7S8qacdIMORr4rTQLGqVyvpiS3l9HcH/sjfKYDkdRKrj9c2RtEq19KfCbqNQOqRLc0d0pUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/62] mmc: sdhci-of-at91: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:01 +0800
Message-Id: <20230727070051.17778-12-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74e8dd74-8c5e-41fe-2850-08db8e6f48f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHQzDhAkjaF1gmCxf+M2t3UJVuxarh5r94EW5lScEcLf5xeqhbOV4gWZDpwwYGsr5L6JrMqojdSkYr4yUNugmbkUkhtueDDydqIbdubUa0VKz+/8RUzB2TgoJyurztbj6+18LA/Q6tcvOxL25sTFOVQWlKBeLMF9Jfre9gT+ItI/uv5WgWXtrMzht7d0LUctlNizry5ICqOLAA5CSys+JKX9lB21Y696HIZybSmqMK/fo4j1PD/EG/S6hD9mbxojzTqfdtyWUp4GLrjGKedjZpTdeu109b4b8GAkiDh1ezYm16UnemxHd7WDHDNGqJ1FB6/NDUTdeHdGGIr/LkWfRMKcMQ0przqRBzPZ7j38uTAYnFkmP21URtA8p5/rJgp0hDs3G0xdsW8vsYxnTq/h8Y0Tn2F7771RQrfINy+GTn5wp7gl7Ic0K/mivhFYNWKRvJ4lGik2aNoynvKQxe73d8aLCmYAfWbJ8s0kbKUC2Z/vNbDlGpXQMJ/uMM2ukxJATIfymlvt2coMtg98Elcra0QA+UZgx0iGXnl+wLdw0L8KFFvt3h54QFObKaQ+s24dEUqSjL2sdQadr4LfQgD44zc7C+wV6j+gWPEVKCclprsBtivCRIQkdQWfNKkKHzlc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(7416002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVTTFVMMGR2VDNBU0NXc2N4YitoRDM1cWo3cGNZZFhKMWwvdkRzTXlGMlpm?=
 =?utf-8?B?MlVJZU5iREd3alI0emE2MUhBNWVlT0IwaXFDR20xL1UrSDg1YXpHSHJYck8w?=
 =?utf-8?B?bUtBQ2RGRHp0UlVDUTc4OXV3c0VlVExpYnlOT3BqY2cyMng4TGdneVc1Nk83?=
 =?utf-8?B?U2MwOEFxL0U3TEZGSzFHNWNqM2daaWplZDk0cFRlVTJTcjNyOXl1d1JEZnpy?=
 =?utf-8?B?TWxUYWprTG15ejJHOHloc3U0TFRtYTRNbXRwNFJPcDNQREJJelFRRU1ycFNH?=
 =?utf-8?B?V0dTUllFVWJpMEZEZmNXamptaDRPZHkwWmw3MWRRUm5lKzZXVWhndktVK0Zj?=
 =?utf-8?B?SW1zNUlIRjRKNUxXZmVHQnhPTlU5SVFkRktBQmxqaCs1VXBCV1pJQW96TzZY?=
 =?utf-8?B?K1J6QTZYZkIzRnJNZGN6Sk55dkFZUEcvTllaM0hvMHBCTEczelFpMUpVTThk?=
 =?utf-8?B?eVFLMVZlbE9OdnlidmlIQ1hPSHlldUllMFkwczJBdTBHZnZ2Ym1BaVdSeVFs?=
 =?utf-8?B?ZlNEc0kyb1BJSXE3R0RFd1RtTVZlNkZ4TE1CbWFZL3poWmRrRkx3c29wN0dQ?=
 =?utf-8?B?T0tlWWFlL0QrZkxvVXV0SUVxTkJWc1M3UURIZUtoOUF5VldtMHZXeldRZTl6?=
 =?utf-8?B?VmJIR0wyQXI1R09oaUJSSGpCK2dtWDZ1R0g4aVBieDBMa2phL2s1dlhDQk5y?=
 =?utf-8?B?Nkt2VHZ5aUpHSk1lMnNRaWgvV0c0Ti9rMFJUaUhNNXNHbU9CeTB4NHZTSitX?=
 =?utf-8?B?d2pYejZiWW55eGVjNGZvQU9oN01JTWhKZkVKRWdpcmN4WE9ORWhDVW9CRjFu?=
 =?utf-8?B?aTMxNTRPdExYOThDRnFScWR0UnBrZXJYdTdybjZFT3pkQ0lhTTljT2xFTUtH?=
 =?utf-8?B?bzJYVFRBdmMyNTBpeko0bDBpb2xITStCeFBLelFxRWxKY09lRzhQOFNPclp3?=
 =?utf-8?B?ckczLzBHYitMQXFMaGttK3A5SnNXN3Y0aGhNVnducUlUT0VkSjhyZ0ZwQzlK?=
 =?utf-8?B?Ui8yZXhzWXBCQVpnSE9zWE9Qc2RXbU5YWGhqbUszbnd5M01DN09XY2dPRWJw?=
 =?utf-8?B?U05Rb2g0RnRrcnk0SDh0c1U0cTkxczJsMVExOWcxR3A4VWI1Tk9PZ0RBSnpW?=
 =?utf-8?B?QTR0Sk1QOVpSeGJhLzVhVHRHZ1JPZ3J6WXNHOFluNlM0dzJTK001K3VXa0Qr?=
 =?utf-8?B?UHl4VzNxODZxenl6czd4NDVhbGNKV1IzRXRrd2hpT3VHUnU4OU42YlBXaVNR?=
 =?utf-8?B?YmNZZUswbWxTcWRKTWoraWZ3OXF4WWh0VXg4emZLN2NUUEFMLzlBS0RxYW9m?=
 =?utf-8?B?RmpzTUhwdiswN3JBNSsyb1hNcDZBSWMwMTlCdWpEdVJQdDJ0bk54c3dBamxl?=
 =?utf-8?B?eEZTQnNBNGQvYnhBRklOMTcvMnlGTWZKSVB2a2VGKzBlMUJXeGtxenF2K1lS?=
 =?utf-8?B?QTRTcVlqbzVkenhlczIwcWYyaERrc0JVcmxteENBcTFUd2FHTC90dTQwRE5n?=
 =?utf-8?B?bmUwQ3JCdGFSQW4xWGJXR1hxd0NvR2d5Y1JkQWo0THh0RU9aYndJMkdnbEJR?=
 =?utf-8?B?S3B3K0RaMXp0L3J1dEhBOG1PRUxqNkc4Vk5QTEpLck5qM2JoSUtzRlZOYmpB?=
 =?utf-8?B?SU5KVDhHVWE4V2lHQzdobkNmMkdWaXZaMVNJL0ROVjRhbVZFWXRlcHBtVnJh?=
 =?utf-8?B?K2lqbFRNd2owNHkxejVoVmR1MGFrMDNQTkxwNTR3NHFWYStQVXF0bjUwSlFM?=
 =?utf-8?B?Q1ZVd09zVzl2NFhuZHJKTzdhMFNKKzYxYUhKSmlqU0NWR1hhMWt1WjZic3Zw?=
 =?utf-8?B?cXgrODl5SGlVa2xIVWJZUEpYd1VlT0NKNmFPa3o1VnFBNEFtYk5xTzkyR2Jn?=
 =?utf-8?B?b2l1L09yU3dRVXhrV1h2WGFjNlphOFJwMGtUK1VnTVF1SzR6V21mcVpVd3Ur?=
 =?utf-8?B?Wm1ITEwxMThicUhDWWNpcVZiTHpxdjVVVk50SnZDZ3MyRGRYOWdEWm1zNmR3?=
 =?utf-8?B?LzhhYVUvbHZmNEtic2JqVnZlM0t3VWpJNjZORlZPQTRraGRSSlBkOGUyaE9s?=
 =?utf-8?B?eDlQMUl4RHJMQzdOYmd0bnpCQTU4U01kTm5wb2ZBaWhTbHZGSTRzWUhUZkRl?=
 =?utf-8?Q?lJnVsBTIm7wDQbZLJTz7j9VgM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e8dd74-8c5e-41fe-2850-08db8e6f48f2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:22.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02Iq30tRozaMujh21xEbKBaOo5gcD6NiTdPSP9sP3wOw89rpf4ohtEJs2AulMxBIS4zC66Pr4kSfvDEHHrwE+w==
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
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

