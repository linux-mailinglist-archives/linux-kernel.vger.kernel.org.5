Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFF751B15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjGMIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjGMILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:19 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26F1BEB;
        Thu, 13 Jul 2023 01:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iELBa7CsJSLAuUWWFAqJ3Hr6v5J+alAZS/Arq54nI/+kyrn/sUH+LWoqgLno24UMrHyyIwAx0MMzdicT80/QfbRNxDnpjRIgQ86bD8vpKLU/DPPH8nZzIFYeVbN5hv4a0yYIx7oEi1llZnWwvccv08pTEFvt4aIuZEq3ceJ4uutPTBAiqX58ne3sZYtdLpep5DkQLPm/0W2en+zYlkq4F7zKy+YkF96aUmcSVLGPy6Xv349Hyvm0/9K9+f80GxNJaR+iW4ubdYfZFmlx7ZMnTBFKsbqDHwK3IfgSqnWtY9L1cC8FuDsS9Z2XW67DiVW/dQ7qtyY22X7e5QNK/a3yGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5jSVvTfy21nexuFITYTeRJZPViozYwLNoQA6yut0bE=;
 b=kBci9uG3Epi4xUKDnkr6muhSKCHUJLJwjOA4TDjKfv88AiDSnLsXcvRCRKjSm3g41sd644+6yM518zjUY8Oov5xV56nwOf3WLHhIRDNAcC126givfnArAoZJ+mM337sqypQ4F21XK1E3Nd9mj3aoZTTvTb4gDkR/d1r0WGynaxqlEufwPoa4TsOJESTS9SUk+x6Tt9Zp3JIq5/8G1IxJPXgfB34fQpKdPwBW7v++qJUhz0XPxYQ0beziir8aaGUScqs48cTYv3aJhaaklxKGvv8tUhdN9qaGnATukAlZ/l0JVd5npO48Ht/PbS8P4rWEHWnj61zSMuXdXKhlp5SZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5jSVvTfy21nexuFITYTeRJZPViozYwLNoQA6yut0bE=;
 b=UtrCq/nk+QfjnJ3K3Qpw/+lpITTeYDNaBf9M2vpqMw5epuu1JxGS0tcSb1C1RcihnfZSdNqZSQrMmtaV6dEKBe07BcR+2NK9eYI/qqql20M0+NMEy/DFHU1Do9JNZ5TJqusuj/gnu56OGUMQflDlcARqfu9c//kXodaylPGSI7ajhqBwpYIHLU/05E0EbDsSt4ftefcxpnZSeBGlk2dxwTtczESxh2j0NQ8IWquD8e/CmL8g/EnElVTHsYnTuw3IEmag9bCZyuSQ++unCe3tndGQtapphLjaKT88R8PpOKv6OWIe+EbYyuqFA+MT0ebEX2OL0A2KgU7eP6mj0n63HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/58]  mmc: uniphier-sd: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:34 +0800
