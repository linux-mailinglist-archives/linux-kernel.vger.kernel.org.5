Return-Path: <linux-kernel+bounces-22041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA14829854
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66089B20ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC36481C2;
	Wed, 10 Jan 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fQikDrRd"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2093.outbound.protection.outlook.com [40.107.20.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8C481A2;
	Wed, 10 Jan 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQlq00Tzq7P/mMU56rZMU87LnsAH7sBdzeQrvmmiP1Kx0hnhlC9Gb83QCc4iKjXdMXVEwaQDmzsVo8iOsMZqefo9nRMhwSA1dJuFIqYwSL3oylHkHW6BROpSediUvy8cyycVHUnfAWsHjZQiElarHBTRlruUh9yo7gafcywVUQYznibI2hN1lPO9PFwy3VvySEDNQL+Ey/oBfRUBgvqmdzw1BGHtzX/p+d7kpU51DIX0rrsvP7E4cnKljiRt+szXsLDstqdfmzcUh5cMarHcjvlzywRoH2GOJuidIf88qw8nb55uDv5fK9eVqk5nXtmPqsNl6APeQosrtXL8DhOKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34SaKBO8OIgvatMNnolEBX4W5FSr2id9kZsI7FyTqys=;
 b=ZPUy55Xwr8KTCW1iLqcFf1CG4O7vz9zZ/LVtdwAmUY+H+GTxv/1wNke3zRvkpY7sxlfWiytnPN5kgHETEgr8wi1lLdNonhcsrsk3O4yW4PfJd2tfcAAqCnk1ejtgDz5CdE2NVc1vv0tGtHEJD5Ri33QHufiGtLEuZQI8fF5HXzZLjDaB6R+oOZSBxB2GVqCvEJoABOBwVwjfZlaD/WIYJ9VMpwHFAaD7IuVDQd313x81Z08RtWAkhT0+Z4nvLxPnlqsAYWg8tw4Jym5lJd2DdCdCItoqWhaivYCtUzKH1c5xuSk68lUfFT6mt7lhMg5Izj5thnJlF9TgDJGnaoqeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34SaKBO8OIgvatMNnolEBX4W5FSr2id9kZsI7FyTqys=;
 b=fQikDrRd6XiLN8CsN7EiPssmZbnrfoyf6XwhpNlkxKxA8ksYhmtdnG83YPXb+Cq0hiZb1sck/nXvEzeEffkwWCFB9GGTGTaqQfdc27KUZYgZpleMjXtptMo33HVjX1arZlMBEvX5z4/T4TXqwFgEffy91+ax8bTUPYOXVDQLR38VEV5QJsyWVF45bC449AgAH7+R66eAGZNc7TRZFBesf7VUsdXc+b5vSYl8gNCc249gmTaMQCsDVKzq/6QGfpDkn7ZUBSvtnpI9MIwL5WwL6Lm+4mLb66UZwBl8oNrHwAQWazgF6ZH0wqUhWpUS9d31r4wrgiJmmej9tVsDxnqNnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS4PR08MB7532.eurprd08.prod.outlook.com (2603:10a6:20b:4fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 11:05:24 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 11:05:23 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@openvz.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH 4/4] netfilter: bridge: replace physindev with physinif in nf_bridge_info
