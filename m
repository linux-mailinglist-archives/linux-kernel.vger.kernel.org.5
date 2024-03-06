Return-Path: <linux-kernel+bounces-93635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5140687329F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07141287F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2B5DF2E;
	Wed,  6 Mar 2024 09:35:07 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB05C5F8;
	Wed,  6 Mar 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717706; cv=fail; b=uHQxXvGRZ19dMioNK7N3yOqZXpqKwF63xGNKzyVY5CvpDdn20sha4oAsgopZoYFW3GN4U/Fib8foytkZj1xnw6JITk8LdN/EVdDu/2jZBYxTDTFHurHahdYtF9y1LBJS6Ip94bUixxSXUuxoY3WAC5RC9ZcWCFsRqhLDVVYdXFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717706; c=relaxed/simple;
	bh=qEZUXXcGfu5KrdkYtdSJ+/hWTIHGy8fMTs2fV14JElM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDiyA+ZMVREQ2KbTQrD9e/OqmfFdeo9q9d4sWCl6ETLb+L1KJJXsjoQ81tliEGi0rfFcn0YNYSwOung8v25EjVAR2N8idM/IC8D9+pYsFjoErUTGfmvlUfGNxuNJuWSFm2B3Azs9VN496zrmcjeKxoFlpoTjaLI4xG95YaRltz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBgR8HbpDJLsv07xKgx5zAAUAfKM+y3Yug4pMykuJ37ldZ3lYF3XHYmUkijRPNyyG347j4etP0hofp3t9Z9sWtVIQwnsZu0pJkKGLrwGrgCTgVDepFN69J21EnqwAzuGlTjdbUhK62ZUkRhUHVAJYeDtrRGJ4qbPM0wUnGcj6LpQx00l9ljRdAPIUIk/xabsxbOlsaHaH573ijn0BqCzj21DW5Gwt3xtZq3oqDpTNuz5bBq3Aw3qNpmwiF88chz66fAuYAapfbnFAfExfhBIMk9PVnkAVjrkdQMMgFjjSHykCF2BaHQTvujrFr3sSbhwK+YiGcvwJERIhiUXwHkeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okrpVDdxdi53NMy6hb3yIyBF7UdzqI9iZbgrC34zSKA=;
 b=cZS18ikmSrh09Pq2zx7zrR+vcKtPS2KCfA7aGbP6eXx4XhGRBEQ9PpLSuxO0mQbrRzTWus7qH3JbsQxV5gy80WVBvtzF3gbfKxEFKSM0tdimsnVyQIHD3E4C4RifmdlUNRZvJlbnHOEdzQ1EkitjIJPijv0AsD9axVbyrByNW4Kdu0xbKZevK6JuhH38X+jjoK+r2XXHGcswdENi6ojXfc6hrYR4ZKxfCRglLwzzJJqNZ3ayTOOpKn07lHQG2Y+4D3Uj3XOsAa59QaoqWAkKA3G1tn8k3hjQwnGDf7DC8kzu4xRxjc1v082KFI3gG5QSkAs1aH4LibQMvVVTJ1Oi6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:50 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:50 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 7/7] admin-guide: media: Update documents for StarFive Camera Subsystem
