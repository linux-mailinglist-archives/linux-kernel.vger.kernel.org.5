Return-Path: <linux-kernel+bounces-19215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC558269DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ADD1F22F66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CAA134B0;
	Mon,  8 Jan 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XcBGM1ib"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2109.outbound.protection.outlook.com [40.107.21.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349431118C;
	Mon,  8 Jan 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFW9C/0lYWu/PyKymGVg4v7gQXH0Q8y/S6kLqeE0gcyeZkb8Q1is816H/oepSlGcJoGkrEK0S0aPCSRHR+2HJWp81dJyVdNh5Nzf20j0+v1FEbrnCShXcqUUEZFdBBRRb2MEK+cgVPpI/CAkgCvFzmiLIVPgQlVQYjoN4EPgNRgmOVWgW8f8aTPKNGO6qbsd/SeZPDFDaPpTuoVhjNrnu1QX5Uto6tGgz9l+uu2ZFYzgYknXXnc4AEvURWSqsMRSp1YFETfOZF7I5atgONeHtsd3Q2YYIA36hyvhpF+GPKvHmqcrVH/+FVqQ2J7aJrn+cuzyQaRqJ9HelbR7hMLHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9RvazB+joIMSoYhQH1x9Y6GmKIVmQH5HwoMtw4Vt5I=;
 b=mWbGxozO8ZVYaFeiHAhfrfOHHUcWhYAdi91dhRWOsvWtLiL3Nt/1I/xOX4iIwovxl2Xi97vpaOh9jp37yXbOUzC0sshCdWq8yhgdj6SIYwBKPvgW3JTiGzhwC8fjUvhVa4F3kqqw7Jge698xE1X2+XIY6fUfZ+GXRlshTeJrAuLxPcFW56jqSnGILlV1OaUN27WKxRBhhjt7/RFcr2OQsBJbItGatwD5w0g2OSZP7b7vEmuM35Ti7+uwCxy/ZpafD2PAxyearodFHCe2fx122NXmQgrVehddvvCGVTo05Jb7xDeC1uSJyGk+BpTwKcQ/8yF6BDfYluX1enQFa47uDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9RvazB+joIMSoYhQH1x9Y6GmKIVmQH5HwoMtw4Vt5I=;
 b=XcBGM1ibXQrUIfl7AlCrKLP0X5ihOunYHlN+8lDgaDZ0jE9M0MxscH2zjEExkvJ5EvOwGqLc4kx6gf3TpxalbHY3s9ur0shbINqwoDJoBkQ/xUJc4eZSi+tD3peZfvC4pgT6mldEMN8E/caWgCi/7iIoEiIM4rcDCLFDiHGCmSRnGsY5mcSaJEqf9lMKOtoqaL1c60Ba1CMbR0mmSuRsDwwIr89yniyteEEzu5GEidZdUsKzZlJ7ICD5RO6cp3uVRYSxSwlvmjkgAhH/rkWxaaDfDuYKdsWrxCTCObvuO2U1k9YooFtLU9jK1NwtZQI2U9VlI8ueXnqHSwxcXZIxCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by GVXPR08MB7678.eurprd08.prod.outlook.com (2603:10a6:150:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 08:52:48 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:52:48 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@openvz.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Date: Mon,  8 Jan 2024 16:50:12 +0800
Message-ID: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::10) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|GVXPR08MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f3a349-4f93-49c6-6521-08dc10273035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RFWcrdycdERoTDaUfBHjZhFdV9V8fdRlaGd/HilaCObr9Z77+3s5C7D04mR8lKIGYSyKr9p0aKUZoKyLlRexNMtmn3vpRSkEXrFLO1zXNAhJXN669UC4CVUjJycUSS4w5lBpOMvR+WKJXDC35/Dv+oC+qjt20kbpsovD8h7s5lLZOfLLz+oS8L4LEMtlHXBzTlrNvBhYOhfkUwAjPT5U3lPyBPmT2Fxo0cna4R2JC3kbKzd3h9+675Ez8Ywq59n6eNpSFzFLFGCTUIegtMdINitpZQ0nII6SjWN2xZ9UQKxAVoPSuEqM3+9ZG89IJ9vnxXTiJsel7+WiUUakIXwnmP533QSObbxMDlmzVV4sADWotGFFLdySyKZr42X4wZEPYLy9PZsxD/BrrConuWRoxlKgVLi+AHmxPU64yS5Gc1POJmvYxLET4D4MtSEL/2q9XKb3dXxSI7CrhAXMgkFsrCSop7ELIZ7NRXRTWwOeSrM9n01lhD6XPelEPdadKV4KlGDZoQSURlvigvM8vxRoF1DlkY6ILzySxyaVmt/Rm7t0v8Pb7lGxtPaPLnvxSIF+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39840400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(6666004)(8676002)(8936002)(110136005)(316002)(5660300002)(4326008)(83380400001)(478600001)(6506007)(6512007)(52116002)(1076003)(66556008)(66476007)(66946007)(107886003)(6486002)(2616005)(41300700001)(38100700002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHBdBakAYuuPO8e28U3RRBd8S+GjH9JmuQejwVc4TeOHZ03qOTMyjfKC5sJw?=
 =?us-ascii?Q?IWtjTLY/ujAbM+FAPolc6cC0KAmvJ0rpA0G3oc8nr9glcGCO5w74GtECBfdO?=
 =?us-ascii?Q?MXXb9y091fSx5WQ8XtbfP9Jah9IUADSBpkIvkTvct7/ecQXiX1FCBb7zK6wj?=
 =?us-ascii?Q?shYWGBVBnBEY2dV1dkXLAwcHiMx1fwPPK9pDEvBA74K05eSxssLWFpGsFJj/?=
 =?us-ascii?Q?IS/6ZPV+DY2qlJFkoZK0StV6aPfMcwPVZ/Wsac4JH4KEwY/01a0nB8CQQe4w?=
 =?us-ascii?Q?X+6PEgEcWICltQPdGbq4ul9ydAjNqSft2QiVh/OCgwv+nvObeu+yr8Dx4frH?=
 =?us-ascii?Q?WJQhLAELSvG0mbtl5OikWf2Dm+Olh8IpiGC0xsZK37Xvn/djvv3sj2pJ+OYi?=
 =?us-ascii?Q?uWACspoTk+dDHBFLnt5gqdv8gwfHp8Uo8h9tTk6L8BAjBsntMBNHGaARUR/s?=
 =?us-ascii?Q?iedGcPrkiq3KTdQDfFc1tLkF3VvBwHi4B3AjBEZEKMO+vfUbJxKKlmkvUjr8?=
 =?us-ascii?Q?7XlLAul6Ku4ZHkdyPYSwVx+NSEa0kOGE5kwjSW4QY+yzFUlMnq2xZnZOiSa9?=
 =?us-ascii?Q?cKiEHYSo1ofrS9YWSNTcL6Lds9KMNluWy0Peu9PWe5dkvxKShwtcqhMVtR72?=
 =?us-ascii?Q?XyUOd9ZCrDLKNsZZRr9nad32SeEEzT8VlWcLxW6k4gI+qpkH6SMA79AZY77t?=
 =?us-ascii?Q?duwWxQg5IkOCnD5uwXZLmGqILWOt2QmdYpAx4ZID1hN+nHRFuU9ZcEH9dMJB?=
 =?us-ascii?Q?/WAes34UAbE7wVLkY+xhbTx9G09CZew2vjYBGYDXxvkUZ2gb3XcWYLrlT6bM?=
 =?us-ascii?Q?RNrNPhubC5ny4aeki60YtnqZoDMlZtZbdBFkWMqal8yVl/pweyDt3BfUC5o8?=
 =?us-ascii?Q?U56iB3f/HplalQZ42x+zDa4IT7RPOJLqCsOS58K5iHjfdXppycxsoUNO4bcB?=
 =?us-ascii?Q?fbZt0nxPb4mxkTwZrL2bdM6ybu3ct/bhJ+pRbpPDRTCzbeDgPeZKS4ur1ydR?=
 =?us-ascii?Q?2VDuNtJF+vNey7iKhrHXMQYm+Yq7xCZyU97fr6JjTd6LfsCl/p4xiDvH5MHU?=
 =?us-ascii?Q?iCY6TAaUycDs8m3oDdKi50NOyu1ewT4SDvML/qTp7NXYVe35sAhpTXMQAqqN?=
 =?us-ascii?Q?sWUt+Nd5ixFtFQDFLul9CfHfC/Xr3N6HrmScWytLe8KaRYNAdvtSOf87RCX8?=
 =?us-ascii?Q?4vHHx9praiOWlrGDCHC7m4BPhTnSVrJOup+GuVTE3BY/7FFCkN1qhf1ocwwi?=
 =?us-ascii?Q?Mn9vLaNBrbfHRzW5eiOIfhMN8n7oHs1OJZYtE2h39r/MRqYKHkuofc5aFHav?=
 =?us-ascii?Q?Q+TnnrAkp27pZSACBIPGgIeDGIw00TQiqXAHaQz7KslnYkbogyuK91yzeiHC?=
 =?us-ascii?Q?y/V4xdWGaKZw59OkjtBSt/Dl9XVbR1/ecdU8c959AV8RHNr0rAStkVuWDcN5?=
 =?us-ascii?Q?qILyT0FB+AEwqg0M1phD7ZRDPJjyOQx9dXdIvmmW5cGfBYsZ7Ror9xSMGLIe?=
 =?us-ascii?Q?tgn0PcbyfZijrlm1tVzWGd0Icwr7dLmvlfS8DBH8QNf15nRQvJ7nGGVLJx+2?=
 =?us-ascii?Q?2BPxmTpLcK/mqNk920yVyWvDKqaD01fZIefMJq6ddRI5igeBhvnyg+GHzKHj?=
 =?us-ascii?Q?r7RiuxjJtcOsgfFmOOYPMz+T2N+WRu8jP/RrEk6PzQkD3Yl2PC4mNFBDIDLN?=
 =?us-ascii?Q?u6xOMA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f3a349-4f93-49c6-6521-08dc10273035
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:52:47.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzeq0G6ckRpmdmMocn4fWuFRmrO7meye/E+m4GwL7MJx9L0VR4Sbnj/gV3FSB5ZjYXFjBrfH2yZtPiUCh2qcEgKE3qukYeRq0m+B0sYa8Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678

An skb can be added to a neigh->arp_queue while waiting for an arp
reply. Where original skb's skb->dev can be different to neigh's
neigh->dev. For instance in case of bridging dnated skb from one veth to
another, the skb would be added to a neigh->arp_queue of the bridge.

There is no explicit mechanism that prevents the original skb->dev link
of such skb from being freed under us. For instance neigh_flush_dev does
not cleanup skbs from different device's neigh queue. But that original
link can be used and lead to crash on e.g. this stack:

arp_process
  neigh_update
    skb = __skb_dequeue(&neigh->arp_queue)
      neigh_resolve_output(..., skb)
        ...
          br_nf_dev_xmit
            br_nf_pre_routing_finish_bridge_slow
              skb->dev = nf_bridge->physindev
              br_handle_frame_finish

So let's improve neigh_flush_dev to also purge skbs when device
equal to their skb->nf_bridge->physindev gets destroyed.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
I'm not fully sure, but likely it is:
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 net/core/neighbour.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3d..47d2d52f17da3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -39,6 +39,9 @@
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
 
+#include <linux/skbuff.h>
+#include <linux/netfilter_bridge.h>
+
 #include <trace/events/neigh.h>
 
 #define NEIGH_DEBUG 1
@@ -377,6 +380,28 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 	}
 }
 
+static void neigh_purge_nf_bridge_dev(struct neighbour *neigh, struct net_device *dev)
+{
+	struct sk_buff_head *list = &neigh->arp_queue;
+	struct nf_bridge_info *nf_bridge;
+	struct sk_buff *skb, *next;
+
+	write_lock(&neigh->lock);
+	skb = skb_peek(list);
+	while (skb) {
+		nf_bridge = nf_bridge_info_get(skb);
+
+		next = skb_peek_next(skb, list);
+		if (nf_bridge && nf_bridge->physindev == dev) {
+			__skb_unlink(skb, list);
+			neigh->arp_queue_len_bytes -= skb->truesize;
+			kfree_skb(skb);
+		}
+		skb = next;
+	}
+	write_unlock(&neigh->lock);
+}
+
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
@@ -393,6 +418,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 		while ((n = rcu_dereference_protected(*np,
 					lockdep_is_held(&tbl->lock))) != NULL) {
 			if (dev && n->dev != dev) {
+				neigh_purge_nf_bridge_dev(n, dev);
 				np = &n->next;
 				continue;
 			}
-- 
2.43.0


