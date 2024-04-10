Return-Path: <linux-kernel+bounces-138237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B889EE94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5764B1C2139E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A30160790;
	Wed, 10 Apr 2024 09:11:29 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55A15F406;
	Wed, 10 Apr 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740289; cv=fail; b=fRIzuuOeulFrcngZqmqxwZzF0LtsMUMtSSvuiGRjyDbR9Lpnq8o7PPpbsFXA0BnaxpXvdzbV/Sqg+02d1VpWjL0XcAzcw467DIDoGsmhiFANfSnNEoron9eVtNOFxvFw1oUTA1ndk3Vk0787QobX8qovERraoromHfl65w2wNhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740289; c=relaxed/simple;
	bh=+w51sV7lrP9fLbWXLGg2Qhohea6Fb8xkONdEwHk/YOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S4bz/an4Xc1ZzWddkHAGmohDk6JLO9GKdZxhY8O+E22JMIjsaz/TUk6hdFctHNudK83689Js+bM1Z6I4ANPcjxF8RGU8U8UTfjGdHMu4Eo4hX01RM0sn+yeg1g8KPNdRSTkf8v9uud3HVwzMh7fGVxJzNpULamVdGW8C9oW6KFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYKTJiDEu1+tsQ8c4PK1Q8B2MqtIaGWrM/JRi3PwFWZhqYsFzouLxbE4fj0fibG/GocGpBC5z1rthRNJ6aXbcQWTKLlLOTlx2YndmCABptW3GeBfpVUh2B+/OGqi6MyltmMeH+hJP/q982P4F6QqJioqgSm2dPlCGETgoNmw0iOC3XJ47JJw5WV3IFXRMG9hvwfSUSyGBwUHzptzpmWNrV0zxaa4dSvcKD81voyCrY+X/fwplVGWqhHdUTW2fg80mh3I+myrwI9R3chCHqV66Z9n1ETTVQEm26/mHsSCpYaT1CA1lvSdcCZ3sWGjEk7iY+JmEPn5RikfVo1/CtlFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6TmhdEjZ2mWOnEUjc9RcnutwDWddNv1Xs0WbChx/I=;
 b=eZZCj/1eBH0yPKUrMve6928/8WrGEoERHQAt/tAvclul37giYOjn6n222QhRRKwL67UCDNBYGX/SCMbNTNM+MN4YhhBJK2aOAXQ5bms+sO5PIk3SGFkPBZLPLxQ1nNu04zSy+feJEktTJdKya4CCzGRJPDewWFTMOMhMsnRWf6RsvowYIIKyItm/D5Ov2tpv+xjvVM3MmJm9wo5+uXlcFTTepnRH63kpXbPwp8mwmYwfIaoHkamGzdG+a9gKZXFs4/NMQxPVg5QtOxQTZO8RKGvT736mTzpgcU7riUBTRko93lgluplUdR/grbrqtPr/KVKI2VxYZFIhyLpgpirNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0461.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:43 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:43 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 8/8] admin-guide: media: Update documents for StarFive Camera Subsystem
