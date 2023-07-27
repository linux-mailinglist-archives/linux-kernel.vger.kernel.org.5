Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC857647D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjG0HHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjG0HGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018352D5F;
        Thu, 27 Jul 2023 00:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGcn+I4Ub+B0uY1L7jneCX5ykg6CYibcpcWffsHhkUPgLy9t1mT22Nry4TsXxfygcYTDqQT0lNzktYFNBGuC8WRMZ2sQURO/bz+jGRhWdheNu3WNe6KLu1HSizBJA4tY41cCEL7UI4ShVibDLApL1v6K7z+z5vwgJMfj+/F1+pEhjZsoDsnmAAbeaKM9ucWtlcvp8s7TuXd92FuyMeaahrBas36GQbaHtmHNQBotG6ZHZkqLsvaD73vJB2dAunwzm1zgLAK6kSu/dJCiXVNAxKkMfnQrGNMjI+T1Kn/RRUIBUYOKZ8oHKUD/9hohqDt2VPH1YFPtnAegjzecWkrFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMjCvFA1NPvX3oCRuaryE7iTIS0yrHphNTOEU7WI1is=;
 b=cuhcpcgQqVTlJWnoeO06/yfxS+j8uS9+WccKHyBi9ysTq9PIXs7M7Mz0vbZ8lmWe764bleGmjYlUch7cKnbAoxPgxIVVp6c0kqjn2UWNPOWqvGg1GQzgWPmboK4+lycDUyJN/ZcjYtXcfLMX+7uA0vBc87nqvHvBshfUh78k0M4kvXtE8ZBV+7yy1EtbJYIJo11wT9Jm3KCtisWZ2cBynMs7GOtPHGfYrQlqQJwRYRjFFneIowt2nZNTTgRaAkFIFLKpm1mls0EHd2cTWDBqwhj0ebzJIuP+rJP2N78dXa65CcgwI+cnnEAB0N/GwuK21Yx9kFkmdlxBJY1DQWV73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMjCvFA1NPvX3oCRuaryE7iTIS0yrHphNTOEU7WI1is=;
 b=mhiIjKZSoXAOVm/ZkisFNbTezKPtp7U1vv3iPvOqhMCSklivuWPh+GVOaiTdz5iN+FXlrDsJvEQ5dweh7+38ThtqOP2miwJkkusMMwTod4ccA2yHu01VyJcxCjK7vP0pwGXia/S2FRq2BrcEqmSoe/pgRkvAgEyu4r9vpI5yJ01BudvIHqFi9IvtOgOMZUjAtagNIMw3QPqa1MX/vOiBbBrFl0xbKI2ADSmusf9GGGorB8jqMqtTpnBWmdEmJXlli8YEEqRAk7g6f9eG5fZnIZDkmXZtFo02SIEmKlK3Ve48RUvy7k7STLRdsJgUV/CF/ze4PG7S4vAnMx5PA5Lxtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4152.apcprd06.prod.outlook.com (2603:1096:301:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 57/62] mmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:46 +0800
