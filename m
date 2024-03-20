Return-Path: <linux-kernel+bounces-108960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AFA88128A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A234F1C217C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04834206A;
	Wed, 20 Mar 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="URsiCZxB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0848CCD;
	Wed, 20 Mar 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942185; cv=none; b=hG2gGNRc9gIULgVGUyE7b/keh4XKQrnf7cFwxSKO3xWYOHYIGiUM6BU5UBt2BjyERg5ungR31vdHA5YXix7OX7SSsLWnaB9yrDxOfFY96qk2MHJOfa8YZ0nDIKt3TC9rll1obpSRpTp2vt6iaSkPBOinyQA14sAC7yrEseJPY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942185; c=relaxed/simple;
	bh=kaQgCgB96t5VTmZu+rQvci49DWLn9kxdQ6VHrLubYyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNOs2PZ1Qn2dTPjtV1C+76p/Hg4GpfRxc6S5taYOe83zJ0APNnF6Qi2GU1U1/UmTP64gqX+O8MmltsKyVCOqsygTJawOu3dSJO6QjDxgRFlyYMq1P5avAuDaNaMgKlrUIo+ntIutMqPSEOPY4ig25JdHiIdMd9iG0TF1G27kYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=URsiCZxB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KCuJhB026872;
	Wed, 20 Mar 2024 13:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=s4b1FznNv6D6xML5/Ezg
	27sNa8DMEdY1CNVZlPZf5Xc=; b=URsiCZxB0++NLTplEGbH4xidx8WfugY2plQU
	YtrLG/5m6gSqSRcE9XlP3/5RJy8lfvF5WTE7X7BeruJUJmIM6bcy/QEk1PWW/43k
	06/GDJ0nw7rZ35FSekyAFJfKf78g+77ZLAjxLid4lIokGhYlUgiMIsLGkusRKaFC
	XjeLRQU3qgCJWg6Tmdl6hX/ZP2yuTzfl2KO6MNVkeR0fpvmz76RLPYJ5hfScude5
	3KV7h2CJUH3XKWPxwwfxMFZCogMMoYJCT0cr05tHlDW9V9LyYioXU4t45nlvhZeq
	UCoedK9GwGU6OALXQfuYFwlmfLxEmc+LM4IlOgJjJzzGS2thjQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyh8e1y23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KDgwQg032081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:58 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 06:42:55 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 4/8] media: qcom: camss: Add new params for csid_device
Date: Wed, 20 Mar 2024 19:12:23 +0530
Message-ID: <20240320134227.16587-5-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240320134227.16587-1-quic_depengs@quicinc.com>
References: <20240320134227.16587-1-quic_depengs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4optTS_oxT36O3Oa2jUIw3_SxQegxl6M
X-Proofpoint-GUID: 4optTS_oxT36O3Oa2jUIw3_SxQegxl6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200107

CSID gen3 has a new register block which is named as
CSID top, it controls the output of CSID, since the
CSID can connect to SFE or original VFE in CSID gen3.
The register update is moved to CSID from VFE in CSID
gen3.
So, adding top_base and reg_update variables in csid
device structure for CSID gen3.

Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss-csid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index 4a9e5a2d1f92..ca654b007441 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -162,7 +162,9 @@ struct csid_device {
 	struct v4l2_subdev subdev;
 	struct media_pad pads[MSM_CSID_PADS_NUM];
 	void __iomem *base;
+	void __iomem *top_base;
 	u32 irq;
+	u32 reg_update;
 	char irq_name[30];
 	struct camss_clock *clock;
 	int nclocks;
-- 
2.17.1


