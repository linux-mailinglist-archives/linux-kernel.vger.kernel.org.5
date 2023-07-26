Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E1E7629ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGZEHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjGZEGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:06:32 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::718])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7854C03;
        Tue, 25 Jul 2023 21:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf4VW/IwItlxlqPBf+tZBdK1G2yi8ix7xMMPTcVc7Wz/Rz0arEOyhSehr7xAPU2KfWLM22PeNu0HgnUk3jgxDt75WDYTefB+Yjpjsm8JnFOrPO8FTIJvzrGWtQnvQ1wDw9PoVD6Ud8f/fE0f+rS08KpwR8HtnjxZ8Zc25WH+x1fPC6p0sIgFiTa9s+BowTSn3QFwiGGSlS4fwAD+iOhU6g9GArt4GYu5LTiiS23OL5i7m7ZuHWMROzFyGuflkgxd/7j19TAap1IBO7zivlfnaOPeXBoDxqhnUN2t4x2Ib2hq+YtOKsOtxGEbWUlov8wmMYeQ1jDkff4BcNc6SllOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zfGaaJRqU+i/vJRxACVy8ivU2sos+SCFqN4m+wofmM=;
 b=ga7xew43ZZXS7k4sBq3hIxYjFURXSfJv9XbcSjhQLAKpFNdlEQVTc7hz0C8KtDLUrlydXHFqpx3kn2WuYxqKCzxryWyzrncQd5k5CUBl9YnLxVOH5WD4eUIfgt0DfWwGMK2P4VXlYsDswuKYLN8UvPQjYmzulTOpF4QbGh7rpnE2prk6O+HfxhdpQpxfZeXBqwpXmBoZiRSIJ/DgMA2A9rc7fnE40JZufCQPTuiTf6UP2AMKFjESKIQZGu33sD5tBWTxmbRTHVxhpfA6hKfvHlJ37HwP/l7rjAxhEtmlMn09bPI8pnY5+BgUhE1mRssyvNWCD591QoKhD45RLKOerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zfGaaJRqU+i/vJRxACVy8ivU2sos+SCFqN4m+wofmM=;
 b=mC6gWS+sTnA/1gTGU/g2eovkSxYP8+fs5E9fHAsY6HDkW+je8OBe/VmQGMgDZT7uW4LG87D7QRJX553/SLE8nMSdZl/tfM1lDHSE1jlzdGZ4qYbgQPCJZcLh4I6fTZd5cS7EJARNHx1rJ+Iafl0KvgLmL+LgkRUua6xPKW6skehrfN2c39956HQ3OfglOOByF8xGAJqllO1BYzmCf+Nr6KaLCE71ocguQ8eCsUhdkV/m0oBICdv28gbXvvx7+54CzPkj6JbrdtJCe9JO+lXAuiER/f8e752qbppybvDy/y107EZIglOXqH7oWTvFg4VXy9TIqycBpfRTjoQ2JKB2BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/61] mmc: sdhci-acpi: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:18 +0800
