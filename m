Return-Path: <linux-kernel+bounces-118947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3D88C1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB591F35944
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5B71B34;
	Tue, 26 Mar 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cA/830tL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010DF3D6B;
	Tue, 26 Mar 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455241; cv=none; b=Pit/bh/SpekYUi/Xb43UKgLsjlQPZJqHZyei1YaI4oNqPPgBvcY4H4icur8KsPP476mDXSjkFZGmIHJnrk+qvLEAMitaltTHEdMIhriFIy2gzfd1FgdoWnCfiYTS6Ws3CfHhzzadX10eaPbQYhgG5QmGE69V7//57EOCFfZbRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455241; c=relaxed/simple;
	bh=SDBARoxk7abMKwPdFlku+guO0j3DKxUdt3hiFPYCreM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vD8EBstBXTiEiocJ0NY/Lu/p0IJV97oquv7Wq93maIbGTc4j7lvfaNCqz9/A6m2BAb70hq34bnleN02iM+srhUyI0cVR+dqo9RIyLv2V1fZjj38k1IzvvOWXIs4StAN/IC402QksKX/hVQ5mY4mdFV++VXD7wwTQZ1pBs3NfIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cA/830tL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QAsfUQ003852;
	Tue, 26 Mar 2024 12:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=jSzp/1+
	p7LeTaQA7JKrMHf6fjsUPFL4GUfMuZ+BA1LA=; b=cA/830tLkU+YwBY1W1faxGx
	J1+nyvJVq+KIkCRea5Kr7dgSTGZ61tF7QGga+Ozl/JLpqn1sUoBAag3O0wwIliiz
	Tfs3OGgNbOEZDr5jpxZDc9iwo9Y6HZn4lhYJrRd3HWS+bDUXyIirQHJR+QiQV45+
	54AHV0aCPXEyNf6rfn6Bq2IIWCJ++gls39C9DI6g2rISBAETY7mjRqUw1cId7Lbj
	1dLDj6CTZO4USjiWjdSrkQPy2Cxk5Fc4vz+Aejxxuciqs+ACaRyTV470nJ/ISXzs
	zdyW3RYWazbHb5rRKhRbzfTcePEaPjmlRiEwxHnr0iQDgfGCjqyDF5bunMD4Fqw=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3w0x88g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:13:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QCDsxt004800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:13:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 05:13:50 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 0/3] Add interconnect driver for IPQ9574 SoC
Date: Tue, 26 Mar 2024 17:43:09 +0530
Message-ID: <20240326121312.1702701-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 13O6Ca3ngWZFw-ROFjecxSLR2dmBsl61
X-Proofpoint-ORIG-GUID: 13O6Ca3ngWZFw-ROFjecxSLR2dmBsl61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260085

MSM platforms manage NoC related clocks and scaling from RPM.
However, in IPQ SoCs, RPM is not involved in managing NoC
related clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for the accessing the peripherals present in the
system. Hence add a minimalistic interconnect driver that
establishes a path from the processor/memory to those peripherals
and vice versa.

---
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

Varadarajan Narayanan (3):
  dt-bindings: interconnect: Add Qualcomm IPQ9574 support
  clk: qcom: add IPQ9574 interconnect clocks support
  arm64: dts: qcom: ipq9574: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  2 +
 drivers/clk/qcom/Kconfig                      |  2 +
 drivers/clk/qcom/common.c                     | 30 +++++++++
 drivers/clk/qcom/common.h                     |  2 +
 drivers/clk/qcom/gcc-ipq9574.c                | 64 ++++++++++++++++++-
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++
 7 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

-- 
2.34.1


