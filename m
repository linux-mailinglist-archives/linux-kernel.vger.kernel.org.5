Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5E7647AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjG0HFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjG0HEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2FD3A85;
        Thu, 27 Jul 2023 00:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHBSGuWwsvKHN+7rJoOrILYLu5wcaxzXM40jxJpzCtWdS1wFgS0ODfwfehPrGipSCRKnXnoxxCJASyn0As2MWXNzYFBsNGB4YJV8LyqME0m/BMsfnBtJmjwR7lKuFwljM1CpF6n/4jGddkbila2x09qZNmGmiQCdZyiS23HX2JYqkHlyZNhEZhpVdyrZwc/tQ32q7u/KZOndbFP8jlkPw5vKmrH/gtM0FeIpMcA6HA8qpZdreQS8Y8wsas/OIOq566FONVQ3mvRDnyGdxhxCKGA6ebwBi6s1XT9Gevg+3c8pJlx5Fc9hFMR2L1/c2lvD7x5BJ7RDeTPt7mAq8jjvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VnGOYi45hwpGU2pMDgLIc+XDvJEY43fviyLsFSsxj0=;
 b=Ik+DbOF05FHOv/qke+mj24r1ssqdQ8CmsFEBPhObqhDSjZghwBan8qOiSA4WrHCk7C/rzmKya8RL8z3yKOegrjxzfl+l6NKZYRsxDt6RtfW21yHwi8myMSqgce73IoSL64kfpPK5MVzhne8YBYuXHeXgqGYvSQjcMBZMTFpH3/f0KX6NRnDBMz52ipOoYDq88xsjQP9SIqyhhxbeHxSOsZ6CM3sUzvXY7xsaixdaxaA78vMsh/kp30QBqwoa+8HfO2YJNAasDQp0qaHB28tH2rI7U6HOHCn2JeTI1ssWruiSi9zLtlQ/MvBXnd97WKmD4SWOcyuO0F6N9IcyFQ8vMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VnGOYi45hwpGU2pMDgLIc+XDvJEY43fviyLsFSsxj0=;
 b=UQ8EgVz7Wx+8m5qzwTJ43XDYw31X8/SklE95zD+eZJ1ICCxluoCUVhlSAHHNUZfRdY217TRKxAYfFbMsF0AloZQEb/dNubIWek0WSmoq3tdwwN4M8G/+nyg5biIi5WcGNE4+uVzlmfvdr8rxb9k9JNw5YuRKulHmHiRXhQQG2EAUlqhO7CgLW0apcWdoNKCYjq4zyeeuVIgdYFbHHjpJwSn4RXrp9pIsugkySFXlM/+LPP3gcc6Br0WKh2tp0D1LRLxBks2cl45JaLmjwr+XsTAAJEmYrOrMj4nteRk95ukc6Z9XWu0w8vDRg31+KBJlnrWuFjvMA56DY2XvyUQtxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:42 +0000
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
Subject: [PATCH v3 24/62] mmc: mxs-mmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:13 +0800
Message-Id: <20230727070051.17778-24-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc2938e-9556-4c51-df1f-08db8e6f5505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45K9sinYp2fD/GfRcK/Gy3TNPXxwuBsTtWu+p970jYiqP+xQHQrg0juL5LQFsSMzyuAG82CsQyrs3LfArXhlkAlTRxEV40raC+jzgo9faPVMmLfVUa/mnTaVQP3pfFi3ThPw/3Es8bzwAInR+QgBs7fBDORnDVgsdhl0hP1nQaY8cedIobzDiMHbCagEusoihlOAmmyqMrj40VLYhikvjlZab20zkKUZax/ESP+95SzeRy6UhvzsXI2XLHPW3uRkz6amj+weScwLsTll2nyTWvg8DOiiwOgDajn6Xpn7jbwa1eJJxng+n/yLHAsNnZk3wG3lM34bHLHd1lKVPd2gQcr4iphwRFhUakd1rO7+GOc9R3hKmMdl0MlWo3EjpYCX+yhy0xyKgAeCmt3P2AYLp7EayKn6MSsQ941sEaHp4HZuPfsk+QtLU4fnUYpIf4N6J0u0qQj+MhfpooUVAhM1b4atTH/LOM+E9chVEtfy8Q6qlcGTKrGGuM5NAKgHP43F6b8GQK11Fsn4VK5XRJOmuAXLeJgbOyUKbVNq36KnrONdDLROy7eTPrKIfNVO23HukQ7KDt9MG22UABxXWTEgJ+v2IjozIQBgrIOjZPRO46k+00rso5I5nFSWwyjj6RNV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(66574015)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(7416002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlVRenBIVEF6UVMyQisrblBNOHI5V29MdkZreSs1bHg0MjY5VGVNZm4yaGpa?=
 =?utf-8?B?UEl1WHYreGJoMXVUVnRrcEo1d2g5RW5DbkExN3ZUSkk2YStWamgrRDVyMkdv?=
 =?utf-8?B?RzBiYUZUL0VBWWdjRi9LV3JJM1pWSENXcllsTkVrVVNJS1M3RzB4eEg2VmUv?=
 =?utf-8?B?TG9kdEIrY0ZzWmpGZVlHMmNVM0tmTWJVY1FLSXlwTDlUS21mS0tXeVo1ZzNm?=
 =?utf-8?B?Qm5YSGROdDlEOGx5YzljTVVNenkrTGxXZUN0WXd5VWdIa3dZZFVMK29IUE1M?=
 =?utf-8?B?THE0VjlMb21OVUNibGdTdFM3Rmp5Z0l6N0pqd0l4YkRSdWpxV0JlNzVVMlpi?=
 =?utf-8?B?cHFtYTIwTHZMTnByTWlockFRYkFIRjJxV1p5NzRVUUZMQ3c2OElGSUZGVEFk?=
 =?utf-8?B?QUlvMUtBWmR6d21ZQy9RbmR4RmxQdjRBZUJZT0tuRE9YK3VlQ09mNXA3UGRO?=
 =?utf-8?B?elk3REZGZ0hEU3ZVWFBzMFN3dkEydVVOSFBaSVh5LytZNVhsTGNPQmVhSEhN?=
 =?utf-8?B?SU1iR3dacWp6VUdKKzg3bkw3YVdFTVZ0a0QzYXNXNk9pVldVZ0VTaERNY21Z?=
 =?utf-8?B?b0tnaHJFR2ZCeTNCK2RKWkNIM1EvbWJIc2w0QXhaMEFUNEFZOGxrZ0gxSC9m?=
 =?utf-8?B?Z0hVUXhQZW9Yamc3YVVtazJxMlNrb3FmanBoN05Eb1lUc3V3L1JNY2tUR0V6?=
 =?utf-8?B?Q09kWmFsaDUxVldTbVRRNFBGYXp5ZXBxcnkwZ1FhcXR5SGg1V2w5UGRuN0Ri?=
 =?utf-8?B?WnhWS09pVU1WK2dvcWNFSHRtR1V0K2ttV2t2cGR2RTZkN0lKQWQxQk5IczFi?=
 =?utf-8?B?Wms0OGt6S09tM1RtZ0V1VldHQWVIN3BicEZITkpvc29mYTZzS3FIa0NVc2ly?=
 =?utf-8?B?WmxQWG9KRUJBYnRaRGh3QlJXSlR0RkxHdkg5d1FHMkhsckdyT1RXVkdKY3pT?=
 =?utf-8?B?eGg2Tk5Ib1cwWEl2TlJwbHRkYjQ2c3E3UEozRzBZd1lTUGJ1T01zL2w0UVpQ?=
 =?utf-8?B?VnR4ajBOdVJPVTdzRWFWTU5QWlRtd2FJd0dnRlpOci8zZktwV2hoUldiQ25r?=
 =?utf-8?B?dUZLQlV1T2dzcjRoYmw5dXdaeDZua0g4OWQvMFBLaDFCNndXQ3FpRzEzRExM?=
 =?utf-8?B?Uk1LNjdIc1E1NitSK1M3eENWU3VwQlpQRFpnNE1lOUhYR3NDWitIT3MyQ2t6?=
 =?utf-8?B?Mi9WVDNqL1ZBWTdaUGZTbW5ZNG9CM2ttVzNreU9GUHZsRTNXa1FGVFlsTnBY?=
 =?utf-8?B?UjFyR0NiZGhyY3VKMHpDdmRMMS9UQlhycVVHU1JUaHY2RnVISWhXc0o0bnhu?=
 =?utf-8?B?emlaQ3YxNGwrcVNxVnhLd1NnVmkwQi9GSzdSdW9Za1Robk9HSE0vREdFeGtl?=
 =?utf-8?B?Z0p4ekdsWnRWN2V0VzVzd1Zkc21oZUZpdlpFOXdmdHh2YXZNYWREaHpFTkFN?=
 =?utf-8?B?ZmlaSlNwZFlyRGJOSmw4TG1LbituTkxIeFhFbE9zZ0ZqdUpQSkFCVTlCcmtH?=
 =?utf-8?B?NUhNQmxkNjZUakZqcitCVW00c3luMndkQ2FzcUFsclhnOGUvV2NlY3lnUjM5?=
 =?utf-8?B?TjN3MlBHSkN6dTdVdzVtL1FNZVVkS1FibERVTU9yS1BYWkRwNjdROEFuSlIx?=
 =?utf-8?B?Y1lKMlluNTVFWlMrdkI1R0dIeVVvK3ozZWNGR1RVbjV5d2xpYitiMlNnVEp5?=
 =?utf-8?B?ZnFkVTFuaUFRM09sbnR5MnFZZ1V1a0d2cDIwN25vNkZRRDFwdDNGQXk3dzFH?=
 =?utf-8?B?c3VKUWFQUEVIbmxjYW1lYjNUTjZmaTV6SFNFYVVjaWhtU1BNcWNoUW80Q2Qv?=
 =?utf-8?B?bk9JZW9NUWJ0bjVBb1h5T0JMc1U0ckhJell2dWN3anh6czJHS2xKWnQ5V1Jm?=
 =?utf-8?B?OUNiZ1NCVWYxaytoeWxXTWJWSk5YbjZUNWd1STRTUzlHbE5ZdTFzVm9SVDhh?=
 =?utf-8?B?RUIyZjRGbG1YMndwemtCaTg0bk1JQ1N0ZDM1ckpOdWkva0J2MktEYWcvU3VK?=
 =?utf-8?B?c3R1a2dUbi9ROEtjV2lWMnVmeSsvQ2FBbVllQmZ3UkZ4c1hCczNzRktiMExz?=
 =?utf-8?B?WW1heVZzNG1PU3Zxb091Ym9leEMwOGlYVVRNQ25vK01xYmxZSGlxV0lWeU05?=
 =?utf-8?Q?IGEPxq9e2fUIg/lmRc4FRbSnY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc2938e-9556-4c51-df1f-08db8e6f5505
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:42.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk3IKa3ftWMV6/+2ZEuIOGE8VkgkW1IbZrLMSHkhsTJ75SUeGUJcuybJoSZNlPN3uaeS8IOy6IPGksr6Re9vJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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

