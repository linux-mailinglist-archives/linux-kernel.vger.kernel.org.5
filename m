Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ECD7629D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjGZEEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGZEDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:03:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B744E421A;
        Tue, 25 Jul 2023 21:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTXJD69KgUZTj2u6GKGwFlL79BlJ05p+Gv5e8ng0W4TNTxMspEVKjaSkb7o0nAHpwlkr01UhKxjhq4OXx+Lorrm0Q4WGfyNwBdAAZorg9pjH/AV3X0dy99K3GJoQ4Lfd5IUtAKrICLv3jd8wZnEVk6cx7d7Y31xAzEeTJ615NtrANuPO+LbNzxogb02N8S4dXP/aQ1YGZpeqD7AnBmSfCa4XLbEsik+qUsfuMm421UEVdDDHCT13Vg7a4QwdF2wPqrw6UqNrmaCRYHhny4gamtGNrx3vvZj44kARQrgcr1EFSZJSXPQVW695iV0dWhrcX/VMm7Sj9fLHziizCppY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nPOwPKYNeq/2Tv4iqOeh7ZkKMvKEp8wvhNPamOgGPQ=;
 b=UZUokC+k8+odT7uAU1cqE0wG42trolnTN66wiKHPsU3aP6rLwrg6S6kQ4NANoZxbpSCt/6JLbYbC8LWM/dyYDU9aYC/5OFod+kyjKputqr++aL8grzCKC2iGu7PyhofoDJZjRCGaEmAI1oeRHuSU2c/fFF92eijvVPdjYvIriHDU801ae1LwpUJ0XMiWXzQxlUxcfLOjLvdOPL+W1z/9xolE597Nrb1bGp6QgkbbqvDEEXu6OiG2NNj4imDG6j9I4TJJNyOnjUxnoB2t9MSZPoiPM0jnHzVj3Ogv8C3fmYMwVmbsUZcsjBgJ+xCBRJ1Si2xYa42ESmLLue+NX7aQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nPOwPKYNeq/2Tv4iqOeh7ZkKMvKEp8wvhNPamOgGPQ=;
 b=EtHqE/pcLApsjrI1sGAcpsDHBbDnRAlsQ1DsYZPSHkIYOQVqYfAbA+qnmqDzN/0VDjYZXxAmgxHetsoW3dhppzkR/RhaG3Fh4+sfM7IGBkLJ71YW2x2sYCOHVfc8isKa5UTLePA6c7tuM7eysUJAO3E337nfkbe4/5fgf2Wk8PfDjpgmkk51Im/qoc7y0j1RFJEguVfXqAPORzrY+tNpML5Q9YeAew0ORSl3hpXLI53KhPD5Y7a6y07DCAT8DyGFz7sfZgihEVu/eNmifFYWIwRbi1wr4qk9ieQ+Z41TG1UWxf7aoXURJ0wf+95yET+z48QALatT9BKyg561BUPyuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/61] mmc: xenon: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:00 +0800
