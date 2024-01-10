Return-Path: <linux-kernel+bounces-22341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4C5829C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F85B28484
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68DE4B5BF;
	Wed, 10 Jan 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tNtNSxPv"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2111.outbound.protection.outlook.com [40.107.7.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6A4B5AF;
	Wed, 10 Jan 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiP4er+fG9fp5LcTreIdh+WyFTaEmqnnflZRqVIdPnfgLl9f2Hv7htV0wIs2DnzP/H/jN/w+fRw80DnXYVnZB5viADKqvn1I35Dg5TMJFVCh9nTix1Aazne9UsECNXWnEHh8O68PklC8A1/xig/lrStM+Fe2hgwzEkGqgd4tf03N7SnogoQg87x4cf8WgmL2Np4j0WHVkHxmTyQUT6ya0Q832Aj0uX1I+uU3DhWwLLN+ktTrxqNNIfRJQPGG/wS5Vv6YIJIVkkLOIrLGZdi0l4R8U9D3GyI8/SzvXIg/z6QRGjA9pUQ7DuVcXLZqbs98tWZWJIYjQoFKGnThvsF4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4NwxlJedQ0ViagwLWRxjwGMdLz7Ows/lbaapIOMz74=;
 b=k1OI13qupHppDtMkMOtLOkJSYOS3DRtvZwm4X1kfmGPoo/Imytu3D0mdmG194xXKdD2c1FF/zIC/uwhPovOR0IzrdUGzZtGefMNVb8Wkf6871Eqnzd8x0rGsT2qrsEW0WCOGURsnouDzOMoZ+jP4BlamBj9n7e2KR61Ut3j09RY5jftPjBQz3XoAAlreepD2cdZ6lQADcDX/0xI3zHiiNh2KDhaVKBF+7MHCjps1yPOCHofpg7puI0ry3pmAS2MckMfGO1syKFC1vs05ZjW2b99FZnZX8vOZAkbIsAQts0Ks591OftAYwi29aLmt4xIkX0gab6WT6xqigsz2afc9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4NwxlJedQ0ViagwLWRxjwGMdLz7Ows/lbaapIOMz74=;
 b=tNtNSxPvaNorSzYqWJuONDx0nk4av35ZUhcxcKKVGCIA3RLPR54Nk1Wx0jbwS9UNoJa8th1FxiO8J6GrbPnOvwlIClzSieDIi06CSNArFrNH9quBvBRYx3L0KwihbNYYBojx5QA/srudCUkxmCfJ9dxDa/QKH6F0IPxMc7P4xJYTWxdXlbQ1SiaiDMQclnNOFl4wQUfk6eCHarUp+/PX9cyYhg7plmdVBNF6AtUbkx2DzNBpGSkySs5KEu+bFDvMfSuioQp/MIL/penjwfSPZ5gTw3bpTpuhclDx9izVdTTNKj+36tIo3czdRzaDYoFRjFYdLuzmsua2j/F8LRIHPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by GV2PR08MB8680.eurprd08.prod.outlook.com (2603:10a6:150:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 14:15:11 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 14:15:11 +0000
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
Subject: [PATCH v2 3/4] netfilter: propagate net to nf_bridge_get_physindev
Date: Wed, 10 Jan 2024 22:14:24 +0800
Message-ID: <20240110141457.17205-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110110451.5473-4-ptikhomirov@virtuozzo.com>
References: <20240110110451.5473-4-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0051.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::23) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|GV2PR08MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af2b745-d758-48f1-525c-08dc11e68e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yox5mENy8wsVcQCE+CJE/9k0pdaMcRM2xU8ihwMTPmlggAk5IZixxoHDtLrbTo77MyZ2PZ3FXGiyg7evdXny+ZoFGPJc0+cyg4Ro+3xY/C2h/zHhM45mMVD4dyaxtK/HMssq+XUmUhLicNhXt9bja7xVaujfc853QWUFew/gy4ITVpllcwHPCZUZKRZksKFo6Du/LNJeSc9UezWNe0KVk+7nu25OBWQ306sAC21eYHpccWYHvO/b/EM/azRGFtFdcdl1sZ+TQyr7c31ajolZtiSzHNPKo/8mR5T5UBloWWGV5U2uXpk8NxXPrQxlHgRF+sdxKexn9BCHjZ2nR5I2fGODK/XP5aIJkT+eZNZBAmOZk0zDlLiEuE10bj2V9GyMvQGUI+DeRtP0cF6xObGSrfvq/fa3+YCqgE5cvMWVJB+9oDUVlHR4mf7Dt+HBOTg2kv5weMIXbIQTtzmk0hd4LMAXISpavPuILlmCHhPIgYQna2DAM/g9vzJEt7moVpbCjEkxz0y5nxFpiTQzOstGi96FwyQgYXphvTjOKJGn1403IrNK7Gdz1vmJuGOa+Ql3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39850400004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(107886003)(2616005)(1076003)(66556008)(66476007)(6486002)(66946007)(41300700001)(52116002)(86362001)(36756003)(5660300002)(4326008)(83380400001)(110136005)(6512007)(6666004)(478600001)(6506007)(316002)(8936002)(8676002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sU+Zk56614ReLfnHmzBGO/23qvilrzPPvIcY3whH6K+LZcxsjM4xuOgF6gj?=
 =?us-ascii?Q?nCT42gsH+7ODSqUAeD4S43hmuKjpMS4V9cAFqQbsF/cUs7S0zf3zjC8bVNBN?=
 =?us-ascii?Q?Uhf6IjMr4Y43HjFYxJSFh+v1WSSeFkffITTxckh/UDf111dFFqqhqMFUL1J4?=
 =?us-ascii?Q?WG4UyaE/g7W3rBgUMVMtwnGCTgAoOHhzsJM5JvY46QxvaEqGm6QdxbNXEwcg?=
 =?us-ascii?Q?XMKaSFsYfuSd4ueUhE9AQeAU1Tcunm/hWDp0Qg55UXhElVfpylXUn1HoC+PJ?=
 =?us-ascii?Q?KXYbaMUlO627xJQWY3rdBSXT/Qp6uAE46pws4fMMxdbGwp/3Alq/+B2X1gfX?=
 =?us-ascii?Q?1N02rly0odEuyvCTdv+icYhMIjlTdF7Fil9xY9m2QU02PxSTUZ5oD7A2fupQ?=
 =?us-ascii?Q?flMqnv6wg21dZyTyj4gbTxnJ8Pb9LzfP08G7u/oNEgPSKFZP+d6S8yvGngj7?=
 =?us-ascii?Q?zTi7pcxd2h+Ey/uszoCMj92d8bU5iFRJ0sF+bfpxywCgH74rYz2zw8S8M49A?=
 =?us-ascii?Q?1xON00jNqdERS13LdllZynVC4GMUczvHveXBU9CvvYLXKaAB5j2TSaQX5Uu4?=
 =?us-ascii?Q?cVTAChVyLqwmJy9Pa5PZpNF46kSp05P0+gZpNCbj/aOAmv4DKDNEXypyJz0m?=
 =?us-ascii?Q?PbJxCGDDEwIytQTBRn8QZc0uTZFXdsCE++6fkNr+gPBTDCIAMZsIe51BtJuR?=
 =?us-ascii?Q?Xv7cuIvgDUnGLYImJhRpsIis0iAYGl9r23fI0DOVOO61D2kYKptBWY/cCdX1?=
 =?us-ascii?Q?smQe+rLx1fn4aeUF7aKiqR2CmJUM17t6asnpPmAOAvf2ZxlD9FbfeKbrFau7?=
 =?us-ascii?Q?N1fiYe3usimMnHdqNbfY8HHM5hIhXRmjibAcGW3DTRHk4KWzUR+cFZ5Sg0P7?=
 =?us-ascii?Q?K7u4kMBYGOJH2oUQQbUbmDicqoHc5RoMV81RnXMj+aT9gwTMoQYGmypFer87?=
 =?us-ascii?Q?9LtPw4qyp4Pv7d6Mo5LeECBHxRQG3i+BfyVp91EyzLY+lFPmHdCr554SEz9Y?=
 =?us-ascii?Q?T3a8lKn4OxSe/4F3Smosv4+SiPltwWddj3M8H3Ym2yckNIhX86mOCkUlniMu?=
 =?us-ascii?Q?dacACdN6dAF1R2wkZWqwG2UhwHmuIfZwFeVCG/CUoVh4IAqujZNxU8oBNePi?=
 =?us-ascii?Q?0ikZwvbe0Mv3GyhVfvvLgZzXi7GjX9GAMgqzixZlttKf93Z67Sd3m5EkUuFa?=
 =?us-ascii?Q?VMJmZ5lNP/Q9qI+fVrpoiWjYOvyuzrXJnI6QhjEAhPu4K3RIG83xOPV9t46U?=
 =?us-ascii?Q?TOVaHyOHqHDn0acsvJkHnr+czxOR68XGhwC7eAyhLaBshB/zeh68Bp+//Xup?=
 =?us-ascii?Q?OM1jpj0Rm8iiBjt+zWeOJ9lNWdwe0iWOHhhhV3wObqb7fcnaobzrMa68ie3D?=
 =?us-ascii?Q?0ov/UB4RjwzKsC9ukVy7NHf6v1YLWU4MFnF3FUkYtWa06IhZ7QPHRhffbIsY?=
 =?us-ascii?Q?TO6112kVMSSrD19XG9nGewPJo0QkZfQjp+1ZQI8dZQwsusV+FGEkSIPX6hPI?=
 =?us-ascii?Q?em5Eqbwn+2geLnXsc63fPVFn+SKliqtBnzFXbP8zMPDNyA7TR5d4tavoY1Ua?=
 =?us-ascii?Q?cOD3vuAfub/2oePuSed2w8ou0Kgf5dGcPbkELe/CasyIKWHMTiEH5rwxmPAB?=
 =?us-ascii?Q?c3lYr6QICEJ+yff9YQK9HwV0gmhnNvJAJwN4zQh9IfE3QvaVbpU4LSJl/gZn?=
 =?us-ascii?Q?B07LHQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af2b745-d758-48f1-525c-08dc11e68e6c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:15:11.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmQViXR9pioJRuf/uxpAMZn/0fVWXRGaBqdaCzBWwgiGxCcCiyCerR76e01fzpJrTc5K7E/6kWz8duQi+n4srnBlj4i9hs2UKwU19APOi9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8680

This is a preparation patch for replacing physindev with physinif on
nf_bridge_info structure. We will use dev_get_by_index_rcu to resolve
device, when needed, and it requires net to be available.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
v2: remove leftover net propagation to __build_packet_message
---
 include/linux/netfilter_bridge.h           |  2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c        |  2 +-
 net/ipv6/netfilter/nf_reject_ipv6.c        |  2 +-
 net/netfilter/ipset/ip_set_hash_netiface.c |  8 ++++----
 net/netfilter/nf_log_syslog.c              | 13 +++++++------
 net/netfilter/nf_queue.c                   |  2 +-
 net/netfilter/xt_physdev.c                 |  2 +-
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/netfilter_bridge.h b/include/linux/netfilter_bridge.h
index f980edfdd2783..e927b9a15a556 100644
--- a/include/linux/netfilter_bridge.h
+++ b/include/linux/netfilter_bridge.h
@@ -56,7 +56,7 @@ static inline int nf_bridge_get_physoutif(const struct sk_buff *skb)
 }
 
 static inline struct net_device *
