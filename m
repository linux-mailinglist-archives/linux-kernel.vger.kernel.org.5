Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4AD751AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjGMIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjGMIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB3273F;
        Thu, 13 Jul 2023 01:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyISleTuR9mTcZ9W5jANSz2+fRRBo2fepgRDvwulvC2mhWpxRLb6kmPpHHL7YtCGWgjHPK7C7wQRSGLMOt+zr9BOtTtPUHC7wcyqjIrpdf7Q69qGMfDAZw3E7+3Xe97ks0Vcz1SheSSvsi4C6uRut29duONCesLLdvLMDeR7UkCC3D5O71yrXDK/zI4uJg+Yw4BUayfo368Gh2a9zj8xy/VZ0lO5+ViMQODl6YKTAQl1CAWu7zQ56aBhR/R0Wyxdllnrue2D3fz+Kw1swvbLhUguvV+of5OcZzWEXUWfxg4NP41dfYNJ6TYAjR3BMDE8SiJpLIbYD7MpbvA6Ajq60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBmbgmPN2PB7xhwM2S5ZW2SjDGrd4CXWV0nFzX0ddI0=;
 b=ZoK+yUhggWfajeDUprqKA9v+r8ovBzcV75DDbLHBV/COwGdH9agih0I2LZAOEkCZ/yUhk/+jp9qPrEHX3aKxwD4+aeTME7tG0jZ0U8dCJpvk3vxpdZbeyyk7fqZfQ1NgIqkAMAFiqBsCsjqg3t5smpXqEFanjwB4EQOtJxxAFC4zj44eFs24+lgqx4jNpy/CY7c2DlyFvSlJoKYisgV3k2m5BsXxQdhzEqf7tYFGyaIVm4kCfGl+2wpP5k/I+xeB716hP7M9TGvuWMc1l/QRxM8jpbLbC2N/nGcxO4cNgOp8fK1oViW7bRe4FZxuh1R1coxiz9nx2Oel85C9wd3Yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBmbgmPN2PB7xhwM2S5ZW2SjDGrd4CXWV0nFzX0ddI0=;
 b=Mb2jUFQdWCg5hrDfY/OaLhKG+MSJWIPDbF0RxcWxYaNyw692k59MzX6cWtFJImNCANCcmh8KrRt8aI7TX4YsNs/26jLJh8nQ/Os+ETZ8HMHLNn0JupuJ/Q3Q5q94gn1Jo2fsXEDyTK6tKM5Gw5+Of0Zi8SfCf0Wn6ZG7Sf7Q67lZgp6xnsIsjOqiG50dfwom0k2qU+ucoHaWDrg2Y4kqw80MywjOLlRONz3LA1rqc2KEetLZpnRWugm0eDh3968uuZGmjYaCbRoMsgBqwSWPz7aLq8Gta8N5v18zIsgCJfoDRD8e+emhu1dhjNcK4IYfMe8481O7vTky3L7dKY2QAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/58] mmc: davinci_mmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:16 +0800
