Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B1751B56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjGMIPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbjGMINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCA32736;
        Thu, 13 Jul 2023 01:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGwk7e+pguKWNZLfYTnnjOsnpFlyMvbawQi/5cM/16lk8gZ+w2dSc0Rh71TKso9/frYkh8yuQGkqcO7VmgwWC/5GfLsW/6Cu3mjrt5/jkHWxhlZRqjbyAtwHDRpX5dNKPhyt/7Eq9vHtGEOOyqXXqzcRMy1OXxcSTJ49ZotvugRdXEPyhyoq8VBxDM942lJ5LR5c4s9BmiBvKQl1MogW+HRMLP5P4cExjb/MPM9KUU6CG3jz6SKQ2xjwDox/1LTfaUQYRCy5oTv79XxAEUomQ9/K65SteZUKquuSsNy5zUQybtFMxSUbZalODA4QlSgKOoiygG7AWl+yP/Mmh3awrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpwEOesJAaVQAS0uwMrEHxzMPiBo0LdI9OLganX9nW8=;
 b=iWXIVT+tAC296otdRkJOSVRoK//CB2k6mf/4iyuDhtWHDHswoPZIsKncK1V1t3BehN9lgrRuU1kg5HKvJy+Q3fzvzauoshIM/p+Aid4FQeUw8nrHe9TY3ch16UqmfK9jfjp17wZwE7PMtYcTEqZ/Js7siT53st2JFP4B/V15oUtHwYu0OTVzg3s2WD3TxBjspsVPpISmsX3lsOTezdfPVApDL9UCGeOa86hBenBKkxeuPUYu2vVQXtH2cZJj3LEs/DSJHiT0ZSj4tYukEUcRL8SpCB3BnwuMsE42o4PN4EGAL5GiXRqJozezs3JBkASVskj/Sfq/Zmhif4s2Qw5+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpwEOesJAaVQAS0uwMrEHxzMPiBo0LdI9OLganX9nW8=;
 b=jlo+AwLdi86DxdqKWQzGPQ1QXG5fDbi+5CMsj8cXRa/LyMSC7PtZKF6JomKd7ZQbASbw2kVGSJMahzpNpXKSO22+EwlHFuqhDLKtXavsU8Xuc9vBFmt4VlYA6e+plNxs/k23GTMuiU/xOwhR0f1AgNPUl9GtKjZjUbp+lw3nE9n/UNdCSaJV8DO8SxpNKQ/Ea7Gy296XMQJQuihuTQSY3KfHPAbZPEWr7z5Cl1awYpjCgaHTv5EgRh0SpopUpcokJMcktYM2qC5RkPnWDHGDGtBX4m8zh2EZKO3jGfKRZoIAHqzchp8Oaou2sxIHfSG6V8bqHrOOzvPv9sIxU4AUig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 58/58] mmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:07 +0800
