Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF86751B04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjGMILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjGMILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D93AA0;
        Thu, 13 Jul 2023 01:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYpO/4voLcWTi4d3dfR28v7GaLXJFeL2HqUq2m6EPonIUstHex20K9Gt0KKvzLpFd/rYLWhz8tgpJj6kq3HBMKwRdtG3o5FY7tgoB7e0jBHzMyF3ZBNVsOqwZo3rGkdbvcumpSrWzPaxkiuBE2AR1TgWZD2yBk/ZDn/iWB7vFmUYhvkqjpPBFYy6T9k6zbUK/gg7q/9doRBbNIStS4JZlGJhhMOw6UEJ6pKZTUwNZ7OQdwYOIQYoxlWkoxg0fXHpM9/ph+SdpVXRu/gA+RlNJQHm0JFtZZFtI2/vNaW5DsG2afCs4hFTNjcZ25na0ah3KNl757L2n9i2DhdyGqv2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+CTem6dHExq17DY+SzLyRt98v7BugU2JDEv1g8WLeI=;
 b=Aly+bj1IrrkJUer5Fsc/iPrBjSGls2jd+aLDjmFQbcrT7R/9tz/thjUAwFQ86wSswOVXCY/I0X+FpQnK18lP6t1OxGEJHZzeLIPDBAogJZTuc7Ir9YVwa833SPKFHpARZXbCFLPgnMdNXk2vosSDeee9je52oGxo9pifwhC7zhZv6oUXVWl0NMblhU9vASTuvJZXtVL0hVvhF9GsG42RypIOta8Z0XU3rzKsIfLU4ZZEWteuC54yJEkwnMljtaPYBOnJsoylrRPqLKp22jzaB0Q0nVOUT5Kr/MMifbKm1BhIdLEUHIl1xjad3hQxWWXuzml6ITNrn2Ct43LUB03HWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+CTem6dHExq17DY+SzLyRt98v7BugU2JDEv1g8WLeI=;
 b=h/7+/0JgQfgu8PqnwAN3vMYAR1BjH84LRoIHghilhp1RspockeWHBqvytpZj9u2e89jqYC+bOyVG5DkcGOCecmIaB7uuZ8RWZbUE2dw72J/uo9sS7x29zcQIuDoJlqG8lqnL5vKbrgn4uLMN+mkW1AC1D3ijQIStR1LlReStch84sYbn47gi+esyHGlQsZm+UqweeCL3uxOQZgBwuoUxTCmUDjs0P2aRLZgnhtexQAPmouj1VBZTySR89m/8ib8fJzr9dK1UrpX5bdDOeBrYEQrHsWBLG2LbnUUNPYxGGsY7NU9DkEbyrT4JlQ5S4gKkJTwz4ddKSF4szW8OaJsrrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/58] mmc: sh_mmcif: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:26 +0800
