Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3437647A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjG0HFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjG0HE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2990A4226;
        Thu, 27 Jul 2023 00:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsDZ53fe1/Uvctacb+IdXGaC4bF0q8ox8SfJjyavJYo/aMPgg+rN0e/LZqsYn/axPlC3oJ2rILGhi6r4HOzM22cAC7+nycs9old97TQWBQW/DRj3n9PMe9LMQZwqlNqHj1/BaO04scFbiRdJIyp7ITO1y+NT/y5fhahE5pJOAuSavWbmHvaQb1SG7Mf8SCBJlaVcuHgSKQ0TFqIJdwcO0jHpxNgJElHUYULR87+QdIHOOBK2pKq3gVt2GuH8xa/XuhgLyPt0aXASNsjpRFwexcZJDzkM0aBzbxE49wvJA/C3JF09O2Akln2x40dvfvGvpQRcoYDmUOW/GANNU7sXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHeI4VADTP325Q2WM85PJChNJujdvQV/fU1uFiPIvKM=;
 b=du9zBbEpRGlS0KRA1mOZvDh5GNGc0dgRlKfQ3bGfycQ209oQl8BHoBB5GG/IU88ceVlJ1cXrMqyGRTfUO8SfFO1R/9kpU5tYPcywXMNLyQvQdPAzrEQR9U//uEAPgVX3nsD1gfprsKtaLsVqzqjQumA9HsLLau+QbaIsYjNWljakhD/BQwt54iVyO0dsC/BNMVNmgOkeSyY5YThduDq/jJoB8hID17Bf8ep732JX+tWAAlFwNYM3EV69EdpYWmlshfTv9IABj9m94vGxwLhsBuIKJ/GqA3RYbYJXq1elmLToVf49xNLBx7wYvIRkFVK2UDeeOZFkwlFfW28SbJ1R1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHeI4VADTP325Q2WM85PJChNJujdvQV/fU1uFiPIvKM=;
 b=gTt7/XliYlPZBfoJHccG2VVfgTatatCrtpPXKm0UL9YRpbn8cOzjiEUWzJTHrgdMH5JavqzsvmeYYVxfA+xh9jL7KrqTALJu7l4KbOeaaYaFeFZJVNAh7qqctsqX5MIx2nGZpTo8CIdNHn9R0KBTJyxR1JT8w9n7fZe4e3OlU4/GC0QKS6JQqWs6d0Xd8YlzpQw+9Fh/XDCDljmmnT/La+Fb0gzU7EEAPCaYxY5ehOfcL9PNzUvG8b8Pc89a6DzFboddrfjra+Wi36uSldt+YYze9uDG8Mni/ww3bDF/zowF73WceAwStq4F04A2ewFUZgN0wygS/bAz9xjUId/jCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 31/62] mmc: sdhci-omap: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:20 +0800
