Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA93F7647E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjG0HJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjG0HID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:08:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3749EB;
        Thu, 27 Jul 2023 00:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5DRWNE1r+LRv/HQeA4yOAag9T7ql3SABtqRgiCViL+tmiJvSIYFm1uuNSN3zfC1Mi29Qr6yW6FZh8P5UzH6UYHESB/xz8Hy5SGRdCg83tUT2HdsBe/t5/JR7JNO4VSH7ZZxgskR8StRLEG1ZKC8wXczm6Y27wT941Eed7fzkVAk6rtii1hckVrYTwsAcLePWBFRN12ND2uXmPbwW7yhiAaeoZkXKUJ0o4bnr9fjyt13GhW5FFPQiquyDre0BQqeSY6jTAy93c6E83TrLYCVld0O+nNSVu1UF5C/4LfFnfC8SNcoFDkzgEbKhWFIhsPEKLtyLN3JAZ97KFxyAtz5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSVSY0tmOM4h4fHb2UFkj/zeTOsEVDjfwp+nRZtPSG8=;
 b=ItvpSKFXCA7MFdDiTWko1bRjTvPmWNKHYZtUDIEql00E3+3wIh4OJeGhTMP9YPLllrj+t6iK6M86wqkKkd+jNGRFIZk3bd+tLOhXSvztRdP5iQPYYmZS/Te4oD1HEltDU18zZkQn5O/6C2jj+YH0XGcOJjIKNEt90sEK7ZARoScZa8oRWp70+UuwB8neqtv9QOP+cnvPbAt5cWSH6W64+LQ6eeQiWD5Pnr0KaooHM1q9H3gC0QIaHBaKWwFrIk2FGtosaDESbqsK/kqbyy0MprT23Qau657Tp6hMiFES1hT0udK4KPvEA2gifIxFRvW2Uhb+mgDPdZYz48QwWk7ljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSVSY0tmOM4h4fHb2UFkj/zeTOsEVDjfwp+nRZtPSG8=;
 b=BreGQRPyjhEEYjg5dglmMkjCaoUPB2IWarwdNiBRq4k860RkPWgMSEkhccpk1cCgAhX3PMU4DWv9rprMHsa89zLUdrrkC17y6WQTvX5mdzJ1GObVdm7T+yuAcN3sTGRmAqtuNOaDoGckMNAVQeQGtWzN6kRi00n/aJIwlH8cjMdyUk6rm0rqgBYg4tEti5f9eg+koS41bKo7rrqFqx5cVnfHvJwRXMmVpJ7shaRuoX1cuAOyxvyQrI1zkR2Bpi3hIE9fj/ZDXUzqU/VWRaVqDtYl2m+aQcbc1jaS9wnPVD3JquEdfCY7O8BgKeZir+4imF2UFiyAN4gbc6ILMzY4YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 54/62] mmc: pwrseq: sd8787: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:43 +0800