Date: Wed, 10 Apr 2024 02:10:26 -0700
Message-Id: <20240410091026.50272-9-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
References: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0461:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c8803c-dba8-437f-287b-08dc593e1966
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BIeNPlsVNmru/zeMTjJ9HSXM+AWkjSUYD7qWA7PQ41jUO7JsgPOqa/gV+pD8GMhvv4OW/xbNSY5dqvNJPQmUOYFM0d3VOATzTg+Sqd/616B3o2/Bm+dy5W2rHZh4rzl+otK0zVSL3o3EhTgRFQL/4sZXafb7adD6zCnyfmjCk/ug2M+uiVFVCnKesEP6NuCclKGlCUq/gfOb128OVvq2VzSw+w0bCCFrIO/AW6AnoWd5f4hoOgqwiralUYpaArRTW8LyqjbvVAKCMWSCxRFaeH+4wk+pu0fHWNHDbRr+Wn18mOVD5ui59JRU6rBhH2RGXHn0TGS0rTYHtsWUzGr/ApxQ+71t8vNGC3/MwDLbG7u84uyEuiMP6AXOFGuj11du+vv5GJp/HHDrtIo4zbn2aEWi2WG2psqUGIjG8njzCUuykJlngdsIuAD/gOlJWR7oNKyFhgHaUcqWO9MR0wCbKIQk3ZPDd5Fi8FN6durSjZePiiwoHu1apbKtMvL2epX8IoFH805Myt8vvp2o/c4UFIRj5wdDF1FcavlXZNwsp+SSdYDziA7dSvJizyLooYoLD9vi/3uyCT4DHOtpcVUl6xkMON4vgpNIrIAbJ/1T2pXNoMmdo8WdvKGHQiXl6tGG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b020cqyxBOizk6Fjvu+c8bpY5GuTFwLZwQZguEjAk/TMOnovVZ05maEiLVOk?=
 =?us-ascii?Q?jvTk3UfuMUhezIIVDsYV5LgxPHNubHDZ/V4VL8brqcIg8tiHQLsp3PeBOiu9?=
 =?us-ascii?Q?ntWJgv/mqjZRN+YiVcsTseqbfDi8rhFWS162CpGcYu4hiLdW7it3VkuT8Xwz?=
 =?us-ascii?Q?KntdYl3jgmX2dyMDAHFiqtKDstGaM6xm9gJxL+gWCOAofUFdVx9656yg7PCE?=
 =?us-ascii?Q?SZM1RGeX8Uhh/4arZTW9+9J4Xytp894Q7/Fydrx3P6jc50hKLmZRkKQgHp94?=
 =?us-ascii?Q?ve2VRGfZ+qLReGL2jWxxfndyWtpp6nwdbxPmJgWnSm6Avo3JOr49ZmbwTJBN?=
 =?us-ascii?Q?58idiUUwog/mpBovRK21UmoM+GqsMj6szNgtnUIxa9hXRehbW3wYYhb+5X7L?=
 =?us-ascii?Q?p27w5L/CpHgnEuAMVp41Vtqo6kTBuSvHJgS3KnJhozK2fq6VPrhFvUDPEAgU?=
 =?us-ascii?Q?T84KbNM12PY5MMHEXhkQ3FegPnRqznuQTD9gGPdhMnAa3V5h98ViZTj5MKaE?=
 =?us-ascii?Q?6KXQBikhMALBn6sFQ6ywvieN1cd3WHqfQe3nKG9Wt1Z1vyAw4Rp5ac2A4uhC?=
 =?us-ascii?Q?HXYVpZ5W6vRuUhmd3g94RDLUpY3Bnagxg8OeOGj8KsjH5XS0FUddSKZhia4u?=
 =?us-ascii?Q?CSqTseEucVszjjT24E2dvx5VU7Dd5m4o1GQazWtcF4GXGOGmrFuBXTLl5uOy?=
 =?us-ascii?Q?jsMVlQ07tPubL3fwMNXE6XMn7TcLalaEv9/gYG7TA64g5QL5cAmzSi6KBADM?=
 =?us-ascii?Q?RXr/VXo29AFrBUOQ8tQoQpF+C8666TRDWbF7sZWRYQLhsYwWInST7X+EG4+w?=
 =?us-ascii?Q?cqGPRDvhRdr3holQv64ixEfw0nEtz1WGlwL4IgoT7G93f6F3ZjWWdGeb8Lr4?=
 =?us-ascii?Q?ZaDmpypAz2pAMmTtmNCMBA39RF1LQ/GxKKgeippre+BjMn7cGNIAy4rkoMgx?=
 =?us-ascii?Q?rHyc6D0pZ4GbL3CsUWSgGVabyh0QZNm3a42JPyMNL/JDHO49wTQA9IMrJtOY?=
 =?us-ascii?Q?KZIJ3GykCFyt2Z1rGwJHuQKlUzogUCf7G5SXfZJEis+1kxja+wjHV44U+nVQ?=
 =?us-ascii?Q?VCyqA0AkUDT60E7TQhFldIwLbxFEN79nbBZ+Oh5YAhsLT1jJFchki5XkD0fB?=
 =?us-ascii?Q?QQHVo7LuHuwacXZ+EJh25G3uXNe6rMJNvVAbS/aC7qHuz9V4hO6n1MfXSSXa?=
 =?us-ascii?Q?hJ92CvoV2lPoOrlRM1UtOYuGjCJ+Bfe9CJFSFf2TOJ0WgGWlJjeCurm4WXIe?=
 =?us-ascii?Q?cj8yQFhP6uFgwj5PXmSFCWJhPO/DOxnrVBar8J04r5IKEekpY2DBN1nuhqKr?=
 =?us-ascii?Q?8hzrP3slczEfDDdyzr4VT9UUxnZDDf0ZxMNnZuegVsj6Q45mcdPvHoSOBwdQ?=
 =?us-ascii?Q?fVaP5v6m0wDzyCUXdoGbX+M9icNwlzI0/GmXkkrMEpDXDu0wO7zbH7tSf3s6?=
 =?us-ascii?Q?rIZWq/OBri+2EL3BA6ybjbsapPT05i3ZJt6LZmuSO1EafCAg2YqLzQE/4EpH?=
 =?us-ascii?Q?2kEP4GIaTE9F8s8A/V9i1DeszCrewyS679vZZm1K6qd5KT74FhyHR/Ochekm?=
 =?us-ascii?Q?dfPEsejulmQB4XHlU1lohKxCyTlBZzdB7T/sxYhIG7lkxy/ZDSd8dYMGrs6q?=
 =?us-ascii?Q?su3x5QctLd2o4rB/vaVAZAM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c8803c-dba8-437f-287b-08dc593e1966
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:42.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgV6ptcFes/QMTKFjbimVGvaOFfgroNKLS9BFS6j5Q7jSCVRZHS/P1yMvC7AYKB7X5VqoUAycPLUIv7x7xpQ+n9ZpymdFIsyZR4GNYSaOJikUgnUvF8MBAaSHJLoZh+k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0461

