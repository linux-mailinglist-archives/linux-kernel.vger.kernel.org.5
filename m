Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBD751B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjGMIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjGMINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E723270F;
        Thu, 13 Jul 2023 01:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6OFLE5USJPw9cGX18srZfGrG/3nWgXybbDaT4l9fgDktTKaklW2Pt2eATcM+hY0Rr1vvym8dGd818tEOvicplKbs46ZhSEIp4BSSd8kt3Z8PMT4oVIhb5kV59ANLLXGtmKXfMX4Xk9uQLBVMOm75uW9rxETTM0S8NT56bCfZEG7g8aksn7+n4IhqQNIQjAaWibwbUWbc89Pt1R22KRvh1NKdIAHgDqeL5E2ffEW9EPGW98zH6hCohF89OTam7sLnSvZsgerQEyNM+X1BKNHwBJ6U4OgPrkevWSN8d5Y1xpA75ynDp7YY4VGsbjnXuEO3+OAJ/ZiOxlXo9nEZ9I2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLrIU4EUdrLqb7T0bkwRGkvgLMm9bmDLScwtsrZ+fTw=;
 b=MSYdDCEYdBTXxyZ8jJ7hpgfyEoOSwKb86B/uN91CaR02/e7LyHlpF9RtLtX/7iD5qZF8eSm3NV1ciE13oEnRKf5yClJRqicbYmNqbHiqmiI8uvjsWrzJ+ZVnaAXr/khtC1d11+Vr2/Y+ngVvarSM4qjhy2TqiHTEu2btf1ESNp2dkZh/9chPakOwRdKbSSMVQ2ziOBMbG/e43qaT9q+YFCYIDoRNP+QJa4oS/kibQsw6ZT5hMmS2uE/nxY8j/hAgI1UKpDCoDX0DVuNIazQsrqp+eNoqIePdC5pYaPINwxE4saSfSDCEDlGjujqcxSnPmgRZUDj5h0EVrfG5JriSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLrIU4EUdrLqb7T0bkwRGkvgLMm9bmDLScwtsrZ+fTw=;
 b=dgTMNzw1Op9zdBxKZW/L53YneOtZNoGIgN4KVim/nCq/XKz+Vi045cAR/RrJJFB++CsAT2wBqcDghHhLuGK/OR1wVO8raWJckCp6boLy5OxoggaSONnQfE6fdpaz5jxjxiOgltUG+8/mA25srXuIvmapLa+qmGjIJhFhVQRgli2rXIv99FsGjPsBwHkIOcbKSiYnEHlv8dxUtHzXAuVJz6ZcDzq8en9LvH3/oHMGfkaG1UMBqx4ZLuTNn5c78LP8kpMApzxv0zlpplt+nZZGQvMnfLnX/Tht4FscTyyQOgSRZXGLx/u/8yCydrUbV7FBR7mO1qT1vXPfCD0oz4XZ+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 46/58] mmc: atmel-mci: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:55 +0800
