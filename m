Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA63751B22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjGMIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjGMIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4EF2D7F;
        Thu, 13 Jul 2023 01:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPoO94keXcqB5YleD7O2ZNydg3+jOqqLNaQGQPNu5G6CgAOtLubObl7uy+9CWdjRpeuHG1RzRlvyzc7NSCfA+iWhuBQUstiQmJkJzpvHvBgpLFIiR5cWf7wBDwroDLi5OpIVLaJw7OrlQafvAQ81aMrEg0OwJPWMQUP3tAtqJRcsfyyZV2pUPXLd4ovJhOcndQufdJ+FFtQD9yewk0FaMNQok0htaz/6+3CsiRnFIcm3KTgqxA/1mdIw9xEjsfyABIHZ7wuYMAsAHJH3s7hTqgWuFi2Ic14LKvg0AJ3gsSQJPgn8i6Rvi0I/TPtkt2r9w0Tjsb1juQWxtSH/2FCJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYB4ULj85t6RodZH91W/2KX26vucD5LOfkqU3wXonck=;
 b=hyPdntu5m3BFR+kJqpB1d0UpcsJcjxff6Gwsj24snXf6W80aSyA8ZrMfWYZuryYvXekv+2joXPAuLBhrKdCQBwHvdH0P+H8ZOFNrO8Z03x2+LUQYEpiCDTcdwEtAn2VY8P98BQbjkHR7QbDWDzPJWoF0Q9bIOuiJ9kol47DiJBVBYMRkvUEj1rwsa7qsePwe7sVmwBzcu36mMOLcbA2hixAdxVn5oV7+gRsk5k8WPA/4Ko9ou88A3DWwxU0PMrtgb7Hv+6M90qZYm7d9aYSs/KGr78o1RrjVmTtBvzO6q2aW284n/zITpewfqEURghDZMNJaTMH4qustxexcTFPekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYB4ULj85t6RodZH91W/2KX26vucD5LOfkqU3wXonck=;
 b=S0VvKPOh2ecIOoqq5spv49Hurl47rz83PYTFSjzVqmJaJiak9rwawDQebmHjddCHt+SGoF7hmkarDCYkdXRyVR/8EljWlQQ94Jb/iwrVh8WHPPOHgwC1ztLMzl5TgLhxkV/G2tSr6hHGWnX4BoD3l5m4YCNVRhsdUULJosd9ziDgHLhnehULuoeK4i/P6abKPhaaCq0lWsqT0g2ZWov3hlanfQyBzmqM9TeINd5x2hm1/MEd64IzwcpouTS0xyNofGv6hACNR9u1KOCBldClpt9fsPiuV7OpbFSXc4y8+oSdTtSpfaWaZuoCICGzJFEeD/k7Eqfnjkv1omWcrINH+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 34/58] mmc: sdhci-of-aspeed: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:43 +0800
