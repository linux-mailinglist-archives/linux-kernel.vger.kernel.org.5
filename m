Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689C8751EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjGMKS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjGMKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:18:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B479E77
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUHSZJECmq/ttVDYmM2zXFsDnBJw8tV5znQnxEzwOakD+JihyqEe38BuYocF+819mVdYnppJzkCe/H53JI4CGrBj9IJnlYaFJiQ2YzMEU1BsORaVTka9g38tSBWxY4ZCSEMB6TazOqSWzHK35Zf6CEQtcvCKpui5XEpnJKebl+NBDSw0cz9nA2DOViUSjirOo2XHFBeNog/oamMGT8tr8HZQCGhAWa2iiQyAOgAKwA4mDyo4AMsepQpTmAw/RDVmVh6kKCPozWu4SX/W1jHE5lpoXhLaCBrKMEjwWVBJiH8j+HAPGxjdh7uLBCtrapR8Npk+SZglynA9jw6AP7/QlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeaHT2bqmX3nJfpzENvL3co3+x17nXy1KmB94ot5qbI=;
 b=m6y2G/oIU9+AbtqlvGP2JLnam6Tn3E/HblH5+IwnWVGX1bm5BLbHzn2N0VTn+ns/kSQvrE1j3wFV5qMk2F2QoAKWfXv4izWVNlMdzgPnZuGxuenPamnezFrbzzxiJr9FEjwptEiEOT00DanAE4dHzQmvy6zUB1J3g4rimxxFx8RN2u8BKoWffFA2oyK8KUdAAQGfrXwkWdWf4m2t+NLOfOPsTreu0QqCawlBhcVowRm0J5DrzdV0y/Om3+F6iCUW6UqscPXQ0ItEO+JnbDsllEJ8rl6VQkpn0WmO9LecurjGeeZ1ergPJyXqY7OPRfLps1wrPtnz7zVyr1xtACwR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeaHT2bqmX3nJfpzENvL3co3+x17nXy1KmB94ot5qbI=;
 b=NoC75sF3bYL/uzvFdzHh40W1PnoUoS+Ue1ry6ntIpwLFU3pFoU7oasqUzj38ScXsPOD/A4DrS8Veiqu4guxGmfFS0oQ5Uw7JunjT44TQaMgWrRvelJOFBgwODwJ9+fB/d8nLyQTNMqYHqVF7niwvbRwTaAJTYsemMWQ4ex2ShM+U1nDOD9UFpyAqqzo6bHikPzoRISTEEny2AvJUfpptha2mObv89iaxm4OoO7zXgm4AS22HK/fUpJBp63rDH9w2sREqS/Uk5nlmsemIG0A7TIlu1ZoRP4/kkI8w6kege2KTEGGDX+rkY6VB2VSSRsd2Nc3cgvA+5qBcWPCj9isw/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEZPR06MB5174.apcprd06.prod.outlook.com (2603:1096:101:70::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 10:18:16 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 10:18:16 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org (open list:MAILBOX API)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] mailbox: mailbox-test: Fix an error check in mbox_test_probe()
