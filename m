Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327617A7735
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjITJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjITJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5239F93;
        Wed, 20 Sep 2023 02:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpZgKJ54pcpjSK+d5egqu5g+Flq0g6z80T+pAiZSIteB9f37PUdk3V49qwtiCd++z/1vrcU94AXPysHXyfbVtMFt6av+fVamctw+lJiNlfNoOI2C39Iia+fmu6rWOyEvxdTD9GPMwmGSykFZ+r76Qk1lv1QhG4C64LWpzi2lhBKTD9RtXJX+EfYOWKVi0xmEkgC0rEBq2cxhoykJXa8sSUpI9Zgs/kpBfIm/sCBDQ84hLngh9vBAQ2T/wbhyhLArQd+mad94OgRaAtuCytkMUCES5Bvl07dbNhnmO6C6H6mVsreJiCOww6RBaKvZRIaw7oMyuaPf4aZrRX5ZT/qWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g6UjChqOrGqzIAclkdP+Q/FB1x2GwnWSWHlS/qLmTE=;
 b=iIy+YBYrDYZLrLOamaoKDcmKqJHor5bGJIR3kNZfJgFZwFMlra+33slLnan4oaYhOak95Ito4cvee3tJzZR6gMwD/ybIZ5K+pCDRRanzJ0p9g3zBnLD2nlTTNyM/QHKir6MjYV3fqWwrVgLZsYZx2JrdB36Nb4Pt6v7baC+gDHXEQ2MNQqaY+GtvpClmotWvV77K0J+X9Oi3Wfv1jUWQFeJmAFYbD5SJ77OvcyaCk/1/5NwqsvB5V21zzr/xAsCeMskmIsrAwRRcehjGTX9y6c/zCuOrRnZxa6uLyMkKKrCi7jJ8lxlJiQ3bDm9qguK8cVoVoHXnR2D8qTPm2L/ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g6UjChqOrGqzIAclkdP+Q/FB1x2GwnWSWHlS/qLmTE=;
 b=e2mG4n7A1/icm71071kl2/2I2o7xauVg5Zu4JbBsOXP4EKD1QbD1atxNiLhdtz37AUueYUzvnzf0LAIc5OY2036Xr1ZMNtQw5zqe7q8zS8E26vIqKnPASznBNuuYUr+bucwB/tyDruxooBxpxNTCPvMhrerlHVRTNJFRkY5NOl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6933.eurprd04.prod.outlook.com (2603:10a6:20b:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 09:23:01 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:23:01 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@oss.nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 4/7] net: macsec: introduce mdo_insert_tx_tag
