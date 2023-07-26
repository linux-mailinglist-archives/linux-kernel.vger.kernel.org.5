Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF17762A13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGZEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGZEJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:09:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF044B6;
        Tue, 25 Jul 2023 21:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neKbGccaA7rWWvTWw6M3hb9kNOtAUJ42r/eK+Q3lv7/UTh7X9Az4GWaKPEI1K8f+RuPOCuU26Z+u+mW+fgBaYrCFRwLNFxNvvRl24GAjvqr7cRehT7ofDbPv0nESf9SIyhGBPhQR0o8lUzx5a1eFcLYNyClcOW2qyxHTXoliwATVKMwzYHyyhqMjV3/YKJkWpxj04s022tuYik1zBhbtYRP3ABoXa1iQ94h0q7us4ELwYLxK4iLNU+7B4MpRjF0c+MYN9+VLhjuP6/iqMOQJoOB0bpko4nUqXek+ojGjVdl1fxgrUIdhoUQcRm/YcsAf3Mr8ZdbOqrJduiCRy2KTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPnrvKCQGrGsesSBC854cGT5go4mKOa3EElli0C165Q=;
 b=ifleiRb8DnSsba62z84xTH/38O+OEgcH4s0ifC0YeMgTdMmqYVM1nh5sNPb9f/CCtK59TZMtQHO5zRdWYXiU2EpXGMLJjXmq9+QDp5vG3th1MazQ1y27oq3oBxkkgX0J0WipB/TEiith5o+ctqav9UWnGxHRWW4V3eaeeHkl8OF+q3vIHtYnnX/4nYmexc+tTI37GRXgN1H0zuGNQUeStdZhi+BphqSvLMyjtgD8B3doMCFd1qG492GwFKV2UGsfBo9XZxkmCKkPG0R2QgwP9QKHFV47wuySSiSYIasy7aMSf7Og4bT8EBYDoVFoQxrcmgQZ5V99Fl5bMLLFdJzhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPnrvKCQGrGsesSBC854cGT5go4mKOa3EElli0C165Q=;
 b=HkSukUqRjYTBCfHSRgYRkpw8yJ3VCjmT8s11faTAXiiS8lEVSFoJ7RJO3WnljFAGZ21baBLUMrdBYPPkb7ge73xx3V5TQ8Rh+DjlHca4n/K49/DhNbESMGPPLTrYH11DEsYPArna5GYOkQV082RU21IZ5u/iIso3xQdk0KcJxl7JaoZuHj9xBRssuSyZGKulluVTYJ+E3qOdlB5joPTexrqLSLDMi+8IxNkEEA5nBJQslfNJ6OLPVmmKGGhOoHqtpPJtFQtU2hQygQzhF+/ewtLK7gZ9P6PImVnlqXdD33WrUQNnt7zI2Pnb7cgL40dgCwqVgtgFITszHkqHMUyQcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 52/61] mmc: mxcmmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:32 +0800