Message-Id: <20230726040041.26267-38-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c3e8e53-42ed-4f5c-5196-08db8d8d1265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keFaUUfoVmkW02imy3IBFCz+CgUgFH9gb4P06VMO7EtRgYsx3kF+/swF5tIJpbRF2yn9hoscmjsnAZ9iBwf48xdf4RClGzBxai6swen4eMzbCQdv90n7/XaXo4WrmMa1YwglpMxVgvTh+TwCbD2UFhk6+kGfgyV2VyRb/E9ptH1awXK65INXQyILMve4fj7rFVaGIgRcSUQzB5b1GIL2QgVPFQ3yIeHwdlKhXuTMsXFPbJIZrMTecOswcTvxN9sWVFOCze8pgmyRVlgnzAmSQKKFAWscbfVrANN9dyv2f2gUI195SK30P5qtlQ6mCwn0Ct0HUkSfOgNhPnx1mOrPicv0QpnlJDGQc6pkieVjuzAciaQLmR2qDmsSlGxXvrQUsdQ+stsj1QxAdr4bHtBHpLk0khUQNdmrIQffvKf3eK7a/i/n/90DMApzA3z3itj0d383TNahN1N/ijy1luzRRbUBuHYlDUAmEEtiJ/hZcGufOAkO2Ik7RoPNpUeT1xcUeacUQtOrfEAxaNN5FVxKiz30SoyZf3cIjmaeWddLfpD49vUytzNuYHvo/j55Avue4CwqiMBGIpNOAzqTLNQEIVvxZV+J+im5/RClo+n34R71LlTWGMvsHW2dpcHzC2s8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWpTSnlncytVZThOMTRFOC8zejhPNFUxZXJtOFVVbzl5WXJMWnVmSkZFU1lu?=
 =?utf-8?B?VzRIdHZla3YzMHp0SVdoRmpCYVEvTG9aWllJVDA5cCtwYnNhZUVqQWZsNkpj?=
 =?utf-8?B?Um1mY1VFUDlJRk9RdkR2SlZwb0FxcndsTzB0VXQyOFB2WEwwaW56Y2RZb3g1?=
 =?utf-8?B?ei9oV1kzWXg4cXBWWTFMTlEvR2ZTSU1La3hqOXkvSk8yaFArOVN1MkJEMUt6?=
 =?utf-8?B?Q0I2MFJKcEZ2aEQyd0xXb1dIbWhKM0c3R2ljMDlGSXRkNUk5UDJnMHNlYjNm?=
 =?utf-8?B?TkJWdmF2WTEyVzBPSmtYR2hnRlF1cXFsWE9iZ3dubjBHVGljTjU2RkpnSUVj?=
 =?utf-8?B?bVJnZ3JLb0lOSEFWRG9laTFiK3NIVjRRZ2FhZTI3aDRKWDg5YW1ZL25RcUsw?=
 =?utf-8?B?UVprb1JZQUt2NzVRdURlczI4Z0tXZ0lCMEdST1ZIMWgyeUJFRktXblFhRWhZ?=
 =?utf-8?B?aEdDcTFXZnBMVTJOdTJOVmswWU9rUjNuYXBiVzBxZWh2RVNiZXlnaC84OWxL?=
 =?utf-8?B?M3AzMFpvN1JkcUFhYlNDaTBNYjgybVpXWTlHTDJsS1FVdWc1NGFBTENTcXQ2?=
 =?utf-8?B?dlRadTNDUHd2UXdxMDhXNWcyV1VzcmVBZklPNlJBSzFBdmtLK001VG1BcXEw?=
 =?utf-8?B?M0UxaU50SW5ZQlRIQVJUazE2Z2h2eUowVVFXM0NDMldVMWpvaDJKZ2MxTHJC?=
 =?utf-8?B?MXdxTm1Fditva2thUXJRcGtqbDlka3pjUTlZOXZ2bTVaNlVuSUVPZzU5TVhs?=
 =?utf-8?B?L0Y3SUtGTlhwVXpNaWY3bS9UVm0vQ2U0dkcxQ2V1OEFPYWU5OGdmUEpBdm1R?=
 =?utf-8?B?QU9kUFhoN2VzUm1BM2pEQ3BOVmVzQzY3aXFvMzQ5Z2xjSXdDdXB1Wngwd0dF?=
 =?utf-8?B?a3U4dzNvaExhNkZQV1BJaUdEM0orSGNEa1piSHNpUU9nOStRb3NNUXQxclg5?=
 =?utf-8?B?V3ZKQ1diZDRWdlZGWTFlT0Q2cTNpcFlMbUx3OWJGMDJiemJDdHdjWHVtTEln?=
 =?utf-8?B?aWVVTGZ6KzlvenB3eFk1Z0xraEFReHA5Q1d5ZVN0a2k5ZDRFdEhrN2hpTXMz?=
 =?utf-8?B?NzBMcEE5MG1TL1c0UUZVR2dSWkxidFZIQkxuSXNCbVU2azBjMXRxREZWMWVk?=
 =?utf-8?B?ZnNJN0pWN3hkZm9Peit4czY5NkVsM2g3QnpmalFtcU5RLzVtVGNLY29LUi80?=
 =?utf-8?B?by9JcVk1TlpHT2hTSU1TbnVvdjZLN2E5U1dCTHVQWW9lOXJjK3FJcXZYN3dh?=
 =?utf-8?B?eHMyWWREZnE3NDUzdkJwbjJoSnFlN1lPbnllRTBNZ0JWK1V5QkF5RkZYd3g5?=
 =?utf-8?B?ZVdMY0RkMzZLOHBScENMc0JZdi9jUzFCVmFaak1vNzVDenlvNWZFZFpmVWpD?=
 =?utf-8?B?bHpzbS95ZlJJa2RKTktOTno4V045dllYcy9NTkp0c3pSVjlTeHpoVGNJTnhx?=
 =?utf-8?B?bmZUMVhBUE0ybGxrT0s1VUNwdTFOOTB6ZXpZakhvS1lFbWEvemw5NWtTL1dT?=
 =?utf-8?B?ZVl2Tm11bnNRSFdIaE43VDJsMUVyMlFtNm5jUTlyT3VzbHNBTkVFVnpBaEI1?=
 =?utf-8?B?RjBleVU4cTYwaGpicU1sL0ZpdzhVZkNhdzBDODhxcUFIZlhjRjh4MmVDNE9H?=
 =?utf-8?B?a2tSSXhKbEZkQXFCVGhtZ0hTclA4UWVQWHRIbWdnamxoTHZoT3NubE00U0JD?=
 =?utf-8?B?V1kzRXpNREVuV0Q3enVad0RiQmdZUnZ6aXJWRVFySGxzbmJxazZEcTU1Sm8x?=
 =?utf-8?B?aUlKdEVuRUFPQXpuU2JnbjQ4c2xJWjVVZFFoWmFpNWN0eEwyQUl0ajRPamQr?=
 =?utf-8?B?WDRyUllYa01yTnAxakQxN2RmOURIMDlkNFhQNm04ZWF2ZmZmenU3bDU0c3hX?=
 =?utf-8?B?TXYwSFZnSXg4WkllZFByYytXZHhnaXZ2UFk4Vjk2bWhYL2FXb0J5YWRCQmln?=
 =?utf-8?B?N0QrK3E1RTVQd3Jza2UyZGQ5REsyUXU0QkFqQU1CN1F5d3FlV0pmQTIvOE5B?=
 =?utf-8?B?SWViL2E3bVV3bkhhcDFrWklXNHNwY0NxdFVlQ3FNcUlPUzhMdVJHVzdDeUNh?=
 =?utf-8?B?RkNsd3FlTEh6cXdqdGU2Sk13ZG1WVWFYUVVXQklZeXNmSTIzMkVNZ0c4SzIv?=
 =?utf-8?Q?AD+IJCDyfqFVI2xDxNf/jjWXj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3e8e53-42ed-4f5c-5196-08db8d8d1265
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:04.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdWGnOvKlOfg8RJRgquJS9y92JvK89uPt3E8Ysvf6IeEtaDo8ods7Nk6ZATan3dlbQwQqxXXFaDIaSBbGy48ug==
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
 drivers/mmc/host/sdhci-acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index edf2e6c14dc6..acf5fc3ad7e4 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -917,7 +917,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sdhci_acpi_remove(struct platform_device *pdev)
+static void sdhci_acpi_remove(struct platform_device *pdev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -939,8 +939,6 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
 		c->slot->free_slot(pdev);
 
 	sdhci_free_host(c->host);
-
-	return 0;
 }
 
 static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
@@ -1033,7 +1031,7 @@ static struct platform_driver sdhci_acpi_driver = {
 		.pm			= &sdhci_acpi_pm_ops,
 	},
 	.probe	= sdhci_acpi_probe,
-	.remove	= sdhci_acpi_remove,
+	.remove_new = sdhci_acpi_remove,
 };
 
 module_platform_driver(sdhci_acpi_driver);
-- 
2.39.0

