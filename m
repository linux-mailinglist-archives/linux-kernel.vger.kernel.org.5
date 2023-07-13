Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1590E751B31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjGMIOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjGMINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992113A9D;
        Thu, 13 Jul 2023 01:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtzfVGbyEzJT81I2HFniJjx9PMzANlkFhtD83mn3DP9dAhI3KNZtlWBroe9a+xvduYbe2vBpG6pbMFhwh6skxwYH0DIafaTMMk6+ItLcl12YbGJ/H0ZZ6ZXIG3oYl4f5KYMG0kEkmriQx+cZMzbCWIwRkntB/HKig/Nhdj0xxli893mGAT8fUEKjo/ub3ysINo4DdjwwoWIuDjIqsmAdJsb350OXOEWV4Q33zfdTgX7GHb9KJP6XHgZoBBkoTTwlecPYBxH3/l7Qh7t2WFtXNWIGlTU7n7GzV4YBJxhyK01/JwmxyVYMtfR2pScTSNZcJFg7DpqrDavaBDPUjiUe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsecs0FraqEkVI69yYtZuIhcDu7CE/3dvX42vrGL9bQ=;
 b=kqKBEWVY4L7xxw1srMrjuPtwRKgrxH5tq48E0CVyO3j6VhSJjcZAm2EgAfprLfJwS7t/QnKcj9UBOI/hKJ+7YdmMO+AK+5UpPMaEInPhLpu2II7x7Y1seIbpfMyV4aEmAlpXkCfhn1HPR0a/XbUYVGmb/DW4TjnqMMD1mtLAVGS4x3G7mIFX13rztjz9o7jvvZudvjde8uWeD97VLhfcql6Bv1rLg+9etpvt3pNMSlb0323/563nCOGut5rOVuAdiR/lWJGCttXHfEUhXvAn+Vdg+Uush4PgnKTqjyOOkohA/1LviB8YCJHfwf2nzuqh0wCGqjQrDCqNNC0FjIWWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsecs0FraqEkVI69yYtZuIhcDu7CE/3dvX42vrGL9bQ=;
 b=mPVKroVwhB1GecJN0ZLGjKxhzUHAuBNP1TRGIhYdc52OTP+U3qWCirLIrq652vGpiuqyDE7xmkSmwv0edDODoBeuHWYCaIBdvyNRN/HC9MgEJ6kr8Sj1+8+gvvJSLxg+A3ZRzR9HjPS0zM/WidRr63WXROgoUwPgHkXYlyJkaMj+4G941At/DzjdQ/+Gj5pgp8yePS41X5ild0ql1hsB7jCm3ifmqKcBuc6+Vgp6eE74h/e8T0+0COODK7ctssKva/FqzorMge5ejDc0IL6fWVcEEQsKtOCQKQWmg7t2HQwe44JkapAaW8yrcY4icjbeTwqaHQa+dXCcU0NaHCFIDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:09:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 43/58] mmc: owl: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:52 +0800
