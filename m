Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6D75C38D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjGUJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjGUJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:48:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BD35AD;
        Fri, 21 Jul 2023 02:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl6BYj2ZKDT13HtNKI9yGBhjEtIAiezQo3eg1rPA1STUYfy90inWB5xHGvcSs/WXuXOGaq53OoO3hzYBQMnlygCUhdijnE0K7qd2MCGhMOl29T0GqzzdBvyPIIKF8HMYeHtsxp5VhMQxEkzkvdV8Fsbvb63LlIDfoAgRw0Mr+z4bp9/XqyqVHpsN2jy16XU2LB62e359LpRPXusOw7Nh0nsiVOT+4azodiVqSvzfPUIdPsQw7j/EqWYihDNHthwgxl8nRo+nynxaFOuAJj1P5+Z7Xh5ghMOJ2sXVIS+U4yuWUcFGPxktSbHGCyn0X2i2LT3eaTulSAD56Dv3PTIyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7xJSqPC6R6oyLUW7A4Grg9gjrzZA4zR9DzCNmCHg5k=;
 b=jq8eToF4MZRlz/OyWTgVXDOwilmP70wYhKfo/zktwWJ9b9tVfFcb9JPo0VIeAF8OkJbhVgfRTvsLwC+xcec2d3ix8Mz+I+63NKMlyd+1/XsFvLPS4z2OlvOW8v1V1/dKTaPdwaK12okR96ePMrHu4sqamIAXx14KZfFPXHgDbN2qkNIzkhrsUcGzzsV3+vxGhg42uZT7IS0lbnbPJarZG4D4xV3gyLuaStUcchrKdTK1adQZ1dJQ7AAXd9Y+K6bP1alkwaoerIpR+6GCzVzyJZmIETkwiGyIbLN2stOdHVyYqqpXv3eRQAhMXYEj5Ax/8+5seLkHFaaMNPssxhwe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7xJSqPC6R6oyLUW7A4Grg9gjrzZA4zR9DzCNmCHg5k=;
 b=Vfg0VrrWIQ7lE4EPXt51RC8KzvDDG6MXA8DOv8YPcr+6tEMh94myt9tTymy2jInrzEaW/1dsbqIhDo5ip82QZjmybaJ9CoHMUWDvbsXum4fPu5lZaXc6J70caWWl5MbjY3/9Sb9quK0kchmra2kx0goOZOFb5nOTWkYdM/7SQ6xPf6wImoWLO7nF1KdxzTIJeIu0kiqQdulvSh5XT0C0bps4JH+lrZWw44srL1HwdtK+pqP0Zz/CGXyKUTmWaPc0sRsTtZ8OSEq0Gr4zi38Y0oS4ZfZfENW3EqE5OTtslAm5x6ydMF4pYb1xBOTNeRAerLXaR79XHlM1lwpzthmVuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:47:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/22] thermal/drivers/qcom/tsens-v0_1: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:38 +0800
