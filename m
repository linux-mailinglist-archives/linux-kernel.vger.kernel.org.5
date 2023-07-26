Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53F7629CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGZEDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGZECy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:02:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB96230F0;
        Tue, 25 Jul 2023 21:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY5dvD8eVSKw7kSxj+2HqZ5jDL3Xk7YNZWQOSN2Dr+9comgsFcPJKn5kRp4LaMgjk0kz6zF10qpmlmL0u/3Lutd1JvZq1+/hHKD6ht4pzNB4Y+25MoQRFvm5l6OfVT3Ipt2H+/XswCg1w3sRxXcFQVQ3u/aWiOzbeFDZU1q68rLgDN2BOvAt9ahy9bs0zn4qp4ZKwgJehvEfJjw1I4iJUMk9YkQFUAodBUIaVf0JhD1wDupBlbNOpVu7UVMVf0s8WOWecTXy3aVcZLPLivLXVD79AMWBo7bx6DjAHHG1GrlCJZ4DDGqJjHCgoxw2oxulejZv0qIQklRX/hGrZ/nPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf/c3z4jK3Dfm6LT+fxuyv4IoKncH6+TN8IV41mX6co=;
 b=X1nXqh3lCJsTxOZPJ2F+UhZGmHqZNL3MyH9n1aBv5/o41rCdKhFR6WFVoCqui3ixIS9l1itrHTYqN5ldtljo3sfHhcjafwo9g+USllbJijUfW7cnn1kY4swiJT9GmbTnhEVAsH6sqVW92GX0vHC1V9F/GCAevGNaoXG5Q3dIuEPDfqkj9X3AtSkkS8S4n/nVBMe5A6EKMG84wjaTpM9xKLFDfZ1P4xioer13f/Mj2sTsPejUN98sBRO8eyQH6Ab9/sRgCHaaNP8zJtFBP4Ekw3j+sk1e5BUovo0FCxsoYKCxWqkum372hquUhopRHlQjM3OQErtOCOaN4ktx9ZdWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf/c3z4jK3Dfm6LT+fxuyv4IoKncH6+TN8IV41mX6co=;
 b=KIO620I07EL6bFgsh8kkO95r5crbvKCyu5PaCh8p2IzOddxSYxhuGYpFWxil0aaiaDaA5cZUDQWKAQlxbqjpFfEspePqwCRrnyIzZ5lVtK6SmfBFiRrpw34cwU0onfeoMzcB0l/XRLoIjbBJpvTMre+U7B/b7Vgz/1NSke2P0BdihHNMLHRclmsAX/xQh+XvZZ/1c9Orz8ueweKbp6N7EmwaxAq4mU1d5GPQvS9E3QJxfdhARl8Gh4X8Z1xSF4noMibRegxSHN5PZL8nu5g3kZSTbMejA6c/WsBwSX/9tG6x66QF1wnVRj6pmrpOTD+tgaZlVFlooRnyVtHs2L1yrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/61] mmc: rtsx_pci: Drop if block with always false condition
