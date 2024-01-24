Return-Path: <linux-kernel+bounces-36416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F1583A070
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00450B22F26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76427C8EA;
	Wed, 24 Jan 2024 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CNuWt/Ts"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997033E1;
	Wed, 24 Jan 2024 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070328; cv=none; b=O4+0SRhLLfN+ST6o/K2PftJXpAiZ/mqGmh57hKXc1gwaTPMa7FddwwyAHyAoiksmfI4M20KmxBwIDvo3yMf1Jotk+7850Oo7l1yu4QI8xuiWYHhmdFr9sTBR03l1fgh1jQsNvs4aX2DGDqcATpl/+bEFFGKajMDf/aICqz+DL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070328; c=relaxed/simple;
	bh=Z1s+V/qCRyJP3GIGhiOG/zuiYuQsCRDzolyhdYZlsJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A301NvTu3CTiESrs91lFn3fou33zVkOQKrQOEbcMr9yoaBm5ksDHwZ1iMSS3XwikFHL7NPmIjuHTFeD4yEOXLnKu7Q9u3xkG7itE2G6fHw964hrdLREmbDothE6UWSZuiQemDh9JO4iCtgyeG4YS87t9q+57Xq2Z7R+/NAuCcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CNuWt/Ts; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O42LOJ018132;
	Wed, 24 Jan 2024 04:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=j0WrjNuqJTFbXzVKqBCvNcYJMSiWYcyljt5OHBM4AJw
	=; b=CNuWt/TsgfsFY2Nd1dVOCS6+nF/GIz9lAmPRIsZWlp2JK5j9DjGg+7iQjQr
	qmWWEM6/YZxr6UJQXHsRfXEBKXNO+LD6prFPZ5w7x5jqzYxqltbHgMOMUnY/ckE3
	AjD8m9QCMst5qjCRFKBUCIZFes2Z5d3pvPdKuAXfD8MKAmJnnGlUjEBnruQlZ9Nq
	wB/ag4Mle4NKZAH1SrAEC2rrH/3FO7KUs5zfNxE+MABm4tEE/WE2Opr6hxqaFLl6
	aP8N8K5TsC+7+q6OSRQtkT0AaIsqD9Zy/Ce0VY3cCOBrXlFnunu1Ybn8Jq83H1s3
	pPeElUttPZzbUfkhthiGJQFZw4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmh00qye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O4PGi9030380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 20:25:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 23 Jan 2024 20:25:15 -0800
Subject: [PATCH v3 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to
 GX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-sa8295p-gpu-v3-1-d5b4474c8f33@quicinc.com>
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
In-Reply-To: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
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
        Johan Hovold
	<johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706070315; l=1266;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Z1s+V/qCRyJP3GIGhiOG/zuiYuQsCRDzolyhdYZlsJQ=;
 b=etyhi32oJ93vyKyw2B7Jv/s/vg/sbyY6qFg3Xre9d/zVeAzk+jycW66Z/X6dTFx1XpsSfJevm
 iqpZuJesK3BCl2LQzBEBnep69oM/4tSHE26i3Rwu7J29MAw0geOAVf+
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sQjLpxuj90hWc4MptYli9mdh7aeJlanj
X-Proofpoint-ORIG-GUID: sQjLpxuj90hWc4MptYli9mdh7aeJlanj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_01,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240029

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


