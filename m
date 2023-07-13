Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD9751B58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjGMIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjGMINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865433AAE;
        Thu, 13 Jul 2023 01:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFG+BmRmKmBMGzF81Gec2TEtUeH2wCPksSuqPKXwnaMFghL1houS00jyCdPhmhtdQZ3kQaTn3F4jcLJb9OKeCfLIC8zbG1Rofl2dPba0fLaIIWdZCOESBs0CfZcr5vT8/uqPOOGyOgRnJvnHM/Z9AqEBpuw04YLYAMp5/bmiBEqpKi2ZgEVLQedMfZY3t/M8y6Zhl2QKRCEftfOvqKMbEy1xcmGsVlMOGlHOHi/UP5r0WxrUScL+K8wj5LX8B33+VgbOn0jpgAaniOiaIQIt/6+VjwwLAnAaUBgs75IQOHACbbuHwB4XNOjQq3dy28KYzcoNP3FGq71fInIyP6sySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn1Y0HfAvqC4vDw6hlHUiBXNgQB8DADiyKB9NqPTMOI=;
 b=HrK6z5AMj70je8YcmBcm+vAiO0m2WcVgwXTDVMTYp8nmf9+8W6gQn3OijJMXAw3YEOFnQZMrEdKI7jBier8e9nJopbbhq7DX3gVDDuf42No8kTZaqw0MzrLPkS6h7GCv63LFcLDp1i/WJhsFOJZr9DIACCbA2kzRZqG3NmUG57SuhO88bY+7uL4/2BuNDSpCkwcHDlMGqQj5zXT9Gc9ukr+zZSl+zeCRAx4E8/WAmgfGs80O3AmBXrYK1zI05kkG8A7KyYiLnZx3ZAzmFPqMrrAdUH1qThQbUbRheHlKtN9fFpBRyDnxZL6Sq3LG1SqbZU3gHPHQWU9rkbVD1zSTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn1Y0HfAvqC4vDw6hlHUiBXNgQB8DADiyKB9NqPTMOI=;
 b=Z55meHdKQBxF+JqyXbyIabX1IifDfQOgcmwtPCZDM5VAvamkzuAArkKHEOF2a98n5fg30eo2nTpxH+ilIkPGkIPnwCDLZwbfPzOGix20xU+f+VbSfN9tXhoayA6xzmzS93Way19lF/nrCkp16S98XKQ+HMa1QiwNz/cUo3XAVR8Tx6alVi4Um99hiqucl3GQjxvT8AMXTOx3Ox21HAFXsPgu7NUXP4PzmonzgKBDh+dOpPV3eg5N2f5nHKHPVRylEOD53zDwesMIaNymP6gHqFhceH9tE8IhyFPom7A+DKpUJrEnZRKi41Vc9V+lw3XPf4YzjewRTPNOXjaMSYJ5rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 57/58] mmc: renesas_sdhi: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:06 +0800
