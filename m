Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2152751B19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjGMIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjGMILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0032D5A;
        Thu, 13 Jul 2023 01:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAfG8K8oiLmTcxK72fLT+71a0lDjX4zaQvspW/GQMcf/xXz6UFfPfq5GqCdpuLKYjSbLZyNwU7Xfk2OmrN4Mtv74m648GsE+WVFxfRszAy5QvV84ABlHqCuv9yiOSbi2ALoG6WEpof5w8LANFj6JRLiAfED8x7DKt+TqQQWN2pbsK8ZCwoi9wXBg2rOT2qZDYl6cudFs1+1JoqQ10bp1uirGW5OAeUADicgDK7T8L4oTLOkcUmmB/QY0Zn2biLOe+REYe1Mq+5fYOUd/CQ3KsMxRkanimRwWq7wS5Zvnrj8ezm5LYkHClIRW1Sk21dshRF0KZ53zYVGqtYNGZqma3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpY6vRX9+fV+aGIzDgKV7CSAOZ5ZunmmE0jQlRuvPxo=;
 b=HMDq/X6m8bBQTyDpC8haWdynrv7OZlsenJCXmyUfy7puGprKzenCJDXaI55iFwo2NgNrvilEvnaEVHkk6zjlDd4YW9d6yOZ9A49l6WAr7gy4IXC+fVhhBuZyCabKNnqNqG0/4gpt7hqWO2Hnyux7/HBPdF+A1jz5Ipej9qP6j6dJzcx7hwswhAQit4bz9nTX7y1ECMDE3L9CoBnHiS8++enqdSFpm4c0OxwbLlhqDgIefbRTAcwbTvzWcQ+nXaMQ4IL60oS/twWkhVmx+fp2q7jIzn77GAKwXYAmq1r4PKUCJWIBgx3dEh+PnBN5Gczmyu7e/05j3qju3DzlAGeftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpY6vRX9+fV+aGIzDgKV7CSAOZ5ZunmmE0jQlRuvPxo=;
 b=fBdcHnbjZ4vhrGI5tGlAbpy5gZBD3/cA8NnwTkk7DgfG6+45KCQDMMqKJKMCEm/AE16d7hux/ry5m++NgMfa87Is9RmpZJk3onauAfsealPbxqGntE5T2gJ7VX0UBQU3+ibVm/C3f+/R4KM5cqiZW0m8J4ZwZqzVMcCNS8dbLP4oBq+56jcnE636WLvHLLw5UTLvTbzEodfyWK1D6q3YqqwGyighH/WtHWnnFBGNp5sTEAmMXH8iuJYQZmDIT/wI2H+nV9V70VOGNmKVQweVwXzDkg8jHPbPp1Kjy4fqM5BoA9/IVo1EnVxvm6tu/DPgihQPaU/6Q1WidGaba7SjqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/58] mmc: sdhci-of-dwcmshc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:37 +0800
