Return-Path: <linux-kernel+bounces-30998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E84832747
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6845A1C21401
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9E3CF5B;
	Fri, 19 Jan 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iE+0UbsW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204B3CF4A;
	Fri, 19 Jan 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658831; cv=none; b=K7mwzXDTUgPQs6n4hppLjZ3lfrPHQ1xOR37mhoHN4qCRvgbqoPxAXP7QcgkPU/8a1krIOEu+xqDnSlikyVzberIX0qRIpLqMY+ePqfcr4e6fv7c8ihdOrwIhmbmVj40HoCACMDJOdcMLDUuWpUVi1tnstnLY/0gdOr50VQ0hVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658831; c=relaxed/simple;
	bh=gEEt+UQ05eIzedGoHdtXVLTSR0qyhcZWNSxchr8lTps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUQK7AmjUSjeGmIkpP6LGLa0tPdJGkay154pgnaZKvJw9hxHHv+LbBtzdw8iOMxXr6M+QGxmBnxulD5zlD7q/e9gh0i5FJNeYhWDaHOFM2jPEEL9uN5uBrKQv54zF8+OVT3Ok5JquYjbBP2r1NNSIlMe56DnEvtpn8+HdlmO4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iE+0UbsW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J9fYHZ008194;
	Fri, 19 Jan 2024 10:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=3El0zt+SPeVFAJpg3Vli
	/3txpfvPP3xbVXqRHqPuHpQ=; b=iE+0UbsWBSDaPE6solL+FFnazjZaUyMuzw7G
	7s9qPmTiwex62JkWV3938HesrV3AeIYJILZ4Kf1QuWvdl+I+wq3E9m3Pk/HdvgCP
	OvSeltsloSMtuCPGle9a4A4egyPSEFEd+pZMBDYfv2Axyw0WmL3TcJ3H9WYiZ0kO
	+gOrJyeKXFK8zzuD+adex39aNvnVpp07ztko8ezTa6kh0AoiUnP39a9N/oy8sbfR
	B6FvCH5pz5pc2cH/zrN3OE4trligvRMVtaXT0zoA1rwuxA4OE50EjvZwM93t8krl
	gyYOD3re42zvMeHDlC1SyvK5pl7msCb04SzYa5+Pk0JEa/uOVw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq6uba2np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JA7586019168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:05 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 02:06:59 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: [PATCH v4 2/6] dt-bindings: arm: qcom,ids: add SoC ID for QCM8550 and QCS8550
Date: Fri, 19 Jan 2024 18:06:17 +0800
Message-ID: <20240119100621.11788-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240119100621.11788-1-quic_tengfan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jZFkonoG69gomqFp_DjnyUKJamKsU48F
X-Proofpoint-GUID: jZFkonoG69gomqFp_DjnyUKJamKsU48F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=561
 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190044

Add the ID for the Qualcomm QCM8550 and QCS8550 SoC, QCS8550 is a QCS
version of QCM8550.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 51e0f6059410..dc7ba87b50d7 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -265,6 +265,8 @@
 #define QCOM_ID_IPQ5322			593
 #define QCOM_ID_IPQ5312			594
 #define QCOM_ID_IPQ5302			595
+#define QCOM_ID_QCS8550			603
+#define QCOM_ID_QCM8550			604
 #define QCOM_ID_IPQ5300			624
 
 /*
-- 
2.17.1


