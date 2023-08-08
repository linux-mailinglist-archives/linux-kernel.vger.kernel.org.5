Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6421B773C84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjHHQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHHQF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:05:56 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A16EBA;
        Tue,  8 Aug 2023 08:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIXViJCxQCgigSoL1muRELRXnjCh4I6GTVQkgu3MovIpkqsnz02/r6D26K2I+Sq0zajEw3/HEL6X6L7o2afEUXmJ/OBQ2Vf2T9g9jsjSIXLe0+Cj0bPea6lGG2I6fJJpy1pfbNvgtH35xYs6qU5vEKIz5Bkm02Ru4eVWPW8tuxng4BBHxQqmzOBPf6YpRAPoCrc8v4yxZU+ZhPJh/ys5T74DTV9YtnrAVWOp9OEG15Z4SFcfN1t3IptFAlPGw8LFjFwMoKLWejyV9IvslzE1Ga8GEHMWiAF7VpFiuHi1NoNfD0zMcHnWLdfZFp1YoRuFHBldTQU4oIyhOx2qBC7I/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPEDWiHu9fH89Rs2xhF+r4W7ZJCqZzBWOeNAe1hhsyc=;
 b=WYRlBg0JzD52Zxe6PuRMZygqxldxIvY6aN1gUtjfPwnQ4L0ERug/KsOx0BlbmQj0pCAjFByM3CzJVXX7jUD/cbiPhZ+4bT9gFc4Xs+FSzD94TuSnSB9lwMJm3Lavle1a5hC6ctVrpGJODXUP3H0TNNtGRBlqy9NFvcGXPvZF0dVTH1JqPUF22ZAYbleM9YDVxtkU6tr8LDQcDPXUG5Ji4UGFVXMZzlphwOQThhMUJ1yLLUwMzWhnk/2qh4oL89cYfaC5D+mSHgF6aGY04Eo+MvcWr/9WvVN26s3IWiSRVeAdknDZHqgGDIwa6J52hj5qzBeP+Gsv1XPDjIAaaK9qnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPEDWiHu9fH89Rs2xhF+r4W7ZJCqZzBWOeNAe1hhsyc=;
 b=iIDdfE8EdDAHtLqt/zbnsoJuKwcJ1jqI6olqc7NQiSuaAZJ00efB6+RaLxINp9Ufh2FS3OCmWjgXkhX/1pflT6H/gLPTJY+FG4VU+U+5CiYOpUdX7+3DYblFCPOKLp1vBF8fJsFrt7NBFAPmYBpPzjrrOOXxUHiOfuma3+URfYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:55:46 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:55:46 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] crypto: caam - increase the domain of write memory barrier to full system
