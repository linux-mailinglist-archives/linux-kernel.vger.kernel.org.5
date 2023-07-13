Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A2751AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjGMILd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjGMIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:10:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CCD3A86;
        Thu, 13 Jul 2023 01:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqXRLArFgAnr3xRxhFqSPk8q8bYuQc+Mt2B9ZfKms2Obrue78OiGsi53mvuaLLYCAUYIctEfS5bJSewHn4+LuQhhEF5JCQkzjTTL99Qva6KmtrqQuxLkscmOGN11Wb2qMghTLY21VUUjByesMlrFcdQaY/+gOt69M49c/UayHAabiZb2vBFfYTRI+lE37AOBUd7q3Ak4RBHgBZUizDYBfSTQBac/ArLlu9KEX/cwAi8X2oVR92xbJg2mcrk/wCiSHWlgDVa3xZX9qgkXk0aQGd5e0UKFDEmo5aQHyzsXvFGDxEOGSysicSD9HmagN1RjtzwgpM8JfNdTJBEjK+ybDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGKTRYq08V0JvxsGHP5msYQNQ4gzgDy3xPfXbsZZVBw=;
 b=NM1olmGIG+mWw5zZnl0sBxZNHupDT9LAgnTboxZyQL5cSHCpE5fL7CWDA3TsbsWt0FVEUiSK6Es9+gyRDKpkhFXrjzsddH3yPFMNAVMwdGJa0aJ2MQ+hhx8GqDXCfpwt4KEzdFilY7zGFjA5OWja5ZHeFfMToPHoyc74lNVcqnpBQbz2xgyflSq/ucAJBTjYHBB+IGo3tKRdGmaAX56f6SOjoT9OfaiOO/LTPydI+hxdaGVFG/8w192YvFnJ558hykngSOTXE4+4hNtAa1gH5ZvRpQndm3NTsbsbKDiJrGWs/kPLNv/OPHkTduPzfjqthI3t/sFch2JUd31T94HwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGKTRYq08V0JvxsGHP5msYQNQ4gzgDy3xPfXbsZZVBw=;
 b=Q0VymLNWjYdXUxlnR1L3p/aDzrV9Zbmd4EaGoMUkMmapxJuP6iqLB2bV+V1vibU+BHOAVqRA2lKgY+PDpMGW0jG+tS/OuS68McZCXFt+dGLHkmaIZMYLGn8sLXwp2vQ8kJLlUlGMpny9K85Nf3XNMBVEInN1i7r32jK0SME0+mhmC61oKE5ygo2ICNsFbhydV7rzM0ADDSF5mZ0Sdj7CEy1DEYP0ylIV5WfVNvDh6Li0JAkqJSVcGEDJ0OQ4850RfqLt8eaghNl2p5VmX7NXQ9YwkW5d80w8LP4h9hNglkqfzqW+spxhf0GG1BJLnvWVDHQCZGhBYm3aBUjIpAQYlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/58] mmc: sdhci-pxav3: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:24 +0800
