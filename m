Return-Path: <linux-kernel+bounces-126562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBC89397D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB221F22199
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEF213FFB;
	Mon,  1 Apr 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l+uWJoeo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720512E58;
	Mon,  1 Apr 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964364; cv=none; b=S64zBgN9wjgk5wCbPpx223E8D1Syx4EVISfhyOq2iAviHnZsf2GTNQeQOzcL7126woZ68fCqY9k7CblZDT+q/lBwxmOsZOSTjNWXSyILrFSvY9gfMfzQtWsWDocsPBMnFBUoA5ehGQOYHvOmdthIiPloofZEWeIHRuR3C3XSTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964364; c=relaxed/simple;
	bh=74rZWRCSCx1IGdY0RqQQmYHLKenHYUzQDW/ccW82WZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8YIb8hLXQrb2ZiWd9bkbXBRFA2GUxi3BoOlG78jvznPO2HGz3SC6EB/FrjyWSfz3mpSYzun0Nnmt/dcVUZc1YoRFrc7A+i3gCOBw5szlqIutxYEupbJu+u+CpdgzwpT1iByZCt2/hXls0ogDIURMGO2VBAErZ+cDjrmGWLJ9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l+uWJoeo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4315ojiq032411;
	Mon, 1 Apr 2024 09:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=/Z455yzbHoSG8tTliS0eX0h8ao43BpNNX+Frh0CB8+0=; b=l+
	uWJoeoGYzl80ySSUPT68O0GekHshOeT9MIivJoD1Ionlp/b8VpgF3IhOLQps1kwl
	UfOF8ZYF+NkswzvWkE+IglGDIZmd5BwJ8/SfAnO8+PxOBM/JYVBp190RWCrzDR00
	RTdnddkZSi063oosrdjJtDd5FesN9TU5RqGqSBYH98k94GDovE5Je+0ws/VEaeBB
	MKZs7igeXLKLrlfj6mHHetZIP+a2Akfo5dAZHIBAOMIz8msfunFk2TEzjeB8kkig
	9Z2eaxFa4ZdgsMKrRtV/RbLMmFLMdsphpFcQPUc6M22VDATTyZ+HhAom/qi7aMjY
	VzOlNIEXer1AlqY82YIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7m86gq41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 09:39:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4319d7l6010046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 09:39:07 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 02:39:01 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 RESEND 1/4] dt-bindings: arm: qcom: Document QCS8550 SoC and the AIM300 AIoT board
Date: Mon, 1 Apr 2024 17:38:40 +0800
Message-ID: <20240401093843.2591147-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1O_Oz86U-TU-kqJqJumvVwY9DTF5h3di
X-Proofpoint-ORIG-GUID: 1O_Oz86U-TU-kqJqJumvVwY9DTF5h3di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010068

Document QCS8550 SoC and the AIM300 AIoT board bindings.
QCS8550 is derived from SM8550. The difference between SM8550 and
QCS8550 is QCS8550 doesn't have modem RF system. QCS8550 is mainly used
in IoT scenarios.
AIM300 Series is a highly optimized family of modules designed to
support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC chip
etc.
AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..8115088a6076 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -42,6 +42,7 @@ description: |
         msm8996
         msm8998
         qcs404
+        qcs8550
         qcm2290
         qcm6490
         qdu1000
@@ -1005,6 +1006,13 @@ properties:
               - qcom,sm8550-qrd
           - const: qcom,sm8550
 
+      - items:
+          - enum:
+              - qcom,qcs8550-aim300-aiot
+          - const: qcom,qcs8550-aim300
+          - const: qcom,qcs8550
+          - const: qcom,sm8550
+
       - items:
           - enum:
               - qcom,sm8650-mtp
-- 
2.25.1


