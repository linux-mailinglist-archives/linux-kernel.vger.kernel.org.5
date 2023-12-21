Return-Path: <linux-kernel+bounces-7818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6281ADAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21431C229F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB06FDC;
	Thu, 21 Dec 2023 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J6SoQsTV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6206F8C01;
	Thu, 21 Dec 2023 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL2IatL017801;
	Thu, 21 Dec 2023 03:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=qxoKW4bRzJoxnQGhW8Ud6uaUciCN2bKlX/uk+24M/+4
	=; b=J6SoQsTV/ln8c1K0+luNTrgD8uTBspUCAkkdFR81mMv2vqKnGqZZh+bOCcg
	n9A4UpSjdZUmu5jdydNu0XOCh+5FYvGZug/di/1ds3IMLOzrLAzuw2L5UtcgdKDE
	k2HM4xB3/uLJulfDPCGVdO5wgVm1KEjctokK0opZpJHxU5EBnJ9QoJ956tFNC2VY
	NS4qhX0rzA4j69lBdc1mNOPhAye1WCXDml/6EJRYpGbcMyJIBBMZybXeh4jY6C2B
	GwOsyNdbJ8K2ib0dqpSJMfi5ytSEq6kf24RR2VO6WZ1IffjrmRjJjvqHoA3YHjWV
	5T10AloWKquX4MMdjuRoLk2IoZQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4b5u8dks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL3oonr003636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 19:50:49 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 20 Dec 2023 19:50:35 -0800
Subject: [PATCH 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v1-1-d8cdf2257f97@quicinc.com>
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703130649; l=841;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=gsLSzEtTNvvjs9aLDTb4B3w5KFCxmior5IC60emfAk4=;
 b=7KZMkkOYfPdl/o2/c7khRGaRw8a5OOlkrlJLkcyB6UDJ2bpf82xRPyr6w6YKEkC8xgyec/QsI/vs
 Inmml+nBCvduDR2gpL4ZSF/HC2zCC8UJFWrjIW+6HuP099y7GDz+
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u2tG44NJ6BpkQtlUBQGpEa8IqcN6OXBu
X-Proofpoint-ORIG-GUID: u2tG44NJ6BpkQtlUBQGpEa8IqcN6OXBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210026

In some designs the SoC's VDD_GFX pads are supplied by an external
regulator, rather than a power-domain. Allow this to be described in the
GPU clock controller binding.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index f369fa34e00c..013ef78d2b31 100644
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
 

-- 
2.25.1


