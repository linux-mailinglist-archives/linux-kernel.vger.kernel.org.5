Return-Path: <linux-kernel+bounces-138218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB689EE38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A50B23269
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDF156996;
	Wed, 10 Apr 2024 09:10:50 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655E15531A;
	Wed, 10 Apr 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740249; cv=fail; b=AEr+yu3UHJAePY0GYp7IeEPISTG4L72U9PsOZ1Hqs2NhiWNDaVIi3R3blc5W/IDvC1bDcur+3rMPEayqDQ/4oX8hbqQA1NYHFgLCKqs/CyAOAW5q3YCB7n9pc1cA8gpeOFT9Dzuag9XuPC4jaETx34nGGuD/tZqEOfeevgsbry8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740249; c=relaxed/simple;
	bh=CqqxCtrLQtbi/NtYVqo/aRLEUFRaTLP/NSO5KRjOH6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLUqPadIK+XWfC9sNaIR93G+DaR/0HVjP9hJ/gmRanQQZqArIckmed3oDefPvPFr0ma17+TWspdkkLluBTRAD9k0iLrx+aGJ/2RViikfdy1ho1exQWcgOSTVglB8RAEpSK0AJ2/L3ct/UzjufJBZt0XjkcjDZtTsWnZ8l2XcWPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glOsXyVlNO5ea6WO5E1Ohs5CjYUSG2OSkPFrvrC2HAGNmVVY2H6AW3tpWv5RtNe9hoyn5TW0o5fA2CFc8o4ZlH8QNChkJslr1aHryYHvDwONJ60K/VqbpwwDFQG88PggGHu7CQfLhBsx62Rhc6op3tlNwYzPMiYeSBG6NIasHdn5Tf6VdVqXzKye8vO2m8bju6wjXC+Yhilbk7cLlCZhsCj0uSoM/LS6T2veCalDVLVGDR/ybeKpkfDQt2RbPUlxMwSvhraD5bTNTKWGOQ/bYdltaTPows2Koki/MskOAXFm92ic7JVR/sGdIVB+N5qbrXpREuvishfPLq5CxM+MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+swQDihLYIny+jQI9HdFv3ov7Y7dMrR2xj0C4Tan+4=;
 b=T4L4Num7SFTw9vKbY83L72t+sh/oKXH4IOvgAUjvMDU9R8TOUNtiaDvMm4WielmZ9zYOvgauQ0Gozsf3WJxwDAw63SCv2PBMsPKJoP6mLIa0orEtXx83UdMcmGsiALZoz/+hZa0mW8jnORyAuiwfWLbpto15e8R5QmTOunlwNpoOPKATUSICRGmz/eyxw1KCrUiDgszebxPR8qVubpiVtCZ2M2x8uB40gJKardbFGGOBy5DwaEPqyEA/tsH6zv6jj3tMZzENE47jqBqqozryglO6qKtfP0wzbmkrzuMgWz5m8tunwGRQvbNHJGDnbSOTw66rznwUrTgmgHtauKqWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0896.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:35 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:35 +0000
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
Subject: [PATCH v2 1/8] staging: media: starfive: Get rid of current_fmt
Date: Wed, 10 Apr 2024 02:10:19 -0700
Message-Id: <20240410091026.50272-2-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0896:EE_
X-MS-Office365-Filtering-Correlation-Id: 35454e8b-b323-4e1d-6172-08dc593e14a3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F/lASc+fOYRxPeqpye3IkFDM4ofZvKKVYTmJ9416X7sY3TlxDsLIqri4wlrzNYJvtlS1l9OsJBOA+wpt5/zdO9/ZvJSrYL21abGdS/jS3lvqU8AJnco0tHYACRo0MJmcuxllEzmh5jqbUFYMEsw5jZMoO4IjrAmJgU0YTrHxEH9h/1PIFtnq4JyaZKj4YIOh9/VTDpvfuxJj3+Qa2C70DhtHhOXdW0W/vRK7LEHncoL73cnF0GVYBkwKLRzXivFciSelJ3gS8kpUVEGZ1JvdCF8Ep6Rs30oA3feqxr7EdaNgRg7U5EKvnC4z0cgBmBkUck200S0I8mncJbAZUr3NRpjopzih7Jr390JFi9MgzG/j7HjuMU2osUVQ7iidC+Wa2uBAJLYvtsO246qMTb4lnGxMaWdu3shasuebsbQ/h+1PBVOlJZkGBbNH9vtrh2Piv5zCcw4P9F8U0PD1CqummbEpA56EunRWqwz/IGtl3vgfBk0n3c7Pv7DuBI45i0tvD0Go91qymZ8TNy5BxdNwhC1SM2+U24H3EqvuCCWamiPOlFa2mS6BWP9jkpSc7o0x5nXPNybEVW9KH+EkFFXqRfUdqmcsVegCrOF6kCjoUhactgCbu6OhYO1w+jZIlsvP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ri0oQ1APEk/237/pAaaasF/3oteztwIIGWySEDDIow9GY7vebms2jKCn6QP9?=
 =?us-ascii?Q?y8shjOCIsAUsOGRB3zGxDFFGefRcAwAJaGS1RZAKONn/whHbDiwYLh392OWN?=
 =?us-ascii?Q?QeLOT2dfNjJoRpJmas1faIa4CEFmHg/sf9EDvZp3Mb92S+Ltf8N/HcbLX1+f?=
 =?us-ascii?Q?4f2IiLnDjPlI/hQWfnxzSZ+oDUICUnVOzs1nzBRR6tsv0vUIv4VrK4vD7Hqq?=
 =?us-ascii?Q?CALcGXkzolzQhDiElK8VDG6k8AENm2LEYgso36PfJxAKRKDXfvzleUjLndKH?=
 =?us-ascii?Q?E24ZHCtDu9YRY6WKvXST+Jsm+rBdVj7L3IpAjIMGIExycUEKcmJbDsmpQbY7?=
 =?us-ascii?Q?bGgOQeHqT/jua2mCHalFv8EGyo+MPRgZQTwhOnhMs7XufJTIBGSIalU2e2ER?=
 =?us-ascii?Q?DUjvHMs7fZiUTHTohvZJwh0lyvwn65HGn7asQcoUEGyG6iaqKt4c3gbIoaS7?=
 =?us-ascii?Q?8WQGAri7gaJpXY92r5CMkhcRlvgtmTpwWGCF8LiOzcxhjw4Q7ivHeYMYOutb?=
 =?us-ascii?Q?fMnlwRAbgk0FrF+8vOc2M2fa4WWyewT+axfbZwEpuZRTOSL+Z0J3riuQ59PJ?=
 =?us-ascii?Q?R0k2zU/v8oub/LIUk+9Mv8tIr4D4vMRHSJeLWTnWcaDeib+VinT55PilwSz8?=
 =?us-ascii?Q?6o2v/iNr7k3ukVctfIkIqmj9HL+sHTDq+t410Z7VN3sn4IZnbXD6RpC3MdrK?=
 =?us-ascii?Q?dgXzVPsQTxmBTcgBJcrv9gEoRMC6G12kMgSQdjzPWc6KyiJ1YfHP2KIEL7ys?=
 =?us-ascii?Q?L7Sus4X7V8ExoKSBC0HC1meo0DqGdPWY/cCxb3/Lbfa8gEEi/qVS568pHy56?=
 =?us-ascii?Q?BHv5MPaK8fHwT7Epqv+LURWPK0q8vssU1qDqckLMd+4AIql2eio5F5OMOBhh?=
 =?us-ascii?Q?ULN+dtp4pVPxRGg+1ZHWtwZuESqTbV8FzwHYQRfaNrz/b8yUuGGE5aUKo9fP?=
 =?us-ascii?Q?t5J7T3P9tgqBefCTY1edXo88agIVttD+670nO5Xv9cz6+bxmgtfQ3ZFbORmG?=
 =?us-ascii?Q?ZwVJeIA+0ycT6MIgfn/jUXK8nsIRq8DNy0X29D4y1T1bZJK0lTAtJlu4p8QT?=
 =?us-ascii?Q?cROOfgc6yDcucb4kmqHjqh/y4tXiHGBXLWO10CvBf8YQBDYpD/UgdqYXZvYL?=
 =?us-ascii?Q?Y+SzKfZ1gL2tRU0UAiek5ORaQ8Jy7/zAaQoaURO8+CQBgnl+h/Ciz9ra/D5k?=
 =?us-ascii?Q?ZKqetkhkY5s+DKg4D6Etlt9yBNM/LnbraoKcl1u14LdwMDP+/2GtNJZSCxZf?=
 =?us-ascii?Q?gXLcgRy6xeiH5PbdF7ODzfvk7sVbIVixeo6hW3W/bz62MHM28SfavHkA/bUx?=
 =?us-ascii?Q?mNTly9ITTJ62dj1V84Int7gNP18EZ8ERqrhOTY0fPdZ3E1RTHrIqPTJD3uUy?=
 =?us-ascii?Q?fV90MreTQLPpBVV5gbbZwXCixsrQP2BheJUT47JebpBl//CH7BT3vaqFUJ5I?=
 =?us-ascii?Q?VPgenS4WIflcV9jogyrPyjDNtkedS4qlwS2RgK5fedpJhxczvKD0fnk1D8Yx?=
 =?us-ascii?Q?V9CLI0vFqgvkZVqFFC9Dd8OL7h3d5oPTXmDzbuDtym73Gma3HOP/cGOKXeKV?=
 =?us-ascii?Q?q7UEJU3XX2wuY12iUYJPYTgUwBrQmBdNKRZl8BLQZr1MnmhF/Mc+BZAi8N5N?=
 =?us-ascii?Q?5jcSYccv0uuimxgamTauiI8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35454e8b-b323-4e1d-6172-08dc593e14a3
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:35.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu6O94uwzK0xr+gj0QuEusHcv+WSVIT+O8xcjRTvBkRJDYRrXgDbHDvFlFOO2i3JYRnN1fj7ZHZBqLup1CoRYVomWVLcbb5mS0o9JLXiVus8sLq/svRfw2E9znQfOdKG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0896

