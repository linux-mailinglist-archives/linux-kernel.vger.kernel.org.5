Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0954076477C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjG0HB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjG0HBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5760268B;
        Thu, 27 Jul 2023 00:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdfqWrCDkPMf0B4r5l0YDmMIFoo3GUe9yLpLkthOh0hjpIThN/ayOwm3tAxankX1EfnlmYiZQvX9tTKwDsIhZIvTlfDZhQ/fu/iyIOuIX5sTCyjiZa8szSYxqsIovsKNgHlyh40LXzOv3oiU75/PPu152XhtsLpmLbhLDx9t4BFDVLI7OycpVYW/DHQVPoX/16v0aS2Lj9pVKfxpzxjvFyTC8MZAnr7Yy0nqMZgqZRzt6+eM+tEXqiG5U1D6bLRhhnM1f6mNfmICL8WRPj3xd6CMsolNxHRBzxWNI+0YDjV3PcHLfAX+bfk8/Ikl/v4gM1BEBsDlwOKBHX0I8mFC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7okkAtAy4Ay200gbDx0jngJNeo2uhW4SadPJUa5pIw=;
 b=bUXst8yk2XKPzXhSH4YVJdYuFAuHv+Zv6tw6cKUCRwslTm+NFMcvqy+rTKSWkuwMgADfCHkPPiviir/FROiBqgIpz+rE6NhDQCDRzYxNhzSK2+IpWBumga2+oEOmmyDvuKLl7HuysWcjCKR8F8qQYgbIQNMJenXV0Nkhyc47fePnWLVK1tgty86X40PrxeEu0KQdRfcxgT1DYIf1GBPD9C7vsi1QDeivdWbTQhUEeXs9rklIhXAuL7zcNdWMqdjHQe0MCH817j7gBDU9YTHi11twszvAOK/aoPjuMtUDwjupbrTYtBk+9zlsc+jlelIrUXYQNPkedp+/xTjTc0goZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7okkAtAy4Ay200gbDx0jngJNeo2uhW4SadPJUa5pIw=;
 b=RdjFo4TWUqrVmr0FRhI8EKIIzUcq1KM0iwYpacKLUoboLmnV5I94pB0L+Yrc00rSCeD2YBpxtwZCuTsWsesrXWOGFtTZOCiGqpc3tPmxQeEIPEGcI+e4wuwfEIcoHHV8fAR0ZAGPvK2AVKGVRejEZU0FDuMYozK2ZffXBkwMUmCVUbZKkKnVm25nw/NbpWXisWm+E0NGNlbofuDjH8FRCIXhuQon95qXZn+Ppfctf2NHvHlMbPNuHySCExVJPYGX+3OprhQhOoYMqlUttUAv5nz0WJeuc8tg0DbIL7PcY1/iMwpC6Sn4h/GPsZ4tN1JgDuJzisqh5Qk6q7LgzatUJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/62] mmc: dw_mmc: hi3798cv200: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:57 +0800
