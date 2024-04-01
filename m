Return-Path: <linux-kernel+bounces-126628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E3893A99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621441F21F41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB3B20DDC;
	Mon,  1 Apr 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XpsgJquJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6B286AE;
	Mon,  1 Apr 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711970101; cv=none; b=u4+d2hxUUmfDSNY42uVDDEcJPOd27qcyHtWLJ0VViNo2sR0OmDSY/UDk5d/NmqATYesmW9/HCIWnNJ2oW6N7vsT2iee+XQflO7HPTOWOlO8pqXT9yIfediBV+hw60NLqaMSe55tHlc/K//AuBFp32zdM0F3VRRNa3ulmPaEl+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711970101; c=relaxed/simple;
	bh=0hw9EMt/tZxck13waYtBYJgCkWi7+MvWNZ12C78+Lo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h0LXPhxwryNluLPWN1j1bqSl7cp9LPBx9/SIcCL04ecAeA4TC8LuEm03gWTGNDdt+wANBnntka5MI5sgGX+WCkUfGHFSS6MXh3sDi+fUn+g4hBr9axWEbI/f2wKCHLcYzBP3Zo5n9w8nBMqX5FeTBYK8/+WKLWHvBWlC0fuT4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XpsgJquJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431AbJhL009311;
	Mon, 1 Apr 2024 11:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=sSigRcHfDClqSGzUQBPUN1c73pEGuMfeVb4t9iXz61U
	=; b=XpsgJquJwD/zuKwpXqR+pPXXgaNlzGrqDVcLFhRTTL9XOjaKKByHBuPsPDI
	3JP+h732wXY6BhpzHJJsQJMpykZPcrbXldvz5rRUf89TvONtTBXrPUG61PITJirj
	RHtZEbghsKRdIySSo9oIo6sJXXC9QV1h/VZ/Yh3f86kptYWqCx3cHUxz3Gbaqavf
	oL/jtl0svz75jJpSQAsscIB2s06uT6k3Kg4JCWFHwbwd3i4eGSvQiimKWXqi3pin
	FlP9d4lKhMExFw5X/BUjItxMbdrBDO6L6sSiH0Y9MII59ZnDEi+SMWxYHTpSkX5H
	yxdyq+454P5W/hle9EtDq2XShPA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7ub382j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 11:14:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431BEtNl015025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 11:14:55 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Apr 2024 04:14:50 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Mon, 1 Apr 2024 16:44:24 +0530
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8150: Add video clock
 controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240401-videocc-sm8150-dt-node-v2-2-3b87cd2add96@quicinc.com>
References: <20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com>
In-Reply-To: <20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EUVAjk32AyUqHPVW4viSNIjq0ZDJgYB0
X-Proofpoint-ORIG-GUID: EUVAjk32AyUqHPVW4viSNIjq0ZDJgYB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_08,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=995 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010080

Add device node for video clock controller on Qualcomm
SM8150 platform.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8155p.dtsi |  4 ++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
index ffb7ab695213..9e70effc72e1 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -38,3 +38,7 @@ &rpmhpd {
 	 */
 	compatible = "qcom,sa8155p-rpmhpd";
 };
+
+&videocc {
+	power-domains = <&rpmhpd SA8155P_CX>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a35c0852b5a1..56694efa0c33 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sm8150.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
+#include <dt-bindings/clock/qcom,videocc-sm8150.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8150.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -3715,6 +3716,18 @@ usb_2_dwc3: usb@a800000 {
 			};
 		};
 
+		videocc: clock-controller@ab00000 {
+			compatible = "qcom,sm8150-videocc";
+			reg = <0 0x0ab00000 0 0x10000>;
+			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "bi_tcxo";
+			power-domains = <&rpmhpd SM8150_MMCX>;
+		        #clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		camnoc_virt: interconnect@ac00000 {
 			compatible = "qcom,sm8150-camnoc-virt";
 			reg = <0 0x0ac00000 0 0x1000>;

-- 
2.25.1


