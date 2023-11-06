Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3151E7E28D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKFPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjKFPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:35:15 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC7DB;
        Mon,  6 Nov 2023 07:35:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ9XOcdpXmlq/39TmV6lxSDuRx4KRMyLPxYrJL78RD904pRULHiOX7JnlPgM0TmxgKKZvnJPiGrrUwiq/UuDWxC9JBnQX59odeLxwpmVKmNWDZZoz2jfKpnqe0zKT8QnTH8eKT1ZGSxxomSCZtKHDfKbvPPUJCCBAYmL9u3l/PguVs5a/opKzY6ua2z5OnN+l0dPaG9CbscRwmkrt7roP0aYGiqbdkeItRoleJBMrbindujo/299C3Brk/iL40NRPyKXai+v6bgpnM8R50VsevY2n3xDJRVUT4/e2k6ks3xcYtM8LEBzAPO2jF8xm8qcdv4FNSikyeBqB3Z0DWFO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp889dFH/3ILxFvFd+Wf2bwzyznNr11RlwMvCD4M+Rg=;
 b=VATwBCcSPacRrEQzqFDJtgliTfcB8fB4M//gwicfOPqu3FY8EWrl563qNL+1EyiaJ6uzxacXxoMKb+lYPqjEMZHAoBuCXDv7uoLXMZoH3e6joabl7y4spAc2H0+f8rFogmgXFUCcYj6nzOhAxy7dZWUc5czfnKdZ2TvUV28X3vQwUj5un2zsEeWbzcdBgz5UiE1dLdkUFZRSZMqxSjXZtuLEvEvPRm1GypYg8E2xXWdeXmplthCLBBqBLaiB59io7Le4Ii69Pkw0fHXvrRWukNT5Pk8cPZW20wE55Oya7I7A7bIApk5qnzsNijAup+3iN3ejHIx9YUyQ4rTd2qjvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp889dFH/3ILxFvFd+Wf2bwzyznNr11RlwMvCD4M+Rg=;
 b=K6JU2LWYTV5EeeVbJkI4XzgkWW4PKlNmYdIYhs1o+8TYUGlHRq2jp1JC00dhd44YjvaPoLuiFUTT+lKEUiBaxW8yrifpJ9PTTlpj8D7O7vG/NNwUH3icTjHdxfjMwGCoFcq/rjqFYIu5/6nexJyVQ/HBIKyCDycVLxpsa9V5jhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8915.eurprd04.prod.outlook.com (2603:10a6:20b:42e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Mon, 6 Nov
 2023 15:35:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::2635:52a:c866:2576]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::2635:52a:c866:2576%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 15:35:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] usb: cdns3: fix uvc failure work since sg support enabled
