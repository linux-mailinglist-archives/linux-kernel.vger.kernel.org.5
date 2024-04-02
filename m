Return-Path: <linux-kernel+bounces-127686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A787894F72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1268DB24115
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF25A4E9;
	Tue,  2 Apr 2024 10:01:57 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADA17C8D;
	Tue,  2 Apr 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052117; cv=fail; b=kT1enF8S1FP2t4+bAb6JUau/NZrKWXgtNzs/YhAS+Ub6+r9Uhq49VBS0B1r+g34XnatR3NhZFGI/a8pJKQsMUaKsrgLqFd3HaDcdThqiriwlFayz11nx3prFduP7v7WKPoTvJyfsKatthhnUU/aqf7Hbp/KD927bHCW+pycJv9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052117; c=relaxed/simple;
	bh=8vy9iC4xZobNonXX5You5QxmsSOWhQLEJArk/ruFFtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aoeqw2ZQx/vyhEYIf4XfFx2gjV77yBJr0YNW2S7w7p54d73DkI6Z1nVhZkFmfI6LmD0PLWZAEVFZPSaV5XHvtu8suJWd9hJYgt4bG00MK1BBiZ3s6RwnV8pUWylJ40T5KsrMR5y6UfWezZf29zdfcW3MfdewSp51+/E129YiN5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub5vR5cVFA9FDUklV+/Dsp3HSwCRQ0a90qhKilbQdEhCl4Enxc+axVVbCTgfPrhBOhtsjgTHyykGSXEotiioaW2e3AXI+y7mv1mO9qZNJmVbgnGk0n4CMX/I0yf4I47ZvwfGNbe+SchDwOScIkllz4dkd04Z/TDMPVQ0hlkNsh+nq3tA/ND8bKj7SVrwReo8PzthFM+KWqzVgB2EKRZLAX+qzvAZo+VWXSfEBxEtqQFBS3EAcxfPwoKaycPwxUPypfOrmoaWBFwQX1vRxwo2qQzFU8xbLbHOi7Q2Q9nQMQon5+0rVgjJ5BTrcWkiqJAgm5UnbjGLd0FnFJT3+dHeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpOFUQrZW8GSQTbW3FIMAhf3C7AGEcEZyiE+jejurPc=;
 b=CnD6LJUw1998zvLYzQy2qvjt8gRAGaju+NBVagkSITTFY36n2KlTCmJBxgpdO/1fmCodnQiAZFJcHOMZqX5EzbVMvCdwzqfvNkDAg+5cNBHnUjpFKfe1kAlf4/u33GHgKmomoB2qJBSXtl3eDHapJoYgbhkoEEHIcLa7D9kfm77dv1l0mLkFXVFNlYo5Zh9scm5mZAu19rRyxXz0oIui3POPeTvUxuXEMnkE3xkduI4e5c2PylGhoQT5JlVErP02ht82GzLUC5baRzIzg7s9iYELyvTMGO0k79PGdQLKJV1q5P0/piVns479qSA+h3K9CyYsOeCETHZDG1MT0ZWtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:00:43 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:43 +0000
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
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Marvin Lin <milkfafa@gmail.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 13/13] admin-guide: media: Update documents for StarFive Camera Subsystem
Date: Tue,  2 Apr 2024 03:00:11 -0700
Message-Id: <20240402100011.13480-14-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
References: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::11) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: 369657c0-cf06-4450-7317-08dc52fbc263
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qF9niEURcctatKjlD3lhalEvypwVvxLLjdZF13+XQnOp/Uopuh1+b+G7vpSYIdZm90P+F79coDzxQch41b1ydp291ZKcxwGPPjNqHeaeXD1Q/fchgKVhsfIJ4JWHWKQ1WtQoRKvPv0SeoBGQxdcNoXsGtgTLl/zEnGWV2LFp0DYIv5g0x36Bb/gY93ESLbgX+uRKuGxcmyJ7mQj3ycBy4AzoV8pxeu836mJFemF6mHuT+LlSAUalLDjqvzEAF05/JBecKs7zpvrmW+0P9xCms0Paf/XkLEvMe76mnCk0WrFQzgWhTbY+nOx1KaGOMrvBUmxlJjk/92tQ9Lk2dSSy5hT7gn5YJVnHGUcFH4Zn8JLIDfPCM+A1INYVoTcT+QJ+EOwSawVodvBR0jYSAYZtqlQ0tUCbfwYg7tC6eEdwut5FrW2Y/B4Ji8+tlG4YuG5jesmuUHUOfmOwm9uEWZVqss14wx6Bz7qodoAr+AV6kt8IiiJWSq5+5crZPXIjOcqj4aM7sl8OHFpcWfpuoRSmkXOot1ORbaDRrFlzWjBTk4WNfH+A8owi5QhtRPFV84Bho/0r2PXzcq1CHpKLN9ubyNvNQLjUv4h18XgCl5ZsvOPm7w8ygQnBXy6DtSj2kOLp9X7m2E0qFsx9k47S2ic6Bg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+AhEdW/0gzVZgaxNxUI4clDiZDXsAmrWX5NvFkRcixewka7tLzoBkt60lUk?=
 =?us-ascii?Q?SvrtWdWonNvfeXpHj3c+eoWTtzzICcm1FG2Jmd6C8/vnfpmW7ogdiPUlN7rT?=
 =?us-ascii?Q?rHnUSS3h20z0jlUJn4KaiZWLBYNZWRSmRtxIa3OJbilj5ZWgTCUXAMqfFWQw?=
 =?us-ascii?Q?CoB7wibtauMEDu3lH0J+qxgSGkxwRN5Jc7ow64V+k25CLSaXTstH0vw3rzEg?=
 =?us-ascii?Q?/zzTJcsxyhOcEEBAHay7F14vO/1w1AGLBxCV+LoLspqLkRtBgJ/Ey37ptW7F?=
 =?us-ascii?Q?kGQu2H0Y3xqahkqgemLk2Jb9qXfvNCyiI3JGsmCh+SUwYzXM1mm1EiINhnWN?=
 =?us-ascii?Q?CuFn+F+5wnc/BfwQ3cUzxx9Lrfqd5tcSzW1dbbU6rCqcA2ziMxhPKoOpsxUm?=
 =?us-ascii?Q?zoqmBX7FNtnf0kvApF8jW18QXWK/OHdi2jaZAtKibP+dzgi97Kk0oU8hbQKA?=
 =?us-ascii?Q?cV9D0/CBD81vdbGqDvDCC46UbltOtmCwzX3A9RfIN0GOgVIiZdVQr2d6At5N?=
 =?us-ascii?Q?ChzyOm1fEOzqPOvA93a7+olF2xdfY1lZDus9lCPekCYjwr/p9mrrDS9lOsKq?=
 =?us-ascii?Q?x2fAt6hm9sVgqwTc/67jvf3T++WuKoNZ9fQAr2rHCjWYQkSV/WmC6OaZqTx8?=
 =?us-ascii?Q?y1jHyqr1oPKqvqJfbDAHQrYIuNNtkhxLFJ++2rMO3otw47cNHI+jcOnpqDXt?=
 =?us-ascii?Q?kJXfBiCk3mGkVkt5OI3KEm9pvaju+nkyrRS2DKXR91caBNUj3KbnMCNhwsFM?=
 =?us-ascii?Q?1rILWs7Qbq2Tm14cDLaSLESxOG4YubodZGtbjMDtbj23wOW/L7U3osz8VBAv?=
 =?us-ascii?Q?2yQuUDFDGPR8/W3Kx6cAln76zIKV1wXyF6zO3Oo9cSVKhr6+KTY4P2Zb/DxC?=
 =?us-ascii?Q?RxRh4UpAMu+NL5Zo3D881sji8J1yeUUXHVXwXJ92LV53qo9fLbZTjZGY6u7N?=
 =?us-ascii?Q?lfnbw+PQPtiqQcGAItrRPqIklYONPRaxUmOAK4Z0YRQcRN+9iuHXXslYvnnR?=
 =?us-ascii?Q?gkW95y6FlrifLpKJ6rm5UdIOHIIYjXgoNPmx1stISSsiF3wqfdb6LpgrBSoZ?=
 =?us-ascii?Q?qKzjg5bH7pmjn7bgEzF0fNDaErq84hDVOkaMaU5WQAbJzllJFFWVaFSqF0Bp?=
 =?us-ascii?Q?2SJw0nPEdG0kFaIeCvKcAP48osAJjBE9fEcUFhwGttMEgcqIfuhKyt+1FY5Y?=
 =?us-ascii?Q?7P1XzCqOXXcwyyUvTtrV2sFB1SaYbybWtxTbo/wCmvLojY6qpJIZVoNEBlt5?=
 =?us-ascii?Q?rlLO3nCi8LTNmPrMhgb5HXFVCxgZVFDucCyy0dN9slLQYwlXayTA07PVXQuW?=
 =?us-ascii?Q?YccM84zOzu1ohhgrCcoIN+6xVAiPwDbXjUUOQjq2smGplcAbPX5vOJzxTVzl?=
 =?us-ascii?Q?3NFQ/OsblayhU7monz+ZiNIFE4p5DmVMfSgtgzGvp2IQ2yc9MHuZU1dm0mus?=
 =?us-ascii?Q?AU6bqEE9odWDDIekte3k9DhWLzQiJFuJLq2kGR1of1ClfaPsvVfWGPBZeL1+?=
 =?us-ascii?Q?lv8yuNSs9MIhiixrz7nLn6/Xji6KxAjLlvJCcn40tqNYf5ansrEJgBiUqujg?=
 =?us-ascii?Q?XRwaTPwEwu+W6hu3+rviEK7Ps3YfVW/yobTnh3lL2q5qUz9wDdvQ/IqBdKBv?=
 =?us-ascii?Q?QI6pE4X7BFZT9Z1zqbUGiEE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369657c0-cf06-4450-7317-08dc52fbc263
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:43.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ssf3/xkxlETVX7GX8jpaLoteFOGve+r8i9pAgyY4M7AdT2carv90tAjB05r+SUepyIxgnKbDVU2nZDbppPVlUmmtQ9A7pPJowYM+RmIx6JGn1gf/DcJbhPsDmNjwUgiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

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


