Return-Path: <linux-kernel+bounces-10735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938C81DB13
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DDAB21385
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B05D304;
	Sun, 24 Dec 2023 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="abfHNBab"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4CCA69;
	Sun, 24 Dec 2023 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM/NpGY9RScxv+geHcnKzQG1dBNByoXG/wxicfCzCiDCghZ8E/7t8eFKfluG0kQAKwvdHnUXaRikUXfHPBwB9cBK9RTRtFbv4Fi72WXulyyeW97JyvgADjBKRJDKxmqMpJkppoekH4FfQhk+CyvUE68MxF4Z5Nwk8pccOBs8l09vaGkkRf+qAUYIQN+3kB+IHOaMsWFSBmEQAzU6z6kCL5JN2s4OJEaL2hDJHVaC+mEWtJwhVMA+9mSKBaXYGS77ZezyXWWZoiW4B+UdhCs4S1YQBcGEaRU89dsJ9DyJ4byAGnneFbR2mlbEiJMKQ9lk9nfjA6KwDWUol/WloaxpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQIXbgiy/6tTNdJJgqqx1tpTwJQce304/cfwQ36fGEA=;
 b=G0OWUDpYQtqX2+hQnCWXRZmjAtel1K37de6PZ5OyoZC/E6rtGffDIWMdeGsTh6OyE9CeccKIT3oSwJk9IvKH3/TZuyS+9AW85iamAHYIj35qb0q+AqcSjU74HPwhlmNUitwsi98H02QsA0KoXYXhItXOd1HLe8+6WzbrR3lKKypmd4+bIqISM0Hse6dw471hoaVZjCYlKu3qf9hXcasAF7GctL+L66AbB7NTD3F23SkXWLLvvsQMOkjfWDQszmo3MvU7xltkNrHvI+XvQKALG74CcPoor0iNkxHqu8368gIbxdQkGw3zQZ12zYNsxxGvspehvbxkPSx97VSEzCQt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQIXbgiy/6tTNdJJgqqx1tpTwJQce304/cfwQ36fGEA=;
 b=abfHNBabnJdp7EXiMboQ5jpRQcjudVsUPV+syM2X56wsqCCFZ+uyDHNNx0l59Azs67sTPX4AHZGvdbt5hu1HHhWL2wnr+5eOSxI4KTrSI3ss6HbfCfv3+D8K8712tQyXqb8J3U2t/W2nKoiuxbd8z6f1huG2es9HBf3YQFqag5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 15:38:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 15:38:39 +0000
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
Subject: [PATCH v2 2/4] usb: cdns3: fix iso transfer error when mult is not zero
Date: Sun, 24 Dec 2023 10:38:14 -0500
Message-Id: <20231224153816.1664687-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c60a1348-5b37-471c-e90b-08dc049666da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D7hQa5/2rSgoq+2L9Nt18sfAuUVqAqhsm+cdZ3u4wMyo3fX8dIGR1PrSrLUs7aLCVjKQpkdbsKRwc70l+L6hNDf9HwhChAeLVOqBbgr0E+JdX/aIzPr83b7mjVpOsemF0n3AHgaDRfATA3hnUWdxfUilfqj2JC3sc/Z/ZAaMNgiVACufMdme+s4esmhZ++Z6wyfIe+MsvO4QFvT993EF6usGLT4g7pM1VmzivkRX2EuZfnZnN6/RQhH4D9YEo7OjSEYp2UnzacVWC3VqdRIdoU5OF+yEXtEc7Kvr7WxLcvedumjIHHJIEN8rDMW21lBsJ696j4iwvf4jP+tQ+ok6yBBbO1w546aDyJLmtjUYs8hIRaDyxRl+leyRdlIEKCCIR1fwBkutWlBCoqNqj0QXUqMIOeGn6U//rjezqfadEycGrc6lOjeyoFIbUEOHh3NkseVkqMql3i80AeYVU9VTYmkEOpI209GXo9QfTWRgFGUDN4t2wP48zcqgAsivyoGPCwWxC4CwoHc7yPC/72fA5TqV0TYEUHNrNJX+p9qzO+wl2lSVpVsOszoT8cgL/JIQNTZuvN8JTvPrbLOpWPfi2Jdvr3DmAstFwu9eHcN0hfRlfQ23BRZbLSm0zgTVnxK4FRDuUM/cUn+DIdDUH9eKTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(66476007)(66946007)(38100700002)(6916009)(316002)(2616005)(1076003)(26005)(4326008)(8936002)(8676002)(478600001)(6486002)(83380400001)(41300700001)(52116002)(2906002)(6506007)(6666004)(6512007)(36756003)(86362001)(38350700005)(5660300002)(1491003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVpA7a1KAZllbA454AlofAV8eE38ejjuUjCl1iUOpmEfTTq+VZiYKGGJemOJ?=
 =?us-ascii?Q?pxdCtYyQgY1fgJE3DZ4CMfJt6aQ4siP5APuP79/Bqr46er9aXXtYRBMy/w7T?=
 =?us-ascii?Q?u5E++Y7s6PeNW9ngXQ9t1nOGbrkiiJl8s4ZIRjVEe7C2Hgs4L89l1jx01OVQ?=
 =?us-ascii?Q?LDOVjpuRaTl82rN6eCVSVc6l7rKcXeXeReqMnX4XfH1RbR1veuqRUPCSKLow?=
 =?us-ascii?Q?agdWoEuJiCJmqkvvLy5hsf8qS4lQinL7TGvPbqN9KWyoxfHgqMnFKpRZFVJD?=
 =?us-ascii?Q?WVJCUq3BpeXXAedXjo1WxXAyHx8cPZWqfmuajKH86mSYTUmnUIMDwSuPwRtU?=
 =?us-ascii?Q?+4GWhbnmKzmtau0gMQuxrOyeYyjY7ARRrZq1rj4rGonWM7KdhWOAVl96Zpqh?=
 =?us-ascii?Q?dZM1FN/bTxbawWbzDpNUcVLjImvq2hfxqhu2U46cPL2tRqz+4Y4USApp2Vn8?=
 =?us-ascii?Q?3Cdovmioxf6vc0/W4dh9TZ2W5Yegt1ZPWyHBSB9rZCfIgmqatHuub2vD4ODe?=
 =?us-ascii?Q?UMiwJsBh507F8oVb90A8HzHpkODtF8j98eG2cuTO5fyj2TajGLot4gDbdpG5?=
 =?us-ascii?Q?HAF0t/wj1ffwCHc/NFNU25uwv6lxSDwCI0kh2V5oYBgF+Zeo6iU51RULRsa4?=
 =?us-ascii?Q?DnN4nNmMSEZHQ1J0v1AZ8VxkQNWPLT1jLcc7dG9yOjmxNhYiUDtxuIriSlBb?=
 =?us-ascii?Q?YB7KKSXtLADNE2z9epwbkdG5muCv3E8XweJR/NEmFwAEEq1E50jqP0zLPkBp?=
 =?us-ascii?Q?8dueDEIhwGsD74eg/8A2ka9frL/jD+Er7XsYJXj5qWPKgyceVNkGO4TqqM3l?=
 =?us-ascii?Q?SABa7kD4APBv+jyKv29pacvKdTCupV8JCu7HPCuVLKk2o0uJ8G4RlnvRGz3y?=
 =?us-ascii?Q?IsAjV3zQPPNpUct9uURaefoBtzI8Q74s/EDXkLN94/pRoxLiSp9vI0f7uS23?=
 =?us-ascii?Q?xOuKWQpIVlWoFnfz84CBPqaRvuyXfdKHIYmcB7G70RSknB7jmoxZAharVDIU?=
 =?us-ascii?Q?ZxhbXW0x/xGuva6TXgIztAqh4CWv+gTWH0uEdu2pLEv6d0Fnbb7S0LNQRkZu?=
 =?us-ascii?Q?1M0KjJ0VJYkMPVVkCHP1q8NxWN7fKC3eZ4gUzg9PAETIz6OQEgx9uj+J/KYJ?=
 =?us-ascii?Q?ibxaTetC3tGLXiAfw3lsoVhWjJwzIbmznvh/ssgRKiGXKsNBWYkgy0ieoD3c?=
 =?us-ascii?Q?YBnkEpsdKzPivcEqxXr2YkI7oWNYk4H/rThc9ScRj/ASb0/UdDHCTWlG4roQ?=
 =?us-ascii?Q?TEL7v/5oHMVLqIqL2FJlHjYOoE7YEQ9qtvBy9GxfL1/qHnKUKl26Yr0wX04+?=
 =?us-ascii?Q?9Z2ahTzLk9bYP3326xftBsUZHeYJe39wqA3Y0VCs+Mw9fY0WjzSIVLDoWY4U?=
 =?us-ascii?Q?sJpdZpNltumNbB/Nx00h1zd8CzRLKbtBzMkQOkc6rAGyTbdVmmuH/s+pOYAz?=
 =?us-ascii?Q?NPCwhycIX1VTSW47SZkUFLrGtH+/PSZ4Va7ebmj8co0pLgotQ/CRxqBL4aJ2?=
 =?us-ascii?Q?KyJBlqogiOSUrwwssu3HvAEI5FwHXKCFsdkb8GPBmWZiH0eXk3P9Zv6PZzgg?=
 =?us-ascii?Q?Cy5JFmJ/r0GR4KdklVA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60a1348-5b37-471c-e90b-08dc049666da
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 15:38:39.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zmVdO653DnZRafSIm1FWBJCEKSFyWBaO1gTOWYJ2R0Sko9YzZP2+C3doD1FM6/9nWxrx+yumzEKWcBpAgBZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