Message-Id: <20230713080807.69999-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f629f65-9977-4305-23ea-08db8378592d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1f8uWHkh8/kk6h5YiruNSZwowt2K1p64+smHAS7yS87J+2pFXRQBpM/DzO3sQwqDh3eHDaauC1NtawJpLvoABe/Dt+3Fad+P+H8ucOqTlBF6dUeYUGAE5nCbWrybRoFG84D0tyFLTcWRO3ZM5vfSkz63fofDGHDcThmY80VjgX4LR6QJF2yY0fNIMmFbLb8JA39/no9nRdomjDxFBI01yGd4r9fjZa9uSy/bNgOBKvrjj63Q7FvBsEvBaHeL67wmzeITGHS/69cUxw1Ua3m11oZv/puVI5pDNPHiH04IiYmI8z5ZGpvidUivb5OMyhxiGt6dFncAMNTEzLjjlrHFGsuV+YicqujPuK3iXsx8+bx4Gzp5FLoEHiRWn+yAL2JYrYhn9fcqBNh2Xu165vmGuy6wfwfOJILWUWZsdRM8L7zmp6FMKWjYzAYxPVGc5mLUHULrqSrtdWIW7wkT1Hd0Q2ZW7WjuqLoONNGnUaj4wUSfKZyo+cJWb0W1Jxg6nP/StUbrC3mMDCsX1SqEn5KnOB7lqGNJ+Dpz23+NyJF74ngssWHk5cdJJ3hFVnH+OZZENDH2I3dAEhex31wbym9qP3rxWzXMUVt8XnAgUmk7oOJuUi4XIV3sfug6igqHgMlxtZ2j6AW48u9RVE4pQsEb/US5Zh+WHeLxOUXibCGjHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(6916009)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVzWEcyQWNvM0ZxZWUva21PeE85VmswZFdVNWpXMG1oaDRORktTUzg0Tk1q?=
 =?utf-8?B?ZlA5WGJvYVY2d0R5Y1l1ZHJyUVV6L2Z4WVJWTmtpRVFneFk3aXcrbnRqblJR?=
 =?utf-8?B?U0liMXlSajEyM1I0cy9TZjVDNmJjbVJId0R6NGxndjVkeVEyTFIrdXhIaG8v?=
 =?utf-8?B?ZE5xVnprRk1nVzFKUU9MQmVQeHFMazVlSWRyOFQ5Yko4NjdxTXRKQnV5b3Jw?=
 =?utf-8?B?TkNheWd2QWQ2NDFoZDJvSzFjQm9FQ2ozTHprajJoLy9kdWM2SlBCNDBFS0Jt?=
 =?utf-8?B?MXFFOTEvM1hPMlhDcHZFNUlPeUd4Smo5ZjRZUDNMc2FkbGFzN3BYMHRrRGNl?=
 =?utf-8?B?ZFpSS0RMZy9uaDhIY29tUEtRV3Q4cXEvZVJmd1N0eEV5UUdTdFRrRmlxQXFu?=
 =?utf-8?B?bFJiNlhkYWpXb3EzTmtVV2daNzNheVdQYzVqK2JDc2QvWjI3eis2ZWQ4Z1hP?=
 =?utf-8?B?d0Y1a3RBMUtXNGwvRVpVbkwyOXNSdm9RcVczcTZtRlAwUXZjbVUxblYrUlNQ?=
 =?utf-8?B?eFFrWWZEK05pMnMwRjZYMzFMcWRCc0J4bGtmY3BsVDc3VXJCMW1WSEp4NnIz?=
 =?utf-8?B?VTNoQjVpR3pzc3dCSGhnOFNoQjJiY1RJWVZVNEUyU3JmNzRKT0F2cmxpcis0?=
 =?utf-8?B?WXk2U3VySVBwU1I0MThCWTNCa1RaWm9lbFVsWmQwdkJXQzlGTmZZc2RhY2ZT?=
 =?utf-8?B?bjFGMUR3cDdkWVBEWEppOHZPWU4vMWNBUkljOExHWStjd2w2M0ZxOEo1bkZk?=
 =?utf-8?B?MVNYcGFCTDdMZ0p5TFBUYW5kMW1tcDRzRkFSemVBdG11eGp2Y2VkcUpDSW92?=
 =?utf-8?B?ZEx4blhCOVRGTURXWUV2bDBZd2dkZ2l1c3hPbDlsOWp3SGNoOVFDUVNNZlIw?=
 =?utf-8?B?bWtnbjJlM2FRNlRvdS9MbEcwYURYSTF4L1JYRVlWRlhWeXlKOWNadHowSGI0?=
 =?utf-8?B?YjVDQk5JUXlRL1ArNzhOQnd3ZWFMMGFqT0lzQXcwY1BaNDlLV0dobmNqc3J2?=
 =?utf-8?B?N0YyWWRzZjZ2eXN3SW92bWJMaDcxN1JUY1J1ODd1YStDSGFTR1g1dXp3Qzhs?=
 =?utf-8?B?azJZUFh0VEsreXIxY2J1eW9CRW1EeCt1RnpsV241Y1lmUUFrZHova2FsczlC?=
 =?utf-8?B?dlBzWWd2SlFzZ01iQ0JPUXRtZGJ3NVV5K0NEMVR1aXVVV00xdFAzOTdXYzVU?=
 =?utf-8?B?NjF3eFd2U01XdHlWU0JNZnN1QVRHK2NOSEpDUkRWODlZcnZOdmpFaDJSKzln?=
 =?utf-8?B?NDdyZkNFaFFQTEh1QStSN0haUy93U2JWVkFWYld6citYVUlMNzhCdjhLN0t6?=
 =?utf-8?B?bUN5WDJjZFAwbUpSY2IvY0wwaFJaTnpJenNFeUpybUEvN3J2eHZ3N3ZWblFG?=
 =?utf-8?B?RGd2dC9zV3liRktjRFVRUWRYNWd0R1VYNTBmV0M0YXgxTTVjVTVKSFR6aThk?=
 =?utf-8?B?V2prL2p5ZCtVR091RjFFSml0YTg5QlUzSjlER0pYalVnNWVuNHVUbm1iL29B?=
 =?utf-8?B?TDA4RW5uR2hUMlVRUlUwb21Ka3BZTGt0a0grM244RW5FQ1pWWGZwUTNWdjcx?=
 =?utf-8?B?RUFkSGNYeWE1SnVsSVNlVTEyVEFLNFgzdklOaStiOS9NRDl1RkJxd3R1TDFU?=
 =?utf-8?B?WGZZRmo3ZnFoL0VRR0hVTUNzNkRodXFkWmt0aEJESm1IVVJtaUdVWC9EUjNE?=
 =?utf-8?B?SzNLK2NGOVNYdkpaa3hkNDdpeFZ5RzZSa0ppVms2bXZkeU9zME9hd1c2bWVn?=
 =?utf-8?B?akdvYlBvWHpkVVM5SlpXc2E4MkZxOGtNamVYRWNRUEgxTkFMaG00SVBoTGxO?=
 =?utf-8?B?ZTRSYXJlNG9XWnlPZ2RkczlNcGhvajRCMFplVUxvdmdMaGw1ZDRzRzM3K2FB?=
 =?utf-8?B?czRMVXYrR0dwNDdqQnFUaWc4Q1RJeVpacXppQ1g3RXdsQzFWeFhwOTlwVVBQ?=
 =?utf-8?B?UEtOazN2M3Z5aEZLdjdTb0VmSlR2bVNBMmRhWGZSd3I1Z2laSmVOb01Kdjgw?=
 =?utf-8?B?WUJYV2J5VDVPMHAxaU9BelB3R1R5YnRpbTgzN1pjTUV3YTI3d1YrMTZMdDlI?=
 =?utf-8?B?S3pTcnRBazRtYjhsYm9MWkFidXFGWXdWTElaSHh4MW9aTHBNUGVxclRkdTZI?=
 =?utf-8?Q?vDMb2/rBgXgERP3AjrXnuD480?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f629f65-9977-4305-23ea-08db8378592d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:31.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgckOsaNr6/uPQhFXpvEttvE85IVt/77et5ffb/6D/JPI/l+JsRndPGOObDXE5/8yc4cBdC5WK9oL4595QbV4g==
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
 drivers/mmc/host/davinci_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 7138dfa065bf..0a08b85e35b0 100644
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

