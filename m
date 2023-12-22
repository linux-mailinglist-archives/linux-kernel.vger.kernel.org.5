Return-Path: <linux-kernel+bounces-9330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0D81C438
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399231C2453E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211511CB5;
	Fri, 22 Dec 2023 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MBESSgJC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557135390;
	Fri, 22 Dec 2023 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM4Tenl006508;
	Fri, 22 Dec 2023 04:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=j0WrjNuqJTFbXzVKqBCvNcYJMSiWYcyljt5OHBM4AJw
	=; b=MBESSgJCe40UgvGfS5cXtc9pOcpipk8zZwDz020Jyz26aCyCkrQplIn5GhE
	cE+ez7c+e1iHOoalUPb83PIZb/JxcOtNEnR4Z7/PBTtMqGXYYoWB5p7DTQYN79Z4
	2RoZU30qJvn3Uxo4m0tygX9lRgIPE1O7iz1ycBOrOpO+xaAae8StRHRB8+F+ERcb
	yw1dRObQJtH+8l+UBZPDT3QIjUi/l/VOaX6nj4rXPB2pRBoiNFOJpJDD26dXCNaO
	R+2m/QrKbLn6qKtm9YLJrd7Ibx2Tp649Kvzan1dFMvRYGURAGZkbCBRZ++A795EY
	AtKLUldMZ5dWRGG7JpDQa9z+JMQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4xpq8hu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM4dOZE029439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:24 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 20:39:24 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 21 Dec 2023 20:39:22 -0800
Subject: [PATCH v2 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to
 GX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v2-1-4763246b72c0@quicinc.com>
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703219963; l=1266;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Z1s+V/qCRyJP3GIGhiOG/zuiYuQsCRDzolyhdYZlsJQ=;
 b=lbNA1J1+FkB9NyGyfqK3rCoL2wayntY+NVfTaYyW9iKJn7g6cltHefwDZD823lGHRBblaUdjbrlw
 7L8QPpNIDkOL7WF7fLW2jycoXvGTXAU5tPEa+olFIsQtl2S/gEf0
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8MvO7bwx9c7rqnp_3h8aaKyGmbrHUYtL
X-Proofpoint-ORIG-GUID: 8MvO7bwx9c7rqnp_3h8aaKyGmbrHUYtL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220029

In some designs the SoC's VDD_GFX pads are supplied by an external
regulator, rather than a power-domain. Allow this to be described in the
GPU clock controller binding.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index f369fa34e00c..c0dd24c9dcb3 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -53,6 +53,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  vdd-gfx-supply:
+    description: Regulator supply for the VDD_GFX pads
+
   '#clock-cells':
     const: 1
 
@@ -74,6 +77,19 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+# Allow either power-domains or vdd-gfx-supply, not both
+oneOf:
+  - required:
+      - power-domains
+  - required:
+      - vdd-gfx-supply
+  - not:
+      anyOf:
+        - required:
+            - power-domains
+        - required:
+            - vdd-gfx-supply
+
 additionalProperties: false
 
 examples:

-- 
2.25.1


