Return-Path: <linux-kernel+bounces-8797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED881BC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288C21C2488A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE5627FA;
	Thu, 21 Dec 2023 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oi7ugUy/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAE58231;
	Thu, 21 Dec 2023 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEcF/YonPq3jDRUnANhm+EKQ/ln1a/1is+8cjpWUdoXkFlLZ1ZTxWQfdcDoFrK7HYYJqyor4Ds+7X+CEJwrxt7EPwpu07SmwMmaqCIx4e4ctwy0z3agBQC5OrW+qmyfQW/TPXxb34jhl2BSqBQh6ikyM7jw+mhs8C6nKzRqjQd8T22t21HcFvhjukdqy9SCJT1qbvM9HLxbLFqWh7uTH7ndrf1hVV+H+xZbIDQQCm+nmV5QK8d9rHpnCbb2rnB9dHzQhisS428KXu1YLBXr54IBP7moCkWse6uNBwL435iRCUg5MVKZlOfWFVSYmD6h1NIgL6rJnYLersMlQEn8Wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gvRrEG/EeWuk2IIS1zOMeLsdsRDXnJslWsrdXPBCaM=;
 b=OWHNbnQCqkZJpUrVOrSXtsYsr1ZdKdyQAUXcVOAkVg1bHDxvnGG893xsn7MvQ9tQzfD0pY25LpFYRz6u/WhVrX1GarrsNCc6f+q8X2qGnMmH6on5KmGRasMSS8dxTZIDlrJtiFGfyxon3gLrZ8WQZKckc4uggTKqpmeG6dmUj8joDoW1bEsHIgEbzwchW6cRtPlg+EXRp0pt624vFH7F6gDqn9mBDO5hNau5KQl1Ga6hwjICFMULrqJBTpJYn9jLS96CrsMZ2R03GIs1jS+hwzGT77Bu+gu/+kGjCufdS6+U5SdKafcYFd/MrAIVsbsFU4tYIgE6/u+oAJhMsCTBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gvRrEG/EeWuk2IIS1zOMeLsdsRDXnJslWsrdXPBCaM=;
 b=oi7ugUy/hkuETF5phsElM0eXGocxmmPT7PgiGoGmNIsnMgF5Puvh1r8Jkegb7Wc1fKea4ZZ+uuF9G5HetIRj949loCHWzKZwHorRRCQO82PpNppCV6BZrL9wCoZ/wrFGIKEeUokiSPVcQGZfdHbfu8gVlLsYk0lTyDtP096NE4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 16:54:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:54:44 +0000
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
Subject: [PATCH 1/4] usb: cdns3: fix uvc failure work since sg support enabled
Date: Thu, 21 Dec 2023 11:54:23 -0500
Message-Id: <20231221165426.1590866-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea1e21f3-8d62-47be-2c5c-08dc02458847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u6o+QV0ci53mpEVx8zIpVV2J7gf8hkmJ4H7ttjrSWj366/Fl2OmiX1wtn4763UuEOu0nb4GCSKm4VuzdGMSALKodNd069CfwkXFBwDxbqRg3GTD6yu+w/DEq7dDeKxjKhcxKoe3iHez4LW/6W5qmhFdhDNsq2XZ9oUmRVTJSfzIDV+SBjQF49bnKIF68coYevWwpzz5rve2vCjYJZU+BUjFpZCuOQD+kabks4lDivuyUXhvkentmJlodvtmzEuWAYiGmTn6nyZ2NBE3Gctm+oysuzUMsbsRYXzoVuBdK3dXC0mSfKPV8lH1cSPgEBO7eyTSoD3I+RZsvxiRR5TnhJ8y8Vona8xaS1h9ha2hv4yZiKDBesF1hxHE4U4BWv8alH+uPnFeAg9MgaPzydkFkhz66PDA5t7aTxnZKxob+yQSN+jJi00w95hxDpa8XIOfcmLe5ETcPW4jPUxJ0AZwBHofQKYFujeIM6YjMmsJtNCDIl/lzXCevCuT3GTo/1QT483a7mHVWwr5GXkX3chTBs+hbdGDcghcd45XF0ZEgT70FqRmJSQXULCep8rdr5ad7rJnis5PvHUC9wJgsUzHiQs1jUEGhUqyfR1n8XQdgPkMJRxxjT4VxsKoIYYFeGxjP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6512007)(6666004)(26005)(6506007)(1076003)(52116002)(83380400001)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66476007)(66556008)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAmpPXrJx5RwyemkWW/TGDxiiBGJ40kWVn3IQzsJ88gZqBrViaD/uEQGyRTa?=
 =?us-ascii?Q?as0UWLk6oIuxVXBFKeMjwNhE/mp2exlDxzgXPFrJlNeGmsgQjyvcpVvgH3bf?=
 =?us-ascii?Q?b2cGI2bUGPl4bWrhh2brX07QDMnJ9wRgObdWsLwun0nGTjwV2a/hoAZQscXw?=
 =?us-ascii?Q?hCSz+tvIIt/vkrNz1uO++WVRnWk0WzceDzJAKqkzM7J/7XSCN4MMCDuZtSbP?=
 =?us-ascii?Q?RZaOOF4wkxYLjmUzIdN6DOmfsoorhKsqRclHOzoWsJXAF0T2RxI59dyPTEAe?=
 =?us-ascii?Q?Opne3kQ1nMnNOFYmjtuOiS98Ahyie6ra0eFcWW33Z3XsLMvBuq0SYLlB3kcn?=
 =?us-ascii?Q?pLbqtFGCVnX0C8yXH540CyooYsI3X5EnNzZa6Li9AiVBbBHJjoLzHNBqFw0/?=
 =?us-ascii?Q?fUs8StR1tSfgM2yaka+wbnpyHsw8UsAr1EB5NVskNbkl52crjYvl+RkA3Qdv?=
 =?us-ascii?Q?FpGHQNwOzaZfVNrSjMOu5XKITStXlNhxna48lPm8fh5N27G127+6AAW7PMkP?=
 =?us-ascii?Q?8fZh/goA9cmQgCb9+/UFEhnUlC7aGk/L6B2g2c6W5aaNzyhlnJKp8FUievij?=
 =?us-ascii?Q?an2hPPudldJB4KFnjQCdSjrnxhiPPZN4G+9uyJ9j2oFR2EiJpGZUFTInImB8?=
 =?us-ascii?Q?1jSrJc6ltWiGpZxpRZWacmjLLvORq3+i8bIwGzzmN60NK97KUr5boyRcYVbk?=
 =?us-ascii?Q?qMzD+uiMzmVyyo7/BnSMZW3t2wtfFUPd0wCDbiS+9+XCSI34mjBkj9r6t/oH?=
 =?us-ascii?Q?UZyP8YSS11laayHmKtl9gRh19GVnw5bznby60vmPnlMrOSARQYkQri2FwNPR?=
 =?us-ascii?Q?RjIDuBNBQuoqSoyrgRRbyghU3BJTFSA6uZn0hD1sLDJskteV6EzPjAP+9EMK?=
 =?us-ascii?Q?L15NzISyITlqgCY9QxElBXaLpzAPcbQsJ4eP6b+DMQ/LNNnoX/v+QailYbMz?=
 =?us-ascii?Q?1+lyN76R5nq8uVsDADxkyCIlp7qSrx+6t0Edoomc2RiVCmW3BP7NMdveOP+t?=
 =?us-ascii?Q?Kg+TXJyJvk3v99Z01a8UPhX64YirdatUC4f3L1emlNBQIWdP8WY1E35H8L4K?=
 =?us-ascii?Q?2NSH54X5nN0LgSmukaOzMjF7CLAIlrQHhqWnAPS53W6Dmq+Cm1X4lDslDgNR?=
 =?us-ascii?Q?mBKEwtsEtqiAmpJzA5DUC+BjJ1BI0dEIa7cXmPiBc67FL1BWMF9YjG5xvqcu?=
 =?us-ascii?Q?ya5HMadqiHeVLNxvM+5kIXXTbOzVT46wcxUsokSg711R1bwtPtjAcla1YJi7?=
 =?us-ascii?Q?MUspaDnr/50+4DlsluucNpxTRlxWFtfFyaQKLfkcJO5IVHzJGKWI/hgWzkI5?=
 =?us-ascii?Q?dYCaaCLnLIbt5ch8codPvLN0l7G9vOTv+ouL5kDnM0P2y5H+HMzujs/ICx0J?=
 =?us-ascii?Q?0VqQaCCkw5nRivleFC5p9MHJblcsDFybSD79a2msU8vHdHbxOh68Ot/vSoWh?=
 =?us-ascii?Q?DiffSuPUgj4szf1ApWuJCYINK+hGEpAbfOZiiSthhJfN6dy+M29Pzb2RIaMW?=
 =?us-ascii?Q?fJQdsXfxqgBxxBEIA+VCIRzTrW2kClKM/IgoWiAZn1hXDNz8jOEd7jtZ5quo?=
 =?us-ascii?Q?GHg0T0BlKyMZWBNfnQKyDrY5h3g7teRquZBk9ofC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1e21f3-8d62-47be-2c5c-08dc02458847
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:54:44.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MrRV8YM+gRM7FFsuNuigHc+Ue9a7rGJoKs3GmsCYd2ptwYThs7lip2k9JGrOfTuaqJoykKGqtUZKngyA8xX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324

