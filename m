Return-Path: <linux-kernel+bounces-122552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200EC88F955
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C001F2D05A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518E3548F3;
	Thu, 28 Mar 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aBiiNIEa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8951C21;
	Thu, 28 Mar 2024 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612856; cv=none; b=kScndVJBBI6Z7HTFt5gErII+1K7gGw2r3RDviM8V1I8ceCSBRv3VUQw+G2b/jjt/QGl3HjEr97YpZPUinbYZRaPdQxSPufA1NObd5bnLR9qQCyzxHNqwwuFwut6FbB29GrW9h/jlThx+a6oh8AilEVggLJUU25X8wDo085/UUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612856; c=relaxed/simple;
	bh=6D/XBrDpS3VYWEo5+olO35vs2lsCDJRt08g98ENovZA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PCGu7QBieUvZvfVOboP8Z4nytXpntqZSELcPJgAg4d8+j57GRgD1JGz3iYl0sbds5/TbjLvgXvnGEUlRyDbXn7Bgm2AwzE2VDnITgTYC6TzNLuaW2yoAA3v96OYXTnpBSLH3a4ynmn/GzH3gKLTpaezjMvCe9okpdx8HG2VTX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aBiiNIEa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S51Dfk032357;
	Thu, 28 Mar 2024 08:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ZRmfsnh
	BGaXe0d3EUk9FYQYhFIOlTI7BeG7C6Lnr2FI=; b=aBiiNIEa7AZrziOq4x7HEcL
	1fQCJzxEepl/QsSGYuPZj2mfpWxXOHZc0im1RtGSx0z6+/qKL3ky3YREL7ns862O
	VPMpVm/9Eiqp19+ITxcXsD4tjhvjkcezcuF2sBTYL1k7yj6Bs8YKfBakUDvUDJMA
	X3CO1dIvW4nP20GUa9BAQFSXDTeNnUbUIlGP/HHrvunD8YwlzzO1fOjk3uug8nzj
	hcDO3jQDtmiEtMOBJ2JTDzBosXpc1Y1sYmDs/hkFpJ2vnTVD3YRYMhSy14BRGHa8
	pWO648dYWJize+U1LxTIoxmt74y9pvnG+c9YjBTIiRpOF1D5ahgrR5dn6qONAXg=
	=
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u212fp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:00:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S80nYw009784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:00:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 01:00:44 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v5 0/5] Add interconnect driver for IPQ9574 SoC
Date: Thu, 28 Mar 2024 13:29:31 +0530
Message-ID: <20240328075936.223461-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2Gs2P9hx7qEGPO9qnt2cIfO2Z2clUP35
X-Proofpoint-GUID: 2Gs2P9hx7qEGPO9qnt2cIfO2Z2clUP35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280052

MSM platforms manage NoC related clocks and scaling from RPM.
However, in IPQ SoCs, RPM is not involved in managing NoC
related clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for the accessing the peripherals present in the
system. Hence add a minimalistic interconnect driver that
establishes a path from the processor/memory to those peripherals
and vice versa.

---
v5:
	Split gcc-ipq9574.c and common.c changes into separate patches
	Introduce devm_icc_clk_register
	Fix error handling
v4:
gcc-ipq9574.c
	Use clk_hw instead of indices
common.c
	Do icc register in qcom_cc_probe() call stream
common.h
	Add icc clock info to qcom_cc_desc structure

v3:
qcom,ipq9574.h
	Move 'first id' define to clock driver
gcc-ipq9574.c:
	Use indexed identifiers here to avoid confusion
	Fix error messages and move code to common.c as it can be
	shared with future SoCs

v2:
qcom,ipq9574.h
	Fix license identifier
	Rename macros
qcom,ipq9574-gcc.yaml
	Include interconnect-cells
gcc-ipq9574.c
	Update commit log
	Remove IS_ENABLED(CONFIG_INTERCONNECT) and auto select it from Kconfig
ipq9574.dtsi
	Moved to separate patch
	Include interconnect-cells to clock controller node
drivers/clk/qcom/Kconfig:
	Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK

Varadarajan Narayanan (5):
  dt-bindings: interconnect: Add Qualcomm IPQ9574 support
  interconnect: icc-clk: Add devm_icc_clk_register
  clk: qcom: common: Add interconnect clocks support
  clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq9574: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  2 +
 drivers/clk/qcom/Kconfig                      |  2 +
 drivers/clk/qcom/common.c                     | 39 +++++++++++-
 drivers/clk/qcom/common.h                     |  3 +
 drivers/clk/qcom/gcc-ipq9574.c                | 54 +++++++++++++++++
 drivers/interconnect/icc-clk.c                | 29 +++++++++
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
 include/linux/interconnect-clk.h              |  4 ++
 9 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

-- 
2.34.1


