Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250377647AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjG0HFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjG0HEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37813A8B;
        Thu, 27 Jul 2023 00:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX9PqmCjPrUIUtGkrMqDWSN3SqmyxtHC34ny0Kqo3wrXWY5azf2kh9CX6vNdTNEtGR98BYA+7x/t66pykVAWoJ5ZyyKKQ0FY8zRuFJiomUdK00ryWgzl3xETyeYqWIb+ugEMeYifYn7zXRr3EzsDoxxGRq9ir3vEGujBScjj7MsldVDQU2RzJzv9RydJNAe0D1dkXtwVP/ZquVGsbAIEPCs0L4yTUzi98Wy1C5SeYXqRxU6ZL6raTgIhk5T/LXMU9CrUWTL+o1qMzK+vTCxwEKKi2uptz5JZ/CHjHpxtgADeaNe2fTTjeMSJJkE87UTWYodvuJdik9Goiqu38htSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+10ydIUPO5ixnkrhznKc/nkVD1LxngV1Yz/wNMbmTJc=;
 b=dNYuZKxvb1ToFxAb0MW9pr3+O+20ZgiT5P94dI+BJ6Vp61IVEHmLw3W9ziYonNCzqQQ1aapmU/GHHqWt0jn6C6t2jkyhAqilp2kmkBcU2BH5Lo4nnFd+mikfYzsuQbMqYNn5gW82PpiReK0WENqmFFi7b1Re6BgOLsuo7uIuptud5bHQqA+RXCEVDeFSa9Lrw+Zhwt0mz8cK1znWrP0zptZbg4/Cvp//b7xGTOuoZQ4mlxln57GattCUXSxW2zelMSPHBqqAjvG4wNh9z8akhWg2tdrf+Dd35Mt75uCd/jfVqZqX95QLxV0Cj8y0HT3Mxk8mtXlCXDQyO2Mkh2VcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+10ydIUPO5ixnkrhznKc/nkVD1LxngV1Yz/wNMbmTJc=;
 b=pYvwPbyPIqNG83Ro4tvg0I/eh4R+o0YMAZR1reAYzLvUDKgeSVbxQcdUjS4OfIoq6+wGjJ5k7lDKNxmIDq9RRYH7+YUGEUXim434tZwT0cG5VUAk6a2yZruQU8XoZp6O33fulbcIHKeztDDiuZ0pf1u/73byyLrtacgkzWe4T+NB/bWkpBg5VtEfiDzEkRyozd8Sn5Vyq755hAJ45Cm7zABwedLJr2OufR3XHKYL7LOPUR0VUKSb4x5lI+sWCM9JLbRRvE/6KLjEyoEMK38PDLGQpY7NZxLm9H/ldZG+/l2uFCWMua9b4EpS5lMQ1GNSUOUkYVaU5PdZM13c3k5zVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Hu Ziji <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/62] mmc: xenon: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:09 +0800
