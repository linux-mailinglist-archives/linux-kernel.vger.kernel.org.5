Return-Path: <linux-kernel+bounces-22038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650182984D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAAC1C21A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836F47A46;
	Wed, 10 Jan 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SRzYYAKZ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2112.outbound.protection.outlook.com [40.107.104.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840E45C1F;
	Wed, 10 Jan 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvCiglLInss5Dz4PfaVyq6SQH2izIymECnA2gPDU1pQUbXfhZFpPhV5JyRwjn4GRIdmcbtt9kIdn0o6GGwFFn/kTVmQUvpvBRoDDDg1K0fZDoxy/LsT9enpZ+Fqr/Y0b4+Tll6wpsvJLwX/VUCWf7mxzzetJbFJkgL/5Gt2k6I142Q/1AJU0tGImJaXsgEsYt39Q3W5Kh9O4aRSfQXcdqKoh9vnazUWus46UFGc7RfrL9Wx184lFLDR03NWZUmSLQ8237hQUkDFA5a5ixLMIj4W7qTWvKy7N9HDPzFAMK8v8DLziCqZnt8291Jq+nHKHdfq+WpdtQGzLGGhbI/BJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHFID7yZPMUZ0kqhXE4bLvAGq4gFBZ1ilWbpG7XzBNg=;
 b=RJWHsmo2NmgVjgde3RTJk5TFw/tIiVH0LLJOUAj8YcgpFaBmCVcFnHNsOlnSruOWzKkUkH3/cfo7Ax2ZjkmA6OsimGAM5IIb9tMhCSt0A4G1OOeH/v6j+EQM3++t5SEvhHf2MOBgBTAk8P4JhSqMpzCTD+m+ilMhkpbK90fAA3mtajnj2iIUJO5uzUj84ks50Kp+IbHgAjo5nZrbAsaJs4M5zE3KV1yRgg9YQEI+Er286Zc2hjitVMaT6PEM8V2M3bTDTTCsNsOicOPOB509kgEdIapvClyohR0S3d0eyGh52fSUYqLVNG+grlZoeXYNGhGkvHEQn1QV/jXibj/M6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHFID7yZPMUZ0kqhXE4bLvAGq4gFBZ1ilWbpG7XzBNg=;
 b=SRzYYAKZDlY5edaAcAVA04T9kWgOvNgXAT7NBF45CnvcJ3gfSlNeq0j7+3Ql/gR+MfvAgjXzIg4ajw+Gm3edI8f0w8AN++rDlewaqe6fyMsB/XY+p35tBIp2hP/vSDHOzZvX37cqEME7F9hTVYGE/8dcVKO/Ui5y8cQ5f9bND/PpsMMmqV0lWjirKxoDQx8R4nFEWYZhAV2J3QfaOt4ZA/UkF1k32uNrtfPHLWMjryj6zvCDmBLVjO0o1DuIsC32B5yB40wVOpD2BUIV6r8uLMxE+w98nrO/UKsrIM1+vZs1vPxMEuJYLSIdtgpbZOeXh8AyKZsUTKqOO78Y3pflWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS8PR08MB5990.eurprd08.prod.outlook.com (2603:10a6:20b:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:05:16 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 11:05:16 +0000
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
Subject: [PATCH 1/4] netfilter: nfnetlink_log: use proper helper for fetching physinif
Date: Wed, 10 Jan 2024 19:00:11 +0800
Message-ID: <20240110110451.5473-2-ptikhomirov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9aa885cc-3d70-496d-a2fe-08dc11cc0668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OthMp17te05x7zltSBSCFSCKl0Baqh2blxzDnQ9xGm7hdS35WDyUJco8cps/fsuFIAyUtnmZa8tjqSUSrMZ07bJLN56XERh761+VCho1UziQNGG6cXs4+7JeilUvat+mJRfL+lMRsqtwD73XN6kuuv7odNsjE01s0bHd4rPHWXXbDo2UgbKHkAuDrCVmwYCSHU7g91tNtFLarbH2amCilY5QTp/nvsOyya/oBFf3fhwp+h/9xjAbDwKoZbNNyNKtlcBjZ2wTktKjPunotYSv7Q53aKudSpcyWVob9FYNCBo5lF0SJDZ+68vkO5sO9W/9FGMpCEkHUBDbaa7V0S/4sriGcgghqJ97Vh7cAOyRDKI8e5iMxQmwvwOqBkgva/oTsPLwapRRNRg7LMnQ7CD6fGotT30Y4LHhuzwpPZnSmUJPc+Gc7wANC6N01Mko/RVvjGy1E4DjjMqIZcJDGQnubD1hrxpajEelZelR90Itfim1RfFDl/NoWrN4E1lj78OnnY1Wxj1V6CSx0fls541Y9CeqnNf+StvZh6uL2y+tP+EAY3BBF+SnzfVMvmGXE7OW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39850400004)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(1076003)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(4326008)(6666004)(52116002)(6506007)(2616005)(107886003)(8676002)(316002)(110136005)(8936002)(66946007)(66556008)(66476007)(41300700001)(2906002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1eJ75sM1Fq6qriWRwcQ9PATQA20dlIjdYrpA+KsEDIy3XF99bGeS1QR3x7RR?=
 =?us-ascii?Q?gRx1u2IqpqxWrRiTVJNaPkmoV9JXdV1T91bbqV4v5p9EL9CRiOJA+EZkRCNh?=
 =?us-ascii?Q?RkcWSCT7yY29bRM+/zygxC+9uk4VKfKT8l2chJ9DUIECqFH5MhZkC14DItM/?=
 =?us-ascii?Q?/PZ7ehBpD7rtyB/mvAeRCWyk1WEQnj7WIZwkoxm3fVsjCHuuolHWtCxXwLoo?=
 =?us-ascii?Q?r/s+K9xbfE4TExS24YBi2tM7IoEsW0i9qtx3b+6fHm0D8HSSc/R5cFitmgzy?=
 =?us-ascii?Q?ONmEMxr9y/mzophCJgTaxuY5QQbu7s13sAeydf+qcJm9jG+HGc1W+wYe4Gen?=
 =?us-ascii?Q?dRrAWg6rBsbsldUUuA7nHUop21sUC7kvlL9H1T/P4TKSMknENFiTKpcZj/oL?=
 =?us-ascii?Q?yRjgWUMp0VcxnsYJxl9UspPqFndaqku+ZaICBP8gzD9VI20TrVRWOGb+A3fS?=
 =?us-ascii?Q?Kl8lWv6w7GD+wRRIl/SLN/b9pAZ6IJSR6p7dhCpcYgJ+ghO5uO+yuVGUbA/n?=
 =?us-ascii?Q?fD02ZGHMAQPQMOOqRXBgk6vA8ENU4mTSZcta8p8nJDlj4fkK6m12PvfswX6s?=
 =?us-ascii?Q?9pX7RhBLRDIr8GgZUCAioO08NP7e1FY4x4eOJqMd0B3PrL+D9shQ9VMnBIbe?=
 =?us-ascii?Q?E4tUJPXW2uiL7v+dVb6iwWLshqYdybmX2DJ6UTwIic0h0Tu4G5Onj5JAsr1+?=
 =?us-ascii?Q?ukOfcym4Uu9PqjfPe/sdPTvpGGxcrJOFssYMpvuGZOb8nlTXZA2E11BeiHYV?=
 =?us-ascii?Q?VELqiS0tHA1AT4BuEM/XPrftrBzLrhTTdeOQuPBu1CKpIbuNAe6/frnlY/SJ?=
 =?us-ascii?Q?9qWI3xPJ8Ojz+TZi1WU9AAn+FZuL6770Le26WICArFQ0Pb/fYBuIDHPxx8he?=
 =?us-ascii?Q?0ddnbHM2nnt3y9LzPXz0fVl63+CxANRV+Wx/9m2uiCb2txj6HfeytDU3iVYi?=
 =?us-ascii?Q?0AS9xHtULHLsBT0Wh3anF8bgKuZTL6x9k4kBZNZvWDCRxivZ4udys5A8qJk0?=
 =?us-ascii?Q?zHgt20H0rHoMY+9O5FBiAEvLn8/MTlHQ/hIf719r5eGM3M1HkoBvd9uzm3fo?=
 =?us-ascii?Q?SFH5k1KCBWvrKPXN4EmUhmNlp6/Er1dd82iZiiEaIZXzzu+ZDISAfRu+Nq8L?=
 =?us-ascii?Q?3eHriTjOl+WnklJL44PjjMiCOQfccoH/qM6p9NXo+NCf0yE24YpBx+Z+FPRb?=
 =?us-ascii?Q?LkjMGu1haO+3UveY+vxQExCGO0ZV7d0JsZl20gFAItk9JqlK67eLw5Ke3Yp9?=
 =?us-ascii?Q?9orQtaE0+wj/kF3mL2kT98ME//pmQ9Ai7QlG5GRZBZm8/kjd/kS3imhbT896?=
 =?us-ascii?Q?I+Q1LB8pAqsnpJxu19ZVa3ZpTWXBaXhWuDfP7A6BAm07GFxGTxfBkNpaSZwf?=
 =?us-ascii?Q?K1n+ZA96hoAEaYoHLGRoTHvbPigxeasGiupk7KiYA4fTIXReLXDNFKIGehrs?=
 =?us-ascii?Q?zhvveXrTMO5AonGJKB6ZrnnDwYmeAe3xSP5yvrFyLZVnfLXOaEjdze/H36cO?=
 =?us-ascii?Q?nt8PBFw4tcwYxgmBk7hgOeqS1ij8L4eHLW0YOUIG2V2y6owL4YIjPdwHO+iw?=
 =?us-ascii?Q?p03uZiNlRMjSH4RNLE5JjLmyPxOJ5tl6eyxdp1PZdTUx3uNLz5o8BuWADkzI?=
 =?us-ascii?Q?RGE+6twHKeJvwiIxH6GSOtASBScHJ2VZeMqFr3qXFzZZ2ZTsAJXUJIJjC4ZE?=
 =?us-ascii?Q?s9xMmQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa885cc-3d70-496d-a2fe-08dc11cc0668
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:05:16.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW1X6rbMZ+/drMyafQmy2sB8OUFMO7YtWgqq/90mus7Bpc//r5ivYwmgDqgVJZuAmL3fGSF9TvL25W+CBIkKo5TCjpp3z8sfsVx5F68Rgyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5990

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


