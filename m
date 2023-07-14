Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CF75374A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjGNKAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjGNKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:00:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E11BD4;
        Fri, 14 Jul 2023 03:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evzVefcEGcTKxW53/Y7TF94+A2nqefYK8ntJs57eomLRprtcC4WDePlM+fIFo/a79LXvHHPVkrn/hJh1aj0c5YkNpAFtW8wfWWWTleaYy6Rmfyby56vjjSK0dEsfUtumCKhkrui3jqwerbX6YyjHC17LsZ8HU78P+EWWDPlTUqDMzAXHfHhFS7YPlHcbz3OjFsNlpFm4we/3SwqPIoH2epX6LziWnqukcTv5vHIQRlEt7J2QdlMQ+BQEdPsGWem6RHz7gtcHz7bWkNoEAlLfTJv21edl1lqYPzRsce4aL5LN+5EMGNul6JtR5ySMnaBh9apOiydkflRKqtEbTPvSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiGnj2H5bbP0nu7g61JOHJAwB2UNHOGqSbYg2mTmJcE=;
 b=FQvOApWE04houyWscVvJh7rRqOphUT7tLHcuqBklpneWD9q9i9o9+UGmqeDFW8XfqmCpCwhLaIHsyatMBHuMBmPGXNaZ+MM8sTZsCUdDlcrT7W23ytkHb42VskAIsNuclAXD0fRpQ3rzks3xbWH5Kwa9K6Jv7BPYfS40IQDUfT7XSg3utB+YodxGJy13keNrVXiY0zOp+TgXdJzffwBYLDiAeNT1+zPqtnWA7ECYyF6ab3QFh+JZ3wAw+o7RfIchdk8lRcakEieE4tMuDpl6279EVONfPzhAxs1qSSc3gzGLX9gzgPU8UGlY/JgLVZg7DnYAD0tT1SWTBABJdYUhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiGnj2H5bbP0nu7g61JOHJAwB2UNHOGqSbYg2mTmJcE=;
 b=NsEgwpcV3iCYICvXBc9Kjr+0MpUgnlySIgPzRQ7ByUJE6BNk+aA7bJzBTdjWcwrUANwUB/0EorGhj6lPlFJNffkQYl5QKdG61zxQE73xbyOZGIdGZloeofh4bukiAfnnL3DEI2q4V72+5x3GPhDwujtpuWzALIc/iK0ckaCDBJ1wqWRsyoEVX3XFlvtfZz5i8o8xaeFJixqR+CYaujF3TRggtZdQeJQs62qdLosRcmyem3vTHrnKJPwAUzjwwBrIVRHPVNDvi7j7W7cSSGYZ6JzfVu9HffECxvsx16lD1YtL335SYV50msg+jhOC8kEAGxP+5HhAQvcY+1iUB8sh5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6191.apcprd06.prod.outlook.com (2603:1096:400:33d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 10:00:36 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 10:00:36 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Daney <david.daney@cavium.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net v3] net: thunder: bgx: Fix resource leaks in device_for_each_child_node() loops