Message-Id: <20230727070051.17778-31-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: ac22902d-f09f-4094-b92e-08db8e6f5b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8hlRJCG66UWq1xuffSu8RcapNknrYaMW8cF1ybFzF1sRDTyleL8QkjMGQebCsk7HgKAD/ke/W2uhV2obWs3PlOvIEXt1JnUnoj+YwdLEwLIfHZG8NIUoNAdvxPPIe/j59BRaA/qhzBNzdReVQxUnULV6+ftJTpQxM2QU7sdkyfQC80UxlIO3kpKvQ1MHtQOMAtWeaHJgZtToqIqhGbzYsEl8tyRSZPv3HO5+7vDQwpZP9cWcYme+Fl+vXllaghYMJA/llFuj8A3wHX6kQvYN2xvWR29PWijoex8XCdBB4krbL+2DDotKOVJIMwCqL1KBUokNLcO/GuvEjgEJ/4/4gV4VY8TZrdueNfGjKTQ3Wf/4zxB9TW5/EWTBQaROW4Vuw92UK0pMuyzcQ5BKYuqzWbTCHgxLYpS5TP30s8dyDWrs0b0lKYBKnx63O2JlauUmS1QqFQgU2W5o3i2INj+QsoB2IO3RmWKjNRi9B5IDQy4+t4wMo3d35xQz5i7Dccg61lrvl0BQoeAWv5BQ/toqHCSNnAPKCdjNiv0Fw95gWxdPFUI75DAlj03sTO7uT+Qh9Dy/N28laepzH6Bj1g0H9F9QtFAWBrsTVpI7j+lH4JeABWHnrbNCr70xeMOTwH2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(66574015)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUVseFFDR25zUmFKdGdTby8yMk8yaTltek9CQklQYll1bmFYdnkrcWltdzhG?=
 =?utf-8?B?SUMrWGoraWdKcDlkTzVRZEs4TklXaGFYSzZCRVBHaUl1OUQwYVRGcGxjOFEy?=
 =?utf-8?B?NjJpQ240YzhieFBnRUxoL2hwTzNxN2Jvdnl3MFZoYkRLMG5DV0hZdlljR29h?=
 =?utf-8?B?Rzk2V1pDR21HVkhKUHBuZkFEdXc0ZzZCY1pNaFNJNDFXQTUydEhxYzAwaXMw?=
 =?utf-8?B?UWQzd25pWFFPbEVweFZrTmtUOTdFSlF1Ukw0SWpYU2FrYWdvYm5rbWxpOEhE?=
 =?utf-8?B?U1BBK2tHc3BCeE5VWlBjeVUxRnQ5TXpXTVpZUFQyaGZvbG5YdGM3RHI0eHQ0?=
 =?utf-8?B?NjVBL2RDZXJZQVNNU3lnN09kYjI0QTQ2Z1p1eEpLRVdUd1Z3SnBzUWZ5eGVX?=
 =?utf-8?B?dVBJVG15aHQ2WkxUQ0Y4bDhmMWN2ZTlHMUVWMkg0WlpqMUNhUWlrOWEya1hr?=
 =?utf-8?B?b0RZeC9sR3ljMjlsK0tiY0lGaFU1cWpkN2czTklsWTZFS2xDY1BPNnkzUksw?=
 =?utf-8?B?VmdmTURVN2Q0V29oTUFpTndKSmZ2cDJJY0h6SFhJZTdSZnlsMVlsYUJOQi95?=
 =?utf-8?B?aldXUnlGU25zNHNiT2lSb1FLR08rTDZzbVM5L24yYVprRGRSOFhWbE1yWVN2?=
 =?utf-8?B?K1dtQ1ZZekRVbXFzSXcraHhRRk42RCt1cjJTdlkwaHk5eFM0dm14UWFJOHpB?=
 =?utf-8?B?eC9mSVJtU3BVU04yZTVkd1dSbUJLSnplNzNndmhiUUx1K1pMR0wwQjcyUVdU?=
 =?utf-8?B?SmNlSU1Vdk5WcUtXanIwM3Bycnkyd3ljQXhpayswRkt4YzhVclR3QWRhaWVr?=
 =?utf-8?B?Q1hpU0Q0VGFUd2Q3azIySnJuK3dvNk5RcWJWK2hZV3ZIOHVBVENWVXQzR0RC?=
 =?utf-8?B?MFo3K0xuWHEvUkwzRjFMMnM0Tk0rcXVaYk1PWFhvV3BndmxFemFEUkMyVnN3?=
 =?utf-8?B?Q0UxV0FUWnR6YVVVU3lnVmlXNVRnU0k2WG94UjdlMWJkbHlSZ2FVRENuSnZw?=
 =?utf-8?B?dENvajhZWHhmQ2JJWS92eVhLTVFEeVhCdUY5QWM0TGttTW1zYk4xQ2hwTFRz?=
 =?utf-8?B?UGxmMG0za3B5QStOcmNmUWYvcmx2RkQvZXNYRituczMyQjJSbGV4NGVsUFVv?=
 =?utf-8?B?OVlYMy8wYlQ5S3RiVm5NMUNIQWFZQ2RGbjFDeDBUdnhWWEdNQVNWSThhUFMx?=
 =?utf-8?B?eHdjZUZsVDBLbHQzRndiYUVDK1BZWCtPNlFIRWhCek4yYkFNVXlDbzdhaTRr?=
 =?utf-8?B?Y0VlS25KM3llSnhSYjJSc256ZU51bEJIcmdFWkVYWkwwMkVRb2YyLzZ4TlRr?=
 =?utf-8?B?RXplMWRXWTBnemM1V2UvbENpMUY2bWdGUkN1OGNTMEI4ZVR3UUdUbXhvTmJw?=
 =?utf-8?B?OVhIR21CMG93ZjZUem43WittT09nRkRFL3FOSDIyak9UWDBJM29xVDZSNkJW?=
 =?utf-8?B?a0xqWTE5bG9DWStGTXVNTDZrRExMWlpWcW1xUFJpeFExY2MvQVFlUUZxRjJm?=
 =?utf-8?B?aDNEQXJuMGt3YWc1OG9JbklhTUlnUUtlaGxpT3IrdzVnQjhacGs1ajVGM1JF?=
 =?utf-8?B?RDBYaitnaE8yWEtJb21TUCswaEJIa256WGI2bEx3T3hiaTB6c1ZhR1Biak52?=
 =?utf-8?B?OG8xdGtxSENRTzlVaTJPRUtrYzRseGVGWFNQOVB6YW10NHFvcHoyaUVrTFkz?=
 =?utf-8?B?djRLRFYvUGk1S3B6OVEvaTlwVXFpOEQxZ0orb0s5eVFHMzFxNDF3cDVUVCtR?=
 =?utf-8?B?b1BpNXJyZEhVOUZiWnVvaEpwS282KzFvNy8zNnhBSHNFem0rNnB6a0JTMWVQ?=
 =?utf-8?B?MEJhNWFEek9EK1pIM09veVFzVm1DUlU1c1piSHJJN1htK3huSXlValdYV24x?=
 =?utf-8?B?UHc5VGw5QWZydTB5S3ptQkRSTFdYQ2FNQkNadFo0clRKd2p6cDRaalRYUGVt?=
 =?utf-8?B?Nk0xOG0ySzdFdTJmNUNJWks0QXkza05yVTNFdG5vZEJPTFYrOE1OcFhHc2kw?=
 =?utf-8?B?OUVwRjVYTkdkOEFxL2NXMzRCQS8wZjdWY3dBYVFYTm5nWktkNXJraXhmRFYr?=
 =?utf-8?B?SHhQMGJ6dmdPbmp3UXdBTFNCeE1JRncyNnNtbzVoZzdxTGFDMEd0R095UWlr?=
 =?utf-8?Q?t1VcV3IMR/f3CtCBStTnnmBrj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac22902d-f09f-4094-b92e-08db8e6f5b85
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:53.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmgXOYqfA4fLru8d+dPhCENLGGSGx1TzibUQQwiWeylr9ulQXap0wm0qFkjB7d7Gcx20CKcjMj1zSOBN+mCOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
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
 drivers/mmc/host/sdhci-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8ed9256b83da..6aa77eb4a3fb 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1394,7 +1394,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_omap_remove(struct platform_device *pdev)
+static void sdhci_omap_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -1408,8 +1408,6 @@ static int sdhci_omap_remove(struct platform_device *pdev)
 	/* Ensure device gets disabled despite userspace sysfs config */
 	pm_runtime_force_suspend(dev);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1478,7 +1476,7 @@ static const struct dev_pm_ops sdhci_omap_dev_pm_ops = {
 
 static struct platform_driver sdhci_omap_driver = {
 	.probe = sdhci_omap_probe,
-	.remove = sdhci_omap_remove,
+	.remove_new = sdhci_omap_remove,
 	.driver = {
 		   .name = "sdhci-omap",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