Message-Id: <20230713080807.69999-46-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b111f1-20c5-4eb5-5a34-08db83788316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgKPut229kyjXbczrK9i1FHBdKSoUegiVz8WoA4LNFyeLQ4cXJ8ZibCSlQ40F6WGBwAZXPr5hKZ39aWfyBOQegZVU2pJzmuvQmx0xtUFwQSVAPvkpd7KoUxcF7u9jnTSdB/b+bcuwpwdjPYOjdYM6R61bm5CDPlCBdVnUwt7tqJIs8uIKJz1AqvZGb5RpKkS+WA6kuqbrPRER/0AnUfmog9ZujuR1okSNyvcAjhssoBGO2eKM4s+Rc+NxkAIdIaFvLw7Ip9L1PDLqTofCEs11v/Cwdng7pnjJlUY4FDs2XBCc1Pa4M1I671NoZ1ffFRqgFmHmX8yDqtCjQw30KyS4jqxK1ED8xJa3EZcgCbpumVBE1lJ9hWUkGBaTqbvzff809ZrZsjgiXiC76PeYW4QDoKMNCY6NGmsVaD0+G5pMrIDyRtNUUv9iBLcZtAZBa34ChaBRgn25zmctqr3sKh4QUqLgWu0rCQFFnQ2y51orlK5SpmGioZs+CLPivLNlzday//UG3uVuMfoC5v/rRSFgEi/HTmMYHY0bSJs4IacXAHV+KEh4KsVqF73GCN5p9DDSTMWmIbW3BUkBhc4CFyPhGv9UM22ZBD09CGWLBWr4cAsGrR+IGStJSGw4wl1dXrR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmRVcExXckFVN2xsaGRWNUZkeUZIZWR2WTdtMiszby9LZUJEWHFtU0N3RENL?=
 =?utf-8?B?RUtKUnZmcklCamNmVnE1emlHQ2xndWsvRnFNRG0reERuVmV5MWMwb1k1cE1v?=
 =?utf-8?B?eVdheGFhQ3JmbUVYOXRlTUUwVFlGdklIM25KdWNVbk1qSjYwMk00VTZrYmh6?=
 =?utf-8?B?VVhsSTI4RWdrd1NWeFN2bU85aVpEZFB3T0VPWjhBTnl0UUtrV0RaMUo3N3lU?=
 =?utf-8?B?WFdPeHBOU24wRWNWUUM2Tm1ISGRNK24wQkwvQTF1MElHVFMvMXJYdUMvWXJG?=
 =?utf-8?B?TWtjZWZOTUI5M095R01hNGdoMFBvNktsenVhS1JTSjMxZUhRbzZCLzFYNTFa?=
 =?utf-8?B?cUlubVNLTE9rODU1d241Z2toMERlU3hqZU4vMVhadXdWMy8ySDNrbEdraTNT?=
 =?utf-8?B?UUtVbk4xL3pMQ1lFV1lwVlRaemdUM3oydXhyZzJJcXNHTEtiTnR6RVBiN2hX?=
 =?utf-8?B?SERydHdSOXFHQzZSeWdZT1ZpMTAzeEk0NjJJVWloWnlDR3p6bld4V0p2OFNQ?=
 =?utf-8?B?TE5QRzQvWmlqcm1pVC9OaXJUMWk5Mk9MUmI5OUk5QzRJakJGdk1VWlhpVTJT?=
 =?utf-8?B?TUVkaXZ0UmpKM2lUMEYxVW9vWmh0SUpxS1hXS0paV2pScDZmYXczc092dE1l?=
 =?utf-8?B?WVJTbzlnS1pOQVF3QnpLYU8wU01wdFI0R3ZNdGFqZ1VZbDNoenlVSFNJVDZv?=
 =?utf-8?B?aGI0Nit5Q0xBUWpxdkUycWprUnZ4dFVwYTFJR2JJbUZ4VE43M1RscEJsUHEy?=
 =?utf-8?B?b0JRUGNxTzdXMElYblQ1RXVDVXFHQnJVRWl3L21Zems0SjhyK1VhZHRBRzBw?=
 =?utf-8?B?aWtySUdtZnFtRUtOL0pMdVFFUGVsYkhUYVBuMjVwcUUzUGV2UlJBL2tLQWJB?=
 =?utf-8?B?NlhzYzZscWo1Q0ZmbU9jeTZqOThpQjBqSXRZcG1LcGttcmQ2bjEvTktUNjJV?=
 =?utf-8?B?V1BVQkJFVlBJYy9scVE0Wmpic2cxVjJPMjJUSFIxNFNqWmtUZVpLejlZdFB2?=
 =?utf-8?B?cU9GWWhVOWNTclVSOFloQlVWdEZ0ak5VMUpFTHhDaHcwVTJaYXdSRmFHNDhy?=
 =?utf-8?B?RzkwR1ovY2F6cmwvUzhJOTRYWjNEZzFxbFhjQzlYbXBQQTRRdW5MTnR6dTZU?=
 =?utf-8?B?WVdNTUdaazRNRWd2OWxPd1R1cGdsOVBGeXgwVGNvREU2MXJaUis2dU5QWXY5?=
 =?utf-8?B?VDMzZ2FBaHVPOHIxQmorSkJhcmMzRXpNc1k1b0xQeG9wcFhFL01xOGUyNVlW?=
 =?utf-8?B?SkpyeXNrQ3d4RUlKdGc4SFFXaUppbVVUSUFnUis4eTNxRzZUODJIclZNZ2l6?=
 =?utf-8?B?N0RWekJPWlkrVjlRTXUvT29BRmxDakJiSGNESytwOUE3cTNQR0UrOFF6TFVu?=
 =?utf-8?B?cDJHdC8wVnFBQ3RWb1RzMXZPOUVUa3NJaFZuY3JDc1gvL2JUb0ZoR3lFQi9t?=
 =?utf-8?B?QjkxYkNvUEd0SDFIZXNTaVcwcmltVGxJRWFBOHJPNDFBZHdCQ0swVVZlRHJH?=
 =?utf-8?B?R1pDK3dIc0xaV2hhbnUrSGZzNFRRa253ejkvMnkyVFdCSWsyN2tYbWI1Z2Nu?=
 =?utf-8?B?VDVKWUlubkJuTU84MmlWbWlFYzcvYXRDVlpkT3IzWDNYRlFzNXJMY0UreXJW?=
 =?utf-8?B?WU5Ud0w5ay9qS3U2dzNZWURIQ2Q5WDFGb2hQVDhNakJTbExzWmxBRTMyRTlX?=
 =?utf-8?B?c2xRcnllS0J2N2xjVU0zdVNieTZlNFZ6TWZDOFJkR2YvTTlKVUl1LzZSMkYy?=
 =?utf-8?B?NWRKcnRyT2M2SFhTQ3o3Q0x6MEtBR2RnRUtpYU8vRFFjZVJXc2tFdzhxSkhp?=
 =?utf-8?B?c1FEbDkrM0xCVHl1bFg5Rk9mUmpjMUFhTkRGRUtOYmM4UW42U0ZGK1liUnhs?=
 =?utf-8?B?MjdaZzFEZ0NMcWp5UWk5OEg4ODZKWSt3alg1a2hnTVY1N3ZkQ29DekZaOVB4?=
 =?utf-8?B?Vno5N0d0bFNCNmc3Mm5TUklyeWlaUU5qTVQxZWpKUkREV1lSbHVRZXFQR0pX?=
 =?utf-8?B?Vk52aWxEUWV1TkExTjZ4MUE3Z0pYajQ3OXZGaFZsVmpGaFlXYmowaU8yeERq?=
 =?utf-8?B?YUpWaDdKeU1uSUI0SmM2MENSWWhXUmkyWjVrejJ1TWVGYjBNWHJUNXlrRTZj?=
 =?utf-8?Q?7xbWcv7aUnEePlXKWFwXKbhQm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b111f1-20c5-4eb5-5a34-08db83788316
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:42.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbSvHRvCLx/0I3gDa8idvi6VCNqMZkXDk90YDzqPaN0KtCOWzNGhpM4ogbT1Hdn/1XtTZIkeXvzkJupS1AeVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
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
 drivers/mmc/host/atmel-mci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index dd18440a90c5..b4ae9aa939a5 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2600,7 +2600,7 @@ static int atmci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int atmci_remove(struct platform_device *pdev)
+static void atmci_remove(struct platform_device *pdev)
 {
 	struct atmel_mci	*host = platform_get_drvdata(pdev);
 	unsigned int		i;
@@ -2630,8 +2630,6 @@ static int atmci_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2664,7 +2662,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops = {
 
 static struct platform_driver atmci_driver = {
 	.probe		= atmci_probe,
-	.remove		= atmci_remove,
+	.remove_new	= atmci_remove,
 	.driver		= {
 		.name		= "atmel_mci",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

