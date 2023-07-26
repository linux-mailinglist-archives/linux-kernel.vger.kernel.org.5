Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596ED7629EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjGZEHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGZEGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:06:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961584C01;
        Tue, 25 Jul 2023 21:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiEVMxGj4wwxvO/HM4EUYcWPWjDiOqHJZ2Z5rubUO7gt/66pcqMwlSPaRIo3PupxQGqXg4zqvyLfV24iX4R0gRnaezks+1I5zQGGoZ5OGFHz/M3meg3iLpVT3L2Qe6RWIEWmLLP9PefB+9B7QbQC0NmjmgqIApgv1hpgmZFXHOg4Y4P9TLZFBQZOgO1Jg2ATWPSNCZb5DaePnrjdFiytOB2w0vDw/D4RJz50GsPurVjI9Vlq7JkVV86m1mJc3ZfSParDZnPAhpoxMSsyrtRW+RwAr+94zkmpK6YIUP2B/0KTgrfCpdt55A0Do1ZvSSxBbuGIyPjCLoVZQ8tn7K/WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnEm4eeaXUww5eDuPQKSh3EIaMee7cr4msQcxUd2bqk=;
 b=YsTdP8Vk2FUKvEw1pu6gVOkmzBqtpVzQaoN2q8MH+49A1vO9+VUL47nvn7Th9oS+I1T6bDF8RLYyPmSTQ+HXeaxGaBpXYus74fO7c9O3AAMuTCoSkMZ69L2A8oM3K0ySTFG6GwOhL/pqwJZlemCF+ZC9YoO58fi0Z4Dooi4Czwe+2WybQy/WXSHMLVI8n7KNnYl5Cj3JzesLhlbcOnPHihF3Qj6i02MBtR2YxmXTk221e16NfOyhDiSjFqskLb4zBIsrAaJGynSWRcDGJTU+diu/SyI2ZQ5iiXykuIEYiWsU5b2f0bz7+nOivbkY3tXE7bu5jNZ0R7tdn5i9emWK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnEm4eeaXUww5eDuPQKSh3EIaMee7cr4msQcxUd2bqk=;
 b=XpX8JNNgsDBU0NpcRAlpkv4LC4qAnIst75cMsstYbenJ19n3MOk/0C1HveriffzjHqnr/SeiHJDoLprzxlQD1rGn4A+9SsWYjQ7IH4mTaH73lMlAwWrUOMSbSv3XhehflQ37UNiBXyqRCCmz5pYRoFXzQ6sRO/TpyEDKTdYjmYjVBne/F2BmvkC7XohzMet0ZupCuasyFKy7Qp8H+bs7zgd1tuJWXDqerUmGbtuR2BQUgHmorQ0Mr/R1G9F4kd1iEvHLuz5iDf4CE+D+eZK0T2whmIAyLJQ6/KMYDHW3SmNSjKqK948m68LglbYx8i8pjprcZmKNDdyt5yqTMj2wSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/61] mmc: au1xmmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:08 +0800
