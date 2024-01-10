Return-Path: <linux-kernel+bounces-22074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83858298CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1938F1C25A12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6547A7C;
	Wed, 10 Jan 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cz4ebTh/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45504776F;
	Wed, 10 Jan 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8dUtu031047;
	Wed, 10 Jan 2024 11:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=1pxZF1V
	gXUObLRMD2bqakwsBATZaMyfK/JhWTXjS5AA=; b=cz4ebTh/QEhFW7Ts2hLygeR
	VD7ccpEFaVyL78xJiC2I2R6sYJvR6EHs4lTX188jgEZnejS59b1091qk70x6yLPN
	Zwc73RhPqj/8tIUz9bLXD/aBIGofOBh0AZg4uVV0AfR6ExNjmjkcu3LirNZHoo+i
	shzq+eVMoMq2wFTX3j4X1/UOystFebrgVq00CytZrOOaI3v6jGKWparnpYAnd1H/
	K6CliXMbo9sAF69AlevTIvNIuSYwNf/4I5I5yjypw4w7iDi5obolitv/11mEJ1kD
	rfC1rBriJa45tKp/2LYU9snsopTwlmSb6i8dqminI5JfbqnIibLZhhfTDjvb8BA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhq2h0egc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABLGeb026369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:17 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:21:12 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH 0/6] Add PPE device tree node for Qualcomm IPQ SoC
Date: Wed, 10 Jan 2024 19:20:53 +0800
Message-ID: <20240110112059.2498-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
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
X-Proofpoint-GUID: r1Taov093tPbF2j_vgN0jLBhkg6Vpykn
X-Proofpoint-ORIG-GUID: r1Taov093tPbF2j_vgN0jLBhkg6Vpykn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=407 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100092

The PPE(packet process engine) hardware block is supported by Qualcomm
IPQ platforms, such as IPQ9574 and IPQ5332. The PPE includes the various
packet processing modules such as the routing and bridging flow engines,
L2 switch capability, VLAN and tunnels. Also included are integrated
ethernet MAC and PCS(uniphy), which is used to connect with the external
PHY devices by PCS.

This patch series enables support for the following DTSI functionality
for Qualcomm IPQ9574 and IPQ5332 chipsets. 

1. Add PPE (Packet Processing Engine) HW support

2. Add IPQ9574 RDP433 board support, where the PPE is connected
   with qca8075 PHY and AQ PHY.

3. Add IPQ5332 RDP441 board support, where the PPE is connected
   with qca8386 and SFP

PPE DTS depends on the NSSCC clock driver below, which provides the
clocks for the PPE driver.
https://lore.kernel.org/linux-arm-msm/20230825091234.32713-1-quic_devipriy@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com/

Lei Wei (2):
  arm64: dts: qcom: ipq5332: Add RDP441 board device tree
  arm64: dts: qcom: ipq9574: Add RDP433 board device tree

Luo Jie (4):
  arm64: dts: qcom: ipq9574: Add PPE device tree node
  arm64: dts: qcom: ipq5332: Add PPE device tree node
  arm64: dts: qcom: ipq5332: Add MDIO device tree
  arm64: dts: qcom: ipq9574: Add MDIO device tree

 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts |  51 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 414 ++++++++++-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  66 ++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 758 +++++++++++++++++++-
 4 files changed, 1279 insertions(+), 10 deletions(-)

-- 
2.42.0