Date:   Fri, 14 Jul 2023 17:59:59 +0800
Message-Id: <20230714100010.12035-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b334ca-7031-4cbf-c6eb-08db84512b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECIMkW4F/0QrsLigAr3pCtnatIr64wbDzcOe+JA/R7Whrdm/ZO6p2EwHJ79ERS9Htu7YCSiF5AsjOEdA9GmY5bv/YOjUDpj0kuUZZApUt2S05jDaSKeCSM731yTr+hKAI1hvbvan/uWuKsSIdZJcaebIW6u/EBki0+5fpGIui9EUCxA3hfq0LZ3k/iTVdBEMv3HHvNZkQZEdPGgza9oxPTTBSD5/eS2VOvHE7mWMYdHUS87Zv8x9C1S6ALCRKnpit+J2k97XXSCEU0tV851fdAhygDrOSacyOos/zUMut0z5lGwH/wZpdpCdmJRC+7NuEhd1cXMkW6Ls3mMv84DcQmFapj0cC2svleEcFp1AkoQhCjDliIENywmsEfccRgjrtPk+qrNiWWPdDYH2X8JN+1cPeCgizov17MtsHt3NkNXOCZO+DPHI3B8/dZZ01gZ5F3fM+vg4qPM0fntoUtUPRhyGZUQeBgSw2zaxhf4FDy1HkHJljAKmH8FYGhTqFKD+bk9pNX1uvtrnGFHzoEr32OdASDUxKr5pBHC3LBTC6SA8P72U+2kXutoK2yfVCxkHtRbklChp7Y16iuDja2JFpb6i0MNVU6n+7HRbgJn1ISLlc6IrtVJ4VPLPnCpSqQDd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(38350700002)(38100700002)(86362001)(36756003)(6506007)(110136005)(6666004)(52116002)(6486002)(107886003)(26005)(478600001)(186003)(1076003)(2616005)(6512007)(2906002)(5660300002)(66476007)(66556008)(316002)(66946007)(8936002)(8676002)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+yGwucAGwWuCRuCTxbOpLiVWgQFTlAQaklkDifhpMPkwWoru+OA3DRsCrCgw?=
 =?us-ascii?Q?AIEmodNOdGmRyw6OostCEuQT9eI3AC3wi5XrUFk+OlqtP1HG/GChNL6FvbK5?=
 =?us-ascii?Q?HJNBzStWInys0YRpdpmx0O5sr4Ccuse1h1JqSLLPbBZ/hWVe2NvG+/x8gui1?=
 =?us-ascii?Q?bzYItZlMTGHhSEwRQRPdATLcgADNMhHx6XSbkcTJi3Dtvj5XZuMY1hpZ/mXF?=
 =?us-ascii?Q?3hBCO2d4kvh6W74w7R9ITU98aNwrxctAzfox5FelAp7Jt2yXEMvoSqkQGVY7?=
 =?us-ascii?Q?OM4vQRQsziFjrDw4pMY2Of0BKIZTXTSgeeeQrpWTgQwW126KrCU8HKHlS1US?=
 =?us-ascii?Q?Jjy8g9s9c3YTLTDPZXxMraMhVv7kks5WokCZjPc+5OHBvPd1N+FPEgvthsrb?=
 =?us-ascii?Q?aX8tQZZx+m4XZZvzxepOWEwl6y+34F65PaEqSpcUSWlf6S5ftBXHa4Z/aOIX?=
 =?us-ascii?Q?wOgQQgd7Z2Wnr1A9gqPdZcyY77ZZFCtsEZ89Bl+e4m0Zknd2dOi8N8rwZfEX?=
 =?us-ascii?Q?piN3QKYCe+qRDIN8s7gyRd6JE2xlJC8v4JJeS67BARctnzY3jSERiMc7IfEI?=
 =?us-ascii?Q?r2k47munHIzZa9QSeZB4VMV2lxiADTvMFN05OXdzfW8mcLn6HmWFVni+JHW1?=
 =?us-ascii?Q?7FWvFNj0sKDDkLiyvlfOZmvGVxbm7grlJS64QBtFPubIfzrsJACAewox2L8B?=
 =?us-ascii?Q?XJo15qlDVH7FDwY9U64AT69CWKi6dDlLREK0muJhSw7QX0L8l8dDlWPbzxkm?=
 =?us-ascii?Q?PgG6bBrmPrnSeLWw+amJMLLp/gCvopt2CSvaBDid/2V1HPMFCa/EyYANbM1D?=
 =?us-ascii?Q?VP3l1bLJKitm0jRifmbSwUmobPeAKZi0iFYvF+kseC0sAxMSY8/01eiqCZEx?=
 =?us-ascii?Q?WVwGXTX64BV2sFQWAXZ8l47erVxqoNRIMMfP0825xQJIUfmGaNeeyZx7ZmfI?=
 =?us-ascii?Q?3FjBQ1n4DDzZ/HXNCQvWFFQU+Qo8wnltK/tAGNaiLCcdYfJMtLMgVhqdz7pr?=
 =?us-ascii?Q?s1rfjjklO5dTd5wVlnQp00j4HIZ9jpHdj/jh5qcIcSz8iwYhLQ6c1HqJlmtg?=
 =?us-ascii?Q?5mBATcCURsVhtRLta0DoDO0J3vXgEjKTKvQjQlNsS2dQ8R74R5wnjcK9oh7i?=
 =?us-ascii?Q?oj8KFmiTImiwTQ61bRgrtytztIjw7HXhZniGJyylVJMPzv49qsnwBeRyRUYs?=
 =?us-ascii?Q?APjwoC89ZOgnSb1FqDVG9nkpoehiN2NnW5BWoOoNnXI57tc3gXW58THMb4/l?=
 =?us-ascii?Q?AwwSIjarInOwsrDt91/Ec9puEEANnNz+DI9pV0EtiDpwyCyn4dhBagf0j2r3?=
 =?us-ascii?Q?14ZCU6dzktyhGU+Bax5TbQETsLuPxzdtxLEaURQjCEyWVLSwqBNW4ZlIUy2B?=
 =?us-ascii?Q?L6WQC0k/n3KRJ1dA95VK0pLR6dA35m4WLug7Si77x1LXkg4RICixMFtYQdR9?=
 =?us-ascii?Q?9b1D0gk21rxpLwWHhz3cb8E9hEOsdzuAfN1y5spbDRt33zXqRoD0vqcEkvsb?=
 =?us-ascii?Q?FUg1MY7BTCRQd0tVcOfbm9P80Tdcm867SEoofMCo+8l5ZyX9d25ToM5Jnu+W?=
 =?us-ascii?Q?F3yG9HUf2opbxqIwEWgMm+YGbwkOPpHwoC1r2uv1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b334ca-7031-4cbf-c6eb-08db84512b1f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 10:00:35.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6MOL74hNXmDzGGpuQIblN2rV13bXMQ7VstucOMEdqpoS3mQp8746x3wZ73P4pEye4tgh/zr3STN7O+NQ/qmFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node() loop in bgx_init_of_phy()
function should have fwnode_handle_put() before break which could
avoid resource leaks. This patch could fix this bug.

Fixes: eee326fd8334 ("net: thunderx: bgx: Use standard firmware node infrastructure.")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8decb..f8a8b2ab72aa 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1469,6 +1469,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	struct fwnode_handle *fwn;
 	struct device_node *node = NULL;
 	u8 lmac = 0;
+	int err = 0;
 
 	device_for_each_child_node(&bgx->pdev->dev, fwn) {
 		struct phy_device *pd;
@@ -1479,7 +1480,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 */
 		node = to_of_node(fwn);
 		if (!node)
-			break;
+			goto out_handle_put;
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
@@ -1501,10 +1502,8 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		}
 
 		lmac++;
-		if (lmac == bgx->max_lmac) {
-			of_node_put(node);
-			break;
-		}
+		if (lmac == bgx->max_lmac)
+			goto out_node_put;
 	}
 	return 0;
 
@@ -1519,8 +1518,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		}
 		lmac--;
 	}
+	err = -EPROBE_DEFER;
+out_node_put:
 	of_node_put(node);
-	return -EPROBE_DEFER;
+out_handle_put:
+	fwnode_handle_put(fwn);
+	return err;
 }
 
 #else
-- 
2.25.1