Message-Id: <20230713080807.69999-25-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fff4feb9-875e-4a62-281d-08db83786ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vj3tGXbA/hNN+K0kbADOJxLK5ThT9tbLqsDP09nyjEhdBJGZd6cdSaNlj0LsKJO+Idt7vwLZvWPuHHxX5SXLVa+ApIRn8vodOPwXWAzceBm63wPGfTxt5TKj0vqJoRjpGt0bXx/KabKswC70HBtPI9LpCiwwFSFOvqhSwslNYqUh6fyOXBUK4lX0mljIsQIlnmDJzxPgKAJcIKQ4cCf4lLZ724KDgppHzSZ90QNn/XHQAcFNHcdN7ejibRgpjx0Z2DJEgGLyOZzwGmUJ2ofM40I9rWIxta5qZbc20jfq11iHHcoefhRnaBfiKnfrfBMrJXfbdmWD7KFrNkN2y+VaDiO6NeUnnQU8n+BtCPuI7ZqqXr2i7YBcUgJRC43hPELzA8YP4x/MqTrMoG3KWoRPaYugMkWeSRYNP9MzO3GGt4wiw2X1nwOCQPqXVgkW17ssFkhXntFf28M0mYbjPPQf6WXxcv4RkHjLXq8F3Gole6KiIn4By1jO1Xwm8PLlusAY4hQAD8VNVNtPDVQu+AOFhS0fnd5k+mF0AHkdUup2jUxN5hGOwOY7Q+8hTjXJM40XrqMteuIxHSWjnOU1kqjv75D0SQ02MJnzMxUcA/1EZtC5Y9ldg/9hXJUxtwnKtWXI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elAxOWlCRzAvUUJLR2RNOWpySGhZWXhJanFveVkwS2NCd0FwUTd0Rit1blV3?=
 =?utf-8?B?b0MwbDU0bThrY1hRZFg4R3BjQmpoRXZETFYycWpPNlJHSEFJelFORnhpNlZX?=
 =?utf-8?B?Sm5GUEM0aXVZMGJNNStuQmRURjhTSW44bncrZDlJaDJVNmJYd0NES1lualN5?=
 =?utf-8?B?TTRQdkgvcjhhMXdwWVptVlFHVGl4Zmc2dHAvNW1GbTQyUTJEeGlkNU94ejMz?=
 =?utf-8?B?NVdjVTZRaWxtVCs0M0dCd0lTd25SZzdrd0YyUEVSY3JhZzB5YitiTUNES1M4?=
 =?utf-8?B?VkpQU3JraHJTZ1dFcDBDcWlzT3kyditYL01TYUpDR1VLMjNsN0pnbmtBSng1?=
 =?utf-8?B?cVBWZmdiS0lhRVdvR1ZjQ0NESXNCTXBpbmZLQ3dxNUduMWVqTUx3NmUwOTdz?=
 =?utf-8?B?UlF4akNJdkFvMzQzcjMzVEcvbEFEazJPeGc3WHByWDY2eWttdjY1WEMwZWFE?=
 =?utf-8?B?M09FbXNwM0VwQTRQNkR5WkVrVjlibmhTSTgyaGtCOHdHdlFzeVpkSHNQaDRt?=
 =?utf-8?B?eGR3a0dBUE02NStZMWRtdlUzMHBxTlVmYmd2WFh6RXBBSS9SK01YdlhnRnhY?=
 =?utf-8?B?MGZscHdySmhrM3JyQWlLdmc1VTUyQVVsWitoYndGeW9xOEMvZjVadklKQURw?=
 =?utf-8?B?cUh5QUp5UkVzVzZYVlZmbFBZWjFuTVJtcTQwQzQ2bnh3RmNEeHN6T0F1ZW53?=
 =?utf-8?B?WUUzTmJ0a1g0ZTU2ZGVSdTROS3poS0g0bkdabjRjOVR3T0ZsUXJOWEtsYWlU?=
 =?utf-8?B?RjRUL2NXYkNPc1ByQ3N0b3dJZm5VTlZ1UkxqQlNhLy9BZCtXMWlCT3MySWdB?=
 =?utf-8?B?MEdwb2U4Z0xOVlRUSFZZNi9UaVltNk9USmF3UHI1THJQK2tyT0N0dUlxZEZO?=
 =?utf-8?B?KzQ2a29OQnZ3b3F2Qy90RUZHd21mMnFpVk84ZlIvM2FFRUlEa1RKM3VjQ01x?=
 =?utf-8?B?VDZXcjY2bFA3VmprRW9oVEZCL2VxR1lwVmVncHFucjVrOUNaeFpxM25zRzZ1?=
 =?utf-8?B?VmFXaXp6ajhVVVVXSkxIclpQdmtaWmN4Nm1CVDlqYUc1Qml5VzRsNmU0ZzU0?=
 =?utf-8?B?MmNKNzdFUjlFM25jQ1VmY09xSGRSSnpHa2NpTlQ0MW50VlhwK09nOUFVVE9E?=
 =?utf-8?B?NDYwM3Y0TW1ZTG5ORlY1T3V0VEg4a3pEanNtQ0ZqL1ZySUlmeE9ZVmJhdzVF?=
 =?utf-8?B?dkxBTVhpN1FabXI4bWt0cXF2YVFJb1h6UHorWnNZMjZNZyt0K013ZHp4UnNB?=
 =?utf-8?B?bmRLN0FybHJFTXVzTHBjaldGRExKUmI2YUNFVSs2KzJjYTQvbVZTU2dXbDNM?=
 =?utf-8?B?NjNjTHNKRDgveEFVOU0vYW1vRGg4U3lRQk5Mc0ZocWFMeUxaNmF2Ti9sL2ZK?=
 =?utf-8?B?cHhxYjlSb2J5dTJlK1phaEpjVDVtOFUvWFd0NFpaSVpNellBaWdjdTlDTExG?=
 =?utf-8?B?c3JFdXJnM1JqaENJWlJIUkZXaGVjWU0yTW5MWVY3TkRzR0FhS3hRYnpGR3l2?=
 =?utf-8?B?N2cyMnNvTEtnWFdndFdjaVZhSGpzR3FEa1BsenF0S0NiSEFwRksxWHZzemxr?=
 =?utf-8?B?YWh6ZmZCcEpjMGJkeVhvWlFRZ2xNanBMbjlxcTJhTUZ6MjZmRll6SEF2QXFt?=
 =?utf-8?B?WGpRQ3NCTEplUEFYOGdDQitEa3lPY1ptbE1aSEE1QXh3dSt5d09nOGlQYVdy?=
 =?utf-8?B?ejR3bFFhaVp2SExrSjc5TmNSc1RMNHNFdkVkOFB3eXUxdE5kdzhQTUhmMXRt?=
 =?utf-8?B?NkpxNHJHMXBjZktORkM3VWZENGJ5UHo5NlJmZ3lLM29mTmhyMzgzRDJmckZK?=
 =?utf-8?B?VXBRalpLM3BuTjg3cHJyNnkrbU9MdDlybDJteG1Scnc2T1NVUFNDRHdTaDk2?=
 =?utf-8?B?N2QybnBSdFllb3YrZzMxTzZubzg0RWQ2Z2VuQU0wRDRsaEhhUmdvYjJLbFlC?=
 =?utf-8?B?SUt2YkdubUprNlZtSFgwY3RUYi9sTzBRSXRnbzlXdWQzWDUxRk9DWVY3RXdt?=
 =?utf-8?B?RDN3RVhXLzZCcTQ5bi9CaXc3TnQ5K3h6VmlTMHFPVnNESmU0YTZndkJ2eGNL?=
 =?utf-8?B?MXc0cFg4UWR1T1VuVDJpL3ZHZUYzY0JnWHJwdmhyTDVxQTZPenpwbFhxanJ1?=
 =?utf-8?Q?DRKRZOPQeKskaPh9PfREcUWH3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff4feb9-875e-4a62-281d-08db83786ca3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:04.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lftmugZw51U8Hhl9rrtMlZQtfxyRrc/Mxj7JI2Vg4y/c0s7/0lyLcZ/tVNNz7W3Bj7DYWrZNsCrYXxzdo0wYrQ==
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
 drivers/mmc/host/uniphier-sd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 61acd69fac0e..33a4d1c6ef04 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -727,15 +727,13 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uniphier_sd_remove(struct platform_device *pdev)
+static void uniphier_sd_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
 	tmio_mmc_host_free(host);
-
-	return 0;
 }
 
 static const struct of_device_id uniphier_sd_match[] = {
@@ -757,7 +755,7 @@ MODULE_DEVICE_TABLE(of, uniphier_sd_match);
 
 static struct platform_driver uniphier_sd_driver = {
 	.probe = uniphier_sd_probe,
-	.remove = uniphier_sd_remove,
+	.remove_new = uniphier_sd_remove,
 	.driver = {
 		.name = "uniphier-sd",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

