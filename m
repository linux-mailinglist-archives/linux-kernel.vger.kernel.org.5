Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CDD7629E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGZEGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGZEFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:05:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBB2D65;
        Tue, 25 Jul 2023 21:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqcVB9J5OazVS1JxNg4p/2D90npr7aEIf9dh3+jYMeO+dpYQ734jkizbk11nWVkUijMo2zKzh2iqDMDvsduXEMvWUcsVieynRKP3azrvzaplyTlh6roQGAFY9kAGmvBWRHogpN6ETXywgRHWuczZp8SB+fe/uk23u2PdsjXMUHs1d9YlVpae/ydlscwb6FNOIrKFqXUue6DpE0T9Gme8J8hvDcL5CCzwc7fr2V9xg9zqEDQIMSCRmfNpmVd92r1uzvTkCFPPwCMhtUqilDFg/zlcYCn8tgiMxkVIYpd9P/hsuVttMtrebYPpZ74IxyyrwPcstLK07F7JGSBqNe2puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Zc+RUhord8kJyLZmU9Nv573/MVj8Cm1en61bIyoSc=;
 b=bgktIhcQ6oWFp/nYRYI1n9IiBb03nut410hIWSg+jyAYIjrRlBj5EbJBMizKH+M5MTbQiz/KPGH4q2L6x2bIPrhlurdJnGt3N1VOn72RQfXnDXS9kmg/RunJ6T0xkuIqL0070TqtGhsmu7A1aMfdSpSjgxeqkiokrghYvPUzp5ESs3GpkQCltjL2qYh+gt5DXDggtqv1kCicuh3RqMNmVp0omgH1IeMUfjKMBmomqy9sv0Sg4/uccWbSfyTOOdtfJnkXE10vBq5JTRX3QyCqcJxNIxzLGUDKgvRpxq43TiLjW322kKuHK7qrjtgCtRQxo+N553pjbxS9/HBFgvUPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Zc+RUhord8kJyLZmU9Nv573/MVj8Cm1en61bIyoSc=;
 b=ZA6RIM9gZAV4BxvQKco5IcZRSi1L90XfA8A0+c3H3sa9tf+sLExfEt8trYRTx4ccKhONKvxD+q/Pg9BXzRto+Fn9q2citbeFK42obDIhBCs/tc2Gn7ypbctcp1mlW93ViDzWSNKLIy+BrcDBMuUwwrn4TznwDzEzeICPKh8GdupMdwHX1iP58GUKG/OsFpABx+n3wEW8GRma7Bq8ZdJdR2E2GyIKxFNnTVIr0KZhC5qUYytgbGerLK/o6XxSTL9jby4RsQlzTGFj8yAgXktj/wzIbjSbd9iwq3Kuly7y6FlhN5eiyG3obILs/cPAW6iTEPSKKRBELBJEijvup/ZmNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/61] mmc: sdhci-of-arasan: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:06 +0800
