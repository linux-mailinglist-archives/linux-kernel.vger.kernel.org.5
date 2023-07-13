Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5C751B29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjGMINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjGMILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D4B2102;
        Thu, 13 Jul 2023 01:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oepT/ZoJyvDVwxR4VR7zY+fG4EuW9UVnViY9J6S7zk1Bnfwuy0SKC9mXZphEXwqjLXryhI0XGwQfrj4x6QNIiN+Wu6jOn3E26H+0AheIvMAiQW1pG12CSI3VM2I+xGZStE0DQPpkvJYnJtivV49bp15CdGjLJEP0QhYhJjdFAEB33vVCSkBUkAlnrBizY+Gy+LqFTcsvrEywlGs1fkv6Np7mA+Hv/cYVskjazzadLo2VRsXr0JqKhgx7kL5F3SRqHU2lC10U6SNnXaDwRrAvQh1HzjYWwgI2rHLW0kdh6o6DyTTZBiClIIr0y5doudKQqhuzSzDNoo6BB0J+m7hCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMtEtYh4yggL3P4Ktr/c7Zr9RRKQR6LhGA6gTsORCp0=;
 b=AeuuckOgKEMLg6D8nyyu/sQNCsY7pMVrQx7YuOwIrtq8sZCCOZ7Ss49IZMF9pXs20IXgtYwypANjzsccpwuRe2C0AXv/QRe5Xx6iarYDu/hFoYaGNkmYTtJYwUmVWsdOMlCWf9pcIRLU1YfeTY/DHX3Ahj460c2tgJ8ICs2rWAB5kuSrP/ZoQHv/H+bentY+E6aN96It7We8tk/CNW8Mw6GSNHj++BLLZGgXbV4tpjJNG2FoLM82thX31nYRiaVybk7G/l5G3ejS41C1743kZ+thzn5FvrLFdiQ1wBAeb5unGpsAgb5aYZTpeLB30eX0DKcfMOPD2y3d/0AeXThjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMtEtYh4yggL3P4Ktr/c7Zr9RRKQR6LhGA6gTsORCp0=;
 b=get4PgZLKhRYMqQxX5xtrZBI4EueLM/enpmA6YrBHnN0tVo4RaC/rU2gfUgD5BGHIyBHuE/3kun6p1IPCYnj7cSAAV4CamNey0pfG4lzzcdQAdjqXvNXAFgczmYkR7bIA3/NZYHl66ZlJWPdTNbhVQHF9kQTA6RK4CbGXtDDxpcYkdN5JEB9xzZyRTqc1D0gaT9jJB5a3CogxY6JYzGmQNGs/5j0Xeq/l0kc1zovQ3SVBTtAwuCqZIFBef5QmeeUnNHyjxKlkLPHSyWQj5i7mVxeCSRoBlVOke/ULCRq6rttVVq7srquEboIX1IFeEp51aeTuwG0zP3A8XObijmvUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 35/58] mmc: meson-mx-sdio: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:44 +0800
