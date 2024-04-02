Return-Path: <linux-kernel+bounces-127685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC840894F70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7403C284AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18B62171;
	Tue,  2 Apr 2024 10:00:48 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A665EE97;
	Tue,  2 Apr 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052047; cv=fail; b=cq2K7pDk1XfjakWfVJ9vjRvwKY2FciwtQTyhQj3nq1lvap8XSJISbsENs+MpSeAqRfDpNnnNJODXP7k/DhpQRyqsfRurBIJwkinTz2IlyfJSUcfye/W5YNlliKDi/l+fZwmxtP8p6Fazy69VL89z1dp/1gyLRmqQ77nbEbXefms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052047; c=relaxed/simple;
	bh=thuUBZn6WEQ7V9/XqRBOxoUV9tG2qm++7+sBUJNoNc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RgUG3lGHEiDn9Tj+3ixTwIKHE8yjxnjGc0MNJle1VB/ZUSIM/icciDVH4M+7PW2FzSSayiC0j7qfBpGub/SCG3qGKckjFgG0woPbRFwDPDihDObhXbE1eT3BziEDfYY4s8C79lm7j5tulZqMVt7jRn9Ci1pdjq2mBGnMcbiQIq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beG92suycSO4ZupaFZFqWoFcuFJ/O+pq747aBzqXK4aXBFaLpVN/PEUseuhDIP7IEwxAQZVIGFNaYVvUTbF5v6paO7hijH9+WDQEQt5rG+Z4FKm/ns7XX0vAlOi9IxeQ51Z+cNslJ1pIwojSMTmRbQ6KUjglB3FBjaOcQApCAeQz6nQBZokBGeqD0p5EAmWvTdd8FC3yvQH5FYMM6W2rwvmJiRj+VXTzHT0bWsCsZQHVEI2AK4g1wmhcNhvsgdFHttD+onrEqR0Nwvx2GuEg+NxdcEwCYeWMv8X0QRcoEHdzJixC6/vhKyRDABPwsbbYHXY/Q1ht7xHRO70qyZ8RmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqgLyFITePX6RyQniAWmO+v05oRBpAbNPKhuvXfdp/8=;
 b=XQ2cltQc09rosjFxu7yOZ4sko7jYMvdLSOs/ylRbbWMFLxf70pmgyKBkaI3M3FB6j9Cd+B2IWfmXwl0sxzI+2Peoh67qW9viOSqvyURMjFQmifu89SyL3cwWVqArtoMB621mkwh91J/WtXZuc7fQ7rw0CXajQNB6F1iW4hl23EeTpsYk8isVnD/Gt5O5RMNtPc/1a5VZ00JcBIVDTAfQW/R5D9ydlEygzv11mxTv51HG2EPYDjaBVkdiSRBlHlJKOeafYpL5ODUDZYRYExp5zuBS8ZUpKZJ0SSbGGQ0fgojZ82PANC6gJePOTz34Eo4yegUbOBazDH5mw3M3tJcbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0862.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:00:34 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:34 +0000
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
Subject: [PATCH v4 08/13] staging: media: starfive: Add for StarFive ISP 3A SC
Date: Tue,  2 Apr 2024 03:00:06 -0700
Message-Id: <20240402100011.13480-9-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0862:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f68321-6e10-4481-9970-08dc52fbbd24
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pTirFKNmTD/+vWZkDrdYaJWgez2Ly57J9YkWiq0CZCFGH5tuRKD5hDnbykVgBDBn7aDeGPq0nGPr5BgjHnBRH1sI6c9XQ3EqJOaFgLTJyXKQUT0UrauF88oJkQIG927ZBtwMcUltSmhJ6t+gORpEWe5XZ2edJzNIwBep6mIcdZmPgVSkyBmid39IadVv4p87/6aQbjbz3rQB38b85b46fFFpSqIYe3mawvIHwtZ02DV8KV1aQQKu9gaxEkj/PmYfJLy7E9PTLnQFT1N2kVwzSSrH9wmc30xnvSDVxC403VMZCKToBn8TP7w7rqkpFBpL2eaNSYHV97eWXC/k9do+78u+Huvleaa4grzysYAmYW4N7Plw2hGUC2Luw9i5dOOFYARuU/oyWVBBFSH+UdCEZ2/rW6ZKzgu9ZfIdnfiyA4Mllw4zlFxgn/E4sBSgV5vCa+waUZvQZA9vdhPLeodOHEBq/eIPjGbNmtSXF2XDqxFjJq8oQfv2b+cQW/WLSzdxQxIQLI50JzJGDOo5FG2vU/3eomKs0BI3p0J3IiPSf5iem6Upe/7rsvmOHYnPwXKnf/yd+tVOaVl8mTSnllgnbZkiG2VLR+2wQ4Zp1dB6tlsh+LNx5YYYe6T+M5omQymVL5BLt9Y96KmoW8q+Ywx0TA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHhi1M6VP9lHcu+1bdwebuB+TdSyNASoNF+jVDXQAEpEskF6D7Z6Sx2tvELX?=
 =?us-ascii?Q?stmfFXXfGzOYuxibs/xYy3AP+2ulTbXA7rNgKWItPqq/+LinEJuWc+CmY8wn?=
 =?us-ascii?Q?vQoXAKnMxQYOyyuBmWLZacDi/LvDkDlIE1UBIPd9wQDdRpPMIL561WU8nrrR?=
 =?us-ascii?Q?l+d5LgIg3wYScoiWkG5rSIfXJ3EvRQviI0gt0udZFSS46xMNAGU4Hi90rv8K?=
 =?us-ascii?Q?lPjHo+t+AyoqZJrlrEGMoYXJG5BYrg13T565grFMEpBSql+wpIits2cl9CrI?=
 =?us-ascii?Q?dMRqPhTYlk6qlpdBIyFxDVFclHCMCaBcrjh8s4RKTcFhC1OniGY1iw2SYvx5?=
 =?us-ascii?Q?kjLp+R5xB2k1S6ZtIyQHwQkeoMzxHwW1ml2AE5S3OZUpjmdKvrCWnJw68Rdz?=
 =?us-ascii?Q?eHQRI4CGFxigBBsBiaeoq5wHR5FVtLVk6IuL9KNhBz1KSBwgtsIXD/Jx9LXw?=
 =?us-ascii?Q?jQLM65EIOxOLkiHGCkLEco7b2oomVTY7Mg0ievqPT29WltSfGwCOID+hVlCc?=
 =?us-ascii?Q?kfhOnf589+nVdYyThf0E5MCNFbFsJ7zfeKqe0qVHmVVeTEcpyMVeW3QLdCkV?=
 =?us-ascii?Q?ztS8BIKulz/fWX33+Mali4dqqEu6+CpYJBhEY91XpO2z1qdT6EsCPmG+8AEz?=
 =?us-ascii?Q?le7JvSSCfjxYC8jQEaP33mWhQ5KytbJPYrZH1UnmLflZ0tkjh2EDARVcV4Rc?=
 =?us-ascii?Q?vj/Zy71ROouy5Tb24RYnbBTYSYoVzFb1rRhF7nWREF0c1ZuqwLf1W8XSCP8V?=
 =?us-ascii?Q?bUYK2OmVQdzur4fkcYZuGmv3ESdzcoELAeS1B5KNqpwFDhx8XhbPa7l9kXCt?=
 =?us-ascii?Q?pJGffTmfD1N6XYbz7M4MihHaW1hHiyTWKnPc27+s9jO8kdmZD4AHO6jNh4ir?=
 =?us-ascii?Q?mc7QqQtBZ/s74rOkjsxcOfaFCdpZm+6+9F3J2orlj+4/ce/l15x6JuszD6Fx?=
 =?us-ascii?Q?jdISWJwEbIRUm0shD1f4c4wp4EnzRadD6Asu5S9CTscPn0L7SMZSGeNmj1wd?=
 =?us-ascii?Q?QQuOk3C7HmIod9F3FMkOY5VYk/d9yvEMcTi4BA8XFwjHSuXIo/pWzanVc0bq?=
 =?us-ascii?Q?Y9w74B/i33XS4RXl3X+nrCXmeWOghfV3UbTZlbjib0d6RVny4mzDv6EvW6DR?=
 =?us-ascii?Q?Y629usvlsXL9MW9L5+kjqsX72QvNDpcFtCyTfxAIkvjJifz/DnuBbWjVZ0No?=
 =?us-ascii?Q?xbBQBRDDLCfbHUKCuO6pf/nteqNMxkNr26Z/UNkct1TWonxbM6wzM5WR7nFk?=
 =?us-ascii?Q?CM245NmaPbZSvLsu801s6wLXhaoRN+HrzBOt/LhIoH5k8dTJbVpNvRFl2Mj6?=
 =?us-ascii?Q?FgxFCD9OhZXmI2vbYx3poT5TbbMLMysBQG1SMN+5oHmo9xJ2AR2v1JnyG/lZ?=
 =?us-ascii?Q?8dlJxhoeu2zIXYy3iz66TQ16h+HLDdkZ+nbNKxMbbKYbDeZqFOG5DtXcNwaL?=
 =?us-ascii?Q?D0rM4X120rwpSdE09exBiJuwLoImDXMDJ7h7pWsd0WJCewDA1bLNLZ/ONjY5?=
 =?us-ascii?Q?Jo5jGuwVQQyr1DdSRRYV4nBF/hd63Ptu3kULpSWjhMFcErNi7ySCFUj3sZog?=
 =?us-ascii?Q?iDeuBSS4qSSVnqTMJSWpnG09mkLbSo7l6fqQRPsFV4FsOst17V5hqaHsZfVq?=
 =?us-ascii?Q?aj7m+hNRVundaHMSn16XoY8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f68321-6e10-4481-9970-08dc52fbbd24
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:34.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES/5aO8rtR2va8FFbcSeVbsnzNeXVUxAqf3uUdzrIG0orJE89C+1HyTwS2M4JoSKVLt6QiHEXE3j+YvraUUkUo6kmS4iyNTYRt6b3/OPJVcGyH7TMzY3KptZ1VgCRhsG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0862

