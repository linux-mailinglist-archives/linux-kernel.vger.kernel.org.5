Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8437629D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGZEET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGZEDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:03:38 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E684209;
        Tue, 25 Jul 2023 21:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbXHsr2SfrsSqt8WFFzVsKTLmWka5EbQGRRdyTUbYdKLAmMJygsII/haJobW2eqAzW0X/pVApqgS/TAK2BLBcvabdDAz7uhecmkFUtiIDQj1mF31lhc9DXKNVEjDtvRWqxCDdDMBrZQszmjw011dfcLH+LvlXAn3k4hc2NRiyXMAu83fWTNzqQGtOR7oK20KB/tvRMEDgC4w64MwNFzePDEF1q2rP/bhuUFvOzGUXiRvdj77g9mH4hsPt5BU8fRXm/Lcz5TM7fdZatBaePJO+wZu/3sZs3F/auzuhVeK1+wDGZPuz89L8E2zJo4tNhNjNq4r3VE7FaCM42C5UjnShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTCEmJzZRC/a6SHh4C2nbpGEXcRFJ6SVNGbm/AwkaN0=;
 b=MjTZu5C1PBdfXLvYrzWVmO3hnIjkGj3YPmW4f7q/kU1ZE0VNDajI78TSXoRwcYHeQLjqyoZccJrsX4DkHgtH83mBbDbyqYkmm6+5OQr3QkRgjH8F4O4YYrqXjap1KemVlIp1tdD86rqoQnnvKISc8JkBpjFPNoKmcD8PwMKurUrQKUYwmslS8EQg8oFlcpOUo8JSYYp7I5rnFd56j98o7v8hfr74gaBWOpeg4mz6qK4+cNefifVzrPdd//f3JC4O1+VxFpMJUi/0QD7ElHxk+SX/qvt6QYaAqRnZzQzck9Aqp28BZlCSJCbVuyP3Pt1K3xYRafALwn4328oytaS/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTCEmJzZRC/a6SHh4C2nbpGEXcRFJ6SVNGbm/AwkaN0=;
 b=fFKKS/Gh5hmWJVZfF9P+zbvtcMDVZJvAxjqBdHxyoUGsIL2ib0PXmILaZiDYGwLPhgjvz1HxEOqa63vr8Kh6895HT9dxB676mllcCWKcSwh9uuSCZV02k2z5YaKeCIfKk3NPqvwE5aHSa6NVSqo1s3/rJOe1CZyxAXFITWI1MRt+bsuqNy+nXCLEhFosfDY7ZLuWixLZ6UoMqDeNCjOlB70yUkYhuXcjLK8RFmCuxzACmy4Mz/MPZF9WKRLxx1f+DfjNFigFB3tvUm1dhfArUDsZOd1IzULSLlJ96543kbZg29ocwVVKB+tiWwV3cZjRNedrWwWww6+JPDXpGh3WbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/61] mmc: meson-gx: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:59 +0800
