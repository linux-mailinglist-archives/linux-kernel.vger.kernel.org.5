Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8107629F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjGZEHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGZEHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:07:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20705.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FE3ABF;
        Tue, 25 Jul 2023 21:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBfZv26qTrnUb6ZTYT5/UDZwscYFtj5UOTzAfaYrj2QfvV5/rKHOOy5GXxp4xT5ycgtjhVnX1B4176ZOmfrlNNfrNIUOgbO1W1KSyZSjXOhxso17N2S0SLp040eljOMhnvjdqHJ21qBI7LDTINYNo5mbow2vPfFlkP8xGKQzmMHaiuM8qL4hm3v8PReMYQ2PZY+GZR/pS/Qv3sSoGGujyoE7e3COW4wbSfhaW5KEnOXBzMYz3NmnR41DfvjbGJSgllkv+ZlHrYFiyqSMlMeGk9UK2KO/ONTALNUokfM2S4YGQYA5xkHSELZl+cK/gq1S/49Jck/7Rck/JnzRoahWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRmZXFCwumSmLXQwjvRHThU5yBcyjcWZ8ZYYoqniSk8=;
 b=KEOU5Q+Yn97+iC41TJ46s00sMt2FHIWBJhU7xY8ja4vf2VTzeyyDMXcREKRCh0C9lwwvm9Dw/E6Fdu5cUWGbatqffDVnlvqc21u017otjhQpA3eM6ohtwJ+j4yFqE/39pV8Ii9yXzk/+OWtcri1/2CvNYvdvCidwXTCvXvql83AN+iOfuPh7zW2SksIRjJtA2k0sqUrkHdH+W/4d8il0AB2f61eITTdIWWGrINsq41hX2O/LyZAjboc3coTFguOpyiVQubjidqn7aCB1L3OnJapfvSWBkVjoc+NPMSDOMd0mV11FR7frJe1m8BetOxv4AwZNB7IrQ9pTKSqeQTf20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRmZXFCwumSmLXQwjvRHThU5yBcyjcWZ8ZYYoqniSk8=;
 b=OBRSfebgUVCAL2S1ZroyffWlKVIVzZmowf6GYbTgHZJfFbjNIGUyuFCKyt1+2C9jYsOsj+Di78HiMtaAakXPc+WcKlKFchqOyhKdZA0vdq221XO69Sf/ZWcSx+Gb1Syji1b8oLnEx2GfNXoPigj/g03Kgj6m78jquAxbXd1kHG/GIIj5U8jRL4G6UOiFhgQXoeoFKLGWVzl6I82YiDtjlmHInd/XA28771jdTxnCVuF1kv7huZn6IxFewLOL6QdqG8DkMgBA+Y4Y0RxEd18DTOoJouUq2+Feio6dugasnHn+CaR58IxS16xqqG/KEDm6hdnRzphM382h9bkGHpgFBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/61] mmc: sdhci-sprd: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:16 +0800
