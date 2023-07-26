Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB87629CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGZEDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGZECn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:02:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA182719;
        Tue, 25 Jul 2023 21:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR3q1J7BoVdICTxRTKDaEIRhIVwVo/J/5cdYx5iDmH4evnxqoVzMscQUMC7fXZRcxUWpKACF69uJH3USqoCbhsB1zWEyjtW2u8Tia2TxexxtuR3rtzlsCRvpwjFAZDR9cv1PKODxmqSVSjyVS6c4m+kwVWKf1QKNgCzDjvgdPcrwCbQqz9KYCXm8OhttKsMhoYTvmcXmF74q63P03DbxCUxYgPvkDh1sqvEx6wTuZONA21FLjn23ktPDt7xOESrMwJNlalrXiQuw067iDynE47ibqWBi2/UUqpYcZhIFjJIGY4xdQsHweKWzHWXmAvQ1V3ttirjC8EvdbES6BLViUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGKTRYq08V0JvxsGHP5msYQNQ4gzgDy3xPfXbsZZVBw=;
 b=oQrFTfTk+LAsp9wtCF4pCELw09SN665BeVjrW6w0WF0flptt8EKl+vHVqFlwJLlRyRXcvH5R9DmMtGdPQ9QFQPto1Hw3uZ5ZDbAwR5bwzB8D1DGXebE2/8WfsOAOcD3h+eN2K2oMjhB0o4mC91vy4pNaoSOEzxR8EOKMCkOiCJqWbKIJVaf/IpQNcdYjBjoXKXHO242UrUbRFW1mNBZAAb+4b5olBj5voINV3TVVTi+s2t6kL/X5SzDf3j2b2XMyEgHsHcpDz6pd9OeaNaBxBXjufmSG58dwbjl6UnNFlEWxhdPpaku1HY1PKZOx7nFXjazTMosinrXgsj9gOGI0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGKTRYq08V0JvxsGHP5msYQNQ4gzgDy3xPfXbsZZVBw=;
 b=bgBDVDlcbjUPFcfeoFWiCp9OJ2FF74mnalr78lGf0aHOAVJaFJYAAMnAyNhb+uqyzPKOYTgdj8zX6C9TLfA6IGE0U3jYKcksQHhuvUu9hHEecJbd8IphPjBDv/lX/K9l9Py7bcf5hEf+bYumvB1YbqN1iB0Wb2b15N3mGA4a1Vu+d5W29VyNGZaoTcY5TvRmXNaZGlJKVYjHh1Mj9jsNyOdjlfHPywonHzEkCeyIFq6/Uw36857D6Blf2uFNmTXX/cSFXEfK8K5FxS+yMxDQajMOzX8QKrYHRD4omM/1c+slwVpS+9+N/XaNGlJBEWR+0ztt/yz96fhopH7nVDS+Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/61] mmc: sdhci-pxav3: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:55 +0800
