Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71D67629BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjGZEBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGZEBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B799C26AE;
        Tue, 25 Jul 2023 21:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6Fj2eaCRx8IYRQ1S2pTdSEL5ARbT8T1qV6G9GIOxcxQZ1AVN3bFvaJM+8ykxobvEMor/GThm0vaiJaTL3ziXTNuv+TfPt48P690gqdFnASRotCTfIjUwplw4RNG89TeEPAZyT+Ep39TYGLWMulXFA1oLv25vGZl1Sqzfk2MVqR/u4zBoUM31BxVXaR7uS1RkVYPwKLULdkSdv/mquxlmtxJj3UPUsj/L6c4SqIPoKIPqg0+ed+UaE61BM4GC8b469ipG1k5xe7GVVMTcz6W2ZjCvYnFE9lp90SxWqip2ZbYvt2sOCxskfVIZw0W3B9xk8MM9+5kaVH8o1KbdsorMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO/T/iqSahPS1fYBVSCrfdexxtG7yArNkbxS9PglIXI=;
 b=Fd9oFGRnnzLi+AlbLo8y1jFKTXmyoDmbwne7NVmEz3v6sybuCYSUw+StAXyHlB4gS87NDL7QCIPiKQ0H6RmmIDDeo6xbpi3LBLhixwpkRsTf+h2DCGgX7YTo0r+m7g3qnVRu7ZBeD3O790fRjtWfXZ4qNXkRj6d0mJKcayCJ1+fp6pb5wg+/sTkvg1VBI8/PWM1p2TKQL7UfFxMWZLwAW4k/p0BCUQ0jVE7M1hUZ30ARObhz48FhpNzzM8lUk4drohzLw4EeWMnVr2GU1JS/f3eWbUwdAy0NMtgIjinzSgzrLXYEiZM1TT8u6NjU0lfNgcCZJyiUoosuHKpDzGhHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO/T/iqSahPS1fYBVSCrfdexxtG7yArNkbxS9PglIXI=;
 b=QhMbmKRDdXg/OOQl6guPZoP+oZy9Zw7wimdcwfz21ME/zvYegLzLrQhJNP6GJzaZ7rleJE+mFuv6MCJxLHKP6Y7WWrZ5L5lBburryLpFkYtuU6H+V3M8PDYO0FsCi2LEAmNuJ+oh1IudwNcPhSLhltIRN22J14ZJpudo1M5I82BK/YNokH0x/LjvltoDdjuEiSzt/AAKrBM9SaUNoDa4jg20N0xfdthwrBwtXDhZKh3+fgJqk/tVTZhjrvofKOXa5I/zRc1wptjMt+M97pKLJ8xsXOXLWMy0msojDyS1j0XVe2on5F+0ykUynkkJPkYJO0o+M5ihzVtXTI2kEM287Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/61] mmc: cb710: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:46 +0800