Message-Id: <20230713080807.69999-58-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a95f51e-207e-44e3-bcf1-08db83789026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grxq6O8jAvVjxhUK3fx7LutbTtH5ueUbPOytvi8vNn/2XVKVGiVP/Ca2Pkru6tA9sGbXiLpmw57eDnkmHZCZ8Sqz6QjYKvmRy3PCbAj3PaYXobQVphCllN4REYKPvs9EOKPwfaT7QJKUW+9TmEjTlJiuV3uDaOgsrYBdhc4RZ4RCjdH5JqePWQImsOdOBq3A54aStDpS+cCc/P/gXiUmbasAQYeekD5no0BFX3k1lJk2JCmnn5c8xtTU5As88rxVsK7BbcJd3gloPR85ypuF7Dm+p186MSfIqahFW1t7R6xuys/85ww88oEr/AqmqHzwNQWX1Fam1zM+hxlhJ5eQeshBRTqZAGb4H06UfsSujN3n7A+wFUToi/e0wwOlAFgW1u6dEyLxW3R2Dj9Y4y8k9AtlZn6CSE6SHnW+HVWdUzVs/fUcMiIMayzfw4IB4IGjoLxUYWJm6kjpQ0ylvt7uGO4Qno1X3rGcjRZo13sGnrUHsMrS2Zz29f3GD0Phw3gZu5OQg/7buuXVuqBTxgfGbuTXRR4qb1GQwH9Rp5GU6bUkxcl29LjnG00XNxFyJVMafH8z35UeCO8qrRS9KFR8zLwEbrTHl5/s5UsuvTz3PyKb1IQ2YOZvwP1TbpXwCOdapAhw2UbAvCqdVvuwyiZDdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(921005)(2616005)(186003)(2906002)(7416002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdUQy9GVW5Wa012VUxCeXFTYU5oUThBa3g5bXNaYVRPQys5Nld1QXB5K3d5?=
 =?utf-8?B?Vk84M3ZveWthQkFDdWRXQSs5aEJYYkhuUVZ0Q09nNVZJVzJvb2IyaE9ocEt2?=
 =?utf-8?B?OGFjR1JkVGl3bVpFbUZJRkpIdXk5OC82Y3NIcXhhTVZlZDlCeXpQaU9RTUIr?=
 =?utf-8?B?OWIwK3c1TC9DNEZYY25zaDRQRnZ4L0FMM1h4M2w5d3YweXJNdkxkb1hFRFZ1?=
 =?utf-8?B?aDdqWTdiVGY0NjdxRVVpcDFmNExRNzZHaThzTGJBVVBUN09xQXVCdDlRTE93?=
 =?utf-8?B?a3E2aTlsRUNmeFZJZ2x3cW1adUI4VVdtNm52VFpRTGtoOGgyV3ZhZi9iY00z?=
 =?utf-8?B?ZTRBSHVDcVQ2ZzRLdHNTaHZxWUd2NDB6VGxnRWFLUUxSblNWODhLbjZsQUpw?=
 =?utf-8?B?TWhEVUxtRnpTbGU3dVpnd1Q0RUxEYVZvaHM3cFV1V01jeTU4OGlkbXFnM2pj?=
 =?utf-8?B?OE1Qc1BEZUtGVmZ0UmdUdnc3cUtvc0h3a3FjNnZWOVdiVU1RNWorcEZSSUtS?=
 =?utf-8?B?NElMMUduaFhPZ3hFR2FFSHpXSDA5eW1lSHQ3bjI0bVJTM25rUWJTQ1l1b2s0?=
 =?utf-8?B?QmlVZkpqVXRqbk1Nc2g1T3liTFVESW0wSEJGc1NmNG1hL296bm5tenRvN0hl?=
 =?utf-8?B?T3NWdmZjV25qOXF1VlhjZ2VoRDBsd0IrTmtWdkpIQnZkdWoyN3dtamZnWFpi?=
 =?utf-8?B?alFCcVI2RGlQcURLZTV1cmJXSWtPeUN2VThOcVUvTVZNZndSMnA2R1dtcWhI?=
 =?utf-8?B?SndjMVBranNoaGNvYiswTzhxd1FMMjNwVTVrd2NzdjhhdzJJcHBCMFhFMFZn?=
 =?utf-8?B?UlJrRTdBR0U5bVJzQVhhMDJKZnJCdzJFc2kvUXlzdXJWeDZzMjdHSmdqZ2tK?=
 =?utf-8?B?VklrMVpWRlBtd1FJcnpMQlB2a0lXbGJCbG9VNFpnWG52OEE5TmN2WS81S3lv?=
 =?utf-8?B?MGZ5cnJMUUp2ZEIxbElUOU05YUtEc0cyRGpwSUVpVEdWMkgvcjArS2VWVmRQ?=
 =?utf-8?B?NHpHVVQ5SWRUYjRYcGllSXQwOHVZUVF5VE43NndTOWJSaFRMdWxiWUtLTWlM?=
 =?utf-8?B?cHhZbHVqNVpCSFE0ZEFJTXVVSXgrVlB3NXpTTHpobzczRXNPL3hhbThUN2Zu?=
 =?utf-8?B?VUM1c0c0MnVnejdVTytZK0hSRnRIczFBZUk4aUg2c3lTeHc5S1dEY3hrcnN6?=
 =?utf-8?B?SDd3UHpuNno0WnA3Zyt5dk1IaGhkMGkzS0NVSzJTdUpvUFF6NGp5djNrZERs?=
 =?utf-8?B?Y0ZoTHdHUEN2YjRvTFhvMGlOWUVGN1ErYW5KNEhrUGVkYkhEUERZVFE0cTRn?=
 =?utf-8?B?NWovVnRQS203NE05eml1SEVLd1AzTEtrL2lWb3BSV3BrSnNlRklBUTVDNk9X?=
 =?utf-8?B?M1U5KzU5Q2t1K2hKdUhWVVF1dmhxT0VrSkF5UndaZFpQOHV5UCs4bTl6UXZo?=
 =?utf-8?B?UlJDUlMxZ3M2MGdsT2taYml6VVlVaUlxU0g1UmZKQjlhOVJlTzBSNGFxV3ll?=
 =?utf-8?B?M2k4TWs5UTBNL21WdTN5RitadEVGTVpSV1Y2RVlMTHhvN2ZxT2dUK1l1MytV?=
 =?utf-8?B?QTkyVzZibHBFRW1WZzFiekRhVWlSVUp4UFd2b2IxMHBUSXpOczFhQS9wSzRt?=
 =?utf-8?B?bFVkR041WXpBcmVWWXhEQTJ4Y3V4Vm9iaHpxSUpPNENhN2h5S3FPUzRQNWg2?=
 =?utf-8?B?Z0pYZ3g5SzlnRFhvL3Qydk9tVDVueHlFOXMwMk1WcFZwd2g4NXEvWHlDNXFv?=
 =?utf-8?B?RkhxTU1SZVpkZ2FNZHh1VHdDdEZ0T0FDdFIyM2REdXlXaDB1Sk0zekNkQWt5?=
 =?utf-8?B?eUZSMjljWndLSjdROXlTam9jQWx5SytUTC8zeUxiY0FGT1pTZnFraVBPZFFj?=
 =?utf-8?B?dUgyeEUwY085ZXo4QitrVXFXRDUya1FBejViTDd5RERRYU50Y2F0VTVvbXdq?=
 =?utf-8?B?dlcxQitxd3p2ZENBUURzTmo0OHVZVTM0TVc0THI5a1c3OVJVcE1RVEVPdWlo?=
 =?utf-8?B?OEdHY2o1a3pUNUlJV0h3TXJUdWRFZUFJeGpSalhTaVpEeldaaDZNMEp1dkdK?=
 =?utf-8?B?SkFDS1VvbVNGWlZaVDIzTmpSOGYxUzBJcG9pdUNBNmVLMUtCM3ZCVEhFeU8w?=
 =?utf-8?Q?+D0EIKGvNB2S5CUJ6HAIIFsO4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a95f51e-207e-44e3-bcf1-08db83789026
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:10:04.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQh90/ef4W8HJzKtUX1inE4hhsHp653HQjnNDd+EkljAy8rJx8aZkqt51S0sIXLsWgjgeItMHEPDKFEz5lo3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
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
 drivers/mmc/host/sdhci-bcm-kona.c  | 2 +-
 drivers/mmc/host/sdhci-brcmstb.c   | 2 +-
 drivers/mmc/host/sdhci-cadence.c   | 2 +-
 drivers/mmc/host/sdhci-dove.c      | 2 +-
 drivers/mmc/host/sdhci-iproc.c     | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
 drivers/mmc/host/sdhci-of-sparx5.c | 2 +-
 drivers/mmc/host/sdhci-pltfm.c     | 4 +---
 drivers/mmc/host/sdhci-pltfm.h     | 2 +-
 drivers/mmc/host/sdhci-pxav2.c     | 2 +-
 11 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 6a93a54fe067..2e3736603853 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -319,7 +319,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
 		.of_match_table = sdhci_bcm_kona_of_match,
 	},
 	.probe		= sdhci_bcm_kona_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 };
 module_platform_driver(sdhci_bcm_kona_driver);
 
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 4c22337199cf..a2b6d8f2eeb6 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -430,7 +430,7 @@ static struct platform_driver sdhci_brcmstb_driver = {
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 	.shutdown	= sdhci_brcmstb_shutdown,
 };
 
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index d2f625054689..1702a499b36a 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -617,7 +617,7 @@ static struct platform_driver sdhci_cdns_driver = {
 		.of_match_table = sdhci_cdns_match,
 	},
 	.probe = sdhci_cdns_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 module_platform_driver(sdhci_cdns_driver);
 
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 5e5bf82e5976..75335dbf223c 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -110,7 +110,7 @@ static struct platform_driver sdhci_dove_driver = {
 		.of_match_table = sdhci_dove_of_match_table,
 	},
 	.probe		= sdhci_dove_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_dove_driver);
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 86eb0045515e..0dbebcecd8fc 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -432,7 +432,7 @@ static struct platform_driver sdhci_iproc_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_iproc_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 	.shutdown = sdhci_iproc_shutdown,
 };
 module_platform_driver(sdhci_iproc_driver);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 48ca1cf15b19..5072b59f6165 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1521,7 +1521,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.pm = &esdhc_of_dev_pm_ops,
 	},
 	.probe = sdhci_esdhc_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_esdhc_driver);
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 12675797b296..cba3ba48e9dc 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -85,7 +85,7 @@ static struct platform_driver sdhci_hlwd_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_hlwd_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_hlwd_driver);
diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index 28e4ee69e100..26aaab068e00 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -260,7 +260,7 @@ static struct platform_driver sdhci_sparx5_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_sparx5_probe,
-	.remove = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_sparx5_driver);
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 673e750a8490..72d07b49b0a3 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -187,7 +187,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
 
-int sdhci_pltfm_unregister(struct platform_device *pdev)
+void sdhci_pltfm_unregister(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -196,8 +196,6 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(pltfm_host->clk);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 9bd717ff784b..6e6a443dafd9 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -102,7 +102,7 @@ extern void sdhci_pltfm_free(struct platform_device *pdev);
 extern int sdhci_pltfm_register(struct platform_device *pdev,
 				const struct sdhci_pltfm_data *pdata,
 				size_t priv_size);
-extern int sdhci_pltfm_unregister(struct platform_device *pdev);
+extern void sdhci_pltfm_unregister(struct platform_device *pdev);
 
 extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
 
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 91aca8f8d6ef..1c1e763ce209 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -359,7 +359,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove		= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
-- 
2.39.0

