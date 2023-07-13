Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1A751B43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGMIO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjGMINN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A022712;
        Thu, 13 Jul 2023 01:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmX0U0CvQUm+jGcUiAEPuI/nPvtRtygC7Iek4ki8pQPDlh94vorOKBtL3Dhhx0C5ruGMK+TgU40g+Ecx+Dl3LPrLMlSt11MxhcPZyqmK3JRX1pltm/AIQcFKPWM68qwzTWcQm4b1W9uYB4FPkV477oVnNduI9nhSBT3criKplic8/ntB1cklwvi+CXHuFYP0zcDqjWciMyvgZsp0msZT9RQPXluZT6/FnOOPfr6jOoaw0rWIexP0zSE4EqllgiplPsoIO5SBjOhmId21wI0TiJ/bIVfRrJ01GrLrNHeslKMPLaVZyTHoJo931MdGC0HnN9K13d1CW4KJgqakTs4PtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xBenoS6cHFlJZ4Fb3iZ6ctod7pdPtWLiCXA+h9S9tE=;
 b=C44O2vWuKgsOjhvJSQrglhUZOuqseDWCM2j2PC4fnaudW7AIA9mn734Wecv7umxYeWN/VXfBL1X9/OYwWPsvb6g8pnACLB1+ePfNgXGeNVJaJiu94pNiW5lHyGGA6M6+CjrFR61Gjg8kFqO25wykB68qCs2wpVngh7s4bKV03Wp3OlgvsHELPn6hHrhAO6qEI2hnfRs1oV5UK6w9QM+nCVKMEV+wEA3TJrwYY1Z5B3BPBz08JV5Z0us0v1VQaefLdPQ3ac5hIpxTRGsKCqj6ceQgQaP9YQbdGydTMeIssXPx6BRw2IlhwPHEyKGL+uPqA7Tr+/xZRUKWCMmFg7PIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xBenoS6cHFlJZ4Fb3iZ6ctod7pdPtWLiCXA+h9S9tE=;
 b=NYNnr1ieV/CWRL9t9l3VunDRihKgKZQB3oYr87SMfqQAwMGKjJlaQRVAZ7SYGcymCcEcrR7Mf1zHANOnLZJm7oE2QBMO1vkxWQRzJdnuTLx7fau9cV19i6zbVixDbb+7mQET0T9c3IR4JPAW5xtrB6+F4tYpzP1Zrhq+La6dMwFs6suEU5aAo1Bk+IaUMdqsJLCGXebzNN4NC24YGJnsDYGgDKT95ePrAOA/Wi7QgLRazaLBa1uqhBtJHupoGmStQZzDOtfTvpc+RIIlWlO01lEOLb7/3MzaEMdSb63eZ8MtMCOPff/uGzFWIegQAdhkC95CXOEjIOsmg7sTnjGNdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@axis.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 45/58] mmc: usdhi60rol0: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:54 +0800
