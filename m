Return-Path: <linux-kernel+bounces-138221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C1F89EE3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC211C21E93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A11591F9;
	Wed, 10 Apr 2024 09:10:54 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D2156C78;
	Wed, 10 Apr 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740253; cv=fail; b=ADGWLZFCVPWdVSsGzlOtSHjPkH6i9aR1HiAY5Dc4EyTZYsvcOSmTAngIZ2PxsdJqh06ScVNX5KoL7QmpPMZNe2EMEnGRxVMmRHdSM97HfGMe6z2x2zUfdCzSBlS7MNMO3KjjulJOPKk8Cb0vxNyJXxDjL7PYG7l0ND7C8HaDGA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740253; c=relaxed/simple;
	bh=oWFKPBnibXbYMJQ17p/qCuiV0qxFSHAeic8KwJUShWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhYMdcr7PYJfkK5ZsZMywfXUUZBqk8NW/elWcDojHqY+98/6tbW/NSYqP64XFLtxMn1qhpHv30aVAxkxgEgDDDowiifVDNi0YsFi7EcVmMZM5cKqyulol4CNHupICciFQGKYjRplT+Tqm0hCwv0lYc18Pd0/yIk/FTbySgP9krs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCH1g1+sjVa2QCIdiHzIfquy/8CmyT7N7/z8ax8pF9srmyyeg6Utrli3yGjesF157oRuR7bQr5Ur4micKe3fKdzfH2obqr1e3SyVliaZFXI6+K7bfnuYSglk+h7dwOCEE70gYyY+1oblPnmbJCYrjfgIBSZv1LADYsxwGb4rXbedechYPw8TRISH6bsy8TKGZ1PFROONiZoO81bjAajmWaCp6S5IwsyU+Er43HcEpOnjmpLLaUJz1djrk9jh0PCphsafYx5dYpXlamQLCVAZ0xFfGERQE391TINh5Wak1aB1j33choPnQvlNmwD69v7zLQfFPX4pewmRawyhYSwVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIX/xDnAOtDSR7YZlid5lJ6qFBNjV70uM6rm5EcVJws=;
 b=bIyAtTWtl9Oo9aTV7KC2cPzOAHO0b1noKQyGJJl04SzZN6eCN4JtV8LLPmUbx+2eYkCQ9zhsTMin04u1TNRUmfHcaojRqh7bVQvXhNGcitiFPOMCsCbR2J/+CtxlbuUbegJtbW2tA9Kz/X2bF7ieOBcPqPsW/vxB082YZNWc1qRc7vdgaq798p4Sb3WTImVO9tV4402z6VqBRSfFPx3zjOva9GHh2AePWFxPdzInBoPoAfFqox1oF8kRZCMV0t0FoWdqrA3lQnFbGR5s7Ex0WTLCGr+zn1s0m14Li99K6AOa28Jrrh84YpHn5stqsy46gpK2EpTjlpP5ogCiK96rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0461.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:40 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:40 +0000
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
Subject: [PATCH v2 6/8] staging: media: starfive: Fix bayer output stride configuration
Date: Wed, 10 Apr 2024 02:10:24 -0700
Message-Id: <20240410091026.50272-7-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e8731dc-4c72-4a9a-c1ca-08dc593e1817
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lFlAEkpHbf7D+7XLSH6uA7e1lfbJySfzuiJqiP8fkw4nBw8N+01aWPbzuv3fOE90JX0Bj62oL9yCi5XRl2lBbZ9SY6UwZjBCWWyeRCQZpayfZZcay5DDP0kOEHIVMq5KWpQy8hHKTLe2G1rNvIjURpexX/DbMfrAdOpk8IWrMIKr6mUMDCgk/bs4E99avau4xEQxMyHgF1QO3a+V6BpoFSpRRGo80ZFy70/ov4p7OPV42HU/bwNNZTX9rGO20DiSVnzSrRgwoHp+mSWgxA/otJYVSx+EV1aVH8ExO/icxBjxSgebGFWEFkqI1lXTuWkzg8GktQLXAmphqlCZx9GEe93qDYqQ87lblWZtU8V1qFcvFCpCd4w0fOSiA9dVu9XT/Ax6Y/zEI5NGFxVuOY3XORupIc+5X9wwRWGP3TWoYaQ23HzFhoKttIv4fnaqK+21QtEadKmG8jueAg3keFM7DY0/kocxg6vZv/TCzdYMpn/sMDEzWz+a7/+OVyKyUJ2fs5WRv+OcTjFAWMCHogbSlq6aPqsoim9w15SZpKy7lSyygBahLtgtko8Ovvx/hyxhPjq3d3ft8F+hHY7kovT8p4TR//gWLWy5Ei3+6ZVaQPhu7lmPxfJAfpsVLM9lsNQq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zBIajwX2WHC1sNl8AiRUPDKG/WThXg8HiaYGK7aHxxXv9RSUY4/ngTCHoOaF?=
 =?us-ascii?Q?AFIbiRbQmd53+nnuYy9d7tHCYbfJthgg79iNn1esqT52vxYG3b6vqleHSACg?=
 =?us-ascii?Q?T7/uNJZ16DeIFiLQGRlzhxKauhjGbIHpreaOEcXm+OsQvwBHDiFujb0YswyB?=
 =?us-ascii?Q?T/hhiRhQ7A+lm1YtJ6bgLzoTWiPtoAF2fdEKJC6hflHok7XzxJ5hmOhgoIbQ?=
 =?us-ascii?Q?0CHzweGhAmIkCrwYoVoJcPkyybt3P2dI3WZGP5IyF6SvITFdRmGQHH8NVeA5?=
 =?us-ascii?Q?SDqdP4wp7GG9OEHFYjG3wyQpTJ371U5uH9Jo5zZrkvqCZ52gy7zrCuLHExPq?=
 =?us-ascii?Q?yjxXVWkFS/SHxQJbqgsNV7eaYbB5wSmOX58TOonv10Zt6L8W2w4UGtr3I9qJ?=
 =?us-ascii?Q?Txw21W4NtIk5TJrNz0GuWCRrv2w8yr7l+W8JzvlDaXHQlhSUf/iOBPigulDx?=
 =?us-ascii?Q?4hGjWb9ozq42lhEHbi3vAxlrbP+DVrV3D04PwWN8xSEPZ6e1Mx8+HOKEmdnc?=
 =?us-ascii?Q?QzRLMfcHcJ3CZaMzso/VDc7OLCLudEWtC/w/D1Rk+9tGgRkYvD7k4qGG7gYy?=
 =?us-ascii?Q?GnWMopAGnvwGlpkKLiyJyRkLibWoiFpK9kCV78PngicYfTloNmFjSgDL8cn/?=
 =?us-ascii?Q?+B1a0j9WIoXPwmIRvgpPCvj3DCw3kApDoQ0l4Lp10db115nrgk7q/sIL5UKx?=
 =?us-ascii?Q?xwKY9ci+8Tx4efos7449dy9SJ3hpRZm6v001EaMSnxWZdJXrn6043r5et+d8?=
 =?us-ascii?Q?I+QgJbZI026aalSXuoDO5SniaKfhqlBy4wlztnZNCWcdUslGhqTEBLAh9CzO?=
 =?us-ascii?Q?OvyHuqL4qyDSHmXvI0SSU6IAzlFSLpRGHgCI/hv4m+7fXFKsojCm33nZIBJu?=
 =?us-ascii?Q?MIsZ7I3Av72uOHr/GJLNNw7ACScCuaiI/Hj957eZS3ORKAe46xIX45sVZOeJ?=
 =?us-ascii?Q?L6inmqOAZUYc7vLtdHICzd/bFiNxno12r9+rD+imBqwSdthGDvmS9Igreq5h?=
 =?us-ascii?Q?GvckUOpTG7oAEL2/e+DGBf7b4W//fB5uwmoigMfGldDK+g1E5LGdWa5n5hMQ?=
 =?us-ascii?Q?Eb3Dnoy2w//BT1WneOT0sSKz6HnFKfslMhWd8nnWRzeTK56DIHXiNVnJvGk6?=
 =?us-ascii?Q?WNw0uyx8Nwigj18n3tR+ZEIDYZ5IqwbihMMIoaK+1tpGPgdo6l/wKeMDz5kd?=
 =?us-ascii?Q?hxPK+6bGhYcoucpHn9kPDjGY32wFgiJlsEdVvHNc1VbI2n/+Y0KQM//QR72A?=
 =?us-ascii?Q?8SbTPnD19f6F4Jc9l4HqrdpUF5a05tnUtxI5J0i/94ZdVncYPJ5cf2pnGLCE?=
 =?us-ascii?Q?sbNIa878TpfnzgeRtcmTCVXN4+8nfDFRVs/3v81yxkxojnCCq+L+oqlxfUkZ?=
 =?us-ascii?Q?ABzc3mcXPmY1CLT4wBWbAuUOeDtEde84yN53QdpL6lkMlew86iw6vS0pBnlC?=
 =?us-ascii?Q?Mh8AAEC8YfDOgRQf9lc1cMiw4c65YXX/Dwnnf1lB4SFMMwzyww8ANU1pfYe8?=
 =?us-ascii?Q?RYb5uG8oNZggRtNsuZxeJo1HvS89i/dHX1DnazWAsI2du/hwpfBf+4YoygHW?=
 =?us-ascii?Q?e00kz8OnpgBacfVRdyzTxng0xbvYPglJTQ33GDNM3NGRpF4pQ0hfhyTXulA1?=
 =?us-ascii?Q?wUbGH5Lir51V3C4DGrFHeYU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8731dc-4c72-4a9a-c1ca-08dc593e1817
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:40.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9ZT4pZVnZhhWn8/9NyK8M96NIm7VgOY8AIUnK6OryDkZUzw3UxPn+CJckKvEYt73XGDwOqRAkCpMVf8/zeuN2GAmpiyZHBoVTvgXo9ra76+6GWUFK1iJc63WaaP6krI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0461

