Return-Path: <linux-kernel+bounces-93665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970FE87330A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C4EB27DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5775EE6F;
	Wed,  6 Mar 2024 09:49:15 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788855D903;
	Wed,  6 Mar 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718554; cv=fail; b=b1IEdjywI+Wp7cfiStQFA6f00yaEZ3SPLc0E2hbLc7WS3tYvSRdSDRfYhNBgWi2YGzBOrKdD+zqxPaDOHPpA5KEQxbeXrTjAXVXYTg/pW8OJY0NVAqt+dgrFAVwwCORmq5UdyCSWoaZIQqIkP278ZBhNNQrMm2FVE9sAlp/Lf+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718554; c=relaxed/simple;
	bh=bITfJJgMEEDmklNHaEfseE9jsww7gadnLcPygZMdMD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGrM29NEfSxjowQRemb6ijN3OXCwowJwjd7xZrcQ03b/iuFaaWFiev3KOcCD5wrXUKEAdoEAUU5sbjr0fFzTKsCMj/anzOUBkc/91eXkk5wtXh1hp+NarISWb9RpwiPj1hrfKPEgq0o9xdf1aaLVokV1xQEcuYotJQ2ubcYZt90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwID9MFRukfFEVL/y/X5wRn/P6H2hgUrswuGuFeFm0npKAcFqxH2dOuJAWEW548UowV/0+XuTQYjLNJ/UVZLuCJja8+QYw1lFeyruL22L+2p37LGdfhWc/s5HNJB6AeETE07Z5tgLIvHBLNZ5ucO6xd33vBBJaNjUhf4yV50qXMEP92I1JcegJRjPVclW9YyduWLneZUY99gb1hHFygiNH4a5Jpgfy58w+hQLFrI4Nh+uG5+k1uxNpdhGUi06RDBmN/gj5IW6SvrGbZ8na5p4MlICd/2aylrioTBkthkKej9QM/dfM51Yhdffv1LQWS4RnAcPNPTfqPy5X37z8vAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/ZG3rH0d+0pY/m2YlgTq+zhQIYZEEfnKg8iyu9aN+4=;
 b=InSsQufK9HuBJ5oo4n+CPGeP3e/GnY/jZD8+TbiF1P1wc+xlscmD83PLGPl3Qoy6z7VNfM/q9gQc1rd9PJDqDMgU5PubQCoUyxkME2EPbQjssh81znhYKbSf/3gIH5DrNbXI4wa1KSKKfXK6qNUgxWOJ9tmGsKajk6vsBFEOao64REUVQtQK/+vLrysqi6hE1VxzaJlLq0fYhmLrgK7S/i2+ZSsYhWhVj3ZJ0KR6GPxpjBUdIX6HP3XendNV6kctyWK/pKiFeIbDdvQ1MB4Xt6OvC8zZuji1Cf7z5rSCsMxdCzbaN40c0mzyxapCPQtXzSgdW6Gydej7fjSPHTW3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:44 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:44 +0000
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
Subject: [PATCH v1 2/7] staging: media: starfive: Add raw pad for ISP
Date: Wed,  6 Mar 2024 01:33:29 -0800
Message-Id: <20240306093334.9321-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5a1a613-c6fb-4057-a36f-08dc3dc08479
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VJK+Euv448HJcYeeoQzgaA3T+HyZTexOIPEv+GhHwVYPyzv7RL45eSwLLHMvRrd9Zp1s6VJgAO176K6bCDJl26IATM9qQnEcBcBZNslHEt+0AK0HhV7Z9+1W1KuYbncOY4hJcFnO7puGG2T937g0BdFyHALXZF5pRAF31xKFXf2GHxTHm0Sk2nYGHxedI00STqqZ13CZKRfi9AjPhRe4ldYbRhYTaQAa1hvQB9FeGHg4KOYrppnSgA0u3dwmC+tIWBVjeS3vYfPa++wo5R0VHySYH/KQ7PkEuV+nMS5mwA863WgT7eoeQp7pa5qDd2HXnCu9K2pslXYZJPr9vKkW1ZjEqs/ijSpaijUjIYBQIh03TraiEnm8ariTusr0m/L8pgRRAz6ftg11uqkvpgoLrP3hGpBD3odairHBzgPdvn/UNn9HTmIl7X3nR/nR6rz3hAH2jBxMMNmtTpLFGCFS8akPBhwfKnG52t9tFJqWRndAsgq9TNg0YMEJ8IaLQRUjV7LQaSP722bmVLPBb7HfaqSGkxD2WY/5ict8t3x/Y+ReeMd+fXa7+dQjlZpLzlEt8u/0facX6Tl2rlSj2am178be0QDQFBa6gcO2u1aWuq1wqfrzJo3Da2nRStE8wvTE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NDVM4nP27oflQJi3isFAod202UfjcbY8tGPL45R69U1COtGhzTMYoCdcRTIt?=
 =?us-ascii?Q?DecruSCPnVQzIjqy6VYNT/wPknhtj65OH1QC5j/S1VQP07Uhy2yvwvuO7Deo?=
 =?us-ascii?Q?ThqJJo4/Vfi1TQbZFIzecpo6wbKPOA+e/CiZP4E/CTUdv37IRqaSv4eDKmIL?=
 =?us-ascii?Q?KeYb7QPYkwOzhCDlSWlpvZFhzdrvoITn3VVSD+g3gum2al4wN8U8ANXhE/mg?=
 =?us-ascii?Q?QhQ+US9z9NhzSlSdEJOg1HjKQxcWDURx8lqRe85enSWufU8wOrrlrxD2hgKD?=
 =?us-ascii?Q?eD8OV6QOw6CNFlr/dJ6fCmBGYmt9FgnzTfM5zXu7I4OEkZzobQgnmSWRWF/H?=
 =?us-ascii?Q?qimrYQ0tXefYNIGpRKkzMJ/w+qPrmQAtBiS9q9twt9pqcaxK5zdaxtrAe3Q3?=
 =?us-ascii?Q?Vg6w290dgJaemrccAjYYGejHvEmX+33Ut70fh6r+979l5YoVa9QY/mtMGij2?=
 =?us-ascii?Q?dxS40czUyFnKIpAp89u9z127UlgT1jivclw2Sxe99q90hEdh6+V2vaVVV6rT?=
 =?us-ascii?Q?5JtVcxtI/J6pG5gwSI6ujiNhEBNOXxcB82vAYmKub1dS23N6w0CCAv90iCRS?=
 =?us-ascii?Q?GxFYGPVdpaVnGwPArouAdTxT99n3wqbQSYiDtv5rSsz5KTDwoYWNNilY8SJB?=
 =?us-ascii?Q?EXfj7xpFBQsE0x/PPyWbZ7zyDf+GnRaDXMSsm8YdWg0SJxyhWcRpdWjv4wUx?=
 =?us-ascii?Q?mhDj9GSPcesGGXbE9RsAASAVHjxbxG66Um61+cHK81jx3SpjBhZ+lIbowElp?=
 =?us-ascii?Q?3V6JoMEfKug85b30ARix7RSeyZvmqwhMLROcZoxG1b9BqWJN9qeQvh2EfFLc?=
 =?us-ascii?Q?FtjJc9G1ZrrLxrKnILlGjrvMmKQ+hQ4NH4dTLlRmLX3ACM5PFCVnOLNrDQju?=
 =?us-ascii?Q?ibdbOPdd1ssT5WeWCr10U7aAdUI5d1POMhgCABuqMMDceFWD3gvFrHoI0oTd?=
 =?us-ascii?Q?ZqQ8WMGLWjust7frx0AXtYMgcQSJky9Mm8FKKzr91dxNwuRiyZeO/O5FXh+Q?=
 =?us-ascii?Q?7iTO7PUhQEkbYbhMU2ffUdysI27Sw349ssd59t7kgri0VyY/YQFmZr+OPBQ9?=
 =?us-ascii?Q?JQFDwJuRuqFo+B83cKgcQ3rpgO+0YncaBUoz6LBMpLZ5QuzbX4OXheOJdsH+?=
 =?us-ascii?Q?euGDnO4CsIlkW0c/FoaBiKIxNkyL9yXbvBitLvor2yEinv8fZynju8rxsi4i?=
 =?us-ascii?Q?QFNfReEAe8L9XxDCOJot9rKN7qd/59yuxbTOFKaHY7ZOdT3VKM0BKvXviFBG?=
 =?us-ascii?Q?EgkEadP+4ekudiaXsrP3IFnrSKGBdjZ6DZ05T9yHbha9gLUIeWYi6xJRtdiK?=
 =?us-ascii?Q?OtGeNV8lmWd1l51AcG6SgsYFcv3ZInOul6y9Nt6ek2fvXf6cbrmnMjN7cQOe?=
 =?us-ascii?Q?0u1bv3UqVilm+IIdCXl5VjEhVtA6YEG1AhKR+tpkyYsihgMD81IU0q1CfsCG?=
 =?us-ascii?Q?7nkYP7rvC7bLCg3R4/3kY1NdRER0+kprqXA9RvIZqCu+Y1gi22HnwEd0S0ZI?=
 =?us-ascii?Q?8jQ96ozHHWzG927PcYcoB9noy29tb1yxhd0e39AuCoYoBqDNsXdB829FSAGp?=
 =?us-ascii?Q?Y2T/TKTGP4f6rfn+Hnkjih3KKZXKlgk0ev0t6+wNrCIkRXoyerea9sDEqOH6?=
 =?us-ascii?Q?1/zrmdPiaxItC0CP70Jqvzs=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a1a613-c6fb-4057-a36f-08dc3dc08479
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:44.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9z9AkyFGEZMNGsuStbnvNmCzAELOHVeCsAp5TQbfqXihSVKCaxb5WFsA4N8idRtiBQ2dp3RmhbX2frkCay8woATVCW73FXoLFtA/jsfK7Yd811lLFX802SR5hzf17pr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