Message-Id: <20230713080807.69999-15-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f95b1423-929e-4641-5dd9-08db83786168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6ElLLyIIX1SrnUPbavt18ms4VENk9Q9UlOrP3vQ7QlAt+Z6OP3Ml+lbRB6ADvTTMDqF4mKdqRuOl9eugdun56a5ssDw/SJXmag02ilWtieXR0nixearuNKjvXOppyYeU+2/YYuuntTcnHTvP+sSfgbVcts7QL4pYZFqZx5U6oEww6uF7OZD9j/3Rtm8xsx2XgEsZPHH2Rgq8BWyZPeN6VwmAjnbCM/WoXOocYOwM1yqG6sokQrKoekRZJor49YKguhWvJiOj4yNrABeS1WUa2CAI5DhVsCJX5BfHchZjzThBX4VeYmQGu8YK0sJttzckfa9vQtH4vGWFRCh6U3meGOQOD8XlRuFvRnGHyh0jW6j5RHfbaxb0U3czNzsEao6Rm75fcFGJzC0bOOeRzylvZXWUDeKYJQ4X+1yDwm0cl/rVzL8tdguF3IUXsMYi2dUvvgByRuhLzQxm8MoucL3eaPlpvAhETgBzYdyKWNl6s7Gnv4yPeev62d9ys2GVUm3U/PK3bYoWnGOyCbI2madqljTS1uMfost/fynfjWljxiG/4/tECrSv4U/l/xP97hQIhk211tsyJwigHWEw+ws90DF1ZF0XGPrGze8cJ259N8t2f8UxyFFy0SCNagBCsDJ8DNt6ZZptHWtLbbsXNBfFzYsQn1fhBKr1jHk4N0abVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVNCbDhyWUkvRUkwRHVUNVl1blNSczMzcDNFYXpTU1I3dldyVHhxV3RqWnBr?=
 =?utf-8?B?Ui83bjByaFRXZmwvcU1yVDgzVHhsMmVod3BCcUlLNHM4d1dzeGNYdmpnSDBW?=
 =?utf-8?B?bTlUQXB4UXBoQ25jQk45UE91THlQU0xKYUtLNUVidXpsR1dMTDJTMlZWc0Ur?=
 =?utf-8?B?cm11Y1RJV1R1aXEvaUYySzNnV21yZVpPaFhrVzNDaW1oMzBUd1c1Z0tQb2Yz?=
 =?utf-8?B?MUtmSTIzdkpSei9UUmNvYWowRWNLRk1sRXN4ekwraktmei9SWWY4RTIzT0RT?=
 =?utf-8?B?MmF6aGptVi9NZnJBTjdoS0JKMUZDaE5DeWR3aWh2NEtYMmVpMEkyTW0rMVBw?=
 =?utf-8?B?Y0xPeVpERldTUDNoQW8rSUxFSVVhaDArU2k4b3FWZ2NJczYvcFZzbnZFd1pY?=
 =?utf-8?B?b2V3ZXhjaWdneFNLVmNUbi9iT1lSYVp5RkY0Y0ZNakl0ZDhwZUJac3puNFFE?=
 =?utf-8?B?cWtaRk1PZ0EvWWpJdWJVZzFTK2ZOeHB4aXk4VGk5UkRtU2wrb0FBanpLcG5Y?=
 =?utf-8?B?Zmh5L0tHLzMyNUNNYlhtemtYOTNYQ21LL0lnMkZHM0gwdWxqWjVWbkRWT1Mw?=
 =?utf-8?B?ekNROXlYb1dScHM3Q2VpcWNCaXRqdnF1ei9nNWZlVisvNFRqTklpM3FHS1Aw?=
 =?utf-8?B?MDZ6RnArdWFrckNscUsyc3pwYXI5YVdYOHpXQ3FYTFBxem11cnNsaHdRUlBV?=
 =?utf-8?B?SzBLb09GMFhsSUp2RHArZ3RZcW4vNHowWlJtZ1RSc2Z3SDJxUjF5U01uUUxw?=
 =?utf-8?B?U0xCSzI3RUo1WVJsM0R0dTR0RlFDNFpCRE1OY3BDNXM3RVVlZjVwRitBOUh2?=
 =?utf-8?B?OGE3WkFBM0xXeWhPSGFUeFBobkd4TDBIVlVRaXFIMXNNcm1IcHNkMm1ROTFV?=
 =?utf-8?B?QXRQWnBWd3czNGtuc0dxS0k5eU9VVmhQL0dMYk1ORkFSbnZtSnVHalNVNG12?=
 =?utf-8?B?dVM5N3F1b2V5dkN2M0k2RDhvUzZncUl4enFmcWtjcWpWNmRQS3lOck9Dc0o4?=
 =?utf-8?B?aGxRRjBsL3E2NmtIaWdoMDFPcG9Ub0hscW5oOHhnK29uVldtd0kxMXRNenFq?=
 =?utf-8?B?MDUraDJkUllzUlVDNGl6Ris0R3BvV09kT1dFeFhySlU0ZGpSNTR4aGtKR283?=
 =?utf-8?B?Rm9yZ0JCQ1hkQnNrSTg1UXRtVWNpS0dRNlBuSkN5V0ZLRnQ5RllPejNzYlVK?=
 =?utf-8?B?WlFFZCt4dUYrTVhJUnlhWm9QTzc2dWlIZ255OU9ycmlBWmZ4MVFlUXlxdDN6?=
 =?utf-8?B?ZEdtSkdJeTkrT0x1M0xLL3RSVWtXak9HQ3pPaXJjclpqZG9CSlk0WHZtK1JI?=
 =?utf-8?B?WmpxT0VQRHpRdHdPZGJFLzEzZkQ1OWlOUG1aTm5aWXpaL2FiR3VzbE1HMFBx?=
 =?utf-8?B?UHRka05wajE4ckpSaE9tcTFmelUvNTJoNmljTmt1TEVFbTBsOG9uYU4xUlhL?=
 =?utf-8?B?UjhPMU90WWl2Rkw2a0dRazYwTmVpRlJhSDFuYnhYVllQbGk0dWlubXdZQ2Fs?=
 =?utf-8?B?algzVjdhWWNtNzYvK2JnMWhBckdBRStQaFo0Y1NWT2RNVkUwb0Jma1Znc01m?=
 =?utf-8?B?b2wyTUF6TWt2azlBUWJtclU1YmwzRU1lcDVaMlI2UmJoZ1FDMWI5UjdZN3R2?=
 =?utf-8?B?ZDZoS2JHTWZKcjdBemRVSWs3VDN0bDZtVkR6aWxMNGFzQlVhbWhrY2dmRWNj?=
 =?utf-8?B?Z0hoYVhNTVM4T3RNcVQ1Q0k3R3g2WTZsNmZZeHlSb3lublRIODlWZ1ZrYUhO?=
 =?utf-8?B?MERhY1ZuTlNUNGFCZnVZaEYxMysrek9CM0FNeXArOXllQ2liejFDMDdLclo2?=
 =?utf-8?B?QU50MXl0Mjg2LzZLcFhhYUV5bThnT0k3MHdES3lCbEdGTkdQWndnald0Nmdm?=
 =?utf-8?B?TFo5VmFkQi83K21ybDluSEVDbWxvNVJ3ZkdFcU9MTWpsOElMNVQ0amtYSmxx?=
 =?utf-8?B?NGN6VnJaT0grblA5bHBQWnQyUE0rR1Rtd01UR3M4cTRDajJrVW9rNDNwZytE?=
 =?utf-8?B?VWN1YXZ0MThyd20zYmswYk9zRjlTb01pdlptMXpaVTZHOCtZYzVYREFRdVY5?=
 =?utf-8?B?ZnRQaHZYUHc4RkdLb3M5TFgyZlpDaGwvdlFDWjZJbzlSS0t6Wk8yVXE3b2gy?=
 =?utf-8?Q?njjFsrZLlz+KmmqgZzxUd81D6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95b1423-929e-4641-5dd9-08db83786168
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:45.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXaFxOAdWfzGwrBw7VpJAbdig1Wo2kT5z1BAMpDA38b7dwsulzPOyrounYSbZR7ZtPJgpkMYA6xDIAZuklyW/Q==
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
 drivers/mmc/host/sdhci-pxav3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e39dcc998772..3af43ac05825 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -470,7 +470,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_pxav3_remove(struct platform_device *pdev)
+static void sdhci_pxav3_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -486,8 +486,6 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pxa->clk_core);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -570,7 +568,7 @@ static struct platform_driver sdhci_pxav3_driver = {
 		.pm	= &sdhci_pxav3_pmops,
 	},
 	.probe		= sdhci_pxav3_probe,
-	.remove		= sdhci_pxav3_remove,
+	.remove_new	= sdhci_pxav3_remove,
 };
 
 module_platform_driver(sdhci_pxav3_driver);
-- 
2.39.0

