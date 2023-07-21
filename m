Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E2575C370
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGUJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjGUJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E030C7;
        Fri, 21 Jul 2023 02:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2eNIq/WnazaKQTWORgJO/oL1lSpSx2MFwpQAo9l65CzMaNqeW/ASQBvC1VmU1UqUD1xGgJjWf5KZ3I6cvJRg9NzRg6V7vj25Tzn78ZfSBW/2ozUYNXgzfT4+WFnUwtZtL/gHmmfpuBozkSFaOvYhrEvDPXYn0YLt0jeCO1Qot1KE/jrmO6GSPW7IjOxwn8sAXvzlOvTMXoiD/vXox8ybA0z6xCJk+TukGCgjiXDkj2a6f3r2wxPLRkGOXv9FKvqXwg33BkNLOzRvQ1rPj4M4X1XBtHRUX6WWzI04SXFSANYlDWUokgHLGGjtu/9oYlcvFx9s1kK49ZzIkaCG6ujaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEGCtasWCOSsSknQ0GZz9Yd5JlWw//E0x5dPjE1KYLQ=;
 b=VPS+cy1up6OuFUufLm1kbZcGcWk5jNiIrrT3Q2ucD4LbpxqV8m4pSwxBDa7EhbhF9zmwqPTVK8jYqrt1KiFjf71yn13A55zMOn6Kt80bszEtHbRZTtKQs6Tcll/g5fqaOTtcEDPIecY0knAfkd8T2S0YyCFs1/m/hfs6oodzp5aUna1CCM6y+NG3TkwDUhPfTSJBo208idz7yzMuMU2TrKHIjyp5rVbC3r3J7Rn47VsF1nglQuGSIaEAsvXCrm3XfbyLcUrQ6U5/kSZeuD5HA01Jc+kJzzqtU77Mq++9jwTAascsFZ6YZOR05mQizrssQHKsshZB3tH6M0czKQ0iNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEGCtasWCOSsSknQ0GZz9Yd5JlWw//E0x5dPjE1KYLQ=;
 b=fx4kYkOZifPa/0KlMBxDl7LwrtimndrdTnyiS8ZtcIF5wk0kxVUDJVCrWTt3QHCucbVjsGXwNSaBOa80OK4SBoqS9EybEFT23Dagn/ZMC7Mnyb1MkYyBVo47vo65SQ0Nf0NJfgBl12u2FZ8bMc3ZT0C+8iCqtpeIL+RM4IZV1+pAFKEMKduUOOCsVZfKQFPqCvgDxFGAtlXQMFxxpxJ5C60ill9GX8H1DccTlkCFdTrTV+DGCS2IvMJ9Xytj6lg7XsZXXa81WB+Gvij0c1ZzbTpoimB9wlqynisDfaUu+QmU2+L83N30XT8fiEYE4RgPCfKhZMSjkobUaMcbyTwigA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:10 +0000
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
Subject: [PATCH v5 06/22] thermal/drivers/qcom/lmh: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:25 +0800
Message-Id: <20230721094641.77189-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c826e84-7bc9-4cb9-1992-08db89cf740e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnMlm9bGtj/jWhIWppXFpAYUjCvwFErB2VVBRYGpvizB/QDSW7KCJVq3bf1lyMexkdpxr7Bcbq3crRWn/wc6BUxjFdkZBMPExb84Lm+Awoz11AcVxUb72STe1N4Lgf/XtcgjT4TJ4uB7vZ/duw96cKYPdWNPoriBXbO5mxwkzScUsKl0lpZhtwOzmQihLpdQqujN12Ae3FvyjA7q5xoTHroEHs1Xk5NbLLNPDpmq7VDHDxdKbNO7B3JFCUHnl7ixiMynEgNDiKmVDzGiT0jRlI8okXkqNagRDlFnRgkHhJkwzSK2wC/kgAMyiQwANtWyY9BAti0D8m5c0SKJQ1dStUGxrpkSgKedW1Pq8+di4Lv2xzyyRw2eyLjKol+WeiwvJe6TXRjo4ljC+4iAcC5C+pV1QlqYm8G0ZZdJeIPSKdI1gDk5U538AMskqzaokML47wflAF2LCR5gZnTm47j8MLRAa2Unnl06Oexm8+r6u8WbTnPuYkwvbsQ9kdmK1QDoAO+zi1ikc0y8s5B8C6F3UAcZT8HhRy21AdFyOr+DH1DmUs3BZgPbiBuW1nt/2Ts83W3aXuM0Q/qXR7LvM5BEEFnGkMob+ZEs8X4JFze1UC7wQmZc47vieZZDuhq7829F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5LRXIzOXVOMld2NEpaSGV6UCtENThTVnhHRWIwdDI3MWl5OU9vU0c1SEYy?=
 =?utf-8?B?UzRvSVliZTBOdkY0dDYwYTBrTEhsRTZCbnN4bTdXUU1rNDFUM1VVYVVsaEs2?=
 =?utf-8?B?Y0lnYlZGdU43WEZWVW1tQzg3enJ6cUVQQ0tEODhRYkY2U3dYaGR0bU5LTHFs?=
 =?utf-8?B?VUNsSENyZzRnTkE3a0JTNXQxTEViMmtjQ1NLUHdJZGVseHU0bVZPblJ5ZWM0?=
 =?utf-8?B?Q3FKdDBOU3kzSTFoVVMvYTd3aVNNK0txdXFNSzdjZjR3K1liVGZFYnRZcE1k?=
 =?utf-8?B?WkFwL3B2QW8vUW9OSlp5OG1LVFFueVo0dHR6YnppS1ZlckZ5UzlDS1lZZDdD?=
 =?utf-8?B?L0k2SUtubksvcG9sVkEyY29wbFdocjRxeUxFUnUvd0tpdDRYYlBhRGZNTlJi?=
 =?utf-8?B?WTJEd2JxYVJKKytibDFUS05OTEtyaW8wY3ZTRmszWmdOLzcvbnU1aXRxMnY1?=
 =?utf-8?B?Wkd3NkczbmZDTytGYjJ6NmhiQTJLbjZTRkU4Ukg2NERseXFLeFJySGdKMEFj?=
 =?utf-8?B?RGtpTlVGTXFTQ2owaXNMY1BTNVUzVzR3QmtEM2VaZ213SWZVY3dlZWNkTHV3?=
 =?utf-8?B?YWdYT3JNeUl5WDhQVFIxWUxxUXdmbXF6TUlVT3BnaERtdmZMTDgxY0dOMTdM?=
 =?utf-8?B?YlVMM1hIb2Rvanh0NGlMUEpkZ29uVmI2cVEzNnlza0FVWWh0cUdzY2U5bG1k?=
 =?utf-8?B?Z21qelRvQVorRjhvMGtOUWVoaVZmMzhqVFJvU0thRzlmWGVnVlNqZUs1TzhU?=
 =?utf-8?B?WnpoTUdsdEJ0bXpXWUJ0MW5EVW85eEZsM2t6aUd1akZZQVY4RGtIWnA3NUZw?=
 =?utf-8?B?SGZUODdkSkd6SlMvMHgybUY4aEs4aFU0NzZjVlZKdGo2NVo4NTN2b1Y1TFQ1?=
 =?utf-8?B?UU96MXZZZUJjY1g0SmxvR3dPODNLSEc2ckNzMklSdHVkNEdGSjdrZ1pJTWVx?=
 =?utf-8?B?bmRSOVhiZktnM28vQXBrbEJqaUlDZ1VkZzBRWWtCSVJBcnY0ckRzaDlqS0Jx?=
 =?utf-8?B?MWp0eFk0amFCOXV2Mnd6TW9mNy9LeUdFK3ljOVY2Nmhza1RUa01RTVFGN3Ju?=
 =?utf-8?B?eEs1Ukt6OVM4ZUZVdDd1ak5WVWNYTG9VdzliMmNPM3RtVzlMVUtHM1lFM0ZV?=
 =?utf-8?B?eTZvUDhlR21mTmwvckxJaE8rTy9LYmdheTZ1ZFN2TUgxK0tLWEJTZUhPZ2c4?=
 =?utf-8?B?VzViekF4Rm12RW5UQkRSazUzeE1wZ2svR0lDMi9IdEcyb25FU3Fqc2xxUzBU?=
 =?utf-8?B?eTIvUGdtZUZRaHI3Z3V5Qk1oYVlBb2ZxRVdHeHNpZzAxRk5xMitzNGxnejFw?=
 =?utf-8?B?Um5TOENQa1JwWkJXZEZJVEdidy9QcFlEMzdrcjRMRng1S0d4MFE5L25qdDZv?=
 =?utf-8?B?Qlg5ZituWjlZc01jVi9IZ0NsMlZuNStGblF1RmFSbGhMRVhGeGo2NU1ibjlo?=
 =?utf-8?B?UUNXUE9GU3VBR2oraXBIbmxzR3BocHg5OHJnalhCb2swaW04MkNtVVZJKysz?=
 =?utf-8?B?b1I1Q0VNeGd5bnN5NGU3Mk4vUDBiallEb0RxNndxaUJOWlgvRGswZ2Q2Ym5S?=
 =?utf-8?B?U2dFWkYxU2V1RHpMR0Qwa1Jha1B6SlhGMFh5MjdmNENlNnkxdENFSnd6TUhs?=
 =?utf-8?B?Vk5Gcktxc1R2UzJCOUZMZ2JhRzFTUkdub3VhQ0JOREZQWk5xNDJnc1hMNmtY?=
 =?utf-8?B?aUxhdkpiSEVhM0w4MzY0TGFEakdUMWI5RDVJKyt5dUJnZHFiQTFHUjVHMzY5?=
 =?utf-8?B?eDQrS1JIZWFJNTVmKzFZMkVjc2tMbVhMTkRrQXUvYlEyZlQwOGJ1ZHdsVmxL?=
 =?utf-8?B?RVpTUzNCZCtoQUxJQnh1NVdXSFM0Vkp6VU11QzRTZHFiYUFvUjQzdG90R2Z5?=
 =?utf-8?B?SmpCclpjSktMKzl4V3VxaFp5eVJocnRndlNZdzN6c3prMjB2bktJSytoNEpl?=
 =?utf-8?B?VmpBeXRXNlQ4cUNsTHBjS2dxeklMWUNNN2ZxRnNkd1JJWTd6MTE1NUliL1hR?=
 =?utf-8?B?M25tNzhnUnhRbysycm9DMERLMVdNMHJWTGhnRWR5NmVrQXYwRUVtbVZEZU5z?=
 =?utf-8?B?T20wL3FLaXlVeVc2dDhOK2ttYWxsR3ZGcjcxVkl3dDZ5bHFTYWphMGpuU0Vr?=
 =?utf-8?Q?g4eNrVEugksogTuGBDxIs35KQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c826e84-7bc9-4cb9-1992-08db89cf740e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:10.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rueYrhLiUgrUucvyzkb4TPktGJja1cwq8WVjB2LGMxeNlOuVn4nePFmOfhFz1dBZ5OFc/DifCkArw8nu8UmcQQ==
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index f6edb12ec004..48a14d7e8bf5 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -207,11 +207,10 @@ static int lmh_probe(struct platform_device *pdev)
 
 	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
 	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
-			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
-			       "lmh-irq", lmh_data);
+	ret = devm_request_irq_probe(dev, lmh_data->irq, lmh_handle_irq,
+				     IRQF_ONESHOT | IRQF_NO_SUSPEND,
+				     "lmh-irq", lmh_data, NULL);
 	if (ret) {
-		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
 		irq_domain_remove(lmh_data->domain);
 		return ret;
 	}
-- 
2.39.0