Message-Id: <20230726040041.26267-15-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a52f104f-1c10-4f4b-39b2-08db8d8cfa7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgOTw8bJHF5jZL+K+DfohbK2LsDR2ptEun/lt4i+QOm2aEJJz5qkAhiCp/mEkkI/apQ6lnk805+3B9C9BzyIFlWJpf108c6flSmhhUriMUSq2Oiw1vO5DCMELEcGpSNVPbt3dOno6SWGzo+CSbrwsyKKNZtwP2Rhr8Pa7+H2PrWTICDkCC58LpFSfbM2c9suXrLk62sJiW0IxoAgRx4x0zWQxvjJs8gKuz41/lZJzxpSa/PQfDwg+ORTWT1hm/VcNjzuZDZwrUzvzxdKOu7785wA7H04EPCSo7h5pl2F0zeKLhw4FEnu5BR8TRTvN7h4VppesIftYzqWynDga5hlm/PF3b4IBzzn8dVs5HaH7uRHbtbAR8pei3z3L/21L/U4Tlw0clKh/nBkTW8b/xewF8q2tPRR/2D3OKMmqMZ6sKBktdzwA4d4eSueyr2XLIXEf7hvjQoLFMuyumL6Dp/fT5tu1CGkQilUCkI+VhwqH/qjSQCgDET4y+/M7jXV8xm1MdE2+WEX0vE1EiITmnJCiCU8OHEcUUiVu/evlJZbaP2mIteW7XJAahpAAO0K6agLtU3c+UwXMvMqPsK38tTU7nvwoKVdd2blXxqbqR1O4kRVAdNJIaxoosX/mjOUarqq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVKVHlLS0hPV3o5amxrYk9nYlY2UTBoRGJ2Wno4U1FEWFVFcWNxcTZ2cEpP?=
 =?utf-8?B?bWRzeHFUeC83WWdETVFnNVUrUTJtY2dsY1RzUlJheGxlRHltcUxDTTY3VnBt?=
 =?utf-8?B?bm84TDhGM2NvU0RTQXlta1RGcjBXVzNKVU0vdW9wc1RUK3VUU3BPLzRHVlp1?=
 =?utf-8?B?aDRpVnAxZXh2Y2hxOStjdFloV2FMWVkxczgxWVpZTzhNSEQ2VStxa2FPcTg0?=
 =?utf-8?B?aEV3ZGJDa01ydXhvcDVXMzV2QnY4eldmREdhV0hSdHY5bHRBbnBYaldmOGdi?=
 =?utf-8?B?cnVLaFZTYWZHR0MwUXlPSk1lMWluZ3RrNzUyeEVkbVJGVGJ3aEZwZXdnL2ZI?=
 =?utf-8?B?NVp3bVZWS0p6Wk9wY05NSHh2TjFmTUMvdktZL1FNTGR1YUkyMXp3aGZJZ0Zh?=
 =?utf-8?B?aHFmN21aZ3VwdlYyR0c0VkxxaEh5dFI0V1JEbDlnNFhIMnNmV3ZIK0RrUnJH?=
 =?utf-8?B?MFZLL3lGMCtUZnZVYTBjVU9HaFJSMnpxVDhCMGVmbFRDY0xEdytLdjRCOTd2?=
 =?utf-8?B?cFZMR3YzY2FOeFd6THgyeDBZVTZhVGIvUlNycU9BbDNaUnc2TFZyVDVJeFBt?=
 =?utf-8?B?L0l0RmhEYXlnZ2JRNFNXM25vZ2Q4K08vdmxRS1ozZmkvT3BEamplaXBla2xt?=
 =?utf-8?B?N0NrK1dGZ204UExWQ1VLLzZTczAvcSthb1JtY25NMWcyM3FYOS95RGJ3OS8w?=
 =?utf-8?B?L0NxRUVDZCtNREdZR0FZTm82NVd1ajVuY1FoSWFFRzZSdDJjODRHOEhHNDgw?=
 =?utf-8?B?R2dvdVN4S1lSYVMwTVU4ZXdUalh3akRvSGxOTld0ZXpyWW1oTTI2R09zTlN0?=
 =?utf-8?B?U1IvOEdYRGNueHNOQnNicVBoMEx4R1BaTE14eUtXQklzc2pvcEJWN01uRUdW?=
 =?utf-8?B?dGRha1RHQnBLdENOSzJ6enZ4cEtSV0tKWEF3MzhHaktTLzF6K20zVWhGNVVh?=
 =?utf-8?B?M29wbThDZjV5V3pLVWo3NDVhamFTQncrc1ZkZGdrdG1PeEZueTVKMEhPMk1P?=
 =?utf-8?B?bEQzZjBMYU5nbk44V1hMOENmVDAvN29McEI1d3BWTVI5cUFremp1YVIzV2JF?=
 =?utf-8?B?OGxvU3prN3E5ZmtMQmhlVEorTG83dzA1TXJwamZhVDhwOXJGalNHV2hKRzVB?=
 =?utf-8?B?UmRrcXVNejhPOXJZN1dOYVE2TytuUHFNYmNuNEh4dGc1bHdNZjRkOUVUQ3Nk?=
 =?utf-8?B?c0VGZ1FxOUNwOTZHMjUzSC96bWVuVXgzZW40QXh3WHpTcVBlK3dxdzM0OTBn?=
 =?utf-8?B?a0FMRHNzMXM5ZXFqTHdISTJIMDFsb0tOeEtpd21LcHl3eTFQc2xhbGdYNFpW?=
 =?utf-8?B?MEJHeXdJNmgxTkhxRiszdWhNbno0YkpHd3p6TlhRbHoybWlybmNiNnZvWk5N?=
 =?utf-8?B?eEgwTURMUTh5Vm4yQ2JiU3ZZM0U0bk1DbGlLYVFFajRRSTcyQ28zVWlNMzZr?=
 =?utf-8?B?a3IvdWIrUkJlTDkwNWdvS2ZjUGtFVDhZTHhDTmZiT2VMZXpsNlJSWWp4Z2VN?=
 =?utf-8?B?QzhZdFBXZGhSZ2Z4aFQrT0cxUzhFeldwTHZrR2YzNTZrRUZXMEErdFhnZTZN?=
 =?utf-8?B?ZzZTbXVGZVYvWSsrdTV0cHh0YTBwZ016T3h3YnBwMWRCTDFyTllSTHlzMk9r?=
 =?utf-8?B?L0lmc0dqek16N2hITFZZOUVvWlNUb2t4L1lENE82a1E5eWp1SC9yYlBlcFZO?=
 =?utf-8?B?YjFkMFBSUXduZkpjdEV6dVNlOVd5OXd1dlBkRUtUanRlTzFPSFh5V2tBcE9y?=
 =?utf-8?B?NXR1MXdaSlIybGFpYmNUNWp3aGFncUJKMXNGcUVFa05HZzhTNFdDZ3VPZzNu?=
 =?utf-8?B?Mk1vdTdFcEFJT2pEdmJxelNpa3hnNkE5RE5CeXp0NW13Z2d2U0pBaCtzeWFq?=
 =?utf-8?B?SWV6MFRyaitib09LdkM4VVptVitiakpZRHRCMk1tMHVUNERWNy9YenpiME9E?=
 =?utf-8?B?TzJuSHljaW9jOHpsQWx5ZGhtZmtPWmtIM3NrcmF1cWJlY2ZRcGhpcERQVkcw?=
 =?utf-8?B?SzlMR25DQ05tOEtqNW9KS29yTGtBeHBNOWlOQVVONytscWh6RTN4VTYwNGQ5?=
 =?utf-8?B?akNwVkk3WTdLMnRiMnpUdnNEQUVSOHFqNlNyTGY5ZVJVc1pNVUhJOGN0dHdn?=
 =?utf-8?Q?acJEH3vtPFPvODJxH9wVT0fIn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52f104f-1c10-4f4b-39b2-08db8d8cfa7e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:24.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1rG/6MweAQylJnsvFvM4cES7Z7UgqpYRe232Z+5q6vYlvvRQ1/dc1fWUAWZ6jpMXWSYFbFsKG6LEoifhd7jDw==
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
 drivers/mmc/host/sdhci-pxav3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e39dcc998772..3af43ac05825 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -470,7 +470,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_pxav3_remove(struct platform_device *pdev)
+static void sdhci_pxav3_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -486,8 +486,6 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pxa->clk_core);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -570,7 +568,7 @@ static struct platform_driver sdhci_pxav3_driver = {
 		.pm	= &sdhci_pxav3_pmops,
 	},
 	.probe		= sdhci_pxav3_probe,
-	.remove		= sdhci_pxav3_remove,
+	.remove_new	= sdhci_pxav3_remove,
 };
 
 module_platform_driver(sdhci_pxav3_driver);
-- 
2.39.0

