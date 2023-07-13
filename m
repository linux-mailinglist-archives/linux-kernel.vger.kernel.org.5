Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7243751B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjGMIOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjGMINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AE92715;
        Thu, 13 Jul 2023 01:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuUM4eQjDrV8h7ZctK8ihKoXoSRQHzXWW4cwDIxFHmHVo0YhIVEWVaKT8XUDKk1pKrcbORCo7k/QMX/vlGIVG526aqFcMZDo89B4238BL8roU0t4J8c3XrYiIJi0oCFyzh+lO6h1W1dt9WxYNRlumuSoXV5GV7uEx9Fg3VuaNX8Bgaf/J3Z45ic0efYIXWzwcAUuPd4xittkHcBDIbb7b0msPjfE3/cf6n4Uqws5+qbWjc1qf2F9fs4TCHLk8XRc3llunhFJTlFa88kk/Mn/BSsK7AxiO3nOXJEwvrQuia414N+hJQ6/OwvY+pX0bk8Uf+BuoouezjboLr45z1feag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZlf3kRbzhOTHqfQQOVUzmVEhE2nBa6PIZr9CzqCeCg=;
 b=N3RtUgfP0koTip9Q53ZHzKLlScuMX9hhqY23eaZbuO/oemXaAJ3GEKxRNrai0HDZuybbRC6nRvEQo9PL3UrcHE6mZUaLvD344yVH5sKQd8VWOEwHRkR82p478czXuKH7RhbA/2hXk4KJex9RuoLbPmFN6iZt99XOmk60lJp8Yx4p5T66aU/d8asufgaFUOUJplIB/b9qWIjtbS8ujwa/2faQAOoDZ7C6S/0ZmF9gDRvuJBACBUmqbmoAD0I1wH97uu5mW7OqtWzV3Hud733Tbnyh3LpJhnl1FomI2kob/9ZWODm6KGvfvh/S8ofU+vHvGi5/1caJwl3z+T0JVEP18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZlf3kRbzhOTHqfQQOVUzmVEhE2nBa6PIZr9CzqCeCg=;
 b=AE1f9sIm6F2clUyjGjrV6RPFOAJbT+ycRhuWv15UsbAjuUf7i+Ozg6gVsGPJHd7Jx9sDnQ+k4Zg63tHchEIJ97HFdwPdwM1i1P/mu/yCVb81HLvGyWGz6VbqzRtx5h+wxiTAC+7Qo3Cx5zl3DR3SRhndMCMiaQ5BUkQ4GQ4joW6yogHZndaSsjJCvPRjOERRf2Rwdx3zm2P5cprmjRAxwmy78SN9a4MfAC2+qNoq5qLSTFYn0onqiCRQ0WHTIsNRNgGn27cRQZPzyPAZmQGPG/jaVRPq5Xa9cRJSxvvaCAUtUK9pbbdofYdixtiOab8dws7g32JsPRbcn2PzFITQWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:09:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 40/58] mmc: sdhci-msm: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:49 +0800
