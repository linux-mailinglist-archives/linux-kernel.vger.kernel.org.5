Return-Path: <linux-kernel+bounces-5421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49634818A89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F62F1C21844
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7D1C694;
	Tue, 19 Dec 2023 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E+qPhXMK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C901F945;
	Tue, 19 Dec 2023 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMbi6ELaZpcoYjTUk+cnh7RkFeVV421Z8/5LOu5jrbju6aH2AVk7R3+jwBPA4WYK2grnJ0xo09n6vUoSzhSr2bOs2uaZAFg3iy831Hm1aKMuXOmHMm94nQalIxSl/6fgRCI/SLIDFAgEElY8mPuCGQ954CijYVZkXwVZpIF0CqNWFOKIs+wqf4shZ3Si/DaPv/zhYbYv7KECAIEEs13iLaQanwU130m7csdzLloqKZ5KQnc0nm65c3R+bF/furbTl8UDO2VKRTRhwDYRul3DOUxNHpgVt+33GrWgYsX4+mQ1lRG99LC6iFsSM35Wzn2msUXBOhsmVgPKK/cR5fi5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgCA9z3FFdHqcFoAUtvHXi95RstR+QgD+kmoILEiOCY=;
 b=eIswTvIsuWuOZGbGyphVG5gviv8GPm2ac+DCx0Vclb9qqbxfdaRus4kLGmKIPurNM6bMiPLEfdLzcRycIFy1yj562u6uHkFzmQxu+Oon449/UkGZAlbLCTfraK2kU42aWMJnAn5U7WU7VdKu/LLDmOLfh6c+rOvK85qzzv9jcAgqh1ud6kMUDU+lTQWyKnv8pBNZyR6vnrdmN1IIFp9XjXFUniIzXusNkS5hsrJnMQ8Q8thdgkyG3FQkU+F5nj59V3QfPabKa9sX5fISj1DKmcooR9iZT8cUrF6DmS28LCz34A/gHCVIBygrBSjwYT1PY+MEidwWqXLbQuSciXeKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgCA9z3FFdHqcFoAUtvHXi95RstR+QgD+kmoILEiOCY=;
 b=E+qPhXMKnkv0qnvgshXFmblbV9MQo3VCrA6+ebyH2tt9TSXN5ACJxssVycR/DHUzs1WG04qzkn/Lnt30AmhJ3Ct1p6AkSjazoFup+xe6KpD9HCeL0IoBhTZLOpmJbCCU0mytLE8jKOdeQ4juaiE399ulhmrsaJ6rLrGlzb/8eNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:54:24 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:24 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com,
	andrei.botila@oss.nxp.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v9 1/9] net: rename dsa_realloc_skb to skb_ensure_writable_head_tail
