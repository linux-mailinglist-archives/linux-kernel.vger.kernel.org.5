Return-Path: <linux-kernel+bounces-23767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5382B16C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352FC1C23F27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69051C3F;
	Thu, 11 Jan 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fHdbotv5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2123.outbound.protection.outlook.com [40.107.20.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE751005;
	Thu, 11 Jan 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihi/w0x8UjR8uPeHFUwpZQ+b8i9o5z4BYTmpnw07DGsEOdI+ky4oHrsaW47eeAa8Y69VQQB1mk5gwuFxmk+LwnKJSVFlrNuRFL7/Mx1QBUL9Np1u5J10x6tgVZAMHAZ2YXTpLbOJ+gttR8rQOe1oLm/zrjt1rkSnpWSL+XuqnuOgF90QWWI3lMef/tEMkGtGOcRFH417YPkanYew2pMQnyu0tz9PZSARkphJWpeXZN5mAfyJUOrDLdO1rTyup7LV7BogDbJYJBeL66I7vfSzlUV2yxokYNKh/ubIzvGyA7UKUyHwMxW3C/cL+fT30CCMzJgtvw9KfBPoAszbJ45ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34SaKBO8OIgvatMNnolEBX4W5FSr2id9kZsI7FyTqys=;
 b=incspqBsYmvjpGxhaTQFemi1GeusFARQInRrdj4T5SnM08drDoT0VfSC1pIvrddRh4bSj2fdhqRswnHP+33O/pD6eWc/M1GBjIC2O+HmR89D+vSauertnJ6mlUqaWMyn+z34TN4kNbq8c6D+Jun6bxLOmla3b1w+fmjQihCgtX98Fd1nw1g6y53KtCrEM1XfjViE5N+hbuE88kx/f4dYIRbRbkvwNemPRstrjhYlAoZwClHT4GsdGd5F9TfgnnDuOfgkVleq8HjnBNK8nrI6Vwp0Xyyh1Id1D3Htmrg/Ii5pWQ2vkA6xKUY68BY1RCbjahuUEPzXr0yQt1YD1rl1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34SaKBO8OIgvatMNnolEBX4W5FSr2id9kZsI7FyTqys=;
 b=fHdbotv52OsH6ydjsWbibXqHT+P/7eGl7RhFNzUxSO6ikywv7toPxWp3/9Zqqb0wau/v00Y29iXKUq1aEH1TrfCWveIZccPitVzOeFCtPeEGunobfeNLeOGmIVi1cq7EXaPMcLehzTYGIomZwXowq0Q6F6EqFjkukE6Iwqj8nJTwV7Je2P02+9uMB9qIiPl6O8FwixQFIVcYinBS4Wnqtlx+wE5evzsfZ0hOrG9ry4wpySlS/+RK7RUJAD//8Z2xYjb/el0+h0tD+kfV2tYbJtXV5un3pOGwcimsNI0uug3ublcUrBtMedJL4UN2q6xWWQ6W/PjADy/qnYnwYbm+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DB4PR08MB9238.eurprd08.prod.outlook.com (2603:10a6:10:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 15:07:20 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 15:07:20 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	David Ahern <dsahern@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Kees Cook <keescook@chromium.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	kernel@openvz.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH v3 4/4] netfilter: bridge: replace physindev with physinif in nf_bridge_info
Date: Thu, 11 Jan 2024 23:06:40 +0800
Message-ID: <20240111150645.85637-5-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
References: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::24) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DB4PR08MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 424f9b44-2176-469b-05aa-08dc12b70229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9V6KPw0lXC2rYBE9NeZMRvApYKCJqZUtPflGd7iZctgqxlHS00m48S0AvAqJNxuBoyYWjYH5NR4zSX6BtMGXWcCE/nOuj5nly9V3HQBlqxvC/Ilr5P7MNoZlcEx3VKL0LdAyiCqjt2Zf+LxHh4NuL8t3Kf0EA2jR/ZRLPdyZf6go0JqnxlYGz1V+lobQjw3bQEdGRFBAJKKomZPveqxX5THDA08VaPN01Yd1NgnkWg61lEY9tKk6/Eb25IwAd9ZSGcsFxa+AB3OSnzm3rq2mV1gv6gcN82n3xU0nfyrwUHnGzWbssNln1YyJpVv76Y+lIsUEvS56IPCFs3xmUU7G/6OqpkYS3kY4W+QKSLk9SzLK6zg9DwbSCwR6R5dTbTxozpGOtPNPo2bLw1YX7AOd7mtkeJdnqJOCEBNwbcUuMZVTOFc0/8V33EKI0mt9aAdBOmVlrDnZykent405OYKVguyMNAUoaidFImClXJeRKquxLr7L4/g/veJ+OBXiAl16pSbxD4O30/cOI2jNbAi8NqbIlI/rBkx6Zxf+ayAHpDYIZ0YLlaKimeRXunw2hVWlgTTfIofrZb8XOPy15U4+NQcoTfDaGHSackxhakTa36s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(36756003)(921011)(86362001)(66946007)(38100700002)(107886003)(316002)(2616005)(1076003)(6512007)(66556008)(478600001)(52116002)(2906002)(110136005)(4326008)(6486002)(6666004)(66476007)(6506007)(8676002)(8936002)(30864003)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Dkyt6DB4cAhK6unzPlNeYFZuKBEcfrjDcpGERS6uvu6ZwsllCxKrNpaT32k?=
 =?us-ascii?Q?5FJDtc5xb++Z4d4/5uFIwNTcHTfKoCgWtz6I/myNZLEfKxJp4qCNDxJjFuiA?=
 =?us-ascii?Q?Qdqe1+ZfKv1Ic94Acn1yuSh1H2apeyEqDsHkWYyO4LAhr+/Y+tsXAh3ynsgn?=
 =?us-ascii?Q?LyRsIQFqNFvQcgKVO+6eS2vxMN10KOArS2LSmqKf+pn7mVu8Y96s2Ec1Jrm2?=
 =?us-ascii?Q?pmY1XcgUpuk16Qan3Vni9fkDH+mvgA0CJ89oHog79ZuidK2/1jnwhZ3K+Ob5?=
 =?us-ascii?Q?G+uRsY3aIgLH2bEHHLeFPJtUjW7N8xj0m7ZeAfg0SXWQVEf6KLpgw2w6LSbr?=
 =?us-ascii?Q?bNdhtB8SfebycboJZ+o2GUxoJgBd7bWWfAjWi7tBV83v38KD/cX9Y34z8KfD?=
 =?us-ascii?Q?zabR0wV1Bv6D5IkNl0bi0uZu7uLTbYhnvOa8IFvg1Uhh9kpLiE1k5yC9yV2D?=
 =?us-ascii?Q?l1znMo6mH8I8zLLgrbkDN5Vjd1RhbxVo5N/BWb1C9aTSokMeLg81wgrUq1kd?=
 =?us-ascii?Q?JXzMM8+U4Hoy1SEyxNxJjojnZ0K5MprhtIeHP/dBaL2YuHgKvcGq3t4zfYEu?=
 =?us-ascii?Q?7LGGxAuBBErgUOcFtZdfuFWK65XyvJBofWCeqn0SlS+mcuS1PfL6ALM0wTtf?=
 =?us-ascii?Q?rW/WV98jKaYqzVL0j67iw6KVDThej07W42c2QjEiDF0Tl9Tgb38+ob5gAIKx?=
 =?us-ascii?Q?rYcQkVcpIPoH/WvX2VkGdqOU5wEFbDs4zUTirycdlU8obf2ToGTJshScBJnM?=
 =?us-ascii?Q?j/XkEY1sbcSQAsJ4fSW7FTYzRblrqOb5MOCmxfc8DDPYPPEAYuDTUxQH/MD2?=
 =?us-ascii?Q?Iq3JsoKt6W61nZ+nWMmVQN8EyksqMvQCbeRyfBVvy1cqcpAmGrULc6SskM5P?=
 =?us-ascii?Q?jMQctGTuah2ILyNJfqSlGZP5x7htma86+Z4Qbp0akuEYOklVMnacFndwTP5I?=
 =?us-ascii?Q?CqKDip2yfLAsdFHnEoPEwNa3uX+EO5e+VyosWtY6CsOmuSUcr0467b4jT4Ul?=
 =?us-ascii?Q?AAiqEqu7w6d7y5Yky9eGiwHPrJCobObMXSvN4BpqtSL2dYWW/2UQ3a26rb3m?=
 =?us-ascii?Q?bR7iMUBCkRDzIx7HLWhKwJPbjQDb/9J0d/wEAV1AYg6NbkbcoISRlJuFHefE?=
 =?us-ascii?Q?MjmKMa4RpgNxag9AH3CEis5mRWGDWuzvLLNyNXFUPfu/n80+PUWhSeAtqRyk?=
 =?us-ascii?Q?1A6GoxkLjQb7ggjdZloK5SFMK5YYTE3eMR0HR9eJ1vCAq8zltHdssERoC7mp?=
 =?us-ascii?Q?ge9bOZt5dkbMlAm4aztzk4xDnAN6uyiP/hU907kTpS3KGXjB2avVMXZf3RlY?=
 =?us-ascii?Q?Y//7bJmcmzqM/RUxYy1v6JLWRSfgM2R7+B45zRo+QuZmtTTCZa1udlv3PxVk?=
 =?us-ascii?Q?Aefe2/+5sIn3thDg8nSzvN6/VFCkK+x2fEBstEdvICLHBEubh6+2Wnvhwezb?=
 =?us-ascii?Q?xBjHM+7wM0kpHqSAztHkdWQaykFwTfhj6VWVD8TCsg/Gj6iZ1KrWD5c1jlTY?=
 =?us-ascii?Q?V3qgt4mW1WGvhPjJiYqwD+0u0oKHpTUdSIpD+e9Y57SwsK/YVcG9k/5QCjL3?=
 =?us-ascii?Q?mRjIVszTBQ8BTNlU2NuoPyXKTB9oP3tzOSSfTzA4Y4O5lJ9meKeACko1MY3I?=
 =?us-ascii?Q?S/rVxhj/3YBmvYdbOgphcGVjRglCSKkm8BmrCn/iqBKgdJFR9ZFhO+OVkkRR?=
 =?us-ascii?Q?a0ZqOQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424f9b44-2176-469b-05aa-08dc12b70229
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:07:20.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUWl+OV++rJ7b+++TdlGbkSpmRgpO2V1Z6dmkVwFpS4x+4XF6/jmUL1x/2O13olsgRuADpSAu9DGZWbvt9sVjuS4H1CN5bBxxmficz88ryE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9238