Message-Id: <20230726040041.26267-6-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f4c318-dcda-4de4-0f5f-08db8d8cf09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLQCY1k12dIcrpD6mDGr2zwjvt7VUyMsPucb03BhjehQmdPbveh5ZKpCqCOwK45KjPkYtOTNL62MJHnFoMS/6Gxhbft4YlxR+KUtLtG0YRBgJhMQdm4TiU+vNR1sAY5bVN4GhfxDkU7iqQ1eX6aH5hz1qaysLCtxcgCcEmPfZpMCJXLofLsclJunctrEVkMU7Bbdd46C/tm0vnwwYEBKpMe30BCchBcSJpmt2lBghH5MVwaJ8GlaNq0ZBfHloHydOGBcLJ6pNLM/cmdod990TieIXHYTMVs8MA9hPQtdfi/c4sLHniDSquqIraTkQ/zYH0bm0GVfc0aCm0DHEi/9/OgUSJ5CRd742k2X9necMSEInaqypfGD03PKVy4aq4YgHQQehgTX7nOsxu6soj3GuTCLlv3Mo+IQ9cJnewiRvRbrIynvg2uUxytI1orKvjvbFVnj+wr7SNJpRPHH8l9Bi2i5zZhSS2verJh9YtgR0CXh7pu40vXUZUWwc1MbWd25mzDA58aZUHHPhIv6QpnplQjaBcN0q9FuZfs1YQHQUD6jMURD4/Mzdtcq2P4Fj9gMU75ujF+2oeys3DlCeIfZ+W1bOaU1yO2xxNh6l0cVUtM74Ndv5vrlbzRg8yNFMuzs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlLakFkYkwvQWhHZ2NpelVwU1BVd05OY3E2SzE2dlIvQ3J3VCtaNnJkYitn?=
 =?utf-8?B?N2xVUStJMkUyK2Vhc1ZwRHNwTHFBV01SMUFQNHl0TzlIbnVBVVNLV2FnY0J3?=
 =?utf-8?B?MURCTHNVLzQ4Z3h4TmxYaVBtQ3c2cWlrRGFSdmo1VnQyWUF3cWMrWllzd1NR?=
 =?utf-8?B?U0lSelZ3aFhBWnAxRlhmMUFFTTh4WDBXUzh0bVVTT25Eb3FiSFVLMC9oWXg0?=
 =?utf-8?B?WkVXazBWbkxRelg3UDUva1piSXRINE5xVG4xTzQvcmZwcUF0WTlSRnlZTzFF?=
 =?utf-8?B?QW0rVmczUm0zYzZyV3dQN0hIdGNUUTU3aWkydmp4MlI1cHlTQXFlU2xPMW1H?=
 =?utf-8?B?dkJjZHFsQTlEdldGeGREbnlqZzFXMmw2VkVJNmpKU0VJbm9ZTndna1MwRTE0?=
 =?utf-8?B?Rk02a2NJakRhTElLRG1TYkhUN2YxL2VSUTZvcDBXNTF0SUM5YkRNanlKaFJF?=
 =?utf-8?B?d0RjazVYbnVCem9CL21QUURZSDBMUnFQcGtQZW13V2Ryb0VrWjEwMllkQ0NG?=
 =?utf-8?B?YmRxN0s5dTdPa0plY1o5WXk2WGlyR1VnUzlCOVdTMDM3TGNPNVpWMkltNVpL?=
 =?utf-8?B?WUFFL0VWSW9HdG5HK2tWekNnYnluVUI1ZXl1RnEybFNTVjJFcnNNMm5lNkxP?=
 =?utf-8?B?bUUwekpNdVRISUpQeXVDSUVsKzBXcnc2MnNwZWpzTllaL21VZUlQVnROTk9w?=
 =?utf-8?B?cy9XdkV6ck8vSm5TZVpOamQrSmpBQi80TndvZ0UyS09ZVkw1RjFPaG5ZSStW?=
 =?utf-8?B?ZDNrTzVIcndVckw0U2FmVDlqUlVld2U2a2FSM0VFQnpRZmloTk5VaTRqZmRX?=
 =?utf-8?B?MjFwWm0xa2lsUTNhcFZUNWQ1RVQyNDFnMExJVWdaZGtKU2FXemFkUlNjZGxm?=
 =?utf-8?B?KzIyYkVVYjN4YWVGZGtzSVNEVFBIbmZvTTIxbi8vcG5TM2hxRXc3R0M5VERQ?=
 =?utf-8?B?OEoySFFMQmxaUFcxUThRaUlCLzRlR3ZsdGUyUVppVU92ajUvTERkNjY1alNh?=
 =?utf-8?B?S2JBSGxLdFJxWGFBV3piY240MDdGYmRlVkQ4TnRCT1hPelJLQW0zU0RDRk5F?=
 =?utf-8?B?UHU5Z09JdzBremxyVDNYZmlqMUppU2xaSmxPOFVBUnZXVlZRTlNTejgyWGIz?=
 =?utf-8?B?MHcvV0RHWE91OGVFT3pVdGVST2NPeXV0L2lOWFFaL0R3YUxkbmRGR2Z3ZkRJ?=
 =?utf-8?B?dkE0NnE4S1Vkb3dHN2NDclc1UmpNTHJoYmJaUm1YajNQUGYxei9JVzlXeTdk?=
 =?utf-8?B?Y284ZVo3Z2NDQjFRVjFTa2ZMekg2Q3dhdnZBaXFPNzUzc2dCM2JHSzVVYWRZ?=
 =?utf-8?B?eHZ6dGhTM3JnWjFtRjI5MHZZUGt5dzV4Q2dIcTgzWU9zR2lZK3BiSEVrbmR2?=
 =?utf-8?B?anZ4MTNld3dVb3p2d2RBdXNDWmtOc2M5TkxXR0N3bjJuWjJZZ3dBOGJ0YWRP?=
 =?utf-8?B?UVI4UE1XaGRZNWJOOGFxNEk1cTM3cWRUaEJibkRxcUh4ODMwSHdIK1dsV1dy?=
 =?utf-8?B?SWdoQm41ZmhTTEFwUzBHamlxZGZjd09NRnZvaFZKdTJtaEdvSkFWMks0aE14?=
 =?utf-8?B?cVlFREczYkg4OGIyZDUvaVp6dER2R3lQd1IwNHJXQlBmTU14TkNINzVkUmxs?=
 =?utf-8?B?SGtkcllNVWFSV2hrVml2emZ1QlZsRlBPSmFkeVZRaHFNNnl4VVJISXlkVWlY?=
 =?utf-8?B?NC9YMDBpM3cyY1dnamZGaXdHKythSmgvSEM4T2pyN0JTbkxvK0RUeUNTT1c0?=
 =?utf-8?B?K1hlR3NsN1d6bmZ5b3BMZWE0Q0dIVEh0R0lVYUd0U2pkaWsrT3JkK2VCc1BC?=
 =?utf-8?B?QjdNTzN0eHkzT0d4NE1KY1JrNC95THdmZjB4L2xxVUo4UjJHWk9EYU5vQndx?=
 =?utf-8?B?eU9HYjE2UG5CTFRqRzNWYXk4ZlZ6T2xiSzZDNDZxWDVyUTJHUlhEUTF6cG5V?=
 =?utf-8?B?dFJhN1pINXhyRDM1dUJLRmllZ1IyTmVrWmVORVU2TDVLVTVMZEs3Z1B1RlBZ?=
 =?utf-8?B?NW43Yno2bHNERmFveHpocm5TTUkvTkcwOGgzbEFSNUhUNXJZWWplUG5xTjFS?=
 =?utf-8?B?L2ZLcTl2c21XZjhZclZPTFFtc0NrSFN4TlcyT2s2RjRVSWlhdlVmWXJqdlVL?=
 =?utf-8?Q?ig8piFjIId4qs/Hi8MbOhQ+TP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f4c318-dcda-4de4-0f5f-08db8d8cf09d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:07.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUcIEx4xz10cX0FJjvBbUcd0h+GklEfN9Pqbhpnxak2irWl4W/01ec+sgjNeUdCo3fsubaw3Jsh2YZlmcbyhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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
Acked-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 6d623b2681c3..0aec33b88bef 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -745,7 +745,7 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	return err;
 }
 
-static int cb710_mmc_exit(struct platform_device *pdev)
+static void cb710_mmc_exit(struct platform_device *pdev)
 {
 	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
 	struct mmc_host *mmc = cb710_slot_to_mmc(slot);
@@ -766,13 +766,12 @@ static int cb710_mmc_exit(struct platform_device *pdev)
 	tasklet_kill(&reader->finish_req_tasklet);
 
 	mmc_free_host(mmc);
-	return 0;
 }
 
 static struct platform_driver cb710_mmc_driver = {
 	.driver.name = "cb710-mmc",
 	.probe = cb710_mmc_init,
-	.remove = cb710_mmc_exit,
+	.remove_new = cb710_mmc_exit,
 #ifdef CONFIG_PM
 	.suspend = cb710_mmc_suspend,
 	.resume = cb710_mmc_resume,
-- 
2.39.0