Date: Wed,  6 Mar 2024 01:33:34 -0800
Message-Id: <20240306093334.9321-8-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: ee297a9b-6352-4eed-58e8-08dc3dc087ca
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KJj3kc836m7RwZdCXMOUlN8YJrfBhNFUDDF0vcDELyW8b851uSWQOjtB9LkM7hLRjQVScVpNZswIXVk+H+eOvr8bDSB8meDOR0wpCYNhTd0Uac0aE0g8Ppf4OxHwhKoPIVUvKhTnAG0bj18IWIsL/VXiqjqUi8jFqVTq4j+pcRCQ+cKRYBkh8hsqXd6VtOi75ZijouGKgECWFbck2BiRdo3HaMSWldnzFsWh8k/1oMQxiVh6BpNbiIEMzzkxL1V3UWt7bLIUR/gQ2o8oOBbGK0llVYBMQYys4Ys9peE53G2sZ6GhBxsitTFC2XuFDhtCvH2aWNkGheydMM2BUnxzQMpd6YUMItzkSXCqFQfNSfuwCthRdDEXjAzlZSyanl4Assvg5xHpztoirlX5BWbJo2DYafNsict1LwGVch1I1pLMMXRZ58AkJU3MsAVHNoraCPW8MbxGk6ALqlFHyA/WMlJ4zmbcDkljEJAoFWJy044jYpCD+y6invOlvj9MgdVk9FRdAQ6Jr4K3NegCVPRr2/xcJMQb0l2chSBZpk/057Sf2dKMsdPsBL7zRiW8OJD/ghHfOzK13mcyO4NmtCNdeCcw23kxjlOe9TyzwgEbEqq7zRojAIbVtvdZrfmJtSZ0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ljocOJK+M6zvMBBxlp1vFXgzMPSzYRHEh6KsR7zg8JWnr80HNHib154/belt?=
 =?us-ascii?Q?Yg058elEy/tJ54DI/ci2IrMSKtRj8foqEOJlQjr4l66z+FG5x8NwqK20j1tn?=
 =?us-ascii?Q?Mny665fcne/bx3G/GEbgoizHNHc6qMLwdFVaWG1sEndam8/VMl18KSCMZkRg?=
 =?us-ascii?Q?7HXZ1gHnO2wbRm7FTMvcGaG89nMeZaX1xC3BRcLj2w5IyI7zfFp9xh4t7ya/?=
 =?us-ascii?Q?kX0DDIUqW3UquSaMznG5a8q0ZareQGvfdB7PR+Qx83kRuNc9Zfm3CyDCk0hW?=
 =?us-ascii?Q?/UqyANpWTQW+C8r7A5MTp8C8kbpOOGsiEZ8eJypS+tQlPerzzZ7T2sKRH37D?=
 =?us-ascii?Q?o6s6HRkN5E06AN8Fsp3rrbylw22gERzoAoU0xDeLMKnkkrxcrXNojlTqrMfn?=
 =?us-ascii?Q?y9fQ0njFnDWCPn8fTqWEoT68iQ2IGPDdnxaW5ipDVckUfKs+qqTEqKM3qzgD?=
 =?us-ascii?Q?L9fSljbhVUAN1xytcrRakSRitqsqtzU/2K0W5ZhegkV53ld4jhFVDvdwCrfE?=
 =?us-ascii?Q?OmwVPEZUUDCz1Cvld7bqDA+cK14nbsnnzPkCqE3ndLhsus1lWsOiZUJ3LA/l?=
 =?us-ascii?Q?lw+gZzSf0lK7LnrpILASc/onUjyYaLvB71RH6miuikL5NMpsAxj4pi101Ncy?=
 =?us-ascii?Q?khkrSUKDgYfoSUxDNBq0E4ZXcGfPP+qYS4YMByL+kuM997trSY35cL26hLGO?=
 =?us-ascii?Q?TpAZUEVbqJOhQdcnS5XmTWahy+7jqtvDL2HgLeEMWGHxJtkKc7kQwSo3HtH7?=
 =?us-ascii?Q?0w1p5H78Ct04HZbX5n4eUGWAxhpe516A7neD81eoFS9iu8g4VTShdPMijTBB?=
 =?us-ascii?Q?tRMe4B98VD0bJvVqYMt/vqPpn7Q0q9r6QBaaNpl57akpXNrMock/8i7BeSrk?=
 =?us-ascii?Q?KVS1H95yrCx14bogqhEVOlaWi4qe66rubcC8K16OhiKC7HRQ/1S8S38v1C3z?=
 =?us-ascii?Q?VIfk8FqXqIp0KR+M2jKcg3xrzVidQrbAFoEsHc30SCn2ks1sTsgomrxxHDor?=
 =?us-ascii?Q?vmpk37cAOKAq7gfrWGCgjw6B3EKadbEDcgbsFeBRWpUiZ5EKkRaCo8nwRzq0?=
 =?us-ascii?Q?0UosS/bJyVioK20vQD0wv169BhQ+sMrgyPG89QWxK5mxUmqQFACRwrV8fecf?=
 =?us-ascii?Q?CQhqaWOYDRt6lMYQRXdkwEb1w49wS9RQ/Ky11LTrUOjScgcUHDsWHl8ajc2g?=
 =?us-ascii?Q?kudnNeq/bauRZX05kneHdz1TLfEqnBpKSfbQOMzkXwwju3uJWZBgYO6OG85c?=
 =?us-ascii?Q?PjKdAgBinjo1X278Jchp1Ernq+6otkb5tNwx4odgJKt8aU6fIU7lKEKKcQIK?=
 =?us-ascii?Q?QXYtl3NRLg8dcKgMkV71abOojMrD6Ym1uOWq3tuMN2O1zTE96NVQPN2LVm01?=
 =?us-ascii?Q?2WWEKeFWzWmp4t1+KaKAjeEe4bceuSSqMDLSLkrtrMbsDVVYIwqdwNEnAnh8?=
 =?us-ascii?Q?KJhpwh8GMDgZDUtVaFJQROKYELh/R+xSkBtWOLq+jhZo/Mo34xueIvsuQf4p?=
 =?us-ascii?Q?mnkoCBUzV+KLmPYWxRBilM5E/rIk8+OLAmNj3yh+X3tlEYkGMQiVlf2c+0Ws?=
 =?us-ascii?Q?fHSN3siYSRTAAtaYZ8smpAy5LC3CO1kSIopDdp89iIO2jF4zlRJZdDRVRAdL?=
 =?us-ascii?Q?DBvJTozYOWtqlIrdazAuzv0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee297a9b-6352-4eed-58e8-08dc3dc087ca
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:50.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmNhJC/IsSgRTlmYDwxbliYjHqasddawBeu4Q+AYmI3sClbkVXkN08DQG3XWAhNaZdjl0ViQHWj8FfXP/Zr1T2a7Sf4SLQdlouEczDH65g5URyop5pf0xxwJNHr2cMpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

