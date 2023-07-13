Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59837751AED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjGMIKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjGMIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:49 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16B2D4B;
        Thu, 13 Jul 2023 01:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWsbBNUvsk3a6tHrEl6oUj18qkavwE4pw4klaIPY7vE6EArw23V6UuK+Fl3coRFqbloPaHSPNkT2CxeMuzN6UNa0cqnKmM/SPEFOq+39QVLLVw7qjn7pRpYiLGPMoZsznzzOTp9gi1JgfX31G9+J91pCTvEm2xlS993BHJ2Dehuw3OQuwq453qPDANlJnzxlZzT6MMElHJx0CbQXJx6Kgg0CdCM+whu4gj1LsW++7IElQP4RpeXDfk3ZFm/jysuWpo7yRJnSrdNilfgfungHERmnV2dEu7cYOcSE6euBNPLibTJ+uy1q4MycGBk5mrsIWOlncw1F4/5hU+dWHiwwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df1DKbWeg+xqkSYPtOjL8RorXDmDCAUtgwB9kJK//H0=;
 b=ONNbHsFEmTxwebA2oPN5iJvGOB/OQGPOhokU592wVO0MMIjjKm3aC7fvyxbVcgSwGiVM/nDwJgxb25qmw4tMsQyGd54e5E0GAQ1j+mARi+3y5tFjA6FuvD9wDiAOPISN4e+clz4L4mxnywHdhcSWBAu6gx3uGbl4GsMfl79PQl6z9IEWL0wmf/fPn2yVIVEKHkNAQOZGDjVKjKc45gEBS8bHR/HjzZ8TqQ51KBrSn4Fgy8BJw98G9ecmyXyqvoRbA1tVjdxxwfEMAgTiWMLCoNFpvb+a39MqhZHwSOGoaYs2vh6d1W/f+H6x4T/e8sm/FPxuOzZ/AFMGHx9cxuFCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df1DKbWeg+xqkSYPtOjL8RorXDmDCAUtgwB9kJK//H0=;
 b=md32cjf05J8ArcVzr9GIhN1Qx901qVLJYNE2758OL/r3P8Wfwj+nRjGlhImWOV5ExWgyOIBdUvIklbcDMk/DGECmheyLvbNPdTL3lJcUpUDzUQdW2I8ABpc3JyKQtgItGRhd91sbjF85bjeYE9MwMLxyEapRQLiy5FOne7s91PbarMIl0sr7mKDIw9+sgGU5P8oRZgiI1FE7+jAsQEKeluCUrQIvmWAJBFoOD6bpKvRuQGJd+ECjo8LvT801fisfQLucj6551HikL2k7Tbe11def0p0CzDrerHpUse4pDS1Sn4k6Wnl6BDqkhjr9MW+2EXBqvezdFAuSduk3KLotBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/58] mmc: sdhci-pic32: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:18 +0800