Date: Tue, 19 Dec 2023 16:53:25 +0200
Message-Id: <20231219145333.240323-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f1c28f-e120-4627-8758-08dc00a26396
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	acBmGiNYneN2PoH5kYBsXZGMlskdlyDh6dJECL8OQqpz+ao6QleTgjPfCcsWe5uTyS75jw2m67eDOHGWHrdzAKh9xsxCnYoX5zgrRDCg1Vx6JgtceWqUo9R7yZWFPq5/6pHjwVswShc+7QctBD5Etskho9Bwmo4VN6/Wc6rbSkj0nfDG29lEldbYocg7MU8+FZb+y8Lghvby6JR8ckNuCf1s4lTnsJG0MkIUTspvRmq9GYC0Fk7Fc6SOqcVpt3WbVuAqq7a0QMU8c/yXIkEyFq4WK8/cNa6FPufr9oIH1mqlitUDOAu3bdwbnZ+w4RlrtYYbxrzm6yT/5UVV43eR+tJlqKqW9XhziE0zvlMwYtVUpHp3aZPHun+Uso94h7LjmQ1NqsUaBRLN0LZcMKPOpIbeNvUc5EjS5Lo/NbYFqbKLvp2qPBvitIyMaQbW54kTG+HLvLn7cOr793SDEM25Ycaf9G0qQKN/8Jwbc0K305wTdxmqeJKgEJAMp8TKs2Dn1354PKe9PVkK37V3Hakpv1+r/tJ1WkTQHEtPLYZJ0q0dWegNWQ5CFrTqK/+hmX5+W3C0zeTY3kX8P6GBOdB/iyr2SWmQHRrlhJ00wcSzaXgdnszCVKKaMTdvERMuEB99
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(66946007)(66556008)(8676002)(4326008)(66476007)(8936002)(478600001)(6486002)(38350700005)(41300700001)(7416002)(86362001)(2906002)(5660300002)(26005)(38100700002)(6512007)(6506007)(83380400001)(2616005)(1076003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMwcIM0maRkt4HxjT7I7g7qzetpP1nakL3APMgH02+0jVHoF1/8ydwzDJMxy?=
 =?us-ascii?Q?yHO1mItSW9vufPcUA2RQtock//sgzrpk65knLUmYQv9fxCipfgjkbdL0yz+/?=
 =?us-ascii?Q?OiYmitQVycPtLIxNcGHXIqcKbWaPAfgkbgcwE1/7LPB/YKiKVxRTwXvTAu2E?=
 =?us-ascii?Q?VHASXwQTLYtmLyMHSBjCKbk/sZMTbfyQoKBDWDufMatS5AzT5uirBpVKcPIy?=
 =?us-ascii?Q?hXkLyymCRCKunZdIShHMz2s/3qZ6HXURs1cjItNypYHtgFwOkdA2yveZXH3x?=
 =?us-ascii?Q?mtKd7gLjxmDG+FETZ9yWwMk6gKK7blErCGWw8gr5iv1E2NTZ4S4E3YwIyJhc?=
 =?us-ascii?Q?k7WZLHKl3g5nUsv4xrawhz37gHaxspjtS56lm82vxZ5xhKlAtm9/ieZJPL1j?=
 =?us-ascii?Q?whFwtSGcD8KO2cJ10zy9tIoz3YTtAg0lTgc2PvMDkFon9LDFxH+clpj5Qh+X?=
 =?us-ascii?Q?P2vsKES5VZjc1h5gTFiDHUCWLTHdWdWM0ovXbqXebM2g4zq4snZt9DuoGw+u?=
 =?us-ascii?Q?Bel6GmttDlEpalUluyPneA1QG/PSJtSrte6br3wLUk21Kqiq/ppHEoJ9QTqi?=
 =?us-ascii?Q?Wyuy8L77PnYXxWjh+eeNvdFOxhZd29x+hi9PscPdAm7RK995ltkNpxn30HUs?=
 =?us-ascii?Q?/ET6TAlyzG5XKoB0W+L4aNGkML5OhBpYEuQut8rq5AU4HWtZmlgLGBGpy8iU?=
 =?us-ascii?Q?i3V1dOO2gVUrzluMlRi+Cx1IDNEHSJOJTphpThzFmxGnNChFklPtt6S1xcII?=
 =?us-ascii?Q?s9y7bdvdNcUsWcGzFkSCy1/0YYvDnuI4qxdZm75SYWlir90x0bkN++cQiupJ?=
 =?us-ascii?Q?mfco2DjnIdCY7mpcbY8WAZX1zWK+aObQMxcKrPFSfUNb1z8mAZLLOem6X2Pq?=
 =?us-ascii?Q?Ve8CfiMdHG3nCr6o8FQIdw4LKyTU26MlU5HGP0HstrR6digIGTK+6jBenTPb?=
 =?us-ascii?Q?9rIUgOjNPwZ1EBN+Y9M6+BBBTR4yg98Lv+cZXWD9zN7yQILkxk2gjWaR9xiA?=
 =?us-ascii?Q?Huo1bYukNlXdKXfYJ+XJo1IH1tV5PPG6PRMkEdrIDzsDPPttUHmiEPpsowl8?=
 =?us-ascii?Q?0DMGGMeLhzwyCzuypVGm3rqH6CC32BlBFNkqHGxioKTmJTETdX2G+drTxlMs?=
 =?us-ascii?Q?J3foLwDFKdKSU0Q3qtmmoASXPCjo508qApAFWl0s5ek9GZIJAbmVGu0uGknY?=
 =?us-ascii?Q?VU1EBpNxVCcURyW9Hqrdk9HbffthjlvYP3Vkon4SHJTVrBzAF/0cbEaDEvvj?=
 =?us-ascii?Q?QserXlwek5ztWxPl0sYGqutuVabAdp77LDvoIpu3IFrVG+i+0gZu00Exwoax?=
 =?us-ascii?Q?q+9E99PdV8L7C4QZKiASgw57xNSz5AfwA2M50g6D+atl6aQ6v7bfxfAFVHmp?=
 =?us-ascii?Q?m4HutnABENmVj0fPrU03dTpoGOvyOB7LMMKgP490fBSdVPjmkt3dl0qQnw2f?=
 =?us-ascii?Q?RiD0+hU15XjZdq2LQK3BPjg9m+mrQC1rUlCbV6ix+XQkFO/rKcjUnjftU9ba?=
 =?us-ascii?Q?ZdANP+/1vTwkoC/jTFoJpHXHd5pPHVC787XFuOEFbKlA1zv6fPK2Vw3Od/ZR?=
 =?us-ascii?Q?wMJQwy7HKt7UYW2f6KY00HhUqTwi8/PH4Nil6Bz5XMT+wRnFO4udWzCn1xzB?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f1c28f-e120-4627-8758-08dc00a26396
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:23.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv4elGtuGcKwTrAnAB09PgCr1BLuk7ZrACQn0vRJzgFPW5tYjI0QUIj0gE9+FJlVtIvlaVZEPwxHJZVj2aHeDxtv6ufwDMkEWicYuZseHZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948

Rename dsa_realloc_skb to skb_ensure_writable_head_tail and move it to
skbuff.c to use it as helper.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v9:
- patch added in v9

 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 25 +++++++++++++++++++++++++
 net/dsa/user.c         | 29 +++--------------------------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ea5c8ab3ed00..ffe866d426a6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4009,6 +4009,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb, netdev_features_t features
 				 unsigned int offset);
 struct sk_buff *skb_vlan_untag(struct sk_buff *skb);
 int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len);
