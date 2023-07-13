Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A286B751B51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjGMIPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjGMINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EC3272A;
        Thu, 13 Jul 2023 01:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJBThyzzJiCwNittwYp4PUGRov9nGj3vUJekVmNFPDeROohoYdGNV8R98qpnH1k64nJbVFab1aNqYdGlVBLzHUI52i0SlNsp1G/t4XcBWLic4wpBO9T1JGrKrRahZxwQRuvaR42cloteFwIAXzCykXXuZa/DzWTWUitZWoqxEF80iULWuslpsXePilbiZB6S1OHPZNh+E+eeWBIiJ1bN6cdA+WVQPenrXvwgTRUNIymAmUpW0hUmfRLrJceYpnAHrmRLl6UleHMWeOgxncaX0juoAnn3st1iUjEZmYme9jEIdy0udPksJnz4WfsbIKlk95Cmnqgg7Dco9nSEX5BeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9Dfs5F2gSSKlNfyHZt5vKY/Z4kFZTv/2MR5XySfA8w=;
 b=W4FUOyCQjezyC/7l7rQlm+9CAt7sCBggsHhelDjEH+e5CmeF62xeTPXSFiFQnXARflZeuYXEse47uW+OZbN132lUie7Xe2nk+RbCIs8gi8AuUFJ5tM/Bij3Jmm5Jj1STvW+/iwZumm9L4yICc9X5B/kLiHcvpgsMASGt0/AudUpHDnSbUiv0b/AUfJkWiEZGT1KjjovdnqiyIZyP1r12UL1h/pPBZrwMSROPXPVg9hvK61K2jEgZXeIcSZaV+3qxuQBfKXP7PFxgRPK43I73R8rwSRBIZ0MHu2S7YRukS7cOoZPzjs0r+yJFlaPzpDJ12jH4DRfJKoGg4t0WhZimng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9Dfs5F2gSSKlNfyHZt5vKY/Z4kFZTv/2MR5XySfA8w=;
 b=UISrpoqiEOwUWaLBvo2A4JbmxnDnTrdsWmUrMOIkeJfCiW/vLMqfaHxyf8uKcoFFpGicFk+2uvI+VW9aEBYTR46f+SYahsbaAHoUE2aNcR0zmq3bT6Pp6YweSK7OG447gGi8gyX/itXgb9PszLH5s/j2+UUnxd1LLSOjdNloxC/WKY4v/TnGx3sQAKKzjOH4hk8l46R3bypoKo2PeU4rlkwdbc/W5ptiILb/uZ/KbzRzj8PZfZFndMIF3vVpZP984ThehkhaEoksHI7fPeRX8NG/rni7I5egoAMWZ92uKYjL4HwHJZWXzBv4X5l9BcegNjHIo2fU2nqkOcRZ2R9QnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 49/58] mmc: sdhci-esdhc-mcf: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:58 +0800
