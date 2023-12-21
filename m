Return-Path: <linux-kernel+bounces-8798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C3A81BC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347601F22D92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C16634EE;
	Thu, 21 Dec 2023 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fnEX5ULk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266F5823A;
	Thu, 21 Dec 2023 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiMuEI0/9GDA2EZK/hkkuyNAjZjipIfTqD1RmdlMoj3dJK4jMAkpiHtsMwsHXlHy6DtOBgRHiISeZSJVC3dPYem9Qi3m9XttJGHmSMBed/7bcKUzeV6OI0Vyf8ik4cdsDenpFQ1+UU/4TT8NOOQiQpu9PFfyzaCILe3CJUDx2XfnuBtrnuTydSSBNW6fbLlL60952ZyNMEMlD5KTF3QCRNblZBpPRb9gcnlLoD3D8xqsdwMcKgYfqQBqbRRHNpFaBU+XfZODnuXzaFIDIfCyra0c5kUHXBpiQkDkd4MyKSqWgqTW7OZVoYcyX8xVSSWwuZDJDmCzrozyfK5zk2Q7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+I4UWP/ujUsXhcyVDZML325GJfBB3qOZbGG/5f5phA=;
 b=Z42eA+BiJL+9U5JS72kUgYavKegMg4MEbGkKyQd525Nex/eO0dt1fs5cpbydBptfpqS+AoKreMJygMMSSxSuu51ei+zFTQ6Q56bJ+XkEnUMQ9+f19YXSX3m74wNT5a0EoEXpFgL2Rr7THZ2MqrN8VrCJUSGxHJPb8LPcMZxXb77j0Y/s4b3P55jPOsN1e7DAmOlWDBfauzv1+rOgicnYS1gZIEJK0t1Bc2/niob/p7RANUdRhRkSTUFxhI8Prud1sXra5+ELTXuIDeexzCkuYowYw2292Z0bTSJ0xFIeQD7erDYT4CxDlW5R05oPDSgTp04mTnxqCl7sSwBbXgKM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+I4UWP/ujUsXhcyVDZML325GJfBB3qOZbGG/5f5phA=;
 b=fnEX5ULkcl3M0nJABh+q/AdmrwTsKGuyebeoYdOe6ajRtwdQ3kZqtRkwjzi9x7/LGxRn+BiS0vDdBoqZrh9E8bU1oBFCd16Yb4A9CjvqmREz1G3LfTKGUSjxKLlWLt86fRKQYjFY2nCU4X+lKejus3SlgRW0FQmjvXHspVDI7Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 16:54:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:54:47 +0000
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
Subject: [PATCH 2/4] usb: cdns3: fix iso transfer error when mult is not zero
Date: Thu, 21 Dec 2023 11:54:24 -0500
Message-Id: <20231221165426.1590866-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d534bbf2-0f7e-4c90-2c36-08dc024589ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0LsZJ1YuKpmjRyEW7tDVjBPZ/e6uws2Z3BPRp/p70/gOe7WzjDR88naaEwgOhJsRzfAntV0jpfOiENGfQenSgAj8nBZX+xd+6ZZT1iEg5lzYBcjw4DO8FfKeu568FQouiJHxf4lDMcpRzcrLJmMbgVHKc8mmABCJ4DSoq1vq2uH2mNoic8d4G+gMufK8edPyfj/RN+7Yku35tSjTOy9wN+aQOhSu3EKY8/XcJKlWgDW48orXIWM4C3tVOq0sUb5zBKm3FbNirC2PwtZPbbbUhfGBXQ4ZTt3AlfTEyXM2TIYNLZGUZAs6yqu6QcBIAi06Hzzg/29zZSgyLDAO/TfMiORVcLV6ZNxB1X24nTMFnJ7yTg6mjq9ViXKjycuw9ryzMI32GnAB9FOLIOZJIzJgSekVrURo3dz1fixEsE9iHetAPwVqaQ7F/kkP/FAHTewlP3dD0ixUoOmzTphf5zDLmrXtWB4oVF9ZvGqL6vFEExmkbjmUgVxZz+jaXKLCZcw1TBx76Ee+hGXMZVfZ933qCQHMJp/QqirlD/8idd6icHfplLLVOu+i3BNPOOZ5/DDpbRdS8dmEwif7Tn6LHOI27t9u2s3t9jV4ni7CgTZjfOd6l7koVZ2J0OiO4hu7ZmNo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6512007)(6666004)(26005)(6506007)(1076003)(52116002)(83380400001)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66476007)(66556008)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ax43GxcOrhyiZvdog5FUGWKr7Hs+lo4Ci/4K+VhBTrCk4sRZPnI3v6DFAqr2?=
 =?us-ascii?Q?jkEuB3y4U09yUB5hONXAEinuHpRfdF9wA2ayj6Odc13qI+bWdBDHNxDoVRrA?=
 =?us-ascii?Q?ZWX+U/kleMJf+9LsN8fIQe/QebJ0WtVYA8iAu9xGnRz3vAxC/3UIyKlAGCsH?=
 =?us-ascii?Q?vzpryFRT3Z7BwzpTHSMrvz3pCZwNOHiAQJcZ4izqaZMukXI8ZWB1ZI+EeYxZ?=
 =?us-ascii?Q?QyeLjBLrKGbiwT3pr4h3qRou9B69gBeIXGWte2VPO81RF4BgXP0V/eXjJT3z?=
 =?us-ascii?Q?4H6fmVJ5Cfa0mDkyEWAOcS4Wf/azlOC/Y+TByXmyvLsKACHAqVsMAuXs3eou?=
 =?us-ascii?Q?imcAQUgtjE1lSwpwXkYCXnS4U0BKo252G3P3TSQhwr+uCLVMRkpsOECTDbUU?=
 =?us-ascii?Q?58Z5CnTA9DlwTRvzI9qHEIw1jdlB2q4xZ+OiduQvy19p7Q5I+JgH+9TVzOrU?=
 =?us-ascii?Q?2Gf4QAVfuOw8BvTUUbBNAL3AHHhLNFMnLlwyMUnNnZpnu12HKc7i0dx7Crr/?=
 =?us-ascii?Q?dCBSMKd54MoGhWwT/0UMNwPNTV1M+F0ozc/VZvTtqLVCsvUJtbnWRgTEFXT3?=
 =?us-ascii?Q?OjfACUIhCRcFZVKqYHXDpG50/KLOZ35G+4pKkDmMY5i3Nutkj1nANjAVOH09?=
 =?us-ascii?Q?A5UzmMyD3peTO5TKpGclH7enc8uU7PQN0tV8SpB/3VGL/NgXSYqbUrFF3NKd?=
 =?us-ascii?Q?IHO5mnGE0tBx2IZpCGB3fbptDWDViG6OiOUYYPh77aStoOvPNrKinzDwd8Of?=
 =?us-ascii?Q?NZWy9Sll9uR2GNEWBKd9Sk8nuU/ZEcYjdoe/sp3o+1ZbODhagy3W9LW5jOhd?=
 =?us-ascii?Q?aRFkPUNXLxTIb2myUmeinoTh7Gdygw0dHaRBGNot3NLVkRFySnW2p5qPMhpH?=
 =?us-ascii?Q?qSyOIDSddt1RFOHQFaCUQGyX5t5i6U6VAqwrveAsGGMnsEJ2aeVPVu5bBD73?=
 =?us-ascii?Q?Z863ohLKSpy7w37CYigdfgv8BqX4oN1gsGC9m4qRjJwmIryFUqWVkLlQCnDf?=
 =?us-ascii?Q?p+Mj9i3czwXkn9m3avQZtIZO7XCwgHg19mQh7T0dEWVPonoJ8cNjYytM+Ot2?=
 =?us-ascii?Q?tzmeawGDh2qYSj8+yF0WBjkOlggN/fiZYWXPwlONcVRrd6vInFm++OrR0JKN?=
 =?us-ascii?Q?4mkaeZXiNqxm2ExFxHmLuDKXqzHOCISNqDg7jivEAcRSzvFR08wtT9t/aYZe?=
 =?us-ascii?Q?djJWXqPFdfXDein9odAQgPk/Fk49o4ROhyF3pkEqhv6/zkeZo4deCb+gf1il?=
 =?us-ascii?Q?oFLtJ/HzgvE2AdkkzCA1Kgg8PJ9tpo+XSiWTxLdH5N82NM/hzEPGaa04enBC?=
 =?us-ascii?Q?LYnbQ3ui4jGboofoQBxaGjXxTvUCDudcU+rDtMJB/B98mPWzb99Ual5ETfSs?=
 =?us-ascii?Q?L7Y4YaWzvNsEsDwdkKA5/27Va0BUOqdMGFZPnO9WpXcEFcnpnEFGWIQUd6nK?=
 =?us-ascii?Q?LCuV8nm9tRn/9N/ISe1EjzBgJapdHlX5O+7G+E8TeaEIs54vdJvoxL0hCWb+?=
 =?us-ascii?Q?GKU20sOJ2L/w6RpWU2bjYBRlyZ5EaJzeXOr+MeHaMRYqcbvjs1nJaI6OPRwG?=
 =?us-ascii?Q?TEpRPxtf5ySZE5waA/g6G8VoxpjtjIKo8b+3Nw/w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d534bbf2-0f7e-4c90-2c36-08dc024589ed
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:54:47.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AP7mul0wHbpVrnMeczPmsSgu9UVf8Jg/o4ENPD7VPUw/8OkLSPHuHd4QJq+2K6/mdx8U2AAq0jotNPCaJTKslg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324

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


