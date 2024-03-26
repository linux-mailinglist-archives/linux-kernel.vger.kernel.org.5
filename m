Return-Path: <linux-kernel+bounces-120028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3894388D07B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC43B21834
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FFA13D8A9;
	Tue, 26 Mar 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SzOC7NNO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFED13C831;
	Tue, 26 Mar 2024 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490871; cv=none; b=C3blExEvVdiORMHdkHcuumYuRg5+/9DTe9FYpKZ6WXHG5hsk4Iza4O9qlpFBEAqrFEkOSs1nj54uJn5y7QpYGGFMrSGaomBLt/6XUs6P5dQGsnLYhElFDwafZGMG+Sb+OyGRcVB7vfnorUMa1XgkxuvfYHcQ7DpToLbY+bnJCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490871; c=relaxed/simple;
	bh=Vp/JyCV6UGm42E0RDam0dPfhpmXTwyBzcuI28kLPDg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHXJl85e0b67vtAnD0Odh/AI381JUk9AunS+HcwotvmL0Nz4kogYXh5uq1oI2fgepz5WyuyV9qv2Jv6Wv3DpjJdwO5CK7lJJ1srH3MYf80H+sQ/kUnJ7BCrSbqK0SrYfnHpeDnSUiBy/Z8W5/xCUZw/vWsM0zcKERDR4ypl8ON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SzOC7NNO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QLjK38020642;
	Tue, 26 Mar 2024 22:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RP+4I6XZjna53YyJmzMnlDMalXZCXgYLpJEgj/Xa1Bw=; b=Sz
	OC7NNOP54ouRyubFWDVESt/ecoMGaf7DVJV5BwJmjGK4wK7GCLwva1KblHHYYjY4
	gARXI4ooGeO/Vzu97hi1fYHPkajIMzfReZFrfVBWnfKKDdO/HGOUgrlojgXqeEwy
	CDjc4XGgwl0dLI/XezuXE61Mzxbk2m4nANpHc4PI0KLmKZImW/cbuFX3ZsePHWQ+
	vRBolNVTkM9qpJOqJXiJg/U3nnmzgA84kgfbbePdck+nT9fEr8fyX0RD7Tyynkng
	FS7e54gP1sHBed42CAmuWI6RNgxGB43J+fEwNweDbglGPxzPD3OOD9mdnBgI0LtX
	MHwu3d1NelaP8zVROWVw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3tvya455-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QM7j1d031024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:45 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 15:07:45 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108 and PMD8028 support
Date: Tue, 26 Mar 2024 15:06:28 -0700
Message-ID: <20240326220628.2392802-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326220628.2392802-1-quic_amelende@quicinc.com>
References: <20240326220628.2392802-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D5E51RIRVXNjSqd5zl8XNfEVWpIfGBYW
X-Proofpoint-ORIG-GUID: D5E51RIRVXNjSqd5zl8XNfEVWpIfGBYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=898
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260159

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to include compatible strings for PMIH0108 and PMD8028 PMICs.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 2b17d244f051..a786357ed1af 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -57,10 +57,12 @@ properties:
           - qcom,pma8084-gpio
           - qcom,pmc8180-gpio
           - qcom,pmc8180c-gpio
+          - qcom,pmd8028-gpio
           - qcom,pmi632-gpio
           - qcom,pmi8950-gpio
           - qcom,pmi8994-gpio
           - qcom,pmi8998-gpio
+          - qcom,pmih0108-gpio
           - qcom,pmk8350-gpio
           - qcom,pmk8550-gpio
           - qcom,pmm8155au-gpio
@@ -143,6 +145,7 @@ allOf:
               - qcom,pm8005-gpio
               - qcom,pm8450-gpio
               - qcom,pm8916-gpio
+              - qcom,pmd8028-gpio
               - qcom,pmk8350-gpio
               - qcom,pmr735a-gpio
               - qcom,pmr735b-gpio
@@ -304,6 +307,21 @@ allOf:
           minItems: 1
           maxItems: 7
 
+  - if:
+      properties:
+        comptaible:
+          contains:
+            enum:
+              - qcom,pmih0108-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 18
+          maxItems: 18
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 9
+
   - if:
       properties:
         compatible:
@@ -452,9 +470,11 @@ $defs:
                  - gpio1-gpio22 for pm8994
                  - gpio1-gpio26 for pm8998
                  - gpio1-gpio22 for pma8084
+                 - gpio1-gpio4 for pmd8028
                  - gpio1-gpio8 for pmi632
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
+                 - gpio1-gpio18 for pmih0108
                  - gpio1-gpio4 for pmk8350
                  - gpio1-gpio6 for pmk8550
                  - gpio1-gpio10 for pmm8155au
-- 
2.34.1


