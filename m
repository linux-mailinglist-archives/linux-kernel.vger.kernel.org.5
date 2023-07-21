Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162BD75C3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGUJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjGUJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:49:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677D230D0;
        Fri, 21 Jul 2023 02:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6wlzlGQPvtMMyFqjjrmiYvHtVLAZ1aCeWbkDzsK7Vn8V0priy9jgG/qU0M2pvjp0YXOglaghury+lfYAsx53Nhh3QrYRPEMgdQToGhAze7IEESbZ/rZvhm1GnAVgPzlzR0bEgKwCO3w8jvuwgBASm4S4l8U3MeNEaQEUkMg/miBUR+AyMyqG5ntZnEW8l9LsVEpanwp0Zk2Qgy9aSjYrtiEQqjsE9ltTJlc/fKIaTJYr+vaNgEsopbVciPt6Ox3F1fxOBSZP5V6RLtA4JTatvh7v2r0QPqsOlzZSFBSEOXHQKH27L8HnN/7kaGcgAlC+lR5mOnMouLTe57yJcxnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+TzYuEeTgIKdnKfQ77B8vedEfB0P2/z7sQrh3Z4zJE=;
 b=JVQgROdNkBp2PKh0grjhUy+F6cDegVgT/ijW8wOzGgQjw8etkfa+W67oceX4ULcPfv7LwEAaGIihpTLiGyuakWSQx8/VbbsTjjhg171N83SlgCny74Ehpz7LHYwX7pxkfBkgVwSDj3OKRQ5T3S5cOsm0gWwDQKS/HR5rEb578E9d9dfoOGdlsvtuYl2HnKUeeuNQT9Z8o3GKI61IO0r11ACpxDHbD+a0v9cvuNtmEnIdmW9+87l/+SAGGx+PhfiBqPwSodN39pcQWPzTOoJQ0HDeU5RS6S5okpBaWxaqfAAHn06h59rLjpTEr8FAEip+xAh7r7UaDa5YdDg6QgJhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+TzYuEeTgIKdnKfQ77B8vedEfB0P2/z7sQrh3Z4zJE=;
 b=qfcHrklTXW184EA90QgOV1RDHJpntKHaG+564U4M5St5ugEuR0m5OMWRPh6AooN7IbLq5ZQc41W/8iPrxRUHcG2P0bZU+vAWakaChBKqu8OeqOfcjZOzsV6x0xQDS87E59AaqCU0/OS9l2z0kWS4iV/ct5DmiNAHqkxlH/zdt49k+GFtpt2qiAoIrWTxDRPi09awjePWuDBGGur2nkEadxKMpgS1UoKjJNTU+zqi6QJE3ms9KyoVPVtoOFOQrgJzrGV5c4RWP/w7LAS39+T5951ve17d1w7KkXsKGvz5lmzT6a/Ondmz2bZ2bX84Tu2nFgzHbPFm/14IDB9FXtZfSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:47:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 18/22] thermal/drivers/stm: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:37 +0800
