Return-Path: <linux-kernel+bounces-5425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6EE818A91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7687F1C213DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86795210E2;
	Tue, 19 Dec 2023 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bTUBBNeU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED831CF95;
	Tue, 19 Dec 2023 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnHT0SJXLdIbsKol71hWR10ZM0injcyQ//3IecxHgSHtktW4v6VMwjiv6FIHK8tCICIqXmcelfIVCkBLfnb047uRcdSh05dJNvcseSSaJct/nZugWQ+/qOxI1V3os3voYHWBUmjdPNiX5vIm4GPDJondeAzr9MWCjVACXA2dMXbXFuhipJwrGpvq4swOhKJ9YScK+eneSJAEI5ZRWhuG+ezoPoIkZp47EhoEvRAe5UZtb5GafqAfjzCAlSfmEZcZ/GctxI+NcchMTEH2lLdNBFRXzUpYKgeKZLK/uL5FJFAsfuhDdgBzGcb6Oq5XU5p3DMhTGO/fNSgM/8k+oBExKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOaeUvv2OGjlns3/7+mNuuFcedn6gLueyzYkqwjM7qw=;
 b=Jdpoedo/7YF2Yoyyck0d6x8zShQrzLtNG4cgkVBJ6B+2YJ7TfBeO7mqX1z7WJhijYAwLTdeI0/eTY3axkf3ib7iO0fxxbLxMc86V7MXQlbe8aKIgp64HuB/84puoIcgdkYot7H0DYR3UcsFVA8fm6rAD/fkpoVMkoyY9drq3omFJMtR2xLCc+d/AGGv+MEYWCECWMIt8/MU8Mdg8O4DXfb1tLoAKpNIvMBj997hL+0JoGlgz5KIPoagjFpw/Ppwr6kx3DNTF+cMQne5MeRlb/v4uo9QuwR/by8rOyDYCXWRaFB5jToJv7G7BlkG7S/yvx9XXwXxuSG16UsAFn0ypLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOaeUvv2OGjlns3/7+mNuuFcedn6gLueyzYkqwjM7qw=;
 b=bTUBBNeUEr72Wc/Tl7MxoGrrY0lPD51cQJ9/2cSivyCdU76Hyz0+OQ7U2DeWNn1ph4MPegJv5jg2qznJoMcj/xfk4fEUG9KEkngbD3NQ+jTmUvTBRdgLEIyIwMcHRzeQAY285iK/gH6AdP5IoolwMEEp7qu07yO9Tm6Tll0r/m0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 14:54:26 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:26 +0000
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
Subject: [PATCH net-next v9 4/9] net: macsec: documentation for macsec_context and macsec_ops
Date: Tue, 19 Dec 2023 16:53:28 +0200
Message-Id: <20231219145333.240323-5-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: d39e6a95-9427-4d2d-6642-08dc00a26573
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aLD6FwmRZETE85LyKp3fEMV6wrB4aK7drmnX+Prfa/uII9J9yHAsy2DXTvKKCIIgIjsC8WUcBLmmvgaeNRZ2WGm9BtxRsrdAFJHsmqqra7fqygXOTDsVvH9AEyq5gFf9/TAY3QJVXOBc22bjbNtribOSzBPIA1ieJBa5zJ+td9S6whYppBgibCxcstS4jJi8cc9PbH2KnxR3uNipUi9jPLI9yMfiymklM3+RhvLI/92Va1QhSYFhMRTNVmbnzn8uKLwPaCi4rXs2Q/J0bCw6G1/f7wNvaCyK7UYC3b1sbMhVwhWcpNrcHM8o2yhSBEhFWA82OvTP5Kp/rICuAWofh3APKtdlM6NKR/F8ruTM4FGHQny1mSnHBbFqsxgKjJzBfAuGd6ubMF4u6oFIplvDHKyZ3ve63EPk1Ucxd/U/qJPF4OWBjTzDizv4MnCoxVGLiwkrWRBBV6oJCYkxlDcEmBcyRRRFyh5fr3oZNX0Wlc6sy8Q+d685Bypl+nHkKf2wCkPYF4G08RHEva/iwdVfyqTHyNCPfdNR/O3JJjnu7ZZYuWnYWC4SGoXyUnUZoMDoxMCbtceAim6rIq2RpGpC9eenxAtNHyp96zyw3IjAuUgmjAs+Bf1CF+uBqydc44ln
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(52116002)(2616005)(1076003)(38100700002)(83380400001)(66946007)(316002)(7416002)(5660300002)(41300700001)(8936002)(478600001)(2906002)(66476007)(6486002)(66556008)(6506007)(6512007)(4326008)(8676002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C4/i98Dx7TIY/qGbrizFMQ9gMHD/f6NE9pYgXygQYZ5risbKePtQUWl20T7u?=
 =?us-ascii?Q?7E00a02Yybj1A99rz3bU4Lkri2+3se3qKh+cz2v5RJ2StwELqjEsT+p3FqlZ?=
 =?us-ascii?Q?Uf56KcFL0NPkZ2Y3DwO1q9Wdaz0K4YRz6qn9OCfX19B9N5XeEyMKLFehXUg3?=
 =?us-ascii?Q?W2d827BoUc3Ym1tS7qqZnsxwf8b94lOtieY64ROAE0gXN+BaYgw/Fm2WJRuH?=
 =?us-ascii?Q?1BItdbfEOiyAjTyBQ35qYHLakVtxVDb8WYc28EShnmNUH6PjNbLMb+3p//Se?=
 =?us-ascii?Q?0lrVOgSX5pT8ypXhUarwDT4wcJSFbrMB8s0Qbq5hynEqFGRcQ9xgVevEgkoZ?=
 =?us-ascii?Q?xZQVzCKlmf95NdeidunMGtWapxJmSGjApTN0OtMjxyyjSoRf1g7l+EG+UvW5?=
 =?us-ascii?Q?EQZZ4wspkPBa6+A4E60Rhi6INi+YOJs6fMq5WZeL3t4OmKOkZO/AQHINDY88?=
 =?us-ascii?Q?6reylNrY0Y+Sm2ZnYSPG81hxkOOs4hDwct0hBOdpY6NJjG6yHFSuQQ4ZtzJ3?=
 =?us-ascii?Q?VF9Tq9w00V+ZvsGcrVwrscELdJBdUPOKyuNNdGYwXaRfc4p6vd7Q6+1az3QA?=
 =?us-ascii?Q?PS1oozHCnhzzFUOSYzowOqC0lKFfvqCQkdiN48Y/dpqd2hejhOplCk78ABfF?=
 =?us-ascii?Q?+v/GchEw8jU+9mbLgoSdfpk3x/D5K61o2Uz1HOJkdk/FqtSX7FF5RryzyFoP?=
 =?us-ascii?Q?y5QvnwihBkODEnsE0fWgAXRRsPqJ09L5CUw1o/7Wpv1GB/x61UdFLnSOxUGd?=
 =?us-ascii?Q?W7BQKRRpYrQt1s4I3a/DgfnubjyfGEU56OAETD+Pl3uzuCjdClRp9Km+kZ95?=
 =?us-ascii?Q?pd+z/7JaSPI4lTmwYZfz6YMJgG/oyiU+YK0VhdqtNSKMN+g5DkqGCQ8i8wN+?=
 =?us-ascii?Q?BWz9VuWJbnBjukTH2cS0A3jnPiLybA6ahdb+S+RBR+f01toQxbldtR10Wqrz?=
 =?us-ascii?Q?zYhhScIiR773rwINADkRDGJIOp7TusP7S7YQUX5296a1LEJ0IZCDq4wKG/aI?=
 =?us-ascii?Q?VMPzw8gn8ARHxiEX5Qcl75l/z/vYzm0NtAi7gSgA9BHhmatrp+WfPX0h04gX?=
 =?us-ascii?Q?Ow/UaPnL1sadVZo1myY/8qy9xjMXv9dDgQC4h17FAi1BcG6/KTtGcVDfNfFm?=
 =?us-ascii?Q?fr44ZNsOi+1unDPi08WD+7Q8Helo0fS6+noa46NebHQyoXnwcyfwHvwYT8rD?=
 =?us-ascii?Q?zARPg8EP4nTm529zsM5/rpP+guwCAwYz2Qzgy6Dt/yS+R0N0cLkgZW2bky/p?=
 =?us-ascii?Q?67pEVqL6GoFPohEH0S0M9HnDi9WZt8UEs9i1qpacbWIHnH06GaITdBWDg5se?=
 =?us-ascii?Q?CmWiGqrMCM6fAlhCb0anern+TCbTLoN4UdFhR1Lm52zKjdofrmCuvrAnU//F?=
 =?us-ascii?Q?aRlGE9sQhUqYdNfxaoejv4Y17mcxo1WMS7oR2S14KjSdmfYg/yUstEMIN29N?=
 =?us-ascii?Q?X9vqsdpLflFKep4bVS7n3Nh4Tm1k5TKH77VMp26gT4h5Wa0x5fjRR7mIvYay?=
 =?us-ascii?Q?7otLLEpW6orOcYPFWf3Iq4nwiiYkd6UWdTi5VuleTY3M92Xt+89MhEwaMsdC?=
 =?us-ascii?Q?KMUVcXo20/xbzh9HIb0K5B9f4XqjVQelPZ+TsymTNBgQUiMJ3fCPIHCzh+Lm?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39e6a95-9427-4d2d-6642-08dc00a26573
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:26.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQkwwKaLLRuHYQgFF7D55dKnRXS3cJl6zMgg1le0iJQwg8kvyH24smE7I9S5mO0ygAZTDyJWJrVFzUriTxNw6KHleCyaEb6STMgPxEWRQm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Add description for fields of struct macsec_context and struct
macsec_ops.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v8-v9:
- none

Changes in v7:
- added update_pn description

Changes in v4-v6:
- none

Changes in v3:
- improved description for the netdev and phydev fields
- fixed typo in mdo_get_rx_sc_stats description

Changes in v2:
- patch added in v2

 include/net/macsec.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index a5665e9623f2..0821fa5088c0 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -247,6 +247,23 @@ struct macsec_secy {
 
 /**
  * struct macsec_context - MACsec context for hardware offloading
+ * @netdev: a valid pointer to a struct net_device if @offload ==
+ *	MACSEC_OFFLOAD_MAC
+ * @phydev: a valid pointer to a struct phy_device if @offload ==
+ *	MACSEC_OFFLOAD_PHY
+ * @offload: MACsec offload status
+ * @secy: pointer to a MACsec SecY
+ * @rx_sc: pointer to a RX SC
+ * @update_pn: when updating the SA, update the next PN
+ * @assoc_num: association number of the target SA
+ * @key: key of the target SA
+ * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
+ * @tx_sa: pointer to an TX SA if a TX SA is added/updated/removed
+ * @tx_sc_stats: pointer to TX SC stats structure
+ * @tx_sa_stats: pointer to TX SA stats structure
+ * @rx_sc_stats: pointer to RX SC stats structure
+ * @rx_sa_stats: pointer to RX SA stats structure
+ * @dev_stats: pointer to dev stats structure
  */
 struct macsec_context {
 	union {
@@ -277,6 +294,28 @@ struct macsec_context {
 
 /**
  * struct macsec_ops - MACsec offloading operations
+ * @mdo_dev_open: called when the MACsec interface transitions to the up state
+ * @mdo_dev_stop: called when the MACsec interface transitions to the down
+ *	state
+ * @mdo_add_secy: called when a new SecY is added
+ * @mdo_upd_secy: called when the SecY flags are changed or the MAC address of
+ *	the MACsec interface is changed
+ * @mdo_del_secy: called when the hw offload is disabled or the MACsec
+ *	interface is removed
+ * @mdo_add_rxsc: called when a new RX SC is added
+ * @mdo_upd_rxsc: called when a certain RX SC is updated
+ * @mdo_del_rxsc: called when a certain RX SC is removed
+ * @mdo_add_rxsa: called when a new RX SA is added
+ * @mdo_upd_rxsa: called when a certain RX SA is updated
+ * @mdo_del_rxsa: called when a certain RX SA is removed
+ * @mdo_add_txsa: called when a new TX SA is added
+ * @mdo_upd_txsa: called when a certain TX SA is updated
+ * @mdo_del_txsa: called when a certain TX SA is removed
+ * @mdo_get_dev_stats: called when dev stats are read
+ * @mdo_get_tx_sc_stats: called when TX SC stats are read
+ * @mdo_get_tx_sa_stats: called when TX SA stats are read
+ * @mdo_get_rx_sc_stats: called when RX SC stats are read
+ * @mdo_get_rx_sa_stats: called when RX SA stats are read
  */
 struct macsec_ops {
 	/* Device wide */
-- 
2.34.1


