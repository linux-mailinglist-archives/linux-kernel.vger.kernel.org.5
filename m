Return-Path: <linux-kernel+bounces-23236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F4882A946
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1454EB224FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2EFBE9;
	Thu, 11 Jan 2024 08:44:06 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2078.outbound.protection.partner.outlook.cn [139.219.17.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA112E4C;
	Thu, 11 Jan 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIxeOipYEthRXY4VNYER2SdrT8spMDhUbVfT+mwFE2DsJdHCKMv84f5+tU3GBppEY5+n4QoFyzkciyIHT8DNuicELelNdg11hS7bOC/GOHi/S7tBmXXauOD23rV1BS8LPaaK3Devjri5xu15+K2WwqzkvuoOL2geZ0pAF+sZ2Qz++hM7Au2MOEKxa45qSUh0E++EfRtCqkM8DpkB9VNgtn4EhiIKMpvykF1m4ZIIWdxxQpkjVRNr6gx4CYf3/MGarfn7gDnEPXB/MoPRcj7UVNTho518YXX+Lj1JidckuwTEGL70MQ4Gy8m2RlKpAy03HaQ6aJtbJ30sqaDnkaQIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpOFUQrZW8GSQTbW3FIMAhf3C7AGEcEZyiE+jejurPc=;
 b=ChtAX8/hG7mft9bC8R0UOLo8tZd3JQhymB9F4Srx5a2MTUcBziMhXylIc1tbwznM4mVSxmm/7lk0tnCQqc3u+Tol+Wu/pU9OeJI4/jNqEmIzHtbcXllCWZhOPY79JaWADApKBrqNZZTHf+KNKVLjNjjS6UEZR+XkwdKrFiv9sepOjEeSAJq6OH+rFOhKqONm/M6JAVMoo4BJlf+IM8LjwnjtB+HRnXfHyMbschPSHSvA3evizO4b0jAYK7s3SJyc8ldEuCOHVqscYcbUZswnIOIFIiU5uYFANa231je7NKwkRPuIo7EndzNl6PW85woHhacuadBBmkYpxECGWXleKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:38 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:38 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 13/13] admin-guide: media: Update documents for StarFive Camera Subsystem
