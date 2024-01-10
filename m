Return-Path: <linux-kernel+bounces-22080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E18298E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D85728202D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC34495D2;
	Wed, 10 Jan 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DihKeHFo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8F495CA;
	Wed, 10 Jan 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AAGBdw008594;
	Wed, 10 Jan 2024 11:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=d37+e83tZwogOPVrwPm8SdeiQJvavFXD5ROs6vq+SHY=; b=Di
	hKeHFodxIwRnYIVjmdcl+H9hIxLqKcwGOeVKglNQ7F0WHzU9n6nwh41kclwO27pz
	gSLn0z1vsGPHx34QjUfywhGCcA1I8pS3hBhy0PlAtbISlY5BRAY8wl21LP0aHUBK
	BUTEsYOakDDqsuZNE6fxzMfrCXQubzkNAi+67/eeXd+/S+k0f67r1fTdj9SpXVks
	+4lQWOvgwC+t/N2MB8oQNsXoaOeOT1ODLWmDJ4hnuPWl9a9K5XPqAguJI8VHzSId
	uERvfPIGbMYYqw48UbydEWvOCe54RJcCakYxCQBMEVAWPDwVUawHln1nd52zaf22
	0odaI9uwlaJKdicp8Wog==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhnbnrms5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABLbix020799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:37 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:21:33 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add RDP441 board device tree
Date: Wed, 10 Jan 2024 19:20:58 +0800
Message-ID: <20240110112059.2498-6-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110112059.2498-1-quic_luoj@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sAbTDsgBYlvv8YlsnNYBgKDcn9gvsDMC
X-Proofpoint-GUID: sAbTDsgBYlvv8YlsnNYBgKDcn9gvsDMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=902
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401100092

From: Lei Wei <quic_leiwei@quicinc.com>

RDP441 board has onboard QCA8386 switch and 10G SFP port.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 51 +++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index 846413817e9a..d51968e9d601 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -12,6 +12,15 @@
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
 	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
+
+	soc@0 {
+		sfp1: sfp-1 {
+			compatible = "sff,sfp";
+			i2c-bus = <&blsp1_i2c1>;
+			los-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
+			tx-disable-gpios = <&tlmm 24 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &blsp1_i2c1 {
@@ -63,3 +72,45 @@ data-pins {
 		};
 	};
 };
+
+&qcom_ppe {
+	qcom,port_phyinfo {
+		ppe_port0: port@0 {
+			port_id = <1>;
+			phy-mode = "2500base-x";
+			fixed-link {
+				speed = <2500>;
+				full-duplex;
+				pause;
+			};
+		};
+
+		ppe_port1: port@1 {
+			port_id = <2>;
+			phy-mode = "10gbase-r";
+			sfp = <&sfp1>;
+			managed = "in-band-status";
+		};
+	};
+};
+
+&mdio {
+	status = "okay";
+	reset-gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
+
+	phy0: ethernet-phy@0 {
+		      reg = <1>;
+	      };
+
+	phy1: ethernet-phy@1 {
+		      reg = <2>;
+	      };
+
+	phy2: ethernet-phy@2 {
+		      reg = <3>;
+	      };
+
+	phy3: ethernet-phy@3 {
+		      reg = <4>;
+	      };
+};
-- 
2.42.0


