Return-Path: <linux-kernel+bounces-83224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF45869076
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC751C21966
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF31448C3;
	Tue, 27 Feb 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b/r4MA7C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EDB54BFC;
	Tue, 27 Feb 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036706; cv=none; b=NeFvO1xBdBaD8dxoJ1s5bABbElxvPwZP1noIDXQpPG3rbLHD0GiLsYV8NZOFcRi+Z77uEoCg2fSww9Ycg1pLc6mZPrpISDxj0tYe3OWGUUVqIPyHyEk7ciD2cvKwyM6BlbKvf7bYbtJ0xht3Q+XxHjADwotbpRK4THlLgj5U8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036706; c=relaxed/simple;
	bh=ENhwF49Tw2Y9G1pmtz10Lk512m3x6tyULz3RLatZkoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQop9PBOn4o1rbFCfEjkpSivJTnRksEQTD0tzp1iz/MM7noeW25ZUEpcCDQfKJ7xKqHyK2IfbF/d2KobBBtz72abeWv1MPXMF/AGN5sU3pG7Cnnfdgtv8/cl6AA7vcyFetsFcHQyYZvsBFCQlV1N+U97YWh2Vg3hSKGyUD1eun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b/r4MA7C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RAaWmY031574;
	Tue, 27 Feb 2024 12:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=dPo6o+zA4h7BIo6aKyZIPsAasEJtnqwE7tcyvP/KnR4=; b=b/
	r4MA7ClJwznKtmCuoq1+xw+g37TOos76hyTp//p7G9GamA4wis95TSMTvr1pDvfx
	xXlVr1Ztz+msW7dxP8SZ5sMp656Tnz0n0VrJOJg/1jfsdLYYuJ9YVGbjACXWcZAO
	0owftkQtN+29q1GIQZUUH2DE3DiUTcLS6qe72QcbG2o8yY18R4kZweGp1B8fmzPi
	cF3TY0cOdmPjHYeTdrOusjIuAnaymlfmZ+/SDIAhi/pNmjr3k3o3rdQ12Ik863ef
	EqfsxmYTJ3l6D1eyr3tkb6A35vBdDYtDwp6coTfo3Qhh5TcaX6QDgNGrkLORI5Bk
	gHyXs4fFTWDjSGYQQXbQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6nrh5fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:24:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RCOvXC012777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:24:57 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 04:24:54 -0800
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH 5/9] media: qcom: camss: Move format related functions
Date: Tue, 27 Feb 2024 14:24:11 +0200
Message-ID: <20240227122415.491-6-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227122415.491-1-quic_grosikop@quicinc.com>
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G30NLSB1NioHFO53KHTPlkHW2I4Qf0rQ
X-Proofpoint-ORIG-GUID: G30NLSB1NioHFO53KHTPlkHW2I4Qf0rQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270097

From: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>

Move out the format related helper functions from vfe and video in a
separate file. The goal here is to create a format API.

Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
---
 drivers/media/platform/qcom/camss/Makefile    |  1 +
 .../media/platform/qcom/camss/camss-format.c  | 98 +++++++++++++++++++
 .../media/platform/qcom/camss/camss-format.h  |  5 +
 drivers/media/platform/qcom/camss/camss-vfe.c | 86 +++++-----------
 .../media/platform/qcom/camss/camss-video.c   | 26 +----
 5 files changed, 128 insertions(+), 88 deletions(-)
 create mode 100644 drivers/media/platform/qcom/camss/camss-format.c

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 4e2222358973..b04079703ba6 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -19,5 +19,6 @@ qcom-camss-objs += \
 		camss-vfe-gen1.o \
 		camss-vfe.o \
 		camss-video.o \
+		camss-format.o \
 
 obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