Message-Id: <20230721094641.77189-19-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: b39fc405-4e07-4457-1c11-08db89cf8784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzMUkSUhbywZQpA3N8ZR+aY4fuifa+oAlXbD0967Ts5nBmreNKTjHsJCNKlboBzljeZyZJd4KNbSAGg7vBv4pwqBkeZoYtxhAAo2rHPx0TWQWIk5u0FUUEqXB+QbnIb+ICfcnp1YboQWKuvqWylNU/dmop/1nkHAHHhtcb76zcJkqWSar49plXTHBqhv53kpI7W0ROTC1Yb9sbFkpPR1nEhANfKR+0HI4MseKbrDJCDuZmTSQtFhG598NdHAtdToiwH61f8ANlFCPZ+zgr1muC6lhUlA1Bg4bq+4nTqRMhM0yYe65oQjVtHrCzAWeDmNtuinIHfczxjMaKpWWJMiDENpo187Rdw1s4gPk2Vu/0uMAC9MqIIIodG5KAnT/voK1UB/pe4ssSbMASN312e91xBbjRX9smShEWCD0f+YsOF3DrLSL3/oEZMimvHE0IFn7+yukiub3kgZy3Gaj82qYHJNUBHX2enJW8kBIGab0YOibhoLPH7vd4BuwEVWCmNNXw4JTJG5P5bDdniCUtqqxfuhL2YzYQy1249ktZ0FjCjSErgGgoR9A7u+Ld21kj9lSZR1MQ+CIRLdy055mXRJy1n+3fti8G64G4lABWrARxtElSiZdxsH/eq3OEJbxuwE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(52116002)(6486002)(6666004)(478600001)(110136005)(6512007)(186003)(6506007)(1076003)(26005)(2906002)(41300700001)(316002)(4326008)(7416002)(5660300002)(66476007)(8676002)(2616005)(66946007)(8936002)(66556008)(38100700002)(38350700002)(36756003)(86362001)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNGSldBT1Frc2NTM25xMXE2dS9RY3VlRzZkanQzK1JWRHcwNjF4Y2VmTzBC?=
 =?utf-8?B?MjhNeGJ0ZWV1aVRvMEcwY2gvVkJMdVFaZFJ6c1MzaDFDVzVyc0F2RTVqTWE1?=
 =?utf-8?B?amJGRURXc1o5ZTVqeDV5N1JPY0N2TWxwamttYjNYRkdQYWNSbUEzVHg0SXEy?=
 =?utf-8?B?aHpCZFdFMGxOK25pd2R1U0daZ2NaR3YraFZ4dWJ5NWN1UVhySWphVjhDWDVU?=
 =?utf-8?B?R1VoYnJGQmxnbHlmTzVpdnk0bHZSK0pKeUVUbXo5Y3lQL3ZRckpBOXVid2RE?=
 =?utf-8?B?aWtzRzVweUNscThjaHcxakpWTnNvWHlzd2lianI0dDQ0L2pVM3FSekNxNXlz?=
 =?utf-8?B?Ump4MHltc1ZwQWVmL3RFOTBpcUthZlJTQlJPSUJRQm1sVk1vMHFIVUFVRmNv?=
 =?utf-8?B?dzVINXZuaUxhYlZDdkV1c2tKY3ppc0c1VVNyVzdJS2UwdlpKQ2RrbE1UakNP?=
 =?utf-8?B?Ym11MjVZaWtEUVhtd0diaG5xMi9YZm8zVjVXRHFtdjFzbG1wRVhyLzU0WHFZ?=
 =?utf-8?B?NlZZbFEzM1NpMXlESGZ1REZqL3l0MUp1V1ZBalZGamV2V0lySEJPWk9QbFZI?=
 =?utf-8?B?V2gyR2IzeGxaSno5U0c5citxSklDbC9YWVU3Z3BQY2plckhjMDBHcERDMU1i?=
 =?utf-8?B?N2JpejJvRElKNm9Vc09Kb1h6M2ZSK2Y5eE1XbU9kQ0wrZThTYmFmR1NITk4z?=
 =?utf-8?B?T1hVZzF6c25lUzE0aHIrK0VWRVNKRW9ic051WmxJc0JjQi9qTkZjNGNzZFp5?=
 =?utf-8?B?L2s3M0JrSVkvT2pEL0NQTmJFNzNra3IyV0gwck1td3QrTDc5MGhzdWltemtH?=
 =?utf-8?B?eFpSZ2s1bVA2NkZ2UVljSk9lTzAveHB6UldLbjdHZnV2K0Z4Z1AzNG5TTWRm?=
 =?utf-8?B?K05vNVVBcmNKL0RoTGtQYmVnKzBPZk92dnVOM3lsQWl0RlZESEtTaXhRRzVz?=
 =?utf-8?B?Z0ptMXM5ZlVxYVFLZ29SczZEVS9xVUsxc2FLazZiS2hXMjdwMWhXYnVUU2lI?=
 =?utf-8?B?amkyTzhyR1ZZMEJDUDdzcE5zSjBMR2xlU2s1NkNLRmQ5V2xkcmw3V05qRDdk?=
 =?utf-8?B?bktxS0JINkg0UDBQbFJQcGtsK2lBcGRaYzJCNHByMU9LUmxpeFBEWDYvMlhP?=
 =?utf-8?B?R1Q5OFg3RWtYQUs1T3pPOUxVRjV6VmtDVDZtbTZhRUV0cDI0T0pqUkZ4UjAw?=
 =?utf-8?B?V05ROU1PclVTWnFzblJiVC8vZmhvM25OaVdDRy9za1JUNVphYkM2Tlh0Sk9N?=
 =?utf-8?B?T2tvakxEV3EzRFdqTXVQem9pc0VaSUdNcU1HY3F2OGU2Z2wyRHNFSUVIcjRX?=
 =?utf-8?B?NkoxMGlwNjFsNzhuME9Ga1JpNXd4UXEwdGdTemVDYm50NUx4M3RqQ2FXK3pS?=
 =?utf-8?B?TWlhdCt0Vy9LQS8yYTNXQ1FiVXBxdkV0UTVSNXl3WkpHRzdwcWhEOTMzUjcr?=
 =?utf-8?B?cXl1cm9vWkdCUHpXZjRheEtseGtTMGdiVmVHbk9KQ0xtRFFORVBqemljQUM3?=
 =?utf-8?B?bUFUOGRiVXNvWVVhSmJWYTljZVJEWTduVjZ6NWY3NktyL0J2TXFoOThqY2Y5?=
 =?utf-8?B?azRmTXhpVFowTzlVQkVUNFBid0w3Rk1nUWowUXBIdnVxNWlmamhxSm1jS1g5?=
 =?utf-8?B?bjZ6WmJkMlRsd1hpNHQ4L2hnS0lJTC93MEVJVTNrSm1DSHlCbjc3OTExbzl2?=
 =?utf-8?B?d0xSejJnT0E3S3Evd2d2Tkcyc3YzMC9QN3NDZndnckVsSlErZys1MU9zczFr?=
 =?utf-8?B?ZzBFUWw0K3UxTGl1eFlLQ2V5TzJUdlN5WTRLNmdicXJTLzRQd3ZBSG9LN0R6?=
 =?utf-8?B?NnRmMG5rcnkvN0sxUnNDemt5MUNoaUlxS3gwQnJnK3ROT01Ec1VWU0N0UUJI?=
 =?utf-8?B?dWUyNEp0VmFDKzZwYVZMTU4zamlMQ2xRYTkrc2wwRlVKMXNRWHVjOFhNZTNq?=
 =?utf-8?B?S09IM1VnOWJLajZob2VZdVIrOUxLeGxRV0tiOUdLbjFWb3BUWVBINElSUTN4?=
 =?utf-8?B?aURzcFUzY1kvTm01U0ZDekxmeldWMXprN2NUYVFkU2t3TmNiaENIMXRPQm9T?=
 =?utf-8?B?ZHFTOHNUamxHZkd2OXA5N01kT3V2ZndnNFNNdU1WSlpkSk9mMTZLZWNDcEk2?=
 =?utf-8?Q?B0sKQyfCsThMkUS88D6r3tJuV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39fc405-4e07-4457-1c11-08db89cf8784
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:42.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRDRWDI9cXvvvsa57ELLKLgSYKtxp3ZD32Bm1yRVSh5N4a+si+9iS+XECjHeHa9rTBmUkXIsaOsXamLXH9mkBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6311
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..d4528d36c085 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1171,21 +1171,18 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	} else {
 		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
 		if (tsens_version(priv) == VER_0)
-			ret = devm_request_threaded_irq(&pdev->dev, irq,
-							thread_fn, NULL,
-							IRQF_TRIGGER_RISING,
-							dev_name(&pdev->dev),
-							priv);
+			ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+							      thread_fn, NULL,
+							      IRQF_TRIGGER_RISING,
+							      dev_name(&pdev->dev),
+							      priv, NULL);
 		else
-			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-							thread_fn, IRQF_ONESHOT,
-							dev_name(&pdev->dev),
-							priv);
+			ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+							      thread_fn, IRQF_ONESHOT,
+							      dev_name(&pdev->dev),
+							      priv, NULL);
 
-		if (ret)
-			dev_err(&pdev->dev, "%s: failed to get irq\n",
-				__func__);
-		else
+		if (!ret)
 			enable_irq_wake(irq);
 	}
 
-- 
2.39.0

