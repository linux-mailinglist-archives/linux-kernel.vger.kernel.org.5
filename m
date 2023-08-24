Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E190D786B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbjHXJRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjHXJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:16:55 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64E10FA;
        Thu, 24 Aug 2023 02:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya5Wf/KtY2DmorBh8JiSvMnIgGl8hHocjhScuU7jMCoo6fLht44vLJzebSbGLlxqWskRtLMFTvwuh4mt9ZwSshHRNNrsuz1MSCuX4cwUHgNQ4RkLv5KEL2f0qm0PRkCwGFNt8lzSB7VXXyO4eqTKxdFvgiPPBga2MMnMXDjJCRXFeyUiCCmBAoG6jerit8ZGt2NGhGz6RvFvFG1wxp/76HuLJS2Eay/8F5eqqSb2WbTBHWpjk5r8uB+kTrAQLVhZpqDqij0T0FwZ457T7cGRgTpYEFiHXjcj1M6Ti7lq7bwY8RiygnvuWULpwvpY6mPmOR3G72U66iMedRtmqqxJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrBXvO1CeyVbXiCrvIumv5XwqqfCDIbbgamdkGLIRKo=;
 b=ZzcHM4CBpV+WbIWVhi3jVyMC2p6KBFDkCzqQ4nyUe6h+vS3s5Zbssiu7ZIEIEdp7t0e8i62BAgW0Peyz2bdXIavZAb0REIt6H8FzB7UdCM+VRnr4gsXDMPXleMuPiPqrGCFXwBRg9tcr98rbgn4uTfKLUhn0buu1a9SgDjZZYylHgRlnu4s+lkr16VvcByEL3QQx6BV+7iElfj1TvPykY5VA1pvQu8Hj7fFY9h3SeXD6eXqB9MqcPGrXcQdXiJubBCFj0wmxdGACd3a792+fEKDUKiZjtZYflihcyvXKQfcQ9cSU2Q/H3VZinEW8JVwQEqMjjLcJCdzwjbioWvoEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrBXvO1CeyVbXiCrvIumv5XwqqfCDIbbgamdkGLIRKo=;
 b=bIF4q1TMNet57yEZAzJKg3VEZXwnn73lMPtXurXvTXaRVgdMHCp9tFYSoiYf3byaiiEbN907DqWhOlDHcxgetLgVwhY5F5dW3RCi+7Zshjms45hEMUp8woR1eZyDviiHTLCcXGUNPWPqpl0QYQahgb3tiBiKUwmDdHDUE7fVdpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8260.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:16:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 24 Aug 2023
 09:16:50 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v2 2/5] net: macsec: introduce mdo_insert_tx_tag
