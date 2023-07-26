Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5317629F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGZEH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGZEGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:06:38 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D5D35AC;
        Tue, 25 Jul 2023 21:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMJCCLHIUxX/P9pwZSRiiiRcehnRO/aA6BdO6hdBArv9dSP26j7DO1KFGA52lVvg7p74VvJRQ17X9ZCofyEaWZ8KW0ZCYB4Ox/XqM8MPTHfT8a7XOEVyx33T7vIamcfRIam4bnfZDd0vjWilpOm17KjakKT/0+WFmfKsFF+uY4EzWx+6LvUMgjm6kM+aiI5YoBHkgfhLm1RbEtF1LScChH+YfUTMUhi0JZsmUrro/iWqBXTd52mWJGOpued437gxQUo4PsK4OFE8Qv97lzezd3jFBpl3VC80Onv7rKKlxf+BIVO+BDRgzbUoWEB6HnRn3FKn7rpdtexAMUMFiwpBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw4Pv13PwJyGo9i5NmSf9Iol6jil3qv/WJ4az+CnkgE=;
 b=VoCUTV9disEx0vj9y6Ifj0+saVZCsf2W6jI6FPT9XGaoNMwOQVm/uMylEj+NEdaYyU1zoluXNtvJPvnNzhxz0MFtBiaa/h1q8sBxxcV1c3DQMK51z6ZwbP2Ts2MCp8HLuc1Kz4aj0ESNk3T4kAgNfA3aOoVhIRXXyW6xrgYCf1L7zELUZtitqUyU2hSuvY707j5fqLFuq5UizHWyYghioRcOzO/h7NB0lLyiA1FX0iTj07pVurM6bv7dG8rsBz5nkyQ1hX0yCVIUZbc359zcfAlikb97Boqgdy0aEXep/N42fTv6stl7TuKTce+HnL1wAWpumZSJEHsdEK4txJ3bFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw4Pv13PwJyGo9i5NmSf9Iol6jil3qv/WJ4az+CnkgE=;
 b=mt80DIyyjCEnTeGX13DfV4Zmh5Y4mJu+xam9z3acOMppNAh3K1F2DNHwI5VFD8eeEnylG4roATSnTl9oIJ2FEPB2ue8IM/CpcEjDynUlrpjutCRxzcAdGgSorUHD6SRVEehN0qe2Nv4OJeEtePSzaNSPZZo38ekFU+/P7HU+te3GPaZ0fM0md0ZVEfTqW6AxNqwjzT7v4/BflKymveDR4hb7A3O1YzTU/l7UAqOTobSX32Fvz9PTJ12d/VmvwSqnJsEMtCkADGKXpbQAPSV2lPpp+njOPtf3IuS9cfI3EHH0e76IvCdShtGiiZO1hKLkZ3XpiXIYbA8bTZC3rfw+xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Robert Richter <rric@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/61] mmc: cavium-octeon: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:09 +0800