Register ISP 3A "capture_scd" video device to receive statistics
collection data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-buffer.h |   1 +
 .../staging/media/starfive/camss/stf-camss.c  |  13 ++
 .../media/starfive/camss/stf-capture.c        |  21 ++-
 .../media/starfive/camss/stf-isp-hw-ops.c     |  66 ++++++++
 .../staging/media/starfive/camss/stf-isp.h    |  23 +++
 .../staging/media/starfive/camss/stf-video.c  | 143 +++++++++++++++++-
 .../staging/media/starfive/camss/stf-video.h  |   1 +
 7 files changed, 259 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-buffer.h b/drivers/staging/media/starfive/camss/stf-buffer.h
index 9d1670fb05ed..727d00617448 100644
--- a/drivers/staging/media/starfive/camss/stf-buffer.h
+++ b/drivers/staging/media/starfive/camss/stf-buffer.h
@@ -23,6 +23,7 @@ enum stf_v_state {
 struct stfcamss_buffer {
 	struct vb2_v4l2_buffer vb;
 	dma_addr_t addr[2];
+	void *vaddr;
 	struct list_head queue;
 };
 
diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index 323aa70fdeaf..3fe4e3332719 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -126,6 +126,7 @@ static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
 static int stfcamss_register_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 	int ret;
 
@@ -150,8 +151,18 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 	cap_yuv->video.source_subdev = &isp_dev->subdev;
 
+	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC_SCD,
+				    &cap_scd->video.vdev.entity, 0, 0);
+	if (ret)
+		goto err_rm_links0;
+
+	cap_scd->video.source_subdev = &isp_dev->subdev;
+
 	return ret;
 