Message-Id: <20230713080807.69999-45-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dde8bf72-e21b-42cc-eb7b-08db837881f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/4XVGt/kAI8A9rwIzZk01Dg3qv+q9k/a4s30fX7uJ/NDqsMNu65jpGwwzswoJkv2mRWYDME8RqcgdZJXbWT5TSU4bug3hb1BPeMZURS/RggTsH8uuDpmb2vxpt0kE8S5a2FpBcnFIdgE3YHhxphdrHDLS67bP1QsXFbqgqwpNnYacPIZGZKGMtciQ4/zmBHlc8SBF9UddYqVo0M5BclEEIK/WMxqrK4u8LSGYdhgpev2C+yzXjFIqzxoypuNgQTVhas2dYDi8A/b+y7Nejfw+WZ/Gy1u+rcT2iarxsK6ZxZKnqjzHdZDpfDN+Aj8e9ooRkZfsQSQyn7ioSUAlG74LmLwclRpD/nZZWg2T1WG2YRrwij2uELdLZTa5hBB8A4oiVcV+EXEgasw/htU2YY6VwV++QbjKYiRP59sd/H1N2lVgVohy/bBIm1hSbDGmfGdZ5s2Leg6zdkBxVB17S8g/+nXnuWvKoKEDxpboLddYGyYwpkFdoB3Hc94+Gac3GnyLT1KD1VbeLb3gCukzC0eGHhcoDgKPUSbUlFnxD+WYqrwfoR9NFKk8zvwnQxBECyeLjmwOhqlV0KzNWyo+cDbJ/jKN8/13+4b1hiDbdGai2tXLApOOZ2oNAt/Kba5Wfb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJPaHlNREMxNWdXZzFQbTR6dlcxUDNFT2gvUzZyZERHeE5SN2p1ZVZtL1Zt?=
 =?utf-8?B?ZGY5c25tc3NPdGN5eWZKYkVHNHRaRTQ4OVJ3K1lhQ2RnS0lJVmlDZ1F0cXd1?=
 =?utf-8?B?VGJxV3VMWUE2K05mTktjaU9BWTNwa2ZFNkRCcXAvOVFwWmtOMi84cTE4QXlL?=
 =?utf-8?B?NndBb2RNOGlldGRYWkJoRm1kVHA3cEpjejlFYk1OeUdLZittSWNXSnozNkNu?=
 =?utf-8?B?SVR6clJyUjNTSDRFVHQ5NDNuOVZ3OFV5aHNsbFB4cmY4Yk0yQlhiSzRXRjBh?=
 =?utf-8?B?NU1BTE42by9Ha3MyMUxJTHoyRmZQdFZoSUdmMFk2OHkrdkZMVXcvZUt1VWhJ?=
 =?utf-8?B?bXVoOHI2QmNkcVdaRG1NNDFLbDZlZ21Md1Qyclk5aTJUcFRCUE1ja0x1cTlE?=
 =?utf-8?B?RU9sK2EzcTdvKzdIVUhVQ3RKQ0JCcG95S1dZcmtwTWZRYmpWbWZydUU5OW02?=
 =?utf-8?B?VHBMei9Rck94WXNJczdwTTNnajFERHZDUmpoMVNhanVqOTc3UElDTEJnbnFP?=
 =?utf-8?B?TFRlMzhmRXY5QnVJekVtSFpLOVFRQVR5OTRIcnRNVmE5eWs1cXU4N0REcER0?=
 =?utf-8?B?TS82dVNRVVJ1K1loSytOMnBnRkRVUTVUdTU4MUlDUVZvYVQ2cm5VZFVDYUFk?=
 =?utf-8?B?MFJKRkFLRC9UYVpOdUV2M3h2eFY4MGhId3lkYTRWaWZmdWZKTEhYSmpoeDQ5?=
 =?utf-8?B?TmNwSkZHNVRKdXM0SXhJWWpiV3I2YmU1bEZpcnh6YStSNWNVUEo4aGRqem1E?=
 =?utf-8?B?TzVvOUMvUWpWdEhOcnBUYmVFQVpMcklTODkxRHZCV0VrSmJsSlhDaUxhVlMv?=
 =?utf-8?B?VlhITUpIUGJSZS9ZWmx5TnJiWUpYUTBYbHJYbDhJbDFDY3k2WVlLNDZMTW9X?=
 =?utf-8?B?ZFBjUTFsSWNVcGVRbzNTL0RleEQwd1NESUUyQTNEM1UvekVBRmh6M0loLzl0?=
 =?utf-8?B?OWpLVTNZNDNzNXRUaUxFWW13WEpsU3NpbldlMlZudU0rcnFMTjhXWjNkQ2ky?=
 =?utf-8?B?VW9zaFN5aEF6REVyQWdwbTFNU2FiNGZrblNzdG9IKzFKdlphZGV6Sy93aHRH?=
 =?utf-8?B?V2JKM2Rwb2taVXZrRWRUSjl6SktYdWJiS3FRTWxibHQwRTd3YzFTMVRRUysy?=
 =?utf-8?B?d0oxZFVROTdySjhEdE5raVFmNy9XcGpzd2VvQjZLd2lwaGdCcHNldnJtbkZU?=
 =?utf-8?B?bTRjak9FWWdud21maHBZVk5DSGhGSDBrM2lGVVJ1d3lRZmM3Rm9zZi9sOEcr?=
 =?utf-8?B?OW1YdDRGcGtpNVpxS0tMZVJDSnBLOXQ1MkhUcHFnRXBtdVlySTBFb0RwUzl2?=
 =?utf-8?B?aFJXL0dOd0JRUm1PTTY5TFJYTTNTdlRmY1lYUDF2WnorUER3RVN0TWUxSkFG?=
 =?utf-8?B?VUVnTk9LRTdEbzRLdWhaVUNyM043SWdZQjhqL2ZhUFZKM0d2aWZwSlVZdCt5?=
 =?utf-8?B?Tm9UQkRPWTltRnQxSk5kQ1hiWGVFelVYNFZSWlhxd2VkM05lUnZHMnp4SzIy?=
 =?utf-8?B?alo5RWFRMkJja3Y5elZNNnAvN29Kck9mTk94Y0s4OUVOYzFlRUhwN1p1clo5?=
 =?utf-8?B?Ti85bWEyQnE2SW1SdnRyZkdISVpkTHpNYjczekdjditIdnhQaFdiOEJyd2d3?=
 =?utf-8?B?aitXUVdWVmlFMkhiVE5Rd2tmdTc5RnM4UHhyUHBTSkFEZlVNYTVjR2dTMjJL?=
 =?utf-8?B?RGs4RHFvSi80NlVEOXV4Wmhpa09yRGNEc05LeW9BdnpQMjgxb1lFWFQza2c0?=
 =?utf-8?B?SUZjaGJJbWhOUXdXTW14cnZzZ3g0L1NTaWFYZHBGdEhUL3h2Qmx3WnMvUzM4?=
 =?utf-8?B?Ty9NK3QxblBVa1BCSUM1YzBKVmtqWUYxUEw5bUdOOGdkMng2bXZWQUpWVFpF?=
 =?utf-8?B?bkFXcVEvVEdlaGVKUjR2WlZrV241ZEk0eFVJRjZJL0U5dHl5eDVucC95VWpm?=
 =?utf-8?B?VjhHUGpTSm5nYUl5TUtZV0J5aDhSczFzZnFMbEEzWXB1VFBlVFlKOTVoMThR?=
 =?utf-8?B?cElyY09vb2JKMjRZUU9UWEtNcEh5ZTB6WkpIOGZBZHdZaVhVRzBkc0wrZkRE?=
 =?utf-8?B?OGU0VEQ2NHk3d3NIVTZ6ZFFIdEkyYXJzc0pIVVNrcHRkYkJlR1dxcloydDk1?=
 =?utf-8?Q?BA7kmZLfvaMoCe9+l7GYUhMNT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde8bf72-e21b-42cc-eb7b-08db837881f5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:40.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nULjHEMRtraFf4TnfdJndH3Pl9FiPUrtVrQoQ+aRmWWSAzlV3Zpj08mI7B/GMYSXALtNYx7RoONSZL0S2qFI7A==
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
 drivers/mmc/host/usdhi6rol0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 2e17903658fc..6e421445d56c 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1884,7 +1884,7 @@ static int usdhi6_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int usdhi6_remove(struct platform_device *pdev)
+static void usdhi6_remove(struct platform_device *pdev)
 {
 	struct usdhi6_host *host = platform_get_drvdata(pdev);
 
@@ -1895,13 +1895,11 @@ static int usdhi6_remove(struct platform_device *pdev)
 	usdhi6_dma_release(host);
 	clk_disable_unprepare(host->clk);
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static struct platform_driver usdhi6_driver = {
 	.probe		= usdhi6_probe,
-	.remove		= usdhi6_remove,
+	.remove_new	= usdhi6_remove,
 	.driver		= {
 		.name	= "usdhi6rol0",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