We want to support multiple formats so saving one "current_fmt" doesn't
work. This was only used to set the ISP_REG_STRIDE so use the sd_state
directly for that and delete the ->current_fmt pointer. No functional
change.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/starfive/camss/stf-isp-hw-ops.c     | 10 ++++---
 .../staging/media/starfive/camss/stf-isp.c    | 26 +++++++++++++++----
 .../staging/media/starfive/camss/stf-isp.h    |  3 ++-
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index 84716c809ab1..44ac472d9dc3 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -387,7 +387,6 @@ void stf_isp_init_cfg(struct stf_isp_dev *isp_dev)
 static void stf_isp_config_crop(struct stfcamss *stfcamss,
 				struct v4l2_rect *crop)
 {
-	u32 bpp = stfcamss->isp_dev.current_fmt->bpp;
 	u32 val;
 
 	val = VSTART_CAP(crop->top) | HSTART_CAP(crop->left);
@@ -399,9 +398,14 @@ static void stf_isp_config_crop(struct stfcamss *stfcamss,
 
 	val = H_ACT_CAP(crop->height) | W_ACT_CAP(crop->width);
 	stf_isp_reg_write(stfcamss, ISP_REG_PIPELINE_XY_SIZE, val);
+}
+
+void stf_isp_config_yuv_out_stride(struct stf_isp_dev *isp_dev,
+				   u32 width, u8 bpp)
+{
+	u32 val = ALIGN(width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_8);
 
-	val = ALIGN(crop->width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_8);
-	stf_isp_reg_write(stfcamss, ISP_REG_STRIDE, val);
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_STRIDE, val);
 }
 
 static void stf_isp_config_raw_fmt(struct stfcamss *stfcamss, u32 mcode)
diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index 0cbd23069ac6..d961e06d9f7a 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -53,6 +53,19 @@ stf_g_fmt_by_mcode(const struct stf_isp_format_table *fmt_table, u32 mcode)
 	return NULL;
 }
 
+static int stf_isp_g_index_by_mcode(const struct stf_isp_format_table *fmt_table,
+				    u32 mcode)
+{
+	int i;
+
+	for (i = 0; i < fmt_table->nfmts; i++) {
+		if (fmt_table->fmts[i].code == mcode)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 int stf_isp_init(struct stfcamss *stfcamss)
 {
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
@@ -60,7 +73,6 @@ int stf_isp_init(struct stfcamss *stfcamss)
 	isp_dev->stfcamss = stfcamss;
 	isp_dev->formats = isp_formats_st7110;
 	isp_dev->nformats = ARRAY_SIZE(isp_formats_st7110);
-	isp_dev->current_fmt = &isp_formats_source[0];
 
 	return 0;
 }
@@ -68,15 +80,22 @@ int stf_isp_init(struct stfcamss *stfcamss)
 void stf_isp_stream_on(struct stf_isp_dev *isp_dev,
 		       struct v4l2_subdev_state *sd_state)
 {
-	struct v4l2_mbus_framefmt *fmt;
+	const struct stf_isp_format_table *fmt_t_src;
+	struct v4l2_mbus_framefmt *fmt, *fmt_src;
 	struct v4l2_rect *crop;
+	int src;
 
+	fmt_t_src = &isp_dev->formats[STF_ISP_PAD_SRC];
 	fmt = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SINK);
+	fmt_src = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC);
 	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SRC);
