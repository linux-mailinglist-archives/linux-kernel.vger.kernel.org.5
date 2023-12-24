Return-Path: <linux-kernel+bounces-10734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2281DB11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED51D1C20D8B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AEFD271;
	Sun, 24 Dec 2023 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LdgLnE/J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB263D0;
	Sun, 24 Dec 2023 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMiSLqDUnr356SxDGYHZpYbp4w/aXPD0BZayEgDWZAK+Lgox1fGqYdILhNTWW1uieonthtq607UPBGF0VuGZzKVUzZUZGs4yUOmre1mQq5KI8qgCd9hMWEUodBsHImtQCd43+wuCIs/TKbDGv69Kii9dXF2AUG8my/Uo8+yjOTLZjVBQn/1ZxU3bgEnA6IAJrO0LCcY+HEKWwlJPHV3RXQQL3z1llCiUV8g1raE4OEA7idNxhuU2lgZwbYSes4OJ1ToS1QegJwTNLEV2eKXj7tA1aCIha6uvcZGW3T4I8ZxPhpnnG5W3T1rJJFYjuPBj1uzUwI2Bbn/bW3FR3FaMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5XvdZuJjs6eWiKoyhTfHugb0F0xahU1WBlLSCZVgyA=;
 b=RPxtIbBNkZOctGzYQfr1tjXdvhL5RTHtowBYmNVBLG93IPb2a0x3egJnzFb0sgYIdXGWMKQ/61MpfW/OPp4Wt/7HdcPdl9lGL6TrtdLSHmgs62hePQMuKzrfaGNu05H7PPnbvxl7n7t3vV6M+JStKld90gCgIrfL9DVwQJE3Hz7RlhzlBAgAc6Hi7o0mMVaAoThDqGom2W77nWahKsyiVH+nEoq79/MZZ73RxKZT+oLS8YQwTRXlB9TJ3bCwxJPRyE1zUjpG7yMLyzp2u9ZxMxZBa4mlpNLZZQ70Vpiz12H6iDG71gQa87C8jxwu58IOOYw4ZSR3deZ0A7MaI1O/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5XvdZuJjs6eWiKoyhTfHugb0F0xahU1WBlLSCZVgyA=;
 b=LdgLnE/JCG36Dv10V7cywmgnTSmBDrmfNA+d4jHxr4IMDL2luBX8yIrWSlByxHoAz8lQ7mKuOk6KkK8C+VrIbWzi6tbPzW01SO0lxDfHjm4/4Xvb32eL6sqs8vfVa7GsC1tbOQO4/m6CsFHMuPByOOr4PzeP+j9c5Ph1b/dEJ4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 15:38:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 15:38:37 +0000
From: Frank Li <Frank.Li@nxp.com>
To: cugyly@163.com
Cc: Frank.Li@nxp.com,
	a-govindraju@ti.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org,
	rogerq@kernel.org
