Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509C5779336
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjHKPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbjHKPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:33:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38853127;
        Fri, 11 Aug 2023 08:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvpb0rK2uHoXWOy+wfCpBXNb20yhVWRWkIgS9JH+G1WiqnHEbplOU/xVGKEWNN8eXjtH62BPiGThop5DVP5SBrqdL73mTJauw7UWKr7egdyiYxeY9yu/wUeSOLsBoSpKzVdp1cCcKUSFcXETldQfk/JuLbO/UQcv0WJ8ulcxMmq4g1mhP8f+/qUeI9PZlVcGry4v8JJYNef3yJFN/p1KVJPlEczl40oF7NOVthibZNwQ+8LelbDvx8jrr4pdEUjcdjgUs7kzBUNbEXnBRcWhVdVT2esWoEhaOWgYCvxnTyykOuk58g7kccvqtGXP27kvkYnhQGsu5b31YkD1b7xS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n302FhCwcAqsPW68Jy2vFnia3ZFUgTvrR4/jDMJTHbg=;
 b=nJTRVD+zUt1fY/zzDkT0oU9tw7usv6s9AwPLuapBTZFiOTasS2kbQX8nOtByJGM62HGZ7xgmbUkP1W2SAOZfsn0VGtmYWhdMkkDChLb/LS+oM0fZe1mgjhARJqIrOtpJG7Kq6LSlFlRWKLCZgVPAHXndb861rjy/z3pkSww+O6ttzMcfHc0tcRP8DU4myZLP1waBJCBOoBvzc1jBu01i1Vr5E9V3Z/kfC+r0/2SNhJ+SIJjsqKl8+Paa7CYnUd6CCSqA38H37vMzqjJDdrVEgYEoPBbPpDvGw2/wQFWUlYtySafy3iZ5AP5rSVus72pkcRsVc7ehGSgnqEN24RTaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n302FhCwcAqsPW68Jy2vFnia3ZFUgTvrR4/jDMJTHbg=;
 b=dsgn8okdt9W5vuj4/VEIwcX7zUcN9HqOTxhvlpHTsvXe6OE9BAVla2/c95jelyl1AUPFjdWCEjz/yqCYpdBBsB6nqWeYDZgb+In2apJe/iNUgIQOvpxeOl8MlTrM3XtFdZcaT5DPk034LfvAYunXjwDar55pFFKlRbDviGqEO1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:33:46 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:33:46 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Date:   Fri, 11 Aug 2023 18:32:48 +0300