Add ISP capture_raw video device in documents. It support output raw
frames by ISP module.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../admin-guide/media/starfive_camss.rst      | 11 ++++++----
 .../media/starfive_camss_graph.dot            | 20 ++++++++++---------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
index c224e6123042..b8d1ce878847 100644
--- a/Documentation/admin-guide/media/starfive_camss.rst
+++ b/Documentation/admin-guide/media/starfive_camss.rst
@@ -44,7 +44,7 @@ The Starfive Camera Subsystem hardware consists of::
 - Parallel: The parallel interface,  receiving data from a parallel sensor.
 
 - ISP: The ISP, processing raw Bayer data from an image sensor and producing
-  YUV frames.
+  YUV frames, and also support output RAW frames.
 
 
 Topology
@@ -58,15 +58,18 @@ The media controller pipeline graph is as follows:
     :alt:   starfive_camss_graph.dot
     :align: center
 
-The driver has 2 video devices:
+The driver has 3 video devices:
 
 - capture_dump: The capture device, capturing image data directly from a sensor.
 - capture_yuv: The capture device, capturing YUV frame data processed by the
-  ISP module
+  ISP module.
+- capture_raw: The capture device, capturing RAW frame data processed by the
+  ISP module.
 
 The driver has 3 subdevices:
 
-- stf_isp: is responsible for all the isp operations, outputs YUV frames.
+- stf_isp: is responsible for all the isp operations, outputs YUV frames and
+  RAW frames.
 - cdns_csi2rx: a CSI-2 bridge supporting up to 4 CSI lanes in input, and 4
   different pixel streams in output.
 - imx219: an image sensor, image data is sent through MIPI CSI-2.
diff --git a/Documentation/admin-guide/media/starfive_camss_graph.dot b/Documentation/admin-guide/media/starfive_camss_graph.dot
index 5e8731e27701..dab3e3ccbe9a 100644
--- a/Documentation/admin-guide/media/starfive_camss_graph.dot
+++ b/Documentation/admin-guide/media/starfive_camss_graph.dot
@@ -1,12 +1,14 @@
 digraph board {
 	rankdir=TB
-	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
-	n00000001:port1 -> n00000008 [style=dashed]
-	n00000004 [label="capture_dump\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
-	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
-	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
-	n0000000e:port1 -> n00000001:port0 [style=dashed]
-	n0000000e:port1 -> n00000004 [style=dashed]
-	n00000018 [label="{{} | imx219 6-0010\n/dev/v4l-subdev1 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
-	n00000018:port0 -> n0000000e:port0 [style=bold]
+	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1 | <port2> 2}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000001:port1 -> n00000009 [style=dashed]
+	n00000001:port2 -> n0000000d [style=dashed]
+	n00000005 [label="capture_dump\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
+	n00000009 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
+	n0000000d [label="capture_raw\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
+	n00000015 [label="{{<port0> 0} | cdns_csi2rx.19800000.csi\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
+	n00000015:port1 -> n00000001:port0 [style=dashed]
+	n00000015:port1 -> n00000005 [style=dashed]
+	n0000001f [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
+	n0000001f:port0 -> n00000015:port0 [style=bold]
 }
-- 
2.25.1