+err_rm_links0:
+	media_entity_remove_links(&isp_dev->subdev.entity);
+	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 err_cap_unregister:
 	stf_capture_unregister(stfcamss);
 err_isp_unregister:
@@ -163,10 +174,12 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 
 	media_entity_remove_links(&isp_dev->subdev.entity);
 	media_entity_remove_links(&cap_yuv->video.vdev.entity);
+	media_entity_remove_links(&cap_scd->video.vdev.entity);
 
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 75f6ef405e61..328b8c6e351d 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -12,6 +12,7 @@
 static const char * const stf_cap_names[] = {
 	"capture_raw",
 	"capture_yuv",
+	"capture_scd",
 };
 
 static const struct stfcamss_format_info stf_wr_fmts[] = {
@@ -55,6 +56,14 @@ static const struct stfcamss_format_info stf_isp_fmts[] = {
 	},
 };
 
+/* 3A Statistics Collection Data */
+static const struct stfcamss_format_info stf_isp_scd_fmts[] = {
+	{
+		.code = MEDIA_BUS_FMT_METADATA_FIXED,
+		.pixelformat = V4L2_META_FMT_STF_ISP_STAT_3A,
+	},
+};
+
 static inline struct stf_capture *to_stf_capture(struct stfcamss_video *video)
 {
 	return container_of(video, struct stf_capture, video);
@@ -84,6 +93,8 @@ static void stf_init_addrs(struct stfcamss_video *video)
 		stf_set_raw_addr(video->stfcamss, addr0);
 	else if (cap->type == STF_CAPTURE_YUV)
 		stf_set_yuv_addr(video->stfcamss, addr0, addr1);
+	else
+		stf_set_scd_addr(video->stfcamss, addr0, addr1, TYPE_AWB);
 }
 
 static void stf_cap_s_cfg(struct stfcamss_video *video)
