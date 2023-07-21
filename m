Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66075C3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGUJvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGUJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:50:29 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0683A4480;
        Fri, 21 Jul 2023 02:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1X9y9FcNNu/kjf/1setfIQ3zY07e2hMPNQhzMkbjMRBjs9PWUpvLAa1O6mN0PH3m3sDtyulsterfmTjx7eIDtXhL2ONqGardJaX/i124yCWr26/tXGc7jyL5PARLU8DsK7ctHUt1AQ8tbTYfOXt4k47wDeI+FosnPSRY3R6PX31O2SJlQtKcvQ7ljWvrAMjgApwJNzT6SNpEkN4W2AcwkISC5uuBMxtpyT+TJC7A+MpF+7HOIj9chrSVXUEl/NzSj7Vldj/id8zmnIqUNndD1yuLHqFHjXU8AiWitOFDtE1UuujRxMIq4VkVxWkJmAe+pQPSOMYLKFCaw21qjvdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIbTe94tJb+c7Hut//D6DIRJqgxdHnLzwdkufWRqizI=;
 b=OxLzCYm9O98vAmE18D4z3fGsPw2CghRbp5nI9lzxB34ffyoUbkTZG2oR59/PLvwm/0s53ullYaTrMwNNRP1E3/pVsZFdOSiA3fg61yfMkRZiTs8GWXZLzHiNPQ9+QGbwHirBHZqWT2vuRSqkiXwmuFMoZBrPg5K+DYNk7pY6va6X4hY7MgW+M9is60/t2490nmEyy+Bd2kw6uBAxWN/sR6msQdAdNaqH0ilS0YKEpUQPhIAvlcMldnJBtyZxNyYR0MbIcIzp9T9N5WOtPBJv2Ytc3fLUidnjtJfjuHT6pcy/ZmA7D0VLuv3iPEo6eVs/IFuarHCrX4Pf97rAimeXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIbTe94tJb+c7Hut//D6DIRJqgxdHnLzwdkufWRqizI=;
 b=YfLqnjU7d0ZgjnPx6Goh2df6H0perLUo5GqPhjXYBeRZwTP5SwtaTd80O9ttxW9miD489ghMngkpoipGYRvdwplxONFyaS2AWT24xNfSDdwY3xTxalTeRWgrNy3a45pMKiPR3A3INGOu2+pJe0zXJU+Zj1lC+3y3l5ySFzUoJojssEqdiQ8l5NfKqZGcYEJn7Mb+DUC1F1ZRizIsEYbZUwLeMK8Y/DPSY5r6YLk/NEoRtuzC7LcwPwlMjNn96AhlFKELmGDZ//qDqu8UvCOx9RQ037G0TSXebYNWiULAaSgKufQ54aTRRcgGFVmsoOv52qYtm9f6seYmDnmy4nBT5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:47:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 22/22] thermal/drivers/imx: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:41 +0800