Message-Id: <20230713080807.69999-35-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec7bf0a4-a3ac-4054-a764-08db837876e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16MSeHMUey2zVk3KeGERPfX8XV6QLbsK4hPHIMot37+9Sz7Qahqwq7+UvyUwmAZeK+0C9wIpRCRiU4eTyFxry4dF/NsRJwxJ6nMvJiB8RP8X7hBmboEUqPzEEPIqjhDJBlXStNyK/SybASANvjVEHv0YZyO6zpuNaJT2wZqhgxxuVb8fGNxyauMBtPrmmeUJtiueU7EgXT7X8m3OVGeKD8X6vLPRmF0H6DjU1s5qa5A0kWVbMCTACgSFWGOhIdekM41Vk2WgJSRjYA0OJiiZVAcsXeHdO1MzRdYet2/VPps3rEpVvwB3kSzGkFVoAs8QNf4FSe9Ge6JQHCW2YJ9Pxi6M6/oPjvSK8ZpjEyR+EWmA0MxBdiHuG+j6+SqayjFFaGEehkLZApJEQC6pcpvh1cCY7dYjrcA9ilaUlIXMlEZKvMVPLqY6KhVP9UndiEPJwOQGUzb0huZVsO330lvWWiHDvnlhISTkZMwLylLYnnNoJERZCysgOQ8q8gRCSTtqELlEAJI+neAUHl19aCDo7umLUOPPj33RteHKOk9p2wy3Fja+D9OvATSSmTBmVDENHEag4q1K1bSncOgQf73kMo+5qXXwQuFWdlKFl074oC23RMvM+msI49SA9lNtW7lq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(7416002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZQQVp0QTVsUkxTcGlXRTdUb0JSOWpVTWNEK1RPOEV2OS8zeUhDMWNOZy9H?=
 =?utf-8?B?MzhZZTJZR093V0FYeHZnSGlkczZEWVIrNng3S29OV0NTYkk3bHEwZTA3Y1JV?=
 =?utf-8?B?T0VOQlB3MkY5Q0JQcURGWXlRQ2JaeGkwdWZ5QXl3bEo2UEQ0Y05McXpkdDd3?=
 =?utf-8?B?NzliRkxHekZBYlRHTDY0WW1lOVkyR2pVUmQyb1dqOUJvdUNlMUdRRnAzeUtu?=
 =?utf-8?B?N2ZlQStJaUd5TWhJSGpDdzcxL2FOTmprMFhEN3YzNU9LS21HSUlxZy9QdDgy?=
 =?utf-8?B?dkNENllTaHhTQ0hKVll4YmNucGFUdjJtdTYzaWlIVTdlWFgrQ0RYUlNOQkY0?=
 =?utf-8?B?TG1ScUJiZHhOdE5kSzIwZi9iV2lEQkFYdEZKVnRwY2hualJ6czBSZTIxK2k2?=
 =?utf-8?B?T1hDMVpLRm9veDZCL3g1ZlU4Kyt0K0RkTnBPaEpVeEs2UE1CQnZBb0ovK0lE?=
 =?utf-8?B?MStFRFQ2OXJrb1cvUFVTSFNYekljTTZZRy9OMmZaQk1OT1FYOHRqODlubWpK?=
 =?utf-8?B?R3BUSktoWkhnQ01yOEZlMmY0UEtWL2JVK0t0Qng1azJYdkR0bVJObldnZHI1?=
 =?utf-8?B?eVBwQ3AwcDZPelNqK2Ixc1Z5RnhhZTZGSGtyNHNYbXltWER4ODY3VUQzUUVE?=
 =?utf-8?B?WXIxWjJ1K0xLZ1JNUUpEb1RqYlQyd3NsZ1A1RlhrTC9LSE51V25rZWFkU0lV?=
 =?utf-8?B?RDFwaXlDYW9POHZVdkxrcUVoK0s3bFR6QkE0VjhVNkRhZ0NSWWlCYVhKa1hN?=
 =?utf-8?B?YitnSnBZZS9YbTgwSTFLOXlZMjhvUTlnb3dKd0RCTDZWQm9DT2tiL0V2dGRi?=
 =?utf-8?B?Wm9OcW5lV2U0bU9aTzZQOHE1MkUyVC9EYTdQZnZsUWFYTGh2Vkl1TVFSTXZn?=
 =?utf-8?B?SkhpREtNeWtmK0hOWm9peUJqa1JkblRRMjJwWGZaUEgvb3hSQkNwYnRZcTdH?=
 =?utf-8?B?KzMyMGpIM2Qrd3U4c2M3M05DbE1RSDd4MzNkejhWaldJVlNINGpranhXM283?=
 =?utf-8?B?RDBsYWlSVmtXSEw2RXRzUlBCMGxlQldhUkp1enFNM29XSlhOZzI3WFhGaTRk?=
 =?utf-8?B?b0F1S0QvZVIrRkIwNE55QVZlT1U3ekhOaUkwcjc2bitLQ3VTK2JHT1k0c3or?=
 =?utf-8?B?SzRpTmJnellQZjdUK1dpOXpaOER3eTZYNWk0WWtCYXVkbm1rSmpZRkZIYTNt?=
 =?utf-8?B?WUkzSE82UjBGU2pSTTdDZjNrbEU0VFpoWGtLRE5rTnN6bVNYcFhnVHFjMUpR?=
 =?utf-8?B?TXBDNnFYMkZ2R2QzSlkvd0lXaDN5V3ppaDlhWDNISDFRUTgvTDY5dUsrRHpq?=
 =?utf-8?B?bWoycWpsUm9NdVZqVklkRTFTMmxTM3Q0SmJ3ZENCQ1ZBOGVlazdGWWVidFZJ?=
 =?utf-8?B?MlZMY2srVHRIcWVvVWRnSVE3bDA5TzBmWWlKaTM3TXZMalZ2M00rQi9LR3VD?=
 =?utf-8?B?MnJxLzIwTnVKTVJUeUxXWS9KbHNBUzRxdzZadFJWeHltNEtrNnVINXR4THly?=
 =?utf-8?B?TFFUQkNCdVpTVzcyYmsvTTVUMW9TN3JiMFB2WWJUYUZVYVRGcnMxMUFXVU5E?=
 =?utf-8?B?MmNEMkRlUlVXTkh3amREZHdiUHErNTJqSm4wUW4xaVFRSnJiMlo5R3hQaXdG?=
 =?utf-8?B?dERVcmV6a3BleE9ZM1Yvbm5SNm95WmpFcmJOZTd1c0tXQWpaZFBUL3ZDcm9t?=
 =?utf-8?B?ZEZpZjBaL1MyakVCWmxhd3ltVE5lOG5jaWw3M3JIQWxhUkp3Y1pQOFEwZE03?=
 =?utf-8?B?SmRPQzlDNFkrWTJ5cEhXMDdtOTFLMmlVUDV6cWlaeFNIMHhreHk2bFNkWE0z?=
 =?utf-8?B?cFFtd1V5bFh3TURUQmJwQldGZHk3UmxlcUlsWTBRUEZIcVVycTdvVCtUWEc1?=
 =?utf-8?B?VWhYVUJEcis1WHExMURHQWo2a3RKbGNZcU1GaFhWcWRDYWY3OE9KaDRxTnFy?=
 =?utf-8?B?V3RTL1RiVDZKaXg1WFZ0dUhTaWx0bHJHUkwrMEhSZGdUOThydnJJdVYvSE1R?=
 =?utf-8?B?WDB3M0FOQjI1b0ZPcmt5RUxtZWcvKzVkb3NmM0hIYWl1MndHallyamliSCtJ?=
 =?utf-8?B?QkgybGZoc2loWkVBZTgwSjlkRk81K3ZzRE9DU3BKUVZCamxiTTZaTi9iS2wy?=
 =?utf-8?Q?fC+YcwYQfRpYUCgrm5HS+rdRC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7bf0a4-a3ac-4054-a764-08db837876e3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:21.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUDynbJ95iJrmAuHYp84wtGmS2lPp3GnPWZQtu30c5ff/3E7x+0lxwNM2rc4wq5kJTd6SWVrYg7eSmQrkLvhbw==
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
 drivers/mmc/host/meson-mx-sdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 3a19a05ef55a..a11577f2ee69 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -728,7 +728,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_mx_mmc_remove(struct platform_device *pdev)
+static void meson_mx_mmc_remove(struct platform_device *pdev)
 {
 	struct meson_mx_mmc_host *host = platform_get_drvdata(pdev);
 	struct device *slot_dev = mmc_dev(host->mmc);
@@ -743,8 +743,6 @@ static int meson_mx_mmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->core_clk);
 
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static const struct of_device_id meson_mx_mmc_of_match[] = {
@@ -756,7 +754,7 @@ MODULE_DEVICE_TABLE(of, meson_mx_mmc_of_match);
 
 static struct platform_driver meson_mx_mmc_driver = {
 	.probe   = meson_mx_mmc_probe,
-	.remove  = meson_mx_mmc_remove,
+	.remove_new = meson_mx_mmc_remove,
 	.driver  = {
 		.name = "meson-mx-sdio",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