ISO basic transfer is
	ITP(SOF) Package_0 Package_1 ... Package_n

CDNS3 DMA start dma transfer from memmory to internal FIFO when get SOF,
controller will transfer data to usb bus from internal FIFO when get IN
token.

According USB spec defination:
	Maximum number of packets = (bMaxBurst + 1) * (Mult + 1)

Internal memory should be the same as (bMaxBurst + 1) * (Mult + 1). DMA
don't fetch data advance when ISO transfer, so only reserve
(bMaxBurst + 1) * (Mult + 1) internal memory for ISO transfer.

Need save Mult and bMaxBurst information and set it into EP_CFG register,
otherwise only 1 package is sent by controller, other package will be
lost.

Cc: stable@vger.kernel.org
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 59 +++++++++++++++++++-------------
 drivers/usb/cdns3/cdns3-gadget.h |  3 ++
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 22a31ffa69423..4c6893af22dde 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2065,11 +2065,10 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	bool is_iso_ep = (priv_ep->type == USB_ENDPOINT_XFER_ISOC);
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
 	u32 bEndpointAddress = priv_ep->num | priv_ep->dir;
-	u32 max_packet_size = 0;
-	u8 maxburst = 0;
+	u32 max_packet_size = priv_ep->wMaxPacketSize;
+	u8 maxburst = priv_ep->bMaxBurst;
 	u32 ep_cfg = 0;
 	u8 buffering;