Message-Id: <20230721094641.77189-22-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e42cdd8-88c2-4e7d-1846-08db89cf8c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWDUlaltgJhgCnQKW/leisz7mhcwSFLJqiRPwHMzPdZ5GiWwdZEPzAQ6J48RJ6tKro9ie9UINTgmR4JQiZ6hQDboQ4IIS+nHs8SPah/eavS587oin/YnhCmDWLD6K4CE3X9NPAerVJR6qAaD98F0Zn+mit8iMCgiv6sPT41LtTLHm+UXXcXfG80AmUcZoa8j6fShetkB9A9exzDRNlszjDZwoEh7Gp6vpq1lJnaubW+UZSbB/7ph9+dpRWmcXiF/xoLSdSQA5sFY0KGrygLbSUYT8pic2VlelWXqdZsQaYH159SXJN43MmND+tMYQc5/2fSH47OjjgLY+c1k74+dIQ172A9IS4bXATzwqsUguCHtQvpWHjzKhM93cM+RE1pUVCtGoq/ovsAjC5xu+2zjYgUJ+QXOYiNUsytBweq77vSQ+LsmXy6BKF3ZF/Bo7BSzXde3DPwCg+gYfvHe3+SVwniPQ1HfY4m/K26ADmr2MxivARD7aUTjTaYtnhrESiIC/u2IItLtlLk6t6JYIJbOaDMc8y6eDUvI3wO6kcTrmBHQrBO2b/HRKL5rzuc2kYrB1de/3tryZbYPUigR6aQ6hgcJ531hIZlQFxC+Pn7Nw1Ge4kJXL6TrNtpYOnrLLtK9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(52116002)(6486002)(6666004)(478600001)(110136005)(6512007)(186003)(6506007)(1076003)(26005)(2906002)(41300700001)(316002)(4326008)(7416002)(5660300002)(66476007)(8676002)(2616005)(66946007)(8936002)(66556008)(38100700002)(38350700002)(36756003)(86362001)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9saXQxeCtYZmZnSk1od2wvODQ0bFYreFprcHZNN2pHR1JJT04zK3NmdnZO?=
 =?utf-8?B?Y0RaeEJBOUpFWW9zcjZRQXRCNFo5alBHV3BxYTlCTVJwNGswOC9IU3Zybm1y?=
 =?utf-8?B?RHN6ank3ejZzQ254dzdlYTdjMThDMmEyQ1Fhb2hyYmgzWi9OUysrbU9CUHZX?=
 =?utf-8?B?OTQxNGtrazdvWVJDTFMzTGxLT3AzdmtVaDRDL1dmYTd3eUlLNFJqWmhPNnJv?=
 =?utf-8?B?Z2RDQ0JnTWgwc2lhbWFpbkVDVU82TkFJZ25neTJIbU1GWnFxSmt2Y3BWSU92?=
 =?utf-8?B?RndnUndMcWxMWWhQWkthTGpoaVZEQjl6U1YvcVFwNTdzSmNVTEVUU3JOTU1u?=
 =?utf-8?B?MHFvWW5OT2h0WlBPR3l1OE1QbUdod2RwTWRzbExtTHZXZEFBR0ZkYUFlSW1u?=
 =?utf-8?B?WEJpMFZqczRhRndMMTRGc2R0RmZMT2x4QURoNnJvcEk2RitTcXVQYUZhNDda?=
 =?utf-8?B?eWFJc0UzOEhkcTBLUXdRWVlKYTAvcHNLZ3BhWDlXY1gxUkVKdys1NzJIRU1Q?=
 =?utf-8?B?ZUZrSzRXYmxMV044Vy9waWIwZWJJWUJpL3FhVTFBU2N2TzFZenppQVhHNi9I?=
 =?utf-8?B?Ry9IaDlTTmtiYkc1UW1GKy9mSWJabjc4WlByMXJyeHdISUxySCtOUCtjVG94?=
 =?utf-8?B?ZmY2K3QzQVNBR210UW1qdGhscnc2M1gyLzJic292VU1DazJJMHlkclZKQXBw?=
 =?utf-8?B?a1drQlk5TFJaWlY0dmp1MWJRSW1BanZwZ2MzRVp1SWxicmdyMmZ2eTIxb2F2?=
 =?utf-8?B?V2RzSlFXbmphVmo3USs1VzVqSGlrZVAxTFl6a3ROODd6UWpyZ2RvMFZxOXNI?=
 =?utf-8?B?QXBieUtUTHI5VzZsQ2luSkszc0I0bC9nU2ZaQ050VDYxSlJOSHdXNTRBVVBJ?=
 =?utf-8?B?MEt3SUdnZm9veXcwODhFemwyd3RqSVlrZW5BUzJ3RE9USG5vU2VSS3ZnRFJX?=
 =?utf-8?B?a0dwenZsMDdiNFRQVy8xcEFiMDlucjBmTERMbTY1aGRncWlmZWtzRkpPZzVW?=
 =?utf-8?B?TXNGaGpQUTE0RTh6MWtDZ0x6OFRWa1AyOFdzb0puTU1UaHhlU3k4dC8xMk9o?=
 =?utf-8?B?T1ZxczNMZVJBWVFEUWg5elUyeGlHZ2hhbk1pcXVxNzZCN1FrdENWWVNJMWd1?=
 =?utf-8?B?RWxRZkVJbEhLMlg4MXlxbzdmZWpybWgwanNnYVZHQjI0L0lxNmhLaEhkdlFT?=
 =?utf-8?B?ZTNVU2t5ZEF1anZ6d3FmWmtwUUpLd2R1RG1nZDRMYWNBTXBPMkh0ZHBmdzV6?=
 =?utf-8?B?NEM4MDFmbFNKSVhzS3E0N28yNzZTangxcFJpNU56b0k3dVVZTENpb09Fd2Jm?=
 =?utf-8?B?SmZxTUFPQjlHTU90a3hvR3V4dVhCOUM3d0VaNVQxOVhiNDhzTDFVb2JWdHVr?=
 =?utf-8?B?dkVOZXpONkw4SGNaOUorTUcyQVRwWVZQNEFydWhLWWI3cFZodlpSdWpiWlpm?=
 =?utf-8?B?elF0L2N1TVAyUlZDTnRPVDdGNjlqeUFWQlJVUnZZbG5paFp1MlMvWnN4MFJC?=
 =?utf-8?B?em94aEFWYnZVdGtrak11UjgzVWo5VFVmL2paYXhHQVY3K0dacmNvOTdCTHpN?=
 =?utf-8?B?dldqb0UxWmtmQ2VIdmFDb0tnaGluOVp2dldhS2h6T1pXZHZ5THdnQ2pQNzBW?=
 =?utf-8?B?dFllRVA4RUtGeW8zcWxaUXFPeS9EanpZSEtNMVJQMzhaM2p2UzVVbmYvcVda?=
 =?utf-8?B?WnBDR0YzQXlUUmd6ZU5RNmltSGxOQ1Nzcm5DNURzdVRORHBiSUtudWwrUTVP?=
 =?utf-8?B?dll5UVh4ZmdBQ3dWczlCS1VlOFNqZGNRWGJKd2FLK2tzeHhkai85bkhtTnYr?=
 =?utf-8?B?M2o2SGJsVmtOQmFvdzMzKzZCdjQ5RXZsMmJ1NG04U1BxQlRWY3RoaEN4UmJJ?=
 =?utf-8?B?TkxBakVkTm1DUWNMQk9CbVo0Yi9uaVJIWW9laFQrWG1kaFUrOFBlRnlFemNG?=
 =?utf-8?B?Yi9DOEY1YVFtdnEvL3N0SUdnektRK3R2amR3VHVmdFFWbDRmMVZzRmU5N3g1?=
 =?utf-8?B?RnY3NjcvTjlWUlFTRDhIbEZucE5uSVVpTDY3b21xd0xnRGZpN1R1TW42Zjdo?=
 =?utf-8?B?RHZsRFdBdGNvMXQwdFVKUmdpMlAvWithNUZIZVNxbDdqYWd4SzNsZmQrSTRa?=
 =?utf-8?Q?GtAkwAKsSUyVBDiWsnScTSB40?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e42cdd8-88c2-4e7d-1846-08db89cf8c90
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:51.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+mqNAlShJxMX1ySgcwgYiTsVmWdSj4jbn3SSliafoG+HmcsCinI20aXBLVnIoTQT4k7d9ZtwwJ0cNlbj08KWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6311
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
 drivers/thermal/imx_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a94ec0a0c9dd..3131a09f9906 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -746,13 +746,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto thermal_zone_unregister;
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
-			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
-			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, data->irq,
+					      imx_thermal_alarm_irq,
+					      imx_thermal_alarm_irq_thread,
+					      0, "imx_thermal", data, "alarm");
+	if (ret < 0)
 		goto thermal_zone_unregister;
-	}
 
 	pm_runtime_put(data->dev);
 
-- 
2.39.0