Message-Id: <20230726040041.26267-26-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5219fafe-634a-4528-c71c-08db8d8d05fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtZwPbC0uOD9dXWAZmeSy4Io4fuFx9JvI8qgxlF9eEGH3PFTLv96gS/OjXKA5yY+hzz3KArhgzGyLPzlemC6pLdHmyp8OxOJL8t2bbKZYODENw8bAVlQytmlpywJxw8lWnHun9MwY0GWnqeEH5DMXddOWLaP4jRYHGd4KzMK8lGYQJA9uxKO/fzZgG/bigXZB8u4mzHVt5n2Lp8/R9tR4NuuuWGFbw9lvCX5C7cgSrpvQMUWcOMAG7hc9Ulhgg9fNeHfycrMqGXIFX8uwo0CJmkEuy5XhDNmL8+c57+hbd5WyAJT2XhtSg4qyU8+5wdJ0yuQWeFHkVuZwIAWvVcMiti1aIWn2v/SPFToanHhSabztKyBRmcuWkhNLLkxyA8mIyyajvaHllJE+/IuFfkPICI9bgq/Qt2XM61iPF3FPUvKUWzNfCRYrSfw40WYpbvvqKxrEeV/SFum6T0oG45HoRoDUCCjFdm7fNd833/alGgoLSbKuaN20MFoTTMvc8VF69p9AzOEJZwTNa+9M7XAU1decS4GNoQw5XJRjlJu8jebIycYKS/1vFUuIoA13c4Oy5n53W+OuN9pNoN8FEVho38CvUBL13ohnW8ACYhhp199SWpgtw5ZyICjYlFjrNYR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRKcm1Pb1p1czRYdklhKzJHdTl1NnROOGk4N1lwOXluaFVnMGZwUUxWWGh3?=
 =?utf-8?B?cmRUZ2lGRFoyaDlpUUJKQldjWXU4SWtCUlVpUDRYZENBT3lRdzNJSUovRExL?=
 =?utf-8?B?SGFJYyt5aStOM1dBV01nSFhaNjZpMzkrNDU5OGRxQ3M2aEtLQnhsSHBncncv?=
 =?utf-8?B?dWp0UTdYMmltczlOdHJxWE1qbmJBN0NJSHY1NURUSHRLZjQ2SGVKVThWK0tl?=
 =?utf-8?B?NFR1a3JWWTZwWUF2MFNaamV0R1k1YU5jMGp4Ti9RNTU3UmwxNU5RVFQ5VDdm?=
 =?utf-8?B?YytQMFIxcWJsWndXNksxQnFUWk9QamtMcGI3NytBazJOMmMyWlJNcmYyZWx3?=
 =?utf-8?B?Y0t0Sjl6V2U0dkZPT3pkSjhaaHBrMmNsanFUVFlJMG9jVWFWSXBXSThVb0RS?=
 =?utf-8?B?eVBLcUxrMmRIa0dmV0V1RWhGKzNUMENHRVUrOU55cmhFTUFVdHNaRy9BL09i?=
 =?utf-8?B?TG0rcFBoNHh5Z0hHMHREY2s3bmpoNEp2Tngrd2FUb1pQYjBJMExkMDVpVk8w?=
 =?utf-8?B?dmNBQ2VVV1F3MEVvUXRSUi9LdjRSZWR4U3N3SHhORndCNDVrQWxqcllaYUJF?=
 =?utf-8?B?eE82bDE2ZFhrbUhSN2hEcWhocndVbzlodmF3RU93bU1yZCtwbXUwbEpqcElp?=
 =?utf-8?B?MDE0NU9WQ2VrdTExdzVOc0tpRUtLY3ZWdXQxTnZHQUVyZlVHUTBsaUxtdWNB?=
 =?utf-8?B?ZDUxNy9xMDEwNUhHWDBMYmEzdmxNU0czdVRFbU8vaGRZTTdCS3E1UWNwSlJN?=
 =?utf-8?B?MUhSWWpMa0JmU252ZnFlTmdyY05wcjd1WGNFWEZiTVNqUUp0am83c01SVUJm?=
 =?utf-8?B?YTFTR2xKVDlUbndRajdPQWZHUmcyZWRtZll1OGJwTnFhWDE4YWJUNzZZaVhx?=
 =?utf-8?B?WkEyS3ludXp0eW45dUozRitndEh2SHhoUCtaYXRpMWhzc3h5OW5KTitMZ0dR?=
 =?utf-8?B?aUU3NWdjU0pDdkVyYUFMWG9pVDBBUWlnc2NtV0hTZHF3TDFCeFNtb042a1pR?=
 =?utf-8?B?S0xBK2c3UTVadGtsRnVKTmwxTzNQL1lnaFZudjJMQmZjVkZwUlRqd3djWTUz?=
 =?utf-8?B?a1NMZW5PMkJKSmtRLzd3eHVGR2pwZjQ4a1kwcHg2NUJWSkY2OStOYThReGlm?=
 =?utf-8?B?OXNtd2F0YysvdktIRW0zL1BLNFFxUEJHRUFiSmVjUllFR2YvRGZ0TnJIK21z?=
 =?utf-8?B?UnB0VTB3Tm5sWXBTbXFlNE9mUE1MQ3BrRGs4ZzJ3ZWVTQ00xeU9MUWUzT1d4?=
 =?utf-8?B?bytoVTVQVGhJRXBjZHdQekIxL2t4SFR5N3BtYjFMZTRkanhWU1p1cHpCbFIv?=
 =?utf-8?B?Sk9sKzJtMU03aVBYZVhDK3BVQm1KcGNuNU52di8wYXpiTlBGVFNIYkxTNVFB?=
 =?utf-8?B?VVpLczN6aHgvVUh6N1VJczg4UkF3VlhuZW5DN2xFQUxSbnF0WVlnSTlOU1Z4?=
 =?utf-8?B?RHRrcG85ZkluTFNhazM4R2xJWlRrSlg3eEpnM3lDYVRQNzFZeGw1OXJ4QjNK?=
 =?utf-8?B?K1ZqeWRoZXN1d0FPcEF0YVEwdWVIYUNzMTZYdGNIRVo0S1I3eGpqSWdMWkR6?=
 =?utf-8?B?SW5aVEZzOUZzak5sZHA3QWZQNzg0NWh1V1hzRWNnTnlReW5qZmJFTXZVeTMw?=
 =?utf-8?B?N2tXei9oMjQ4ZDZQL3BtV3gzcGdSSVJvRTk2YzdJY0J3cS9VRWJkbGNvS3Rp?=
 =?utf-8?B?R1NseFAyTWs0Qm55QTExdURmSlhENHhxZytRWmpSbktrTnMzMi9aZmc4S1RW?=
 =?utf-8?B?UncyS2paL2VvV3VJeUhqR2FqUlpIU3lwSmRrYVZGUTczUUEyYzZzWlFGMXpU?=
 =?utf-8?B?dVRGclRHYkJkOFJTWi85V2hLL1RqQW90QjBsa2J1SXdXWWVuVkQ4UjNpVVdG?=
 =?utf-8?B?dDVIZ0lhRlgvclFGL1I3S1l0U1JlTEwrRjQ3WlFmNTJRNTU0Unp3ZmcySWdG?=
 =?utf-8?B?dnM4eEU1L1c4elFLUHhhUnF6QnJ5SlVlM29Yd1J2SGdDSU93WjEyQjl6eHRw?=
 =?utf-8?B?b2RrcjJKZXh5K3BTNUdmbm5hMUVJQTVjYnhHbFk5RjNUam1ZMEdlakkyNStH?=
 =?utf-8?B?NVVKZHZzOVM2UXBSTFZZMUlpaGxxQlFCTGNTNGtSTi9KVFNlTHZLaGU3RkRY?=
 =?utf-8?Q?jT3qDIT4vJpVyLqBQJn4lmV4b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5219fafe-634a-4528-c71c-08db8d8d05fb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:43.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWsJ7rjL4jYgswUzvuPBRUxBqcMVlqz5IdBlw9pEDZpsM8Rlou93jzNG4u0ogAZQsGcoZR8WBJ2eg9U30YdbxA==
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
 drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 294dd605fd2b..160bab0c437c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -2016,7 +2016,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_arasan_remove(struct platform_device *pdev)
+static void sdhci_arasan_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2034,8 +2034,6 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_arasan_driver = {
@@ -2046,7 +2044,7 @@ static struct platform_driver sdhci_arasan_driver = {
 		.pm = &sdhci_arasan_dev_pm_ops,
 	},
 	.probe = sdhci_arasan_probe,
-	.remove = sdhci_arasan_remove,
+	.remove_new = sdhci_arasan_remove,
 };
 
 module_platform_driver(sdhci_arasan_driver);
-- 
2.39.0

