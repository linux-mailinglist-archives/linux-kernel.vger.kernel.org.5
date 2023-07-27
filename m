Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCFC76477B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjG0HBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjG0HBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F1226A6;
        Thu, 27 Jul 2023 00:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEe7OF2RFmujTYC6kYlCQDq/+fso6//badFPk13SwphhDewiPk+t7UTS7Y+1K9HntYflycf7MUcRbpnfKJZO8NBGle8ThofjXoMGT1u8zB+AtRRmaLO2CpKsUMHRu2dsraOpvsJdEj5Q4jaa49mK3gTEiAoEepIPEJiwwXHdIrbs4FlBlgEGgLk0gPHPxbRgXKj/UwsU/9VHOd0vLuXoWdvJSFEKgbF0MYSMvjjCacPuA2SMtkAk+JxDNf4IH0ebDUCQl5ErEjKny5XO8U+MHYgF5orSZDY4CP0ZG9RkecurBgynws3zhrwi03sFgRR13gVe6UqPG+s58faaKylo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/FEi+NHrJgVzPUdApTL1O5ZKA2lbL/MoTwujWdTFXw=;
 b=jooUmuxIQwp4hkknl2C8SmQOnxui8JdbQGjqpUzm9BLCRGYq48q9BZETlf2lPm+QS29ridlTi9UTiiFasgvQbPB8QuKZyDIrYZmPsrCIX4ns2RCo9Q8Zhl5G8tox3Szk89bDVeZ+a9x98fKAw1ZGKT9BuYlf/wwmNEX+b8RzUsaK1UlN2pD0TKqqa+1VSev0/8OKGmawujj7mtvIo7IvZNJYkW6bGvNrLqZ/jJbRIzgptl+cWkHEO7c7vCoUIEEfSRuY11Hhw1E3j/9RyMf4l2t/bl56B13qRD0Bry/beqkahUe0GV6Wx5wbiGpKao5NK/OjlEcZT1Wj9ugByiW9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/FEi+NHrJgVzPUdApTL1O5ZKA2lbL/MoTwujWdTFXw=;
 b=jnyUevhPwybGl3lv4jrdxNBXPK3FOHYgJeDqJiI+dlnFFYZxtPRAuosfgAj7kMM3DScJaTqP4wpShlX+yi+nVkTK/oZGapM3/YFulVhLNijC0QDZRL6MmwIHCz+Id4Pt6PD+bnIEWHprM66/j4mIMxU/M3ikaMypesZibssTtVCX5jq0FRIsUw0desYeZIMDjARdZZSFKSghuNlFob2Y9kMdIbAzakD//8MC7srW5b9bJxOBe8hVGtHLKeZlZgtxl2P9ALjIz4w9JxiJyy+VNN8X27D5+BpeQwIXDJdn7FTfwgwS6q9GOVzbGtYdi0n/LF6t8FnKwfRrcIwU9tyO8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/62] mmc: davinci_mmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:56 +0800
