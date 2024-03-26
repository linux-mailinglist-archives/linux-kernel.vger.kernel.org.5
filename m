Return-Path: <linux-kernel+bounces-118895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA5A88C0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5EBB23D27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E374407;
	Tue, 26 Mar 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o362150c"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755659157;
	Tue, 26 Mar 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452830; cv=none; b=Sy4DOMAmb0ZHBfRhSpHtOlqauDh+As5GCBxigUNdICx/3oOuf/4bnYlWVA3S2r+2m4ec7oO2NSgUzaSOOS5tskVcPqJ4wWzmWa9JM64+Jr3sqVkORGpjjYKpJvReA0+wYmxkEc0xN5UR8W0nBBzo1NJ1cjPiL2GgvcuFpFJ1B3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452830; c=relaxed/simple;
	bh=U08DR0CT+VX4I/1rf8xBMPVKZb7RVIOW5ecciVZ/898=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kt8wQHlykmWXs7uzgZ51FSsCY2NNjLyD+4LeD6i9RcGjVYjGa7rMGzP7YkeUrXxZBT4AOP+eSRlPdNo9PYLN6rFrDHqb7LOC2ctOfUFhsWThAyWnrEb8Ek/nLINbGGTaO2NJIDHfJczKoBoulAmHDkzxmCB15+uI2Hpok2DHhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o362150c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QAtm6F005821;
	Tue, 26 Mar 2024 11:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=on4AWLn93ibcFSQpwiEvZLq/uMGCeteTx7c8FxvaK/c=; b=o3
	62150cL3+8CU2RkNQekzvApCtWIpVLxip9XL1yqHJkNxs5yF5tHJhdOdYjjyojAL
	OQ0UZEvNdAnKus7XPsfZBpIOgiK82FCUHhC58dM2H9owNJJarVCcCZXjGMx4Qy3x
	vxz9DHXduM+25+LuW5mXPE1aXjfgBLRuM0KgX8wKApVkljcTC9X9VZmM8KpH12Bx
	OrdMVFsFbBWvKmg0uYj6wZYYCPhndTrIJ9V4eM0a0wQB1cB26bGZvTNeTiBPasqv
	gZ/NiiOnlgGGpjI+PablUas+21B5bPvcSeIymti6SPuol7i6YNXh56dsRkUTSzow
	eZQtwxqNrEsjZdQkUk2g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3w1h83dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 11:33:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QBXfIM011687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 11:33:41 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 04:33:36 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v18 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
Date: Tue, 26 Mar 2024 17:02:49 +0530
Message-ID: <20240326113253.3010447-6-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: vNdObDfIazMCX4jVv3S8GgmjPSvCW-Ik
X-Proofpoint-ORIG-GUID: vNdObDfIazMCX4jVv3S8GgmjPSvCW-Ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260079

Add the compatible string for SC8280 Multiport USB controller from
Qualcomm.

There are 4 power event irq interrupts supported by this controller
(one for each port of multiport). Added all the 4 as non-optional
interrupts for SC8280XP-MP

Also each port of multiport has one DP and oen DM IRQ. Add all DP/DM
IRQ's related to 4 ports of SC8280XP Teritiary controller.

Also added ss phy irq for both SS Ports.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 38a3404ec71b..f55f601c0329 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -30,6 +30,7 @@ properties:
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
           - qcom,sc8280xp-dwc3
+          - qcom,sc8280xp-dwc3-mp
           - qcom,sdm660-dwc3
           - qcom,sdm670-dwc3
           - qcom,sdm845-dwc3
@@ -282,6 +283,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-dwc3
+              - qcom,sc8280xp-dwc3-mp
               - qcom,x1e80100-dwc3
     then:
       properties:
@@ -470,6 +472,38 @@ allOf:
             - const: dm_hs_phy_irq
             - const: ss_phy_irq
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-dwc3-mp
+    then:
+      properties:
+        interrupts:
+          minItems: 18
+          maxItems: 18
+        interrupt-names:
+          items:
+            - const: pwr_event_1
+            - const: pwr_event_2
+            - const: pwr_event_3
+            - const: pwr_event_4
+            - const: hs_phy_1
+            - const: hs_phy_2
+            - const: hs_phy_3
+            - const: hs_phy_4
+            - const: dp_hs_phy_1
+            - const: dm_hs_phy_1
+            - const: dp_hs_phy_2
+            - const: dm_hs_phy_2
+            - const: dp_hs_phy_3
+            - const: dm_hs_phy_3
+            - const: dp_hs_phy_4
+            - const: dm_hs_phy_4
+            - const: ss_phy_1
+            - const: ss_phy_2
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


