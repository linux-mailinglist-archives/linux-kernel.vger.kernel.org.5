Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C83794106
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbjIFQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242865AbjIFQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:58 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F719A1;
        Wed,  6 Sep 2023 09:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn6bWW6p0b8AyvmX3poFsiyqZbcorT30J01YfRl2zdRZBAywxEtBNRykvp7XZMBUlWxee/wL0YA5OstOJm+Gx4rt4szV+wiso8+H2auB+AwoLIERcUKyGJKO9x2VUu0YY6ypbLs7raJvdbhJmf6QVkRi7XtYdfi/uU+FgQL7y2OYC0P1sRcYS4D3SASbQNmGnRcuJ10IaGp4+ulMZvFpfVfmvl4d6IGG4MOaXzYg79sJR69+OjxvV78633NVUnsmh1/e6Q1CctVZZjwXqUcdhRFh2Dzu3+Ee36vQ7l9H6FHKdU6vb4npmJE9qeA10b0z2M5m+4ZgzzleC+RB/qLdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJz7zpQ2FlqOkGNv2+dnOqqY79gTV2uj4zKFtkTMr3s=;
 b=jqibfBTGQcZL19KkYwhEl/Mv9DZ8FOG0waBV4ST5rKbuGyqhNbI6TS0ckgtr/b8sYRDEbFNeoTwIFB4ZkdvKKpFWPxc9MqIVKTQCuLIQ+/PZL4P0WUnVUzWw29/Rj6I690yMr4hlK0TlndT6YNP84Ys2knS6yNTujjhZwmAFiChwy78PSE7wrPV0uX0TsQsGUY2jurbVin5EriEk5/gDFgguwlJ/bxUJxNgLayCvA9tKwkO+1K/4l9+Oso0sMI8dgCXWXPpo3AFRcPqZdcOaAa4faM68c12AXm8Wvnu8Z/vuvlsoD+cnMAgUfZlcitZ7uol0X7IEYusOrL+clqzFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJz7zpQ2FlqOkGNv2+dnOqqY79gTV2uj4zKFtkTMr3s=;
 b=lojEa8R14lxORqIUkWwi9lby8ZCLFs0FU1IqM7GiNK5hYNnOOB09X72aW7QHkkzHe1DverLH/NMZKhB4f7lvbegEoCG4r1UNnt6y1fy6CrnEwCB7tJEEd64+hNAJAV6ieoksPfmUzXNOhvMzf4O8vULuBPzKn0YKZjuiiUkCImg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:34 +0000
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee]) by PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:31 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v3 3/6] net: macsec: introduce mdo_insert_tx_tag
Date:   Wed,  6 Sep 2023 19:01:31 +0300
Message-Id: <20230906160134.311993-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To PAXPR04MB8958.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8958:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 44335e0b-5de2-49f4-71fa-08dbaef2ad35
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54k8oDuTqmP854H+ZnkeiDv2qBu28fpOvK9/KPEmaiHEyHc9DzZ9bMHR52b6PZM20oZlm4xJtJm28RbYZh+u3Nt8fzEO3SSCbWQaNTmNruftIvIJ2Vud2ploh7c0tann21woX7MsdqBpMmFz/F3uBt4Bnp/97rwvoK8zuGGgUv6KwVnrCpKJoblCZiEmfvyW4kiprB5XytpF+BA44RTEnfhWotYLV9Rqx0pg6lNPH7rzCwphKAXXOZye68CkYSrYb2eyoKWG2ezDEB6UgFOo4C3ijB/XuZFoG6RdTE5TE/KbsK7fenrQ0sJT4pqrFyauP+9o/rEXt6lcEQ+jmaz4UTLPULTWA94EIRQIG3LYO8c51x4dHNI670ITT9dYlPBer0IgRTZ19vsdnHgztBkuq3A5WhSRrLox/X6NcUgfMRdo8pzGJVU4kaMZzorbjfOKKtGLI2JecZP4A5EV8R1/BXZsQUePlIzSQx6oamMKd/8FYE13KeqglubaNXs2bKckWJSaiQH9eeWSV4QKnAZX5WLfttDFrVQ4odRVQBJUHJTzOtX/IJd5gXE/vWyK5cJaCdZnAXUj7WZ4gqnk3y3rVCLVd+fXPWy8vIQnkTqdtaieHUWoNnCAYkxSPVV6bz+0o3U24CDbNgyTAR15qeQi1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(66899024)(7416002)(921005)(38350700002)(86362001)(2616005)(478600001)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(52116002)(38100700002)(66476007)(66556008)(66946007)(316002)(2906002)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LcWPDhDjsRQYAoTZ37JkUu78olZRkSJtZhQ9A1RWIrJqiVa122ih95TfOi+?=
 =?us-ascii?Q?pbAfT3hTuGGCNA+pYyJu6odNjeMDH5MAUt2pVbzOhBr65+f88Crtlo3mSj4K?=
 =?us-ascii?Q?Dek0frM8HW4ih/Jl5agmme8s9TcoufxfykD5leFfAt1DJXcgUyZ7sDq2ClIc?=
 =?us-ascii?Q?Zd1vFJ2kOAMllhqrK/ybnWuIAB5PaLIXxmaCKAYXX5orQPc6HL5bLVy3ejqE?=
 =?us-ascii?Q?oFmTHgqUN34uxbS66WwFmaVpIxNWf9HB153Ga+hTEWq/dg11/+o17yifsKkW?=
 =?us-ascii?Q?mdTwz6vHtToWLHxgEv6os6rLPM9bI++NWhMQ7giQtTMM7spw6meN2EIA5ajr?=
 =?us-ascii?Q?CGQeqTi+/f4hZEyfQY4h6ilC9KohfzAZAm95ftMsO4IlGPxpfyr/mr+7ViYG?=
 =?us-ascii?Q?e5ulllLqNX4/BG1eT2ttMivUWruIdeDv9J+dxbUmiGcOxEAyiYqoiMP5K3dG?=
 =?us-ascii?Q?Xal46KPLxEnaNQX+tXsmdQaCi/yi/BGOER1rFjklQ69nLr5+Qwgjvd27SBLN?=
 =?us-ascii?Q?8m64g1DpQlPjqcdKXGcQVAvUPhPv7Q1JCu1nqt9WFJZ1k12GB/VlUlk/kUJ0?=
 =?us-ascii?Q?Xqwu/nupuqNunGdCGK4v6YkfMugC6UL0WQoXgqpEtFmCGNekGjjFgr4x/w25?=
 =?us-ascii?Q?2+NxB1BMyVEHjKjNoQns+2Zp3nFBlmO8HxCpiRyBOyqYvrWPjTRORACFIdHp?=
 =?us-ascii?Q?UGOXv/vg67ZR65t4FxyQ3Qwgpyh2PjPeUugb3lxSEAd8hss7LLnj2gcLTbze?=
 =?us-ascii?Q?BNWgiN5nFQg3Odso25WrDyB+Ry40+iE86ecAHca4Bj9PTwp691DJmDY0Wpms?=
 =?us-ascii?Q?4H2bw6+l+lKLD74hP2vtffCoRgZ/6fSMOncvkz0R/qFUGlaFe4N+qFXkqTdE?=
 =?us-ascii?Q?QayGTY0DdhDkloqoLiUUlKpUJP8ySGE26CpOY0MHCqrttbsn/bi2jczSYoeA?=
 =?us-ascii?Q?IUgTSRD1EQ/M+MvbqMvBUSHMbFq846qiIlwk8VmoFHRZ+SufWttxNzkMsjEs?=
 =?us-ascii?Q?s9tuIFwH/6/2o3G5/r3hUugD13ypeM19pJEthOz+PGiMRXuSMqMZ5LfBhlhG?=
 =?us-ascii?Q?9dEMC5WIr3ko10NjDuLUNNTx/llyQ6338WT/ILg/UdVGghsOhBePTTppAVoG?=
 =?us-ascii?Q?q2fcCkaLvUbtoC/cdJ7O3uVwDFeLQB6BBSFZh3cMQu39OOR/DYtKkKzombRG?=
 =?us-ascii?Q?hG+AIAbdoaAG0siSO5cDvM3i5u2FbXbRbFINQd9jZUrjlN3lT64G9bidTuFV?=
 =?us-ascii?Q?TVIGh/2Y58OgWfpC9f14eZ0YKDOC3wZ69nPedgtlGoezxBEoukCS1KSHgf7v?=
 =?us-ascii?Q?TFblDLmhbAkTcyx8Ohkv98B23SmCdp9Q8roDHDRKy3M7EceemU5RpyuOe9Ai?=
 =?us-ascii?Q?eFeSj7Lhg1SECjXHz9baI8wHlzSW9gW6tBhV/Iq6wQaWssNnXu6jmAchZx/R?=
 =?us-ascii?Q?kQdDCkea+924pLNxdlT13qoUlfrWf2dpmM6XmYd5/qLVLBBne5Lf1/L1Cc2H?=
 =?us-ascii?Q?mBgUHEVxVjSLDrCk+06OGooXsnwA1BWNVfCSSrgQTKf+D1XgCPEDQt0aA4Fc?=
 =?us-ascii?Q?EGoZ39jwGVUomJPvIslnHId0vNozYLqVogD8SLGqFTnE6cVe0vFAerCB5+xA?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44335e0b-5de2-49f4-71fa-08dbaef2ad35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:31.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j532PzwZCPN5aPm/drDCGIv5HpOPAd1wG/G0NQJaeJe5wDPZnqkiSsQAimFpHo7C2Evm3UpDdM6s2WMyRfwNG1DCMhMldkpybBBNcgMV12s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
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
index c3f30663070f..0c150364a6b6 100644
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
@@ -2582,6 +2585,29 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
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
@@ -2619,8 +2645,13 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
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
@@ -3378,6 +3409,52 @@ static struct genl_family macsec_fam __ro_after_init = {
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
@@ -3392,6 +3469,15 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
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
@@ -4125,6 +4211,10 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
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
index ecae5eeb021a..4e4fd9bca9b4 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -314,6 +314,11 @@ struct macsec_context {
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
@@ -340,6 +345,11 @@ struct macsec_ops {
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

