Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA7762A07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGZEJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGZEIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:08:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C30448E;
        Tue, 25 Jul 2023 21:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4XHDPI1lHO+plL/VmcgemDDo1eAWJAsFIDKYZFeih4dpVpejU5v+LzO1SdacgZkNZ4vQQ8d4DGD/umOZCgtT+UfRFieoEIkhq4ASfhhq2REXEDwDFm8i/V/Fp7nQXQlTLsGyy9y/xNQTLkfA/hB/NOaUCxkI/b8fGyugYqMDJhO5y5oCe3W9tpY2y1dmTKG50KPAKhq1TWU+tcsH05bHPHquDc+8WhgkoE1/iQS2bWGATF8WU1xshLjLFHTKvLly2hF2B71WNSvCJSzC76z74UrtnnXCmrJcf41b2IL3ZyKrWsf24ywGvc0TNJcZ2J95R66BoBsPuX9U/Ziy9pwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg9rpO+O+Vuwq16/2wqHAmJUAen0JpqCAiTPkimHe0w=;
 b=XCp/M99SFUhm2aT2Fpx4vE9avbdVGwAxKnGCzyPNDYeJzQCrqOabFcAXOLrW7pNEF52213f8ehvmnBQCzIerNdBB+q+8U8FZtKYg9M7AonMblPEqyMvHtdkFauzB+GfS4UCcT5Z2QU+Ulx9e2Pgnkef0ZDbNz5pN1v4VCy9DmxpHVeA7Up/p45uYA+b+IAmJQiKpQYEuNh+5lcdbO/+ZhRZfgj/el1P1vP7ewnGU9IXC/V7zm1Sk95HkVA0Cm4xy02V4Pq43zfwACIXGCrkYDjcON3u9evDI+/EKKKtDdQuq8bl6+IzvaLRU+ZIT700qDqPT2S50T9h8pGCWNuEOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg9rpO+O+Vuwq16/2wqHAmJUAen0JpqCAiTPkimHe0w=;
 b=X8zy3zNtoFEIPoyvS+JTVGircL8d45et4Ip4b6WnSc/exjicFvT3bofyGESVII5jhtNlymePgb1nwKScqYYm/mJyN2vYvsgsZq+dOi0v4q3I/h9IRlS+XEKY1/cuu9nGdI40uERkPMriLX3c/kyAntj6BVYqV4cv6+Ov6wsEs8YhVdZpWn6Yzc0RAWE9DU0bzBzLrBpPJVESJyDErCFQfRfYcDFbV6FzI+vTiYR3tLtCo4sK7RfmcQcBFtz53R+mj8Zs4orL5CjSauZCoiR2OoH8DKCFuXOuRixFlInZeZQFQAV0DoUip7hds+NHiv5TlgnsOGEED/uVUfUIgHTADA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 47/61] mmc: sdhci-st: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:27 +0800