+	src = stf_isp_g_index_by_mcode(fmt_t_src, fmt_src->code);
 
 	stf_isp_reset(isp_dev);
 	stf_isp_init_cfg(isp_dev);
 	stf_isp_settings(isp_dev, crop, fmt->code);
+	stf_isp_config_yuv_out_stride(isp_dev, crop->width,
+				      fmt_t_src->fmts[src].bpp);
 	stf_isp_stream_set(isp_dev);
 }
 
@@ -181,9 +200,6 @@ static int isp_set_format(struct v4l2_subdev *sd,
 	if (fmt->pad == STF_ISP_PAD_SRC_SCD || fmt->pad == STF_ISP_PAD_SINK_PARAMS)
 		return 0;
 
-	isp_dev->current_fmt = stf_g_fmt_by_mcode(&isp_dev->formats[fmt->pad],
-						  fmt->format.code);
-
 	/* Propagate to in crop */
 	if (fmt->pad == STF_ISP_PAD_SINK) {
 		struct v4l2_subdev_selection sel = { 0 };
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index cad202d9ce6d..3eade22c669e 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -574,7 +574,6 @@ struct stf_isp_dev {
 	const struct stf_isp_format_table *formats;
 	unsigned int nformats;
 	struct v4l2_subdev *source_subdev;
-	const struct stf_isp_format *current_fmt;
 };
 
 int stf_isp_reset(struct stf_isp_dev *isp_dev);
@@ -584,6 +583,8 @@ void stf_isp_settings(struct stf_isp_dev *isp_dev,
 void stf_isp_stream_set(struct stf_isp_dev *isp_dev);
 void stf_isp_stream_on(struct stf_isp_dev *isp_dev,
 		       struct v4l2_subdev_state *sd_state);
+void stf_isp_config_yuv_out_stride(struct stf_isp_dev *isp_dev,
+				   u32 width, u8 bpp);
 int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
-- 
2.25.1