Message-Id: <20230713080807.69999-34-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26d5e4aa-9aff-4f92-df32-08db83787563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFQ/vMCkNJCFwT68oYAQMTppvLLGuGcjcr1csqHj6+dHBeOtHSbcq0vmD8ZMahwobq0S8K5d+zpbJurDLZK2Gs2A1+Rf8G3PFUCXv2p4Gyn86gq7z/LJKQniEkeifC0YNlunH8tU62klWO7tsvrcKFTYn5h3Tu08TFwVp6zawZJjYd0fV3TRC1PPmJPbVI2nBzw1JG50J98HQJyqIbTX3gPtkV91GPRwA6pW9w4KQIhCpk6KPhJeMHpALp7n3GOpGb6A5fbPENyQ1daPgi+/oFoE7708svlWUuS+TEAL7jdjTFCc8xlwoGBRNGZQC0wJyFI0WRSelxmf17TW6RDuy6n3vNDKUhXkhrfDwvDbmD8gbY0NBZy+FJN8/0RmPXeVWXgmRiQOMNI9ufFgwOpKciLXqhgtv8GMzP6qtnRAkbT6Sp8Nn9GZ154rPjzTiUUiWzk2/hT/g7nDDt+1yCkZIBACfmOYxiyAebpArv+HQLFVlNGoNSWG2Wrhy0+cLqTF9wsACKMV+JIJUd5mHkxE2/Pdz+eRCrsu2kY7LI30x+bKtLwxItmKSqIMa/y1MCCC15wOgxie+9kRZ+qbXB46YaMuDMJeytqU1VPo7PsRd1563MrvvajPdYFL6ZJyf/Kq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(7416002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1JaOWRtTHlqc3ZCLzRDVjBnT3doOGVYSUZjNDEydWpXVDFQWitPMkFSQmEx?=
 =?utf-8?B?TktZR0xYanU3VXdkV2F4bXNSUzFJVnRXNWF0OVVqZVdYS1A5WDFIaE1DbVh5?=
 =?utf-8?B?NWdhUlNEUjl2MytUUG9NMG92azdvTWlDVzdLSzIrRnhCSGowZnVvMEVnaTh4?=
 =?utf-8?B?cWNkSFBVZFpYQUVyeVJULzBrYldXSlZSQzJjT2w4VnErK2JZUXFrTnVCbTdn?=
 =?utf-8?B?cGpUUjVKZkcvVytxRUhRendwSC9PTU9JREdCejJPWm5RVGI4bE1oYUlHL01R?=
 =?utf-8?B?Z0dKT2REWjVTMFFsTVkvM0xxeE0xeEpQakJZRnl4SnpGUGZ6dndMNHlVa3or?=
 =?utf-8?B?akxDUzdwWlBOeUNURkYwTVJES2U0UGxNamh1ZjRLaElRQ3F2Nzg1UlkvdUk2?=
 =?utf-8?B?L2VRN1F0Z0k3dDZLVFdQRFdsVzBkYThDcnY3Zlp3Nm5IK25kZkhxMnljMy9U?=
 =?utf-8?B?bHJrdm9wSzFQRlZYS21leks3aExkdXZrdmpsM1crdDRPUXZORnl0dThRbDBU?=
 =?utf-8?B?Q3A4dEtzaHRBY09QWUV6T1NEUFdlYTQyWkxxbytUSkJ2cnhVSW9FS2pPQkJv?=
 =?utf-8?B?VGZ1ZVhiVzlod3ZLYm1sSEtFL2pDTDVsd1R0TkczMGFlMm12TlI4UUVLTVZm?=
 =?utf-8?B?NE8rWjk3MVVPN1F3TGNRdXdib2lwZ2U4c2JUMm5yamxEL0Q3UzZ0OEJXWHRW?=
 =?utf-8?B?ZmRZd0M5eWFLN1ZsaE0rclErbEVNUlhBU1AvZlduZ2dNQVlvT3hSckFQSmZC?=
 =?utf-8?B?Rk5waXErcUc4NTZ2MXFNbGVEb0xFczNsRE82NWVCcUQvSXJFaGcyWW1Nd1FR?=
 =?utf-8?B?L3F6WDJKT3pKRkd6ek9tSURQUkYyZk9ERk9aUjVwWEozNGZJUmtQOU9laXlu?=
 =?utf-8?B?ZHV1K0FTVGFLUTdJb1VqeEJVeU5ZY3ZVeVBmM0dkcUxGMytsVi96SEhyTGVC?=
 =?utf-8?B?cXZqKzcwRVRsbUgydGZoeUNFUGF3aGl6RktTdXlzRnhoWGN6blBGdm84REd4?=
 =?utf-8?B?MU9iMTJmMTJJQmpid0hpaXRyek9VbDVTSktHdUdkTWpSV2ZQUUFzNXNteDEx?=
 =?utf-8?B?a2tHaWwyMHVPV3h5UzlObEZ6Vlc4WVlKOHZqdDVhRTFTMmxocHMrbFhKdVRU?=
 =?utf-8?B?RGc3aDBUSzlPOVloM2ZFb2hCMDIyY0Q1QVczNGpZdCtjTE1LT09oR3VWRTd1?=
 =?utf-8?B?U0xuRjl6NUVzK1krcFl3Q1B4ZjRBelNFbUtXUXZzbGRabm5UNm01V2ZvWWtz?=
 =?utf-8?B?RDZNTzhtMklOT2ZsRjErblNML29yRlFtYnc3WmJtUENqQ3g3dVN5MFpHZlVi?=
 =?utf-8?B?L1V5cjNHK2VBbDBzMG5vTDZYYk1KRUIxMkFWQndYZFV6Mkc3bTlHZXJUQS85?=
 =?utf-8?B?Y3RsZUt2V1BVN2dONkEzcE4yY0JXZ1IxdnN0ems5WjNmVEJaalU4QUNsbFQ1?=
 =?utf-8?B?L1dDZDJBY3lPNkhzNDRRV1B2clZEWDNmUU1Lb1R5cmJlSnFkZzBkbGtkbUtm?=
 =?utf-8?B?b3JKM2Jiby8yMVRybER3M1doMlZFZzBLQ1VxSzQyY0E2eWUyNWt3M3hpNVZB?=
 =?utf-8?B?M0xCSVN2aWQ3R09tbkt1UVE4eGFZRVI3MUFrVU5TbGFRdy8vOG8zSlJ2aFNx?=
 =?utf-8?B?VzRrNkkvRi9Dekx2aFg2dmZEMW5pZGNTaHN1ZTJSSTB3czJWWEI4MU5Xa3gv?=
 =?utf-8?B?enZSNldJQTlVVUFwRzdkN1IzTzBFNmFtaFYyTkVQdDYwdkNrSGRDbk96WCs2?=
 =?utf-8?B?blQwTEJrMlY4ZVBNVWhkUUNJckdvaURJZjN4QlJVNlZzYmpmWFU1ZlcvNy9t?=
 =?utf-8?B?a0dMRUUxek5CcnVuNjBpRTVxZkpxYVcxSmNQR29JUU4zTk0xUlJHSS9FUDZD?=
 =?utf-8?B?QmYyd1lwcm44U3JrKzR2RFJLOTlrazlSdWFjL0JLTUlwd3NFSXRYZ3AxODVu?=
 =?utf-8?B?OUV1eHdoUTMrRFNGNnhzejF0b1JNTmMvWkoyYjZudlUvaWdDb2N0cDJYVkFh?=
 =?utf-8?B?WGtKTkxaUXdLRnpQNUwvU0xjbmlrY3F0RU1pdWl0Y0F0cWl1VnNIc2w1emls?=
 =?utf-8?B?NmdCZ0cvT0o1eFpXRTNoaFhjQzVBbm9VQlZINzNWbDliZUZxS2VYdTlQc056?=
 =?utf-8?Q?Scu6EyIlyY/GPudXN4gDC+3UV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d5e4aa-9aff-4f92-df32-08db83787563
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:19.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhlGAtM3uC4hssoZQ4Be3bL9ZEteG7xOu4rd4bxk7NReJSHhi6OlpISTRQgQsyp4MLIP/6XUYs1U7U4OiAaimg==
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
 drivers/mmc/host/sdhci-of-aspeed.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 25b4073f698b..42d54532cabe 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -450,22 +450,19 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int aspeed_sdhci_remove(struct platform_device *pdev)
+static void aspeed_sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
-	int dead = 0;
 
 	host = platform_get_drvdata(pdev);
 	pltfm_host = sdhci_priv(host);
 
-	sdhci_remove_host(host, dead);
+	sdhci_remove_host(host, 0);
 
 	clk_disable_unprepare(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
@@ -521,7 +518,7 @@ static struct platform_driver aspeed_sdhci_driver = {
 		.of_match_table = aspeed_sdhci_of_match,
 	},
 	.probe		= aspeed_sdhci_probe,
-	.remove		= aspeed_sdhci_remove,
+	.remove_new	= aspeed_sdhci_remove,
 };
 
 static int aspeed_sdc_probe(struct platform_device *pdev)
@@ -574,13 +571,11 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int aspeed_sdc_remove(struct platform_device *pdev)
+static void aspeed_sdc_remove(struct platform_device *pdev)
 {
 	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
 
 	clk_disable_unprepare(sdc->clk);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_sdc_of_match[] = {
@@ -600,7 +595,7 @@ static struct platform_driver aspeed_sdc_driver = {
 		.of_match_table = aspeed_sdc_of_match,
 	},
 	.probe		= aspeed_sdc_probe,
-	.remove		= aspeed_sdc_remove,
+	.remove_new	= aspeed_sdc_remove,
 };
 
 #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
-- 
2.39.0

