Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F8D751AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjGMIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGMIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957DA273E;
        Thu, 13 Jul 2023 01:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNtxQLew8Eepx+EpLw03kcQCEvXvMlslmTc1trlkFq8WTGAwGqd5aPg6Z50yg4NstUrzxYbxc3F7Avak3MAjLOkyPNrDzxNrWiNe2B3zxBhRd++U0dyMNLEfpDQ5D+wjQKfaRGt2z4JVxNM1ocWuILjW4zdJzfkNJyE8gnWQy77tWMMnABMFYycjOkNg08FHcHjRnzNPcTdSRDoRr4bYYIdsySXujfKvhKeUGT+xcEXufPYWkNmsm1DekbnTMNJFicEwIc1GbPSqm/5DVJCtAoz3N5WcQY4wU+/RzyaBRsiOz8QR+dRforyShtBdMthD07RlE2yuyRhSbrARmC9hzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PMUwGYkEKhi1gyynW+rXvAujgXDga934Imb0yL8Frc=;
 b=oICaM5EoIQNYQOJV/+K70wffDVNcurlhqcLSN49r/WEZQvAgbsErLs5hjJHoyTsVJmmU0t1/HibmYkFuSTqyyUgVCAuGQ/ElwXhfDeUTMepczjfvBdsI0oa87K5f/AI9svVQeVA2Fw0fIFar8Fd73L8SUKFTOYMTPdBLsEK+ePK7b5W3CoZV3A/FPBoci42n5pcA9mXfj7WR3JjqkAuQ4yp2bAlzXy0AF/Xxbru6EKbQklRx35bG1+U+6IkcBZ7kapUBYX7aEAsrsm7mqD9iI5JH5X97ElMmc/vZEKLmz1labFSFTSYv5WuclmZIeCYHJWrmnCgsdd83STC7Zh4HoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PMUwGYkEKhi1gyynW+rXvAujgXDga934Imb0yL8Frc=;
 b=mAbC8qtZHLm2XxvvRFPWTJ6HfxoNJ5+sjpfN0LoNLEtnS0/imdjKS9EETLshbenfyAMQoLxMJZDCWfuaw5VUJ34ap/e1GvFjXDzQ49xe7Gvc3Z3qnDJhKBsfAM0G/5HUKzTriKJAQHaPm0ZmHNFHWKjUzC+Bpp0kciRS7LF/FACmwXbjOmxoTHJU0IDtiBM55oHTDMqfimn59pTeKiA3isWGw8p1ym0rkakSydIDqhUCAnkL6IwGsKF6bj/sAeWXopXWOkf8zwOFaPNXz4wvg4cwA0uq+8+/bD/a919bZafph2cCEjATCktmXI39Pe3qKNZAWC0SZpfmgnElrzCfgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:28 +0000
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
Subject: [PATCH 05/58] mmc: mtk-sd: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:14 +0800
Message-Id: <20230713080807.69999-5-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 65243354-70f8-4313-0517-08db8378572f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3K/rcR/1cvOzD8KEtQwp6jaRtH1evDn3LbC3nT6rsYbCh+kFldHtFvVG423kInQyJUpZ3iMVNfV+hS46a9j3x+oRBmtOHdyLNqvWCwvedZJLjVv+kUEK/G00P23iOMXKiRXqhhgW5wqnVcnx/KulRgo/VLMeU/0ubsYB9wKnqiIkDpgIh0IL/akNyrJvUqdCIue/3uOGCj3VJio+gGKOEc7bw9RJ42aaHpJEUhpVBj8bLC/cpkDgsUcS9vG9kC5Wtf6K9Zl/n/31f3vysRdFKALNzud+q2fP4jyVI8kndpBYDofNLsrzqmufy9v14Tm8wUFL7h3p0y5LMUgmn/Q5JUxqDr0iWZvC3n2+BVf9dlh689cXh9F3deSfe2GV3bam3btvSCYt4mGMGXat0IRZcvdZVJj+XMq7gP2NfM3unhdkVC6RxzJncuh5QyuHhKoGMh/WRSDcdTF9SvNwI3wI93nYJ+efwesErXlsS5X0+T7YX1V+q0o3YSFV9MgqvlhDuDUI4cKzTvRENI/aFCKaOlJbs2pnHVIZarKkTVk4lDkwDobW31kg/rCGjT+8b6WQiqoaF4DnmEVjdD735O45xU6/6J72donpfB4DEJHNTREa16h9n921p7u9b1omFXMv6v3SZISbp+mhLaWgWXfxCj4mBVhUnVmcCyxe6YC8W4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHZEK09qT3VzQkx5N2VwM0VmSE9NWmowTzNmS29hMmtPY055SlpsVGw0T0xy?=
 =?utf-8?B?dlZTWXZjc001VkYyd2F4Ylh4UG9EVEgyVDdOYUlMRVg2ci9PWWRPclV0RlhO?=
 =?utf-8?B?SHhvd3ViSkNiejFXWVVLZzZDbUNRZjlDa0REQjEwNE5aL0FmUW16ZEN6QzQr?=
 =?utf-8?B?VldZalNpNm9IZU1LZk5iWEtjTnljSWFnYUR3R0JqRDdDLy8wU2pobFVFcnRZ?=
 =?utf-8?B?V2hzaVIvK251SlM3Q1ljdEdwVHZuZ3BObDhHMnhMTDMwK3pDRTZlclJ2Qm5h?=
 =?utf-8?B?WlNUSkFmUnZkYjMxQWhCTUZMWmZQeVRDNlVSd3R4a1RXQnVOT2ZFaUdVTkJv?=
 =?utf-8?B?bElHNlhSNkNSR1gvZnp1dGRJd1BpdEkzSWhIZmZrNGZTVzRSTXpCbkRJeERJ?=
 =?utf-8?B?VVNmclByOXgyTlE5bzhEQ0lBdExXdW9ZRWhJZDlxWlpNQis0RURwMnRqSzNr?=
 =?utf-8?B?VmMyMkpyM1QwdVMxTEVwazZEdWtCWTZXcDVBYVZmcUJibGNwdGpuckFWeFYw?=
 =?utf-8?B?VWNPckNRY3g0d1Q0U201ZlJkbHRET0hQaWZnazBYTDRXZG1hMmthOXBFUjBq?=
 =?utf-8?B?M2srZzg2U0EvbkZqbGh2TWdIZVB6T1g5bHU2Yld5c0ZkY3FPZHI4ZUJhOHIx?=
 =?utf-8?B?cGE1eUN4UG90cVQ1TGNEbnp4Mk4wbFBSNkRGWjZzcnZ0aWEzSHhGZ0NjNmRT?=
 =?utf-8?B?a0o0aXhNcnJGalBHQ1BXc3k0VFd3b3hQaGZwK2V0WGVZaHEweUxrVkdIdU9Y?=
 =?utf-8?B?cGg5YjN1dHozY0ZpQ2ZxdjQ3QVhGdXMwcGZhazN2djVIelBZb29RMC96M0p6?=
 =?utf-8?B?enB4b1FvWHpMNmVKeE1vbzJzZXFRdGVHaFNqS3ZuZSsyYTlieVlMZzduZXRo?=
 =?utf-8?B?VXJYUWc5WEE3YkxmeVlZa2FmTmlpOVJiOC9oTmdDSHg3MzhxNk5kdWRrQjFG?=
 =?utf-8?B?a3p2dGtYZzIydkdVTks5YWRlYUFOQkFYVERRWlhUSy9RR1dJR1k2ZDBUM0pD?=
 =?utf-8?B?dFZ6bXZKQk9BYXk0S2plYU1iRnJXU1o5QWJiRmdLYUJMSnBtcCtlTWhtY1l2?=
 =?utf-8?B?RmNkamVlSGxBOU9COGVIcXhvWE05U0NQeFZvaFFDeFNmRHh3d1gyK2FjSXJl?=
 =?utf-8?B?bFRhY2dTT1JnbDQ2bmpXL0IwQjY5N21OcS9qaWpHZGxtWnliaTdNNFhYZ1hm?=
 =?utf-8?B?QXNkU1BSTERCdDBNcThlTlZHcHAzU0IrOEwvQlREM0V4Ymk5RW5XSHo3Tmlz?=
 =?utf-8?B?VHN4MUIzUEx2Y2U5c0FSZ1E1RzJtcndNbFk0UDFscEFsMUpZcHJBbzh4RWdU?=
 =?utf-8?B?Y292UGc2MEd2Uld2aXZiRG5heUJxMXM1WW4wWmltc3JXaXVnc1NCL3pmWXhV?=
 =?utf-8?B?SG5qSFdUcXJkOHd1ckxRZ011VkM3eXkrMWJSWWV6M1lBWDVhVUNsTExNbzlK?=
 =?utf-8?B?bTlVRGlodlhoSFFRaUc5YStnVk8vOWNHYlRZZkFPTUlCVjZSK0pWNGticlNT?=
 =?utf-8?B?YVdGQkpVMWJGS2o0SnRyREg5ZU1ndi9mcE00U01Bb1IrL3h2OGZCRUhYZGR6?=
 =?utf-8?B?UFRYTFdvdlZ3UDExemxOVHdIVVlRQUloK1ZrYnpPQjRJOVAzZ05ydDIyMXRk?=
 =?utf-8?B?ZGJQZXZrekJZU216K0hJT1k2SWJscjkwQllFNkxiR0J2cy9nYUxheWl3azNC?=
 =?utf-8?B?M0F5TzlxSjJwREtqUXArNGk1eXZKcFNML2RkVFlRUHluSnZHZjd3cXdQS2pp?=
 =?utf-8?B?YSt4R1ArZG0waCtsMmJzVTVxa3VTSVY2aFFTQTE2VjZHZ0xONGNraWxGeWVT?=
 =?utf-8?B?UWsrV01TdzIzQzgveWtBM0ZRV3piYnE5aW1Cdm5ESXUxbGVMZTFiN3R0Z1Rj?=
 =?utf-8?B?SXBrQVlrV0hFMGx3RFREcURSejRncW0rSmdLeFpOWUdvT2EvV0hCVzNMU3ZL?=
 =?utf-8?B?T3dIcndOZVV5ZzZvMjcweEhMRkladVZuSUdxVE5YT2s4eklMREhzbXFWcmt5?=
 =?utf-8?B?eHBqVHVUeHJaL3ZxQ2xZcU5wbmE2WUxNYlIzMW5jamtXRTNHWVBWUE1zWHpz?=
 =?utf-8?B?eFlveGdsQmZFdGdkbFNrbTlxZFNNUHJJM3Fzb2Jjd0txeFlVOE1sc2pEUTdZ?=
 =?utf-8?Q?rn8rIDGBP3QDrqQxS4JlmxFsb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65243354-70f8-4313-0517-08db8378572f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:28.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmTm3zWwWCOyyQezqBomPK4+Kn0vzDyYzjhRdWNJvrvgs0XKREqBgidtgs91aZQ20GJ+k4DoMz8kV/p5ORcb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

