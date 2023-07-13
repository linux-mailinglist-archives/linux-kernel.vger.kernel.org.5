Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88795751B13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjGMIMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjGMILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:19 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23802D44;
        Thu, 13 Jul 2023 01:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCebGbQXLkJ9W7E2I0phW/qoWKrDC6drBuQF+QbXTG8VIdnSX6q86nZTm1XIHr44e5nIxYWlEq4QhLngIKvXN17z9KtWXRQigGtrsLUuSpUpQin5e8JQIDSCPQad99eKURGLCUT6vzRDlaR0HvRDRCLlO2viwiOku/k7EnnLt42ZTrCxIKjs16weMZf62cXlII7ZFXGOo3iPNfG8hwHpxOSULwWzBFqAjAxk9irEl/qpZky0AcDFcKxlaDa1/laDr4rXjslu007k2Rq7sZom7YdhsAiWhXmug3DMGVV/1+ruySUOwm3OHWpNV5jWvsh9ljzWl943qnl/xsW/kc8a5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qtX4rBf8ivXplsOW7iRs7V8GlYIlgMr6Tweprq61nI=;
 b=W7b2aKqE0/YzTw7NAstJubJW8ONc9OrFfXcsLjuFSBFdsjgVWpVuM2le8fUuzQu8AigNBuU/Z5beDPsSEa98FQPi0uKaObBeF0Qqr4Sb4a6l6OzNyf38uxjy6ym0j6fEkLfWBZgtNvrlfsqtkV68naAwiqF50tWIsu8M1TcWL04gac87ecoEyqwuQNjzVblrOX+cxkVHWxTwsPi5A2UHqr0QUBeoXyU+UqRdnnMwaCsQ3aunbhcgIP2l61pb3YXgsQcib/Mf4aiOYrPDIGX2btuMi8v0XRRY+aeuJ4tsi3l0mlcq9o7xLGET4Lbwt+hFms2FrwD7AsVxkMYflpBnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qtX4rBf8ivXplsOW7iRs7V8GlYIlgMr6Tweprq61nI=;
 b=UwlxPtG1Ovq4S1NwJKSoQIB8A8xX7Qc8yXqrf8wmaMapGAX3Ss1JIrJvVClRGruGNQZIaO0UOakjTmZ3mfHVp9hRSxE2PV8laPpFN8vW7hWoE3muVf7x49FTFNUOVV/wCmCY0sx0GZTiLpykeWHV/Edmazf+MmC24pWJMbiejJHmOpZ3Fak3U5xuTXrC3cCcwLmDORknwbLD0wmOB4sFxUtMgIXpguM89j6wryMUTyvs9FRgRHUIf9D5Mg8eBFAStARoA3gQ5otFCpUfEZdMlUGJZs3N4w1q9CKM8mu89acNzpP2IQyyeF2TCeYke+ppeE0Ix+TG9xI+u/+8v9bvmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/58] mmc: f-sdh30: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:35 +0800