Add raw pad for ISP, it supported the conversion of RAW10 into RAW12.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp.c    | 26 ++++++++++++-------
 .../staging/media/starfive/camss/stf-isp.h    |  1 +
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index a5573abe0d7b..6bab0ac23120 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -10,9 +10,6 @@
 
 #include "stf-camss.h"
 
-#define SINK_FORMATS_INDEX	0
-#define SOURCE_FORMATS_INDEX	1
-
 static int isp_set_selection(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *state,
 			     struct v4l2_subdev_selection *sel);
@@ -28,9 +25,17 @@ static const struct stf_isp_format isp_formats_source[] = {
 	{ MEDIA_BUS_FMT_YUYV8_1_5X8, 8 },
 };
 
+static const struct stf_isp_format isp_formats_source_raw[] = {
+	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SGRBG12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SGBRG12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SBGGR12_1X12, 12 },
+};
+
 static const struct stf_isp_format_table isp_formats_st7110[] = {
 	{ isp_formats_sink, ARRAY_SIZE(isp_formats_sink) },
 	{ isp_formats_source, ARRAY_SIZE(isp_formats_source) },
+	{ isp_formats_source_raw, ARRAY_SIZE(isp_formats_source_raw) },
 };
 
 static const struct stf_isp_format *
@@ -113,10 +118,7 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
 		return;
 	}
 
