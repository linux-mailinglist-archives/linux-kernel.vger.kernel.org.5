Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07EF764797
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjG0HEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjG0HDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:03:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0352D6A;
        Thu, 27 Jul 2023 00:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNcvX0mgVEt5/N4rV8GERdAzkKB8iX3K3GP4OtKhsvh3Lv2q3vsJXgYcCFkEHj3kjSr95sxMy/0WMNjpzQua6dryXVG5e/9O4Uo43zmkKVRZL4gagyYmEOyaJ84Y5m2PQT44qjk4z42YAfVEDajwWwQJDZ7Z9WWQsO/RK91/vDJXTmY+rLYB/NzH0nlw4gae4hwax/BiNySAvBOBkbEIJ1ODLabGo+qmQKrPoB6QqDw03RmKqDrHjeAMdA55zDM/vGSzQP4t8fzcFJfP6jETAQji1L3ZArKTPTENxPhBpToJHVBPCAb7VWmaptshqNWueq2z8zE6l+YPEAyJ8GOVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+CTem6dHExq17DY+SzLyRt98v7BugU2JDEv1g8WLeI=;
 b=CxrAIiY6VWLLs6pbQ7YA5t338yj9hsSMLn0c1r1gZI77BMTb2sepH48D2tvYwMKZ5EYO0N2gffv8wc9yCpUrCV84Ev8u3qbbnyWG9TKbEdwl3O75sqd6s0RiKsaZaLtmB03rkN2vhzFS0JW2rX2sA71aCAOmRfkxhTN/6KdBOvckHq+AzCuAjWynUtj8+pJfd9UgPY/tnkhfgPcWOaWNfwQPGH4EehNW9VbMsUAIco+9y6muO+S72aNWx4JSjawF6VTnJsS3+nWtoX+fxTmAgk4w2MShg6UsT/UffsWsM8i2V5WMtKC/YuYzuj54wZlrbxM3O83tf4ptXcVeuYEalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+CTem6dHExq17DY+SzLyRt98v7BugU2JDEv1g8WLeI=;
 b=LHUi29VB7/HApOCl6GTXVIUa4PtG+aKZFbXAY4RXtSYdlE+RFOZTez196R6U/qJJa9YxE/H1jbx5qYmqvqsDSoAcTF6+RsQy7arwm1whzacT0sjRkbqUnTKoyLbrOw05aeYCZfSXe62vFnagvs8urbnCS61Wy6azMqZ4YqNaj7nBY6H4PvZK90GSZSuvcFelFR8qI28LaTEn6GqNOHjgGAHYEQlN9isFcbU5h5BW59JyqFcK6ij0Lo+GyrCnThS6H6zqg3cmVm5BSlCPeFvqgQ4kM/3UUOzIJ1V67TZiJNovk9YNOznq2fQ+TjPqTuBxThLKbo1X8cqKkVURnX8LoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/62] mmc: sh_mmcif: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:07 +0800
