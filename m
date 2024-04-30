Return-Path: <linux-kernel+bounces-164157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A238B79FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0F11C20CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F9194C70;
	Tue, 30 Apr 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XM+HBCLx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1819066D;
	Tue, 30 Apr 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487468; cv=none; b=atWI4IBFDfquRn0Kt5zJP0kl9UeGvqv3aIHCnu+EDZkghSoHUFgi6c9bwT09Oe+Rqb5qX+JPIPG6ER73K38T2Yq71Vch3i+BLc/KpwzeYKOtZZfWidVAcLgFjWzZS2xC6wbwQVwE/PHTwuyXKMKLhNg8ojsLPLED4jkYW2Cwjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487468; c=relaxed/simple;
	bh=2Sb2dB3plDhDej922dw23WRBHWFAdzbIPgxjOHua/24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gESG2MVLIxn5hV5/fOpC2h0ggHXIpCCHSbngSdzQzHaz9/UxuEwrSWfB4u6hUCWUDgPZpiekE5dErrVo3X6JsSR/zQpIWjZ0urUlM2OSS/sA+PlDeZP0KrhVFpEccg4i8UeFjnWsIxXnmp0gORC63Kdf+lvBf6p0j6qpZuAEzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XM+HBCLx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDrMOG005699;
	Tue, 30 Apr 2024 14:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=eAL7wCtJct7LcH/+jakyDHDf4kvWFw1lEsDJyiJ4HBM=; b=XM
	+HBCLxcKY8fGftaqvwx8q1FUkS5AgoDjndP1KUuiX9RjEOtJs8F0Opr6QSbRguOO
	eZJti2rC+2Jw+kv2HLQBh8+s/U5NV6LN2vGcqeOsKP6pPY4/4MeWcR3R78ZOJvWJ
	2HBtpmAR2KIil28Qzphz1ZeS8e/qyz2fzOamKs8jyz4w4Ae0fA87jU483fRHtGv1
	NjBNYRnyZpp0cl671/+Nt/l00LKjPl3WOE5fUlc1ZdwhEQuoR0QGfdE4BY+D7QWD
	+1HLTchE+BJRuJic6MQtA6W0O2VpL1VFXXdNSm9scVebyrQkv54OuVTkxpeex3I/
	6UBfVGq6/wURhadaojBA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtvf7h1em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:31:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEV2Km031090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:31:02 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:56 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
Subject: [PATCH V3 8/8] arm64: dts: qcom: sm8650: Add video and camera clock controllers
Date: Tue, 30 Apr 2024 19:57:57 +0530
Message-ID: <20240430142757.16872-9-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430142757.16872-1-quic_jkona@quicinc.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: pGqyF1Q2sqQTZdukAZD23eVTk023Kl3l
X-Proofpoint-ORIG-GUID: pGqyF1Q2sqQTZdukAZD23eVTk023Kl3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300103

Add device nodes for video and camera clock controllers on Qualcomm
SM8650 platform.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 8e0c1841f748..18f955ec588b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4,10 +4,12 @@
  */
 
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sm8650-camcc.h>
 #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
 #include <dt-bindings/clock/qcom,sm8650-gcc.h>
 #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
 #include <dt-bindings/clock/qcom,sm8650-tcsr.h>
+#include <dt-bindings/clock/qcom,sm8650-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -3309,6 +3311,30 @@ opp-202000000 {
 			};
 		};
 
+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm8650-videocc";
+			reg = <0 0x0aaf0000 0 0x10000>;
+			clocks = <&bi_tcxo_div2>,
+				 <&gcc GCC_VIDEO_AHB_CLK>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
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


