Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980C7629E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGZEGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGZEFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:05:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4507273E;
        Tue, 25 Jul 2023 21:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M13qXiC/LcyMkfESAVlG6XWOnbjryIziGoQy9Gd2tsBnVwz/k4dO0GAmXGGciM+Swb0Vgp5jRgBJUgOIlj1s1ZpQ8PX+xQVYYuK8WaHe2lClL7qdSDsC2hg5tZOc+tTxuviSnWVYQ1i5EKIVnEp165pQQyDDsQ3Np9lVsZVyeNK+G6HHDHiXemgRkLoxw6Ikf/bJFO16fmlbSZ53+VV4UwtDNlhtkkJjTgiqM+J7gCEi4xMWFI5xEx8P2g8Ao9vBhc4ifVFkII5MJVXIhEkhgH5KmIPzFRCZnqT9DFpcvhvBkEzEZsBkfagGXLmWDbxR152TQDZcKiDx5Ogb2FZlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VnGOYi45hwpGU2pMDgLIc+XDvJEY43fviyLsFSsxj0=;
 b=QuQg7+w8iA8dWJKMcg4pY01yd5Rbu7OqEH/wUQgECK1pqOjsJt3yY1573LHAZsHsRSObW20u+Vq1uSrvJdtBItCci6upOMMLBda4uvwQKxZm4cRI1dl/pMClgC/pX0oVKMhwW/ofOmEOqnUfAYaeCUemVXVKKC8Xq+PPvb0ayfvBCetuRf5IxBPOQRlBPbKoml2MU/r8tEkaJ+5JIGLM80dd2s/61gHPUZm6sPFuB6VW/qTNE6ybwaqiAKaORPugJ1f8pSVSQSHQt0Kf+nC/4bWh/PjbSz2/crbREMK2NGTJ8mBDjZRr/czKxqoi42sYn2j7XT8YdouiKexf0Kbg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VnGOYi45hwpGU2pMDgLIc+XDvJEY43fviyLsFSsxj0=;
 b=j9R/JW1zeTFlPWC1RXn0XiBjKmHlarat2SF5An6UGNPX+BLzuVCkMkz+earYOtaqPu5qQDVoYQWLCiYnxlPcYiYzmR0XrBO1CTxJlPh3UROqX5Xo3qywFopoZgaf3jfvsUtPP3x4BseHMXUocKzKP53rnotJWjn1wNCB89ud3UaHJV/0mag47vzpZl2fMmFLkjn9P8Rz4UfeI3WqrovpR/Qcx/h+GE6d+sbDTJ8N7UGS+D9NWGwu54tQFF07OUejUZWnigIrQIzGu5WsBpOzjF6eNppJGwP7XjFrkKuTRsGdi4l3EBndvhbWXinBLh4S0SdDsNZCfxPqThxBnDjZYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/61] mmc: mxs-mmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:04 +0800
