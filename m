Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361357629F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGZEHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjGZEGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:06:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01635B7;
        Tue, 25 Jul 2023 21:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+5TNHiqleWCIH/+9g/U7+ocgdnbvZCb+4tmCfkMalmEqUNuQ022LPdOsiseQ4wgY5MXgfoJwOQ6ybFD9FozD90WoeFlxUoa0o1d2BH0e+img+77tpSOunB9Y5VcEjA9KqbYRprYLTWHoVgjy1wb522Te9+oL8+4ltKH+5gjEKtL8qdB2hWRSMk43SURWk6kQ0CX2djgt+c9ctXoiN7WABpqr+1YQnEmmTDiPahiAxdGreOmCtvRaFkj2FeLNwLjsfQSGAdagCTTGYsjh1yEnwR14XhokIB4LL7rNy1LJrSlOcCiwGVT5bvyRGgVur7/9FkVV7EMOz60rDuC4cLTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyhbeNXUgBwkQepDAzaYajBffSTDYfSaQABURS0z/Nc=;
 b=SWX8e3QHPYzEBpXESt95y8xEs6WfsOI5cxTqs1erwlJbUHjbhMWLPNczWRO5jKD4yujQxm+pStjqUB2R5WA4WzBKJJiZqyZch2MXtKTuVKd5B15yU6KS2qUJMJE1NY3nBscRVq0TPdIZ50nYe1ktZhlsiNYup1Fzp5/XnyGlb5oAdmYcug6r8X3bxhjOPZGZulIGNJ3gYr/vq5qJTiVMZYubug4o7m1RbfJxJev58NUbhowMzP6ngUDg1RKcEfjol1qYRX2QUF1Lvr/L0QUatlsvvG5bPlrhExohLdqhX6cdER+s3zh4Yp9QuZTIFktcZH6m7AyvAvbKMTfF2EnvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyhbeNXUgBwkQepDAzaYajBffSTDYfSaQABURS0z/Nc=;
 b=K7qIgoDEYmQjHHv6rwMfmhvUY0Z6VNIJv4uc22BozO7YhRHl4ta4KWxgTI/pDUXoubJQ2ZEGcCtiisxjc4F9Sj5A+iBMPvbM60y3zcl0Q0j0i+pfVsiO/Bjz5zXTqqWB/I+XWOJ35AXnY1LtvgaDiUntjShGROVi8xBoEx5Ng6YGq7o9GRX2zNn05nZ+j7F2iEgGeOn8Qltu1ZKgpA79Ze3+/zc4WH3pyxeesVTR25YTYAuSSg/hZzy+8/Cmwaf7n9UfefAUNp4jsECKhrQxHh48pxSJrWa8IfQ3XSQILOIgJxfBi1rav15wg1STqw/82kSIUv6k/AVo8uH3ySLePQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/61] mmc: sdhci-tegra: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:17 +0800