Date:   Tue,  8 Aug 2023 12:55:26 +0200
Message-Id: <20230808105527.1707039-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
References: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:208:122::41) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: bd421307-2c54-404a-dcb1-08db97fe04d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6P/YwkLADMgbFrDZHW01ZAhDQFefK6qv/7HK7bS0F8+5Hm4TsZNPFAgm+iXb7DXW7e6y2boIDEY/CTV7FpVxaSBnJZE6fA5bDlMJQvHgkfASgMIIrPJHaadbP1PJw+x6/AtFPAq6q7AF6wz4yXsD1SZ8Pg4GkyqPGYPOshaUx+gAw/VOMHn4fFZwWRz8RqCmJunOfnTNfcWQFrEceb5RhDDA3g6xap+FLGo5o6mHCQpgBkQnPu48oItZaGP9IXkXR5m69CGdl3wpOmYfoiBZfQQ+gQAFusgyBnKExd0swU5pX5v7S3QclDfTST+asvwyvI0T1iAOPM0qiAaIHOU8wpNbxV0i05lW5EzeSwt/PgOopjcm6umq61IQ2T5EvvE8c8jQqoeQYxaDOnCOXWkscmmCrrY5+RXHz4FKf1vONiMIdUnvgllMnCJDhXtBJhipnmSSt2W40R1aNY2ipiBBuGVCejIc4lrPO/Dhxwcax1pXbPDjOYIvA7Ox28+sCDqVKHPiXfycEUeJrOjD7tH/0RqJKeRFTsJdcrQ0h6KIItJilr/A5eH0dXe3RlV2ImoRgZWmXtZopi34jyt+LQPeolFJY9xPvxJYpSRnUJCzFZK2zsJLiVKT5fGSD9hptJ+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799003)(186006)(451199021)(2616005)(6486002)(478600001)(83380400001)(66556008)(9686003)(6512007)(26005)(6506007)(1076003)(66476007)(41300700001)(8676002)(316002)(52116002)(8936002)(66946007)(2906002)(4326008)(6666004)(54906003)(36756003)(38100700002)(38350700002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNgbRVAMey+0joEdtvaERxtY72ZanYIVlO1fuvDzarZl/CaoZ7m3crVVUXdL?=
 =?us-ascii?Q?T9/3qGemHuMrzfOVKr/PNJdgAh03jDqH6Xk7LIjwnDIA8H1fZDElWaPezmtU?=
 =?us-ascii?Q?CMWY53u8CFqLfHstRXaDWcAJyDqdTy3KohiS/fU+BW0Olf+0I2osphFZ6DKW?=
 =?us-ascii?Q?4m1o8A8sUqTvBacwqt0lAzXQl5RZ2cL0GCC2gli9rIdV9wGlFIytZwwLXoGr?=
 =?us-ascii?Q?GB8Gpt/GfoLqBXEr7Lepm8VEsTw7gcZdGEk+73KrzlZXD32uTR7VyOtyyYeA?=
 =?us-ascii?Q?kOTpM58yPFikm+xViRR/nfXQ0TiPfhSRPP3YVJaPmgzlLQOEUDIcz0YHmloW?=
 =?us-ascii?Q?3mStY2TUZH8U0+tCak80pkiRk83IJ2qKN9Pw8pnRnsHsctD5GShHwFWHuzAm?=
 =?us-ascii?Q?DJ1m9Y25XHDW6ctbN8iE1mxZLylsiT60fgVMIOx/J9E7nFPUjxCB6g1m3rgS?=
 =?us-ascii?Q?r5CMYHGgBTVdk4iaZJiA8sLUNYU8IGyjCGBv6J3NkK0ZuCgpWvC0GTe/uOr+?=
 =?us-ascii?Q?RyTw+oRWqyx1DMrgyCPya1QBH0rPBPoyr5Ro7hvlHYxt0kyr1tQZhNKQ0L7E?=
 =?us-ascii?Q?DBD15/s8HOsVpFBNOYWv4G+q5DDe054LeEHiSKHHsey88+N7WGwvJTAzHiqq?=
 =?us-ascii?Q?1RHefWeT8iu6U6BrlGf/+7IgGykzm+1bjIbG3mvSKh4lAAvyJoRkJfgsLed2?=
 =?us-ascii?Q?PLQSnEEMqyE7ZIAAwnFUV6lPCBrctUdBAmL0vjzFXFutoNHhGdHGrGmYcb4k?=
 =?us-ascii?Q?CVcdngHOUSpm+a158bBFmN4I9scwYqY4ybvZhK0PQepgM1PLQUNjjCwF/P7x?=
 =?us-ascii?Q?fPu20akcyHnv0WENFhe74cAp8ggpSqn8y+C70brzY5IaDBNdVzlSuGVUgRLF?=
 =?us-ascii?Q?Ps0Kbxd3Ws2SXSf44kmqHGYkLf1uGFqJ2AcZLPaUJ4KXc7Zh10RJrlZ3TsL5?=
 =?us-ascii?Q?3u9j1v1Tv1VCigITRDdt0yXmF2lEWya4HyhJFR80Gq1iSF6fxd85vnUPTWC2?=
 =?us-ascii?Q?IJbW6hfVO6puQ9Xt7bxxXF33KrvgEnJwNrE4iAWgiSS6WXv/m1NFd/L7I1y5?=
 =?us-ascii?Q?gh9f0lkAeaX8Ez8ZNzFPv6ebGEUwJemT+ZTKuoc/H7t+6m2g+T1Qwbs/lO42?=
 =?us-ascii?Q?hayjGe5UlZS1gB8wg0zViKYyYyxx/AIJsdiSNfwk3UJwQwPG33VxNag/XKx+?=
 =?us-ascii?Q?8+ZfG4NufQmLDPB0/oqkEJSef276IsA8tMQJGDJ9m39wqirYqg4yYxipeaKl?=
 =?us-ascii?Q?kJ5tSajUaFKPOAlnDmjh7ZqRXPr9C3+S5YLIYZWWCgFF5pXqqPjny3hjiD+E?=
 =?us-ascii?Q?5X7Vh9IsujywvPikK3ykkMt7hWt/UobHTrJZfAXCRHMKkkbltglNuF1cI9BV?=
 =?us-ascii?Q?QmF4RWMCh6Lo1GYMbNdWjc2sVkMfc0fB/fq0NiVS200oVr+ta9RtqDDtuDKi?=
 =?us-ascii?Q?IcVVvVtOoxuynGDEMZjCawVduSWghcEVDeYgyVdFgGT+rjruCUB5vMmc3Nkb?=
 =?us-ascii?Q?Jhmq0vtjXkV52FC8aHUCSchIhk/gzAVzWmETrEPkVqAGQGCvFq+83HBdya/e?=
 =?us-ascii?Q?P4qbj/jyp24pB6Y1NnkUi4EOelXFYRWs4c6pDCFMhHP7BaiH6SSbOrXV36Wg?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd421307-2c54-404a-dcb1-08db97fe04d7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:55:46.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXRQ7WTFOZ3U3QzdldYZ+NpZMfO/4oru/RuQvTPyoAiqhMMgMK3QFg5yaCHmyC3SW/LcD+zumkv8ESCdOykDvW2+cddp/TUQ2zyNA5n6dNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

In caam_jr_enqueue, under heavy DDR load, smp_wmb() or dma_wmb()
fail to make the input ring be updated before the CAAM starts
reading it. So, CAAM will process, again, an old descriptor address
and will put it in the output ring. This will make caam_jr_dequeue()
to fail, since this old descriptor is not in the software ring.
To fix this, use wmb() which works on the full system instead of
inner/outer shareable domains.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/jr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 767fbf052536..5507d5d34a4c 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -464,8 +464,16 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 	 * Guarantee that the descriptor's DMA address has been written to
 	 * the next slot in the ring before the write index is updated, since
 	 * other cores may update this index independently.
+	 *
+	 * Under heavy DDR load, smp_wmb() or dma_wmb() fail to make the input
+	 * ring be updated before the CAAM starts reading it. So, CAAM will
+	 * process, again, an old descriptor address and will put it in the
+	 * output ring. This will make caam_jr_dequeue() to fail, since this
+	 * old descriptor is not in the software ring.
+	 * To fix this, use wmb() which works on the full system instead of
+	 * inner/outer shareable domains.
 	 */
-	smp_wmb();
+	wmb();
 
 	jrp->head = (head + 1) & (JOBR_DEPTH - 1);
 
-- 
2.25.1

