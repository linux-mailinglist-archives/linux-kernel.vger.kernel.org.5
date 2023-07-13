Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4D751B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjGMIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjGMINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A293AAD;
        Thu, 13 Jul 2023 01:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feYPKqM09Rwe+84PFwBiwzx6IvZx4tLxuB6OjqbNTncKHATg6lke0MiLSU9oWdPEXxKJaDipEFs/EVYEDfErWSKmyL1NJ00XcCg6QOpRFygmyCW81azyJhzmwHRcFfDHGhDFVGN555+zS8qOH7ELtJ6P6S/qdGp6DQGCiUq3nHBiROD652LsoT6vBTFzU8vjgFRxRDVFeu9qukZUwzV0Zpd4n0f715klabRkVeOrWdwsugMDspmf23lxd/v0VPJ8SFS826EDC6XgRFRfb5lQOoKphX6Lz4lkkUZlEw5dX2eAgGuAT+IXt9GgS8k0hP5/He8rV3QbJ2DzgWeRLA9SFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbvoRarTmihEE9SfYnfLmCP64NcG9T0qKBlCHawhwDE=;
 b=OwrT+VYS7/sj0d6dWPjtCU7n9nKXMsa/9wpcnHEOr0T46o0lIpDdJSU+S7igTsyLu18XU1ff7KGwkBhN+3xNejmvK55Qd8fftFCWk2LO9uFEdAdEjrSAM/21bdZ86lir0Oe68bav05YbdxrfFDZvtDmSaRcU+NQOGjIph8loqXoZIMNHQK8eozlf0HoabaF51VEYsWcmJ7iv294LdplamcvcFru/nbj69kr1E7ge4B9ghVcvOWwt8pqMcBW6z0sIyEcnIXLeBi+go/gFBDLnqYkmVLdXq6S4XEne9cMR9xcfec/L7qPbwgXcpAjBaHgXO8Zx9tmvdGXRKzwVYGICoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbvoRarTmihEE9SfYnfLmCP64NcG9T0qKBlCHawhwDE=;
 b=AYHvr834Zc2nmgvSQBvvnmkNmzEQdEpqg/Q6aka7kNd5NMKcZYbNtNkwXKrcdteqsrDr4nij6TPGBPG8FfbJfipbMS9iTERE7rn2e6wVrYoFCwXattBUXb5Ddcv+GndoUHCa4sa9IxgjAX18P/3epJdJYHAMfJ+UxC7x9pcClYRChMNw1Cosd8CcBCaxztiNKbdaNXFc3GgQq2V+Px5MfoafOx+VIVdJTSxF6kNfH6B1AWYoVuoqwoCQGI+dasb9YRXi+3X8XyFI9QX71RwcTq5QpCcTPIXYG63WWuB6rejXIQmIHZ84Zksy03iA1YGSt41RHz5qC2Eo/xq+3SgaLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 56/58] mmc: pwrseq: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:05 +0800
