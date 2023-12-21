Return-Path: <linux-kernel+bounces-8799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43F81BC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838EA285B07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB026350F;
	Thu, 21 Dec 2023 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONmXltIa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC1634F8;
	Thu, 21 Dec 2023 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di20RUglnkTR40FVPLINJiUKyI0tUGoY4mXMB0rKT+Qu93PcHExbkebEJx8rKrEEAOIAbv0/e3mfcZ0n7FVO/zj+UjwkvbDS7pjD4Xe2uggfSMw/gOSUsgUgSX938dz+LQYDuC7rpfxK4q/0nt5GiP7oI148Mrj/GW5SdcauNAVD3d4hHQQvQf6nsO8hWgpjVAXQEojfBsIIzhMFDojSDDuazrbb8Gm5FxdWRkv/tZ+3zCZi/TeWWBMJQfQwCZyCcPkhbbTgjo/rB078V9GfvUNKfE7trPMBm/a9+I48V9fJu6n4evLCk6jVnchLJhIqEaXU+7nt9ZmwAWyLGBk9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uU/DgeUPYPON4N4JAteu/Ha75T2xugBeu8V8eh6toY=;
 b=iarZ9iICei29MyyzmRC4Fs7YIfKU6G2SesDb+2PmwvL8fwljDcsemUZLPRPJgBjAqgoMpBEYIy/c2d+NNA1ezJ9VDUIVf+T8MWdnZy5vT2fb9WWErXBT3+40h2R5+YY48Gf+tUgSb7xP1xlIyBMMJusWV1VsRiuApyW3apg1vFw0+0gQn25QzSAc2amIiqVrpFmJZI2OBuV4cXwUsSgK8Dko51yb898EmSpRqldJdtpkP7f5ivnt9Gk5x4vwiA9QKnJzrwdo9XIJ8rbI+9TEI8quFu0Xf2GRJrpBbPFn9k0HkDBnh+G/MEP+co0yqd+QmnwG1kV4YxADt/pkcgGhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uU/DgeUPYPON4N4JAteu/Ha75T2xugBeu8V8eh6toY=;
 b=ONmXltIatheBfEKmaTmTngg/2qeGGGOc80OCZurpiTw9630ASqN3fjqUy35jRBAUL+iTGu44RHMtGHkueJTrzBOzUmdjCybNilARqb4VNiV5bQd+EZNJiHt8Qh07jmdIf0PFtLx3zb6tTKn94PGKf1hgUKWGJ+cfIzanyULTPA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 16:54:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:54:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: peter.chen@kernel.org,
	cugyly@163.com
Cc: Frank.Li@nxp.com,
	a-govindraju@ti.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	rogerq@kernel.org
