Return-Path: <linux-kernel+bounces-93631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40B873295
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2031C21423
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C425DF2C;
	Wed,  6 Mar 2024 09:34:00 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572D328A0;
	Wed,  6 Mar 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717639; cv=fail; b=kC6ZfHy0uwIt69ZhRJuNASU5yzOMFjQbfuib+DqXhpCKOnPbh6+yQCsvVtxz/VOpgzklufymlBuvqv2fHrP6eRQ5Wl4UpSooLiQBu7aHXHNS0gJ6hkbp4ub1yWJweWJpQhj0OfYN7xKeNoPJ3Gmi3DN8qz4vIgQOYnJu/NGBvto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717639; c=relaxed/simple;
	bh=tOALpcc4YM8n/3py9YC53u/17iNhVUItYA+c3zRKdmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSATFv+TycNaBXfn0d+Zfaqny23XeZhXi+J1vD8oK7VYVQ1TSTYNkA1IyKdHL9tekjeerzarLhoux+z9PoLmtc1d7q4gOd0HBp4AXLnWrWJwDRfKHB/QmisBXg4HC0kPZ3IkAwXso6GrjcnifNz+vm6EPSevMR2b0ucdu2xf2/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIypIJqyHvuQfeIur6JUOMW5275WiRi5STtH/mBlgJC+mwLeVBmAQ3n5neNqi93tVPQH1GDp20Z7v1q6ghqo9spsyxikPwJm438vov+eK/+AOxxB6WMB/gTTa9ZN8zQeTvZWO0XWxuMnBwNtxqI3JsbWPVPx8Ws+xa60C2hZdNw4xH3Q3s5un8NBf1zFKgck8LhtyxWNqHENsdJir7P4Z8sSQ7uWuHQQVn7yHCOi25dBKQhfF2pia6bQnMn/tJu0L8SQBpuCMSlnk98dO+/IT/rhrkotEVlGKdpcJWVV5qsMORJOPNeEk+1DIf4ccfjlzRNMJ6ykran+QUfNY3VnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zYNQNZAC6tzfZZNanbbt2SZhYlFf0Mq2X72yc6nS5Y=;
 b=oMVxuUweIl+CMYsL//v28i8qEYTvGdhjG136LGF4W4BHt/lqHCD3/f2jIWWADHYWyLdboRP5Xm9NRrgY9czQ9TatDrgSJ9ah3AVK/d/qsqOeUzu0uAMRVaZsM5ApvM16TqIF0iZX5sAFEqVs+hzS3k2fNhZCjzTO/xrHzPnWpzURPqMK5ls+7ghRGlWbp1Iml9z1wlgDDnxNf777bg4QxychiRirl5NkYkxBmtgGV/gHj4PHW6rrVvECNy01vSxLFuCtnxagWtHxuywhkW9CxCF5GCTnDzQAMH6BR5lK9Vbir4G152/vFF50QJ6t8nqeWtcGNkbrw/4fxGD/dBFlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:43 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:43 +0000
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
Subject: [PATCH v1 1/7] staging: media: starfive: Replaced current_fmt with get from sd_state
Date: Wed,  6 Mar 2024 01:33:28 -0800
Message-Id: <20240306093334.9321-2-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d83a1810-153a-4557-2430-08dc3dc083d5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Dwx1GrF8AFWVHNEtedA+EYpZM9KYsTqZhjKZaPZnxBl2ycA3j1N+YtGHil/YODhh0InQrXtRUVcTYT/L0/FLb6LEMWZt0owLlQWYoclFS/8mv5Isxwrb6erREl05O9VTUXuTXCwNErVwZiiMKxHX1QJbIflfBX1WykSdeNnOyb3r7Hk6wQkrvjQZbBtPI43PnNUrIchCe4El48qooWvS1AZJtffZ1RtctBfG8Cz2EGJ2uPmsQAtIBjlqgVGlf5d6PoaF9hH64DYbOZBu6lN4g6n52sohUUrQ0BkivCxk9lUG41PCns+SgubfaFvmF8SYSLH6ZTGRjFDTTzlfpZ2CQFlC+LE9HDQhpoZRL3e1RScFlPiN9ejYQFFdHIug30wBW8YqTcQdSNiXg3gxb0AjVGcjfWJGMaBtqfxbRqnbkFGJxEg0bjYeazXyrFMf8RSxZOlLVrawVMbsyVtg3viyz3oOA2yiKS+XgQXBuWAT2Po8fkhRq4aY+Zb7oxYrCD2NJx+fAGd4yjWsc+8W7XnZ6Rmi98LtJQbpJ5fBjsEfDE3/6jVnGHnC797mm6xQAQpyQ8J3WPpTfd1N3Vw1avk24X2dzxtcoVrMc7UCNHs8vV5okmU2Uy4FjIuAIMI6428
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WpCA37aLR4SJcS3gCCw3621wTDsVVFpSwt/UQX1kWlvIooNWMOWrVSTCpZN5?=
 =?us-ascii?Q?CZDIHZVqGR70B+CyTYq3D49XVcvZy0oTlriDw/CsnrbCD/fp2cPovWUMPDzQ?=
 =?us-ascii?Q?vR9z8ZYbzXtN/X1hNXD65ltSVhYcBXhWfJKsEWLXun5T1UlvmvyyniZ1HJBC?=
 =?us-ascii?Q?gCel6G3ihmB1cGOzP/AHVx+ukwiTMGVnqz8+ip5G3hB5jdUKvTt4RApKwqje?=
 =?us-ascii?Q?RZqhv7r/ZywWm5BGmub5dIZU+VjmyNMyRhM+pCDnHrOU0QqdnOYEK+RhEF7h?=
 =?us-ascii?Q?IlnHqWocaesJW/Win+yabANvZdZB21BWsGAgDJrExX6rOnLgDHS+f/YwCUn3?=
 =?us-ascii?Q?LKCuzhi2uGEvXzvzO8CUOHLuWVMaWMxN96cdDPOURQnllLIm7bLjDKnoGu6s?=
 =?us-ascii?Q?99sDZ8CvzqIIOQb2g2boSFtUh+9Upe8vAVEFVCqefBnK6vxMW3Pqgn53rlSI?=
 =?us-ascii?Q?yiTOVgeXWz1FuzunIYtD935BqL2MTA1ZLy+66FywShDd0wG+bVdfEt4d8kXp?=
 =?us-ascii?Q?qAUzV+Sfsm6E8/6RwrJQMSu7FuEJE7r4ATqCSlyUgclWMZc9NBdb4Cphtkmv?=
 =?us-ascii?Q?5AAnOHKXdo5bRHL4ifYp9F52EE/kYKFsgfM+k5CVNWCxWySGQeohJXjGVuUN?=
 =?us-ascii?Q?tOPWLZt+kqRsSuQ3GXcGSw9k3smv1RJoHMkX9fCLUWs5tjxCpe6u8qq7sHFy?=
 =?us-ascii?Q?QtZYLwfi5O0hxYFRa2HXaQ9Jeqt4eSrV9LiDaAn12rGz8+twzeuFeKNI2czo?=
 =?us-ascii?Q?k0XzRKFpv9bJKzXjTbbWwk3DhBZbGlDdcAVA4iatoGZO+u214eRyFlHojmSd?=
 =?us-ascii?Q?hW8UWfSlkw7lCnz66sEDjc8OLka9BiNu/mwHwmHz3Y0g4heD/ptMs/mbKX8a?=
 =?us-ascii?Q?4Ow8Zx+omkX6VJJKxe+uyRJ+axTsGyIYQElR4coCbrss/HoGdmVcnIxqzo4Z?=
 =?us-ascii?Q?RRPgDRudGI2XnUmrUns/NixNlEGHvFjllXzwcrfKongHJY3w8iDR8/cW2P76?=
 =?us-ascii?Q?OlHeraLdyTZUuPwD0TpoXSeX3WrBCjOTvcL7+9PHF26FvqxqicBM9z1OYs3B?=
 =?us-ascii?Q?Fo93lH+OTn2dVr0gjah3uBlSMn4uNkIqDDjbeNeH+jSMJ9+owRNMQ3kanWJm?=
 =?us-ascii?Q?jg9KG4veI7GrFCdLmNzK9TFEdAqv96eSs7XReNbJuH6xDhY5gVJN7owM/dxc?=
 =?us-ascii?Q?pKwXX1nNF8pqSWxQumMWY0Qrbk5x6+dKgVSI8Q9Mou2BeOmxIpSktf1DHARX?=
 =?us-ascii?Q?PmYDvU+gtIeGIPTllgUsffViRwf8xtCXEGCz9Hr49BeFfyrM96UWHv1acwZe?=
 =?us-ascii?Q?w+ZY3SYDg3fmS2/XqawUh7FUbyZeVEh3pKAUmzvM4AIq9fvwY96t6tDzVN0o?=
 =?us-ascii?Q?H7SbcxkerM1My1dAO2sfamwhqFD+CFQZkAG0drP/sMUz7zErQ4wzr5zDqUKo?=
 =?us-ascii?Q?mhiy+jP5xiTY5+BSo0bYFIJab5Kf2u0W9/GsUPiQxIZJWBi/8qAf0+5d0iqx?=
 =?us-ascii?Q?6VTb0ctNP+6pseMiaER/jJG6Cw4KkdmBPdpS8PTRi1MG2aED1UQbXpaeMnoV?=
 =?us-ascii?Q?DVViS4EdYlGcRiiVqydOJbpvArTATUktQ4E2i9aJDCuXR71bJ9MF+QPe8FLt?=
 =?us-ascii?Q?4ljmrVTImYz9oCY5vfx+lLw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83a1810-153a-4557-2430-08dc3dc083d5
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:43.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWxkYRlVgK6NiSsrEETSXfNnkk68l3jAayNrHMNqQn/3oNDrKtetl3BmDvlRu7OrlrIOz6kH8oguqrToa76Fvv1Gx33zZUVZhD1M58ApyxxAHzzeo3s3K21jSeRonKH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