Date: Wed, 10 Jan 2024 19:00:14 +0800
Message-ID: <20240110110451.5473-5-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110110451.5473-1-ptikhomirov@virtuozzo.com>
References: <20240110110451.5473-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU1PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:802:19::29) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS4PR08MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b2cbca-5443-4bb7-3193-08dc11cc0b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2DoP/lVTTg00MsOIF6OSyiHhYpbVWe5TiVSYFIjnlPtl/AOoieGap9Jay8RkE+Vn4dIm8DQDOZuLgOK8CV+dBusvbIkfP3+/ejlp07NkZWfrncagAMLJ2vDw4X+2C3u88+FKWs/2vv2JRb1ONaKstMnM3Xg8J+IBST+RZbLQYhuW+qWMc84yQCOMF8cYwUHYAvGSbqeOK8JqSyjvlOD9TilS+2mIX0nG12GtF7J1gGRrNzei80n1jhoKrCAjdUgPPyhPY7leRIb3Az2aiFuH7FnK4/8QLlBhFQjCu0Z4jCDH2wBdfcSNnbASv/ArNEVywkGCdj+gzTKo9Op+YOa4s0g/gPadaKCmIuZ1uwvEM+FXGj4dtYrZNmXHmtR83nx+Zwy8AMwKasnXwQNbY5GfurKy6fjAE/uWIp8X56bxbSKhrl47woRppBaoNKbouP/weAfXa8Fq+qN6ZLXwbhVHv55Ns0kGbay3/pqM/7aSa4gGUmFIkQsYiSeDWLOKvhdLU6yZUcWoqKEx6SiCrWXf2q+OXioKLow9Q0VsXDBm3QA8OPTcFUJMqSm6SlHO9L7d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39850400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(41300700001)(86362001)(36756003)(38100700002)(1076003)(2616005)(107886003)(6512007)(6506007)(5660300002)(6486002)(2906002)(66946007)(66556008)(66476007)(316002)(478600001)(52116002)(110136005)(8936002)(4326008)(8676002)(30864003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qkrc64uKJu2w+WqKAqtP8EVTn96ALJJpU/cpHGeusMPRkCJtres1YDhCq+ez?=
 =?us-ascii?Q?yfeoeztYRchoJt/5uhG0CDDsM75ngmgpQjE/GhqzkW+rFP5DPuHTQJbNXhMQ?=
 =?us-ascii?Q?k0qvdalhysQC6Y/jbrhC0GvJXTRq17s9DMJFtXkWF4c/kF/8555CAXfCMxn+?=
 =?us-ascii?Q?3mWPAQ7M9f35phK0fPHrNf1+eJtIzMfhokrgGUR0Hh87UrQIUiU+o2Emhwqt?=
 =?us-ascii?Q?VJwLnTF/zeyZCe20ZUzjQQpuGeYzpRut1tEvAcFl+VOa7B5NN/f1Lvt7gIqf?=
 =?us-ascii?Q?VSr7PBTaOaKzqZ+UvJly83Z9BoEFUbS+SgKCkX0ITnMZkC3ose+hQ2zLs5zG?=
 =?us-ascii?Q?jl+3m6Hik3+umuKsAYnVjZvV1K7OvXBHvmF/EPZoxXgKgGZ3kLP+q8Ejdc6G?=
 =?us-ascii?Q?R3cQ8EUiZuOYnHA6wOgJP/1uEEtwXkYXIA6E4AGJppgsXL0N5x79Z5oOrp90?=
 =?us-ascii?Q?09Vz25HsmmuUUXTs8wkRKQ0ycCuO5KyIXo5NCrL2cgJVWa1PzEbqubc2TVkN?=
 =?us-ascii?Q?sEECdJ0ORv0jo04Cndl1rKqzHz8DmFQ1oQbvd6O1lKXcZrKnV/4RwMFFsFp4?=
 =?us-ascii?Q?HgSzzZaAgdWQoNwuSToJPSmpQHfbyVyj4PbSHVYdxxuC/kjbw5I6v8VV31Fc?=
 =?us-ascii?Q?SagvcsuYju561O3PkoRUOif7qey8tplaNzp3Y5YX0DAIPuGAUy/TuPbKOmSP?=
 =?us-ascii?Q?VdijzgU13q93TLurigsqgeF81DbtXkSWhNZ20jJ8ZSYTMplTukjqlK8FloW0?=
 =?us-ascii?Q?DldndMEm2wW8zuHqKwoZZ1Mej09EZopBzo3crq824g06CnsbQiQE1IXp2ZdG?=
 =?us-ascii?Q?loo1qlghl1Cq6ycw/mMPmSoHGF5YfdZTo/UXVIhahjFuP8pNvphCzRF15gsO?=
 =?us-ascii?Q?0gsJ9Cf49qv/pRpw9I2+Tw2uBbQ3wUw63UadkGSoSwa9WP/9/7HMCg/USz3d?=
 =?us-ascii?Q?jQ2ExGfmek8Ag4HeDD8/y2hLpDIvnTNPVB8WMYjBAfcUCOGUeKSkz2xwFiYT?=
 =?us-ascii?Q?cR33ogM4CMPCX5cGZRucUFHxxg2SRs7h/Pb8+rLBbXPcibsQNBItdfmXp3Zo?=
 =?us-ascii?Q?BrvRofciFWdGGqUTM8DRcbsIqk6YTtKz6IQwEPCF36Eq8ZzkJw1TguQ3Bflf?=
 =?us-ascii?Q?vEPata3e/QY5v9Gu5Uzfv+PSMPggX7eZ//Y98M1u74nan0iCtv957mha/TF7?=
 =?us-ascii?Q?RsrIRILGt8ruLACWrli3/1uxh+cvXQ9kUN0WgekdT2lueMlkRqJzUchPVyg4?=
 =?us-ascii?Q?/qJHnBq2RFdVsY9QCdUljSUB8B+1xyHwpAXdCwmmuk8xAB60ewPrcA/Nlvk9?=
 =?us-ascii?Q?Co25+yg1vODyI49HG/mfaKa+wde9LIpId1SyVPqqUBmpUoUqzaDdntfa6HHD?=
 =?us-ascii?Q?+iBw+WcWuLXyeTW6aEJUZJCfXH73AJBePvlP/vXA/UjkX8WssepSD0fvYy82?=
 =?us-ascii?Q?KRJ98qWrYO3XSmSl4RReSMKqGSpoqk74WAOGargJQLON6cj2Ta1eVue3Nb97?=
 =?us-ascii?Q?LazimSufqHQxIuETcbj/aSVB1tGFMaFEt1XjzkQAwHcjUHSJFAQqihbXJ070?=
 =?us-ascii?Q?NyjekOYzkw3E44cEVktMPFKWUojBv+MxJDA1V0I2DPu3qEbX/W4VKx7w33ea?=
 =?us-ascii?Q?Il+95T30i/hixNHf50yKLK5THsE8/ES7+3ypv7tl9nsIhJPivSEfARANsekC?=
 =?us-ascii?Q?n66/Yw=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b2cbca-5443-4bb7-3193-08dc11cc0b26
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:05:23.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXtKvBAF/nrfjjBNkS6bzq7kjAC3KW95n97k1lbgFEOcx+4mi+Hdqb3mrcQbukXcXqDLJxKkqMQYmkdO9zRdFMjTabEs1GnwdKEBvlnlR08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7532

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


