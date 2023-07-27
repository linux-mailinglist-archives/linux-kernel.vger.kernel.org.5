Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4437647BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjG0HGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjG0HFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:05:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B391D3C2F;
        Thu, 27 Jul 2023 00:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdDHWSG6YRO43uTks7FZH5nHueubXgXxOqSXkximsa/9QWywiWgRh4z6NfyckEHMBcZWl4nJsl6uNsik5z9SJsZIt8edE83LfqKQM3+29IyUfRj40hU23BjsWWZixBE6EciUq1iIH2Mc9dTH7ivNRVnCGtlIE9ikuK5/M0p/G+nl3DNubJ60E2athKB1Q8oyXqRv94xhVPGJ1rLAWPGrPMmtJt9VNVKCWZV+1gZQuS8wjMN5hwyZVONjJkwE6dIctNAOAJ7/3CZczuINvzYxEq1i2VyCIoN2K82heAPU/4o9G0+90Vyiw4VaCWSLymYlsvOhO0DNZt0uxt1pCPuLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVMhDTzlw8do8am9acRTwjuR6yvB0w4OzOuapIYozcA=;
 b=Z8omnq+2FnQKcvEbZXJgXocjSNmyGdsg+Y4GiU+YajsWJehsxftqebvfLnw7Y2/C94o+mNAhnGP1sQxFWt8ff1AgSIyrMneDZXN+e/HtUHXXcmFR1Uox2v6XWPlOusjCAyyP19+5uWcSLxJX5sorUnWYJ78RqoZIWfRM8A15/w5kAtCqpUDFmPw0CLJ+I2RHw/pFF+TnMV0AjWRzuwsMhomCnCgcHVUvB1bY/98hcog6RxpbPrWrX2L4ZZoQsmP9Fp3btNYIPSwqV2lvjJsDaDyE41tWbfdMPH2/IIcDbtWZGqjWo2YqS33UatdS0mcjxrfrwtfc+8Po8FxsyrkTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVMhDTzlw8do8am9acRTwjuR6yvB0w4OzOuapIYozcA=;
 b=B8yI5ylbwSDF3/4lXV1sM3DRWrYCA1EP7K2S514WPE1MG3F1kNiVSyGmcZ8MlkwfJXtZnChiLPzb8wC3TbcKY2kCj3vKM2sFfNhJHr+qjJZe3es3aRTMkIb4etMetiu1U4nSqQFwKMJogYMVqmQvuvWa26arnbxjSgLlCFlGvqfQIUM90tZxcU5dlFqc9oW/noSMtPMQoV2a04g4oAZjmCceb2W/Z2nVsjDMv3LVBnLFrAq609Lw09WWZjhSEeAKGA69QqQLXgxgEjhd/WApkBKUGFh0mA4RiH/xJqP8HRmLpoR+kyjC+xqrTm/EuVeJ8SZ/Sme6OPrOoiXEDOBEwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 26/62] mmc: sdhci-of-dwcmshc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:15 +0800