@@ -227,18 +238,24 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
 	INIT_LIST_HEAD(&cap->buffers.ready_bufs);
 	spin_lock_init(&cap->buffers.lock);
 
-	cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	cap->video.stfcamss = stfcamss;
 	cap->video.bpl_alignment = 16 * 8;
 
 	if (cap->type == STF_CAPTURE_RAW) {
+		cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		cap->video.formats = stf_wr_fmts;
 		cap->video.nformats = ARRAY_SIZE(stf_wr_fmts);
 		cap->video.bpl_alignment = 8;
 	} else if (cap->type == STF_CAPTURE_YUV) {
+		cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		cap->video.formats = stf_isp_fmts;
 		cap->video.nformats = ARRAY_SIZE(stf_isp_fmts);
 		cap->video.bpl_alignment = 1;
+	} else {
+		cap->video.type = V4L2_BUF_TYPE_META_CAPTURE;
+		cap->video.formats = stf_isp_scd_fmts;
+		cap->video.nformats = ARRAY_SIZE(stf_isp_scd_fmts);
+		cap->video.bpl_alignment = 16 * 8;
 	}
 }
 
@@ -362,9 +379,11 @@ void stf_capture_unregister(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 
 	stf_capture_unregister_one(cap_raw);
 	stf_capture_unregister_one(cap_yuv);
+	stf_capture_unregister_one(cap_scd);
 }
 
 int stf_capture_register(struct stfcamss *stfcamss,
diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index 6b3966ca18bf..abdfa4417145 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -451,11 +451,57 @@ void stf_set_yuv_addr(struct stfcamss *stfcamss,
 	stf_isp_reg_write(stfcamss, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
 }
 
+static enum stf_isp_type_scd stf_isp_get_scd_type(struct stfcamss *stfcamss)
+{
+	int val;
+
+	val = stf_isp_reg_read(stfcamss, ISP_REG_SC_CFG_1);
+	return (enum stf_isp_type_scd)(val & ISP_SC_SEL_MASK) >> 30;
+}
+
+void stf_set_scd_addr(struct stfcamss *stfcamss,
+		      dma_addr_t yhist_addr, dma_addr_t scd_addr,
+		      enum stf_isp_type_scd type_scd)
+{
+	stf_isp_reg_set_bit(stfcamss, ISP_REG_SC_CFG_1, ISP_SC_SEL_MASK,
+			    SEL_TYPE(type_scd));
+	stf_isp_reg_write(stfcamss, ISP_REG_SCD_CFG_0, scd_addr);
+	stf_isp_reg_write(stfcamss, ISP_REG_YHIST_CFG_4, yhist_addr);
+}
+
+static void stf_isp_fill_yhist(struct stfcamss *stfcamss, void *vaddr)
+{
+	struct jh7110_isp_sc_buffer *sc = (struct jh7110_isp_sc_buffer *)vaddr;
+	u32 reg_addr = ISP_REG_YHIST_ACC_0;
+	u32 i;
+
+	for (i = 0; i < 64; i++, reg_addr += 4)
+		sc->y_histogram[i] = stf_isp_reg_read(stfcamss, reg_addr);
+}
+
+static void stf_isp_fill_flag(struct stfcamss *stfcamss, void *vaddr,
+			      enum stf_isp_type_scd *type_scd)
+{
+	struct jh7110_isp_sc_buffer *sc = (struct jh7110_isp_sc_buffer *)vaddr;
+
+	*type_scd = stf_isp_get_scd_type(stfcamss);
+	if (*type_scd == TYPE_AWB) {
+		sc->flag = JH7110_ISP_SC_FALG_AWB;
+		*type_scd = TYPE_OECF;
+	} else {
+		sc->flag = JH7110_ISP_SC_FALG_AE_AF;
+		*type_scd = TYPE_AWB;
+	}
+}
+
 irqreturn_t stf_line_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stfcamss_buffer *change_buf;
+	enum stf_isp_type_scd type_scd;
+	u32 value;
 	u32 status;
 
 	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
@@ -467,6 +513,17 @@ irqreturn_t stf_line_irq_handler(int irq, void *priv)
 					stf_set_yuv_addr(stfcamss, change_buf->addr[0],
 							 change_buf->addr[1]);
 			}
+
+			value = stf_isp_reg_read(stfcamss, ISP_REG_CSI_MODULE_CFG);
+			if (value & CSI_SC_EN) {
+				change_buf = stf_change_buffer(&cap_scd->buffers);
+				if (change_buf) {
+					stf_isp_fill_flag(stfcamss, change_buf->vaddr,
+							  &type_scd);
+					stf_set_scd_addr(stfcamss, change_buf->addr[0],
+							 change_buf->addr[1], type_scd);
+				}
+			}
 		}
 
 		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
