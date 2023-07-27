Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5E7647D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjG0HHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjG0HGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F72D63;
        Thu, 27 Jul 2023 00:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlcljh/lY1roGLeghwutf9d3JvuGcx/4TiVIW55p02f+xu49b2MTfBQOniUPGikCXIMJtelOncn/gMCqrZQpQQ9huz9+JoOrWf/D9cE0bmwZsm7jcQaS62A3Dv5k8khvmYtqgNNZBE3uYt0APaTqnvkhm9iELlxG157o0Hav8jjqHacQmHL/W5SMTWTb/WaD0s09PFaWWLqYRyzin0lipEtL1lWGNe2tDjwLW7rDgcvlcosSXBMjPPfM/N9RVQ9GCMs/nqzC0YjtzAdDYUqzj2+mbeESGBB7lahvi4mDHN2ycKwjTtFX1CpPAKkBibQGYZgsBqeeSXGlktyYLJVQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgkpH6iKKcR7a4wKXniEGd6Oga+gRHlJdFEF4UCfl5I=;
 b=KOAOPs+fIAV9iDZ4amwmUmFAMHR4HUow+VBhoHEYY5IUlahA4o7Uo4a5EEm6wGpuBNUA9qR9zQnSWouI7X2hdvplZ5SlmXgXkf3U36hYpWM1X24gIVKLfXVPxIGxjZ27SppUFV10Ru/Eqw7U/kDlwpYIsVlxE/cOlpCvntZXa/Uwe2R6qQS5SAaZgGBnNeHXYOWlewBygaw0BjqluN+ywLDNmIfNM8fMH0TLGN5C8q3D0j6EDcIJoQJc9x5tCmQZ/mPRDghZzJHbFdFiPFvkiU5ANcynuVZRcswD0QaVL7127cGIkc+xTi0+CteDTbb5r5mfLQbUuZYfWW1NknniAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgkpH6iKKcR7a4wKXniEGd6Oga+gRHlJdFEF4UCfl5I=;
 b=fa5NxtQjNgF/XvnDgEBbKlGpeuQhPHR4vKWfCYlUW7KVHxLPZNjFnRDlmM6nmfW1VLq5cWokCbzHHB99N/ScTBgYL47xVEeu/jrUoPkHROZNiYyINEYORdJt6xp/loG7YII1RLqB/qhncUfB4A92PIt1T2st2HKaqL8PO9LgOsttTLr99W6ybVu5Bgknl69q6+kvCTkfomAscybFmmw3ZkD4UwQDfe6BLbGKwVEzJy1n8T0voyCrXIMTbTu+IJWKTTrFj0aMrktAf9rF2A0AjdyEa45dF+tsxiwa9XHDsV0PepXimOyh8i4PJ46iVvKPaOxhYaf4DvHWhxSKPib0mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4152.apcprd06.prod.outlook.com (2603:1096:301:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 61/62] mmc: f-sdh30: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:50 +0800