Message-Id: <20230727070051.17778-7-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f08c3d-8f24-478b-c605-08db8e6f4402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsGP/RV40bLflh50vHlztjwD/IwdOJ8UBH6VnYn/AzwZlM3H+dPQkFYGH9AE+nsUHGVFyD1dipD99vDX0T9xWOyV7Jq7DzrJTmtp8+aHubadjbvLkADktWNTOpfSY5/KmEOx5Yvz8ecq9FIAH1DSkxBbjkw04eFXYF8A52x9NRJWh6eFVIF0LSkWOKTvvufuNwbbSWQ/XYyuQ0R0qYY9rK12BV/Bqj/Hnap2oa95kh8YuN2C/6TueQsHXgBZo4d0ubi2KojQu56Tlog1uxh4RSOR+z09EfBhRlYaaw/UHiUoy0+LWxcB/Pka6Ify8uSOVLhRzPQS/7/Hkl/Wp5hutyswnvOC8imlsgQ3TEVzyV3mqXcEm3yffdTxNEvJ90HIZwJiuDWeGdeU+8r0xhh9+/gY1v/A1nXYGMnizUmMpNGDGtqJdSdYid950w/UmqbFpp1tonctQsdJRphGeKh17Oq++raYyYkG6/rxBCb5eqWyp3bSIN7JxpQ3jwvb8uBIV1YSxz1rQcDh8Ipsi0n/yPwxzJE4Vzpo52myxs39+X73a9LDMeGkxHstP4wW5zSAOYK060ZHUZXrYYpPjdhvS1ZEzAkgLri7ECC5YaerP0VS6SQd2xbyLNV02nW0C0BM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(6916009)(8936002)(52116002)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNsMnBxUlNiWnlsQmNpUS9HZ01hQWVxNktFN1ArZENadnI5V2dGT0xqdEFT?=
 =?utf-8?B?QVFHNU50UTgyRW04UVZFVkZWNTFUZ3ZhQ3pNSkFGZm82STlrK1k0VGQrNW92?=
 =?utf-8?B?STVmNkZYVUQ3Y1VMTDk5THB2bXZJL1dFN3pIeVE4ZENGajB3UHo2RGhMNHNP?=
 =?utf-8?B?VjV5NFM0aVdJNFNOWmpBTjV0SjFDaW5SMmlwc0FiaTh6VDZpRzlKUU83Zyta?=
 =?utf-8?B?bkR1WFBFTFFzQURsZytBaElUK0pSanFMd1dzYlk1R0FFc1V5bFlJTWNWTS9C?=
 =?utf-8?B?U2VDeWEvQTRDSDJwNGpRQzVOSy9nb3JHWmpYZ3d3Q2lXNFI5NWR0VTArbE1T?=
 =?utf-8?B?ekZBNVpoQTM3MFRwSWs0YmFqNXBBWGRtRTNsZFFBRjZSMkVZbmpHcnF0dFVR?=
 =?utf-8?B?SjZ2NTFGRU83Nzd2SzdscXFDN3JlU29uNE5rSmxmL21uQkF3S1FEM0tYVkU2?=
 =?utf-8?B?cDhPRDVsYXZGWHA3eVNYRDlEN1R5ZHRqSmZ3b01YK2d1SlZVcHBPUzBKbnFC?=
 =?utf-8?B?ZzFLVG9pZVRaQVBKWVh4NmdGR2ZKNDBUQ1RnYzdjRFdxTXM4bmVEWEczZkZ2?=
 =?utf-8?B?ay9FUjNkeTVBMzFJOGNYREo4Z1Urd2p5bG1USnhtS2x2R0JUUUVvaldzcGpr?=
 =?utf-8?B?T0V6N2gzakNWdlRYa2xWaEJpck1zSUZKcUU1NldDc3BhZEVFMGdjcVEzOWw3?=
 =?utf-8?B?TjIrQXJmK3ZTN2dmRy85MG11ZzFleGZXeEpDUS9qd3lxcldjMGFaTTlyeGhX?=
 =?utf-8?B?aVFOV2FIRDNENlRXWXpWdllGalJ0QkR4amIrenJKZm5JeEdBd0wremJqZ1N1?=
 =?utf-8?B?cU12OGNjdjMveUl3MjczdTZnMGdqZU00V2hLc1NURS9yUXh0RzZjLzRjWG02?=
 =?utf-8?B?WXV2Z1VKTFRjSEFDZjdQN2FLSXdBT01XTVU2UkF5dEdJZ1Z5R3dwN2RDd0RO?=
 =?utf-8?B?anNZMEUwSndrUVF0a3RjQ1hxYWZRUXFuWkZpU3gzSEZqSFY1V2JBWlhMVzR6?=
 =?utf-8?B?cGFXaHRLanBIM0VuTU10RW00alhIMyt2WDQ4VnVpaVFUcWoyRGg2dVkzMHRj?=
 =?utf-8?B?VlBIUEV4YUdpZ0lYckVqNUQ4aFUza0R5WExQb3pFNEhsVWgxdG94VWhSdGg5?=
 =?utf-8?B?bUlrY0hIVU5qNVhYdUJiUHQyRGJzRlZWN1BjVHdRYzdlczQ2Rzl4dTNoUzZ1?=
 =?utf-8?B?d3pDdHd0N0VqZDV6cEtLVzdCeDNrZ3B6MzIzTTlWUmN2NWdGRm43YTVTa25Q?=
 =?utf-8?B?a09NSUtuM1grZHRmQ1JPUWlJQm5HUTVoRDNTQ24veHZoTkZIcFR4V2UrbTJJ?=
 =?utf-8?B?dTBNZVQ3YndOYlM3ZnlkT3ZKYmcxTEFONWh1d2x3SnRrU1NRNzZ5Z0gxQ0h2?=
 =?utf-8?B?bDd0NnQzQVhBZGl6bGJTcWZrSG9nUkhwcjBqcC9PcFhnRm45MHNrU0lRenZV?=
 =?utf-8?B?elhaWVdKM2Jic0NEZ083YWJ5N09RbWJBTStyN2sxWjZFWEFCaktsWFJGejJG?=
 =?utf-8?B?czg3UWFmNGFUZER4WkVVb3RRS1BLZFcyekNmcjN1UHFBdGxER01CMTZkTENU?=
 =?utf-8?B?T3k0MFhJdXpTb0h2Wk9SSzBSYzN4b3BTOFBHc3ROWEErL0UyWXd6ZXZVRytz?=
 =?utf-8?B?S1FqTWYyWXRQbjB0MXFqYmIzcTAzd2FFMDRlR3VHTTZiQkpWcjl6akFrejFK?=
 =?utf-8?B?WUJwdmJ3amR4OHVoOXBra0dDQkpNdFpidE1uaWJoNEczeWhVbnJTMkNpSE0y?=
 =?utf-8?B?STZkSyt6WFUvSXZBb3grZ3MxWFNJQzdYQTJRMVI3ZmJTdDV3Y3JSQmFldUkx?=
 =?utf-8?B?MGsxQWJCb0V6dDh3Y0g3OElGM1lray96K2VMcnlFSGJ1V2U4QVVsQUdzbFRq?=
 =?utf-8?B?RmduZGRBdkx0c2g1WWRpbW5qMzUwbldhelNvZHFKc1pMY21VQnNpeVpJd1Zl?=
 =?utf-8?B?a3pTMllHUVRxaUEzcmhlWjNpbkswMkdxd1QraUZJVzU5em10bm45MVhpeFg3?=
 =?utf-8?B?N2dnWWcxcUxuMVZvOTFjMG9ZUy91SHRlbERLdGszZm40V1ZMTjFzRVh3K0k0?=
 =?utf-8?B?WjFkOVQrUGo0bmxIaCs2T2VBL3dkNlR2YU1ZbGVKUnorUFc1ZFlFUFZKSTNm?=
 =?utf-8?Q?Xyas83bIBZXODKGaq6fQXCRML?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f08c3d-8f24-478b-c605-08db8e6f4402
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:13.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HYuJhu78zYIOORwtU89mPWkVgOsVLuY3HR6Vj/7Gx/Lp6WEK0G0A6w59YKtKKYSssAC6Rha2RlXjprJ+W8gPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mmc/host/davinci_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index fb686c0d171c..3757e4ebb614 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1345,7 +1345,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
+static void __exit davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 
@@ -1354,8 +1354,6 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
 	davinci_release_dma_channels(host);
 	clk_disable_unprepare(host->clk);
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1402,7 +1400,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-	.remove		= __exit_p(davinci_mmcsd_remove),
+	.remove_new	= __exit_p(davinci_mmcsd_remove),
 	.id_table	= davinci_mmc_devtype,
 };
 
-- 
2.39.0