Date:   Wed, 26 Jul 2023 11:59:56 +0800
Message-Id: <20230726040041.26267-16-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5202d598-0408-45b3-31d0-08db8d8cfba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B819JqcATNe9qM9hYXgmqPD14CD7WPFd2PkoGBHfTIOLFCtTI+91dslpyna1fWYezQVloahUj1HgcWzCiVK4jGHVg6FkZW/0nFi9mnbAg6UexVnnz9pZIM6LJzb28PYe+BdM/A5sV5EB+coiDXXQk7uJ8SspO5NTidAqZ9i6UGiedYUwEsG2GaVS/nC+N0W4Or9qGnqPOasjbXk8TpJcPfegGCxEifMI7kZof+uraaM+5eRzgb2yubrjBhD7XZtyNBuJ8Z29zIpTMEMYs8Vjm1T66Bokuh6ehqkZYdJSCDk9lD+AzQAtvz7EG0sBhCqojtQZvft/UCQA18VdHBoOYjNHC3SXqiOkdJg2lId6u1uQPL/tQbp25r+rp+CqtMIwiFh9FIk4gba1NKzY8ud2SKN7jj/7atq5j/UYRNIjTf+aaEDRd1vAjmGM25mNSgdt3PLSzstC1L8tmMFk4mSnaDi8b6O/vXnRy9ccHyP78gVUzmvOjqLYVa1wnxp8kxTExgCgMfUrszsfwHnNdu+/0yzK3/2l3TiL55oBqKsJEnHez1hl+HgPYEdVLHq09mxFnq5xZXOx/9imYKQk893GFyqagWJgQOsNT9o1bhF59d6F3dIun5jPiMjMiLD9y5bO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(6486002)(52116002)(54906003)(66476007)(316002)(6916009)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJucmp5dmdndzVsREZCOCtoOVFtRFN2SFBydFM0OEpxdUU0OU1GZ0p0Umh6?=
 =?utf-8?B?djBGVmtQa1hNZkVMalpsMFdRbHRiMjVqUHZqalVrRFBhTjN6ekRWWUFqNmpL?=
 =?utf-8?B?TDBDNWp6Y3hiNHhqMVBPejdDdjc4bzZ0VVR0cHlzUDVwTHRtNlVaVnFYVXN4?=
 =?utf-8?B?Z1l1cXljNmQ0cXllK0plNWwwMHdYZ1h0WmZGWGtBa1FQV2JRWkFRb1NPUFQ0?=
 =?utf-8?B?dmRYWXhyS2xOeVA5elNZQW9uK1RSVGtkK204NFdLMFNZWldYa1BaYVN5ZVNF?=
 =?utf-8?B?VmxRYlBqSnIxRFlIQTA1aWdJRk92YzZRTjljNGFUSllXQlM4OEJlbkw0S0lo?=
 =?utf-8?B?a2V0dndBcFFNb1pBV2hvMmF1SVprSHhaQVNCeEs2RnZnSEg4TGtHQlByRUxV?=
 =?utf-8?B?T041M1o1V1pUY2x6WGpzSEtrbUxRN0FDRExPYTQrT3JBdW92RlFyQjJVeEY2?=
 =?utf-8?B?VEJjTEpsbTRFNmFvcHFzUklENTVDbEVzblpmM2lXem1RK1BhS1c5WnRlWkg4?=
 =?utf-8?B?Sm1ybE8vaTZxbThTSkxDNHhMRk92VjFidkdiWXkrS3ZvQVcwcHFOY0FqcnJD?=
 =?utf-8?B?K1d0S3BsTk85czNFWG03a1c2VCs2QlVzV0FOR1JZcFZDcEh2RVVmM1BMZVc5?=
 =?utf-8?B?dTR0cDRaWjVjRmxWZ0tudzBCZDVscjkzeDgvK2JtYXFpejJFVGZnamIwb2Nq?=
 =?utf-8?B?MkhvYWdJQTJIWWRDbEVHQnpWV0tjK3QrVGNtcVBYU0xENnlCUHFTNzQ2SlE3?=
 =?utf-8?B?TXYxR3NPSkRTS1NHWlIwRVk0UGhZdS9Wa2JxZEhlN3daeVUrbGt1K2U3WE45?=
 =?utf-8?B?anZBWWFzZ2ZEN3p0d2NXbFRnRHlRYTdXTWRSOWNnMm0vWDAzcFR3bWk2bTNm?=
 =?utf-8?B?L2M0V3NCSXVKN0o4TXZDZkNlUUZHMmJFeUJLOTllU2JRRzVMUDZJTnBUOVlD?=
 =?utf-8?B?UktxWWtISFBEd0tDQjFhdDR2TnFtUm9oVlh6d2hnaSsvRVJzbFZ5N2tCVHhV?=
 =?utf-8?B?QnF2OG9BcXpiWnpuRllUZlBidHh2eGMrTklUWlNlQ1dyMFhncXZmdHNLWS85?=
 =?utf-8?B?UURZaVZqc2hJemhtWFpsUUIycjNTZURXa1VGTTNBNnl2bWdZTXUwZE1FTytk?=
 =?utf-8?B?aEZSQlQwWUJQbGN0ZWtBY3NWUjhtTWlUZExYVVgxdDZ3YmdONWVobWJObmpE?=
 =?utf-8?B?blJiNkxDTFdsSFBiMkx4OE9oaGNBNHB3OERySDl1U1hZTDBQWm13V2VLNmlP?=
 =?utf-8?B?bzhjOXFMajFyNGE1ZU5VS3FOTWRtSW5XOHR4SGlEMmFpZnlUVGtLb1QyWVVt?=
 =?utf-8?B?Zjllbzg5YXp2Rk5hQmt0MDZPSU5tTkpNOTVCUlUvQWFMNlU1dTZSa3JLTncv?=
 =?utf-8?B?eVVuZFpNNDV3eWEwZ084cllqOEd4ZC9JZlRJUi81YnF5MDF1L3lBZTdyZnMx?=
 =?utf-8?B?TGhINDZMaVdJUEVLZUQ5QnBuanYxb0p2WDVtTU4yc3dkOHJhelhvYjZYS3RF?=
 =?utf-8?B?TGllemNqblMzWGpBbWZwcGZsd2R5TGtORzNDYnI1bmF3MEo2Q1AvUytPWGIv?=
 =?utf-8?B?a0JvTlNkUytYMHZSQ0VKNUVMWXI4L3E4L2s4cC9rMHFyeGh3QnpEY0FEZzZk?=
 =?utf-8?B?TUZ4UlRXNXZoVTBlM3J2YVp2YUlka0hlQW15Vys4U09NTGFZekR5bTdScWl2?=
 =?utf-8?B?MnA2K0lSTUJ5OXRNWEhCRmNaUUVhZzdaQkFPaGdZRzNkVnUzK2xVazEvaElp?=
 =?utf-8?B?WTRuWnNJNiszd1VVR29vMUpLVW1SaVM2ZHJWcjVNWUJCVlY3SW5DRWdCUVl5?=
 =?utf-8?B?c3ZRYno2SXJhTHp3OW8zR3NzaWEwcmQxaXZrOHdSWWg1dFhRZGc0aXRHRktW?=
 =?utf-8?B?RkZmYms2NjZqdUVQZG5wN1h5cnN4RXhnWk1hUWEvdVJKVXJBMTdCajFRTHhr?=
 =?utf-8?B?aG1UOVRabk9sVzlZU2I2OVZjTStuN21tdjUwRFJuTG5uc3ZhYnNPRUtFRDhy?=
 =?utf-8?B?WXFpcEl1a1VMUmExbDdJTXRkeWdld1V6cWhsaW56UFd6SWFVbXJraTBNcWVt?=
 =?utf-8?B?c2tIUmUrZGg0Z1dsNTFaZlhqcjl6ZEdLRDlvRllMbE1GRTBxMmQwcS8wRWxr?=
 =?utf-8?Q?l7TagmVxs+jMXtovZPTbG/O5q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5202d598-0408-45b3-31d0-08db8d8cfba8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:26.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKsUSwmPsYn3/wYiMVBsT1h9qk+Xa53U4r5rSrPgJfKH0PqUVCDmhqUebC7jTPa7aSB7uZZ11x7ntT6y4rJ3kg==
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

rtsx_pci_sdmmc_drv_remove() is only called for a device after
rtsx_pci_sdmmc_drv_probe() returned 0. In that case platform_set_drvdata()
was called with a non-NULL value and so platform_get_drvdata()
won't return NULL.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 8098726dcc0b..062d07c2ae5e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1529,9 +1529,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	struct rtsx_pcr *pcr;
 	struct mmc_host *mmc;
 
-	if (!host)
-		return 0;
-
 	pcr = host->pcr;
 	pcr->slots[RTSX_SD_CARD].p_dev = NULL;
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
-- 
2.39.0