Message-Id: <20230727070051.17778-26-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7eb1858-cfc0-41fb-15cd-08db8e6f56d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teUdjnIdMCCJlnugWyPb6g2scXO76FPhiH5VlLtZmN96J7D92Ed4hznBjJCMMoFTpNXJ+sdtph33oHl4qkoSLx7vPaOafDq0tMsn+M8HNCLUcHOOV0m3aP4FJX9D8UMStiNBquvG7iE4hA1kjDHEC8TtzT29hx/P8W6ft+c6n8xp8BIMLYx7fVZ9o/okuZ0SmoslBr1hHwVE7iu59HlCiJokDkDyH9c8t4jZH22Sto0xZmRaVyGgz5CatdejjuYY6GfMXMn3XwtGrUo+j6fbGsImmvUYPBAPA1gieedLnl6EHHU9RN/Oj7QaO01juVbW0uDpTCJl/cwfyx2soKuXKS8SSFii3jYEs2leg/BXDzYXN/tNrG4iSL9/Ip5aWOw1UXOBCFRzo8dGjfpfjeSpNwQXOmthC/uMgGgl+e9kbwmymRKqlBWHRUashyItzdPa8sDxzves87JcurzMAaVmoivIZ4fTw85ZEncfIwstGupvDfcemxspEEKn7zURrgz2wKno1+9ej4ObZPK5afJxJpUAPK7DAEw1ctJo5+5ZO7O1gETTLBtwbcMY8hxNp+veSQWCfy5K/hJwShojsSNdiZ32s8Bqc8e/9eh1tGrPttRvYaIHa8TN13yhst7HH5BPY+LZraAn8LfJIbHOWBmaiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001)(133343001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUV1S1pjMTlUVmlqVmFraS8vK1Zyd3c3cFc5THd5VXBvUmV2THZvN3JacDND?=
 =?utf-8?B?NFFSa1JrR2hWZWt2Y3ozRGNIYUw1WktnRWY1WFBFOFZaS0JzZ3Z5bUYvNEQ4?=
 =?utf-8?B?T1VROFBSblRsdExsdVgyL05rT0ZtbG1uamRwZHlNV1FhYWtpNXhsbEc0QnAv?=
 =?utf-8?B?WHQ4TlllSGRuSDFYV2FhMERmNSs0SmxFRDVDa1QzaUJTYjEwbUZBVlN4VEdS?=
 =?utf-8?B?MkRySktYUmRQSkluYkJiRUxUaTZPK1Vsc0R2QlFEbVNoS1dnSHU5UHA0c1JX?=
 =?utf-8?B?TWZGSHZNdm01NS9GVlVoR0p0TTNKYzZnQTdZSTIrTVlhanpQMjNsc2c1SmdP?=
 =?utf-8?B?SmNMeTZLN014VGxEbnFBVTYzcHdCcVZRRTdrU1RNTllhZG5pYnpBTUhQV1VO?=
 =?utf-8?B?ZFJkVTNLVWFjczN5MkpXa0ZBZ3lmdXZZM3VxTmkxNE1SeExJdzdFUFFTQkFn?=
 =?utf-8?B?YlRrK0dkMnNnUUJiNWxZbStSYW4wVDEwWjVGcThTTGRESmhtVkRYb1V6TnBi?=
 =?utf-8?B?dGQ2UE5pemlNL0xQRjJKYkh0UC9NN01oOTJ5UGdvMkNZcUFvdDJ0WHNwSXlx?=
 =?utf-8?B?NElnOGNVQUFOcjBmejMyS1h4Y1NSUTV3OXBQMGthZUcvSUQ0aE5JYkgvd290?=
 =?utf-8?B?VEhlbzhoSk9FbWF3TmFZSFJCRm51VEJTNUNmeks2Kzk5eFo1RjZwTWRuWWlQ?=
 =?utf-8?B?amx0ejQ2WW42RG9JVm1VVk5WZzZZdjBxUEk4MWJMWHBvek9YeG1STnFabFA4?=
 =?utf-8?B?RXlveWwrR3RwaFBmSHNLdVpTZ0J1anh4UGl3YmhNUmFlZVFrNXJraDBPYzhS?=
 =?utf-8?B?MTlTUzd1YVdQTXRGb3hLWDNGalY1Z2U2YWkvRWx3Ly9rZ0dEUU44Rmt1Szkw?=
 =?utf-8?B?SFdrQW9BZlM4YW5Zcy9hTnFIYTNyanRpZDA4ZDF2c2VBSXJDUDhyblBXVzdF?=
 =?utf-8?B?WHA0dDNZM3VHUXhrUHB6Z0UxRWYzMkNjUHpuMXU5cnZ6bkRrYllBOFJaYXdG?=
 =?utf-8?B?cFdMQXkvZ1B6amVYY0JtOVRlZG1hNHRPWjJ5ZGxpUzgrbklYQURpUUd0ei9G?=
 =?utf-8?B?TzNndy9wQVBTTnRRR2hGalM1aDl2bWpGOXh2WVVlZnBYQlp5TE1MaTZkdkQ2?=
 =?utf-8?B?bkszSExjUFE1RnpidFJXMmMvMTRhWXFhUEpadEgzL3c5V1huN1UwWWs0ZUs2?=
 =?utf-8?B?M1JyVGsyQkVnZm9VV2h2Y2cyQUxsQXk2cUJDOVRrazRFSGNlS3EydXRUZDFN?=
 =?utf-8?B?c01jM0FyN0padUk5bVhoakUyNXlsZjczdU9YYXlFN25KVXJ6OWFxaE5DVEJB?=
 =?utf-8?B?N2NmMUp4enZUM1FHRUtzTU5rVkZRV2V1S0xvUFo2c0o3UGg1dytVNEZodHEr?=
 =?utf-8?B?T0tLMXN1MEtnWVFXYlBxQVUwZzhFQys0dWhZSE91eDlVUmlkbUo5Sy9QRHg1?=
 =?utf-8?B?WSt6TlhscTRXampobFVJZ0Era2FMNW53UkdZZFBzOXVwN0NMb0FwWnQ0SnBQ?=
 =?utf-8?B?RW5JaXJUWjFuY0w0UEMzcGZQNVI0ZmhkTmlUam4xM20vQ2JCVmdPdzFjVTc0?=
 =?utf-8?B?aU1XOGhqaUloQ3dHZ2pNb29HejVGS1NlbkdMaTVmbW9UOSszK0RPNUJMRXRC?=
 =?utf-8?B?WGRqdldHWVlBdU84OGNHWUV1N1QxOHJxMXltMU16MHNJdWN4VjV6RE04amZW?=
 =?utf-8?B?Q2ZUV0V2NStPSk9HMkdMUU9idDNibllyWVdQeTJHOVkrU2t4Z3RqU01NdHdM?=
 =?utf-8?B?RnBZeUNTanFvOE1UWGg3VFN1SWxoblZqSzVaNTJabE0wVnY0WVBjeHZWaFpJ?=
 =?utf-8?B?WFJYcFpFeVhuRmtoNTY4MGFTZmZnbjg4SHRTSkVoM2phUUNnOUt2MjB6RDBM?=
 =?utf-8?B?ZzBGRSs1akd2RFVONE1zN003T1g3Y0x2VER6dXNjdmx1WWhtWm1ZSDc1VWN2?=
 =?utf-8?B?ZjFlSW0yT2phRExZR0hLK3RNZW9ERXhwM095Zkw2UmQ3V1MyZUFlZlp1dSsz?=
 =?utf-8?B?SWY1U3Q1VkVscHZGVFBPMjk0U1NNbjBRVExjekordzlYYmJiWVBzOWtCUXA2?=
 =?utf-8?B?ZlNYUnNFUlp2RkZ0V0pBQXVSbDFoSUZqOWpWaGxFb0ZBQmNZSDIwcjRmcjM2?=
 =?utf-8?Q?9ul2fYu5PtdVkFZyA4ZMuH8KX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eb1858-cfc0-41fb-15cd-08db8e6f56d9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:45.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMZkv9z/rHskG2kwKoij5rZu7xNLykAKZK6H2KykM3AMTDIfRQizi9vN00af4wSENnaa7zYlyAuBqM1oaui5lA==
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..5cfd24cd33fc 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -574,7 +574,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int dwcmshc_remove(struct platform_device *pdev)
+static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -589,8 +589,6 @@ static int dwcmshc_remove(struct platform_device *pdev)
 		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
 					   rk_priv->rockchip_clks);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -657,7 +655,7 @@ static struct platform_driver sdhci_dwcmshc_driver = {
 		.pm = &dwcmshc_pmops,
 	},
 	.probe	= dwcmshc_probe,
-	.remove	= dwcmshc_remove,
+	.remove_new = dwcmshc_remove,
 };
 module_platform_driver(sdhci_dwcmshc_driver);
 
-- 
2.39.0

