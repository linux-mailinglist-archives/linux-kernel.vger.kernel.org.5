Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879CD75C38B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGUJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGUJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:48:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B12D7F;
        Fri, 21 Jul 2023 02:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAlvYNOHbLRWL8dkY+rxaIkaylhb9PZ+z2o+5wurx8Hv7qgyZ85exdWLRFYlJlBMzSfo2CRljWRJcPPtcM01/0k5ooGQWZYgWrFmuDseiS0yqgzE+tGh638cC+rkHteO34r/CW6FDO4IcyyJpxvXgBEmRdAxNEUyWtAB+Ahe+BXuslLs73VVIKA3n9rUtovnWTqk2nNu2Gws9KVRvbf+Fjv46MXg2kNKzt3eAej1tjWGsnvsF2dEqvaJ1Wp1V67CVvMu6FWwrY5rDWc2Kd8Vc52ADSjAG6ipgqd0cqN4CEi+5MsHIYP+dxNI9kyT05Vx2YzP3iZLGHw3KLMLJ5AjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2g69HSmEHuTTYKyKe+Ic9ejjUzfByis+TpAlcnSq4U=;
 b=kZsKGoO4Q4fhuhAEoJzNR/2PMJROpaBDPllmeHrVDKB7xnrlKInRj+o/BPemzKtYrenwnQORgKjTXPG3hcCpoJ+Al7GVxUVgvLTbIATSpfGY1WbK6/kVxhblsppKUN+oV+52V8BCo1dx/rLqT30J2Gy3si18eSUqhuP6pu6K+Kt383VFHz3ycJ04MYta8Wx9EPyrtkr2CZbuXkp7pBWMdYtK43uExFSXcZp9NTsau+eqU9c3KOHYsTbhbL5ZdMuew0OdubRuJORfAqMYpvT4pmTckcUXHCNIe9R8ivLjLrMhLAFemju2Kv/4pj4Kz5b3RINS5pZ1P4Ry3j39u87Cpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2g69HSmEHuTTYKyKe+Ic9ejjUzfByis+TpAlcnSq4U=;
 b=YTb6enSVBUaz+anOhpMDaLr+55YqGeXHhuNnCgZ2ki7Db5AOVri/B1zUuBWny/HyRQPFqFnYbM79fzC9cF9FZb0b/z8txIv15AxN4FBXPulcrUYSmTtOBuWXwOrTA2JLImVEGFphBOt5/Pd+btTouoVeV1lVvF6/ngjZTOz51wW3IrH3ETqZwa1ByOa8QurqZoGwVp4//h/q+hb8ZQdXJ1ludefNzqC2lj172wZexfsIwrlkM6FgKBqtpR4qqYlj027rxYbGC8sV3UNzLRRrW4ElVe8dVWospzAFXKrVrFQnTC29BOzAihTVxv/k6kJZDIuluA/8CKVUW6y3o4ydvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:25 +0000
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
Subject: [PATCH v5 12/22] thermal/drivers/hisi: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:31 +0800
Message-Id: <20230721094641.77189-12-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb0de5b1-2c60-4176-d00b-08db89cf7cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A94iBdEAKMIA9jAfumInEJw6Gxgt23CRzdQ8Cenkvwd/do5Y1Y9LG98albR70c0NFvKxNZ4ugQ8pHXnmm7lxEMhxur/8wOjZdNe1VmjAaquXlOmOm1JrlxM/u/YwMI5jt6zv6o2f66D5AHFnQn2efP4WJM3cVyidgdjrEwAl2sc/FqwrsUYc7E/g2swqku2YUbafxxrNA+3s8TLkFgImFBfDJuqEYh7N7nwgDs/b7tuOj98Gpv6OF5BxHg6V9CkfInG3+OmYQVOKdL9YJpiWvBHloz+cs6lPGh2eQ0MOFbtxQkUaAEClR9K89qh8pez6UW9axK+Y5n2fojjKCdKFX80jJZEVgK2FKInQneqdPHZzdPBl+SSLLKmFIIcD4/SztxX8wCkDokm29EZu1CtFoQrScwArYSz4Uyo4tb4fR+M4bk2LskLhxnBkYQ8M9BOluWKOemiiLVZjNpOcX9Qy8ExBBj+O/XNgtY967FWPZDQUK5xs37sV9p0LhDn9r8eGYN7GWEJXR3UyiYxuaAmj/V1J0tDQOHoOhBEVnxuTkK82G1zFk9s89KqnDgabH2Owevb2ffvdpA/SHZmybtMa6JebAsAhpT6/t4uz2syaOIvFD7TZNw4qrhibjRtRLo5T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdLSXJyaEsrTUMray9SWFI0WXlTN0tERHhZWVRubWZnRjYyNERGdzFmRGw0?=
 =?utf-8?B?NWdIRUYySW5Qb1FmOFdXSDhpOVdYRjJ6bFVEeEdlbXhqYWtJTEUxVVpuTFZO?=
 =?utf-8?B?Mis2aEV0RnFZT2ZjY3ZRcGxha2NJRE45akEraEg4N1hKYlF4MTB1REwyODll?=
 =?utf-8?B?Yi9rVWRHM054RWlaUjFiT0xFTkt0YlZlTjJUcXBTSkh2YWF0eGJvK2E2TWRH?=
 =?utf-8?B?U1M0RTlpbGZvdHd3Y0xBRzI3amVwTFlpZk5ycGFHYzN4Wnh0WVZZQmRMTGhS?=
 =?utf-8?B?UkJwdXk1NUhnQ2FodzdHSVdDeVE5Nmx5cEZ5ZUQ0STM1MlZRLzByMERwZUox?=
 =?utf-8?B?dmtHci9Pb1RwY2RYQisyNnFIZHo1S2xFR0s4Z00wK2pzZjVsVjhaT2ovYk14?=
 =?utf-8?B?VGlwZ0pXRGQ5TWFrOElCYisvenZ2QUhOWUFQbWR6RXF2MThSWCtVUGZjQjFK?=
 =?utf-8?B?eFpzYUpKNlhSK2ZvU3Z0Y0UvWmlYRGNVR0pTNjUrdFpBR0Z1UkZheXdhM0NZ?=
 =?utf-8?B?NEtGdG92Yk56d29iY2RFTExOeDUvNDhIS0hpeC9EWlMrSE5xZEdBdkN5ZXcv?=
 =?utf-8?B?MXh4K29FQ29VMkJ1bG93T01aNityTGpEajdjcjZiQTZsUE1MTjlzalRVUGd2?=
 =?utf-8?B?UnFMYUo5SGRWbGRDWmRlNXJvZTNuRkh1cmFlM20yMHlRQTc0MFBWMHcxVVFn?=
 =?utf-8?B?RjFxTEZTb2pSbHFTUUFjdGtObExVU3A4STQrL25sNFRHQk4wMGVyZHhZSE9W?=
 =?utf-8?B?c2lkdHYxOEtiUm5aM2hVT3BFdVdDeEMybUNmdHVKV0UwZnp6elJzZlcxVlQ3?=
 =?utf-8?B?YkFrdWl4RHdWQ0RzU1ZWU1BwNzhVbUE1c1U5YnMvNmd6MTZuMkhoLzg0OFRz?=
 =?utf-8?B?QlBUV2REdGQwUDduMENGRWRjVzNKUlhvWjV1c3ArWmRHUHBINGtBa3FGR0M4?=
 =?utf-8?B?S2JBOGZZbTZ2TDVJeEdzMysvdnFrMlNUR0drY0VPKy92NFFlN2hyN1JJYVFo?=
 =?utf-8?B?V2puK012SFlmcThOemlZQ2tCamJHMVhjeEpvWmlzVW9SVjBPZVhlVjU2U1BX?=
 =?utf-8?B?bUh5Q3NGbUVRWGxTZGdDZ3c3bkNuK0lIOFlSRCtqOC9icFJCeldUdUIwTThk?=
 =?utf-8?B?UEx2Q3dBQlBrMG9IMzNrSmJMelRyN2Z0d1ZQREt2T24rcEprbTN6WHNIUGdh?=
 =?utf-8?B?aFR5VUNNNEErTkZ2ODRSblZwcmhJeXFncnAxWDFkZzlndG83YjdqMTIrNFRY?=
 =?utf-8?B?andxSTUzL0duZ2JUWEpITzdZRE1WWmlLYnJSNjJOaXJLOXFKSkx4RXkzQVJ5?=
 =?utf-8?B?a25XSTJrclBBVkZaWG94ZnRIYmc3cUNWVnZjSHBQZUVPbjV6N1pqdzVxWkMy?=
 =?utf-8?B?ajRJMVM3WGdYdHA4V3dYdVkyR085OXRRSStmVHBISWxveVNkNHZ1V1ZTYndw?=
 =?utf-8?B?UUMxN0hWUmhZWXpBYU5LQ2RSeStaZ1dPaVZwZlFGWkZmYnZnYjI1MmN4UXRt?=
 =?utf-8?B?SlVPSU5BOEVSZkl1OFgrWjBiY3RDck9yRjNoNUp6bmMwVSsycm9nRE5mTWZa?=
 =?utf-8?B?U2RzdjVlem9VY2RzaGNaZ2QrNENVd2tKVHFndGFxU1d1WjQ2MndJQzBCMmlC?=
 =?utf-8?B?Z3M5UzRCeHJrOUJBeEtVL24vcjNtTG9YOC9ZMlhnclVwb1lsN2pvVUhiYURM?=
 =?utf-8?B?WmY2OEh5WE9QWk5UNHFJTHVHeGFzNTBzaUtMSkp4UVh5ODNwOHQzSjVHcWRN?=
 =?utf-8?B?dkc0TmxMaWEvVGZVU1NETERoWlUvZDlkbXFOZm45eGoreXhSNFRITVJ3ZGcx?=
 =?utf-8?B?NThUMmp2SERjTEgwNStUaEZuTng5NWtBeWgzbldlWUNKUXZvSkFWd2lkbkU0?=
 =?utf-8?B?aXFXcTBwbW9BVVhCY1h6YlVxUFdDWnVka1dnckdDRG5GNCsxQTBOb1VvZGdw?=
 =?utf-8?B?dzVDeVZidmlOUk5XcjFJV0FpLy9MRHU4bHRVQU84ekxYTThhM2QwSkpXY1BR?=
 =?utf-8?B?RFFybDB0ajZwSjZjT0VWV3U5aXRPd3p4c01mY004WTNiVHZxOUgzWnQzZHhm?=
 =?utf-8?B?SGYzeTRvNjVIQ1hDYWJ2SzVRdmZMcy9CcVE4TVR3aThMVUc4Q3huS2pRbkVi?=
 =?utf-8?Q?pO8plqJx9szzgISLrcqNlt3gT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0de5b1-2c60-4176-d00b-08db89cf7cce
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:24.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7S/F4KsXjcZwEmXyB3eJXKExHfOhS+U8UsY7mMnYWZqkejnM8pEXBTfvZGUJTFBwspFpOjjBIu9xhIs05xw1g==
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
 drivers/thermal/hisi_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 3f09ef8be41a..ee5f50fb2b68 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -576,14 +576,12 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		ret = devm_request_threaded_irq(dev, ret, NULL,
-						hisi_thermal_alarm_irq_thread,
-						IRQF_ONESHOT, sensor->irq_name,
-						sensor);
-		if (ret < 0) {
-			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
+		ret = devm_request_threaded_irq_probe(dev, ret, NULL,
+						      hisi_thermal_alarm_irq_thread,
+						      IRQF_ONESHOT, sensor->irq_name,
+						      sensor, "alarm");
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = data->ops->enable_sensor(sensor);
 		if (ret) {
-- 
2.39.0