An skb can be added to a neigh->arp_queue while waiting for an arp
reply. Where original skb's skb->dev can be different to neigh's
neigh->dev. For instance in case of bridging dnated skb from one veth to
another, the skb would be added to a neigh->arp_queue of the bridge.

As skb->dev can be reset back to nf_bridge->physindev and used, and as
there is no explicit mechanism that prevents this physindev from been
freed under us (for instance neigh_flush_dev doesn't cleanup skbs from
different device's neigh queue) we can crash on e.g. this stack:

arp_process
  neigh_update
    skb = __skb_dequeue(&neigh->arp_queue)
      neigh_resolve_output(..., skb)
        ...
          br_nf_dev_xmit
            br_nf_pre_routing_finish_bridge_slow
              skb->dev = nf_bridge->physindev
              br_handle_frame_finish

Let's use plain ifindex instead of net_device link. To peek into the
original net_device we will use dev_get_by_index_rcu(). Thus either we
get device and are safe to use it or we don't get it and drop skb.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
I'm not fully sure, but likely it:
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 include/linux/netfilter_bridge.h    |  4 +--
 include/linux/skbuff.h              |  2 +-
 net/bridge/br_netfilter_hooks.c     | 42 +++++++++++++++++++++++------
 net/bridge/br_netfilter_ipv6.c      | 14 +++++++---
 net/ipv4/netfilter/nf_reject_ipv4.c |  9 ++++---
 net/ipv6/netfilter/nf_reject_ipv6.c | 11 +++++---
 6 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/include/linux/netfilter_bridge.h b/include/linux/netfilter_bridge.h
index e927b9a15a556..743475ca7e9d5 100644
--- a/include/linux/netfilter_bridge.h
+++ b/include/linux/netfilter_bridge.h
@@ -42,7 +42,7 @@ static inline int nf_bridge_get_physinif(const struct sk_buff *skb)
 	if (!nf_bridge)
 		return 0;
 
-	return nf_bridge->physindev ? nf_bridge->physindev->ifindex : 0;
+	return nf_bridge->physinif;
 }
 
 static inline int nf_bridge_get_physoutif(const struct sk_buff *skb)