Message-Id: <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: cb227c5d-47d8-4300-60e9-08db9a805a3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jakIw+fThGaHTvwNVQ2MrzayBq6RyPGr6ohd4PGsHeibCJfIFP9HAbgjUXIXndOqsFpJqZHgXA8D9mkJ8YMQp43S0E1I3FlXxm63Zo9xynzfPT7msqw00XXeppZO5qsWyj9Pi8DDi9YgIae4DTXK53W5MPO2vuj9XnLhLRoejxY4o+DbaGGDU363JfvkD0JKQCpwIazUckYtl1B7atg2c86Bl4pgqo5vkKNyJ1H/p6uoWFJH3BkDTbqKC+P2OF+d4EFuvuoT23vkipAe/fAd5aEkmybpso1R8H2DTw7becC2qnX5jXH2szQ6ldDKTaFl8xDOaPQtD1EL8vEtcQf52w3OzynlSev3Ft3XQ1h/F8TORaxGyVPuw2TWkWWhyrFy/HejtvTVwhLH1cNqSJsJhYmfIgUA0yGb6oRHGwBKO67lDc2cBrx7oc0AYCEx5Fs9K23mdpZiCtDiH/Y29n50TgEQuOscQEmJ+8IlwoTpJKLioWCFLzsOGZrYrnT6pM+g27J2n4geJxO66C5o+RQNVV307uWX4lcVoeJ7oFquztfSTRurykUISYUSApqW8dK1EvtlJvfzcf0KXfjSpzO1pzkJ1dEhMFuCf+DbNmOg+ksuMhDbp1FEmx7SSHUxXKlC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(186006)(451199021)(1800799006)(2906002)(6486002)(52116002)(38100700002)(2616005)(83380400001)(6512007)(26005)(1076003)(38350700002)(6506007)(478600001)(316002)(4326008)(66946007)(41300700001)(8676002)(8936002)(66899021)(5660300002)(66556008)(66476007)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Men4UDyX4ksM3C4wlGYk6Fu5Hb6nz/5JkwZ1FmF9qcTkvG0dOxjaWm74cd3l?=
 =?us-ascii?Q?nsCSKAhoj+D2MbEAKpgYU2DNcGRfTw9hd5D7ZQBcI0bMbT/61BXd+mmHj+Ee?=
 =?us-ascii?Q?Clo344opjPqc7cIeikwLj35U9ENjnpi0SpJokpsYJqindxuvW3D7x5IXubIJ?=
 =?us-ascii?Q?A7BqzZwgBli8ezeBFYm4RIomGZRP125/kO/0bmCCXimzK1jadtbGn6g46U8k?=
 =?us-ascii?Q?3yC05VgLcJfWIL8H6MEAmvRPzgzefOsuVbaQ8rKHS27+6jBYeaehCRBs3YN4?=
 =?us-ascii?Q?8r/dG4+X/gIapLHFPbKpaKJw7eJRAS78BKtvUwAr8QzDdiAvHyFI0QZ+pG4x?=
 =?us-ascii?Q?XbIJnhQewz9/zzavKN4gh8drRGgAyMQdtdsgLOGyTBZueQF0POnMRitNm0w1?=
 =?us-ascii?Q?Ja8DHkGBLjo7DMa7GXbWBXkQ3pvCK9D4zS3fGzWhjXiksiTgg691BV1p4Pjf?=
 =?us-ascii?Q?isl5BtaRHsctmnrpVVCRc+ziooqfPEQDZwWMStp0/YbsRY94HtlCShDtt9I1?=
 =?us-ascii?Q?9eSHZ+m6/fT/osib1E8xdfhD/9xFJrtGozwv8M6g7MXoXhI3l11kg0GSis+2?=
 =?us-ascii?Q?s7z/NU14I/RxJpxVf15Dxplp+GSQwTfy7waWgJdnIM9KAO3BfGGCAqZIl9lZ?=
 =?us-ascii?Q?M3Lh6yerIDs6cH/rTXInfwX0AjRDUR16ew/Z8Bgim8aqM5KXkfm+CLwILVQ2?=
 =?us-ascii?Q?LEzVdxMmAwzpcF7PElnJnoogX1bm2UvdwZy2BKeeld3Od42yxogt9taFh3nf?=
 =?us-ascii?Q?ZPX/8TdCIH5HSlJJLpogaOrsAnntn+wefP4DYkX8Bag6a7SA6dQVkceqbwkW?=
 =?us-ascii?Q?9fKvkCIcoesVIHbyIyvN/bZPBPo9ofaf80ubQJ7remtmIc3tsqCeiRv5Xgem?=
 =?us-ascii?Q?UpIKP85MPkcPFmHC8xARCUzTxf2IwRdGzyc7/dEzfQ3KZlp4imvssODLhu//?=
 =?us-ascii?Q?QX2lPzaTNZfOPSFKvenkbe0MidXITLW5rlnT55gGSaXV1DIrRQDbPhd6nlsP?=
 =?us-ascii?Q?AMvfe+sncZb1sZr6owEWe6sHWk29MHDzecU09pxDUlLCSBMDxb+hGkkHhLbm?=
 =?us-ascii?Q?j2i+N4Pwh3oNS1DcwA60wLU8a7vh52FnMlaf3pIDG5I+ZEarmnWoj1jfWbtX?=
 =?us-ascii?Q?VQ1jQGs2rLYgKqebbMMfEBcmFiVvj0YeRQaLQRYsQrKl0EYzmdAbxDH41U+S?=
 =?us-ascii?Q?sfijBECnyKRu5BD3rdEIs7NyQz7ZCzTbYl/bRB7y9KkDaO1uhCeJ0Zrveb80?=
 =?us-ascii?Q?DnTlfqsAgdcu3j/ygtZjdUypZO+meOQwY66tKIYzakfBkZQBdnyYzoCdQ5tr?=
 =?us-ascii?Q?+HqSRWCf3RvZzsj2+3VoJ2RNeOFPGQsPc7PBK3CRAARgwM+H0TQEKTU9IBCD?=
 =?us-ascii?Q?IfW0wqXKC6CdJp1hl/AM1NFChg3RU5EsJ8Okypet6F+Q1QBZdhmmCPPUsMUt?=
 =?us-ascii?Q?1JbNoaFv1oMjwJr4JOVSQYiZrcaNeEYjJlgAueBC1X6ab7Nj7jN8aIZmsuC4?=
 =?us-ascii?Q?PYhI1jiayYr6xiF6cpM2Fc5JTMPJ5MdyrU5V1KVJQu/FLG4GPXjKjkGku85q?=
 =?us-ascii?Q?QF4ZPSj+B/z+ObrRybL+VHfuBTo55ZoJOLOgVm4J3QtJ+/UrczTB8v6AVnoq?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb227c5d-47d8-4300-60e9-08db9a805a3e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:33:46.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKSb8luYZUde2S/eGfFIiUE79B+WQ4jAMUeO2b19x5LrLFy2c9VtF8pfytAKZ0pdEcQAT7p5/i4FVOa9X3avSLCBiNitNTTc+YYX8PftQLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