Message-Id: <20230713080807.69999-26-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 63815350-9561-4b17-d835-08db83786d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEf5PqpvC7aHnjxIsCo+Gn+uXlzgu+AJ6K4ECIuLDXwYIKMS1/giP2DOc8BxbGYlaoMNGO7W5MsByfziAkTu2ZQVOhKeEKiStXBlJu5gb0auH38srCdNsFbv3ntkZkB1+IHJ+HCxMQl1X+zuNVg7f/0HoPlITkisUphqJHsorYnyIUvWvMed4BA2cAG25xdZ/aDJjXJjoT0f7QyVrg0+mGHNWNG+lFLPYHQfJI13XeZtz6/9IIKHZgwATZrtQ/S8DQ3g0FJXYcSMiXcDS/CQad7nBgWtXK/ulLE4rt2XiiA/c5ZFoE2+ggK83GhXtzFc08Xo8adzrghHpnP+SGYt4PTlPuDn/vDZKsbqPPlQ2LZybKS5LBm1dqKHNtPPbLJARBWMV9TlM+yviLiTff92IcvzESit+tkkV3bmnas7yKKA1XGuq2pFOI6FDEXXdUskN/SGk4GVIqKC1sDwnCCd+CC1OUmdtM5c9Y6aXVP7m/GaBZsuRHtY1ZhkS26PBesQJ5vJQN3OdXdh+3M1yZE7y/m+KIFkow8pU5UAmxP8hfnMTEpd8p4QK6yjup2MzntQu13xQcnoN43myrtrW4c6W1ELLYH55PfLtWWpdZEol1I59E4yOqSDBetwWNtEXQDk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHhOVVVuRUlBQTFDbTVxR0JwaWViZVhhVHNNMVo5eVljV1BSQWRuSjhtZDlF?=
 =?utf-8?B?MUJob2dRanc5U2ZxR1BPSHZEeEw5aUJpUU9sQm5DTkdqdlo3cG9SK1E1S2wx?=
 =?utf-8?B?M1pRYWZXQnJCVElhR1RVdTE3Ny9veGRVTGlTLy9yeGF4dUt3R05ZY1pjT096?=
 =?utf-8?B?MDZNSUU1TjhHWCtVbTlsY3p0elJJRUJzazh0WU04T0tMMTNIL0M2OW1OZnY5?=
 =?utf-8?B?V3BkaXBaTFkxanVtMXFOcndUUUR1UkJNVzBBTDhXN3NFbTJDUjZWNTdVWXZO?=
 =?utf-8?B?NFZqQWhZN3A4aThlV3RUbVJpbVExaXFvSXBORHh4eTRFZVBuU3R5U1ZqeHcr?=
 =?utf-8?B?dVBuVkVEeHdRQWRHS0Q5Z0FqMVM0K09KTi9GSVBLWDl4anlCUUVVeE5wNlEy?=
 =?utf-8?B?Zmsvall5TlBBMHp4Rmg2QkFWN29lckMzVDU3dDVCS3VvYWZGUlpMTWtScUQ1?=
 =?utf-8?B?d09nWUhwbWI4cFJNQ3B6ODU4TVdYbHFJY1ZIbUJUeDR1NDlYSWFkRXNsbmQ4?=
 =?utf-8?B?U0Era0FGbTNNNzdUczdCZ1g1Zi9zc2VTeHlzbXNLdFRnVXFaeWZNMC9Ybjh0?=
 =?utf-8?B?cHljWGhUeHFuRVNQcER0dDl3K0FUcXBFRTVQS1krOW1VMldNa2dtaVh0THRY?=
 =?utf-8?B?NVEwWTVnc29IOUxZNlhJZTRyYkZwYjlvV04yc043dU1VZFNNVkdnMW5BVXd2?=
 =?utf-8?B?aWllelB2d3RibjNaWDRzUWxTRm5abCtHbTRURzhGdWpYUWFZSTBXTlAwWmJF?=
 =?utf-8?B?czNFUW9vUDRmaTMyWmtuR0dKRWVhR3NoUmZQU2ZjeC9zMWdFS29MaTVHWFRM?=
 =?utf-8?B?eFVEektqN3hiRjNOb3AzYnBLa0x3TWFOOW5MaGRxV1d6TzNodUNrZ0s0c2d6?=
 =?utf-8?B?RmpzKzZMZ0tYcUV4S0Q5KzVnR3F5eTFnOW1FdWZNTjQ5a1ZqUXpacng1cXVo?=
 =?utf-8?B?VXlKdHdwaFMzRk9wTHJHaVJKZ2xYMHUzQ1B6WXRjZTNSM1NTQWdOOHUwM0Jp?=
 =?utf-8?B?RzJ1c0RxTDZqWlp1bjd1YnhJSlE1Y0lETkdLeDhkZk94NUxXb1U1bG9taFkr?=
 =?utf-8?B?Mjd2UndXM0UyQ0t5eUlOT3ZvMU9vd2NhcmxHZDlSTGNGaEplVzZVTE9GZnNy?=
 =?utf-8?B?NC9pQ0lLRE5LQ3hMYkJPNkFvMXNyWjZhcXdTUVZaWVZQYXZheXhnbmxUa3VT?=
 =?utf-8?B?Y0tld1dvOXBRSUcyN3RQUzgrc05aQmhVRXpoVWY3RlpuK0NlS05MV3lKYm54?=
 =?utf-8?B?R3hQV29RWG5ld084YWpicnhRZEJybHU4L3FYVE5pbVErT21tUlFUN0V5d1Js?=
 =?utf-8?B?K3pqOThYVGNVMXF5WUExUU5LMm1lU1NVa1d6eVp3RFNCekozOG9QQkNMM25o?=
 =?utf-8?B?VHJvWCt0Y1hDRk5sZmNPNTk5YzNiYVhCL1hzMCtoTmtjU1BKeVhnSTdtNno0?=
 =?utf-8?B?bXp1TkI3VmtJdEk0TUpieTBmRnhNbW81alVFOUFtaTdKMHZyVmZQbU4rN00r?=
 =?utf-8?B?MHBQKzZJZytKaC9DV3B4cG5vTHlpM0pMMUR1Njlnb3ZOZVpuTkd5MmpjQTJL?=
 =?utf-8?B?VVd2bUUrclBJb2NHM1gvWUZXMHJjY0R1QnBLMUROZ21hbDJwa2prNDBwOGlS?=
 =?utf-8?B?TmtJVHJnVVlhckZJNnZUcGp1NE1oZVBsMmpZd3g3cVZRT1c3czlZcWNNTGo5?=
 =?utf-8?B?R3FLRGpKQ2FGTmcveGd6ZnhQeDA4VFd6a1ZGTlFpeVFzYVk1eHl2a3hCcW1O?=
 =?utf-8?B?L1VyczhvTWROejVVNEJreldxbk5landDdHZLOENaRFp0a0ZoRC9BV3hoZmdF?=
 =?utf-8?B?UWZhRGZaQWlEeG82WmRnbzQ3Q2pOSWp2VVF3V0pYREZOVXFiVThBT1FTbWVi?=
 =?utf-8?B?MTAxOWZoQmxEaHYzbVhPZVhCQno0ZzJVWFJqK2RyNVVnTEkzZ2VQMStySHdo?=
 =?utf-8?B?d240aTkzODZrQUQrUU9YOGc0b1R6b2VsSUZaaUhnN3ZZeStseGY2dnNjNjRy?=
 =?utf-8?B?TTF1YU4xMWNFSUZQWG8xQVlmVHl6ZmttK3ZYeEcrRWIwdmZUeEx6RlJMeFJJ?=
 =?utf-8?B?NUJENW9EZDZFaUFFLzRwanpiZkFIY1ZQY2R1cW4wdGo3Z0J0WTlQMjFZYkR6?=
 =?utf-8?Q?IqdnIz7M5s/7VY3/bMd0RfHWR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63815350-9561-4b17-d835-08db83786d80
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:06.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NincHnWZFrmhphbUi/QsYeCTI2IQ5bvV5P+Bqg4qgTqrZjwIGZ62u69Qv+EnMUtyrtWksoo8/OHgjv7pdXhkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
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
---
 drivers/mmc/host/sdhci_f_sdh30.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index a202a69a4b08..6016e183c03c 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -208,7 +208,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_f_sdh30_remove(struct platform_device *pdev)
+static void sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_priv(host);
@@ -222,8 +222,6 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -252,7 +250,7 @@ static struct platform_driver sdhci_f_sdh30_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe	= sdhci_f_sdh30_probe,
-	.remove	= sdhci_f_sdh30_remove,
+	.remove_new = sdhci_f_sdh30_remove,
 };
 
 module_platform_driver(sdhci_f_sdh30_driver);
-- 
2.39.0