-nf_bridge_get_physindev(const struct sk_buff *skb)
+nf_bridge_get_physindev(const struct sk_buff *skb, struct net *net)
 {
 	const struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index f01b038fc1cda..86e7d390671af 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -289,7 +289,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	 * build the eth header using the original destination's MAC as the
 	 * source, and send the RST packet directly.
 	 */
-	br_indev = nf_bridge_get_physindev(oldskb);
+	br_indev = nf_bridge_get_physindev(oldskb, net);
 	if (br_indev) {
 		struct ethhdr *oeth = eth_hdr(oldskb);
 
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index d45bc54b7ea55..27b2164f4c439 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -354,7 +354,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	 * build the eth header using the original destination's MAC as the
 	 * source, and send the RST packet directly.
 	 */
-	br_indev = nf_bridge_get_physindev(oldskb);
+	br_indev = nf_bridge_get_physindev(oldskb, net);
 	if (br_indev) {
 		struct ethhdr *oeth = eth_hdr(oldskb);
 
diff --git a/net/netfilter/ipset/ip_set_hash_netiface.c b/net/netfilter/ipset/ip_set_hash_netiface.c
index 95aeb31c60e0d..30a655e5c4fdc 100644
--- a/net/netfilter/ipset/ip_set_hash_netiface.c
+++ b/net/netfilter/ipset/ip_set_hash_netiface.c
@@ -138,9 +138,9 @@ hash_netiface4_data_next(struct hash_netiface4_elem *next,
 #include "ip_set_hash_gen.h"
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-static const char *get_physindev_name(const struct sk_buff *skb)
+static const char *get_physindev_name(const struct sk_buff *skb, struct net *net)
 {
-	struct net_device *dev = nf_bridge_get_physindev(skb);
+	struct net_device *dev = nf_bridge_get_physindev(skb, net);
 
 	return dev ? dev->name : NULL;
 }
@@ -177,7 +177,7 @@ hash_netiface4_kadt(struct ip_set *set, const struct sk_buff *skb,
 
 	if (opt->cmdflags & IPSET_FLAG_PHYSDEV) {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-		const char *eiface = SRCDIR ? get_physindev_name(skb) :
+		const char *eiface = SRCDIR ? get_physindev_name(skb, xt_net(par)) :
 					      get_physoutdev_name(skb);
 
 		if (!eiface)
@@ -395,7 +395,7 @@ hash_netiface6_kadt(struct ip_set *set, const struct sk_buff *skb,
 
 	if (opt->cmdflags & IPSET_FLAG_PHYSDEV) {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-		const char *eiface = SRCDIR ? get_physindev_name(skb) :
+		const char *eiface = SRCDIR ? get_physindev_name(skb, xt_net(par)) :
 					      get_physoutdev_name(skb);
 
 		if (!eiface)
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index c66689ad2b491..58402226045e8 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -111,7 +111,8 @@ nf_log_dump_packet_common(struct nf_log_buf *m, u8 pf,
 			  unsigned int hooknum, const struct sk_buff *skb,
 			  const struct net_device *in,
 			  const struct net_device *out,
-			  const struct nf_loginfo *loginfo, const char *prefix)
+			  const struct nf_loginfo *loginfo, const char *prefix,
+			  struct net *net)
 {
 	const struct net_device *physoutdev __maybe_unused;
 	const struct net_device *physindev __maybe_unused;
@@ -121,7 +122,7 @@ nf_log_dump_packet_common(struct nf_log_buf *m, u8 pf,
 			in ? in->name : "",
 			out ? out->name : "");
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-	physindev = nf_bridge_get_physindev(skb);
+	physindev = nf_bridge_get_physindev(skb, net);
 	if (physindev && in != physindev)
 		nf_log_buf_add(m, "PHYSIN=%s ", physindev->name);
 	physoutdev = nf_bridge_get_physoutdev(skb);
@@ -148,7 +149,7 @@ static void nf_log_arp_packet(struct net *net, u_int8_t pf,
 		loginfo = &default_loginfo;
 
 	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out, loginfo,
-				  prefix);
+				  prefix, net);
 	dump_arp_packet(m, loginfo, skb, skb_network_offset(skb));
 
 	nf_log_buf_close(m);
@@ -845,7 +846,7 @@ static void nf_log_ip_packet(struct net *net, u_int8_t pf,
 		loginfo = &default_loginfo;
 
 	nf_log_dump_packet_common(m, pf, hooknum, skb, in,
-				  out, loginfo, prefix);
+				  out, loginfo, prefix, net);
 
 	if (in)
 		dump_mac_header(m, loginfo, skb);
@@ -880,7 +881,7 @@ static void nf_log_ip6_packet(struct net *net, u_int8_t pf,
 		loginfo = &default_loginfo;
 
 	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out,
-				  loginfo, prefix);
+				  loginfo, prefix, net);
 
 	if (in)
 		dump_mac_header(m, loginfo, skb);
@@ -916,7 +917,7 @@ static void nf_log_unknown_packet(struct net *net, u_int8_t pf,
 		loginfo = &default_loginfo;
 
 	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out, loginfo,
-				  prefix);
+				  prefix, net);
 
 	dump_mac_header(m, loginfo, skb);
 
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 3dfcb3ac5cb44..e2f334f70281f 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -84,7 +84,7 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 	const struct sk_buff *skb = entry->skb;
 
 	if (nf_bridge_info_exists(skb)) {
-		entry->physin = nf_bridge_get_physindev(skb);
+		entry->physin = nf_bridge_get_physindev(skb, entry->state.net);
 		entry->physout = nf_bridge_get_physoutdev(skb);
 	} else {
 		entry->physin = NULL;
diff --git a/net/netfilter/xt_physdev.c b/net/netfilter/xt_physdev.c
index ec6ed6fda96c5..343e65f377d44 100644
--- a/net/netfilter/xt_physdev.c
+++ b/net/netfilter/xt_physdev.c
@@ -59,7 +59,7 @@ physdev_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	    (!!outdev ^ !(info->invert & XT_PHYSDEV_OP_BRIDGED)))
 		return false;
 
-	physdev = nf_bridge_get_physindev(skb);
+	physdev = nf_bridge_get_physindev(skb, xt_net(par));
 	indev = physdev ? physdev->name : NULL;
 
 	if ((info->bitmask & XT_PHYSDEV_OP_ISIN &&
-- 
2.43.0


