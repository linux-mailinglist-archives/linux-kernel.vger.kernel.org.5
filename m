Return-Path: <linux-kernel+bounces-22040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE529829851
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660FC2894BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998C47F75;
	Wed, 10 Jan 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rDyCniIK"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2112.outbound.protection.outlook.com [40.107.104.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C447A76;
	Wed, 10 Jan 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be7pupxgcGNEAi00MdqSVhjCic+e6Lnn6Acc338mCs0pR4/K/DOPLxvTbiWL6TyODP9eTbva2Qzk9Qt1t6yp1OimsyF6ttkTpSfoZDW2GX6fjOHwfw9Yyx71aOB39i541rkZ96KBkCkrGy2wZipbfcrdHSFyCYKKR6FcmI3/1aMx1hJep/t1pkLV3O1fAj+Y0ubadHu37YF43q5pTNbuRCnkVmQXVSXI1N3Fh/L0SrYenDHCCv0jscXQMwP9CsZaCRWbxZGh602cdcLEkVr/y283ukct3f+LYolzdxhZoqJlUtzhf0m5SU1THEKRxqgK27Z9Miv9A4DIcZ+9B6JKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe3cO7GjcJxW3na/CdSgUBO8HWJMSJUYmkXZwOyIE30=;
 b=bQY/bIPmUTUksQpN2YyOk4Rtt4bYoL6K+M8uTTVs+0TIZrGBloHAvRlql8z9NqiU70dWszwUPmUIzhVehTRlVH/EC/eKP4T8UlwV+RREejBXiC7xmJK9SRqkh1L3ICxA08+60LKz5jsAXm7AxMDIhKfie4WB6OsakOaTeYvVegafwn8H5cYeamAFTJpUOew71tcBQaeKdv3e5YiDKFKaxinn0opN3bMs4nSuGkszs6aCdMbMUD2csrfg6HR8973J4EzWLbWdabflRWfu/YWmQdPy+GjNaDI9iqwGgDbxCvOuhMy0yzfoRD5QWPRdJiaIv9lfXSQperdr1cEC+4gCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe3cO7GjcJxW3na/CdSgUBO8HWJMSJUYmkXZwOyIE30=;
 b=rDyCniIKsf0UWsyXFIbPg3Utmf1d93bZhtXP3Y9kf5HBsdl4MtUmoUFNTgthLXCAExQhpeCnPGklToe79aA66H9D2/C1p8Y+MwX1U6HPrT3dh20IWzULOZv5u7lp7IeJ9wphLFYQyroHAq+M7OgRHjt6dEelqTQD0t2sWinO7aeQOc5Y/ybBmTcZvn0sO2eUDJLnBIPM5gdeFxoTOwL+/COzRp+x2QRQgw+mPueGk42wiiQKnwv/ST1yCIeafTQ9BalR8zYrqE0xxY+3WT/pk+LMT+D1QRnis+ar8Eytt3BraTuu0xxPAyYNA9/clFumlaA5mpGl/csKyJZnJ6//HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS8PR08MB5990.eurprd08.prod.outlook.com (2603:10a6:20b:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:05:21 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 11:05:21 +0000
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
Subject: [PATCH 3/4] netfilter: propagate net to nf_bridge_get_physindev
Date: Wed, 10 Jan 2024 19:00:13 +0800
Message-ID: <20240110110451.5473-4-ptikhomirov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS8PR08MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ebc161-e4d6-4e7e-1cb0-08dc11cc098c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dJLwRJLDN8ctTpmdIpbRlofhVwbWHE/O0fgHQrJPUT3en0gOgGNuGZkJ4ROaM3cYh8kKwpWXYkuYkAuCDylhx+Gd21RR/eresVGWXu1NRv5bXXVQeIT9XcGfrqjjRHkBICnTuv+6ddnTS/P45yXubKTEvZ1j8v4uMFKr0Z/5C0vUSR+ss7+ztduFToC9gj0OynA36DjsJ5aL5NDJ69z5DzlrP0wP+bKlP14qTstCuzrqL7iM77z8DNHVyosKXt8U/tmVfVGlm84jkJfKH5CikH/tOZX2NZPjL4JjskR/94+Kw6sfyPu8heO4F51yg6mWwvp9ajq559re4bZx/wDrBo0LqoZ2ITfaH4LXw/nIwgmGzstp1lMkRVRDj1nn7cZ/DJTGRRJ6JnVsmv9ZgxdZOYXtTX/V48Y3fo5kowaYFgJIYjaNRyJhRYBjpS8WlEI7MyUsEPEIztnZFEy/Y0d7RPHYYtJvYOeXfRbm17eDGI+wOokIf8J5z0jd3i+br2RFvgndi25FRnLLixkdwwwCa3dJZsK66jw+0kDDAXuDqClG/4prI8WcUYsDCsnBRGSO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39850400004)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(1076003)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(4326008)(6666004)(52116002)(6506007)(2616005)(107886003)(8676002)(316002)(110136005)(8936002)(66946007)(66556008)(66476007)(41300700001)(2906002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C2Thc/jgWhBdAO8rTszOQMOa56aurQOvLLJsEYC+3+L5LkqmTJ1k6ys0vKZD?=
 =?us-ascii?Q?It243KrM37l4iHVT1ieDkcFwgRoe/lpkD2F4TFfClo2mWEVZpN4bdK6pl4Bs?=
 =?us-ascii?Q?efcGxFMLvwjkNWkdXaJsNVjiLUpcfvBQzTD82qoA5P1P2AJ+PGrhF0YVLvzk?=
 =?us-ascii?Q?9iZrevVTgVeZ+1541nGUbY1mw/dS28VS//va0DK7/yKXUmxDI3alCBd1QwH4?=
 =?us-ascii?Q?Fo85tN4EApAIG1lMb2b8sO3kwUJtN+26vSvfIdREyqVeMz4n3ttcYI9tPliF?=
 =?us-ascii?Q?i0EpxxwoxeMaS1PzcqmRjWNjwbDcPUXFqF/S4gldwnRnTV7ZNdhbfIlkBiQp?=
 =?us-ascii?Q?zNP0s6eOekwYqGHSTcyoDty42UuSatJl/GXAAYqTG8ZTRYkSAZU5GeuotOZy?=
 =?us-ascii?Q?MPeJm9OOmv5o4xdRVYi0aLMTAGw0NCLB+41vB4lvbodqD/Hz4dECkKMkBcwY?=
 =?us-ascii?Q?5fyX5LMRp00Av4FahBPE508rXqFKalC2c8mojmGAN8ylBThuLbbi5IMzjA3v?=
 =?us-ascii?Q?dnwSsXAEPMJHmzKtDyBDGqAF52DjyFxcsvLMODyOFARW9XlF40fMbIStGZbf?=
 =?us-ascii?Q?/aZ/ytXwBJhKgn6Vkc8MxRwiAjM0QWn3/MZD+3n8ozsSRTc8U/68GKzhWOmX?=
 =?us-ascii?Q?6tnAEYzvlePUd8XDcbiTd6BosXW+3S+85XRNmCmZd1+3nRh4bK9gnNaq7VOe?=
 =?us-ascii?Q?/9Y4zkDrfg57cb3DRQBPwoLwKBetnfkGSkWQwjoY7fo2xsGZ+git5pC/MPZE?=
 =?us-ascii?Q?ZdV8NHdefU5FquaJko50srB0gLp2F8Fq9a96+QTTWzNWMNO6A61jWAlTl3/8?=
 =?us-ascii?Q?sGqLw2AwgD3GuQbcgQ+Qz5Uoi3wIZHtY0FCpnDF8E2iAZLwbngY1Zsyh1VOW?=
 =?us-ascii?Q?vCXcxuDf21U+B8rL/pZtzxgVdtVwUKIMBIg0J+YZQAmin2wtH39xXzVdb7JK?=
 =?us-ascii?Q?ebTnz8UZigzfhbQ7EquHHjdCCbIplTh3rgeU0GTr3a9MEsKxUY3OZ/YHWRkr?=
 =?us-ascii?Q?i4HtfErMd6m1P1JjqjAhfPdKdoSspdkNTTJeFw8T6PG9DcHzfKtFVGFfJUSP?=
 =?us-ascii?Q?u/G4DtDA8wXKUZ8qeSG5zuHn43udfvYxjJZ824wEDaF+BJhW18w9sO4mOGUw?=
 =?us-ascii?Q?7w9iOFYgfQheY01yE6uLYy8xzdRqEXoRI247brWZsnZLr9zsAj8x1WPL+Kv7?=
 =?us-ascii?Q?z/PhHC0prTwfXBYlbPJ66ekvKbpESM1fl+npqA4a+hV992uWd6T4IHbFEXeV?=
 =?us-ascii?Q?ys7M+bCW4Bs+LomiZEpLBEIioj4PldETY/KtbRK7OJgyApniEZ35JXLPo7Xk?=
 =?us-ascii?Q?s+PkBQh/mlGUPMYXmAtx2qUdgaP/zvokMRS1zmHNgtRa0hpQI9lxsbFbCoG6?=
 =?us-ascii?Q?A0M0Td8eVLZCF3xB5UT9t/0SnL+ihpVR/K9H+qTjIx4bwe62dZexRSMYGLE2?=
 =?us-ascii?Q?dDp57APKf7QbE3T05tFpn76tMBw/kyxJVJAtpk1/ffvke5/fC0aVgO6eqIru?=
 =?us-ascii?Q?1vCe6hZWZRceKzo1jIX55MR0iChFs1QFEaArxXV8jgIHrAYD3g0/9pbHoqzt?=
 =?us-ascii?Q?98TQm+5DfVxt5BJK3YadB3TLoV6ywQbYTsk4mv9yxarFj9+RLMA/JpNiX9Gy?=
 =?us-ascii?Q?EnyHk4WmDuENCui+WsYI6reaq4th9IY/ay82lN+oLswdWQ2EKUt9rRcmOK5m?=
 =?us-ascii?Q?GPZ/Nw=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ebc161-e4d6-4e7e-1cb0-08dc11cc098c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:05:21.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ailSpB743b9yviqeuPlki9OHjculBU/G/oA60jFI7ErZlE6nJZq3UvQN1rREYC1RyWkwVTzrz8V756ukOUgQfj2V9nzv1EWfak2n5dgp3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5990

This is a preparation patch for replacing physindev with physinif on
nf_bridge_info structure. We will use dev_get_by_index_rcu to resolve
device, when needed, and it requires net.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 include/linux/netfilter_bridge.h           |  2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c        |  2 +-
 net/ipv6/netfilter/nf_reject_ipv6.c        |  2 +-
 net/netfilter/ipset/ip_set_hash_netiface.c |  8 ++++----
 net/netfilter/nf_log_syslog.c              | 13 +++++++------
 net/netfilter/nf_queue.c                   |  2 +-
 net/netfilter/nfnetlink_log.c              |  5 +++--
 net/netfilter/xt_physdev.c                 |  2 +-
 8 files changed, 19 insertions(+), 17 deletions(-)

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
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 134e05d31061e..ad93dd77e6071 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -463,7 +463,8 @@ __build_packet_message(struct nfnl_log_net *log,
 			const struct net_device *outdev,
 			const char *prefix, unsigned int plen,
 			const struct nfnl_ct_hook *nfnl_ct,
-			struct nf_conn *ct, enum ip_conntrack_info ctinfo)
+			struct nf_conn *ct, enum ip_conntrack_info ctinfo,
+			struct net *net)
 {
 	struct nfulnl_msg_packet_hdr pmsg;
 	struct nlmsghdr *nlh;
@@ -804,7 +805,7 @@ nfulnl_log_packet(struct net *net,
 
 	__build_packet_message(log, inst, skb, data_len, pf,
 				hooknum, in, out, prefix, plen,
-				nfnl_ct, ct, ctinfo);
+				nfnl_ct, ct, ctinfo, net);
 
 	if (inst->qlen >= qthreshold)
 		__nfulnl_flush(inst);
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


