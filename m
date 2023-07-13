Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A024D751B57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjGMIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjGMINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0E430F9;
        Thu, 13 Jul 2023 01:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkYuSPPKk6NQCwUMKpjwRbeAlV6bMCKKUSfGG09wl/9EumS/kKTpxVSfu1oUq+hHwhWTIqfAEXet0E/GiYMeWCgRvsqu65odDw/9Naq6xowJXyIdGktOh2I/aol6EXUllTUwmFH0+q8zaiBDeksnxkvomeJxN9O8mV8C2xuJHcDekrhHAsvaJRQvMSmMk/P78YAtwChEk71i+vTAguGRg86wJc9Zk+uB5KbkEnLQUBC/pIMJ1XmN+oFlanZxOVcb+wx9bHP6cCRW+7BsJwJojX+mzkq9P4S14OVEW5GKHGiwn4awHRKcrcUC6nzjyIB1XdHERSvRAQkPALDEE7teZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wphu4Q5Iae50th4Q/VjZF6H8HkQGUHhGQ950+qm5eQs=;
 b=iIzrZUbx0JMdyvdJ0FTDI1QPkloNeIL6t62y8KzpZ43db8XnPbGWCX3MBZdbZhIFh+1tovoOa9DTpfGVioSNfw4Pfc8UlgwO9CnXct9arwoRLb59xqTQkzropg4BBmI1RSLygdAChNsZgCL6yPD4dCNiee9mnOVwS9QWn1vfxsHLnY8MEjmp0FbdbgbizsTmx6LaKOZrW4GFCrquYR35DA7YdcMCIKBYyCYTU1eZIs2OYQ6Wx6xscysFVoJrsqyKxp2tVjF7mevi5/MvrM1X1TVgOy9JaKmdXhDf2/jRinrky+p92H4xVwKG9Cz1AubWiUhXILroq+38OZkKjYjgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wphu4Q5Iae50th4Q/VjZF6H8HkQGUHhGQ950+qm5eQs=;
 b=VudOY0InlJ/MO6FuZlBu75VEN0oguPr99Q1FQ8jW00FF6GpP5LTwreEdNE/MEPXlFE4eei1c/6/NU6v77rUYyHMJt7M67KPgxG8wphZ4H3E7NxvokHgVRbnD90ul0DVwFyHzRLl0UrK4S+jV+QNqvykYJvrWeyRLo7PZpzlo1zPwjdZ2aIZH0Q4girOY8LN1a/VKIqiGpobcuAx2tf03XRJ6B6Urxgc+RzAAS/g2TmcddXZp1bbXaq0ZPn2HpjVrzHnz0T8sKsR3ym/+mame4YDNzhTY640HEzzI9Nd8WEtZ9O1fgH/uOCS36txhgtgFNeIOm01E2QYL/LwY5tsZMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Nicolas Pitre <nico@fluxnic.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 53/58] mmc: mvsdio: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:02 +0800
