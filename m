Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E322751B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjGMINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjGMILd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46561989;
        Thu, 13 Jul 2023 01:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbhbVH2hERxPHY52LWq7/Ckgxkiz4fG1WTAhAKw3Ncn8TTwCWEhZMKRAxvZDOSi0CwuYLxUW4vaI3t6+JZEBLYqVZdrxvyor5rGhIc5mpIE6s0925qjUaCz1L21BDagRhJg3XrwSvnE/+EY+olUOAlVQ6vjPTU0q/Sn+RAVz+6UW+kuQPPYSTSSV6KdzRnSyFu0MVP0p6fW6GQlz91Ma7nOydOZxkqOICVnXXxYV89RHOdEEMdjOF/HxpWhVioJjPkacJRmR3x/wvnlc6kf3WDnAIZIqaVVAACef1AkcRWi2rQfs1gFCP5nKsymKstWWENx9bGaG3ffKlqclpWmayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyhbeNXUgBwkQepDAzaYajBffSTDYfSaQABURS0z/Nc=;
 b=HgqKI0vdHsrYi493pu6Vxh32DigfaQHXnm0lXDK8tSYVunHxSo4M1+k6EBB6eRy79c9p1ZSdQCA13VBqyHgAg35BgcLgnwVT5KBcr3SFJCH7YtkQvZ76e2SEZV14P3SbiI4lPo9lY1u6zIgmR+02JPoCK/fVDfCvO8QJWHCakOvVTqnp6PEC57vw4hV49ycuIbIsH037MLYorqxqplulE8wnPKg71vd4aCZxXIAFkCK15PC+OVwjQ4wnSTzQITjxHA82UhI0XFxUKy2deh6lvbw5hl3SWHSWBPqm1SUICLQkeziioUSNFKbyo1WNcGGiLZy7RQ3kvMkuLDGCOgk8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyhbeNXUgBwkQepDAzaYajBffSTDYfSaQABURS0z/Nc=;
 b=g98B5KiHqYILHCXHjabDjza7uZGLglBseExTep3eWOlmqgw4gGW3eKXHDErUCEJ1mkPxyY6/UXtoYZPTQN3c599uhOapK3ZFMtpT6+/JGe7U/PRNdS7s4Ko1RT0xz3XB94v5zqyfmeKPKlTDi72Ords6SvFQbxMoUUWTGxdKw0TAPsl7QLLgDXZIIPLmr/q+OrlWSI6BJ17oaskdsfKcG6iovoc5/iBSwWCcT8kz6NiRKgX4lald+zQSIMvanecH2nUCaHUWyM1L9ysdnz6RRwqDY7zDKkJRezl3ZOWFIN9bEOSuFpTm/kQ2c9jvLcRYbDmdov1egv7QA8HWvWPAEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 37/58] mmc: sdhci-tegra: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:46 +0800
