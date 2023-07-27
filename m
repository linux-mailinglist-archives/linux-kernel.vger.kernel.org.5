Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5679764831
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjG0HP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjG0HO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:14:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20711.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240872A1;
        Thu, 27 Jul 2023 00:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4mW8h5PnrLFdbw/N9wUEPDikqhdEN852t/6buh7BD07rXqq3Vq47Swuid6vsz8bDP6hMJivHB22c6U8YEgkJ+0IjocevewW60G977Wh9eHELx9n6AWZTrFIVVeRumnkLu7HbD190PrzSxTkQQk2IXlb+qRKZwLckXjgOh7GDIVCSc3M6Fwy9XP4JJX+zvp/7YUKr39vBeinPBJibvLomRqFrLXdjysRO6cHHZudiHQ3qglGwQwozLKMvK4AvM0WrqqZjbe3bKwhs+P/woO6OchLr2gNs+Ezdch7DNKKmgks6XIZybGkuDFYExfjeNi7D6o+ji21k9fjyYBQjv33/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AftkKfw0z8AD4ham5M5MC4dYIWJjDbvgy5EIjA9X60=;
 b=mdr11/Zw5dP/BWs8+EwtFXDpnJYC7qkcajCl/fX/mCPt1cDMq3Fs46XTa+tJIuwHQNfSbFRhzI7be5fWKff6zSOGGSBQdYE9Z6ju/H37iVCiK2dRdXLOJDEegdmuTTl0yXKa0hJq+5EsSQ6UBm3JwJYEOZFbvSppWqOu3zw4vE9WrW+FHypmb8xG/EMuPkPXdcOrn+XOCjYH4Yr9Ct4n6qAsuqZeR+1Oc6mIpeEd3bDK2IMSMtvgbzL75Cr8E/s/jmFtZlhrofJxoyribuzidHRmWFJPi2UypU6Trg4+zhtK0UkimdB2PdmOiMyQKaFjUV4EPFYmcfB0h0sGbmmPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AftkKfw0z8AD4ham5M5MC4dYIWJjDbvgy5EIjA9X60=;
 b=Ykl4jBfGWj2kKMfTnw7L+a2uxHb4VnkV1QXQb6nE9BDSOW2Oihskc3VPyaV4xokj2WTWJ7unVTjmNDlzGIIAfYFGN7FgJWTT7YfZqvX/mbJ1DPSrOyxzB3bvPNr5A8IgmtwnD50L6LLXy/YWpmIUlKw0uZV37kajMtcx616vHcd3yhUqIfWgTu4nv9MQYTR2QovE3i1TWRIiCNvglhEKaOTySfLnx+mdF1hCGrqmqnzdXy1JO6qLstLBP0Cfem2YET6FTnWdnTS2RXAq4GGS4LnhhO6RbHhkeBVgyWmX/i4jjsIVTCLc+QF+3DDVtR2+dHl1RS+hYFlGCZ86dydCjw==
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
Subject: [PATCH v3 53/62] mmc: pwrseq_simple: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:42 +0800
Message-Id: <20230727070051.17778-53-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 62204229-a88c-4a76-60b4-08db8e6f720e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCBheim7O+eGCQyt1jjaQZKqXh5Bt979nAJ4zKFR8N0DVqrXF7W9b3iYuw944FJPswBf0XKC3BPYoBw6tCO+OIZmUqxyp7wVBb84vjaO6molR2gZ0p9OImz3qCqz7M2ctQgEcermueNnzmkfUlmtjZn+M3Ny/w9lGADC/chnRozWTZfUsc4aO/OGXWEZDcQS0Yj+k7goBXWwPv7QtrulBXnWslH37r0tl5+wMbOHtJgTIL1R5V2xxpFd168HnPULkzBg/JiMNu7Mjitrnj86eWYUhH2ljJGRdSTaAXbC4VmaMwgFVfgU8WP6U8gLLaOxIP0fvlNkf1/AsAXsWOPDFMcXg0/pIkRvbpUwsmj65k+rTWUue0S9qbfiKwo7ocGNlUdZEWlQev9fF+97GCAgjVzm39eeDxjfmW0yHYT0TGXOFZsuVK/rqMyWnWe1iw3BMgEtt+StROKifnX8p9SjaeBB2CzvuDBu/4uQUipCVT9VqV3HDkkX3bsD8nPd0cRFFbRpWFYTv2u2y9LbHPCjgoQ+LeAPdUF7kykebSp3fSucRQxaJambvvL6WBnY4D7dMqA0vUTH5wuxS8B27MR6kEebuO5aMh+rx8Gg1hcEbNQLrcFc561m+f+XrgMOn2NZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6666004)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(6916009)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlOWDZnUUp5SHE4MzF4RTEwRU9XVlcwcC9ESjB1Wjh1eDRkRmNSQ0pjS0JP?=
 =?utf-8?B?RzJ0TktmaXBmazBySzhaM2ZwNC94dVhTMzg1RlEwclhmSnRlS05kL2dPRlAz?=
 =?utf-8?B?ZDVadDkxSTFKUjducmliazhuQ1RGTFJRUlViWjZwcmVCWDF5WGcxQmZiRWUv?=
 =?utf-8?B?UlNNWmlrcXY0ZWZhT0VFa3JSRThIdDkrUlZMWmg1SVBtTHk1aEZOdU4ydXlV?=
 =?utf-8?B?ZWEvMVltY0pIR25meUtkaDdLWUJqZGpvVUkwVlNDNFUyK2I3b1hZcks1Q0lN?=
 =?utf-8?B?WlczdzROQjRDZUpDUmJnSVJMam1lNFBQVkRFUHFXWTdkS1VRWUlsM0EzVEZC?=
 =?utf-8?B?TkpzMnVJajVEVGFSRWtWaHhtTjVSQVlDU1p2aGFpQU9XSDV6N3dLTmRBMDhZ?=
 =?utf-8?B?dUN1Sk1VRlFtdjhSNTlZK0Q3SGRqR2NYTGYrZFErYWlVeUNCU0xONUhVaFNt?=
 =?utf-8?B?VWRDekpIckFWOVR0MFB3MmVPNVhaZXlYTTFwaklpRUZzdmZ4MHBtRlNINFVa?=
 =?utf-8?B?akpaMVpuZjhueUdGY3pTaWliTk1nNjFOVjBYdG42UnlYMzc0bytmb29DTHc1?=
 =?utf-8?B?TjBIdmt3c01sOWN1NzBYVjlTRzA4MkNpTkZseXFvMTFtRWR6U0hlYXh2SUE2?=
 =?utf-8?B?bVE1TFlKV3VpK0pJK2ZQVEFkd29RcG5ubzREV2pJTnIyVWNFdkRDWDFibU1m?=
 =?utf-8?B?NmNLOUpWRVBjT2pSOFpkUUViNVhrWEtNOHIrcHNSY1cvVHBTekZrUEJPZTg0?=
 =?utf-8?B?SzJMaGdITm5jOEV0anN1b0dsRFpvbVg1MUNXS2ZweDgyd2FWWDBGNy9ValVB?=
 =?utf-8?B?N09NWHI3Ym9DajdhZy9qVlluY1ZlWFliNzBMMmNrY1pMRHFjYnRTdEw2QUxz?=
 =?utf-8?B?T0tmd2NqRlp6S2VKL2phMDZEVWZGNWNBbnpTVXVqY3NlYmM3QWQ5UDY5d3hk?=
 =?utf-8?B?cytUVmRCS2UvVGJOMDBoZm5vV2x3OU9hWFk1Zm4wWGZwREcwRzgrWThuSkRR?=
 =?utf-8?B?TzE1eXlsYjFQSksyNVkydG5hdUNzeE9zVXlveE9jN2lhdG5CWEtKZGp3R1Np?=
 =?utf-8?B?bXBJZGlwSXZ1RWNSV0cvbHNHS1BrV0U4SHoweWxRNS9YSGpqSXRBLzFudXp1?=
 =?utf-8?B?cTFLeVdsdXdaYnpyRnROSEFvN2J4bjV5T1dDd3MzbFZQOTVJbmIxVUxTNGtY?=
 =?utf-8?B?R3Bkb3MyNmkvaEtCR1lqRmRhL0EyekNob0tHRVRCY3drcUZKdFRFMUE0S3NP?=
 =?utf-8?B?T3d0RGU3djhxSEFHR0xWcDdYa3hZZEE0ZXMxck92T1lteERVRGhwVURYV3pT?=
 =?utf-8?B?VjZ0cDA5ZnlUVldYUjNZY1ZKQnJWVTVKS09NTkZoQXUwcTFkZ3YzUFYxOTRS?=
 =?utf-8?B?VzRKS1BMSkpXRGFXK29KMDluemtsdVVObTZUVm1vc1A4NlVCMjBtV3F2R3hp?=
 =?utf-8?B?R0pQYng5UXdnclBiVmRqQkhhU2dsNXRzZzAvMlAzOFNZL3N2Y2lWenVZcVl5?=
 =?utf-8?B?c09Oa3dqcDdTd3FWcWlaRUtzT0wzNEZGQVJhWDhQRHNWdmtqYXBlWHFxTSsw?=
 =?utf-8?B?S3dIQW1SWHFLZ012WjJlSGVHN3A1WHRYZStvUVJFQ0JZSUgzTGZnNEgzK2Rr?=
 =?utf-8?B?dmpZT0V6NlNzd2srM0FHUWdJNWkzWUFEOTRXWmh1ck50ZnAzUVlkbnFubnBR?=
 =?utf-8?B?MzNsNU40bnNVUWZzWUxOei9JMFY3TjZrODduQTU5dmhrSmxBdFoyRU1mV1BM?=
 =?utf-8?B?cGsyLzZoejlrK1d0cXBaM29QQWRYanlpZzNQV0NJR05iblExbHROTWVVRm4r?=
 =?utf-8?B?dUFZMFZjVHpReXNZMXM0S01RVFlPL2UrellwUGMyQitjODg4N3RLeU1tRHdU?=
 =?utf-8?B?TTBqb0lTdlBHcXlDSTVxTDdmbVBvRDVmR2U4aWNLVUk2SlF3azNxTFRka0JU?=
 =?utf-8?B?cnVVUjRSdEtDbktHSG9tRDMrYWNDb2oybllOcHJtOWlkTE1heHd1ckhKUE9m?=
 =?utf-8?B?bWZFai9ySnJ5OEE0ZkZEeDRTd3RpTjNMMEtxNUw0UDY3VjlTbXBKRFRjSWxF?=
 =?utf-8?B?VFJCRFUyTm9keTBWSFd4UWZXMVRTZzZQa2RYNGlhUzA1emQvb1ZYNjRqUDBn?=
 =?utf-8?Q?OZiceugwaffbUD+ouzynowUH7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62204229-a88c-4a76-60b4-08db8e6f720e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:31.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v59jLg8A8N2RnRtcUQzugxwMLungP44UeqgFvf3/sLBKjw21tJit2poVsELHS9IEPYoGgZOa6f8bk0HVItIt2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/core/pwrseq_simple.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 3bac1e71411b..df9588503ad0 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -142,18 +142,16 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
+static void mmc_pwrseq_simple_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq = platform_get_drvdata(pdev);
 
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static struct platform_driver mmc_pwrseq_simple_driver = {
 	.probe = mmc_pwrseq_simple_probe,
-	.remove = mmc_pwrseq_simple_remove,
+	.remove_new = mmc_pwrseq_simple_remove,
 	.driver = {
 		.name = "pwrseq_simple",
 		.of_match_table = mmc_pwrseq_simple_of_match,
-- 
2.39.0