Message-Id: <20230727070051.17778-57-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0b5464-b2be-453e-8a6c-08db8e6f77b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tt79AfqB03ZaMLP9dg19lbuhbHA15Fx83IAbsUMM0ke1D4n7pwlZSA0fygnHhTcz/9FN11wqKZLWK0lR2j5wp2JBjWAV7JbE4kcBfCQVZO5RK7usWYoOSjxVIt9QprhCT90SKlcvobbqdwwQfmEt6j0LyGcOTSI8wa6KNRrv1ckhqV+amiq67SWGFQOIkOtJc0JhffEnTLsUzMk9gsakORIZhr5YHWezS3iawTawczD7ZB7o4TZiHz50muYN/qKQRrUHV458vxRN3ZnXrUsEeWoBJMSLJ0nSGQHVgMG+NA+ySgAKC4idhshCfwxo854IB7UGEZj/y9U/KL/6HstyOdUNxFWufOvERhFXP+fh67ZqQ18ePr3bN7fiHsavxpGrKUhT4fgG5ll+/znAh5HSRs82Outg8EwTuXmTa1u6T92RSFrKhZYbrajxTylfrikvC5efXaoPCz2wde6LIHC6akK6tEaq/8Ryjsv4cDRlaptRxkwslVxD1mnB9P2gQTbKKrfCjyM/m1D36Y9CZqzDtlY0WwXpw2zkpERQYGtgmh5bz/xsea7gyiLx+OFtyqycqwAzCNbIiqBGvBjPHs/DvlyAiDpFIvTa3x8JfrcFsQ1F3DgtySN+ZmBQ4CRnzks5lF4rkLiFP7WFxoy4x+CoCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(451199021)(921005)(6486002)(478600001)(52116002)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002)(66556008)(66946007)(4326008)(54906003)(66476007)(110136005)(186003)(2616005)(5660300002)(7416002)(316002)(8936002)(8676002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWs3L214dXBIaEZ2dEt5ZzhvU0hKRUtOYXY4Rm9JdS9UMmNmem43V01zSWRz?=
 =?utf-8?B?THR4dk1iMTRSZ0VqTlFMUWlxWVc1MlpoVDdiWXlMTmMxSjJBSXBkK0hMc2h5?=
 =?utf-8?B?YUhyZjZsQTdpY0dhVmNCcjlsaFkzejlOMFZrY0ZNU1RGRkpMWjVVbHRhRzR0?=
 =?utf-8?B?K1ZqWlNjRG5LOXE0ZHl3eGpDcjlLUUw2S1V6VU1QVHNsZGFXQkMzMTVFZmRi?=
 =?utf-8?B?b1JESXlpQ1JlQWN3WEF1S0dsQ0FWNlpNSmR0MGF2VTlYeVJCY2tFRWJlZmZT?=
 =?utf-8?B?MXpra1NhT1FnR2tSR1hHcFZKY1hpbDBpcmZxdk90K08va3hMak9HWmRqSjZT?=
 =?utf-8?B?bU5YZWlSenp0TDJ1L0NwQitBTytub1FlR2RRdnErZGY0c0hMajNDVUZOMDJF?=
 =?utf-8?B?cVhRbWl0SmlKeHgrU0tST2orYjYzNTczdWJFVVp2UHVTYkVrZXVPaHNMS3Uy?=
 =?utf-8?B?VmpMRkFXZnUxV0EvdkRYanhhUnUwYVVBZW1aWEhQVFFBa2JnYTZadG1sZ2gy?=
 =?utf-8?B?bE1LMWlGajdoNk5sWWdlRG5WMUNDRDZCTGhRSXJhYzRnempZWk0zNk53bmpr?=
 =?utf-8?B?YzM3Y1VpYUVaNms0MHc4dTY1ZlJWM3pYM3lneGw0TGxhZGNOdW1VcmdCQWVI?=
 =?utf-8?B?akV2aXZscFpIWk1RUkVlN3Y0a2ovZEhCckxyVjRHWWVGQ2piR1JEb00waDF3?=
 =?utf-8?B?dVhSL3dZdnk4dG5TdmJYbjgreTQwQkF5NmlYVnFBMnhWbkY1SnBtb1AyS1Rl?=
 =?utf-8?B?d0pQL0ppZ3JVTkd3MUp3WnprWGhlc3FIazlRK2x6cDZDdWNkTmpCbGlkdUlQ?=
 =?utf-8?B?bE02MnRLanBhcFNhdm8rTmszd3VLYXdRMTdaNm9ZQk5udzB6WFhvYloxM3dj?=
 =?utf-8?B?Z0VwM2cwcXpmSWE1SDBvN1ViM0J2MVdhRlNUWVRodUxHc1F1MkRXejlyc1ho?=
 =?utf-8?B?SlRUbEtUZnlwdzlXalpJdVpFVUNUT3hwWk5JQVBiTDE4SEpCdjY3dXQvNGwv?=
 =?utf-8?B?ZUJGNnMvR0tXZTA5U09mMEU4WERCaUlPOHZyNlJ3OVgrd3NBckNrM244cjNE?=
 =?utf-8?B?ZnQ2clhsTnNjbGhnbGRTblQzdkgyLzBGQUhvSGl3ayt0aGo3Z21BMUhJZW9S?=
 =?utf-8?B?eURZMFhHSENmZVZ0YUR1dlV3aWhjdzkvdjA3MFRVZjYvei9aVTZPdHI4ZGhV?=
 =?utf-8?B?RlhSUy9ja0o2YmJwdEZyenNaR2JXT2NWNTRvcGx1Vnh0UEFmYk1qV29CdjNL?=
 =?utf-8?B?YTREd2JUNllwcjlXdXJzRHNLRmNmQkJ5RHUxVHFFVEtCQThqeWtGTG0rS2RY?=
 =?utf-8?B?dEkzVlBFN0E5NmNQVE1MWnZOQmQ4ZGNPU29uR29QZmpjVHl2K29tVFBCM0w0?=
 =?utf-8?B?T0traFdEVTFGV0YzdFJTbHpyeTIweWFGUkdndWYrZUtWcXpUemM0WXpQUjJZ?=
 =?utf-8?B?R2dPbm5ObWpMMDR4WUptZjBKTFlhK2k1V3ZuT25qTzhrZ0lPTTJHNk9ya1pt?=
 =?utf-8?B?QTlFMis0S2tIb04wdUloVDhOTFphYnY0WFk4aUx1dWZYcTNuMitOYlJ1YW1P?=
 =?utf-8?B?SlY2blluSTVnOGpjdzdvVFJEME45OGZjTlErVGZOSkl5TzNudXNUN29Hb1lE?=
 =?utf-8?B?ZFZVbVcxYTVBS0gyYnlMVWdGODBpMmZ6ZENTNW5GR2cybmNiUjVsZUNGWlpy?=
 =?utf-8?B?T3lCV21OQlB5dEhTWHZpRG52bk5XMUdVSnFlWCtzdHNSYXVNL25heWRJeDla?=
 =?utf-8?B?MWppdzBSK05CSG9IWTRJc2N4OG9uaWtJblBGQ3dxNFA2MngxelljekRtTGxl?=
 =?utf-8?B?R2tBU2ZMek5KblNkV1RXOFpNdGU1T25yTFBpTXk0Tm9rOFpKT1lCa21VT0Fp?=
 =?utf-8?B?OGxxYjVOQkFIaWV2cUtSZGFVbmZMUTJBVVNrMVlwVUNXRjVIcEdZb0dqMkNC?=
 =?utf-8?B?cDNiUFlJaTM2SGlKSmhNVEE4NTVoTGVrUG1PUkUwUGJJd1RXTmZVcWJnZ1No?=
 =?utf-8?B?aElhbEdQenRsT2hlUDRyYkdQVFY0Wk8yT3RKdVp6L1lTYXRRSmhsMjNZN0wy?=
 =?utf-8?B?c3JmaDFKeFlYOWVaWmM0NXFOdjd6UWxnMXpIVWkraFJpdU1JT0JaaUE2aFdp?=
 =?utf-8?Q?XA5wzaEpKGqeOaIfzJiTmLQ1m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0b5464-b2be-453e-8a6c-08db8e6f77b0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:40.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCupYqMD7AOXMcy0UOBCYNpB6Qc3xXu7oiPLb6h0ikp9cQVet8uV6ztVpQumEkU9ANWwMlJcACLEPyRqht+ysQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4152
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
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com> # Broadcom
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-bcm-kona.c  | 2 +-
 drivers/mmc/host/sdhci-brcmstb.c   | 2 +-
 drivers/mmc/host/sdhci-cadence.c   | 2 +-
 drivers/mmc/host/sdhci-dove.c      | 2 +-
 drivers/mmc/host/sdhci-iproc.c     | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
 drivers/mmc/host/sdhci-of-sparx5.c | 2 +-
 drivers/mmc/host/sdhci-pltfm.c     | 4 +---
 drivers/mmc/host/sdhci-pltfm.h     | 2 +-
 drivers/mmc/host/sdhci-pxav2.c     | 2 +-
 11 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 6a93a54fe067..2e3736603853 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -319,7 +319,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
 		.of_match_table = sdhci_bcm_kona_of_match,
 	},
 	.probe		= sdhci_bcm_kona_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 };
 module_platform_driver(sdhci_bcm_kona_driver);
 
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 4c22337199cf..a2b6d8f2eeb6 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -430,7 +430,7 @@ static struct platform_driver sdhci_brcmstb_driver = {
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 	.shutdown	= sdhci_brcmstb_shutdown,
 };
 
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index d2f625054689..1702a499b36a 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -617,7 +617,7 @@ static struct platform_driver sdhci_cdns_driver = {
 		.of_match_table = sdhci_cdns_match,
 	},
 	.probe = sdhci_cdns_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 module_platform_driver(sdhci_cdns_driver);
 
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 5e5bf82e5976..75335dbf223c 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -110,7 +110,7 @@ static struct platform_driver sdhci_dove_driver = {
 		.of_match_table = sdhci_dove_of_match_table,
 	},
 	.probe		= sdhci_dove_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_dove_driver);
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 86eb0045515e..0dbebcecd8fc 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -432,7 +432,7 @@ static struct platform_driver sdhci_iproc_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_iproc_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 	.shutdown = sdhci_iproc_shutdown,
 };
 module_platform_driver(sdhci_iproc_driver);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 48ca1cf15b19..5072b59f6165 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1521,7 +1521,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.pm = &esdhc_of_dev_pm_ops,
 	},
 	.probe = sdhci_esdhc_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_esdhc_driver);
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 12675797b296..cba3ba48e9dc 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -85,7 +85,7 @@ static struct platform_driver sdhci_hlwd_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_hlwd_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_hlwd_driver);
diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index 28e4ee69e100..26aaab068e00 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -260,7 +260,7 @@ static struct platform_driver sdhci_sparx5_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_sparx5_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_sparx5_driver);
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 673e750a8490..72d07b49b0a3 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -187,7 +187,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
 
-int sdhci_pltfm_unregister(struct platform_device *pdev)
+void sdhci_pltfm_unregister(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -196,8 +196,6 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(pltfm_host->clk);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 9bd717ff784b..6e6a443dafd9 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -102,7 +102,7 @@ extern void sdhci_pltfm_free(struct platform_device *pdev);
 extern int sdhci_pltfm_register(struct platform_device *pdev,
 				const struct sdhci_pltfm_data *pdata,
 				size_t priv_size);
-extern int sdhci_pltfm_unregister(struct platform_device *pdev);
+extern void sdhci_pltfm_unregister(struct platform_device *pdev);
 
 extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
 
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 91aca8f8d6ef..1c1e763ce209 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -359,7 +359,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
-- 
2.39.0

