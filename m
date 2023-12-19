Return-Path: <linux-kernel+bounces-4539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC2817F02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01C2B2389B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC51FDE;
	Tue, 19 Dec 2023 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dGy9nFNX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED410EF;
	Tue, 19 Dec 2023 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ0ODIX023805;
	Tue, 19 Dec 2023 00:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=wmW/Mbrv0Q4mlT21P9u/4mP1/QuVJjTaewpFTD/O53k=; b=dG
	y9nFNXSdBkkFlRe2ijezsaKLQP5Z5ChokXv4vIYo823DB2mm8G4tYlUNeB2lQ31w
	I260Awpm4UIYqSyqBuijk/Bq0u07dxAW57R1cAZS51HPzacKYHIMsqnUPDYGk2qT
	QhZ5lCPpQKQpZFf59Os7qHlXUECLucoJ4vb5eP/5lJsgMGTqVrIXEeCUcKIrQvLV
	zsfUU5Q2gubdNf2eTrnNWm3MXzehWWbWh8RIAF1B3fZhEGrIW5cZTiTqKFT9gZ6m
	ajxvgIit3d9DTm3W0I1I/Z55f/J59b/2SvcOxx9cdqb7TphszoChnAlSu3PdNY30
	T4ckqj2YnWpQcpHxg0xg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0j55j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:51:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ0pEL6017348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:51:14 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 16:51:12 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v3 0/6] arm64: qcom: add AIM300 AIoT board support
Date: Tue, 19 Dec 2023 08:50:01 +0800
Message-ID: <20231219005007.11644-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mE-8-2Qo7WqqkH3_gzeewelFq-6xCVS2
X-Proofpoint-GUID: mE-8-2Qo7WqqkH3_gzeewelFq-6xCVS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=681 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190004

Add AIM300 AIoT support along with usb, ufs, regulators, serial, PCIe,
sound card and PMIC functions.
AIM300 Series is a highly optimized family of modules designed
to support AIoT applications. The module is mounted onto Qualcomm AIoT
carrier board to support verification, evaluation and development.
AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

v2 -> v3:
  - introduce qcs8550.dtsi
  - separate fix dtc W=1 warning patch to another patch series

v1 -> v2:
  - merge the splited dts patches into one patch
  - update dts file name from qcom8550-aim300.dts to qcs8550-aim300 dts
  - drop PCIe1 dts node due to it is not enabled
  - update display node name for drop sde characters

previous discussion here:
[1] v2: https://lore.kernel.org/linux-arm-msm/20231207092801.7506-1-quic_tengfan@quicinc.com
[2] v1: https://lore.kernel.org/linux-arm-msm/20231117101817.4401-1-quic_tengfan@quicinc.com

Tengfei Fan (6):
  dt-bindings: arm: qcom: Document qcs8550 SoC and board
  dt-bindings: arm: qcom,ids: add SoC ID for QCS8550
  soc: qcom: socinfo: add SoC Info support for the QCS8550 platform
  arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
  arm64: dts: qcom: add base AIM300 dtsi
  arm64: dts: qcom: aim300: add AIM300 AIoT

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 579 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi  | 371 +++++++++++
 arch/arm64/boot/dts/qcom/qcs8550.dtsi         |   6 +
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 7 files changed, 966 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi


base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
-- 
2.17.1


