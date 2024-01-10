Return-Path: <linux-kernel+bounces-22037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13682984A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A111C246B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4435646BA6;
	Wed, 10 Jan 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="zHqYCfBP"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2112.outbound.protection.outlook.com [40.107.104.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296F41770;
	Wed, 10 Jan 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwl1LHo2Rljguovu2G0M7VBzwIIJvHglf8QGi9DFYKa5PIiVICNkjE3Iz0a4pw0ENrKquFql7YjGGSdZ1KjwN7whZMX/BNfVs8W6JzbVR4km8qn8mf0Txgg8KPTeMoqG1nFAgrS/tvaN9wHsUkjtJVUFXdIZx7LRVQzq6xYCCsQeawQOm7jWJHT5o2YUMmTKjABbdZZiwRPpJ0LYAQN+/YIupykjW5Z1HKZILZnmz3oYpifdNaMQsvjG8K0E14edOYyiXnVFjH0eL07F+9Gcs0yEiTrb56e3JJQcgOnPwV1kya5MdYc3PZuGbhUc85Yh5IGmdg4lvx8A/aL0opXpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHSJ7NPSeX8QLt1uCVXToQ0Swk1PBWjYNJc8K3GLrE4=;
 b=TerfZCkNT+yl0DmsHzldxHTLWHrv8zRERWcz0n+z55Su6/J8Aui7SyjujfRKhblke6JbmLI3zwFNUOzlgQ41sUhKjK4TJFfQHzD6zU+amQXMPm5zLomBmFSd0bddKQ0BEEuGAn//GN4Rigm7AiP74rSMV0nwRwYWmHAiL5wjt6Ah/sYYWXCSagHQvTixRa+TYvmfH23elBnzfbZ+xkCfv83CgKmKAUvWRWHIg+U7G6jNu700nPsS/bLfjRavr83qHgtr6nBWKFZOHzI1VRN48WgTF2oJ7E69HQpSE35Upnx/CfncWnf6jFkjNwdR0eLldwD+VCe2UR/xmEze4d5gCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHSJ7NPSeX8QLt1uCVXToQ0Swk1PBWjYNJc8K3GLrE4=;
 b=zHqYCfBP8JKf+oJbwq5f+E78d3NvYyf8ky5bjOnJD70C/YVIU5AkP2bJQU4QxnTPl8xFJ95868eIQ4cXPIjWWJ0BQV9droaw5TvPqWLvizDweS9YxbuRAmk+Rkf44RLcQRWDMIVrg7fxwDMF9zshoBQ8KJ1BQgFwiNYQNI498r+uAZXEJ34hkTQw8qAnD34p/LK3X94s07uY9OW0HeBOwa2lBT3bAt4oUJ86/MqA6vBgnd11cLW4f1UD7yYRqilJ0D2bojbysXCKev3u7XpShgtVMjesPTKfE6QtyhFv41c6Oje/mOeMWrlcjj485kZNtIT0DFcA8iuSibO5D5nbPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS8PR08MB5990.eurprd08.prod.outlook.com (2603:10a6:20b:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:05:13 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 11:05:13 +0000
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
Subject: [PATCH 0/4] netlink: bridge: fix nf_bridge->physindev use after free
Date: Wed, 10 Jan 2024 19:00:10 +0800
Message-ID: <20240110110451.5473-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: 2b5fa989-8392-4281-a04b-08dc11cc04e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G+JaM6DrzGVFgbydTur7ntLLsU3y/8OL1C4Y0ZcdsqcjfCC7/gytSf9SLDmxuWzoKra7yMvXZ12Tdmq4f9bmjJzyb8wujblom+lfuLHjgg2ziNhyB6KL0a5YNehZYLwKlixg1ZkCSrVg2dD4UF4WcybTcDGCIgVmHsQooAiFOQdc0YyMqaKKWdcevjJLT1MYzg8mwA1KO4uqa47QcoNb9NZdhcHrLcY/JCUkwJQpUGosXDK2cWHii6U3VsYyFM6tkqDvxRtGYTYC+s2gELp2VKnTUEVijjrPdesbMVFmnGhxLIWnX4p+lf9CggOJ2oIBGnit6Tg+dsygEyPbhu2wkLjCBH76SoIFrSnwRysKl3CGxKTyg/PNDl6RK+Gnnl1VCkEXeREyQSVPIzxcmPmhP7msWDEJzD5EqCzoDZgx01D1QyF4ujqLhh9gPztYasbSQGyGiiH74Yfpdh1gqFywPkfuPAQ5nmFf6TDWxTIvc9FmEkqFCK46IL24qSqM14rATFQ+MhSp7w6z1ovF41L32wZQ8dIs0ltNDTOGTyRGMMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39850400004)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(1076003)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(4326008)(966005)(52116002)(6506007)(2616005)(107886003)(8676002)(316002)(110136005)(8936002)(66946007)(66556008)(66476007)(41300700001)(2906002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CorPpyzU60oZikcKOEkgwAYW1N9BvCSqw5kQ0uL9SDeAmGUk9azMUQG3CwMQ?=
 =?us-ascii?Q?ZWC2Aq/ACb6tV4peZZtvHyvWhgQP5hASMcS1glhowzdleVsWwHLYjVn9WzLm?=
 =?us-ascii?Q?lLplgUbuIdW7tqvExX9Ri5wdNmtVdAgcnyQQuOJ0DGa6F8/S/3tYSuwRT2kr?=
 =?us-ascii?Q?YVT5dikHWRtnCUg+jyTbMTUS23vX9fp9h3bJCovvN5qiopj+cJIKpQkfLXK9?=
 =?us-ascii?Q?Zl0lxy37s9bLH2jKn3Aa1T2Or2+2K9ZlieIjrAP0PIA7rK0tsdT9WUgrxZcW?=
 =?us-ascii?Q?d0jNjlU8Gs4IcBvhdVOkpVfuxkjpRUKSG5BCoMovlymVCwUHN/Z+WaZFJtJc?=
 =?us-ascii?Q?XpsYOUwH2PSOk7+VLuZ9gUsllxr5t+iF2sjnYhWWt33sBOrgeeMW4VlfoQBF?=
 =?us-ascii?Q?INpo2blMTC5RFtlI94gWQv3S4njS5aQ7U6YrVkEhMgvLp89+2N79DwPq+hGQ?=
 =?us-ascii?Q?8gTnFtI1+bTXSVF4sAOYeuGngDMgqiRsofLwZiKWXv41qf6e+zBa+Pa9SABG?=
 =?us-ascii?Q?RpjORfnRjKm4ojX4q89DGyS4bM4xz7B8mOwsg25613cePs95bNVNQ++NmwH2?=
 =?us-ascii?Q?kMWbuMGrzBvHpYyeEhuQ480zHg1dkTM51cxIKNQsp8MVfTQFuCkqAbFZOttp?=
 =?us-ascii?Q?6JYbgR3qH3A4w4cJuYpISNttZE/XnAcG0Peai+711TY7GZhmAUgHyzbVe/1i?=
 =?us-ascii?Q?IusKkUh/uVdk1KWx/dW5zg+2IS5jV1zWp5hdAAczgo6+CxgbNSuGHTzv1W6K?=
 =?us-ascii?Q?4e/ySQH+ch6rQlAuCoVyhfxu8NvdsCpiIavtQi2n2yATBpAtEtb1QD4mKQY0?=
 =?us-ascii?Q?B4FwFjpuj8iM9m8IfZwgxYKHp2q7uG3yT+0mi7uFgrIniacN60mRMMcZu2nD?=
 =?us-ascii?Q?ANvBgl2edIw7K5nBL8unKZBfe4oW1Bedntd1oikxlicpLh0zFunfx3Kyredb?=
 =?us-ascii?Q?xC6LYQAzz7AG1/hIK06KZ1gIxrGsr3xtCSIWBC81QN27vKdEkGDJ9sp3lzXB?=
 =?us-ascii?Q?qEicsGa7sblluSzpid/qdGyS9AWDwMSqjrVo0u6gD/Txyq5hEU2AQSDeAuDD?=
 =?us-ascii?Q?wgFXmjafb8jFr6qALJWYGMUVFseKCHS/tpu39SHJ0lG5opbkmPBtC7CLJUcO?=
 =?us-ascii?Q?tEKigZ75MSgzAhst8cKJh8vEL/hgI7rbfBDldLgq/ETaAepCNLN42HYKBDgo?=
 =?us-ascii?Q?Hu5Zzc25nmd+r2rds0RuY08ur2rTNroQJZHq2yZsXwcUK1N+InPbaO5TzLzN?=
 =?us-ascii?Q?IlhBI0vNI4fTuIaLNrjSOND2TgHdrWNFW7Zxvl7YwFTIjew5J8Nzij6AZGEm?=
 =?us-ascii?Q?/BQptuYiPnFNRx1dqABxbzUsgUU6sUKe3A/ROeSBxH6jVT6cPI9eHdLIWA6v?=
 =?us-ascii?Q?bsxVotC+LJETTxnFUY2j13YVLHbYApqpYVGD0SFeAppt5BpQpFmW5i3hIC+Z?=
 =?us-ascii?Q?A3vmHsdC1T6wx0EOJ+j3CxqUMVM3A/A1hm2GRaKHKl4pcXD0Qm/zHQLGuOhF?=
 =?us-ascii?Q?+WPX70afVXby3pwQJDMsNUihTbn/vh5I0DffneCXWBJBnIWK6epU4J+OLxUi?=
 =?us-ascii?Q?5opte7fpPAbMurohLPNt46Q0QSRd3PfqOqAW9z4v3N/k2UYZP1vtrhi8dR37?=
 =?us-ascii?Q?PL0hPETirsHd5CfRHDgrjj9tSgHLoXdUm9rycQ0No5LeqTjwnwgpQwaeLRwf?=
 =?us-ascii?Q?6FutAg=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5fa989-8392-4281-a04b-08dc11cc04e1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:05:13.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8HnLPXhEbO5V2R6X62rr2yVP000OGzOXnWll2xK5L/bSOvxVV/xqp9YWHDt0DR5CrsUmiXpiAUJJ32GrTsggTOiH4HgvglmCG/7s6F8cpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5990

Code processing skb from neigh->arp_queue can access its
nf_bridge->physindev, which can already be freed, leading to crash.

So, as Florian suggests, we can put physinif on nf_bridge and peek into
the original device with dev_get_by_index_rcu(), so that we can be sure
that device is not freed under us.

This is a second attempt to fix this issue, first attempt:

"neighbour: purge nf_bridged skb from foreign device neigh"
https://lore.kernel.org/netdev/20240108085232.95437-1-ptikhomirov@virtuozzo.com/

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
 net/netfilter/nfnetlink_log.c              | 13 +++----
 net/netfilter/xt_physdev.c                 |  2 +-
 11 files changed, 83 insertions(+), 43 deletions(-)

-- 
2.43.0


