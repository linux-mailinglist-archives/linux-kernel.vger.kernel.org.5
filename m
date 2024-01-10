Return-Path: <linux-kernel+bounces-22081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A58298E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CE5B243D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F2495FA;
	Wed, 10 Jan 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hT9KKwT9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870A495E7;
	Wed, 10 Jan 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AAhJw3012648;
	Wed, 10 Jan 2024 11:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=6qhSHiLUEMIZqqtuODQqyRrpU7sCEv0dSwFH8nc3DCI=; b=hT
	9KKwT9DPdfM7be2i14T7ztFnEkJ2MW4h1SM62f88qcOFKE7XhHlAi/v90vdrTy2n
	k63LPf1eKqnVeC+sYOmLG+3POihMsJTK3XG8scdQG2v7A76mNCug425EgCPmdUSh
	Jrr8si0/r1nhANSnHKC2fX4jCNxjKaqJmuJpe0GLASqOtycnSfaW75QCEVkPco2F
	03CifEsKIAw6xu6mXTyA2qJulHVAIXUvwvKIQ4vrLKnnYHHRtqGzgbA5iarcMBpc
	VycNRpO3bB82DltiQBgP7+aXtsxkTUWfgt0VdryyjfioIe9oljsARmImQ8Sprfdm
	Pv2y5Y5jysarn2dgXIWg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsqyr335-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABLfCT027571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:41 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:21:37 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH 6/6] arm64: dts: qcom: ipq9574: Add RDP433 board device tree
Date: Wed, 10 Jan 2024 19:20:59 +0800
Message-ID: <20240110112059.2498-7-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: qRHlwPZ5X9hJR7qrkypKZKW6oTvYbnEO
X-Proofpoint-ORIG-GUID: qRHlwPZ5X9hJR7qrkypKZKW6oTvYbnEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxlogscore=857 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100092

From: Lei Wei <quic_leiwei@quicinc.com>

RDP433 board has four QCA8075 PHYs and two Aquantia 10G PHY onboard.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 66 +++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 1bb8d96c9a82..298c0853b4d2 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -60,3 +60,69 @@ rclk-pins {
 		};
 	};
 };
+
+&qcom_ppe {
+	qcom,port_phyinfo {
+		ppe_port0: port@0 {
+			port_id = <1>;
+			phy-mode = "qsgmii";
+			phy-handle = <&phy0>;
+		};
+		ppe_port1: port@1 {
+			port_id = <2>;
+			phy-mode = "qsgmii";
+			phy-handle = <&phy1>;
+		};
+		ppe_port2: port@2 {
+			port_id = <3>;
+			phy-mode = "qsgmii";
+			phy-handle = <&phy2>;
+		};
+		ppe_port3: port@3 {
+			port_id = <4>;
+			phy-mode = "qsgmii";
+			phy-handle = <&phy3>;
+		};
+		ppe_port4: port@4 {
+			port_id = <5>;
+			phy-mode = "usxgmii";
+			phy-handle = <&phy4>;
+		};
+		ppe_port5: port@5 {
+			port_id = <6>;
+			phy-mode = "usxgmii";
+			phy-handle = <&phy5>;
+		};
+	};
+};
+
+&mdio {
+	reset-gpios = <&tlmm 60 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	phy0: ethernet-phy@0 {
+		      reg = <16>;
+	      };
+
+	phy1: ethernet-phy@1 {
+		      reg = <17>;
+	      };
+
+	phy2: ethernet-phy@2 {
+		      reg = <18>;
+	      };
+
+	phy3: ethernet-phy@3 {
+		      reg = <19>;
+	      };
+
+	phy4: ethernet-phy@4 {
+		      compatible ="ethernet-phy-ieee802.3-c45";
+		      reg = <8>;
+	      };
+
+	phy5: ethernet-phy@5 {
+		      compatible ="ethernet-phy-ieee802.3-c45";
+		      reg = <0>;
+	      };
+};
-- 
2.42.0