Message-Id: <20230726040041.26267-19-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: 113f54cf-6a28-4450-3a96-08db8d8cfe9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i+GW4ZCuJ2TzDRzX/d6lVv9THQuNO3JKJaFjG9KKdh9iVRdWC8ryrT0P4Wkw1KyRjaQatkpZu7yM68LPtwyMqqeaftczL4EorImd+H3VxVbrYhWb11qBzZkHOfe1l44udzik1jJ/TIWT7BisLDZ0oERWWuXDcA+1uDcEdntYVL94CB+ySSyGLymfGe+yXwWzdl1FqE68nny7yy2m97XkoTsrQW8zARTOG4x+CEAhesrq7Qs932fRRQPI3zcAC7oj/E1IKkh/7N5gZAmbXbLtM3c8MsIUyEB80F03F9eypJCnJN+AEB8TI1cotVmocE8l3dgynX9EvNw7NxPp6MciUU2ErBHXoQKFbgm1Prs/lYAdkPwAh6kO7dFvY4EPKJSLSJSSGVRXa56hRRsP4NpXVglTqULCeRCumFo6OC7Ru0wO2eTIYv7p6wx97h6/WTQMlmaUmeXRfwRT0X5DpYo7AG995i0D7Py0OaTlrwvKTOkZCmWi/nd9xcF0mzwbjRqT6BIaZfHOjQZBLw/z7DKzP99ceV/qPOQjI/i4nAcmxuPCGo/jyAngXekGap7V8+JqqdKN9Hgyn/vj+lWU0YVHub1Nz4t5CS6oNuLdamHU8wbwnTBiWIoKZpDGo5NdGCq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(7416002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3A5cm1ZZ2FlSktSb3JxMS9qQ2dwU0xhRXI0QUF1bmZrR3VMNWhpSE5rZ1Rj?=
 =?utf-8?B?aUhjWEdOTXBPZERDR0FOVHJwYVErdngyVWt5Ujlpc3N1MVR0dEJSVUVaY1oy?=
 =?utf-8?B?NlkzbHE1dXhET0E5Q0daUmE1eXdJY3ErMExxYVFHMmllL2RRL2dOZUxrdUN1?=
 =?utf-8?B?R3FhdWV1MjZUQXJDM21OQ1BuTkFoaUxjR2U0NXVFMkFETFFTcVY5ZVdyS3lz?=
 =?utf-8?B?TWt1bFZXUGpVc3ljUmhJcjAvVzFrNDllTVlDWDNrNTNybXBYUVJrTEgwRFNp?=
 =?utf-8?B?ZHIvTnF6dmpwOGJyajhIWkZIWHBzc2pndjlTTWhkZGJmUGNScklQUHZ5ZjNS?=
 =?utf-8?B?Y0UyYjh6dG9iNGZvLzV0Y2dZMWVRaTJ1SFMwMXBwb05HRU9NRUl5bDNaWFds?=
 =?utf-8?B?aVowVTdDdU5qNWw2SG8vOU1TdWVBeXM0K2htRUhSNEEyQjFtSDlHSml2UWZD?=
 =?utf-8?B?dmwxVHhqdnpkS3ZPcG5WQlRsL3puNXJRbWhhdGlsamk3eGUwRzFRbUtOUi9m?=
 =?utf-8?B?clZWZmhuUTdveEYwa3pQYjkvS2N4enhpVVBNUkZEYmlpMjV1RU9ob0cyQmdY?=
 =?utf-8?B?SzJkanFwWWRyRnVlRzBJWnF4cUx2dXQ0NkRpL0wvVUc4K3BmOFFyT3BqWk1k?=
 =?utf-8?B?bmJZd1hsN0JGTElsRjV0a0pKQlkyb3JDaTJQdjVBY2ZYc0VVci8zTm9Na3BQ?=
 =?utf-8?B?emlaSWl1S1dvTHhiZzAwUHd3RmJCeFg5UkYyWElxdFdIWWVnVDY4MjlraFl5?=
 =?utf-8?B?WDc5Y2ZIWkNPVFZCazBTby81bGMvOUJUL3JlNjVwbkI1V2pwWGRPdDNTemJG?=
 =?utf-8?B?Y1FEUnV3MnN6VmdwN0IzOEE0K0FEellVNTU3QXNFQmt1bUdkS3ZoM0ovOWw1?=
 =?utf-8?B?dktjQUd1ZE5KSVpITDJUS0hSTFlsa094Mjk0aTVuUXplSm1CQlBvY2Njc0ZQ?=
 =?utf-8?B?L2Era0hzTCthUHhQcjZBcGFoUlZjSStnT0s3b2t6ekxxUGhlN2NLd0MwUkFH?=
 =?utf-8?B?TFMxZ1NSZUZ4WmI4OUkvQy93NjZiS2lOcG1LbS92b1Z4bUk2SFF0aXNWakRr?=
 =?utf-8?B?VEhJbG5FWFpVaXZ6SXRMMmsybFpqd0xRZ2I5TFhMUU9SL1hmbW9BVGVGTG5r?=
 =?utf-8?B?QWlYbXc4dnFPc3NFNEhiRVNzYjNqU2ZVZjNGVDBVVnE1K2FpbHZ2K0wxbjZt?=
 =?utf-8?B?a0EzS1BXV1dKc2dabFJnWUZvVTdCWmwvMXJ3MDAya0xzSDNkZnB6dTEraWZ4?=
 =?utf-8?B?WERFZGJYQWM2dW5WSitQUDhUSjVURmp3cmlBOGxZZk9PQy92YklRZ0ZwVjdH?=
 =?utf-8?B?U0E3RUJkV3hIUmp6VEx5TmpXTHlsazJZV0VzV01zZ2Q2SE1aY0wzdHdtZUN0?=
 =?utf-8?B?M1YyMHgzL0RwS1RNcWVQRDFJVXYvVTVOYS9hQUhVSXNRZnZNTzE2amNsTlpr?=
 =?utf-8?B?RVNzVk1TSURCR01rSENTYlQ3T3Jsa3JaazdUT0hLUVhpWVhaOGhxdEtnelFp?=
 =?utf-8?B?eG5GV2ZjdmVZajZ3MGREc3F2YWh2Y0lwczFMUkk5dzFReTZ3cjZ5OHdmYjNp?=
 =?utf-8?B?d0J4UzF2UmZFODA5bzNJZ2xhQ3puTTZGVzdWOENIa0I4eEtkdTRpZzFiZU5p?=
 =?utf-8?B?WUVzQXlWMWYwTk5yRHA5TERVNEZaSThGY1Z5ZEc2bkZKdUl6UVMzaE9MZEdH?=
 =?utf-8?B?THhEWUhrck5PWmxVT3ZFanNqNmxRYldVenJzYWZiQnIzK1lxMWExdzRLQjVx?=
 =?utf-8?B?UU1idlgxVnBlbUVBUFRZTmFKNGRIblpPbXd4MU1nWkQxM0ZzUEMxcS8zVnlw?=
 =?utf-8?B?SVdCU0Jjek9lU2lTTjFoZmZzY08zOXlwemNSNU9taXRzMkFuYlpMMlIvMnNt?=
 =?utf-8?B?RU1YYXFHcnJpVTV1Z2lBNU5HRXZRV3FEdUUvRHlKeE5UQ2hKMGNXaVcrVE5l?=
 =?utf-8?B?Z3BWN25UM1BlU0xnWG5qNlZIYmk1aG8rT2tKaGFqS3BXc09CZHovV3c2RTBJ?=
 =?utf-8?B?R3RYOFlraW5LNVNhYjZqTVlHeThEOUJoM093Ylg1T2EwSmFXQVo1M3FGMHI4?=
 =?utf-8?B?QkdlbU8zVWIvKzdCVCtFa29lN3ZGY2FMYURUM3RpRU90Mm5Lc3hSZTVOOEIx?=
 =?utf-8?Q?siItjHkjMM5BHb/3taQ/J6qBZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113f54cf-6a28-4450-3a96-08db8d8cfe9e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:31.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuyG4YWJ2HTz7FBNxSzQWRqJxmPCStqp2IqjNbn0kK+npngC7Q3nxtfvLEnZMp7EjUUKH+0xDwE+6VuI2FbvHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
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
 drivers/mmc/host/meson-gx-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d652374f37b2..a2601d0ece71 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1294,7 +1294,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_mmc_remove(struct platform_device *pdev)
+static void meson_mmc_remove(struct platform_device *pdev)
 {
 	struct meson_host *host = dev_get_drvdata(&pdev->dev);
 
@@ -1305,8 +1305,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	free_irq(host->irq, host);
 
 	clk_disable_unprepare(host->mmc_clk);
-
-	return 0;
 }
 
 static const struct meson_mmc_data meson_gx_data = {
@@ -1337,7 +1335,7 @@ MODULE_DEVICE_TABLE(of, meson_mmc_of_match);
 
 static struct platform_driver meson_mmc_driver = {
 	.probe		= meson_mmc_probe,
-	.remove		= meson_mmc_remove,
+	.remove_new	= meson_mmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