Message-Id: <20230726040041.26267-52-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: b9716d6c-682b-46d5-2ab7-08db8d8d2144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0vpsJLLgRBUhWjgKKlGYjMQ7GAu6/OF9U31wP3R7DPvCkRiQWuF23qQ5HB/O7WMl0XfEkLLf3N7XjML6bswZK5Mz6W+byb1h5ss/DuJINGn+zWEk3xiJkX8q32GL1DuVHQyJYvL8OS48IBIQeuNbW6htyzWlt1omm6IuEg6xa1lW16y/BwYShUoOfbmm7WXICIw+SZU23UvKwyqVwrIC3odznLn53IuLZJ/gtRzrRbJJ6AffhqrNOnCwQvOzHaUiyMg6Cq4wxGA0hnVaLEZuC/r08j9bfVdhpD4bIjw9GFFCS73M7zpFaJ65t9FBGu7y2ume8rhBMRCVHbUxefdiRyemoQsWm+vi2MI9oP7PB7ioSLAV24F/vehkOeL0rt6CW+Vle4fvgkbdaYlmTpVjJPSD33QOo4fj8LW7K8QKXCWATBSX6w6gG5li0etjBmcUmCJEQ8Y20YqCRcOmODR+aMcwEJFxWd64ZffOAqlTAx1P0MUbs8DwLnpI30/ahcjWQUlo6bBOx83nzQWMEIBla2aD7Hugd87X3hbhF/QSPw6ysfQBkzSteyCOQmXodql11Ddk0rw4+b+pfD0iQeIYOxHDLy209Adz9iAq/F7kYCaA/8zXx1uRqy9AcmG/zZA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNJRDYyT1hTMjhkbTBnWWhuLzVmLzJac2poMzZkSnZjUlBkR2MxdzlocVRx?=
 =?utf-8?B?U0Z6Y1BaN1F5MXY4MnNhL3k4VjE5MkFxcGFFZytjaGJYaTZkSGd2TjdXM3Mz?=
 =?utf-8?B?RUV0ZXlwSnA3QW5WQ3ZJNUk0b0toaU5LeTdjQ1pJRzhoQVVaTTRiM2hSaUN0?=
 =?utf-8?B?bFB4c2V6eDVtZ1A4U0lqOVRXaW1JSDhLcnVJaXNVZFJWTlFQWVFDRk9ZT0dx?=
 =?utf-8?B?NWRKbXpuK3Z3VXpRcTVYKzhpSGNnN1h2dzRLTFV6bEZrMXNYaHZwZU9KdXJp?=
 =?utf-8?B?TDJhNk14c1R5K0JadHBFTk9nOGY1Q1FUN3E5a3hnV2lVaHc0MDVGUmFtK3Q0?=
 =?utf-8?B?MGdjdS9WL0Nsb3JDcTkwUlJZTmtsYStMd0N2cmhaYTR0VTFaelNuRnlCKzAz?=
 =?utf-8?B?Z1A3b0tSR0JHT1hDSW1qTjV2ZXhyaWkweDV2OXUwM3gyODc1RExobU5kQnhZ?=
 =?utf-8?B?T0xlYTRDODc2azVGaVNUb0N4VXZvZ3h4M3ZBNjJ5VHVISWdPZXNneTVnL2Fw?=
 =?utf-8?B?NlVkZjVzMGVqRE8yMTlPajFHeTEvNWNFVHgvYlhpdVVMckttWWlXS2xRUndB?=
 =?utf-8?B?TUp2VVU3WXg4WTNkL0IwR3JobXNHNmJ2Z01YODM1amRqS0xQTkNSMEcydmNk?=
 =?utf-8?B?RlF2a1hFN3NVNlo0anViaTRZUmlWb1ZuWm92SVJSelhhT2NkYUc5L3lVTFBm?=
 =?utf-8?B?K0RWbDErZHlzSUVxYXZuSjRvY2Y1RWZDZWhNTWFrVTNiSzBsa3gvc2Ywbmt0?=
 =?utf-8?B?WWE5V3FDTVlkOEJqemN2TVd2RndCWWNia042cTVGNjc1OGxVRGl2eVJGbGlY?=
 =?utf-8?B?bEpLU29PbE41cWxoOUxpdDVjOVBpMXV0aVNlTzRQWHRQQ2FEMU0vb3VldndY?=
 =?utf-8?B?NWtJeDd5MVowMWlSK1lUd0hRazFVdUtTTlFJMkhwdzkzWDU5RVpSdlVxSUNt?=
 =?utf-8?B?c3ZodCtVMCtNRFByS1lZNERFMk5rYkxmSXlLVEJQenc3akw1OWQrb2IxTU9i?=
 =?utf-8?B?dm1QYit3cFFiVGNiK0gyMElhSDJOTlIwdGs4WGlTaThHTDB2Tmp3TUZJbmVj?=
 =?utf-8?B?V3doaWtxYzV0UXRDTkpzUUhUbHhDZTVCK0o1OFlkVUx4YThNTlBHVld3NGNl?=
 =?utf-8?B?aURoSUQ3Kys4QS9NNVlkWlByMkZYeWIzZ1NlQW5ybmcwdmQrWTIwUFIvd0NV?=
 =?utf-8?B?WHhrbVZQS2w1ZkdVWGhlMmtPai82emVpdER5alRjUTZoTDRjUlNIeFFFMVVt?=
 =?utf-8?B?YnFlVjFIK3ZIeHlwV3JGemxhVVdueHM3dDUydTM2eW9NOTVBTm5XTWp6RlVN?=
 =?utf-8?B?K085ekI0QnN5VzQ2cW15UDhCdDd0UHVoZFh3bkFZTk5jMlBTa0ZYbjJTOXlX?=
 =?utf-8?B?TVBST3FFdFlMWWdwRkxpQ0R3YnNFOFNIWWpuV09UL0p1RFlxSTlvVUVBQXBu?=
 =?utf-8?B?ZVdyVGVEbVhXWG94NkljUGhqZ1JyelE2aFprZkpvSDlYMElDMDdnZTNIakNa?=
 =?utf-8?B?MDRYdy9ZU0wwMTJiVWVJOFdRRWNlZGJjTUxON3VXTWZFOEFWbHdOWlBOUVpn?=
 =?utf-8?B?a1FiYUVLUlBPczJ4WHNmRDVqUmZUYy9QNGt5d0ljTHBya0VQUkVxM0VPaTNp?=
 =?utf-8?B?UjhEV3kwcVVuSUo2WC9lWUlkY1R6VXE4RTN0TXEwUm9qaXkvVjVQWC9sY2Nj?=
 =?utf-8?B?UE1ER2gxdVRFWUViODlkakJjRWdzZllBOHBzQ3greGZMYXRCUmd0d1VQQlRq?=
 =?utf-8?B?ZU5ZQ3AxNWVJQkdVWklXenF4QzR2YmY2Zk1zU0ZPOGgxRFd0d0tzbWhrbnlP?=
 =?utf-8?B?aWxhU0lxUVJyZkRQT3VHOVRTZEwvUlVZclhDd2pKZkMvMlZ4ZUREczVRMmts?=
 =?utf-8?B?dFFUN0VWRFpZN0dmOG9UWkxPMFhia1JOYkhQVCtaWmtlNTJQRGRRWitqNy9M?=
 =?utf-8?B?alBOaUdNdFVTVHZWcEtOcFVxL1VSc3pmSXRRNzBKOG54Wlc2L2c3QTA4RW9D?=
 =?utf-8?B?cEJIdnBDYlJVVUV3eld1YWdFN1plZU4zbEU4WGs3clNrZTJRZno0K2NtbUFj?=
 =?utf-8?B?RHdrMlBYQTJidndPQXVET2ZEMHZISHBmMUpVaFVMcmREZ3YvTStyWVEyekZ2?=
 =?utf-8?Q?GS5gGaGYZDDsVx4nFgBLPTeIP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9716d6c-682b-46d5-2ab7-08db8d8d2144
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:29.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agMwEnhML1yrNA9XMj2Pogt+i15a2snGGJwRhY9/gJxR7337q7K9N2Q97SrhL6PBX1bktNn0zbXn4DgGuHVUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