Message-Id: <20230726040041.26267-20-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9195fc04-7526-4576-f174-08db8d8d000a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOLPvLgUmj/KlX4kWOaC1X1eFDvFeAph+ZBKZzDfUESQ+c7ua940Ec403ODv0SsAc37LVONQi8topJRQGJCHLS5hA1y6uRBa3wzaQ0eUZMKVRbuVhxxDSkp0o/nPkTL4GPfV1qz5K5rL7fOqCpFGXY9zGx14npc99QBMxRp6On6+ArsIMXXDO+ZlF9hAdwk6AUKZN/rXQH3BEn46PEoqnQ+7cKy6Hs3zpxyj8T5wW+xsBnLpyGWk97vcpIWACNqOWzovCathyhK3MsR+Np1rqp4/qAX8JvgqucYb9/S7pxHzAcwMcLQvM/CNEAzA6G35xOn9ZU0xHNss+EcOe+4ehoxKESAlQRA+iVfHXhM5IxvnWUud6X3G3wmQwlak4qlDkDgXJ2Rro0Kjy3CqIQfvRNnVo5RMGFy033eRLlti60Cgih1QLjfoKXkvHGDociUia0DfK7p9gqFzypt4NClz0jZNFJZIordDpUP8Xt46ej7WRQmX88ZIowBwBMaJVQ5ZyGLQ5kwlk8k0hPoVfFSrH1ApMa+BnmG/Nv+yjTs2V+mk5JzNArnqkwvwKtcuWyJ62pk2J6fcJ4BioftyEd+K3/80g+lwoIuqcmytnrN9wjtkVPu5WFcLJ1cfl5/Y3gpo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BLM3RYMjNta0R1bDZBd0ZIRWdvMXlzRVA4T2t1TlVBVFQ0UncyNktndlJT?=
 =?utf-8?B?SkNuMWMrenZDcTBSTE5ncFZMQ29lSVdWTlZZK0pYSTJPTjM0WFl6QVIyNHdv?=
 =?utf-8?B?OHFxTEZOanJyUHlaSmlVY1NYS1B1RVIzcUREaEg3UkpjdCtqTVIyd2Q0RytB?=
 =?utf-8?B?UmVWTDdrWE53NFhicTN4ekNZU3RQcEU1ZkhlNWVETkJEdmJYdGpTSUpnMldI?=
 =?utf-8?B?dkNISzJWZk1VSDZQSWtUL1R3OUExeVg5NWo5OUMvLytnOTVyUjZqdmpBL05x?=
 =?utf-8?B?eFl6bFUyYk9oUGptdXFJLzNvbHBHcVB2MEVtMTRQdmN4QlJRTXlzQ2JQZ2k2?=
 =?utf-8?B?UTVLU3E4TzFMaUoyd2RNeXR0S1d5TUtCempjL2MyLzZSUlZjN1F0cUNiZnhl?=
 =?utf-8?B?VFZ5Q3ZUZ1ZXay9kNDRrdTJFUHFFcUNDNDJkVjZQRHBhM09vUmo5YUlzNUI0?=
 =?utf-8?B?Q2puSExGcmxBY2RISHZjaEdhb3ZJd0c2Rkh2OFViSXZkK3B0TjV6bmVoUVZ3?=
 =?utf-8?B?citueXFPMDVEazk0ZTRLQ25vb1V5Q2xWNmM2S2FNUG1VWnhvSkMvN0tWM3NC?=
 =?utf-8?B?dUtyUTkxNklJOXR5NFZBa0J4YVZsMUMvSDFudGlaTWNxU2VhNCtHbk51cnkw?=
 =?utf-8?B?SHZQWTNLdXErK2FiemM0UHNSb3FqcUQ4dysva3ZiTWN5M2FJeWlwYVhrMnZM?=
 =?utf-8?B?NnhHNFRQMGNRc1dNcGcrN0hWbG5RbSswWTgwd0FzdU4wNFlwd2s5K0hNaDYv?=
 =?utf-8?B?WFBDMm4vdEhha2V5enFLZ0s5cDlTOXcrZlcxUEFrbG5UOWx0c09WbmNrSlhr?=
 =?utf-8?B?M0lYaXJ1dGNCSEl3Mk0xMm85cVZKcVdpekhvRDc1SFRQWS9vcDBoaVQyR2JY?=
 =?utf-8?B?cVgxSFZJZkdsZDMrdEI1ZlcyKzlGais3a0hDY3hUVGNyTWo4cUlESGJNV3pN?=
 =?utf-8?B?ZHd5a3NvZUlEaDVTSWtZNTIzS0dOeTNPanVYU2Jkc3pzMUlNemNJR201SVpk?=
 =?utf-8?B?OXBaUWdFMWx6QVVWOXN3ekxIMlg0N2hXbzdIZDZkS05EcDNMZzI0TlpFaGc4?=
 =?utf-8?B?NUVnTVlHQ1psN0tCWlZacWZiY3hlV0x2aXpYc2VPZUhDSSswZjBIL0plSVhx?=
 =?utf-8?B?QVdtRUFSS2pjdTBNZW9IUFQ3Yi9nWEZXL2xKeHh0eGxmR3hmWWViODV6cDRq?=
 =?utf-8?B?bWpZM05IbHNXWC81L0VzMkF5NExBcERnbGtnMnlFZ3ZybFJEd09DM1NZUGs5?=
 =?utf-8?B?cFN4czA0cjJRNGNFZGY5cnRmbll4VHZhRDhyV2FQR0gvQ29TZ3JsUGtXTmQy?=
 =?utf-8?B?eTdQWVliK2NPdXh4NzkwZ1VhNmxYSkV1L1dLOXNXOUx3dENxNDluRWxBM1Bj?=
 =?utf-8?B?SXpkSzlwNjE0YTluZnRJRTdrNUdSR1JpalJBQjVEMWQxOXZzV3NTakJhY3oz?=
 =?utf-8?B?Y1JueGd3T2diNHVQamFRcHlpQlk5aXVTeFhMbUticUJsTE9BSjVKWnk2bWFM?=
 =?utf-8?B?OGNKdngrWi9OaURGQTRBaExTQXFkUjBxUWVqQlN5WFlmbTVYRW8yaHNSekc0?=
 =?utf-8?B?Q1h3T0d4c1NBTC9Jb1c5dVdHUGhTSS9RRlV0UVNGS0p6U3Y1RU1rMHdZT3JQ?=
 =?utf-8?B?YXE2enBjZHhPN1dsTTRSUVNvNXpZdVk1eGRMdzgxL1Y4clRJcXVjdXVzMGVi?=
 =?utf-8?B?WVJld21HU05PcXVGakQ4MXFBdy84ZVhNZ2F4V3loMmJyRVByTlQrcktrSUhN?=
 =?utf-8?B?a3NaOUxYWnNWQTF0cG1Za2VseGZkMUduMjlFTEJ2Zkl2Wkw4YTRqQWFkVk05?=
 =?utf-8?B?djVEMHN5aS9ZWmtObStadGxNWU9NZWJjRzJQL3FzNkxxOFlSVHVVQm1tVk1D?=
 =?utf-8?B?a2J4K0tNZXNTNVpaTWVKc2pRMWkxZ3hieGMwT1pLY0kvdDNJY3dCR3AwK21V?=
 =?utf-8?B?dkZEM3Zwakp2UGZYWXFVZUdjK3U2dFZ3bW9hMEMyaFp0WXI5SzJUZzFuRUFm?=
 =?utf-8?B?RzJLdThGTHFBUDVNMXZFNUl6c050cHZsdlEyNEtJWmZRN3NBY2IzK0lCMS9M?=
 =?utf-8?B?bFFaWTcwLzk5NjlQb2srM3hLYVhmNXBRaWpSRDhEdm5wY3VzQythN01DSWg2?=
 =?utf-8?Q?0qobfuQIB1AV06A0Wj0M8VJEH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9195fc04-7526-4576-f174-08db8d8d000a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:33.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R508bRrtVvNwVFdspoPTKOLOPDFnwShiuxJqMPiped+jd2sV2Z36uZo7RQ1aCaDHJnwlcEKT1O2xoKGoRLRXkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-xenon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 08e838400b52..25ba7aecc3be 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -578,7 +578,7 @@ static int xenon_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int xenon_remove(struct platform_device *pdev)
+static void xenon_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -595,8 +595,6 @@ static int xenon_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -705,7 +703,7 @@ static struct platform_driver sdhci_xenon_driver = {
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
 	.probe	= xenon_probe,
-	.remove	= xenon_remove,
+	.remove_new = xenon_remove,
 };
 
 module_platform_driver(sdhci_xenon_driver);
-- 
2.39.0

