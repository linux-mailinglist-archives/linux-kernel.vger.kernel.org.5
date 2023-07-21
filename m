Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3275475C3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjGUJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjGUJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:50:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC844220;
        Fri, 21 Jul 2023 02:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J43RpKt4DRzZ7yOxVN9y3MgwYBWFbX2tH8eAl/7XdwNMzjTpgCC4EICZVVDnNU2qk4mZKf8Jw60FR+dubR6MUPlkklnSpsyDlCxBdbaq9hkSmlsWCxGjC4CcWbW1ClEjDMw6i8y13xuyzRb5VTWG8FmTBb3bOPIodkdvYPOpQn3FRdufbj8qefUauAbkGFyNVys6lOqWow9Lv5IOgHlSSKYA5OEDSfMZOKkW7CSygMXkdrVwUsxhjzZuvnXMtJ/7yrft0rPvKY0Ws481XQTIZlpGIXriIjlzOhjsG403wCcvv7pQhPZn+5ZWAtsFtkbRT3ZA1spIJoncfnuWGKkplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4bfb4yk8VVql8CBIboaJds/47jikygD97Ynoj6D92M=;
 b=bZo1qAAcMO6KhjoLfNW/o9Oj1skYQ/Akx/kw5pFjTxFWnsI5YKh8vEMMWCiRMfp/US7727c+U+WViK2TKwDzf5iweYZcwNqbao2Krls+M1hRCd5fdingjLjgrNNWdrkEOJeb8Q/cNnROJDpLbyuocxbLRefrHbHEXtsjKQUQDye19cqTHv8UntPH/xP1BgAm4lykfGOfxzdLcO2WcIEeRLOPUnoX4rAhJbazwio0ukrchiG87DBzFKWBg1bfVbxKJyQ3e57OF0EI0dBWnmLlY6MdYtRpQFgKeT0R+BjSYb7M93FWCPERxVMpB6QuRWt4TmudRT7bhna7VJCMpU/r/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4bfb4yk8VVql8CBIboaJds/47jikygD97Ynoj6D92M=;
 b=dnnKKBLOvkjihUG90bDE71v/OBJS0X566qXj11vWSsMEnnUfPo36m7VEixLFmq12OsblsyGelu9dnjVp99ujhSM+W3SVY+P2wlZ+gZNk6VX6Rc5+FgOQKp2KuRvkcGQ2pNba6AaxR3N3x6YcmHNOGeIjR8J8iKWcznoiABqco5y7Dlu2yMAr1kWhe/Vj1T43p2iSy3I9IFTQGdN+X0hw98kpCxw4H50xJxxmik0tkn2Xmr+c4NrllWji3sRHaVLFLK0xmiU0W38oexps7uXwXZxH5eg57Xc1TksW+OQ1wNu4aUTiPZduxjCe92BrF3TqvuQPXNHGvse6s11iRbzxGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/22] thermal: max77620: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:35 +0800
