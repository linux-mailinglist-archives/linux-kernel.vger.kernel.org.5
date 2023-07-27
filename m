Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0519764801
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjG0HLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjG0HKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:10:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20725.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF64EDE;
        Thu, 27 Jul 2023 00:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlF5YNQxPC0GvMlvQDcAamdkGso8OgjWxBTOAQtIY4GzmTTji49R6muBCho0L92NAZ/1hC1G85pQBvYAGjY9fLlKw4EZqaXVinebvrnxfA/RyQmlc49BPCtGTPvJ3kbfylN+glwfwagOcrhuhDRzfAC52358nMJP5tBxiG00u6CCAfFH/8QCRe3dVDppaitDsBHbjXmo4QIrHhZTOgDdOCOur6CCGmn3uH3CE1v7LAYJ7SbtAGVpNcLpNf0pvzCpzbaZuPF6fz9JeByOZHqUryZwsH+Jh9emNcOrb/wm8c/MCENo3L4zJswkmZPSAoGfGdcXP8YVQXy9T9MlctEvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPnrvKCQGrGsesSBC854cGT5go4mKOa3EElli0C165Q=;
 b=VhSQNRYXGkfTfzb3o7Kpg2D2cf2G83p75Opz8vWHx2e2N4rNWQSWEFv9R1B6QHxArpiN0a8b5BPcbP8l6Grfn4j5G1qup0dWQVezLfqR872IxY73pMy38WcG5cGhbiQJ9qWDm0az8KbK59EgURh5lGhb9f9LiW7Z8iR50I7sdcuPaw1pV9Nvl4y0rfhfr+GtGapE3XqipY9xge+cdo4YQYY+8HDmJ3u6KOXF6hm7o6pZjkHqw13CEzA8P1TeUFWEorABHgx+83McN1u8IHM82A2sQOOAHns91IZ7rsz5rhAmlMED7nfm1FHdL+EBNE0RyPNm6MR37th5bte2lNk9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPnrvKCQGrGsesSBC854cGT5go4mKOa3EElli0C165Q=;
 b=BoY6FuRZAOdca1DtGORzXiBv9ys0pOljZ73sVn3yw8oHhhw/qXjy0II4Cxyznq5vMdW37/6bS2NUlF4pdCGSlYh/NuhaScMiu2RVppbbMTDpOeV6FqyHdwtjcadzLQQ9OkrdbJVTPkV3MeDfphAdXLVlgkeLUdoOoNhxnBHTBTPx1FUAe0EvUYQK1VrW5veL/fr+JLHIL28mAlGSphpEa0tmmUX1CfWIgWISfEfbcppfdm3Va6atNaVFnka0ekLEbNPgv1oe03ZFDoBlQArLd1gqhffLfCvDrB/8RpGWdt3v+0kKsOtkEy7ZzHTKHkFD8DN1Y9CBMadJeJQcDbAozg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 51/62] mmc: mxcmmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:40 +0800