Message-Id: <20230713080807.69999-37-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 608b097f-ff8f-4778-228c-08db83787941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0wvJjjF4LRBa37fubI0Bg7mZwS+RLbcOBm8HH12kcMTUDUdJ5SwItfLvISlC8iGmk8IL9D1pf2HQECaT6JlOgKR/y2WiEZVel2r8BfQYpK2cFR55kR7ehxOSjYNzEKQTMPqxxUNaOjfk4DfsqCQOhbUhy8ZE0YZQ73aM/hCtxWhzo+/xFRk2T4GynXpxwT2FGeMtkGWdeDjs0tvHTdTpr2kcGo8PtXfA7T8AbxrLvVLTydf8+p3tziigmBptHBZo00xE+jUjQTGJhdAwdL/9DNwbkrF92EI766Vmi20yoUuDyDkhrRfvXA57OHoG8ijv4cajZDxTW7nWo/NfWlc6HMPK2z7fiiP9A3D75SfpC7/XqyUr7B+BltI4DpNZBLv1QXJNM3b8i/mKiKWSzEr9zZlyIOFCRN4wv2CsrRAfS+dRFPRlPKl9lARXOsp4qelzKTOvJ+xRw+ClqXPyxIlYnvrKn0onXaMWoGtSLs5DMJstpX+Nqq7rdRYpwevV04uJHZW3tFzPXNLtbNakYEBsg2y5Zn9sgn6CM2mpyRbNqgdvLLyOwzUT6ltdFgLBdcLVqI46DCMXJd1wNWy/73lI72rGWqdu4v+IvT3SltJ65/VgS+IMGU95SIIRkjMx7KX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(66574015)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0M0Uk9lMzVLSmxoaTYzbHFJUUsvaDhYMDUydzg4QTZJY0NBRmZHOSs2Z21Z?=
 =?utf-8?B?TVFMMk1BQ2FpR3JxQ25XWVkxbDhWNVAwYVA3UUtSa3RRb2x4V1R4a2VGTkIz?=
 =?utf-8?B?OHNFSGtLdThTbzMwbXVSd1p1TXZJQ2RCdmIwUnZuNlhqcU1XNDVtUGNtWDNB?=
 =?utf-8?B?NEdaUTVTbjZ3RG9KM3FNaGN5YnNUK0hMYWlWL3Y2OHZmR1RtZ29jYkRrUGdD?=
 =?utf-8?B?Wkt5ZkN0OVRMNGh4alZOMlJ1SytRWVlSTFlkNFN6c25BQms3N1lNT0JXOUJv?=
 =?utf-8?B?WnZNaGRxUHQvdWxMRWN4NHVVZ0Y1UEhzbHVQVzVaUGg4aG8yWCtPVXA3SzFT?=
 =?utf-8?B?TzdBSjFvS0xtMXZmRkV1R3VXNXErOFdYajl3V2RPdzI0WXExZlVldk8rOXB1?=
 =?utf-8?B?VHhmcXBib00xNnJUT2dBb3k4bTQxTEh6emNmbVFUcWc0QzV6eEdtQWZCN2No?=
 =?utf-8?B?ZnJaTHg4MWJEeUR2SEx2S0VpanhKZlp1TlVkNC9rSENSL2YzeUxjUTd2bkt4?=
 =?utf-8?B?a2NFVkFJcHF4WDNjQk85VkZBQ1ZyN2VrOTJJZFJ6V09BQzR6dXN3NjU4UHc1?=
 =?utf-8?B?SWVvTU00RHIvV0oxakRrc0RjMjc4aW5NVTZIYW5uQjNJQ25DLzFxZXc1WTZM?=
 =?utf-8?B?RlVDOHlsQ0JjeHFFTXkzY2J5ZnJocHNmdlZBRXptbko3RTVwcE9CRmFxZTVL?=
 =?utf-8?B?VTRxaWtqM0RhRUVFME9WNEk4VTFNc3VGVDdUdElvbXZLby9JeXhxb1BhMU5O?=
 =?utf-8?B?RXVyRkVWT0h1a0dLdGdIWFRWcG1DSnZlb0R1QkFBZ1c3RTJlcytHWXp2OVRh?=
 =?utf-8?B?QkVaZGp2eGlUejV2Uk1hT1VMOHc0dzgreEhjenFWZjBVVGZNdzlzZmNhU3FD?=
 =?utf-8?B?T2ZPU2Y4MkE5c2hhVElrc1lLUnJQalVDWUt6bHpPbkh0a3RaaVY0Q2c0SUll?=
 =?utf-8?B?TmJlNHBKWitKOUFGSllIcUwxRlAvZGdTSkVHYnlldVRONXAyVG1lcG1XMjlh?=
 =?utf-8?B?UTlqazRkVExNYVN5MnVZM1kyYWZOdXlSekxwTm5PZmh6dGNXaC9nclowWERm?=
 =?utf-8?B?aVIwRmxaOVByYjJlZlVYVmltS3hkU1BET0F4empYNUhjRGRCeDdKN0M1V3E2?=
 =?utf-8?B?Q3ZBYTZUSTdCZjJzRkxBRHlieWNxSEdhWUNXT3d6dytMNys0ME1MNnVCTWgx?=
 =?utf-8?B?cjY1OXpQcVozb1UranhJdGVYbktpYUhOVi9SQS84ZFViYWVGQmQ3RXZlbm1H?=
 =?utf-8?B?SldMU29uSlhtUis5TG53K2Q4c1U2a2ZScDB0TG53TWZVanZJbk4ybVo4UjVM?=
 =?utf-8?B?WXlHZXFpaUs4b3hhNFFvenR5UDRxUW1uYUU4Wk44OWE3V2I4LzVqZ3JIQXNt?=
 =?utf-8?B?cVNMeU8ydGc3NWRUTDYwRWs3alJudWk5aUhSUUc5UmF1UVZuQUUzNTRQSDFz?=
 =?utf-8?B?OGdnZ2dWRTZFcnMrY3RpMTNSbUhpTzdGOVdTMEVTcGZadE9xSTZMdWc3L0pO?=
 =?utf-8?B?cUVERnZIbGtwQXV4MlpiTXJDQkNESk1taHhYUDIyb3BTNFl2NUtnaktpeEN0?=
 =?utf-8?B?bWJWNnpRbGs4UlEwNVRlYVJhSGNXRGxqRWxDS2pvT0g4WDU4emcxeHdNdlZT?=
 =?utf-8?B?anBkbTE5ZWJteUJXZUVEZlBsUE5uS0ExT2k3b0ZOeEcrL1R0YjhKQXVuMnMx?=
 =?utf-8?B?NjNGZXF3OURpYk9hU09ITFRtamxsZ3RTeDdHNG54cENjR3JOOWQ3Wko5Ump2?=
 =?utf-8?B?OWR1eko2eVpXdFd1b3M1Z0VKZ2s4ZUw0bmdMdHNya0NqMkdockxkb2lxVmJU?=
 =?utf-8?B?NlZCakQrKzgzdlpFQkV1ZUlIVElid3NNUXR5Rk94SVl4ZTZzS2lqcGYvWVlp?=
 =?utf-8?B?NDg3cWdUbWdkTUZ5bjZwcTZIUHhVMDV1VWNZbzV2WStYSk40bnlvV2VTMnh5?=
 =?utf-8?B?RldaU3lwUm40THNwMVY3VTRvTENtM1NqbXRtNERhTXV0Wkc3NjhoYzRyeDlt?=
 =?utf-8?B?UHVrcnNqaUZHa0Y2ZFJjWUl5SzFGZGpiUnhnbU52dVA4dzh1alphWWc3OXUx?=
 =?utf-8?B?VGF4TzdGQXVDV0oyc0ZQNS9lV1RCUHJjclZxcmdKTzNnV2EwRTc4WGpjZHJk?=
 =?utf-8?Q?H6h8jkv4ZsiWcQnnE0mngkKnr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608b097f-ff8f-4778-228c-08db83787941
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:25.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbVOEdo5JOIPyj6g67dd3yo63D/I1FjKCJ67VKlgxdGfyYprgdtjJ5XfieSE7PfJUFupZgkB2Bo91LiDmYSKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
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
 drivers/mmc/host/sdhci-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bff084f178c9..6a50413afc8d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1818,7 +1818,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int sdhci_tegra_remove(struct platform_device *pdev)
+static void sdhci_tegra_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1834,8 +1834,6 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(tegra_host->tmclk);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
@@ -1933,7 +1931,7 @@ static struct platform_driver sdhci_tegra_driver = {
 		.pm	= &sdhci_tegra_dev_pm_ops,
 	},
 	.probe		= sdhci_tegra_probe,
-	.remove		= sdhci_tegra_remove,
+	.remove_new	= sdhci_tegra_remove,
 };
 
 module_platform_driver(sdhci_tegra_driver);
-- 
2.39.0

