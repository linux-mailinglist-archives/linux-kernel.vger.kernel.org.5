Return-Path: <linux-kernel+bounces-127705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC129894FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69020282596
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F155E091;
	Tue,  2 Apr 2024 10:15:18 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587BD5B5BE;
	Tue,  2 Apr 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052917; cv=fail; b=ScW3sFvJi0F+yNYHb4oUXS609mY5ZyyhbwGF3ThpdOwqaIWSnGTmTJ1qmSD213V64XoOGwZCBp/b+Eo1sE7QmdmZ7mTylv+IvArAwIIOkSQyCdYljf+oY5R+C6yY84HQlRvRRfPIUlbdbq9jmsAYv9G/xYaBAxEmDO10m3z9sPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052917; c=relaxed/simple;
	bh=O2TpQH3aYr58MdlMZd0isYo1hG/MrS/qWM/6mVNG860=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTVvvnWG9o+ZLzYGHD86vXou6/46IrfkIUB7ibS3X56lttQruhmANoVgu58ZZR3sP1BS0j4JSP4FgjO2rsdD43z0Z3oAQ84bOUIgtDMcDncSI2FHW0o2Q2SsFYrTNeVVIESRaKVBeAkGM6eLVcUAkizPT7gAKq81epcK6U1Pnu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS+DeLYj3fwuwtPM+r9VHNSdF3/3e1bAS6DkYhqK9OEj5vmEG5FMTm10GSUZKo4dN1G+5EbqBs6Ajta2/ls8fzI4QHWld/8nOphl1UnzRHiKhhiNZzqfBKyC4grNtT+RXW/yFoIFxb23YRkR5MCpk6njkNRhMVZWnhgwdqe3mVOCCb4pkMBZwqG9oOlqa7YSRLs0cV0X6u8nz0fXRu1jzzmCknqdxUukTg/mpexnui72hZOVpmKCT9zvOFF2Nb4sFZf6OzlNMC9wrSRFacVGMd08bYwg51lm7eOEohTHXavIy8MRKvYE7z5lx3+zL8kTzM6TE899mLpyu9ogLl+UBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg8t6KA6xXaAbxDKOd9ejurVsKOaesP3cweja2TCY+4=;
 b=MjycnmaQDIoinB5FlK/wvre4eqrkBO4St564qsKG0kKbYRC8p1P5+5GTsdDqNE7JcZvIN/nkns+3BdulSQHDn9kyA644RQoPLLZbzAXtNehZCG7KJ3owuH/HeX1/L9CkrvhDpVHifLfR4P62S7Z1fdM8uWgrn+OgKAT2Bh5/OSYruANhzLHnn+rtQ9qemZfjHmNkxjEFBExdaKA3Ozg6XxLi+WScGmCxJHgxiRIJMq0K2P3RchG6Nv6A4spEEczHIAp4uKKSQKYNU/duQfNmugeACWr1QEII1OdiIZbCw3RQXB4FHz9z5JqrbrtegnWhUEHrJQJVJdf464eArT4pnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0669.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Tue, 2 Apr
 2024 10:00:27 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:27 +0000
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
Subject: [PATCH v4 04/13] staging: media: starfive: Add a params sink pad and a scd source pad for ISP
Date: Tue,  2 Apr 2024 03:00:02 -0700
Message-Id: <20240402100011.13480-5-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0669:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0e15b9-0835-497a-24d8-08dc52fbb8f4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lk/+w/QHiKMkx23pa0vliVaEcozfPcUOO002m5GH/z08ZpPqHf0vlOuBZasIacDVJQokfBpQ+7ZQpyzHFgaha8SBuY+D7f0eibnQD/aqWe3+5llnG6UDaxcTyJZJBbuXF/HfAmAhRoy9H6qO+aQ5jVMCxoJljjm+EPxiRVoUsnYeWFu0+fwUUt9pOwLdMHNnLVZE6rFV91qk65nYPsMm/e/bIpep9GHq241aUQuxUdYvY6Huz5HJGgn/npbGYfY9yreAedxtIYRn40z5gGxYv/6e6Xv+2h8wjyrebdqNylpMZGtoHakHdBChGlncb0l5anx3jprqRew2b8LaXDTqV2RKlqIQoeQZcmkEGY846QlyKyVFGO+u3y4lsSIjUJ4wy+vm5IpWAIo4BCPW5ony679Ds6krVIpQQ+rz2wMkeA1U8qV6F+Icc4dBczLCfT31hdLwzSSj3e286yZ8TJTWGBrTIXq4WJDV1G53bk835UXYqimvwF8xn/z0Z30akLBaq4lJSHlcJv0Ovwnwau49dQFk1c8R1WKspASgHz/g15jtdVw/Qpwk1esgZrtntWO2dOG2E3N0CXTcQwwKdtSb7aG4CZNqauRjIK+Gn8ogBcT9/PdsMuYiEEh+B5N8SZ0kZJrNeS5VF38x/Kil5tsY8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UW+Bk1XaX5LaUn4kxHtIibWqM8vegRY8WN46SrMPCAXUIs8vXu/w3YjQSymL?=
 =?us-ascii?Q?UKjuJBxX1QKfmKjKZHlT6/8cn3Sf/F3XKVSYLN/COrgpFwH6+QyPzU7go5K1?=
 =?us-ascii?Q?OQbq4xdcr9C0zaa27O8BHRFwuP8QPivDqhPT3D1OAwBg+CMFbv299efct9Wb?=
 =?us-ascii?Q?e6VdS48IpH51UsYMkvGf91SDquvw1xia/M7hhq0bLFv3SowFFO5A5joxrXU/?=
 =?us-ascii?Q?XQ6vQw7Tg6SU506jS2i79XhdgwaXLQSkABDBNV9ySxezVRMaj3MalNvqahZ3?=
 =?us-ascii?Q?ni1J3MXl2uMTfFwVOOJrnlrRx1DTZPsjqUAl2wdABxeJE+rq+BVaSCuLTZ67?=
 =?us-ascii?Q?QD3mSu6uQrHOFuCmJEDh/VIzTZIpHQHv3hTS8/sl0Aqby+hSHWKe63g/gkMH?=
 =?us-ascii?Q?5lpb6MJvL1RaqqeEPjm2xMG1R8X1JiVXK3yaNv2I/avH3zQeyNuNj+bA59AX?=
 =?us-ascii?Q?xfTS/SskjaNx4osoxRCXGBmaYASkOpFn8quWO+vXweRjmvjUX583IxOBvFcO?=
 =?us-ascii?Q?4w+ORq7720C0yF6IxGRfyHGNrhAE7wEhTU8KoDDIIam+CiCfjKQgjftmiTs4?=
 =?us-ascii?Q?Ze28poFtcBzMu28V9weJZuvDwAfYTXLIlY3IINBiDpOO0RnSZwCfrFj962Z1?=
 =?us-ascii?Q?7yKql4zFEkf2dls2DqbCLDr/sv/X/GSqfFAIL3Uxbm8wrYWykjHL+karJKSb?=
 =?us-ascii?Q?VQmdpNZQJpl+C86bKGaHsRcLeCFEr7AKuZKo2xmtgO34pJ03bq1XJBK4IqyV?=
 =?us-ascii?Q?loLv5x2eggL4klGTDkN3AahqhnCKMBVu9HEDeaapNRwkAen75jMGtLSAw1AX?=
 =?us-ascii?Q?IYvJv+Gg9A0YEygP38EgM/asyMvfR8T8TBb+7j+DBCFTq0M27eCSg2s11xdF?=
 =?us-ascii?Q?UH4pfZy/YvK3KhMagwPD+dv4dCpyCnnQo7WINvW1ehsCqBBu4lb0BaWyVRfb?=
 =?us-ascii?Q?xUpCmiA3RepBx5n7TIFoirGqZy3zGDy3n7BVqp/CENn2qJ8h7Qv++reFA12J?=
 =?us-ascii?Q?sET/DmETKU44UvUNfPPicRUcVxRdTUlP+8zLYZAiWS74zIyPUkEnzkuksbcl?=
 =?us-ascii?Q?MwmAcl574EBiD4tmtBrLJ4OJ8IitCu/1x0b6X7C1Vn8d6Nz+sOskHrJua//E?=
 =?us-ascii?Q?SzcQLyHwsa2OLlSYeooORecIR01lAJM2kn765/1eNRoAV/VRw4h5iutwgUE4?=
 =?us-ascii?Q?pzNAbxTR1LWOh2UfSe/tig8sYRVImUJkAHV0wAijpAe1kEekZREgMqyfVQ0l?=
 =?us-ascii?Q?ZlXrponJdg/nSnj8RAovAW5P/kLnpuZ47KZrO3w2Gq7kL5bd/oVye9f4gswP?=
 =?us-ascii?Q?uBeuYMYJrka0fqUjNFdD1BMxZBuEYaAjJIjcUkxtPtntcbb3oSvD8niPptF3?=
 =?us-ascii?Q?tSpyETyedpt/ds9jVaY7hKmJWjMh2RmdQFcclTXIgNoB487diAYM/01e3lj4?=
 =?us-ascii?Q?PotNFpEB+oy+b79B/knJibCN9DkFiOwimvqvYyOpcunQEUIiB3iUoy5misM/?=
 =?us-ascii?Q?Iw0SWt4NqBz42ylNkVkW6W4tIbmAQLcmR8faDBP8SBcrIy2/DN6rw/cDBS04?=
 =?us-ascii?Q?9TDb3pOhwaAgE0oEaMFh0ZxZ7HfooxgxWRfkYxUfUEMaxZu8o8/Apmoul6hQ?=
 =?us-ascii?Q?OJvJIAcB+PfSlo/Mrn/ez6c=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0e15b9-0835-497a-24d8-08dc52fbb8f4
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:27.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXwEmNcospHv8UAOP/e4cznaH7BM+6nfUcUV+o0N6Wwei92qitnU/RubCdcI2Okp5BjyGIA9w+u1XMunK1lXvGMgOzcpeGykO9AGtDE9OwaCVuqLh7Mfu8gJ0/axOHul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0669