Message-Id: <20230727070051.17778-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 621fd040-264d-4dcd-764e-08db8e6f44e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +I71yupEiYIK9mGrudvf1CySr+AQll6z+IivwGplBaPoV8PVbSwgmV6ojvYY8auz8rRCLEVHboOf0veE7vvD91Jn2nxM9sYs7W1TTW0htKVxKz1GTCSzHqmL/0Q0Az5nWozu7a6zEqpgx/5G3uwtc7KE0SN868viisevogV+ZtC/E5JsiR29FwOvezbuZxkxE3f7jsWnYHorIQ2LwmTQIV7NmM5tuuOwUkRrBk98WpQ+TELp+DO/zLH9DSINyYSx7wNRGIcqywYLEb++/IWmHcsHiZrJzI8cWcM1zvxKZNEiJM8mr8RtcEw7if5bSgpUyHUnBhf84RgNDaPEjCNoJldbbbUTcMu+Oa/mL2m9/yC0GLoCJlFOs8Fg8bhAEdK5Dtcc7UjjTgNyNYbhIP646wuRw7Ozzq/+x2j8OQTQLUiOpJLhA0hd3hsCASR8+VXqNIrncY+pAa6T1nyV74bj4zLHJ9NhSUeAIAztXMv2J+hOyLOUbHiY6zUaFBm8pujstpn6ecsUaDxOULjFYnfTftljCyWsScoA3dOUT2Z9WV2utlx2+9J4m4lZWDl493aiOLrj68Qfw4fwf/7YjFBlCEUg1bUXKgo/uTA9AGQa02FJlVdxWjfPfI6IvXJ8GT0m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MldhU2dGQU9peUMwSkY2dXBPNjFmcVltcHJsL0VxbmViQ1FIVWtTTGs4K0pY?=
 =?utf-8?B?QW8zSTR6aFlCdFQzamNTMlMwNFFYQ3NMaHVtWlBaSExQbUZua3BCYm9sU2Nt?=
 =?utf-8?B?ZWRYYUNwLzQzYzBKeTJLOXkxMGFCSkR4eTAycnFhdkl1ekUrY3cxT2xSSStS?=
 =?utf-8?B?L2tQMGMvY2dvZHlIY2tud1VEcmpLNGZ2TnhwemJxZ1lGbUhXLzV0TkZzYW1x?=
 =?utf-8?B?cTVVRllaWXA1YWZKSlpLQ1laemlkTVpScE9RMTliUDV5VmdtT3EyOUJ6WEdr?=
 =?utf-8?B?Sit2UWlKY0JMdkNYb2dMTWhKMXNobU4zcGx5b0duRU9iWXdsbVBwMGgyU0ZU?=
 =?utf-8?B?MFVIK2NBY013Y1g2c3VaTHBFUVlvaXF5cmpnQ1ZyME9iLzJIYnpUNGNTTnJ4?=
 =?utf-8?B?TWdaZHcxMWoxSTU1SDVsbVZQMkc2bWFYNnNwSGlYOHc0SFRUNE04VER2TlhK?=
 =?utf-8?B?Q2xrQVRsY2c2NEJ5VERHK3p4WTBpbXJmUXQ5VTdqS09ESVRtM1d6QTd5WnBX?=
 =?utf-8?B?Vmlub0F1ZXVQaVAyYy80NWNrRDBFTFRQdTBmZkp6MmVnR3ROamNqSTNvRGpu?=
 =?utf-8?B?cjFGNUVFMXA5VDd6WXZXd21yY29rd3JUMVJYL2cvU3p5M2hSaE11OHhsUXMr?=
 =?utf-8?B?aGZ2bVlaODcrWVJSTUxDNFp3SHM1UVdSNFRFSm4zYVk2RTJRODhiQ3hEMjhE?=
 =?utf-8?B?Z2o5SlhOcjUzQWk5a0hjZFFwRHkzOHFsVG40TXFLKzhDWS8rVFI0T3FVczNP?=
 =?utf-8?B?ZDJlZmtZTFdybTNsaWhpeGlUS2NZWlJ0b0l1VVpDdElVT3pPMlZ2c2JwOHRn?=
 =?utf-8?B?LzJsSldrZDVWRExUOWhMaG9GYVpJYmRNVEdOTC9nTDJzVkhNc3FBWTJXby82?=
 =?utf-8?B?a0JEZ3dOK3ZPTjlOdHR5eEFrd2JSMmt2bklFS0kybkNjS0xLSEtnbmw1ZU9R?=
 =?utf-8?B?UktrTmVaRnZRTlFuSGRFdDlCeE43VTVOZGhWb09pdkgzaS9KbDZkY2xSdjk0?=
 =?utf-8?B?bHVsRSt6YnJzbUNLRDh1bndnZXZvNHgwbHZmczd4MU0rRFQ4bzA1OUM3eXZh?=
 =?utf-8?B?VEhaWURlNzMwNlVPS3V2TlpLdlFlQjd0MXRqS2d5R3JIWXlJOWRvN3BCUDlC?=
 =?utf-8?B?RjJxVmpvQnlCMzNBb01HT28vVVNpTUVocU9aelZuNW5WSXpPV1Exa055ZmxQ?=
 =?utf-8?B?ZWpFWk52Nk5TUkFhbmpLNUVzQnYwbE05Vm9jbU9vQzhYK1Y4UVdZVUVWQy95?=
 =?utf-8?B?T3NnRThpMjlNWXhna2tGOUhSRzJmSk9TRlZlZklrNkN0RStZc0Qrd2Yxb1pn?=
 =?utf-8?B?V3hLcGxMK0NWZGtPWEZnaWRRQyt1SnZuZ2d4OSt6MERxa2RZOTdGRDc5bXBS?=
 =?utf-8?B?d0NqdE54K2lYSER4ajRXYURhQXZnL0hiSVkvN1A1c2RxSzUycHp6eXlzdkFT?=
 =?utf-8?B?MTVKN1BXZ28vKzdob2NkTk5KcVBLaUhYMnlwbWJkY2l3cGF1RkdGS0NwVDBC?=
 =?utf-8?B?T0cyVEFieWpHODBMdzA1OCszUnczeG13MTg4R2h3a3E3aXpubU1FUGJDOXB1?=
 =?utf-8?B?NFZiMDZzY3lGdU56bGhtYlN0UXhHYklBT0VUSk1RUVZ4ZkpGVWdVcDZGQ1hQ?=
 =?utf-8?B?YUVRN21vUXRnaW51MSs2b0lZbTMxSGRXNXRHZEVtb2VjZDhGRWlXL2hJRWNu?=
 =?utf-8?B?RFp0RzY5OE1uTzk4MVdkWkprZUl6VFptRG90SVBzU3JoanhCQWpickdYYURs?=
 =?utf-8?B?RFRTdG10NkFNUWd1NkZMR3ZPTXBYVFNja2JpUHprWStuVkpyMFc3aUJkaDVM?=
 =?utf-8?B?bEJ5ZXVmZi9ZVEV3M2Z6VjdIQ2ZkYjlra1lyOUpkRnR2c244Y2llWDNQMVdR?=
 =?utf-8?B?dlZ5cTJINkN0MVNoZExqdVQvT2Y3VTVsM1YwRWNFTW5aeHk5d05DMVc5Njl1?=
 =?utf-8?B?QWlUc1VwbmlzSTFxYVZqcVpSdVVxWU9pbUlTNktpaG92MElHdldqcTVWZEZO?=
 =?utf-8?B?VERFeEEydnpQeDNBbFZFVG5qM2JqNTFYcTY2NFRrM2UyR3hTc1BLYXloWDhY?=
 =?utf-8?B?cDlSME13RjhuSVBxeHErT0ZoWFY3aE1rRHZZL0JKRVl2TFVTN1FEV0VVQjE4?=
 =?utf-8?Q?pk/kmlhFgS2fqk7LgHGnUNo6r?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621fd040-264d-4dcd-764e-08db8e6f44e0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:15.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7VNosngJElp3aPuh8sfbZ4wb6FAwyvKFuY1z/QJfd/PxlLgyhSfshGQB/jhKIErm6ZGJigJ7P0wKXvMELRjuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 6f22fe054087..e9470c50a348 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -171,7 +171,7 @@ static int dw_mci_hi3798cv200_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, &hi3798cv200_data);
 }
 
-static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
+static void dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 	struct hi3798cv200_priv *priv = host->priv;
@@ -180,8 +180,6 @@ static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->sample_clk);
 
 	dw_mci_pltfm_remove(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id dw_mci_hi3798cv200_match[] = {
@@ -192,7 +190,7 @@ static const struct of_device_id dw_mci_hi3798cv200_match[] = {
 MODULE_DEVICE_TABLE(of, dw_mci_hi3798cv200_match);
 static struct platform_driver dw_mci_hi3798cv200_driver = {
 	.probe = dw_mci_hi3798cv200_probe,
-	.remove = dw_mci_hi3798cv200_remove,
+	.remove_new = dw_mci_hi3798cv200_remove,
 	.driver = {
 		.name = "dwmmc_hi3798cv200",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

