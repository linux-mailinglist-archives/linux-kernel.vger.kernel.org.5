Return-Path: <linux-kernel+bounces-93882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094A87364B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F07B28B3D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A08004E;
	Wed,  6 Mar 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G3RW7QOj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1578682;
	Wed,  6 Mar 2024 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728048; cv=none; b=c5Ey4tINBGi1rJajS3udsY1yZb44INVoe/iibJijSHxCFuAGPEN/GBhg59Ig9LkQb8GY7bUElygwg4OnwcGPzLtsVuf5iOpq5iKaEBEao77zkYO/3ZlcmcYjD44WazoyB1PFqMNWlju5lM3JVA4HWqAz/NyEMygejrurWlJvs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728048; c=relaxed/simple;
	bh=tNa2pO3DxCUf23rLalNIYqIGxfZJD7s/HasBZY3POgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptEDOR3EYTWk9vV/hsDTZQywxXft05KCqvdetUEfbmgbtKA9H2AvOSVOKiidnSW7BZgXuQFEbGOeie+h4v4duc6K7GxJEp6t0MmzeJ8SQMvbwyWZgtXGMpUZwi5XKeyWtPEpBqDdJ/nJNUCa6a5dAutotQ3FD2VG/fdonRamXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G3RW7QOj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426Bqokb001766;
	Wed, 6 Mar 2024 12:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=GnahFC5xU+L3TooWag+V
	CCXDbcKdEp+ORqjNvQepIVY=; b=G3RW7QOjCm9hGhey9/dbAZwOUego7S+rKDOo
	PXZvNFRBCYTgGc2sUkvPRSS4gCiP+69iKL8swaroESIp57MUPciwd5L+HH47vHRt
	9UYxl2XBNWdnr3C54AbnO8yWgMWYMi03p3G8VPiFAo7zHJnZkbxhrUfnPQNIuxrr
	V4ivh7CN5JcBAT9zTNsLUOH8B6lWilC3454b+b6MKriVh/LW6/YVvK0X7HFgrlUl
	Wog5eh1Tzn8bwd6WYgm4DjUqViJDyr0wt49Ikg9lAVD8ttpKG68mNj2i3iIlowmf
	Y9Q++OM+w3+bKg58P0KHiu86x/hbyrNlaSpZkkmLdjvvtqUp6Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpgdsryxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 12:27:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426CQoVp017148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 12:26:50 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 04:26:47 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 1/3] arm64: dts: qcom: sm8450: Add qfprom node
Date: Wed, 6 Mar 2024 17:56:33 +0530
Message-ID: <1709727995-19821-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
References: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vt7X1WRfNVGA1Ol6_-_xamqgO0AX5Z84
X-Proofpoint-GUID: vt7X1WRfNVGA1Ol6_-_xamqgO0AX5Z84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_07,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 mlxlogscore=833 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060100

Add the qfprom node for sm8450 SoC.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b86be34a912b..02089a388d03 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4575,6 +4575,13 @@
 			};
 		};
 
+		qfprom: efuse@221c8000 {
+			compatible = "qcom,sm8450-qfprom", "qcom,qfprom";
+			reg = <0 0x221c8000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		nsp_noc: interconnect@320c0000 {
 			compatible = "qcom,sm8450-nsp-noc";
 			reg = <0 0x320c0000 0 0x10000>;
-- 
2.7.4


