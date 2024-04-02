Return-Path: <linux-kernel+bounces-127869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CE8951EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20231F23818
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9769D31;
	Tue,  2 Apr 2024 11:34:27 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2099.outbound.protection.partner.outlook.cn [139.219.17.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4536996E;
	Tue,  2 Apr 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057666; cv=fail; b=U3rqN8+310x+lC1g0riHZNlPfhYbaHG1WzJdAU6NaN2B+5EBGC5vjS0A8LrsNusVqNx4vwoVcFng1BsnuY9Pt8+eiyZcg6r8CvGoEtd0sQMN2qnbgODFYGsQe7Odp6l02HztennMLFSPuWkJB8aIpjYOOhTBPqoZBdMnP05tpzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057666; c=relaxed/simple;
	bh=ZqS10ZAMwMKng4bCcyIYliSH0HU2nzc9NUI+fmHqPks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAoFBt1AzQVfk6UIQ0DE3hOndAwMprk/Tykk2Dje1ajsuSkkbMZBr0n4CK2XN62fhrFsNa3uuu6qz1sEYIsAYFZibMUqZzbNWiyPhCGEagnB3ke55IavUeYwj5jDKaKtd5MywMoD1vawl2/NTxODeNjwWXMGBPhDzYu2LA4u4w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daYlQVy0dvMGPWZ7c8gBbo/98HrnklsMOMLfAQR06P9O+LKwIetX5rTzLBMl+LxlOGagDNSA2cxOvs89EMyu7ujtYm9lYj3gPZci3o+XAmZLB9X7MK8GAWot5q4nWW1g+Uw/KiznEPy+FqeFbe7QpN1eZptTtaNU0axhjCDRxZw9wkkzvFuC9PQp7htHvH+i46GA6r4un0plgrugE49CnyFMwvoAeMU735UY08bMKo73r9/7I6cLz2M+T4tj4U0Iusd6zz+af8QgZa0y5i24R2jU8nUzLIJzRkkhqg/t75kdoUOTtB8y2jU61kv2MMFtpAfmziYALIfk9DM2hKVu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpYS+v+cBn1HqDAmhXTHJL+v2aLemV00fes8PvGvKzM=;
 b=YD8DStXGF3TibSz/ydKCXpnkOFbP1pKPYh7az9HwpM6gTSgvPXo8cgVsEad77RhqqkLygWwkuyT8ojApFDafym4tz7gTAE5IHqo993co+qHsuUmHRLPYq/jjBhDV4ROWvkqTfM+mjS6fH33apSjKp3nNjLCnANxcORWPhi8SBmjU8GULmoELw661ljKtYl00pnkwq7NBLIOjmxqLNRKgAxdWx6tBIbSnY9BqUO09xlsoc6ZNI4IlkaHaImHV9ugkSn80+iPf3035Ko45PI528gHF330KlvC0uFqXcKvJBkevawzX42aO2zIcTRAhe7/QtUHgXNwInsUDWya1+pHITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:00:38 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:37 +0000
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
Subject: [PATCH v4 10/13] staging: media: starfive: Add V4L2_CAP_IO_MC capability
Date: Tue,  2 Apr 2024 03:00:08 -0700
Message-Id: <20240402100011.13480-11-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 19475ed6-e837-4fe2-7130-08dc52fbbf37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jC2asqYZDPvM7257TdOE38s6girr4yTXNr+Z1FQdqcOSxSl4+vD2PdQ+UXut/nc/h7Yj73Ch0Bt2BBO10t3/UjiUhtC8nhcG5EfLPlC1Zv1eWPHq7Vn6wWID/vpdaVxFXsa7g31rJScXftHEGBV8a910XuGm80v5Ocm7xv/fnCjveuJExxQ8n/kJcf4D8LsNpoDH+1dLDjXI3LUDX8OYXszoaOn0tVom3pfB0oeepnWUtluA9Xkb2BmK31ubLDs13PTM6t9Ypx40ddCWiRSfENkbbI6RSavz6ayit0gUDozwLNqg0Vcg3k1tuU4WeeJOil08//PfTGf6eL7JdPx7gMeQyDERimxI7IbKW/GpOda9roNyNRo+d/WcFfjZay3WSy0XefRhzGW0NLA23pzCuSFNSvg87pXMQ7oyRZx/wSQImf/79NunB1LET44TmbnKSCqo+q7XpGV8dnzlht9R2vXSVX+YKAPp0dbHcyrJNPSRN6M88vm/JBN6P0cphNzWrohEBBigK2mFZYrfAVA57HiSVFL3RKfjnJKbY05erDAITHFd9qbof0J8TDj/ia+CJLwwjVr3dQ1prQAsafeWW86h6wWJPIEDj7LFJq4BpHNyhF7TvYhHCBdXVty8MBLhdMjyriLv/r3Cj7CueTOYZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TtLTMtOAhQ3yKSjXXB2ZSmv4xrSpfNMoekM7kO6NoPEJSJd10koWCiED79Jv?=
 =?us-ascii?Q?l93V+sqYxpaMLZdT/ZttzXbXYKd6xhq0Ji5nD7TWfhPPGYFY9whSCLhKZ90U?=
 =?us-ascii?Q?TVuD5yfvp4s5GupgIM5lhHK4/nUgL2rNGNAQpCt6dYgxNYiZuWLidSRGq4cW?=
 =?us-ascii?Q?5mfgllO2tvQPSEbCUHrmRZ+bBaWwJcDKNq2ycGmiJPQp4hu5GyGxy5dZqLR8?=
 =?us-ascii?Q?y4Ooz3Xe3pCoPrx04zh577GavvMZUf5t9ZWEhGk2mmXUoJAi68BoiDlsh01T?=
 =?us-ascii?Q?JrS+V/0QkIwLdxJy1sb2UzxYxmV8m96lNnjSSlOnLrp7Y9EhsClXRPqX7Vtr?=
 =?us-ascii?Q?5zuCP2a2L6F88CG/ocaT3GRq0/pbVAvipKuSUXJuYlyDXcgeGvZkB9s/DNVR?=
 =?us-ascii?Q?KYeCeVJbPV7T28PVHk/gTtBeUHCHwL9kpneJkBOVLzfzVivulzSKpSgUvWCE?=
 =?us-ascii?Q?xN74pP1doDjKr2FVsd0DmgklpbDaofjTMmUdI4NURzpWNub5om4UHbGrXjFv?=
 =?us-ascii?Q?fW+cFi5CC3Bxj7LIIAIOvzeOU/OmPPSYFCnp15PM3t8QajD8G68HuBP77fcQ?=
 =?us-ascii?Q?D5bAAiWaQQ5RD4dXd05n2ZepaBmquIlST8bprN2d5d5HMqmO5q0XkUnCrqe/?=
 =?us-ascii?Q?MMtHvqvyUS7YQES9dNLJsIjRDGBgA408pyUF8LveFEt8wWSvDysnZIUU49HP?=
 =?us-ascii?Q?xobv11o9oNV3po81Ew5HkOtfmEp/mPECxF81OMB8WeynnwkZ0j+bAmmJXZZp?=
 =?us-ascii?Q?HmAxr5F/z5rwfTPg6O5hyM8LUzS07xNs1RLm/qdNS1ULSsds+HcIxqtcE4lW?=
 =?us-ascii?Q?7gd3XBngvO+sS77fYSJz/ARKzJeA30z9OXqODcNjI1P1Vk+cjPHssrDWUHNn?=
 =?us-ascii?Q?moBeREnUndTjtvNKqRydAXKsItQpv0UvHLLi3/RXf1FhTcYxi63NJ3UGOfdT?=
 =?us-ascii?Q?Clt2ncZPUK05xhwI3A9i3q4XWx1YREsbUr8hI24awK+RWBQcybtKdPS6xmQa?=
 =?us-ascii?Q?D12W7bz1/i91bu8XKH66ELBQG0O1kpjCIjxHQ92FCb3MDq1TA8NrSRBlDIVO?=
 =?us-ascii?Q?jKjIOyY20KiWB33+gjnPdKXVmBkJr4nXYl0/e4egZkBCnMrBSEsIvGn0QLA0?=
 =?us-ascii?Q?5EpF/IEaPAd0Rf1GehffvgGCdrYys5VbUYwXdaNAM9OcOrznS2aMXd4AlpGB?=
 =?us-ascii?Q?Hjde0bBGAbg0YDRpDQa0+PfshlB7abcZNV0DbS2Yw3E7LbDaCflNB35tlcU+?=
 =?us-ascii?Q?Af56rOB9HXebprZVl6Nz3tplVAIAsdBT1XMJ4W+NZb36cQOsadXX6oVyJnAM?=
 =?us-ascii?Q?J1CDCclhS7oZGkMIWObTZV0DOgrj2VbbItVx3XirP9OMoX9QMONtgfglEbrQ?=
 =?us-ascii?Q?02/6/1bloUTipuuxAqIiLeb4Y133HKpiAsNSV5afsAvzMI+TWBBKmO/mRQNp?=
 =?us-ascii?Q?YfTrHVptIHiE5QW9Gi2IeFG0DbSuqYefWipJsKqr3C3QoJ/aq3Ex1w6QvJvz?=
 =?us-ascii?Q?iW1bcI20XJn+ETGeojZeyOkdF460V5zCbuvVMpSI3mYWR0hxqKR2khrrc5YD?=
 =?us-ascii?Q?yT2rXFZMsnnYND3mknKMo6ke+FOvNBJjaZzcOnZSxBwUV09S5ds7v9lC2uEy?=
 =?us-ascii?Q?xt7JCIa9yo3BwXgZ+7lJZT0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19475ed6-e837-4fe2-7130-08dc52fbbf37
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:37.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4h5e6lKJaPFZk5uVM0u8Ch3dT2aehoqFcS641D6ZiqVo+Hncu7rP5CniAWpfHe85Kbw8WF2Bpu7W1dgmC6izRIhT3M49s6UabvY95FpADQWTXFU/jR/JmpyYHtEKa71
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

Add V4L2_CAP_IO_MC capabality for video device. User space can enumerate
formats by mbus code.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index d9e51d4e2004..4ca889a7b757 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -665,7 +665,7 @@ int stf_video_register(struct stfcamss_video *video,
 	}
 
 	vdev->fops = &stf_vid_fops;
-	vdev->device_caps |= V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_IO_MC;
 	vdev->entity.ops = &stf_media_ops;
 	vdev->vfl_dir = VFL_DIR_RX;
 	vdev->release = stf_video_release;
-- 
2.25.1


