Return-Path: <linux-kernel+bounces-138220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2B89EE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FCB1F239E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A7315531C;
	Wed, 10 Apr 2024 09:10:53 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A529155A21;
	Wed, 10 Apr 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740252; cv=fail; b=DuSn2aq1yhnqdE1iss6wbhAVX/PeMi+pCu8VGNCe1OrMz4vFatM53hh3UX8RhnGnoPdRYkILrZd0WbS3/KO0vWsWplRKBsbVo3QuQDag1lm3ufaaBhPFILiZaCbRTA4mBQLac6A+Ms6+2GSHKwu6+F67lI3MDvW07oVAcrtch9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740252; c=relaxed/simple;
	bh=u3jNxEuaz46SNF6p48mEc6rsp6RXql7AqFodWTSDQDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETU05MOfg1mEINMeKB0HklSPjb0SDc23uxi7WCHe/9+SgGZ2phe3MXCYvGbIw3aVm7dzNWGB2LA4XDRNC+RCTPSng9r69iXMdc6ifhnfNl81r5MFNm5MxG8CNsPcH9+pm+cctRZpEsH18Hhom4G9lkpbUgoS8oKzDl9AYhoZZlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbrb7lpE3o9B3jE0Dh1/B84xxnC/l1MrkO5m466aqSaCxPstzVset6tW2VQqop5+pxXgQ+O0z4CWDDL3q9iGAvMtWLV7ztetWR8yeWfHBjxCSzURCJBuNQZxKrWGgiQlDrlXsvLRYjCHXSsK0A4TSFcuBletOuY8JeUxjk70gmIYpv0IEU8Hpo4qaTyw5eeaebhMzT6F+AZgfOa9iRL03rNfrp7BcFMk0ZkzibR28obdTS73JnGpBq/zzRq13OD+zb+8DcEo7Xw639gJdYyhYYpDBEEQLbktlc9aQK6QsgkeRcjGogvfNKKv8BpzmNZ1UY8qicTpazaDYPkX5xLm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lha8EdwMlIkAnTA0bgsSPh1gSFQZdpXXx2W7oiC70kg=;
 b=PpKzTCxS9MwIaXlq5+RRQ+NHSvetwKG9f3ujc96YfUbJQM4tW/YJhekOpujHJfY4kJZ36zW6Y5W0Zr2WEJSHK0fe/fexunnZWKmkpDA2nrDPIkfo0FYjRApoI1XNObCCBOyKEE5tX2j7SmY5ZpBKc5+ywvFSfqOJxkjvZj1EPjdRpguHvvYvbzg7b5h/1zzcDJJNh94iUjQVxgf8eVgFD9DabWP/U1lMbBRE7CjOQaMKNtv0tBxBWdtlAPTJDHB4pf+tKcuRPGnQdPthQYlJDyN5mb+W9hYKOhmdc0ASXty4aR7kigd4ZlLMBMfaoPtRPK9xVk1G9dvQaJ4zi+E5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0896.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:36 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:36 +0000
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
Subject: [PATCH v2 2/8] staging: media: starfive: Add bayer pad for ISP
Date: Wed, 10 Apr 2024 02:10:20 -0700
Message-Id: <20240410091026.50272-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f191cd38-1f12-4cd0-72d0-08dc593e1557
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V/yILe0shyKKu1GTuPTxLgn6E3prSqKsYtAAPoHzSrb5PNhrrREdDqCt32cO8UtiweEOpUxtWSwoHWtaFfX+sjNiVF969ni/IbR2fa2MbRBpt0uNxwH1c1EaZP+nXT4fO9oKm0xgPQGwiZvx/WJFFuPp8/55T6ht3GakknCArmkJQQqq12LX6yPLCV5UJucWpUdjfPcAWfbsYt6Iaw3SPTDrOyV7/Ee6t9+omWVfpIEvhL1Z06xEs/bgpKKGvvfS3r82G6pqnLT5vmcEZoHHqKpagmNcaXtKx4ssZiEFrbpVrRb0ejsSm9HHC7BUCRPBORPo3mPE1X3EwTV/YSRs5WOv4cdhW+uzQW7s36OyRBlCTmYPRKzanwR6rHO+O7UAmlMmSwbqOHZFEew/asa8ZVmvZ4YP+ShGN2fHGphD+cml60dlAULhnSZeeZqcGoTt5fuxLyBASkbDNVDxJt4/IF+XTFley8IscPxVyZOou22yjPkM/bwb+OCPRbXSyOThsPkJx+O7Rd2l+UXYwzuIZjo99xvHKkQfl5sCg9DJ0WqsyTLPumo+qv65y9DWKXxCTRn4MJsJAZCt8Dwo4KuYcO8RnZtQe2k2KMsckwjE5bb9AmOborjh0gdGEOSHYK8/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJXWySZ6Bx7Lmpgz9SVGst2MOvKheoc1bQYpAeD6NvKpP8f2eW/9GK0ssG35?=
 =?us-ascii?Q?r2A0ZrQoE3roSki/flKgmpoCb3/HbNRGAYfRPr02qobz+PuGW45yVvXAT80Z?=
 =?us-ascii?Q?0n/MiR7dPWbBtlH9jXZGDvM+PXC5MnxaQFh8uU0bQiWByPd0n4gp4ijv5IpB?=
 =?us-ascii?Q?/qF4XAgum09XIQvqv31Q2YJg9aJC3GooeChMD13EaKTrBbIb7OA1SKluvFSW?=
 =?us-ascii?Q?hFSS54SLNkTumUKI5e2QXtdPogFPOAqVK39OYQ+pp1xHer7ftDpBFrFVdyyh?=
 =?us-ascii?Q?pRzsVgU6VNDYKkZoXPUigjKlh6TXBqzyXbnjHpJtAwvrOXCbdQ8h41rI/oeV?=
 =?us-ascii?Q?OAaUSgwPU4xWZw1hs8SBQTHfHTHSXcHJFFNpuP9koHnZP2OziJUnl6ZE3LFp?=
 =?us-ascii?Q?/F2EFSY/R6RChGCryIwJzbf0VL9K350mB2A7hda6dfXSqvTVdJqaZ1ldre9s?=
 =?us-ascii?Q?IKA6XQy+iVuKSXgrgmHa+qPUXsxkTsG0oyRSOMWO2LY8h2uAwyMlEp7SPTq2?=
 =?us-ascii?Q?g60nLWF3Xzx2CnJoA5wn1hFsFjHrlMNnhcN8qqSTIBqi/G1i+GzOBqZl2m+k?=
 =?us-ascii?Q?xAYSV1hvtS9+IJ9L7+2B7j6KkJSrsPXhV58NNKowvFa7X1Ow5xMnMIKqZrDI?=
 =?us-ascii?Q?Xb3eKKJ8nBj2lBBPt2YYvWg2+/mA059WlbbnJDgd1NBeuFUNMrIFxhgLuvDD?=
 =?us-ascii?Q?XOKHUaCiF5tbp8QOvt/2pzCm78tCVFTQnI2iJB+3hNDXk62xw9ePdR5K+7R3?=
 =?us-ascii?Q?Jqka9G2Nsr2IO86oPGQNH2mAD/RBmzcCme9n0SL/yeIh5ryG3TZZNnU2bKvl?=
 =?us-ascii?Q?GrNdQ7H4AuTDnp8Nj0R2AhdCFZskV2PDJLsrmF+5sv/YKp2R0KJYjeDESuWp?=
 =?us-ascii?Q?VRMHDbmaA5YWVUiYx1sxrC0Vy0z++/5X79gEHi0krMzq36jSjqNpbocQJlpW?=
 =?us-ascii?Q?8zp2GLxQr1agxC5MjZok6udkcvLEJdEHKQzb8uyFKbvDVyxZuC/qRBv8XQAc?=
 =?us-ascii?Q?XrPDafIiFVivulXRBe7sFDJtZxoF3dNt8bNqxfkWxjIW91uwMWjh7QhCHkxd?=
 =?us-ascii?Q?4ts1FxDLgY+CNJaQ1+GuL4tF2PEC5UmCf9OGWJptaiCTI2HV0CHycsvr9EjB?=
 =?us-ascii?Q?SRbQZaW3RWMbu0CxISpVp481AON2JddzpHnZYM+Yoe5NQ8sce9GRQEK2rdGE?=
 =?us-ascii?Q?/xLnN5GSZ0iBgcy23ZNGynQxCvhDbjZWUfTuVvPI6dKb1kCj9RvEuD1iR9DH?=
 =?us-ascii?Q?CbUMwnuB65XQOT3csKYlBW1cFYpG1kRYXiXqEIsv4bBkYSEw1e5xil7zGbIa?=
 =?us-ascii?Q?qyc7IDiQ9Z/7rNKPCZihklmalYZyfhschFGhlawjPjETDYZhdW6n2tVKFTPI?=
 =?us-ascii?Q?iWoW51CkYGeTovD5Sht82yNl/GgrUQGCQtxbecWFtVOWZwppX4pxiaO6q64N?=
 =?us-ascii?Q?unLucg0XWgnw/Q4MwDuNvk0TLDpVnbR4R7qaub4bViqya433wg+KxxU8L545?=
 =?us-ascii?Q?DfKZ5t68BMfS1dFGXYRYXaO7n6N3pU7TtGTNEiZ8obNy/O74T/zKTzr3MC/N?=
 =?us-ascii?Q?nNan1rVqK0vxIvCFzxsqjF1L0t1T1L2LzzjBIowCs+SZIWX8Pw8T+HJhwq0Q?=
 =?us-ascii?Q?4WxN0Cil/4ptOJa8Y83L6ws=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f191cd38-1f12-4cd0-72d0-08dc593e1557
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:36.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTNhmcYuFvqPT/u6YYBH1sSvzkwkHrHzHSUlenlEeQEk53Fot/adLfnIKSxakDEwire1ELM0Ga9fwylKPiv+bsXYg/uxEAcTFGTT0XA96r0BS3UA3BEtMlOQ5SwGPU0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0896