Message-Id: <20230726040041.26267-24-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726040041.26267-1-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: b78077ad-7320-4ac1-f21d-08db8d8d042a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcT4S8uAF4USK9v2vG56eRvFfmJOToOdOUxUT21ak9rBVKKXbBrRLfD/y5GFqUYYqUPylbzMsGmRUGgsMkUZz0/MrBQ9yOhN9JaUXsw8T7Al3hYCv1ZlSf4Bj5L7qg1n6xQ4EymioE5ee2751j0xZC3WMBiRGd+r5fAhvDwFUZ1ps0dVZ6yglZ8pbpk0XbEormY//zgfzKosknd7ZqU4VubQgtEPsbD0PX9PDEJDtA4CrMcllVhjE/08L+ggmCcQGe+KqX0GCF2XKkJOy4Jz3TovoHTsxD+oTgLe5a+nf6mbp0mZhfyBw99jj+0nnSnL1pGY+laiJqEoM2Wjr3gox4VFg/Y5sI4w628xlnH5Qj39vQqSV+7K7ULLxbzhLmtXXKfVl5KhWyE+HARY3iBwRtUzZDyNDYHE61XZbbPFFtvb22EyrXV5ioySrcQ53KNyEgcegYm0roOYSDCmZw33aDT0BYbLXqo93Wuc2rIiyzlefTZSjebCm4/FJEE3S1KBVD0AieGe7AaM/CZIGMnKlV2eE4rVCTxLRg9QhLG85GgLpxHBCOmMcDgO6NzX5N3qp1R0ufKv3g0LrvsjVRN13WtZd+abNo+7rfg9YMG965h3nT1e+AV9EDPW3QenkXSD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66574015)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(7416002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHNicGszdm1aa0Y3bml0OE5wNk5Lb3pLWG5UdkkzejVMK2pkMGtKalh0VUEx?=
 =?utf-8?B?N1RxSmFhdmsyQWVXMlhvS1BESHhmczg3K2gxRFErbmlhc0JIbmtjdnJFTDdB?=
 =?utf-8?B?VGFIUnJxSnc3ZGhQWDFwZXc1MkxrbUR5Z3YzczZHaWxFRktNODhaN25VeXdo?=
 =?utf-8?B?U2Fac1FxUW1JSGtLL2NWdE9OOEM5ZGpldXRqRDVoNTRpcW5OTm9EYk5wSXIy?=
 =?utf-8?B?azhKbTB0ams3eGNXS2c3eGdBRWJOSm1uc01jR1Rac0l6L0JmcEFQQ0pzREhx?=
 =?utf-8?B?SWEzY0t5dUtLbmFnUnRNVXlTT3IwVEhVSDJRVmtjSExMaXBvTERJQ1I1MnpL?=
 =?utf-8?B?Y25yTzY0NERHbmVyWGdsZHY3ZUdUY2FlQktLWG1BUkZFWm11UnV4cXM2SGRW?=
 =?utf-8?B?Y1VTenY5OFU2amIzaHVNdVFiSndTcmVhMEhpQkxtOXlUUWsvd01rYUFDSlZE?=
 =?utf-8?B?K2xOWm1XSVpaVHlvVE5JY3IyaUJmTzh4OHdvTHBwaDRHSUhYc0t1Z1dDQ2wv?=
 =?utf-8?B?b0dXLzN0YUxVZVB5dFRGY1dvSVBDRndod0xLcE14b0hWN0ZmQ1Jnb21ndEFR?=
 =?utf-8?B?bWpnT0NFS3ZJR1dFZWllbHA0ZkwrREtMc2ZWRTdyNXpOVDN0QnhjSkN5MmxK?=
 =?utf-8?B?YUIyN0k4SXJyem11NHMvM215ZFp3cjFPZ0VyV3RwS05PdEZHc1QvMUNBRml5?=
 =?utf-8?B?TWRrY0E1NGtiWVZoaVlmYU40T0RVQlNtY3A3dEU3YitkcmswMFI4L3JtdndF?=
 =?utf-8?B?WUVQNE8vWGpWdU1ZWUtkUHd6OTllb0p5T1c3M1dDTSthOFRzZkpTVVc4YWRo?=
 =?utf-8?B?UHVhZ3hpTWZ2VjdoSUp5TmQzK2xtQVZSWERkNzFKeGNkMnpBRnhhcEVSZk9v?=
 =?utf-8?B?S3ZJWCtIRDBnWlVNcGZBam0vb2tvSkJLcUF0U3FNdnY3ZnVqZTZwbXRzYXhB?=
 =?utf-8?B?SWM0TWJaQ1hwSzJISlE3ME1qZC9UMWRlQmdQdTJySVRoVlJYM0lXYVU3bjZw?=
 =?utf-8?B?cXVZeWZhMUVCT1JxUmhWMFA2bmh1ODRuNTRzQW5pRC9SVzh5WHY5YXcwL2xJ?=
 =?utf-8?B?UU9xSGg0cjlxeG1Uby9wV1U4RkY5T3pZY29ZUGV6Q0xUSXdnQk9HbjhhUDIx?=
 =?utf-8?B?SlpvcFdhZjNhUk5FWnErNzhyMkoxRkRTb0NkbnExck93QitNMldFcDZnNW03?=
 =?utf-8?B?Ky9tNGNlMTRRazZrZ1djdE8yTEpTQTBubFJiVXlrN1FhN2VrQy9WL3g0cGJp?=
 =?utf-8?B?Wnk0NnVNdWIvNVZaZFp6UWpYTllhZjhSRVIySGFNUXY0Zm96VDZ2eDNqaWhZ?=
 =?utf-8?B?aVF3RkRWYXZIWXMwWFA4K1ZBa1FhZWV0Z3BPbWR3S3p1YVJiS2hCU0UwWjhm?=
 =?utf-8?B?ZTlPQVRscklTb3BmWTU5NFpweWFtZm5GQ3liNlJqWGxtNW5ZaTg0eGk4WDBz?=
 =?utf-8?B?cFNXRVVkTFh2UUJPaVVERDFzdDN2Tkp2RFJMdFNldE5NNEF6TVN0SkttUVc1?=
 =?utf-8?B?b3EyWnZNVHdpSTNqUDJIc21iZ25uUXYwYUZnZDMrZXJjaUdCaHJQek1ZQW5v?=
 =?utf-8?B?UnFwYm81cmFhUkJkQmwxaDk0cVFHeDJBUzN1NFRtekxHVC95dHBEcDBCQ0p3?=
 =?utf-8?B?NnBhOHFLS3YwSGVGTDhucm5iK3hvUGhoQzNIL3ByNGF5SmY5b2Vic0N0OXYz?=
 =?utf-8?B?SGpwWXFPQWUzRVYwMng4dkJKOHhMeFcxNUZ6Q0FhWnAyNlpyNWJTQ2VUTXhF?=
 =?utf-8?B?dWNlRXZNY0NnYk9JSnl5bUs1bU01OFpEUDdoeE1YbEc2ZHgwVkx0QUUvaVZs?=
 =?utf-8?B?TVluYXI0ZVVid3ZKUy95WllIYTRrTDZLM3Iyc2xoMkhzR3BudlZoQktNYy8z?=
 =?utf-8?B?VGk4S1cyRy9mMlI3S1RZSCs0QXhQMmtSVGcvYkxPRXlSWncxUWRsY0tOSm5u?=
 =?utf-8?B?WHdkdngyaFZlei80Mng3dW5HVHd4d3dwcGppcVNRRlJCdExEYURHMmhPTmlJ?=
 =?utf-8?B?MW5ENCt0MnZBSVNYLzdQTEREVitWajFXZjVNbmZ6bDAweGxxaE5tNVI0T0ts?=
 =?utf-8?B?WkFVNzVzWGE2YTZKTDZHNmROSUZ4Yi9WUVFmS2orVHNWUEduOTNJeUszRmVB?=
 =?utf-8?Q?lDgNIbhHkvMS3Hl3rx3HG9AnB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78077ad-7320-4ac1-f21d-08db8d8d042a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:40.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hp379q+pZabz9riJk6/T+/h2FM0Dzxl04AWv0xYDgFVkj6qTFv94wwhfx4Qe2P3tVeDiiaTO1EvcchYRNUZInw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/mmc/host/mxs-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 8c3655d3be96..9abfb169464b 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -674,7 +674,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxs_mmc_remove(struct platform_device *pdev)
+static void mxs_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct mxs_mmc_host *host = mmc_priv(mmc);
@@ -688,8 +688,6 @@ static int mxs_mmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ssp->clk);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -717,7 +715,7 @@ static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
 
 static struct platform_driver mxs_mmc_driver = {
 	.probe		= mxs_mmc_probe,
-	.remove		= mxs_mmc_remove,
+	.remove_new	= mxs_mmc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

