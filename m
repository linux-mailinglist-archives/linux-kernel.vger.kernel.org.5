Return-Path: <linux-kernel+bounces-5424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCB818A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B6B1C21856
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0551F94C;
	Tue, 19 Dec 2023 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aRlXfdXk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F921BDF4;
	Tue, 19 Dec 2023 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAcLHzAn5EaXf9yqtaKY5KTrB268LcONM/u9fESOQRSDbDEOwio6ylmBGnk8a+g5221/9XNeudoKcXMpH6r7xYIVpxj+zYEFZf9hgdan171cFsuO36r6BsCLlC6X5sCWF3Xe2mKVeUjxKTRRhV0LpSoMi7v+S02qj7ig0g5nPHd/gAJnWF1WZZUffew5BbydxXDETY0bB9Lv+nQLIQ4Vso29dResFifDhUs45/0/YalHNYM5Sk+MJqEQmhvZXSDsnULs84/2ufunyEfe6PI09zV36ATPtftg20eEICxXQbk5BPe6imkFH+gFHsprq3dGFS3MwJEL95suRS5ygphggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAVphSyxLt1bXvJ4BU3IbC89cPoAgIiskgu/nHHmjRM=;
 b=A8szjxUbVc6ps3XZucS/u8C53b4GXWelJLaF6MUYg4NftIEeDyqwy6nt8dXGpUq+Lh/EbPKxihrISWcl4Ejfu6rqHeST6QmM6ExvPYUDZ6j3GjPAj3k24S6ffAr9mdTuZk29EVH+L2tF5hEA+hQBllIZx73oZr8HwsQamv9OOpRbPy+SrxkYsL3uW/HjaSoYDcz6ZkPybJYw8ebD/JVT5XaGxVvgVypdbyGApgwpeFf35nqrtKe7Z5kHkt8uccgcXtrP1aSFHJVqMbZ+bgp5SKs5DMNpz1utksXsKmVDbFx0yWH6TXhVtlNN26pcoY37i6uu0HVafLQeHLCUFXCkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAVphSyxLt1bXvJ4BU3IbC89cPoAgIiskgu/nHHmjRM=;
 b=aRlXfdXkfeSqQeDHB2jLoM4gyR+QmHruzWHyTHMupQaWKWT6caNzhBIBcxtD+XYdOEIenv0e8F6PV21Nx3LuAfKYoQ+d1bBlauzwb1NrRU/bugUvNZS38Vpg/7D+Ejl2XcMmO2eFdAFCwtU0s387j1G+gOBqOR+9arXE963OQOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:54:24 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:24 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com,
	andrei.botila@oss.nxp.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v9 2/9] net: macsec: use skb_ensure_writable_head_tail to expand the skb
