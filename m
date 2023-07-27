Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B015B764789
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjG0HCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjG0HC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:02:29 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B19E3592;
        Thu, 27 Jul 2023 00:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9Ko/a1Xzq86tWXhh75VtVCOnUh268CpV92rTYVJMnRiXvL24iP+08Yz6Is01BCXoHBGHNsed0tM0v4Wei+cdczn6668WWqlyNAumDWa6tTszjuVkM/61eXaWaZz1FR8w92BtjqEQ9ermZ0j8yQL30qkTGziyYbE3ufZ1t4DUkcLn1BbAMVF7B4cYimztePBU8gPqOC/qhD3JNf8Myb+kbynfWDvZHXh4WunUGhvNpffHztUn9oS6nZx2iyIqJEa3VRc70IAHHqvTWMTIl2AwmPtw0DWLLrlZ7oKmDx7JtOpJ87+9xyWUNfWz3gG7RWAFC7L/9NLcSlc7mAbY2HJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nbEbIK1DWhnXMWnkEWTsr0nKaN3qrg8h4rvOqRdbbE=;
 b=Xnt/151wqkvC6/Jh++5/hxtruakhTRH9p0xtK7CMn9LjD+OWi937ql35eD7MYqQtaereSx+IHyWlLBXJOIYy91wfwnJjclwapgYosHy56Mu5EJc9PAi4zXWgU7GshUMWl4QK+78z/L3ujH8Pc+KraCByzIDru5S7u1JKydMizQS/5GKMvM8n+T0NCEpTlNsCyy54dyH6bUSSR/S303irzf2sc3w/IJy50DZsW+0IZGzPOgWIUKGePljq5u6FzqFo0E5SnMDriPWsaNJy/PG5DbLRePt2s40C/NPLhTR8g70OCvCbITyw1wkMMPe3LDnUU1NKdZW6uN5lXMbtpHKPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nbEbIK1DWhnXMWnkEWTsr0nKaN3qrg8h4rvOqRdbbE=;
 b=YUNtcaKLwv8/ZZuC6U/6lD7lFTqlpXVZsTrnxJlTyzfggXETkO82fJzLAUVV7YJN7yatuhTq3Gp9B015TYIpIbxPU+Vj14f/evPp6FGcjQv9PDIbQh6RQbvm6frfo3AROUFI0JEPKxrsnQI+hMxCi56ZbxPIwbZmr/jMa/GHrTbAA9nVlMV9ZkMrduwb+9NGpJtk6RI/Xwv+dx+Xwi3Q49VA1Jp+zUuE3AnOxIrI7wy3gXzb7pA2/zHWOE/WTnOVUy0oHG3xzwZSsyLg6ty5+KQKCTbYQjd3vlMgZGvELiFvOJIkzXspoTD/mrCwLdpMP5eShnyFT77zoKIWnd+oAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/62] mmc: omap: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:02 +0800