Message-Id: <20230713080807.69999-28-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: d383a0e3-4b9c-4f4b-2098-08db83786f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHzKSCmjj2eVBEtw9yVNG6ROnYxfU9u302A5Ot2ZwOzOOo8TdwyI6zvq5oz2k9RGGybaNoC0URrRo4KiqK6df7we61dD5phPeII4sz3PD6qBbctIP1E6i5Ys+8TIaC4CX9es8I1t3zeiqoGhytsDzJp2vP0KSZ3i0Gwt0HoQGbaTuxKgC30yebc+Xlp/lWaIXiE0zIbSoLKMGlTgTNTJKL8Zmwd/ZXuSHWpS8U09tcnHxNmUZoamPr1J3lNTpuwXxr3FcuagT1RKKGVvqoXjkGzBBLHC65z+g3c4KHBiI7vtQs7x2tIMyFT2RMCneDgzkAXyMLr2KFFhxZX3z7lqkuKAd70S7wwXXNs1OoENqsvKXAVa8Dxdf5BKyxKEX4I1IWM2M8l2DaVSzV+7M8LuT91gxK13c9Ac+0v48LOQpwIMAUt3FJuDa1vSGAfN40h2esRbH1Anq4ztWexLSMXaVK+0DP7/FG3lQFIGvbSLqxNy1jvWL84PNOkEVq2HU13Q83ttyHZowi/Z7us12XUX/1hMld468YFojBbbGFiVyEfIOHKPobYXr+xCLMjt8kKOUmCq47Sa17DT+wfWhb6LHFOeQ5qlHleePV790Fxy9WFZimCO3eKz/1cccZPZZcV9d9cwnlLz4hxyWtuGK1d6MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002)(133343001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TElka0JucmFlUXlWMWZmU3RlU3dMRXYxSWNBZmFUMHcrcExhNFhjQVBMOTFO?=
 =?utf-8?B?ZW9pOU5uVWlMZ0N1UUxqenFoT2tyaDBVdE5sLzBtNWJ3Z3FPUFJzZml2MzFV?=
 =?utf-8?B?ZE1GaGRjMXNpOVFlTzFDbVFBOFJYMFo5d0xNVHVEdEM0Q0JUekgxM1dERGNs?=
 =?utf-8?B?ai9LT3FlMjdtbmVXREVWNWVwSGNQSkI2U1B1cjdmbDRqa3FaeEt3YkJzZkR4?=
 =?utf-8?B?VWw3NXFqNk9QQTY4UTQzUENmZ0hZMWlGTTN1ajVzUEczY0gwWkZqSnBqWW0r?=
 =?utf-8?B?YWFPbzIwN3pKMTdkYkI2V3JzRGVDYWxTNlVsWDF6cEQ1dnQrZzdObE1yeVJH?=
 =?utf-8?B?c2wwbEprSHdESGl5UXErdGVXR2FjQ1NPdTBjYmdCUHRjcW9FNnlVNjJTQjZJ?=
 =?utf-8?B?enJod2NvQXNQVHFKWWdMaGdpTkEzSnZsRjk0bzVRRVVQWk1tUTVPeTBLN1Uz?=
 =?utf-8?B?bTZGaU1zK0pSQU1waDAzSEJ3UnMxbkRuMVBBaFFuQUlqQWFRZ0tYcDR5YVJK?=
 =?utf-8?B?WFVLZHJXYVZZenRLUXNGR0NsNFBFNDdTbHJwdktZbDdsTk1aS1J1V240K3c3?=
 =?utf-8?B?WmxsUUZCN25SbjVoZ2IxSi9GNWo2N2JPZ1AwbU5uczdjMWc0dkloQ09GRlBm?=
 =?utf-8?B?NEJIbDBWOXJUMmo2RmRVMGZGb1VGSVhWa0ZJM0ZRSW04WDNUYUUwajM4NmZV?=
 =?utf-8?B?TTlLTkpVZkgxR0wrZm9jSmxLOUJhdEF1eGNOSDcrVkFkYmNoUmk0dEJTTzBi?=
 =?utf-8?B?SjRMYnF2QnE4Zi9ia1NxRmV4NmRvcWdlVXFvWG9yNXg0RFplRFM4MFJLaE04?=
 =?utf-8?B?SHdZWFJPSGhnKytCZTBWMWtWN3VTWnVzQ2JVYVJDbWpMVEtLM3N1Ynk5MDZv?=
 =?utf-8?B?cmhxbWFtZDl4dmZISHRRTmxZTVVJZlNCSHdqdDR3YVVrT3JRZ2ExeFN0d3Bl?=
 =?utf-8?B?QWxjaG1hTkJRSXIySjMremxteWVRNlNTNTYrYXJTTC9VSEtBTTYvK0phbWxT?=
 =?utf-8?B?Zi8zRno1cGdaWUpadGlnS2hCVnRJVm9sTExkQXhaakdwSkQwbXBPMkhWRTJY?=
 =?utf-8?B?Y0s1M0NWUXVYQ3VSQ0JjYkFwNldIRHBRZGFCdkM2MTVCclI1MkJXUWNvRTZJ?=
 =?utf-8?B?MFhVTDd4K2w1K2I3YWNtOW1HanZ2aUphU2xZcjBPMWtvTHlLZUZFSGMxaTJZ?=
 =?utf-8?B?SCtIK1VTS3IzdzRFRUJ4ZVhuY0k1cW15aC9oczlBUmxzdHZhZkRRY3lxSW5k?=
 =?utf-8?B?V05xb2xQMEx5NG4yNlE4NUQwSS9iSURocC9RV3A5dGN6My9CV3ZSNEJNS3Ni?=
 =?utf-8?B?blVSdUQ1K3R6OW9wUFZwQk03M3hUTDRKY2s3alU1UkViSTYvMmFwb3BUcE9V?=
 =?utf-8?B?QktwVEEwMjZyckJBWFRoVlhKOFMxU2RxR202R0xZSVpUR01aMkU5eUM1SUFh?=
 =?utf-8?B?QzdGbFRGaG5FaUJRK2hvQ25rZGxEZ04zM3FSNGRjUUp6NEZGcFdTZVU3Mjd5?=
 =?utf-8?B?V3VicTA2RURWMGU3RGxDbDNqMENXOVkzcmZZdGhKZ2lIMUhrSkVGSE0xQkor?=
 =?utf-8?B?TmkxZkwxVXJ3dVFuc2VjOGNhc3ErM3J6dVFENnJHSit6MWlJV0k2bDhzbVVm?=
 =?utf-8?B?VTVyRjFQTVRNUlEwTFNsOGlnaDlkL0FpMGVMZzBqd1hGS1gwOHZVbVR6OElU?=
 =?utf-8?B?YldBVkUvS0VpRjd3RHpzaURaSGNZdUtQbWNja1h4TU56MlFLWWljK2NzQXJ1?=
 =?utf-8?B?elZCaUo1RGZ2cUNjVE5oU0xoN01kVzVlNS9CS0R5U0JXVFFPYnZzdThPV0dW?=
 =?utf-8?B?K1d4UEtjdEhySHBTTUZKZzdHckVLako4SkVaVHZOQ2pTVDlWaFZ6dHFET2pv?=
 =?utf-8?B?SnY4OWNDbFhmVmFQTW9GQzdBdFd1a3V1amRNbmtIY1JnNkFldHMyaHlFU0xQ?=
 =?utf-8?B?YWM2WS9kMlFhWkx2Uk8zNFRvdlVCaW95TlRJZHdaMHR6ZFNkbk5yRmZkTDdv?=
 =?utf-8?B?dzBYM1YrZjN1cTRlVjVOb3ZCdUt2T1J6a3hjZnE2cGJ2UnI4dE5zT3VWOEpp?=
 =?utf-8?B?dkRUMDJuR0Rpejh1MVVRMktyb09ONjJ3aE1qWFBhWHNkREF2aldEdlQvbnNS?=
 =?utf-8?Q?5ZBzSgkIyKAQ5/OeGfrHPRVkn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d383a0e3-4b9c-4f4b-2098-08db83786f67
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:09.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6n7Vr773Ei7oycpmUGyAJqiWWuGrVWIelnE6zbtB6oFXNFfffisfLHtwYx/3SNN6KwDCyTWCfF2poWhLe6Mo2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..5cfd24cd33fc 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -574,7 +574,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int dwcmshc_remove(struct platform_device *pdev)
+static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -589,8 +589,6 @@ static int dwcmshc_remove(struct platform_device *pdev)
 		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
 					   rk_priv->rockchip_clks);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -657,7 +655,7 @@ static struct platform_driver sdhci_dwcmshc_driver = {
 		.pm = &dwcmshc_pmops,
 	},
 	.probe	= dwcmshc_probe,
-	.remove	= dwcmshc_remove,
+	.remove_new = dwcmshc_remove,
 };
 module_platform_driver(sdhci_dwcmshc_driver);
 
-- 
2.39.0

