Return-Path: <linux-kernel+bounces-108993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963988131C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CD81F230BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E656448;
	Wed, 20 Mar 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UsfmqM/o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A554F95;
	Wed, 20 Mar 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943944; cv=none; b=kFMtttqm18M2GK1SfMFgcg9RqJ0EMN2QJ1QFV8R63oY3IBfxY0/a+7BU/EsVRloXNpNBbPjRdfKGb9dmGXocUo8P8FTXM5BCsPZSSb8i2wdvpNqosEsyJL79rlbhPOHm+olxbLKy7n+IDWSKzMfk1fSsx4KwmOpYnw6ibuMwmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943944; c=relaxed/simple;
	bh=mg+tMIJJhQbZSc3KgDFAUUn2/2YBkbBqeNy6994sZSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBpWHDwuNv/6Ybrm45H1VdRCv40UhkLxcln+vwLEVTDBuhdEvSdFNNGVDH40lfcLrt3/G79WUP8LugUa9CawmzLBH8nJUCJuUP/og7J+lTR+Mm5I9zZ0uZ+9OfNS4Mxtz3xUHhUwux1z0dDaBxXQOSwmv+sROCYIS8FoHjPbDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UsfmqM/o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KAxaQ3022954;
	Wed, 20 Mar 2024 14:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=INhy64+y4NMvRSh4JLod
	4Mm3dtQbDC0zNVojtPjvHjs=; b=UsfmqM/oxuvKSsQ2KKuGUOvdSU/JJWzU+q89
	aZloPtfqRXjKvQrRG3bUa2Ag4cnCi1rP8QWtQEFjnKDUJKZTJGwZsIksCl2/DWMR
	Cm0nN1ugi6WPQ5SWj9eLAazWkg+szt1GTRLv3PSW0aKNOfNCq8TXJbDDTq+aFsd0
	iK0uN8pmaL2sZmfEBD1Aqbj/iVYJ0SL3bY5KkVW8yV5QM12z5fDWE0j/ID35EAbh
	a+cY264COltwUKitD4fWHrg7R8XQ7awoa86sqhOzWFV0N5LwQCerd5l4H1kPrwJ7
	eil/EnbLoHKV6YDB5FNwMeV7rqpoYplQDCMU/4Tz6wOKd+AJFg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyrp7966r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KECI9j022912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:18 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 07:12:15 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 8/8] media: qcom: camss: Add sm8550 support
Date: Wed, 20 Mar 2024 19:41:36 +0530
Message-ID: <20240320141136.26827-9-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240320141136.26827-1-quic_depengs@quicinc.com>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VAeLu2k_EwkZaCbRpLGP2ik50JcODnxB
X-Proofpoint-GUID: VAeLu2k_EwkZaCbRpLGP2ik50JcODnxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200112

Add in functional logic throughout the code to support the SM8550.

Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
---
 .../media/platform/qcom/camss/camss-csid.c    | 19 +++++++++++++++++++
 .../media/platform/qcom/camss/camss-csiphy.c  |  1 +
 drivers/media/platform/qcom/camss/camss-vfe.c |  7 +++++++
 .../media/platform/qcom/camss/camss-video.c   |  1 +
 4 files changed, 28 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index eb27d69e89a1..e9203dc15798 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -590,6 +590,25 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 			csid->base = camss->vfe[id].base + VFE_480_LITE_CSID_OFFSET;
 		else
 			csid->base = camss->vfe[id].base + VFE_480_CSID_OFFSET;
+	} else if (camss->res->version == CAMSS_8550) {
+		/* for titan 780, CSID lite registers are inside the VFE lite region,
+		 * between the VFE "top" and "bus" registers. this requires
+		 * VFE to be initialized before CSID
+		 */
+		if (id >= 2)
+			csid->base = camss->vfe[id].base;
+		else {
+			csid->base =
+				devm_platform_ioremap_resource_byname(pdev, res->reg[0]);
+			if (id != 0)
+				csid->top_base = camss->csid[0].top_base;
+			else
+				csid->top_base =
+					devm_platform_ioremap_resource_byname(pdev, res->reg[1]);
+		}
+
+		if (IS_ERR(csid->base))
+			return PTR_ERR(csid->base);
 	} else {
 		csid->base = devm_platform_ioremap_resource_byname(pdev, res->reg[0]);
 		if (IS_ERR(csid->base))
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 45b3a8e5dea4..f35af0dd2147 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -579,6 +579,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	case CAMSS_845:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
+	case CAMSS_8550:
 		csiphy->formats = csiphy_formats_sdm845;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
 		break;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index d875237cf244..ff115c5521c6 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -226,6 +226,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_845:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
+	case CAMSS_8550:
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -296,6 +297,10 @@ int vfe_reset(struct vfe_device *vfe)
 
 	reinit_completion(&vfe->reset_complete);
 
+	// The reset has been moved to csid in 8550
+	if (vfe->camss->res->version == CAMSS_8550)
+		return 0;
+
 	vfe->ops->global_reset(vfe);
 
 	time = wait_for_completion_timeout(&vfe->reset_complete,
@@ -1520,6 +1525,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		case CAMSS_845:
 		case CAMSS_8250:
 		case CAMSS_8280XP:
+		case CAMSS_8550:
 			l->formats = formats_rdi_845;
 			l->nformats = ARRAY_SIZE(formats_rdi_845);
 			break;
@@ -1605,6 +1611,7 @@ static int vfe_bpl_align(struct vfe_device *vfe)
 	case CAMSS_845:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
+	case CAMSS_8550:
 		ret = 16;
 		break;
 	default:
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 54cd82f74115..78a746be952c 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -1029,6 +1029,7 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 	case CAMSS_845:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
+	case CAMSS_8550:
 		video->formats = formats_rdi_845;
 		video->nformats = ARRAY_SIZE(formats_rdi_845);
 		break;
-- 
2.17.1