Subject: [PATCH 3/4] usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg  enabled
Date: Thu, 21 Dec 2023 11:54:25 -0500
Message-Id: <20231221165426.1590866-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221165426.1590866-1-Frank.Li@nxp.com>
References: <20231221165426.1590866-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8d98d5-cf49-4643-2ba5-08dc02458b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WE2zLfTzEZMwScuzu+NVdlE5v9zOFvqLR7mySFaUqZgcS0gLhgqCc94Xqsn43MYvp1AE1obpLdHBj27ysEPdEpRpBthtIQV1yEynQQbyFipaIC0siosYQ3UtI0f5okOrqeydgW7I3wYJLiiAVeYT0BQ1YWIz3Nlj/2oHz4OoHYKAdw5GCMmF5BDmI2JU69/yxDDXWpI7Xj1fUqzjzsdME8GaLKG7zQv1yAvx4/ichRCH/VCI9xLxcVEDkxAs0LPOFca+WTiKGMM7WuDOSMaoxfxNHuptYRI6VjWUpgEIlV4QkYtEsUgOjKMUTHnVVcXYb1QNBIS/Hc5+2UCZUUVOT41DkZiH/purfU1ptiI0JfP1O9bc4jm9W+vFO21aHrv8EYgjlrVrGor+x1fWwBsN+tMHNaAw+hF6SF6w0OyH8IOzeMKlNQeWrGLaVo75egrV23G7Dh+DsPL/pzQLazPtNhYWCfo3FFJ0FcObtizoApy0A800E8g5WLK60EbOyMLFOog4EwO+AhRv801cnvphqDh4nxHrNLLea+vvernLhszzJADyRZYYx/Qz3ZNMFnzVLSRpXut3kBpYTZudnghjlWpwXCU9+/IZkosTLAD9QjKVFJqHGgMtXcwrpln263Fx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6512007)(6666004)(26005)(6506007)(1076003)(52116002)(83380400001)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66476007)(66556008)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y8jF0os8liuFVHaGnXzg3B0qfiiYY+zaf/8/GUF/xfKqNGqIn13wSILtPv8V?=
 =?us-ascii?Q?eA+dX+GwhR3bUOpNGfs5nofxf2hWhgj9Snbn0bYQOB0lFvVTjj9yv489E6HT?=
 =?us-ascii?Q?DoTCLyeSmkt1DgCBCnoo5MLQy9w8jlbq+gawsWM96OI/i6X6Cpt0wFVXwLo7?=
 =?us-ascii?Q?9wFgRL+9sh0En1r7hR/b79WpzE5WwjN1raFQHE9zSNp9qnTv3v6/+UhpLbdd?=
 =?us-ascii?Q?PHGASesCdeoXFlkCPuBLJiuO3gUqisefuLhTSJFP7DvjYEqcNEHcZo4mnPfG?=
 =?us-ascii?Q?jd20zjpcrVH5ELhhuCydfK5oYIjnxhsCy8JitRcTZEI2zDsgH65n3fNlIU2Y?=
 =?us-ascii?Q?SPidsOLy6D79Zsr24/uvEqU5CQRbxAnyLQzlTb7xwAOVmdXcyYt2zd9AhV0H?=
 =?us-ascii?Q?Q1cCazclp8quECe+o1tb+I19uG5Uv3Qw9EcOYKjPSNSZFjvH1+silKyVi1D4?=
 =?us-ascii?Q?1rD9oA7G3fRcYgK7qq1h4fixffwWk38NZCR7f0Pb2rUKzL9zRuT9p60fjpG/?=
 =?us-ascii?Q?0qPdmzlcJ0Rsd7im2AHY2U09ibVMMY6nvZhA/VrGJw/CXc7gT8qRF6qDBI1O?=
 =?us-ascii?Q?PndoUps8UkZDpokJZkeDhEn1G9ef2HiJtAdvoULRn1ISurvXTJR8Hhb7lcXC?=
 =?us-ascii?Q?+5qpT0Ya3AOCpikGeZlzmBUXPh0W6w/h4adBzB25CiE4dLrZN+mNtaHKpfx0?=
 =?us-ascii?Q?3/x/sdc3VQRCxxq4aoY17alX1RtrXdqpxA+e8CdVFPSrbZfjoj4aFZXtaYy8?=
 =?us-ascii?Q?PA1CzNirOYpn+d1pM7ajwe0ciAUxzHSSqqm0quwaj/fSo245oUBnBXLIt2Y+?=
 =?us-ascii?Q?i4qyp3Cm6Ij4hjlUgK3x5plgiIA4VGwJ+8hntJwzaAjRPUonhDP0CjyrrRrx?=
 =?us-ascii?Q?UB7z1lun8GSiDXDIZOeMNcd8qExWWVctUcpLkNCDv8dBYNo2IBglDk8OCF70?=
 =?us-ascii?Q?gWLY7/bW8QqKNxgf04BZLWsiigi+CwsbzehceDDTm7DulAeNjnQhqQ1bFsFP?=
 =?us-ascii?Q?F+x8ZljHHxCIAG1AOxEbRiZuRquzoE0fuKUHay/YpqlSraSii+14cJiIvhSw?=
 =?us-ascii?Q?l2ahr3/ffFUE74Gf+rinYRtaSCy7uf3I4CSFfMxeYCNMk2f7spHxEQHuD5jP?=
 =?us-ascii?Q?ieDMFPFVX5StgJM2TDspVED/Fq3JM0AEAEyCrFjz2EiuI8KSK6SVf1zNuEvc?=
 =?us-ascii?Q?2jnbD8Ej/TlQ/EpDV3rN8hJGXbk0JADSd/9fYv1dWBFkiRMWLedWlTQddM3l?=
 =?us-ascii?Q?6rTQt937NcuMr1b/vmdBKh2+Ci/l+hiQXeFdM/KnQM+q7E6E8iC92MP0X2xC?=
 =?us-ascii?Q?w6pWpPkC2P9Uugea03ngvT+dXvzPIUP4SGg6N/c8ps6TlFWQ9jZHsEp4IWvE?=
 =?us-ascii?Q?1PRg6JDfQ3aneo0bPcq3RJ5G74LQh/iCsOKrkjxY/qdG/L96H4qvMjUZjBgR?=
 =?us-ascii?Q?GcfQwuxzpMFC0bJEoSDBzSkq0aY2lItss7hjxv/XpMcs9uEBb1ZiQH2Z581t?=
 =?us-ascii?Q?OOhmEXjWCmuljuUOMNYyweHOgUyw8ipaNrhRJ7K/N3ZSWSdnjCeT3saAZ5+c?=
 =?us-ascii?Q?FKXrHCM3yCh4ewSryKw7W9/6fbRAsex8nU0NLOL/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8d98d5-cf49-4643-2ba5-08dc02458b93
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:54:49.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbDQy+yb43jLakY7y5XMSYg7UeOVIF9PHEIQHyjYGoTC3tj63RL29haW6u4vKmPdzjY+rUbM22P3kNAgYFYRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324