Message-Id: <20230727070051.17778-51-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 9639d4bd-6a0e-4ac0-74a4-08db8e6f7068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sY5403S8SmMp+vCGdB4C4Yy9apx2NX+bLU/Gcz5s60YdremJFXKRNY6hsI6DA9VjYaLoZ07QMaUfyJhYpRjBJC0qipjEIC7qQxcc3i2+6nG+lXxJUiBDUhCNKQ0nkDLQDTKD96kJ11vuCNRtx9uvtroglK7RUBYRe0rw6sjYGBeOhfNORk59x8uef0IBq4AfGp8bh7pwM7pTmjVckQqMdfDGuPtrGybgEoDjhjz0Mhby19cNBmEjZwxYmq8kCH43rtF3KTCPvi2GUWXh9HHeesbQvRJwyqU3bcROtM7b89u38ronomQjkO/vG6BEoF3+q/jn1iCvTTsi4Bno6D0m9QqYipvISHWg/HdaiCpUIgrd4P/xEL3Zhe44jEBgdeUxhjrvTO8NJCVT4SOtkTBbf6Vhipdg7Ve80DU2K6SMM9URs9w0lqRxoR/lW6L7hsgCQ6+3ldX/py5ZY8N5Wu3evUxOopcW7RlFczzPsPbNMFipU3Z7zqbxUxpL45b5bxqN/JtY4YVmMWqRPNhFLg017OQtpO1+Hk8k7Oe8sTsqNs83ba2Jb9pm1bXmQziWXgwkydIfSNUHu0E67exEFcKxuompuItnLYLukF5Ea2pLjPoIV6G9ih868Xv6fMxXuFzZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6666004)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66574015)(66946007)(8676002)(6916009)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9JaGp2VjkzNEM1ejBRcUV5aVpxMVUwT1FuellOcnJMSzAxbTJSZzRHeUlG?=
 =?utf-8?B?VUF6WWIrUUVLOVdrNGkxbFRVelZUTjgyMUZ6R2IxdFdjMlNUdW50TDZJUkJp?=
 =?utf-8?B?STlHZHJEcXNRNW9kYW9tVVJ6TTdFdnRuS0VUVmROVXdKdDNxL0tHcEJvWmdi?=
 =?utf-8?B?cGp3VUVKekNYbXBuZzQ3eGhmNDgzNWJpRWx0RjRKWjZJTWdkVGExMGk4L2tZ?=
 =?utf-8?B?QkZPNXFtMGNKWjcvVTlOaFNVWnBwckRPOGFwQXZaV3NLNk90dWM1WUU3VEFn?=
 =?utf-8?B?bXlVVVJ1RTlwUkY5Z3dvVExJd1dhOGszbW9FZDdUVXJ4UC80ZjVIKzBsenFP?=
 =?utf-8?B?VHlldE83a3c2SkJMMkNPMlRMRWNGQ01pWWNVbXpUcXJBaXRBakpwODFEVjZ3?=
 =?utf-8?B?b1M5NUdjejhvS2IyY2xPalVmbjV0dTV5dFluNGE0WEdmVE9ybjJMaWlxcmFj?=
 =?utf-8?B?ZUl3L2Vsc28vVjhjNjdJazRuU0xPZThIRWZYNDNYcnM4MDdPSllDeTFXMmZQ?=
 =?utf-8?B?Q1NqeklUamdEVzJZRHdxeEs3VExIemdCUjNaYjMxbzNJVFNjVlZkWHZsNjdY?=
 =?utf-8?B?Y2lpZ3oyWWhsQ21uUVN3YnJIYzdqZkFzMW5yYzNTOXpGaVF0bnA3V3hJZWhs?=
 =?utf-8?B?dHJTUEtoR3N3TXFNTVVOUkpWOTQ5SmlhVzZtcVd0ZGQrV1UrejA5K0wvaU5Y?=
 =?utf-8?B?SUc4L2N0WUx6QkVnbkRDanp6Y0tvYnJwT21wRkZTUmlpWFVzWTdtNFFxanBi?=
 =?utf-8?B?MmVOQnh1U1NJa0ovQWxIaTRsVC9GTkFUZWJoaGxyTEE3MjVPVERjelRxNDNK?=
 =?utf-8?B?cHhiMnB0Ni8xZ2RHa0EyT1ZZdmJ1dFgzUXRZS0J3c0g3dTR0VUpYSmYvekNG?=
 =?utf-8?B?ZmZPbE14TitzWVh3RG14ZXRJZ2s0MFpNYW1YSlU4ckFvWGlLTUpiU2JOa2c2?=
 =?utf-8?B?eEpmUmlyRElHVk5jSnZvVTNsei9OVklJQ1dTOE9BdHI1czZtWFF6eGRKKzZy?=
 =?utf-8?B?SG1LR3I1bUNiRVlzZWNkL3Bab0dUQnRVbDVEZnp2MG9NS0JIMmVUKytKeU9K?=
 =?utf-8?B?VWFDMk96b0VoTmlqMzd0RTBhU3VJc0cwNFhYS09mM1RiUlFzRGpvMkxlMzRj?=
 =?utf-8?B?Z3pnMUx6OXk3TDdFNzR3Q095UkQ3Q3JvVEFwZzVDcUtHd2NMUkI0NWt1alFL?=
 =?utf-8?B?T2xBeitQYWFWcy9aZ2tkN0JINnRqZE8yOHc0QUsyYTlCWkg1djVaOTRheFMx?=
 =?utf-8?B?K2d1T3VqWXBZbDRLRDZxVmZJa2lpS01hNkhreDk0THRyc01YOUx0bjVmaG5t?=
 =?utf-8?B?RTJhelpWUjdSZEFDMWk1THhqVnY1dnk1SlY2TFpac0xQVnpYVU5mQm1OektW?=
 =?utf-8?B?R1RLZ2tIWE05ODM2dklGSGkzQS9qNFhpZk56ME1HQ1VhazVCVThFOEZ3bktJ?=
 =?utf-8?B?cGJPRXIya2lCcXk2R3dQWTU4U2RDVFV1RktmTnVvRnlRc2JmandJS2F2YW41?=
 =?utf-8?B?RXpDUW9xRE1rMWhQVzhhU0dzRlliR0dsWWNtb28xdHA0RVNhRW0xeWpZdnZB?=
 =?utf-8?B?T21XZCtXNmdEcXFQUll5MElQSnNXZTUrWkJVelg2SllDbTJucXV5M1BsQkhp?=
 =?utf-8?B?NFRocFlab1NrS2FlRmJlWWwrbWgwMzZ5TGhRMkVKdW5HdHJ5bWdkM1daclg5?=
 =?utf-8?B?WC9xZU5JL1FHaUNvN2NYY2pxL1JyNU9FeUdlQUN5djBXaFZ4emViaFNURy8v?=
 =?utf-8?B?S0NXaDY0VGZGbDlRNTRXY2crYnAvRVZhd2ZYWW9zRVRlUk5XRjMyS0lGdlRt?=
 =?utf-8?B?OWhWK0xyU3l5RkZXa0ZwNkt0THBoV3FQZjZ1dm9QTmZkQjFUNmtuTzhicWEx?=
 =?utf-8?B?dGV3Mm5YUVRoZndYNDFuQU92ZnEzdnA1TGNZMDVCVTZiZnVtVnZSSVlDYWRE?=
 =?utf-8?B?WG9pbVBzSlNJVGFqZHNLbW9wSHByRjIwTkdRZGRQR0xueXEzS1NKa3NFQzJX?=
 =?utf-8?B?cmdFS3pTbG5KS2tMR2owMldtMFB2SUxkbGVIU3hIVHhTZmtDMWIwWW1xMld5?=
 =?utf-8?B?SXpwVCt2RWprb1lLb1B2bjVvS1Z0emxSOFRDSVNiZ2g5ZG9kYUFFd3hhQ3Q4?=
 =?utf-8?Q?CGRAEzpD5mfHyp782fGgHI5Py?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9639d4bd-6a0e-4ac0-74a4-08db8e6f7068
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:28.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pkxKm7GEoyF8IMb2ZG0tLBflWzwdkW4S9Ldjx+S0CUb5Kf8OtG6pKcBWpdR2t7YfqccVSxd+YwvQwxXLfJtGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mmc/host/mxcmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index f3a72569dd1a..133127e45b81 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1163,7 +1163,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxcmci_remove(struct platform_device *pdev)
+static void mxcmci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct mxcmci_host *host = mmc_priv(mmc);
@@ -1180,8 +1180,6 @@ static int mxcmci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->clk_ipg);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static int mxcmci_suspend(struct device *dev)
@@ -1215,7 +1213,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
 
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
-	.remove		= mxcmci_remove,
+	.remove_new	= mxcmci_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