Date: Thu, 11 Jan 2024 00:41:20 -0800
Message-Id: <20240111084120.16685-14-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4adeefe5-fffa-4d7c-884f-08dc1281207a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9vPfPawBswxprqsK+nmVRHIKN9qLyoAoEibmBgh4kcjdqesmdPpytKVoxSqrdKIpuNCb0KjQ8wwTp/cKrQi55is87JZ3T7+Y7AHRyQg2mkqUKsJPuBHH5Fo7f7uQ1l+STAhYiqfbwR4ffjLmhr+UWYoJDVhC23mPm3jUvBj57gP/ZyWuw1pildkvs8Ns2qFV/qSbU+IdlHCxe8kxGb9bv2LiYmtUqQQRH9rp8xvBF0mxc+VNMSNgwDc69f8dsunsdhiuBHFVAHO6KMxEOr/PvQAG1mehU/rQvKPTrYk7GY7wp0UAp6O6FS05BqZnlnb1C6JMsAVVn5jfkQgd1LrcIwa7D+zjBvxwDFujlbtWaADrL9O3cRIYU8tz2sjYMJaVe33my4EY4AD5icDhd06B3Sc5MWNXQk/HOEs1lvZfUDldOct+1QzpzQVOI3/5I1cAE1umWYt6Ng+3HguHYnf5sr2sAYbkAXxTa0FlQWsxZkUvo/JmgGpczl9w8dwQ6Vxhu0C/Eq8xd3p/hfwtAXY7Z9upj0Qix13GJZr6ckwOj7IsERUuycKyWvTsCYlBkBJjiEAPq3zYoXBAz/4Z9Z52Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfbBV4WjX1MUy8Gss0IqLtkjxJbwiBDkrLzJmanWA+UmwmnQp9f6VcO5e4SQ?=
 =?us-ascii?Q?mcM52jelNzUVX1aEA/h+g2qtHLoP1qof0jaf/l4VLYqrlsK3BO9jpJzbHGN1?=
 =?us-ascii?Q?2n3LjO2e7KOZqVmd+1RwmU2jcEtBKUNTKgN79y2LvgqCuqw4DdHeJeym86+N?=
 =?us-ascii?Q?uORR0PZmmW9CkR7UgboovVu7YjW+trzDrL5ueSi4J6zga1UgPGfTqrp4J7nS?=
 =?us-ascii?Q?9SsnnSKZlduXo8q3Nkw5X2Q6aCfk1lZFKODFn98xtUOMzgXXRuZejgwlnyA5?=
 =?us-ascii?Q?QV9iGNe0vgwqSMwtXH9P40YURgOX4y/PROlul9JlD5VRb6/A4tcpKGqlj6Oc?=
 =?us-ascii?Q?UYIUQ85k53Px/SmVWGZS7aAN+N4VxV7DZsY9AAvpTBZxEaWk4wADSZW5mYjF?=
 =?us-ascii?Q?HQ0uYSeV/azRUsqtwl7rG4a3+0Jyid7OdrXbeavHALxTHAshvaTGkPqxMzjD?=
 =?us-ascii?Q?megN8gX5fkIrnVD9sGWgUXOb0ZrleWFFYJlFENIL83i5oM2jlH1tzhRofy9f?=
 =?us-ascii?Q?qZP6ZWGwAdIpD/Rpof0NCD+UMkjh0+RwmvWfcqqOXGRtQaohOLEjnlxPnFHU?=
 =?us-ascii?Q?2DU39Iy6EgQHxd9EwnOhFzo2A56YuKsLu7kVj4YVDpF0K+d0AxldxZhAY00v?=
 =?us-ascii?Q?wlQHrNVJSO0CyHGLN3VcpFpdq21ol7OkXhFk6JrxvT65e6mD3q8BZVEKQqOj?=
 =?us-ascii?Q?f/tX1A05l8hib/79mozdgc8Y09y6lNUrAhiH81HXrfywWBvJwQLkSJwDnSz7?=
 =?us-ascii?Q?wDP16epO4NHXNEF/uLkKyl1zi/9azg5FymYV3RXau+FSotDk1HO/J4azaRn4?=
 =?us-ascii?Q?VdA/KkVIFc0j7WcXNwdxGdc/xNQCWGxX3fCyOlp7OC9j+a5QoMwMdE/AtpHj?=
 =?us-ascii?Q?iQRWOqgmGvOEn3aMggIVZ/tHuuluO+FvzqkwR9kMsVq6uot0zaQSApOC2MyH?=
 =?us-ascii?Q?bScmZmgNv2Rt/JcoGejuAemXyKdMBtauqz/ta2w7bv3e0jdFFSEVkqTj9JE1?=
 =?us-ascii?Q?rZACQwPzz2N39xx77jhthZj+IyVZCfmYAKxcrUMqj+8kgBt9uuxE/Jr2q2IR?=
 =?us-ascii?Q?9k8Vz0H/cpcKUmaMoLyEbGMp87nwqCBOBRG8nq25vhmRCGQoU6n9NEd2hFwv?=
 =?us-ascii?Q?KJw/+zd+tsKb///ynjjaU0wjYPeoybqbVxBAb0G/zrOUikKLTCfxPluEUTwR?=
 =?us-ascii?Q?vj1iDhrsnmSn7hrk0zcL0nPNaBn9pdvw0JXBP+b26S6DPPCBNbdNrWCdi8ux?=
 =?us-ascii?Q?hFIQRgxCTCHBhN50IMx3WPZWOb3O4xV03IcsyXsgbBbaXyZYIyHd2edjoK98?=
 =?us-ascii?Q?ecakCkkvXE8b64FbTGwa+X2EE+s0EL+q7tdS6xJofhssN2FLmac5jPXR1mP+?=
 =?us-ascii?Q?Rr0qlhUCl+suBeNj7cVvVjMXh/Q13p4FOI9t/ZM6PuQ6VjHfCIPhBam3YEl9?=
 =?us-ascii?Q?6RJA1JgR+8I/32szJZsKkSUc8JZSs9F95rzPhMB+hTKl8vg5y3JItjn+4UuX?=
 =?us-ascii?Q?hgPdrIeYZiJC/y7XXufH89hMjr+BTM2kWk+1lY2ZD/8e5cMPDTdIRMD3qwDW?=
 =?us-ascii?Q?gZUw37l/qhkj3HUSL+qGmX1qIkyvCoWT2FrW9GNOMOovQKC8PsAfC4AaIq2P?=
 =?us-ascii?Q?37ZnH5/ZuRDm90hvwqDcxCM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adeefe5-fffa-4d7c-884f-08dc1281207a
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:38.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDqW2SKFUzz/7OTyOhbeYbu+cyA726nbYdZeRVvIBJ4oiMiLiOsSW1gFM6UCRvKJSh/o1CeIblTJEck3ZR9Svh2aer7r9DsbsoGdaJMawQ6DMg2o3sImdZD19li3tAyx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

