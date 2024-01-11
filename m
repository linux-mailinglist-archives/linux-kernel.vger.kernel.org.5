Return-Path: <linux-kernel+bounces-23766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAC82B168
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCF1C24003
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD95027F;
	Thu, 11 Jan 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BaiRlxNE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2121.outbound.protection.outlook.com [40.107.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43F4D5AA;
	Thu, 11 Jan 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C36QW/jkvADCjhdnbQUom+2l5fRGnU4t8GM/mcNP0O7jFFcmhXIYNeXPq3H7uoPNc8WRAqXLVqFpZB5r7lu36gmDaq5BOWBsn4uQgRYCSOh3+7OYPHa5pcGm8FJV6sUUN+4Z7iw71WmmcgfJ/SGHFyzFSh1jGqxTeUuyqDkXr/01uB9oYpMr0CLLY2OCzLi5xcKF8JFQ8qsw7l919meUUTF6Kvwn3G/h7LMOmMXCPreNc5O9oSgKSrNoZ2IWNDnM3yOdBMpJDpAm1YHKAvbczVa8o2QWlgZUReSRAgpJ707IXhEeopdWwhy1uGIdq0zQ5uKHNgoQ2r0e0+2NQ55LMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4NwxlJedQ0ViagwLWRxjwGMdLz7Ows/lbaapIOMz74=;
 b=gcspO0lNuWYmLGaWng9h85nX3zuD6rF1s+M1MxPIMz5J6LWb5/UTfZipcigdu7ZWlnCvIz5TNk9Odt8KsxNrrdOoe/1KIUab4Zaw6afjcP4+E+4Xs44QZtfX9DFyvv91yu4oZCiE6v/tDQ5rY614TiixJRm/kzVANVWC6ArjQP6+xfIjucUQ7ZTa8z/lE9VfQncrd8HuQep6/OTni8rBIr+G+ss1PnA21oAl4WQzaB3h+uJgbRP698JtPVXAQc5MoqXwFR02cwDfaaZsZ2D2ZhAeHHWSKA8PCAh8u88ZGeDTfHMiNQ7coSHIYmB8zpDD7TZvSEEe9qiTISTn8vLuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4NwxlJedQ0ViagwLWRxjwGMdLz7Ows/lbaapIOMz74=;
 b=BaiRlxNE18t+wAto8YTYQEq6TDyVpHF8RqKj+1x3IDv6phagh7JcAzTOghU3COXSGtCd/lj6WI1mfKeMcnvPFbbrcqhKMBDKEehNd/TtitJRC6xjPRxI4TvqXpIEaphat7uGsL27p3R1BnCDIVeO/w9yBStdJw0ntI6gLQoDpyEze7I5j40DfXWt7/hleNuqnIxsH9/CLFsJZCcrC6cgNN3bFP+U8qqZXRm7x6pAQt04fTdPR5Sgd14J8WE0BAaqR1YJzD8wJLUErpUP3EIADYIfHi8ijxghOwdRf9b22pSs4rxOuBlF/O+sppAFaAFVxMH7ZuljN9VY5uDnKahlxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DB4PR08MB9238.eurprd08.prod.outlook.com (2603:10a6:10:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 15:07:16 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 15:07:16 +0000
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
Subject: [PATCH v3 3/4] netfilter: propagate net to nf_bridge_get_physindev
Date: Thu, 11 Jan 2024 23:06:39 +0800
Message-ID: <20240111150645.85637-4-ptikhomirov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d654b1de-78da-4a58-21db-08dc12b6ff9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	byDxSmtw+1nxTcasxYV4oZmEgrgCZqAcDnQ1vV4VPHtz4lroWMZB2hjc0Shpx/qM5w5ZnnwQa5Iouo3SnVqftZgMYIp5NrYtvu9BBG0KEFULwO0kTo/ymnXbvOPckz/kGi2hew1tZuSWPht9yH+HXjSLVPl5Q48NdXnRxlF9VzCzBRy8DnqTB/j7kiGwx4r4fYTcZj2/BDJ5Hk5waEopkslPMhuY6zGUtIvPRHOuvcEVNZME6bIhEvl8fIAx2aHYGvfspnMQf3QBVVwpRQ+52JnALttvEOvRg1Ff59fcRp9OjDHxlS778KlH8+wGm7SJjUUzjzkzLKln0YFpQ9MCPJzGaNtz0qmyTpxisOldLJy1WiT2NdW5s/8ImFzrrXnvP77e2DG1bctwh9HgzEgfofAUkzILDyaNF7vwsFpxjSt43YE0YhWOjmzDiCoZG1AMlpmE8L2JURGqTZZLWCEylltlKksoicR8D+ik8Ai+55hZwWZnYkT3bzXmUEA7QzjLPdj0js+zF/5A+hkBH9NNccWXKeWTLsS0wRjFchpSgSgOAhcnwEEI6/oDM91ub2nLO2JgNAA17zmsUad1+IKeeU01u/3VnJmEsytYpLl8dKY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(36756003)(921011)(86362001)(66946007)(38100700002)(107886003)(316002)(2616005)(1076003)(6512007)(66556008)(478600001)(52116002)(2906002)(110136005)(4326008)(6486002)(6666004)(66476007)(6506007)(8676002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1GPtmgXcE9GmxZLxRQfE7xvTmk4USs1xT3O2xHzYBykmMORKhSkyHCOgRTTO?=
 =?us-ascii?Q?9QMkXqkrCoIw/PqwM2h29cmW5BDu7tdBhK9iubt/ITfbG1nsmKeFwgmaf3LN?=
 =?us-ascii?Q?tQKjIo8LhOhP+QPHW9kgY6Ba0rymb39E8eN1DYPmTtZNm6U6bSJPvxJOB2U7?=
 =?us-ascii?Q?5aoiuCxgz3Bj5D+qraJLmP0a/csjGOGhdJzSaLlBiUVhS71i331JPcSRbJsr?=
 =?us-ascii?Q?0LWpAq61NjmAI7uIOr8h3B+UwS0883MQVIrlDpFBxylFVCoKe+FGf/EkhxHi?=
 =?us-ascii?Q?jK6sJn4PLYQ3AG2XPPf4KmhCI7cvY2uNpJbxTZSFgJor3wGBHnCDaXfK5UpG?=
 =?us-ascii?Q?BWw3QGO+1w2qmhI2OIcopbKZF0tWfyrwUO79J1l626SSC4EfpqK3lQENyvpP?=
 =?us-ascii?Q?tvjhnraitRP+ohwNG2Lo4MAs+cFZau0YEWwSqx15ORwv1nYzykpUS+wZtePE?=
 =?us-ascii?Q?wkXbGMbV1zDuO0RTfa0XwUZV36DhB4bzb07oHzAa99zNdnJoablZDGJ5JKWW?=
 =?us-ascii?Q?pogJXXDt/AQ1jcUMNI5wXMLfXEwp0cfBJXjZKhYsKvMsU9p5KG+jEOJp1g8e?=
 =?us-ascii?Q?peZq1RwyIuEIfHv4spxdtP7YVay6Y3r29VT642MWK+6mX/uPAEPXYhoa4jOg?=
 =?us-ascii?Q?Yi26OYHn2mWcO741XvE3N01LZ1308YpHrUAgJLOkrh5Ro3nzq716N/YleICo?=
 =?us-ascii?Q?pJlj2I/7qpTe2mnRfOHiZ6JTADrHdqfCjuBmFMEEcALffhN0q9lxcyJ8LGkQ?=
 =?us-ascii?Q?xfqIwCa/xtkRGPXY9eFpybVdJ3J0kddO7dD4rwsph4vLj/+9tkZD2H8vCyli?=
 =?us-ascii?Q?LOPesPy6LuhwT1m8CtZFujRV2UQocDRekUQ8bUwyZriySVEcq4Cwor23Qb4Y?=
 =?us-ascii?Q?ryNMByjfAN/aABXS+M/8Z0l/yCJErJnZ5Z87F6oNL5FeyIvSTc2sGhf1L1HY?=
 =?us-ascii?Q?JSY87a+7hkdTozgXO8HqBtwnwEEVOUmfw22Er7nh0McYAGlE1vow8IrHUS6T?=
 =?us-ascii?Q?xYwg4oeXQGPOTSBoETvpTwWMa8nj+1X488pC71jW25b8Fny0UchBDl6/BWwj?=
 =?us-ascii?Q?KEnfOSo0iOVdpuuAxQ5UHMnvAukJhWmzTnNcxnHeCSmnH/PtFsRlPw8pCuUK?=
 =?us-ascii?Q?QboXKtNXKZFY3+hp/nAqPbe+A8rBkg8v8JplkK1bW/zLFWAxMIrydG1IkgSt?=
 =?us-ascii?Q?ZT5RWeAyEME/Ri0HQQxN3Sz2M+HQnlwbWkoaGdFgqUh36fBEJBavrM7apmyF?=
 =?us-ascii?Q?Fy7U//Pup3iyBt3K5DEJbLK1+PCVjvm6n9rSWuLyaDmxQt2liiCIS37z8ZTP?=
 =?us-ascii?Q?mJCdz8iNWhZ307ewbKa2guvVfaZkjPS04JFoSDd+jLZL5A2YdMbKihotiCtB?=
 =?us-ascii?Q?N/MTLrif0Aki2VoH8YrPyuP/r/SkeZ30vNAnsaq7ZRV7/1KyqXQw5/ycqOxW?=
 =?us-ascii?Q?An01vmtXgStNVBQc3Q4rSg3XYlaSiBVNffn8ibT1o1a9BWHw8DawHdjwNhXL?=
 =?us-ascii?Q?rIAFzCmbvsMqX8nJl+cLXkYTXv9Frioe+B5HZAym8+K43U72iiHBv4Pra+ib?=
 =?us-ascii?Q?4k6xPvcc8yaGcqPzibRB0N7U9XCgNKrMsW8NeCOcotUBa+oBx+Xl+rFRIJYo?=
 =?us-ascii?Q?JNPPk0pCQ2YmGN31YpGlO4VRpJnxerxKFd/jvbZLpN5WfzR5GPHi3YMyt/cF?=
 =?us-ascii?Q?+MZMQw=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d654b1de-78da-4a58-21db-08dc12b6ff9e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:07:16.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGbQmPG9s3k3FuSjp1VoPMNAxItCTcGS2YDOu62Yik37WRv6jgOzk7Fp9Lh3RG+EIXSmzkadXuujtrD7ZACt8nm/3Ffvjp00TaZEEret0N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9238

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


