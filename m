Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BCC762A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGZEMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjGZELS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:11:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20726.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::726])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B22723;
        Tue, 25 Jul 2023 21:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZzz2k23tY9E9DkzcFRmbjaNpQrBOTGkJRenj75ZDKzKnDndjCmTNKIVU7/4XAbD6eFXQwut8qnbDrRokFHPaZW1zfKD/+/1ykS0Nt2y2Fc5zvcbqGdZhuhFKseMvlC4vhS+ENQXD2yEeZW4j94XDEidEM8tkYfKdH9EGksnCSWOPga04iLO2QRZZOSL4UgSBr3nKzr/wbbCae2QcoWu3MYaubo92NvQdo8tJhCv/9Q1hZnrIwrVIeD3rGy19YY7pAFa1pJEiRYxFmGEUuTn2woBkQacOqbS0upnMrxEFwqyRi8E/bKfFrIDKV7lLt2eewdGBDWcxWzkM1NuI+6jPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5kSZGu3d+Pk6TuHZ/mAu3D5XOULVl2/U1CyZRthij0=;
 b=V3YF1yyS4ud2582uxEVjvzBC72F55wDH35VNgUix9Pvmcz4jPVryupf6LISrmNIDGBRTmSHxsnKxNLUdWtAwvJg1pHTfOSMn2k+OCLaoA49M+XXTiL64N4hG7/dnXaPW4OUwPwL9RD4X1Kod9IkDMCj1Jv/2scL5SMCRbNlxEXKcxXaraguFak2Y8XzUnibzzaI08YqXsC0wcYVnEtWHdw+FOdUyvyQlchblJDkoHHOhFY5whAgVv+P2qqXHbydL5JRGHBmC0uMLy8GHOsAoTaQ3HzeXAoShLZlV+YdpntTx9/Y7Qf+2fezeQ0wewByQavAO6qPFTEdYWe0e345ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5kSZGu3d+Pk6TuHZ/mAu3D5XOULVl2/U1CyZRthij0=;
 b=OcfGKrzDfFmG+sNI0yjO9px+fioRXDMmfy2PgFfKCu8Yhq6zCV7/bD3hl9JE6LPYTW7wyfOhMJcBU2o9Da+TGPq8hdsMbCcJc1E5jlrRQDFHGP9m617f0yksojjO0VoVhTE1AO8en1it1LG6AIDoVTEKLlvCYlEjjcmdK0SHt1KsBecEXEgqYqHLdLS74ODlIMaoiGgRmMVaOoU4k93Lk3fd5Wk2vx4yAp8H8e4FSJJ+e0NpyTC3pmqmefYORtBS7wlAjcRFCVvuDkRU1j1aXKdibJlWUU3NMqq0gqYtxB2Bkr+uOS+C/VnRURuJtWjcx9Ybgg8LGxVyu2gw5hvfnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 60/61] mmc: sdhci_am654: Properly handle failures in .remove()
