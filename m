Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B946175C391
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjGUJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjGUJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:48:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05343AAD;
        Fri, 21 Jul 2023 02:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnbokOjhOVtCzeTlxV/MiMVcrCx6WzlGT6gdTYl0h5PGmxdNB0sXlYn50aksdYEXZ8H3MndA3E9MmdDaYHRfJqZgY4SJNjjZmR1xji95d58IE9MPpADbQCkLIGOnjx5nIHIa6I9gjSjIueF8S1PA0fQCypxyXAp9x4eFrsX47x+43eWimc/tqsydCb5DseU2XT5YM21YiXzpQfROxFyQ+BSQBDMN8S1bVgI8jz8IJdGpTyY95bk2Glj+6C+EBOeuywiGj2q6O8a/n2tV9u2djp5ZSLd5agOsDEfdEzCN3mhp9snHD99s0F0XCo2f2sQQHC9Vf0/03QYx3DaB307kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N03nusCUS3siQa14uFSaE/KiicaLWmrEtJVE7dkAQQg=;
 b=LrAHWHmEeSNXRkuD4wRPGMHsqFDa//bxSNhCqQgPah9G9LuIVRU6wSvSOx1Nn5B/5ErYkFGTL9T6jGLUJdemaSyG2hrMg8rTa7oSVktYQaKpwshkvfgaI4GVD7lIiu4aKAEB1slNkW+F/cMOhBgq9xg6s2tdu5x8yLhQl597RMzbgyzDcULqzvpyZqOnc1zCucuFYpux+3xL/aoUAzbADH3GMN14Oa1ey8W0CAdiOEJlXf3az3Syx1f7fWxK2Q485C9d7/JOXI590k4beTtGBTSwuk/5bXIVqYzDnmRWVY+k7wYMd6etC8QvHDcrmoH7qwWGFlRD+8b55DyXJBv63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N03nusCUS3siQa14uFSaE/KiicaLWmrEtJVE7dkAQQg=;
 b=YmBKuiCviNQBuNCuzg+QTbpGCyUE+jyOIL7F3SS1ND8w3sLMMSRppFhQj3s+OfekMjh0oY0e8tpzA9/Yrif8DwJKM3wUSaudAVvj2yB6LEBZMNX9Y6/TCq1nkhksI0am6utH8ns0wRZCQ2x2C5Ff4PLP1V6+dPQzk0yA9uPVUknR3KpvNs8HK0MamPYtKiHKInZ3GVzV8em+c/g89nyxmx7V4cEmCX76r6RGWwbLrj3tV25M1QyyfyB1D8rk7khbbhEccIDWOhqxX+QKB9GosnLERamGomXYO16afyY44C1MlaUwfSVBM2NbV9cjC0SjUylPfdzqrQ6u6ecWo06uKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/22] thermal/drivers/rockchip: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:32 +0800