Message-Id: <20230713080807.69999-56-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 067aa949-a9ec-47d2-3285-08db83788ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du9G7VOMrNu2lIGtZ+FVzXV4xi9u44F0krhpXTMj0APFbd2pno/1CrWHY9CPawacrBQRyjSaNNbB56j/SdbtjPwLEQ2tJkt1vzSUaBtEHz9Aq/d7AV8oUHyRg/b82TrpoC4Cuiis5pHHph6kSTN10y33N/Psc5mn8lBRBpjPXwgom8T1FKm3PU3sOSYQqbsvG8sGE12u9zTJP0fOnxgJ20byHlyY6fp5X7llUEallFZuqBcEGnmvsDf/0ydt7SdEXH8aho+rFNSx+Voaf8YKCqhUJODR1SePstuI2+tfIyWCzCom8kw5AKWA0uyUJexQ9haJwUGtfClmAG3Nv96Y+j9DTIJDGMf1hAPhg0q2LsILWPRvAmLY9g6wK9g+p/kJt5nw0eMfafDd4eHn5VJgREE0ioKMZBMQcCZTul3mqYZhHOmbhvLwcUzgROvF5OyIwvsPdjuga5DBw9vbt18y+120spqu/PHEZViI+D55dgROhpB6akfSrLHJYS9Aj/QAl6QOWw4U1B0bwJceOKR14olq8ATy+J6OXtpXj3LL0kTMkZ4/JQy93sc2Tg0CULjPyXmEAFMxVsdzXkzLUUEZmQhkt5dhBybTU7fhJ3x/+106rfKoW5zE8HK/Fq0yclTB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(6916009)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck0rdmttajViUTgzejg1RnNSMGFMbCtWOVR4Vi9ERTIrTHVPWVBkTWJGUjlZ?=
 =?utf-8?B?ZExvenN4dE53WW1nSnd6RHoxb0tIVXlFT013RHdPdzV3VEJ6M0U5cjliQTBG?=
 =?utf-8?B?MkQ3d3NwY05ONkNlcDRTQTlCNURjanRwaHR5TVY3ZEZUZE9xNjZQaVhtcW11?=
 =?utf-8?B?RDNCMXFMdGpTRUVHNElHWnJoSVcxMWlNUkNxREpCZ0pmZG1wa0xPdENFaWFB?=
 =?utf-8?B?OUkrcFhKb0lRb1VRcnUyOEZjcmp6dzlBeHZZOTZBMnJJZTlkTTRSdGt2UVZK?=
 =?utf-8?B?dGFVcVIvNEY0dnR5cG9qYzROV0N6UXNSWHhWb3ZQbmpHZUJ2YUJPUS9jUjBF?=
 =?utf-8?B?UVpNVHcwc0hwMG1pdkI2cm9xdEdEL1lna21xZmlqd3UrYTZZZmhXdlVNZzU5?=
 =?utf-8?B?amxDcnFYejlWcDRQRWRIYzUyNWpkZklLMGhOcHZrdGVEUEtzRWdNYThvYlRK?=
 =?utf-8?B?OVN5bUFpQ2xhL1paQ3JNbjN3eVZYYTF4bkFQRE5QS0xlNUVGQTBXOTRaTnVX?=
 =?utf-8?B?emJQeTF2YU1zcmpWSG5WVXdhR0lKYTFKa0VGajlTS2VOT3JhT1JxbDJvek9X?=
 =?utf-8?B?QWVHbDZ3cEg3MSsxV0RwdFVEaVlGZGRNRGNISkxxSXVuTXBxL0VVYkNXemRF?=
 =?utf-8?B?RjJCVU5YT3ByUFd4K3VzeXd5NXFQOXl5YmtZN01VcUcyU0dzUm54YkU3aUxv?=
 =?utf-8?B?YVVWZnh6MDhydjhnZVNJbU0vTlk2Wmc4N2x2R2VoMEkzQnRBNXZxdU42dkw5?=
 =?utf-8?B?NFRVc3l0Zk1tT2hidDd4K3lUcGtlQSsrbTZhdmo4NjVNS2JQcnR2eDZpR1V4?=
 =?utf-8?B?ZzdKSEc2K1EvNUZ0Sjh2WG02REhBa2hqUTA5ci9UNmxZcmlSNExwQmk2NVRH?=
 =?utf-8?B?b2RUTFQ0WWtrb2ttNjZmbGJ2ZjQ0bE5rdjY3cDNYU1Yxc1Y3N1Vaa0FWaEIx?=
 =?utf-8?B?VE9xajI5UURqN0pFTEFqVnYxMHdCbjVST05NSUZGNWU5K01Na1hMdUdrTGxL?=
 =?utf-8?B?Q05IYngvOU04ci9zQ25WMWk4NEpUbnhMM0Q2dDNOamtEOVJIbEhpZ2hzY2Zp?=
 =?utf-8?B?RHJ4dWF6WTRqUTRDYzBYYUZud3l2MFY3aHhKZnpUMXNjU3FlTXpjc3NGamZu?=
 =?utf-8?B?ZzFlUWtUK3BqdWVkSmUrS2pyN2NPTDJXeXVQcEVYVWFmWnpXOUswenpRd1Q0?=
 =?utf-8?B?eDlod1ViamFkeVRuamtyS0o1a2pkdEhqaVBMTEU1eTRkd2thR2FBdkFqeXJl?=
 =?utf-8?B?bFFLa0djMENSL1ZVV3M5RlBBaFVCcllCRUd4YkhhUnpKN1RuTVRMMTFMNGM0?=
 =?utf-8?B?QWt0OUdTcmlyNTM4WTAwVUlyWFN1emdkaHNlblZMWlVkUDRncC9aazgraDl6?=
 =?utf-8?B?UDJMTkxDZ3hsSGlNY09qcXVPQjhtSjY1UUtoelRQeHpFd0FNWUpOcXN5VFFP?=
 =?utf-8?B?VXJWb1FDWEFENElyR256ZWVNSVR2eFRwZ2pxTjZTczYzOVFXbXJZeHdEUmtL?=
 =?utf-8?B?dkx1cmpsMVhjd3UvVE9lNkF5UVRpdnJGeVlORC94WnRqSnVNbnVxc0FFR3BP?=
 =?utf-8?B?akk2bXA2dEw1L3dFM040Qmk4MDRPdG5UeXdobkdzcHQ4V2VtUWkvMnpRWUZw?=
 =?utf-8?B?OXNXNWtmdllESzhJMDlCalJwNlI1SFdRL0pMTTErNC9XaG5Lb3BnazlqR3B6?=
 =?utf-8?B?a1RCaVNhVFJmaU1SQk0vZGVRTys1NnlJa1J2R0NmZmt4VWd1Ni9OcllwTzUx?=
 =?utf-8?B?bjJHVjZSUUFtOERQbVJjeE1hczZEcFFSS01LczVEakdYVGV5Mlk4bDVHM3Fi?=
 =?utf-8?B?QS9DMktBbDkxVUVTdm5KbSt4dHp4U3M4eURnak5OajdTV3lnVmxHQTgzemdL?=
 =?utf-8?B?d01qaXhFL1RONnE3dmp5dEVKTDBxb0JxRjg2ditJS2ZEZU9XWW83N0ZrVm5U?=
 =?utf-8?B?SGM4RzllSkJzTDU3NDR0L09yamVSaDBUSklRMU95MHJRNTk0Qnlrc2ZjZ0Z4?=
 =?utf-8?B?OTZjTjI1c3kvLzJlTTZiZ0ZtTllnaDFyNFVsWGljc2tZamkweks2c1JERGU3?=
 =?utf-8?B?TEtmenJldStlVWZuY3duYWhnY3BjNk1wZHBybDBrWHpJdkhnUkp4d056OUpD?=
 =?utf-8?Q?mNG3wK3yfjdA6UIk+u1jw5eTm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067aa949-a9ec-47d2-3285-08db83788ce9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:58.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZX3K/eTVawsrFH8gHk0Pn24LwEYnofN4JueXTqE7jnmVjCkCD8FqQRabXCcuPj9gBCidekQiBINznOpIsrjsQ==
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
 drivers/mmc/core/pwrseq_emmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index f6dde9edd7a3..3b6d69cefb4e 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -90,14 +90,12 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_emmc_remove(struct platform_device *pdev)
+static void mmc_pwrseq_emmc_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_emmc *pwrseq = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&pwrseq->reset_nb);
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static const struct of_device_id mmc_pwrseq_emmc_of_match[] = {
@@ -109,7 +107,7 @@ MODULE_DEVICE_TABLE(of, mmc_pwrseq_emmc_of_match);
 
 static struct platform_driver mmc_pwrseq_emmc_driver = {
 	.probe = mmc_pwrseq_emmc_probe,
-	.remove = mmc_pwrseq_emmc_remove,
+	.remove_new = mmc_pwrseq_emmc_remove,
 	.driver = {
 		.name = "pwrseq_emmc",
 		.of_match_table = mmc_pwrseq_emmc_of_match,
-- 
2.39.0

