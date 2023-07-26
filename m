Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC607762A10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGZEKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjGZEJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:09:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5E5275;
        Tue, 25 Jul 2023 21:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4yQtpfsikGP+qZbYLyEYz9uAzb/jC9SAK01Rt/9z5Cd+MY9UzLMIlyFDzxOROgB1PSdrQ6dZxlAf9YXFsdEaCTzoOPgpHmuH7/Aa7FDrjdxZxmIMhHE8NbCYKs7MUfM1ZG18gyOS5q7cFesp97+VTtvYUdNAEd2iLHi9Li0eAWc+FKnHUcZhqEjpea72IBhqi00Excc6D3fPSwb6fn5jUWxOiChJ8OYzIlufBmuST3Xxr+dhzdb34cfzcxC0oNL8G/3RLuJ+x3LaSdonvB6FeImneCbpHqBJ5m9vOaH0vlURpZZp1RvoKbA4L4DHjXqWY4FpcgBFnlAIoYKT4kZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEBm7LsosykrIZ36xdCU79ltEaLYPmnrbi8vErCUUN0=;
 b=jTk45OyIKvO41egTVt93tjH70t73Su0CsVUi+xRarkJXe74Mh/332u+Bwy3f28pmLLV4IHrc+SyBiXqBBxienGjEncByZjhH15BYtTRQcygEMPkq7LAw2SBuB/tg+wT+hVnC8kxi1MMmjf530NAj//p8ai/+Oq3Tm276Pv7mNKsbKdiK0BduDKTl1xJ1Gh579mcieLdcOYVKTHJMgbr0bCc8mwEw/oGukMlceHD7khOBkzSF3opF59nPylhycS/baQ/0K8Y2IUls3qhiNqZhVsFQIaW/Ew3CEyYJSqNBE/MI0ziVbG+mWm+m2FW3yrODpTC+vJ3c2UmyKC9DhE+Liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEBm7LsosykrIZ36xdCU79ltEaLYPmnrbi8vErCUUN0=;
 b=atPNBvvYs64LVQUOmNacUMTLfBb5kF10Uhiyon2Vgsi6QI9qFcAVdzoT4OTAljOnZSj4v3XLlZIlJLik6YzOHvgIVwjgRlH+5wXtqvPU8xUpLzjwmAJYR4RKt1gzA2jnED/pfHUTnoD1W3tg1Yu2rfItenUxT6IiZYU4xH+xpU9IdDlFwqWrFbH5SPFluX9vxRjgB1wM+XfgHCAH2/xiNBRgVSOYG+ya5t1PfcDSLEKzn4oUHetFV1JQDbS1GpK9sE2PNMvS3wi69AQUGs+dLMZEotNjuL0dO392zR68l3+wUniKGXjFDj6sDXvzwfHWpgUVI3vez+bk6Mncc9Xx0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 51/61] mmc: sdhci-spear: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:31 +0800
