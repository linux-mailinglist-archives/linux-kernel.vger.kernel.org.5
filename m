Return-Path: <linux-kernel+bounces-109849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB4885679
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93831F21AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7AC55792;
	Thu, 21 Mar 2024 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SxyiApaG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFB54FA9;
	Thu, 21 Mar 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013199; cv=none; b=GhUE5uKS+rZgjDn8nWVlu7byilACFBx2HVyB5JAN01XRrd8/GGdmlJEQU1smKQfAPhg+DrxgH286Y0A7GFiD8pNgpMrfNiREPQfEnLS8bWiSAgWcmIyebEwlSfrWYAXPA/WvY24TKQYLtenU8qjQF0u2RlpQe8hD1fAziEVfscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013199; c=relaxed/simple;
	bh=BrzGNroUrmCHN6it7HjPBR+/hXkHhQYwAPYCMTehjUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5t+VmEYbqMWd4MGZRrkxqYdYQ+MCrefowZgl3B614Q7VEyJVffIH4E0KIF/tlIrPUFZyFY2sgx0PLyMbhMFFfBKmAUd+xTSzfma/YV0Xg/xufMqxPcnr0vveU2mdALrZRSSebY4Tn4Hv42L/uq+DcquOJSN49t691VTw+JmFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SxyiApaG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6Y13U026350;
	Thu, 21 Mar 2024 09:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=NRb4sfIcHpoOmlqbqawjdPdqwL5q4+UpZTMfJf4F994=; b=Sx
	yiApaG68xrvoT/NA3BTnrlJYRi/g6dYbPnkvPnuifChd1vBvfkPYZ7NFmBMTIWND
	3F6BZscuO7NO2BVj4RXmd1CCYj5mp1DXCrUxrUTTgiSxI+vh1qDC//clFyTDcUkK
	dUEVWeOTVYhD7oFmV+zxoVghs+jTVuIIeOASV/6kFBs4FABybePMLwthj7xq2mSw
	RdX3Jp1y+V/S1ysW28n3w+c66Pz3IWUvKZxVT8ScxPwNL6gMUUa3RXW16z4cWGNH
	NHO9tMNXJjsgxievXaWQ5333MXKmDbLT8+AsbeDaOuDxjWi7SCTucA/6y1priVVv
	VZFi8jx412uN9xDcLAvA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fqxgba3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:26:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L9QXSg015726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:26:33 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 02:26:28 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: [PATCH V2 RESEND 6/6] arm64: dts: qcom: sm8650: Add video and camera clock controllers
Date: Thu, 21 Mar 2024 14:55:29 +0530
Message-ID: <20240321092529.13362-7-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321092529.13362-1-quic_jkona@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UUNrdCfD0SnCEXUxE6OLIK09pAuZunFh
X-Proofpoint-GUID: UUNrdCfD0SnCEXUxE6OLIK09pAuZunFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210064

Add device nodes for video and camera clock controllers on Qualcomm
SM8650 platform.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 32c0a7b9aded..d862aa6be824 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sm8450-videocc.h>
+#include <dt-bindings/clock/qcom,sm8650-camcc.h>
 #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
 #include <dt-bindings/clock/qcom,sm8650-gcc.h>
 #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
@@ -3110,6 +3112,32 @@ opp-202000000 {
 			};
 		};
 
+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm8650-videocc";
+			reg = <0 0x0aaf0000 0 0x10000>;
+			clocks = <&bi_tcxo_div2>,
+				 <&gcc GCC_VIDEO_AHB_CLK>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		camcc: clock-controller@ade0000 {
+			compatible = "qcom,sm8650-camcc";
+			reg = <0 0x0ade0000 0 0x20000>;
+			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&bi_tcxo_div2>,
+				 <&bi_tcxo_ao_div2>,
+				 <&sleep_clk>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mdss: display-subsystem@ae00000 {
 			compatible = "qcom,sm8650-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
-- 
2.43.0


