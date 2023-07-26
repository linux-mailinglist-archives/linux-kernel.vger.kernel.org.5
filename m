Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379787629C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGZECU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGZEBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A1B11F;
        Tue, 25 Jul 2023 21:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBUNuf0hDtZV2xsTwMuQDlIT6tjuiXFlztXl7xxmp2pKjGEVRX9nAcBWZBMT3Qlnu2/5oGe5zN6umgoPlZPhZPGORj/n1eoSJQnuZ3Z6tFnkZkaKsnf3oEXm9hDLdnHOajkMF7IDsRsTuChpk7JFD4n8CVm1y76qZLRDCtkY3MkHDb7G19Bjc9sYUJM2iuVSAErnsBDMAT9NIkVKupthiDvkI53NS3mIml8RpHmGt1ZYtKxkJ13bOUUkjCZEkHePVXqZu50RJyX98qRGJv1usCddJynjWgGJckTuLQy12NuMLtHJRXiaFTI3t7yZvaAe26BtVeHi0Cp59FUb0FIQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfkki4xoknH9pl2wMgN3/myZCKUOHnsaDhrfpsUGHGA=;
 b=YZXIUW8jqtLFfMmR9bbzBqAq+t2QjHJDl8YTV9ZPTjjk1PUd47zQ++j9AIIBdfKuE2ub0oquPXuz4IPbLfB/xLozBaTPQwmCnxRN2XzEr3Htivu0stPPcZh9cIpu+k7t5G6Php5bLt4zCwv28HcRtu4rLE0Mi1MhFYMw8Av19r9qMvHNUly0ho36r1ejZ9G2Wbbn9kpM7RC3mOTfTW79HEgSBPR6QyFHcW/XgvI541nB6PhUsG1Z/dEb2LWp4BFlk5gAT4nZdO8C1oEhm9Djh9urlKPECWA2n29I36ew54rC97L4D/TQwpBb2t/WtMi958BDC2J4m3aKebenc8lyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfkki4xoknH9pl2wMgN3/myZCKUOHnsaDhrfpsUGHGA=;
 b=j56RiXgVdwAPpBaP65ZKvX4BnSRGMOlKIfRxQQeWvTWP7VazzfliHtLoGccGh7tYV6xsf4a+Q47cv/0G8NRVSq0ukTK2r8/12n19AnNgtALFIsBr4rC7nye847dyc3CewiqgI7mnEVoy0oIqtKgrIRvwS+13OjzMYsTYQKwYvcGJQdAEBC67qpWH+j+HZOOyAUjRW6esRm6HdKSOL0h2HRr84PyYcmnmeiib0uqDU6c+2rIKKO/9S92FJT3s3H+xsCpghk4A+PnosWN/bJGXOLowoMbSqrjK0+mtUXaCZEOo35skJkc0C+PPYVZEvfK+FDKYK8Adh11+xZ55CjAjVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:18 +0000
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
Subject: [PATCH v2 12/61] mmc: sdhci-of-at91: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:52 +0800
Message-Id: <20230726040041.26267-12-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e60ac90-e227-43de-159d-08db8d8cf705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3ICjyOkbkW4HIDlCry9+qm2jXZ6xXPm7hxvAaCrYncuQwMyngLp1+EQaUZnCY1KRNDPxULpTwcq01qp6Bu+faBaBcZns3Rd9un5KgGeVlRc62uA+kpoHGfGXxbU6Dfgnnh+I3Y01n8GO88whnDyFTzBpQq6mOKJJ5msx2+oIB0/oVUDMla7XlYIs+7UD4FnhwBMgu9imhB7hc+YL1G21ldHe9ZO7FJgC71McnzCFOLV2JPwz4X+9tzI/zeCjD6pgffmN6J76z1p/VEZHjXCPGgDgOywqL3m1Y0j+4SkxEUSSfbaf2sA/+U+/Gbz5fj3CxTXY7Db4tTbOkP1MNLQed0pZk3eenaKGf8p0bbTlCigb3xZh0uRFVxvFbuEDSBVpMH3T2rB4GIaUc6OoFo4rizAQjICsrPLFUbyE0sQoHhy0kyc7C3lEt/Q1TjK92L9TpxNf9/AjNImRbaKaydnTigHi2n9ZkWtI2PRNmdra6T4xqPUv68NzH0SNYOSB6prx++sqFTRmftYuIkXzXAKenmYEj+t4vGY9FeDq+5krYUG1EP8k6LFrWjspS7Nqs0Iyi3cV9zs8Y0NUPljoEPzJ7j215KIOystgqMT9rROvCMTY1MAfXO+Rx8oZS8yH+d4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(7416002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hFNC9DYzdIbjhhSHQzVDZEWm9FQjN5QU1NTW82djAxblFwVlZ3bjhZTXFT?=
 =?utf-8?B?SWRvZlc4SGRNVzliOTIvb1pOZEdxTkpjTVdKeGM1emsvNVhYNzZtaTV2VTFO?=
 =?utf-8?B?SlVONDBxczBIRnBXWDF3a1F1YU11M0JGMkdXN2RuS1VtRzhsN3YvSWc2WDYv?=
 =?utf-8?B?UWxudS8yYzlQRkVQVHZkZzJwL0NWWlNJbDJ2OG1wYWVvZkJqc0RmQzVTTWhq?=
 =?utf-8?B?NlJoVWt5S0VKcDROamtHemN4M3VLdWtFdEcrd2V5Nlo1cUp6SDhNMU93aE8x?=
 =?utf-8?B?dmZPdFVnc2hRWXk0M1VPVUF0ajRmWkk2NWt0am5CZ1dFNXVQeWxyUTFZL0ZM?=
 =?utf-8?B?K05PZDJMMTVWbFowQnA5N3liUkhwTWIyL0k4UUJ1NThvTThEYXdhZlJ5NFFG?=
 =?utf-8?B?d1l2QmMyRnNjSjl4blkrTXV3WEIyL3d1VUhON3FQRkVPNXdHYTFjVU1wM2hj?=
 =?utf-8?B?VmNWdEltL3ZlRFFUYTc5SXMrdUNNKytVcThkQkJmVWp1M1RJUE1nVmQyRWox?=
 =?utf-8?B?SUZ2M3duNjVkOHgrOE1JWXpPMTZzaXhpNU1GWVhFRGtnbUlTc2UvQmVUa2Vq?=
 =?utf-8?B?ejJVK0tNTnNYOWJFRDFickJGRnMyR0FKQnhDQkg2RU5EdzBlL2cvOWlaZ3Jv?=
 =?utf-8?B?ZjgwTHk0UDNnN1JxSUIxNmswdi9CVkpyTFRFQWdTZkt3TGlSeVFvYWV2VjM1?=
 =?utf-8?B?b2g3ZG8wU3lHUEV0N2Q5bDBMSnBiTWQ0bHMvNTBCMUc0Q1pOL0t4U2NWaXZF?=
 =?utf-8?B?RVk5dU5UeG44dTNad0F4VlNiZ3psQVYxcCtXOXoyc09nQlhyRzRUZ1YxUWl6?=
 =?utf-8?B?alkxYXM0Y0ZvdnZiMTdvYkpWSDJjQi9ybVdjdmlLbzIxRWhBU0NMSWFsMXAx?=
 =?utf-8?B?SFhjOE1CSUd3Zm9WOE5rNzRPd25ka3o1N1JSaVlkVGk0Z1lBcHUwQUFkdFAw?=
 =?utf-8?B?dmx5enQzaEI2Y1RmTkllTWwvSjhxcEF4Z2hKcDZETjJxdUdoZFpaNFFMdzM1?=
 =?utf-8?B?SGlVajJxOGs1Yll2Y3lmcUQrMnpBRTBKNHM3dTRKZnMxMEVuYWFEZmFQTy9k?=
 =?utf-8?B?di9uaGdYWkRrVVB0NGpnQ2Z6V2M1c2pHS2pWMG9lNEFDdXpCZk9aZDA4emll?=
 =?utf-8?B?R1k1OE9Oc0dmbGxxcmFLT2g5S3VBWlo0NnVuZVVzRW8zSmRPbVd3c2RJdHhl?=
 =?utf-8?B?dzFpL21hOEdSN0MxNll2eGVtZXJhci94c2JMUzhXeUdtZTM0dFdCaUEySGox?=
 =?utf-8?B?MzBGQkRTby9VNGJha29nbjlYNEtmWnlWVlBCSkJqb3V4ZmNWNlJlaTFPNkNm?=
 =?utf-8?B?NnZudTA3M3VOV3prMmk1QkhkYlJFTUVwZkoxK2llcWJEL0xZemMyZWdHS3FD?=
 =?utf-8?B?WjgyanVJRjBiZkY1ejI1cXB4Tkdqclh1WDhoYWJoYzlCekQ4aitDcnZoZWYw?=
 =?utf-8?B?bGJ0eFF3SkJ2RHlUMFQ2d1dkYlZ3d25XR2t3eVFMckdpVFdaYUt0Q250a0Z6?=
 =?utf-8?B?K0FNakxYVzQ3K0JUaFBZNnlRWm9YTHk2R2RGbzVFeGdYK00yQXNRWE1mUXor?=
 =?utf-8?B?bFBVT0tHUkNseU1KVzIxZzlUWjJCdWl3SGdFNGdLbUU1b0hrWEl3YS84dW9p?=
 =?utf-8?B?MlNLNFBaU1V1RFNvNy83OXdjVFJjNFNWd0dMQmNZOWlDdFB0SWhmVzlYUHlM?=
 =?utf-8?B?YTNiMFZwMFVYRHlMbUtVOUVHT2toT2JTQXJLQ2tWOTlzdFREQkRFWndXcnoz?=
 =?utf-8?B?cWhQaTZtS2FBZk9yUndXajdkK3VQb2p6MHBmaHNhcXdtMXE4SUNuVWtpTWdy?=
 =?utf-8?B?YU9ReHdZbHRwY0UwVS8yeE01ZjZ6d2NWR3NvNHNkenVWREgyb1VOTlI5ZEdF?=
 =?utf-8?B?U2JiZmtVTWdNdWFTa2FoRVkvSmZlSzNWME13REFZRmwvY20ydzZGbEk5bUZk?=
 =?utf-8?B?WGFuOThDK3FNVkIxZTg2TTdXZmg0UWlRMFEwampaTFZ3OVR3NWMxd0dRcXdN?=
 =?utf-8?B?c05qWE1qaElDY1BNOXlCL3VRemZlbFFDMzNYZnpEcGRUekFwSS8xV21heTA5?=
 =?utf-8?B?Q3RCeWhOeDc5ZWdaR2xZbFhVSmpRWkFkN3hjVzhNMzdZVDh6TmxoY0RsWDdO?=
 =?utf-8?Q?J0unTRK2dpVC8qKAQV26Bkt/F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e60ac90-e227-43de-159d-08db8d8cf705
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:18.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLaD9b9FGSsZbuebRgS8yzFee6i+QJVRSezagWbtcktNHkHT/nK3oK79hHleV8gcEL05hA7316a/VM7H2tvMHA==
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