-	if (pad == STF_ISP_PAD_SINK)
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
-	else if (pad == STF_ISP_PAD_SRC)
-		formats = &isp_dev->formats[SOURCE_FORMATS_INDEX];
+	formats = &isp_dev->formats[pad];
 
 	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
 			     STFCAMSS_FRAME_MAX_WIDTH);
@@ -142,7 +144,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		if (code->index >= ARRAY_SIZE(isp_formats_sink))
 			return -EINVAL;
 
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		formats = &isp_dev->formats[code->pad];
 		code->code = formats->fmts[code->index].code;
 	} else {
 		struct v4l2_mbus_framefmt *sink_fmt;
@@ -281,8 +283,11 @@ static int isp_set_selection(struct v4l2_subdev *sd,
 		crop.target = V4L2_SEL_TGT_CROP;
 		crop.r = *rect;
 		isp_set_selection(sd, state, &crop);
+
+		crop.pad = STF_ISP_PAD_SRC_RAW;
+		isp_set_selection(sd, state, &crop);
 	} else if (sel->target == V4L2_SEL_TGT_CROP &&
-		   sel->pad == STF_ISP_PAD_SRC) {
+		   (sel->pad == STF_ISP_PAD_SRC || sel->pad == STF_ISP_PAD_SRC_RAW)) {
 		struct v4l2_subdev_format fmt = { 0 };
 
 		rect = v4l2_subdev_state_get_crop(state, sel->pad);
@@ -294,7 +299,7 @@ static int isp_set_selection(struct v4l2_subdev *sd,
 
 		/* Reset source pad format width and height */
 		fmt.which = sel->which;
-		fmt.pad = STF_ISP_PAD_SRC;
+		fmt.pad = sel->pad;
 		fmt.format.width = rect->width;
 		fmt.format.height = rect->height;
 		isp_set_format(sd, state, &fmt);
@@ -361,6 +366,7 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
 
 	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	pads[STF_ISP_PAD_SRC_RAW].flags = MEDIA_PAD_FL_SOURCE;
 
 	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_ISP;
 	sd->entity.ops = &isp_media_ops;
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 07d6c2758253..4fc5cfac115c 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -393,6 +393,7 @@
 enum stf_isp_pad_id {
 	STF_ISP_PAD_SINK = 0,
 	STF_ISP_PAD_SRC,
+	STF_ISP_PAD_SRC_RAW,
 	STF_ISP_PAD_MAX
 };
 
-- 
2.25.1