Message-Id: <20230713080807.69999-53-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c7127a01-a44b-4be0-60a9-08db83788a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9P7MaUa+lPX+bpbjfDWnZct7XEANSkkbYE5t+phWd3jhmWEiUSoPnaoENK4trM4r6uq2YyRgv+Y9/xEEP8mp9Fprt7Dh9rrJEK6VSS1kX6RE289yqUKViO2oOl8yQOvPZ7DsDnpexXa7fsD5yMqmbjD0O7Fx6bBmEogoVh61eX/egZkJxySDE8T+izBx7HAFdPgMWBwDnZsv6uAyDlo6tNvAD+AIA6ikVc458LWTI+uG0Qu2xoJFIfybmob9iHhHoQpVzqM8iAz/211T1KGaO3JZqFHnb1VG6PCUrJ2kKsWcywt5NBv0qyOiD7SktP1hG2VDujRM/1PWci8PYq/4TctSiy8B6OJ019RLoQ3c8ZGRuva98+zpXwnrAQgAU2dE2rSpflvIgI2/fBf15yD+Z90qvEzAm2R4lVWP6ywZODVZ1eesxSsFAR2mK7xMyj8h92RiAfoX1kFm57KbIRHKpWauKMJpeq6bXgGxpH/eFGU+2Z4tUYKvWSQD2ctcuG1MwuE0VeAF6uI2a/MNiwxkqxOLhen2TpGn6xmRaTUJ/U4D0n8p97MaMXmg81PrNYQ+JcLOxuF53Q1MLKGm8auMn2R3TAySWt6QUfwcX+he8E08y50TFitQpDccFtT0FYjz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVLSnc1TjlOdm5TeFV1QlRPaC80UnFoQmlBam1nZDVYcE1rKy84K3pHTmxo?=
 =?utf-8?B?bXJTZ2hRQnZUUzhXd1I5WWlRYjJidXl3bDEvMExGRWtyaWR6bFBJOFd4c09n?=
 =?utf-8?B?UDJzbERxZnlLbHRCWkg3c0sydVRVOUYybzV3Z09rV0cycER2cVpHenRGblV5?=
 =?utf-8?B?K0FkdkkybHUxTzFTbkVJYkw5Vk1CN0orVEVIRUZWbnpBNXlFUTV1cHFaaU1m?=
 =?utf-8?B?a1JDbE1HK0R6djArbzJuNDVvVGY1TWFYd3EzYlVma1B1WnFQV2xMWkc1TmV6?=
 =?utf-8?B?NHVrQlh3OTNVbTdiTjlDKzYxTERrSjEyNHNUanVrSTg2TnR0eHlGdnh0Z3hT?=
 =?utf-8?B?cUFOM0FIbENGUGZDQlB2bnFrQldoZVJOZ3JEc3lsYWN5ajJBUCtuMDczRzhW?=
 =?utf-8?B?aXJKQjRnS28ybHpIMjVPbXA4SkJ3c3pqd3QwZGhselRNTVczMFdNNGFnMEtP?=
 =?utf-8?B?K0RYSjNsUTNsN0Zxa3llRlVORFZaK1haald1bGh2bmcydTFsSkxBUXg5dS9K?=
 =?utf-8?B?cDVRL3h2QUcxTDA3SFp1bEFJWjZZWVNVU1hCTjdrV1FId0lMUlNZSTFNeXg0?=
 =?utf-8?B?ZStyNDUrYzRDT3Jnc1ZhRVFiS3VFQW52WjZ3K0p0NUhOYVFyRkt0WVRtbkVW?=
 =?utf-8?B?bFBnMG9TNTFGS1o1VUo0anNoMnY3RzF0Z1BqUTdrM1Q4MVlJZlBrRE9yV0Rh?=
 =?utf-8?B?TnVUQ2ZzbzZMOXdDcjZVeUIxaGdGYXZNZmdJdEpvK3UvL25QUjBTZmRwTDBx?=
 =?utf-8?B?bFVQaFNaUUQ1N3ZoSWlWNWtZdlJrTWFGVEIxUzAxTUV4akRMS25EeHc3bmJV?=
 =?utf-8?B?c2VxWTFpb2dIRkloSGJlWEVXcndxcm9nRmJ0V2NFQk1JTnJZNC9WOGtXRDZZ?=
 =?utf-8?B?bGpjb0RacGY4SlJGOUY5QTZvZmhLSHZHMUxlY1BKb0JPWUFVZ2NFQW5Qd200?=
 =?utf-8?B?UUs4Z0EySU5hcmhHSlFUN29UQjFFb1F6VUZERjhkSG1xSDZrTUwvemdjWElB?=
 =?utf-8?B?K1RjbVN4OUM1ZW0zcDZvbkRGb2cwUVNydkNlZ1FoOWlxSElIT0ZQWU9rd3Vu?=
 =?utf-8?B?Vmh3ZnlSYWNkYUdTTDJMSHc2REVTdS8vMlMybzlSWm94Tnd6cmFZdmRkZFR3?=
 =?utf-8?B?NUQ4SUJzYVNuMm9rRjFKc09QakIybXZaNHIxUXNoeGVVMnl2QXVnZnFzeExD?=
 =?utf-8?B?WEVBSmR0cDNtUFgra1pzV0MrTnl0aXh1VEttS1R0ZXR2VlJHaUZTbitNUy9I?=
 =?utf-8?B?UlhGZ1J2elBEWThBcFhoTWw5ZWlUclpSU1Z4NEhsNUNFUW9BOHFjQnlvNm02?=
 =?utf-8?B?dEVKcVBVUmt4UWdITldsM0IrTTBJM1ZwZ2pNOHVjUVVyYklwNC9DelNXYU44?=
 =?utf-8?B?cGpLSkI5a1FPOWU1NmtuZmNicHRteDcxYlYrYWtoL2xjeDJ3WWhCNk11Q2tG?=
 =?utf-8?B?anRMSW4wUzBrSWRLc3pZMnVRR0w5YXc0SlF1YklRWDVrNUJWelZqalNTQTNq?=
 =?utf-8?B?ZGowTGJ0aS9PWisxYTlpdTdocTdlUGlPZEdWZTBuUFp0Uy9Zb0Q4WldvTVJt?=
 =?utf-8?B?Y2laV2taWDUyQTAyUkpTWW5kL2p5T0U1UCtlTncydENjY0xKVFU0a1E3NGtS?=
 =?utf-8?B?bWduOEFiQWxoWlFhbktUVnFaWXF4b1lRalpNNkEwZGswZGR5a0hDMVpqNjBG?=
 =?utf-8?B?Q3lZdjRIM1BoTURiNkRtZDFQWVVxeUlwV1Ird3pKZFkxZi93bTFOVld1TEM5?=
 =?utf-8?B?cVoyZ3RPeEhBY0VHaVRGc0p4N0lYRDdQZVVvZWQrRUFFNHF0MkR6cHNGVmJo?=
 =?utf-8?B?MjdYOWdwbStrQmlibFdqaHBJS0pEZEVaWjllaWtTR05weGl3ZWhqeGl4clNG?=
 =?utf-8?B?UFJ5SDBkcTRaN3JtaDdGMm4rbHYwWVJXWXZWeXVhWTZsKzZTWVpMTDByMS9R?=
 =?utf-8?B?MFBBRTMyVDNheWNQN3h1aWZJNWN1SkNwaWg4VTlPT3FEQVIxZUVpWlVTcVEy?=
 =?utf-8?B?bTd4V0o0RU1nakgxbUVnWXRVTmR5RE5lRUJHRFBCWDVtdWZqdElxVkVqU21y?=
 =?utf-8?B?Z0FFNDc2UTZxTHdyUkFjcmxOSHBMdFB2OVdYSGN5UVUvYXRZRnV2YWYycXQ0?=
 =?utf-8?Q?WB0SSVq/oscdHeXVFOkIku4jE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7127a01-a44b-4be0-60a9-08db83788a2c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:54.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJ1DgpHISCAhqFs0moPXXrjAL6eRJyClNEtvKhB+kCj0gb2L7/DiH8r7bHMUDGeZqV+yRxtPP939Q/SoDezqtQ==
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
 drivers/mmc/host/mvsdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index b4f6a0a2fcb5..ca01b7d204ba 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -796,7 +796,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mvsd_remove(struct platform_device *pdev)
+static void mvsd_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
@@ -809,8 +809,6 @@ static int mvsd_remove(struct platform_device *pdev)
 	if (!IS_ERR(host->clk))
 		clk_disable_unprepare(host->clk);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id mvsdio_dt_ids[] = {
@@ -821,7 +819,7 @@ MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
 
 static struct platform_driver mvsd_driver = {
 	.probe		= mvsd_probe,
-	.remove		= mvsd_remove,
+	.remove_new	= mvsd_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