Date: Tue, 19 Dec 2023 16:53:26 +0200
Message-Id: <20231219145333.240323-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af019e2-33fa-46d4-a9f7-08dc00a26438
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YX89b/W54H6nea1xkNwT3DJ0AC2Cw6Vlf7DMyosvJBiuMxSoEWfx2Dqdo6p31LSou9rqUJjYGrTxdz4I2AoT8dQnWiy+jDGnnqd9ldfXu0O3iopb8TeI86Il6oOERw/wofVm3zAqPLqrAIsMyy3zx5QhOB5XzEghEAtBYvgBviTqsKMhfi25gDAis+GKsLEkli+obhqDfC2wfwbGl77KPqhDBDe5tEaMTL9mmKsr6mhkK2s3lwbZlZ44gDnGTeHKsWH2uKLgaBlqpcPqkOtA7IxYcpO2nSkELxNjIG4n4+9XOvr+9QyJ8wnToW7L2CgTmPEcJcENc9zeDbfhKdEsxoea6qcgJS38QLFlCbHuahN10P114gNfsJoko0He72rws2ijuFMc1aJdv+WCP9YwIc0pBV7PjGljcHOHkaLHaf9bRHDn745+j1T8a5508FPdbGomEi0Bt65264Iz35YFX1Rnkv2g0R3pzJa0Brw8/GPRsPhwUY37tNhyB4LHzqaE8mRaOow7hYGtN0aGsb1P/BMlqDko//DBkUlV+vEPIRtOpLmNgjt62eMm09OpR+1ePo4ZFriIwDpF3P7hSg2wSIBw/YL1lDccoS8c8OB5ggOZT5+VaqjUGRuQmomicZE0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(66946007)(66556008)(8676002)(4326008)(66476007)(8936002)(478600001)(6486002)(38350700005)(41300700001)(7416002)(86362001)(2906002)(5660300002)(26005)(38100700002)(6512007)(6506007)(83380400001)(2616005)(1076003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?58HHjxlzYdAgOqWuotoHjEgDkPGfF4pMrw0cfJhGaWx/kBnStvn+ldjAEQUj?=
 =?us-ascii?Q?0cybOhBPB56I8ySgrSpLKG5ScBOnrgOtz8zYP65YNhTew5/pjoDSdL1sF2pH?=
 =?us-ascii?Q?npLfmLYF5JlD7jKLMlnjZwOQh7v3QAHNySAKNPUJKdoEdSXP84ZCcSQaz/J0?=
 =?us-ascii?Q?xYSnOclssfC/pqo6vkOi2l++LdUUf8vxtTCU4IaBhuq32BTsrbSxjoXtldD7?=
 =?us-ascii?Q?dptTcHA9d8uqrXfS2HRlPuthhS18xkrbS7ecOkKHio2Ydiu8QyzBRrt8m8Lr?=
 =?us-ascii?Q?mehBmy6JFPvbeV/PNk6WhG8ai6EXDAH0EX/wyCqklJPZFgPJjUVaonaVO7I6?=
 =?us-ascii?Q?C5d+c30VDoRgZvy3CmTbFZkUv4RxWrXrDcqnDGBRp4SdKRo3onKLt1OsKSzb?=
 =?us-ascii?Q?Hp6FvM68L/zN0Xv0HGf9LcucjKe7qtj0yHrqgPihwY5lyxur4+sVldk9iJ3g?=
 =?us-ascii?Q?JutQdi0y7WHb4iXRD2o6VAn7D91I9+QlaGCD8bQ7O3cwMPavAc86BR91X3bl?=
 =?us-ascii?Q?ulOw4tGjl5J9EX6vFLAjkNgqrJBsFBGUX5BMWkgkjbVz7ClH8ipJa3TIwGjZ?=
 =?us-ascii?Q?blbtP4ILbzqXT5Fm2bi60JkoV1+jKAL6BblcrOH3Pphwzi9dQBdq7+hVd8q0?=
 =?us-ascii?Q?uYYEdRR+BH8wbYy0H+4RbPxNY0x18cOFtPVI6Z9oTEjDKGXZPuYPf9m58rE7?=
 =?us-ascii?Q?49B3CNeA9TcMNn+JBHv9jV57ULAmjqcmHWvaavKtDPyPGebrDUhjxaHNNpHa?=
 =?us-ascii?Q?9WV+NIvcF0zpJO+IPoyHS/8d9BrmWh/3Q3ElmnSC9OgKAdbtFtFs6+lBLgoz?=
 =?us-ascii?Q?S9QMVhQdvoh9h/oW170HL441999el1GRFZCjFsF8sXhACRppdYQAA16f32PW?=
 =?us-ascii?Q?OVQ781XQd+9EtDjTWRdxdZYvWwxQyPbf/+rxiAIm5eicCRDkTV/jgySVSjce?=
 =?us-ascii?Q?uNwmcZF17KtaMNSw095T67zI949zEm/NNJ3ya5PjvSH7KJPFjmLHrHqlaFVm?=
 =?us-ascii?Q?LWN5BZB3FeywY/QHuBbA6U8PfKzi8VtxurqtbWAcGprbohvumd278tQQAhHI?=
 =?us-ascii?Q?5WkNPW2eiAsaNcck9w2ppo5K7GzcNYdvJyi7DqGxnhaCKHGP5dMFVymwlQjw?=
 =?us-ascii?Q?Xnal+3TJtX3geQ+pXBvf00d7EjxNJhba4cQBKMs7yA3V/3z/WpMGTTBCtCRH?=
 =?us-ascii?Q?0stLDM+KKPSjcc5M6q8Y7WDKTU33Uchpv/6FFoRCNZFXbJa83nTd5BxtoGW/?=
 =?us-ascii?Q?E8Bavyl4VAPa+9PXC6zOicLJjhjflZR0qMSaFaB4gpZ2IVcYmPGo53LuVB6R?=
 =?us-ascii?Q?AAQT5ZxbHUTOXzVxOwgOyW6+iZdAVVsXzi6Y1xQgPwmgveRay1EergvufFoE?=
 =?us-ascii?Q?x0hUTSUpD83RQjtMW4Z1UJK+wN0LY0bTacut7HQTYQBcRj6LSD8Odcx9UPhN?=
 =?us-ascii?Q?lz1NnvYihW/XqO0GPzy6AVYJX066h6nYkzXS346y3KLV5tfeS13w3g2PFHRL?=
 =?us-ascii?Q?O9bJ4ioinoxZikiP85J+w35d/zsdkODLZPCw5p40XqSThE2BnjJuldSWh0pU?=
 =?us-ascii?Q?WIkJcZycW0J0phNsS59bogiCZHxOXaWhvy2IWAQAhopLS5Y7sUeh4XnC0Mp7?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af019e2-33fa-46d4-a9f7-08dc00a26438
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:24.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ulg5Ech0zUbT5Ami1TlqlkgDBdzq4hUXLCG1BkE/NHlKZBbUft4t3GcsMTE5zLCyzEV8/4VPP2YtfJjGAxDb40Jbv7s9Dg3l5El8n5ekBCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948

Use skb_ensure_writable_head_tail to expand the skb if needed instead of
reimplementing a similar operation.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v9:
- patch added in v9

 drivers/net/macsec.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9663050a852d..972bd816292a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -604,26 +604,11 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (unlikely(skb_headroom(skb) < MACSEC_NEEDED_HEADROOM ||
-		     skb_tailroom(skb) < MACSEC_NEEDED_TAILROOM)) {
-		struct sk_buff *nskb = skb_copy_expand(skb,
-						       MACSEC_NEEDED_HEADROOM,
-						       MACSEC_NEEDED_TAILROOM,
-						       GFP_ATOMIC);
-		if (likely(nskb)) {
-			consume_skb(skb);
-			skb = nskb;
-		} else {
-			macsec_txsa_put(tx_sa);
-			kfree_skb(skb);
-			return ERR_PTR(-ENOMEM);
-		}
-	} else {
-		skb = skb_unshare(skb, GFP_ATOMIC);
-		if (!skb) {
-			macsec_txsa_put(tx_sa);
-			return ERR_PTR(-ENOMEM);
-		}
+	ret = skb_ensure_writable_head_tail(skb, dev);
+	if (unlikely(ret < 0)) {
+		macsec_txsa_put(tx_sa);
+		kfree_skb(skb);
+		return ERR_PTR(ret);
 	}
 
 	unprotected_len = skb->len;
-- 
2.34.1


