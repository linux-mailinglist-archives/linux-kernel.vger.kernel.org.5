Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DBA75C367
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjGUJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjGUJrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D4270F;
        Fri, 21 Jul 2023 02:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDXd/CPMirmrO+1y5VAH2c7LX0EU8LQnpp8FpQH3y9WwiHimci7yC0RbSqvnTuGIiFEhQSBvZLUQJSIVCgsXnfAScACyWDuRD4+pO+dteVkbFARD+BM+MMk9a6MuUj9t57K45qO7ec0kqhk5s4LO6DEpdQGqj6AJlsGYuz0B16Za4aKKz8HLMyfHjTR5XC1/T3LsnAdxDQxQ4grpfkmP5zh4SS7L/ZbOkM70LfFU6zhbuRaoo220LX+b6oriZ32aTODsrDMK3ijb5EYbBejQSMt/vPQyAbGA2J5JeFxB+cFe8+oZA8V9jEmB8UWaLmF6vn+jRC8/XdeO3ANQmIlRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjfxK/rG41MW8xIM0n4h07DdTRX37piixiXYncIAkj4=;
 b=Ne6nVZOisOBoZ1H7/Yag2haTWq5quNDobNRcL1NAGihZCdvsT10TcGvviGGYkQeHLJvJCBroDRWlWBdMNob6OT81vC0rscl7txGcIn4PaqyHCvkhtmHio4fv2jGpt5tDQqmr0bW/N/Oj1YN5LinOHsC5gO49OSICu3SJMD5hxyaXGdFEhuw01Wn9Z/2BFY3RfbcR+l2B61xZzChpCDPR2yg5EHK3N+qxqA38TBzK2xDsCWoQ3bujH4IZTijBfrWprjaS1dCMNM2+FlCOTgiCSRhzrbtfUNhRLR77Tmu05kllfFq4iPUAywoR3QXZ5f/pU+2moUqr7Lx9/0/0mbyezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjfxK/rG41MW8xIM0n4h07DdTRX37piixiXYncIAkj4=;
 b=e+8GAP9DxQENM00UXpAQWRd2hHCR5SqBmD+Iwc9E1ooecbqOKto43uVdUfAUsaVWzGJ+NuAl/1sJowUoWF0UrRifOckhp0yQr/1YR4LGVs+15fDGzvcG348evNFz8n12PS5J6Bhn9waG3EYBRrC8OqsQGzKb5WTLouWTt601J1smK3IMxM+o9i9d9U8m7yb5AgPnSzVn86JT9Fe9KeotI3Uv/RIRXMOB5KUn6GEylabPUiXoMX2wRZF31X1LEKuj/xPzyn2EYT/vPTcAyiWZn0JUjEfpNHvlpDZ/jWei+Fo3ux6fTO2YUivw6fb+5GHnPj8hL/foTcY7g1c88Tfdrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
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
Subject: [PATCH v5 04/22] thermal/drivers/broadcom: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:23 +0800
Message-Id: <20230721094641.77189-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 251298ff-5de7-4960-2ff5-08db89cf70af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csWfH3CDlS4Q/rOIrUoJlYR/FVBebOJJXmnfcteUKGJDSOXklyrRmk46RVkT95zga50fuLc/4+v7k5L2/FVvTQQjnnO+jXFO/8CgjnbqNwmTzXOrzCDyDWk6J5GXtupBPbW0e9kqH7UHBBQ/TDVmaKM3htdIiZ9GTd6FTG78OjQXXJ2j/k8JHAWz/xpc2TsMefVwrXcRiSNwrgsPqJq53ATcgCqR1xmbHGeJ1g+nGCzLCIfRQC2YX4gwSeGljdvagMe+KIHXAGES4XUoLQyj0N9WhdY5eGUhUDx+28gTuU49pODQihOuLdbMDPlWRLVwnas2WSuFw5Pc/Ar4ZDiQGsrs6kAsbF+sSEKj4M8Xl12FUKLDqcD3tc+lHCSJfB54SFRww8P7XWHRpVUr/AkOEMPbKhiPkqiI7wF9PKL6keFaOZzo68IJN+7L9bgOn6Kz7jQZ62wt2vFI+Wy8uSWPKaD/oi9NdXyp8sr5vZdj9VtkdWe2ihvsY0YNAtuGPinlj+qY87BRxVtmNbufUJw7qD+4ViLGRuq/rsnJ0Lf96Ty6JnIP/MQBe5KQk9Pid4sfZ+XABTHEB6iArmlcWaI9Tanf1nfBbVMAucn/NWIPYIUbeONe+wMPEZCE5UVk3cLR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNKeitEbE9zTFlUTU83MkJTazFvaVMxRDNZWVo2MUdjQ1FzMlJkNjNTUzc0?=
 =?utf-8?B?OUVPaWlhL3ZsWW5CYkFqLzJtQitHVmtzTEVoaG1ZWW8rSkhSbFpQZW5TcFdO?=
 =?utf-8?B?UStvZXkvUEhpWXJHckNFNVQ4Y2k3a3pjdVMvZVRvV3B3VmwwdTMrVUM5a3o4?=
 =?utf-8?B?OXM5Z0UvUk9QWnR4QlVMV2lDZlVLSUdDSHI0VjhTcVhpR2Fmem9zbS9aZWZR?=
 =?utf-8?B?dFo4MUtma0JmREZKNlV2RzlXcnJHRmJ2UFEvd2ZxelVxbnNraEk5am03ZjQv?=
 =?utf-8?B?c1IzRDlKZkxhL1dlQWlZZTRQSU5zSUJtbXZLU0VPTmttT2pHbWFsWi82NUI1?=
 =?utf-8?B?TkYyUE93Nmoxcmszc1pCUDRmMDlLV05JSUt1b0RHUHcrYTZjaGhjb2VvNmVP?=
 =?utf-8?B?MGtRckNteC9sTzBhaDRhQlhVd1gvaTFTSTlqYnRiZGxPVXRnS1lDbnk2WVlO?=
 =?utf-8?B?cnNCTUNsMC8rYyszZVoyTmtxM0hDR1VrQXcrQnhrWm1TNnE1Wi85WkR2TDFx?=
 =?utf-8?B?bDQ1YjNqYVhSYmJZVnduU0VsNFIvc3Z2Q29uT01pc3B4dXZ6dlhDekVtQlNx?=
 =?utf-8?B?MEZaRVA4UFRKc3BpREowUVpTcmd5cnB5Y0VUNTZLekJxU3lVVFkzQ0J4OEU3?=
 =?utf-8?B?WXp6SnY2WVJBMlYzN0crZXhoVmNMckd0M3R2cmcrT2xTeUhldXNEYkJOcDF6?=
 =?utf-8?B?aWx1T2dHVFhXUTlBY0RjRkhZeWV1K2cxKzVHN09LZFNYZFlQbWxYRzhSSFh4?=
 =?utf-8?B?dnYwVGxQRWg1UWRTSkFBclhkMzZBU1VzSzQ5eHVRbGpvRFMyVkR1MUs0Q1Y5?=
 =?utf-8?B?cmJQTGZvaUxSd1pocG4wSk1Zd1RDdmh0MkFIaEozTmNLRWpPS0lDYTl2SHVp?=
 =?utf-8?B?Y0EwWFdXME1nRUozMWM4TVpLRnErRHhnV1d5OWFiZFpDZlNCb0pEWTdBSndN?=
 =?utf-8?B?OElCZDlKSWhPYnJSazlPME1LM3ZTUGh2NEwxZTUvZTFSZkZXRm9pV2FEYVEy?=
 =?utf-8?B?TWp1bVF3eU9hZmpqTXZZUzNSZXR5YVllT2p2SFZmbmZ5Q1pqYVpiVG53Y3V2?=
 =?utf-8?B?SStmSkNoL0Vhd0w5bVNTekFrRDlGVU5hTHF1WXIyWmtWcDRwVU1iYkdsdzNm?=
 =?utf-8?B?U3k5UE9hbm53NU9FcXBNd252aGVySmNMMzVuaGZOTE51eWJsMWtScjZFQXBV?=
 =?utf-8?B?cEkrWWhLcjZZTzR2NHBjK2xtVkJLUkd2VnpTekdqQitiWXdIWTdYRFMzQm9O?=
 =?utf-8?B?blloa2pWUWRBZ1gyd1NoV0xyUzFXcHQxRURZV1M0M3pkYWp2L2RYNFdMT2xq?=
 =?utf-8?B?U09qWFc1cit4UUxqWm81MkhQaGlOU3lBMGExUnRFTHdFMy9uUlZLY3RRZjZW?=
 =?utf-8?B?djVRQmd4U2tMWnp1NUtqVTZsVlY5Q0lFVTRrT1J2VWtSNVdQREtRWjRtdVBr?=
 =?utf-8?B?cThoZVArb0w2aHhxVmcyY2duak1KTW9WVkdLK05za3RyTk9nSzlyMmRSR0t6?=
 =?utf-8?B?ejVtNDZlaVRBNHNnWDhDOGdsNEszNGIvZDJ5bE1vNjlLaldtYUYvV3ZMTENG?=
 =?utf-8?B?RmV6RVpQQUU3TWpnLzh2MmpTbUYwMFhMaGkzMWZyM2lYR2x5Skk4ZmxCcmxO?=
 =?utf-8?B?cmNCblJjL1dYbkJmSCtLR0Vsd0VmSzhmTWNMVGZMVzlaV0FVZ1YxZVpOb3Rv?=
 =?utf-8?B?Q3ZyYytiem5hcEEvNnJFdTNwRGxEM0hoV1lGVmpDZGZNS0tMRTN4UmcvOUFz?=
 =?utf-8?B?UHQ3UUhJRGtjcXpxSjRBN3A0eGt6UDFvenUwbk5kUmhQUk0zcExaWTVpU2pm?=
 =?utf-8?B?VTgxYVBwWDdWeFJ4L2szMmNwTUdGNWxhalp0Skd3dGRlaStCaEJzZDd5NmFN?=
 =?utf-8?B?enAwMWZwS3paTENiZmw2TGZTbzRpd3FxTCtuVE55c0NkT1BlSWQzK3AxTEdO?=
 =?utf-8?B?TENBeC9HTVF5SUR3a3RScjAwSGtUOUUva0U4aG9UUndHTlRzRHJUR3RHMUhl?=
 =?utf-8?B?VVdpdUM2b0hrbU4wQnBwLyszbVJJelUwMVJPWjlSZHVlaFZVSWMzQ0Q2cGtM?=
 =?utf-8?B?Q2tOTFVWd0ZBNUZNUHlId2pvczl0NXNCUkdmWDNocCs5TlJNNFloTEJZZG5j?=
 =?utf-8?Q?Ho8+CrujAL8fu1EOa/9P5d/Bl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251298ff-5de7-4960-2ff5-08db89cf70af
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:04.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaILFn6eWtfhLoaQNiFFPimwnJpDkxzmQwFeY95M72/kvVNlMg30+EDAdO2nqaK2gxIVpSLc89Kz1oDPN+C3kQ==
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
 drivers/thermal/broadcom/brcmstb_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 72d1dbe60b8f..ea37e7ee688a 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -349,14 +349,12 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						brcmstb_tmon_irq_thread,
-						IRQF_ONESHOT,
-						DRV_NAME, priv);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+						      brcmstb_tmon_irq_thread,
+						      IRQF_ONESHOT,
+						      DRV_NAME, priv, NULL);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.39.0