-	u8 mult = 0;
 	int ret;
 
 	buffering = priv_dev->ep_buf_size - 1;
@@ -2091,8 +2090,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		break;
 	default:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
-		mult = priv_dev->ep_iso_burst - 1;
-		buffering = mult + 1;
+		buffering = (priv_ep->bMaxBurst + 1) * (priv_ep->mult + 1) - 1;
 	}
 
 	switch (priv_dev->gadget.speed) {
@@ -2103,17 +2101,8 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		max_packet_size = is_iso_ep ? 1024 : 512;
 		break;
 	case USB_SPEED_SUPER:
-		/* It's limitation that driver assumes in driver. */
-		mult = 0;
-		max_packet_size = 1024;
-		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
-			maxburst = priv_dev->ep_iso_burst - 1;
-			buffering = (mult + 1) *
-				    (maxburst + 1);
-
-			if (priv_ep->interval > 1)
-				buffering++;
-		} else {
+		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
+			max_packet_size = 1024;
 			maxburst = priv_dev->ep_buf_size - 1;
 		}
 		break;
@@ -2142,7 +2131,6 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	if (priv_dev->dev_ver < DEV_VER_V2)
 		priv_ep->trb_burst_size = 16;
 
-	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
 	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
 	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
 
@@ -2176,7 +2164,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	}
 
 	ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
