Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3BC764777
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjG0HB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjG0HBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866091FCF;
        Thu, 27 Jul 2023 00:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbzSfAyL/esAQASL7Bu02p03BN93Y17xGgwu8X9JxnT6Ezet3Y1sMtgr5Cteia23TdZq2E/jG+LLCMG0WfuiNX8Rv0rBEp8iTgiOYhcVAjA/aRXpMIfMOztAvlb/dPT6FxRPUp9iK1Qbw+qsHc4BKYTbPcjN3Xzez+cqIlNiz/QBO2iLnvUvC2IeI7vEu+w/52QXTq85JSHc8hrFNmFAOMLMvOgibXErooZbKe79yysF8Snt0Gdi6cgoEQMooboP/e4Es2+mmz7qJ/sojSPUl8sKrrR77gFrZNoLoTqIEjtV8ixspME/RaxNSB8+4MIYi5E7B9qDyug8fbHjiULH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGvwJMjXkY+aIWcQi5FBmNL1QkzER169wqMxqG1gqGg=;
 b=dImUVLP5YKPyIG4kDVV3Co8rhavefJpZtFSZmbr/rrIdnpvQ85OXBh4YGy2OH1i16OuLvcIEIo78IydNn7ITareZTzDvf96E4XcuExLVg4emCmBLmS6MHGwXll8cAZi+6B/YNcmc+w1tDyIbJDTm2BvvwVlBAxDnaWo8S6ui7cW6cqo8pcE+erPz+Cv0r4gr/uGVj3A2NEiOQdzhkxd9gY8IrqQ7OOvQQfkOECpYsTjpVzuSqemQvlTmhp9Q5H58yBXJGyDzi/YqLhW23iX1Lt6WSJOA9TJFwnMicPl2KF3rYTr6da9vL45VZFa2+sLpsP022amT3dnhRy5KR1wyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGvwJMjXkY+aIWcQi5FBmNL1QkzER169wqMxqG1gqGg=;
 b=orMpc7VJ8hxUJ1dEAatFvtGatJLWxHtsEYvHx/WDZS9IBYXVa5CCSjLuoH6lDbjCdNluhgKFmXmyvrVpqI66M2pnDD8WfniqAOl22XMaFoMYUMNZAmzDX+dEaT4f5iKdzaTTnCUU8t20McmXDfnSWzVJSOc7esINWoUGV6xTJw5Q6WGQNNDf5+a7Vkgi/EyUVDN7ZIyKk3MQPUkRiQ5dcrIQFlhEShSwpCuQ/yXExJWuORDFPNTd2aD6//XvSF0amD5j1sAc1sflPAN6o2cRz3QZx0geAxupREtvfeRdZN9/TcHhhNrRuJLFY7qdPWod9545K60A7Q64ztRAN84jSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 05/62] mmc: mtk-sd: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:54 +0800