current_fmt only can store one pad format, when setting other pad it
will be overwrote. Replaced it with get from sd_state directly.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/starfive/camss/stf-isp-hw-ops.c     | 10 ++++---
 .../staging/media/starfive/camss/stf-isp.c    | 26 +++++++++++++++----
 .../staging/media/starfive/camss/stf-isp.h    |  3 ++-
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index c34631ff9422..b933d425cbd0 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -345,7 +345,6 @@ void stf_isp_init_cfg(struct stf_isp_dev *isp_dev)
 static void stf_isp_config_crop(struct stfcamss *stfcamss,
 				struct v4l2_rect *crop)
 {
-	u32 bpp = stfcamss->isp_dev.current_fmt->bpp;
 	u32 val;
 
 	val = VSTART_CAP(crop->top) | HSTART_CAP(crop->left);
@@ -357,9 +356,14 @@ static void stf_isp_config_crop(struct stfcamss *stfcamss,
 
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
index d50616ef351e..a5573abe0d7b 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -46,6 +46,19 @@ stf_g_fmt_by_mcode(const struct stf_isp_format_table *fmt_table, u32 mcode)
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
@@ -53,7 +66,6 @@ int stf_isp_init(struct stfcamss *stfcamss)
 	isp_dev->stfcamss = stfcamss;
 	isp_dev->formats = isp_formats_st7110;
 	isp_dev->nformats = ARRAY_SIZE(isp_formats_st7110);
-	isp_dev->current_fmt = &isp_formats_source[0];
 
 	return 0;
 }
@@ -61,18 +73,25 @@ int stf_isp_init(struct stfcamss *stfcamss)
 static int isp_set_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	const struct stf_isp_format_table *fmt_t_src;
+	struct v4l2_mbus_framefmt *fmt, *fmt_src;
 	struct v4l2_subdev_state *sd_state;
-	struct v4l2_mbus_framefmt *fmt;
 	struct v4l2_rect *crop;
+	int src;
 
 	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
+	fmt_t_src = &isp_dev->formats[STF_ISP_PAD_SRC];
 	fmt = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SINK);