-		  EP_CFG_MULT(mult) |
+		  EP_CFG_MULT(priv_ep->mult) |			/* must match EP setting */
 		  EP_CFG_BUFFERING(buffering) |
 		  EP_CFG_MAXBURST(maxburst);
 
@@ -2266,6 +2254,13 @@ usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
 	priv_ep->type = usb_endpoint_type(desc);
 	priv_ep->flags |= EP_CLAIMED;
 	priv_ep->interval = desc->bInterval ? BIT(desc->bInterval - 1) : 0;
+	priv_ep->wMaxPacketSize =  usb_endpoint_maxp(desc);
+	priv_ep->mult = USB_EP_MAXP_MULT(priv_ep->wMaxPacketSize);
+	priv_ep->wMaxPacketSize &= USB_ENDPOINT_MAXP_MASK;
+	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && comp_desc) {
+		priv_ep->mult =  USB_SS_MULT(comp_desc->bmAttributes) - 1;
+		priv_ep->bMaxBurst = comp_desc->bMaxBurst;
+	}
 
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 	return &priv_ep->endpoint;
@@ -3049,22 +3044,40 @@ static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 	struct cdns3_endpoint *priv_ep;
 	struct usb_ep *ep;
 	int n_in = 0;
+	int iso = 0;
+	int out = 1;
 	int total;
+	int n;
 
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
 		priv_ep = ep_to_cdns3_ep(ep);
-		if ((priv_ep->flags & EP_CLAIMED) && (ep->address & USB_DIR_IN))
-			n_in++;
+		if (!(priv_ep->flags & EP_CLAIMED))
+			continue;
+
+		n = (priv_ep->mult + 1) * (priv_ep->bMaxBurst + 1);
+		if (ep->address & USB_DIR_IN) {
+			/*
+			 * ISO transfer: DMA start move data when get ISO, only transfer
+			 * data as min(TD size, iso). No benefit for allocate bigger
+			 * internal memory than 'iso'.
+			 */
+			if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				iso += n;
+			else
+				n_in++;
+		} else {
+			if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				out = max_t(int, out, n);
+		}
 	}
 
 	/* 2KB are reserved for EP0, 1KB for out*/
-	total = 2 + n_in + 1;
+	total = 2 + n_in + out + iso;
 
 	if (total > priv_dev->onchip_buffers)
 		return -ENOMEM;
 
-	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
-			(priv_dev->onchip_buffers - 2) / (n_in + 1);
+	priv_dev->ep_buf_size = (priv_dev->onchip_buffers - 2 - iso) / (n_in + out);
 
 	return 0;
 }
diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
index fbe4a8e3aa897..086a7bb838975 100644
--- a/drivers/usb/cdns3/cdns3-gadget.h
+++ b/drivers/usb/cdns3/cdns3-gadget.h
@@ -1168,6 +1168,9 @@ struct cdns3_endpoint {
 	u8			dir;
 	u8			num;
 	u8			type;
+	u8			mult;
+	u8			bMaxBurst;
+	u16			wMaxPacketSize;
 	int			interval;
 
 	int			free_trbs;
-- 
2.34.1


