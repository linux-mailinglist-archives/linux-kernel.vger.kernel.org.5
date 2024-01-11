Return-Path: <linux-kernel+bounces-23271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76982AA09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41691F214EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17513ACC;
	Thu, 11 Jan 2024 08:57:22 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2065.outbound.protection.partner.outlook.cn [139.219.17.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDA17727;
	Thu, 11 Jan 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiDYwprjCFr4cPa2XEGfFIn5Gak5giIxtSDGWV/hn3kRqgtUSZVXZD2+sU+InLyyUw+1ZdZ7qJ5Cc39Ocy5+lqq1riMHWofwslF0uv1YgPmI/tQOipoxYgnldw11+rWQVUXpRiJtz+tFQNdTVJYIX+eftmu9vcK26ENPy4xYwFnbmu7TgHxbxLpe4+6ch+exGba5fV1X+7k6aIQOHhzvhQSuH8uCoPt78fy+//xTqFp5I6EXlujCwIn5hjmcCzGYhu6GGpOuUb30O+DGW3X2ncVJZaGgJYo1C0OMlIyhEWWTlZk60RHzUyB6GZGd936RZe56g8KjGfzn8MVrF+aXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myCz3x19pdBLyepP22aXlUVVrVPBvbaFTbiJbWyXl5U=;
 b=YMaor2rZGXVerJq15TB+VDQsgvJiPRBH49ryYrU1zXAugbptPKh6DHwiKFpK/O+43W3rurL1H6eBBGo+avWTICeQwlKa2FcRtmeAN2hnamSe3z3Q35NnI0ywfV+W9dUdIQQwwMsZiOnXDEXAHOrUvk7jHaqRUGO2kKExoC/aQA8bRq8bSa5PEJrxMWulNZGPHpU9uE/SiuK21DRwgwoxyVFbnnrFcH2wO2E42EK5QB4wP4LZUhoSuescQBa5HV671lx5CuCDeCdj6LE8jgsXnkSgOPpvUo2LjwfzBpVPiOHkP8B1RnGrQe00kcYMBCcmKjsZDaUEZn5ZGjcx/mtMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:31 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:31 +0000
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
Subject: [PATCH v2 04/13] staging: media: starfive: Add a params sink pad and a scd source pad for ISP
Date: Thu, 11 Jan 2024 00:41:11 -0800
Message-Id: <20240111084120.16685-5-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea2347cb-bce9-496a-d2f0-08dc12811bff
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JGIzBUIgsRWN/PT2iQoehm5WouSkXotqEe3jRzlIaPxmNKyOzcWjG7luLj0RsU42PtnIXtchxWs2L4rqnEBcVf/CZWwZ1luTE0/u/sj8hPlVo1HLU82LmGmAYhmWw+2p8avBpSMkeq/36iXr9IrKpa9yj4hBdIoPL7NPMHM7Db75GrpbUk+qslvhGKnVW1OHtjD9JK7xhHAmajjVI48X+RCHp/O4BVhx+Mz6ZlTQtH667mPw20zveEDEmF7L40La+syi5AB3TrbwwlK9EM1p8UUtsIib2VHB/dASgwHz8ITzYjY9o7kWWrxgv6LmrQWP13XCg/LdyV3zguWRa7trvcIqA8NB1U9oWLJVWzoSbKKyzKW4Jy5XS9A6JkeD+56oroT9oE+e1bMJLvnZeeyXTdWeGBWApDmIDms8kpPslWC6G5WRz7XbwVNekegaw3p/DTpVZ5K3cW3DYJp7jKLjKsEkiAfMWCXdexBHpSW7qkVA+Jc8jGhQRWuILNhQru4XDcxnC5GrhsSCDKzThyRLAHwXR0L5GuBdYqlPL321viaGkzR2NFSDeXK8E4ZvvmO10yIjBmDnmAusl1DLqktRsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TWuEsLbUZE7Zg+cKrDI9vE2jm4tReDCFiQD7DzHgGEJfnigWavHKVaCx1o9S?=
 =?us-ascii?Q?w2Ri5Kjpp98f57Sdt01hXtBOAxEFT9q5myunByaSeGpOnOqNxZaf4WB11ecq?=
 =?us-ascii?Q?wvhCuW2e6fq6s/qlUlFvoOx37iyPdm5HbRoSGTn+cqH0FOivcPCZmMKlAhCc?=
 =?us-ascii?Q?hnarfK0i5SECb/h1BYxMvdmHdy/Dmm4jRtw7zrea2WwL+LEU2wSv6GLiLq31?=
 =?us-ascii?Q?Q0Ll+FI+NzlmuJmIUOGWXPLvW5sWf/4e87Wnuo98m6vmyyj67upAWASvbkVk?=
 =?us-ascii?Q?M6P+eciXf2GEGOvrc9j2nm8RkxMngoXXyWCr0k3aiNer5wfVSezW6om9fdjL?=
 =?us-ascii?Q?EvTjl0bVK+FHP3iq7ox/sU4qxT6HyAm4ntyC69z5aogjSuvLssOABiiHmvze?=
 =?us-ascii?Q?UYbhECzsjViC109WjcEZcBHnE27XC1Y54Du1xlCHCHL7dOZkymoiji/AZi8s?=
 =?us-ascii?Q?6AzT1soOWWkD2f+PZ9qlLqnrM66kYmZzMXaEmHhGYiEmzjQckBPem8/A9v0S?=
 =?us-ascii?Q?kTFM1ZUcV+S60UrBHv9xBUcTfM7M+T94mvAjkS3JoUG4r32+Ks+JMdfmx7/g?=
 =?us-ascii?Q?Png9A2tmMlC57vY9nsvJtxpweKWINuWwjGzVfUbiUwqbZlfHaNM/uV+tlDLl?=
 =?us-ascii?Q?tjn54Lol14bqFvHJT0I+/4hgbNI4WEES1V0IDcRghzZDDUjgciVyd9gk68Wp?=
 =?us-ascii?Q?XQD4GC4NTb3HXw+2mmYYxDBJxZu2GHoHRnHZGSUyg1vYRqw4wy5cnD5zDVkf?=
 =?us-ascii?Q?TCiQVkDC255aYblP+O606R5jUZFCnfgcYrGCVi2GAZdmbJWGUKgBnrKIYMGB?=
 =?us-ascii?Q?rRiokV91aOOTL1lu8jzv0d2Qtutuu2J6PMo8eiLUbgRklvlcd7haZC1VeJ3m?=
 =?us-ascii?Q?1azZ7FLO6yGmYra+ybldpzEqnwp9aYVDWvD+RYSlH3XBWs15h//GCZkDlONz?=
 =?us-ascii?Q?2kJV3X1mV2BdgN9z6zgsZXefxvU4muizJ/QeyqqORjd7EwAjre798JS9gHXm?=
 =?us-ascii?Q?W8qQScbS8W+BANyf3wBOOr8lTKf92hlCE5h2gKPHvWgZaVF96K7nuW8dWqnA?=
 =?us-ascii?Q?f0g2zftsTM6uBnK5DZ+y5kwRhiVUpBLyGz4rnjenOw0ptP2rkvPUe0kC8f6M?=
 =?us-ascii?Q?p3+BUqLm4EtbwKEcrx3t78DOd70eO3vRfAYGEI51j+2ACG0tmgar2X5V+Onf?=
 =?us-ascii?Q?RciX2dOTax44/5eZpK66YkdppvFRlCLbe9FTyki/OrPcFo+Ved2tVvfRfQ2w?=
 =?us-ascii?Q?N3+HM4tyyuIP57I0L/5W8rD2yNXJ1uCMEF3qLD9Z5/K8dw3CHtRIPrQM4eMG?=
 =?us-ascii?Q?UsNqNbhdgrZeCFRZW/6nMv7SHI3LY7ImtQNytJ8SIhXEnsoRStUfQFf2plCW?=
 =?us-ascii?Q?I9aAjmu/Lz+i5w37bYfpk8VKeWOIsY8Dg5gg5lvVzKcq9KkCJiJ+haTZdIu6?=
 =?us-ascii?Q?9WCtCoQa78nkzvMs3YauwTG40dvhGfaJevhrs9agNB5Vy6eyXRyDa0pESOrJ?=
 =?us-ascii?Q?WA42C/SQTKRIyK4+46jqYtIoJuLh8R29xkw4ceq73kztCQp1y58HpQZxgUBl?=
 =?us-ascii?Q?2Q95hy9ARyFC3C+uAAM+W9AYHl6J6chDroudTvQ7oTgYRa9j/6fe4y+bhFT5?=
 =?us-ascii?Q?H/GGe0/cXYA8zup3aA7WbvM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2347cb-bce9-496a-d2f0-08dc12811bff
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:31.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae51Hp2OPx1ZAbRGKW2iWyog6av1ZCpy991csWYEl455UFlwbPwUcF6JkOmbSiSrzifaDSyPW8DhJnWWny7TUhRGdi2LVkAfCaKj8C1rNbr1wp4qa4NXoD4EAmhaM2nA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

StarFive ISP can use params sink pad to transmit ISP parameters and use
scd source pad to capture statistics collection data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp.c    | 87 +++++++++++++++----
 .../staging/media/starfive/camss/stf-isp.h    |  2 +
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index d50616ef351e..0ebffd09842a 100644
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
@@ -24,13 +21,23 @@ static const struct stf_isp_format isp_formats_sink[] = {
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
@@ -94,18 +101,21 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
 		return;
 	}
 
-	if (pad == STF_ISP_PAD_SINK)
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
-	else if (pad == STF_ISP_PAD_SRC)
-		formats = &isp_dev->formats[SOURCE_FORMATS_INDEX];
+	formats = &isp_dev->formats[pad];
+
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
 
-	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
-			     STFCAMSS_FRAME_MAX_WIDTH);
-	fmt->height = clamp_t(u32, fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
-			      STFCAMSS_FRAME_MAX_HEIGHT);
-	fmt->height &= ~0x1;
 	fmt->field = V4L2_FIELD_NONE;
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
 	fmt->flags = 0;
 
 	if (!stf_g_fmt_by_mcode(formats, fmt->code))