diff --git a/drivers/media/platform/qcom/camss/camss-format.c b/drivers/media/platform/qcom/camss/camss-format.c
new file mode 100644
index 000000000000..6279cb099625
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-format.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Technologies, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bug.h>
+#include <linux/errno.h>
+
+#include "camss-format.h"
+
+/*
+ * camss_format_get_bpp - Map media bus format to bits per pixel
+ * @formats: supported media bus formats array
+ * @nformats: size of @formats array
+ * @code: media bus format code
+ *
+ * Return number of bits per pixel
+ */
+u8 camss_format_get_bpp(const struct camss_format_info *formats, unsigned int nformats, u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < nformats; i++)
+		if (code == formats[i].code)
+			return formats[i].mbus_bpp;
+
+	WARN(1, "Unknown format\n");
+
+	return formats[0].mbus_bpp;
+}
+
+/*
+ * camss_format_find_code - Find a format code in an array
+ * @code: a pointer to media bus format codes array
+ * @n_code: size of @code array
+ * @index: index of code in the array
+ * @req_code: required code
+ *
+ * Return media bus format code
+ */
+u32 camss_format_find_code(u32 *code, unsigned int n_code, unsigned int index, u32 req_code)
+{
+	int i;
+
+	if (!req_code && index >= n_code)
+		return 0;
+
+	for (i = 0; i < n_code; i++) {
+		if (req_code) {
+			if (req_code == code[i])
+				return req_code;
+		} else {
+			if (i == index)
+				return code[i];
+		}
+	}
+
+	return code[0];
+}
+
+/*
+ * camss_format_find_format - Find a format in an array
+ * @code: media bus format code
+ * @pixelformat: V4L2 pixel format FCC identifier
+ * @formats: a pointer to formats array
+ * @nformats: size of @formats array
+ *
+ * Return index of a format or a negative error code otherwise
+ */
+int camss_format_find_format(u32 code, u32 pixelformat, const struct camss_format_info *formats,
+			     unsigned int nformats)
+{
+	int i;
+
+	for (i = 0; i < nformats; i++) {
+		if (formats[i].code == code &&
+		    formats[i].pixelformat == pixelformat)
+			return i;
+	}
+
+	for (i = 0; i < nformats; i++) {
+		if (formats[i].code == code)
+			return i;
+	}
+
+	WARN_ON(1);
+
+	return -EINVAL;
+}
diff --git a/drivers/media/platform/qcom/camss/camss-format.h b/drivers/media/platform/qcom/camss/camss-format.h
index bfbc761bd46c..86b5790e343d 100644
--- a/drivers/media/platform/qcom/camss/camss-format.h
+++ b/drivers/media/platform/qcom/camss/camss-format.h
@@ -59,4 +59,9 @@ struct camss_formats {
 	const struct camss_format_info *formats;
 };
 
+u8 camss_format_get_bpp(const struct camss_format_info *formats, unsigned int nformats, u32 code);
+u32 camss_format_find_code(u32 *code, unsigned int n_code, unsigned int index, u32 req_code);
+int camss_format_find_format(u32 code, u32 pixelformat, const struct camss_format_info *formats,
+			     unsigned int nformats);
+
 #endif /* __CAMSS_FORMAT_H__ */
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 3daba9e26aee..4e0a8b2bb737 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -278,48 +278,6 @@ const struct camss_formats vfe_formats_pix_845 = {
 	.formats = formats_rdi_845
 };
 
