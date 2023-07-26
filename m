Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63967629C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjGZECe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjGZEBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D33269A;
        Tue, 25 Jul 2023 21:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9X6JJstVeMIx1NYbrC4WUzNYBgnH6G2ZuUz7oVfQO8VVUhW8GFUMsZlqz3EdopbP5IpvYgf68hABT+FNEcTOBsakh6tjxSQ878SQtChvqg9COlCQAD8CPjrE5Po22tiH1FwmPNYbEpcoIwsDrwuMTun8BhJsPn6eDPEAlDS2BoTrBGKvYW9aSn7/brBcvimQHh1eOydqTSXh+k2Aoz1rwU6/45JabFCqFydDCZjNWPUgaKM18NvBI3b6rKbaA8YJ8X7kXas+oyEjWMFYSayZdokKbm0ia+2VXOlZ/A3LK+aJkHZOjiiVJFsuPfGvtB1O3GqVipX9XPrYXJJYJkbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nbEbIK1DWhnXMWnkEWTsr0nKaN3qrg8h4rvOqRdbbE=;
 b=iadOem73v7RXXT/6hi27s3h8fcc4guU74W62GRLpHjkuP17OCDWV1Sl9DxiugzTn4FDV+XjId8t2fkxfLqPn9n1IM71cCV7jaqAUMTzVS6PBH9hBGg39OcFNBjw7Y9NQziy51OWIU1uv3R3ZieLs4ofpPfFqcvmIteGHV4NAwPk24oXGA6Aja0jnqF3/WmaMMHKTIa+XiYZYSrpnJAxKAnLgyaoqudRB34l1wSCEetzamzm2jd+pwzRFgsWosgRP//f8Hb4J8a33cGqF9dn7xerf/f06cIFGbfzTgT40oiUyLVDkHsqOSLK3itakMZKKc5QNf2yvcpkXU2YqsJR9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nbEbIK1DWhnXMWnkEWTsr0nKaN3qrg8h4rvOqRdbbE=;
 b=EgGE+KzC+majlwTJi4W0ty+AboVwpEOkkZbYHUc+jjbXQ0cOJzIv03jjWzLeOc0tCxdVXWBzvFtbqA7Xcs61u5mr75nF/WOCDRTOgh1feZ6FTM71E3izPiHpn2NRT6okr+8XidqT07ZKf6FgM4r4nMI2F/8mPeTw3YNAf/sb+gc2t+q+dF7rAVvsxORCdGxf+yrdAjtnIiIJiSAQhv3P648p6jDjfa2QcFxdrmCKys/ojrZsKsx2ekJS6+wWUA/eK/JrVkRuEFJs2XTMXKYp55FUwIShAv4YXAg5ERX89oEAMnGJsQKQ7/GmWhiT/l5OrFijKcLCK0NhmB+7ZAzAgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/61] mmc: omap: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:53 +0800