Message-Id: <20230726040041.26267-28-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83cb8af9-c32d-4acb-9ed9-08db8d8d07ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjlCMSSqqxqI/pug06QNmO+ufFz6YF0FtXzYzPFQUj0Q8TRRrpB1G3vVj+gSJQgzqxUprgL9GhxCvGKQGwJMKpxAQ45ENYyKLkCkyt+FrM94T40NKM4bNX60bU5H620PKbXFa1/bTMEhPpxGR7E12HiRoHCzI29jcHGCYHFx6DM01GXJ4BeLui/d999qRXvr2Na+zmX+XMZYJihB+2L6xF/1od7qbS//fOQNLpfoIMKPVCNt8XNPtjq1eM25+CHND43cldz94g/zrnRvNXUkuraEjCfCvjgmhL871BjNdPPe2jwcNRujpUgGS5ufEd7fHgny+5iaZt+odb12Nq51a/glqpa54tPvJ4e+q/80wFgq4uau6Qp926k1V7BfKCLYX0tIo/XrkagMUmen5VWJ6afsl/OpGCJQMa++ZjuWDEGb+Xk1HamhzqtmpDpBXo6X3hUwF+UgvrEJFepb8dBb3ZSuJSSZaqgJRHr9HQuJYL2zXYY01F+S3zdIO+VG6FCrFatyxW95Vk+OIj3PTlYtyWbZaclq4YnaADfkBvNy8G8oTKTKyRzRvwelUhn9lcA9nQae7vu64EijNaf48aeH8HYuETvRG8olwCEKzjT6vcEa8K4la9HCdmzcN6g0NzChiztQC4Klgx94owfQTF7kOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66574015)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGtieFk2R3lkYjVreUF3MEV1ZzI5ajVtbkVIOWFuTVVUZUZDeU9USXl4SlJG?=
 =?utf-8?B?RUloZ3ZzVGR4VTZTdExWYy80Nld2dHBkaHJ3ZjRDOGNpMlhpeVpPNmdHTWda?=
 =?utf-8?B?aXk1UW9oZTJSZTRrdUhSYjRvM3pDOStEbHM3c1ZQT245OGFyc2tkU3dETmlO?=
 =?utf-8?B?aGhIYmNVVmtvM0JnQm5TZk1JNGhSSVB0T1RnOElPVFZTOUtHV0JTZUpzYUJV?=
 =?utf-8?B?cjBta2o5bDBTV3BQOE9EZGJXd2NDMytMS3NEb0haK0d0enRVTkdrdFBWZm0w?=
 =?utf-8?B?SmE2dGpVc0dZRFByY1NSWTlTOWk4ZzZiUkVMZVFzb3lxUnBoaXYxaG1vWEoy?=
 =?utf-8?B?ZUN6VUFaUEhQSklqbVl5MXNTUGlINUw2VHJhcFB6VndzVThidHpXb24vdWRT?=
 =?utf-8?B?L1E0RnJLenlRR1dUL0JNY0pnV3M2RVZMWkhpRWExQVBXV2s0bFU2N2R1R2M3?=
 =?utf-8?B?emJmS0Z2bFBxSWUvR0QwYnkyQ2Jxc1BmaUVoVDBKQ1N6N3ZnYnZTbUN5YTJR?=
 =?utf-8?B?N3QvVTN3NDgreVo5WFVtYkNrWVM4S1Q4eTBHZjBkRmRnektETFpHOW1vODFI?=
 =?utf-8?B?WlFxTHFLcVZmdWRMUWdXZmozQ1ljcXlzOE96M3hLeE9ycXNFNGdRMFlTNTBa?=
 =?utf-8?B?SkNTN242YXdTZkdRR0FQTndiZmY4YkNYVXhzMm1SZlJXZTl4YzRkRlh3b3Bw?=
 =?utf-8?B?S0hqTGREc2EzL1RWMnU1MFZQZmFQb2V0TDNySHdJK1M0ejEwNzd6TVJycUk0?=
 =?utf-8?B?SVpZZ0lDL3lnV1FtNFN1MXA5QS9KS041eEd5L3UzQU1kK25lWG1IRkk5SlhM?=
 =?utf-8?B?bnMyalE0Z0J5SFQ0cDhUVHFEeVRDa2I3QlgxUFJuVjVhWDBHQkp4WEhCcSth?=
 =?utf-8?B?T3JSY05ObldCbWlqdVRDQnlSVjVSNFZyRGdnS2RPSVpZQXRXTjQzbDYrVkto?=
 =?utf-8?B?amp1dk5GQkMvZk1ETlJnMGVGQlBBZ3dMbWY4cVArNit1d1lKU3pOMnJGTmZZ?=
 =?utf-8?B?NllTYTljYjdmTHZMRURVaWc0MWVBTDl6bXB5a1pGWVpxTEI4M2xHcG5xL2lH?=
 =?utf-8?B?aGNPR1psRTlYcFFvcm5wZFNmeFg5U1VOUGFGV09QZDZESGxyaGtXTS9BRUJY?=
 =?utf-8?B?L2RkTjVFblZZdS90ZzRkWmR0Tk05QnIzb2UxdlNISjVjRzdFRFZFWkppcVVl?=
 =?utf-8?B?d0dERE9WeDlVRHU0VFBUcXFpUHFFK0Z1REQyNlIrNksxMjBETDJEd2Z0ZEJj?=
 =?utf-8?B?ZEtTTHFvT21udmttbktwWjJnRVJta2xqcU9qb1NoT2xHaWhDaExFcU45QndK?=
 =?utf-8?B?OWV5UTBhOVJVcWVzemw4YWRVeWlEZUR3NW9LY1N5Y0k3akJGQzBwSzJ1RzBK?=
 =?utf-8?B?VVlYZHI3UmRsOTZmRmo3Z2ZwMWUxWHBEaHBzUWd3dTBRSkdkeXVSZDJzdk5a?=
 =?utf-8?B?ajdzcTd3SmdtTndUSTFoTUZBbm9MUGlWdnZkVnh2MkRrblJMdW4zRnpTcGts?=
 =?utf-8?B?OFAzN0F3ckE5OVJiWmIrV3YxZTFYckNvaXd5c2RQWDhuNG11S3dxZmswQWlh?=
 =?utf-8?B?N3VZTEprS2JMdy83UTJqV2ZpSFZscjl1dHExZ3FBaG8rUFRZUlc4ejJKNUxx?=
 =?utf-8?B?UyttcFJtT2theXlmSmtNYy83U2orK3J5T0N1clBncEpDbHZsS1BBV2g4U3Jh?=
 =?utf-8?B?T3FaRVNRYVNVTHJSK0V2OVpNMUcrcGJFQ3ZTcFBkSE5ML2lWTktadVJyOENt?=
 =?utf-8?B?aWNSUzV3QnpWMzlqRjF3eWF5cmE0VkdWcDJXL0tBOCtISTRrK3F6Qys1UWRD?=
 =?utf-8?B?VFNFeUFCQm5CZTl6K1hMc3VRaUUwTmJTVjMvUXYra1JRQWZHZXZrMHJwZE5K?=
 =?utf-8?B?UUdRVjM4bGo4SVhuQWpjUFJrM3h5cHd2ZWhlQ0lFdjdJTnhPK0QvSzVWbU9C?=
 =?utf-8?B?WVNIdnhDbEZ1WVh2MS9KT05yU01FeUt2MkZYK0N3empIMnZLenVncEtMWVJn?=
 =?utf-8?B?L2pJekV6R05DRGphSkUzcTJaVjQxS1ZaZTdFTmhJM2ZmbEw4ZFk4d0o1Yktj?=
 =?utf-8?B?S3Y5elFkcHhSL2gwMjIycGRXVk5na1RtQUdlRWZxSVZEbDd0SkpRMjBTKzZh?=
 =?utf-8?Q?TdJG4V1Dt9DbD1lqPJ0RTVciF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cb8af9-c32d-4acb-9ed9-08db8d8d07ad
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:46.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNGjgnmiO9kgfZT+jp1IoGNzizuTRAhrVTlM1a36jWa/TIQG+GTlOOcE4uz9hkXVPS67XC5fRZCmSb7ZXVyAkg==
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
 drivers/mmc/host/au1xmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 82dd0ae40305..b5a5c6a2fe8b 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1114,7 +1114,7 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int au1xmmc_remove(struct platform_device *pdev)
+static void au1xmmc_remove(struct platform_device *pdev)
 {
 	struct au1xmmc_host *host = platform_get_drvdata(pdev);
 
@@ -1153,7 +1153,6 @@ static int au1xmmc_remove(struct platform_device *pdev)
 
 		mmc_free_host(host->mmc);
 	}
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1185,7 +1184,7 @@ static int au1xmmc_resume(struct platform_device *pdev)
 
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
-	.remove        = au1xmmc_remove,
+	.remove_new    = au1xmmc_remove,
 	.suspend       = au1xmmc_suspend,
 	.resume        = au1xmmc_resume,
 	.driver        = {
-- 
2.39.0