Message-Id: <20230727070051.17778-61-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1212ea1f-6995-4399-47e5-08db8e6f7b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7B9fHdbSVjtabl/FnTD+NnstSLfwtNZL7JOMlqHsCuDOPjG2YczKfeQ6M7CdTRiyU9LBVZZb1Z11p6sL43wwjPz2PzNrrFc1cXEMuhf1A6wIDLmLrPLBChNX7SvK1tXmwp6pqb7lYgEqAfFiyrpOyuGuFP9dkWGpsUvEZJON+QhcApGkWlB9CNkiycqUt9W/+M7aAW9CauEo1+dhkMcahtTEoryngTGj7sVZrt7nvY/Lva/zRNyPiFmXGkYXaN9nFHtSXkUnFiUQqza+Aa/sa8oVSBp4Q/EBHRMKWkyh83cAy+pjL3GB0twFe0+6GCNXSQyRcYPuKKuZOadLpnHck0DesRlI5lMUT49+9wWtuJgdnMS9K857yv3AFBF/I7UEhwhS75oKUdzKSKACTUgLGhXpU83Ufcqc/MAzmMHl6jQm7WfBCgJmM9wiX09pfunwNLa7cTIKBB+Mmxo7Tvzk2Ml8YrSKMSLZctMMu3w7Wq/NdorqYFASfl16oEXngj7/53kyyiyWLqzhgCSFSF3PDj+aySBCFaC9KNGa98Sod4jUrH5ZBCpF7Y/KTpPfkqdqsg5pJpIQl4xhqYa+Ew/FlFMpiyNhhsl7mu3kLZiubEhTYPXDASxWIxOdhg8m7mQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(451199021)(6666004)(6486002)(478600001)(52116002)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002)(66556008)(66946007)(4326008)(54906003)(66476007)(110136005)(186003)(2616005)(5660300002)(316002)(8936002)(8676002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHJGcGs5U21NUjFBK1FjaGtiMlpzUGY3S0dSUEN2VjNkcDFTVDRRanB1bXBD?=
 =?utf-8?B?RGt0Q2hxSEV4UGl4ZklHSUNPUDhXTzhFQ3dMRk9zYTVxRFhGUmgxZGdIKzdC?=
 =?utf-8?B?a01pYmcvMFNkRmVpMjVveUFRU1Ntc1ROTkZ1Yzg4aWFmZ0FBL1l5Sm1nM0R3?=
 =?utf-8?B?Y05WYWNVY2tnMlg2V01kNGZzdDI5RzkwTDJJTUw5d2xuR1ZSVnpMMW1NV2wv?=
 =?utf-8?B?TEhURXg0Rm9oYjhsalhlTjhRdTdINXZmM3M3Znc0bXZFZnhOYW5hZmRzVEJF?=
 =?utf-8?B?d1NCanZCdjFiZ0F4ZGFDU0F3TkEzWU1KemtBcGllVTg0MWJJNkhMaEhRRWxu?=
 =?utf-8?B?Z0k1ZlFkTXpGOHZrRTArNmsrZ3VSOHp3YUcrWXVmcEhQczFnR3FjeUdSNEVG?=
 =?utf-8?B?ZGd6TktXY3ZqamNmMW50cFY0TzFMTVp5SUpoRFZrakFoRkZSWERmRUcxZDZL?=
 =?utf-8?B?SDdEZTZhdG1Dbk96U1dYSkkzMi9wSmxIVDkxY3dJQy9qUnhPRnJoeDVNMmRJ?=
 =?utf-8?B?Y1lSRjRmTzZvWmFRcGRtWnllWlQveDZuYUFJNjVFaUhRN1AwbjVUclV0bEJE?=
 =?utf-8?B?blE3QnpXQklsb0xjRmdKUVJNZzlocVdLOXMyNkFFcDZBMFhyZng4T0RKSzMr?=
 =?utf-8?B?NHBEUEZaRkJscC9TZHp3TXJVcWFvR3hZQnJpeWk5SzZidjZWbWgyanlmbzRi?=
 =?utf-8?B?QXRlVnRmNm0wQjlGb1Q4U2VzcTY1Sm9OcEF3QzB1MGxaNk5XQVh2b0FLSlFt?=
 =?utf-8?B?ZFZLWGFqdUtlYnZNdzRzbk9CMFE3Qmg1ZzZUN1hDRUxTanNUU0QwWFQwdUls?=
 =?utf-8?B?RzFUUHBiLzVpamtYQkxvSWhrWlpMUU1qblo1d1dCNUZGcU5aZlZjaFluYzYv?=
 =?utf-8?B?ZmZuUytiYlRLMW9LN2tpOEhCUHNRbVh2T1U5SENocUJwZDB2UW5Ydms0VElN?=
 =?utf-8?B?VFlLOUNxNm16ZXp0TTNIYlRZeVBHZUFaTWNZNEdpaWVxekozNlpNR3d6c09s?=
 =?utf-8?B?bFI1a3NLdU1nM0JSUVVhRVc3TzJKVnowbXBkcGhlRFlVa0JKenphTE1PQTJr?=
 =?utf-8?B?WTIrL0t4SmNBMGNkWHh0cUNGZDU0OHJhelNlY0F1U3JWOW1FTjgxQlpiSWFC?=
 =?utf-8?B?Y29kQkl1SG9qNTFZRVF1bDFTZ2pEK2xCSURNUzRvYXcvQU0wckZlUlpiQXJ0?=
 =?utf-8?B?L1ZtTk04cmdVL0hsTk02SWVacTNpR3ZpWGtzdXJRVkh1elJkeXJMdjhYUzJz?=
 =?utf-8?B?M1RMM2Y1b3JGbjc4TEY1UEMwS09uK3ppNFFXUzY1ZURmd0FXSGlvcTBydG9U?=
 =?utf-8?B?djlwYldTY2Zibi9YdjkwZG1PY21qQUZEN1RDbjhRSkhTVW5BRHVrYzgzM0tQ?=
 =?utf-8?B?clptTlBoZHdUV1ZZS2RxOW1manFNdEQyR3ZtNWJITHNRR2MyRm01czQySnJD?=
 =?utf-8?B?WGorSHRqeEJqK3k4ZGxicE1kNk5CbHEzZWdBQ080SHQxWHZ2cHFObzN0b0R6?=
 =?utf-8?B?SUQzdzc4M1hpQ3ZlWnB4L3RtWmI1UDJZdThFeStvZndQSzdNR2FwMk5qaDR1?=
 =?utf-8?B?UlBtVlBwNjJ2b2lOZVBLTW1rWUZpYU5uV0dqcHUzSFYrTk9hazc4MWlyT015?=
 =?utf-8?B?TG9zL0gvVnM4U0ltOTYwc2JtSTh5RXczV0VCOXZwZUs3WkxKOEJ4TzdlY1R2?=
 =?utf-8?B?YVJMVmxGR2xaa3RqU28xazFwTXZncUhKMFpwZ0VacTRpR3RCSzJiU0NqUWp2?=
 =?utf-8?B?ZEE5WWhFUlR1RWt5Y0dRSHo4Z2xaVk5VL2M5cWNHRExybXlMWUFCMklyTW9G?=
 =?utf-8?B?NHFralgwQW1KcDIrRVB6Y2hPRTNxZU0zSVFTUE80SS8vQUY2amlBQTNLMlp2?=
 =?utf-8?B?RVpYRkNsbGdvN0dnaGIxK3lUVWZmSkFJQkU4RlNLeGxTR1VOUzUydGdsYStw?=
 =?utf-8?B?K0JPeEJJc0JLeEZMVDRVUVNaMEhoY29XZ0JiUWxBOGppRHprYnlVeGdLWUI1?=
 =?utf-8?B?cmdsbjZ4a0M0NytMMDY5U1doTTBFYUkwTnlxcEQwVStWY1lXaFo4U2pXckhB?=
 =?utf-8?B?dEtENkdwWmZVSjBzMW9UL3VQSnFaYVBhem93VTJERko5bC9MTUxZQmhGckFF?=
 =?utf-8?Q?MguXZFWHGzIyzmKqmmteSq1Nf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1212ea1f-6995-4399-47e5-08db8e6f7b46
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:46.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCrOr199+mh8cbOIIhI4Kve+/3kkp3YQ1zZvXpAP1XICvWCW/rpNM+6SnG1p7YwBaE/8wuisImCP9h9KpxerBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index b01ffb4d0973..840084ee72e6 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -206,7 +206,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_f_sdh30_remove(struct platform_device *pdev)
+static void sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
@@ -216,8 +216,6 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_iface);
 
 	sdhci_pltfm_unregister(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -245,8 +243,8 @@ static struct platform_driver sdhci_f_sdh30_driver = {
 		.acpi_match_table = ACPI_PTR(f_sdh30_acpi_ids),
 		.pm	= &sdhci_pltfm_pmops,
 	},
-	.probe	= sdhci_f_sdh30_probe,
-	.remove	= sdhci_f_sdh30_remove,
+	.probe = sdhci_f_sdh30_probe,
+	.remove_new = sdhci_f_sdh30_remove,
 };
 
 module_platform_driver(sdhci_f_sdh30_driver);
-- 
2.39.0

