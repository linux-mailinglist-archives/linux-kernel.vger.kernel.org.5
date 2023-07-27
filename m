Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91D7647CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjG0HHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjG0HGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::700])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574AB44BC;
        Thu, 27 Jul 2023 00:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/sxdv6EOk19F9Hf/8AWI9Aiz3hYNydAcR8VdwvslG+mIxlhs0mVNDrP1eGjAL9aQljfTr0oZoPlLSVKxEdUMN5XwjnIB3y2ySoaTk7LLrzWcFBhtKHr6s5afEJAZ42BgfhKnKsCVJ7fibQBcuYPJ+zmRSMxptn3B9AjQLolcCJcg40dYUyV9bimwuKU8Vhes6DFBZQVhc3djqfTLbm6+5H+ABhQCeuFeVjTe1QLLddITzoaFEbK83GiYYnDmcfuTyDAwMfmtz2rYpsxyJhl+HOOxiiEN1crEwec5tpfK2TKzdrhxxAj83iDQv/3Uvpq87+bXUb68WfU2y/ssqcrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTZCoxTOibIiO72DCM0N13jMV2Q6b9NpBszadCYFgzM=;
 b=LHeGOOTVNGoUGCtMb4hoeGWF20M0ZPn/LwuuhOKBmGkIBElDEqX0SstwoztUunvF6IDXn3aZXCdefBX7tX2s8xLUzDlNVdmv7q80w/cHpJ9/6e9xDgRsfLRK0DpSz2JYinp8rmZarYBPvj1Kkvmx00GOSQfC7/4v6Z4/iZVVzRlPOTwrI0BmFIS4c1Kk3KU7L3nc8f1oS6cqIf89AqZO4RZn2ndW87Og1c7U6/iQAdBrQXLiHVFPP8KKL6B/cBEBjtteEAweDGnemz213i+odqWq3cPBB3I0+BAN8MjnUbn0UqCIQ6kLRIAPNizK2KP6IYg9SGAlk71ayJGeqqYliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTZCoxTOibIiO72DCM0N13jMV2Q6b9NpBszadCYFgzM=;
 b=ZpDL65tl22II+WkehmGiONo1cMm0RQWLGn75fKKAzzN67cjIm7lB6RFaS/o/PrmLLuSbg3DS7rrtcKetaHEYiunHC8I12dPZ5xzcKxIGgUVVmso+L8qB289IF9XZlddVktGfjguu4EW5FriYuW570mluSpsyAy2Au85S0oo7zNfklodl04PISNt4dzxwo7kznQReMwqiojVTpV98fZlWg0o8Nw8UH/zrwz+cp5AQPcLUcpkbCddHnooXiKpeJRaddbylxF3QezchAK9tkTpIE3ccR1lJRbCKH5AzgOn9lgHGk5y/u3ShZpybNJAgZfzITi6wUB3LIzpiyTdOGy2ZMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 36/62] mmc: sdhci-tegra: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:25 +0800
