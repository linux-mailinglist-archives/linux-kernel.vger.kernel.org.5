Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3586E75C383
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGUJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjGUJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D930D7;
        Fri, 21 Jul 2023 02:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICrn6L49WCKH73MWdY9X3Eh7bGowQFLSJKr6iu5vDdcvTsC4aGJGRnqJg4CXywLs/bnbIzNFcZfqbGYGT/CYO2kcByD2fhuQyG0jD53QZE23uew2CXB8SqDsRaR9jxb4EGvfubMH8OZqOBvcBQBhzEaQEE83lnf6EvmpH0NJHYelJKm++uw+EvMUhLKG09EGv4o3zB4REMtnx7WUofoCeSUk+3dRWW/HphX1iK+6kg3dRSXh9/BrkLg4bmqlcH8dYJoR9bEIqiVlvAZqNFrn9bKY3oGgJ17AhFSHJ7/HKts5PrGA2FYxHvX1tUGpBsg88tWIdkUhAPjIt7akz0srAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+gwW3HWoFbyKNr4P4zmQsQ0AWdekKwoDQhwbjDld4s=;
 b=J2X/hCcddxm6sMaBw++W167h2z/j3UKMr0CnULfgtGFLwbNWZAoiaRmYs+V4QhKFa+w0HeCzFBQyRAjU03VL1nsJ9qs3rw+z3Je4xZFgT6lIJcNk2Cgjo4J77JD38Z/bJtd8IlkDcH8Zo5JCy0aiSNSjzPvjoattLCGCpUGTxm7SQlWX/AJnuUasvDRtVQFyXDbJcdGz+PS2Gpy5cNiiozR5HFw/fSBxeHj10n33E0qJWBb3uvc8zNH2iBQXRQW9zavrMcNEo/thYy3qWKV5vz+TyBFaY0uK2s4Uip7UP0CLo46R+v4fqJxZx2IruMU17ml/TZ2KwlkT8WdW65MiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+gwW3HWoFbyKNr4P4zmQsQ0AWdekKwoDQhwbjDld4s=;
 b=cF2JDo5dPh1vPk+ZMHECqPCMHysej4t8qvwFlUK7Pc1+9z1CIbWZeapFwF/Du5Nq96jYnPSp/8DoSzmgVcyi8U+GPDL3KgIKMe+2HMAd8JQZjt+7w4ZU/BzGJqL8nJo4N305nV5R6YjdO1BOtnPn4HDwLG6Eh4noF9XbgR0SomNKWjtdhms/4DczdQi7aVEaeqpiEl8LK87Nrd2w0PbgXEMlJRfBwD5YlLcOx/9jD7QDAM+kHPg6+vpShUg3dUT5JgOa2gixaVYpX4l71KA0mQhSc0npFg41RJW3bWMJV76P5jbxexxIozqpZOsmoDQ8J4QBW5tsMvC4B4sa3EiU0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:12 +0000
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
Subject: [PATCH v5 07/22] thermal/drivers/db8500: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:26 +0800
Message-Id: <20230721094641.77189-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0dff76a-c25d-482a-d2c1-08db89cf755b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Nf+mI4/Mbgb4QIPpg+NgXypRZOsvG9mTHKTYKoRjvR9DdmfEaP9Tqeni/OMV/tD1GQRL2C9u8iArqBTnqzJk/o5qVcXpJBXIpbO9wcNneFs8W8la/JntM6wPCTZedM6NCBQjHpurQgHEcPH2CKZN4P4RNdgHXuqpQIonqLvkr8XTW7S34VNtlPxrxDxQsQ6NgXFj5U1UI/HGnYKJE9VK9i9NnGLusO8RUXy4L4HkMUxXzTqp2q5fnP1DxCzw4NB8uc15MwJzu5vYfdMd6X+hxhBpAs6e4LXEJ2GCBkHJoMkHhOWtMqXR+BM9+is3xrooCMNd+hEqmye643dunzVY/1txENvQtADY4UHDOA1CNLZZGdcJxiHKTE9uuhUDRXURRRtZrjJkOMznjO9CtJ1MfXhicz/ZLySV5b6jv7y38nq3jaORKNm4gw8dJsQB7HRGb/x6ICwLWFhM09Q8fNmk2ECL9OnWNyqX0jNvpU9r63VAcsOFM+co5j5WLtLioIyJkevdGKSXVisLWN1YUffggobRtFOFdlKAetCTGZAmDGA8lhzDh1lYCtRk6RR+44pIC4BsiKbd9KPcaVzMGYMkAY00YItLE0wZXihigMS3wZPP1oF9jTd7odq6VKOQEWT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skp0TlJkUG5qZUhoR0VGYTd1UjZ0TVU3TVdacmxzc000V1ltMEVBdHYzQWFw?=
 =?utf-8?B?d2JOVWlBZkU1R2VPTFFOTkdWQmtuWkdzSXNCSndJWlhZbDN4N21zcnRCanV2?=
 =?utf-8?B?TTU3dExFdGI1YTBxWW9KWk5GanU4cGU3dGpJWlZ5dm5qWUVyVFJWQk9nVDN5?=
 =?utf-8?B?cXZiTUFOTHZOVXRTb1A3WHc3Sm1ENDJIRDFiRVVhcVlkd1ovWlRxRzY2QmJm?=
 =?utf-8?B?VERUcTZ5WXl0K0hBajVLWXBud1VxQ2dzc0ZTbXhWOFQ4bGV4bXZvMUlrNVU3?=
 =?utf-8?B?cXJPejl1d2dpWmd2ODIzdHZmMmJtVlR2RXc5RDRSMS8rTkppU1FvR0RmUnA4?=
 =?utf-8?B?aXJWTG5vMHRIM0N6TzZzdFJQdTJlYkZYMzM1RXlocGxqU0ovTWUxSHVJRkFp?=
 =?utf-8?B?dUhwUCtOcFphQWVqTHMwOHJTRW84WEE0V3h3QU5mdjBBWUIrajMrS2dpRDFZ?=
 =?utf-8?B?eFNKb3cyZUgrcmJmN1RnNytnSVRIUWM3dlk1dUZvOUduSjZaK3NIR3R1dkZQ?=
 =?utf-8?B?SFVzNDZiU1UrMCtvdmdYWFU5eDhuWHlISmd1Uk5DVS9JL0E5Qk1jejV0b1Ji?=
 =?utf-8?B?bFZaU1c0OWVqVnZUT1FnUlRXc0Vsc1BqL1o2dHdGN0QzODB1S2F2NWZhSzNH?=
 =?utf-8?B?ZUYxTEpkZi8xMzZKT0hUM1JUR012SFFTOFBUWnIxNzdHeGlmVHg0S0RvZ2kr?=
 =?utf-8?B?ZndpRWJvU2ZlWjg1alNjTkdZYTRWdlR4YWdnb0w5b0RKelMxcVZobUpHaUFw?=
 =?utf-8?B?bmR4SlZoRUZoU2U3RDRXL2RwZXhCbVc5NUgzM1NIaTFZOS9DZWtnNmtpdWt6?=
 =?utf-8?B?WFNjM2RKQWozd3dlVTFSRmRmZ1VwSTNuSVRBUU0zT0ViMWZaRXlBODJlbmVY?=
 =?utf-8?B?OUg4c1lHZUVhdlliNFJYZnRtYlpHVEdCUGFGdWhRdCtGN3BwcnM3T05wRTNQ?=
 =?utf-8?B?UHR2MEhJajN3T1ZyMzBxWi93dzVQaVJvWWlxc0VLMXpCQzd0dGh5SjVQYnZx?=
 =?utf-8?B?UmRRK1V3Z3NsSk5tbFpTZUIrNkF4Ri9MZEFNa3ZUTjJKQ3d1eFF4V2hBYUpP?=
 =?utf-8?B?WlJrc3o3aWViWWdYc0h4cEdKdU1KZU90bzh3NStIQ0R4b0lqdEZBemp5QjRC?=
 =?utf-8?B?YjdoMk5MY1ZzN244SDdOYlJhTGdTV3BhTW4rVWRoR3VyanpFazAxK3Q3Tmps?=
 =?utf-8?B?VXoyK3RRdDhoQkZkaEpwRHVVd3IvZDZyS25CUHBCWEJOcFJuUVFuSGllT2w0?=
 =?utf-8?B?TzZ3ZW9uRktPb1p5Q3o4Vkpnc0VXd3FMWlFnTTdxc2lyUFRjZi80bno3VVpC?=
 =?utf-8?B?c0NLNDJ6MXcycit0NXgreVJzVERoSytadFl1TmNBOXdHYkp6WUJjUUpRRHR3?=
 =?utf-8?B?ZU5USTNKTUxObmNoVVE2QjMweEtCYjlqN3h6Tkp4MEhFRU9Ua2N4UU44Q2Za?=
 =?utf-8?B?TWVFRHpoUXp5ZWZ4NjdhYmZsczRCVmJWdGZDcTQyS3BQdHRpeXpsbFZzTUJh?=
 =?utf-8?B?UnVWcWsxSlVVTk5ldisvbGRoQ2RHbmNWeXBxNXZ0SmR1b2gwdGllWUppc29E?=
 =?utf-8?B?UkdnektWQjhBaHQvZVV0ZFhwYVF1YWs0QVFCY05qanhhRGJ1UlFRL2hORmFv?=
 =?utf-8?B?dzRGdXFLbjBKQ0RqN1JGeVF5eTR4VzJwRnhVWFhhVVkxT3NuOUtwNENibjB0?=
 =?utf-8?B?cStCeDdOWDBqSXlwcDFUM2wyRlMyT3hYQitkYklWYVFNcytHYTRLY0JUVmtm?=
 =?utf-8?B?N1pveGprRVdjM0RkeHM4c1E0TkwzTk04NE95aHZMdWlnd3p0Y1R0UHovZGFs?=
 =?utf-8?B?TkJOYjJJWU16aU92a2RpWjJOVXFuYUZXajNzbWxsdGc4VnI5U0hFSUYzbjFQ?=
 =?utf-8?B?R3ZTK2N0TkdXbW4wSFd0azRYZW5CVzZzQm02VFg0YnRDbGI5VEZucUxOby9z?=
 =?utf-8?B?WGJLcEcyOC8yK05TTlp4c3N1cGtrSU5kN05nR2U5WGR4aUJBVlA0ZzEvbXJX?=
 =?utf-8?B?VFFJMjZTOVlMY3o1Q1dhRmNhbFJuMHNITk5DRXYxeVVsajZva0NDYzJzRXRM?=
 =?utf-8?B?bWlIL1FXUmxmWStqNnNvYTJLM0hjSElDMFFtT2JQRFRJVmZaTWkxQXl2ZU1P?=
 =?utf-8?Q?0/1vtXw8Wjucg77UhzEncDIUy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dff76a-c25d-482a-d2c1-08db89cf755b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:12.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImTdWJDZnd6c63N6ido1LZwl/uxovGBRTpXyATl+75blg+1emqIuXEp9ritOH+qTmWmts/25B4FOyfuFnECZmQ==
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
 drivers/thermal/db8500_thermal.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index fca5c2c93bf9..0ef8fc2eb4a1 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -164,25 +164,21 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	if (low_irq < 0)
 		return low_irq;
 
-	ret = devm_request_threaded_irq(dev, low_irq, NULL,
+	ret = devm_request_threaded_irq_probe(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_low", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp low irq\n");
+		"dbx500_temp_low", th, "temp low");
+	if (ret < 0)
 		return ret;
-	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0)
 		return high_irq;
 
-	ret = devm_request_threaded_irq(dev, high_irq, NULL,
+	ret = devm_request_threaded_irq_probe(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_high", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp high irq\n");
+		"dbx500_temp_high", th, "temp high");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-- 
2.39.0