Message-Id: <20230726040041.26267-37-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e702cd-3a7e-4bcd-1b5c-08db8d8d115f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ioyyv0vlWHmSbvE1dObAAe9sQe6zl3nXNC42xzl/A2afPKpI4t+28Sl9ce4vmtx+29w2w9jGiwYIS+C/a7ZgKDOChgyR6mIfKd4vs/Ox2lyPuS4O56Gs5mPaGbz9u8oErge9MbCet/UPp5OsBixD244YfnlEc2AFeiX0QP09VlayrR4Pra3aFqPTZPYcEYforpN/oNWnpcR3F5xiXzTU2/6RnD+kYlUcaFv5q3Gjr1FSPdvZ3gA0814H/5qDC8U4zpD06lKHrYLLB0W48YNl5MbFB/qywmjgSe/gG391Lhhc1ycO7orC9B8jmWlH9dy0zWF59RxvwLDFgoZxF6wkQKsED6sIixesySsgbWXpMSygFcuwoa77lGda+UczrgJDsYkywCnMhLi5+gmiRqJiIZefBNG3MMVtuK8eUXM9sPoDqduvdjcGE+rYbHQZ3VTEiXuiTnFwy4GkCBMC3bpccOymhw9kMuDETzBqawqVExiXiMWdzb6TUCzD9kWuzFivv8yW7cEudt1baz/KeFIZxx+rMTeYTK7Dss0da3WdGGB9flnM/mzLtcss3x8Q6J7/ZDnkivypV79Yk62WhVW5tGTalPprcI3XA5J/RqQPORmlivTMvj+QQmFrVoOD0RBO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm55RE4vRXFtSzArZjhKMzBsK2VYOVlCUm52aTdKUWNoTUgwc05XcThXY0pw?=
 =?utf-8?B?R3dlUExTSGJ6NHg5NFFPaWo5UzhpSnVLWW9pVmkwM2FsN2pFVUd0OG9QRWkv?=
 =?utf-8?B?Wk9DdTdCNXlEOHgySTJDSUJaM3pIRDhiTUxDUk1FTCt1Q2x5UjhIV0trUGo2?=
 =?utf-8?B?ZklHdGJrUHBkYXVxQ2VwUjY0SWdzY1JmZ0lPcVJUNzFXdjZIb0FTakM5QXdR?=
 =?utf-8?B?YUcrSjIvZEtTZGM2MnlWYWZ6YUlGN3BEQUNZQkE5cEtvK25ieW12MGdOK0lM?=
 =?utf-8?B?cUl5L1Y1cmVMaFpYWHJ6WXNDbXpueG5MTnEvZ0d5TDFuYmlWZlg0bm9oQSto?=
 =?utf-8?B?d3pVMUxlczJ4THBSWC9KK1A4KzNlOFFydmJJMDRFV3pacEYxT2IzeEpISnlR?=
 =?utf-8?B?YjNodXBwQzlqNlZaUzFPdjlDRi9WRGpjUUZSOGptWXpndUozTEJkTXpVd2lL?=
 =?utf-8?B?bGxjR2x5NUo2TTUwR1N5RnJzeHdNSnJDbm83a01yRVN4WnlWUTZxc1kzMkxx?=
 =?utf-8?B?cG9WeVhDKzJjUkFzMWZVV3BNT0s4aG5QY0dXMjBuaFFDbUNPY08xclB4K0xW?=
 =?utf-8?B?c09BK2FGZ3AxUFNKMThSYW05VG9ZZXUxTEtaRWdicGJXRURCTWh0QStHYnN4?=
 =?utf-8?B?ZlpDTUVnL2YxN1ZueDNMem5tODVqVUxSWUZHaFhEQ0ZHNnJLWVFpNURiZXhp?=
 =?utf-8?B?V2FrRHc3QW5yRGgyaHZlb1JRYzRxM3pjMzdFeS9KTEJ0UWsyN2Rzdk8wSHda?=
 =?utf-8?B?WitxNmlkb2xHYkdwdkNEcm9yQjFZbUpMK1dlYy8wV3BaZERyeUZKazd2eVRM?=
 =?utf-8?B?V2NkVmc1Mml6RHhHV3J6STFYZmhyM054aExwM1pTUVNPbi85TDBGQzF3a1hx?=
 =?utf-8?B?Q1FFdDd6U05aTXNla3hZc0xKMWwvcEk0NUtROUxXa3JxYlV4VWtYcVU4U3BR?=
 =?utf-8?B?MmlJQW80RTdncHo0RlBBSC9xMjErbnZTd1dmRTBkU0NRdjlVZEtwMmFHZVBU?=
 =?utf-8?B?U0Q4eis2bnFIbjRMUldySUtZcG10bCtrRWNvZWI5dEt0aktwRGwxODRTMGxz?=
 =?utf-8?B?K3RRTW5JR3lwMXcwck52NHBVaW5tRndZQXdtVG5rZ0Z6VndsN0NaM3RPLzNy?=
 =?utf-8?B?c0pVNk44ZjMrb3dxWnVzamdveDZTVVZ2QThibkVyV1lPcFBmMGJySVBteGFo?=
 =?utf-8?B?akFlbkpudVR0VktKbHNodnQyNnZKdWo2S3YrOEFaY1QxRzZLeDdkNmEyL2pT?=
 =?utf-8?B?ZzNTKzdvSkNuNXdkWDBhaklHVHdjd0ZWRi90ZU91bkZtMDhmT2ZzT29HWURH?=
 =?utf-8?B?UkJTeGtNbGNkUTF0UVA0aU9OakR3T05sSmY5cG03VmNuMThwUHB1anBIK3Fk?=
 =?utf-8?B?dkhScUN2S2lhbFI0Ris1eHRKVi9lU3daSWxoakFPbUlkanI2ZDNBNktiYTZ5?=
 =?utf-8?B?djQ1akZCY0VsRFo0VkEwNzg3UTd5VG0wck5KQUI3NitNMkk5Y1ZLVXRUbEpk?=
 =?utf-8?B?YjZhd09iNjE5OHJNSUhzWC80MFNvKzBlMkhlT28vVmVCbkpRYmdZdHl5WXVh?=
 =?utf-8?B?dmt3TTZmUlE2dDdhWHVsTEdUU0crbFdvZ2o3T1NQcU9XNnN3VmpxQ0dVVUZP?=
 =?utf-8?B?RmFBaU1ETG9nSmlPazNZVUtVZjE3Vm1aTGxiU3FkNjE5U1NkMWxhcTZ4ZVRq?=
 =?utf-8?B?a0IyMmJFU0lrV2QwN3A5cDE3ajFTWUZvaGVPYjBHRVptUzhpVjN1b3N2dGdH?=
 =?utf-8?B?K3FtK3lCYVNKMVBqWUJFV0lKZEt2VzBlcXhZOXprcWM4N1hrUVpBTnI5eit6?=
 =?utf-8?B?U0ZwK1k5V0o5V0tkZ3JHaTVXbGNYdVQ5N3EwK2xvUjdsNUhDS2RFSlFpMG1w?=
 =?utf-8?B?MW5DV2VSM2dzSDg5VmZ5VW16aXhRa2NhNlFRalpmT1BWUmMwU3FhY2Zzb2xv?=
 =?utf-8?B?WFRjSFptcHlUSE1GY3NlOXkrWEd5eldicmZ1Nk5OTG05WDRwU1hNbmlHamxV?=
 =?utf-8?B?RXZmb3AwQ1FoOXQzbXd6cmVrcG5kdkdiQjk2aHZkc3k0OTBSY3c0QXlnQ3dE?=
 =?utf-8?B?QVBkajdoNmMrdCtnNC9LRytTUXRXZGtoVElQZi9yQzJXdTJEWUdlYVR0MkNQ?=
 =?utf-8?Q?vbHyrZIYur2ZHkWeWzP4UitEX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e702cd-3a7e-4bcd-1b5c-08db8d8d115f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:02.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XidedTjoX/aLnEy9wT9E6UyMdi4EBcR1Ulc+Wi5ID4cs0xUxFPh13d0WsN+21v2tUa7lCbYPWSJO4C1czcIc1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