When IP version >= DEV_VER_V2, gadget:sg_supported is true. So uvc gadget
function driver will use sg to equeue data, first is 8bytes header, the
second is 1016bytes data.

    cdns3_prepare_trb: ep2in: trb 0000000000ac755f, dma buf: 0xbf455000, size: 8, burst: 128 ctrl: 0x00000415 (C=1, T=0, ISP, CHAIN, Normal)
    cdns3_prepare_trb: ep2in: trb 00000000a574e693, dma buf: 0xc0200fe0, size: 1016, burst: 128 ctrl: 0x00000405 (C=1, T=0, ISP, Normal)

But cdns3_ep_run_transfer() can't correctly handle this case, which only
support one TRB for ISO transfer.

The controller requires duplicate the TD for each SOF if priv_ep->interval
is not 1. DMA will read data from DDR to internal FIFO when get SOF. Send
data to bus when receive IN token. DMA always refill FIFO when get SOF
regardless host send IN token or not. If host send IN token later, some
frames data will be lost.

Fixed it by below major steps:

1. Calculate numembers of TRB base on sg_nums and priv_ep->interval.
2. Remove CHAIN flags for each end TRB of TD when duplicate TD.
3. The controller requires LINK TRB must be first TRB of TD. When check
there are not enough TRBs lefts, just fill LINK TRB for left TRBs.