Message-Id: <20230727070051.17778-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7c6b32-30f9-459d-1563-08db8e6f4258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNIVMUIk94K5b0FrqRVedTmq3dOB9u8iXD3BNfzMG1bzE1wu/kDSKZDqPL5fc0+66x+meyaODuRA2amiN9Zo4KwXMlwgXS1UPJs8sMedDsxID2s6tVPR12cLJaau6OUBz10aRxEX31rsVbZuf90eMbPu0hlakfk9XuzgWcpaH0pfPE03Fvzv2hiH3ERjJtAid8GKHetOOBQuYcJVxBNddb2YrcDmJYSeUcwGtulvlnRAi3wpEwkaVhJHS9YSbSQ+VZLUt4p0Yjmq7OLlDcVzgw+dfKnRi1UPO+OPKKW3tRn5ALxC5PL+meUySZ/Y4L3/orD9l0fXAUPyHYWrywCb05R3p0enGN68h6zcYsq6yWgEwc7+S+xhjR6D1BrdoaQn4zZs5I8158wr3Wptzfp4u9yIJz+2nOdRUkXzDf0ACQb3v7749Daj+9frs9oxRY2s0XoVNImdMmmBMhad2cvSwwmXWceMi8RBqtcc06nfsjkJTYxeEJgo9g6Vjm2ucob6Ui+0hLJB7v+XsZs34oIOIj2a47Er/gOgvg5d2rTPDjdTVirT7/Pp1VgEbTZWyErTTg/Av1ORpPu8ym4ZVtcHTruLU3G+ziFkycl1Y60I+lwV47tNrCG6xt31G5I/HSXO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1UUnFWMksxMmRwRGhQa25mTnhWazFmbXhnTTBicHZjS3hlaVF4UUtVUXZP?=
 =?utf-8?B?TnJSTkdNOExCMjlMb1JOaHZmTWVwWDFiNE11bmtpRXU4OVFROHM1bXhwQy91?=
 =?utf-8?B?UUtKZ2N0R0VBcmI4aks5bzVRUnhwRkhvMHBmK1JWbHNpdVk1Q0wzMW90Tk5Y?=
 =?utf-8?B?dlpCVFlXd0pkUTIwMTZKR3VtWTh6SC9NZEladW5iaW1HcVhEQll1SU5tZllv?=
 =?utf-8?B?cTZVQk4xM2lCQkhPQUZaZVBQY2hKQTZ0djFPMHdhVzJEQllKZDNyeU5xaFZv?=
 =?utf-8?B?MHdsNWdWcEFHckV2TTAzVWRvS2tvOHdRT2V4TjI1VTdHcG5UN1MybytraXdU?=
 =?utf-8?B?bHhYT2xKNlZHdlFYZjBkUzJlcCthTE1kQlBXbGJidzd0TTRyTGNuK3Y0TWUy?=
 =?utf-8?B?OXNtUWljdTVSc0YycWNLeS94RHVHZTVlc0pNcEpLdkxvVklRYVUzaWRlUytG?=
 =?utf-8?B?bEZ4ZWFHN3VRamliUjVOdDg2eHREMHFRRHgzdEpZQ1FjR1UwNzdLNmI5RjRK?=
 =?utf-8?B?alB4czJCWEZWWGgxcEIxZGgxeW1lUDkzcU5MYXFHZWNaMGVRME5pNGF0cGNT?=
 =?utf-8?B?Uzlna3JkdEhPU0NENjBSS1I2NDA0dlhlcjNpUE9jK1dXVHFVcUJhSVpDaENl?=
 =?utf-8?B?anJZV1lYT3JxaHBCZlBrcWFXOEVIMzZ2dXNyQTVtUEgzMU93WnJ5SldxMTlB?=
 =?utf-8?B?ZWJ1a2U2NzRIZEcwaG5MMzVMQURCQSt6ZStNS2xEU0NtNW85Mml5dmZNK1ZM?=
 =?utf-8?B?M3A5NEg3azByY2FqYkRsZVkyV3dHUmVTWTA0YXNMSFFuYTVOYmFTV0c3Tyt6?=
 =?utf-8?B?R3lXSWpqSUZ0RmNjTHRBT2NYMWlIRkJES0tKL2wxWGJTcVk0SlRoOE5SeGdP?=
 =?utf-8?B?WU9MRTlhTEdJZ1FrNmtKbkVSUmhGQy81dHZ5OTFzNDdVWW5PeG1aMy9CRnF0?=
 =?utf-8?B?S3pvSGVlY3M0VHA5MEIxMG9DK3BMWkl6TnFDci9hSzY3YmtZK0JqQmtnVlR2?=
 =?utf-8?B?Z2J1OWpOVXpMNHA3WWw2Ukl3RkdybGMvanorekMxM0NSY21pR1p6TlBKZXhO?=
 =?utf-8?B?Vi8zVFlYN0NTSWFpeFhPSzNsUll2MXB6U1Ria2hZditiaEZ2bUVGcWFjSDkw?=
 =?utf-8?B?bEJTUnBKWTI5N1hWZHkrTlVZbnpsWUpVZmQwRU00b2lpbWd6bnY5aTY5L0Q5?=
 =?utf-8?B?Sm4rME1OTXNBYTRwK1pBdllqTkVvMDFJbExlQTVFNHZ3Zmp1QjZ6bjZibW1H?=
 =?utf-8?B?aUZtUGhwaEdZSDNYY2docDlWZUZhcjk1Qi9ocUFxTzhtLzV5MW90WWh4K1Z0?=
 =?utf-8?B?ZXJNd0Q0dkNRV3RKTjY2Yi9DVE43dU8yWWZiZXpmYmowK2RqNjRzT1d0V2hC?=
 =?utf-8?B?ZXJFbWpNY2FiUktETDlsck5HL3BEV1gyVnBndEc5UXF6bWgzeWd1QmZsLzhC?=
 =?utf-8?B?aXovbjhmdE9vRWNYQmloWWp1UERieTVPRVV3L3FRU0JxUVVtVTZsU2hPSWdv?=
 =?utf-8?B?Q0pPSVViMTVESXh4WVpYZHkrNzVPYXJKQURYblptOS9YQ01qaTdtdXhoRUJP?=
 =?utf-8?B?TjBMZjdLNnZwMmJHOVJjZmgzL3pubUg3eTU4ZmMzbE5haEdobGo0R29QV2lK?=
 =?utf-8?B?aEdhUEszSTJPYVJudnppR05TOW5zNVk1MkJCVVpxMWh5OE83dG02SWlKOHI5?=
 =?utf-8?B?ZGkrSkYrUkwvd2ovZTQwNE5XMmxQMHRaY0tmUEg1SVUxTjhqRU1rUWxkM0lH?=
 =?utf-8?B?aHZ6a2ZyamhKZFlSSmVoY3pIMlUrMjhwcnNzK0wwcWNlcDlCMTVqRXRWMSts?=
 =?utf-8?B?VnhJQXlDdXlHVDEwM1ZRLzZLZ25uOW9ibytZZmthMmtCY1lNUnByUEUwVC95?=
 =?utf-8?B?VGFGcTN0a0FGRzR3MXZRWnNxUjI2RU5SY2FUUnFtMUxaZjNOblBzTUlyWnhM?=
 =?utf-8?B?OXp0SXVwZEZON256S2M1alRUcy9ITDUzRDdKelpVUGxFL21lMDNnZmtTU25k?=
 =?utf-8?B?cndmTUVzUnVSUVVIam42b2dEbkdhWDBzdjRnWkFJSDBDWnVRNHFnN0cweHhT?=
 =?utf-8?B?ZUhNc3VUQllBUW5LTjhYWXArOHNqQi85SFdoK3FKdlhZc28wY0hGbnZxeXgr?=
 =?utf-8?Q?1ZV++nByTQbRAw0EXugj86n0a?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7c6b32-30f9-459d-1563-08db8e6f4258
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:11.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9Zw3WftG5PuUdJFBaOiV9uudrU1iecBJy+55xXogGlX40MLOQudcX9OdR7He3b4wRgbA832u169CtQMq+wWWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 02403ff99e0d..9e2debd1edbe 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2887,7 +2887,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int msdc_drv_remove(struct platform_device *pdev)
+static void msdc_drv_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct msdc_host *host;
@@ -2911,8 +2911,6 @@ static int msdc_drv_remove(struct platform_device *pdev)
 			host->dma.bd, host->dma.bd_addr);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static void msdc_save_reg(struct msdc_host *host)
@@ -3054,7 +3052,7 @@ static const struct dev_pm_ops msdc_dev_pm_ops = {
 
 static struct platform_driver mt_msdc_driver = {
 	.probe = msdc_drv_probe,
-	.remove = msdc_drv_remove,
+	.remove_new = msdc_drv_remove,
 	.driver = {
 		.name = "mtk-msdc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

