Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428287647E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjG0HIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjG0HHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:07:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E323730DF;
        Thu, 27 Jul 2023 00:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Enp1XhEDlYrkv/h3QE5DaUeIayhoJZ/pQvjvbuOdH+x3VWHjkmIsr6Xz7EAbasn6Dnhwsv5Q07bF300lKnH0xwPGS2TRZRJrZ/1K5Mu6Vmx1/GYRB0A3DyyjIYZ2x/l61RFexYpP68lwiceyzdAFXgVRdeIPtPpMl/ZXWxuvWLQ3Yy+JHGswe7N+XyHgPaA8MIaKV1+qLxWf3cMOhJ0Jge+xk7Xq1HbJHklsHG2HzktyAMx6kuFWT0DUpRSuoDgEqvEz/9SKe603CNvcEzbZGasvpNdiNktn2edE+6+Wp3TgVLDuBUDKBsjcmqcTOd1kSqQDK5D9vL7sCFNvNdwS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xLwqq0e9Ue8vmkwjT7LOOQK2kVdeTE1Pd0css584r8=;
 b=DuDsIm0cFvOfSzoe7fj7MTsBXlGdFXD93kVkDJ0WuGYK7OmyXal717SIG0fz6jVrvLDp1V7WL+soNLAbfSqLkPuyHnhDfrAa7UcnnYstLz/VUaf25xUfKcNVnW+QWHUDD+JPKQE0uY6I0LGTslM/RIO46OgqLA591SOtKSfdNV+SdkvNkWtqgwf+3KCrg4dJEoZBfRszcRZZRt4kGpyrZ3pDM5aTRkW2pn4r/ve+XR1N+SgcJHgrvdOv/FXVSvFdwyGBO1DLXAYHl+VMcGp5spe5eqnO9S1gB9Xh/8d48YgBfzUP3Yf4Pdqz2M/PT9wJrEFuff5Y1Sj3I9LVL24nAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xLwqq0e9Ue8vmkwjT7LOOQK2kVdeTE1Pd0css584r8=;
 b=cqzJjbv4y1ZY5wjIy8bC7lOrzwiAJTh0gPJiRcKwzWoGFstlwExrMTC9KIPCU6oMmX1CPpob0OUeBhWWaZUMyxKxlYfp6exevVK8LkJqezAoWBtFCphtmbbn0QF+MyAgYLXz1JxQO4dGqayoH14344rELMhpjjRmnh1SaoymGwxT7XqeRoP72BtqdE8G5NiKpYMIhggTyhdcHDfBt07tJfo5cZe6JTUweS8+oNH7+6QGzV7JGMukV7CX7h3DGTYVFNItlOA9X/8oQRmwZhJq6x1d14xJLWr2eAvgUyICB8thCSlLSdnSwg7Lun+x9QI5BqjuFkA+RxtdB7iIXDcfgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 46/62] mmc: sdhci-st: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:35 +0800
