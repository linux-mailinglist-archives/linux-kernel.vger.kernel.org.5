Return-Path: <linux-kernel+bounces-117689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A68288AE74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114341FA3D42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B6128377;
	Mon, 25 Mar 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AK+Iyw0W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EADDA3;
	Mon, 25 Mar 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390633; cv=none; b=HW4xjtQtwb2stu3g7RNpRQs4cV/i2frVfX6G51Cuc4/gZwei+7I6IH0ICw4fDr1QAU4uNdqx2eV/wfJRrl5D00c+D4Py6bMoBhY+r3yBt/7r2bDHYTDFez3iejeq2TEsC3BSrEpnTxZz5Oe74/MrnCyQqR+Y+B/l2t2ojU2zWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390633; c=relaxed/simple;
	bh=F98y32gaA9gSnxbHzjHEwOuPAjBbOlBrmxZRjnMa31Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpJ749sAu9QVHysJMn4HefjXO9+/G8qxA1+4hWfQw0NS6sTBmABKOu6rz4hWWSfunSzvQiwtX/KW1GG1KA8n/ii9Bur6w+5hIS6hdISxJm/wmn9oRQ9d32KB1xDUzrpGa5lsIgwISoqJfIHw/emqT2IbwVfIcNqHQpChKubQcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AK+Iyw0W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PHxVSP011580;
	Mon, 25 Mar 2024 18:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=8Ac+f4XGlHgMJczruhsr
	BAKYJ3wD1cNAd938M08roE4=; b=AK+Iyw0WE5v529JuN9hFGfG3vdeXDNqpZhVC
	2+OzwbSEPHqLBC19elwi4e65ZJ0bb7vCz5Ua7ovCZhrPSwKIMOtQn61LDfsolh4f
	DsfZ/qoN+qKwQUXsUWhEfUGefsGj3ECAM8kaCFXjwcCClvgvCNO/qeBezlOfsCSC
	wCxNWsll83mp2T9/511Z91vUaAuVu5vr7LyOtfe0Fn3I2tEDdFyZnl65V76tXEPI
	vi4P5Ft3BoMn7DMa+wWBOKic+qOJtCdn7oAIBWAztLVKUciAl1II0OHB10h3jYj7
	71bSPKhJXMRMMoDewrx+eOtln3wa9SVJAtXmhWbBAsPeckyv6w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3626hc3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:17:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PIH6Ig007541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:17:06 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 11:17:02 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
Subject: [PATCH v4 3/4] dt-bindings: interconnect: add clock property to enable QOS on SC7280
Date: Mon, 25 Mar 2024 23:46:27 +0530
Message-ID: <20240325181628.9407-4-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240325181628.9407-1-quic_okukatla@quicinc.com>
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sxDAfBo2EWRbZ6zO2r0w7x9JWbXV1JZ-
X-Proofpoint-GUID: sxDAfBo2EWRbZ6zO2r0w7x9JWbXV1JZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_16,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250107

Added clock property to enable clocks required for accessing
qos registers.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 .../bindings/interconnect/qcom,sc7280-rpmh.yaml    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
index b135597d9489..950ecdd5252e 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -35,6 +35,10 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    minItems: 1
+    maxItems: 2
+
 required:
   - compatible
 
@@ -57,6 +61,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
     interconnect {
         compatible = "qcom,sc7280-clk-virt";
         #interconnect-cells = <2>;
@@ -69,3 +74,12 @@ examples:
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
     };
+
+    interconnect@16e0000 {
+        reg = <0x016e0000 0x1c080>;
+        compatible = "qcom,sc7280-aggre1-noc";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+    };
-- 
2.17.1