Message-Id: <20230726040041.26267-36-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b8482f6-4488-4ac7-5bc6-08db8d8d104f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXbxExiTw5sQHN3z8cuhug2xFU8yhR7tfKN8eKADnhg1vb3nO/I+o/G7OnPdsz4KiI69vTy+CSQ6z2GFBUC1w+t37Vo7bi4OdBI2HeXDMVbE6jhuwjzkXseAZ8eUI6vvtCrMTuxfRRNOVmexio42uQ57q+gliQtgKkoGhIQinQNs4PzTwyBUcS3C3DcO1qhCFRqX1G0O+f2VyrjPoSworOK68gBoc+5BmLR1jMWtsIwORcvBvTTAKomza+PKlIhObe3M39im49+DQRaQVq1fdmeFKTPPMlEaD7nesGM/HWwGMdXz6ekweVx50pUqsUSpNuYpugyVtTm9/xdwduX0Z9YvF1PjonH4on/3iImADgLPAnBKw6Ikb5Lb0T0uKq9mrS+spk3fOeJU8oVf5T+VlvX2Pg00ID8yt7X54MaqHOG3dd5GBtSKiIV+LRQE6FZzsGwAYkPeggSVVYSPSf5KD7B8o/A9c16XPIl3vJieBfAx2+ttbpaRt9Pv+SfFQtck/+GHwWaCGH+53n9HpSXEb1ejp1p+jEUuuLvYXmxicTnZNMoKvuMWW34JrJoWEf5A/3QAUoADj+MWFxeElSzQkwOFIuvELeqooZQuk5kzEqx7pVjrEsf149y+ddnCJoBJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3ExMHNBcVNKWmF2cTNTbXU2a0o0NVh2ek9pZXg3djZXa1pIblFiRVFuUWJH?=
 =?utf-8?B?YUlLNnVKRzl5K1N0QUczcUcxdmd2UTlxaGFSVEZ3eThGVS9kYmVFMUtjUVds?=
 =?utf-8?B?MEVXNjc5NUJSTVQrcVdUNWo4RDZyUEw1MHovQWhwSU92cDEyU3JJVTJ5bHIz?=
 =?utf-8?B?SHdYU1JvZXNBVEliSC9WajA0QXV1OG5VNTJ5UDVpVDBoa0ROaWJXR0hRRFBM?=
 =?utf-8?B?S2pYSzBNeGh0SFpUM2h1NGRaYVcwckkrNXdlQ1RKRjlNcnF3MXo3Vkd6dHIz?=
 =?utf-8?B?YytDWGZvaDlVa1BFUGxYc2ZCSjNoVlY1dU9PT21aUG1WRTR2SHBsSjZiSlJB?=
 =?utf-8?B?K1RMN0NHYytrUUlGdDM0aGY5R2wrTC80Vk9uVWdlVjlEUjFuRlVJN1N4eHVu?=
 =?utf-8?B?Y09oeE1CaVhtK01SV2E2cmtIekJqM0RwanNCRzRWNGplVGl4bHlmcFQ2MDNw?=
 =?utf-8?B?bkxKMDVCVDdoWlBoVS9Pak9obVBWcmpXbldSVEF1L1gybHpYZ3ZVZzY2V3Yz?=
 =?utf-8?B?Q0x2T1N4dTNpMldlNzZmN2YzUjZoOVBJWGJZc3c3Q1lQYjZNOENvcThmbnlW?=
 =?utf-8?B?VklYTmVWNy9rdFJxcCt0K2xzeHV0emlDdG1ETGlESTh5bUovbFdOMHNvYWJn?=
 =?utf-8?B?R3ZRbFlPWHJCa3FmaHpSOXBwdXdHck9qWkRuVzhiODZkQmxXZU15Mjd2blhn?=
 =?utf-8?B?eUZON0UrSERuT3g5ZTNpUFZYV0JrcVNWY1NtSFZ3YnJ2c0hqWnNRWnJZcGVW?=
 =?utf-8?B?ME9ZRTlhUGIxRjlaZlFSU2pvbG1Dd1kraUo0cnFYYkNaUzUwOVhRT3dzWlBL?=
 =?utf-8?B?SWpPbUo2YzZlczJBN1dlV0dZY1pDendCYmo1WEhaSFpXZ0NVM2M3MGxrckhX?=
 =?utf-8?B?dlMzRDdNSG93Z29FOFFFaXE5VGR1QTdUUGNmVVJRdmJOWTVHMitUOUxXbDdZ?=
 =?utf-8?B?R2h2cGNIOFFwdU9KZ3dsbWgvRldtZ1Z2S0VaeXFWRHNZL2JMZ0FFY3BYOW9J?=
 =?utf-8?B?ZGUzOXE3VVhYSHh2U25SNS9jK2NINldod0lNSTNzbTl0UkVJbUhLRTdjSzgw?=
 =?utf-8?B?MDEvRmpSazNxSzJWemRUWTJ4QlVGTTd1dGpCMytJRm1xZWNNS3pJQTMxc0Nz?=
 =?utf-8?B?NTNEWEVGNGNiNDQ4NTdycC9hanRSMWhTNUVFMzJ1OGtYWHB4c3Fhb0xpdzN4?=
 =?utf-8?B?QkMzL3BhZUQ3WklwZnZnVW9rQkRkMUVrVldHZkkydjNsLytsTEQ0WVBveTdN?=
 =?utf-8?B?WG5SZEN0K29DZ3NodjFjeHlSKzFkYkVYcFpDMVRzZGxUWTJHbUVtQVA5MEdR?=
 =?utf-8?B?TkRVVno4a3Awbk5SaTZuK28xZnNUZ0ptSTNlMkE5bjlJSUtHRnFaRVBScnJw?=
 =?utf-8?B?TEJkU05vTTZvRTBkc3ZxQnlvY2Y5YkZySEViT0xRYkg3RzRKZkIrYmdDRjJr?=
 =?utf-8?B?OU1RYkFyb1R5YUpncGtWa0N4YVh5bnpobFZRWDgrOW9jV0tmS25FVmNJeDJI?=
 =?utf-8?B?S1kyRDF1RURmV0RjanRtM2cza1RlUlJiVUVuSnBjQ2twZ3VhVjVwRnhENnEy?=
 =?utf-8?B?S0lISXZTaU55aUk1UjZxeStDNGFUcDM4Qk5aSUEydzlxL2tUdHE4ZXpueng3?=
 =?utf-8?B?bGJPWGlPUFhCbUpSSTNoMlBjWmhrbzdxRkVaWUY5Tks0NjlzYVMwTjhKS3NQ?=
 =?utf-8?B?ZXNQR21OQUpDWFB1b1psRWhzMnZrUmVZMXlYQ0lQdlI2aFZwM1pMVWpDT2Rr?=
 =?utf-8?B?UzBaMVVnOHJ4dG5iaUsxUithcFhRK2tiYVBEcjk4QjlDWWdYYVZVRmlTeld2?=
 =?utf-8?B?a3paWEZ2Y2E1ZVNFaWFpbVlOdW5kSW5TT1FKeERMQ3VQTVFKbnBvZnRMTkZC?=
 =?utf-8?B?VmRQaEhLenlGelRTOFR2Uks0QTRCSWcrRTV0bm9UZnBUSjFrUjJZenF2ek1t?=
 =?utf-8?B?bmpMWjhCeWwrTG1Zd0RQRFF3RDFoWTN6Qk43TUg4bUJJdzh0aHI1YTBEdEFi?=
 =?utf-8?B?aEl4V3ZzUDFUUk1yR1pEQVNTbUlLblhBdGYyMW9RTXpWc2liYjN6eENNdkND?=
 =?utf-8?B?UDVoMkswWEw0cHVKbTJWUGM5M2cyQitWRG1zazE3MVRFSS9qNWRoSDJlWkpJ?=
 =?utf-8?Q?eTV2MJgXYlHXnMd9va8/ALkAI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8482f6-4488-4ac7-5bc6-08db8d8d104f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:00.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIY9JHLlas6scAZxPAzI+etjYm+i87hnS/qGS0wd9L9BuWHG7ZZzapYg5wzIKMp2+dV1ZE/ht8MtFHl9QOZwag==
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
 drivers/mmc/host/sdhci-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 7f4ee2e12735..379cb3892757 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -720,7 +720,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_sprd_remove(struct platform_device *pdev)
+static void sdhci_sprd_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
@@ -732,8 +732,6 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id sdhci_sprd_of_match[] = {
@@ -800,7 +798,7 @@ static const struct dev_pm_ops sdhci_sprd_pm_ops = {
 
 static struct platform_driver sdhci_sprd_driver = {
 	.probe = sdhci_sprd_probe,
-	.remove = sdhci_sprd_remove,
+	.remove_new = sdhci_sprd_remove,
 	.driver = {
 		.name = "sdhci_sprd_r11",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