+	fmt_src = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC);
 	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SRC);
+	src = stf_isp_g_index_by_mcode(fmt_t_src, fmt_src->code);
 
 	if (enable) {
 		stf_isp_reset(isp_dev);
 		stf_isp_init_cfg(isp_dev);
 		stf_isp_settings(isp_dev, crop, fmt->code);
+		stf_isp_config_yuv_out_stride(isp_dev, crop->width,
+					      fmt_t_src->fmts[src].bpp);
 		stf_isp_stream_set(isp_dev);
 	}
 
@@ -157,9 +176,6 @@ static int isp_set_format(struct v4l2_subdev *sd,
 	isp_try_format(isp_dev, state, fmt->pad, &fmt->format);
 	*format = fmt->format;
 
-	isp_dev->current_fmt = stf_g_fmt_by_mcode(&isp_dev->formats[fmt->pad],
-						  fmt->format.code);
-
 	/* Propagate to in crop */
 	if (fmt->pad == STF_ISP_PAD_SINK) {
 		struct v4l2_subdev_selection sel = { 0 };
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 955cbb048363..07d6c2758253 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -413,7 +413,6 @@ struct stf_isp_dev {
 	const struct stf_isp_format_table *formats;
 	unsigned int nformats;
 	struct v4l2_subdev *source_subdev;
-	const struct stf_isp_format *current_fmt;
 };
 
 int stf_isp_reset(struct stf_isp_dev *isp_dev);
@@ -421,6 +420,8 @@ void stf_isp_init_cfg(struct stf_isp_dev *isp_dev);
 void stf_isp_settings(struct stf_isp_dev *isp_dev,
 		      struct v4l2_rect *crop, u32 mcode);
 void stf_isp_stream_set(struct stf_isp_dev *isp_dev);
+void stf_isp_config_yuv_out_stride(struct stf_isp_dev *isp_dev,
+				   u32 width, u8 bpp);
 int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
-- 
2.25.1