Message-Id: <20230713080807.69999-40-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713080807.69999-1-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 8144fed6-6092-405b-bc2f-08db83787c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2nzhaVighvM5uQT39Xd1qmDspn9lLPmnAyA5iWkknJmXTvAR9jGzT/Fgi1s5euzAAhi4syb4dgx6NvNn2CTOp3HddMC6KPxXfdN6Dz7UppDy8o9MplmSlTQnt/7EZZvamHrcpCmNupYfdBav/kApwRHcM4xKMpJdioidIwPsOvmO7WsmVSjdBfv3iRLde6VSy3Hj/d+4eZYRyuA7tO845ArOpq3UovwRvbQHXm+02GrNY1Gkv691oY0SkQY31OJAg4xqwEU9zX+miQR2e6kP82qFuNAzBs5Gm2mqB/SJdBLxzTCJFuLZMa8JpkaF7cByBsNyFh7i+KLEbGRqcrveTTXJlYXR3+z1bAXDWU7ZQiCpBnOBH/eOWmd3IqmpIygVX88zheMoWHH8vVuz4JhumexVi/fAy3LZglYYKhilVIIXKcrChdZS5MPTo3TzI0EIXJR1KkTW62cI8nkb2ovMtDT83qGlYiZY4wVgtLXPy0doiGDraCqdXX8PhfljqGL6OZKV0N/3Cf7bvR3HQFvlDpxlhyoo55vfgU6NqXOEa26WxcSwZqOLSTqjIYnAfA0CFkHQc1B4Hj50O0wDE4ximra2e8asCdiO9sIb1OpPYYY9PqbLGixsX5p13wthw+n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDEzY2lIcERoSnN4Z1hyMktHUFo2MjgxSXl6eXVqQ090L0h4M2RWbTdhUCs5?=
 =?utf-8?B?OHR5ZWJ4Z3lOcDU1V0hLUGFOZkpRaURQTVVseThjakpPb3ZEV0NUcG96cUlW?=
 =?utf-8?B?TlpWYW9FRE9vVlJBNWxGQnliYysxTWZ6QUl0Z1pPWThjRXBrTWJuaFA3MWpP?=
 =?utf-8?B?VmtQZ2dsVG0rVjc4NVBxcXgwWlVadnlDV3A1UktXUlNJYW9TRXBNRm93QjRI?=
 =?utf-8?B?QTlQMHNKR1NlNm1LK0Y2aGdxN2hoeEo4eVZvMUtWa3d3bmhvaHQzTHM5QnNG?=
 =?utf-8?B?ZlFjVHpHeitqRWxkeVdiRkNJc2RWS2t4cE1scVJaNzB2Uldzb3VHL0V1TGpo?=
 =?utf-8?B?WDdzWGJmS29yQ2RXZnBiZVRQSmJ0VHZqVFNrNXdlUlBwMy85UEx0bkpDRXpD?=
 =?utf-8?B?ZG53WGhDYm1jZDBtMVhpT1MwYWJGcDdLRzZHaktodGFGVDlxM3lQS3pjSU1D?=
 =?utf-8?B?T3VGcFNEai9PUlhJWDZ5VjRkS0dsaHdKNFNlZjViOFJtYWtzMGpFMVBibTBC?=
 =?utf-8?B?WHF2K2J5L0J4cllsU3JHVmxMMWtwemlkNkJFVlUzdjhGRitadVdFWG94WVMx?=
 =?utf-8?B?cFRxY0RJWGJmSkFOK0hIMWVIUERrc0lRSXNOUFpTdUEzaE5tTGJKUVk3UVVW?=
 =?utf-8?B?ZVNsV2pvMzBKdk52Z1dyYU15Ris4VUpDVitURDV5YVBnN2dDaFlqSnlXZXhy?=
 =?utf-8?B?amdndUdzdTZwQUNjSmpIMWVKU1FZZkJ0VTdDalRmRzFVYkxSVkNsYmFzNjhi?=
 =?utf-8?B?aE5PRnlGS3ppZ2w5eTh2aElNaFAxYi9DbXVmTGJHMlEwenhSdk1YVThLdWs5?=
 =?utf-8?B?aVVETGVMNi9vSENuZ0EwakcwdkxmVHpRNFE2aDdTTzRRWmMvQVpIMjVNckZ5?=
 =?utf-8?B?aEM5b29pRk0xcXZlWUhWOVk1UHJvdVBjc20xcVQ4eVJjazMrS0RxTXcxT1gz?=
 =?utf-8?B?N1IrUGRUMGFQanlnY3BCLzJZVVBxdnpMSWpwbHpjUEFTMERGM2xZc2d1N3NW?=
 =?utf-8?B?QmRtaHZaR2E3OTF0RUkvWHhiYjhETmc3V1ZpQ3lkOFV4SjkwY0t3L0E1Zjdj?=
 =?utf-8?B?Y2xWbHFKRzRXeEhOemk0am1jUWZsbisxdnZ2TFdleTUrSFl2NlgrZ051YWxa?=
 =?utf-8?B?UHZVaVUvTGdqaHpkOGR5S1hYR09nem91WVBIVW5xdUZaY3oxQ0JGUG5CUEhR?=
 =?utf-8?B?b1JTelpqK243VlFWVSsyUlp3STdHbTFjVHRmd3RKZHNhRXdNM2tNRG5WMDFv?=
 =?utf-8?B?cTVRT1JXTURqT2x1S1BqRGtEZ3BnOEU2MjhFbWsvaHlnZDV2ZzBKUHhuR0V1?=
 =?utf-8?B?OFBuWjIzZks0dHNsYlpsR1Bqb3NwcGZWdExIeVE1TEpBNWRJdjFoN3h2NjJF?=
 =?utf-8?B?a0toSkFmN2hUTE1RYkp4T0lWMG1KQXNDSmhNVXlReUI3VzZuWjRPTi8zbGsy?=
 =?utf-8?B?Y0l0WHF6eEVIakNqWVNmekVpazV1L0RQNW5GZnRGNzcyekUyY3NBaDB1bktP?=
 =?utf-8?B?bDgyViszakVndkpveUM5TFIrR0ZVbzFKZnBYWWYwdTBpNE5adlNJcG85V0No?=
 =?utf-8?B?Rk91c2NQaG5DVUdrQUlvUnZncjdpVHppTCtVWXI3Vy9Yek9ZSEV1VzBSRFJJ?=
 =?utf-8?B?S1BGZXM3RkNqVUJYd29HUUJWTmlaSDlmVHhvRlIyd0ZOSDQ3MlJLOUI3eTV2?=
 =?utf-8?B?ekdPQkMrS0NxTUlKZ20zZStrNE9CRndxZUIwUW5QbE44eUw5MVREU28zVTZo?=
 =?utf-8?B?NmRsUmlkdExJeEV3N0FRMEhDV0w4QTJXQXJhQ29MOVo4NG9XNXVSZklnY1NE?=
 =?utf-8?B?eGZXWW9tS1YxNVpDM0lnajRYN1R4RUdUOHd2L0EvZ0VndThhNGxkU3BCV2ow?=
 =?utf-8?B?QVk2bUdqaSs4QXNQZEdMV2t0RWxsWUVhajFlLzZFSmpJYXgzdTI5WEc2QkYz?=
 =?utf-8?B?c3ZRL1QxNElXcnZsdTlYTktLL3Q4NnEzQnVUczRVcUYydUhQdWkxcjJNVCtr?=
 =?utf-8?B?RzFGSFN2N0h1cFhvbTgyaWN2SWpCMVkrNVRBRDdxNUxDa25nTTgxTzMzWE9l?=
 =?utf-8?B?eVpIUS9VWWZoR2U5MlZOcVZrWDZ5c1ZIL2dPWWhzOGVsOU45QmxoWUlsSk1D?=
 =?utf-8?Q?ogSX1CTL+BzPP6rHuKwhguvW0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8144fed6-6092-405b-bc2f-08db83787c91
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:31.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC7InX3hGypnph1gCs1mTlS4DKy2AVKS+xymuHBre6B1WKy8ZeT4bYOlSCOg2bcDu2TsPUA676GrfY/JFVsFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/mmc/host/sdhci-msm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 1c935b5bafe1..80e376802ee0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2668,7 +2668,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_msm_remove(struct platform_device *pdev)
+static void sdhci_msm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2687,7 +2687,6 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
 	sdhci_pltfm_free(pdev);
-	return 0;
 }
 
 static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
@@ -2740,7 +2739,7 @@ static const struct dev_pm_ops sdhci_msm_pm_ops = {
 
 static struct platform_driver sdhci_msm_driver = {
 	.probe = sdhci_msm_probe,
-	.remove = sdhci_msm_remove,
+	.remove_new = sdhci_msm_remove,
 	.driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
-- 
2.39.0