Message-Id: <20230713080807.69999-49-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 196059cc-3ff2-48d3-8561-08db83788632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwyLlIvjgaPBNtEIeSotWGjnE/0ui97yaC0vd6tVd3xrW2w/Wnj7bVm/u7Ia9LTrdz91ZJqLx+0QRdT/G50qlOVHxRyF4cVBO+l2pK0kGXBEXa2E0Ppc3TK1yLBzDGRm7bRCXnc6BGj4IQuoJlwLPrwGhFCd9Z64mGczr3gFBxh3wl64I4kUABoqbxywkuM9CoWTsSgF8Rol8aVIdAtuoyy7cKSosrcUnV9yuhCJmOKMZMXcowZDaf10igT+zwqPWkeZZOHXbPLtlbMZJ+aUiAOozr798WxO4m/cAZraNzspPyNdnMp/6/MnqugKPEMcshX5NizsgRNZIdjdInnwHC6euh0JMIW7O/l4guDfh4KEAovG07qcXqzTboOGUbcWPM630znMbVCf4BPdEYcQZT/SdVfIzdgE020efQ4DaOkFyLTZgL+BTecG3dwoLX4SPGHZbreUvV5dIUX+EtUvq7RKd4F2SG8vyN3JondG+LKUfT99zqCsp64UlOuuTYN9i0YykK9muFbDF2QcNOpWgju3WJPWP+G1ITLdznw7zmgobxk5SktnxYOMg5b2N3HX2cZkWptfwjgn3NVx1uKBXsa60XZtpQivvwUTQVg/Rg93Syz7sgrV4yucIn771U3d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0JrZlFkV1hjUXZSUmh4Zmc5MHY5ZGlsUW1jbTZ1RUd1WTFsSzB4WEEwNUdh?=
 =?utf-8?B?V3c3akpxU21mUC9KM29Mci8yN2NoV0N6MGd6UVZoaTJTVVlORTQ1SXZ6TXFD?=
 =?utf-8?B?TkZ0SzVBWVNyS1VTbnMxSzJLN0ltV0p6RzlKM08xTTZyTE56MEVCMFVBRFVG?=
 =?utf-8?B?WnZxT01OQmpXNWRTaVRqdDhwN290M2JPYU1iVnUwb1crZUUvNnNiZEtzcmk1?=
 =?utf-8?B?SWExMkEyN1lwYVlnRWpLVXlHb29iSFZJdi9FR1puS0UyUXVqN0QyRW91UXdV?=
 =?utf-8?B?aVdEaHEzUG52MGNMKytFZml3TmJML05rZUl4U3dXMHE0N3lEd3JEc1RFS0JS?=
 =?utf-8?B?WU53L0VzRkNMejFHOW13eEpIUlAyODljb0tZWmo1WUhjVFRoS2ZISk1Namsx?=
 =?utf-8?B?VU9zTGdjL2MvdW4zY0dEdVlKMW55YXlwMG9sTWlKbHRaOFlJTXlDOUtqYXd3?=
 =?utf-8?B?RmNoMlVEY0dWQlRLS3JzOTJpdkxnbTZyRnAvelV4VzE1amRUYXRvQ3Z3UW4v?=
 =?utf-8?B?RnhFSDlVNUkyK29JeG1KYUE5MnMzdmEramRuOHY1OWNUU25rUGdtdS9VOWFK?=
 =?utf-8?B?QzhiRXRla2NYOUhjUDZVZG1DWkZic1N6dlRhN001N3hrOWZ3RnZZbFVzWkIx?=
 =?utf-8?B?d2ZZd2lMNXR5VnhMWW5VSHlzTFJ3S3BOK3MrUXZyWmEvcXZoblI2L0orL0R6?=
 =?utf-8?B?OWpWaERRUmNXdkdGUWFTYWN0QS9lUTI4OFkvSjc0anEvSnB2eGZ4UVUyRmVj?=
 =?utf-8?B?WnJiT1huZmFUVzhGUlN5RHV6blMxY1pFMDRvakVJZUdQeXUrdWMvVlk3aWRZ?=
 =?utf-8?B?UG8rdUhtdk0ySkYrV1p2UUp1eG5Rd1RiZGpoMFNqZUk2SlJQSGVUd2RBQkNS?=
 =?utf-8?B?QmVZa1B6cjIySXp3RGlWenJhV3lHcVJDRUxIWm14Z0JBUUxNMEFoNkRGK2Ra?=
 =?utf-8?B?dDRIYnR0YThHOXFIaFdLTlF4TGdXOU5BVWludFpCRkVEWmRDUENrTEhyeVdC?=
 =?utf-8?B?RXRreERXUnNRWk05djZwTmdEVmlIazBYL0NVZ0JtOVE4cVpCTmo0eEt4RTh2?=
 =?utf-8?B?Vm9yK0MwaDdnT24vSEMxckhpSWtOSytHMWRtTi9RTWEzSEdNYXRXZXp5OUtj?=
 =?utf-8?B?bzRONDk1dTZhUmxFYWh3VWZWeE1taGVodUtjbjhudDdJa3NSUUt4U0RxVmZ3?=
 =?utf-8?B?WmRFRURHYmsrN0NsUm9mcXY3ZXc2di9ZTTZobEJPVU9abG5vMmlaNFN1K0d3?=
 =?utf-8?B?ZDF6S0QycUJDNnBXZytvakdDdXlIUSt5SE16YUlDK21nM3ZvTVp3cWZnY3dp?=
 =?utf-8?B?WDY2bW0yRkZ4WGRYWGFzYUxOdHdMK0xEUHJPZW02UkNxYkxaMDdpcDJUN2xi?=
 =?utf-8?B?dXNGSXZiSS9HNDllRnY0cWlHVXNnNkMxdDYyTmx4cVpRQ3VnaEorUkV0Slgz?=
 =?utf-8?B?ZG5WdzJKWjQ1RDNhYU9LWS93bFR2RWxzOGRuV254YVdxL1VXeVhhTktTM3Zh?=
 =?utf-8?B?K3R2L3RUenpMOG5oWVduRlM2OUJkWCtVNkM2U2VZc1FmbEVuMlhvYnBWRnlR?=
 =?utf-8?B?K2l4MWFHRThwVHgvMGMyNGJTWk5vNTZhSG1GbUZxRDF3M2xjS1JEaXpvOGpR?=
 =?utf-8?B?elpGUXJ0NU5MVmk3VjVjYllUSnRzVmlqVWJGU1ZUYXpmUzdzR2pZRWExMDZU?=
 =?utf-8?B?eEFocWdoMEFuZVFtUE50YTlLT2dqcUE1cUxHUVFVZTZXcm1YV3pVVmE2WEt1?=
 =?utf-8?B?bzkrVlhCVnJBK1ZqamZUQ3RhckJBK3ZadkNyeTRkbWtSdUdYQUNkUEFFdlpG?=
 =?utf-8?B?bW0yanNBOW16K3pHOGlqNmszOWZ5YkhJWEk3NytOb0VRbGRkUStRVlVuYTdL?=
 =?utf-8?B?cGRldjF5Z243dXJnaUdsUmQxdzRJUlV5SFRBNmFZVE03WkY4VloxazRhaHhn?=
 =?utf-8?B?eFdpZERKallObEg5ZEpHRlhLSzUzVTBCVFo1T2V0WnQ5QVdXYVAxTi94NjlW?=
 =?utf-8?B?Y29pYnNEZHFpR3F0SWtJUXUvekZLZ2R6c2Yzb0g5dEpSRDNrdkNjajBEMXlE?=
 =?utf-8?B?dTNrcHBMWDF4dW4zR3lJQmVNQkRLOWJrLzhqUU5TRDNsRWE4MFh6M1VGajBZ?=
 =?utf-8?Q?9B005Uy01zcvIUPBcENf9AT1/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196059cc-3ff2-48d3-8561-08db83788632
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:47.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10+ozMp3kmmHKcNV0CEG+Wirb++c9NAod9kZ2OUNgMNyRDQgQ+jC/STvMipbgw9Z7fYYiuJJHH+oK7ZoNQpRRg==
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
 drivers/mmc/host/sdhci-esdhc-mcf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 05926bf5ecf9..a07f8333cd6b 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -489,7 +489,7 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
+static void sdhci_esdhc_mcf_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -502,8 +502,6 @@ static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
 	clk_disable_unprepare(mcf_data->clk_per);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_esdhc_mcf_driver = {
@@ -512,7 +510,7 @@ static struct platform_driver sdhci_esdhc_mcf_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sdhci_esdhc_mcf_probe,
-	.remove = sdhci_esdhc_mcf_remove,
+	.remove_new = sdhci_esdhc_mcf_remove,
 };
 
 module_platform_driver(sdhci_esdhc_mcf_driver);
-- 
2.39.0

