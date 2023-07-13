Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5C751AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjGMILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjGMIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:10:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77E35B8;
        Thu, 13 Jul 2023 01:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he+1XJJsxvToGLZ45EtF8h0p1E3ZLrmgQ0OZWIu2YeVTe7p/bGHNJi/nRRAlSL8FScTfyx8Y5o9bIPXcdphXhxm9cR6sUrum0xWTn9Jo7kIxJ6dfy5x8jRdp2Yqka0m0PkASDTnjHs01zJX8tmQOZ8ReCoFeQsJyG6KmSd4IsdBg7kECy58ZkXAfJQANPZtrg8iy4FFYAkU0f6WFeOVgXkaq6Mf2sKoyk1cFlbMc18JoC0knTq8eZp2NACT16df1PGsiTZPcEQBbAjfME10OlmIrM4X17HkM1wZPs5Q1Bw0TiiTzClEXQLMhxS+zZAKyhWkjFTSRPUMjvjGsW2OVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkUpr7l0pDttVGz3kqCsUAr3ho/CgWL/40WVT1faxUc=;
 b=fhFkYKjgNGz6QJwws+j90yXbCojVcL32yvZaLFwJKFapzKmVzeOfOwrL5FJxB3QDliboN2xnvU5/vk5DsIWmDNfi+riSiYsY19J4xxYUbb03NfxREf4UZ05dxs7/zFU7XwSy0XveiyBpIADPE7oOxJxceBumbcArt4p7nnzbriPjQnWYVqATCznkPhESSX3M+TFiLq04qzaKgWC2lU//PP8O2/Bgid/Y7etqUunNAYN2POhxGkaqLwXZO0T5cock4w1KhHn/6JWdTmbnAEaoRT/GJXKSUqAuvaJBb+W/WDU8rokGE6qbY+ac6nEIJvDCXxyEaGrsOW0c2NPp1pZQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkUpr7l0pDttVGz3kqCsUAr3ho/CgWL/40WVT1faxUc=;
 b=ANBeX31iKNXVnv3rQphkJpMKfWR2e5J9SqKu9mfyeFESwWQDb6WcrmBm3AzuG6rVcaa1AW2ddLVmGkHGTL30n87QHQMS17f6Ebdq3YTe2kCWolNZVnUDgcGfLTeQ+ibtX9dyZzt23/PeYyRh5fjW0OYjYRLpyLjJaHGr+7YcuIT5d3N73KM48UXt5iWTAqkjMbxSpwWJmS10ONeWfU5dTr9jliqPxyj2xLv5zWsZj1m5RIM8oIMp0crPx4awQj4CvpgNTwmZCBysTGJFNo7Hsga2qxYtW3Lha7Mvo5O/FdFAR4/L9cTT3BS1UWlqP1WdKAA55CuxKFdssSnYWH4Qjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/58] mmc: dw_mmc: exynos: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:23 +0800