Message-Id: <20230727070051.17778-18-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 74071265-3901-4a77-f30d-08db8e6f4e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbVKWs5pZ6IKrDe8aF+VH7uVXQKumDYIL3XA0ffTeIzxjmFsXEisHXsPF1MYGIr/jK4dQHGYMO6K93RQO3OQ17uPXwjiRZMT5IWTLNs636GYbW2vOuvZrYF1SIhHnXAUDVvybuQG92guaG5DM8DciNr7issKtJvj9pDibk8EUGuAlbHiNqmAFGargJmFDiUVYO4c6ETg2INogk4ElbkgE20BYZtrEPvnsN+otCYZ6qw6PzBRXuZhVuGmok7YeTdBkw8WBIvllAa/4F1Q1/PyBwuhCMfcaq3KBB+HdYdc951BZYSmMscWR1eGgyflHfeZySmaMEVNegC7zB2y/UQnpwYWiau8bc52GT3PpSHB9VN4MbGocG4yNVGzNlsBB1jYmrrW8vtFN6huKy5EI6rbtmmTt8kxnWNBvrclsdbAkmkNDesRRjl/M+8CtqO45r+SbWPeewlT6w8BBqjJwwG6JmDeQY5YfKvIoJpSshJmFFSs3/pQlJWCppd9fjknsVmMJg7vdm0i3bGe4SbO7bInGKuigYJkif93FhIeAwCXyo/trDsnVQ4F/3xd+jYYM25CRWm042h8RddpacnzLxr8VMYz2BRtk0BVN9pd7mqkidQDiaPFmnKlCw7vE9ZiLEiW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(6916009)(4326008)(316002)(54906003)(66476007)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUoxS2ZmTlRaRDdWem5xdU95WnRRSmJYNXBpdWJraGxaYWhFZ3VnTWE5NTdH?=
 =?utf-8?B?b1p3NnNKNnFsUDZDZ1RqVFRLeVo3R3pCaUlocHpjSklOaUtMZ3pzZFhYMG4z?=
 =?utf-8?B?b3pQeU0yVlN2cldJTThxZG1Ocm4xckpGVDk2ei9KWmxLRmk3dW9la3BNM1Ny?=
 =?utf-8?B?SUEzZ1BwV0lIQUh1ZHdlZDlIRVdHL2tXZDN3S0NOZ3JDWDhWRGprUm9BM1J2?=
 =?utf-8?B?OFdGK3BFcUwyY0FJRzVVTVlHbmlKNkYyK1hyRjRrM2hWRjBleXoza2lnaGpP?=
 =?utf-8?B?ckVyMWJ2MEYyOG5iVjRmT2MxUjdmMmNVcG1Xd29xZ3YrUXhiejFXRXF6ekJJ?=
 =?utf-8?B?VENRM0tkT3BmQmFVUTNmTFZnWHRwcHdsNFhVK1Z0a3kwdmdGdHJ4YUdmSDhQ?=
 =?utf-8?B?TG1JZWpWUk9hRzZkaXlxNVNrMDlYZ3R4SnVnS1FrZzJrVU1kZ0lmVkdBbDJs?=
 =?utf-8?B?aEVFR2U1SVMycis5cS9MRU4zR0ZicGQ3M1ZwODVFNC9WN25XY1BpSTFtYm1H?=
 =?utf-8?B?bWdOdXNIa2FZSXRJZ2x6aWowUkEwVG5VZXRBSjlBWlUzWXo4aFdkYWI1QmFO?=
 =?utf-8?B?RXZMOXE0UVJkOW4zbThLcFVMeGpYd2hudzlBOHMrREFOVHFTT1JaQ2QxcU1q?=
 =?utf-8?B?UnplNXhXWlVVbHEyYTVsVGZxcWo2VTNQTVhHMFhUaTE1VlIzL28rTEVMMGFV?=
 =?utf-8?B?UzZycHNwLzdoVG5HNVZBd1hmQmNTcUQvTVIvem5CNHp0d28vNFVITEFxdkNJ?=
 =?utf-8?B?dGdENTVFMkdXVVdNOXVkK0k4WWpmWlFJQ1IrVDIvWE9hT3orMDc2c0UweWJZ?=
 =?utf-8?B?UnJmSncyRDlEVFVxSVAvTGx4KzZyVWRITDdVS2NkOFdpVlZNTE1yWncwV3hI?=
 =?utf-8?B?ZVFJY3B5b3VXMldvbHcrZ1luYTIrVzY0dXcwRVVGQVlDZ2hUZ0poR09tQ3ZV?=
 =?utf-8?B?bG90S1o0RHAwMkxmYVNyRGNYOU9xTlowUmhWUHFWMnA1M0FTSXR6N0pOL1Fz?=
 =?utf-8?B?MmxWTHVVL1R3MHc4MDJiYllCdHR2Q2NxaXpob041TmNRWi9jSnNRd1F1b1Vl?=
 =?utf-8?B?YldnQzE4SVVHdDNtcEJyc1ZxQ3ZhZ0xESzFuNzNLS2xIL0lmVytoZzRMUUc3?=
 =?utf-8?B?KzVmakNxNkNlQjlFN2pMang4b0ZzVWYvZ1pDVzkxQzAwU0hmQ3huelUvMkVI?=
 =?utf-8?B?UUwwWHQ1M05DZUZXWkp6RHQrblVZaXlJM0RmMHJrakR3aHFKK2tTSVB1ZFlG?=
 =?utf-8?B?cGJTdDFyMFNjM29mMlRhVUUvS09ibWhUb2pLeHRkbmd0QTMxUUtBYzlNWUlZ?=
 =?utf-8?B?V0huNjdCU3pwOURrVHc1MmhYYzV5R0ZoaFVkclhRNlZFaXZHNDlLL3ZGK1RW?=
 =?utf-8?B?cVRLZkVwY2ZTSmVqUmFiTmpYQ3hKT04wMC9rd2F6QUNUSWJnRUdMUHdSblU0?=
 =?utf-8?B?ajBTQk56MlJ1SlZEQ3QrM0pGUDlPTitaK2p2Mk1VblltaDg0OUFFeHEvZ21T?=
 =?utf-8?B?bFVqL3Z4MVcrOWdBVkdNK2ZtbVVFazJBZGpiQkVOK0d1cDhEdDhPTmFhYmc2?=
 =?utf-8?B?dDAwQVRIWWJFUWFBeFEwLyt5djg0cHR3MWpVa0wvNzQ4dTlna25uOWhza09l?=
 =?utf-8?B?YjhCOWUwaWsrczU5L0pWMmFIbHdaanlQY3dRSlhkOGorMUNNdmwzRDBVRjVx?=
 =?utf-8?B?NWhMbXFjSWJuejMvS29mTHZ1b0NuZkxlaVRwZXdVTlhQb2xlNSt6STF2YUxo?=
 =?utf-8?B?S2tLYlBsUFBlNEYwYmVNcUY1RGRKU1ZWWWpnb2s3di9oL3NHRWNxcUFhWndp?=
 =?utf-8?B?RWlJTCtiMjBXdHFYNHFmSTJYYjU3WFMxSnhEQjUzTTZ4SXhXejJGOUFqUXcx?=
 =?utf-8?B?QU1xVkJkd2Y1TjEzNHYxWmwxRDJnem9NREFrdmFEbm9tb2gyVlpEekF4U2dO?=
 =?utf-8?B?aTFhamdPOHpPQkpGM1dYTjRXaUhpRnJjcTBXdkkwV21nZ2ZRd21vdEk3VjVS?=
 =?utf-8?B?SkdyK3o4aVQ4MWNGSk13QlZ0S0UrUDlDUm5iUzhaZDBmUE9xaTEyb2Z1YWJC?=
 =?utf-8?B?UlpLbkhmSmcrMkg2RWU1Vkp6MFAvTGhrOFRQZUk2SkZyaDljcGExZlRSYnhk?=
 =?utf-8?Q?Q3Pv5jDKw8v3xgSQFwWwfRglW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74071265-3901-4a77-f30d-08db8e6f4e72
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:31.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utOJFE2mYMHUXa5w7fl4/RhJGj3nEB5u2sXw0jZOqGF81Z9sxUAe3b+yDcyuenjrRM9JMorWD1MUUJZM4t/iXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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