Add ISP output parameters and 3A statistisc collection data video
device for documents.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../admin-guide/media/starfive_camss.rst      | 11 +++++++---
 .../media/starfive_camss_graph.dot            | 22 +++++++++++--------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
index ca42e9447c47..020f1969e67f 100644
--- a/Documentation/admin-guide/media/starfive_camss.rst
+++ b/Documentation/admin-guide/media/starfive_camss.rst
@@ -58,15 +58,20 @@ The media controller pipeline graph is as follows:
     :alt:   starfive_camss_graph.dot
     :align: center
 
-The driver has 2 video devices:
+The driver has 4 video devices:
 
+- output_params: The meta output device, transmitting the parameters to ISP
+  module.
 - capture_raw: The capture device, capturing image data directly from a sensor.
 - capture_yuv: The capture device, capturing YUV frame data processed by the
-  ISP module
+  ISP module.
+- capture_scd: The meta capture device, capturing 3A statistics collection data
+  processed by the ISP module.
 
 The driver has 3 subdevices:
 
-- stf_isp: is responsible for all the isp operations, outputs YUV frames.
+- stf_isp: is responsible for all the isp operations, outputs YUV frames
+  and 3A statistics collection data.
 - cdns_csi2rx: a CSI-2 bridge supporting up to 4 CSI lanes in input, and 4
   different pixel streams in output.
 - imx219: an image sensor, image data is sent through MIPI CSI-2.
diff --git a/Documentation/admin-guide/media/starfive_camss_graph.dot b/Documentation/admin-guide/media/starfive_camss_graph.dot
index 8eff1f161ac7..7961255d3ad6 100644
--- a/Documentation/admin-guide/media/starfive_camss_graph.dot
+++ b/Documentation/admin-guide/media/starfive_camss_graph.dot
@@ -1,12 +1,16 @@
 digraph board {
 	rankdir=TB
-	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
-	n00000001:port1 -> n00000008 [style=dashed]
-	n00000004 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
-	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
-	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
-	n0000000e:port1 -> n00000001:port0 [style=dashed]
-	n0000000e:port1 -> n00000004 [style=dashed]
-	n00000018 [label="{{} | imx219 6-0010\n/dev/v4l-subdev1 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
-	n00000018:port0 -> n0000000e:port0 [style=bold]
+	n00000001 [label="{{<port0> 0 | <port1> 1} | stf_isp\n/dev/v4l-subdev0 | {<port2> 2 | <port3> 3}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000001:port2 -> n0000000e
+	n00000001:port3 -> n00000012 [style=dashed]
+	n00000006 [label="output_params\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
+	n00000006 -> n00000001:port1 [style=dashed]
+	n0000000a [label="capture_raw\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
+	n0000000e [label="capture_yuv\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
+	n00000012 [label="capture_scd\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
+	n0000001c [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
+	n0000001c:port1 -> n00000001:port0 [style=dashed]
+	n0000001c:port1 -> n0000000a [style=dashed]
+	n00000026 [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000026:port0 -> n0000001c:port0 [style=bold]
 }
-- 
2.25.1