Add ISP capture_bayer video device in documents. It support output bayer
frames by ISP module.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../admin-guide/media/starfive_camss.rst      |  8 ++++--
 .../media/starfive_camss_graph.dot            | 28 ++++++++++---------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
index 020f1969e67f..ed7fbe08f4a2 100644
--- a/Documentation/admin-guide/media/starfive_camss.rst
+++ b/Documentation/admin-guide/media/starfive_camss.rst
@@ -44,7 +44,7 @@ The Starfive Camera Subsystem hardware consists of::
 - Parallel: The parallel interface,  receiving data from a parallel sensor.

 - ISP: The ISP, processing raw Bayer data from an image sensor and producing
-  YUV frames.
+  YUV frames, and also support output 12bit per pixel Bayer format frames.


 Topology
@@ -58,20 +58,22 @@ The media controller pipeline graph is as follows:
     :alt:   starfive_camss_graph.dot
     :align: center

-The driver has 4 video devices:
+The driver has 5 video devices:

 - output_params: The meta output device, transmitting the parameters to ISP
   module.
 - capture_raw: The capture device, capturing image data directly from a sensor.
 - capture_yuv: The capture device, capturing YUV frame data processed by the
   ISP module.
+- capture_bayer: The capture device, capturing 12bit per pixel Bayer frame data
+  processed by the ISP module.
 - capture_scd: The meta capture device, capturing 3A statistics collection data
   processed by the ISP module.

 The driver has 3 subdevices:

 - stf_isp: is responsible for all the isp operations, outputs YUV frames
-  and 3A statistics collection data.
+  , 3A statistics collection data and Bayer frames.
 - cdns_csi2rx: a CSI-2 bridge supporting up to 4 CSI lanes in input, and 4
   different pixel streams in output.
 - imx219: an image sensor, image data is sent through MIPI CSI-2.
diff --git a/Documentation/admin-guide/media/starfive_camss_graph.dot b/Documentation/admin-guide/media/starfive_camss_graph.dot
index 7961255d3ad6..5255c12c2b15 100644
--- a/Documentation/admin-guide/media/starfive_camss_graph.dot
+++ b/Documentation/admin-guide/media/starfive_camss_graph.dot
@@ -1,16 +1,18 @@
 digraph board {
 	rankdir=TB
-	n00000001 [label="{{<port0> 0 | <port1> 1} | stf_isp\n/dev/v4l-subdev0 | {<port2> 2 | <port3> 3}}", shape=Mrecord, style=filled, fillcolor=green]
-	n00000001:port2 -> n0000000e
-	n00000001:port3 -> n00000012 [style=dashed]
-	n00000006 [label="output_params\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
-	n00000006 -> n00000001:port1 [style=dashed]
-	n0000000a [label="capture_raw\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
-	n0000000e [label="capture_yuv\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
-	n00000012 [label="capture_scd\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
-	n0000001c [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
-	n0000001c:port1 -> n00000001:port0 [style=dashed]
-	n0000001c:port1 -> n0000000a [style=dashed]
-	n00000026 [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
-	n00000026:port0 -> n0000001c:port0 [style=bold]
+	n00000001 [label="{{<port0> 0 | <port1> 1} | stf_isp\n/dev/v4l-subdev0 | {<port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000001:port2 -> n0000000f [style=dashed]
+	n00000001:port4 -> n00000017 [style=dashed]
+	n00000001:port3 -> n00000013 [style=dashed]
+	n00000007 [label="output_params\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
+	n00000007 -> n00000001:port1 [style=dashed]
+	n0000000b [label="capture_raw\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
+	n0000000f [label="capture_yuv\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
+	n00000013 [label="capture_bayer\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
+	n00000017 [label="capture_scd\n/dev/video4", shape=box, style=filled, fillcolor=yellow]
+	n00000023 [label="{{<port0> 0} | cdns_csi2rx.19800000.csi\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000023:port1 -> n00000001:port0 [style=dashed]
+	n00000023:port1 -> n0000000b [style=dashed]
+	n0000002d [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
+	n0000002d:port0 -> n00000023:port0 [style=bold]
 }
--
2.25.1