StarFive ISP can use params sink pad to transmit ISP parameters and use
scd source pad to capture statistics collection data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp.c    | 77 +++++++++++++++++--
 .../staging/media/starfive/camss/stf-isp.h    |  2 +
 2 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index 4e6e26736852..0ebffd09842a 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -21,13 +21,23 @@ static const struct stf_isp_format isp_formats_sink[] = {
 	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10 },
 };
 
+static const struct stf_isp_format isp_formats_sink_params[] = {
+	{ MEDIA_BUS_FMT_METADATA_FIXED },
+};
+
 static const struct stf_isp_format isp_formats_source[] = {
 	{ MEDIA_BUS_FMT_YUYV8_1_5X8, 8 },
 };
 
+static const struct stf_isp_format isp_formats_source_scd[] = {
+	{ MEDIA_BUS_FMT_METADATA_FIXED },
+};
+
 static const struct stf_isp_format_table isp_formats_st7110[] = {
 	{ isp_formats_sink, ARRAY_SIZE(isp_formats_sink) },
+	{ isp_formats_sink_params, ARRAY_SIZE(isp_formats_sink_params) },
 	{ isp_formats_source, ARRAY_SIZE(isp_formats_source) },
+	{ isp_formats_source_scd, ARRAY_SIZE(isp_formats_source_scd) },
 };
 
 static const struct stf_isp_format *