Message-Id: <20230727070051.17778-54-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: c59eafa2-8874-4d42-cf75-08db8e6f732e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuDH2aEExJ9sfiDvKUczpK5+nGPCbDtR4uslrMk8n2v3v+NMAS+K2DeSwMtNtFTrdR2FW1yEUBGVtd/fItYh3YjfJOksNJigQVBKRdrqu9v+Bud1ao+mOzUGErVuZ7GGS+5jXvAisdTzr3sjhI8eVvAD9LZo09gefGk3X4uteJBK96muzGiUv6onIGOV2VSmvXZ0IOIktDFSUQ4xd2/JgbU6ijVzEP+YeIT3cMWmYDPBZC47n1+c59boTloL1fNXOGZC7IUGj89MErkbWcnNW6Kh+YplabCMm3tQNgNOC8DBpnVW/MfXDO/sKiRod0j6JvR7xYi5IQfr4W72Ii6Ay0Ba2lBqiPnzzer1H8XHUDYm9cosQ8Gk6IHZ2l+BT8ri3E5suGJ7Ar9ndGmQpOqQbind/0+dzBI/tgQGlMvsumISHDaN9d+oqaSxVhCA3jtC5B4/gtr1tUWtq9c+vV4qvGcsZX7xBaj+cmA7QQLe7CM+xFVfd1EzXHx3fJPoj9ULrzQbTyrY7Ug2mJ8c0XIK7gMjDAbetwQynONHHAJ83HToFSzQq2EGl9bd1mIJv7uWdXBU2AUI4dtXAGxeCzqExOktCaS2XbOe9e+IcR5/l5i0krZXxRQHBCNEh1OyuUiG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(6916009)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHQzVFhwSC9SZzBadFFZZklGUk1VVi9qMEVLbGVuTjhLMVJIaU51R0JJMmpG?=
 =?utf-8?B?TzlUTG1CNVI2QVBpVjlMNjdrVDl3TTZxNW1XSGhrMWVGS2l6bUduZ3dybGVs?=
 =?utf-8?B?cmlUU2dZNWZFRXdkZ1BnZzBJTFhvZytVWjVRTlNqK1BaTW5LNFgxWjNyZGVv?=
 =?utf-8?B?TzYyejFNMDRGUVpraUFRaGNBRHdlNEFidnNEK0w2UXJGR3ZnZlpSRGJ2c3Iw?=
 =?utf-8?B?dmJwSFlpRTUxRW12a3JzbUgwVDJGQ2REYWxMV3l3NHlCNThQeEVrL0RVSjk2?=
 =?utf-8?B?Q3NGbFZlaGtxdWlxeVhtcmtqY0kvdUgrNjVsUFlZVW8wcnNrSDR3TW5nYk10?=
 =?utf-8?B?QThNOTE1OGNocnB4REVNME0rWWxHdDd1cG9QcThYQlhKMWcxVjZoUWZ0azdB?=
 =?utf-8?B?MElWY1R1V2p3T0c0cFFXTlNFWnJNVEIrekpQSFJXdEtXbFN2SEI4ajFyWlNX?=
 =?utf-8?B?dkRteVJNOE8ybExjeVI4cUhnZjdmV2FuOWV1anIrR29vSmVYdDdzamlWZTcz?=
 =?utf-8?B?dzJycGc1aFVxRmo2OGxaQnFpREhFc0RhbkpqV2g1eU1TNEx4UENqeUVJamJY?=
 =?utf-8?B?ZEl4OXE3akttUkFCbTVGaDJMT2FiSEF5bnIvY2JFVHBvQURpRk9WeE9nbFdY?=
 =?utf-8?B?M0dsUUNNMUt1Z2wybTZDOGFUYWxSclpyRU9selEvSU1scS9jcEt5OUNiY2Zz?=
 =?utf-8?B?SmhKWXhycTBoR281U1J3N3VKYnorbXpMeFUyMjFGSzBZUXdKYmlHWDk0dzh0?=
 =?utf-8?B?ZnRFTG41bWZ5SUQ1cjA2ZWZsVEFLNE9uTUZ0MEtGcEtUWmVMc0d4dHo4ek1r?=
 =?utf-8?B?L1UyYkFwUCt6S21RcUFNV25EQ01hYzJFNWpuVGNiQVc5RGNRSXVhUWFWYmJn?=
 =?utf-8?B?VHNmS1R3cTRaNHBhSS9Ddjh4MUJYL01uL3ZVUnRsVE41ZFlvRnhNLzN0QlQ4?=
 =?utf-8?B?VkE1MENpRk5BZURDMEg2RHBzL0xvS2tvSVA1ZDN2QVJHd1VNd2FsTzJzRVJs?=
 =?utf-8?B?TzZQcTdvR1BCY2RzK1JDR2krblRoalB2TW5JUXovRDExNDB1VW1FOTVtemEx?=
 =?utf-8?B?cnhyaHlxd1JmbGc0MDNrMkE4emFjNVdhaE5aU3ZYRmpaQlBib0E1N2JpOEU3?=
 =?utf-8?B?QzF4WG40Nk5xeWlwREFTN00yVFlhdjhYelQ4TVVQbDYvbXFpU1FsYUgwTXJ4?=
 =?utf-8?B?Y0phai8ydjVLb0p0UnVpTm8xWTh2NGMzZ3Z5T1BDVDQrZ0hVQmFXNHhTVjVJ?=
 =?utf-8?B?K0ZJYThrMWxXK1F3SVE3emFabUEyTTRUZ3RPTmtmQmZ3R21HTUxNL0E1cEgz?=
 =?utf-8?B?dmlUVkQ4SnBEcVZDR01Obk8vUWh6ZVlqenRYWTNMUFJIcDhtdHpzQXduL1dU?=
 =?utf-8?B?NnJMaDBMMW9yKzRIR3FYblhOWW1JM1JlZzNQVEQ2akErKytrZ0hmd001VTNU?=
 =?utf-8?B?K3Y3dnFWMG9mTjR0V0c2TGpMeHAzVkltOGROdllxOTNTdit2b1B4UkxobTk2?=
 =?utf-8?B?Ry9YN2diTktsSk43YXFuQmsyWU5WYmNCUlRtZXpockNsV01GYmZzRC9ya3FL?=
 =?utf-8?B?MjNrbUgxRVhmTDZSODl5YVA3NVMzS3c4cWY2QUc4M1Q2NFNSTE9tTVBGYytR?=
 =?utf-8?B?V2MvNHdPeEhSS1hPcmtSbzl6d0ZaV21Rc0hEMzRuZTk0N1ZiZG5RNnRhL3p5?=
 =?utf-8?B?MFFPNVBNZG9FMFlVQ09yeTdBSHIxVExGNDZ0L1dTWSsrL3NyRUdxNEtORjJu?=
 =?utf-8?B?YWJ5dkhjZTBqNWtUV2E0MHNGMGNwQWNid2tKNXZzeGxCMThkRmlka1VpYjZi?=
 =?utf-8?B?KzZWRlBFTWdLd0tiR0NWU2JrbEpoaE5scE5vdHZPd1BzOForY1g2WWtKRWJE?=
 =?utf-8?B?TGpSSjVMOHdhQ2NFWURQeUpZSHkxSDVjbVdsTmVDaDFRZDBJbE50TjdGSzhq?=
 =?utf-8?B?RXB3eG1TbnZzdE5WREdIekVvSGV6WFpqQ01pMTNxckt4UzIycXJFWmJ3Z1NJ?=
 =?utf-8?B?UVp3VkRONlZGVTMyV3NEdzJreXdPejVsR05NeHJiK25DYUJTS3NmZEF1VFpM?=
 =?utf-8?B?aHZtOTd3RFVoZ0hOY1hyWThLQXJXNWNLVitDTm1YTnMrSVh0NU02OXYvTE81?=
 =?utf-8?Q?Mfdc1ylvKQNLryjhndKIz+Fny?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59eafa2-8874-4d42-cf75-08db8e6f732e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:32.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/e9MMDH7i02wcyK4eSmz7PBnfGaxR7XiiBGGWgaR9b8co5EUd0BIyHg68L9KVgQZoIsRyFJXsjHGM5QYAL34g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
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
 drivers/mmc/core/pwrseq_sd8787.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 0c5f5e371e1f..0c5808fc3206 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -113,18 +113,16 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
+static void mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_sd8787 *pwrseq = platform_get_drvdata(pdev);
 
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static struct platform_driver mmc_pwrseq_sd8787_driver = {
 	.probe = mmc_pwrseq_sd8787_probe,
-	.remove = mmc_pwrseq_sd8787_remove,
+	.remove_new = mmc_pwrseq_sd8787_remove,
 	.driver = {
 		.name = "pwrseq_sd8787",
 		.of_match_table = mmc_pwrseq_sd8787_of_match,
-- 
2.39.0

