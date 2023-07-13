Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6158D751B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjGMINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjGMIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:12:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CBD30E5;
        Thu, 13 Jul 2023 01:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULLE3FEEADYGmCyPdBA+tdycBsTPP+rAQ96rP4G6zLoovxNKCENF81ml1qXTVI/PGZK/rZ9dJMGB3qth8YJRXEuguNukTmuxptAx6rzBf6U36d1w6okwGzCB95jzIFl+4aPVTdv2/GlbVaxXs1Iw6SHOFHfnIYKrg0BdOWx62d5WeDbJmRzjqwSIxBiGIqaRuGZnkRGvLdh0JKn3dmqSvZAHee4yerFhZ9YeUCxc2+txIQHCS6+UkvqkGJB6P7NCNYm3THmRE85y+u6hNqezz7RfsG8J+SDyyVWZlQgdABXReQ24IPg5E3f73LGxpMTJ0zFJjhHRgVdnUfy0EP89og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zfGaaJRqU+i/vJRxACVy8ivU2sos+SCFqN4m+wofmM=;
 b=IotPw/V3NgZfKjgYyvpdEywNdfCOw4DaQe6Bom1LioZkMCHb8hx1HjVpe1/mPfvcU/55Tjy1s5WLkIPi019BROAf2xOQZRdJkqe4jWIF90KkEJf/9ChG0zkR6DARoLiRZ/z8O2OZlpWliQFvMgORmYRNE4+PlcUC0EUpmKz4HxDF7FPKJhF1O91Xh7j0NeYlDkc7pFCNK6xSmgd5oQLZD5d2oBWMwIDEKo9VD6lNl6PMPDQHaQ8lSSwUIT6LuMLPZm7jWEPWh5pk11Ftg5v+BpHO7kCYLjzr0iAdsCXoWc83FmT7hrVvncaE5ue4v6smI5RXHjYp1sEPEzq10ZZVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zfGaaJRqU+i/vJRxACVy8ivU2sos+SCFqN4m+wofmM=;
 b=plhwjkh/c3TfOgS1ndieLMqK3pjerdtjlcVdou+VjUONSjcny1fE1YhQmoKZ3Fv0mePqmkwgWNuepuVGs6+rXyrf49htoDUAa5B4pak4VLQbuT0GkqLQTQVayWLTNmsxQT+hGz36MNqXKPDECAnWyb23Xxgrb8Oyo2EBFMDALaFIpIMxk+vBTzbH/AZGnuhK7ff41kp8kG0+OB8+YJ0XHcY1MwTm7iAG+bSwHlR8DT67ziU5PDF2MmZQIZqm2fj/f/5NpYJZwTKFWdbdpos/2K880o/K4CJCifPZAOIvGSfepZKCFDHGACiFqG2KsZDbJ1bnZqGrZ6FQK4JaXS6VCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/58] mmc: sdhci-acpi: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:47 +0800