Message-Id: <20230726040041.26267-47-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9eb9e51-28ae-4395-4ad1-08db8d8d1c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KOa4FuVgukNi4sySAOxPdfLBvTLVrsSwfKYb4ParvQItOXQfzORcPfINP5+st5T6/I1uPCVReqozM8rb1gJBgQmxINt/WPWtKVVIgqRvX/NiUX3DSaggjfoA7rs/n9JuTWzErJa/mdOSRxKBb5vDywhiLFm1zTdBMbm6rDllfFjmadVsEGUJKwQ5y9hcQPGOir/zYtx889EOnZIc7v++NpumTBOz8T1IpsHwXqRDIqF5+b/JVSUtGDKgRaetwsVKMbvlHrOz0WFedGb2pWUWYS/FawZn8VtxXw1FQh8CNdjpvsnFc6f9odKmXOZw/iBnLyr5k6axlGyMba0cT+4kJpeEVW5sTzGO4avWmwX3xMVBlE7fhe94PTZ0NEKSBlXnAeS1yg79loda6SG1KDQlYLZSxrOW6ULZyqUBl66JK72BmtQparEodzLAKlOpJuhraY7xgVrUrgYqthy78pe8fNkMI9dqBDNfA7vGynMNEStcmTsWQd7awHE91L3Q326G4/vZmGAV71nGwZseo26Ecouwt6uCT5gH+fLR7rRzvmb4vNCJiZEYfI3nX6NO3l2h/gV9kAT363GJS1K+q/mR5FCVR/CshE9HRJb8xY8tW2IUMpvWdRnKcsbn1o2NigG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2kxdzFQUE90dm1BdHI5MWZQeVBSMktMcTRnMmVVYzExWk1PUDUxUVhqdGVC?=
 =?utf-8?B?dDcxTmtIUnBnZDZPSW5LYUcxNHVSMEpCUW1vbDBYNUhhME4xTXpoOUF5bEx5?=
 =?utf-8?B?UGFHWGZ6K1BPcm1TQ0RIaVZtaHpNVXVyTHNuMVBFUStVT3J1SEVvK3ZFaVB2?=
 =?utf-8?B?c1BiaGJtaG9keXF6OEdpZU9XTkxVK1A4RHZjRDYvNkdkUG8zeU9KUXpKMzlj?=
 =?utf-8?B?OUswUnh1dTVLZklFbE02Q2JrVnBERDJGS1RzajIrdHpBald5bWNtajV0Y3E4?=
 =?utf-8?B?ZzdQdXlheVVlODREcDZXclJHV0ZLdnJOUWd1OXJwZGE5a1dsWWZVaGxFUmJK?=
 =?utf-8?B?bWlFeHhrQTRkUFZFTmFDQXNRSDR4c0s0Tk41clU4SVBleitraGMrK3hQaGEv?=
 =?utf-8?B?ZjVoNTBma3ZrZjRhRDE2d2d0d3p3TFRBYWI4L0Uxa2s0TEJhSVlVVHJ2VGJG?=
 =?utf-8?B?VjR0RUViKzZ3NHpRd3RnNFNuanhZN2VzOFV6MG9JSS9PUUNhRUFGS0F4cWhv?=
 =?utf-8?B?NHRFSjkvQ0JqWTQ0M20wbDh0K0FtSkQvd1dScXplM0YxYWZodm9jR0RWaGJq?=
 =?utf-8?B?QlRlaVU0UUl5d2FramNmVXdzVTNZZ0cyb21FMXU5anlEOEhKR25RSUo5ZGtt?=
 =?utf-8?B?Qk1BRUx2UFc3OFpPM2lYWWJFVHh1WDJpMDd5QjZDQU4vZFg1Z2ZUaEp2NUMw?=
 =?utf-8?B?bTE1Zm5waFY4dldVOU9ocTJmbUMyN3BCQTVoKzV6UXg1V013MStGSkVLd3A4?=
 =?utf-8?B?anNHWjN2SkZQMEhFeHVUZThDQnN1VFJ6eWE1YVRld3JpZU84MnZ6SWUramcy?=
 =?utf-8?B?cVBUWm9QQ1ZkMDBqbVJqRHgrQlBreTczcnpxcDAwTDBaeDZmamhnY3drc2hW?=
 =?utf-8?B?ZTl0RGlwcXEvU3dtYmg5TG1zdktUM2F1ZGg4M09vYmhQY2JOZzM3SDZHTFZh?=
 =?utf-8?B?cEZOdW9OQjRCTm44dExBWFkwaG9xS1ZtQitiZUsrMEJFVHJBMkdCWDd0ZWk3?=
 =?utf-8?B?Zk55b1NGdFU5bnlrOWZqUDJ0MDVLZ005US9TU2ZaR0NBNzVJOHRCME5Eb0l1?=
 =?utf-8?B?dDBFN1lpSnhmSks3NHFZck5uMjkyRHExTGlpTkR0bEpvZmNsUDRSbTlvWlND?=
 =?utf-8?B?YmhwTThzSjZvcGZjSFNxTEx2M1lNSnFYcFcrRTh4dUxHenVWTVU4WmFFUWRy?=
 =?utf-8?B?K29scDBkdWNWZy85SW5kbDJ5WC9MWHBCancrQldGUHdybUZnMXhJbEZ0MnVD?=
 =?utf-8?B?YXlMUkkxRlhybnZLOWZtdVdBU2YrVEhHT3ZiMWxHK3NGajBsdmZXQVQ5bm0y?=
 =?utf-8?B?WE9wYkpvbGhuNDlvVXN5NG94bitvcjkwT2hmcnorUTRnc3d4Nk1nR2ZVRWdw?=
 =?utf-8?B?ZEdUMk5uNUNndlgxSkhMTStsTnk1bXIyL1Rya3JOYWJFd1E0RDg4QjVYM3Zx?=
 =?utf-8?B?UzdhUEdEbTNWMXZDQXJIejJXa29xQkdGTnJGT0hKQURKVzBSK2laMjA2TXkz?=
 =?utf-8?B?R21NZmVGWFpVWUdORGxXYi83Nmx1YnJCc1kzb0EwWm5obWk2MXQyWUlJb1BJ?=
 =?utf-8?B?Y0N5K3R0U2JsMC91UDJjeTMxcEtzZUlmTVdVRitwVlRKOUVqbTBOVzZxcU9N?=
 =?utf-8?B?aFYyOHMyZ3dOU3JUMzMvbG15T2pmdDU0N25nZ2MySUJWbTdjcHd6VkZRU2ov?=
 =?utf-8?B?RVhMbWtsdWFnenRMWnhIdTYxLzR4bDhDazUvNGJZMzU3R2ZwWmFTZThwTWt5?=
 =?utf-8?B?YVBsODlSMU51UThFTnNtd0toaEFtaENDK1NzVUtVM2FOYk05ZkM2OC9FUHpS?=
 =?utf-8?B?N3doaWN1Rng3M3NaS2RWdTVnN3A3M2hMTTJwSnFFaTRJUVNMbWxTclNWbmZL?=
 =?utf-8?B?N2RDOUhybU5oTURCSzFNNHhHNTMySElWbkJzdURJSFVJSTc0YStqVDBNZVFX?=
 =?utf-8?B?TWpac1lxZGJaTkJsS3VNL2M5STdjNmVjRUpGL1p2ajBORUE4YVdsQ0ZGSldm?=
 =?utf-8?B?SmxVeFRHbnR6bXhyTVJQY25FMEV3cFcxandyMVI3a2ZqdG1RdUNxcWx3UlJ4?=
 =?utf-8?B?QVVDdGlYc3ZsUzVyTlY5YUxuWktubmx6RzgzVmU5U1E0ZmplZkx0UHFYdlJy?=
 =?utf-8?Q?7nsWJpBT45zS6iTHwlkIU/hKH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eb9e51-28ae-4395-4ad1-08db8d8d1c9c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:21.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUR2cmGN+Go73rY3Xn5lUxneYW8DTNS118ZrBg+kHsgDmpZms78CEVIYAvNoVlnEKn0wd8mImY0+ahLi8lM08w==
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
 drivers/mmc/host/sdhci-st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 6415916fbd91..d955b5f4b7e9 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -434,7 +434,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_st_remove(struct platform_device *pdev)
+static void sdhci_st_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -446,8 +446,6 @@ static int sdhci_st_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pdata->icnclk);
 
 	reset_control_assert(rstc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -510,7 +508,7 @@ MODULE_DEVICE_TABLE(of, st_sdhci_match);
 
 static struct platform_driver sdhci_st_driver = {
 	.probe = sdhci_st_probe,
-	.remove = sdhci_st_remove,
+	.remove_new = sdhci_st_remove,
 	.driver = {
 		   .name = "sdhci-st",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

