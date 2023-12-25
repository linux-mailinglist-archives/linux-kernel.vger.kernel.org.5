Return-Path: <linux-kernel+bounces-10956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20C81DF3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE3F281A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157E3D9C;
	Mon, 25 Dec 2023 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xbus/8kE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C21CA71;
	Mon, 25 Dec 2023 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP7tY9Y012547;
	Mon, 25 Dec 2023 08:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=/z5k1zu
	1LE8h0VJkvzAkkY25daJVDH5BqekPkzmPob0=; b=Xbus/8kE8Kk39mFe4IjhNVY
	b+iHfW5E8EiCgzGk1XySlad+S8EDYgn63/VVPmnVSzk+3w0jdFIEn1iMeg8JPggZ
	z7HBQz26qyqE0amXtv08id6Jq1DicU+1dfTYQB/OeZKJBBBqEB3o7/IslekiQbS4
	bnk/HNZWm5mMahapxmCOLMqaCGicn/zc6WHjCKrhKf4WycuwvEP/fseM1eNdqOCG
	iz1Kn0f5WDG+UmgVaTzRLM7CND/evffInAdl8e7bHvw7i9ro5v9oG3Iqe7UiBSuh
	aTYF11QaM5sVKOODzc5TrybCRSxr5XJzo1yEOFf0H+rDRwH+GNcKsYytexur9Mw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5ruf36vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:44:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BP8ifaZ016570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:44:41 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Dec 2023 00:44:36 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v4 0/5] support ipq5332 platform
Date: Mon, 25 Dec 2023 16:44:19 +0800
Message-ID: <20231225084424.30986-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0NI6FhxF2T9qnW6BZ_PmZ8WZZOP0SmTr
X-Proofpoint-ORIG-GUID: 0NI6FhxF2T9qnW6BZ_PmZ8WZZOP0SmTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250066

For IPQ5332 platform, there are two MAC PCSs, and qca8084 is
connected with one of them.

1. The Ethernet LDO needs to be enabled to make the PHY GPIO
   reset taking effect, which uses the MDIO bus level reset.

2. The SoC GCC uniphy AHB and SYS clocks need to be enabled
   to make the ethernet PHY device accessible.

3. To provide the clock to the ethernet, the CMN clock needs
   to be initialized for selecting reference clock and enabling
   the output clock.

4. Support optional MDIO clock frequency config.

5. Update dt-bindings doc for the new added properties.

Changes in v2:
	* remove the PHY related features such as PHY address
	  program and clock initialization.
	* leverage the MDIO level GPIO reset for qca8084 PHY.

Changes in v3:
	* fix the christmas-tree format issue.
	* improve the dt-binding changes.

Changes in v4:
	* improve the CMN PLL reference clock config.
	* improve the dt-binding changes.

Luo Jie (5):
  net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
  net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 platform
  net: mdio: ipq4019: configure CMN PLL clock for ipq5332
  net: mdio: ipq4019: support MDIO clock frequency divider
  dt-bindings: net: ipq4019-mdio: Document ipq5332 platform

 .../bindings/net/qcom,ipq4019-mdio.yaml       | 141 ++++++++-
 drivers/net/mdio/mdio-ipq4019.c               | 288 ++++++++++++++++--
 2 files changed, 399 insertions(+), 30 deletions(-)


base-commit: 3b83fa94cf316aaf9ad9a367ac8031a06d31649b
-- 
2.42.0