@@ -93,13 +103,19 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
 
 	formats = &isp_dev->formats[pad];
 
-	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
-			     STFCAMSS_FRAME_MAX_WIDTH);
-	fmt->height = clamp_t(u32, fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
-			      STFCAMSS_FRAME_MAX_HEIGHT);
-	fmt->height &= ~0x1;
+	if (pad != STF_ISP_PAD_SRC_SCD && pad != STF_ISP_PAD_SINK_PARAMS) {
+		fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
+				     STFCAMSS_FRAME_MAX_WIDTH);
+		fmt->height = clamp_t(u32, fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
+				      STFCAMSS_FRAME_MAX_HEIGHT);
+		fmt->height &= ~0x1;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	} else {
+		fmt->width = 1;
+		fmt->height = 1;
+	}
+
 	fmt->field = V4L2_FIELD_NONE;
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
 	fmt->flags = 0;
 
 	if (!stf_g_fmt_by_mcode(formats, fmt->code))
@@ -119,7 +135,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 
 		formats = &isp_dev->formats[code->pad];
 		code->code = formats->fmts[code->index].code;
-	} else {
+	} else if (code->pad == STF_ISP_PAD_SRC) {
 		struct v4l2_mbus_framefmt *sink_fmt;
 
 		if (code->index >= ARRAY_SIZE(isp_formats_source))
@@ -131,6 +147,10 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		code->code = sink_fmt->code;
 		if (!code->code)
 			return -EINVAL;
+	} else {
+		if (code->index > 0)
+			return -EINVAL;
+		code->code = MEDIA_BUS_FMT_METADATA_FIXED;
 	}
 	code->flags = 0;
 
