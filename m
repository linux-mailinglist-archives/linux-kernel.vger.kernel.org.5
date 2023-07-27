Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEBE7647A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjG0HE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjG0HEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::700])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0263435A9;
        Thu, 27 Jul 2023 00:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKaFGLFwzVmtpL6ek/Z1GEoNnP1dytgJ4yYWk38GmwoPlNlaD+Y3dBp/Xt/5ND+TA+3rAWlegGeBGISmIKpY/qjA/zVZuWeWb6jIKCQmSvqIZXz3qVdEj2924qQxqULT0dXelt2gCLIPeYR/vaOaa2gQkGMNJKDmYn1jyfNQ1+HarhkPjf+4dIf5qAvuv7YYvI/yqFypfTjPlt0tLOzskmVRYFpC5F0J7mmmlWIeqCdiJMXtBPb0wxTQQU3vU56U5XNRKiVy9++Lg2KFJA++yOAloVnZEYPYo+FQ/fbnPnwmoX2wfqbPMKbneFGc6Ki8ipP30AkERkIgH2nKEMHuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dtSozXRpKhBSknQ+s8s/18Y8o9VbBvC6Adg572ej9s=;
 b=Ze8s9YTJDVAcT9F8S3lKLvFlN4BD1uQDqmLvaJirXroB5ZToviLE3pCnVSucdnRFjWBxkMZoloe8sReBxngleLbJAfn5GKmObzk6IzT2QlMUZRdtkqi2x/hMLI8/t3FQXDEvOTaTCYhtsSE8kV9arcK0u81+xMEFrkFbgFPAFZEyIuHXgIyYnOZZ7jH3+J842FX3x0NM8HL65gQty8KoA8Fafl3JUEmHZS8gN/pLjv2x3HlEgKEY85ASzL6qS2CWK/RbfQOoh8cy8aWREi2c3DkOVDEyfzRAiMXG8xhCQkHKVMZ4PGLn2MmPCr2/uexqDh69h6GBk/rayJ0k6GTvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dtSozXRpKhBSknQ+s8s/18Y8o9VbBvC6Adg572ej9s=;
 b=o4ww/8idn4fZeNcS6w2D1nrVz3mZzQxkNKFxNZTd/5snV66QFD2LoXf4WvFPafCzpnkkHyZdXMl5ZZ2rPvdMkaw1ozdExYoSec/mmerwxRJdWt21bWykOtV64e2WhaD1QAFWPTMieqPcJ7H4TRCsz54KTO6WPGJbSfcSIPgXzQtn7Prh9kL5L/NDan2zWc8YUKltNeki7Ig4m4+JJ8DxHutBJ7MfKy8OTUsXeY8KTphWwI0E3oVmgiORvPvTunkuxJSSvxYWesqvIW4CYUDsb8MAqXd0c1F9Ea+oyWrK/KOe+HP4LpN+++yEmWZvG/Cy6UQHrt0kSJrui2rh6h/yIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 29/62] mmc: pxamci: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:18 +0800
