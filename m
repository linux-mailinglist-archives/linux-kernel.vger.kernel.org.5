Return-Path: <linux-kernel+bounces-23765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123282B164
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FD828B5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F95024A;
	Thu, 11 Jan 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gL4dqjCp"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2122.outbound.protection.outlook.com [40.107.20.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87E4F8AE;
	Thu, 11 Jan 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZhrcNrqNTmHfGAkTXSa3JhYIsb6a3dFsfZ0P/fWInIOUcyR7QSOmKBcnxAXlk9PIVH421GOGKQP3sJvmeundEOjKOQhsf6kHn7DRYgnnfTB3ib+eqtN3EOs8WIFmkpedT+C8MbQNilehSBj1kVoGZ2mP5coc4B/nHIaIqFgD8mb2NdILrEsd3LFXzcXY3OG4n6Z8AqUdmF+kR7t1nLM+6hshpx86dNrdFeBwdvSsgwfE/T5QYy6vegLuZUNHyT2DyR7/AZHrYTjv9mA9N5G0MlH/Ly3P9SyOAgi0yng/GzCfvvYHTQjwWQsznMFjYEZBSrgECcqp+Rp5kXN0Ggiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVI05A05vZ9RZ3xCdO/vIitX03AtEFJSRyZlFjianXw=;
 b=hFOuNwWOjknTKCruZmIBa5WUik5ca/CwYCE0FO1GE8UQQAwIzF1pxxsbLI8/rbTIgzVOY5oJrwSk4LS/4CHZfTk2xekR+T7X27Xj0lmgOE7dStZ2lESnq9C7RcinPK8K0HhJWOjwWE3cHrACHpiKUx9q8xGbltG5TXDJM4QVN3q+QDmrnXen/g9Aky2R8lH0Ww76cYu/DZgx6jrc5D7DIi0SBdVuQnZ8dj0eHrog72B/2PC/bnuhNHE99Cndt/fZ+1PLiGcFCmDEuwODpLnrKJEV59K/FSZN9nDIs/a+YZXPOE9+T2XI3dAxPRBFW0s9j4JGJ4B4h3ZivqUw8YWrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVI05A05vZ9RZ3xCdO/vIitX03AtEFJSRyZlFjianXw=;
 b=gL4dqjCpSFTFznMd/fI36okyKbLZ2Jicycy0SLvdJTc8fE5vx4XA5DEuiwy966MpL4TSwKfkFbz13U9xNJ77cb7hMmtHRSc6lGe2UxySX3h10j6EzqBMS9QrPo1yLvQpw15wNdOUw4dkVjNDbAF+5vovtiTVnHMjkX6umcCaltInvjQNfJBR11iy1N4a+e/utT5zTM7FAdIDO20wZXW+doeIQW56+TWGuJwIvYreAcoBx0a/kfxqfcDKORj9Lo966s9m1e+ABWhsASnFY6fBVrFa0sz5ZD0Kh+2qMxPO0kIYjzIBdeQ5sr3teMOpWWgTPnaT4MT00PW05l0pAF2Njw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DB4PR08MB9238.eurprd08.prod.outlook.com (2603:10a6:10:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 15:07:12 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 15:07:12 +0000
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
Subject: [PATCH v3 2/4] netfilter: nf_queue: remove excess nf_bridge variable
Date: Thu, 11 Jan 2024 23:06:38 +0800
Message-ID: <20240111150645.85637-3-ptikhomirov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b0ed4336-4013-44f3-6723-08dc12b6fcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3M5oj5wKRpSilxHXdMr8I79tN6UlgzfUb9vr13vfNgLn3+FFrwRltdTeLMcjfFUsnIFyGwiXUEC7VbFDgErmbBSz3LUIxxE9LQuEKvG97Px+K7VBHU05giZp3DvssczceLbNTO1OWH9igNK3tI1r7jovXI2sWdmSFDeAXp81Jh6ck9Foeho6Wj9x9U8BqkuN6QV/yhmdu5vcZy9Z13zhI3T6P6SpzKBrJgzlA09b8NGtljMWLFI8X2hVqaOTip4AOr7HKGF7PwNZJjICpOE+O4nlvID2VoZYo0UgL3oLBt/62jdBaEnsmwVZtKjJ+/ZDbL+xok9CU/yxCdVqKlxllksNanafQ6z7MkC7utCarEVewbkurukDZUNhH15aPN4d8yp+hJ6GDr/vuO3eunr+rr1So0wLolTDICbFxTiLjSFqqE9H7qXITjjArIkgi5TF5mKuO7NCSxaOI/UT9VND9nNFP6dMY+RPcA5Vyjnn8Gj7IUh8wByl1UVbaOYGXdk4PNffm6TwtNCgJX4aZ+yUOt4ZaTJg/lkdnsF5MhyTNF519JXV4AXgkwEGkqXt7BzZFVfh+atpGyk/o7UBAALE9aOF055cyygcEDKRv4UDueY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(36756003)(921011)(86362001)(66946007)(38100700002)(107886003)(316002)(2616005)(1076003)(6512007)(66556008)(478600001)(52116002)(2906002)(110136005)(4326008)(6486002)(6666004)(66476007)(6506007)(8676002)(4744005)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YXdh8xgmUvTNpAlV0a1OBdvsbxnna1CftVsBkgTkE/vG6jzfJnxwMYrsTnf?=
 =?us-ascii?Q?aNxvgL9p7QHQSNebX1eFTEYEU9LPEtXQCCMeHLrbHcZUJs5c6bs9U83egfad?=
 =?us-ascii?Q?5P4YZicLpPF6YM0UkZvsex3beCEboXSko13RSzOmBQIydE6+8e1mh7GaQsXn?=
 =?us-ascii?Q?gSksXiXIjG2znh2rOEfqWa+3E3I/wmfgbjjnfqQHQznJagFUvS1HV/9afIdD?=
 =?us-ascii?Q?E40DWOHVlF3fwhIBGjCJGWQoGlu25ktNJTFwgIspE3U1AZyro5o1zI1Wyb/o?=
 =?us-ascii?Q?4CMshxEIGnaMZQ5WeXlMdsouMB9Gbuc5v8e2JRfSwjRRUExsuJvtan5Mwa+j?=
 =?us-ascii?Q?WualMXqCcQM3OLrJXt4m34G62uG8x6AUF0YKA5YfOh2/pf3N7vUZyQ2PU9k4?=
 =?us-ascii?Q?X0W8vstwN22S8/0Rsno9eYz2fbw8EU269tXAMlzJ2OKTtlg5MuHRest3gJyC?=
 =?us-ascii?Q?kU3dkgD5DoDSMd0s5H3nNckL1K0vcI5joGUbEO23nMprCKrWGwzZpaJsNjNn?=
 =?us-ascii?Q?t/9eKojEJgDXn1BH+f+IG2fbI3YHqLkaB7+knfLPxu+GWQXtXSpibQdxo8EE?=
 =?us-ascii?Q?Hb0HrVqIGIX6dmzL6wVsyO8VAQEuTcToiRo8r2b5fbHXkAc+daC3GOgivCew?=
 =?us-ascii?Q?khQFd73UH+H2Lm5tzHkEawTm2Qu7MdrDxiW9tTQbW7A/2AATspfayqD+j4VL?=
 =?us-ascii?Q?sbkLRgTCSnUdrZKdDESbkq+BCW7BtVtLU9QXZz1zGqRWm8qgUq/zOgmiLU/S?=
 =?us-ascii?Q?ZTUogyx6BMupS2n13z7tY5NltqNZtAjKVhO8U2mk+4BiKp2LaY+qJkWo9kQk?=
 =?us-ascii?Q?rlY3JZqPB7uTq5kGmLizBzG7Xp+dreR06IkNHy7zyqjq0+ragd0OrhXBRjrg?=
 =?us-ascii?Q?1DUrmRzwQdUq5e93h2XG4R8cNhpf/YTd0jvdKtULEjo+3GP8MwUlFzUYkQh3?=
 =?us-ascii?Q?u0KuUtlFtJSpOsdEWWZgGBYHVxMg6yVbxRIJGvAp7OrOq/ZVM52n6A5qEUEI?=
 =?us-ascii?Q?y54/agRUN7myQP/4naO8fkKK+9DQ/5QAsH69eShd2ZIwdI5KchxrGoYPrKxW?=
 =?us-ascii?Q?ITEPatiXf9yhlcdK3E/Pri0RNN7uNg83h5KgnrH09oxHxgzChkAL9WTTw2/t?=
 =?us-ascii?Q?XpdJS0OYxItRuMKUUNNNO7VRk1ymVOYYyv4gIM0EoVzqxjz7aMJpmLR53M+u?=
 =?us-ascii?Q?Xrf2gUwdeC6MWz0xfJu87bTzdD7WzA1xKaZ0mPeE1roHsZfPajPYPhmfoZvU?=
 =?us-ascii?Q?gKY/mwbEprUAwBj1wvnZPj1rVu7H5xItBrg2aGWaMugdiJwgi3Ip7e3Z/3lw?=
 =?us-ascii?Q?TdmGBll+x+uHkieRVNJ1jccJQSTqKbzollcNrFTrNLEJYYJvo6tdIBmDjVf0?=
 =?us-ascii?Q?uO5wWuwljvf6p5OzkmsNNehDK8Gm2fjfHdmQzzRVuMmtpFJS0FaCIlEf1QHW?=
 =?us-ascii?Q?kq3OkL65JhaWsVoDyutF6An2JVXTuU2Q52qdD7zJ7+Gu7k2fjHC4B8dxy1m/?=
 =?us-ascii?Q?HsE7YiJKeX9tV+QbdWRUzmnqwmkDVmC9q0LNZR9lYhVwYbTktbUFnYm9Dmik?=
 =?us-ascii?Q?8e+aaeMjjWMvO6yDx957MIS7NlAc2CPbAuYKk0qb04xgyQbIPMKxYRR/0qIW?=
 =?us-ascii?Q?QtPFYLeBXg8iXjVUHKQwqhG26pmn0WFqJJCjG4+YA7bBVseghqxy+qsuC8sh?=
 =?us-ascii?Q?CMQ6yg=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ed4336-4013-44f3-6723-08dc12b6fcfb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:07:12.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffxMfEXsEhfucciuvIITgelkKeSa0JW+3E0aHh1fdoiFJCxW1nV2rvNxXgRrS1Bu+QjuDPAHNQTtP2M94yCFioI3w62RYUAigjB5FmwVtrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9238

We don't really need nf_bridge variable here. And nf_bridge_info_exists
is better replacement for nf_bridge_info_get in case we are only
checking for existence.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
v3: fix spelling in commit message
---
 net/netfilter/nf_queue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 63d1516816b1f..3dfcb3ac5cb44 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -82,10 +82,8 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	const struct sk_buff *skb = entry->skb;
-	struct nf_bridge_info *nf_bridge;
 
-	nf_bridge = nf_bridge_info_get(skb);
-	if (nf_bridge) {
+	if (nf_bridge_info_exists(skb)) {
 		entry->physin = nf_bridge_get_physindev(skb);
 		entry->physout = nf_bridge_get_physoutdev(skb);
 	} else {
-- 
2.43.0


