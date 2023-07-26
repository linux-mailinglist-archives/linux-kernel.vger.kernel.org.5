Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7677635CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjGZMDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGZMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:03:32 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C34CAA;
        Wed, 26 Jul 2023 05:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtCaTx3A9hMHrTph4JEgCklb/tON6twhCdzkjRVqN+jcS1tEBC5XCPvmKbU1f1hgwP457ThTH2i3VViavRU5EyiFxRDn/C35MqALFqWnRgy/l8i2EtRhF2S93C9ecgkgFO+lNSWNH3VC5VnobKnYVVJjrgr5GSIcvflVGylfsQumMS+NacRoNMvB3JPQ7nnJzjD0+ZDx0CVclidvyQFBjfJ5WESNX4kjcDGuHtggYIql/bJj6BQQ0vml1tUfyQ3thaMveHNDJkjATcyxbAioJXwxIUqIpGoe4jlZb3nd7UCZfWq8639MwCor5y2DUXGCw9CU9p8pEMJjGcYvSKbsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9BCu3xEt2q3AabB4NiWkMNAVGyiWiLUiW8CQPAablE=;
 b=glkLU548aRKUHKYGigzQuY24aObpI+U70XvfGSqEwCrQXrHlSHlkaE0qqyXZIHWZUiIF2gsi7jrV+RYWLbdklzRvVGmSHOC1DP1iyBqe1SY11EpGRPII9p8zjpqh6HMo13aQpUsnqp5SPv2O/8pcpiMsP8bbXpBTGmJDQ1BkSoZL4R/J2fNeRmqMcIUtUl/Svo3vJpkHuJhwG65sSf6HAYwfiAuUtrcq42nZTedbAgTyKedca8TQMHX9+MiClU4tgqrPAWDpEpEZx3k9oPDP9y8ZPNgYzoLoAp6GgUHkJQY947YdkzIwfQAQ1XIFzXG/YM1zHncP6/Vu1K6y6uJCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9BCu3xEt2q3AabB4NiWkMNAVGyiWiLUiW8CQPAablE=;
 b=gcP43hvxyC5S63dbTTxC7DZVAghezj3SdPXzugIoQiIQbk9Vv3fD8XehPC5vbB984PKzOWLNSpRcTg6gxNB1o5OArTUae9FK8XpiVl8hpbfP63vX2k4KnQsg0CkGA6LiRvt0/HPBfWot141kqb3dYvQguqRVSutM2duedXJlK8t7DC46J6MnFbzY+clL2KUBUci8BeTx5lX9wDzgVIcHvpCSyVYm7VY+xiRSfQNOuA+1ykEg0mYEQiYPE7925T7pLS0Au0P+sdk44J10StieCpfjYXrLp/poGzdvo3kRSDa5ZuMW6qWK+4LsgbD/USOXslaMvhQPNuvkXR+q0rGE4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR06MB6580.apcprd06.prod.outlook.com (2603:1096:820:ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 12:03:28 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:03:28 +0000
From:   Wang Ming <machel@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] crypto: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 20:03:04 +0800
Message-Id: <20230726120314.5982-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|KL1PR06MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 494cbe58-5c97-459c-0057-08db8dd0527a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqP5sH/ncClcCkZw430KSZPPymp/Fr/7+/xaR8OnTcEqwgec0CAlJQ11MFIcCslm8K953z8VTeoU3/mHsv0QVZ923YdE4bzHSpKEnptLFZhQhQnfKGSPJcdNJTkSeGvawSiB1sDTRY6OVFrrcrQF+1pSC31RYgORawYa5b6rP/xexfjC3kJmCm8sHLFs5Tlf2n+NLPhrf8H8m9L4ptlNGST5hwrfS1whEMxbHMfeV3wUNG2o9gzAHjh604wDwusfkB640xv6NbZnFFp2gcG3Cn94ZnNbQFnhG+nWuavSFl3oIWAkrNP8JgCpgse4je4+cJPaGOIpx6oVFYx0Miu07iM72AzjGtdeKU7TTh1ExjY7se6aIxZFfh3SWlIx/mlnmUfvNxAgc6Na0ydk8iuXbVTsYPT4itfttKjNRStArddF5S9DA6OCpiVp5HIQRrVSy7Cvn//exe6eheZ0sMJYIZabPohWMCyi/HVIG2ccvTG9mn6RxAc8TJsjM7pDQ5jqpEnBsnZH9byAs63V6ZVNUfVyzRmzSI9v9mslNzGC/wQDIrAy+epZmHD+OUTv9Zn092yRZorciYPOzHrpvzDEeIBNbTKB4YsZYTFRK+FtoinyC5nZNpB30COoVlUz3u6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(478600001)(36756003)(6486002)(2906002)(52116002)(6666004)(4326008)(66476007)(66556008)(66946007)(110136005)(38100700002)(38350700002)(316002)(186003)(8676002)(86362001)(1076003)(6506007)(26005)(83380400001)(5660300002)(2616005)(8936002)(41300700001)(6512007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFHR6/TC2Ygl0qaVPXi0mREko6dOXzxEix8tlM6N1SrO/T1cZNopfaiWM4m8?=
 =?us-ascii?Q?enD9ELuE+qbMPsK+m9vrvKHtQDC8YuyGZDgE7MdxdebEs9hkcFpG45H2GzG9?=
 =?us-ascii?Q?g+0K6ZdL8dnPQgCSItM4+uj63aoVi3Jf/22dlpC44tnNnzk8nWC9KlS1t64k?=
 =?us-ascii?Q?ixXjqZ3TwQFhnSmH+GDAsxbIfovUf4syRwVyacI2sCl+egNyRBpDEudmPPWv?=
 =?us-ascii?Q?ExcGbTUnLxqmTJNunikgxzlt7kY8QvKtvR/tmHYxN1dv4qJU1kmx2B83GGfD?=
 =?us-ascii?Q?xbncJyWcPxl/DCjsRyF/GruP97gn0Gm1LixwmcZAhwJdYhIbupaMXVyVCSmE?=
 =?us-ascii?Q?AX4q0NtrroMdfd+4yR6gnXw6P1g5iqVqu/J9dkhRhwDFdfntzC1x9EZVES+7?=
 =?us-ascii?Q?xu9IlAkJp2KYEJJkIe3BkunjP/JalyfDQ47mbx1BJHPLyb/fYm2oodY3G8p1?=
 =?us-ascii?Q?unKbRhBzROuC5T6NX/iH3fLfdSuEPjiQO1jh3hUNXsYXkovgeoiIPCwDeBy8?=
 =?us-ascii?Q?vabgApfC1AlTwmAdPtqaS5gcGGB4wJVyTBkOo9FPRAT7UOdkN1CaWBACyK8X?=
 =?us-ascii?Q?drjP+AaYZiZNMa2maA9AheKojlLAg4nHV2Kk/iCxieRg6r6qOpxKEGQxRDSm?=
 =?us-ascii?Q?KIGO1hnZmis5QYLCnxuNPeTE1VHQerco0xWAZO9lI7n0niX3Qeo5AXxkKSv4?=
 =?us-ascii?Q?vj3pq1vjmsrU5q7M4Gu1VCnoRxAPF5XoKRgowzXKmC51jImGqHBIW1a7u91V?=
 =?us-ascii?Q?sOB3BUrZU6vbgEidcXonfoBFd96wJkXA0zZnlL2F14GHZl47SWztzBc8+YT+?=
 =?us-ascii?Q?gph94jfYDkjTE02p8q6neiLtesTfTxdPYRGKcJNW6xIfj0xNVPvSRfqz5T7X?=
 =?us-ascii?Q?9LUjYTmjBMz7rHvhn220sXgc4fdHOXTILosh+s2bIdEes81DimWOeGny4ItB?=
 =?us-ascii?Q?/8NTW4M5kpn83OeXagrS0tjnM9IXwZSQpkFzTrryIuInl+9x6fQDfyUny8Tz?=
 =?us-ascii?Q?Yfg5NyKqUsNvK5h7jni1mlMRhu3q0eMLBuljEhhXp7aVVc0dd94hLtZfPjdM?=
 =?us-ascii?Q?uUClY26EDefVJghJttzcuQC1IDhRhQzoRCz+eQlcj1bFg9ri+ffLha5/oJP3?=
 =?us-ascii?Q?B0HgZ5gqjgcNKqQeuJStzkY9ErNt6LfRidhT5wJnoJb4eTxMVbglrqiA/pTn?=
 =?us-ascii?Q?EJegqdw5rLDaQiJ9l9wgb12imKFxBrrX3doexMh1F8dAFyFCJ1Ul5Q4wWe6u?=
 =?us-ascii?Q?9B5gWaafZsDB7dooupAQPyvJo96FSZsKgkWb6XwkrC/Wz6D0arvl1EBXd++v?=
 =?us-ascii?Q?Jmy8VRf3wtBDRmD9UBJiIz3XgyD96eDXOXEUR2MhgBdO5XQRk3nlgs2MB0Gn?=
 =?us-ascii?Q?lNGmo+ziPxf8YFUY+M6tNqMwwc6QK1MrTUq87a2ADjs86U9ZC5s8pIUB+Ql/?=
 =?us-ascii?Q?r82eThUgkphtpMKrtuhCkX2WamCB24K+QGH+q+OXwsqsQkoP1C2eisCJhv7b?=
 =?us-ascii?Q?88zQsWOeqWcUobHuKQuzelAgsqz1BpAAIyeqaIZYSAmdmx9Xb+LoYrdNCesK?=
 =?us-ascii?Q?RbdnO/lKr/O0Af1eu6HnYVTGN4FrbRDNUaQseuLi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494cbe58-5c97-459c-0057-08db8dd0527a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:03:28.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwKeIsWb6z5yEtVqJnhB8l1DBvv0BvEBHKLqpjwqk1oVgVhJZsP7PHiYJfZ+gxVCttseePbXqj4sFuKCkRgA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that dma_request_chan will return EPROBE_DEFER,
which means that dd->dev is not ready yet. In this case,
dev_err(dd->dev), there will be no output. This patch fixes the bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/crypto/omap-aes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 67a99c760bc4..de7f1eeb675a 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -236,14 +236,14 @@ static int omap_aes_dma_init(struct omap_aes_dev *dd)
 
 	dd->dma_lch_in = dma_request_chan(dd->dev, "rx");
 	if (IS_ERR(dd->dma_lch_in)) {
-		dev_err(dd->dev, "Unable to request in DMA channel\n");
-		return PTR_ERR(dd->dma_lch_in);
+		return dev_err_probe(dd->dev, PTR_ERR(dd->dma_lch_in),
+			Unable to request in DMA channel\n");
 	}
 
 	dd->dma_lch_out = dma_request_chan(dd->dev, "tx");
 	if (IS_ERR(dd->dma_lch_out)) {
-		dev_err(dd->dev, "Unable to request out DMA channel\n");
-		err = PTR_ERR(dd->dma_lch_out);
+		err = dev_err_probe(dd->dev, PTR_ERR(dd->dma_lch_out),
+			"Unable to request out DMA channel\n");
 		goto err_dma_out;
 	}
 
-- 
2.25.1