the ethernet frame. This operation will increase the frame size with 32
bytes. If the frames are sent at line rate, the PHY will not have enough
room to insert the SecTAG and the ICV.

To mitigate this scenario, the PHY offer to use require a specific
ethertype with some padding bytes present in the ethernet frame. This
ethertype and its associated bytes will be replaced by the SecTAG and ICV.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/macsec.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 include/net/macsec.h |  5 +++
 2 files changed, 84 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 144ec756c796..32ea1fd5f5ab 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2633,6 +2633,18 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	if (ret)
 		macsec->offload = prev_offload;
 
+	if (macsec->offload == MACSEC_OFFLOAD_OFF) {
+		dev->needed_headroom -= ops->needed_headroom;
+		dev->needed_headroom += MACSEC_NEEDED_HEADROOM;
+		dev->needed_tailroom -= ops->needed_tailroom;
+		dev->needed_tailroom += MACSEC_NEEDED_TAILROOM;
+	} else {
+		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
+		dev->needed_headroom += ops->needed_headroom;
+		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
+		dev->needed_tailroom += ops->needed_tailroom;
+	}
+
 	return ret;
 }
 
@@ -3389,6 +3401,61 @@ static struct genl_family macsec_fam __ro_after_init = {
 	.resv_start_op	= MACSEC_CMD_UPD_OFFLOAD + 1,
 };
 
+static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
+				     struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	const struct macsec_ops *ops;
+	struct macsec_context ctx;
+	int err;
+
+	if (!macsec_is_offloaded(macsec))
+		return ERR_PTR(-EINVAL);
+
+	ops = macsec_get_ops(macsec, &ctx);
+	if (!ops)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->mdo_insert_tx_tag)
+		return skb;
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
+	if (skb->len - ETH_HLEN > macsec_priv(dev)->real_dev->mtu) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	ctx.secy = &macsec->secy;
+	ctx.skb = skb;
+
+	err = ops->mdo_insert_tx_tag(&ctx);
+	if (err)
+		goto cleanup;
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
@@ -3403,6 +3470,13 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 		skb_dst_drop(skb);
 		dst_hold(&md_dst->dst);
 		skb_dst_set(skb, &md_dst->dst);
+
+		skb = insert_tx_tag(skb, dev);
+		if (IS_ERR(skb)) {
+			dev->stats.tx_dropped++;
+			return NETDEV_TX_OK;
+		}
+
 		skb->dev = macsec->real_dev;
 		return dev_queue_xmit(skb);
 	}
@@ -4137,6 +4211,11 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 			if (err)
 				goto del_dev;
 		}
+
+		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
+		dev->needed_headroom += ops->needed_headroom;
+		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
+		dev->needed_tailroom += ops->needed_tailroom;
 	}
 
 	err = register_macsec_dev(real_dev, dev);
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 33dc7f2aa42e..a988249d9608 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -272,6 +272,7 @@ struct macsec_context {
 		struct macsec_rx_sa_stats *rx_sa_stats;
 		struct macsec_dev_stats  *dev_stats;
 	} stats;
+	struct sk_buff *skb;
 };
 
 /**
@@ -302,6 +303,10 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	/* Offload tag */
+	int (*mdo_insert_tx_tag)(struct macsec_context *ctx);
+	int needed_headroom;
+	int needed_tailroom;
 };
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.34.1

