Return-Path: <linux-kernel+bounces-108987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2076B88130B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37E41F233E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5A4D58A;
	Wed, 20 Mar 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQNDxt13"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113D4C61C;
	Wed, 20 Mar 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943932; cv=none; b=rDy94N5RzIhqcYI21TiE9sKrF5Xk/UM4ZzSNr0XdoUJQBF+vbz5PVqPQhuCzu8KOt1hBFbs1+vesXM32Soj/IvjkIfDql8Icg2rz3SbryJYY7jRv0kaDc3PB4ouEHdWqZlCd467Ag4BPmnasA5XzDfmj7qAUZuNrV2/yOZuGirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943932; c=relaxed/simple;
	bh=kaQgCgB96t5VTmZu+rQvci49DWLn9kxdQ6VHrLubYyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEB+C+/pRPeHu8jHmxmmDt8J5Cn38rXxyQq+kk2w3sUedPQT147/rMPgj36qWMCe21YrW12dLB/acR31DWyYGIAI5AvE5m8ywld8U0S1ou0N6xgSiSDaZ6isIT6ReJetzm3YcnjMqK3WcLkHUq6Cd1rPun6O6cJXBf2RH9OPE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQNDxt13; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KBjIQO032018;
	Wed, 20 Mar 2024 14:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=s4b1FznNv6D6xML5/Ezg
	27sNa8DMEdY1CNVZlPZf5Xc=; b=dQNDxt13HcsggDcI2TehNh3QTEjEXpVa+30W
	Rz7wxEUKVl44YLUtwzbL6ZL0CLmSGzO72e50u4524gNo6wp2nEITpqhopHPhOJzY
	av8sptFkbXLuUzrNcLzZRABGklEYEakhL5u5kqjlIAwJmEk6/VcXAaqy0Bz3IsI+
	dZBdyTDdElYpRXqwckD+Qbcql99KMNcn8M9egZtM3syAKqfoI0WwhQGB/coxdnXv
	4Wa04cQv/Dz2NTP9J9bfO/NT0knLQbdtgpy3Yc+xA0kDrqWV/OKIU3niNGL40UGg
	3fGT/LXvXsZlS8Sl2LzFZaBpNKpIT6Ao6EW0qivz+2MAxj22wg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyrp7965u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KEC6LA024002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:12:06 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 07:12:04 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 4/8] media: qcom: camss: Add new params for csid_device
Date: Wed, 20 Mar 2024 19:41:32 +0530
Message-ID: <20240320141136.26827-5-quic_depengs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qhYRbRXFh6tQz71kNima-LXuIEJERW3Q
X-Proofpoint-GUID: qhYRbRXFh6tQz71kNima-LXuIEJERW3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200112

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


