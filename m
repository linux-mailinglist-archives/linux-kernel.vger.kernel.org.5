Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6DB751AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjGMIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjGMIJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B83582;
        Thu, 13 Jul 2023 01:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+7LzO2ESswEnHho59wiFdaQUo9TWJcrJdrYkYh0WTqIKCmdzhTzDx22yZ9dM/TA2TT/nhv8s6VFw6uSUuohXZbJKI9IZyPQNxNRtwGA/zX1HTXU+Ucl8q0WC46Qw2KvfjutlqX4KhRpIXhPeAuo5+zqgvXKsAJj+PIGa44+mwAL8LI5UA6NZ9bTu4nHimugctWG8uJzAwk9oelVf5/seP8q/nlyXt6FmQK7oBIvIv5NkIDmwgZ/FiZ+rJCzg5dY16pDwN/zkvrQ133NecEe3x1SHJvFW0KZT6kFncLHT7Ya6dtjrok/IA//jP+AMTteAIyxtm82NcrMeocuY1ZmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGmVUJSjL3qqF2yxLWtGfO+5IKk70aRQaFRf9uXQRf4=;
 b=m1cWayIbTldEt5v9nrkODjePljP7Qy2nuGdjz/SGIBspLhWwfztlBzuonwAO3yDTUGyNupzkpIMxkr1xSlDDCGiPMWZbIecqsCq7v+m6YdGSiI0ZqHHrFOl+fJyv6l/9TY1P+O7Ghus0FSCPygea5GmTI7FBzj7Z/zRDz7VnVq5NcHE1dMuTswKhcqdlE19sxnt9JkPhe69XOOuczvwcI5rPSgEkre04TLxmmNRPh2ZoCKkI2Txml9+mosNQ0W5TSP3MUzej8uZ8hZEXIutta2WvzwuDRu77m9y0OFyjHDSAWg0MDorDEXULQS4x7frMwVLXpQ2hrV/4VX7hOYXgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGmVUJSjL3qqF2yxLWtGfO+5IKk70aRQaFRf9uXQRf4=;
 b=ZCaz+22RWlwS3FKoHtLZTCCOJ7Y+gO1FFztXd78kX6G+a95T10Haqf7SLUoabvArU8bHb+3h9VeB3++yXUu+hPjSq9sQHY5BxajBZVfHRdWT55wcTeAf1STASwaxTc6RBNDDwofi4+4dqjLZEBtI6FPY3SrtXcyLIUE/6ZX6KDJedDk604VYqBO/I43E1iU64XtjLrzSf7iAJIRvmh9gU22/0S6/WSNqD2sUDrSmdFPtdaT/hjwC2U3RcBMqvTZWMd4eLMZcZ3Otxpii3ZXR8eML4dQNXd7EFZsjcui6Iw6iLxSV9AbMiucgoQF4/cWgd+BBiNEepj7zaba/cU4QfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/58] mmc: sdhci: milbeaut: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:19 +0800
