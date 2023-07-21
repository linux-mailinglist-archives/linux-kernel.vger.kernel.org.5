Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C585675C398
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGUJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGUJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:49:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30FB3C15;
        Fri, 21 Jul 2023 02:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2Bu2rAg8A/6NkmmK9oioxIYDuaiRclYMdhO4opH+NweLRn65QlEcVkrr0dLedcH7b9iVTTgtAcEs2vchZE3TLBBFqEcu8AaEpRM8Ji9y1y34sGIn1jZQkmqyDXFfrTSm3H+nj4BOXTkws8lCnmmtwCKPEI5pvAHJhpcJDIm/HZ2BBnDbRw9nGdQ3n1H9GkN3WRmoE0daxjgFZdR+vD1tHw3+OcndLUc1FUSX7lGjG9tlADtwcri3d40I94OfUEJXDelyzckvQk/fUs542eaJUp2rHnakDww5pGCYLFyUyQCTW9Mm65D5GKBAuS+2Rk8ae92uIkVql9rPjHgshRnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izFgSNRGswVrvbWqupaMcttliD0G0cUdm7n6fKfxdI8=;
 b=ND5iQn/zWgbaLBRfWYdwaIVt9yVZIvCqjCcc3yOfKh8DwMHk8dp64ImRWiNTy3uB1+0x1A4i3fGAjM2SDBkD/3hoFxeLQmFGiLNw35er2oEvWipyOwaVzR7+tPPdICBNTnX6lZ88SJ1+/+4gpm3WpM7w63FuNjKKaUiOI7CZjf7Gy2LOhlF8HvstLoq3hCS70NVac2u/5kFYS+TKw65wmmqwWuh+BPNC4FgwZN9X/XUhzNj/MUsDqSMjlXN+sRHgSQ7MxHhphTn7z9odeByPYBU4d7tWgTqjUMyET13qe+jNz7+9m3+WmgPr+Q1yOTC0hJFkFIQAcZaa4dC+DqMZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izFgSNRGswVrvbWqupaMcttliD0G0cUdm7n6fKfxdI8=;
 b=K6dNsgHZpXs6I4Z4Pgto0mACUwSiRC7eLCZgLc5JR6J6BPOxGZpluVePxi61HVcQG9yYEXadFNEFnSnf/SjqRvfzSnOlOztS1G37UEzi0r+wGrnA7XlRfoCDSi/YKSniwM+0otsYcx5z1qaC4ZIKz1Gii8D9zglSf7Tiodbu0Hb2xU8woSzH0exjVvy0MxxLkSo5LXtHJekMRVMBQ0JxBb1skR5qpCrNahnbGKWvXRcltCFSPCB8mJZpVeQzOXiEsRjCOcuS0AKzVJKMuTTOcSb352fUVKEWdCMNqgZbmAVxzTJ4Cr4KNV3qGlUCyxoPy0NGb6atCUB21zv+a697yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/22] thermal/drivers/exynos: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:30 +0800