Message-Id: <20230713080807.69999-17-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7977818-571c-4e80-1a67-08db83786364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UG+y0B6CsZiWDx2Nr+tsmSY2w9rEgBOa9qgi13h1JERWMR68R9LMcwuSl71Ju59OjUEm4oljPYsx7/h00DizwmkJRS+Dq3fv6fclBtH8+TPBPJ4AX/g+8MXwr1IDng+svqQV3n40ZmxPu3bwJdeh/qTKRd/9hONsywbMgPDEhE/5gjlh2vqK6BKN7/XLdQe87NWF/C77e9RleVfFGYCtPbt9Mxs+sEWF3g5bw7IHZGKUCfMM+90p1SMstFcO1DlJgOGiExYXa3aL44AkQifOrrdVZy4kKf5r2JnCQDdJ+ivD9qohhlLmbeWduUDz8eSJHtti1rfMCMBPXLJcdIcn4CSarAl6BDAq6XfrYV6nEFJsSnU/kHH1xPEWMRWVQQM8G9gXHRbzJO45pjZaKsKjOuUv2NHKvylnhGELK5852KlLJGPRbcbzTAiOvwljoSNMxAOtwYqJiX+A8/BIP4wjiuOLpmOaTRqSkmuGNftC6PWOtCSX2q9WzQhp6ckAjvJcM6Or8foV6HbjyzTvOqvNHEBXGak84Y4gP5kVv7bmNn7wID/HYkTG0pzt17P6R5Nu7ZSrPTblF36tJLHBBH9TnB0uztPiBmjIwa3p27eVFlJx0lXWIwdHYgJPorD29NyFW0+l+cvY425qfVAhXQ9/XwY732QWkUc7/mSgvxWdWt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(6916009)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly9CcTlOeEJNT09BdklJZk5kdUlaSW02V1VqSURGUHZNUVZYRStNZFlqMXdo?=
 =?utf-8?B?QUJQVXlxUzFiTFZBRGs5SkNOck1aSWR2M3ZlTzJQU2tkRWRkVmtqSSs1STQy?=
 =?utf-8?B?V3I1Z1lkZldMb1hraGdaUjBMWG81ZzAyVW5GcUYraUZXNUNKTm1aYWpFTk1u?=
 =?utf-8?B?TU1jMXp2TVYzMVV2cXRYbkowSWJ6YmZ3RmltTTljZmFnalM3T2doWEZPaEVX?=
 =?utf-8?B?Y2xRZHM4SlhTaHEwNVZUZlRXeXZpNkRsd0lxUUNGT0FvQWNoTmFjUWVBVzJo?=
 =?utf-8?B?SW5sZ2xtQURNMWpxZFE2L2ZUUmc3YjUyUUpEYzlUYUNxdFBMelZISEVTU3Fp?=
 =?utf-8?B?dG5TUGdsY0FuOTVwenZhK1E4NUZYWmMwYTc5a0JXeG4yem9kOGpHRTlnZWJl?=
 =?utf-8?B?alpEdURuN1JPcFVaRkZjRG5yd2ltV1NtRnFUK3NlWnllcis3RWp4Q053NWZN?=
 =?utf-8?B?ZFJueW9nT21qUVlPNDZvaVI5WXpBSWdUaXN1MVZwc1NsVWlrZ1JnYThLcDFZ?=
 =?utf-8?B?d1pIQ252TTRIaEZiNEpMcGZweXl1OFBHVk9PSFV4OWNtdFZ0RG1GZ1VVeEJz?=
 =?utf-8?B?bHZwSmEvRXJyT0hMZFR0NVNkR28xcXdjTGVnWGhIbmlLUlUycjhRWUlTeUN6?=
 =?utf-8?B?SUdDSkJ2b1dTSFlRbFZKMGV1bWRGRGFCbXVNcDdOYUN5SGkyc2xtc1dFWTU4?=
 =?utf-8?B?Qi9tUmV1d3B1Mkp6TFBWcThvUDd3QU5aQUQrUFNheWdObXQ2S3BqR21UZGRr?=
 =?utf-8?B?bTdzRW9tV1dRWTlIYnF4aVlNcFNJOXUrNHZPMXMvSWVOY1lJRVhlRTVHTTN4?=
 =?utf-8?B?NXVsZDMrSWVLQW1WaHBmbGQ0TGlyekI3aGhadlREQzRTN1lLRVIzR0d4V3BH?=
 =?utf-8?B?SzREQy9WWU1vYW9QN0Znb3pyVnlUUUFmdmdNelFVZG9kS0JSUkVaMVlzTStl?=
 =?utf-8?B?cjkrUUdNVTl1R2w0Qlc4b1F2a3d5K2ZlclJ4T2FmVHRobjd1YzM3aXFqRUZO?=
 =?utf-8?B?a1ViL1g2OGI2RTU3OWZkVXBPWWM4ZDgwbUdoS29KeW1Va0l5UWdZVXNYaCtU?=
 =?utf-8?B?dnBwUXF0L09pWWxTb3MvS0ptZ2R2YXVURUhHdUxURWMvQkNENkEwOG1ZMlZT?=
 =?utf-8?B?ZjlsTHluQ2Z4YWMraVBsYTlEZm5wakJDZHZ0K2hGMi8zblFXRG0wUmJCaFdT?=
 =?utf-8?B?aUVBdFpoMnRwUnFwQitReXNOT0ZEczY5Z01IMlV1WmFjWWFjZFNBV01GWVp2?=
 =?utf-8?B?NEQwTXlRSGJtRmsxNG5LM1d6Q3d6NW1uRjdlZUpma1k5WlhWbVRlMXdUeUor?=
 =?utf-8?B?dnNMZ1l6bStVWEVncVlDak1aUDl1b2dNYkRib3ArdXphQWtaRDQ4MzhVa0Jp?=
 =?utf-8?B?UjZJaldmZEJzZ0xnU2tuWXE5bm1xMkNlMHJCdDB1T05pK09FYnF1NmZvdDJJ?=
 =?utf-8?B?VzBNemZjQ2xYUnlZWXFNY3FtZXZ3bGVNSWc1V2tiWFEybkNSZTcwK0JleHRj?=
 =?utf-8?B?STFjWVJtVlR3djFCckpuanFYcEdZSDJPOXlkSXpPS1VDa3FqSUlSK0VaSmsv?=
 =?utf-8?B?cGNiQ3lXTWFjZ0UwL3dnRjJmWW9ibW0vQWVoRUNNekxxN0FlUlNjRktCZEFV?=
 =?utf-8?B?K3VZT05hU0dGNEl0eUdvTkxVUSszR05BYXRqWlg5NlhhNGlsbk1PL1FZZ0xO?=
 =?utf-8?B?a1M2QVBpOWU5NTJwcEwzY1JITlRhWG9jSHVlSERVdTBCcHpaMlJUdTl5SC9q?=
 =?utf-8?B?WG8rUzdRTm5Ld0JLc1NZNmhQNGZwdXZEa21hNzJvUDFKM09ZUjVTaTRJT2xM?=
 =?utf-8?B?OUl3SmRycEdRRC9ieXU2S3MwVDdTdk92eWtLbkNuM2R0eDhFR2ZBdEJRd2p6?=
 =?utf-8?B?Sk9PVis0VXpLODdqbnhxQk9hZFNHdmRqSWQ1RTdsVVZwb013TFNNRHhoaUlz?=
 =?utf-8?B?S0pEdkpIOHczSzVLRHVGSFVpcHdLRmJCWWIrc2RZUEVIWXRaTkpkN1kyMXFZ?=
 =?utf-8?B?ZnM1eDJkdFAzMzZaS09zN3JIZ1g4VVRrN0N4UnRhNE5YaVJGblcvTlNvNktw?=
 =?utf-8?B?Y2hBbE1vR3Vld2VJekxDYkdFa0hYWStOeTdoK3ZDQnJrQmJGdDF5d3k4TXlx?=
 =?utf-8?Q?gpMW6S/YJoB41KdzAZMHeCcU5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7977818-571c-4e80-1a67-08db83786364
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:49.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUszJBISyrIyN+EAK49YUDYwQbF0dgwZI2LTdLTXQdiZheqsRW9xxAtvwY01CZf9ZNiAbSxQxpMMsodHgFregQ==
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
 drivers/mmc/host/sh_mmcif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5cf53348372a..1066e0c2831b 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1509,7 +1509,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sh_mmcif_remove(struct platform_device *pdev)
+static void sh_mmcif_remove(struct platform_device *pdev)
 {
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 
@@ -1533,8 +1533,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1561,7 +1559,7 @@ static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
 
 static struct platform_driver sh_mmcif_driver = {
 	.probe		= sh_mmcif_probe,
-	.remove		= sh_mmcif_remove,
+	.remove_new	= sh_mmcif_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