Date:   Mon,  6 Nov 2023 10:34:52 -0500
Message-Id: <20231106153452.2397035-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e4f8a4-7e03-4771-a2dc-08dbdeddf594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: am/p1SwjM2ZYpAWrIV0pVsxr9UdG9tAtlGbyr8HIj0TOJaEdq9WueQ7ZyuK7oV0GBL00xY6DGNrQdkIEz5crJFQ7ZrW5/oP9LxjaZ1kpxpEn5aJs0aVbimMUVL7wMzWNkIvhbQ1vqyHxMVuitJUfq3vwGHC4Nts1mC9GMlSTsNDBY6qTL3YKOkubIZ/mMk4ZHc9vycbTM0tdPUZZ+wIS9oIk1JfQgfpkjOlypmHL+Kd8trsqYuAvMJ8H2NgPpbfICcP+WcgZ1tJN1icIYiRyY+UdM3gHsDzT/OTkFUsClUKY3IESLqlIZHCjLYCvA9OTnZO/eYMzYUcRDyfIiWgTq1XVUsSbH3R4lWAAuncg64IiUutkqd1o2IUULQSY3x9VFYRNCcFTsFbugrbr6R+kgsphi43rMvdvcSBMKeu7gRrCEEwvHOzh156bsR3jYDAJLuR2ayjMafD69SWR2jm0tNW8Zr3TOXcYRxwDk9Tb3sIMI7EzwcJ4hvpkRJlWvTu6NPWh1stDDtaQqi9LbgIEe2pvPGoJczQ6v6cpgFgoZuPzgZvorKm+gNeD/ih5Cf4CW+iFl0siTHcZ8LA7gXeAU5Jhb76e64zVD115f0zYArU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(1076003)(26005)(52116002)(6506007)(6666004)(2616005)(6512007)(8936002)(83380400001)(4326008)(8676002)(5660300002)(2906002)(6486002)(966005)(478600001)(66946007)(66556008)(316002)(110136005)(66476007)(38350700005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M1i/Ocl62XH2EdvqKZNCSsiUh4OoJNvWgMCEjZoKfHN5MbYeSy0beUzKdkwj?=
 =?us-ascii?Q?qEnUwqk6coZVE7v05cFnJI7BKznFAezlliEvlJwEnSZI63KDhiA4LRbnZdFS?=
 =?us-ascii?Q?f59Aj5Y33vF4nbd8NnhIFMgwgwnoI8aOc783sXAFmMYJWQSy6LsisoQpE4Lj?=
 =?us-ascii?Q?KPhv5hlkjyFX8RW0cbkWkjFdXfN2AGP6Z/KLt8NTA6LTdyaE+0ZtM5eJFOUW?=
 =?us-ascii?Q?QyPkQDfAh8SU39AJvAjde7lZXnsivw2/xgUukrNCd0WBnVoELvPG1//jmZs/?=
 =?us-ascii?Q?vsqZebuFdU/Rq32Sb3C2wOF6ZsO+nEhX5HCiBe9kermeA+Gdi3/HnOj7vkBn?=
 =?us-ascii?Q?2w1tb5c1qpBaV7lsGBSOSp+ojftwGl6HkzOCA6PEK7hd5zqi6N/H4mVp+yEN?=
 =?us-ascii?Q?Dam1KdqumLHyzyxBT9CZgbqsmWkWArqXaooAu+qzAOYWF/ku/+Hq9RYdBfR4?=
 =?us-ascii?Q?vRYRMQCDKXG0gNRDm1XjFsrCGS8Z5ZksfyC097/9jcfqC/f+Kv41v/eqjfS+?=
 =?us-ascii?Q?+kZ+rUGJlCVeXkCnYKjT4GtF6iqWjvuP4XNh0XRl4x70i+NCgcj3p+IvTPyK?=
 =?us-ascii?Q?PvytLTOI9NwPzbdxzokb04gG7cNKoMmYulTW+xLEkK6pbmjJH9wLXOHd7ANj?=
 =?us-ascii?Q?Ny0f82o5t+cAswrKDBLnZoZKUJcAxZqp66LadY592H/SlQvYh8RDrZcAiI5H?=
 =?us-ascii?Q?4LFpG14GexJ3PUPObCJMbclNJ6tSfJAnf41TlVSHFql8jcpjd7xk1w7mB0u8?=
 =?us-ascii?Q?V86DpjDYjVH7fbesNmLaFnce1j02IHzTnTdHn5FFPsyrSDI/GOzrqq5bTaVO?=
 =?us-ascii?Q?xgIEbnmguiU+jmCLfkA2HX8wctZzuPIyTvGJnIT1H9g2Hh5vTj7PuLhuXysM?=
 =?us-ascii?Q?/H1ny4ORKDUd6H7nV+RmPquHJQRerpwvy3tgfC8AW8In+j7+LDB29z+n1q9o?=
 =?us-ascii?Q?Tzk4KVUpX2e7ze3ooaIEATwIMJWI7+N5PpygzHk83qepcVdy1ahWlEBRYhBQ?=
 =?us-ascii?Q?odmO2wDJDu/9gmfulRQS/BsOA3aKb6p02jvD1yoJq3z5LAox3DC8xxQc07gO?=
 =?us-ascii?Q?bWziLufWBPwaGAI7+Yjkd/mWbWHIZnYhnkjY9esDoN0RSeYl3s/QpupCb+iO?=
 =?us-ascii?Q?uImF/qksZofN/5gd6fqFEkfE+8zPUAWrRA8qJsaTaKlh3kwRjtgHLOPLBdnS?=
 =?us-ascii?Q?9OnG866bHrCB9PC+8bAojAom/GuTAu3mA5yLfBymFznj461UhNdpPIp3DWTD?=
 =?us-ascii?Q?1/fwAXwSRPWkZ0PBSmhg5V+YzMc2LvIw6sbVS+K6XB13NWP0gItmomq2tymF?=
 =?us-ascii?Q?V7/7YIYZdMR/rqPwOB9KavjFJQR3zS0oXtzwXuCcm3+cwUBim+80o8/oZ9NL?=
 =?us-ascii?Q?T3ot9qrwCUS8aOYktTT/mRjGz29O+KrJXyQXK6KBOXVLdIFwuby+x4TPiR93?=
 =?us-ascii?Q?mK52rd4DlbNn+B3fyAznl8ELm/A6dGVBhQNl9ZkWIi6mkxdjejmdwk/xySUT?=
 =?us-ascii?Q?POPy8Vq2kriCjlEX6i2s6pnOG4Qf7SBgW0GcY5r281VjgrMhGUYZAMmTUOjc?=
 =?us-ascii?Q?s4UXRA9JjClknncWxdGKEXDsdhYDygdBSaT9/Ppw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e4f8a4-7e03-4771-a2dc-08dbdeddf594
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 15:35:09.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcj4ErNxN3tPl74+rJRb1R79/cP8jXf2O5q8DSMufsu3aonTInr6fNMLywwRV0vpW4CqaceHV0G35mukRxRZoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 7733f6c32e36f ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

This patch is depend on https://lore.kernel.org/imx/20231031084521.GA1948529@nchen-desktop/T/#t

 drivers/usb/cdns3/cdns3-gadget.c | 51 +++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index cd08897f8da8..23580ec33202 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1117,6 +1117,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	dma_addr_t trb_dma;
 	u32 togle_pcs = 1;
 	int sg_iter = 0;
+	int num_trb_req;
 	int num_trb;
 	int address;
 	u32 control;
@@ -1126,15 +1127,13 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
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
@@ -1183,14 +1182,31 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 
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
@@ -1208,6 +1224,9 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	do {
 		u32 length;
 
+		if (!(sg_iter % num_trb_req) && sg_supported)
+			s = request->sg;
+
 		/* fill TRB */
 		control |= TRB_TYPE(TRB_NORMAL);
 		if (sg_supported) {
@@ -1249,7 +1268,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 		if (sg_supported) {
 			trb->control |= cpu_to_le32(TRB_ISP);
 			/* Don't set chain bit for last TRB */
-			if (sg_iter < num_trb - 1)
+			if ((sg_iter % num_trb_req) < num_trb_req - 1)
 				trb->control |= cpu_to_le32(TRB_CHAIN);
 
 			s = sg_next(s);
@@ -1507,6 +1526,12 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 
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
@@ -1539,6 +1564,10 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
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