Add the bayer output stride configuration. And convert set the stride
be a helper function. Improve readability.

Fixes: e57854628f58 ("media: staging: media: starfive: camss: Add ISP driver")

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp-hw-ops.c   | 13 +++++++++----
 drivers/staging/media/starfive/camss/stf-isp.c      | 12 +++++++++---
 drivers/staging/media/starfive/camss/stf-isp.h      |  4 ++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index f170fab2bfb4..c990dc124f77 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -408,6 +408,15 @@ void stf_isp_config_yuv_out_stride(struct stf_isp_dev *isp_dev,
 	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_STRIDE, val);
 }
 
+void stf_isp_config_bayer_out_stride(struct stf_isp_dev *isp_dev,
+				     u32 width, u8 bpp)
+{
+	u32 val = ALIGN(width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_128);
+
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DUMP_CFG_1,
+			  DUMP_BURST_LEN(3) | val);
+}
+
 static void stf_isp_config_raw_fmt(struct stfcamss *stfcamss, u32 mcode)
 {
 	u32 val, val1;
@@ -459,10 +468,6 @@ void stf_isp_settings(struct stf_isp_dev *isp_dev,
 	stf_isp_config_crop(stfcamss, crop);
 	stf_isp_config_raw_fmt(stfcamss, mcode);
 
-	stf_isp_reg_set_bit(stfcamss, ISP_REG_DUMP_CFG_1,
-			    DUMP_BURST_LEN_MASK | DUMP_SD_MASK,
-			    DUMP_BURST_LEN(3));
-
 	stf_isp_reg_write(stfcamss, ISP_REG_ITIIWSR,
 			  ITI_HSIZE(IMAGE_MAX_HEIGH) |
 			  ITI_WSIZE(IMAGE_MAX_WIDTH));
diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index fb48e7a29e8c..ef07639bf4d1 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -88,22 +88,28 @@ int stf_isp_init(struct stfcamss *stfcamss)
 void stf_isp_stream_on(struct stf_isp_dev *isp_dev,
 		       struct v4l2_subdev_state *sd_state)
 {
-	const struct stf_isp_format_table *fmt_t_src;
-	struct v4l2_mbus_framefmt *fmt, *fmt_src;
+	const struct stf_isp_format_table *fmt_t_src, *fmt_t_bayer;
+	struct v4l2_mbus_framefmt *fmt, *fmt_src, *fmt_bayer;
 	struct v4l2_rect *crop;
-	int src;
+	int src, bayer;
 
 	fmt_t_src = &isp_dev->formats[STF_ISP_PAD_SRC];
+	fmt_t_bayer = &isp_dev->formats[STF_ISP_PAD_SRC_BAYER];
 	fmt = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SINK);
 	fmt_src = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC);
+	fmt_bayer = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC_BAYER);
 	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SINK);
 	src = stf_isp_g_index_by_mcode(fmt_t_src, fmt_src->code);