Date:   Wed, 26 Jul 2023 12:00:40 +0800
Message-Id: <20230726040041.26267-60-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 299dbdc6-bba1-4a3a-b0e3-08db8d8d29ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjGX8+A+3DlKQM0PJnERwdyS1WGD5sKBYnpy2C48ArFo/Zez1KoBN56+dBIFjNU1ZqSR/M0PW4vtE4GOX1QFydUcjQOq9QISNJ/wmee9dvbWX4mnDIzys3G6yBa2I/CCarwechGswChtj9X/RjhsWeBnXWyMIQ74BfIp/1LzdaiAl3Yzs5hErdsMGnhOtWr6sKE2WGPnEG+OEseDQo53bVX50Aaccuyy7ZUS14gHEgU6rfbWBAYC7uh+4ONJxgZVDCtTEnQ0HE1A+/IhcMRHdbQq+m0Niz6aHZwLfyM2cHA0p54FVoVTFRwBW+EjrFmCaBrRTI8T5R2EayDxdz6jG9DPKNAjM7+My3f7J3eRhNVsBxx3VhEELMwzQ1hceYRPb4/+p6ngk+wRIYV2dyhOEuCNG3vblxUUYQlunDp3tM/FVtmNvsqjz5CZJ5CeyONbRG+UOYvkpv/fxGhDXC3D9XVhYiWhaThxzFYN6QTADzmXVb5uwilggNFBI6jdnw9CeuYgT+ZU/8nThEF69PDaB/qmsDvWg3lu3iS2N7RcZXLt3rq0QZj0DWKWQtpZKeuarXpwhQAquZV9B3iVX0rxG9oBjkkZ6KwUQZXDT7UorMzqTQ0Z4shI/NLytFnXMvq4Xflvf4syEWDQUO+QLU61GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(4744005)(2906002)(36756003)(142923001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlRZTmlXdWc1Umgzc3dTOTQ2QU5hLzFac09kd20xbHFiRkVUM0NsU1FvOFJv?=
 =?utf-8?B?L0dTRkFib3ZXYU1NYTVLTDIrRFJUMGhrcW1uMEMzOWtBM3plUlRSdFpGTzUy?=
 =?utf-8?B?STUyTmVzd1NYYXQybkExa3lTdGZTNFhoR3ZxY1ZvUWo3UnFEbzAvN3M0UFFq?=
 =?utf-8?B?UUVRd2NYdmgyNzJmWGx2Q2MzUE1tQlZsNXlMYTdiTWp5SmVaeFNkeFkyZ09E?=
 =?utf-8?B?UVNWRnJJcUJVcCt6OWVoZG9oTDNlM1hsUktONnE5d2tONlFKOU0xK0d1K1lD?=
 =?utf-8?B?MDV2U21aUEJNNkFkSmI3UkdhZnBVQlJ2RUt2Z1NIQmx6ZzJ3Nk1nMC9XanNs?=
 =?utf-8?B?VGROcWRlbHUwOUt5NjFCcUZQT3ZueHd3dFhxVFpNV2ZoTjJ2aytVb0Y3c2dQ?=
 =?utf-8?B?eEVnSmd5RW5ySHFXM21BTHpIOE1ESTc4QnRHdnBYbXp4TkhTeWVsSGlWUFdz?=
 =?utf-8?B?NlJmeHJ4Rm9qMmwyejNhK01MdmhoeGdlVnRlRVRKWCtUZ2VXbnE3T1BpendK?=
 =?utf-8?B?VGNYYVRYNy9weHYwUXpKVVVrS3RtNytUTTI5enV4SUt1WXVYRzJQSHZMRnYy?=
 =?utf-8?B?TXY0UkpBV3VLS0E4ZEd4SlpTYlFKZW1UZ3B4T2Y1OEdmQ3NacVpXaDYxSUJC?=
 =?utf-8?B?aXMzaUlIeHNnd3RTM1RKU2ZWd2F0YjlGbVZ5aXlVQU9VNTNCc2R5K0FNVzBX?=
 =?utf-8?B?ajNCNTNKb0lYNWdieldvNk9yUU56Mm5vUHR0VXREdytldk9VZ25JcTF1RE96?=
 =?utf-8?B?S05JL0xuc2dOdkZmc3p6cllndjNpbWZvTjVNcTMwUXNiVU9ORjBnQzlFZEVP?=
 =?utf-8?B?cnh3OEZFOHVEaUhlUDJHalgvb0tXNkJTem5LZFBMZWRwVEZQeSt3Zmg2LzYr?=
 =?utf-8?B?akZoSGJsOEpsTzdraDNtYVIyejA2U2ZkdlE4aVNxWmR6bTJqV1JrMEFaM0xB?=
 =?utf-8?B?MGZNVHJPc3hwTGxOY0poSWtlV2U0eVdMN1ZPT0trZUwxeEN1MUZ1RWM4bENV?=
 =?utf-8?B?TnRydGMyanl1MVpWaWMwQjhrS3VjZjBtdDVJWGlUNjh3MnRna3hVLytKMWJ0?=
 =?utf-8?B?Q3czRzRmSmdIdU1VaEhlZ1M5THRWSWxnOW8wZ2RvNTZNZmI2YU5NMVhnczA0?=
 =?utf-8?B?T0VFOTAwUzJrTzllWGZlN0ltVDlwZ3NBMUJWOTgybFJJdVE5VnNBeXVEbGZ2?=
 =?utf-8?B?SlJTOVpxVWlKRk5DWFFoMmo3Z2RMQjFOUXBBSGtldnhYdUZ2UkxESXVoWkhX?=
 =?utf-8?B?UnhwaTZ4OEtnWml5Wjd2LzJuOXJjdEtBaVJ0c3pVcll4NVlOdm5vM2FNWXd1?=
 =?utf-8?B?UWpFbkE3c1JpRS9RSUZmamtsUDJpRDgySkF2eStiRmtQOVgxUURQU3ppblVN?=
 =?utf-8?B?QjUzQnVuZ3p2L2pSdS9TcEZ1R0hJbmJYcGs2d0k3RTZ2Rm9zOTFBV1Z4amFF?=
 =?utf-8?B?Z3RpaGUxeEJ2RTE4V0thc250b2lPMjBXSWM0V3dRMm53UG1KY2JWUDUwK2Jn?=
 =?utf-8?B?dDJXRnFMMDczUWxuZC9pbjJpcytxOElaZjV1NDM3SmZvaWI2b0M2YUFKaXMr?=
 =?utf-8?B?SmNpaWswVkx6bFdCYUx4eVFHSGhWc04xOXVMb2RzUGEwK3NuWDV5WlBqc1ZL?=
 =?utf-8?B?bXljS2tESmo3NUhzUko2eEExUmVlSElzTlcyV0xjOTM4S3N4UCs5c25oQm91?=
 =?utf-8?B?TDFvOHIwVnBjYVZKUGVQYmJGaGdnM2s4QVhxalJ5WEVtd3B1U09VRUZVQkM3?=
 =?utf-8?B?ZXB5MDVBdzhDQmE2ZGt0anRBbTNsNVlEdDNtZjhjQjVRY2RFZWNPYXdUcDgw?=
 =?utf-8?B?Rko4NXRNeVJXdG5RNStyLzhiQ0Z6bkVmbCt1YXduc3l3QlBzb1NjZklJejNW?=
 =?utf-8?B?MDNwM3czaVRaRkdjMnBZRzV3dk5CcjNobUIxQW9qbWF4RnlGNGxLMWlpSXI2?=
 =?utf-8?B?aHkwMEM5dzFNZldOT1d6bEp3Y1RDQjJadDFzWHRoaHU0L2FqTkNvNzJIZTJw?=
 =?utf-8?B?aVY3NmFPZTEvbjNsZFZxZEh5Rkl5VWpXRjViclRNdGpRUHlNVjY3YkMyMkwz?=
 =?utf-8?B?N0Q4NjZOc3o3VEYvaTF5TEplK3d6R1ZxZHVJZk5ydVZ3azh0b2ZoYXB3amVF?=
 =?utf-8?Q?AN8bemQeWwPBAI3ZUihzjT97w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299dbdc6-bba1-4a3a-b0e3-08db8d8d29ac
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:43.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzmImaRH4xntLXGWw0CUzhdvlLw31KrdFlRZ/rj7c9dTox1fVRrvKlo3NVKBaaE16qUcard734UTY14HwK+gRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning an error code in a platform driver's remove function is wrong
most of the time and there is an effort to make the callback return
void. To prepare this rework the function not to exit early.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/sdhci_am654.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 7cdf0f54e3a5..abe83736d396 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -873,8 +873,7 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	WARN_ON(ret < 0);
 
 	sdhci_remove_host(host, true);
 	clk_disable_unprepare(pltfm_host->clk);
-- 
2.39.0