@@ -485,6 +542,7 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stfcamss_buffer *ready_buf;
 	u32 status;
 
@@ -496,6 +554,14 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 		}
 
+		if (status & ISPC_SC) {
+			ready_buf = stf_buf_done(&cap_scd->buffers);
+			if (ready_buf) {
+				stf_isp_fill_yhist(stfcamss, ready_buf->vaddr);
+				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+			}
+		}
+
 		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
 				  (status & ~ISPC_INT_ALL_MASK) |
 				  ISPC_ISP | ISPC_CSI | ISPC_SC);
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index fcda0502e3b0..0af7b367e57a 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -10,6 +10,7 @@
 #ifndef STF_ISP_H
 #define STF_ISP_H
 
+#include <linux/jh7110-isp.h>
 #include <media/v4l2-subdev.h>
 
 #include "stf-video.h"
@@ -107,6 +108,12 @@
 #define Y_COOR(y)				((y) << 16)
 #define X_COOR(x)				((x) << 0)
 
+#define ISP_REG_SCD_CFG_0			0x098
+
+#define ISP_REG_SC_CFG_1			0x0bc
+#define ISP_SC_SEL_MASK				GENMASK(31, 30)
+#define SEL_TYPE(n)				((n) << 30)
+
 #define ISP_REG_LCCF_CFG_2			0x0e0
 #define ISP_REG_LCCF_CFG_3			0x0e4
 #define ISP_REG_LCCF_CFG_4			0x0e8
@@ -305,6 +312,10 @@
 #define DNRM_F(n)				((n) << 16)
 #define CCM_M_DAT(n)				((n) << 0)
 
+#define ISP_REG_YHIST_CFG_4			0xcd8
+
+#define ISP_REG_YHIST_ACC_0			0xd00
+
 #define ISP_REG_GAMMA_VAL0			0xe00
 #define ISP_REG_GAMMA_VAL1			0xe04
 #define ISP_REG_GAMMA_VAL2			0xe08