Message-Id: <20230727070051.17778-46-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4beb5dea-850b-4ba7-4283-08db8e6f6bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPWFDHrokiGbubHqfRoK7qx2Wi93VrWk1jp9wzcbR/m+huN79EA/ZcZYT27LivEdRimQkxC8bBOTeTu5hNYBtLcGIuN7tixLgjLDPE8xn7UnNfmYriOnzdVktvlBaFKyIjmvl9BDSQ6Gx2Glf8IU/linERj3yDrhCoLX2LImDA9rh75pdZ1K1gIIWXqdcZdqVlwPH12tEYf+APZhOfWVcJBcKB1f4Hkf2mzPmiyvZj+Sy7M2XaojIr9oN48I4ULomGmzSPVhXtEHOzUzi83ssejZV6nJbflmmH6gEzQRqVwBrWapEfkfD+e+2o3eXYIXksIDmTejsxsToSE4gpvPn0y7Y4PAZTBmsVzGeqgzrBLJUGXdf4sci/XL8+s6vOP+vYdYcVI0jey9wMB/syBkhbsnvOw2f6qvNGP49tICPOv5iKz32kOQ2nEj9X9qxYsZ2uiuuwBNx/PLuljqiJvRhcNdyvrgtXn3Iz/GFsbOzELRVOqC/+EnkYieSr5HeZ9xGEPQIweXs+FANs8q+j2sHB+IlC2xLRmTdqTD7aXzDxuonC95FdbbU8Vg0vrzHuDd3LdK1EXNtqYEdeBjarbQO79GMSNrQCZ/kHJgtrBaSAEW33xMQjk2igMaEnmoNloJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTlFdCtIS2xVL3ByQ0VmUnlDd3pJK3YyeW1QSitOYWZVcjlsMWNXamc2Z3ZS?=
 =?utf-8?B?cGk0NmEzckZGYUdiM1l1RndJT3cvN2JXYnBOS01LRWZyTkRhSnFrTVNPaEs3?=
 =?utf-8?B?WEM5RmRHSjVCNVkyaS9HN2Q3TjQ0ZFgveUFGZnVidlVlUDZVVUVIbUhDVzF3?=
 =?utf-8?B?U2lUbjlhSnVuYmlJTzhFN0FnWDJtVWE1amdhK2tTN09HdGxZRUdkbVFXSzJZ?=
 =?utf-8?B?WTdjdlR2RitHYnc4emUzMFJ4YmRtcmplM2VOZ1NYYUFvZ2M1UFRHYWIxWnFX?=
 =?utf-8?B?Rm9JTWRkM0s2Q2lRZmQzYmhCRkFoYUcxc2l3c0pxM3YzM3BaR3BuUGZMdVNM?=
 =?utf-8?B?dXdiYUxxOUZrZjFWNEx6ajJvcTFSQ1RROXgrQzhDTEVvelI5bzlGUkFWTmNw?=
 =?utf-8?B?QzMraGZUVFdVL0E3MUhmMWxUbFFJSVRlTXdveURKc2JlL0RZTzAxSzhzdlRn?=
 =?utf-8?B?MkZScDYxaGJNYkVMc2IvcGxuT2VBK0tBb1JocmtlYjY0cGdCYldtamFuU2JU?=
 =?utf-8?B?Qk5EZHlqZFNOZW5ma1V1QlZzNzk1QlFacHRDOWNseWFzRGRBZ1RNRWoxaWVO?=
 =?utf-8?B?NFAzZE1WS1BFOFV5Z3ZaZVVCTlNuY1J3OHV1YVlKaGUweGVCUnE3aXBuSkhv?=
 =?utf-8?B?YmR4UWVqOWJndU80OEo2YkxUa0hRRDBSaVBwbWZGUlE3N0pRNXdUNnFaRXND?=
 =?utf-8?B?NnNuNzhnZ0pxbitPd1RYa0NrdkU4Q09vdzNZVm1hSmdXK3F2alJYVk5teG1t?=
 =?utf-8?B?TWdYNVE3bGw5L1Z4UFBxMk5PaXpVeWNBZlJ5cDBpTExmUWNWYnQzOVlWSUpW?=
 =?utf-8?B?SHQ1aFVueUU1M3oxOGhXU3V4azlzVUo1TFA1UWxkaGt6aUllVm9yUTJpb3ZN?=
 =?utf-8?B?ZTlVM25hM0c5aXZTWndNRVZtT1FlZXJaV01naHpOT3p6TElsTnpRT0NMYUlM?=
 =?utf-8?B?NVZQaWhmY2xwYVVaY2hnZk90YjBSWWVzVjBBYkdjbmx4Z2x6dVJsMFljME9N?=
 =?utf-8?B?WVd4ZGcxaWlPOUhhT0xWeUZUZEdHM0Z3TndIN251S1hIVEQ0SGw5Y3JRbHdF?=
 =?utf-8?B?TzRXNWhOeE9Cd0VET2ZYaHhzRUZTR05YNWQwOGRzdmhXVDhpc3ZodmVIVmhX?=
 =?utf-8?B?b0N1dFA4bEh3U05kdklpOFRuTWMxQmcvRXlhYlRLcGIza3MwU2RFQnZpbjMr?=
 =?utf-8?B?anQxWVl1ZGFwUWhTR2dCakE4NU9iRUVzTjh5VUV2c0RzMW92QWUrQ1JRemNo?=
 =?utf-8?B?Q1pvYm5UanZQZllkb0I5ZDhReDgxdHI1Q2V6UjhIL3lBeTE5akJ0YTVSN1pu?=
 =?utf-8?B?VVpCV0FIakxDaFFQUEZWUG5sbUMyUmVacFZaeFoyelF1Wld6QURzK2hpVEJK?=
 =?utf-8?B?cmgvaFBMbUd1ZncyaGlMYmRIckp4N2V5ZmIwRW9hVWlxWlRrcWp1czdROWxp?=
 =?utf-8?B?NG5EOHZ3ZjcyWUV1UTBXaTk5Vzdzc0FKL25rSjNqK3liazY3TElOK1NFYnc2?=
 =?utf-8?B?M3V1K1VrbUZVUklwcUFKS0N2SlBFRjdIZjAveW5NRnRJRDJ3cTZKNWNISG5P?=
 =?utf-8?B?dVU3UUhSQW5FT3QyRC95c0ZpZDR0RHgvYm9YMWtvNHhDRFRvbVovU2RTb09s?=
 =?utf-8?B?c1FBVXFvZ2RGS05rQ2d0L3FXUlNKTW00eG9rSnJyeW9rSS9TcXBKZ2pGM3ZC?=
 =?utf-8?B?MWRvVlJ3UDJENGNvL01kRkR3SUFiT0hYSzNoTGF4V0JRc0V0REdMNFJLRTlw?=
 =?utf-8?B?K0htZ3JpcVBNV0FYb0pRalkrbkR4T1FiRmFrWXBQS0VsYUNmSk9KME5pR2Nt?=
 =?utf-8?B?WmJBOWdXbWM3T1RmU2lXUU5SWnRVcjFvOGtOcnRYZ1BWckRseDQ1WCtDUDk4?=
 =?utf-8?B?U21RckZXQ3NSU0krT1ZPbWIyNWVkRjdSQWtSSFFCcjlYQ1pFN2cwS3pUZnBp?=
 =?utf-8?B?WGxnUUVNYm1Tck9PNU14dlJZbjVGZ1NXK2I5anhERjhPN1A2a1pwSGdTZTZ1?=
 =?utf-8?B?dzhZYWorRm4ycDJUb2pNWlpRWmRxTlMreWR2Z2FwdTVqNHBjbVpVWGhEb0Zp?=
 =?utf-8?B?L09Da1g2TWlNRFZ2bi9NSm9jbVBzOHpSS2tBUnRwTkFjVlVMWVZhTEV5OWMv?=
 =?utf-8?Q?OtYcCh/LageHHxt2HwTTWZO+D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4beb5dea-850b-4ba7-4283-08db8e6f6bf0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:20.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7PTYPZXEejbzdJHsIIrQ2mL4wimfWybK7lHLv69lw0YbKyi5ktvtwijLBCNA82d7grSZyVPc/RPybC1FnnXWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 6415916fbd91..d955b5f4b7e9 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -434,7 +434,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_st_remove(struct platform_device *pdev)
+static void sdhci_st_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -446,8 +446,6 @@ static int sdhci_st_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pdata->icnclk);
 
 	reset_control_assert(rstc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -510,7 +508,7 @@ MODULE_DEVICE_TABLE(of, st_sdhci_match);
 
 static struct platform_driver sdhci_st_driver = {
 	.probe = sdhci_st_probe,
-	.remove = sdhci_st_remove,
+	.remove_new = sdhci_st_remove,
 	.driver = {
 		   .name = "sdhci-st",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

