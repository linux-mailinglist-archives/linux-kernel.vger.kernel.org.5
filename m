Return-Path: <linux-kernel+bounces-107282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806A587FA60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53A81C21B54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B97E0F3;
	Tue, 19 Mar 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JZ7xcwxF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AF7C0BD;
	Tue, 19 Mar 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839303; cv=none; b=eTkfdu5CyyrljqCMBzNjaDOm1qT04VBGS52Y6slIro9S5lQwxmThYvmNGJoC/3kkhPT7Iz26alkhhu3S7+8z5pDrYJHoQAjhTym7mxIjtbSSjqMefVgYvbha7GaEtc9YKw+tdYoZlLbApp5CYGbosynySv8Ka0VSYMD83khTf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839303; c=relaxed/simple;
	bh=Mwzj6iisSbKiLVFpn76fjTrokIiqpECVqSnOSJzrvIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhhJg/usBGViHkjYLmbqK1R17ynzP6N59nlQ8hzzEj7ZMJqNNO+/sdeb1zQV3fzmj2vZI2OVGF0LU99d2gbr2S3rcsQPy1xbM6jtZOM62qWfPgT874ej3WU48kYOvjWL580tCCIex7Tns13LyhS2tDuCzErg/pFGWZiGc6q+bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JZ7xcwxF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J6xP5f001102;
	Tue, 19 Mar 2024 09:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9fmatg734/m02D1xI3E9DJW0IjgrgqydRgrxez31dG4=; b=JZ
	7xcwxF5nPvRGOyH7YFBI3cfGKkwX1vLAUTdn3Vk3P8YDf+SjCYw8RZFHdtW6z75S
	YQxDS1+F2dJmslgOyoFOVKESea9rwLeE/TRsmUO6lRtH21HznL06xIplMLoe178k
	xr4vA6t2+zzzMZo5WK3UnwLrudOS+OugU5nd1zu7vMbZG8kYx8KKL/5j9jlZsByR
	pHIVFIBTqT5+RPrP4MhvPihwzs3xrRLmlUiuWeraUUgeEFNLtC06jamABOBbB4gA
	UV96/CkGUYFpl+R8lqGvQ90ie043V7YOSR1st+WhWs8wAiEEMFtuzf2duF7VMPxR
	Y0ijM75U8z+mnmQXsKWQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy5ws092q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:08:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J98E79032074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:08:14 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 02:08:08 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>,
        "Rob
 Herring" <robh@kernel.org>
Subject: [PATCH 3/4] dt-bindings: usb: dwc3: Add QDU1000 compatible
Date: Tue, 19 Mar 2024 14:37:27 +0530
Message-ID: <20240319090729.14674-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240319090729.14674-1-quic_kbajaj@quicinc.com>
References: <20240319090729.14674-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Abw1QYQfcpV-XZ-QoAbbAadDTLMP6yqJ
X-Proofpoint-GUID: Abw1QYQfcpV-XZ-QoAbbAadDTLMP6yqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=835 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190069

Document the QDU1000 dwc3 compatible.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 63d150b216c5..2437777c166d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,msm8998-dwc3
           - qcom,qcm2290-dwc3
           - qcom,qcs404-dwc3
+          - qcom,qdu1000-dwc3
           - qcom,sa8775p-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
@@ -245,6 +246,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-dwc3
+              - qcom,qdu1000-dwc3
     then:
       properties:
         clocks:
@@ -440,6 +442,7 @@ allOf:
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3
               - qcom,msm8994-dwc3
+              - qcom,qdu1000-dwc3
               - qcom,sa8775p-dwc3
               - qcom,sc7180-dwc3
               - qcom,sc7280-dwc3
--
2.42.0


