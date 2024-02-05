Return-Path: <linux-kernel+bounces-52252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9948495F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340DE1F21507
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D30171CD;
	Mon,  5 Feb 2024 09:05:11 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEB1429E;
	Mon,  5 Feb 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123910; cv=fail; b=haEhD+uWs9Xz7WCWW+doAIKsAVxe/95XM6NXb9DslF5N77x9UNBd8fbXcMaYyGrd+bkBn0FFafYCzshjf78Rt2JINum12lSdDXIIkWQVlgwLl+Pr5nCoi8WP+51Z684IT6lKgRsXwMpWfnaU6ODdhRy7loQHvQIZQG7SNOoaYrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123910; c=relaxed/simple;
	bh=8vy9iC4xZobNonXX5You5QxmsSOWhQLEJArk/ruFFtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9CuDpIhWaV2TMfF2e3buqz3iuCvx4uv8nsewH53t7lz92rwAGRaJGzg1aHnBC7DEegD6HcqQJZjozLZZB6Kyisk2ftIXK3eZnXMhDwK+XrbEcXj2YAZleJ8Rr4QC+Yu9rBOTMgamBA3zKYi+E4Yyo+7ftb8Zg8/xRKAf+JkGn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSEhPaCmVG4LD5I/rfQduHt6dUfEQm8SPzfi2PNh6oDlPSDf5ysZXvvNgDspXtaDgHzftrVLPXX1ZBTDKqlzpxwXYsAuio5cDV3ydwGMA/bzdxND5lwihTEZAhI9Cx5uvgSOCPQLIIy5coE3EvFviUWIj2SSLYvQDCuGTHG9eS0TOlX4A0jUxjJkBN4c88Y7+Ozcb3Qa1ytoAaIeqVvW/uKWGMWJrPi5UKKLOkCzPfZl+e5lTUkH/qnHNgb06yOmFQG5siTYv+7LwPwHFvQVpvU5sDFmWf6I2fbn2znU1cfM/9TdzNbHmK6Hd+1viyE/bHgPRUpSyO9DvmTz4wQLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpOFUQrZW8GSQTbW3FIMAhf3C7AGEcEZyiE+jejurPc=;
 b=RvFoR1Rovv9YZwi77ZYnN1zlbEC6AxmttTfUrYzNyh6aG9H0v+YcybKB6dDIxmSWS837aKHah6T78YlDdRMNUpFrk6QeEc7Ih4NZM3wP+bQIGtlTN3crX3PQo28dMIjNqqkkN/cYtyBi5+u7tjBP7BYx9cXthAiLR1z4ZBdLEghxh0br1NtqIv4TpZU30z5msQkKd/Tpd5XrdDEQcYbxRbutHJRjcWfgA6J25Mmuk9MeKC+wTwa2PG4zBNouMNa31XWpaiLVzGyDD87OoU4jI3oA+hTARbajDcKEHanPXs8ZuSHVw9pyz5S3g/vevBf+pYOKG7tHlJiR8ezAFboOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:55 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:55 +0000
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
Subject: [PATCH v3 13/13] admin-guide: media: Update documents for StarFive Camera Subsystem
Date: Mon,  5 Feb 2024 01:04:24 -0800
Message-Id: <20240205090424.40302-14-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
References: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0815:EE_
X-MS-Office365-Filtering-Correlation-Id: d72dcd5e-5c92-4d33-ed3a-08dc2629851f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OgXrNeTiKnnxiVtVzPddcntGGr3PFT9QsSf5UozD2yGMaNX/k1bInvY9lVYfqDPsXQYRuBYQ5AD7BNmrh+hUTkJNzOh4I58CJjEUbTZtpgaKqAhCULdq/X4zZ14c5pUyyl5P3wOwotkDmgGMFkApfoqMfX2WjpCCD8Q9o6B9lgVVQwoeMAJoijFrqNemPD7QjTp9G0btAqMiUqCaAwR+e4Eqevh0pvV8HVxUuLMLyO6mPsSRYQAADoRPAGAbQE+d+YTwLog2pe3wcuVKbjEFisOt5LHd7EDe1+W8qVXPeMYlOdaXGXJz6Nv7hQPYCUQe8Zbp3HtECJiqUPbaxNRhjLDNYxItuznMHJcGa/AbUe2lOB4gNLB6LYH4in/eZ9QJqw/253deFjFrgWqrUc6HXT+HiBvReMqZINhJDjJkv3GvXdY9ktQx/g3oY9tV4S7to0HUyMG54yC//4O0U8k2ARvTvprWosFmYDmE3cQG9uYM225NFvNX60x/0piajtiyOR214IDL6n8pN9Vdj5bkQIHmV3TXJpMFJVTUV08+WvIyJo2Gpgcf/nw3fowBzed0Vkb5VKaRi4D5j1ugmBQdiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPLmmRuIqlYsEWq8yOEa8ibeCSJwYBIqr5T9A19ra9DbyUpeXVHMouPLlrcl?=
 =?us-ascii?Q?ZEVO4jCYTxygBk9vJcN/9pX/mncepVAUVSEUtpdeopewLgZPRTn41fk0p7R6?=
 =?us-ascii?Q?UYoGpiTWtcZMEFM2xh05K/i+1MBkLIHPtHxqqXH9/tLNxQf6aUG1i7ZZB04y?=
 =?us-ascii?Q?LdgUUHATkqGM6SMl1nyU4QO2SZZ6XyO/GOYcvsbSPMlX9Ut8dJZa82IAjyee?=
 =?us-ascii?Q?bG4QOKgeh4g+nBMn+sWR55nQBtz3fOlt8Ux515OklTNxCKeCaYO/UfOqPOR4?=
 =?us-ascii?Q?V+v6l/KitXLGXCP0Y/04SAU6AlLFe0xvIsgZxMNrISr0XK4RxgPbuvxKbu1q?=
 =?us-ascii?Q?dZtoV0CQTG7BblI83RjMyh7A9dPZPDEP6VTFtFfKpRvltUuk5XIQKqHgiJGi?=
 =?us-ascii?Q?uwwspgMpSAw9aUuMimRXKxGJyRLdk2jrMMxK6Q44HJvvl3jO+g3XKZG6lQml?=
 =?us-ascii?Q?9FsTYOaU7Yi2DmFNcD0CwiQgTGsrh+6vkDkILmtwchAE3NfAUh6n0i0Kcv1M?=
 =?us-ascii?Q?HMBz+e1WwYXZTp14FtW5GC8mS5zNUBKuHl/tdbU5V/9rJydjnnAZQOwy/IER?=
 =?us-ascii?Q?aidlzJOOhSRdJB/IzzjsiactEOc8nF9ScUG4DQKUMcsTHFOi5oSAYj4dHWNj?=
 =?us-ascii?Q?vZXTNHYp64naSB7+Am1SBkczhiRZ4kd/7gHUL+o4W/6LcrxN4r411lLjILtg?=
 =?us-ascii?Q?+YG4MWjfriPlCowvx4uy8OS68fYixfbg0SEOSh+VMnagFJ5UKxho2tfF0Q3I?=
 =?us-ascii?Q?mjWoMHwcdVrJcZX11X++bgTmIHWexN8wWMz4JyD7fAZ8Cds5oCzZYVWcIjOE?=
 =?us-ascii?Q?JO82dUuhkyu/FWzEPPADu1MhN8E+OARnGfO3vo7Vfk6oa8eUv18UKP9tU68R?=
 =?us-ascii?Q?K8j1mnTWyocmPsVrhRri3q3fdglo6kcoa3pm6/B8q6Urq2gVZzZP+6mNxb2G?=
 =?us-ascii?Q?UnUv9PHqbbY4+uyhisJsarQw4RqSbfylQ4KKpkQceBfsajY6ZFufB4DFM913?=
 =?us-ascii?Q?Mig74qm1oYV6zqOJ+d43nK5EcVlH5KPpBRpssIEEEep6ZEVsVJ/vYhmovHrL?=
 =?us-ascii?Q?WX4BtKWlf7dJbRnNf9fd3PnqHlWF8Hmf3Z1WgF1C0baAeBKXCSWbDmMJkdwf?=
 =?us-ascii?Q?XCDRO6qOX5kPhyT0C0WPNSFji/Jy4Ysqq9SVN/qU8mkFjAGK9jnrF35NFO7m?=
 =?us-ascii?Q?mQaSNE2EjmJ3MxfFD6SwQha7x/ArSthvQsBBE7Q3aYliQOnVGELUBFpGei9t?=
 =?us-ascii?Q?g7lh19PxN4HdKb5kwtDK9a/o0fWpsHGQ/1VlF3lgVie2LqgXDtfrQ64WMxwc?=
 =?us-ascii?Q?EqlD1bvJWN2WaNyUZp5/195omosyWHNpvpekdD9Ac87/9PAzwijbSq2l4K5T?=
 =?us-ascii?Q?TxyXanDh9hFw04/vbdetwt7YyjbasfzmNZYtTHXlKVOhPlELcspiYngV0BGt?=
 =?us-ascii?Q?nK2tNq2m6IFV/5AGN5xlMXAA8SkqnMiQeRWqVLUkOv2dRc5YQabFkOU99W1B?=
 =?us-ascii?Q?EryrZu0YOtdCZwW/qrI6RvWAABIt5H4qRTq3/eqCWSlr+VVjwNWclW4Ww/x2?=
 =?us-ascii?Q?R8CynT12Pb8nfKapNO2NXlXCDeoI/RVh43AAHYYt/QdeYSCpcbrA3leX6bE9?=
 =?us-ascii?Q?5QkH7oQsiyDR4MAsk2RaxhM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72dcd5e-5c92-4d33-ed3a-08dc2629851f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:54.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Onm3fgqm8eZsquEby3MfQZ1wpPsJNNxpn31ygaXSMrSAc7tRzXEH1AHM4mYIyglMHVmlq9cDCR3ivJZbnk9cYvL1xjsar6Q5FubqjrV9i9QZe2lS/nESFRSqyuCnL9q9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

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


