Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151027629D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGZEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjGZEEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:04:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E534489;
        Tue, 25 Jul 2023 21:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWJVu8xAC6RzhRpnbCRACJtpBIQSF6PaXsqWkd4xsoATwVNBDbRPI1GfSR0R2eCAZ9Hi4Y+G8A672mJ3pOQp1CvZGk3/2mT7ZfKW/ObOtmIPY9GQF6IrP93jgU1jFSHv7azsJVoV5CsJM9M18KrKzB4OVE2mQcDzjHTQ5MILISJm13sgR3K82vaCl1hpmp8FMFwK65w+rTXVh+R3hHtYmaxatdrqHqamAItpxQAyy2rMuoskGKWK+RmI2sGH3D5ET+lyNozYDwTXgPWFVw0cFKpQyyi6XrYwTQptQS1/O9O7HIMJYJGmNbM4HwSYaAFg1K1g96M3BA4KU4zj+A0fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dtSozXRpKhBSknQ+s8s/18Y8o9VbBvC6Adg572ej9s=;
 b=ZKK9miTdXwcWa4gBUXFoN1sl8n9Xt8pEmg/uBzIti3/0Vm+dHwOuesWtPvkpxeTihsZyxoQQiXSzIVxmYwwMl4iq+FJNdWujG5ic+rS3/ktWfOBdqVrdGhbG4mTTUGrhBv0UzZYeXRDX4w0aG+NZ5eEx8hPaaUQZqWvSQI1OLlDBre/DqYgJtyTS37WdmCot7Il7mIQFf+2YeXebDD3QwomyB/RYXVbCusowTm0s4nkA7s/BwYn3at7EIS3plGYAD/+Jj18Dn2Ds6WW6BBQYb7ugBNWfZGTU1IgjUak0T/Wpz2u7m6+25amfakf79AFhWnytE3zPYp0o8G9TqY7F+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dtSozXRpKhBSknQ+s8s/18Y8o9VbBvC6Adg572ej9s=;
 b=GWH0n7atTIMuAi9ObhApCNjqY42Sm1epzATXaIRoPAPuhiUQgYW9yMH2ZrK0Lr1aY8Gf5gSbyWCUUCbHRLoM3XQBnwxpOjilB07zwaZXsJCFkdRHISmoivbAMwR+eoC7MQ2xVcOLUDfwpEzz16XLZH5gjXNB9o03C5YK5P4PWv59GWEen9/cuxA5YFFZ/9MsPQmmxDCQlFSG3/GwCaVS/XFdWtRjtqD3xE/d7qUUxCHyhTQbrPbrsL0Rk0IWXx7aIbW+APElb35L3eHOgVQVY7Ml3AZnf7gG69KyqeBtd+UE46kSpsZcW+Hf05/fE7KMuT0GxnqOkxBflQE0OpD2Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/61] mmc: pxamci: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:10 +0800