+	bayer = stf_isp_g_index_by_mcode(fmt_t_bayer, fmt_bayer->code);
 
 	stf_isp_reset(isp_dev);
 	stf_isp_init_cfg(isp_dev);
 	stf_isp_settings(isp_dev, crop, fmt->code);
 	stf_isp_config_yuv_out_stride(isp_dev, crop->width,
 				      fmt_t_src->fmts[src].bpp);
+	stf_isp_config_bayer_out_stride(isp_dev, crop->width,
+					fmt_t_bayer->fmts[bayer].bpp);
+
 	stf_isp_stream_set(isp_dev);
 }
 
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 8505603bdbc5..546c79332e9a 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -77,8 +77,6 @@
 #define DUMP_SHT(n)				((n) << 20)
 #define DUMP_BURST_LEN(n)			((n) << 16)
 #define DUMP_SD(n)				((n) << 0)
-#define DUMP_BURST_LEN_MASK			GENMASK(17, 16)
-#define DUMP_SD_MASK				GENMASK(15, 0)
 
 #define ISP_REG_DEC_CFG				0x030
 #define DEC_V_KEEP(n)				((n) << 24)
@@ -586,6 +584,8 @@ void stf_isp_stream_on(struct stf_isp_dev *isp_dev,
 		       struct v4l2_subdev_state *sd_state);
 void stf_isp_config_yuv_out_stride(struct stf_isp_dev *isp_dev,
 				   u32 width, u8 bpp);
+void stf_isp_config_bayer_out_stride(struct stf_isp_dev *isp_dev,
+				     u32 width, u8 bpp);
 int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
-- 
2.25.1