Message-Id: <20230721094641.77189-11-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0357db02-0714-443d-f01a-08db89cf7b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emk92A8G4Bu7gMFUnbodr9nLJUxYzuUwkYSvPoVRUKZRVSUrF7RFdvZg8w4VWtU9malvJcGTc+ept5A63CmlN7yA+9WxgptNquq9B0gEKfXsk0/usS6Wkr6ND9aQXCi1l0suMzQEbuXNsZ2OARQzTApcr+SmDBA1WRkb//kv90u1IYyow3S680DuiaG4jWPY56B2fyHG0bmAoeWUQIlgKOpUxgFH5lsJuUjctNascUnptddBVXvjQ7mi6o9qq4d/tzEqXvijCqcm0H8a+IfPxMY6h4t0v1Bj/A1PeqBRqmSwk2qX7YZ47LretDO7m4lXR8O/URiFgjRj0m+fhqkIjW++iozjIORjF4ChIjUWt1/3GO6GYBP0KFjNDUhcx9RRp6WquHaci7WgPPtvg+tMVLqRSSR5Nub8hgr8x5Mor9vkpc0vhgHCZhPULdage/UO2dr7F6NSLCyMeIHmU+V+3J+7z1zpvbxSgh5BMSTPEt9ITnlS4pA1uccBROC+UD2iNMnZ6015WfjAo+ij2G167rb9kSUC1bDpsTnyuca3OIUAIeH4qV3czn3pvSpUmrpv6F1xaz2q64F9FM7cnEyVMTj6UmqhkAnt/gHUKaZhtcjO8mQwW652Vq2LlyQ2+Wuc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JFUThxNjF4VlBwNVBmTkR1VlNDbnlMc2MvbHlxMzFDYmZuc2hIdXE1OXNx?=
 =?utf-8?B?a0JUK3FvbkF3cUpaLzdlcTdRdmdWVGpEV1habWprSDBud2VqQVcyUHhUOE1I?=
 =?utf-8?B?RkVWaHhCNUFDQmNZaTBWL2VWWTVhdGtyYjNMUlZNOEZEZDY3MmdISXV2TTcv?=
 =?utf-8?B?LzRKMzlBWktqVkkyc1EvUGM2cnVJNFBtSFF0eTY3Y3NIWUFIVndjNlM4WDMr?=
 =?utf-8?B?bmtSWXJSdEZ1M0RmNzdSNkNWWGFSOW1IL0l4YVlnd2lJR1IzeGhISFMrTkRK?=
 =?utf-8?B?QjBRNmpVM1hKZVZSQnlrWHV0YUVweUZ1eXhWYnVGV0dteFFScUZLVHNTRFZH?=
 =?utf-8?B?Tzc5OHZYTFFLTkM3MXNFTjh2YXRzKy9hTEdKQkpyM1JxTFdaMVRmZjlPTll1?=
 =?utf-8?B?cTdHVlVqc015MUVSQTIyNmQvNitHaVFwdmwyQm04dExJN1JlUFh4QXZmM0dw?=
 =?utf-8?B?RnZVVkJzdExuWml5QlZSVlZSRUJrVW9wWkZuZUZiM3NUdTFPYjkzcG44T1pJ?=
 =?utf-8?B?dXo4NDBIbTUvVTQ3d29XaHBUZktMaG9DSjJXYVQ4TVArWWY5dC9rK0puYWpI?=
 =?utf-8?B?Z2pWTGRTcUx0bkFYaTJoNzB1NGdqZmpCVDQ1YUg2VFNRdkYybVptc2taekUy?=
 =?utf-8?B?NjZiSFpkYVFCTHZ2YndQZkNTQU1XR3NTQ3BVcHJkTm14Y0ZKREM1QXUwZTRT?=
 =?utf-8?B?VjRVNVkvM1ZNMXU2dG9wWWhuMTlML1pjUkJMVUtJbmtxKzVad2tzNmloTjRD?=
 =?utf-8?B?RHAyUDA0aUtSbEdVV0hhNndWV1REOXNWOHdYQVY1Z25qVG0xaEhzbWZFbXhI?=
 =?utf-8?B?VUlScnVGZmYzWkFrNUgzWVFuUmZCY0Q5dml4K2Z3akNucUZGOGFuTVduOU5W?=
 =?utf-8?B?NXlIOExyV054NTdBQTNJQnNuWGwwNC9wMWxYd3MwT3hXUUZYZFJRSURJSEta?=
 =?utf-8?B?ZTFkZ2Y3dGtPTzcxbGxObDRpREZTaU5PenpwQVIxNCtOUkpWRjlTaHZWdHR1?=
 =?utf-8?B?emNXU3FiUWN1UHJ2Z2JNeVZULzl6Um1EdmhCSUFIRG4yM3oxQXFHSHB5NUpt?=
 =?utf-8?B?dGxidGpXOTFidTMrUkpsaURock9JZzlUL0RmeVJHSmgrYjZBMlJNMzFmMjR5?=
 =?utf-8?B?ZWM0NFBWbGhHNm1XU01iZ0h6VUlCSFNpY1J4WkozR1VqenNiRlZKdjJ6VmJV?=
 =?utf-8?B?TmpuSERDbS9lTG5CYmRqUFA4bDJ0VUVtajVlTVJGenFLQzJENG5CZHc1RWt4?=
 =?utf-8?B?Q1RLdWYwbC9BSmhvT254WG81OHJ3Q1MvblFCUDhicVgraGdYL3JpdjN4eE1E?=
 =?utf-8?B?V2JqeFhuc2NLV3V5bTdabVF0aWZEOGNhdU4vcHZwSk0va2NZaXBYMkZtMVk5?=
 =?utf-8?B?TThnVHNOWStVNkx2TUtqQ0NqemZjcWpKM0UvWW5MbWFBMHJ0QUdQOHpmMHA5?=
 =?utf-8?B?bkZ5N0JYNXdiN1BIT21FcGxHeXkyM2VlazdBWVAwS3ByWm43WXlpdlVCSldN?=
 =?utf-8?B?dW8vd0dmYVBEUVIrbFVEaHF4SHBnY2laaENFU0hWUm5pTEpoUkM1UWt1c0d6?=
 =?utf-8?B?d1VMZnBjVUo1TFN6UmNhTUc4V2J1d3hwWVZ1UHVPYTk1T2p5dUZhcjNYcGxI?=
 =?utf-8?B?aGZlY3dTSjNGZ0VGcXJ5dG9Sa3FCUTlBZ1RENTdyVEd0YzZ0ZTVKckVTY2Mx?=
 =?utf-8?B?cVlTN2grK3pGUVAwVTc0UmVGb0M4SU44Z1NyZnRWRzVuVXRMVHViMTZQZFJV?=
 =?utf-8?B?R0pTR1BYbHkyMWZ2WDRvK3QrZlNBT0I5T05MK0hLUnJZZjVHVmV5MlhVZ0Iz?=
 =?utf-8?B?QU9RSVZDMDF0R1lPVFEwVGlUaEtJWXBFVjByUEM1bno4K3hXOVd4TXdTSFBN?=
 =?utf-8?B?VG05UXk0RGJEdERUcVQxVXJOc3gwN2JIRmUwV1hUbDg2TmtEWkszZWI2SXVl?=
 =?utf-8?B?dkFpQVJqVHJqYkFjL0pHUXpudGZjaW1lVExSR1lLRVZLZ0RlRFZVS29QUEFS?=
 =?utf-8?B?UUNrQ09hUWJtQU5GaHBnR2k0QmNhaTZpYW5jVG8rR1NMVWV4a243dW9JQURL?=
 =?utf-8?B?TjY1QXZLWFluWEJwc09SaTVNQU9ZSUJJa1IwT1ZJTUN0THFTWjJqMXozOTFS?=
 =?utf-8?Q?5s8UZTiT03c79R8FBMDKFEre4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0357db02-0714-443d-f01a-08db89cf7b79
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:22.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EVO4XBOLeE6hIhifWu7A/5dRljc5ycb2D+y3S65tEwJfgHbAjtkuZ+Kskou6Pv4lbiYeUo8SBO+S753utvyBg==
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 45e5c840d130..697d2fbdb1bf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1100,12 +1100,11 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
-		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
+	ret = devm_request_irq_probe(&pdev->dev, data->irq, exynos_tmu_irq,
+				     IRQF_TRIGGER_RISING | IRQF_SHARED,
+				     dev_name(&pdev->dev), data, NULL);
+	if (ret)
 		goto err_sclk;
-	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
-- 
2.39.0