Message-Id: <20230726040041.26267-30-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: c05cc003-b61a-464f-0bce-08db8d8d09ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQwZV0OeFfcynpOf/1lvuQFUTu/6nRkiNuiunJDH/b2UQJTWeGiCBbUqJIi8YGHXECIXDhBHkx/Tc3FmBdL6LmP0omCC8JEnvqVmurLW7tJFysyVRgH7CgzfKHtBw0D/gPg9kcpwgCE6/XI/P1mN7KneU0EVXVR88g4LTlC2kv5HpcBcWUJpzJov6198cf3EO8K9aJdXAjipkOg/BLw+Efqigtvaq+qEHWRMdi1z9PeeZ+F/Y1FVBUcK55ddRBAlEnJ/zwc64f3NZANZfLT52uKnho+RAFaa/A4sOcBcHiJOFhoKbu9EUKp0kMbo6gPv+6BY6y7suFYfc69eN7enNBGHl+8yVMrKr5SNTTDy74YreiVd8KKP2QSw78oYG23NpH2iGB9GkoF6zirFB1dchp/wS86w9GqPHR+ElIbDAb2vhoWa+AY2u/WKvby5M9zYbS8GuPzfFQugUNch9LXAUkrRZFdObj80HFj9vg1zY0+DwPFgvqXt06kv507v7RESCenRpyzvXjcsWPds5wPVpPAb6dlotqBLB0mGAYNy1gDDlVCRzpJtY8I4g0btq9ffMp7bi4oEwo0fYiQSBpSVX2mS+qVtTLpPdFJh2LrrcQ+Xgb9y8gap3mC0QwEeTcli
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNtMzI0WE1vMFh0OXJBd1hYd05WUWdqclRZcGtGMkVQVDc5M1NCTHBzOXZE?=
 =?utf-8?B?eGRyb2kyc1g0RENLRytCbTFiT3BOVEluYUR6UlBzN0xvdVo0VmQzVFZwdWFi?=
 =?utf-8?B?b0h6NFg5RnM2cmxYSDlFNFJMSU1xVzFkN1A3RkJ5eFlkY1l0anpHM3V1bHdm?=
 =?utf-8?B?dW9GbklJRElKVFJTT2YzU045ZjFDWkthN1ZwbHJ1MzdmTUZwN0RPaUpvam1v?=
 =?utf-8?B?L1lOQ25uUnYySjZuYkJ1dUVvTzRrQU1hK21KN2UrZXcrYitqWVNxZGVUbGtS?=
 =?utf-8?B?aHVEU0p1T0VhRTJVdmpGNnVXcExrK2wrZFE3NTZROWxnb1NLejY5SGlJbE1K?=
 =?utf-8?B?TUMwcFlOUEN3M0REakwrcmlQNGxyYldOL0Z3bk1BRmFwS3pWLy9HNHordzFx?=
 =?utf-8?B?dzZGK3VQUHNHc2JLa0ZWek1qSXA2REhUb0IwTVZMTFlRWUhzVjVWaGxTbWRK?=
 =?utf-8?B?T1FvUjZWbmFaaXFKT0xZY2s3YzBqdXJiWXVDMm9ZZzlsZVBHVVNyY1FTVEJE?=
 =?utf-8?B?RVhoTVZwb1h2SGNEZTc3U1hraXVmQ0c4ejNIb2JnNDZRQlJtT09uQTRrVSsz?=
 =?utf-8?B?M3RvM3hYY0ZYcU0wODhmRWNoNUZEYzQ4RlNUS3ZqcWVCRFV2N2pDbWh5Mmxm?=
 =?utf-8?B?L05VeDVaSEFYRVFCblFZRUdBelZucU1CZWo4bGNRRzJRa0xuaVVNTWd0dGNP?=
 =?utf-8?B?anFmVXVuQlpQL2hKM3FHZHkwRkNmMmRFenRnd0RaeFpML3ozUEUxWS9ZTXF3?=
 =?utf-8?B?dnJ2RmEvV1VTdUUzVkRwSVYwOTBXcW1jL1RRU1BvZE9PVHk5cjNMNVdPZHU2?=
 =?utf-8?B?VDdjVHVnSjZ4VzVGSzM0aUlkRmpqTlhieWJ6Wk1xazR5QVduZll2UjRKb2sr?=
 =?utf-8?B?WFZyYTVWR0M5eS9oY2YvNFlDY3Rwa2ljZ2o3VTFITytkOTI2TVRnVnhnZmxR?=
 =?utf-8?B?RHR5M3NsYlF3eE1jb1Z5UXhpVHFBVjIzZnVnWWNqSHRPNDB6azJmYnd1SUZU?=
 =?utf-8?B?MnZzWDQrYkR1Nis3M0NlVlhzemJMQTE1bTR2QVp4bXlaRWNOMnNhaHJZQnBD?=
 =?utf-8?B?UFVzaFpSZlJ0OXc3U25KeXY1N0x5bHQwTWdadU40ZjM3MVRHQ0Rvd2dBV3Uv?=
 =?utf-8?B?ZVNnZVRsbXVYK3FlUEVTV2d3RVNrVXhqbDhob3Nodmdudk5sdDFqTm1VVFcw?=
 =?utf-8?B?MmRwN3EzNnVxMVU5ODc5Q2dQUDd1RzdNSy9TaXFKd2FGNzRIY3RzRU94REdL?=
 =?utf-8?B?OGNtVjlzbldMekg0cFBkRGZESFdZMitNOFNDK2Iwb0s4SWo4ZnhYelRiYi9F?=
 =?utf-8?B?dkw5RHdXWUZxSUl4a1VzWTFEaXU1K25DU1NKK3dnREZCWFRpRzdNeDRQRUxJ?=
 =?utf-8?B?RjliL2JkdzM4SitwekV2MmpwSDh4QWtjRUlqUklwK3MrQnhEOVdWaG5BWkFP?=
 =?utf-8?B?aDVFM2pDdmxObVNCU0gzeXRrcnZ1V3NNR0czbDI3R2FBN0xVUWp0Y2FTcHNO?=
 =?utf-8?B?eFZIODAvMXNOT1hQaUwzNEdpL1JNbng4dWZnTE9iWUFUUUdPZHZsWmlyMDFF?=
 =?utf-8?B?R0MzYk15d1ZJNWpwY3FmejhQT2dUaFNrcHdJRHJ6OW1QSzROR2k4WDY0YnlM?=
 =?utf-8?B?VVpzd1h1b296alFZbzhRTmVCalBUSERKdTlScWM3T1pKWk9LWG1uWEtQYndB?=
 =?utf-8?B?T3VzTklBNVRvaGdDc0NISktBWHdYZUlFTC9qVGtQb3hMMzZHbGwyTHhYVk14?=
 =?utf-8?B?N0puZlZpNUptNFMyOUZySGhUZzFrbTNHbzQyb1RXbjZ3WU5yb3VPKzlWeWZy?=
 =?utf-8?B?MTVyYmJIVkdMMk5GVWhNZSs0R0lDdlFERUw5ODY0cmxKUFBpQVVEY2dxZXI1?=
 =?utf-8?B?YnhBTFhhZTZ6QlN3ZldNbnRvajExN3d2UTZSdUUzdGw5RUpyMXk1bWJzbkRu?=
 =?utf-8?B?QTc4Y0pqOVk3MFJELyt1WGpDUzh6MlRiWStLTnZmVDRheFlhK3duL1ZiVjNz?=
 =?utf-8?B?dE42QUtzM1ZiTEpPdDFtd2NyS1J6R2pJcEdQS3EzYm53dVRPR0ZHV3BwQzlq?=
 =?utf-8?B?eEdSMkI0UVB5Y1JqOWF1WFlIeVBUTDJvYkRUcHRIWVFoZXJ0cy8wNVBsK1lD?=
 =?utf-8?Q?VYrLqP8FeB0B50vjXUvMcFGd7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05cc003-b61a-464f-0bce-08db8d8d09ba
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:49.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTEIMxtu8zODclDsTFe3qT0EuGJ+d4xSKxvCDPOl5TkwkcB0IQjfc4k4AqpKQA9avJ10DXj7I3O9PFix1i7I3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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