Message-Id: <20230713080807.69999-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713080807.69999-1-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3944338e-25a6-4ec8-a567-08db83785bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JU5xiBp+9JigU0MgYTTjylbgYboReiMXfzOugT7FkHCibxFFqLoyw9oi/JMGkx0RNgwDyLzbe3Iy3qaMnYqxR8l5CRYwIByMQXu23XBvR51ZkScDks9jaNLnA/XiELUfg4hzPobW++EofqEmRAQH8ubl8NkId6ZX4RzKsheLMIH6+9pu8I5hFhfW1h3p38k+aW7DSEcXUZFHseJXbrOnlizkLjQUs8nANXNzmaD4g3s//Nv9ghgRJOU3M4x+/J/fqpxAuXGrDngIB3AtdNnacJELS2q5Yv5uLN6/w/DnkgtG9D2tbY4aPhHblYp4ahWmLY1eq1KrwrtW6BUduqbFp6GfNPKOxPmTqWSdJ5oHzenbmml0RnblmHJzdHbfo9r+IwuMMFOi9BO7ivGEr3t0WYXrqjZS14iApjusZUUNK3QIN7MZssWdpuxlr7LGifFyukKwMnjp1TMxIcDDveEOG+vt1TkAY/EOXbxV+jLpCbYyPz0gEi6wHKfaLrvE1ebfvtiyx/Bsika2lYYzAHHvGqYH/rRM4bmHb7UmJSMNOjqwH/kr8GLgqwssxepkNcyiMcbSYjt0fwmoho7huFPmD2p6ZvfgjrPPgGdT9+Mi0vOg/bEPHR6NhBY56KCUwuGxMwtDC6Adhxw3ZIEf8bSPyACiLmpPwZnPmZPQJ1kWuCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnUwSEtxSzNxT0dERGt1QzVzakZLTnhzaVBiU1JaWUhlem00cUlFa1ZpR3Z4?=
 =?utf-8?B?eGJnWDE0SFErcVJZNXJ0L2p4MUVzc1pyN2ozQWNrZjBWdnFFQ1ZYSTk0eDZJ?=
 =?utf-8?B?c0xNVU5tM3NhSjdVZ2NEZFRydER6U0wreWcwbW9tZU9iMFBEY28zL2djWjJ1?=
 =?utf-8?B?TFcyY09YMllXUVd3ZHd0ZHRUTDhtWFcyRlYyY3hIalVOOWM3SGFsZmlxbjN6?=
 =?utf-8?B?N2tqWkp3NHZZV3h5cHNCSmZCb2Q0SWhqZS85QjRHY1FPUnNSMC9QamFuNFJT?=
 =?utf-8?B?c0s1RlI1SFlkMW9PZWw2WU5GYnRzcUtGZzJ1TnNIVUFXdFM1LzNzemZ3aFVa?=
 =?utf-8?B?M2xBZ0Z5eHE0OE1VQUUzUGdOU3BYYnloZEppMnFxaW40K216WUk5S3RIUjBV?=
 =?utf-8?B?YUMzQVBzMWt4WlNQWVBHL0FDazdKS3BuSWhuSHY3djdqQWhYWXdqSzNaR0xI?=
 =?utf-8?B?ZStLWFBEVTkxbEFzZWkxL3gvWjVtUEFER2JFNFRWTFVLakVxbE9DcHJPU2pL?=
 =?utf-8?B?WTF3UmljZXVoNDlOdTNRSmNTR050MEFYL0JZdVF2eXYwR1ZycUd6a01VRWNR?=
 =?utf-8?B?NmVmSG05c1N0NGRWTlZUU3lvWllPMkRzd1dwSVhDeGhXb0ltYmVwT1IzY0N3?=
 =?utf-8?B?clJxUm01OHZRUnQ5UGVsVW5zaVVvWFJMY1NKa3RqOFZyR3ZxeTllSE5wd2N3?=
 =?utf-8?B?Nm9IeWgzRThsMGRsc2J5UTEvZFpPc0VDU2dZaXgwc3RLeEFueHJZYmE5Zldl?=
 =?utf-8?B?RVBBdm10TDBuVDZXdGY1WksxWFhEQVRZQkJpOXA4di82Yzd0bFV4bVVZZ1RT?=
 =?utf-8?B?WDR3c1ZqMzVEcUZ1QUNISjI2UG5pTytCR0Y2MTd2a3lOT0lOOFBvMXpzeXRW?=
 =?utf-8?B?NUI0K1VjeWJjOS9RY0JzOEFRbjZaaWp1UkloOFFZNXFGalBOVkRJRUcvV0h5?=
 =?utf-8?B?eHBmNlVjVmJXVHM1aFFXYnJ6ZEZjVWNqRWsxK1hIV3JiSTNNWXpFTUtTa2pX?=
 =?utf-8?B?TzIrTkttbytiZ2pLd2YvdGE5UVRVZUpybW9aSWJYWEZkeWhzMll0TDhSL0tM?=
 =?utf-8?B?Z1hsMUUrR2JLM2ZDNXJLSjdhTzlKQzJlUEkzNm10d2dQUlhrRXNJQnNia1NR?=
 =?utf-8?B?TUxNQWM4VzlqUXh1NEhnQVJGOGtGVXl6Zlk5T1FjSm8vNE1mc01RR1U3dlg1?=
 =?utf-8?B?SUFLZndIVHhnc3d1dDIxSU9iTmF6VUNDZUF4ejY0VDk4RmNjL1pLcDM4Nzlq?=
 =?utf-8?B?b1VHTmpaVk13WGxKODVFa1ozZkFpcjNxRThJV1FuTHQ1NTNhVkg3cGtEdUo0?=
 =?utf-8?B?MUZKUTQ2OGo3QTRCc2VJcHFqTDQrY29qZ1FqbmV0UU1YbHJ5dTI5UVgvSHFs?=
 =?utf-8?B?cTluSzZlMWlTVmdJK2htWEtVL3pQUmhxT3drSXNqcEhiYmNmZGl1aEVROEFj?=
 =?utf-8?B?NVJZWDRGZkdPMENOMDJXRTRucVBpNnYyOUplRnFxWGdNemNLdlVhdkQvLzhp?=
 =?utf-8?B?N0Q0VFNDWWQwYXdIZWZTck1rdDZMQzU0MDQyallqeDVZNnV6eURoNzNkTlFr?=
 =?utf-8?B?V1dndDJDK3VRenQ1Sis5MGlINXBlc3U1Znk1RzFNV0RHd2swcUFveHdEUlhL?=
 =?utf-8?B?NnJKTEIrVzc4TkpYaTRPQnE0ckp2Rzk5VzB1STdyTHljZ3VFU1BUKzI0d1NU?=
 =?utf-8?B?a2x2c1QzdTdEd0tWR1lBaDhRNGVnZytnY2U1NXJBbVVEY2NhbldCcVlmd2ly?=
 =?utf-8?B?RTlFOUxDYjd1NGRPOTlRdW9ONmIxbXB1d3pZNm43cHVXdEpyanZjL1R4QVBh?=
 =?utf-8?B?UFJJdERCZ2lxWUUzU0FOUXhKZG8vU2pyc1dLRkdYZ2ZtWmFweW4vME5vcDZK?=
 =?utf-8?B?ZFI3S0dpUGV4UHJSQVdPT3VUWHlxS0E0M1RrNW9XOTB0Z3JPUXJSVlFmeHhT?=
 =?utf-8?B?akVtMEZxTmFQN1Jqd1Z4emFHRi9mWjBvM2ZJKzJ6SEVoVWhrZ1g3d01BNXow?=
 =?utf-8?B?ZUI5OGRwVzdrTTNMYjJLVFhQRFZvVkR4YXdBS25RN2tKRHgvaFhETFVETGJ0?=
 =?utf-8?B?Q3Z3Z2tnd1RVeU1Ram5lMkg1dFhTQUs3MXNwd3BHU3I1ekV3RWlkMFIrNjly?=
 =?utf-8?Q?5wCkargQjjcaYl+SxJ3g9rr/d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3944338e-25a6-4ec8-a567-08db83785bfa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:36.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIlYVeMllta3UBADv+Ro8GLhAAdTge4YRG3Xyt1V1iPBKv1z9Jz5o1UMew+NpiEK/V5Vr0N8LS+VMqScjyz3GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/mmc/host/sdhci-milbeaut.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 148b37ac6564..ee4514c90eea 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -313,7 +313,7 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_milbeaut_remove(struct platform_device *pdev)
+static void sdhci_milbeaut_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_priv(host);
@@ -326,8 +326,6 @@ static int sdhci_milbeaut_remove(struct platform_device *pdev)
 
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_milbeaut_driver = {
@@ -337,7 +335,7 @@ static struct platform_driver sdhci_milbeaut_driver = {
 		.of_match_table = of_match_ptr(mlb_dt_ids),
 	},
 	.probe	= sdhci_milbeaut_probe,
-	.remove	= sdhci_milbeaut_remove,
+	.remove_new = sdhci_milbeaut_remove,
 };
 
 module_platform_driver(sdhci_milbeaut_driver);
-- 
2.39.0

