Return-Path: <linux-kernel+bounces-23763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F71182B159
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089D128A91F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23154CB5E;
	Thu, 11 Jan 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MD7rug3C"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2112.outbound.protection.outlook.com [40.107.247.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D14C609;
	Thu, 11 Jan 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr94EEKPK7K1waZMELOe+4rEIaerF8903qQhFhL/8LOdljgH7s5gjtOybznAmlfAW+lkeEAY0mmb/UxnUeeUJgleYaNtoQfXsf1fJPOnshwBWU3HKGpdJrObFAHsk6TYsiCVe3yQX7Qootv9EwqqIz35LEqH8m/c82gf+WpcIBT8mhmQUQ/Fk6s0YdXHstUYNaUPunrBY5FIzbO5mbgIZHwMp+GYswimGt3ojce8Jidi+fY44sHcTn2qjnl48ZeDJz8jg4zaQ6KoC4x9bOy56BknCI5VPLCXHC5sx9jTgPSHjMqdJIICCzWEBdjemU6ZB/sBfu3xCFfFu4wVaAz3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKUKNjyaqIlYEjM9ZPFNE9rgNVN/yxg0yhsgjc2/uMQ=;
 b=fk136CsnxaeIRduhQk7ILCDA37R5zU/JdoG5Ahjomh2iVaE8SEBOf2+zResQUzAj4nOHI1ES32oJhHCHRhFYc7x4hLiUhw8b+5HVIBAXNaR/vQy1K9ZzQ1BRkBSbgaRRzPtrx5JNFs0DNwWms34XW2UjvSW3fnOa5qORnbWwmXDArOxoUtzHAl7KljR0yyiPWQPB6+fIdhbLqlIP1nMbkTADqyppmrOZvQzPNnfAspjEhmJA5qLGtbGKZXqQKUCGnGBO7lwVk2c6W3KI0gtjgmI0I0JGpYVGPH45jMQ9yVZgqnHedA+DhvbYItX3rjq73L25qQOkgHUz5xqDPLMSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKUKNjyaqIlYEjM9ZPFNE9rgNVN/yxg0yhsgjc2/uMQ=;
 b=MD7rug3C+7tGJt+ANNh4egyf657AL5CQwGf8je2KZubRJFG5DhqSre3/83epp+UCAZ3/yU9KuTQ1lwb6rRmJrEMCN0NmlnUdIz6YUPFaRf++7ZlsYI1K4PcK2VfW7ci/aMnVPLzGruOZLLD/w+ntC481Ru0Jsm2HK1PpBwyEvuULMgbRJmw0305BKQORJEOwjZcKMLEVluaNHXr0ByxMi2ORwoo4jdjoglM8omlEp8ktKU6MUgny7f2haCkdJk1XHh9H8HB7BlkPSQRwgop8ZacxQSd8edayHaaYOhi3JXxfEAhflm0FfIx4fKVyfXz0O3HLuRRwsKnfnYqN2+zVAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PAVPR08MB9089.eurprd08.prod.outlook.com (2603:10a6:102:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Thu, 11 Jan
 2024 15:07:03 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 15:07:03 +0000
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
Subject: [PATCH v3 0/4] netlink: bridge: fix nf_bridge->physindev use after free
Date: Thu, 11 Jan 2024 23:06:36 +0800
Message-ID: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PAVPR08MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d307970-de6c-43be-b58f-08dc12b6f7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	77tuly14nB8FO5grkQWaoMQ1u5MzCaAfRXmfB3FRxztbSsDDDZ+ea+dVSNqZLq2fIHetM+8t+/Q5U3qcuZsielTDzujb2uT6+1YTHtpLduZ0tMLPKDhMw5DMUBSr2MSCZOZvYgGrkNSoSw0Lroxif8iYrN3tOj+cbcYVsrPZlN1lyBR4xB/JDsvBCTSUE7KyHqQt9U18OW9g83rMQ3R4lA8yI9ZNnpTiDhUIaAUiNFW2unP5zEyVjjNg+xiq8OJLXeJXxeIjIcMkNMszoDBzZqjvu54emUSWZygIZPdZSUHzHSUzQOX2hFd/VBk3tJARKDzarlPIQ5jmzwfIBmqj0q3HhCm9+VxUAKTQ80PhDklq9IXadQkOAHWPD3GBnLxFuwMEiVXRA6xExi3DVWtdM0laaf0fN5sz2/zN1FZtD7d1oiRTnDBKoxLyzPFZPNmihWx3XhkT2uIKTxHslV8Mz64gctn8dljC2q5VgfP/1IIFWE3N7Ey7BAoxkRbGR60vj5M9nij5TqXyHL/NI91Rnt/ZYFmK6uTh8JuwiiZAFcWTt800LryipLBfRY1jlrXFP4JMZATO6qCHtd66+E2YFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39850400004)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(110136005)(66476007)(478600001)(966005)(66946007)(66556008)(6666004)(6486002)(1076003)(86362001)(316002)(4326008)(38100700002)(6506007)(6512007)(2616005)(83380400001)(8676002)(107886003)(52116002)(5660300002)(2906002)(7416002)(41300700001)(921011)(36756003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vB85gIFIdboCPNTU842ADs8n/UJ1wIrZ5/aT6LWmVnMe17OPjLWTcAri6Amt?=
 =?us-ascii?Q?iLCxcLZ7bRKniIeHlV6+795PPBrawLVpdyuW78rB4BGjWmMLSRhQ8Pb1Ang6?=
 =?us-ascii?Q?FGvbzWNVaLA32skDZzOXCgu92S8a/11Jkjwg8b4cvGNXPsD/BjVVNpt5+aEz?=
 =?us-ascii?Q?UosQXJf6TQ3WcKZ9EI+JpSis1ULjfiizP+WlK6/gB6JbHoZz/R4OZuq/wZPU?=
 =?us-ascii?Q?SkC02/nP3h1OkKZnENQ81lIrpYr8tSE4EpGjEsoG1PLRfV1ehQ/wvOZ9ksJy?=
 =?us-ascii?Q?ZKiHf+LkfgnhPHQfgk9LGQ7A8PIsmN3VuqLxW9txBh1P+CzBxAbhdLB/Gxbx?=
 =?us-ascii?Q?GeSiSC6Ce5C2PCLRdahsBqdgLxQuYnGOM7HldulW/SeMBaSzTBpDvNcZpN9q?=
 =?us-ascii?Q?bHvnMQJWz+gZqIINfxdumPwpA6DgXNtoHhza/HOn163RnA4FbamvhJh8lrTG?=
 =?us-ascii?Q?abZcPUJBDtDAAybLeAj8U/xCZ4a8VJwaQVwgAyJyxlpYcft96RruwpLu3zyy?=
 =?us-ascii?Q?KSIgmHyuIvDhWK7LqlhhxeWapulekbKbZ9poabJrDmuF31qVumiK/ILiRe7l?=
 =?us-ascii?Q?egTmDbRwPMCiGdVfjBv87XfTWo0NtFbTpUNxZm67rrhISgaxiHgAvFehwGM9?=
 =?us-ascii?Q?Ls9oTSyIRXeTcOd0QLeGBgVX8SOXHKAmCPZqTv23rOjQi55NibguGhgO9hXS?=
 =?us-ascii?Q?RRiTfQbQJ50aP/qvmjDs+R8XFZ01ZlsCanSYF6eOYZdDKaN5EgB0qPVr9IbW?=
 =?us-ascii?Q?4TzVD2LicA5DpTXvCSKztPwUBiJ8dORSlGaVKsD4U0Q9OY+xUFeYkZ7A9N5A?=
 =?us-ascii?Q?HaUxZ4uI9JabyBRDejdT4fgLjOO1sr2iQ1aRD8W1PTxQw6wNm7hIE+RMrWOQ?=
 =?us-ascii?Q?ORni/I12ZW/8luQtq53XqvTrqr3pAANG92402peaS6q25xxEL/93FARjbuaM?=
 =?us-ascii?Q?VrzpM4rOou94IeeD49KmjW2FamsJGUCSZ0RoOmL4Ox2BAadDEriyAfNzwqFc?=
 =?us-ascii?Q?RzMjy0GwlHu+647aPU1091Za8xgVMWkgcw5YiIz88w8/m7dtVf0NZsC4JaMy?=
 =?us-ascii?Q?z1F9EDFq8qpHnwcwZjlItITvyMTHVaNLRLG3Ed813py/eHrmnje2Hht/imkX?=
 =?us-ascii?Q?/81bT3ZjIho5Apt4+DFryhUnexb0dNcWRFjVj9wXhC2zhSXkrO4bUMP9nsmw?=
 =?us-ascii?Q?Y6l5dqZS0Gy001kf0mLmAVPjKUAiJay2D5lSvELJGeQ/t3ZbJZ+rBhi5vlzu?=
 =?us-ascii?Q?Qz0/8UIeDbqAkiyzv+ls/A3inUvHoB8gjwLB51OS9UgcZiykcSrLD93L0/2z?=
 =?us-ascii?Q?6aYabTZ8nKrXmLPHfEldhHxVeLbk6fzR027reB4Qv5RaCOjwIx8mQRt9bT2Q?=
 =?us-ascii?Q?Oqd2Pw0vZzqjNOONBKP7fF8ClGvN/PEoSKoz5g2sLt6I8/N/DrFaL3wRy58h?=
 =?us-ascii?Q?Sw0bfjKO7FfKro9WFPiFuL+DkPNCHzuDU3CT0YN6YqGIxuRynBn5JCknZV6l?=
 =?us-ascii?Q?ZH3KXzuqxW9E62Tq5LrjoX1Sk12y6tqdlA7umqvo43IhstEF4SkP7+RQs/ay?=
 =?us-ascii?Q?5OhCt4rB10uZgfxyz+TXpaK4mMFD+RS4rMVktpOXfzinqSnyiLW1LN2OJry4?=
 =?us-ascii?Q?dzDMz4z/WpHS5TnYdIVNnrifWVJ6+ybuRRglyFUTYP2WINlgSD7/0apHkDfS?=
 =?us-ascii?Q?HlrI5A=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d307970-de6c-43be-b58f-08dc12b6f7ba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:07:03.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gakHaKqgaJlg4vpg83g6VKBD8rB1ReqbKmfJPOXGjsS6Fu3ro/bVgIXqM1meHP2YZePiEniWns9dptkRnsUf3fWjROw27Vrif1WvUhOc224=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9089

Code processing skb from neigh->arp_queue can access its
nf_bridge->physindev, which can already be freed, leading to crash.

So, as Florian suggests, we can put physinif on nf_bridge and peek into
the original device with dev_get_by_index_rcu(), so that we can be sure
that device is not freed under us.

This is a second attempt to fix this issue, first attempt:

"neighbour: purge nf_bridged skb from foreign device neigh"
https://lore.kernel.org/netdev/20240108085232.95437-1-ptikhomirov@virtuozzo.com/

v3: resend it to proper lists and recipients

Pavel Tikhomirov (4):
  netfilter: nfnetlink_log: use proper helper for fetching physinif
  netfilter: nf_queue: remove excess nf_bridge variable
  netfilter: propagate net to nf_bridge_get_physindev
  netfilter: bridge: replace physindev with physinif in nf_bridge_info

 include/linux/netfilter_bridge.h           |  6 ++--
 include/linux/skbuff.h                     |  2 +-
 net/bridge/br_netfilter_hooks.c            | 42 +++++++++++++++++-----
 net/bridge/br_netfilter_ipv6.c             | 14 +++++---
 net/ipv4/netfilter/nf_reject_ipv4.c        |  9 +++--
 net/ipv6/netfilter/nf_reject_ipv6.c        | 11 ++++--
 net/netfilter/ipset/ip_set_hash_netiface.c |  8 ++---
 net/netfilter/nf_log_syslog.c              | 13 +++----
 net/netfilter/nf_queue.c                   |  6 ++--
 net/netfilter/nfnetlink_log.c              |  8 ++---
 net/netfilter/xt_physdev.c                 |  2 +-
 11 files changed, 80 insertions(+), 41 deletions(-)

-- 
2.43.0