Message-Id: <20230727070051.17778-29-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2172ce7f-8f20-4e83-3818-08db8e6f5985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uR0C6So0XWwJZCrHKyer+wHkY86vKSNfCC4iGtu5gFDGqyvc+DdOHhphBJFivqsfjggE1x4pMaHj3+A+7/0b/fgNVzMqa0XiFZ+Isrbjew0Y0YM0bSLxOdYgknc00anXklGeYdOUDsEFuPBwFFSRSZPgJfBtZoRVlu+5vqf8uP+HDORluFPl2vg+VgcTdZ9lOB2NdGLzTqesTtToA2bqKXIMHKJvC6D+3FORhaSeydcN1AZTkMMl1wL89GiHR0dAoxVQ3jONNZyVejIuWUMV6bbps8C6bN1a7zvxapIJ5c7oAusi/G3V4yg5puBvnYxcArYojSbATX5bueQp4gcICPjwU2d8jldk54XIxfzdg3Sh3gC0oibp2mEsqQ6IZfaC4dcCSbBH4oPvqvEZwm8L7kkgiKQt9tKRESK7iIbQ7AWbfaWSvD2wos/QC2zW5kfzYpNLjP6yHP+Q1xirEKqSVU19LKxALmSIqyaQwvc6kxoLn7shpyCHBebg2jtz+05uSasZz5ZMHBudYPALcJv08PAZADT1o3xXklQM6Tiv5N/3BF1B2F7JZL+JxQQuHjoQIvF6M+2WgaOpums7SsNxXy/JMzMW82C7b096urpqYyapsppaOjTDAIt5Eqw7CLgY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(6916009)(8936002)(52116002)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFBtZHNhc09oRmVDUm16UWFudGVlV2lhL2xseHpDZTljMW1GRWwzOHg2NFRw?=
 =?utf-8?B?eEdVZHJwVzR5Q1NYYzRyMzhhRFZ1Y2hQdjBzMG8xcEI3QVptb3BUdGFxdkdt?=
 =?utf-8?B?NWdpLzdpMk1QTjlUWHQ5bDQ4N3NyazBOdlpVcnl4NXIvVkhyRE13d0M3cVpi?=
 =?utf-8?B?bGdsSmNTRWRLUlQvcjJ4YkFNWHNtMndMcVRvZ2lUOFBtZkdvczRCMlFWaU1a?=
 =?utf-8?B?NzdWaDBsNjZkMWh0aVAxT3BKOVM5emdFL3JHUmwrZWx6aXNUOWhwZ2J4M1Iw?=
 =?utf-8?B?VzhaOXFnUkp5MWVTSk4zYlYrZk9kSVpGOHRTWnpXZEVmWGhIUC9WbDFxRW1w?=
 =?utf-8?B?Wiswb0FOQlRPVXhOY29RSnYwNk4zcUJsMkJHZjJmWDY2M0w1VU4wajJicFJ2?=
 =?utf-8?B?TFpqb3ZoTTl6KzVmd0x4U2k4Z0k0ZndNRDlXRUVsOUY5TWIwdTlOUXBWdE1N?=
 =?utf-8?B?bmFZQkcyS3ZKTVFnaWtoMG5TNFk5YjNGUndzZkxyU0VCdjZaOVFDNDdleHpy?=
 =?utf-8?B?RW9RcGpTRmtWUmU4SnNaV3htU2RkNXFucWVUWi9zN01ETEhrVVFmcVB5WG1R?=
 =?utf-8?B?Z3RMOEYwT3l4ZTc4UGFxRVBXSmVnVHBBUTEvb251YVNNRXVHa0lKTDUyanpl?=
 =?utf-8?B?c1FlT21EK3ZuOUg3dnE3TWFDQ3huZHNmUmRTVFFEVXBvbktKK2pTVCsrU3Z3?=
 =?utf-8?B?OFREeUxFa3dPNldubE40TnhpSDZqZWo3REdqaGJ6YjE4MnhDdFlsNGMvR29s?=
 =?utf-8?B?cXUraDdYbXhPMUZ2cHRKa1ZDc3BmSUcxNWZaVWNwSlQzbnVSbWg2cFRad3Nj?=
 =?utf-8?B?QjdmdE1zNmdJRDZoK094N2grUjNLVk5HWllVSXVHQlJPc3BGRHUrb0svQTZZ?=
 =?utf-8?B?S2VrTE5PdjVkSk5wYmRDb3l6Vmcxc1FxYnFHUWF0UTJEbkpFWHZNbWV5c0c0?=
 =?utf-8?B?Zk1hbVdjTUd1Snk4TkdIZzZnSVJGM0dZOHRTWWdLN1FVVTBqK1dnSWdNUEts?=
 =?utf-8?B?T1BYaS9kSU8vakxPcjRVUzVZaGRzVGpjcjVZUlVVb00ybUNVdHVFbkVVVlJW?=
 =?utf-8?B?VW9RS2h6N2VnK1ZTeDJlNFBtTVFIeXNPTk52MElMeTR3ZFVFdWd1aDdxREEz?=
 =?utf-8?B?YWMrZjQ2WUVWbFNXMmw5TFlRcWhPaldPakxsdmlEWVdyZUpSVjhSRHFaUFBv?=
 =?utf-8?B?YVdNTDR1SG12SXhBQVZvWEU1Nzl6WWNCZEErVlVBV2JhNER0RUJNUTl6M0xZ?=
 =?utf-8?B?L2MxNWNZOUc4ODV0NFdWRzdQT1Z4ZllVb05KdGkyYTYvNWF4a3MrNm1PQWk5?=
 =?utf-8?B?VnF0bkxWL0Fmd24wZGZFTEttT0VMa04ydXJzT3ZaY2xaT2Q4dmxkaGd6S1pW?=
 =?utf-8?B?eVdTelFHdUNTREJPRlluS1B4MmpKZCtmYm55dUtGeFg3YU42bm8zOUd4L01I?=
 =?utf-8?B?bk45Mm1JSHdXL2lTNnpxd2wrWkwwUEpBWFRKZmptY0kvOU5iaXdSSE1DMXdX?=
 =?utf-8?B?NUlQY2pQeStwWXZaYlBsbHcxNHJKQjFsZ1NZdjRDWU90L3YwTUwzYU1VbWdW?=
 =?utf-8?B?bVpFQllmRFdjYm9HeGF5OG5kVzY5NnNHdjlIUlBIdUYrR1plcVJoV2FGbEd5?=
 =?utf-8?B?VjRFdTJEb0tWZFU4blRTbGhJOFU4T0xmWGhOYnRYZG5ZWTZ6Mm1DS2d2eTZJ?=
 =?utf-8?B?SjlXaHBIRk8rOU50dG5pK00rR2VBREkyejdWTnNSRENGc0hUdkFEb05QWW5C?=
 =?utf-8?B?NGNRbjh6akVENVZNMklzN1FGOHUvUHhoV3lWRG5qRDduQWRXcm5jbTVPSEUv?=
 =?utf-8?B?cTZPbUhweEJiN1lRYUJ0REFuYkgzeXFwZENuREcxajZIR0g1Q0t6VDkrVDl3?=
 =?utf-8?B?Mk5Da2w1V3Y5cU9kdEhBRi9zazYwUXJjSzF6T09DMEFpVXRsUC8xUHUwRjlo?=
 =?utf-8?B?NFdkWDlCclg5dFIzaFkydFlZbjNZNFd5eHV6dUxYR0FmdEFSaTlMcjZRZk56?=
 =?utf-8?B?eDMxQk1wcnhnc3NXcmw0b3dtREtwbVdzckVKVEY5a0F3ZXMwaGlFVHYycHdu?=
 =?utf-8?B?V2czN09KNVJOWFBwUnBWR205UzZCTlkrNFo3VlVXMWs3NmV0T2dOU0NjVHhk?=
 =?utf-8?Q?qY4TasD4qmyB5wucwQvWj697G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2172ce7f-8f20-4e83-3818-08db8e6f5985
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:49.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlkYbRHWb9hdqYaoU0HGrz7Rwxq7ug5pMiMAthsESv9E0NoKW4cBFiPUx9bkF6FInmqX+OYfgVnxGWl/TJCuVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
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
 drivers/mmc/host/pxamci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 1142cd2368f6..e44c8ff6b303 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -783,7 +783,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pxamci_remove(struct platform_device *pdev)
+static void pxamci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
@@ -807,13 +807,11 @@ static int pxamci_remove(struct platform_device *pdev)
 
 		mmc_free_host(mmc);
 	}
-
-	return 0;
 }
 
 static struct platform_driver pxamci_driver = {
 	.probe		= pxamci_probe,
-	.remove		= pxamci_remove,
+	.remove_new	= pxamci_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