Message-Id: <20230726040041.26267-51-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dadbe81e-e41d-404a-8c63-08db8d8d2079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j33NjLcSB0uobzIPCJJvC/W/UE+awO7J6fWB7Po0shoGQ2OWULPU3Y04tYNiVLr6Zffp7P7PlSY5UYOSC9Ppwmpf46ExJJcPDV78bMSsGzwfZoflnG5c//zfpujiYvUmVv9P/AGfe6ShAFEc4TfCXRyq7Wwpsw7lP/5rjM7ZeQM2824YRaL8gJ64uu2sCAN1RXKaFI2Sk2uYZ18KBeQ2vslZNNDnKOcO5LcZL4rVVz249u/pBbp5jCRcG7x5QZ9ZHFflxR5nfOE8W1q+TvF4TOWP4BybGxMqUG7kv+cVY/eDfTnoSkX2u8hDdsiPEblID2KryE5DR+cgm5w+tzJP5ru0hL6TAS9tKallcJmMs8ZxR1U7xFTc5Yw9h8BY0x3ybqUn6g8ZQQqQFnbRmI/Y+NqiPCOPSRgNcd3ItlSTNcF7EZV+M+hy7ep7GZ3iGBfJsWJq/EUihfh0rJH7aDkIseTAoWd/wOgRsX30/AlLkBTLWULuiy2S6oDjZDbHGSjszJQ9fSyq8hdheYHCnNlq6zq+cKVe/qPN/H0bVV9mGz7guT02lhCARhp74t2nkppTl8C7rlAwDcA06cFGcRmWZfAtnAD8epwAOdmLTJzNV3fOhErcBHGVjQYibVP8ganz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVdBdDFkdllXYWRaL2dtejc3R3c3UW9WZFVXaHU4OE5od0xUVjhnOU9EbHBo?=
 =?utf-8?B?WHM4UkdpRjIwbko1alZMODJIRWNWR1QxM2dOeXBrMy9SdmlXOFczQ1hiOFJo?=
 =?utf-8?B?T3U5aG1oU3BIWVhHWDliUTllSXlrNWxGUXNJM3VhN05FME5mRG4wcDYyV2Yx?=
 =?utf-8?B?YTZyT2VEdmpBV1Nwb3llVzBXYUdCTFBNTWtib0hyUDBFeTltZm9BaDN0NlJx?=
 =?utf-8?B?YlU4YkFSRDNBTnk1UjJXUytUbGlXWG1tNzNKMllKQUNza1h4TitNMzlXcktt?=
 =?utf-8?B?czlEQ3VCTWJhN09UeXBFdkVxdVpxcUIwUGt4d2RHSnZvU0x1ZXk4ZE1LazFM?=
 =?utf-8?B?L0R6a1RidlAwdXQ3N2J5V3p6Vms1SDJOcXlESGRMMElZQzFxdUgxQUJYbjlV?=
 =?utf-8?B?Nk10VXJzKzlKdHFhNFlMOVNiWk5OQjQ1akphY3BZT0JHckh2WGxEeFNZU0ho?=
 =?utf-8?B?Q0kzeFA4Yzg4eHYrUVF2My9pSFRBTlA2cDJ2L3dKNC9hdWp4WGNmbmExZXhI?=
 =?utf-8?B?dTh4UHY1MDI5ZnUySzFvdmlISVZIU05CWlNtRDdIbXRIMmJGM2dkVW5USjlO?=
 =?utf-8?B?OXh0RzNTbEx1NEFCN0pSeDYrdWlISGZNQm9jZzJFTWJyU3VVKzFhNmptZHlZ?=
 =?utf-8?B?cWpId0FGZG5vQU5NdURVbUlvYzVQWitZSCsyajZ4M2dXa25Tdno3R3AwRFB0?=
 =?utf-8?B?a3kzRWViMlJtanlXczVnVFFYSG9GWXdJYnZ4YUxNemZWQmdGKzJ1QXdVMUdW?=
 =?utf-8?B?RFlMdEtMM1pKdmFkamk0R1gzQy80Y1hIb2E5STNPa1AzL3VWY09KRDdZalJ5?=
 =?utf-8?B?Q0E0c3dVTVdqWlRxclhLWVorNVRrczc0MnA0M1JUMS83QmtLc0xiR1doZHpT?=
 =?utf-8?B?VDFSaHFWM2FKTXpZbDdNQ1JwNkx5dWttS0ZzbDl1TTZGNEgvTW5KbDJEN3Zi?=
 =?utf-8?B?elpQZlpDc2doMlo3dk83WWZqQUJaM0NhUjVYdDdqcDFVUFUzT0hkNjUvMXJH?=
 =?utf-8?B?NHRQQmtxUFFOR1pzY1B3NHZrV3NXVS9aV1QwR2dYbGU5STMydUFGN2VtaVU3?=
 =?utf-8?B?QnhPUklzV3BlL2JWWWRzeXVPZDNSc1J3ZUp0UXJEeFBYRjdxS1llaWVudmpF?=
 =?utf-8?B?amhUdEdHWHFiTkVVYWl1R1FvcGZMMG5PZWRRVWxtdnlWQzVwR1JITW5rNnJw?=
 =?utf-8?B?MTVFaXVOTk90dkJYeVBncUtudHlDUzNWYXJOSFBJSlhzVldEOTdDaU9UU1pG?=
 =?utf-8?B?Vlgwc1MyTDZtYTVhUHBqVTVDbmV4dzNkb1BRcUd5bEEzMnRQK0RPZ0loZ00z?=
 =?utf-8?B?QVloZ0YxMUp6MHN4SnVmbUZwRHM3Q0dmNFlRS2g0RElROXE2SnEvcEhRY1Ry?=
 =?utf-8?B?MFA0Y09UWTVEV01xZm9pdSt0QUxZdFUwNERUa0wwNUtnU2hxVW5LV3RtUjRP?=
 =?utf-8?B?T25NNnZGdWxsdTMyU3A4UnM1K08xQW5rQ3IrWU5HVi9SWmRiUGswOTcvK0Va?=
 =?utf-8?B?T0MvQWlhSHJubE1jSWw2RzhDNFJDbUpJMVFDWDJXbXBzSkIwbjkvK0lNVXpP?=
 =?utf-8?B?V0NoeU8rckJRSnhSeXIxcXY4UFRvKzV3aUQwVjBqb0RQcUdLUTVNeEtXSTVE?=
 =?utf-8?B?RSs5M2l0T0FnTFdjeXV4R3UrZTd1Qzk3VTdHVVNGNXI5cjVCeEVTQURWZith?=
 =?utf-8?B?TmREdGZjdUdrTXdvaUMzTUYvKy9qWmw1UTdHVHhpWGRZWU93TEZaS2RrOE9J?=
 =?utf-8?B?MmEyRUh6c2ZoaTFzV2FwNXlWQ3h2emR6NEZmN21ZSUpGWHhtd1JlMTBkVnJl?=
 =?utf-8?B?amxLWCthbEg0VjhXRWdTa1g1YnllS0hDYWdwMGVxUElFZEJmdkFTbjdUbTVn?=
 =?utf-8?B?emNJdmd4dVJWblRXRGxvV1JyQkNYV2I0c0x4dWZJazZYNmJuTndxUFNva2ZY?=
 =?utf-8?B?eko5MWNRV05zWWw2Q2tFWVVTRjBvM1ZwcUljYTlYZnIwWFAvRml1Y3pKV3I4?=
 =?utf-8?B?UEU5K3R5R3JHVlRhNDVUVXNuNU1YQTAxZXorNk9NYit0UE9EUDlxR01uZURp?=
 =?utf-8?B?Zk0yMS9CdGtyMlB2cVRDTkpNZGgyaXlERkxkTjF2K2I5cHk1MURyUmZXOXFx?=
 =?utf-8?Q?w3FEdneZeEaz1qr0bvtM/qR50?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadbe81e-e41d-404a-8c63-08db8d8d2079
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:27.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eby7EtEoMiuMK9Sekm9VIb48YO2FHXu3GizbaJ+wF4AwLsX5NX9hvAytANckVV+XczEDD5gUnpfAeo0t1nkJ9g==
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mmc/host/sdhci-spear.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index c79035727b20..ec6c7d8e3736 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -117,7 +117,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_remove(struct platform_device *pdev)
+static void sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct spear_sdhci *sdhci = sdhci_priv(host);
@@ -131,8 +131,6 @@ static int sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(sdhci->clk);
 	sdhci_free_host(host);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -186,7 +184,7 @@ static struct platform_driver sdhci_driver = {
 		.of_match_table = of_match_ptr(sdhci_spear_id_table),
 	},
 	.probe		= sdhci_probe,
-	.remove		= sdhci_remove,
+	.remove_new	= sdhci_remove,
 };
 
 module_platform_driver(sdhci_driver);
-- 
2.39.0