@@ -60,7 +60,7 @@ nf_bridge_get_physindev(const struct sk_buff *skb, struct net *net)
 {
 	const struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 
-	return nf_bridge ? nf_bridge->physindev : NULL;
+	return nf_bridge ? dev_get_by_index_rcu(net, nf_bridge->physinif) : NULL;
 }
 
 static inline struct net_device *
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a5ae952454c89..2dde34c29203b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -295,7 +295,7 @@ struct nf_bridge_info {
 	u8			bridged_dnat:1;
 	u8			sabotage_in_done:1;
 	__u16			frag_max_size;
-	struct net_device	*physindev;
+	int			physinif;
 
 	/* always valid & non-NULL from FORWARD on, for physdev match */
 	struct net_device	*physoutdev;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 6adcb45bca75d..ed17208907578 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -279,8 +279,17 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 
 		if ((READ_ONCE(neigh->nud_state) & NUD_CONNECTED) &&
 		    READ_ONCE(neigh->hh.hh_len)) {
+			struct net_device *br_indev;
+
+			br_indev = nf_bridge_get_physindev(skb, net);
+			if (!br_indev) {
+				neigh_release(neigh);
+				goto free_skb;
+			}
+
 			neigh_hh_bridge(&neigh->hh, skb);
-			skb->dev = nf_bridge->physindev;
+			skb->dev = br_indev;
+
 			ret = br_handle_frame_finish(net, sk, skb);
 		} else {
 			/* the neighbour function below overwrites the complete
@@ -352,12 +361,18 @@ br_nf_ipv4_daddr_was_changed(const struct sk_buff *skb,
  */
 static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb->dev;
+	struct net_device *dev = skb->dev, *br_indev;
 	struct iphdr *iph = ip_hdr(skb);
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct rtable *rt;
 	int err;
 
+	br_indev = nf_bridge_get_physindev(skb, net);
+	if (!br_indev) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	nf_bridge->frag_max_size = IPCB(skb)->frag_max_size;
 
 	if (nf_bridge->pkt_otherhost) {
@@ -397,7 +412,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 		} else {
 			if (skb_dst(skb)->dev == dev) {
 bridged_dnat:
-				skb->dev = nf_bridge->physindev;
+				skb->dev = br_indev;
 				nf_bridge_update_protocol(skb);
 				nf_bridge_push_encap_header(skb);
 				br_nf_hook_thresh(NF_BR_PRE_ROUTING,
@@ -410,7 +425,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 			skb->pkt_type = PACKET_HOST;
 		}
 	} else {
-		rt = bridge_parent_rtable(nf_bridge->physindev);
+		rt = bridge_parent_rtable(br_indev);
 		if (!rt) {
 			kfree_skb(skb);
 			return 0;
@@ -419,7 +434,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 		skb_dst_set_noref(skb, &rt->dst);
 	}
 
-	skb->dev = nf_bridge->physindev;
+	skb->dev = br_indev;
 	nf_bridge_update_protocol(skb);
 	nf_bridge_push_encap_header(skb);
 	br_nf_hook_thresh(NF_BR_PRE_ROUTING, net, sk, skb, skb->dev, NULL,
@@ -456,7 +471,7 @@ struct net_device *setup_pre_routing(struct sk_buff *skb, const struct net *net)
 	}
 
 	nf_bridge->in_prerouting = 1;
-	nf_bridge->physindev = skb->dev;
+	nf_bridge->physinif = skb->dev->ifindex;
 	skb->dev = brnf_get_logical_dev(skb, skb->dev, net);
 
 	if (skb->protocol == htons(ETH_P_8021Q))
@@ -553,7 +568,11 @@ static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff
 		if (skb->protocol == htons(ETH_P_IPV6))
 			nf_bridge->frag_max_size = IP6CB(skb)->frag_max_size;
 
-		in = nf_bridge->physindev;
+		in = nf_bridge_get_physindev(skb, net);
+		if (!in) {
+			kfree_skb(skb);
+			return 0;
+		}
 		if (nf_bridge->pkt_otherhost) {
 			skb->pkt_type = PACKET_OTHERHOST;
 			nf_bridge->pkt_otherhost = false;
@@ -899,6 +918,13 @@ static unsigned int ip_sabotage_in(void *priv,
 static void br_nf_pre_routing_finish_bridge_slow(struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
+	struct net_device *br_indev;
+
+	br_indev = nf_bridge_get_physindev(skb, dev_net(skb->dev));
+	if (!br_indev) {
+		kfree_skb(skb);
+		return;
+	}
 
 	skb_pull(skb, ETH_HLEN);
 	nf_bridge->bridged_dnat = 0;
@@ -908,7 +934,7 @@ static void br_nf_pre_routing_finish_bridge_slow(struct sk_buff *skb)
 	skb_copy_to_linear_data_offset(skb, -(ETH_HLEN - ETH_ALEN),
 				       nf_bridge->neigh_header,
 				       ETH_HLEN - ETH_ALEN);
-	skb->dev = nf_bridge->physindev;
+	skb->dev = br_indev;
 
 	nf_bridge->physoutdev = NULL;
 	br_handle_frame_finish(dev_net(skb->dev), NULL, skb);
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index 2e24a743f9173..e0421eaa3abc7 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -102,9 +102,15 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct rtable *rt;
-	struct net_device *dev = skb->dev;
+	struct net_device *dev = skb->dev, *br_indev;
 	const struct nf_ipv6_ops *v6ops = nf_get_ipv6_ops();
 
+	br_indev = nf_bridge_get_physindev(skb, net);
+	if (!br_indev) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	nf_bridge->frag_max_size = IP6CB(skb)->frag_max_size;
 
 	if (nf_bridge->pkt_otherhost) {
@@ -122,7 +128,7 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 		}
 
 		if (skb_dst(skb)->dev == dev) {
-			skb->dev = nf_bridge->physindev;
+			skb->dev = br_indev;
 			nf_bridge_update_protocol(skb);
 			nf_bridge_push_encap_header(skb);
 			br_nf_hook_thresh(NF_BR_PRE_ROUTING,
@@ -133,7 +139,7 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 		ether_addr_copy(eth_hdr(skb)->h_dest, dev->dev_addr);
 		skb->pkt_type = PACKET_HOST;
 	} else {
-		rt = bridge_parent_rtable(nf_bridge->physindev);
+		rt = bridge_parent_rtable(br_indev);
 		if (!rt) {
 			kfree_skb(skb);
 			return 0;
@@ -142,7 +148,7 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 		skb_dst_set_noref(skb, &rt->dst);
 	}
 
-	skb->dev = nf_bridge->physindev;
+	skb->dev = br_indev;
 	nf_bridge_update_protocol(skb);
 	nf_bridge_push_encap_header(skb);
 	br_nf_hook_thresh(NF_BR_PRE_ROUTING, net, sk, skb,
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 86e7d390671af..04504b2b51df5 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -239,7 +239,6 @@ static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		   int hook)
 {
-	struct net_device *br_indev __maybe_unused;
 	struct sk_buff *nskb;
 	struct iphdr *niph;
 	const struct tcphdr *oth;
@@ -289,9 +288,13 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	 * build the eth header using the original destination's MAC as the
 	 * source, and send the RST packet directly.
 	 */
-	br_indev = nf_bridge_get_physindev(oldskb, net);
-	if (br_indev) {
+	if (nf_bridge_info_exists(oldskb)) {
 		struct ethhdr *oeth = eth_hdr(oldskb);
+		struct net_device *br_indev;
+
+		br_indev = nf_bridge_get_physindev(oldskb, net);
+		if (!br_indev)
+			goto free_nskb;
 
 		nskb->dev = br_indev;
 		niph->tot_len = htons(nskb->len);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 27b2164f4c439..196dd4ecb5e21 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -278,7 +278,6 @@ static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
-	struct net_device *br_indev __maybe_unused;
 	struct sk_buff *nskb;
 	struct tcphdr _otcph;
 	const struct tcphdr *otcph;
@@ -354,9 +353,15 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	 * build the eth header using the original destination's MAC as the
 	 * source, and send the RST packet directly.
 	 */
-	br_indev = nf_bridge_get_physindev(oldskb, net);
-	if (br_indev) {
+	if (nf_bridge_info_exists(oldskb)) {
 		struct ethhdr *oeth = eth_hdr(oldskb);
+		struct net_device *br_indev;
+
+		br_indev = nf_bridge_get_physindev(oldskb, net);
+		if (!br_indev) {
+			kfree_skb(nskb);
+			return;
+		}
 
 		nskb->dev = br_indev;
 		nskb->protocol = htons(ETH_P_IPV6);
-- 
2.43.0