Message-Id: <20230713080807.69999-57-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b64e81ab-a4b7-45ce-b5f7-08db83788dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+ncANHYyQaFGAykaVamhdYGjzksWfXuh4zQq6Ms2iJ4gRtueekeM0HJDXIQuGlJsh8yQMCoDZE1DWx1jIEdLrFK1XWGmOZBtGCJS1t3sFoclx6UiSn1S8k+4jKthCIBjo0vCZLRQXF9dtLds6qKuITesZeK3DT3anURlLMvMHZgGK2jiPE5GCdyHXShVD2mThm204TElSZjd6F2szewW1VCUSHpnY2wpZybCdGImNaTEVxJsLDChEJQ3HehJZcc/ddc/OPGIB4UTz96EiDaxChOJMM9mYAfiPpnBRtA+JEVyG9a9Z0h6ypVfXJuG7XjeE3tuSvnQ1VeTR8CpNt66kD7ltvaFoDlCSGD7FpDv8dUls5ps62edg0sfP1BSU4lde5Vr4CgvojJLi79lHAXb3QoSF08OYQMOSKgeU61nzDTM+lRK8THQZfyxymdgOmoJWeQeB1VxU2u1ZE1+Cj8RaESpUAOFZ6Jji0YRarO5KP8Tc+2UqgAc8HYJQn6NzCky+LgZfL+cODu/EOrci3Ly7I5WFj3ez9YBwwEx3G0P0o3hGdqTR5m/461sSvuKF/1nAsCckWibXjJ7Qr32e4OWXiLX6MNl7pkOamNvg5Iwk/tmpcz8kj73gm9M15eWUpb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFWVDhPWHZ5N2dhMUg1L3VuSmZpM3JZK3lRTjNRaUNDVTNRZnJsdzM2aVZp?=
 =?utf-8?B?bUJBMm9YcHNRTmM1WllhMUxpclQ5RzdQOWtVRUh1bmFGWkdlejl0eksyZWlC?=
 =?utf-8?B?UGhZRVNCUjNEL2V4b0VlZmRLbVcvUk83d3BPK0FpUVdaUnNhejJUdjF5TEc4?=
 =?utf-8?B?akNiV3dJcXBjT0cwc0ZkWTBrMkZaWUFuYkxYZUNXcWFYSTBjWUxxZXY0QTYz?=
 =?utf-8?B?bXlycFRFV0V5ZkFoTkVUWmZqTUJhVXRETFVjZllmVjA5dm55dXRCZTFWWVcw?=
 =?utf-8?B?Q0hJT3hoZGdUeGxkYko4c1ZveTQ1Y1hpblZqaUlvR2lKelowODJPcXd4cXVw?=
 =?utf-8?B?Vk51T3F0bnh4K0JmanVWaGlJOWdLQk9aVlNPWmorNk5nc0VFV0tVZ2tKRmR5?=
 =?utf-8?B?OGpTNU9vWHFqVDFnbXZsb0tKYSs1di90UHU4aG5zZVZ3MjM5ZzB4MUh2NWpF?=
 =?utf-8?B?cnUxVUhJTjA0SDZBQnZUcWU3OExiOEcvdXFUM0IxR2FTbFdkTUpWTzJ0UENF?=
 =?utf-8?B?RDRGaWxaQ01CWlNRbGtPZG1jTW9IcURlV0dFZmRXL2wwTXIrMVhGV09EQTdn?=
 =?utf-8?B?Rlk1eVlJdFl0alBxVnhUNkF6VU1SUitXRWZHQkpKcjl4NllxQW5zNG5GSkRz?=
 =?utf-8?B?ckNERlQxVURwcWpQQkNmNnlnNFlYZHdSdmZraWNUSUdhTkdWRDBncTRGeDEv?=
 =?utf-8?B?eVk3OTBobkF5bE5ZeGJNdnVpbURRWnVGNGwzVHJ2RkIxTlRqM2JkUVYrYXA1?=
 =?utf-8?B?RklTbjFwSzBYeGFxWFdwNWNRSExSZU1HZE5aVHFqRUlmYUdaMEp4Mk94WDJ2?=
 =?utf-8?B?eXRrREpHa1Q0YUVVK2h2T2xHSWs2ZnBCMzdoZ0JYSzZoaHRBdEJoU0FWazRF?=
 =?utf-8?B?Tk5jVGJ6Rmk4Z1pVZWU4eG0xNlNMbm9ULzBKaE5FaTl2L3dQMGlQS1RhYWlp?=
 =?utf-8?B?Ujg5cVA5dFFFNkdPRjc1ZGE5RHY4WHJ5eXo2amw4Wkh6dEhKZjNsZHVMTUg3?=
 =?utf-8?B?Wk9PdWpCT1puNTFUQ1NldGZqcitFOGlmbUFuZ3B6cXllNlgzTHZMK0gxTFN6?=
 =?utf-8?B?UmNWZ200U0xlU1N6cnd3a1l6ekZiTTQ3ZnZSckxOaDhpUmw1NVZDR3dkeG4y?=
 =?utf-8?B?TGlibE53UjRXNE1GaS94U0dYSW1ZbW5GRDBpR1VSYjc2U2U3MTdZWnEycko2?=
 =?utf-8?B?ejJiSHRFQ0tkSWpoV2dpc2VTTkJUb3VydittVXRxMjZUVG8zU0FUOGxDZ2Mx?=
 =?utf-8?B?em5DS1FIR0tQUktGdTBtRjJ6L2VsZ2ZpMkd0MjJ1bFNSWVhVWGNaUnh1NHFI?=
 =?utf-8?B?a05FcWROdWtMSVBBbG9PeWFMWHg0TjRTY2dEVm0yRmR0Z0xBOXdQVGlBTW94?=
 =?utf-8?B?cktFaXkxcVZXMjRPN3I3N0UwdCtON2RBVTZpVDFOeHVLWlVuVDRDcEV4VTk4?=
 =?utf-8?B?cGhIYlU2Mzhlcmd1MWMvSk9TR01xOGNUYXpkdXJ1bWFKZ2tuak5qWXZZdWpO?=
 =?utf-8?B?enpOYUc4cjdzRHBxSXByNlRGUm5hQkhKMU1NQTFxU0JFZTdPT0s2b2hkWDhF?=
 =?utf-8?B?UTg5S3Juc0hvcnVscW1lMGNiVmVEbDhmcnVPSnFZMm83SXlITkZXVTIwQmdK?=
 =?utf-8?B?QjUyOEU3bWRxME9OUHJNV1p0VUZGcVdsa09EQXhUSEJJdlFnUW4wUjhwbWwv?=
 =?utf-8?B?NlpuQ3pQK2FJVDlsVXF5NUFXcTE3bTRpZWlsTUhQZ0MvbnR6cW91ZEM1d2RN?=
 =?utf-8?B?YlQ0OWp0Y2RGM2NkTXNyUmgzYk5zT2trUDNFbTVYWStPNjdCL0cwNnRyS0Ex?=
 =?utf-8?B?QkpqVCsxc29GZmFPc1lmU2dMSTlHdEtScnpuUWd3Znk2TzVxZlUxVTUyeFc2?=
 =?utf-8?B?YkgvZHVZQnBnNWFJS1g5VVZlaFhUbVFIaXNPeW5VaFhlUUxyak84bTg3Szdi?=
 =?utf-8?B?dWRqMHZFVEFVeHdURnZ0RUhGa2xnYkZzMDRNK0pUeEF5WWRYcWFReExrd2o4?=
 =?utf-8?B?Q1FYT1Q0bjBQNjcrZkNSSy9hOFcxbVV4bnVPK0VVbnQ1R1VYRDlDTWloNkcy?=
 =?utf-8?B?Nmk2N3hIL3phMGswNi81R0FxYWxCMzR5bEdDcHNjakhDbytEVkpBYldtZmxR?=
 =?utf-8?Q?s/5cf33YCXzf+QFq/sIrIpSS3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64e81ab-a4b7-45ce-b5f7-08db83788dfd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:10:00.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTFK1CBr3S3scj23z27BhXRGu/Qpq4cO84XNpol+x9MJFf4PA4EAVEgl8GRPUt+ablYtCK2TJBwQya7s49vROw==
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
 drivers/mmc/host/renesas_sdhi.h               | 2 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 4 +---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 68da3da9e2e5..c1fb9740eab0 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -101,5 +101,5 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
 		       const struct renesas_sdhi_quirks *quirks);
-int renesas_sdhi_remove(struct platform_device *pdev);
+void renesas_sdhi_remove(struct platform_device *pdev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 345934e4f59e..5d3adef144d7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1145,15 +1145,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
 
-int renesas_sdhi_remove(struct platform_device *pdev)
+void renesas_sdhi_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
 	renesas_sdhi_clk_disable(host);
 	tmio_mmc_host_free(host);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9ab813903b2c..d8efb8035b1f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -609,7 +609,7 @@ static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
-	.remove		= renesas_sdhi_remove,
+	.remove_new	= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_internal_dmac_sdhi_driver);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index b559ad38b667..248dfeef942a 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -470,7 +470,7 @@ static struct platform_driver renesas_sys_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_sys_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_sys_dmac_probe,
-	.remove		= renesas_sdhi_remove,
+	.remove_new	= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_sys_dmac_sdhi_driver);
-- 
2.39.0