@@ -123,9 +133,9 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		if (code->index >= ARRAY_SIZE(isp_formats_sink))
 			return -EINVAL;
 
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		formats = &isp_dev->formats[code->pad];
 		code->code = formats->fmts[code->index].code;
-	} else {
+	} else if (code->pad == STF_ISP_PAD_SRC) {
 		struct v4l2_mbus_framefmt *sink_fmt;
 
 		if (code->index >= ARRAY_SIZE(isp_formats_source))
@@ -137,6 +147,10 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		code->code = sink_fmt->code;
 		if (!code->code)
 			return -EINVAL;
+	} else {
+		if (code->index > 0)
+			return -EINVAL;
+		code->code = MEDIA_BUS_FMT_METADATA_FIXED;
 	}
 	code->flags = 0;
 
@@ -157,6 +171,9 @@ static int isp_set_format(struct v4l2_subdev *sd,
 	isp_try_format(isp_dev, state, fmt->pad, &fmt->format);
 	*format = fmt->format;
 
+	if (fmt->pad == STF_ISP_PAD_SRC_SCD || fmt->pad == STF_ISP_PAD_SINK_PARAMS)
+		return 0;
+
 	isp_dev->current_fmt = stf_g_fmt_by_mcode(&isp_dev->formats[fmt->pad],
 						  fmt->format.code);
 
@@ -208,6 +225,9 @@ static int isp_get_selection(struct v4l2_subdev *sd,
 	struct v4l2_subdev_format fmt = { 0 };
 	struct v4l2_rect *rect;
 
+	if (sel->pad == STF_ISP_PAD_SRC_SCD || sel->pad == STF_ISP_PAD_SINK_PARAMS)
+		return -EINVAL;
+
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP_BOUNDS:
 		if (sel->pad == STF_ISP_PAD_SINK) {
@@ -245,6 +265,9 @@ static int isp_set_selection(struct v4l2_subdev *sd,
 	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
 	struct v4l2_rect *rect;
 
+	if (sel->pad == STF_ISP_PAD_SRC_SCD || sel->pad == STF_ISP_PAD_SINK_PARAMS)
+		return -EINVAL;
+
 	if (sel->target != V4L2_SEL_TGT_CROP)
 		return -EINVAL;
 
@@ -302,8 +325,38 @@ static int isp_init_formats(struct v4l2_subdev *sd,
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
@@ -344,7 +397,9 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
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