Message-Id: <20230721094641.77189-13-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48502543-e9ab-4a7f-0f0f-08db89cf7e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukcEb0DILkyCxXqQHdNv7ekvSDDN/IrjTYQ6bMeJpKOdrfo8Fsk3R21A9yayXa6DM8Cgcwne+5rOH2Hk0jVOISLDX+MjssZ+416rtntKXsRVn+SFU8lHmT+gnMrh6cfa/7A1az7SDuEcbMTOBUyWu2gsmCEuB6D3+9PQ8LQRhaQ4/cglfnSfB9GOuh8P1RkxH0NbDa/76cVmPbqlJinrLysZN1sv+4aSyOVtWcYSmjbgfiv5al1AcnEiQ8JjZGsg5NddfDyacN3/VxR7Ud0J2wD+SdBA/abrOJpV3k9Q5+CR8r1zUrQBuo2IjWsaaAKWKxZjfF8KkFpEJay2J830Uvlgj9rpGbMvgukRKmBeHVBltVgzE3wRz7TJWfAeO5p5HV7+3p/BJeyr6PrJAaJx2vYuvXNFtef9iLDlRy2xOMG4M59BeXqVpJ9UuKMuWNmFagwnIKgPZ8UMlVvMjaGLlZMhqh/5XDjNplzCT9hR6GrMT/LpX26zvPFkYwYZ3fNceS6e7LHSGbwNcMYNRqNEWR6iKv+4VNoNqlLiqevBClkPhzUgGyIUqQWzE8XayPPNSBr14gPBSh4QqRm0UcKBPJVSS/Qd9Sl0Db6OvHapsDR0vDuAIAdZnF+HDDuk9Vd/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNwb21OWlpFUEMzekd1ekJFalVnQkF2Yk9nOUh0RmNHaEs5Ny9Qd1hWaVEx?=
 =?utf-8?B?c2JKN2RUOG4xbEJwRmNra1VhcFcyYnMwMGExZFFjL1N0dVE5aWhIZWZVZ2RS?=
 =?utf-8?B?N3Q1RXlhc3RleHArOFdHalc1R1RWK2MvMEpjbkVuTk5DajdEMUZ2MDJxVWE4?=
 =?utf-8?B?eERIMjNNUExPa3hjWjR0TEdyTWZXYnNuT25pM0Q4MDdUK21JQjhSM1RlTDFt?=
 =?utf-8?B?Q3pGTzdkZ25SZnp1aFNzeUMrM05Ob0ZRa2R3TFZNcWhhZ3dlWVFwUjNPcGZp?=
 =?utf-8?B?N0ljbEp5Yy82NWF2Q0pXRFNzZXROVVY0L0llVW5WTC9ocUZLcEVJNkxSQ2t3?=
 =?utf-8?B?UUZuR0c3aEg1dFgzbmtGeWx1b09oVzdORjdja1YzbU92aTlUeFRQNWhxclJz?=
 =?utf-8?B?aHVCTlpIYm41UTBaUHhZZ2FjZXlDZm40bjhLMlE0VUJPSW1ETHA3N0owUU9v?=
 =?utf-8?B?L3NaZ2dpS2RtbHVJNFN4KzRCWHdtZUVjQlpSZUU2RE8wV0JsUHl5T1EyL1Qx?=
 =?utf-8?B?VXdrMnN6YURPR1JPSE5tL2luRlpESlFwYXVsVVl2WEI2MlBTZzJBQTBYRGRu?=
 =?utf-8?B?b3MxTmdlVG4zY0tZb0ZUR2MyTCswOU9QS1pyUGdWY0o5Q0I2UW5DZlRVQzEw?=
 =?utf-8?B?NkhCRDVrNm5Xa2xnRlVpV0ZQanhtVmorRW02SVRaMVIwZStjSWlHMFlSZmFB?=
 =?utf-8?B?cWJYYjA0L0t2ZHlwOE8vR2M3azZwZFRBL1JmMUJsZWduY1Fyb20zTW1QQkpx?=
 =?utf-8?B?MFZtL09ab3pTSk9TU2IvU0tiN2RNUTRxK0lpYVExcHkwZlZxRjZDMGswVWZI?=
 =?utf-8?B?MmYzSlljZkJHbURPZDNmbzRBbW8wRnZVdlhxNFBDRW1JaVl1WURKNCtLYVV3?=
 =?utf-8?B?Q0lOSmtrOW1nN1Q0UHpDQTNGenlDak00bFdlV1ZDeWoxWHJOeWxQYVN0NUY3?=
 =?utf-8?B?SkhueVU0YUloaVZWVUFXbGUzRU10ZWNlWHg2OEVVTEtOeHoyMXBrZnYzQkli?=
 =?utf-8?B?WlljcU1NM2c2eWVvU3lVQ0ZWTWc1KzdWQXdicWQvRHIxRTROem5FWndTOGVE?=
 =?utf-8?B?am13dFFnUERyK09WMGd0MlVINTVabWU4TFJndTUxYzVpWXR6Y0FwT1FydkxH?=
 =?utf-8?B?bGRVSU4vQUgxMi9Jd0RMZkx4YXFCTDdTNVZSa1FPdGw0ODhVbDd6NDFYc3hv?=
 =?utf-8?B?dWdGY0hxS1k3V2NZQWdTOVhZTXJhMVVWaStlYi9vOUVTazNKeTdSNVVjR0F1?=
 =?utf-8?B?SWZSdEZNMWtpSUtnWjhvWlN5TGpaVjRpenFLZ1VyRFAyOGRzWmd5dUNGUFhj?=
 =?utf-8?B?UXowSlZkZTJsV2ZDQ1pKeCtCT2tyRVZ5KzBsU212engzUUR5VTkwVzU0TWRk?=
 =?utf-8?B?ZWVBOWtndVNsTStFampObFVROE5hdTBRRk8yNW93RWRoWXh5ZkZOUk1oc2dY?=
 =?utf-8?B?WE91S3VzTXIyVisyeVBnV2lEMzl1UkFPeE8vVEVrOWM5cmlKNldSWTFYT0FL?=
 =?utf-8?B?dUVkOE95WEkzbklvb3FQY3Z5dHFKVjg2Q3AwTnNpdFFkZVhCbGlxRkR5bW4v?=
 =?utf-8?B?MHh2Z2tQdC84MUwrcUE2T1JqYlpPOHdlcUFMeUtIQ2g0dkIvN1RnL2pKcjN6?=
 =?utf-8?B?bHRaQWZ2ZjJabVpaQlBpTUhxVDB1QmZCVkRrZ2xOY0pmQ2IwdERGaFJ2RzNC?=
 =?utf-8?B?UFZPNEQ0Q2orWXhueGt2WXhwZzZZUnEzK0hRdHJjUHlnTjNPdG02SXBFMmRU?=
 =?utf-8?B?K0QxTk9EWURiWmg0YmxKVmVkL2xLS2dGWEtxQUdGdnpkMkVqYWJOV0NBZlpn?=
 =?utf-8?B?YmZPNXYrbDFSbm85UEpmdXFZLzZVYmsxRGxybFNrZzJHUWdkOEdMMTFUWC9k?=
 =?utf-8?B?N1cxMkEwSGhpa3JZSlF5Q3ZSVHd4KzdVbmlJSG5xamRoekdVL1R2MXBORW9r?=
 =?utf-8?B?M0t1TE1UTk83YnJrZ3ZYQjA4ZGcvRzdYaGkvUXhFU2xjZDQyQThzbVZiQ01j?=
 =?utf-8?B?NXZoY0ZnZ0RiTGVkRjRhYzd6YXJXMjAxeFhJMTR0Nmd3UW5rUGxwUWtTZE1E?=
 =?utf-8?B?Yk5YcWxOeUJRdE90VU5VL25KYTdDQ1NKTmZzaEhGL3g4WUtPTCtGUWo2REJR?=
 =?utf-8?Q?3UjR7X1GNrhkblfcry1zTNR3T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48502543-e9ab-4a7f-0f0f-08db89cf7e45
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:27.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98HfIkJnvUzbfPH/v6gTYOVZQe3WuIa3X3f84vvDHhlKY925sYAuXfUsOSZdLQXXVot0RLeLfsFL1rbwny6f0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/thermal/rockchip_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 77231a9d28ff..11061f6ef323 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1577,13 +1577,12 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 				"failed to register sensor[%d].\n", i);
 	}
 
-	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					  &rockchip_thermal_alarm_irq_thread,
-					  IRQF_ONESHOT,
-					  "rockchip_thermal", thermal);
+	error = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+						&rockchip_thermal_alarm_irq_thread,
+						IRQF_ONESHOT,
+						"rockchip_thermal", thermal, "tsadc");
 	if (error)
-		return dev_err_probe(&pdev->dev, error,
-				     "failed to request tsadc irq.\n");
+		return error;
 
 	thermal->chip->control(thermal->regs, true);
 
-- 
2.39.0