Message-Id: <20230726040041.26267-13-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 617605d1-6116-43cc-f12b-08db8d8cf808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jW+iTGM+43YsHqyvCaCon6EC6NKdNIjHh+0GRQRWyLRMuYL9FZ1jJFAY5veImEP3Fzn9ELdytPrh+ucRAbyETUied3OblbXgFL04DURd+c4eYPF2s1/fxVz95ZgQku6y14B5Qr5Za+3WZ3yvV9Qp+aSB8pR4xqo2o+FP7htrFqqcNKq0VMC1RGm8FbgNpAAROHnxi0bQJjYuUuHTQ+1PoevCBtvd/UT62PRw9wCF2ckg16g6bCw9BtpmtfPzwmHD72adEOXLXvVVQUvQrjT2+VccPqppwCgNu245f5TcSafoOTRTCgz3EcK3+Q7LJh3AVfEqPC7QXdcMtxR89m0971ptG1Q+iqHuRY+L1VTx1mUCmnCc6RRt+UbUAjMfROEgxMdiX3cpeyV5QZvE5g958bzxK2IsG/7eVypHKF5b7sU+h6iAGwEW/6WaopMDPIwxTCZJvOd7nPmGwp5tu9tGvixyUAi82gQSbjUVNID8Baw4dIXChaXQb4BS42VEp8SwBzu/mrlgbodnJ2nrIjg7Rn5xyGcCvhtohpB8bQWdgJEyln1Z6Dfq2Yr0x9wv1QFvR+vKb78fHMU76wJMWnrjiocSfGl1jzh26h9sYzo52LxjgmEMV7fGWBjxfsaffbeY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJ3NG5TOUhmcWFWSGxZVzRMbkJNcUo1RXlKODBwN1BNTWJUUTFLODVINW5H?=
 =?utf-8?B?bmxGbE1WRGhCdkRSbXFDSmM0L0hFYlBxSUgwSGlNQXl3TWpKMkVDK0NIK3Zn?=
 =?utf-8?B?L2VaakhRc1MwN3lpM3psVHJCUENDTUxxeXdaaEMxRWFzUkg3cTdUR1BMSURp?=
 =?utf-8?B?K25IMGtGL0UwcUtDZm0zZ0krckswVld5clY5SS9nYmRxWDVRajU5cmJZZ0pp?=
 =?utf-8?B?T0YxYmxPTXg0ajV4eXIyTVQ5QWh5YWNXNXJ2VURmdUtEVThSaGQ3cTRiSjdM?=
 =?utf-8?B?UE1sUHpiK1A2Q1hET0NyVUVnL2YwT1YvWFE0ZjNXNHN2T0pTd281VVV5enE3?=
 =?utf-8?B?RU5JWG9wT1FCVEVSSnVDWk5hZzhGRnY3VDFsU244c29MNHlxdHp6bjVELzBr?=
 =?utf-8?B?cHYxY1RGZFdJc0xpeUJMVWhyRm9RaDU2UktFR3ZWeUdFZ3NQT3luYjBXUTNL?=
 =?utf-8?B?dUF4em1ydkdBaVRJTWRDTVJKU3pPTWYzMlNtczNUYlpsY1NYc0U2OTU4ZWc4?=
 =?utf-8?B?RUx0Wm1kcTUrYUg4d1hQc2c4dm82ZDVvZmZaeEhTWlhhckRDQytDSE5hMGxY?=
 =?utf-8?B?Vmpza3BNM05OOHVBNk9FVVZxaUJWaWFCR3N1L0dvbGxaRkJDak9jU3JGa24w?=
 =?utf-8?B?TEprN3hGUGFTeWlzbUwzQVkxdEk4aWFIcEkzeWUxVE5qQ0JmajZ5TUpVN1dL?=
 =?utf-8?B?akFJQTVqYkpsZmVvWkUwdG4wZ1BUT0ZCRTJZVllTWkYzclF3ZC9WK3FEUWd2?=
 =?utf-8?B?U1RrVlBZbGFERXBEVmViUXdiRzdtdTc5a3FTWGlRZjhnQWdlbDhhVks5SWhy?=
 =?utf-8?B?SExkREp5dDVnZCtBQ2VpNjF1WGIzSmFPRTZmM290R1dwRk1YYlJnRWxaZHYv?=
 =?utf-8?B?c2JaVVNxUTlDYTJiaThZRFRwT05kSTBPM3RzVHlqL0RDMU5vYngzMUxTQ3Rt?=
 =?utf-8?B?cEdmaUo1MitvV1dGRS9UR2k1RXBRK2hQRVpZUHJCODEzRlBtMkFrOXRlNHlr?=
 =?utf-8?B?Z1RTODlRRURKWFJSNkM1cCtZN3lPWmltNGkrM1lUazJyMFpWalovTy9OMVlK?=
 =?utf-8?B?R1VqVVJJZEFWeGUwSU9WRDdyWGZXTjRQYjJNSW1kRUpGTkZXejM4S0hoWUVo?=
 =?utf-8?B?Z2JDVXVtSHBSOWc5YXJwK1QzV0p1OHM1WHd2cDlGODlqeEptdHlOcGRrU3c0?=
 =?utf-8?B?dno3clc4ZnJhREdpdjExdGdtMW1ibmdTVmR6aTBESmsxbXc2anlyTlBJZUV6?=
 =?utf-8?B?KzlpQkovYTFCbWVlbys0TDBTQi8yUGFYYlJNWm84aXJGa3JLYjdWNUNlNXpK?=
 =?utf-8?B?aDlFTUgrUlZ5REwvNG9kQXRlNDh0dXFaZk5mbFA3WW9kazdFR0FQOUNDSHJs?=
 =?utf-8?B?eFlQbG1qY0tHVEYrRGc1R0tqOUY1Nk5FZmJjMFVqaFZJazFmbzNKbWFRMTF3?=
 =?utf-8?B?WU9ubjdaL3l1N0hhd1UyS2s1ZmkwVHlJekx6UGJSMjgvR0t4Z3JMV3pNRjlW?=
 =?utf-8?B?Ti9nOUtrZndWYUdYQnp2b0lSa3JPdEY5cjhkSTUyNVU3MEkxVkt5a3p3bEhs?=
 =?utf-8?B?UXM4WVV2NVBMNWh3K0M0czVGRTJGUlYrS3Y1dVJEVWZPN2dablFJVjRnWDEw?=
 =?utf-8?B?aWV0NXVBa0hsblVReUI0RzlRb0ROaktiMHJDakc3WUZ0K2k0SDFVUW4wNllt?=
 =?utf-8?B?MUVwSmFBSVBpM0NqU3Y1MSswS1lpU01FdWFnZUdqNkIxTEs4RG9ocERSZC9m?=
 =?utf-8?B?bmk3NWlRdlgzR2VNajV5TGQ5L0JrQjlqWUt3Q2pBVUJIQTAwVHNJeHI1SklE?=
 =?utf-8?B?Y0dCZi8rWkgrWjVTRlFXM1dwb1JWMThFcUo3WWJENlIxZHJSQUhrRWxLd1ZJ?=
 =?utf-8?B?THVQSHJXVWRwc3ppdHljYTdOVk4rbGo3QmN6eVVDa0cxOW1jQVRNOExBRmxk?=
 =?utf-8?B?bldUWUVHUm40MmcydTVvTlhYQzVLemVkdkRBbG5tdXR0SDA0a1RWc3lYU3pJ?=
 =?utf-8?B?azB5S3pMbE5NN2g3QzZMeHNRV3pnQlI5RjR1cFRvcGFNcDFhYzZLeVFVR2JK?=
 =?utf-8?B?ZVpqK2RDZk5teFRjR2piQ3M2VEZlYWpNbkdqZ0YrZnhJMFoyL1VIdHgyeHhU?=
 =?utf-8?Q?rvHRHLViexc/Od2QINPfT8Y7X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617605d1-6116-43cc-f12b-08db8d8cf808
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:20.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpqvNS8WdZ/1FbfJR8LTNXfYiY9IQaddFbjszeo/fb+B2sF+TZynsdW5VIUEiYb48ZyX6ZzXg0OGWmvOTvfI0w==
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
 drivers/mmc/host/omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 6a259563690d..9fb8995b43a1 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1506,7 +1506,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mmc_omap_remove(struct platform_device *pdev)
+static void mmc_omap_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 	int i;
@@ -1532,8 +1532,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_rx);
 
 	destroy_workqueue(host->mmc_omap_wq);
-
-	return 0;
 }
 
 #if IS_BUILTIN(CONFIG_OF)
@@ -1546,7 +1544,7 @@ MODULE_DEVICE_TABLE(of, mmc_omap_match);
 
 static struct platform_driver mmc_omap_driver = {
 	.probe		= mmc_omap_probe,
-	.remove		= mmc_omap_remove,
+	.remove_new	= mmc_omap_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

