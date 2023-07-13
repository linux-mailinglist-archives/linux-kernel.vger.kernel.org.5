Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29677751B47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjGMIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGMINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3E42709;
        Thu, 13 Jul 2023 01:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIZ9YvSl/nmfAebVWG1I90bHS5PRDjV9V+3S+vCyi5AX7B2KQTwjuQNwf/4RLJy7Nq3BkmTAGIqCFQxYecKoWTSsY6/6gdsyq5lFUW9+gxSqBSpxo3cOVVad0aJqWP8nQdO3hbqskJmW3+5Om0mYwDF0nExJzP4v96KqCrUZ9RztubkUy/uR1a2SvtjZB9e8UVg9/INy3VdJCjeL9U+GtYf+CMRU9YBc4i6SEsq7ZrohdyZaiZF4NpwZ5tK/ht59tRlv/hjyREWRX64DkLhRdCZkCNyN1+YO2+cGJWCZhtSN8VXKFm1UXIii2XTAOpyJ5eWDk+A3dDQu7LsDivfp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojpLTgBzv5+ZNx3nkgEvgE/P4GpJkxrZ7R2nyuhf08k=;
 b=gxXOqPl6cQgFGjaU6iS/BXkClbFhywTjjhMOkWp0XQxeWHYd3OGoXRkSPW2hJE5iOd+jnuZRhf4QVxE+1ZsXPQiCLi3DC6Sps1QNybW8T+rHe6KMfc8iEfXeeLSg9kx6pqQyfb02Okn2sk+xAluzKA57JewCawFiaD/SvrHXb0HzvIpVCaJXx/vMzLgtod2HuX7coYRS50qjNKgecZZohXZdp/865V4zyktKYTAhg6Io+WWQ1AceWo6fNZFrp0tXU76BuIGAoawPBZAMoefPSvezZ1bkPhksAztEPztOo0l3Bujnz7z8cKr0Kz3lQFERGrv3FXIyx6E2/jWfovmulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojpLTgBzv5+ZNx3nkgEvgE/P4GpJkxrZ7R2nyuhf08k=;
 b=qh3rwJGJdTTewpYVCZO5EWJBEjE9xlnjRsBANlBceMkI5RgEjcgArESVeAuMWAFLCVUWrjqxSHTWNljqa0Klo69x101S2YqYgI4EFBOKwLYsrXgMRH5skuH47kmz/kr9pJZnEIsE2ExVLFqqJKYaZudDLBy4S8tCxr1/Dj1dKCrqdCpmth7HyY6sfvNndeXyOVqiRPxp5J09mSve3DXkZXUuKRrVlfZzd00xo6QlohVpEA6naVge9dJD7p3RH7YWQqThxMXh89dvi968R3ev3yUJCh4sZ4vC78HZBgtmIibujFAG9qeAX6P5+lBHS7ZkjWLXxulwGyIDdVEbRKP/Xw==
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
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 39/58] mmc: sdhci-esdhc-imx: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:48 +0800
Message-Id: <20230713080807.69999-39-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d9d181b-c6c1-4d1b-4d71-08db83787b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2lo3VeOM0oFYnHX8j+bwqdHdrZyTCSGhx9cnq863lHCPWhsSKQVhSLJEz5Y4WCEsTjiIyRwXYW1bEDgq9PHdDSZVOz+Opcax7ta/7vTVZtrTwv4D0gFii6GhDPJfCuYogCnVh0XfQYfoz0eik3ulXyzOIjC+7txAHVS+0hXgFdtYpgCK4dJ1h8581QCrp1Cf4jfTmen+S6biGi4M9mUK+7pDStWd0uomIMHw2mDMQK2VVexMat1YfwG4RUjADNJ00pqkZAH+vWVhRrrVsRN3EF55zXk4gfNSZ8WobFmu8mDWiZWaSZ7hJHjVxs+DrU0+A/NA52q92BJXBPuye4YRzdkLu0HFx0JDKXHIEAOiiZ22l6yNFsX6g6/pgPSLWskzj1JgSWGDJELVyC1ZMSUO5HmWFeEp3RMdyl3kUzALsexBA5fZtgkHmtTfExoG2BXPHykIZmIW/jSunsJeoJ+dPSHCyxgTYLriVoXhOBv/b3XrlwAfMFi7ij9ZxlhrAt5c0D2o7OEmNrY6q53PJyo/qqAZluavXF03o6zxcU/1WqRNbCEvftIJ9IZ7GGmbpDA8HZflmJeT6FTrwclvR5bTkw7FHJ+lPN2uUp6zLKUrjb75TSYvi0Cb9j7Yz07sy9s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(7416002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXEzNDloa093ejF2d0FYcWZjRkJQSGFZUmx3SUtER0M0dHBrME8zNy9icXRt?=
 =?utf-8?B?MjJuOVlVWFYybnFrczdTc0RZS0ZFM2k4UFV3a3ZjTDl0V1Fyb0lWWEIraEJ6?=
 =?utf-8?B?Y0w2cHdkb0tuTnBUUWJHanNOdEhRTDUvNlRhODFFcmlHajVQcFNTRitXelhT?=
 =?utf-8?B?cUtLSC9KOHBaQWVLMkVHRjc0VkpyWVgyTkIrRnlzRFBjeUNCb1YrRXM2K3Vy?=
 =?utf-8?B?VCtjd3FxMkM2eHpTZ1lPVFl4Q0xkdFZNQ0tBb0RrZUF2ZUMrZ254VGVmeDJQ?=
 =?utf-8?B?SmJ6VWRLVDZ6Q2tpditLMUtQdU5oTlh2dVlmaDdoazhaNWpVTzVXMHNqQk41?=
 =?utf-8?B?c0QyOWFINFJ5K1RjdGZlUzdTaUFQdU12RlQwWHU3OWxPV3E1V1krcVptMmNB?=
 =?utf-8?B?Um00ZUkzMU9aalV1ZlBJVVFQZXFqWUM1clA4VGVIa3dyRXBObXU4cExucDQ4?=
 =?utf-8?B?NWhqc2RNOGFGYUNBbWZ1MUs0d1pkMGFUb0J4ODkrdkE3K05saFNnTzJLOEpo?=
 =?utf-8?B?dHA4THlPZmxNNjMxL09ZNFRtNWM5dHl0dkliblBVTTV3OXFkRnZqWUtZQnY5?=
 =?utf-8?B?a1lURFFsbEJyQ2ZlNmRSRFNrYmxkNEZ6c1ZLVkRhSGI4UXJ5RzRxWGg3NWRJ?=
 =?utf-8?B?ajg2T3IzNWY0ZnVCUHVIKzkzS1ZRKzhPM01Ka2pNZzBYS2NvS3Vod1pHTkU5?=
 =?utf-8?B?QmtmcEEzRVMxbzlCd3FlNVpUVkNkVnVXRHdid2NKaW5SQ01UeW1aaWgySFBv?=
 =?utf-8?B?Ny9tNk5LZzNFWXhpRVJGL2dDTzYvS01RS1I3Tm5kSmhnNXdlOVJtaEhkUHRx?=
 =?utf-8?B?OVJkWGZDT3Yxd2NkcWEySlEzVXYrOE40R043MHJUYkI0YkErRnczcVpaVXN5?=
 =?utf-8?B?bXo3THRaa3ViNURoY0JtQldHSU4xRVpBY3dRQnkzTXJxbmtNbXJ1NlJHcEtu?=
 =?utf-8?B?K09rcjd1YnNVTm1RV2Vua2pqTndnNGRwYysvTUNrSzdJbGlxSkdaSFZjUHRD?=
 =?utf-8?B?RE90c2NibTFDUzNwTXFJYVZCMjZubDYxdk51TUlMbHhWWVI5alRLejBaaCtl?=
 =?utf-8?B?ZmRjWjFXSWh6ejY1S0ZQbyt5NCtmL3p4Mjc3bHVJa3VWS0RERjVEYTRWblFZ?=
 =?utf-8?B?SXFjQ1RlMER3QzlRUXNYa29zeEhydm54T3U4RnJ1UTF1emcwRDRZVW14cnRZ?=
 =?utf-8?B?WFRXMFJPZzdnUnFWM1VrWCt1RmEvRDNCRWhxQUd2cFJVT0ZYRWxKakE5NnEy?=
 =?utf-8?B?TmtyRzIxN25JS0ZyQ1dVQTJtNnRXUGlYYTlybXhaYXEyam5udU9JcVBZdHBU?=
 =?utf-8?B?eWhzSkMwWXBBU1prSFdJREU1RTQxVU1EQjdxMUZJUmE2K0ViZUM2dlhVL2R0?=
 =?utf-8?B?MDVqVEsxd0lTZXc3OEdsTlZ1V05ucHRNTHVINzJ5bnk5NEVDRFJmVmxsREds?=
 =?utf-8?B?WXVDajI5bkNWOWFwQm5IODduMGlpdEtoUmI0N2xnbTMycEQ5YnVWalJaN0Jx?=
 =?utf-8?B?cVhONXQ0aGlUUWtHQXBtY3RWcUV2L2xlK09sdmw4eis5QXpSK3JUb29IeEQx?=
 =?utf-8?B?cDQ3N0p5U2JnSXQrcnZRVXQzWGxLNjkzb2tRV1MxN3RnZW1PdDNCaFArZi96?=
 =?utf-8?B?aHozUkhxYWtQOFJKU0JNcjZROWs2YUpWUlpqckdWQ0dtMmxMeHpNejhGdTc3?=
 =?utf-8?B?bCtzTklRQy9BejF3TDJhN1NoQXRGTEVVeWYvSmZ3NzlqMG9FU3RxUTN5WUhZ?=
 =?utf-8?B?Uk1jaG5Fbkw5ZVBwbU02dVRQTFgycUZGMkFwSWZBaG1uTzdaWVhzY082Umk1?=
 =?utf-8?B?RS9VUVZuNE50THBrTXExcGlXelJzL25zRCs0VWd6Q3dsWnNaalZCeW9PeXE2?=
 =?utf-8?B?ckJDdm5ianhrY0x0N1A0YnBXTmVCUFlXdnlPRDB6MWsvRzUxR1lmRXNPR292?=
 =?utf-8?B?Q3N2cFpnUUJOZVR1MDFtTmhWRjB0TWtsWlcwOXhEVThoNlpQMkZaMklxSFk2?=
 =?utf-8?B?Sk84QllQMFgwL2tibDV1MGdwandJYjFlNy90T2RwNlBYWStGN2ZhTUFNZUx6?=
 =?utf-8?B?RHdSTnZSbEIwQnlMajlaOWJxRXhHN2N4d0hiVkpYWm9oeitSR0hFOURSRE9w?=
 =?utf-8?Q?O0aJpFDRCDiOLBvAvNOEmJSCN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9d181b-c6c1-4d1b-4d71-08db83787b71
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:29.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TJBdXdwuXVCa3KrFUe0N/EoNfeqLU9IL0M3wyNcq4+P9xvMsdP/LDD+Te31xGjkBYIUdmW09cK8BmNNsqP1WQ==
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
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index eebf94604a7f..e882067366da 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1802,7 +1802,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
+static void sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1824,8 +1824,6 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1986,7 +1984,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 		.pm	= &sdhci_esdhc_pmops,
 	},
 	.probe		= sdhci_esdhc_imx_probe,
-	.remove		= sdhci_esdhc_imx_remove,
+	.remove_new	= sdhci_esdhc_imx_remove,
 };
 
 module_platform_driver(sdhci_esdhc_imx_driver);
-- 
2.39.0