Date:   Wed, 20 Sep 2023 12:22:34 +0300
Message-Id: <20230920092237.121033-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: ed91dccf-7b74-4fa6-8121-08dbb9bb2f8c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBhNacrx+dvvKABtpRPsYbOi4AahpcKdaHlCoarza3iMsR88eEWflwFQ4ahT085Po3R0oeVA1UIC/IzutahV9aR0QQjjd4sctmq9hgg6Qxa8Kw8UtR1pflzigsv1kBLb2vBH7/rpWiRWIW/iGlbvmzlyqEL4v4c6FM9u3NfLK5bWlAhdnft8ylVBlxV7peu3faGRM7JnNCKcLCJDzoAf607aOXomlHdRMKvCz/EDCUDj5q5UIptPQHrApOOXUcfA2Vxi8KpduGq1QYh6tmNeQXkf1Dwv5f6Qh3EHhgp1vIcPWDFyTWmJUeMMTyI+LyojFbA1X+onvBU8aQOjyObQCqWjGbxJkHVVX3GWoJou5PmSgzKilFSyqB4l6Ett/F+bl8u97eouKksEbJjav4TIvi1T/PXGxf7y1nQg+66elggnFDTaq5Mjombcvob2qrLAS1Wv+1ETlLQPBLoroTvic32hNbGS/qdoKGlPagVNkE87tSpxykHqVkZ/Grkn/ksExwnwRyZzvKalqCgP+kVNY1ql0XTn8xUXlGf0xXA14kGN/QlgH7n10es6bkj5ueuRpeXEFujn1VGLseq2s3lPPn42IjOoQ/s14dq3rpKbIl1XWX2YkAL5XJRrxp7yiybkQuchvG6ou9rNDUZDOwwdPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(316002)(66899024)(41300700001)(8676002)(4326008)(66476007)(8936002)(1076003)(6512007)(83380400001)(38350700002)(6486002)(6506007)(26005)(52116002)(2616005)(6666004)(86362001)(38100700002)(478600001)(921005)(66556008)(66946007)(6636002)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAHUR6VM7rZIGJUvIUMdQIEJT6YfDzI4K9rlAwosgQsfMM7Dh4AU423fhj8L?=
 =?us-ascii?Q?JTbKWPboFA4XoqAJu9g6vpI00xoGjFaHBkEgDsKrcqjF2AZMWWEF213iCVLk?=
 =?us-ascii?Q?q2EGK66C9blqBKG85EqVedoNwcf9L92CW9Z9ENXlF7C0b/puyvUXwEpb1odq?=
 =?us-ascii?Q?3zNj+Ar2ZEKcbd7QTZX8GXT7ifFZXFqfgVRi/DR95YRDloElV2carR5Uz26u?=
 =?us-ascii?Q?HZZuQQc/N4F90zrgFbZslvJbGEQy9YPqDBlr0nlP8pr3JhuVWwwunWRFecAO?=
 =?us-ascii?Q?M5iKTmTJuxbmOvtdKtYqQR5M7lffVjrcORaezrYSjo/2UmWvRt9P3RjGp5Nv?=
 =?us-ascii?Q?pk6fntFXlSZvWrmq7DvB9E4exuOTcyeAHc9vzxwIen/OEoOQhXZ4hnRisNa9?=
 =?us-ascii?Q?B5WM3TTwqfTa7Z2Ho+hrGPpPxb3qjs8NKm2PhlxwKdovzSPu8rbCvorAOUh3?=
 =?us-ascii?Q?dIhuorYsSatR7wnTGZRT9hTGguD3AVTWuwdiLDVxYMvIFYV00c9kqSdW6HU9?=
 =?us-ascii?Q?BsAk8aVH+vWmkE/pq6h0Neu9NgpFbfQvpfI2TEAluXYm62dbP7lx5Fh7m88s?=
 =?us-ascii?Q?rSBYeBQX3TcLngHlyOx5sxBExP9CSIMixGUiaoJMmnu+15KzQTmKYC3CdFm0?=
 =?us-ascii?Q?iLI7LnJQwB/ozD0lfleMdbVtQvAoVVQZZkh+GEKrwixxyKFb2YeZ6xBFrlNv?=
 =?us-ascii?Q?RE0gB3Io6c9eCZ1c/kgszWzD2q/7olBGkIc33hYQ2plzAn5baQbRn6H/B3hh?=
 =?us-ascii?Q?dZwPRUAO89yB+vjDCdD8vZwNuXIM12tIo6nunaGzOCwR9gpCpmqV9zooXUcM?=
 =?us-ascii?Q?o8ayqIi0RkIynJhRp54rAaMGnTOm0CIgQ3t/n3hD+nYdfeJeFpHBOWf62y/s?=
 =?us-ascii?Q?80mdba5gw0C1wSDoRAyhY84X9mMw1k1+zxPfVt/nKdY0UbjRr220SeZi1fyp?=
 =?us-ascii?Q?DlvWI99oA1LzZnQ+pcB9SVAdjERpdwo5T3m1Q3xdN5OSTjVJe7g5O06WPy/2?=
 =?us-ascii?Q?acnVZJBIyqlPwsuVy8q4TowAM8Y40tu6Ji3/r/WKS3g63ma78ntwuMsKEpJ5?=
 =?us-ascii?Q?banMtSZGttH4LsheeBZiRU1/LR3xd/eMwc5Zhs/e16hG4WwWW2SBsGMCm9Gz?=
 =?us-ascii?Q?cnwUEqSZmTJYOJxBzcncp7GsGr985/mmupcq8kcCnzbdt/dnJ0WdNbe/qf6L?=
 =?us-ascii?Q?TInm90inHntZHjEfwvhb/4j7k55uIhEUL+oVw3C+T4ZV97k+p1NLLyJiZibu?=
 =?us-ascii?Q?bnzHRKxz/4c0W7t1d/+PFpPGVRXDcwhOW5Ik3s7i2CCVEGKwR5lOqU+MR3vJ?=
 =?us-ascii?Q?KjIO1R7i1JHqEYj3a/+7sMCcMtamf/kMN5kmCm0ZrOzNJf215sZAY1yk4rGB?=
 =?us-ascii?Q?cjmr+kM+FHIP2pD7izPCBS7TXxMsp0ZPPOxMRn5L1MP2KJBSuEEYY5NkrRcw?=
 =?us-ascii?Q?Z1hvKbi59IIYZ9D8Y8M+OlPQ61HgIKVrjL3p/uXtu0jtdXAxbSQAYYAy/LM7?=
 =?us-ascii?Q?5mS6z+id+OCDdxciaqha6lmEWL71pEppGwYGfeEWYuC9R8GcEiKJUUD9mvCb?=
 =?us-ascii?Q?fHqJGsmMqQ0rQFMRNX3AAw4KPKTJqHTkV/lAx7StxIcnqW8sxcOdSA9sH2wU?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed91dccf-7b74-4fa6-8121-08dbb9bb2f8c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:23:01.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0uaJ8wfT+A3MCvSfTr7RskcMTug1DAMKyDd0LnLGuyqAmQVBvnY9JJxRGrCyKDiPZ9wshDITwJTN7BcP3OX5k/I1bS30h/O2l7QTa0XdhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6933
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- improved insert_tx_tag flag description
- macsec_adjust_room uses the difference between MACsec room and 
device room to adjust the macsec netdev room.
- macsec_update_offload return error instead of goto
- macsec_can_insert_tx_tag renamed to macsec_needs_tx_tag
- insert_tx_tag flag is checked in macsec_start_xmit
- "TX offload tag" replaced with "TX tag"