Subject: [PATCH v2 1/4] usb: cdns3: fix uvc failure work since sg support enabled
Date: Sun, 24 Dec 2023 10:38:13 -0500
Message-Id: <20231224153816.1664687-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224153816.1664687-1-Frank.Li@nxp.com>
References: <20231224153816.1664687-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 204a6b3a-c507-4b00-d545-08dc04966540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NvkX2JeeyEHiMy3w/YhPX7tYR5j+1OB4I88QhaL+BrZ+G6qzOscaFRsxcUz0JKVdBKL7QVzi9kgl2rt9i9VTIM9PcU1HORuNc57Hmo1loNNYqYO1sqsqi5An9royOKuXf3PIqVWaksZhUuiC0IYf/d8Iy46cm2MndTZbLhva3VCyVLew3iHDFM6Jyccwf2XlTbEDjkR8x9nnCEEH9cO1HqCFmfgAurkA0IOyQVVCiDBbkVzCaqEOsSvKSOSXw0zPfGk6yY1UV1GEms/TPZfjLtWYcIdKbevPvE/Ehe6OQ9mg3mbtaFv757UwZw/CHmVLun5GMlghbmyzYdr3Quwsu4kqVIVgdmoM8hs9tBhGpez9XTgvXkmigSPNjr8ypCK9vgoEmid6hrdktnS/8jD58OWAgI/VdWA5VuLU/EeOR10TRk1ALQg30JFV96J0JllVq4YRWo9YN+4Ykz2x7Zmf81xR3UbOsJnENFd5N57MSWSE7n9qbSqZDPi7iow+ZPsCmqEZpCIb8BzwmIMBJuGCV5OM677fRk7r71tNLfTShgX9ZtelEp6MVXAk/Ir1MjpMaDlodkBNaTcaCx8cvwICD5S2+DmSggGXwAYFYvMB7E8nsBtUnQ+Gr+m0L5dQzUVKubBH2WiS7IS8/aolCiW6TQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(66476007)(66946007)(38100700002)(6916009)(316002)(2616005)(1076003)(26005)(4326008)(8936002)(8676002)(478600001)(6486002)(83380400001)(41300700001)(52116002)(2906002)(6506007)(6666004)(6512007)(36756003)(86362001)(38350700005)(5660300002)(1491003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ibtM0XLtYsrG7jglzlavxTlrdlKmZC5aDUKWyaOW5/LOuMQ0kA1rumKq9W4?=
 =?us-ascii?Q?WVH6ofTUE+FctIOh5QiTpSLJSVeLaiTmEfYBoXcC2LKhUisiONEBmbwNMF8+?=
 =?us-ascii?Q?Wg3e8sx8GdXgWRSb642vlrkbLFTOHuj8nbUAiW0W8AgJ+df5uNLDIjRktNPu?=
 =?us-ascii?Q?YbVHA1V5/luhFS8o9piWogwpizkbevRZvpQsb0hkniUIvBbZomVr5dfOk6lr?=
 =?us-ascii?Q?OAUw96X3SYowzMaNPzDzBiMN7z6l2P+TSFd/gnowJuS7NLLhJf3zzh0EGPTD?=
 =?us-ascii?Q?YijjPHERtYRgNLD4zgpaXV1VX7n1PDr/3QkF9DqMB6Hv5c5nRybW9yyV/F4p?=
 =?us-ascii?Q?SblgZKRaPWWRaEo3RSIYK4lz55m71YxjHszAR2nyF7c2gKjaSwN9DnzRs3wX?=
 =?us-ascii?Q?1BnNGIAJ2J612k9gceaCef6KPJdQdMsmV5SUw7Q9AErx6ArwfJJ3sFxByF2x?=
 =?us-ascii?Q?zTJOuaqG0bf+Iil5NbLRurJ4V6Wwc9e8ipxVuL/5XBMvobkwszn0E6415a5k?=
 =?us-ascii?Q?hwBh5vrUibegT/Axzoc6917hvqgIAKgQrX61CEzQdmQQHcuNoIUZ6kqI6f10?=
 =?us-ascii?Q?Fi5kqgqX2SS1pHjmAZu3CF+9YNcJs3w+9qbexVMIDnk1d23b9KOLx5s2JhrW?=
 =?us-ascii?Q?7hIOV9xtB/l1EEL2bkQ5P/C1yCdtDqb+bYj0aXAoT68Ojm0g8KTctFuZbfHP?=
 =?us-ascii?Q?IbiFFPVmwz1pDHuF3mC3ufW+Th+CnpoM+nPg7DXPlX300wJ6PfwWm0Lds/qj?=
 =?us-ascii?Q?T0/wQeRZOoWnwnXlQpaDuS/3NSSvGOmxkAyzhKWqjpCCRVEYZbvvHKxnzSkg?=
 =?us-ascii?Q?NGvxGUdS+5K9fGh9p1u6GiEbBeYAn54s6CoIO8tHOZyjkvItqTCnSIGgcWIK?=
 =?us-ascii?Q?8E7gyqnwREJqnT6NhNdjLgK7BSe74z+SIp6bMA/tRlBjqAdjcM6pREWXEPJv?=
 =?us-ascii?Q?FQ4dWCPEVCsZCuYKI+V2mKSAjXOqPdkbaymuRI07RDKlhARgmfSOhq36aWhg?=
 =?us-ascii?Q?JKJE3c0j7T7Dk1KmccB3pPnkczIXOGcj5QWl/zNYODNgCggpBxUz6mRq5tGC?=
 =?us-ascii?Q?l9SgjXlfKJZh74EGTI94FHO/+Ve2LjcoP7486Sw1o55jsdzu1GxoLGRffm8F?=
 =?us-ascii?Q?72ispGRgBm9W42tG8XsDvUNJs4gSjy1KqrV5c+go0wNOFm6b36sW145MYAL6?=
 =?us-ascii?Q?dZbrwsdVOyCjbQKCgRaUiS/LmiL5j6gaD/An/VGbEHOWdErds4NibfQ5lKwy?=
 =?us-ascii?Q?67Pp4ggfjk+pg1512aPD7QxudoQGRGgCCxfygueftB13xO5fVG3wlbwE+qh3?=
 =?us-ascii?Q?TJIApCKsAyvV7b+oF6tjfF+ohJYm5d+M1WNm4+29wwwY18h/8lT0pqgt9Sym?=
 =?us-ascii?Q?ulomzpHtGN76/bqMANer70md5wH3awjTihfzHVwZhYTRX/erhxjcr9iHdkEM?=
 =?us-ascii?Q?Y9hcXGZzSC48vRSi/0hKU5qvONLxiuPpiuuPCMghB9WTyMlMvLTIvXINFSAf?=
 =?us-ascii?Q?f8t9Zc/LNrRTQlPrl4YWJ5Q7Jp24z3G7/0eGIHy2VtppIknkPfLAKu7oAO2m?=
 =?us-ascii?Q?KQ905QNee93L0EkYgrI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204a6b3a-c507-4b00-d545-08dc04966540
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 15:38:37.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgVo7AgWWBmS6XzeBPOhULL35mFWVDF3QykZMEslXrWWBafziPExquFhm6Ru0yvFfMO4eMh/+V1yIp40JsEVAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

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

Cc: stable@vger.kernel.org
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


