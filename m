Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE97762A20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjGZEMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjGZELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:11:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20703.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::703])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B52D5B;
        Tue, 25 Jul 2023 21:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3AbN0QgzaeMjss4YI+DzmixpQtGCFjJ1cYVorZaClZluUQkaxPDdM9Iezwkt8vdJ9Y5nOKvz4hWo0yVkIIoBH3zUOU34HXLzdjAzdO41FezFNtpx2sDB+SOfw1RC5o0aRR9NOBnZ4n+7LqrpqioC6guSBLdnOLf7MucOPYytGvRx/gKAFL5Ara2Q3fTmubaHEUy+nLQZKnU1VMr9SsctjfzJBuzoN+s5jp4lW5WqATas5j6qWwcgDb5C+K0V+Bd/FizTfKzDntTkZZEsaJYrgR3Ikel+iFmuNsCx8QahW77iuO72khv4M9pUCRmm8ZNl62wCenuM6PTmigDyZyn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMjCvFA1NPvX3oCRuaryE7iTIS0yrHphNTOEU7WI1is=;
 b=DvU9+5juewwbyvdqauPEvvXe3cvZcPejy6kIiM2JM6BeqWyyvEYK8SkItDA9QXktRjqT84uP1jqWLaqZ9KZcmbE5bPWD1WsPyUgbkCm3xxfPDIQjN0rxDT3pIW053ohLBYHmm2xONluWHfHlmq4qHiqiJ3r+vUCH/sXBVPR9I3h8vs/L1Sr8hTPIMKuR7R/Vp8QdfPfC7dxtsxO7200ZojaNEbBdv5dA6y3NLyJnyKFOhy63aoQ7KsJ5U0rJNurP/AjKNMMFz4mQQk1I9Mai31CPnDB+6S3zoLR8iHH2v+fuHtIPvjZ5tMcavK7Xt8IudvRzHp7CqyttiWYKDOATmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMjCvFA1NPvX3oCRuaryE7iTIS0yrHphNTOEU7WI1is=;
 b=ItmGNLTtcpbA6wOpQ5Tfe4oegCIt4ni3H9W0euiYbH/b5wbQIK3Cb0IOyrnAzxcOg1aQOeh/UXejeEZVzIu0a5kHEDGF/0+EydlKQgtMLX60v8d3Wh5M2McTAlB86MtU+3XKC0WmPyk6iF3uUxdz3ozN1vj4azF0aj2URQ5rLcgpEuIhFsIZfBGC3QpWbhjrovmMRlAoTOLdaZ4J7fgtO9UbAHymftMBS1Y9K/EkuUZX/NMrIbRW6rWCaPybE6uKWaFUTL/PS8j83tdRsy6LDXlvSuQqG+XO5EH7lSI84plHlDDm+hH9ObB1/47gHXuawFVGfRKYsSiAxKerYFwQoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:40 +0000
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
Subject: [PATCH v2 58/61] mmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:38 +0800
Message-Id: <20230726040041.26267-58-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79bc713f-d05f-4569-5636-08db8d8d27b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JibFWY4yCYUG6UvfGGLZ38FJU/9OoFLqPNbxzsLHfCZL7BYGLwgcdBGJpJ6irir5EAKsloyELJrvEEfkt4V2zGG/hS4enC1GGJHFJftEzNzbb3bHgiKYzhRJxE/lhakj2+Miwrbd0ckmOLgrlmdU5F21KV34Ubr+K+BJKzd5HzzFYHM2/YJBC9tP8WW2DWueZpf8fwVHDZnjTXOBHY5Q7yi6l5Do7yLoAw0FgThPrXgDKAxWsB/dMLkIAGaFW6/e1XFpz/iow+Y9VumSRJizibpYVRs5qwQv+bwS4wGXZlBDtU01Lh/ypfsvEOviMf8YHxJ3Oz6Wem5iLstQP2KE8YpS0GTgjQkp+d/CusNAmApyy/GDO50GMz8Q1PfRLyE3YJyNIy+OZPiTyNDlyUDFa3rBfeMdWHznDvxfIdVYWfRSp0uOlKr7GT01sGRal1F/7U0wWxpOs/02WwaEEbm5lMIzkqPiseLFg8B6JA77rKdG18vImxSwLDJTHpWm0jyinR7ka2cvvY1jcYs04ISqWYPvaaVsbm2PhsYb6FaJOiI6/TMXxTXVerh9IEkkMOBPZS6rZpSY+ccyE9pq2O78JJAWf958mfDvoC/Zij0K52rJjX3epzKlZYCtcKyo3ZH1BwRw4dMXAXo3S++OITeZTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(921005)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1kMXdmaXdVbE9tNDFTU2xKaTFqRXJuSFFXaVNxZ3RrbVJXUUk5K2EyQ1Ru?=
 =?utf-8?B?eE91QjB1Uy9naXFQa3V5MWJNVXBPd0taZGV4ckpMT3RXTE5xK3UySVF2Ui9n?=
 =?utf-8?B?WHNHQkpYVWwwZDlTNlg5QjBCbTg3TjNtb3JqK1FLeUc4RTB6QlpJWE1wclFL?=
 =?utf-8?B?VHlxeFBNVWhsQ0FxZ3phOTBudHVNWjNnT2xxeWJYNy9kdUY3Z2pUQ1ZrRWxZ?=
 =?utf-8?B?M1k4eWZKTnl6RXk0WjkySFhWSkdvNFlVc05zL0FidXArNTd1TGhXamw0Tktq?=
 =?utf-8?B?ZEVMQjlneE53cy9XVzJSYVkwLzV2MVpMVzZQM1crRUNpUTU3bzc0ZWdFMWZn?=
 =?utf-8?B?VEdnSG5USGNBY1lJWW1zRmdBTlA0RlNJa3hzQTNPd3RBOEw0VnNpN0c1VzZj?=
 =?utf-8?B?dGkvRGRFc3B3S1JTeVNMcGVuSWlNTlg2VEE3M3p3bEtjYTVFWGpVMjdaTEhj?=
 =?utf-8?B?eE1UTC9YNkJWRStEb05WK0dWbHp5VjNpVkxEMG5xTkpuQ3JIOTBWYkttcWRp?=
 =?utf-8?B?eHNNR0hCTmVrZElDV0hkbTczdTJmRkVxakNVbkNEWFpzbFdkUHRBbnlQRnNE?=
 =?utf-8?B?MHM3UVdUdDl4K29Tc3QwOFNCVlp1czltb05XbEVIWFlQVG9ocUU0QlNVSWE0?=
 =?utf-8?B?WUFCTXkzMW1CRGdaYlMxN3hqTks2MitSb01IRlIzcElZNFhaVUxka001RnVj?=
 =?utf-8?B?ZmRXR2YzY0wrLzBGQ1Z0TXlpbi96Z2tUUlNqNGdwdGVhNER5VndGUVVHZHhs?=
 =?utf-8?B?ekFtYkE0WXdGd2ljN1UrNy8rSHgwN2hwVWhvTUVJc1lVbXNKMitsaU9tMWsr?=
 =?utf-8?B?K0lZVVA5b3JaZEROdFpML3pKYzNGc3FsN0thd2dGL0FoZFFjVXZEam5oeEtG?=
 =?utf-8?B?ZXpzeElrbzN2MTBDdkpPa3ZvcGUvSEFhL2hLdDlKaXNqTWx5TU9jYVBLcmg4?=
 =?utf-8?B?Nmd1cGVyUmVMbDlwQUtLNkVubDIwaTgybzVkYVpseUxiUmJJZGpoQ3lBMUNK?=
 =?utf-8?B?N1pldkRYTk42bkNHNFMxVkJhY2twa0srTWdWNG5jc3hVUjlyWWlMMU5YWmJJ?=
 =?utf-8?B?RTB1eiszV1MxNmZtRXVSSzh5VTVPdzdNVWQ1TldtSjhjZTAxd1VqTEZtcncx?=
 =?utf-8?B?ZGFGcGlvWjRldWc0d0kvTUt2TFkzZ29NNVQ4WUV1L1JlMjM4SXh3MStDL3Q0?=
 =?utf-8?B?ckVydHkxa0xIUEZaRmxxQ0NNRFJPUTJyaTVLQVVRYTN0cHFxaWxPMUlBc21q?=
 =?utf-8?B?cm1Oc3ZCeDA0dzMvc29GZEJuNmxxWm9YaWpqYXVZc3pOb0JWUk40NjJ1UCtn?=
 =?utf-8?B?eWN6Q0Mvd0hWWWhHVFJhV0ptNjlXSHZlT2lxOHRnMU5UZitaZDJUc0hVbGZi?=
 =?utf-8?B?RTFmQ1RBUmhoTElvajhVWExLSHYwcDgySXk1M0pZYzZacXNka3JOS1cxZzhw?=
 =?utf-8?B?dzRxRWFud3lXWEFBbHBVTXhsYTNDbUhHdDVWNVpWT0NqT3BzWmVUWDlMTEpE?=
 =?utf-8?B?dC9aNGRsT3lMRUV0U291MXNraFJrL2FtYU8ra2xGdmRDMHM2c283b2JLbUZ1?=
 =?utf-8?B?cldPdjd3VUx6Yy9mUjkwV0ttdHlKWkY3dExBRVRKc0RqQXpTTkdWdlJDNC9T?=
 =?utf-8?B?UGxURWtKckxCNjEya2NFNzAxVlJsSTRSbTI4N3ZrbmVJaU9jcnY4c0ZiNG1Z?=
 =?utf-8?B?bDBLY0UwU3Z0YlEweTZXOVVKd3orTGR5U2F5Q1RPMEFtMmF1YU8wclJPZEh2?=
 =?utf-8?B?V0ZZYXZDdGZhdExwdGNhUHVOTkMrUkdNT0kxcHJzcWpNaEpkdk5CUEJLWWpz?=
 =?utf-8?B?ejVQUFg2Nk4vUHFzTFlpbEVxNW1uVS82c1FLZkQwYjBkWUxUT0FoUG52c0tH?=
 =?utf-8?B?d2R1NjhyN3RYWWF4NjZjeW8zRlErZnhlaXhHd1E0akkweFp0OGIrQnFZQWFD?=
 =?utf-8?B?TUluL1ZEc1ZqUWF2NFhKaFpPWU82eXlsdkU3NmEydGUrQk5ERW9lWFYvWVpT?=
 =?utf-8?B?ZnVmUGFoVEt4aXltMEdXT3JsVjRzUE5KdGZwU3REUzcwbmI1VmFOMnF3YTlD?=
 =?utf-8?B?Y3grd0gxUVBKQjFKTVRJVWpTczFGUmQ1dG1RRE5WMnh4UFg1WkRDNHlXR2oz?=
 =?utf-8?Q?ZD2e92E1O/7nPmNQQcPe6RwNH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bc713f-d05f-4569-5636-08db8d8d27b3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:40.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEeO0mk9anSvDQ94xBTOJ/o3TBUlip1Hhx/NebhJOgi/JfCnOqgEosoetnuDXrSQQcT0Di/ZfsarxM26d1ajqg==
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