+int skb_ensure_writable_head_tail(struct sk_buff *skb, struct net_device *dev);
 int __skb_vlan_pop(struct sk_buff *skb, u16 *vlan_tci);
 int skb_vlan_pop(struct sk_buff *skb);
 int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4d4b11b0a83d..fedbcfed2790 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5993,6 +5993,31 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 }
 EXPORT_SYMBOL(skb_ensure_writable);
 
+int skb_ensure_writable_head_tail(struct sk_buff *skb, struct net_device *dev)
+{
+	int needed_headroom = dev->needed_headroom;
+	int needed_tailroom = dev->needed_tailroom;
+
+	/* For tail taggers, we need to pad short frames ourselves, to ensure
+	 * that the tail tag does not fail at its role of being at the end of
+	 * the packet, once the conduit interface pads the frame. Account for
+	 * that pad length here, and pad later.
+	 */
+	if (unlikely(needed_tailroom && skb->len < ETH_ZLEN))
+		needed_tailroom += ETH_ZLEN - skb->len;
+	/* skb_headroom() returns unsigned int... */
+	needed_headroom = max_t(int, needed_headroom - skb_headroom(skb), 0);
+	needed_tailroom = max_t(int, needed_tailroom - skb_tailroom(skb), 0);
+
+	if (likely(!needed_headroom && !needed_tailroom && !skb_cloned(skb)))
+		/* No reallocation needed, yay! */
+		return 0;
+
+	return pskb_expand_head(skb, needed_headroom, needed_tailroom,
+				GFP_ATOMIC);
+}
+EXPORT_SYMBOL(skb_ensure_writable_head_tail);
+
 /* remove VLAN header from packet and update csum accordingly.
  * expects a non skb_vlan_tag_present skb with a vlan tag payload
  */
diff --git a/net/dsa/user.c b/net/dsa/user.c
index d438884a4eb0..b738a466e2dc 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -920,30 +920,6 @@ netdev_tx_t dsa_enqueue_skb(struct sk_buff *skb, struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(dsa_enqueue_skb);
 
-static int dsa_realloc_skb(struct sk_buff *skb, struct net_device *dev)
-{
-	int needed_headroom = dev->needed_headroom;
-	int needed_tailroom = dev->needed_tailroom;
-
-	/* For tail taggers, we need to pad short frames ourselves, to ensure
-	 * that the tail tag does not fail at its role of being at the end of
-	 * the packet, once the conduit interface pads the frame. Account for
-	 * that pad length here, and pad later.
-	 */
-	if (unlikely(needed_tailroom && skb->len < ETH_ZLEN))
-		needed_tailroom += ETH_ZLEN - skb->len;
-	/* skb_headroom() returns unsigned int... */
-	needed_headroom = max_t(int, needed_headroom - skb_headroom(skb), 0);
-	needed_tailroom = max_t(int, needed_tailroom - skb_tailroom(skb), 0);
-
-	if (likely(!needed_headroom && !needed_tailroom && !skb_cloned(skb)))
-		/* No reallocation needed, yay! */
-		return 0;
-
-	return pskb_expand_head(skb, needed_headroom, needed_tailroom,
-				GFP_ATOMIC);
-}
-
 static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dsa_user_priv *p = netdev_priv(dev);
@@ -956,13 +932,14 @@ static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Handle tx timestamp if any */
 	dsa_skb_tx_timestamp(p, skb);
 
-	if (dsa_realloc_skb(skb, dev)) {
+	if (skb_ensure_writable_head_tail(skb, dev)) {
 		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 
 	/* needed_tailroom should still be 'warm' in the cache line from
-	 * dsa_realloc_skb(), which has also ensured that padding is safe.
+	 * skb_ensure_writable_head_tail(), which has also ensured that
+	 * padding is safe.
 	 */
 	if (dev->needed_tailroom)
 		eth_skb_pad(skb);
-- 
2.34.1