Add bayer pad for ISP, it supported the output of the 12 bit per
pixel bayer format. It actually convert the 10 bit per pixel input
bayer format to the 12 bit per pixel format.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-isp.c | 18 +++++++++++++++---
 drivers/staging/media/starfive/camss/stf-isp.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index d961e06d9f7a..53b9cd2b49bd 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -29,6 +29,13 @@ static const struct stf_isp_format isp_formats_source[] = {
 	{ MEDIA_BUS_FMT_YUYV8_1_5X8, 8 },
 };
 
+static const struct stf_isp_format isp_formats_source_bayer[] = {
+	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SGRBG12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SGBRG12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SBGGR12_1X12, 12 },
+};
+
 static const struct stf_isp_format isp_formats_source_scd[] = {
 	{ MEDIA_BUS_FMT_METADATA_FIXED },
 };
@@ -37,6 +44,7 @@ static const struct stf_isp_format_table isp_formats_st7110[] = {
 	{ isp_formats_sink, ARRAY_SIZE(isp_formats_sink) },
 	{ isp_formats_sink_params, ARRAY_SIZE(isp_formats_sink_params) },
 	{ isp_formats_source, ARRAY_SIZE(isp_formats_source) },
+	{ isp_formats_source_bayer, ARRAY_SIZE(isp_formats_source_bayer) },
 	{ isp_formats_source_scd, ARRAY_SIZE(isp_formats_source_scd) },
 };
 