Message-Id: <20230726040041.26267-29-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54fd2186-051c-485a-0b18-08db8d8d08ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gn6dE3PGSdLd1nq5MrzZDyvJ1H1YLjL2kkOA3xSb8c+lxQS2olF2dIuKzYvgn+Qo65j81vairkZWKeROH7HNwI134Ync1oTMg9Z8FwLkb0jZpBIdhvFDNVZ85yfMhhFSjIXIyfkfslHl7Lb7la+XEnKJgQ6EpTSv+oyzxGoN5k/IsGBsNfR7x/OrCF2Kf95Y0ERPITS1B9aVdzquPYtAK7xSJ16u6dO8DvJefUwvjwMmTukFRdsHIfHL9enkv3TSfQGk49BD/zKHu3Kc9ovu1AAMxat951M93CJ1mTla48kAqZGcVOBt4pQRFuCJR2KPfZxTiokC+xe5fZR98EBNguB8xhnlcYlhXLhNzky0qRL8NzH8nb4QheEI7T56AvDMod5U7L0qeEXJpUkEhhslK8rUskZ+OdnI1v+FHTUuoMrwYokTjoUD24aoNGGK0oErFqJZ5BqGIqPBQZJ1BgRqA1953ctays8I58lEvXd4Ra1EoMHorN1eZbR7QzLsSmBAFl+4yQzHiV6cgMTwefe0jE8hsikf+Ub1NU1co8UQc+W6N04oH8DBeAZdyJQ9DaFRBGtCGKC+F0bYUSUW1n5ZciLIG5UtgY0F+Jju9ARZSEYymnKyIAQlPSysmzzNFjSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JhOFNoVlpXd01TN3R4Q2RUOVg3NG9Nb2haRXpPaitGOGJNTlR1aXBhdHFR?=
 =?utf-8?B?Q2Y5bjVHN0x6eHU2L0hyUWhZRnNGSEJLc1VoSEZ1Z2EyWXhhY0M4c2dzMmhX?=
 =?utf-8?B?bmtzL29TdWcyWm84SGcwOGNBOUhUaEZLT1NWZUNKV0NuTXJtUW9aQlFMNzVR?=
 =?utf-8?B?bFI2M043QkhzZXY2bzVwYjBlYjN3NlBFSzZPV3c3c2U0YlNxd3VqNXYzY2lC?=
 =?utf-8?B?ZXNJUU1XenJOU1dhUFl4Wm9kdDRmck5QSzhieUNzVzdyOGNNemNHZWZmcDlL?=
 =?utf-8?B?UDVnRExZZTg1QS9rTzZJWlBVS1dXeWNzYlFtM0tacHNCRHdJc3doRmFSNEVv?=
 =?utf-8?B?ODFQWkQ2U1oxa2VqN0lacTJKMlE4aVgzbFVWK2pONThjMk9rTGsvcnRrYjBj?=
 =?utf-8?B?R0s1N29RcmJUUi9Bdk9GUGphLzZnNi9waEQ2OFZ0aFVldHJQQXg3UXVaZ0I5?=
 =?utf-8?B?YTVFelhoUzNUOVNWVFAyRUxpblM5K0lreXVCN3cxTjcwbUpzY2I4ZGpnWDdU?=
 =?utf-8?B?YXc0RkVyUzBwVWVCS3ZxaThiVmdTQmFxSE1vYXFFVWp0ZEZXR1J3UEV2OWN2?=
 =?utf-8?B?NFAvMEpITlYyWFJEQU8rWEkweFFnT0NtUTNiYWQyT0tUdDF1M1UwNG1DdlUy?=
 =?utf-8?B?YmRka3Z6VEd0NWRZQU03clQxTlNTYW1ib3NwNnJwMjZSR0JwWjdtUjhoOUln?=
 =?utf-8?B?U1ArWmt5Tkw4bmxoenYwWkYyN0YvQzJWL080T3BoWXhwbnFuQkdiaml2Smda?=
 =?utf-8?B?OHVSR29FUTVxY281dzRNN095b2hnZFhlUWY1dHJNTHpiRHpuZlNIOUQ0NGVs?=
 =?utf-8?B?M3B0WWpEMVJpeG9sbGp4ei9KYks1Z0MxSllkV0N6b0FIaUFMNVppTTV5YTBr?=
 =?utf-8?B?TE5TRTFYa3ZCdXlUdDVMUXpaOHJOeDgxcmM4SEpWTW5zYnFoL1p0RVpxaW5k?=
 =?utf-8?B?NzY2SnJycW1OdkJiZDZRWHJpb2IwbG1KRnR6MXJmenVvZTAzRisvZUhrbnRR?=
 =?utf-8?B?UVF0aTJSQm9QaVZoZmFBWUljalBzSEtOa2FNcDBhVXJ0OEcrYk1DdnQ1T0x5?=
 =?utf-8?B?MnpnU3kzZVdDSmQ4eGQ1WGl1U0RocXNTM2J2NDM5ZE5lYTZyNllCK2FBVlho?=
 =?utf-8?B?Ulc1T2V5NWZYRVBJWWtEam9mSUNicGVFSUhkM2hxUUtaZDFuTk9mSUY2ZW1j?=
 =?utf-8?B?cVQyMTJsL205U0RmckxIQ1pxaXB3OVdmeGZGVHQ4NnkxN1IzVWp2S2F5UmY3?=
 =?utf-8?B?NUREcHpHTk5JSjVrenFlNVJmNTNQNytlNWlpZjY5U2xUenZqV1c4TXFKNVFw?=
 =?utf-8?B?Nmc5Zzd5Zm04QjdOclV1S1VZbUlOV1RDYmc1dzRxS1JNMjEvMWMvYmc4SjB3?=
 =?utf-8?B?R3ZsS3V5dG9HekMyL0Y5U3R0R3NtZjBNL0NwQ2dvQkY3YmxLdnFCazNtTE1z?=
 =?utf-8?B?Z2lFWGpXQ3BxdXovajk5RDVVaERZRzBIVjRzYkhPYm5TNklVSnFsUCttZ1A4?=
 =?utf-8?B?VkEyRlowSFd4OFVwdWRuYm5rM2xqTCsyUks0cytrUTcrVFVCakZOSThTTmxX?=
 =?utf-8?B?c3ZTWlpsL3NlNDROVThDQTkxYjArc253dUZUbGxLY1EvZDFHNFBSamlzcXRn?=
 =?utf-8?B?Ti9VVUJ2dmdrcnVOTGpDeGJmUVB0QTZlQWtrTUZzNi9WakF3K2pSUW1Uc280?=
 =?utf-8?B?U09SeklCKzhnVHZyNGVQTUxmdlVHb2k5ZHA3NzZsMWFDbTZmT08vdVkydkxX?=
 =?utf-8?B?SHBMK2djNXJ3YjNyOWVoTWZtQThlNFU2Q2QwckgzTlN4Ym15c2M0WDRvS0Fy?=
 =?utf-8?B?YWtlTTlIeGRieFBZd0loKytCMUEwekVjampGMEI0T25scUMzWkQxNEIrRTg5?=
 =?utf-8?B?YkVVOWZYaVkrdTlwcDJlVnJWeWRvOXhLRWZUUjBWcmpEUHRoVjZWcG15NUQv?=
 =?utf-8?B?SEtpam5lRFZKbzRsY3JHNnJtRklLUURFYkQ1anMyVlNEVWlMYkVRbUF1bnRP?=
 =?utf-8?B?UDRmZjZvcFJaUTAzSzlJcjdxdEY4UUpla0ZsaGw2QXBPSXlDNURsak9jNWVr?=
 =?utf-8?B?TS9sR2dzSDZ5Q3c4blh1bGw5SHNFWjcxUlJVcFJraWVBVklRWVdhVUJlT1V0?=
 =?utf-8?Q?9Uzz6JBZArh3b98mQZ6l0w4hQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fd2186-051c-485a-0b18-08db8d8d08ed
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:48.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r10X96zQI50bckvCV/62xAPExYVFpqRdSeL98EIJfWdM/uD1xQmqEG0U/IznoqkbhiDt4cIwJ8F90sb9D8qNRQ==
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
 drivers/mmc/host/cavium-octeon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 12dca91a8ef6..d526868b30f6 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -294,7 +294,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int octeon_mmc_remove(struct platform_device *pdev)
+static void octeon_mmc_remove(struct platform_device *pdev)
 {
 	struct cvm_mmc_host *host = platform_get_drvdata(pdev);
 	u64 dma_cfg;
@@ -309,7 +309,6 @@ static int octeon_mmc_remove(struct platform_device *pdev)
 	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
 	octeon_mmc_set_shared_power(host, 0);
-	return 0;
 }
 
 static const struct of_device_id octeon_mmc_match[] = {
@@ -325,7 +324,7 @@ MODULE_DEVICE_TABLE(of, octeon_mmc_match);
 
 static struct platform_driver octeon_mmc_driver = {
 	.probe		= octeon_mmc_probe,
-	.remove		= octeon_mmc_remove,
+	.remove_new	= octeon_mmc_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