Message-Id: <20230713080807.69999-38-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25281a96-07a6-4f50-cfb9-08db83787a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iocbeMeeI11r3SAzS/nTW0owlM7iNHD5S0s64k+PNcE86pO11oaUA/v48MTmWVuIlAfIAotH8SYc4J1rP4mljist9e+sODQBm7N172GdOU6U7AXqkwK39dzIMUi570PvF4DvgYBa7SZ3KsFZrbWA2YKZZUtLJTwMJGcVmfvmMLZPMLnfaPoXR8FmvKcqEVfQK4S0S/B49xcaOzoD50ncE9wmZrYGcGaosrU5aBCVwZclnZX+gfQPCHEjmJK92W4Gyq9OW4T2gHnGwHe2JqnIEWOYrZtYB7CRG12sr/AkWlWaD8Y0/FWkCx+pgVYIGhf5i+tSu4ywA/KHYwgCk+Au27elDgNdBYzxiAHzQ6BKn11gI0TGeTAgmI2AClJcj8ubuRE7dcgaWBUKjOp2LM1Y2uybGHNaSfBzK2vbIdz8wN/5EjsfeafrlBCPABP3jsvVhGkyK2zlr48MGULHvsguFD2sw80qCSYJUQOlu2v//iR71qgKq2T2IwxnoZkHZh3kipJMBfWKham0lr6fEi8S2CgX1v0UdStFnmWXuCwrNjZC0tLPIKnDPDlQegfH+fnZlvhEl2fZYKSw6l0xBK43/GHpchSFgZzjy6wDUALgsumobhud/5ED6hQJvF/WSC/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHhnZzVTV0xsQzVudkh0U2pwOEM4WkJSNGVEZFZzdmM1eUhqOUlENzhFWXpL?=
 =?utf-8?B?U0ovUzduSHpKWDVwMkdlMDNzd2tSR3g4UW96MFY2WkpCMWRkMTZnSkZUdHNO?=
 =?utf-8?B?NWhUMnk5R1FpS0FPQTZPOGlibjBmSStJNEUxSUpXS21UeEJjZUd0Y1c0L0w1?=
 =?utf-8?B?Ry92S212MGUxcmJaZm4rbVZPemQzY0xQcWtyWSs5K1R4UDhXc3ZSdXgxME5p?=
 =?utf-8?B?MlRyQXNYVE8zc0NzLy9jbDNTU24weVNFQWxnRDRHdDJsVWw1WmgreEtISFRh?=
 =?utf-8?B?dFFLRU55d2lobnFDYVFtVDAyR1drQWlQb3BESkovbWZEbmd6b1dHdlYxY3Uw?=
 =?utf-8?B?alhGVlNwU1Boc3RiNEwzUVdTOUFxNnNkaXQzbGNqek9rTlFIOEtqc0x1RGRr?=
 =?utf-8?B?Y3NZVmlyMVFHb2djTTMwbzROWXBrTnpVZHJwQ0VPTFF1TTUrZnhMdXMrOTNK?=
 =?utf-8?B?QXN2dHFsWGR6YTFpeTlGMlhsTXJrd1RWVVRuRVVNU1R5NDAwMExCTHBWanpB?=
 =?utf-8?B?YnpYVHRTMW9oTC92Z1ZUVFYvRzh5K2xkeE94citSMzZ4b3Bpd0xzMWp5cjNk?=
 =?utf-8?B?WGtWZmJmMjFjV01aR1lDRHBkN0lzaWdSTUpTZHpJeVQvM3pEdTRSaytTVlE3?=
 =?utf-8?B?Um1HYTVSNFNaeDNGNTBNaGNpQ2ozWDBqeHRYQnBaUnBPRU5xczViV005UEZC?=
 =?utf-8?B?c2tmTjB6d1hVTTdyMCtkTkZCMnI1cTM1ZXJvaWVkQnpLL0ZnVUg0eXM1ZFRs?=
 =?utf-8?B?NmxvQ3BsaEZuRFB5RGM1dng2c3JMc2M2dUJMQnhYcEl2QmdVSzVmNXp4Zk1Z?=
 =?utf-8?B?bXJmMWp5eUlMTTVCNkUzbTBSRGV2ZEJwL0tHWW4yU1dWd3hKd0tqcFBwemlK?=
 =?utf-8?B?cTRTcU5kczZibTYzZnlrSEZkUEtSS3NLVEkwWnp5VTc4MHlMYzNqbXpKY3h0?=
 =?utf-8?B?RVpuazlOK1ZEdVJPbDFHY1gxbHpYSnFFMmNxbktNdXdERm03OHB1eDNYT2RC?=
 =?utf-8?B?V3cwZUN6RzVhWUZ5V1pRVGx5dTNwQ0c3eVpVWC9xcnNhcEVkODNrTkJWdzRu?=
 =?utf-8?B?KzdhTXJwYXdpRVQ4WGZNY3R4K0IyaU9DMGFKOTU5OG15TEJ0TmJyRm14K3Vu?=
 =?utf-8?B?eSt5THU4NDZWeWNjUnZWOXRQRjc2WE5Hemp0QnlYVWNWTDA1NElTK1Jjd1dh?=
 =?utf-8?B?c1JkdHowaVZYS21ISUdyMnRhbkN0eXFEZENSQUlSUkJYN0VBdS9rckFlRDhO?=
 =?utf-8?B?OXdWd1E3M3htYnpLL0tKNEpmYVZEQ2NMUTBob1BYeDVsbnlvaHVHQWZVYUlU?=
 =?utf-8?B?L3RnWDNxdTlGbVFxbWQ3OWYrNkw2TmYvUWd2Q1h6Q3FPaGlLcHVjbGV2UXFS?=
 =?utf-8?B?WnJnd1FuMWRtam9zR0I3dFNVOGhqK3RFMndZMS9qVGxNT2EzR2E4VGpmQWV4?=
 =?utf-8?B?cDYrOFRyS0pzLzhIMmtYY2lXNjR5a2hLMktEcnMxMjhtb1NXQjFBZlNXWm1s?=
 =?utf-8?B?SUJ6dVZHQWl4QVhPNzdRQkh0SGQ5R3FPS0RwdFZPdWJjVWhVM29zU3hiNUJv?=
 =?utf-8?B?NDdYbFRsVVhoOGdwTXlXdmsxa1YyZERvOHFDMTE4dkROcDlzdGlaMkx3TDJZ?=
 =?utf-8?B?YU5nOTU5anpsa3dPenZnZDNTQ2o4WDZLZkdQNTlRM3pjSVJJK3JjeW5kUGNE?=
 =?utf-8?B?M0dSajdPQmt3Y2tHaUhkbUkvaTV2Qmd1ajNEZWU3MUc3Qk4rdGxnbzRvektp?=
 =?utf-8?B?Mjdncms1d1hkc2xmK2NuaGNpM2hSbFdZOGxkTThLZEQ3V2tMelJWMmprV0xN?=
 =?utf-8?B?NXd6NmxUYks4aERtdXhKcTQxL0wzOEpCQ2NoUnFyUnZ2QWZuMnE4Q2g3M2ly?=
 =?utf-8?B?by9QUlQ0ZUVuTDMrVjhpZVVRMUhhVEc3STRwZVFSSlIxU3hkUDBwWDFqMEZR?=
 =?utf-8?B?NGE5U3VlbU51ang0TVlOM2E1ODR5dTI0bTErS1k3OU5WWHpDZHpxbDkyNUM1?=
 =?utf-8?B?dnZmNmF2VjdWbGVET01LRUhwdGRnbWNFOEgvL1UyTlNaWXJGWlpLTnF5R25t?=
 =?utf-8?B?K2ZDclFmWDE3N0xWcDByKzNGaW9mTjNyVjZJZEREZy9McmtYV3ZQRE51UElG?=
 =?utf-8?Q?V6jj6HxrIB2SJEhiXElWffceq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25281a96-07a6-4f50-cfb9-08db83787a1e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:27.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXFS5bfr6kyxyMnuGy7IPLqBP0IpyF8TiDfycYfUHCpHLONZ+bebofkxcKmutp16R2pS11HF1kqXFYoiC0c6AQ==
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