Message-Id: <20230721094641.77189-18-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25dd82d3-01c7-4f43-e2d1-08db89cf85cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty5Gj0IOo+nnkQtTl6AOhfhcPMvlwZ6WVnhHrYNVE9iFMsTqS0/Weh/6mv6mk19sLje896WMO/SDCMZ/Z3Z8I4nLqNgYl2IiUePmTPHM5Knw8N3B2j5qpucWDOnHTPIUPLOKlk/7pxXiPOfiLAUd1SMiR9NmpwGtTlGvJkTa1yVtcBTzCuDkGYF3AOEn9Zl7cTn1h04DhFjPYQst7GHd5bA6MPHHSvcXZYQDh6GV5pMS0IJLwOaYQSBRyRsqkGOoXXkv4hzmYo/caNgw28UAtFrqtIYEe3rAHxrT7bj6c4ZqNVLcDFcX7hnReWHvma6Y5o1qZkDXXTTkbPFvhZ9/6+Vt9bE1qhat/2Jqn9buRnsl78JySBi6Y3QNICb6aBjARuZUJELKPG5k0OamAtW+aKfP5YRJAO014V6xn/YzeC/mLmzEk5OOZ22URwL6PEPX189GNqxttNzRHSsO7y5UuxjOQ0ibdzuHgdgt2CeVCQagi9AP+1FjosCJkQ9Htiw99J9AhmoE+rCjLDDVwsJqOry5Hyu8mZyd0+tTvfSp3A3vW+Z95nbW/ukBEW5qGfeiHCqs0FNi4u5MtgetnerpG+Y3HsM1X6g9Q8PT03NqfsSkGcE38RT9adb6uG3TG528
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(52116002)(6486002)(6666004)(478600001)(110136005)(6512007)(186003)(6506007)(1076003)(26005)(2906002)(41300700001)(316002)(4326008)(7416002)(5660300002)(66476007)(8676002)(2616005)(66946007)(8936002)(66556008)(38100700002)(38350700002)(36756003)(86362001)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNGaEREZ1BoZXJRd1ZJMWtremtKTnUwN3RLQTBjMXoyM01la25pMWw2MDNG?=
 =?utf-8?B?UkhuNEpsQVlqK2I2bm9uc1o0bGpHWFhKbjVORWU5akp2R00rTlVmSHNoS0xR?=
 =?utf-8?B?RFcyUVB5QW1tRktyalo3WHI0cG4xNWhNY21wcVVNU2xIY1JZOVJmL05zZ2c1?=
 =?utf-8?B?MVFhMlJHb0J2cDJzTXliRnJ2SlVaeGl2NU5jNzJhdC9oVjdEdjBxSDJTRVBE?=
 =?utf-8?B?WlYzQzg4S1YxeEtoU1hxWG1jYW43TlI3YUVrbzJFeTJNOEF4cDZ0ZWxaOEI5?=
 =?utf-8?B?UkY2WXVCK00rdXh4eE1PTkhTbzhZbHNQY2FFSGF5Zm15VFZGcXVaWEFkS2RE?=
 =?utf-8?B?Ry92aGp0WUp5ZDN2OTNIaXRCRDkvbmozcW54SWJPWGVoam9kVEF2d3UybWNZ?=
 =?utf-8?B?ZGFvdlN5c0hYS1dnZXRGSm11eEY5VDR5eC8wTkhLdWtUSTMzTFhIN0dtcU90?=
 =?utf-8?B?azMyOVRPSDVJcUVFNzM0SE9IcisyaHVGMGNmT1pwQWtXeEpLOFBNSkZUWjFC?=
 =?utf-8?B?a1FSWFozMVhvcHp5cGttSFZSTE15U0t2UWtFTk1CYUh0aWxMbzF1V0JOK2pX?=
 =?utf-8?B?TE5YV09FTjBCOVprTStBSEh6Wkl1Z0ZVU2V1YXozSmZqUFlTSko0emg3dTlN?=
 =?utf-8?B?alRhVXdSNk5sdzAxa1lJNlBncGcxU1NZRkE2eUNMS1lzbW0yVkMvRlNzR1Ay?=
 =?utf-8?B?Z25VME5CaFc0UUxvV0hXVFZTNkE3T0hnYVF6Z0c0eE96ZTUvWVN5M2FlSXNp?=
 =?utf-8?B?MXUyOW1pUGlzM1A0anZWdC9FWTEzWkdpTW1wdGZUTkg5eGpEdlZTd3BpUVps?=
 =?utf-8?B?SW5uMkdTb0lpSW56RnM1a3VvUVljQXcxc0MrNXkxVWpiRlNzamlEcUxsVm5L?=
 =?utf-8?B?U0NKOU01ejJYRDZGRlRLOTA5bDNRTHo0aGZxS1Z2U01MNEVWZG1vYzMyWmk1?=
 =?utf-8?B?dDFDWVJzYkJuaUx6ZzR4TThZblQyaDA5VS9nRURRVERILzhubGRwNlk2UFJv?=
 =?utf-8?B?YlZLNTJucFl0STN2TmFmbUJDa0t5ZzkxRUF1S0wzQ0t2WUVMdjJ6ZDR0WWNo?=
 =?utf-8?B?VVNtdHAxanhvNC9RWHFMWW4xVlFkdy9Td1RhUWZyc1NDRU42d01DVkhRd01v?=
 =?utf-8?B?bWlrQWVXOEhUNjcyU3doT0wxL202b0t4V05HeDJydmR0T05EUUtiVXZ0bVZF?=
 =?utf-8?B?bTgvNjIwR3VudFpSR3B0aFVUYTdZNUJwUmtlUmhsZEIxUDNab1k4VlJ4ZDg0?=
 =?utf-8?B?NWhVS0d5UHd5aDU1UEdJRjVDUU9lRFdvTURieGlKUStuQVVlV2tHbjd0QkRu?=
 =?utf-8?B?OUs0QXhiTGhOa0hCa1Q0MmtpNGRyQ0FGVE5KR3J1eXVsVmxtQi9wYUYwOUVC?=
 =?utf-8?B?Skhlbkd2SC96SUovSmhORVJlNHROR2owRTdyT3RaWGh4eSsyVHdJTGdoYXo1?=
 =?utf-8?B?N2l6WDJta0VqeW1Ic1JuTkZsaFRhQ3Z6Tlc5bGthTnFHdXJZNXIrTmc4blFs?=
 =?utf-8?B?V0hudHZXK2hyRy92dnAvdjZQbGxRRnpkSTAyd1UzYVRVWExERm12VUo5dW5z?=
 =?utf-8?B?M0xrOWFvSlRqckQ2OFNRUzB3SDdHNkxFR09aVWJpZ21KaVhWUUVhQ2pQZm9O?=
 =?utf-8?B?RFpDSi9GdHhVTEVwZEhQeUo5ZUZ2L0VXZGF4clpyaVNXNTFMWjRYWThqTXFa?=
 =?utf-8?B?THcvRHBMS0VLWktUVGJKMWpFc01zb3NTM1RZKzIvQVc3MVRZYWR6S1pqSVUv?=
 =?utf-8?B?TDZmMXV4WTl3WU5wdXlpZ1R2OWFHVkc1TlVQS2J2SVJWcWo0bjZzSlJxWDU0?=
 =?utf-8?B?Q3FxL2xteEhmUkpVU3BKV3dRMFU2ZFNSQWFFN2dFVTdxam43WnZOdGxHTkZy?=
 =?utf-8?B?ZzZraDEvK1ZmZ0Zjb0NYY0UrejJjTmVtN0NCMHpKU1l2WHhYZjc0OVNMSWNr?=
 =?utf-8?B?b09TQ3VPblRsc0QrZjM2bWorNkJBcmRGU2lrL3VTT25KWmVDMVdoQ01kUzlG?=
 =?utf-8?B?ek9Ua0Q5YjJkU3pwVk55bVlVMmNVNDNEY3VsK3hUOU9tNUZ0VFNtN2JmMmZ2?=
 =?utf-8?B?VkFlbk9VSjNtR2Q3YU1NRCszM24waXlVZTB2MUZLbHNSK3BjaUwyaEJteVJN?=
 =?utf-8?Q?TiNKLYoWcFTmYMWkFDzVCIfO6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dd82d3-01c7-4f43-e2d1-08db89cf85cf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:40.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxNfBV1HrrqXpF3MlG4NPuTs8lJNpDnAqWpncJfNAMW+b4eoJfsMkfkREzmvv3sv+TI9Y3d5g8Kkqolt+tK6Ug==
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
 drivers/thermal/st/st_thermal_memmap.c | 12 +++++-------
 drivers/thermal/st/stm_thermal.c       | 13 ++++---------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index e8cfa83b724a..40bb318b5489 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -97,14 +97,12 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 	if (sensor->irq < 0)
 		return sensor->irq;
 
-	ret = devm_request_threaded_irq(dev, sensor->irq,
-					NULL, st_mmap_thermal_trip_handler,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "failed to register IRQ %d\n", sensor->irq);
+	ret = devm_request_threaded_irq_probe(dev, sensor->irq,
+					      NULL, st_mmap_thermal_trip_handler,
+					      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					      dev->driver->name, sensor, NULL);
+	if (ret)
 		return ret;
-	}
 
 	return st_mmap_enable_irq(sensor);
 }
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 903fcf1763f1..6a36a7eab9bd 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -387,16 +387,11 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 	if (sensor->irq < 0)
 		return sensor->irq;
 
-	ret = devm_request_threaded_irq(dev, sensor->irq,
-					NULL,
-					stm_thermal_irq_handler,
-					IRQF_ONESHOT,
-					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "%s: Failed to register IRQ %d\n", __func__,
-			sensor->irq);
+	ret = devm_request_threaded_irq_probe(dev, sensor->irq, NULL,
+					      stm_thermal_irq_handler, IRQF_ONESHOT,
+					      dev->driver->name, sensor, NULL);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
-- 
2.39.0