Date:   Thu, 13 Jul 2023 18:18:08 +0800
Message-Id: <20230713101808.15524-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEZPR06MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ade2e0-dffd-4fcc-6975-08db838a78f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEl9JwU4FxLKaoRBPDAryOF0k+l7fLG3HR8PrRLvV89nuxtKuqAtaVE54MHhNyvezgX6MuedDmisZJQzOGg3AMCZlBwcDdQY31IFWHdJX8P+NZPx+vqn+PtEaF02jH4xjhE8uFuqVxYo2dyD/P6uGV8vRTYQioa7qW6XxQD9nwyuH62kgY/AEh0e6L/3AxXmCBUKL+ekTJfclxi4jLLW6z6jni2hp/SgetNOivKQacr7mrrqywMtL+RlY9KXVVncmGWuwaKOwmfE9vIbZAnox3ZU5wcP36SnTy8tsKVshKZIdUpZvgzypsqQuPl7286f4cGpIAmIywFnI+E3Py/1B0VXKau8LJNpqxl5Nk6b/8K+Ak4Qwqjvxwatl7ZQMG9C9V1/gox3z5NnnuFmsgnsF3voQDjAsET9lR6prqDBQeT2Qtrns8wt/bZeoN5SXlzK9ypWpEKBodNYyg6hTT6JAOukNrW2Z33lIhkxM+Z5mf4gCAxzA1ECxRPOHrsdnPfECRyc0oHBgYyRK0z/uHPyjnd4SnMF5bHWiAimlJ5bIAB6svbaaNFzXhqKLOW0SoD0ScAljcM1bh2i0+N+1M5c8sCGlSIRuItQU7IRSe7DcSJRsSf16laW0LSu3A4OaAEz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(316002)(41300700001)(6512007)(8676002)(52116002)(66556008)(66476007)(66946007)(6486002)(4326008)(478600001)(83380400001)(6506007)(6666004)(107886003)(38100700002)(38350700002)(8936002)(1076003)(86362001)(36756003)(26005)(5660300002)(2616005)(2906002)(15650500001)(4744005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBcPvRJMGtUigcBKcm+zHRGWRRKlU/a9ErNOIjkUFs0UkKNAkNyeM/G4dSVC?=
 =?us-ascii?Q?uEoY6DhGk/y4E2Y6d1Iv8ozH39U1DXeSqiB+tEobvJVyG0qQWtTh/diaWPWO?=
 =?us-ascii?Q?RWLRShHdD+2oz/08UCpg4f13XFbscLEi5QEbFCVRDa3nzxVuao6vju1MoSYc?=
 =?us-ascii?Q?t0P+0oh8ZmM2tG3p0L1Jh9k6kwVGPPm7JA6n9/wa6fwwUZa1ni2aeyCZnLRR?=
 =?us-ascii?Q?B7RBhXgbXNqOKl9Bqtl+WOUvd4jLual43g/unmg/ZRlGDeSohow1VprJHj8J?=
 =?us-ascii?Q?xNUKTriEDO/b16izWYCH5n7hzN7Hq/ucFfKjYSv8oDMFzu/5VR2yTJkn2q2O?=
 =?us-ascii?Q?kQXhY2g4VV6RkNXtka/ZO8k8914Jz633I/ub8Bl7LnMnIL2DQ+xMrsIr91qA?=
 =?us-ascii?Q?/wyx3c7R/932coVJYYQ4Bkwc45miyjJbYMfT3AM0qXd5yc0ohqB/dqPCA9uG?=
 =?us-ascii?Q?7VgxOdXowsm2bI6416toYT7X31KAeDOOTz3l2532WlZEZ6o9IlHSbQcImB6e?=
 =?us-ascii?Q?m4TJhNsE8HrWepSJTJh4xYFIi7zB0n7DK6b4Yhdarcss+8G4igH5Qbh0G2DY?=
 =?us-ascii?Q?eQgT3jOerVspYm/hz8jQy8S17H3TUDr106tmXRoQaHVGss6tOr5f/DNNqAzf?=
 =?us-ascii?Q?ghjhObeJtSp8e/P6fvA36iHKRxhoxFMUl2ugIzJO9lHBdNJH9dZi8Jv7b/WA?=
 =?us-ascii?Q?ESsa5PN0JP7touIP0Ps7mTF3ptEeZTWQZsUy8y/F37U7isu/C7rXpxEZ8TR5?=
 =?us-ascii?Q?0yaKiuuEAHeFUsuUaP/YxRhxiWZ/Ftywa/JvI5OAJkouAOPomMLeGcpamQCP?=
 =?us-ascii?Q?RBB49gwDQfavDJadBgF3fe9GIEzkjs4Qj41mFTkL+0Si/gIPBES2CvDv3QQM?=
 =?us-ascii?Q?AqDdXfSoLs/5d/WuZIMecxf2LQr1EhcVV/6rrYHVV2zAc/oAPTN5UgWdDvp0?=
 =?us-ascii?Q?UUuScr9FhOGblac9t/Os/OacymnBEsyPP9k79hChsdCWHxQauHOWUiPgdowJ?=
 =?us-ascii?Q?BQSHlDnVxg26Zgf0A8i5Wpa32vXOXewTzki5FeGTAUE9oHMyFT76b/bvkWYi?=
 =?us-ascii?Q?2xLRQT4yEyTth/FdmwFv8YrAFB1sp5iNdbCu8mn2vliMSt2nGeTv4awUSWaT?=
 =?us-ascii?Q?7BreE6Exj6EArMLBQDu190XqjaPD/iuq+R9r+H1cHDErZFxvwdHQdncvkzf6?=
 =?us-ascii?Q?cCuQMKJpSvkvbv+LbnBHcbEbJg4C4+5U03m2dAG14gdQcwFduGxEk7/YNGNG?=
 =?us-ascii?Q?a1A5zvStIPuYTIa9TRIlQWJxZVksI5aGjKlNzBm10r4gO3XjRpGsh1DC8pKh?=
 =?us-ascii?Q?c5vuvixFTH/3Q45tkk/YvFc9VJMb5ePrY0Lf1QFrHeBBMJ5r0GC8+kVzWsKq?=
 =?us-ascii?Q?x+26Ln0z5euHPOkJqjM7M6DjsukINJJn7juiPDxbyDAm3K3dPOk66pMNKyRK?=
 =?us-ascii?Q?CNAiNRoZkcbfvkxSeIDVC/vyRZway0YcSDjKp0IMlEk71EJHUVfCdZHC3phv?=
 =?us-ascii?Q?nVRzPY3f1IP1xTkUxAgjmqCW2dSuVCa0hgTqhTNzTqYLT8iffoO9viDVOidE?=
 =?us-ascii?Q?iDopYZvx8lUyICutfhglCsHMK3foBxiccUdjWEd1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ade2e0-dffd-4fcc-6975-08db838a78f7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:18:16.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRdN4Y3FM1wJdyeVMxtUrxbN+QSyFUiMybK/SFQB7gPRAOhFMOei/v21FuyXGdhNc7j6KXhfUrXrMGKeTDEoEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbox_test_request_channel() function returns NULL or
error value embedded in the pointer (PTR_ERR).
Evaluate the return value using IS_ERR_OR_NULL.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/mailbox/mailbox-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index fc6a12a51..560c0fd98 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -390,7 +390,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	tdev->tx_channel = mbox_test_request_channel(pdev, "tx");
 	tdev->rx_channel = mbox_test_request_channel(pdev, "rx");
 
-	if (!tdev->tx_channel && !tdev->rx_channel)
+	if (IS_ERR_OR_NULL(tdev->tx_channel) && IS_ERR_OR_NULL(tdev->rx_channel))
 		return -EPROBE_DEFER;
 
 	/* If Rx is not specified but has Rx MMIO, then Rx = Tx */
-- 
2.39.0