Supposed DMA cross 4k bounder problem should be fixed at DEV_VER_V2, but
still met problem when do ISO transfer if sg enabled.

Data pattern likes below when sg enabled, package size is 1k and mult is 2
	[UVC Header(8B) ] [data(3k - 8)] ...

The received data at offset 0xd000 will get 0xc000 data, len 0x70. Error
happen position as below pattern:
	0xd000: wrong
	0xe000: wrong
	0xf000: correct
	0x10000: wrong
	0x11000: wrong
	0x12000: correct
	...

To avoid DMA cross 4k bounder at ISO transfer, reduce burst len according
to start DMA address's alignment.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 4c6893af22dde..aeca902ab6cc4 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1120,6 +1120,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	u32 togle_pcs = 1;
 	int sg_iter = 0;
 	int num_trb_req;
+	int trb_burst;
 	int num_trb;
 	int address;
 	u32 control;
@@ -1243,7 +1244,36 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			total_tdl += DIV_ROUND_UP(length,
 					       priv_ep->endpoint.maxpacket);
 
-		trb->length |= cpu_to_le32(TRB_BURST_LEN(priv_ep->trb_burst_size) |
+		trb_burst = priv_ep->trb_burst_size;
+
+		/*
+		 * Supposed DMA cross 4k bounder problem should be fixed at DEV_VER_V2, but still
+		 * met problem when do ISO transfer if sg enabled.
+		 *
+		 * Data pattern likes below when sg enabled, package size is 1k and mult is 2
+		 *       [UVC Header(8B) ] [data(3k - 8)] ...
+		 *
+		 * The received data at offset 0xd000 will get 0xc000 data, len 0x70. Error happen
+		 * as below pattern:
+		 *	0xd000: wrong
+		 *	0xe000: wrong
+		 *	0xf000: correct
+		 *	0x10000: wrong
+		 *	0x11000: wrong
+		 *	0x12000: correct
+		 *	...
+		 *
+		 * But it is still unclear about why error have not happen below 0xd000, it should
+		 * cross 4k bounder. But anyway, the below code can fix this problem.
+		 *
+		 * To avoid DMA cross 4k bounder at ISO transfer, reduce burst len according to 16.
+		 */
+		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_dev->dev_ver <= DEV_VER_V2)
+			if (ALIGN_DOWN(trb->buffer, SZ_4K) !=
+			    ALIGN_DOWN(trb->buffer + length, SZ_4K))
+				trb_burst = 16;
+
+		trb->length |= cpu_to_le32(TRB_BURST_LEN(trb_burst) |
 					TRB_LEN(length));
 		pcs = priv_ep->pcs ? TRB_CYCLE : 0;
 
-- 
2.34.1


