Return-Path: <linux-kernel+bounces-3805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A981721E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B12DB23054
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514D5A86D;
	Mon, 18 Dec 2023 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WLTs41Ow"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFB5A857;
	Mon, 18 Dec 2023 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIDNGEI020964;
	Mon, 18 Dec 2023 14:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=QHF
	a9KVy94RwhEOf0FG+5uP5Upspb4SPTX/TgXysRzo=; b=WLTs41OwPqA490qAlef
	m/qLuF2Iesu8y5NAOFfQao0zAlEa9EGGp5GyK/AsUPZn77mM2EoETFPvPBZgry84
	yDWcO5dDyCwNm8+7NXq43m4mTd8jkUNWF83CYpH1PF9IhDZdFKSAeln+xiAsVoQy
	AIngIKIAMGcq9+LafsATZKhAf3Ob4nYNwd1fLyPv/kNdH20nbcCFxEbJGWQsxhqx
	/8/5fZuQF8BURtLEfSGZTCWmoDiq7o3w+AFOTbRXkC07UbkXC05XcL/bIFzWSjlj
	B+wi10bCG4NGhDgyvRNcOG1xRohWkKzQZCJRj6WwiX6ib6SEcNt/k/+j8ZhvVlfK
	MQg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2nxs86kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 14:02:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BIE2mK5025693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 14:02:48 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 06:02:43 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Mon, 18 Dec 2023 19:32:36 +0530
Subject: [PATCH] arm64: dts: qcom: sc7280: Add additional MSI interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231218-additional_msi-v1-1-de6917392684@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAP1QgGUC/x2MQQqAIBAAvyJ7TtANxPpKRIhutVAWGhGEf086D
 szMC5kSU4ZevJDo5sxHrKAbAX51cSHJoTKgwlajttKFwFeV3DbtmaVRBoO3Gj12UKMz0czPPxz
 GUj5jufydYAAAAA==
To: <cros-qcom-dts-watchers@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        "Stephen
 Boyd" <swboyd@chromium.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        <stable@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702908163; l=1806;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=IHezx7uoKT5LzglxoOVzfJ2zxmnys0wEhJXuVwYPBp8=;
 b=aIDCdpl6OP+PF2Xv4IVJ0RB6vcrG92VT2PVMk8HRKjQl9GTHUsS3p+Z9Uis6e2F6lWl7WxVa1
 1dbfnGS88f5D0W/UXSJlICPbOG7Cp1VTF0YE6S0G1Feh6Ohfwkd7ED0
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5l6c_5PCImzHzQLmnUTGHzEdUopiuiNQ
X-Proofpoint-ORIG-GUID: 5l6c_5PCImzHzQLmnUTGHzEdUopiuiNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=670
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312180102

Current MSI's mapping doesn't have all the vectors. This platform
supports 8 vectors each vector supports 32 MSI's, so total MSI's
supported is 256.

Add all the MSI groups supported for this PCIe instance in this platform.

Fixes: 92e0ee9f83b3 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes")
cc: stable@vger.kernel.org
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 66f1eb83cca7..e1dc41705f61 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2146,8 +2146,16 @@ pcie1: pci@1c08000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3",
+					  "msi4", "msi5", "msi6", "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>,

---
base-commit: 5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
change-id: 20231218-additional_msi-6062dc812c29

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