@@ -311,8 +319,11 @@ static int isp_set_selection(struct v4l2_subdev *sd,
 		crop.target = V4L2_SEL_TGT_CROP;
 		crop.r = *rect;
 		isp_set_selection(sd, state, &crop);
+
+		crop.pad = STF_ISP_PAD_SRC_BAYER;
+		isp_set_selection(sd, state, &crop);
 	} else if (sel->target == V4L2_SEL_TGT_CROP &&
-		   sel->pad == STF_ISP_PAD_SRC) {
+		   (sel->pad == STF_ISP_PAD_SRC || sel->pad == STF_ISP_PAD_SRC_BAYER)) {
 		struct v4l2_subdev_format fmt = { 0 };
 
 		rect = v4l2_subdev_state_get_crop(state, sel->pad);
@@ -324,7 +335,7 @@ static int isp_set_selection(struct v4l2_subdev *sd,
 
 		/* Reset source pad format width and height */
 		fmt.which = sel->which;
-		fmt.pad = STF_ISP_PAD_SRC;
+		fmt.pad = sel->pad;
 		fmt.format.width = rect->width;
 		fmt.format.height = rect->height;
 		isp_set_format(sd, state, &fmt);
@@ -368,7 +379,7 @@ static int isp_init_formats(struct v4l2_subdev *sd,
 	};
 	int ret;
 
-	/* Init for STF_ISP_PAD_SINK and STF_ISP_PAD_SRC pad */
+	/* Init for STF_ISP_PAD_SINK, STF_ISP_PAD_SRC and STF_ISP_PAD_SRC_BAYER pad */
 	ret = isp_set_format(sd, sd_state, &format);
 	if (ret < 0)
 		return ret;
@@ -422,6 +433,7 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
 	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	pads[STF_ISP_PAD_SINK_PARAMS].flags = MEDIA_PAD_FL_SINK;
 	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	pads[STF_ISP_PAD_SRC_BAYER].flags = MEDIA_PAD_FL_SOURCE;
 	pads[STF_ISP_PAD_SRC_SCD].flags = MEDIA_PAD_FL_SOURCE;
 
 	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_ISP;
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 3eade22c669e..f63817b7a235 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -529,6 +529,7 @@ enum stf_isp_pad_id {
 	STF_ISP_PAD_SINK = 0,
 	STF_ISP_PAD_SINK_PARAMS,
 	STF_ISP_PAD_SRC,
+	STF_ISP_PAD_SRC_BAYER,
 	STF_ISP_PAD_SRC_SCD,
 	STF_ISP_PAD_MAX
 };
-- 
2.25.1