Message-Id: <20230721094641.77189-16-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230721094641.77189-1-frank.li@vivo.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eaae52-7f4b-4efc-0536-08db89cf82c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrjw952keaR9LHfNm1FjYtJ2bgUpy/RDKZ5P75vKFScAmbDLZN7IpooC+JoSdBORrvV2jci8jsZHj/uCno7dZ0F4NeYb2DiP03hOtkvPgkdbBCTjT5l8gTxxTbOiwiV41Ve6XCErYqjDFabQo/MwUEl1ISPWpLkv0dyE1/uU1enmg9k/MglS0q+wpRyGpnRBBwfP6enDlAz/kYCiPlHyDwfRkF+c0Yqw3VnklvYUJqKOyZynwU6sh3oZ8xr6lqClaiHkUM1XxgBY9oAA8SO8Y54CmbX7t8p7sBmteWAh6UGDHqs2hVNCLl3zZfA/enNpEJ+2EGJeHFtCQR5lOUln4CjTQ9he4bC5V+n4matfRVxswm7UKXuyJzX2YE3qDoBeiqWWv8GFuEfu7hWZXzcM6A0vC7/TzBSvZSA0VAee+DB9g5H+nYZJDOemHX3VOPAZy+bHS+FJswgae1VxCqdKwQ6BJhez1Tkoj9DqSOSicqEX39jG2MBFGuZ6Sc2rQLPQjM28JcBhmdWjZVOy3q530OYWldsUB2BsWBYPUWs4vCZc35UAHVB/HDCdy4pqpeHU/eOYACsKMwQHUo4G6W2lXiCmTruk5BxwzD/iAd+NpaXfOjjzP00v9bN7yRu3D2L+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNIS2wyYW11TVFDMHphSGRIa01TMFdHQ1ovRWRxYXFDNXdBdlBDbzlaZ2xL?=
 =?utf-8?B?TVhOMHlsK1RDbkMwK3d4bWUyVkU3TWVwK2hHK0UzSkIrRi9rbE1malJ2Qk1h?=
 =?utf-8?B?Q3Qxak1FOTZCR2dlYnpINmc4WkR4VjM1eVViR25kdmhLZ0VvcCs4RkZiRm5w?=
 =?utf-8?B?S3pwMHMzRzFQTk1oNzM5clhpUlZpOVQ5MXBQekVCeDlaOU1vMFlnTEJtelUw?=
 =?utf-8?B?cTQva1EybDlQQVN5bUdDSklQZ1RXQ3RxZnZUQ29oRGd3QVBzTWRTRzQ4Lzli?=
 =?utf-8?B?RmFpV0s5N3c4bWpjayttR21qZGxGTVc0TnJYREM5NUZ6OFZsZUorRnJ5aXp5?=
 =?utf-8?B?c0JuMUdPUGJlbW5xUk9obnQ4cVhpc2kxbG52VVpveGQ1VXNvYjVTa2tmdW1Z?=
 =?utf-8?B?ZnROT1NVVnQyTGR6eWRKcS8zSWt5SW9wVThSRHhIdU5IN2Y3QTJoN0gxWk9k?=
 =?utf-8?B?cVppVERJMkFHRHdqaW5ZbVYvdXRxVzhJaUJqYnJoVGUxNFN1aDIya0pia0hh?=
 =?utf-8?B?dUp1alJ5Y3lJQU92MmtMUnNwSkNSSllmWEJ3dXc1UkZrMnVCcU1KTHZSUWIy?=
 =?utf-8?B?NGE4VDJMZmJNTGI0RjBsd0NCblRNR0hTRGtPclFZcmFwdUFuMXhOcDdKUGFl?=
 =?utf-8?B?MWNWN1pHR2NEZHFqb3pFVjBVeitwbFlyeGNiTkpJa0IrRDE4bVMxZm13MHlq?=
 =?utf-8?B?amFkckRPRWYvVnFBR2QyS0l2SmdIcHA3TU1UeEFhMXM0eUpWNVF5aUhXMzNL?=
 =?utf-8?B?YkZ0MEg1V0VBY3owL243Mnc1cUs2R01hVit1SXlOM2cvbDkvdFNTWVRwRmp5?=
 =?utf-8?B?Tm9WM3FQVFAwbXBTWjFtaFJab2Z1N3pBRzZESTFQMmtsZkhGUHo1UVhZUjdH?=
 =?utf-8?B?T0xmajdkWU1IdFJwQjBRZHlrNndjcTNGTFRJdWhzNWRWdWcxSGl3Tk9BaTRT?=
 =?utf-8?B?NWF1YUF6bzVkTlVsdzRTYlFQNzlGWmFPRk05RTRrUmtLVUlsdjdrR3NvQ3hs?=
 =?utf-8?B?OUoxaWdWVHVRL2F5b3hObmRtM21TQTRYVFJJdWY3TUVPbVRRTHY3cnFzU3Nh?=
 =?utf-8?B?Z1I4dGMzTkFlKzQzdEVaaVdETXcrZWk4eWp4NzQ2aHNveVZDTjkrTVVGa0xo?=
 =?utf-8?B?SzlWU0FUV2crbjEvdmJ5d2xWRGRjTGpGcVlZeFJhUDJsTlQ4RUNlbHNFNm80?=
 =?utf-8?B?OGc0NFdPdytsNXJQTS9DdWY5M0FmOTR6NE95RjZSUm9YZkVBczFOaWhsQjNh?=
 =?utf-8?B?R1lXbUNqbWhWUnFpNVZBYjlSQU1jN203Q0VMRTdiTmNhdEdNM3BUSzluUjVL?=
 =?utf-8?B?R0t4ckZaZWZhR0dmeXdoRGRhdk95WmM0S0J1dEhUV1RVQjhYT05HbWhZSVRs?=
 =?utf-8?B?REdzVkJTSjZITG1zcVJCMnJ6WElzT3paSE9TUkRnZmZGTHl2MURNZ1VpcTZl?=
 =?utf-8?B?bTUxWmlGUkE3a3dWVm5zM290M2RLY0tvY3Fqa1ZvY2I5MzAzMWIvYmYxR005?=
 =?utf-8?B?dUVtWXJoeGswTExKWnVOVVExakdlQkJKVEdCamp1dHJVR3hHcGl1bjBsaGJo?=
 =?utf-8?B?M0FxTno4QTNxUEhVMHJ0SldvU005SmdJZEtZaVF0MllRcVl5NlJHeEIrdm43?=
 =?utf-8?B?M2ZHZ1Zvb0xUN1YrMHlFc0ZjNG90cWR4VTVrcjlnZGxQcjBzS0d0bm9HUHRC?=
 =?utf-8?B?VmZwSnFwYk1uSFhtMm0wNnpkOVpKRW9taVpmNU5nTmxobkdta2phelRUWVVl?=
 =?utf-8?B?MWJJZW5WVDNaTHd1SEdCNTR6YWFJUWJOZVJ5MUtqenVEVEJiTWlNd2IxZEV6?=
 =?utf-8?B?amU4YVNzQ3NKT3pXKzhNTU1weHJPb2EvN1M1VkwvaE9sZi9kMTI3T1Y2SHFX?=
 =?utf-8?B?MXMwa1FjYjJBMnJRdDNGWnZrcExoWDZpRGVrYm80WE1vd2pqV2h3eWEvdmRT?=
 =?utf-8?B?bmRRbHVudzIxc2ttRmt0NDYxbzlnRFd3bzhNbnFVY2xnMXVKbEtrbmJBOU9l?=
 =?utf-8?B?d05La2x2Skw3SHBHTjNWaU1XRWptdkRtcUlYMytMRXAzY010bXZiMnN3V0tW?=
 =?utf-8?B?ZzlJazZuaHJBUFpNajMwYzZ0K3AyRDRsYjJXdDNPQ1d2RTlpZDIrZWFTOWhN?=
 =?utf-8?Q?RUqoPwrRr/vZZy2qyBeyK5jrL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eaae52-7f4b-4efc-0536-08db89cf82c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:34.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPReEiJND1ptIyymzFa/lkGX4NU7ll0E1KKVpG+b//GAxdCgThRqrlCglyx7/om2NvTTJuhBUhrOnPCKVTzwzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/max77620_thermal.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 61c7622d9945..92289498fa17 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -121,23 +121,19 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
-					max77620_thermal_irq,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq1: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, mtherm->irq_tjalarm1, NULL,
+					      max77620_thermal_irq,
+					      IRQF_ONESHOT | IRQF_SHARED,
+					      dev_name(&pdev->dev), mtherm, "irq1");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
-					max77620_thermal_irq,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq2: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, mtherm->irq_tjalarm2, NULL,
+					      max77620_thermal_irq,
+					      IRQF_ONESHOT | IRQF_SHARED,
+					      dev_name(&pdev->dev), mtherm, "irq2");
+	if (ret < 0)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, mtherm);
 
-- 
2.39.0