Message-Id: <20230713080807.69999-43-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: cee18cfd-0625-4b4f-0841-08db83787ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QgRSbiIigNwH8BBVDzglXNT0nQwCtSUF2YDI7coXCW/012mD1bYwkDXSvpoVzb7M2QFFW/jdrzrIWJnLlP561NWxo+tAKhj9I5B2kQHYewmy/0CSyu+1xix30SKr6joMBIb9lW4B2tqMHvML+TNbbFdHn/J62aqPuk66WiqQ1DpeP5Tl5GSd3Wj6x4CZCmh9UW5HtWMFbv45ScQVqy+GUp1IfTFkpGflm8PSRJfREe70TzA1O5J/gdL1n9bVRuBLUiCkwQGMAec0iB41E96Sgmp8DMkspVn3tOq3+Z5+JKOLf9AymJPo7w6RexFhqNxlsBxeMNAGEVuMxsElovTLqu7mhVkfJ7ldE8XVoKPGJ0La+e0nRPr5oMJiUn8OU2hIbaM49aw5bgeZbNYBd5kMP75CbJmZU0NcSu+uvOSxxhX/U+cYj9E+c5juwRVqAkYVsbAdiDOzU5bfk22b3vLHHmkLLVVrNfYYlTT3iso9EL96rVurk/IxOJk3xvT/jwzWXfJl/ZNWCmXzbS88BBv2+AGaYC5tp288B1duziisMEcz3XKXjidRE9ttnQ9/YMfvUYvxiks7MEQQfuqjxasSTqASeqwe9BqbGJQpiCZAkYlrwzMv7SeSJHnlPNLM3DG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0pldUg3NmxyTHpJQlV4ZmMxZVRzMkU3NnV0R05IaUlPTlhSRjVYcDh4bzRz?=
 =?utf-8?B?REVDU3RyRnJQWjBWME9ZcmhxMVY0UUVRQkJYR0Z6ZXBSVmVHMGlTNlpwNWoz?=
 =?utf-8?B?ZGVwT3QxSy81djdJSC9FdW4xRnhUaTY0RVY4RXJTdEM1ZEpRL1J5VEFxVXNn?=
 =?utf-8?B?aTlXMm5CWTQyUE42WjN6QmhLaWxqN2VvcW05d0tPRkx6V0RzYjBGZTBpaFQr?=
 =?utf-8?B?K1dQbXdDL01QWkluK3pBL2Y1RnEzQU9YSGlIZlVLYnJTRGJtNVhZcTdTbWEw?=
 =?utf-8?B?VXEwZU5iTXB0blRtWGo0UGx2UFNSTFlUZm1mL25BY21LUldkWlQ4Z0R1Q1Qv?=
 =?utf-8?B?eUtuWnBwN01Zbm40MlRwUE1JaUxiQ1lQM1BSakNiZXJVMWljUVF4cnpnMENK?=
 =?utf-8?B?cm9vQzRLaXE1VUgyUDJ4dzFWb1pXWUhscEw1T3MzbjlIVlk2TjZpZ0VrZkxn?=
 =?utf-8?B?a29YRVN5cnZvNjRnc0hwK3NGSXU1Z2JsYWdZVDIwREsrbi8vZFdmN0hwd2Fh?=
 =?utf-8?B?UTZxbVQvOVlSME9iSUNMeVh6ckU1WUdkSm1NQkR3M3QrOUNsa211TisyVEZa?=
 =?utf-8?B?M2kxTVpodHpjbFZKOE5hTzEzc2VEUlkrNEwxVDR4eEh1VTgxOW9WUTFvZGFi?=
 =?utf-8?B?cjFqNXQ0aFh2QUlFRStYTmJiYTl4VnJqV0Y5dCtVTmJEYk1RQXorZ2ZpSEcw?=
 =?utf-8?B?S1lNeWJvR3pVN08zTTNCdHM5Ylp4UVlLWjJpZGpEcWlTYUhHenVrbS9DNFR2?=
 =?utf-8?B?ZU5Xc1V0dzhwbmJUclRBZi9teG9JWFIwTmRkTUwreHVvckhnbDN3L2dWbVVa?=
 =?utf-8?B?Q3N5Yy9pZTVFaVdCOUhCaTZPK1pQM2J5aGVZZ3M0VFBKZDYyZGRqb29FaWYx?=
 =?utf-8?B?czBoNUFSSkJha1N6M1NsdzJsd2d1Wi9aZ3VJYWIrRTVPZld1YTQ1ZUFUL2x1?=
 =?utf-8?B?eWQ0c0FrNURMZXFKNis4QXV0aXhUMUxlOFN5YUpKdDlSK2NPcDQ4VXhTNS9z?=
 =?utf-8?B?aVo0SjdscytEaitLY0Jpb2tmd3d0cDMwaW1VZmszdFhxQzJtQ3NDUEorU280?=
 =?utf-8?B?ZG5zT1lUb0owamRWRkpwQTd6dFlRU0RrTVV6dEhOdHFVdHJBMjNYWjJzUzV2?=
 =?utf-8?B?WHdtY0dONlpXazdZL2RPV0RvRGFGSWw0bVpiY1FPNlVqZkFCNzJWNVZwSFBx?=
 =?utf-8?B?cmxHcE5PSXZOcFJzOXpQTjY0TnFuNXUzRTFIUnBncStlZDF1cTJPd2pKcTl6?=
 =?utf-8?B?bkNlSWJhUURlQlhybWdsRVJuTDlDOVBUTitXWEpCYW82QXFBYVgzUlBaTEgy?=
 =?utf-8?B?RVpkc0tzd0tLZW9Fa0YxVThNMHBSZlNDZHJ5bmVKaVp6ZDI1UUJubytFd21T?=
 =?utf-8?B?VlFrRTRqSkMvQzJ2WGFzVW13WERzajQ3dHh6bTBmWmo4c2FHT1BLZGhzait6?=
 =?utf-8?B?Wm1BT2VGR083Z2NNQzBiY1UzZFVTcU9PTTFVTnhqQUJNZ0ljK0NWUkpoUUw3?=
 =?utf-8?B?M0VnZGg4TDA5MW9tckJ5Y2hWVWRtSStnNlRNODdZWWpoL3p3Yld5QW1ReHlX?=
 =?utf-8?B?RExKUlM5OTIvRzdpQzQydDN0MmRPWENoMmVJaFpOSUlWUkxuWUFqUmpJM01X?=
 =?utf-8?B?aEY1YkNRSmZZeVdsNU5nYXVFaXp3YXVCWEQvZnRVdFE1WHlia0k5RHlncUtV?=
 =?utf-8?B?QmdVMlRHb2FZbksyVmZ2TitSaGxBTU9WeGt4UmVNSXVGUVNSSUpHbVJFVzJL?=
 =?utf-8?B?TTIyTmFRM2t0bCtFSXltVm5tK1NuZSt1a25mWUt2OHNzRkVCemlBbXppY0lL?=
 =?utf-8?B?SXhlaDBnamJ6ZHhlaGw5NFVpOWdaVWMwMWVleGIvdnFQNVlzU3ZVWDJZNFVC?=
 =?utf-8?B?TVBtc2VVVzNzbVlZOTlRRU5TLzZYaUpsS1ZnRDBqNlJmd1NDWldMV1FvYVBk?=
 =?utf-8?B?dE15Y042MllNYXBpRnQ1TnBEcXhHSDRuTWcvOWN0NEFwb1Bzcm5XSWR4b1kr?=
 =?utf-8?B?cUJBcCtQNlVqajh1TkNlQUZ2RTM4ODdEVENHOUJpajlnakdQdHNJamx4U3VL?=
 =?utf-8?B?SlplNzlRNzlkbVFoZlZ0VkRQU25wWlVQL3BmSVFrODB0Q2NGb21ldGUrOU1D?=
 =?utf-8?Q?uPbgBxvGqfw2Vq8ihUsneOTW3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee18cfd-0625-4b4f-0841-08db83787ff3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:37.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOp9e10R59yNVPffQMCIXXkUwk9egrAmP1Ztunup0B/17EZINOo7RtZtL6N4WeJz8UADoZcktO2RJLmxtl8fIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
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
 drivers/mmc/host/owl-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 1bf22b08b373..a13bec42554a 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -667,7 +667,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int owl_mmc_remove(struct platform_device *pdev)
+static void owl_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host	*mmc = platform_get_drvdata(pdev);
 	struct owl_mmc_host *owl_host = mmc_priv(mmc);
@@ -676,8 +676,6 @@ static int owl_mmc_remove(struct platform_device *pdev)
 	disable_irq(owl_host->irq);
 	dma_release_channel(owl_host->dma);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id owl_mmc_of_match[] = {
@@ -693,7 +691,7 @@ static struct platform_driver owl_mmc_driver = {
 		.of_match_table = owl_mmc_of_match,
 	},
 	.probe		= owl_mmc_probe,
-	.remove		= owl_mmc_remove,
+	.remove_new	= owl_mmc_remove,
 };
 module_platform_driver(owl_mmc_driver);
 
-- 
2.39.0