-/*
- * vfe_get_bpp - map media bus format to bits per pixel
- * @formats: supported media bus formats array
- * @nformats: size of @formats array
- * @code: media bus format code
- *
- * Return number of bits per pixel
- */
-static u8 vfe_get_bpp(const struct camss_format_info *formats,
-		      unsigned int nformats, u32 code)
-{
-	unsigned int i;
-
-	for (i = 0; i < nformats; i++)
-		if (code == formats[i].code)
-			return formats[i].mbus_bpp;
-
-	WARN(1, "Unknown format\n");
-
-	return formats[0].mbus_bpp;
-}
-
-static u32 vfe_find_code(u32 *code, unsigned int n_code,
-			 unsigned int index, u32 req_code)
-{
-	int i;
-
-	if (!req_code && (index >= n_code))
-		return 0;
-
-	for (i = 0; i < n_code; i++)
-		if (req_code) {
-			if (req_code == code[i])
-				return req_code;
-		} else {
-			if (i == index)
-				return code[i];
-		}
-
-	return code[0];
-}
-
 static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 			    unsigned int index, u32 src_req_code)
 {
@@ -335,8 +293,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_YUYV8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		case MEDIA_BUS_FMT_YVYU8_1X16:
 		{
@@ -345,8 +303,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_YVYU8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		case MEDIA_BUS_FMT_UYVY8_1X16:
 		{
@@ -355,8 +313,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_UYVY8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		case MEDIA_BUS_FMT_VYUY8_1X16:
 		{
@@ -365,8 +323,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_VYUY8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		default:
 			if (index > 0)
@@ -390,8 +348,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_YUYV8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		case MEDIA_BUS_FMT_YVYU8_1X16:
 		{
@@ -403,8 +361,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_YVYU8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		case MEDIA_BUS_FMT_UYVY8_1X16:
 		{
@@ -416,8 +374,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_UYVY8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		case MEDIA_BUS_FMT_VYUY8_1X16:
 		{
@@ -429,8 +387,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 				MEDIA_BUS_FMT_VYUY8_1_5X8,
 			};
 
-			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
-					     index, src_req_code);
+			return camss_format_find_code(src_code, ARRAY_SIZE(src_code),
+						      index, src_req_code);
 		}
 		default:
 			if (index > 0)
@@ -713,9 +671,9 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
 				} else {
 					struct vfe_line *l = &vfe->line[j];
 
-					bpp = vfe_get_bpp(l->formats,
-						l->nformats,
-						l->fmt[MSM_VFE_PAD_SINK].code);
+					bpp = camss_format_get_bpp(l->formats,
+								   l->nformats,
+								   l->fmt[MSM_VFE_PAD_SINK].code);
 					tmp = pixel_clock[j] * bpp / 64;
 				}
 
@@ -794,9 +752,9 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 				} else {
 					struct vfe_line *l = &vfe->line[j];
 
-					bpp = vfe_get_bpp(l->formats,
-						l->nformats,
-						l->fmt[MSM_VFE_PAD_SINK].code);
+					bpp = camss_format_get_bpp(l->formats,
+								   l->nformats,
+								   l->fmt[MSM_VFE_PAD_SINK].code);
 					tmp = pixel_clock[j] * bpp / 64;
 				}
 
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index cd13a432e291..00b10dda3615 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -28,27 +28,6 @@
  * Helper functions
  */
 
-static int video_find_format(u32 code, u32 pixelformat,
-			     const struct camss_format_info *formats,
-			     unsigned int nformats)
-{
-	int i;
-
-	for (i = 0; i < nformats; i++) {
-		if (formats[i].code == code &&
-		    formats[i].pixelformat == pixelformat)
-			return i;
-	}
-
-	for (i = 0; i < nformats; i++)
-		if (formats[i].code == code)
-			return i;
-
-	WARN_ON(1);
-
-	return -EINVAL;
-}
-
 /*
  * video_mbus_to_pix_mp - Convert v4l2_mbus_framefmt to v4l2_pix_format_mplane
  * @mbus: v4l2_mbus_framefmt format (input)
@@ -121,9 +100,8 @@ static int video_get_subdev_format(struct camss_video *video,
 	if (ret)
 		return ret;
 
-	ret = video_find_format(fmt.format.code,
-				format->fmt.pix_mp.pixelformat,
-				video->formats, video->nformats);
+	ret = camss_format_find_format(fmt.format.code, format->fmt.pix_mp.pixelformat,
+				       video->formats, video->nformats);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1


