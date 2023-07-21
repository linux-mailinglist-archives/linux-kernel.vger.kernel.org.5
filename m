Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60B75C37A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjGUJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGUJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:48:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E3D3C03;
        Fri, 21 Jul 2023 02:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY1qTVsoJH2z6vvm5lUuy9OS/o4MZCin4OsdqiraRmSWX304TK3DCOJpeR0bGH3U3rIwvYHfvJ6VdiC5j6hwlvrXOv7sz/mwjxwoL9QaYcM5G3Klv3YMI93Mq/HYqWspPHcgCQCWx+xMYBPLoyXyfpHLmb1gWN5KFtNEqFXDT5i7T0QcRxqiiXjfEOi4IRPPncXApai65kfodCRZbhSuet1ssp1OfZ0T96Yh6R175zMs3F8TqPHcJLiAOZmuOMGxenRS0IOaakp4KHdPCkgyDgA6JReatfhDUzO32b6y1permb1oRNRTSHUY/y4dWsJ2RA+T07BViZwSMm19DsLkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGhadKGMb1A6nuEIHOjE9NtutBhspKIwNkhmP0V70x4=;
 b=bcfrIHxU2PTogKS/KzUziprUHMBbDxktaiR8rOQ6ifSk0q/lRRxul9+dvCQYmL1kRSLnBmcGUeOsdHX3gOpAF5mEUzz1sBFvhqxgf9jFKNPJ2Ns6UW/fqp4cni4h9L8zZbbnpmiT3YYc4P9u02ItUJdyWwvrKuBe2WXmhSULcAwSbaVyrYBk6miFCg7/XaEoGrsy+J72QekVDw3QN7nBTql15iIT5R36B/WfiynkC0HWwZimj0D3o/YOZu5BGfldEn7+18xRLHlW0qwJ3Do95B0Rc0eTqtND4s6gPrm1ThSVURWlYTkFpzBScPnM4f0uMdTMR0pX7liVG/ycx0UgpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGhadKGMb1A6nuEIHOjE9NtutBhspKIwNkhmP0V70x4=;
 b=X+sBCMev+79DSn634Jp7QAcdTitTxF6/mepxBjbpaLw72W1f2U9FtTGz46ltkuy2yun1iuIVZgzhNEmMSOWpPG0Xhc3OZ1qqv1Ckh2mGBDMMz4QBB7ofTAYWARY1RXWrZd2UJpTuurEycQu5WHhfl+JwQergT42h91J48lrXALf0RucKUsqpGFsbgbP4v4NctgGiyifSJxjcff2LTuHXODh6abmdGQxpW2unuVJ980Ct731yg0uWCwTCmRDZ0oIpYgL3tRJ+4MCTsUV2ZGDQlN/wox4oKm0bbrRNGsMbEbsVzuB+vYQT/PA8jD+9yKai9IhQ2imWFGvXQSIZXdSeAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:17 +0000
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
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/22] thermal/drivers/qcom/temp-alarm: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:28 +0800
Message-Id: <20230721094641.77189-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: abdbf403-d44c-4de4-ad67-08db89cf7888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByFKIY58ETlxR62LHxf/7uxPL6Mhmt2eMYkXod9unv1x8txr9IUN1SnFUNUDRC7IRvjbgbM0qRmIMmTZzTzfIZDOQg81O9lq3qWZZ1FKGLdkHNp/1iJ6PDLT6QxKAWWk6EI8sqAcg+PMDX53kchfsTScqsa+dN3N0f892N3cjxr6pxDF9NgFLCPh9Koxmb66AWrXY+IrGzrnQVU7tm8SQAgINX5OCdnq+044cRbghVPbS+EYxNIuGxKSKiYblMUrrY+x96UWsdoaUaQT+FIvNnNnYSKC735XGHRq07au/boYLtQoed9N7dyLWYRWSYyeTbA/DibBeqBHVxxf8x+Jcvdfd0t0F0x5eq6HLEsHYuzeNngl6mPT1epHA5U+6a2wurgN1qzwsi+KqRYYhuK1649vvS2QSEYsXuxvL+0lB9TbwyH7kH9IZSDqbENhsIrow4CWJxHB4VZB2D4MbxvEfhXaqrdVbqw7ODmu2sZQTneO2LiDGe5u2iiIWRyy6gcIIKWooVNLSo1/iYqLzNDzhAce6XNQLcE0VzPp4Tx69aC8bKg69/PfPsfQBFqI47jKg4zB+s1agvGL/f2qhQFP4eTD9BcS9n3Xc0OC8aWZIcQC2ygB7lMWa9dcpnMhlhdp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUYxajc0aE4wN3FzMFlsUmNYMjU0OUViSXhIbmg1QjhyMHNZN3pyRXJtRlBp?=
 =?utf-8?B?OGtpcFJVVkwyQUw2T0hMcmtYQmc1eEVjMjYyNjN1MVR5clhPd2lVaElGeGhy?=
 =?utf-8?B?emNkTXkydm5MZDBoVUI5dGpmbmZnV0hSRi95SlJGNi8xV0pxeWtNSTlQclps?=
 =?utf-8?B?eHpOT3V4UWtNdExQRXUzM0pYMWV4eFVFUExBRk9iVXg3MkQxMFFsRW8wYkc5?=
 =?utf-8?B?ZnVBY0Q4WUs3amc5ZmRvUFdvNTNERm4xUVQ2NjhocG9TWjdqUUdkOXpEN01k?=
 =?utf-8?B?V0xnTS9xOWRpTTZ2ZzJxajR1eUNNN08wcGt0enVPOXhUR1pJUU9jVG1SOC9h?=
 =?utf-8?B?Nk5xQjVTUFZseTZsZmRtS0dIYjJGTVN4L2xTa05BdlhBNlVzbmlLV2JQUnNp?=
 =?utf-8?B?UnNyQlVWWWNQSHZ4TGNnU1JvdlA4bUN5Nkx2dnZiMmhDYllpazRpSXdsSDBq?=
 =?utf-8?B?aGl4Vlg0ZGRnZjNFeWlPYkFIUWhCSE51ckRnZ2l1bXNMNDhVU29rTlVNTkpj?=
 =?utf-8?B?ME1kaStsTzR3T1F4RzNtNVN5RVNsOFlWbkZ0eXAzOXcxVXkwdlFzbVNvQTVZ?=
 =?utf-8?B?bnJNQVpEVG01eWFXUDJ5UHgyVkZMTy82SWVUMGFqRFpZZmIyRndncnhIOGZM?=
 =?utf-8?B?UXdPYlhXN3ovU2NpVmJnUVRhUEp4cG9abTdNUkplZHFsRnM0emZtWjluVnQ3?=
 =?utf-8?B?NmE5NUFGL0RNMlVXZ0dDSmZPdGpoVWFOVkttMTJIV3JyU1FmK0pwendJZHg2?=
 =?utf-8?B?VkVERWUybzNidzM4R3o4czdWSEFkV3VhaEU5eUNna3pNSXlLMkRvY3R3VW5G?=
 =?utf-8?B?cUhjMkliSmRCQU1Ed00vQ1cwUGZOK2lLYUp0Wml6dzErRUhlMVZxdEowYU45?=
 =?utf-8?B?QVVYdGRrSURmY2xHazQzMGVZVjJHSGFXb2diZHVqaFBDZVFlZnFHUkZVSGFB?=
 =?utf-8?B?VEVIR2dOVE9uT3dlNFRsNmJoK1A4R3c3WjNvM3pOMm0rMkFDUmZrUmRIRTNG?=
 =?utf-8?B?SVJGejkxR2VrYWJXd0luNHFDSmlnMzg2Vld0RTZoQlRaOU9TQ0x6OHp1SzRR?=
 =?utf-8?B?QlZ1RS9aSGx2M0hGa1UyZVpNRnc5Wmk2OXdYWnZRejVnbXFMSnFmTDdxL25T?=
 =?utf-8?B?MlI4b2xJQ0RPSlVZN0ZoelFLcDgrbTk3b3dIZS9xYXg5YVpaRHgzeDIzZkp4?=
 =?utf-8?B?N3RrOGQrRHo2cmd5Tm8weHh1b2tTejAvWlRqb3V6NHVISDdQUXRwdjZwQVhG?=
 =?utf-8?B?ZU1DSGh2bXJLZEY5TDhTYzAwcXJkZ2tPTVhMcGVrSXZxOUg0QnFhN282QTEv?=
 =?utf-8?B?OWtTT2VJNjQ2VEhrTXF6ZXpYVmwzSTNiYUszWmFrem15cnVmUGV0b2Q1aTlH?=
 =?utf-8?B?bHZubmxDL28vV1p1K3NIaW1nNGVIUGMzdisrQWtMUGh5U2lsSEx3d1hJRlhW?=
 =?utf-8?B?U3gvU2E0RFQ0Z1c3bW56NzNyOFYrbjFZOURqNWFsdGtIc0hhSExrSXBkOUtr?=
 =?utf-8?B?dkVmc3g1LzB3WjYwZDFkRGFtQ1hMQjJzMHNsRk8vWlh1cC9zMlhVaWg0TjdE?=
 =?utf-8?B?Zy8rNFBWYkk0dTBEVVFGU0FXMGxtcC9qSFQzR0MzdUlhYXRoQ3FIRXp1T01v?=
 =?utf-8?B?MUVoL282YldQTjB0dVdkenh6MXh6V3h0emEvU2JRL212YktFZ2xORW0rRUdr?=
 =?utf-8?B?cVVFT3cwMUUzUWk5RWNEUWFvM2dnM2xHaWQ3QldCT0o4MVVuejdaWFA1d3BR?=
 =?utf-8?B?SUhTZWlBL1ZNQzBjK21UZ0RYNG42SEZTUHFoWVdzVmcrVU1YVEJ4QmxzeDdj?=
 =?utf-8?B?LzJBSVdCVGVDZjFrcjhtNlRZai80VUQxaWZqVldrRFB4R3RRYkJZWXR0aTdk?=
 =?utf-8?B?cUkxY1UvM3ZOL1pELy84WEZacFJaR21BalB5NGhUZ2QyS0YvbVEwS05WUFB6?=
 =?utf-8?B?RWpZcGJIWGJqUXJOR1dQZ0cvdDZaWjRDY1FBL1pNWVgvbVVCUUYxVzZFbXBJ?=
 =?utf-8?B?alFhbStBNkx6ejBsNlBkdFRyREo3VVV6aUMwV3hIMXhrQWNWUklIUjhuc2Vk?=
 =?utf-8?B?dnlGKzBSTytwNnZaUnRJOG9wL2pja1hBTnR2UWtHMnJJMXY5L0pGTjIzY014?=
 =?utf-8?Q?qJiVYbgFj8nXAvDJFevg9tg5l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdbf403-d44c-4de4-ad67-08db89cf7888
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:17.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++9dHGbQ94Ijt/IFm8e0+JlgYXnRFbTGg/Eoyv1hXlMSTloCqdJTpXQFf90A6lJCKV6LoNPPCZKL+JwDkJWazQ==
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
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 0e8ebfcd84c5..1b4a7eca181e 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -455,8 +455,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev);
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
-					IRQF_ONESHOT, node->name, chip);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL, qpnp_tm_isr,
+					      IRQF_ONESHOT, node->name, chip, NULL);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.0