@@ -151,6 +171,9 @@ static int isp_set_format(struct v4l2_subdev *sd,
 	isp_try_format(isp_dev, state, fmt->pad, &fmt->format);
 	*format = fmt->format;
 
+	if (fmt->pad == STF_ISP_PAD_SRC_SCD || fmt->pad == STF_ISP_PAD_SINK_PARAMS)
+		return 0;
+
 	isp_dev->current_fmt = stf_g_fmt_by_mcode(&isp_dev->formats[fmt->pad],
 						  fmt->format.code);
 
@@ -202,6 +225,9 @@ static int isp_get_selection(struct v4l2_subdev *sd,
 	struct v4l2_subdev_format fmt = { 0 };
 	struct v4l2_rect *rect;
 
+	if (sel->pad == STF_ISP_PAD_SRC_SCD || sel->pad == STF_ISP_PAD_SINK_PARAMS)
+		return -EINVAL;
+
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP_BOUNDS:
 		if (sel->pad == STF_ISP_PAD_SINK) {
@@ -239,6 +265,9 @@ static int isp_set_selection(struct v4l2_subdev *sd,
 	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
 	struct v4l2_rect *rect;
 
+	if (sel->pad == STF_ISP_PAD_SRC_SCD || sel->pad == STF_ISP_PAD_SINK_PARAMS)
+		return -EINVAL;
+
 	if (sel->target != V4L2_SEL_TGT_CROP)
 		return -EINVAL;
 
@@ -296,8 +325,38 @@ static int isp_init_formats(struct v4l2_subdev *sd,
 			.height = 1080
 		}
 	};
+	struct v4l2_subdev_format format_params = {
+		.pad = STF_ISP_PAD_SINK_PARAMS,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_METADATA_FIXED,
+			.width = 1,
+			.height = 1
+		}
+	};
+	struct v4l2_subdev_format format_scd = {
+		.pad = STF_ISP_PAD_SRC_SCD,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_METADATA_FIXED,
+			.width = 1,
+			.height = 1
+		}
+	};
+	int ret;
+
+	/* Init for STF_ISP_PAD_SINK and STF_ISP_PAD_SRC pad */
+	ret = isp_set_format(sd, sd_state, &format);
+	if (ret < 0)
+		return ret;
+
+	/* Init for STF_ISP_PAD_SINK_PARAMS pad */
+	ret = isp_set_format(sd, sd_state, &format_params);
+	if (ret < 0)
+		return ret;
 
-	return isp_set_format(sd, sd_state, &format);
+	/* Init for STF_ISP_PAD_SRC_SCD pad */
+	return isp_set_format(sd, sd_state, &format_scd);
 }
 
 static const struct v4l2_subdev_video_ops isp_video_ops = {
@@ -338,7 +397,9 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
 	v4l2_set_subdevdata(sd, isp_dev);
 
 	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[STF_ISP_PAD_SINK_PARAMS].flags = MEDIA_PAD_FL_SINK;
 	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	pads[STF_ISP_PAD_SRC_SCD].flags = MEDIA_PAD_FL_SOURCE;
 
 	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_ISP;
 	sd->entity.ops = &isp_media_ops;
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 955cbb048363..bc7e7b0736fa 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -392,7 +392,9 @@
 /* pad id for media framework */
 enum stf_isp_pad_id {
 	STF_ISP_PAD_SINK = 0,
+	STF_ISP_PAD_SINK_PARAMS,
 	STF_ISP_PAD_SRC,
+	STF_ISP_PAD_SRC_SCD,
 	STF_ISP_PAD_MAX
 };
 
-- 
2.25.1