Message-Id: <20230727070051.17778-20-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ff12549-9538-403d-fa4c-08db8e6f509b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjlesebFxVEvgi80YwEgVinyAMYDLi5I2Se+i6K0SD8lruWBgfSRkV6PjKyrgOZCrciMseaOuX6qkbN9bIfQ9/ivFgHlu+0Dd09vG1ogiEWVC7C3cI7tjMgSuewfJ0E0txFd85ZXIy71Tlzp6TfqoblSG/WRJPbientjufiHqDVCnka2SKD0VivhY2AOYZmR77ZfcPCHrGXsmRh7IffzdHYiJ68qqoZcm/nZk0E8/BNReqUI89EkWlLFnroFPj5ItMMuKKfAXkHZs0EQDpLdv9GlVBR1z76Fu2smI5MaOM9uiQrrGf91uC5nRJFovw6d/JFFWCB6z30g4UyFPOE13lG5IujSt2qxM9qzT68ToHYr+BbEt+xYlCfitl6ozcmjE+sP8oVttwpLJuIKt+EkU7bjUCU0f5j0uXzV/hUoJv/M/7nH6as3kynU7C+ldh60bcRqtcA9BzhA1C5ckngOdPzfDEGbeW0VfGn+cpPsRyeKLC1vvcBtCL9WMk5y44MO/jiH5mTSkiJM/OVyfltGJ5Z+jEiI/oTnIx7nPwQoLrx3NE5RK5/qaFOelGjCRtpeQ7YwXtClOyCCARZicqfaW7CKMho1Wz5mUhLjglxzQqRBbx5oIHzXGE29EIpGpL6B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtrQ2VZUEJmRU1WNWpYWGlCUmV6YmdlbFpFbEFQc1VaNWNjNWQ5ODkyTlI0?=
 =?utf-8?B?WFY5dGFJYW9rUmFoNkFHUjN1cTRZdzZBck1aTjgvbW0zQVJzallNNTdZWEFZ?=
 =?utf-8?B?eFRiK1JoWDd3dm55TTN5bUFkSFBrcW96VjJoYkdFZzlmY0FsU1ErNktITlQ2?=
 =?utf-8?B?SCtZWTZtWGZ5Y1Jhekd3TWJBV2FiSEdCYkQzUXhHNG1wZFZvM0RzTlloZEIv?=
 =?utf-8?B?d0lDelZ6dnZxeWVabUJoZ0V4Qk1nYkoyT21PbGM3VVlGci9kYTlVSmNLWHNh?=
 =?utf-8?B?MDYrcG1uUFBLWmZUQXRtVCtud3RnNkloNUdNV1h1ZXNNNWtuMDBINlF6ZTFU?=
 =?utf-8?B?Nm84WDJRODdidWdSWEgrMDVYUUxGMzBCSVBPcDZIbzZFd0Y4Qk53VWZCVFdU?=
 =?utf-8?B?bEpCRWpPSlJqVzVkMUZkbndieWo0YkhoZzRYclB5ZGxGWEpNenYxOHJoVmc1?=
 =?utf-8?B?ZmhkWU5kY3JKQVN4NjR3VVdSMVZLYnlsS3pnMHordUZ5VTNJaG1LVTZQOURk?=
 =?utf-8?B?TTdNYmVOSkZicHJqQVJqeWl3MFcxTVJBQ2xVWnEycDZsTUxWVmxSSWJ1SUpZ?=
 =?utf-8?B?ZmpmNlQxYWRPb2VBWk5hcHFuVTdrSXRJQjlzRysvRmJpdzJIcmFCdkR4bXBp?=
 =?utf-8?B?dURzdTg1TmNpK3UxYncreGlrd1pCUHBvNGduNG5CYVJ4Nmw3NVVCMlJzMnVj?=
 =?utf-8?B?NHIrQlRZN2V4OWJmV3lJQnRBenYybG5FRzkya3NWY25saENONFdxQ2hZMWM1?=
 =?utf-8?B?TmtuZFJ4MXVzaVJ2U0x5ZkJsdUZrWmg4cWpVTks3ZkMzSEhUYTRPbXdteS94?=
 =?utf-8?B?Wnc1Sk5nUGRjY1hSTlVoc1YvSHVLcDRtaFozalFzRzRSRlFlR2drQzkrOTha?=
 =?utf-8?B?enNlVG9YdW4yOFRCMzhTdEs0Vy9LL0JZVzhHUzcydGJtRmRNWVVKeHdYdzRv?=
 =?utf-8?B?TW9Pd0xwSEJJNVp6Q3gvQisvQ1lpRlhIeFRnYzhJTWorNHVOMm1zN3pCeDBE?=
 =?utf-8?B?R3lFOUJlaUdtRHZoOU5LaVBDUTJaaXFac3VRVkUyM2dNZ1d6OVpsUDB2OUdN?=
 =?utf-8?B?Y0xMeTlKMGpINy9wNjlpWC9pcFhvY2lWSVc1VDdWSzd2RmE0S2J2bDl2OVR3?=
 =?utf-8?B?SU52WmVuTHp2YmppZnlnQlpVc0d0cEZRamZkNFJGSTZiNUFSWlRCN1hTMk9H?=
 =?utf-8?B?SGpidHlOS2t3OERsbWErbVJxR2F6aWg4S0hsaHREZDMxMU13Ky82b2IzRm82?=
 =?utf-8?B?OGNXNmdhNGlodTlFaE1hWXROWVd5cUNhVkVEUkV5S0p1YlpkaHYrc29jcGpv?=
 =?utf-8?B?Vkhxam5UTVQxVGZSbDNvVVRYd3ZMODZQRTIxZHVuZ29tUllYZFdGOEpPclhK?=
 =?utf-8?B?dFIvRHFsa2YrNWZDL1REZmVINWtvcHdJVjFjSzR6Y1ZoUjhGVXJFcTI4eVJM?=
 =?utf-8?B?ZmgzOGxjdWIwSnMwU2krWjQycm5KeENhY01ZU0w3VHRmeWFmMnlleU5WKzNH?=
 =?utf-8?B?Slg1ZHp0dUM0bUM2a0FWa1phSzMvK2RZaDJ2RFlCNkkwME9USE9qQWtNK3Uy?=
 =?utf-8?B?ZGFLUDY3SVp6TmltQ2ZGVUp6bXh5RDliRlM3Tk95R1BERkIvQ0dqQUltOXNK?=
 =?utf-8?B?dHcvdGtGSjlYWHpsR3pBM0ttODl6NEVhQzFVdFdoa2dtNzJkd0xXYTdmTkhG?=
 =?utf-8?B?UGRIRk1JUjRseVNRbTZ3STRZV1RXTi9aVklWT3B0Vm1uNVJycmV2V3JEdTIr?=
 =?utf-8?B?UUhXTTRLZjY1cEFVNGRjSmMwc3BwYWNsNFFvblZjOEpKdjh1Y0FkZkdKNk5F?=
 =?utf-8?B?Y3VMR2JFQy9SbEoySGozc2N2OHdYWlV0ekVTMk9pU1lwcmFDeDNXeTc5UDRp?=
 =?utf-8?B?alBBYTNTbzBFL2Y0MzdjNXYwTk8rVHo0RUIxUVVFNjQwQnR5c0NhVjJyYzFl?=
 =?utf-8?B?KzB3N1RzdXFodTJJRlN0N2tVWmtlNFJqL0Rzanhla2Q5WU1KSzRjN2Rad1p3?=
 =?utf-8?B?eDR0ZzRpc3NUMEdYbGlzaWdPQ0RYcUd1UVZ0TXRSOFhtc1RpODh4bXRGWFZx?=
 =?utf-8?B?OEo5azk0SnVjWmJiVm84bWw3YW1HYU5NaFYrdmM1RWtVMTJVWCtjNkoyaW1u?=
 =?utf-8?Q?nIjVrlbKFdI/KzlsWbq3F0wG1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff12549-9538-403d-fa4c-08db8e6f509b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:34.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cev87AmiUCDQJyJCAHNsDhilt4/m9ShoONRAslXOlRGQ2zFQ4PH7kAbN4+k8hbHltXlo43mkuaeSPpJz7weH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-xenon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 08e838400b52..25ba7aecc3be 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -578,7 +578,7 @@ static int xenon_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int xenon_remove(struct platform_device *pdev)
+static void xenon_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -595,8 +595,6 @@ static int xenon_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -705,7 +703,7 @@ static struct platform_driver sdhci_xenon_driver = {
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
 	.probe	= xenon_probe,
-	.remove	= xenon_remove,
+	.remove_new = xenon_remove,
 };
 
 module_platform_driver(sdhci_xenon_driver);
-- 
2.39.0

