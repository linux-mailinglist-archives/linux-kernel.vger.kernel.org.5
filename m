Return-Path: <linux-kernel+bounces-23764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE882B15D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37381C23F93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E04F894;
	Thu, 11 Jan 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X7Zj/aYi"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2096.outbound.protection.outlook.com [40.107.20.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8934EB52;
	Thu, 11 Jan 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU+FhpiS0Q0SLj7v5EkmEu0yF09yfscBrs6hI+9ZmTfZbqbtgO/prJQnOhoIz1T3eEbRqf7dy5Hwv5WuIrymwC81lpnY6JcSFIFQKfJJF49OfOIwT4H9cmYbLr34IJemFDEYUOUXrI9Yekn5Aq9xkwHQz0z2SJegP39Jb9wERBEIUzhnDn1XVg8zG6iOtuq75yev79XN8TdeM3iJgvVuIxiucWJSWafTgp9S3tduBvyqjFyDDqsidcm0ep1NhVtK7WpT8VPHU6uAk+Sso6tv03I/oywEVNEh6cbMwZgpcr1m5PYPMMBOdDjP4k0+IGDAN/TXjZmFJlMQQM/AWzlYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHFID7yZPMUZ0kqhXE4bLvAGq4gFBZ1ilWbpG7XzBNg=;
 b=K1WcZE9EXDciJIwboqhoWC1ytm/oQ8Sd0/4o1xTqCxOop/Kht7UUmGhlxzAg63v5/NG7yIMHHxLTUlVAy2YlLdgexHLiAOKShqNq63Nec9K8jVqgjubn8zbl+a7de4nxRBGqRaRlenIePe5aceb8PXRj4o6r1zw4uuE883E9UJjkIjOv5E6FoePasebRtjLb7SraUwuGOeEwZrAvo6Psypy25xcuQTkwR8RPo2WJatJfTyzo6Rndnb91K5s1lyVO5fQ+mQOCmvj8EF8KjbcQCUeEvtQLI+gaejyL7Bz1NWavN+NXJqA+sWBmwpDYj4ZCp17xvaEsJ6A+r5mttCwUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHFID7yZPMUZ0kqhXE4bLvAGq4gFBZ1ilWbpG7XzBNg=;
 b=X7Zj/aYih9C5Y9DuzbRaieuoxUfbTRpxQ3upvxZB3sruYFVa3f+g21Xx6uykE+zZG1nfsp47b/dvnteT02lU2BAmmCjZVPDriKbjYoAEyNPQ6EAzf7b6ZojGj9NBgXg/y2mr+KN0Xx4piCFOC5HGowQvaYRAYgPoAxpDIEAJgEgzGv/HtekPjC0ppnJKPlksPiBEErp/tMrhlqsJedz0BfBsZ2NRerNY+BP95KK1rYzngbtYhdbTAVCw+9JjAPoZWe29mxyYT+PcZrbkWN1jyQsyWXC1AW9AZy4TLMQK1tkyOIJK9a677y+CZea7A4HpdM9nnHqtRS0JeNyy+3WLvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DB4PR08MB9238.eurprd08.prod.outlook.com (2603:10a6:10:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 15:07:07 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 15:07:07 +0000
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
Subject: [PATCH v3 1/4] netfilter: nfnetlink_log: use proper helper for fetching physinif
Date: Thu, 11 Jan 2024 23:06:37 +0800
Message-ID: <20240111150645.85637-2-ptikhomirov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5924aa60-941f-41d9-0e32-08dc12b6fa5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bh5mPl26c7fl88e/lOFs1XxrMNTVfpzwgFfXWh7T50FYvwys6t4ImH0lJmQjlWwQ1B+IuAJTcZIegfMVSsGsMIMQ/Md3lUzLgYIVRU7DdQ3OWKrp8gS1Vft27tmuoCHkDHJ4v4a7ZzLBNBOgAVb/M7exbbPIS5MqqEE3aQwk/8KfyZ4cNsmCA+gtAY4tsRf1bq8McfH5PRheqEWLmRofL8w2ItiXfb8jtWMSusdWU8Y8aAjIbJgSB4MZ1xQzdespE8BrHBZo5/bwOyJr3zOD8iBmDQWVb6ZenK+7WS+jzIUaLToLTd4bj+3iiIA9UWcrGVLRwImZUFqL9+rPQUu1Lv6ErIVMsvaCoD1T4zxMmZIkfmN9q/JEWDchXJIMNhhd2y2wWvaOymZoqOJQpbSXcqqRKYNHBBNJbOnSqzjwAVNUblUS21tLamUa66kwrMOSTxodyJxbAAI0bMPvLkudt+PPiO4zTVb+FSPWk/mJnlV8r0d6hT1MWhtA6qr8fBypj0FjZdtmQGF8BU1n0vJlvOQwyxdbNteoMaknkAIaGKCJQOxybyk4vxHjaDx4eNMHuMgK8wElO6DAK+Jxafg6pvNmUNYjJ8epGMHFi0+zoJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(36756003)(921011)(86362001)(66946007)(38100700002)(107886003)(316002)(2616005)(1076003)(6512007)(66556008)(478600001)(52116002)(2906002)(110136005)(4326008)(6486002)(6666004)(66476007)(6506007)(8676002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Z6PY8uxaH9N/CVrGrYnRbRMXakdebll+nPs2K/EwkdfCTySD3yC+0hzye8E?=
 =?us-ascii?Q?qhwE6LvVluepOE10q+EcocN4dr9tBuO7wN4XoIGz+JDE1ZpIkSb5GS2Qscb3?=
 =?us-ascii?Q?k1LQmJdM2SV4dj1eXtuaJXYXKfuVwiPKC/dggdsWCEdE15UX8BmZsK0WDSLo?=
 =?us-ascii?Q?rvJbUcyhrEkot2xRWRfZBzcQG2skm+kvlBt9WNWHLCuQFQFqposUMNpHR6Cv?=
 =?us-ascii?Q?5y3sbaLayqz6/VDY05i4rwBrBUKm+sbOAit/ihKv9ix25SAu/iV5lGN7o6w7?=
 =?us-ascii?Q?p9ZRM0/NPFJ7/oE3Ao7Yui8JQYBUwtIkX4BkCfpGvDvr5lhK35uG45LWji+R?=
 =?us-ascii?Q?Zsa2S9MEbbB6/qOrptUCFgF8D34/H4x9ihJ0VkAY5lUfAjOsb++xePxRXYMO?=
 =?us-ascii?Q?kZdnR9TJONnepOZq6oGIYeem4tXh9eq0Z+u+qO2RGTTSsoqpSwYsNjE5Rj+J?=
 =?us-ascii?Q?l2et8Qo00OZu+S0JRYZQDyuUsx9stpXqYlXpLr4vEKF2o6qlO8237qSzNWU9?=
 =?us-ascii?Q?FKk0w4CofTYTX6g29MlQ1yniojGHh6YoREb75ku75QYaIBFF++kcqgYGXynm?=
 =?us-ascii?Q?EjSmontN+QyIG9OMu+mwHl1wNPx6sPBfwmiIUarz1FF2EVxd8yVijedStVa8?=
 =?us-ascii?Q?6/HvUib/d/b8K6DF4rRQmqbOc9yJBqo+T+U2WGdHmR1KbMjHiYQbY3IIdqk9?=
 =?us-ascii?Q?fmago1bwAe1QupBF3bSbDN6WQoVpaJh7lMXJercmmex5on2vM41Su8DiSM0u?=
 =?us-ascii?Q?fJwGeQbImt+mALYdbR7rNQQwDfhSU2OgaHhIxWUevuMDvEzAripqu6pqoAzk?=
 =?us-ascii?Q?36dKj5LL0rbfRKJd4NpllsaoBZPXByQy1xsmByhrx9pDh34pvBjrkVhhajpj?=
 =?us-ascii?Q?wNUsdVNzmMnGlNKJmm14580GI01qwbBLJoiK5nDAprnBXV3YaYZIE4kRiI2W?=
 =?us-ascii?Q?1AFCjHDIY5KhGm90SHgO45Ft+KKcW8q4dutPvOq2C8hHS64knnDzhMDu5jnh?=
 =?us-ascii?Q?5netTWxWGZTD3bOxPRE2uNc0UYnyxXR7uGJ5fopOjf4DX8jEAGbeqlp7S5ar?=
 =?us-ascii?Q?WgZNAL3HeIlhxzGRaeI9fDWM1LU21TZV+EdOWHjf4+Dx6izFC4N3G85mjwBk?=
 =?us-ascii?Q?EnbKriP3Z3wRsj4Rlqnnht+uNo6TWQrXffwEhsrdGMqy2fvpoEiD1aoAKbVI?=
 =?us-ascii?Q?ZPx48/wt7dflMR+rwbwJLQZLHQOR7dkA9mWbcjCwERZRp/PKTCN35PVRMSxH?=
 =?us-ascii?Q?LhR/yxzG/3DLfh4LW9gewQ8F3jm7UZNg5NM1uSYzTSiUbVb6+n3dmmu5cheI?=
 =?us-ascii?Q?BVKK99QXAp2aEhd219iquzit0O3nCDBM5mn+bv9bzQf6F5KQ41oClE9c4HsY?=
 =?us-ascii?Q?oFonzOZZ+J9uTBnKauYt3J0adSFPWp0uFJSUkUZVDrHNStNqtV96MxEYvhi6?=
 =?us-ascii?Q?kr1+oh8PbvO0oqE7UCXbNI/gdg8GfmeMjIC2CG4q6QH4nwKFsGSR3snYu1LD?=
 =?us-ascii?Q?meTkCBnQ4toyQUEbNIjro6QSs0Dgib5OgFLJoE6T8IOVhYK7Gm2FO9cdrNZc?=
 =?us-ascii?Q?M9EyXqG+JswsEd6wfCk8NHny/Lb7rr73iJzaL7ktUcE+zse28WQRUAYAE4F1?=
 =?us-ascii?Q?gIuljnHsvZYOkDoTatveQQ6xoNIeOw95BZRK/IPpWKr9pm6jMA7kXP55FoW3?=
 =?us-ascii?Q?fsK+bA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5924aa60-941f-41d9-0e32-08dc12b6fa5b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:07:07.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbMAvFUE5hXFSENVCG8BNOFNDzDX9ot2ymF5ZB0StIkMEsUnMTQUdJDlzr5fcnZqLARPFZE+sqAzkDcnZLpPNWyjAgyYk5/A7c9zlN3fw/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9238

We don't use physindev in __build_packet_message except for getting
physinif from it. So let's switch to nf_bridge_get_physinif to get what
we want directly.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 net/netfilter/nfnetlink_log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index f03f4d4d7d889..134e05d31061e 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -508,7 +508,7 @@ __build_packet_message(struct nfnl_log_net *log,
 					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
 				goto nla_put_failure;
 		} else {
-			struct net_device *physindev;
+			int physinif;
 
 			/* Case 2: indev is bridge group, we need to look for
 			 * physical device (when called from ipv4) */
@@ -516,10 +516,10 @@ __build_packet_message(struct nfnl_log_net *log,
 					 htonl(indev->ifindex)))
 				goto nla_put_failure;
 
-			physindev = nf_bridge_get_physindev(skb);
-			if (physindev &&
+			physinif = nf_bridge_get_physinif(skb);
+			if (physinif &&
 			    nla_put_be32(inst->skb, NFULA_IFINDEX_PHYSINDEV,
-					 htonl(physindev->ifindex)))
+					 htonl(physinif)))
 				goto nla_put_failure;
 		}
 #endif
-- 
2.43.0


