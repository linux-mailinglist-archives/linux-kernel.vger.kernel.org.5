Return-Path: <linux-kernel+bounces-22039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3390682984F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6AF1C22358
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600F47F47;
	Wed, 10 Jan 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XyixGhcg"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2112.outbound.protection.outlook.com [40.107.104.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C14778B;
	Wed, 10 Jan 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU++4Fp0M5F0kWvtX4tlUkbRfPjSk9DlwAQEEVQdaCILZ2kZmJoncN1BPRcIKgWmXISEran8NatzEnDrr6ti7eU1J4vXktb0x4WJClDL9PDmjF62somZJA0rRoaIZyDumoOrluQvup/gljiDk9vsxowesmYCNIEfgvCTds6ffHHd7VCj2XvR+0CZQaA+0aiwlSnTzNz9fdHTDR64ypBF1fSyb3xNrc1f/nALw1DCRxDJR9ci/bx05vnVrFxernnSRLJiXlmJNSOGR1rT3yY5aKU18VviTgUroIhn/QT+dQuOuAZvi6g1kw5jEdQXCQV2oP0hHWCXMqr2yCr0xgJoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4BfzmwSxr4jbT6fnQLS3qcLXzyjFaelTsxNum5s3BU=;
 b=kunzCpWgtbTAf+FjfGV+Uq4unnBi+6LVYQnehQSH/ZvDjqJTNoVS3fhWgQZvGq+obYKl3hK/jnZXa/A2HZ3Caj0Jm8wrQWOArNeZhFaYR7RWliVGTKuuLDqGYWXtsmbHc5jVygIutL9u6K7s3RPb6Cix0GUgA6DsJapGsbIKppM7db0lE2TyEavq3p/TSzQk4sbzUv4bDTlwC88dZqx/Olk968hH2iIA6tL9i1VNiZGX3t66K9D3CBLyEhj45Lf7aDguJNvd2d8TbbCIGEQ0tnfWQHYs77uyxi7jq5ZLN1j1qUIhRElHa/zzuwHfYCVVKlxII6ml19Gr+63MF6w9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4BfzmwSxr4jbT6fnQLS3qcLXzyjFaelTsxNum5s3BU=;
 b=XyixGhcge53RYl9yU5J1i63mo93WLFiCWLeSrlKQ4Iy0YcwBO7rpHl7zSbreYtm5VJ8ufIzYG4JPeOmsly83RXrZ2PBvkl/GAyldmUHuRNhMDg6o29MaeVNiMzf+vbRoMHa487txYUFz/pT1mASGpj7m4x5NwK5DgAwbCymY/OYkJkchV1bamQZbWXm3E2DJCbJcfNdDwxil7q740J0+11WIf5hZ/ywNLVT4GUptIFZHNnW949X6PgjfI3hNTwr+iKkBHVqh3IrKDGWYFITPpcjHSMZ/YdxlVwssvAY+IYCYkzqxKf+bCDSGj+77Rofn8kYoeE0oGEFlzRt5/Iac7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS8PR08MB5990.eurprd08.prod.outlook.com (2603:10a6:20b:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:05:18 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 11:05:18 +0000
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
Subject: [PATCH 2/4] netfilter: nf_queue: remove excess nf_bridge variable
Date: Wed, 10 Jan 2024 19:00:12 +0800
Message-ID: <20240110110451.5473-3-ptikhomirov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a1a5e26-d572-4c67-f30f-08dc11cc07fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	69tJsB7otRatboVOXj/f2lLDRgek7DXIKccMwZcrL048Ss6WryJyxXbT9lL3pvrbzeXjfGYo5vz28v0YlQqJx72UVgaB2gh+2CgftI5eR84EJNrMt6DxceEczCDTaSEr/TECdYgOoAeMnAvAXuWAfV6Q8LeeIVNn7Oc0aHPidETKszfJ2tHf0LU1LymQBQfS42TAlpMwC0TS6SuzKh+uDPxnmfu3fG6tDu8V4sNNAweGvOCEiks1ZDfEYJEslwnUFhgKF8+Nb2tJGptSs8oN0GQfP6gbEYC5HK2R++vncPlF7g+bGLCRIhe6w2dLKbTKnZxGSNrE6mbgYq5X+gpS9edBhMATAuTVZKZUp9FgJhxk5iqCzBfoLk8lCzVYRXI9n0mA+ly00VFdhMOc976mNbRu2RQRVDcezVaPg5iJp/WC7wO4oNq/UfL0/G6F8Z9rnIdeVTvAvONzD2RDxz+vhhqWSjy3/U5fyVxqykGAgCirOrIrwvielCsyFQFqs4gLLtTmN4baYeeOYXUlIfQ8Y2WFuJRjFxCt72JCaoxQ1loTR1bqHS/mM5eLOSYlXLSA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39850400004)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(1076003)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(4326008)(4744005)(6666004)(52116002)(6506007)(2616005)(107886003)(8676002)(316002)(110136005)(8936002)(66946007)(66556008)(66476007)(41300700001)(2906002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hkrJ1rlJBmOL54YRBQe93sGySjyXSOnTcEtWIZRT74i0kKcKeaeQWWIEbLD7?=
 =?us-ascii?Q?OIJ2dZtMZNObT1JfW92fqujwaLmcfB5SiE+87PzRGEKKZ0qvp4Z6gpu9p8wC?=
 =?us-ascii?Q?Q+Mwmsd39ioojld0BsermzQ39ALPsp1VK0FPpYfde3x9Q1Jy6gZVnvPWu1jR?=
 =?us-ascii?Q?jK8R8tbQKaDSZYHNyyAMNZO4vu0JVT83K9+sUCmPsOH7SnnVpDHkr2J9Nr/e?=
 =?us-ascii?Q?CtkeXxPGbnDl8MgTSX0yAT8Wfa+ieWwgPQ3eJHERJ30a3ZM5awJtNVA+ouSV?=
 =?us-ascii?Q?8ITdTOQ7fIs7SWX6mico802tB/nypRG90dXE+jHyavdgO2qnzzTdQXM64AG+?=
 =?us-ascii?Q?3pMbYdKErNnIzgWxZS/do689VXRs86zU5jGyGJOwy8Sn78awDbRgkkPPgoLv?=
 =?us-ascii?Q?84G8QbvxiM/4E3EhikVjF9KqLYIzNbLTfJir6c2ByIQvEbUyAt2skaxwKtbb?=
 =?us-ascii?Q?0rAt+gYp+PmN+ov85vL6vsLBA8hQPTZ01G8vWa2ylsNBq1mso4/l5qMjZ7Je?=
 =?us-ascii?Q?bX/HnnmmXi8Jer5E7Z4yvU6nwKDt6rg+QyPRfR5eSq8a5vmul0qNxeRPeARe?=
 =?us-ascii?Q?nokK8Yw3XdmBao/uZqng+9nExCg4x6+DDb1IM7WnUDPM9Eg3wgR3Zy5NHMZh?=
 =?us-ascii?Q?3MjauH5gNr9F7t2ActRRADxZDcgInIk0mfR7zyoxo6YBrVUTLKFpn1zJUlxn?=
 =?us-ascii?Q?I1azMy7tpOrOJw2eTBcwEGcfP8z2O4PjjmGd2Q3A9TTG9bGLSz6tVS+JSLls?=
 =?us-ascii?Q?w4s1T7TfEIiDNiX0bXNkqMSLiKt8f+qpHy3yq91BAjvKgggfr4rXofqDQFXv?=
 =?us-ascii?Q?KPu/jdQ0JKFHzRUApyxU0PtpOG1ByGrL5fHgm5mhb2YlGBoEJxwqBUcFxO6o?=
 =?us-ascii?Q?PWApp2ACZX/mODwgA0H8gR5yi107gVW9NFb8UosXUCAP4kwV0MNXaGPFgZxT?=
 =?us-ascii?Q?gbOvec/fh9IiQD8075FDwzxa6k9BfpGssBoSZhbs8632VKxtzCCneQzWdK7k?=
 =?us-ascii?Q?Hc1uhgn4lgu0Bg0ahYKH3atmo5Povc5E4NbzqISI7SFkw+Qnfd/pRiZ38bhe?=
 =?us-ascii?Q?zmAJ+x6v8MPOomSTQduW/X7L39ko7n4A3IqdTlV4bDtL1w2DiMCFn8gNLfK1?=
 =?us-ascii?Q?i5gCXTPeg+NIfmsXBlL8SlJ+D6BG42NGLst/aczSFuzjht60XkLTJe1ZlINA?=
 =?us-ascii?Q?hMG6abxd7kH7TkI0NKzZAGDf+UmOzZXjRonpo7ys31E4woecuvmZMAER8UB/?=
 =?us-ascii?Q?PoID2M22Ep9q7Qk36DPyl79TshennoMxGL9XyyydaQ7dx/IiVX0vwwVy6sx+?=
 =?us-ascii?Q?/tVgLo5xR/cSswxynjkez28yKfyIjxOumEa5jRdgZGVXp18QqAxWLyP3rtG0?=
 =?us-ascii?Q?DcMYKPSieEjgJNLn/XoW93aBLYonvaUB854LtDJZJ6nz927fHZMGLzmHpF4W?=
 =?us-ascii?Q?JynoCG2lGIot2vXh9jElMZXnyGkxiq0ffC+v2E2+PrtOh6PjKa4JrXZyUdHd?=
 =?us-ascii?Q?9feQ0QtkvjuB0EnbFGYVdwSFG0Gez1N86tsafQywN/EK4msAaoAE9qhg9yRE?=
 =?us-ascii?Q?zkKNnpO7oSvSeR36jyODiujGd1V6a1bVgoMoWUsCC+cvMpERvmLOfF8uW0dP?=
 =?us-ascii?Q?RWRJVgoCOMuSsy0aAVodl9HCvDCokYjy1zOevK8oFTnQZwggRcfe08+kcG2Y?=
 =?us-ascii?Q?jW2NqA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1a5e26-d572-4c67-f30f-08dc11cc07fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:05:18.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUPiaaY8yMHlDPm9yHRYadVFX2W3JcZukoLQRJhZa4wuixTm637u5JfNUkWyBY90eA/bHS20gdin4j2FWbsUqZhURVbXJ6sQxMV9n1rQQi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5990

We don't really need nf_bridge variable here. And nf_bridge_info_exists
is better replacement for nf_bridge_info_get in case we are only
checking for existance.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
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


