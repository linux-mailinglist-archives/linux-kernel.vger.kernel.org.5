Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C0375C3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjGUJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjGUJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:50:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1A4222;
        Fri, 21 Jul 2023 02:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqaINiKihsksGuzffqa/5orRhMAzGaDuCXo47dXRyUF7JnuXx0kWbbyILUWhOlkt5RknTiBgLapi/5QzTPIpKd/ob8L4yg8SNlbZYEk96dGKuezweUOEo6Tr6h+Zx4SbIzSWMI3SduqgkRvlkXzHwfSrQ5WQJb8WyvkA6i+IOaCMnDr82gzgzswwYWdD3/WAyClH4HQFVG6GH6FTpZubyUKwt1CtF2aRP/xSOkl6SemP1Hs/TIh1US9+biC8Vi9LztCOSo+6oMTU8QEXsTxDjWPdGgsRM3E7hiuoDMtHo6vsDIlYruSWpF4hcwtvdbDl50eGCNLdoNss0LGYrVfgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKc+TavFd7Ci1xyoSggA9UVGFRc6ndR0B+ijlcDKBLQ=;
 b=YklT5ULoEoc3vlSR05cN7cSYJcSuYqbBYf6V+XSdKogjK6qiufiEQGBDGjYMCrU0oSud4gfux3xLIND6UwtqPBv5sPEnz04Y1JErG6NyW+gwZoWAPwLgz1yx6pXDt2ffeg8Zgnk55QXW0HtVyENMUMaLuMY2yYPIpSEbzroPitpSoLvVOFDrG7boOO7vhbjbFUmTJqjHDak4re/oyW0I235Xaa1fzB/h+5ZWl5LH2Lxnpmpw4f5s3A1QFFjlN4GusgRx/IXTKXe9R7OboHKzIfuwrFGrx+WktXm9w2iv1Srbcdc7HL+46ut94IOfuMpnukJkz3jzIJfO0tPmfk16Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKc+TavFd7Ci1xyoSggA9UVGFRc6ndR0B+ijlcDKBLQ=;
 b=S4UIcSfipj0LXdlHupYKxylrjpB/8UItARa6GgK9KzKrW+72yqxQ8pmDqAzDszam70srLQt8WrGujiaKpJv1Lu6XcfEscXbIRorvNtxop5s3oeKEkUEOrlQ8r9TQ8zdiu8JTyv65yd6UdFHUB4F8r2lgwLstfRUhSa4iBVAd/vJduzL0su0S8J34NYc/8S7qo2FlIbQwHS6iVRc0IUGH3VZucXuWcEcLYT3gfg9Gp9+sNJPZihiTW1+hWG00JYw6k8qOEqnPDkAYjVh+mIh0CNWEUSyncrXPDKQav9F2Oih1edv9GVrI5AT6HoGNMaS+5NpkyLX2C2ZwALjXCjYyww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:37 +0000
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
Subject: [PATCH v5 17/22] thermal/drivers/intel/bxt_pmic: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:36 +0800
Message-Id: <20230721094641.77189-17-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ffaa159d-3b1a-48ea-d30f-08db89cf8403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PGmhYBPSC8kHw55zlzS4NYAsJLkhO6VmXZTcB+vfVDtSNGJcPY7C3YiIeEytVjsk6Gu6sxINH8XBldrCGlfj+Xjeb7tiaZQMH75KonUFkxqSOt8b9ojBo/TUKWdXLkelSCiZTIVfTyhFvs7mQ7LcKSo5wuqeDPPZq7Mw3LWKuC1y3NCdbodTRh5eZH+coB/j0CnDsgCfUELPJmnYMWGi2F2gKW1rJvCIBAclMJg0ArgUEt6b5GIjlDsbIO4yh3xD8FKHh31HJI3VIRpaPUK8EGlh2aoH2cbU3XnXyg2EVgG2fdlbX8SkRWIR6mDjhLLDRUkxboveMXlTkMrGj6q5cOK9+qb4G+NrbKCmHsXdx9NlRrdmzmNDOaybXwtKAV0iQtNdPjEKP8I5GV9jCbm+7tTSVARnyusHVhcCLyAVplebPlK8mfsbQcjJsvk18t6y53BUlESwLBmct3suJuPIU7vLzSKx2eDjAdj4XI+l9lgMxwa/twOeDa7puG/pUm+wlL9olU8nD4J048Hn2+ta8jZQ4Me+N5EyHIJP9ZuCf8c7FqgFPdX9VRfQb0KkpT9fKM5+p/oB4lElvVMGkT97QksBCLQZZYlGgbbrbHixJV2yvKe+TrVuIfYAm8/OCDT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRJMnhCNUhqbk1NYUtGR2xIUGtxdFBZTk9oNE5vcTYrUDdNeThySWxSZ1hz?=
 =?utf-8?B?YUc3bDhoWUNRemR6TmR3V1hqRTlIbHBXOUtXbzNMUWRTeEtLWGpnZGQzQ0ZD?=
 =?utf-8?B?MkdIVCtKZmZDYzFtcTluTFZnNWRGNjBBMVdxTFFDMXNoSGZWcFFmYVVHM1R4?=
 =?utf-8?B?cWZ5QmFMYnUwdXZkQm1GSWdqWDFJaHFwazRHUldUM3hBMCt0aEZRd0dGOWo4?=
 =?utf-8?B?dmNYK2R6MDllWTF3MWdqUmVRK1JmS1VsVE9MVWI0QmNjaTFuMm9tbUNBSkJv?=
 =?utf-8?B?SUFUZHpRMjJ0SkM0bm9nc211KzJLTEltdVdKOEZ2Sm5iNFZza3JDYmFUaEow?=
 =?utf-8?B?SDlQLzBzbVp0ZWI2TkhLQW1QU09jakJEZXdQVkI0QVB5bFR4SnNqT3ZFZHc4?=
 =?utf-8?B?L05MYUxacmR3VVVMU3V3WUYxOVdPVStHSGVZdW9QaGJPVXVobmtrRnQvSG9s?=
 =?utf-8?B?Y2o3c2ZrdU82aFNKcThvYVpDQm0wOGhvRVM4UVUxMnJvajJaYUtldVFuYkNm?=
 =?utf-8?B?ZXRobyswaGNWS1dHSUNGcFlJa1lSVk9GNXEwT2dsT0RsbkJ0NUc0WVk0SXhZ?=
 =?utf-8?B?elAxMHRPTW8rcERFKzVmN2F2KzZyZWVnQlY3TFpEb2dydWxPQzRQbkQrU0R1?=
 =?utf-8?B?OURTVnBCWEl3d3RIeHBHSGhSVEFhYWVNSUZKVE5lKzBldUplV0szVlZXeSts?=
 =?utf-8?B?bmlweXJqTTVzYmUyUFlQczBQVndoUWhOM0FNeUhoaFVUODRZTTBkR3hjUitJ?=
 =?utf-8?B?WGRxRVNtSFV5S1QrTitGZkJpN0dnUkpiaUIrUDJ3UWRvS0hZdHdGMFY1dzNI?=
 =?utf-8?B?MkJxUGVMMERHOEVSLytCa3dGVk9pL2JSUUhQSjVwbTRDTXRZSHZIS0xKTEFm?=
 =?utf-8?B?M0t6cUczZTBDbEJXVkRhbTFvbEwycmdCS1N0SytKQ1JhUnNkMDVPZnd3b200?=
 =?utf-8?B?U3NVSkFjSEtBNDJRZEludXBXVGIyREp1dUIzYUVKM1p1NWxyTXB6KzNHbXo4?=
 =?utf-8?B?ZWNHYU9ubm9NUVdXbzFTZ1JLaG9tOEJhblhkUHZETUhJdHNMVW53ZDVNZm9s?=
 =?utf-8?B?Y2JNYzdhMktCMVVqSHJLUVZpbTlBOUhBZU1aa1g1ZFlIYXNtVGNnemRuSjRl?=
 =?utf-8?B?Umh4NGRNQ2VOVHdWTEp2b01veGg5V2JFWE5waUZxdHR5TExld3JkYVpNcnhq?=
 =?utf-8?B?alQ2RVVxRFVjMjZMY2RHa1UrcWFUSHJlQXRtdGVjMHd2S243MC9BaVdpbG94?=
 =?utf-8?B?ZmMzZUJLOVl2N3JaOFdSRkZqTTVhSVpUSFhhclc3bjhweGRnd1VueWFQbGo4?=
 =?utf-8?B?OTN2TWd0dk43cnB6SlVDV25RUDdlUzFjOWZ1OFFwd1U3RjdLMXI1M2dqaXcx?=
 =?utf-8?B?anhyT3Q1Z2dVSDlXYmkxYmc4OGJjYnVrUm9XSUF6NTEva0VrVTVJSGlGc3ZV?=
 =?utf-8?B?ejZvdFFsWlhWLzBjNXhuakFCTnhwR2Q4Y2Zld01RMlhGQmc0eVVWWTZMcTda?=
 =?utf-8?B?MnVsWkk0eGxaSnVCRG8zU1hjU2hNTEp5alRSWENRdVlsWEEzZW44ZnBSYlVl?=
 =?utf-8?B?RGM2TWJTVkM4RkgwY1kwR0YyNmpZNitxeXhwcE5tYloxWWtwQm85VkdNRFI0?=
 =?utf-8?B?aHMwbVlaSnNBU2RXTkgzUmJ4TExabWExOG9mRzZ4N2dKQzhnS3U2V3JVaVpS?=
 =?utf-8?B?VmVlZ2lqeVZ3ZzdVZHd5clh0QmxUSEc5aWFzNVVkYThQUk9FQkNldjROeVJ0?=
 =?utf-8?B?dDhjUUgxRHNxeEJ5Rm9wR0xZWGEyUm9WZ1MvWUZ1NkpjYXlYK21Udy8rYTZa?=
 =?utf-8?B?cHZmWmdPS2Q3QXg0eG0zZ0hBVHNMQWM0YUxLL0R5QisyL1FmR2EyYUFheTRs?=
 =?utf-8?B?R09aYzBBSXAyQVdUaXFjMEsvUVZoR3YvZ2pmaWJWTE91SVc4VlZ2a0lYUWpU?=
 =?utf-8?B?Q3hiMnlHNVBMT3NIOTMxNi93eGc3UXRGeHNrMUR4V0xhaEhWSHMyT2hIMFFC?=
 =?utf-8?B?dXIxN3lsSWRZZ3NVZ0lzRVFVZ0RuTXR4d3pTbFlZeCtJbzd5a3NGaTNNMUNW?=
 =?utf-8?B?d0V2QkFHYVBNNTlwS3BpaWJrbU9xOXUzVC9ERW16emhuaXpneVk1QXRkYVJo?=
 =?utf-8?Q?NHjPq2JSWgvg+MaLDNLoZ+M84?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa159d-3b1a-48ea-d30f-08db89cf8403
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:37.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHAJRwKDLNhJZYqTT9f1rEEeDQ2U3uoNf1gmtYLHNdqZKI/8Y7DmyvXjizsWw/EQn7ohcc4n/XWYTC7HeTWDqg==
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
 drivers/thermal/intel/intel_bxt_pmic_thermal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
index 6312c6ba081f..1bf3e6bf8052 100644
--- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
@@ -241,14 +241,11 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 			return virq;
 		}
 
-		ret = devm_request_threaded_irq(&pdev->dev, virq,
-				NULL, pmic_thermal_irq_handler,
-				IRQF_ONESHOT, "pmic_thermal", pdev);
-
-		if (ret) {
-			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, virq, NULL,
+						      pmic_thermal_irq_handler, IRQF_ONESHOT,
+						      "pmic_thermal", pdev, NULL);
+		if (ret)
 			return ret;
-		}
 		pmic_irq_count++;
 	}
 
-- 
2.39.0

