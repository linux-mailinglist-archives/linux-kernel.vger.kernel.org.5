Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B457A762A26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGZENb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGZEMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:12:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E979049DF;
        Tue, 25 Jul 2023 21:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4V/6frPZcW4FMjoVNkOcaspGo+swmq2yx0C1PyQsr1vJecn+L1Bqt+GK8DADH2GnopsNO0d6OkKjDRqW+nqIQahoPl9Rr8A0cYQmnhK7BumCG9QMj29g1/65hdeaU9VTlXge0QfnBq8fV79OawtHnLCgBAmuCLtblboYv9T+SJ89jGCGcxDDD3W4uEu/V1kYh909ZsCH1/3wiTYknXm4/vfynfmAApzqo2P3w/crFk80mfCc1d5I4YDYqJYLKUHG1PL9pEyVBAQFbnK0Yitba7emlGdU+Ltc6uVnu6a2wij4lxBwb4Cr1eo/qUjIUQv3r/bZ3aviXMBoW6HsT50PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMtEtYh4yggL3P4Ktr/c7Zr9RRKQR6LhGA6gTsORCp0=;
 b=AnKPJhoVozAzcWi8YwnS6XpJOWXaUUGiesAZtgULDHQhmjM1S7KSWrDr0R93oX3AQpJG8s4cDwvPcUKALxV870v061aus2RPFy46eTHwInpCHQVDwn9AymyzpXsPoR55ss/6qr6kJ9ysrLNn9hKl4frp5aWm0uHTJ17NLGMXlKL3DO5sMgBAdiK+2Ymk1P0ATCz5VBEoyt+Z/EE26yiym43gqMhhhRBzTr1M9jbPlUhl3xdT38c8NZ6x3LFbReLej5KBvzY842/LJrUnxN+y3fmMbzR7lIYAAaOH6A8yEIGkYW2OVEqsLG+RYPY338yWkLJXMzZgL0nMWOb+DlD8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMtEtYh4yggL3P4Ktr/c7Zr9RRKQR6LhGA6gTsORCp0=;
 b=ojocoCYpCeQjEArK5y0HDcpzsvhgA5hjZkQN2/9NDbl7IUVbgsoZxI7kItuaOlIv0ZyAn7/ZkM+9jTxQAKKL4JNTDLuQj4b7pEmc57cJjaf2BjMIGuGwxDZ4mIwqgjohXKY/QyH3urFLpssNUdwVvx927ExZtWmKnbQ0QNc8GDk65AQqGjO27EmugHuD5kxeGtjN4gpVi/Rj36Cp1Z09dwBFggSmDtXlLL6DqzC+FPLZc4Qk+4vc78W1pxQXheqongN7uOBIG1DfNiZnz7TK919VLyeKvn/r9ttxwKqYWFycxoK8ViYfKZMIu18j5aqkSqQyPfd89xn5EfFHisdc2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:23 +0000
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
Subject: [PATCH v2 35/61] mmc: meson-mx-sdio: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:15 +0800
Message-Id: <20230726040041.26267-35-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37aa22ff-92ae-443f-fe98-08db8d8d0f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbam9d6l7XOUl6ysMZwFRiRuBIQrhp5a3KR48jAH9K3EmiJxMoJbgYw6NPErsVz/HNBRztQXh7LYY4WlcfTB3BBJxL+JRIh+eIw1zdOI+ZgHECtDIGqNHnwMlRr+xYkTYag67zaUcxDPeftyJfp22B1rai1AwEYnZU2w0EK7GtBgxKMoXhimyMegTRQFoqa4zG+oLMvsgcltasoLf0XoLu1r51JKt/PFX3bngBNbDQ7q9CXGHrMahh8MRMoxy1VRQBI4Qwmdn3j7Qc0rYzGN2UhuYxblhyVTVCP7bU+ak7OQdmGLUpPckFP0pMHzS13/v018ODWAFjiXWD3MAtypeasHitKXEhoyFwv+QcViuSsTHXeqZ+2ZMe8roGBDBYygcPlBAZoMfnXVlqu737M8QfNwxn8kpSTVWF32iFAcRtvfNbRa4VLtneETTLcVbdB2VV2nJLNpR44DEBEEz9mahZbjBJhblCiIOTznH0Mmyje9TVdcJV0VeIkFFi7Vh4IIC1ZRzY/EfxIjPjP1TSifLqYxWuabxV/+IqPxTVHBNdym8TOtQSt1oqfdDJNNMbossmUoyhVXNU7aer/eGSqIohd/FtwSpBU6ZY23EMhSZ1Y+0Qv9cPlFHyaiP008w0LM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG10WFQvT3BISzFDM1YzWjRBdEZaZE9NUENFdlZFVHFNUUFYUndMOWswK1gr?=
 =?utf-8?B?Tm56MVpWRUo5K2RqRXdUOXhsUEQrQXlVTFFuV2NLdFg0dXlRdVJRcC92TkhM?=
 =?utf-8?B?TXFUaEl5UFdPaHdCekErbnJXQXI1eEhpTjJTbzhFUGVuLzErcEp4emp1dzhR?=
 =?utf-8?B?MjRCbGFkRnA1ZnlsMUIrS0VTV3BydVd0TDQyNVlONlF2NlIzb2JNN2NzRExo?=
 =?utf-8?B?Z3pCVkp1R29HT3psWll3NEJTdXRPN0lla0tnVGQwakVMMzBBdStxalc3MzJo?=
 =?utf-8?B?TUdiamw0aFI0TVk2VWtJL2hBa1VzdmNmK2NiNkdoNHQyUWFPbVJZYm5Lemkr?=
 =?utf-8?B?aldKR2NtcUVjemFJUU5rR3VJa2RyVW5yS1hwcTdKd0trZkRNSisva1hSTnh2?=
 =?utf-8?B?bzF5NExCb2NFZW1KdGo0OC9tc3Q0c0MweDFkd2xHU0UxQ0MrVGNmUTdrd3dh?=
 =?utf-8?B?MFJvSm5mZmdWTSttalU5WHljV3R1cEIrN2tuRXRmbEtrK1BpWVJJeTIvb0hV?=
 =?utf-8?B?ektoR2JMeHlRZGdJbkRpMU9lQ3NRWTMwMGVreWU3eUNwT2RGcDlRVVFBU1c1?=
 =?utf-8?B?Q0NtOG5KY0VZQWFETmt3Ymw3NWdPSWQ2UUxiMmhQQjdaMnNVS201VE9icHVx?=
 =?utf-8?B?M2xNY2dCZFd1UllWSkMxMVBMaHUxNTIvdHVkUDZpRzJwc3dqRWtiMlRNL0JD?=
 =?utf-8?B?MUtLWElhRHhtTHp6YlF5ZzFCMWZUQTRVUFVtRkt6T1M5VWpPQXNqYkpKdGNU?=
 =?utf-8?B?aDhUZ29uckVjaFRoTVg2VGJ1TE9iaXVleDF3Uzd1UndwSXd1cy9iOUl2YSs2?=
 =?utf-8?B?ZHVMamZTT3VDN3hNNmN2ZXRZVk5BaStLYld4cThhUWxma0ZwL0p4Z0RKNi82?=
 =?utf-8?B?VVRyRGRqWnhNSGZ4OTBOTzVTK2k0RkowbytEdVV4SkRYWWVDME9VTldLVURM?=
 =?utf-8?B?TXI1RXZFay9MQlRaWFkwMFI2bjdKMmgyK213ZHBLQU9NYXRseElFZGhzYVhX?=
 =?utf-8?B?VzNrVUFvZTdWT2poNTBIQldyZi8wN2lkTGt0eUtySG9MZTM0eEhiejgzQVlF?=
 =?utf-8?B?d2FDOGNQLzlKUWFIaFh2cDVkMjlWN2ErSGF2T2VYRzNpNFcwUm5nZmF6cCsy?=
 =?utf-8?B?cXhDb1NmZUhDL2hlbnl6SVhsOTdSa2MyalhBVGNIUUpXblhYYnUxKy9LNDJL?=
 =?utf-8?B?YkNWb2hxZ2RCWkpsQ3I3ZUo4a2IwSVdKQVorT1NyUjNuclJhTnY4cEVkbllQ?=
 =?utf-8?B?MTBoUG9KdnJLWXR1RXA3b3ZUbUJha010UHZUK0N4and1MjBmZGVIb3RxaUZy?=
 =?utf-8?B?ZEFISTRMM1Bpc1hocjdyOC9yRStzQzNiaDRaYjdROW5jN3I3T2xrekIwY2t0?=
 =?utf-8?B?K0l6VWd3N1pXSUovVEVtVS9xOXBXMkVCWnFKZ05CdjhkOFFzMkQybkhOV0RT?=
 =?utf-8?B?ODFwZ2J5SndPTSttWWY5Nnl1Q0h4MzR6UDd4NG9kaUk4K2hZSU1samI2U3E0?=
 =?utf-8?B?clU1bkRlTmFRQXh1Kys1SjJTKzh0MzNIUVFZT0VtWHVDMjh4NnpsSWhPT2ZK?=
 =?utf-8?B?Z0ZwK1B2L1pFaW9xOHJ4TWVGaDh3bGJFQVJUWkUySTFPVmhjbmFObVpFTDRU?=
 =?utf-8?B?a0dvTkxPMnRtSTNqWEdkVE1XeVFHc1dmWWdyVFF2N2NvQ0hUek93SUFwQUl6?=
 =?utf-8?B?dHExTnh3RW11ZW1xYms3SitnTHhVRSswUjZ2ZmZuZlU5SThwZnRENWlGelR1?=
 =?utf-8?B?dnBzSkMzWmhQMWljelRBblhidysvdzRUWUFFS2dQYW9CK21uN0lDVjF6Y1Bz?=
 =?utf-8?B?cjJ1MDF4eVpWVXJqc1pKZU5NUndZVlI5ZjdSWnBxVWVPZXBrVyt2RzlCRFNa?=
 =?utf-8?B?SW84eStDejRJWlQ1dzArdTdWc0QvN0h5VFlMd0VPTDE4cHoxbm9LdC9PZkxX?=
 =?utf-8?B?T0djazJiNnptMFFuU3lCM0JucXJxeGJYMTNmVjlSSjBqMUxORGhYdHI3bEd1?=
 =?utf-8?B?cTViZFZzMkI4OERJQTY1SnpkaTBkMHpjaHRzVzl2TWNXdTJoa2ZuaDFRdWtH?=
 =?utf-8?B?QUkwNkV0V0NueXZQR0g4ZW5IR3dCVlMwR2VBRVpaekpqLzJNUHJEZkVJdDRE?=
 =?utf-8?Q?rmcXoAVyf0NThhGdVWfMQ+9GE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa22ff-92ae-443f-fe98-08db8d8d0f41
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:59.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFemOGYolw1aPGhILnq6p4rZNgOP0Z6aEg4Nq0ti/T4ZjmBobImDKiWslG1s24MVNHROCJriwy04TNRn7mp+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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

