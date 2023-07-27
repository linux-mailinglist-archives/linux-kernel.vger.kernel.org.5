Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B271D7647F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjG0HKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjG0HJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:09:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D74C1D;
        Thu, 27 Jul 2023 00:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvkHurdC6Bsf/dlmd8nGKveZU5XNdV6VtQOUpSBlt0yVzq1nDJYVt2CK4jvMckCmhKi3I2QSkxBtHJQvKqAMfDF0uf6udYa8Juj0ehm5Oq+197GVuoYvRg7osX3ktlreHW/LaFfcrDyv6QM2dWBZAh90Zr67SS56wPs+N54o3/a3xDZkDwe18eIohsEwfqjWsEhto2M8qAob+0JpXTAqj2PcKt2QCejzrmj7PVyxxUMBAtIXb25Dkv7OTGkhmhxy+E7tvJ1eRxjj6VNLwBPPHRcZ2KDxVwjyrEWSK3sd4n0b0q5tyJhbFHnl1eqkRbkv24eWs6+afkkMEjK5a5pTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w/6Fs9xKHR+EexM64kh9CpY/b+Wy9xMwnRnCjo2yD8=;
 b=UeV6l2Q9wdJTzmLcuiyEOSUfUHghSk7kUm/sVr0NNODBXvkC0XcEPY8Ry61kD9tWSi4kQ29WqeR0Adzdut1pk0X1erciFstxZh8eau4cGMeuDGE/seqC18OdyFScSfWSdUHmacIBtezkJ3Qq/M2dZiNU137/PTmbLwvIPgAGjWYazzY0KwX7dxMwWjj2CGZK57+iClDFeQ3ZYj4A0ZBHwrnUplP6zByx5ewJK9X0DDx11v+s59EiawBSBzfRJSxSZ5eEzdqf2ZqWeAlWVhvcEe54ue0l6rI7hiN4cko1fbmd7BVWkY38blsi5fsmq1ic5BQjh4TFj22epaVK9ZGhTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w/6Fs9xKHR+EexM64kh9CpY/b+Wy9xMwnRnCjo2yD8=;
 b=MFFJfyPotjjQxf3vBJS1sL4JzAC/ZnDfPvPaA6rlZ5HO/I77iadavi7hfHqGrJkTGpa6muhfa7jyKnM8zCCzjvh2e2W7bMbnVTaKtkiy4ytqiMtPXMywKpeWG/nCp5xv2zeSiCGJ5OEGk9XTfTzog4aI2eeGubKDYTOxV9Sc/eHuNdiFWcqVw1S+2sWEsSnUb23UVFcD+yKXXItl0svQfSwhZn58Z0haPHTEathdPetAeN95h1t/EipFIOQOttRhzS9/q/N5m0vl1IuLUHilFsg03md26PGPVHZ0UB4UkiFut6pJG/lbORmCIcAP+lpamSGa/bJGBwlB/ABq/vKu3w==
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
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 50/62] mmc: sdhci-spear: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:39 +0800
Message-Id: <20230727070051.17778-50-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c7819afd-98f6-4992-d65a-08db8e6f6f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAMJNADZb4w7SVadaLBU8cEVtjUkVY6UCWujfRyiF56f4/UY3bOX1jvmmZ4yNwioyrokZAAEY2ZLFNadPAxHojnFjncNA8NgPVhq2vA3rxk0IfV6DR6Y2IGlW7RWH9/UtvySYmACLtZXc9ozD/CbNgM8r/yZe/iEpBvGhOkGCv5iwFr4g3NWKtlToE2/vAknhLraBzlriG9ppiCuWOfac1EXKUhsV/AWvHzTD7m3Bhjt3h21t3iJbxz2lmwNMZjWz9eWVTcbzZC48K+wd91IaY+6RxzSQXcWvkS8Z64hGslzYutSG7SJyQL9gOf2dgYbWfJ36EPnqeci7me4yA5YRnGTlOsTDz//9Ou3fc7gkth/ok3j4W2BXDjm46dnrF8zrvbHVl5s8o/mNkVRVWyLMeuioLl8wCWZsEicnVc6LoHuwSzrl8+ukE0l3Kl5oUGsQdbMOkcgLrDw2ZFapXksjlK2JPndsRBHbli0VAk8O8cgpRW3sT+7L6a+iLU2uu5ByqPUQq3DOLCuQbmrybUmkE0GgCxDnGcWuvtVriqORcbpApV9vneUAAOfakeR2jv+HErdpfNZGZNzKs0fCatGKXpWxhH74iPp2idNZ90r6vhEIwqIQ1g0HM+kQj2424QD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6666004)(110136005)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkcrNWdMUDlBN2lWODFxRFMzOU02alRrdzFkYWZoOVEwL21DOXZxRVp5SURw?=
 =?utf-8?B?bTBMYlBJeGpPVXBmODJWTmZEdWxXek9tM2lla2VmZythVmlIbFhRNjVtTUpo?=
 =?utf-8?B?ZWxsWHBSWUFzcjBxRW91bkFZNU9UU0hLdTVZTjhLNEt1aGRmL0doUWVRREpl?=
 =?utf-8?B?Vk40b2dEWE9IdjdoUWVkWFZJVmdnemJIUmlzanZSeWxJeG9VT1hYWXN0MkQ5?=
 =?utf-8?B?aFRaQzRlcDNyemIxckpCNUdqQWlSdWNRcFNiMjl2NEpDbEFvNkg1K2trWm9u?=
 =?utf-8?B?bER4NFNxKzVRMGtlQUFXWkg3TVExN25NeHZ3eC9WK0dsMk5yaGNkc3VVaFQr?=
 =?utf-8?B?YWE4bi9Lc1FXd0o4amh1UDBPZ200L2I0MDVBNVBYU1psVndOeE5VSnJibnlU?=
 =?utf-8?B?UHJycUZTaW5pVmhaMjBuYkxqR1RxcTVISHgzZDQ1c29rS0RreFcxT3dkcWhU?=
 =?utf-8?B?UDhkVW8zYkNjQjRPcXZRTStZNFd1V2hSVHVwVVFjYkovSWtTb29hR0lOWDc0?=
 =?utf-8?B?c1NKcUpySFJjRzRzRUhwOUVZWE5Zb3VBWVEyT2FMTitNNDNBQTlPODRyWnZ5?=
 =?utf-8?B?SWI5d0VTME1LeDBITXVPd3pjdWpTYWc1THJiZ3o2UzBZRWI0VE0raGdFc3Ro?=
 =?utf-8?B?ZnNkRnNYbEVOVUtwd3REb0RHRW9scnlPT0tRWTBCblBLdHlzRnQremR6MGt6?=
 =?utf-8?B?YjVRVXBUUTFXaS95NFZzY0JpUDJTbm8wN1gwVzRrZkhjallWZVBSZmdPOWVY?=
 =?utf-8?B?V3lNUTgzRUdLTXJGOXVnSC9EaDR6ZTFsbWV1bTFZUVVoV0t3NTNiSGJybGxi?=
 =?utf-8?B?bEFoUWZ4eG5kd1FOTzlyNTQ2bVFJeDZoVngxOFFxb0lydFA5WCtKK0RtYzFr?=
 =?utf-8?B?ZE9DeGIzL1FvR1BvVmZ6NE9lQ3AxV1FCOEdLTmZ6aFBzQWEycUdNRE9QR3dP?=
 =?utf-8?B?amg4OXJKTGlOTFM4S2MvNW5JQkdRUEFGWmkwdVV4UnZqV3VjaVQ5SU02Wkp4?=
 =?utf-8?B?d3c1MzZlNHNtRlc3TXFZNXozaTdFS0twOWVCY2ZBdWlSaFZ2V0JtYUNOUTNE?=
 =?utf-8?B?VEdRei9wOVBEd01oZkZmS0NaK0R6cDdNbS9QSXNENlVuYmNrendZOWdKM0wy?=
 =?utf-8?B?V2k3bjMwTnBLaytySW5IbXMwbUxYM1VmUHJVMFBndTFyWDEyRTE3aWV2OVVD?=
 =?utf-8?B?Ym5pTFlzM1ZCR0pQQzM2Sk9Bd25IcXhMdXBhdWZjOTlQcmJNRFkzMVR0OHJw?=
 =?utf-8?B?Q05OUjl6NmduYmw0TEFYSTNhaWhXMFVHM0JiTE5xb0t1V2hhMG9VVTloTkZ5?=
 =?utf-8?B?cjcyWEZZVlVnZTFLYTcyM3R1MVFrcGR4OWtPY3JRQ2xxRFlBZ0J0ZnZwc2hi?=
 =?utf-8?B?YWJ1ZHNtOHFtYkdnZlZ0NHBsS3JRYm5seDMzT2FwQzlpQVpQODBHbis3N0tG?=
 =?utf-8?B?TTJCNktFUThsQ3lSZkRsdmNrVitIT3RkSmJHZzE4NnJqbkgyYXlGWkRwZWl6?=
 =?utf-8?B?V2xWR2NXY3hCd2ltQm9DMWNVZ2s1bmh6cVpOdlY3K1kwcFl1VVBVSC9wVkwr?=
 =?utf-8?B?ZWNheHFnYTJtTm9TVkRqNVh5WjZtbWVLZFgvMXNHTzZPeG9aREh5djBPWk1W?=
 =?utf-8?B?RWozRFBsUTlHZGdQRkd0V0o3S2RVSUFObXl5SUVvT1NaNnRFY3kvdGp4YTlQ?=
 =?utf-8?B?aHJKc1JpVnk2TEFpQWtDT2lsRnN2QlpzS0ZKYTRKZFJFdi9zd0tmWit5Ny9v?=
 =?utf-8?B?UFMwNXdObHVkdmQ5VUVidVRMZnpFS05BaUQvQTNIWnB5QmpoQUlNdTBnMmgr?=
 =?utf-8?B?cXo5VTliV2J3Y05UQ3h6YnZyWjVYcEtjMGJFMTZiV3IrbGVKZ1B6RDFkRXlR?=
 =?utf-8?B?eERRRk11cW0yR2VhQk5sTnVXclBqMnRYdVZ4MGNYanlxZUpYdlZOUllYMXJl?=
 =?utf-8?B?aWppYnZjTmpCTFdWUTJ1VmJUblFUZTczdHBiVkVLWHZSM2gzUFVGK2NvMmd6?=
 =?utf-8?B?SHNTbHJ6aVNOVlNJNUJRK0xQRzVnK29OOUdmYkxaRUhhZ08vRG5ES1dvTVV5?=
 =?utf-8?B?bkEvTUFtc21OSzZkaHZaem54M3NRODJXT0w1TE5Bb1JrUVVHdXJEcU5xbGhJ?=
 =?utf-8?Q?+HdkZG8gmgYR5GQFi2E2d/h14?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7819afd-98f6-4992-d65a-08db8e6f6f9d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:26.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9ALygSHYvuPPJqeEVbHKGk3SatsPF2QpC+PXShpsyMGH70TcCWKphnpUvQV0dIhQhBH22V1MJ7o38nvRtpMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-spear.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index c79035727b20..ec6c7d8e3736 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -117,7 +117,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_remove(struct platform_device *pdev)
+static void sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct spear_sdhci *sdhci = sdhci_priv(host);
@@ -131,8 +131,6 @@ static int sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(sdhci->clk);
 	sdhci_free_host(host);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -186,7 +184,7 @@ static struct platform_driver sdhci_driver = {
 		.of_match_table = of_match_ptr(sdhci_spear_id_table),
 	},
 	.probe		= sdhci_probe,
-	.remove		= sdhci_remove,
+	.remove_new	= sdhci_remove,
 };
 
 module_platform_driver(sdhci_driver);
-- 
2.39.0

