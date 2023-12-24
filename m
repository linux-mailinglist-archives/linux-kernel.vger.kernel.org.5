Return-Path: <linux-kernel+bounces-10736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAA81DB15
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2683B2162E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB0DF5D;
	Sun, 24 Dec 2023 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QxhmIPlP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244987492;
	Sun, 24 Dec 2023 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxYmQ8GyXsE8fDLLH8VqiIviMjtNxJvrCiCx4Sk11Q2Hr9ZcT+bbCxeEMq/2XgibvYl7WhJbJO1b1aLl3I6bRCsF7N401l5mmwiNaXYk01PM1nfWPt+i2sjXo//qbetP840yR0uiGRjyQDmjyFFx1UfWhKEef4leU8vYAoRlPukTPejdApNvdbbvM3PUcmoZHajiighIr8t2avcneI9Qjg5F9XzcjDhjK2ExL12Tp+ZfediNEhCU+/ebB4Vy1o2vq6Dl8JJPqZqXDLgPI8ewr7ZHLUrWDeAaZhLm05Qs+Ba1dpjHNMuiqJDyGPuD5k6vX29xJ5MfMHir73fORDSNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dglNFq8lvpkTt0OA4Bv5qSnsAVsCr5FNUDys0gH1F7s=;
 b=mwpMWYxH6C0uArhC0hWG/2DDkjAB/LXPfHwqmdTgDJXHoaYtTeZI2+dGBrya30t25++rw7/c4kqWXDPg3lazuuDWTgchu4cHErVBVIRvYN/j9u89RHvUAO69SnP4PKbk9sEEY/BkKJx3DZHDA+3nXVxD9M8bdRgUBxGGdi8L6rmHaIuoSAfybR5psJTuKdP2QJADmQFlf4fpsh1VWSJbkyJmRIwgAJwlIiv2k5p7iXOZhIBITOu0utcTdcgvYADLFMHy8IqseU4nkW94plhUpSt5qnGh2i4L0xzzhhR1n0Yu46LRt4DNjFEDiWdNKtvJpFIDbSExs9a8R13pyGADeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dglNFq8lvpkTt0OA4Bv5qSnsAVsCr5FNUDys0gH1F7s=;
 b=QxhmIPlP4cCXgWUm4nh5BEN/RZVjEcn3cTRc0CG4KRrezVuCW+XrQXEFT4ObjrrhulhWvu++Nq4iqkBGkQTrFS/pQGZb0Lrpn+8yAx0ethI8y/2tvbVqEL3MteZbboC+Rg+PySLazzILZqJPXTRh76WqvDuRkJabnSLWCZmSN0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 15:38:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 15:38:42 +0000
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
Subject: [PATCH v2 3/4] usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg  enabled
Date: Sun, 24 Dec 2023 10:38:15 -0500
Message-Id: <20231224153816.1664687-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68274ff2-a7ee-431a-fd21-08dc04966874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IPO8AZSGZnYm0yg+11aSlWEI6gkXATKmsB3qvfZMgDYOts4JSaTZDQ5BbcKLO5fEd5Kayd7HP3leu3NLtHVUZ92T+HlPJYBIQjOqRiBr1iJpyPJX/lTIUwQmxdVTfJWvwT6l9bqUwVdufc+loZeAm2AjxFkCn0Gk6jYKI9YLrNaehWHy05etRDC0z+/7uzBhXNAEfE+VswVFAh9KDF9YGha9TiJeQx/AHZ0yEzfgHHS5T0vd3OLpVMiIbFvjVVtJEgfl433ARTrRjRnMGqIL2kvfoPBixK6fyABkyteDi+VEIEecDx8KEvCOlgY8jiI+95+pjvqLIpaZaFmMpWCYu1UApZgbTMjyfu/gZKtZy1AaDcPLiOG2OugGYovfdBBtYiUl0lq8Pm34fiEtvs//dqtxmei9gchQZnRq+yTUlDLSsa5vkIlZsqVchS3j9bGdcBODs44xppTDRggcPFnwLGfFAqTTN6E9iQBJuyNBIDmC6Frv11gqS1C3NjCnZO/L7wPmlLlS2TW7YHUNhPuC2n17nmWYUPYmoOf/y2y7GHSsbttdw+opA3HvxGeaY44m3Rpgb2pj3toMQb6ZUMImgXYtxX/5z0ADjOnz7/Q8gBaBhM33aPC2d+g2VfPYELR+STq2cJ1bY8KEr/0PfLDyRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(66476007)(66946007)(38100700002)(6916009)(316002)(2616005)(1076003)(26005)(4326008)(8936002)(8676002)(478600001)(6486002)(83380400001)(41300700001)(52116002)(2906002)(6506007)(6666004)(6512007)(36756003)(86362001)(38350700005)(5660300002)(1491003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHyyfAEE+E1M3FSn6fZgApROQrkioAzenxkiHKSxP/bf5fjlRsN5MOx6pX79?=
 =?us-ascii?Q?KkU2zAGkCllfxrGnWKW3C4tuRnin63XDLZduDFEnMS+Tn7ekTNOrdEPvCHVm?=
 =?us-ascii?Q?FBMZvzjUHojE1eEPWR4BFb8I10125H7wPajq54G9R4NHJZNHk4xPlV1rkdYH?=
 =?us-ascii?Q?BDNZpoDnUaUJuJNgesMMBQ94wVegqRAFJC8XMP6DMH2U+bNmaorXeVH4alem?=
 =?us-ascii?Q?HvCwfXCbSa5mero0XDjNE7aZM31fNl8HdACkWdBpdj1UdXCQ8IrRIG/GjQhe?=
 =?us-ascii?Q?Mmv1Y0Pj00cBYRdfYk/iW6IHmlqGDwPcITLFfOWYT14nsouhyZJeQJsKe1g/?=
 =?us-ascii?Q?qE67kTzojfPkTKb5mwjpj60LD9wBy4GhdvzprMDPYaRKirZc5e2vbrbZYsL3?=
 =?us-ascii?Q?QkDi7G19mhYCePDS4D+Guuxp71/rWDw0egpc1bN8EX9CkdZrL7fClN3aHPSS?=
 =?us-ascii?Q?9Fu6SmlIzq8xcEvtb6A0P0JHT1j+PDaSYlat7B/PUN+UuSXCsuzC2ScYonL7?=
 =?us-ascii?Q?sJ+NC51KoysnDg3r9RJSrxtaYS1pEcXCVhi6E37cvOset/oMgUuEPUPryxKz?=
 =?us-ascii?Q?Hh9wuw2Is/x6ejMAivXEN4BoIY8OzI8yrfY/PiKrvhclqFgixXZjn/dsR6+c?=
 =?us-ascii?Q?ZNI+ShcyAcm5bt12TJiQqCMrK1cK4MFKSXBQEJI22KkpElI+0cAMW7usz97n?=
 =?us-ascii?Q?jHBjI2rOn3jrHr2FUmXfp+wCLMbDHGheTdbqzDrFKVZt8Mntd2HSa3Vw6Yxr?=
 =?us-ascii?Q?GComDHaWfBRkLi2gbAAtlgXQYrPUTuJHOJrwhGvFyg6+mapfpl9dqof067KI?=
 =?us-ascii?Q?VxgxWpkko/FQKnXSqCGx3sJR64uWrUMZ3xY/IRd/EHsvKNYxeyqwXK5zgZzu?=
 =?us-ascii?Q?AU+KxWWvY29jzKHHmzQdDg1/W3GyfyI40eOwF7TKkN+v/tczX6SPqV3jx9dn?=
 =?us-ascii?Q?XY/c3fEdlCCfY8TeO2Yuj1Siyufedgo9DNOeo12zhV5p8FZPWsd1ehJRig2r?=
 =?us-ascii?Q?dNwL+GZFi4P+/KjlacDwJHs91N1j6TXsPg7dr3cEy1h9PuoyVDG9VXY0fXZa?=
 =?us-ascii?Q?VtBnqaTcVT+FuAzK2QID2+6/NeUdAdR3GQbemIz4cZdAzX0kuiK3xwJxLDzR?=
 =?us-ascii?Q?a2Uyk9rcTpuoQ8rTA4ukiDpINoIN3VZjtC46INodEsiT71DHl5jyL/gBgFif?=
 =?us-ascii?Q?/imalaQFrp768rnEbLEh/CfsbFUPa2PfE2rzZpuLmFQyRZWNB1rPs+w/JP1d?=
 =?us-ascii?Q?NJMHf0KJ3q5fpeGhzKKlIXYpJcF9aNtn4mJABpCJZWtRcUgNgOdOwK/w6si1?=
 =?us-ascii?Q?cz4yudZrKDxbnQ3rTdoWuDw7ezezrMEIIF0aTyTOGcdJkgQJsZaVMIc/TZVE?=
 =?us-ascii?Q?W7GoPc6DSzQRT6A7J96PO0T10rO3pKSeMWAxVboMSo1h857DmMQnQEKy78M0?=
 =?us-ascii?Q?TjHBTNr0qjp7MGjTAEwv68cTR5tDMUweirrtbBHoAbqDUMSklYTHfZYkc5Pz?=
 =?us-ascii?Q?qeqXBAKFZLu/Gj8GW08AXm9cTrXIcrGnn2G9cp47UCuyDvHXmgRGvsW7oeOd?=
 =?us-ascii?Q?LxPhYynm64Cj+N1J1Zo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68274ff2-a7ee-431a-fd21-08dc04966874
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 15:38:42.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+B0Jtx3inF1IkIbVdvgNpCJlG3Uj8+o+CoVGLTUsxSOjM0G8V8V2IeirLxOPOR2kN6yzmfUVoJHOujtF4Mm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

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

Cc: stable@vger.kernel.org
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