@@ -389,6 +400,15 @@
 #define IMAGE_MAX_WIDTH				1920
 #define IMAGE_MAX_HEIGH				1080
 
+#define ISP_YHIST_BUFFER_SIZE			(64 * sizeof(__u32))
+
+enum stf_isp_type_scd {
+	TYPE_DEC = 0,
+	TYPE_OBC,
+	TYPE_OECF,
+	TYPE_AWB,
+};
+
 /* pad id for media framework */
 enum stf_isp_pad_id {
 	STF_ISP_PAD_SINK = 0,
@@ -429,5 +449,8 @@ int stf_isp_unregister(struct stf_isp_dev *isp_dev);
 
 void stf_set_yuv_addr(struct stfcamss *stfcamss,
 		      dma_addr_t y_addr, dma_addr_t uv_addr);
+void stf_set_scd_addr(struct stfcamss *stfcamss,
+		      dma_addr_t yhist_addr, dma_addr_t scd_addr,
+		      enum stf_isp_type_scd type_scd);
 
 #endif /* STF_ISP_H */
diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index 989b5e82bae9..d9e51d4e2004 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -125,6 +125,14 @@ static int stf_video_init_format(struct stfcamss_video *video)
 	return 0;
 }
 
+static int stf_video_scd_init_format(struct stfcamss_video *video)
+{
+	video->active_fmt.fmt.meta.dataformat = video->formats[0].pixelformat;
+	video->active_fmt.fmt.meta.buffersize = sizeof(struct jh7110_isp_sc_buffer);
+
+	return 0;
+}
+
 /* -----------------------------------------------------------------------------
  * Video queue operations
  */
@@ -330,6 +338,75 @@ static const struct vb2_ops stf_video_vb2_q_ops = {
 	.stop_streaming  = video_stop_streaming,
 };
 
+static int video_scd_queue_setup(struct vb2_queue *q,
+				 unsigned int *num_buffers,
+				 unsigned int *num_planes,
+				 unsigned int sizes[],
+				 struct device *alloc_devs[])
+{
+	*num_planes = 1;
+	sizes[0] = sizeof(struct jh7110_isp_sc_buffer);
+
+	return 0;
+}
+
+static int video_scd_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_buffer *buffer = to_stfcamss_buffer(vbuf);
+	dma_addr_t *paddr;
+
+	paddr = vb2_plane_cookie(vb, 0);
+	buffer->addr[0] = *paddr;
+	buffer->addr[1] = buffer->addr[0] + ISP_YHIST_BUFFER_SIZE;
+	buffer->vaddr = vb2_plane_vaddr(vb, 0);
+
+	return 0;
+}
+
+static int video_scd_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	if (sizeof(struct jh7110_isp_sc_buffer) > vb2_plane_size(vb, 0))
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, sizeof(struct jh7110_isp_sc_buffer));
+
+	vbuf->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static int video_scd_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+
+	video->ops->start_streaming(video);
+
+	return 0;
+}
+
+static void video_scd_stop_streaming(struct vb2_queue *q)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+
+	video->ops->stop_streaming(video);
+
+	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops stf_video_scd_vb2_q_ops = {
+	.queue_setup     = video_scd_queue_setup,
+	.wait_prepare    = vb2_ops_wait_prepare,
+	.wait_finish     = vb2_ops_wait_finish,
+	.buf_init        = video_scd_buf_init,
+	.buf_prepare     = video_scd_buf_prepare,
+	.buf_queue       = video_buf_queue,
+	.start_streaming = video_scd_start_streaming,
+	.stop_streaming  = video_scd_stop_streaming,
+};
+
 /* -----------------------------------------------------------------------------
  * V4L2 ioctls
  */
@@ -448,6 +525,37 @@ static const struct v4l2_ioctl_ops stf_vid_ioctl_ops = {
 	.vidioc_streamoff               = vb2_ioctl_streamoff,
 };
 