Changes in v2:
- added new fields documentation
- removed unnecesary checks in insert_tx_tag
- adjusted mdo_insert_tx_tag parameters. macsec_context replaced with 
phy_device and sk_buff
- statistiscs incremented with DEV_STATS_INC
- improved patch description

 drivers/net/macsec.c | 92 +++++++++++++++++++++++++++++++++++++++++++-
 include/net/macsec.h | 10 +++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c5cd4551c67c..f0ff33025500 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -93,6 +93,8 @@ struct pcpu_secy_stats {
  * @secys: linked list of SecY's on the underlying device
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @offload: status of offloading on the MACsec device
+ * @insert_tx_tag: when offloading, device requires to insert an
+ *	additional tag
  */
 struct macsec_dev {
 	struct macsec_secy secy;
@@ -102,6 +104,7 @@ struct macsec_dev {
 	struct list_head secys;
 	struct gro_cells gro_cells;
 	enum macsec_offload offload;
+	bool insert_tx_tag;
 };
 
 /**
@@ -2583,6 +2586,29 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
 	return false;
 }
 
+static bool macsec_needs_tx_tag(struct macsec_dev *macsec,
+				const struct macsec_ops *ops)
+{
+	return macsec->offload == MACSEC_OFFLOAD_PHY &&
+		ops->mdo_insert_tx_tag;
+}
+
+static void macsec_adjust_room(struct net_device *dev,
+			       const struct macsec_ops *ops)
+{
+	int diff_headroom = MACSEC_NEEDED_HEADROOM - ops->needed_headroom;
+	int diff_tailroom = MACSEC_NEEDED_TAILROOM - ops->needed_tailroom;
+	struct macsec_dev *macsec = macsec_priv(dev);
+
+	if (macsec_is_offloaded(macsec)) {
+		dev->needed_headroom -= diff_headroom;
+		dev->needed_tailroom -= diff_tailroom;
+	} else {
+		dev->needed_headroom += diff_headroom;
+		dev->needed_tailroom += diff_tailroom;
+	}
+}
+
 static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
 {
 	enum macsec_offload prev_offload;
@@ -2620,8 +2646,13 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
 					    : macsec_offload(ops->mdo_add_secy, &ctx);
-	if (ret)
+	if (ret) {
 		macsec->offload = prev_offload;
+		return ret;
+	}
+
+	macsec_adjust_room(dev, ops);
+	macsec->insert_tx_tag = macsec_needs_tx_tag(macsec, ops);
 
 	return ret;
 }
@@ -3379,6 +3410,52 @@ static struct genl_family macsec_fam __ro_after_init = {
 	.resv_start_op	= MACSEC_CMD_UPD_OFFLOAD + 1,
 };
 
+static struct sk_buff *macsec_insert_tx_tag(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	const struct macsec_ops *ops;
+	struct phy_device *phydev;
+	struct macsec_context ctx;
+	int err;
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
@@ -3393,6 +3470,15 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 		skb_dst_drop(skb);
 		dst_hold(&md_dst->dst);
 		skb_dst_set(skb, &md_dst->dst);
+
+		if (macsec->insert_tx_tag) {
+			skb = macsec_insert_tx_tag(skb, dev);
+			if (IS_ERR(skb)) {
+				DEV_STATS_INC(dev, tx_dropped);
+				return NETDEV_TX_OK;
+			}
+		}
+
 		skb->dev = macsec->real_dev;
 		return dev_queue_xmit(skb);
 	}
@@ -4126,6 +4212,10 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
 				goto del_dev;
+
+			macsec_adjust_room(dev, ops);
+			macsec->insert_tx_tag =
+				macsec_needs_tx_tag(macsec, ops);
 		}
 	}
 
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 42072fdcc183..d9f87dc543eb 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -316,6 +316,11 @@ struct macsec_context {
  * @mdo_get_tx_sa_stats: called when TX SA stats are read
  * @mdo_get_rx_sc_stats: called when RX SC stats are read
  * @mdo_get_rx_sa_stats: called when RX SA stats are read
+ * @mdo_insert_tx_tag: called to insert the TX tag
+ * @needed_headroom: number of bytes reserved at the beginning of the sk_buff
+ *	for the TX tag
+ * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
+ *	TX tag
  */
 struct macsec_ops {
 	/* Device wide */
@@ -342,6 +347,11 @@ struct macsec_ops {
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