Message-Id: <20230713080807.69999-14-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb9ca095-7ce1-4e1b-9ebe-08db83786058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sadgiHwLkT834EFXfPP2FjNefEI+UIKm/UGlSFZD3eH57fbg4Exljn7UhkfSPNFe8mr86WznNAwzwMEEhc/20oieMxMYqkhBFr1eWKW75duy8+FzUtx6XRPNofR5zd9/bQgrvM96FoebiNh6AXuuvfO2Q6d2YLDUOa24Pj3jIzNf4JkwLunPZ7DFXkhV4LjcOnhxIeRHRNChE7XgckZVMxqbGvyGZ1zMN7XLS7wh5neOKfqHz6rm9ggCnbhATolMuiDkclI449KtDJg16i4IQ+n7Hvkpoq6F4MFsFL/Yqk5bvXdD8sIA49SaSGMR7I7WOM1nEz7nVR6YrjfgPyO6As9Zb3p1eK1lyWZvuEAz3vHHyzFsH4sbX8Kc71ksurlhiTG0E9NUJmSNxE75XZZLj4vCM6JUr1ms9uAP8XLRJzBxKuzEZUjUhra4ntCS73Fz44AFdDM3Apzh5pDj5ij0PtHG0qdiWioR+vlfgOVMkpBKWJwSnvRPdDtsb3gZtGeda4UyD9UCjlw2wzWK9fpUd5vnrDjNdFNnDoNaXZ+vLkXKrekTRJOrcZv7yLIiMbJI/R2Cr8GMLwIFGK6HrbSKElmMVyudevP0w0sbnNfIv2h9ZCBl357Yc1E5LVBEtHEf2Rn5fr4otawjzYQ8msDEzhMdz9eyo09DIEBpFhQA3/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(66574015)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZXV2J3UDBKSUVhV3IzOTdMZzVZby9naW9sZ25XNnN4c0NpZ0dPbFpyN2Rs?=
 =?utf-8?B?OWNWMkZhTzRWczYyNHFUYVhXQ1FoUmZVaUxjdXhvSUdoUDMwak1seWJ3VS9J?=
 =?utf-8?B?Rmxrckg3ZDEwK1AyM1phdGdySDFHenZQUGdpb2xyK2NSYnI3Z29mYk9IVE5i?=
 =?utf-8?B?UWJkbTEwWExGRzNJQ0orLzBsbFpUeXdxTERkVWlIZHRIR2NFRjF1ZWxjcHd6?=
 =?utf-8?B?SHNnWlZ3RXA1N1FtV09BcXNYeXBYYk95S21oVnl6eUUySHlYc2NodUEwVjJw?=
 =?utf-8?B?VFNXN0pLSXdqUG14NmdGNnJOVWhDdUp1cjBHbjA0SkJtam9ZQWtlTDl3Q1lQ?=
 =?utf-8?B?UDlxMWhpdjRCZU5oS2hlRStmUmxsK2hwVWhPaHBuczAxY2JNa1laaUVHNjZS?=
 =?utf-8?B?NTQwWjhHSTV2RUhEb1k2VGxQblZJa01KWGRnb2tZT2VodE5tYmVUYW1PSWpk?=
 =?utf-8?B?UlprcmlYSk5MaVlvckYzeDBtM3c3SEFiai9rRk14UkQ1bGk2K0kxUlBKTkJM?=
 =?utf-8?B?WXJqRWVQTHNPeU16VDFSMlc3WjM5NkE4M1QwemFaRWlieVlLRzZieitoYzA5?=
 =?utf-8?B?UTdaOWIyT3N6aEVwVzNZVXR6NXQra1pqOC8rbjVQTEQyQkRhKzRVZ3IrTjRY?=
 =?utf-8?B?eVZwVWRjWTBsbC9WZTdpWUlQc0l4U1FXUkUvQVFRNGhSWERZSjM2ODJNWDBC?=
 =?utf-8?B?UTNEQ2t5d1E4N01uY0k3VlVzVGhId2liaFBCYnhjOXhlK0ZlY1VHVU5GOVpm?=
 =?utf-8?B?V3NQeS9hYUx4QTM0VWpGOEU0ZDhzTXVyUHNaWUw3VDJsaTgzV2JQMnBmdy9F?=
 =?utf-8?B?clQ2ckZRZFMvbTdnNWFER1RaWDU1NjRRWkdDdjErZktMdmYwY3FoWFY4TFhj?=
 =?utf-8?B?MEtBWnh0cWpnZk91YUdiUUc5UkpxWFdGRW9VNnZHOW1JcHBwNGlaZXMrZWli?=
 =?utf-8?B?M1hSTWtCeDloYXJsSnZtUHhWN1BwbzFOOGNtMkNVUHJtTzQvVkx6NXlWQ2pM?=
 =?utf-8?B?WCsvWC9HRVJqZXI4Tkk4NS90U0FERTVNcTNZMkZUQWltNldTM1F2b05YN1NV?=
 =?utf-8?B?bjNIUmlkQVU1bzVUek1UR3BqWExvZFVRV0ROK1RpQUtONE8rdmQ1MDJ1ek5p?=
 =?utf-8?B?c1I1eDRPclArVlVOUDluNjFyaWlkWDFNQlVkbEpvcmZYOVdPRXRjdmEzaDdK?=
 =?utf-8?B?NS9FNEc5UW9vYnVsR2lnRCtZQmkyL1YyUWY2cG83RTloZUlydnJ2ajFwMGVQ?=
 =?utf-8?B?Uy9zdUlOdVN1bGJqSUFvMlNEMXJPN3JaUzhsTm5ZVk8xT2tUbjRSSXgzWDBt?=
 =?utf-8?B?d1VHRWFhbm40aTI2WjBRS2hGN2ptSCtxTDRHaFpYNFNkMyttUlpoeWpxNlBB?=
 =?utf-8?B?THl5V1lFZ28wNlg4MlBjS1hTZEIydmFQV0RWNTNjaFFGSm9QWmF5TGgwc1Y2?=
 =?utf-8?B?c1dZUFNvR3VZakhUa3VPQ2V2Tk5qNHhhcm0xTkF4NDRSTFYzam00SXVScmhJ?=
 =?utf-8?B?WFBiaG5OU1VyeEhaQUNaREN2OVIrb25pNFNSZTVrYWV3Y3pkVk9tMXBmR1VK?=
 =?utf-8?B?ZEtySXQ4OGE5dlA1ZEVkQncvTmRXTEFROFZZVm81QUN1Y3FGTTdrK1RHV0RS?=
 =?utf-8?B?Z0ptbk8wUkR5NFdnVkdwVFNUd0RPY0JUR1NJUmFDRzd3L1hDVWdQaWZvT2NF?=
 =?utf-8?B?UVZrWWZwOUlld3VFcjBIS2VNVGYvQWJobmcrdXBjSE5QZFVWcDBLV3NnZDZt?=
 =?utf-8?B?YXRRMDhodmpCcmFHVzZZY0taOE9ObGdudFdyQ2kxWE5IOSsrRmw4UTRpRGc5?=
 =?utf-8?B?T3FsVnlBSjgxOHBWZnNTZzhmMUVDREpyaGdnaUVIQ2hHRHFEWFBlUGlqMHcv?=
 =?utf-8?B?RW5xZndUOW8rcE5sTW5ZK2xGdkZDYVJ2NlQxd1lOWTNqWkZOOU9EUUV0NUpR?=
 =?utf-8?B?dGdxMFlJd3NLdHV6RDlxdnptTC9SNjUycGVpWnNBRDNwNU92L3FrdmpMMHU0?=
 =?utf-8?B?Q2tqVGtWL0dDMnZkdis5Mi9ldWxRSTJrdW1HL0NBRFlVeUp4Y1FCbHlncDls?=
 =?utf-8?B?dndKTFl5RllFWE0rcW5aaUVFbTVCVjJFN1I1RGFiQlpHckkzLzVLalJkUjYz?=
 =?utf-8?Q?WzCx+0BcUpY1VSfk8sA4O2kXl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9ca095-7ce1-4e1b-9ebe-08db83786058
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:44.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/ITy/xJukbVfHRxXI1tE6p+T8b90XpPD3NXMY45ZhYQJ2Qbxm0sFFmqEHZi7Zk7VEvd1TkmlBC4CTtCQQgy2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
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
 drivers/mmc/host/dw_mmc-exynos.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 9f20ac524c8b..698408e8bad0 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -664,15 +664,13 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dw_mci_exynos_remove(struct platform_device *pdev)
+static void dw_mci_exynos_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
 	dw_mci_pltfm_remove(pdev);
-
-	return 0;
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {
@@ -685,7 +683,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops = {
 
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.probe		= dw_mci_exynos_probe,
-	.remove		= dw_mci_exynos_remove,
+	.remove_new	= dw_mci_exynos_remove,
 	.driver		= {
 		.name		= "dwmmc_exynos",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