Date:   Thu, 24 Aug 2023 12:16:12 +0300
Message-Id: <20230824091615.191379-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::33) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bead965-79a7-4f0f-7f91-08dba482d982
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTn4vp6NRibPdwhaV2H4yO6h9nGFklcyt5tQ9PVR9OszIkXs9hX+cNRrtndhn+q9VQbWvxf1k7SNjnyEqkqmOrQG/QqwSu5CaierH47Ck5nfRBv+emuc8bzAv9mEtrpLgjMPDF0I1s/5ipFPFDSJvk6Wap+gjaPKc3A9dsnT7UF50+7L8Ah2Dr+FvgQmCqMInXkj9X7aZzGqj7Jitr4UHnJ6jVxBqIIU+xgXJCPvCQD9Z+Ai+q9X51PgN3ZYWLHiGKZX/Ec6xIflTwHw58LenY8gj56xGdeCOX0/N/iUWxzyVDg1KQgTxsnYCfaYcxfnAbe2B/VQwpLUjTlhPU9whftYluKoOlIY6PlyL2hV70oPj3vs286FE7LFFBQTWlzg4HcUAajRm9tnS5W7Fn1HEGsle0tjdYCWhhTYSHxmBbgWfRKtCBFMw9wNJ3oMj61igfwFfEZY4d9fF8ahJErlQ/5kaSPgWLZsyv5GLIfelcwfhBMfaKApNci8TtlknGxQReZaPN0MVaE1CAeeiXaB7/Zppw073vgGI2e+hS3cXT6Nds6GSsNefyDiBV8U9PT2wOnsy/vBAW/+7RCNf/5C/aaRy/D7pdl/6PClvYhw5jOc6cpvDql977DnwjlVT5sRuUXX4pbKlqHTbngsjOtNoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(66556008)(66946007)(66476007)(316002)(478600001)(26005)(38350700002)(6666004)(921005)(38100700002)(41300700001)(52116002)(86362001)(6512007)(6486002)(2906002)(6506007)(4326008)(8676002)(8936002)(66899024)(1076003)(2616005)(5660300002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6eOyO6xhwi7eG1mjw+Hhg81X7Mw5isJyJY2OwRBJOxvmtfqBIza7dCuFvW2M?=
 =?us-ascii?Q?rEyrjjCl0GYly/ovb5vOV4L5dUeJGi3a799T0FVCCjJKAwiN0W1cxFCnkpeZ?=
 =?us-ascii?Q?anB6j8DVJ9LcsqvlrP95IaUIH578UOd4IRijsGmMcwf5bbKY2hK0naxxo2MF?=
 =?us-ascii?Q?4QSY+pwmihXHeeV2UxDczAhgkq793SbTka2wt7SeTFEmqmbndCky6hs06u0N?=
 =?us-ascii?Q?u8xtaY/rvH8MKyAiFyvW9f/veBoxBW/mE0DFN+hgACWgigkXpQxDevnpNAEt?=
 =?us-ascii?Q?Jh/g9iVBhhwbZBK4cF9NaexzabO2siC+V36UguN5n95TMXCPtePLSZzy7T2Q?=
 =?us-ascii?Q?JiNHe43Ly/ambdBDiP40RXqlFyOB/010FEbcsaW7I7IPivNf6shhbaPCekVx?=
 =?us-ascii?Q?YSQdDsFw2UYF7iMBrBVutja+3dL+y+k0gYZXsX8l0AsJ6driqdtMbGSM/tO8?=
 =?us-ascii?Q?pQ6NeTOwpuCNuRrM4ve/JVsPTZXc1eZtADp1C8m97uPLJ3y59fFoIZn/IgFq?=
 =?us-ascii?Q?2a2F/P9aGK85p2HcI7S652haoMJXw7vmzjRFiYMDoo7g7AgWZjDiEdp4ZMRy?=
 =?us-ascii?Q?1bxYDw5EQJVHHhaNu2eCbF+m5UcESCHhPqNDRwDWT8Y7fHLd+sUyeoYbgp0W?=
 =?us-ascii?Q?z3JToJ+NaaPmTkpjca6xatMz20ib6xXIbSV4eznnLmk2RbH0LlqldRkOG9p6?=
 =?us-ascii?Q?mE46qP1BOWljXJGvOU5RXC0e6y8Kmt3a0d4CXeLqidgMYc+2pt+skybigTWZ?=
 =?us-ascii?Q?16HoIRKoHZBtaVYOMos5ZgjZg3RwgYdkwjF9IHNlEqrFb7ehOGR3bWJuBcy5?=
 =?us-ascii?Q?9bXNSk7Deka0cV0v5Oa5FUFpuf1Pgc/dmDFmeR0tgiJdWj7V2hxcjiCSB2qU?=
 =?us-ascii?Q?didCWRq/YfeN2H/BaovqSMx1v86lNIJKVPtknLrLhX4gtaZm3gvg87kgSorQ?=
 =?us-ascii?Q?pT9cGrrtikrIKhtWFbTIlZQp1/z1V/urd2AIxWHT6sO0eZYg7f3P+STRN7ml?=
 =?us-ascii?Q?qzGXKlcFM5bvQG+OU9UHRO0FLB0UkrnGN/vZmoLE3ou2cif/+Bp5TzYWzL/H?=
 =?us-ascii?Q?sf82Yk1/L5a1QYsUtZvI7706hZYiJj9usgWW2o/74nuqNI6n6/NCLk3KKFgq?=
 =?us-ascii?Q?TP1HFS1g9kqu0gLgi+IUJnpRalcwVs+yQrLlMSt2sqIE+VM0AfNU1rJXerW7?=
 =?us-ascii?Q?n5f6U1a1v347w2rwdrLi95OMCimxebjiHuiJ2/C5r2YPb6/12JTx+BTs73Xv?=
 =?us-ascii?Q?/FrViiMgEfK/+yoQlmZ9Sgv5FWw2oh8UHNCb1lt4Fu6P8Y/i2hPB6l7X++w8?=
 =?us-ascii?Q?ltahBnNZX6B/+pL2qSvZgYj9BKh+cI0VdGnD7QkiM8IfaFKDovbC62VAZ2Ch?=
 =?us-ascii?Q?DzO/c+nhhStfB13dM7brGoRIsix6HjF9SzjYONVOMH/tFDlnEpUeRRQET5vo?=
 =?us-ascii?Q?LkTBy92fQ2fwNtdkGAh/19XEri67c/29+NWOWFO3UoBkI7ObvuqmOOgdzd6E?=
 =?us-ascii?Q?1ENMMwZo88bcuBbZ/3HEVHklbCCqfb5E1QspQtrg8rxFzV1GKAdM1ptmrK3P?=
 =?us-ascii?Q?D5z8UStG4nx3CRnKXZQlzCJ9FpTvZV3c/QRshNE7yFkojX5HqKlzLxrTWGGq?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bead965-79a7-4f0f-7f91-08dba482d982
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 09:16:50.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH8OTLaqMHer7juAN3X+0BdYQBwrgSGba6bWizr6aW3RlG9yNzwMBSYCf5PJxupTz4bPKZVJKK5uh6bGc1zWJzylCrDEeQpz71QZaX1de/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8260
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
the ethernet frame. This operation will increase the frame size with up
to 32 bytes. If the frames are sent at line rate, the PHY will not have
enough room to insert the SecTAG and the ICV.

Some PHYs use a hardware buffer to store a number of ethernet frames and,
if it fills up, a pause frame is sent to the MAC to control the flow.
This HW implementation does not need any modification in the stack.

Other PHYs might offer to use a specific ethertype with some padding
bytes present in the ethernet frame. This ethertype and its associated
bytes will be replaced by the SecTAG and ICV.

mdo_insert_tx_tag allows the PHY drivers to add any specific tag in the
skb.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/macsec.c | 96 +++++++++++++++++++++++++++++++++++++++++++-
 include/net/macsec.h | 10 +++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ae60817ec5c2..5541aaced61f 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -93,6 +93,7 @@ struct pcpu_secy_stats {
  * @secys: linked list of SecY's on the underlying device
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @offload: status of offloading on the MACsec device
+ * @insert_tx_tag: insert tx tag if true
  */
 struct macsec_dev {
 	struct macsec_secy secy;
@@ -102,6 +103,7 @@ struct macsec_dev {
 	struct list_head secys;
 	struct gro_cells gro_cells;
 	enum macsec_offload offload;
+	bool insert_tx_tag;
 };
 
 /**
@@ -2582,6 +2584,33 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
 	return false;
 }
 
+static bool macsec_can_insert_tx_tag(struct macsec_dev *macsec,
+				     const struct macsec_ops *ops)
+{
+	return macsec->offload == MACSEC_OFFLOAD_PHY &&
+		ops->mdo_insert_tx_tag;
+}
+
+static void macsec_adjust_room(struct net_device *dev,
+			       const struct macsec_ops *ops)
+{
+	struct macsec_dev *macsec = macsec = macsec_priv(dev);
+
+	if (macsec_is_offloaded(macsec)) {
+		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
+		dev->needed_headroom += ops->needed_headroom;
+		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
+		dev->needed_tailroom += ops->needed_tailroom;
+
+		return;
+	}
+
+	dev->needed_headroom -= ops->needed_headroom;
+	dev->needed_headroom += MACSEC_NEEDED_HEADROOM;
+	dev->needed_tailroom -= ops->needed_tailroom;
+	dev->needed_tailroom += MACSEC_NEEDED_TAILROOM;
+}
+
 static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
 {
 	enum macsec_offload prev_offload;
@@ -2619,9 +2648,15 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
 					    : macsec_offload(ops->mdo_add_secy, &ctx);
-	if (ret)
+	if (ret) {
 		macsec->offload = prev_offload;
+		goto out;
+	}
+
+	macsec_adjust_room(dev, ops);
+	macsec->insert_tx_tag = macsec_can_insert_tx_tag(macsec, ops);
 
+out:
 	return ret;
 }
 
@@ -3378,6 +3413,55 @@ static struct genl_family macsec_fam __ro_after_init = {
 	.resv_start_op	= MACSEC_CMD_UPD_OFFLOAD + 1,
 };
 
+static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
+				     struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	const struct macsec_ops *ops;
+	struct phy_device *phydev;
+	struct macsec_context ctx;
+	int err;
+
+	if (!macsec->insert_tx_tag)
+		return skb;
+
+	ops = macsec_get_ops(macsec, &ctx);
+	phydev = macsec->real_dev->phydev;
+
+	if (unlikely(skb_headroom(skb) < ops->needed_headroom ||
+		     skb_tailroom(skb) < ops->needed_tailroom)) {
+		struct sk_buff *nskb = skb_copy_expand(skb,
+						       ops->needed_headroom,
+						       ops->needed_tailroom,
+						       GFP_ATOMIC);
+		if (likely(nskb)) {
+			consume_skb(skb);
+			skb = nskb;
+		} else {
+			err = -ENOMEM;
+			goto cleanup;
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	err = ops->mdo_insert_tx_tag(phydev, skb);
+	if (unlikely(err))
+		goto cleanup;
+
+	if (unlikely(skb->len - ETH_HLEN > macsec_priv(dev)->real_dev->mtu)) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	return skb;
+cleanup:
+	kfree_skb(skb);
+	return ERR_PTR(err);
+}
+
 static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
@@ -3392,6 +3476,13 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 		skb_dst_drop(skb);
 		dst_hold(&md_dst->dst);
 		skb_dst_set(skb, &md_dst->dst);
+
+		skb = insert_tx_tag(skb, dev);
+		if (IS_ERR(skb)) {
+			DEV_STATS_INC(dev, tx_dropped);
+			return NETDEV_TX_OK;
+		}
+
 		skb->dev = macsec->real_dev;
 		return dev_queue_xmit(skb);
 	}
@@ -4125,6 +4216,9 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
 				goto del_dev;
+
+			macsec_adjust_room(dev, ops);
+			macsec->insert_tx_tag = macsec_can_insert_tx_tag(macsec, ops);
 		}
 	}
 
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 76f024727bb4..9577921897f9 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -312,6 +312,11 @@ struct macsec_context {
  * @mdo_get_tx_sa_stats: called when TX SA stats are read
  * @mdo_get_rx_sc_stats: called when RX SC stats are read
  * @mdo_get_rx_sa_stats: called when RX SA stats are read
+ * @mdo_insert_tx_tag: called to insert the TX offload tag
+ * @needed_headroom: number of bytes reserved at the beginning of the sk_buff
+ *	for the TX Tag
+ * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
+ *	TX Tag
  */
 struct macsec_ops {
 	/* Device wide */
@@ -338,6 +343,11 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	/* Offload tag */
+	int (*mdo_insert_tx_tag)(struct phy_device *phydev,
+				 struct sk_buff *skb);
+	unsigned int needed_headroom;
+	unsigned int needed_tailroom;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.34.1

