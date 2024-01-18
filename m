Return-Path: <linux-kernel+bounces-30020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228A8317C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DEA1C23F16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA724B2C;
	Thu, 18 Jan 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mp+yKmHt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481B22F16;
	Thu, 18 Jan 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575609; cv=none; b=GoAM9ZHrkKi5N02018LeRmDx1dLOOoq0GsbSvJ/Y8OuSjmWKXgqIJmfXi7orDHgsY8cYmb4p3Glh91AxOQw4uqnLSk8LykbW/FKiXozbXGBiAZJkFdn2KQE5j0et15gA87S4dAFiWz6mv0Du/i1ep3z+kt7qQSwTpY6hiI8UCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575609; c=relaxed/simple;
	bh=s9YWx0niqq/0hb6eo0iRhIrN+Gm4N4nnCpUXz+Ce8zM=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=tlcL3cQP4APc74CVkCI2W2yZ3u97DNrLDscPUufhfwOzAVK2gN16s2Fpd5Qxj3Q328J2bXCEbu2voTSQTuE33DsDZ+5bNG49OrJVE7Is/1ZN8kw0WAk9EiTNwFcwgU9DaWtWNG1z4x95O93uIYLNkZDBBWOgIRyX44V2z1Aud8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mp+yKmHt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I3s50G032335;
	Thu, 18 Jan 2024 11:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=19/E3FYg6etQ1bcM7OtOpZ5QOGxHV/AWg0H8PpSM8FA=; b=mp
	+yKmHtMzRXV+Z4GJF2tC/c4pAREUug5748pSivDGd4C8D2jp2aEFAqhhFYqO//lH
	FeLlM8c2tTA2+kacOPU+Z4kj9CDFFXMWJy+BM9fmWIg4eveajuQ9gDjJtlCrXgSe
	EYiNZ/FkziricZG6tVhAAHPVjToJMrWRdKWHpm6JzoAjCQ062RX6AgMJcnw1M5qn
	TuxGpopnQav1NYyM1U/T6h0kjO8Y+hP9LuiA175PJxcF5ZFGkcsgJDLp0e6spAQy
	1yM6HE3AZBB/gHS8WWwmI4YrRIfZYPA/IHR1qlhVK25a6IwGO7lWA0qcRT6yBeGU
	Ch45yhi0pgK1+4G+KemA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpu9a0yxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 11:00:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IB00nK013139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 11:00:00 GMT
Received: from hu-sachinku-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 02:59:56 -0800
From: Sachin Kumar Garg <quic_sachinku@quicinc.com>
To: <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 1/2] media: v4l2-ctrls: add encoder maximum bitrate control
Date: Thu, 18 Jan 2024 16:29:33 +0530
Message-ID: <20240118105934.137919-2-quic_sachinku@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118105934.137919-1-quic_sachinku@quicinc.com>
References: <20240118105934.137919-1-quic_sachinku@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aH8yp33KszO1w99GGEPufsd88lJu73yw
X-Proofpoint-GUID: aH8yp33KszO1w99GGEPufsd88lJu73yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=770 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180079

Introduce V4L2_MPEG_VIDEO_BITRATE_MODE_MBR rate control to
limit the frame level maximum bit rate.
Encoder will choose appropriate quantization parameter and
do the smart bit allocation to set the frame maximum bitrate
level as per the Bitrate value configured.

Signed-off-by: Sachin Kumar Garg <quic_sachinku@quicinc.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
 include/uapi/linux/v4l2-controls.h                        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 2a165ae063fb..05ef4a70e3f5 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -576,6 +576,8 @@ enum v4l2_mpeg_video_bitrate_mode -
       - Constant bitrate
     * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_CQ``
       - Constant quality
+    * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_MBR``
+      - Maximum bitrate
 
 
 
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 8696eb1cdd61..e0597b61ffb9 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -154,6 +154,7 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"Variable Bitrate",
 		"Constant Bitrate",
 		"Constant Quality",
+		"Maximum Bitrate",
 		NULL
 	};
 	static const char * const mpeg_stream_type[] = {
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 99c3f5e99da7..7c74d6c417d1 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -393,6 +393,7 @@ enum v4l2_mpeg_video_bitrate_mode {
 	V4L2_MPEG_VIDEO_BITRATE_MODE_VBR = 0,
 	V4L2_MPEG_VIDEO_BITRATE_MODE_CBR = 1,
 	V4L2_MPEG_VIDEO_BITRATE_MODE_CQ  = 2,
+	V4L2_MPEG_VIDEO_BITRATE_MODE_MBR = 3,
 };
 #define V4L2_CID_MPEG_VIDEO_BITRATE		(V4L2_CID_CODEC_BASE+207)
 #define V4L2_CID_MPEG_VIDEO_BITRATE_PEAK	(V4L2_CID_CODEC_BASE+208)
-- 
2.34.1