Message-Id: <20230727070051.17778-13-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ccd3b512-4acf-469f-0e1c-08db8e6f4a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzd4MR0jchwhJGrpDR7ai7lg5yVhvNXKpX1X1oTRqYUMJuQle8gZlZzAo9ihkKbgxaGf70QUbqtWDwR2IacvN+CzynYfGaNrTpD/UDoTUyfn0ARdxYjxlpfKx4cnafYxpJBzoa2saHJd/XXSuUbKx+MSKgPMWlrFIqjtnx3/QTazH6l5Rxz7Ap8wRSewk0zxV79Kkw+p9EjBnSjT8fFeU3SZ46zBwpIkrBMxtS8vm+6pfCCw/dcUEYNgccZP+OUSfNKqzaH5NEABi2g/CfoZ84xjOldVuOb+XKgPwl4e/5EDs4lvLpsXwtb+X2M/NXhdN/cBXofoFenA4Tu4HWEQzogR3ZZwsozfwFasxtHzuOzbdYd65F5XXNLDx+iuMUsW4r7Yz8a7WKnZN+80uroGAhtg/OgaX3l+FSq6hd/d5/Xa60BUnoqvHuvzK7FU3CdLIrWvfLG5nXeXSZHeA7AD6+AHnyak0e6rgMuJnI84T8oH6eLdjdNgbxtyTloYdPvo3WzlU6b5SpMaq54zqLwVY3CEcYk5SnR8GqKsiZvUpmOJ1iQjBqx69D1ri6XyANEmvszpTASLXRhDElsj1YzZu/KDr5BqaJgwI7KtykA3gWL7HVS7nJNhoKptvtbE9fnD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJUL3UrM0hMV3U1M0IvaldnSk96cW5kT2lZK3J0Zm9TZEQreUVBM2RaNHpn?=
 =?utf-8?B?cU95eUhaalgxclAwaTAxNWdkRCtnTWtiNmc4VkY4bWNpVWQxVVYxZEtLYW9W?=
 =?utf-8?B?am1VdWdxNXZmUm9NaFo0N2FIV0ZUUnc0ZG8wUEZzdGdPN2pJcWpxc3ord3Jo?=
 =?utf-8?B?OHgydU5rK20rWEQwS0dnT3BJUmJRV1d2Z0lZNnRIUWhjTHAxcjMyQXhrMHhO?=
 =?utf-8?B?ZXB5WjQ1ODJzS2Yrc2FRcTJsS3R3bmRJbms5V0EzWDNhaTlnMEwweHZKbXdz?=
 =?utf-8?B?OEZLL21waVRsdUljWjhKK2FJM0QrQ1RMY0hYeWtpNlZjZzhDdG5PbkQ5K0dD?=
 =?utf-8?B?NzJHUjRFSjI1VHExYzdVZDRZUEtxSHpqUGVyS0pUcWwwU2RjRWdmTlJzNko5?=
 =?utf-8?B?YnBvWnN3S29uK3F5ZE54WEhtenFuTXFkSExvck1tMStpelV1WFRDWXUzcFZQ?=
 =?utf-8?B?aFJBRXFhUU04SWVETS80U0dkM0lvVG91clUyVkdEVTBsTG5UTVJFNkMxYzFV?=
 =?utf-8?B?SGNjOUswQ052MFdyb0ZUcEdaUWhxeDlUelNrWndEYTRTaXVUYU1JUlN1ZFNR?=
 =?utf-8?B?T05KYkxTTSt6d0FHa3JMaGk3MVNISHRwTmNCQXA4ek51TXFlUkJLS2N2L2h1?=
 =?utf-8?B?Uy9rNDFMdFlRYXZUN24veEw5K2lxQXl3NEFiSzBNVkdRVUFMeUpWdjNMdHM1?=
 =?utf-8?B?d3pHU0M3SE1Cbmx4Znl6Q2ZrYUx2eE55b24wNnJ6T0MycCtVZW1BcHVNa2s5?=
 =?utf-8?B?Qkhlb1kwUStPM3JrdFFkTlN4Q3VNS1ZOaWlZU3JBak93anJxalkyRDdMc3NB?=
 =?utf-8?B?d005K0pwV2JxMUNBblc1TC9YbVg2a2hwZEFRUS9lQW1oMllkLzBkWWpXUFl5?=
 =?utf-8?B?UEF4VzdoZVhITDM5UENXRm9nRHdoRDJsbGZCQTBYdnVseWMzZlJIRkZPWkxv?=
 =?utf-8?B?bTBoSGpBTGZUdFNtV0hndElEc0k1bGowMXNNcnRCYWhDNHFybTNrSU1xazV2?=
 =?utf-8?B?d2V0bHRSMktKbUFBYmV5WmVWaHVnS0IyV0NnTFRGVXpXeFpFRWtjTXlXQitZ?=
 =?utf-8?B?SEZnYU1FSkxMR1FYSEdDRFRKdjFkUVZEc3lDdEZSYzFGQ3ZzMEIreHUxVnlP?=
 =?utf-8?B?RjNXMnpjUzIxUm5NY25WeGVhdXdOSnNodmc1alVMV3B0SU5VWEl4NGwyTFl2?=
 =?utf-8?B?UTNLayt0ekRlSXB5aW9ucEpuVlFQVVhhU0p3b2JVeXpzR0hsblRKL0ZDTHhO?=
 =?utf-8?B?OE9UTjlYK3BycnNRRzdhZ012cHBob2tSRUgvRXE1K2RaaGI3TGtsNlVTamlY?=
 =?utf-8?B?TkxOTmRYZ09iSTRmNHVaQnF6VHdnbUtqVmNaUm9UNGdRbFBIMWtrVjZBMlB1?=
 =?utf-8?B?UldSRnN2NkJBWEVQS1VaQ09BUkFzTTNPYUxOMUFzUXdkZk0wdDFWQ1J1M3k5?=
 =?utf-8?B?YWVmTGZYTWRud3liUmdjdFgreGNRRk1SMzYyWWZoUkt6eGtMd1A2WUJGa0FH?=
 =?utf-8?B?bmtUcXZWTkdCdEJsenNCdER6aWxZb05FM0E2cUFDVzBFTmR2MDQvRzFZbnQ5?=
 =?utf-8?B?WmEzNWM5d3Q5THo4bUFkZHplbmN0SGs5UlNWOWZhVUZSYlBiUThyRUIxd0xK?=
 =?utf-8?B?Ny9MaDdaY0s4c0N3M3pXYzJQRzFvU2tGZ1lPcldXZTQ3V3Q2b3IzSnh5ZDRt?=
 =?utf-8?B?R0liZ2pSQ014NzkxRjZzQ1NHTC9hc2Q2WVp3d1BkSXRNcnRRcVFaS0o4dGZn?=
 =?utf-8?B?TTBVV0FHOTVhMkJCbjdtTGRSb0VzTkJFSVNlTXJzQkhsRHR0ejJnaW4vWXBz?=
 =?utf-8?B?Q2pWS2pZU3VPQVJuZTFUOWRjcGQvb3RrV05GYnE5SVJCWTFjWTF5WUQrUjJ1?=
 =?utf-8?B?M2dkR3QxdWJCR1BmK25YUGF1K3lJcHJnUmtVc2NaUEpOdkNJZlhZNkh1TVFn?=
 =?utf-8?B?VmlGREZKazc5amdXclc4aXZFRTU2ci8xWG90ZEI0MkVxdXBwb1NrcEpYN0xY?=
 =?utf-8?B?azFDc1k4b3E4amtJdG1lbU1lUXFzbzdjUE5lM2NpcjVhblZTMUxIanBOeDJ6?=
 =?utf-8?B?ZitGeHdnbnlRZlpwVWw3QXY2c3NoYTRJVXZVdGthbW9SWXVnZDZMUEZhL0xr?=
 =?utf-8?Q?zHFCjrwLfSfILKn7wPs378Nnq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd3b512-4acf-469f-0e1c-08db8e6f4a09
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:23.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnifgsNW4mhDCHADTp3ThZiQqtwkSGzv5MOq6BUPYTA1vgX/iMt/TMEB8niwQdQDS3Rs3VcyIfdNC60DtgGPZQ==
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

