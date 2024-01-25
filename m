Return-Path: <linux-kernel+bounces-39284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94883CE26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C430B26A62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26013DB96;
	Thu, 25 Jan 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L884OJCD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51813BE80;
	Thu, 25 Jan 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216725; cv=none; b=ISZJmUNOYZLPOIYgthpq4Qxv0AK8rNKaste+1MIiKXbA/6226Bqp0CQ0frUxFem6LVI+pOuJd8fOvj9IzGbsn16jWEsaCSs07U2TpHcz529rsmbVlnkJol7UexNPjR6YN6oj/S27zvq+1QpMOeo3G/2GDJ9CJDDSN3Ebvti1XLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216725; c=relaxed/simple;
	bh=ZTKXdewTHXfouTjQ0Arv96vvn/OKx+KOghE2Ix6ESHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=duTwIRvyyNh/twngeEmqEL3Uq8B0RJa315d/wQujZOqTyvMIU05ag7W5rBY85uszgGYEckeoeYqUpVe3N8YKj/BRV5DXaQ3fnHaeSnB4q5zCLsj+OqpRum4YCXMg2HI76rFykwguYA+68g3TVPhceOIz2aK32BG7qJrLHkYjvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L884OJCD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PKXElb019065;
	Thu, 25 Jan 2024 21:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=5R+nRAa0STmKw167yqehBeM3EkmBG/KPqSZqvIFA3mk
	=; b=L884OJCDQtZY6U27xbVzTsHK0iBPP+qawEJjnFX6+mydBRuIUAwC778deHq
	DVtX/FOuNNu52z16NmzLXW/wyJFUSr71F+YV2gIvGd8+k4aFNA+VTMpmlgww2198
	EKxyiYoJA1ESwCUNSW+cBWPkUNXuWpCI64F4vDKTUrWujf82Sbu/8nUpE5BIN1l7
	qKWJPk0vny5sQuOfu4fPNhtMzNas8b+9LvEVWQ9EKrT5lc7myeWlM7CFPkzuZWv1
	dP+oHWDzmF2zCAeajcOMBH8e7RXqEFe8FyDeMVincFR49nA3T1Tvqfxx8daM+lpC
	ygFCzLClHn1uStGhL30K7RYRpug==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumf79wj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5C9x031694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:11 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 13:05:07 -0800
Subject: [PATCH v4 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to
 GX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-sa8295p-gpu-v4-1-7011c2a63037@quicinc.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
In-Reply-To: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=1114;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=ZTKXdewTHXfouTjQ0Arv96vvn/OKx+KOghE2Ix6ESHM=;
 b=w2m3qdB32VTfY8yOMvxfwcMu3RZRVmTJPgegE0ri0xKZ+LdbCG956BmUbTkZJaiCqiZI9ZtkC
 xB3AXLQ4pbZBUNJkPAlTy4kB4q6NxejjRCNvLMJOa2KOcXSDRgMUNnS
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zOVmWQc9VVwFA_SORDPsSaQ5YgzHhJES
X-Proofpoint-ORIG-GUID: zOVmWQc9VVwFA_SORDPsSaQ5YgzHhJES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250152

In some designs the SoC's VDD_GFX pads are supplied by an external
regulator, rather than a power-domain. Allow this to be described in the
GPU clock controller binding.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index f369fa34e00c..f57aceddac6b 100644
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
 
@@ -74,6 +77,12 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+# Require that power-domains and vdd-gfx-supply are not both present
+not:
+  required:
+    - power-domains
+    - vdd-gfx-supply
+
 additionalProperties: false
 
 examples:

-- 
2.25.1