+static int video_scd_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct v4l2_meta_format *meta = &f->fmt.meta;
+
+	if (f->type != video->type)
+		return -EINVAL;
+
+	meta->dataformat = video->active_fmt.fmt.meta.dataformat;
+	meta->buffersize = video->active_fmt.fmt.meta.buffersize;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops stf_vid_scd_ioctl_ops = {
+	.vidioc_querycap                = video_querycap,
+	.vidioc_enum_fmt_meta_cap       = video_enum_fmt,
+	.vidioc_g_fmt_meta_cap          = video_scd_g_fmt,
+	.vidioc_s_fmt_meta_cap          = video_scd_g_fmt,
+	.vidioc_try_fmt_meta_cap        = video_scd_g_fmt,
+	.vidioc_reqbufs                 = vb2_ioctl_reqbufs,
+	.vidioc_querybuf                = vb2_ioctl_querybuf,
+	.vidioc_qbuf                    = vb2_ioctl_qbuf,
+	.vidioc_expbuf                  = vb2_ioctl_expbuf,
+	.vidioc_dqbuf                   = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs             = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
+	.vidioc_streamon                = vb2_ioctl_streamon,
+	.vidioc_streamoff               = vb2_ioctl_streamoff,
+};
+
 /* -----------------------------------------------------------------------------
  * V4L2 file operations
  */
@@ -473,6 +581,9 @@ static int stf_link_validate(struct media_link *link)
 	struct stfcamss_video *video = video_get_drvdata(vdev);
 	int ret;
 
+	if (video->type == V4L2_BUF_TYPE_META_CAPTURE)
+		return 0;
+
 	ret = stf_video_check_format(video);
 
 	return ret;
@@ -506,7 +617,11 @@ int stf_video_register(struct stfcamss_video *video,
 	q = &video->vb2_q;
 	q->drv_priv = video;
 	q->mem_ops = &vb2_dma_contig_memops;
-	q->ops = &stf_video_vb2_q_ops;
+
+	if (video->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		q->ops = &stf_video_vb2_q_ops;
+	else
+		q->ops = &stf_video_scd_vb2_q_ops;
 	q->type = video->type;
 	q->io_modes = VB2_DMABUF | VB2_MMAP;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
@@ -529,16 +644,28 @@ int stf_video_register(struct stfcamss_video *video,
 		goto err_mutex_destroy;
 	}
 
-	ret = stf_video_init_format(video);
-	if (ret < 0) {
-		dev_err(video->stfcamss->dev,
-			"Failed to init format: %d\n", ret);
-		goto err_media_cleanup;
+	if (video->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+		ret = stf_video_init_format(video);
+		if (ret < 0) {
+			dev_err(video->stfcamss->dev,
+				"Failed to init format: %d\n", ret);
+			goto err_media_cleanup;
+		}
+		vdev->ioctl_ops = &stf_vid_ioctl_ops;
+		vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE;
+	} else {
+		ret = stf_video_scd_init_format(video);
+		if (ret < 0) {
+			dev_err(video->stfcamss->dev,
+				"Failed to init format: %d\n", ret);
+			goto err_media_cleanup;
+		}
+		vdev->ioctl_ops = &stf_vid_scd_ioctl_ops;
+		vdev->device_caps = V4L2_CAP_META_CAPTURE;
 	}
 
 	vdev->fops = &stf_vid_fops;
-	vdev->ioctl_ops = &stf_vid_ioctl_ops;
-	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_STREAMING;
 	vdev->entity.ops = &stf_media_ops;
 	vdev->vfl_dir = VFL_DIR_RX;
 	vdev->release = stf_video_release;
diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
index 59799b65cbe5..53a1cf4e59b7 100644
--- a/drivers/staging/media/starfive/camss/stf-video.h
+++ b/drivers/staging/media/starfive/camss/stf-video.h
@@ -37,6 +37,7 @@ enum stf_v_line_id {
 enum stf_capture_type {
 	STF_CAPTURE_RAW = 0,
 	STF_CAPTURE_YUV,
+	STF_CAPTURE_SCD,
 	STF_CAPTURE_NUM,
 };
 
-- 
2.25.1