Message-Id: <20230713080807.69999-9-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be406aa-ad09-4cb5-e66d-08db83785aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sXIRJAaaQTil2xgkLIa6zzhcqLzxIXTDUVBneAwcCqFnOkbBT7v6VPACyMYew04G5XuArfvjnoMeisUlhRiBiwcx2K1TLA9opJbp0OtqNizTluQiQ71ArJILwQhOakBiKDbsBpurzIDaM6b8xiq2j9jv3pNbkqSl0qlnFj7BzmkWsRE4nxp7NUFgcrD6kf0eK+I+46PCe1ECi7HgjCaWOF4NEJlQOMzUZJPlnQEQY13gMhuQx02f2ezvdrQkpcSPrcHGRI4dxLUwIz5qePPacEPCjWD3MEKwTjjlF79B2EWPj0qMZwd4HrTrfSkDwgMYW30dyZo1PjNkpOJHe2Z/sjmMSEdDzpAzSiyemgmta48iC6os2T1N2fv7TScwfNPETzaNvP63bxgF6mscCNF8s5aYTnPJsrXQrMxtwKDabRlBxbkUs29agwAj2div4ZHxGjaHSdeCkoCvqFdFOfve2uD8Tqw+p6QEVVSY2fwaMFdwCjxFuAjldx7nPbBX1o3zRivQjnX6SUvDLt6b+qvDVLp0FJQ77KzHIkab6ARRNKVbIkDCeamUJXTNIScSLv7NDX95gOSKRKEUFHICfoqagZNpef6sP/VyU8GBV6xVnG9yV98tA0MowjMgHvC3vFVij1T2jlRKepYCB1XroqWxTPweiyd9jc2ma2qz6eIXE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm5FT3ZGQkdrZk9rMDJSTVRUUWhpd3FoRmNYYnNLZlJ4SVNkYXVpQWpvR2Js?=
 =?utf-8?B?Y3pRT0NmekhyZi9uK2xmdURpaEtSa3VlMUpUdlhBdVY0alFmOHBuc2p1bTVM?=
 =?utf-8?B?QVdBRzZIcnk4blJkelJjUVMrS2JiMTA4cS9jWFdpVzJHM3V3ZnZpRHlyQ1ZJ?=
 =?utf-8?B?dFRIekhVenpPNTFXWnF0aEN4Rlp3ZmFzQ3N6djdhd01jODhQU2NUNE4rdzla?=
 =?utf-8?B?R1JYUkFrODBENG5qUXBUNzUwc3ZmU1F5eFYvT0s1dFFHOTlKcm94azFkR2lV?=
 =?utf-8?B?eTdESGtma0ljOW9pbldQNjhEYk9pR0ZwSHhqL3RzdzFZRXAwdjBTVW1kSm8v?=
 =?utf-8?B?U21BNGRwNnRMTUJqYS81MlZnU1RzZzQxSG0yNXh4RVk2SUF5ZXNpVGJUZzVG?=
 =?utf-8?B?SERqNktKNVdyeWJIQ1dDV3RqaHE5VFFMaHNEOVdVTjQzNlltemt4Zi9qdjhz?=
 =?utf-8?B?aGkxQ1M3anU5U291Mm93MnF5bXltVjJPMXc5NDVsZHNuOGY5SkRyd2ViVnRR?=
 =?utf-8?B?bkZFVkNZdTJQODNlTnZVRituWDdhVHFLRHMrTjhsUFQ4NmhkVnZrMldiRGti?=
 =?utf-8?B?YXhtWEYzT3VFYU9zZlR0YjNrMU96dnFKL2JIWnpoNkNUSmpCYlRFTytxU21X?=
 =?utf-8?B?MjByUHcvYkx3blhZbUhETzBJV0J5N1Bha25sVzVlMGhralN6aVhjZ1NjZVk3?=
 =?utf-8?B?cEUvNmIyN3VaME1CcHFPVngxbFZVNVlDaHVOcmdXaVlQblhIMnJMUmltL3Fz?=
 =?utf-8?B?cmZCRkhsb0s0OEJ2ZmdETGJrTTFsVU9vM3hRRXBWM3VjbjhiYzFiYmJqeW5i?=
 =?utf-8?B?Y1RTMjZPM1BTRkkrMVJQZzNzaWhDK2hVSmpoUkJtMGhBYk55d0xHUUdjSElp?=
 =?utf-8?B?OTlWZnJXSmYrRktYVGI0VzQxNVI5NiszcTN3T2sxSkZJbFFoRjRONEpHbGsw?=
 =?utf-8?B?em1NOWc5eUJWLzFMYVdTQ1U1emc0ZDF6Uko2d0pNdjBHQ2dQamc0SGNKRkZF?=
 =?utf-8?B?UTJWOC9vOGduRHFvWHB2OEtOZVNqQ1l5NzN6L09NTGxhdzFoKzk0SGpLem5U?=
 =?utf-8?B?d1JuRWY0R1pTenErc3g1eFNsZDc4Ni9OWHMzb3R0YjRvaC9uTVhHSzNTVUlP?=
 =?utf-8?B?M2RvdG1XYXZDN1BNZlBXVkU4a1NCdkxmcWYxVFkyM1FSTjFLZkZ1THV1RTR5?=
 =?utf-8?B?NWZZcVNiRmZhandTdml3eTRrZ3lyek11ZVMvOVE1Um9xZnZ0RWFTM2Rrditw?=
 =?utf-8?B?c0ltdEttcGU1aUk2MHhHNFpGYWcwZnNFVnQrVjlNRnFRSDdhSUpkTXhFQ0hT?=
 =?utf-8?B?cUFhUVlPN2FxY2RjbnZUcEZlOUgzWndXaDFBM3MrdVR5dU15RkxBRU9ZWmFM?=
 =?utf-8?B?VnRtSENNZFp5cklCMnkzRE8yQXV2cFRhRC84UW9JY0pCUU5PY05pN25PQ09h?=
 =?utf-8?B?RkxvZzlrUTIzSXNHeXptdWNYb3pJa0dYSGpjSTdOM2VLeUFRZUZKbHB0dGor?=
 =?utf-8?B?MDlHYlBsMGlmTmd4Z1g4RDJKakhzdWVMNkZSREpjUmltdm9Ga0gwOXROa1Z1?=
 =?utf-8?B?MkZWekV6QnZRaWVJRmpOMUdqTGFORGZZMmZBcVkwY1BmUHVMSS9WaWRuSkI5?=
 =?utf-8?B?SDNaM2Z5aEQ5K3k3UmIzK2p3ZTRsKzROQUdINkpvY0tycW0vWFVsa3dFbC9V?=
 =?utf-8?B?RlcyMEE5SnQ4elFZbk1zZEluY0Zhd2p5V1FFOTlZRjF3L3haRnFuR3grMFRk?=
 =?utf-8?B?Lzl0Q0swSGlDdTBoQi9PR2hVcXowSlhnU2NBOUIxaENCUnVGMVIyOEgvK1Vt?=
 =?utf-8?B?T3lSU0VYQitoem41NTY4U1lMNkQxMVgyL2J5TzNMR2s1eHdjazRWeHRxWEFz?=
 =?utf-8?B?S2VCaU1SWkpUVWJTdk5XLzZpQmZnMk9tbEpEbi94cmxzSk44V1cvV0JhOG1h?=
 =?utf-8?B?YXRpaTZxaXBtUmN1WmFmaSs0eFo2M095WDc2bUg1a20wU21sWFRjZkN2ZEov?=
 =?utf-8?B?TVNSeHIyQUFZMTR2NXlsRlBLVUszZlgzK0pUT09uZnczcHBVb0RwNVk1QlpO?=
 =?utf-8?B?dlJQMHVOWU54YWdIRUo2Yy9idDJKeVlNWUpqeHBGRDFZaytFQjJpVDBRZ3BK?=
 =?utf-8?Q?64ewp22aDQLpjVCSGFbbrEN5o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be406aa-ad09-4cb5-e66d-08db83785aea
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:34.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLVeSGbNhLNqPq6XDFU0C6aZIxTTEN7fyCwZg9fUU2uw9tvNnF+ER82Z4q5fFMmfjeUvAKLOW+cnV7YPLxtCLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
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
---
 drivers/mmc/host/sdhci-pic32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 6696b6bdd88e..7a0351a9c74e 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -210,7 +210,7 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pic32_sdhci_remove(struct platform_device *pdev)
+static void pic32_sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
@@ -221,8 +221,6 @@ static int pic32_sdhci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sdhci_pdata->base_clk);
 	clk_disable_unprepare(sdhci_pdata->sys_clk);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id pic32_sdhci_id_table[] = {
@@ -238,7 +236,7 @@ static struct platform_driver pic32_sdhci_driver = {
 		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
 	},
 	.probe		= pic32_sdhci_probe,
-	.remove		= pic32_sdhci_remove,
+	.remove_new	= pic32_sdhci_remove,
 };
 
 module_platform_driver(pic32_sdhci_driver);
-- 
2.39.0