Message-Id: <20230727070051.17778-36-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: de7f1df7-c05b-4224-7dfb-08db8e6f6144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqWoVqebPJQB7wCuBPETBB5aeqaQEPcEnB5MBepM0eTrdqSMBxreuZ29VQy0xZjV6/H7v7OxiZKL7XDYE6cUmsHOQt7M0V/iHBRTXQgkxOv+Nnn3lLDFmV8dueLwmRflZuc9tUR+qC+jX0AO/vvB/0Y3vqt/0KUxJEzu+UecO9O9XrvaEUBnPJ/g7Cqz+eW35TDiywxzvrW2XNYrDxo01EL+a8oY3f7agtqq47tmR2mxnfcz/8a2U9ma6T1LV8IKafyfRYd0tkE17hhTDaQTyIk0o//w5nhwinw4/iouBBKo5+GCGeCTwdJudF8uOkGiMFYYe1Kymn9VW91CzouDtV2kxk0bNe8sJ/gvYSOOTsVPJUCDA+et7cPywmppVmU6unUUbKlwMcdw6yNwinnB8kYcT73l6WuysvwYSLDnNmCgGP4VfJJ/yM86MMAtDdk281l7dKszl2HHRplLJhPeXThZZ1l32q2cqHptAu6bo0ymDhiMX1UGIXgmZX4CVNym9RLjHItLacdaElSkYj27VY0IwuMyFvHxsAUv6+0RYyrbEyIhhBAjTX+soySH49wvyx7Sa4kRZGP7H5+OmSpJohusk1+F51nZgOhuL8e8w5lLAaR/KttfNp0osxknozpx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(66574015)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVU2azYxcUN2OUxsbUI5cmdOY1U3a1c5Z2JUQmVXSUtBYURvK0ZOR1p3Q1Rx?=
 =?utf-8?B?R2QrL1dIcmRkZCtocUltdi9oVHBmUlB2M09CNENRZ3k3Uk92Y1pmUnUzVWlH?=
 =?utf-8?B?Nnl2T2pBQmJVdkNFTjJnSDlkbDE4bVloVnFMU0ZKVXYzMFB3Z3VHb1BxNTgw?=
 =?utf-8?B?Z3NXT1JQK1VrNmo2RmREVis3c0Y4SlgzV3Z5c2VjRnlzWWZSejVMNzY4Nnk1?=
 =?utf-8?B?SGpna1E0SnVGYkJDVFp5a0lQb09CUVVlWXJPcktDdE9zQXZqdEg0RERNemVo?=
 =?utf-8?B?RmlFMWR5RHVtRFpQUm8zTS93MXJPYUJhMW83eVhPY242bEdOL28wZTd1VVF6?=
 =?utf-8?B?NEZoMzB6TFBIbk9mSkxaYngxbnpsZFlaa3ZUK3JDYzVETmtQY28zN3pVelZ1?=
 =?utf-8?B?RW1KTTA3Z1pxdExmMjRQVHdNaDBGK0NhMlNJdUpTekpWNW03NWZXbytuS29Q?=
 =?utf-8?B?WlZMaFdqTGJNOWl4MThvczhlR0RmemZyd2lCVFIwb3Q4dmQ2MXJZL1pXVGww?=
 =?utf-8?B?UXlDS3pqTVJKTHdjVi9kajNTRStMZDZ2Wkc2VmFJNUhaVmpQWnVlOG8xK0p0?=
 =?utf-8?B?V3VOVm5KVlZKdnJDNkpONERNb0V6OE1vSC80dEQxSGNCMTNrRC9QL2pvaFls?=
 =?utf-8?B?SzdGcHFqYnN4bjN5NENrbXF0bUJib1RzSDltTjI2eTE3MXlBbzduck0vcXRE?=
 =?utf-8?B?ZnVxOGQwM2FhVWd2NFljRFFTalI0Rk5rcWZDTFM0YzNBNXlTUDJublY4MUZX?=
 =?utf-8?B?c08xeGNyNHc5cFNXUC96S05VNitYc245RGx5ZGIwMEo1VWpYQlgzeUxjQXRD?=
 =?utf-8?B?OW9USDFSbGF2Z2RBQk82LzNVWC9MTitXbkdpclN1K0M0WkduR1JCQ2NESGd3?=
 =?utf-8?B?eEp5ZlJNZHhTbkJKOGxvNnQ0MTA4aHg2bENvK1hNYWYxdHhkQTJJWkduV0E5?=
 =?utf-8?B?dmJic1NzVGNuaDJIbGlOVkduM2YzODVOZEd4Z3owRy9KZXdZUVRFWjhjVk9y?=
 =?utf-8?B?R2pKTk9wNndEZGwzQkNIRjdwcU9wSzRxUDRPdUdOWDJ2bW8yby9vS09nVjZ1?=
 =?utf-8?B?QkdwQW9pT2UraHpoaklTU1djZjMzeTNXa000dlRnV2xLeHNSSEFsOVIzSXBT?=
 =?utf-8?B?SGpRdWd5QTFUZVFwcTlxNHprRWxKN0htWnNlWmo3QlNYMCtGeGdOSEYvWlpu?=
 =?utf-8?B?R0hUbW5pc3ZBeDBrMjFUVUJCOU1FUlg5UFB2VjhtbmZubEMvT2gyZVMzbFg3?=
 =?utf-8?B?ZXlNK25UelIvaHRKbjhMUG52M2pBblh0ZE4zV0dKSWV2Y29scHo3d05YRHNk?=
 =?utf-8?B?MHJEcEpHRDR3R1crUzZFSVJTcnQxaHgwdndhdVNBcGVoaTlmVzVITUVyK1FX?=
 =?utf-8?B?b1owdTR6ZGFZSGVBUWNmakpBYnp6UFczejhhQlJFL2dHVkQxblNwZ1U2Z2pm?=
 =?utf-8?B?aUVYbS9mcDhkTlpKdEZUaGdTQzZOSFQzbW5qUytlbDY2bTFpREppdFdERytp?=
 =?utf-8?B?ZjdMV1NBWWdnMVhnTFNFeWV0VW1MMjdLWjEvSFYwTW5aVm5iUnprZGdKVlk5?=
 =?utf-8?B?S0Fpb1hUNXZHZGttNUhhOWcxdURZbXhvbUlhVGZWTVgza1ZPYlgwbU9iTWk5?=
 =?utf-8?B?WmEyR1c3ZjVFMWxLNlpQbmVwWWo1YUFqWVZlNVFHdlllZVVNbWY2WVhtMTAz?=
 =?utf-8?B?VWE4N0lNcXpVTi9rekx1bmhKMFBLb1NLMFcxeWNMYlpNVktZRG9BS3I3YXJG?=
 =?utf-8?B?TkM4akFzRFp4UFZBc2FROFhrdTFOcGlNK3QwK0FucnoxbksyR0hGOTlnSUo2?=
 =?utf-8?B?L1lKRmJSRTZRQTJTMXNOR2EzT09DaE5OSVh5cTZBNGNIaC9kejZKMEFpYkNQ?=
 =?utf-8?B?anNSbmdyTTAzRm5sbFMrb1FDY1R4a2Q1WHpNbHFqN2xUQVFZZXJEZHhDcUUv?=
 =?utf-8?B?dDVDejFFaTk2WmRsTTU1MytiSnhBOTJwZmltTENBaGhQM2VSaE5GbTdUWXNE?=
 =?utf-8?B?K2VSd016cFB0YXFZaFQvZnlmVk1GMExhK3N4a0RXSXRyYlJnbnhXTGNjN3Zx?=
 =?utf-8?B?T0tYbWdVdUhZQzd4YmRjdWpSUjB1UEV4QS9KTDg1Rm5TM1pzV3haMk1pSklH?=
 =?utf-8?Q?tHIejcZ+kGh57EVeJCwFHWaLP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7f1df7-c05b-4224-7dfb-08db8e6f6144
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:02.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s79wE6s/KGV622dy+b5JffZVZeyXRv+179F5TND3m8+ZBKy42nlkCUCHnldr+HOsAbafUJdkPF82BW3Gln0Gkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bff084f178c9..6a50413afc8d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1818,7 +1818,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int sdhci_tegra_remove(struct platform_device *pdev)
+static void sdhci_tegra_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1834,8 +1834,6 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(tegra_host->tmclk);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
@@ -1933,7 +1931,7 @@ static struct platform_driver sdhci_tegra_driver = {
 		.pm	= &sdhci_tegra_dev_pm_ops,
 	},
 	.probe		= sdhci_tegra_probe,
-	.remove		= sdhci_tegra_remove,
+	.remove_new	= sdhci_tegra_remove,
 };
 
 module_platform_driver(sdhci_tegra_driver);
-- 
2.39.0