.... CHAIN_TRB DATA_TRB, CHAIN_TRB DATA_TRB,  LINK_TRB ... LINK_TRB
                                                           ^End of TRB List

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 51 +++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 15463b7cddd23..22a31ffa69423 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1119,6 +1119,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	dma_addr_t trb_dma;
 	u32 togle_pcs = 1;
 	int sg_iter = 0;
+	int num_trb_req;
 	int num_trb;
 	int address;
 	u32 control;
@@ -1128,15 +1129,13 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	bool sg_supported = !!(request->num_mapped_sgs);
 	u32 ioc = request->no_interrupt ? 0 : TRB_IOC;
 
+	num_trb_req = sg_supported ? request->num_mapped_sgs : 1;
+
+	/* ISO transfer require each SOF have a TD, each TD include some TRBs */
 	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
-		num_trb = priv_ep->interval;
+		num_trb = priv_ep->interval * num_trb_req;
 	else
-		num_trb = sg_supported ? request->num_mapped_sgs : 1;
-
-	if (num_trb > priv_ep->free_trbs) {
-		priv_ep->flags |= EP_RING_FULL;
-		return -ENOBUFS;
-	}
+		num_trb = num_trb_req;
 
 	priv_req = to_cdns3_request(request);
 	address = priv_ep->endpoint.desc->bEndpointAddress;
@@ -1185,14 +1184,31 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 
 		link_trb->control = cpu_to_le32(((priv_ep->pcs) ? TRB_CYCLE : 0) |
 				    TRB_TYPE(TRB_LINK) | TRB_TOGGLE | ch_bit);
+
+		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
+			/*
+			 * ISO require LINK TRB must be first one of TD.
+			 * Fill LINK TRBs for left trb space to simply software process logic.
+			 */
+			while (priv_ep->enqueue) {
+				*trb = *link_trb;
+				trace_cdns3_prepare_trb(priv_ep, trb);
+
+				cdns3_ep_inc_enq(priv_ep);
+				trb = priv_ep->trb_pool + priv_ep->enqueue;
+				priv_req->trb = trb;
+			}
+		}
+	}
+
+	if (num_trb > priv_ep->free_trbs) {
+		priv_ep->flags |= EP_RING_FULL;
+		return -ENOBUFS;
 	}
 
 	if (priv_dev->dev_ver <= DEV_VER_V2)
 		togle_pcs = cdns3_wa1_update_guard(priv_ep, trb);
 
-	if (sg_supported)
-		s = request->sg;
-
 	/* set incorrect Cycle Bit for first trb*/
 	control = priv_ep->pcs ? 0 : TRB_CYCLE;
 	trb->length = 0;
@@ -1210,6 +1226,9 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	do {
 		u32 length;
 
+		if (!(sg_iter % num_trb_req) && sg_supported)
+			s = request->sg;
+
 		/* fill TRB */
 		control |= TRB_TYPE(TRB_NORMAL);
 		if (sg_supported) {
@@ -1251,7 +1270,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 		if (sg_supported) {
 			trb->control |= cpu_to_le32(TRB_ISP);
 			/* Don't set chain bit for last TRB */
-			if (sg_iter < num_trb - 1)
+			if ((sg_iter % num_trb_req) < num_trb_req - 1)
 				trb->control |= cpu_to_le32(TRB_CHAIN);
 
 			s = sg_next(s);
@@ -1509,6 +1528,12 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 
 		/* The TRB was changed as link TRB, and the request was handled at ep_dequeue */
 		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
+
+			/* ISO ep_traddr may stop at LINK TRB */
+			if (priv_ep->dequeue == cdns3_get_dma_pos(priv_dev, priv_ep) &&
+			    priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				break;
+
 			trace_cdns3_complete_trb(priv_ep, trb);
 			cdns3_ep_inc_deq(priv_ep);
 			trb = priv_ep->trb_pool + priv_ep->dequeue;
@@ -1541,6 +1566,10 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 			}
 
 			if (request_handled) {
+				/* TRBs are duplicated by priv_ep->interval time for ISO IN */
+				if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_ep->dir)
+					request->actual /= priv_ep->interval;
+
 				cdns3_gadget_giveback(priv_ep, priv_req, 0);
 				request_handled = false;
 				transfer_end = false;
-- 
2.34.1


